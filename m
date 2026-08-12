Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5975AC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8n1-00052B-Am; Wed, 12 Aug 2026 09:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8kA-0003DL-2N; Wed, 12 Aug 2026 09:11:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8k7-0006F7-RJ; Wed, 12 Aug 2026 09:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=v9hUBAdrJXRkD0+MJSSW4eZs9euezCpjT7sfddaW30g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ae4lW5ZSjgiAhaqu9nY/5MZTKwBtusmECaJRnn7ZHEecmfn6QHX3eF9JDuqC2H1kn
 zi9lWgWDBTpkOwiQncKKKNjKiT7wV2utT0hFsOlQry5XvrS5tLMwoRRChPHOai79Ie
 nWBqv+TVw7dCMEaBh+gIGr9qo5nhYiOtHJk8GLxu/8Y2R2gHlEhcstLMni8RAiFvlv
 AFpMsBmxir4uYjvEB+x6lXXgvi8I/k4Okkr03Z8Rs1NgDQms9tZU3fpqASZY6tQhKH
 oSxlMlvNSouXUOF+bczE1VIoVvfR3nfwkAkGon9guKkG0WXcBVMj/LxzZP53jUeKrd
 m+Q+r4a37uP+A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9FE201CA4D6;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D65F7409BB9;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B3D712F942; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 087/102] coroutine: fix lost wakeup in
 qemu_co_sleep_wake()
Date: Wed, 12 Aug 2026 16:02:02 +0300
Message-ID: <20260812130233.621965-87-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Denis V. Lunev" <den@openvz.org>

cache_clean_timer_del_and_wait() cancels the cache-cleaner coroutine
by setting s->cache_clean_interval = 0 and calling qemu_co_sleep_wake()
to cut short its qemu_co_sleep_ns_wakeable(). qemu_co_sleep_wake() is
fire-and-forget: it reads w->to_wake and silently returns when it is
NULL. A sleeper that is between two iterations -- has just released
s->lock but has not yet set w->to_wake inside qemu_co_sleep() -- loses
the wake:

  iothread0 timer coroutine           main thread (qcow2 close)
  -------------------------           -------------------------
  while-body (holding s->lock):
    read interval = 600
    wait_ns = 600 * NS
    release s->lock
                                      take s->lock
                                      interval = 0
                                      qemu_co_sleep_wake(w):
                                        w->to_wake == NULL -> skip
                                        return
                                      qemu_co_queue_wait(exit, s->lock):
                                        release s->lock
                                        yield
  qemu_co_sleep_ns_wakeable:
    aio_timer_init(+600 s)
    qemu_co_sleep:
      cas scheduled NULL -> "qsns"
      w->to_wake = co
      yield  [sleeps 600 s]

cache_clean_timer_del_and_wait() then blocks on cache_clean_timer_exit
until the original 600 s expiry fires, and qcow2_close() holds BQL the
whole time so the VM stalls behind it.

block_copy_kick() has the same shape. Fix the primitive once instead
of working around it in each caller.

Use a tri-state for QemuCoSleep::to_wake:

  NULL     - idle
  co       - sleeper parked
  PENDING  - wake delivered, no sleeper yet (sticky)

qemu_co_sleep_wake() xchgs PENDING into to_wake: a real sleeper is
woken, NULL/PENDING is left untouched so the wake stays sticky.
qemu_co_sleep() cmpxchg-publishes itself as the sleeper; if a wake
was delivered before it got there or races the publish, the cmpxchg
observes PENDING and returns without yielding. On normal resume
qemu_co_sleep() clears the PENDING the waker left behind so the next
sleep starts clean.

A double-fire (real wake plus timer callback) is harmless: the first
xchg returns the coroutine and wakes it; the second returns PENDING
and is a no-op. Cancellation latency through qemu_co_sleep_wake() is
now bounded by aio_co_wake() rather than by the sleep duration.

