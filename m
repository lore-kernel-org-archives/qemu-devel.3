Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01965CFC288
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ews-0006jv-1T; Tue, 15 Oct 2024 06:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewX-0006fx-E8
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewU-0005xS-VN
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43123368ea9so27057035e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988697; x=1729593497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=avrcLLwmrHbwgP9CnagNbS7sp/K+JpDV1npJXNy3DpM=;
 b=LR4JGIAgzUC5F1yw3XHUgxZsfkMdYCj/XW2XrppkOEqp4O9yaVn8JB8Jd8gJSwUdPZ
 H9aGiLkRV7pk4JhlyHVT7Jy/Qj8rg9UTxS0TyoBQtMhvpprxWdudjhG9xsOluLvDg9Ia
 V3JVcbMSKz3cCJo4jXdTLphZJEM3nLtkY/rb+aJ/UDO1xp9P+riXtMJYIVylMSDNtgCp
 jF1mrbQSCoWi3Qx6fPfRAzTNymmC6OQByU5mpBOmsUzjgQ4ZrIBKkgSuNA68KSbmwp9o
 DcxZcgnC+T7UyQg9P/j3jSzEI1ffQH+qoTO1CnTHjld4u/5yO2xBZJmqzH6cMEGuguND
 jZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988697; x=1729593497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avrcLLwmrHbwgP9CnagNbS7sp/K+JpDV1npJXNy3DpM=;
 b=u/t9am5Ae1+zHlQCyXnVPeqXjSkFMtt0HlBV9ILDAhjzzmLL8fz/rlLyJXUdgSV8Hv
 tgwZYuHhC5YSmtvTZn9F6skwQVblENQep7I/6sNDUYPcjoNbw49mjxEq6/IK58HkAVC+
 t4KQ9b3j77SsOtbLfRYe0yPegMFkYmqF6fPdTFz5N5W4D8lUgoHkZl+z3NF1Gbscxo9D
 mm7zly4wFMJePRRqHG8Fwc6w0w9zsGu69WOoHBYbXpzw0EUIA3YTNjrDo0URZ5qMfkxs
 TuLboarA6zt8cC0vN1UjbPeixYyj5hOoFmIFtQmPvb3iRLjGeXmKytK7NXnIbzrFMj11
 8d+g==
X-Gm-Message-State: AOJu0Yzim/cV+UBfqeauYVOOqrhMyTs/qo+/JH7g/UihD3Y74pT51fmj
 UWNOwrwKLXseyzbHyiHGeyzg2euuQDAYToeXKLzQKSDne1dd98OjLlzTyTXzgKPAvbvi9d+xRvo
 k
X-Google-Smtp-Source: AGHT+IHRgrVraHJg0lz6iKlWmVWoT1GlC3CAEh+ND9OtGx4s8eTjnAdf4ZgQuVLFA6DInYfNowWM2A==
X-Received: by 2002:a05:600c:3496:b0:42c:b22e:fbfa with SMTP id
 5b1f17b1804b1-431255e765amr101321975e9.21.1728988697411; 
 Tue, 15 Oct 2024 03:38:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/28] docs/devel/lockcnt: Convert to rST format
