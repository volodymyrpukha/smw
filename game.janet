(defn random-1-10 []
  (let [current-time (os/time)
        seed-string (string (math/floor (* current-time 1000)))]
    (math/seedrandom seed-string)
    (+ 1 (math/floor (* (math/random) 10)))))

(def target (random-1-10))

# Initialize attempts counter
(var attempts 3)

#Game loop
(while (> attempts 0)
  (print (string/format "Guess a number between 1 and 10. You have %d attempt(s) left: " attempts))

  # Read the user's guess from stdin and trim whitespace
  (let [guess (string/trim (file/read stdin :line))
        guess-num (scan-number guess)]

    # Check if the guess is correct
    (if (= guess-num target)
      (do
        (print "Congratulations! You've guessed the number correctly. You go to the Good Place!")
        (break))  # Correctly exit the loop

      # Wrong guess, decrement attempts and continue
      (do
        (print "Wrong guess. Try again.")
        (set attempts (- attempts 1)))))

  # Outside of if to check after every guess
  (when (<= attempts 0)
    (print (string/format "Sorry, you've used all your attempts. You go to the Bad Place. The number was %d." target))
    (break)))  # Ensure loop exits if attempts are 0 after decrement