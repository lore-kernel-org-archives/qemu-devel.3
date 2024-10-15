Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F671CFC287
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewu-0006lC-49; Tue, 15 Oct 2024 06:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewZ-0006gb-07
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewW-0005xn-2Q
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-430ee5c9570so61298345e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988698; x=1729593498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Aue3fXwAU5o+2SsmJNKamscS2yQJZPRLRAyCQiRlTQU=;
 b=or9BQt5J4BUyUqp4rxrLp+XG7xEpcR5d+hSKkxHIu1f4lPSySrb86Ewbx0hSiymXkJ
 an87oy5ZRA4ZjPXLGrcgKUTt2wYod6Xpj1KnMRygRoK8m3tLnMrOHTm/r+Mnt7JWX2M6
 ELCE1CXaBw+zNfXoEI6sxXCBVchS3L62desyc0Wp9bBLNF2jGrwZTkkBWXZpwNSDZBXm
 2bdUPUnAjYVTNeEjhm/K1iXNB8ZksgCg57f+lyQEu7MOYmVcP+2GvR4bjA9lp6Gin11k
 eIbPvrkUOe4CYOp74qHgk37ptlH28XTWZ7OS8Cdkpj53B/3dr5TQEL5a05b4n2vllyou
 gNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988698; x=1729593498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aue3fXwAU5o+2SsmJNKamscS2yQJZPRLRAyCQiRlTQU=;
 b=RaJxUeS86IHnLF1BEgrBTj4mFogYhgQo3uVsSppN0Xz3slMd9xHGI47/OjWtZDEwAI
 VwqBwgPWN+H2uzUsjALiTXSg1oehSbY1CO2VkavvDtBY6k2z1eZKpAAAk49XzILOKVcV
 7ZLRaSY3h/BV5DJXDIkeI1nNIv5MUDFc64TLAX0anW1lRVhYip+ZeD8DiVpLOjJt/LCM
 wRjKQamSjw1LCxwGsp47OXEhxGtHZ0ZZM2JyeUDYl9zFqg+6A/KeGqqSTZDKY5L/E4Eb
 U5q5B8iFdZBHCGssTDjIpOFVYOmqPxg/FVgovgY9yxiVhnAnCiPNhUYfLmAuZ7EQ4BjG
 l0EQ==
X-Gm-Message-State: AOJu0YzJAVqnAQTYDGV3DQ4V/OCy+2nynfOu/0wNaIZSjtXZf1sVK8Ko
 xcY5Sbn/UeM5949JkErw4iPvR1di20zahLIrUtUJJYkPP38OaO+x0F59jHR0/AqE5SQ4jEL2o9o
 P
X-Google-Smtp-Source: AGHT+IH4YI1YA/ICZUuBmSzj+Qvd6t1mYDP1eMHZmbBVOkOXAwklds1vIbDpkScrDdXa34PSAB3+BQ==
X-Received: by 2002:a5d:45c9:0:b0:374:c658:706e with SMTP id
 ffacd0b85a97d-37d600d2ffamr10420558f8f.39.1728988698340; 
 Tue, 15 Oct 2024 03:38:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/28] docs/devel/rcu: Convert to rST format
Date: Tue, 15 Oct 2024 11:37:58 +0100
Message-Id: <20241015103808.133024-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Convert docs/devel/rcu.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240816132212.3602106-6-peter.maydell@linaro.org
---
 MAINTAINERS                     |   2 +-
 docs/devel/index-internals.rst  |   1 +
 docs/devel/{rcu.txt => rcu.rst} | 172 +++++++++++++++-----------------
 3 files changed, 82 insertions(+), 93 deletions(-)
 rename docs/devel/{rcu.txt => rcu.rst} (73%)

