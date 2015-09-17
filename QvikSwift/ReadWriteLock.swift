// The MIT License (MIT)
//
// Copyright (c) 2015 Qvik (www.qvik.fi)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

/**
Swift wrapper for pthread read/write lock, synchronization between threads to a resource.

The lock can be acquired for reading when there are no writers waiting for the lock
or owning the lock. 

The lock can be acquired for writing when there are no readers or other writers owning the lock.

Intending to use this class? You probably should see about redesigning
your code and / or using GCD.
*/
public class ReadWriteLock {
    private var lock: pthread_rwlock_t
    
    /// Lock for reading. Blocks until the lock is acquired.
    public func lockToRead() {
        pthread_rwlock_rdlock(&lock)
    }

    /// Attempts to lock for reading; if unsuccessful, returns false.
    public func tryLockToRead() -> Bool {
        let res = pthread_rwlock_tryrdlock(&lock)
        return (res == 0)
    }
    
    /// Lock for writing. Blocks until the lock is acquired.
    public func lockToWrite() {
        pthread_rwlock_wrlock(&lock)
    }
    
    /// Attempts to lock for writing; if unsuccessful, returns false.
    public func tryLockToWrite() -> Bool {
        let res = pthread_rwlock_trywrlock(&lock)
        return (res == 0)
    }
    
    /// Unlocks the lock.
    public func unlock() {
        pthread_rwlock_unlock(&lock)
    }
    
    deinit {
        pthread_rwlock_destroy(&lock)
    }
    
    public init() {
        lock = pthread_rwlock_t()
        pthread_rwlock_init(&lock, nil)
    }
}