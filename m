Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E936CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 06:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDzR7-0000cj-PD; Wed, 29 Oct 2025 02:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDzQx-0000XX-2m
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:13:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDzQq-0006qS-LB
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:13:22 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59T6CsDT077258
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 29 Oct 2025 15:13:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=bGlduYgcucjSk4FKxFx6sIJI3Wl9Ysaw1yBUbvVkCek=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1761718383; v=1;
 b=wD+pPedr9AV6xpvmNW1kr+zvTWhBqUCjtasQOkMRlA4L3G7iZCnt+Wfi0Jd+RJ6G
 EghrMqgZ+0hlARmH5tQuYXpP1klnBK237THdIosYS8hcubnYQPfseRb61Vfsb6Vx
 ImjCIDGJH/ovUz0GsgQbjoCeNaJqawGR5Eq/ZHOEKgY59VC5+dXaqTYoqvdW49jU
 dYnGOQTj6/l2qY+jXPDunox4dpxVbrguNs7nEIrACRDVGRK4q76uk1W+rAuowlzh
 Y3EB1szSXi8+8XZBNXn0kcu/ZF4MqvDnBzZvEVCwnTzCirviGy+/ukgiEyBJeieV
 fRkKCK3IprwRGknvJ2BriA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 29 Oct 2025 15:12:48 +0900
Subject: [PATCH 4/5] rcu: Wake the RCU thread when draining
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-force_rcu-v1-4-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
References: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

drain_call_rcu() triggers the force quiescent state, but it can be
delayed if the RCU thread is sleeping. Ensure the force quiescent state
is immediately triggered by waking the RCU thread up.

The logic to trigger the force quiescent state is decoupled as
force_rcu() so that it can be used independently.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/qemu/rcu.h |   1 +
 util/rcu.c         | 106 ++++++++++++++++++++++++++++++++---------------------
 2 files changed, 65 insertions(+), 42 deletions(-)

diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
index 020dbe4d8b77..d6aa4e5854d3 100644
--- a/include/qemu/rcu.h
+++ b/include/qemu/rcu.h
@@ -118,6 +118,7 @@ static inline void rcu_read_unlock(void)
     }
 }
 
+void force_rcu(void);
 void synchronize_rcu(void);
 
 /*
diff --git a/util/rcu.c b/util/rcu.c
index 3c4af9d213c8..85f9333f5dff 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -49,10 +49,13 @@
 unsigned long rcu_gp_ctr = RCU_GP_LOCKED;
 
 QemuEvent rcu_gp_event;
-static int in_drain_call_rcu;
+static bool forced;
 static int rcu_call_count;
 static QemuMutex rcu_registry_lock;
 
+/* Set when the forced variable is set or rcu_call_count becomes non-zero. */
+static QemuEvent sync_event;
+
 /*
  * Check whether a quiescent state was crossed between the beginning of
  * update_counter_and_wait and now.
@@ -74,36 +77,21 @@ QEMU_DEFINE_CO_TLS(struct rcu_reader_data, rcu_reader)
 typedef QLIST_HEAD(, rcu_reader_data) ThreadList;
 static ThreadList registry = QLIST_HEAD_INITIALIZER(registry);
 
+void force_rcu(void)
+{
+    qatomic_set(&forced, true);
+    qemu_event_set(&sync_event);
+}
+
 /* Wait for previous parity/grace period to be empty of readers.  */
-static void wait_for_readers(void)
+static void wait_for_readers(bool sleep)
 {
     ThreadList qsreaders = QLIST_HEAD_INITIALIZER(qsreaders);
     struct rcu_reader_data *index, *tmp;
-    int sleeps = 0;
-    bool forced = false;
+    int sleeps = sleep ? 5 : 0;
+    bool waiting = false;
 
     for (;;) {
-        /*
-         * Force the grace period to end and wait for it if any of the
-         * following heuristical conditions are satisfied:
-         * - A decent number of callbacks piled up.
-         * - It timed out.
-         * - It is in a drain_call_rcu() call.
-         *
-         * Otherwise, periodically poll the grace period, hoping it ends
-         * promptly.
-         */
-        if (!forced &&
-            (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
-             sleeps >= 5 || qatomic_read(&in_drain_call_rcu))) {
-            forced = true;
-
-            QLIST_FOREACH(index, &registry, node) {
-                notifier_list_notify(&index->force_rcu, NULL);
-                qatomic_set(&index->waiting, true);
-            }
-        }
-
         /* Here, order the stores to index->waiting before the loads of
          * index->ctr.  Pairs with smp_mb_placeholder() in rcu_read_unlock(),
          * ensuring that the loads of index->ctr are sequentially consistent.
@@ -150,7 +138,8 @@ static void wait_for_readers(void)
          */
         qemu_mutex_unlock(&rcu_registry_lock);
 
-        if (forced) {
+        if (waiting) {
+            /* Wait for the forced quiescent state. */
             qemu_event_wait(&rcu_gp_event);
 
             /*
@@ -158,9 +147,25 @@ static void wait_for_readers(void)
              * while we walk the list.
              */
             qemu_event_reset(&rcu_gp_event);
+        } else if (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
+                   !sleeps || qemu_event_timedwait(&sync_event, 10)) {
+            /*
+             * Now one of the following heuristical conditions is satisfied:
+             * - A decent number of callbacks piled up.
+             * - It timed out.
+             * - force_rcu() was called.
+             *
+             * Force a quiescent state.
+             */
+            waiting = true;
+
+            QLIST_FOREACH(index, &registry, node) {
+                notifier_list_notify(&index->force_rcu, NULL);
+                qatomic_set(&index->waiting, true);
+            }
         } else {
-            g_usleep(10000);
-            sleeps++;
+            /* Try again. */
+            sleeps--;
         }
 
         qemu_mutex_lock(&rcu_registry_lock);
@@ -170,7 +175,7 @@ static void wait_for_readers(void)
     QLIST_SWAP(&registry, &qsreaders, node);
 }
 
-static void enter_qs(void)
+static void enter_qs(bool sleep)
 {
     /* Write RCU-protected pointers before reading p_rcu_reader->ctr.
      * Pairs with smp_mb_placeholder() in rcu_read_lock().
@@ -189,14 +194,14 @@ static void enter_qs(void)
              * Switch parity: 0 -> 1, 1 -> 0.
              */
             qatomic_set(&rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR);
-            wait_for_readers();
+            wait_for_readers(sleep);
             qatomic_set(&rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR);
         } else {
             /* Increment current grace period.  */
             qatomic_set(&rcu_gp_ctr, rcu_gp_ctr + RCU_GP_CTR);
         }
 
-        wait_for_readers();
+        wait_for_readers(sleep);
     }
 }
 