diff --git a/MAINTAINERS b/MAINTAINERS
index c622433983d..bf62247872a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3059,7 +3059,7 @@ Read, Copy, Update (RCU)
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: docs/devel/lockcnt.rst
-F: docs/devel/rcu.txt
+F: docs/devel/rcu.rst
 F: include/qemu/rcu*.h
 F: tests/unit/rcutorture.c
 F: tests/unit/test-rcu-*.c
diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index 88fa0e9450d..ab9fbc44826 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -8,6 +8,7 @@ Details about QEMU's various subsystems including how to add features to them.
 
    qom
    atomics
+   rcu
    block-coroutine-wrapper
    clocks
    ebpf_rss
diff --git a/docs/devel/rcu.txt b/docs/devel/rcu.rst
similarity index 73%
rename from docs/devel/rcu.txt
rename to docs/devel/rcu.rst
index 2e6cc607a17..dd07c1d9195 100644
--- a/docs/devel/rcu.txt
+++ b/docs/devel/rcu.rst
@@ -20,7 +20,7 @@ for the execution of all *currently running* critical sections before
 proceeding, or before asynchronously executing a callback.
 
 The key point here is that only the currently running critical sections
-are waited for; critical sections that are started _after_ the beginning
+are waited for; critical sections that are started **after** the beginning
 of the wait do not extend the wait, despite running concurrently with
 the updater.  This is the reason why RCU is more scalable than,
 for example, reader-writer locks.  It is so much more scalable that
@@ -37,7 +37,7 @@ do not matter; as soon as all previous critical sections have finished,
 there cannot be any readers who hold references to the data structure,
 and these can now be safely reclaimed (e.g., freed or unref'ed).
 
-Here is a picture:
+Here is a picture::
 
         thread 1                  thread 2                  thread 3
     -------------------    ------------------------    -------------------
@@ -58,43 +58,38 @@ that critical section.
 
 
 RCU API
-=======
+-------
 
 The core RCU API is small:
 
-     void rcu_read_lock(void);
-
+``void rcu_read_lock(void);``
         Used by a reader to inform the reclaimer that the reader is
         entering an RCU read-side critical section.
 
-     void rcu_read_unlock(void);
-
+``void rcu_read_unlock(void);``
         Used by a reader to inform the reclaimer that the reader is
         exiting an RCU read-side critical section.  Note that RCU
         read-side critical sections may be nested and/or overlapping.
 
-     void synchronize_rcu(void);
-
+``void synchronize_rcu(void);``
         Blocks until all pre-existing RCU read-side critical sections
         on all threads have completed.  This marks the end of the removal
         phase and the beginning of reclamation phase.
 
         Note that it would be valid for another update to come while
-        synchronize_rcu is running.  Because of this, it is better that
+        ``synchronize_rcu`` is running.  Because of this, it is better that
         the updater releases any locks it may hold before calling
-        synchronize_rcu.  If this is not possible (for example, because
-        the updater is protected by the BQL), you can use call_rcu.
+        ``synchronize_rcu``.  If this is not possible (for example, because
+        the updater is protected by the BQL), you can use ``call_rcu``.
 
-     void call_rcu1(struct rcu_head * head,
-                    void (*func)(struct rcu_head *head));
-
-        This function invokes func(head) after all pre-existing RCU
+``void call_rcu1(struct rcu_head * head, void (*func)(struct rcu_head *head));``
+        This function invokes ``func(head)`` after all pre-existing RCU
         read-side critical sections on all threads have completed.  This
         marks the end of the removal phase, with func taking care
         asynchronously of the reclamation phase.
 
-        The foo struct needs to have an rcu_head structure added,
-        perhaps as follows:
+        The ``foo`` struct needs to have an ``rcu_head`` structure added,
+        perhaps as follows::
 
             struct foo {
                 struct rcu_head rcu;
@@ -103,8 +98,8 @@ The core RCU API is small:
                 long c;
             };
 
-        so that the reclaimer function can fetch the struct foo address
-        and free it:
+        so that the reclaimer function can fetch the ``struct foo`` address
+        and free it::
 
             call_rcu1(&foo.rcu, foo_reclaim);
 
@@ -114,29 +109,27 @@ The core RCU API is small:
                 g_free(fp);
             }
 