Date: Tue, 15 Oct 2024 11:37:56 +0100
Message-Id: <20241015103808.133024-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Convert docs/devel/lockcnt.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240816132212.3602106-4-peter.maydell@linaro.org
---
 MAINTAINERS                             |  2 +-
 docs/devel/index-api.rst                |  1 +
 docs/devel/{lockcnt.txt => lockcnt.rst} | 89 +++++++++++++------------
 3 files changed, 47 insertions(+), 45 deletions(-)
 rename docs/devel/{lockcnt.txt => lockcnt.rst} (74%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 22cc98bbfee..c622433983d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3058,7 +3058,7 @@ F: qapi/run-state.json
 Read, Copy, Update (RCU)
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
-F: docs/devel/lockcnt.txt
+F: docs/devel/lockcnt.rst
 F: docs/devel/rcu.txt
 F: include/qemu/rcu*.h
 F: tests/unit/rcutorture.c
diff --git a/docs/devel/index-api.rst b/docs/devel/index-api.rst
index fe01b2b488d..1c487c152ab 100644
--- a/docs/devel/index-api.rst
+++ b/docs/devel/index-api.rst
@@ -9,6 +9,7 @@ generated from in-code annotations to function prototypes.
 
    bitops
    loads-stores
+   lockcnt
    memory
    modules
    pci
diff --git a/docs/devel/lockcnt.txt b/docs/devel/lockcnt.rst
similarity index 74%
rename from docs/devel/lockcnt.txt
rename to docs/devel/lockcnt.rst
index a3fb3bc5d8d..994aeb57151 100644
--- a/docs/devel/lockcnt.txt
+++ b/docs/devel/lockcnt.rst
@@ -1,9 +1,9 @@
-DOCUMENTATION FOR LOCKED COUNTERS (aka QemuLockCnt)
-===================================================
+Locked Counters (aka ``QemuLockCnt``)
+=====================================
 
 QEMU often uses reference counts to track data structures that are being
 accessed and should not be freed.  For example, a loop that invoke
-callbacks like this is not safe:
+callbacks like this is not safe::
 
     QLIST_FOREACH_SAFE(ioh, &io_handlers, next, pioh) {
         if (ioh->revents & G_IO_OUT) {
@@ -11,11 +11,11 @@ callbacks like this is not safe:
         }
     }
 
-QLIST_FOREACH_SAFE protects against deletion of the current node (ioh)
-by stashing away its "next" pointer.  However, ioh->fd_write could
+``QLIST_FOREACH_SAFE`` protects against deletion of the current node (``ioh``)
+by stashing away its ``next`` pointer.  However, ``ioh->fd_write`` could
 actually delete the next node from the list.  The simplest way to
 avoid this is to mark the node as deleted, and remove it from the
-list in the above loop:
+list in the above loop::
 
     QLIST_FOREACH_SAFE(ioh, &io_handlers, next, pioh) {
         if (ioh->deleted) {
@@ -29,7 +29,7 @@ list in the above loop:
     }
 
 If however this loop must also be reentrant, i.e. it is possible that
-ioh->fd_write invokes the loop again, some kind of counting is needed:
+``ioh->fd_write`` invokes the loop again, some kind of counting is needed::
 
     walking_handlers++;
     QLIST_FOREACH_SAFE(ioh, &io_handlers, next, pioh) {
@@ -46,8 +46,8 @@ ioh->fd_write invokes the loop again, some kind of counting is needed:
     }
     walking_handlers--;
 
-One may think of using the RCU primitives, rcu_read_lock() and
-rcu_read_unlock(); effectively, the RCU nesting count would take
+One may think of using the RCU primitives, ``rcu_read_lock()`` and
+``rcu_read_unlock()``; effectively, the RCU nesting count would take
 the place of the walking_handlers global variable.  Indeed,
 reference counting and RCU have similar purposes, but their usage in
 general is complementary:
@@ -70,14 +70,14 @@ general is complementary:
   this can improve performance, but also delay reclamation undesirably.
   With reference counting, reclamation is deterministic.
 
-This file documents QemuLockCnt, an abstraction for using reference
+This file documents ``QemuLockCnt``, an abstraction for using reference
 counting in code that has to be both thread-safe and reentrant.
 
 
-QemuLockCnt concepts
---------------------
+``QemuLockCnt`` concepts
+------------------------
 
-A QemuLockCnt comprises both a counter and a mutex; it has primitives
+A ``QemuLockCnt`` comprises both a counter and a mutex; it has primitives
 to increment and decrement the counter, and to take and release the
 mutex.  The counter notes how many visits to the data structures are
 taking place (the visits could be from different threads, or there could
@@ -95,13 +95,14 @@ not just frees, though there could be cases where this is not necessary.
 
 Reads, instead, can be done without taking the mutex, as long as the
 readers and writers use the same macros that are used for RCU, for
-example qatomic_rcu_read, qatomic_rcu_set, QLIST_FOREACH_RCU, etc.  This is
-because the reads are done outside a lock and a set or QLIST_INSERT_HEAD
+example ``qatomic_rcu_read``, ``qatomic_rcu_set``, ``QLIST_FOREACH_RCU``,
+etc.  This is because the reads are done outside a lock and a set
+or ``QLIST_INSERT_HEAD``
 can happen concurrently with the read.  The RCU API ensures that the
 processor and the compiler see all required memory barriers.
 
 This could be implemented simply by protecting the counter with the
-mutex, for example:
+mutex, for example::
 
     // (1)
     qemu_mutex_lock(&walking_handlers_mutex);
@@ -125,33 +126,33 @@ mutex, for example:
 Here, no frees can happen in the code represented by the ellipsis.
 If another thread is executing critical section (2), that part of
 the code cannot be entered, because the thread will not be able
-to increment the walking_handlers variable.  And of course
+to increment the ``walking_handlers`` variable.  And of course
 during the visit any other thread will see a nonzero value for
-walking_handlers, as in the single-threaded code.
+``walking_handlers``, as in the single-threaded code.
 
 Note that it is possible for multiple concurrent accesses to delay
-the cleanup arbitrarily; in other words, for the walking_handlers
+the cleanup arbitrarily; in other words, for the ``walking_handlers``
 counter to never become zero.  For this reason, this technique is
 more easily applicable if concurrent access to the structure is rare.
 
 However, critical sections are easy to forget since you have to do
-them for each modification of the counter.  QemuLockCnt ensures that
+them for each modification of the counter.  ``QemuLockCnt`` ensures that
 all modifications of the counter take the lock appropriately, and it
 can also be more efficient in two ways:
 
 - it avoids taking the lock for many operations (for example
   incrementing the counter while it is non-zero);
 
-- on some platforms, one can implement QemuLockCnt to hold the lock
+- on some platforms, one can implement ``QemuLockCnt`` to hold the lock
   and the mutex in a single word, making the fast path no more expensive
   than simply managing a counter using atomic operations (see
-  docs/devel/atomics.rst).  This can be very helpful if concurrent access to
+  :doc:`atomics`).  This can be very helpful if concurrent access to
   the data structure is expected to be rare.
 
 
 Using the same mutex for frees and writes can still incur some small
 inefficiencies; for example, a visit can never start if the counter is
-zero and the mutex is taken---even if the mutex is taken by a write,
+zero and the mutex is taken -- even if the mutex is taken by a write,
 which in principle need not block a visit of the data structure.
 However, these are usually not a problem if any of the following
 assumptions are valid:
@@ -163,27 +164,27 @@ assumptions are valid:
 - writes are frequent, but this kind of write (e.g. appending to a
   list) has a very small critical section.
 
-For example, QEMU uses QemuLockCnt to manage an AioContext's list of
+For example, QEMU uses ``QemuLockCnt`` to manage an ``AioContext``'s list of
 bottom halves and file descriptor handlers.  Modifications to the list
 of file descriptor handlers are rare.  Creation of a new bottom half is
 frequent and can happen on a fast path; however: 1) it is almost never
 concurrent with a visit to the list of bottom halves; 2) it only has