@@ -205,7 +210,6 @@ static void enter_qs(void)
  */
 static struct rcu_head dummy;
 static struct rcu_head *head = &dummy, **tail = &dummy.next;
-static QemuEvent rcu_call_ready_event;
 
 static void enqueue(struct rcu_head *node)
 {
@@ -282,6 +286,7 @@ static void *call_rcu_thread(void *opaque)
     rcu_register_thread();
 
     for (;;) {
+        bool sleep = true;
         int n;
 
         /*
@@ -289,7 +294,7 @@ static void *call_rcu_thread(void *opaque)
          * added before enter_qs() starts.
          */
         for (;;) {
-            qemu_event_reset(&rcu_call_ready_event);
+            qemu_event_reset(&sync_event);
             n = qatomic_read(&rcu_call_count);
             if (n) {
                 break;
@@ -298,20 +303,36 @@ static void *call_rcu_thread(void *opaque)
 #if defined(CONFIG_MALLOC_TRIM)
             malloc_trim(4 * 1024 * 1024);
 #endif
-            qemu_event_wait(&rcu_call_ready_event);
+            qemu_event_wait(&sync_event);
+        }
+
+        /*
+         * Ensure that an event for a rcu_call_count change will not interrupt
+         * wait_for_readers().
+         */
+        qemu_event_reset(&sync_event);
+
+        /*
+         * Ensure that the forced variable has not been set after fetching
+         * rcu_call_count; otherwise we may get confused by a force quiescent
+         * state request for an element later than n.
+         */
+        while (qatomic_xchg(&forced, false)) {
+            sleep = false;
+            n = qatomic_read(&rcu_call_count);
         }
 
-        enter_qs();
+        enter_qs(sleep);
         qatomic_sub(&rcu_call_count, n);
         bql_lock();
         while (n > 0) {
             node = try_dequeue();
             while (!node) {
                 bql_unlock();
-                qemu_event_reset(&rcu_call_ready_event);
+                qemu_event_reset(&sync_event);
                 node = try_dequeue();
                 if (!node) {
-                    qemu_event_wait(&rcu_call_ready_event);
+                    qemu_event_wait(&sync_event);
                     node = try_dequeue();
                 }
                 bql_lock();
@@ -329,8 +350,10 @@ void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))
 {
     node->func = func;
     enqueue(node);
-    qatomic_inc(&rcu_call_count);
-    qemu_event_set(&rcu_call_ready_event);
+
+    if (!qatomic_fetch_inc(&rcu_call_count)) {
+        qemu_event_set(&sync_event);
+    }
 }
 
 
@@ -388,10 +411,9 @@ void drain_call_rcu(void)
      * assumed.
      */
 
-    qatomic_inc(&in_drain_call_rcu);
     call_rcu(&sync, sync_rcu_callback, rcu);
+    force_rcu();
     qemu_event_wait(&sync.complete_event);
-    qatomic_dec(&in_drain_call_rcu);
 
     if (locked) {
         bql_lock();
@@ -435,7 +457,7 @@ static void rcu_init_complete(void)
     qemu_mutex_init(&rcu_registry_lock);
     qemu_event_init(&rcu_gp_event, true);
 
-    qemu_event_init(&rcu_call_ready_event, false);
+    qemu_event_init(&sync_event, false);
 
     /* The caller is assumed to have BQL, so the call_rcu thread
      * must have been quiescent even after forking, just recreate it.

-- 
2.51.0