-        For the common case where the rcu_head member is the first of the
-        struct, you can use the following macro.
+        ``call_rcu1`` is typically used via either the ``call_rcu`` or
+        ``g_free_rcu`` macros, which handle the common case where the
+        ``rcu_head`` member is the first of the struct.
 
-     void call_rcu(T *p,
-                   void (*func)(T *p),
-                   field-name);
-     void g_free_rcu(T *p,
-                     field-name);
+``void call_rcu(T *p, void (*func)(T *p), field-name);``
+        If the ``struct rcu_head`` is the first field in the struct, you can
+        use this macro instead of ``call_rcu1``.
 
-        call_rcu1 is typically used through these macro, in the common case
-        where the "struct rcu_head" is the first field in the struct.  If
-        the callback function is g_free, in particular, g_free_rcu can be
-        used.  In the above case, one could have written simply:
+``void g_free_rcu(T *p, field-name);``
+        This is a special-case version of ``call_rcu`` where the callback
+        function is ``g_free``.
+        In the example given in ``call_rcu1``, one could have written simply::
 
             g_free_rcu(&foo, rcu);
 
-     typeof(*p) qatomic_rcu_read(p);
+``typeof(*p) qatomic_rcu_read(p);``
+        ``qatomic_rcu_read()`` is similar to ``qatomic_load_acquire()``, but
+        it makes some assumptions on the code that calls it.  This allows a
+        more optimized implementation.
 
-        qatomic_rcu_read() is similar to qatomic_load_acquire(), but it makes
-        some assumptions on the code that calls it.  This allows a more
-        optimized implementation.
-
-        qatomic_rcu_read assumes that whenever a single RCU critical
+        ``qatomic_rcu_read`` assumes that whenever a single RCU critical
         section reads multiple shared data, these reads are either
         data-dependent or need no ordering.  This is almost always the
         case when using RCU, because read-side critical sections typically
@@ -144,7 +137,7 @@ The core RCU API is small:
         every update) until reaching a data structure of interest,
         and then read from there.
 
-        RCU read-side critical sections must use qatomic_rcu_read() to
+        RCU read-side critical sections must use ``qatomic_rcu_read()`` to
         read data, unless concurrent writes are prevented by another
         synchronization mechanism.
 
@@ -152,18 +145,17 @@ The core RCU API is small:
         data structure in a single direction, opposite to the direction
         in which the updater initializes it.
 
-     void qatomic_rcu_set(p, typeof(*p) v);
+``void qatomic_rcu_set(p, typeof(*p) v);``
+        ``qatomic_rcu_set()`` is similar to ``qatomic_store_release()``,
+        though it also makes assumptions on the code that calls it in
+        order to allow a more optimized implementation.
 
-        qatomic_rcu_set() is similar to qatomic_store_release(), though it also
-        makes assumptions on the code that calls it in order to allow a more
-        optimized implementation.
-
-        In particular, qatomic_rcu_set() suffices for synchronization
+        In particular, ``qatomic_rcu_set()`` suffices for synchronization
         with readers, if the updater never mutates a field within a
         data item that is already accessible to readers.  This is the
         case when initializing a new copy of the RCU-protected data
-        structure; just ensure that initialization of *p is carried out
-        before qatomic_rcu_set() makes the data item visible to readers.
+        structure; just ensure that initialization of ``*p`` is carried out
+        before ``qatomic_rcu_set()`` makes the data item visible to readers.
         If this rule is observed, writes will happen in the opposite
         order as reads in the RCU read-side critical sections (or if
         there is just one update), and there will be no need for other
@@ -171,58 +163,54 @@ The core RCU API is small:
 
 The following APIs must be used before RCU is used in a thread:
 