Fixes: f86dde9a15 ("qcow2: Fix cache_clean_timer")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Hanna Czenczek <hreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260610115850.2410566-2-den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit e554413bd2b4d6e1f31eebfb499bce5238b91646)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index e545bbf620f..1c31de60f94 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -260,10 +260,19 @@ int coroutine_fn qemu_co_timeout(CoroutineEntry *entry, void *opaque,
                                  uint64_t timeout_ns, CleanupFunc clean);
 
 /**
- * Wake a coroutine if it is sleeping in qemu_co_sleep_ns. The timer will be
- * deleted. @sleep_state must be the variable whose address was given to
- * qemu_co_sleep_ns() and should be checked to be non-NULL before calling
- * qemu_co_sleep_wake().
+ * Wake a coroutine sleeping in qemu_co_sleep() or qemu_co_sleep_ns_wakeable().
+ * The timer set up by the latter is deleted on wakeup.
+ *
+ * The wake is sticky: if no sleeper is parked on @w at the time of the call,
+ * the wake is recorded on @w and consumed by the next qemu_co_sleep() on the
+ * same @w, which then returns without yielding. This closes the lost-wakeup
+ * window between two sleeps and is the documented behavior callers should
+ * rely on -- e.g. a cancellation signal raised between iterations of a
+ * sleep/work loop will shorten the next sleep instead of being dropped.
+ *
+ * The state persists until consumed: if no further qemu_co_sleep() is ever
+ * called on @w, the pending wake is harmlessly discarded when @w goes away.
+ * Multiple wakes coalesce -- the next sleep consumes at most one.
  */
 void qemu_co_sleep_wake(QemuCoSleep *w);
 
diff --git a/tests/unit/test-coroutine.c b/tests/unit/test-coroutine.c
index 49d4d9b2512..aa1f719b081 100644
--- a/tests/unit/test-coroutine.c
+++ b/tests/unit/test-coroutine.c
@@ -421,6 +421,57 @@ static void test_co_rwlock_downgrade(void)
     g_assert(c1_done);
 }
 
+/*
+ * Check that a wake delivered before the sleeper parks is not lost.
+ *
+ * qemu_co_sleep_wake() is fire-and-forget: a caller cancelling a
+ * sleep/work loop may call it in the window after the sleeper has
+ * decided to sleep but before it has published itself inside
+ * qemu_co_sleep(). The wake must be sticky and shorten the next sleep
+ * rather than being dropped (which would block until the full sleep
+ * duration expired).
+ *
+ * No threads, timers or AioContext are needed: coroutines are
+ * cooperative, so ordering the wake before the sleep deterministically
+ * reproduces the state the racing waker would otherwise produce.
+ */
+
+typedef struct {
+    QemuCoSleep w;
+    bool completed;
+} CoSleepWakeData;
+
+static void coroutine_fn co_sleep_wake_entry(void *opaque)
+{
+    CoSleepWakeData *d = opaque;
+
+    /*
+     * The wake was already delivered before we got here. qemu_co_sleep()
+     * must consume it and return without yielding.
+     */
+    qemu_co_sleep(&d->w);
+    d->completed = true;
+}
+
+static void test_co_sleep_wake_before_sleep(void)
+{
+    CoSleepWakeData d = { .w = { 0 }, .completed = false };
+    Coroutine *co = qemu_coroutine_create(co_sleep_wake_entry, &d);
+
+    /* Waker runs first, while no sleeper is parked on w. */
+    qemu_co_sleep_wake(&d.w);
+
+    /*
+     * Entering runs qemu_co_sleep(), which consumes the pending wake and
+     * returns without yielding, so the coroutine runs straight to
+     * completion in this single enter. With the pre-fix primitive the wake
+     * is dropped, qemu_co_sleep() parks, and completed stays false.
+     */
+    qemu_coroutine_enter(co);
+
+    g_assert(d.completed);
+}
+
 /*
  * Check that creation, enter, and return work
  */
@@ -660,6 +711,8 @@ int main(int argc, char **argv)
     g_test_add_func("/locking/co-mutex/lockable", test_co_mutex_lockable);
     g_test_add_func("/locking/co-rwlock/upgrade", test_co_rwlock_upgrade);
     g_test_add_func("/locking/co-rwlock/downgrade", test_co_rwlock_downgrade);
