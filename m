Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AA3CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXHaD-0003vq-SE; Wed, 10 Jun 2026 07:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wXHaC-0003vK-V2; Wed, 10 Jun 2026 07:58:56 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wXHaA-0004l2-Pi; Wed, 10 Jun 2026 07:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=dd7G+oOQ3XDqCPt5ZPMTezsOHnbLQ5RisRC3c3C2stA=; b=PhH7Kj2ptl+2
 +6OmEK9CENR1C9AQmeJ77X3UrcbzQ8C32FIsaIJVb9m6ZlNkV3TsLQVHsV0xirAHotxbRFiQWGnbb
 nje9rBAgeYT3FTH3zVwsXbp1SEE1PgbAdBHDeFnzdvN+KfgAJTV1mxxtSpgKCHWEoXMyylMcF6oRe
 i4im3ctfuseG3sQ5m5aoz+vVCoxkcoQfCm30qLYKt777Rdb2sAo2srQ2e1Cn+1V+YPuCgn0mNyAvO
 TgtZafFSZZiz8j31YhAYEQSy7DWSKO8sGsQ8ZOqCtvkrpigDYsmg0JgJrTf0XWmZZOmz4b4O4rAEY
 Y15ZoC0k8EQLx+GrNy8TaA==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1wXHZl-001cCx-2M;
 Wed, 10 Jun 2026 13:58:50 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v3 1/1] coroutine: fix lost wakeup in qemu_co_sleep_wake()
Date: Wed, 10 Jun 2026 13:58:50 +0200
Message-ID: <20260610115850.2410566-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610115850.2410566-1-den@openvz.org>
References: <20260610115850.2410566-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
---
 include/qemu/coroutine.h    | 17 +++++++++---
 tests/unit/test-coroutine.c | 53 +++++++++++++++++++++++++++++++++++++
 util/qemu-coroutine-sleep.c | 53 ++++++++++++++++++++++++++-----------
 3 files changed, 104 insertions(+), 19 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index e545bbf620..1c31de60f9 100644
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
index 49d4d9b251..aa1f719b08 100644
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
index edef117284..19ded0b6fd 100644
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
2.53.0