-three instructions in the critical path, two assignments and a smp_wmb().
+three instructions in the critical path, two assignments and a ``smp_wmb()``.
 
 
-QemuLockCnt API
----------------
+``QemuLockCnt`` API
+-------------------
 
-The QemuLockCnt API is described in include/qemu/thread.h.
+The ``QemuLockCnt`` API is described in ``include/qemu/thread.h``.
 
 
-QemuLockCnt usage
------------------
+``QemuLockCnt`` usage
+---------------------
 
-This section explains the typical usage patterns for QemuLockCnt functions.
+This section explains the typical usage patterns for ``QemuLockCnt`` functions.
 
 Setting a variable to a non-NULL value can be done between
-qemu_lockcnt_lock and qemu_lockcnt_unlock:
+``qemu_lockcnt_lock`` and ``qemu_lockcnt_unlock``::
 
     qemu_lockcnt_lock(&xyz_lockcnt);
     if (!xyz) {
@@ -193,8 +194,8 @@ qemu_lockcnt_lock and qemu_lockcnt_unlock:
     }
     qemu_lockcnt_unlock(&xyz_lockcnt);
 
-Accessing the value can be done between qemu_lockcnt_inc and
-qemu_lockcnt_dec:
+Accessing the value can be done between ``qemu_lockcnt_inc`` and
+``qemu_lockcnt_dec``::
 
     qemu_lockcnt_inc(&xyz_lockcnt);
     if (xyz) {
@@ -204,11 +205,11 @@ qemu_lockcnt_dec:
     }
     qemu_lockcnt_dec(&xyz_lockcnt);
 