+    g_test_add_func("/locking/co-sleep/wake-before-sleep",
+                    test_co_sleep_wake_before_sleep);
     if (g_test_perf()) {
         g_test_add_func("/perf/lifecycle", perf_lifecycle);
         g_test_add_func("/perf/nesting", perf_nesting);
diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
index af59f9af984..30458e28083 100644
--- a/util/qemu-coroutine-sleep.c
+++ b/util/qemu-coroutine-sleep.c
@@ -18,20 +18,29 @@
 
 static const char *qemu_co_sleep_ns__scheduled = "qemu_co_sleep_ns";
 
+/*
+ * Sentinel stored in QemuCoSleep::to_wake by qemu_co_sleep_wake() when no
+ * sleeper has parked yet. The next qemu_co_sleep() consumes it and returns
+ * without yielding, so a wake that races the arming of a sleep is never
+ * lost.
+ */
+#define QEMU_CO_SLEEP_PENDING ((Coroutine *)(uintptr_t)1)
+
 void qemu_co_sleep_wake(QemuCoSleep *w)
 {
     Coroutine *co;
 
-    co = w->to_wake;
-    w->to_wake = NULL;
-    if (co) {
-        /* Write of schedule protected by barrier write in aio_co_schedule */
-        const char *scheduled = qatomic_cmpxchg(&co->scheduled,
-                                                qemu_co_sleep_ns__scheduled, NULL);
-
-        assert(scheduled == qemu_co_sleep_ns__scheduled);
-        aio_co_wake(co);
+    co = qatomic_xchg(&w->to_wake, QEMU_CO_SLEEP_PENDING);
+    if (co == NULL || co == QEMU_CO_SLEEP_PENDING) {
+        /* No sleeper, or a wake is already pending. */
+        return;
     }
+
+    /* Write of scheduled protected by barrier write in aio_co_schedule */
+    const char *scheduled = qatomic_cmpxchg(&co->scheduled,
+                                            qemu_co_sleep_ns__scheduled, NULL);
+    assert(scheduled == qemu_co_sleep_ns__scheduled);
+    aio_co_wake(co);
 }
 
 static void co_sleep_cb(void *opaque)
@@ -43,6 +52,7 @@ static void co_sleep_cb(void *opaque)
 void coroutine_fn qemu_co_sleep(QemuCoSleep *w)
 {
     Coroutine *co = qemu_coroutine_self();
+    Coroutine *prev;
 
     const char *scheduled = qatomic_cmpxchg(&co->scheduled, NULL,
                                             qemu_co_sleep_ns__scheduled);
@@ -53,11 +63,23 @@ void coroutine_fn qemu_co_sleep(QemuCoSleep *w)
         abort();
     }
 
-    w->to_wake = co;
+    /*
+     * Publish ourselves as the sleeper. A wake delivered before we got here,
+     * or one racing this publish, leaves QEMU_CO_SLEEP_PENDING in to_wake;
+     * the cmpxchg then fails and we consume the wake without yielding.
+     */
+    prev = qatomic_cmpxchg(&w->to_wake, NULL, co);
+    if (prev == QEMU_CO_SLEEP_PENDING) {
+        qatomic_set(&w->to_wake, NULL);
+        qatomic_set(&co->scheduled, NULL);
+        return;
+    }
+    assert(prev == NULL);
+
     qemu_coroutine_yield();
 
-    /* w->to_wake is cleared before resuming this coroutine.  */
-    assert(w->to_wake == NULL);
+    /* The waker left QEMU_CO_SLEEP_PENDING; clear it for the next sleep. */
+    qatomic_set(&w->to_wake, NULL);
 }
 
 void coroutine_fn qemu_co_sleep_ns_wakeable(QemuCoSleep *w,
@@ -70,9 +92,10 @@ void coroutine_fn qemu_co_sleep_ns_wakeable(QemuCoSleep *w,
     timer_mod(&ts, qemu_clock_get_ns(type) + ns);
 
     /*
-     * The timer will fire in the current AiOContext, so the callback
-     * must happen after qemu_co_sleep yields and there is no race
-     * between timer_mod and qemu_co_sleep.
+     * A wake racing with the arming of the sleep -- including the timer
+     * we just armed firing in another AioContext before qemu_co_sleep()
+     * publishes itself -- is captured by the sticky PENDING state in
+     * qemu_co_sleep_wake() and consumed here without yielding.
      */
     qemu_co_sleep(w);
     timer_del(&ts);
-- 
2.47.3