-     void rcu_register_thread(void);
-
+``void rcu_register_thread(void);``
         Mark a thread as taking part in the RCU mechanism.  Such a thread
         will have to report quiescent points regularly, either manually
-        or through the QemuCond/QemuSemaphore/QemuEvent APIs.
-
-     void rcu_unregister_thread(void);
+        or through the ``QemuCond``/``QemuSemaphore``/``QemuEvent`` APIs.
 
+``void rcu_unregister_thread(void);``
         Mark a thread as not taking part anymore in the RCU mechanism.
         It is not a problem if such a thread reports quiescent points,
-        either manually or by using the QemuCond/QemuSemaphore/QemuEvent
-        APIs.
+        either manually or by using the
+        ``QemuCond``/``QemuSemaphore``/``QemuEvent`` APIs.
 
-Note that these APIs are relatively heavyweight, and should _not_ be
+Note that these APIs are relatively heavyweight, and should **not** be
 nested.
 
 Convenience macros
-==================
+------------------
 
 Two macros are provided that automatically release the read lock at the
 end of the scope.
 
-      RCU_READ_LOCK_GUARD()
-
+``RCU_READ_LOCK_GUARD()``
          Takes the lock and will release it at the end of the block it's
          used in.
 
-      WITH_RCU_READ_LOCK_GUARD()  { code }
-
+``WITH_RCU_READ_LOCK_GUARD()  { code }``
          Is used at the head of a block to protect the code within the block.
 
-Note that 'goto'ing out of the guarded block will also drop the lock.
+Note that a ``goto`` out of the guarded block will also drop the lock.
 
-DIFFERENCES WITH LINUX
-======================
+Differences with Linux
+----------------------
 
 - Waiting on a mutex is possible, though discouraged, within an RCU critical
   section.  This is because spinlocks are rarely (if ever) used in userspace
   programming; not allowing this would prevent upgrading an RCU read-side
   critical section to become an updater.
 
-- qatomic_rcu_read and qatomic_rcu_set replace rcu_dereference and
-  rcu_assign_pointer.  They take a _pointer_ to the variable being accessed.
+- ``qatomic_rcu_read`` and ``qatomic_rcu_set`` replace ``rcu_dereference`` and
+  ``rcu_assign_pointer``.  They take a **pointer** to the variable being accessed.
 
-- call_rcu is a macro that has an extra argument (the name of the first
-  field in the struct, which must be a struct rcu_head), and expects the
+- ``call_rcu`` is a macro that has an extra argument (the name of the first
+  field in the struct, which must be a struct ``rcu_head``), and expects the
   type of the callback's argument to be the type of the first argument.
-  call_rcu1 is the same as Linux's call_rcu.
+  ``call_rcu1`` is the same as Linux's ``call_rcu``.
 
 
-RCU PATTERNS
-============
+RCU Patterns
+------------
 
 Many patterns using read-writer locks translate directly to RCU, with
 the advantages of higher scalability and deadlock immunity.
@@ -243,28 +231,28 @@ Here are some frequently-used RCU idioms that are worth noting.
 
 
 RCU list processing
--------------------
+^^^^^^^^^^^^^^^^^^^
 
 TBD (not yet used in QEMU)
 
 
 RCU reference counting
-----------------------
+^^^^^^^^^^^^^^^^^^^^^^
 
 Because grace periods are not allowed to complete while there is an RCU
 read-side critical section in progress, the RCU read-side primitives
 may be used as a restricted reference-counting mechanism.  For example,
-consider the following code fragment:
+consider the following code fragment::
 
     rcu_read_lock();
     p = qatomic_rcu_read(&foo);
     /* do something with p. */
     rcu_read_unlock();
 