-Freeing the object can similarly use qemu_lockcnt_lock and
-qemu_lockcnt_unlock, but you also need to ensure that the count
-is zero (i.e. there is no concurrent visit).  Because qemu_lockcnt_inc
-takes the QemuLockCnt's lock, the count cannot become non-zero while
-the object is being freed.  Freeing an object looks like this:
+Freeing the object can similarly use ``qemu_lockcnt_lock`` and
+``qemu_lockcnt_unlock``, but you also need to ensure that the count
+is zero (i.e. there is no concurrent visit).  Because ``qemu_lockcnt_inc``
+takes the ``QemuLockCnt``'s lock, the count cannot become non-zero while
+the object is being freed.  Freeing an object looks like this::
 
     qemu_lockcnt_lock(&xyz_lockcnt);
     if (!qemu_lockcnt_count(&xyz_lockcnt)) {
@@ -218,7 +219,7 @@ the object is being freed.  Freeing an object looks like this:
     qemu_lockcnt_unlock(&xyz_lockcnt);
 
 If an object has to be freed right after a visit, you can combine
-the decrement, the locking and the check on count as follows:
+the decrement, the locking and the check on count as follows::
 
     qemu_lockcnt_inc(&xyz_lockcnt);
     if (xyz) {
@@ -232,7 +233,7 @@ the decrement, the locking and the check on count as follows:
         qemu_lockcnt_unlock(&xyz_lockcnt);
     }
 
-QemuLockCnt can also be used to access a list as follows:
+``QemuLockCnt`` can also be used to access a list as follows::
 
     qemu_lockcnt_inc(&io_handlers_lockcnt);
     QLIST_FOREACH_RCU(ioh, &io_handlers, pioh) {
@@ -252,10 +253,10 @@ QemuLockCnt can also be used to access a list as follows:
     }
 
 Again, the RCU primitives are used because new items can be added to the
-list during the walk.  QLIST_FOREACH_RCU ensures that the processor and
+list during the walk.  ``QLIST_FOREACH_RCU`` ensures that the processor and
 the compiler see the appropriate memory barriers.
 
-An alternative pattern uses qemu_lockcnt_dec_if_lock:
+An alternative pattern uses ``qemu_lockcnt_dec_if_lock``::
 
     qemu_lockcnt_inc(&io_handlers_lockcnt);
     QLIST_FOREACH_SAFE_RCU(ioh, &io_handlers, next, pioh) {
@@ -273,5 +274,5 @@ An alternative pattern uses qemu_lockcnt_dec_if_lock:
     }
     qemu_lockcnt_dec(&io_handlers_lockcnt);
 
-Here you can use qemu_lockcnt_dec instead of qemu_lockcnt_dec_and_lock,
+Here you can use ``qemu_lockcnt_dec`` instead of ``qemu_lockcnt_dec_and_lock``,
 because there is no special task to do if the count goes from 1 to 0.
-- 
2.34.1


