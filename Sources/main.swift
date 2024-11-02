let data = """
    URLs:
    http://www.google.com
    https://www.google.com
    http://google.com
    https://google.com
    http://www.google.com/
    https://www.google.com/
    http://google.com/
    https://google.com/
    http://www.google.com/index.html
    https://www.google.com/index.html
    http://google.com/index.html
    https://google.com/index.html
    """

print("With characters:")
print(measure(text: data, regex: #/https?:\/\/([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?/#))

print("\nWith codepoints:")
print(measure(text: data, regex:#/https?:\/\/([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?/#.matchingSemantics(.unicodeScalar)))

func measure(text: String, regex: Regex<(Substring, Substring, Substring, Substring?)>) -> Duration {
    print("tic...", terminator: "")
    
    let clock = ContinuousClock()
    
    var count = 0
    let result = clock.measure {
        for _ in 1...100_000 {
            for _ in data.matches(of: regex) {
                //print(text[match.range.lowerBound..<match.range.upperBound])
                count += 1
            }
        }
    }
    print(" toc (\(count) matches).")
    return result
}