-The RCU read-side critical section ensures that the value of "p" remains
-valid until after the rcu_read_unlock().  In some sense, it is acquiring
-a reference to p that is later released when the critical section ends.
-The write side looks simply like this (with appropriate locking):
+The RCU read-side critical section ensures that the value of ``p`` remains
+valid until after the ``rcu_read_unlock()``.  In some sense, it is acquiring
+a reference to ``p`` that is later released when the critical section ends.
+The write side looks simply like this (with appropriate locking)::
 
     qemu_mutex_lock(&foo_mutex);
     old = foo;
@@ -274,7 +262,7 @@ The write side looks simply like this (with appropriate locking):
     free(old);
 
 If the processing cannot be done purely within the critical section, it
-is possible to combine this idiom with a "real" reference count:
+is possible to combine this idiom with a "real" reference count::
 
     rcu_read_lock();
     p = qatomic_rcu_read(&foo);
@@ -283,7 +271,7 @@ is possible to combine this idiom with a "real" reference count:
     /* do something with p. */
     foo_unref(p);
 
-The write side can be like this:
+The write side can be like this::
 
     qemu_mutex_lock(&foo_mutex);
     old = foo;
@@ -292,7 +280,7 @@ The write side can be like this:
     synchronize_rcu();
     foo_unref(old);
 
-or with call_rcu:
+or with ``call_rcu``::
 
     qemu_mutex_lock(&foo_mutex);
     old = foo;
@@ -301,10 +289,10 @@ or with call_rcu:
     call_rcu(foo_unref, old, rcu);
 
 In both cases, the write side only performs removal.  Reclamation
-happens when the last reference to a "foo" object is dropped.
-Using synchronize_rcu() is undesirably expensive, because the
+happens when the last reference to a ``foo`` object is dropped.
+Using ``synchronize_rcu()`` is undesirably expensive, because the
 last reference may be dropped on the read side.  Hence you can
-use call_rcu() instead:
+use ``call_rcu()`` instead::
 
      foo_unref(struct foo *p) {
         if (qatomic_fetch_dec(&p->refcount) == 1) {
@@ -314,7 +302,7 @@ use call_rcu() instead:
 
 
 Note that the same idioms would be possible with reader/writer
-locks:
+locks::
 
     read_lock(&foo_rwlock);         write_mutex_lock(&foo_rwlock);
     p = foo;                        p = foo;
@@ -334,15 +322,15 @@ locks:
     foo_unref(p);
     read_unlock(&foo_rwlock);
 
-foo_unref could use a mechanism such as bottom halves to move deallocation
+``foo_unref`` could use a mechanism such as bottom halves to move deallocation
 out of the write-side critical section.
 
 
 RCU resizable arrays
---------------------
+^^^^^^^^^^^^^^^^^^^^
 
 Resizable arrays can be used with RCU.  The expensive RCU synchronization
-(or call_rcu) only needs to take place when the array is resized.
+(or ``call_rcu``) only needs to take place when the array is resized.
 The two items to take care of are:
 
 - ensuring that the old version of the array is available between removal
@@ -351,10 +339,10 @@ The two items to take care of are:
 - avoiding mismatches in the read side between the array data and the
   array size.
 
-The first problem is avoided simply by not using realloc.  Instead,
+The first problem is avoided simply by not using ``realloc``.  Instead,
 each resize will allocate a new array and copy the old data into it.
 The second problem would arise if the size and the data pointers were
-two members of a larger struct:
+two members of a larger struct::
 
     struct mystuff {
         ...
@@ -364,7 +352,7 @@ two members of a larger struct:
         ...
     };
 
-Instead, we store the size of the array with the array itself:
+Instead, we store the size of the array with the array itself::
 
     struct arr {
         int size;
@@ -400,7 +388,7 @@ Instead, we store the size of the array with the array itself:
         }
 
 
-SOURCES
-=======
+References
+----------
 
-* Documentation/RCU/ from the Linux kernel
+* The `Linux kernel RCU documentation <https://docs.kernel.org/RCU/>`__
-- 
2.34.1


