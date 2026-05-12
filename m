Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E022CCD4F3E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuJv-00005O-5v; Tue, 12 May 2026 17:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuJE-0007CC-IR; Tue, 12 May 2026 17:06:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuJC-0001jA-7F; Tue, 12 May 2026 17:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619300; bh=0LVjgUCvNCJJfSlu6OGSkQ1Ty4gO4qNymXYjjVcmpok=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Atnjua/GPT5GiE9G2P7iJzUXkhhdQU0JQt3T6qR6Y1ZrLZiKWlIw0UOpgBqlvWuX1
 /UBwGCKYnPp1alqmHxGOBQHx6Q+9ZAUBZZhxYrK9vDjD0znz4i5Dw/7UiHO8NpwHQr
 90MtogIS59XtOszkwlsDGM91qyMnXFhkMGWX9mJR7PfogPHOk6IhQKqRHCz0BEj5PK
 tflsst/c0QNoLvoIsXAu/vmdCiCUfXzU2uhpNtqdZWikSgGTJH6VaZLbjwnUX607PR
 vQVKCNv8mR9JU+KZkT9J3AdOh7URG+/zGAm5zkMk2Y4TSbsbOCU+l/cj7Vq5qmdCgI
 k0bFIicOf5vOw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 53E911AA345;
 Tue, 12 May 2026 23:55:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 61C2C3ABCB6;
 Tue, 12 May 2026 23:55:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Hanna Czenczek <hreitz@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 009/117] throttle-group: Fix race condition in
 throttle_group_restart_queue()
Date: Tue, 12 May 2026 23:53:11 +0300
Message-ID: <20260512205503.361097-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

From: Alberto Garcia <berto@igalia.com>

When a timer is fired a pending I/O request is restarted and
tg->any_timer_armed is reset so other requests can be scheduled.

However we're resetting any_timer_armed first in timer_cb() before
the request is actually restarted, and there's a window between both
moments in which another thread can arm the same timer, hitting an
assertion in throttle_group_restart_queue().

This can be solved by deferring the reset of tg->any_timer_armed to
the moment when the queue is actually restarted, which is protected by
tg->lock, preventing other threads from arming the timer before that.

In addition to that, throttle_group_restart_tgm() is also updated to
hold tg->lock while the timer is being inspected. Here we consider
three different scenarios:

- If the tgm has a timer set, fire it immediately
- If another tgm has a timer set, restart the queue anyway
- If there is no timer set in this group then simulate a timer that
  fires immediately, by setting tg->any_timer_armed in order to
  prevent other threads from arming a timer in the meantime.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3194
Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-Id: <825598ef34ad384d936da19d634eda75598508f7.1773316842.git.berto@igalia.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
(cherry picked from commit 9c8430f5d65144b85ad76433369288182a1c7baa)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 5329ff1fdb..4b1b1944c2 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -391,6 +391,7 @@ void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm
 typedef struct {
     ThrottleGroupMember *tgm;
     ThrottleDirection direction;
+    bool reset_timer_armed;
 } RestartData;
 
 static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
@@ -403,6 +404,9 @@ static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
     bool empty_queue;
 
     qemu_mutex_lock(&tg->lock);
+    if (data->reset_timer_armed) {
+        tg->any_timer_armed[direction] = false;
+    }
     empty_queue = !throttle_group_co_restart_queue(tgm, direction);
 
     /* If the request queue was empty then we have to take care of
@@ -419,18 +423,23 @@ static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
 }
 
 static void throttle_group_restart_queue(ThrottleGroupMember *tgm,
-                                        ThrottleDirection direction)
+                                         ThrottleDirection direction,
+                                         bool reset_timer_armed)
 {
     Coroutine *co;
     RestartData *rd = g_new0(RestartData, 1);
 
     rd->tgm = tgm;
     rd->direction = direction;
+    rd->reset_timer_armed = reset_timer_armed;
 
-    /* This function is called when a timer is fired or when
-     * throttle_group_restart_tgm() is called. Either way, there can
+    /* If reset_timer_armed is set then this means that this function
+     * was called when a timer was fired (either from timer_cb() or
+     * from throttle_group_restart_tgm()). In this case there can
      * be no timer pending on this tgm at this point */
-    assert(!timer_pending(tgm->throttle_timers.timers[direction]));
+    if (reset_timer_armed) {
+        assert(!timer_pending(tgm->throttle_timers.timers[direction]));
+    }
 
     qatomic_inc(&tgm->restart_pending);
 
@@ -444,15 +453,50 @@ void throttle_group_restart_tgm(ThrottleGroupMember *tgm)
 
     if (tgm->throttle_state) {
         for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++) {
-            QEMUTimer *t = tgm->throttle_timers.timers[dir];
+            QEMUTimer *t;
+            ThrottleState *ts = tgm->throttle_state;
+            ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
+            bool reset_timer_armed;
+
+            /*
+             * This function restarts the tgm's queue immediately.
+             * This is used for example for callers to drain all requests.
+             * There are three different scenarios depending on whether
+             * a timer is armed for this tg and which tgm owns the timer.
+             */
+
+            qemu_mutex_lock(&tg->lock);
+
+            t = tgm->throttle_timers.timers[dir];
             if (timer_pending(t)) {
-                /* If there's a pending timer on this tgm, fire it now */
+                /*
+                 * Case 1: this tgm has a pending timer.
+                 * We can fire the timer immediately.
+                 */
                 timer_del(t);
-                timer_cb(tgm, dir);
+                reset_timer_armed = true;
+            } else if (tg->any_timer_armed[dir]) {
+                /*
+                 * Case 2: another tgm has a pending timer.
+                 * In this case we can still restart the queue but we
+                 * have to leave any_timer_armed untouched so the
+                 * other tgm's timer is not disrupted.
+                 */
+                reset_timer_armed = false;
             } else {
-                /* Else run the next request from the queue manually */
-                throttle_group_restart_queue(tgm, dir);
+                /*
+                 * Case 3: there is no timer set for this group.
+                 * Here we can simulate a timer that fires immediately,
+                 * so the queue is restarted but no other thread
+                 * can arm a timer in the meantime.
+                 */
+                tg->any_timer_armed[dir] = true;
+                reset_timer_armed = true;
             }
+
+            qemu_mutex_unlock(&tg->lock);
+
+            throttle_group_restart_queue(tgm, dir, reset_timer_armed);
         }
     }
 }
@@ -499,16 +543,13 @@ void throttle_group_get_config(ThrottleGroupMember *tgm, ThrottleConfig *cfg)
  */
 static void timer_cb(ThrottleGroupMember *tgm, ThrottleDirection direction)
 {
-    ThrottleState *ts = tgm->throttle_state;
-    ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
-
-    /* The timer has just been fired, so we can update the flag */
-    qemu_mutex_lock(&tg->lock);
-    tg->any_timer_armed[direction] = false;
-    qemu_mutex_unlock(&tg->lock);
-
-    /* Run the request that was waiting for this timer */
-    throttle_group_restart_queue(tgm, direction);
+    /*
+     * Run the request that was waiting for this timer.
+     * tg->any_timer_armed needs to be cleared, but we'll do it later
+     * when the queue is restarted in order to prevent another thread
+     * from arming the timer before that.
+     */
+    throttle_group_restart_queue(tgm, direction, true);
 }
 
 static void read_timer_cb(void *opaque)
-- 
2.47.3


