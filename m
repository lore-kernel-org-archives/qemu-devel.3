Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFEBD59F6D
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Dec 2025 05:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUIOA-00061C-Lv; Sat, 13 Dec 2025 00:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vUIO7-000604-6L
 for qemu-devel@nongnu.org; Sat, 13 Dec 2025 00:41:51 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vUIO4-0002lt-9K
 for qemu-devel@nongnu.org; Sat, 13 Dec 2025 00:41:50 -0500
Received: from [10.200.7.128] (fs96f9c361.tkyc007.ap.nuro.jp [150.249.195.97])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BD5fMh9021206
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 13 Dec 2025 14:41:36 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=xW6nxdP1WnT6uah7iD4+3rpmvC/VKj++w+/6JQL3bzo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1765604496; v=1;
 b=DPCjaOYbJNdA884t7C2pVUZuDdn2oMm5X3F59j1fCQIi8NDHtK5hWPgFnzwZzW2A
 3lKfLtoclGG7mDcFygDB+ajCyAWB20tGLJVJD6LiNTTTQNmACsWVaDmVbCFWSgP+
 y5H11yDAvevV1PHVx9XbvYGB9VCAyCJGJH11ZKCgywn//VZSxu2/V85ss0q/rNEG
 y+YDFuYFws+QirK9tuQKaVSpk+o0JX/UwVZlNmxwkKzXTg4NEmK9Fb4jcYk/FEx8
 mNIpWcyLLJO2SjWfbjdTEMVcohWlN7FUV59qlIJvbfT0QPM+FzXyw8SoM9Bg0gND
 4GrqpfElXLV/TV0zJJFRug==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 13 Dec 2025 14:41:24 +0900
Subject: [PATCH v2 5/6] rcu: Wake the RCU thread when draining
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251213-force_rcu-v2-5-1de1ca84c6d6@rsg.ci.i.u-tokyo.ac.jp>
References: <20251213-force_rcu-v2-0-1de1ca84c6d6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251213-force_rcu-v2-0-1de1ca84c6d6@rsg.ci.i.u-tokyo.ac.jp>
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
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
 include/qemu/rcu.h |  1 +
 util/rcu.c         | 51 +++++++++++++++++++++++++++++++--------------------
 2 files changed, 32 insertions(+), 20 deletions(-)

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
index 3c4af9d213c8..2f58f3627f74 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -45,12 +45,14 @@
 
 
 #define RCU_CALL_MIN_SIZE        30
+#define RCU_CALL_STATE_FORCED   ((uint32_t)1 << 31)
+#define RCU_CALL_STATE_COUNT    (~RCU_CALL_STATE_FORCED)
 
 unsigned long rcu_gp_ctr = RCU_GP_LOCKED;
 
 QemuEvent rcu_gp_event;
-static int in_drain_call_rcu;
-static int rcu_call_count;
+static QemuEvent rcu_call_force_event;
+static uint32_t rcu_call_state;
 static QemuMutex rcu_registry_lock;
 
 /*
@@ -74,28 +76,35 @@ QEMU_DEFINE_CO_TLS(struct rcu_reader_data, rcu_reader)
 typedef QLIST_HEAD(, rcu_reader_data) ThreadList;
 static ThreadList registry = QLIST_HEAD_INITIALIZER(registry);
 
+void force_rcu(void)
+{
+    qatomic_or(&rcu_call_state, RCU_CALL_STATE_FORCED);
+    qemu_event_set(&rcu_call_force_event);
+}
+
 /* Wait for previous parity/grace period to be empty of readers.  */
-static void wait_for_readers(void)
+static void wait_for_readers(bool force)
 {
     ThreadList qsreaders = QLIST_HEAD_INITIALIZER(qsreaders);
     struct rcu_reader_data *index, *tmp;
-    int sleeps = 0;
+    int sleeps = force ? 0 : 5;
     bool forced = false;
 
+    qemu_event_reset(&rcu_call_force_event);
+
     for (;;) {
         /*
          * Force the grace period to end and wait for it if any of the
          * following heuristical conditions are satisfied:
          * - A decent number of callbacks piled up.
+         * - force_rcu() was called.
          * - It timed out.
-         * - It is in a drain_call_rcu() call.
          *
          * Otherwise, periodically poll the grace period, hoping it ends
          * promptly.
          */
         if (!forced &&
-            (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
-             sleeps >= 5 || qatomic_read(&in_drain_call_rcu))) {
+            (qatomic_read(&rcu_call_state) >= RCU_CALL_MIN_SIZE || !sleeps)) {
             forced = true;
 
             QLIST_FOREACH(index, &registry, node) {
@@ -159,8 +168,8 @@ static void wait_for_readers(void)
              */
             qemu_event_reset(&rcu_gp_event);
         } else {
-            g_usleep(10000);
-            sleeps++;
+            qemu_event_timedwait(&rcu_call_force_event, 10);
+            sleeps--;
         }
 
         qemu_mutex_lock(&rcu_registry_lock);
@@ -170,7 +179,7 @@ static void wait_for_readers(void)
     QLIST_SWAP(&registry, &qsreaders, node);
 }
 
-static void enter_qs(void)
+static void enter_qs(bool force)
 {
     /* Write RCU-protected pointers before reading p_rcu_reader->ctr.
      * Pairs with smp_mb_placeholder() in rcu_read_lock().
@@ -189,14 +198,14 @@ static void enter_qs(void)
              * Switch parity: 0 -> 1, 1 -> 0.
              */
             qatomic_set(&rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR);
-            wait_for_readers();
+            wait_for_readers(force);
             qatomic_set(&rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR);
         } else {
             /* Increment current grace period.  */
             qatomic_set(&rcu_gp_ctr, rcu_gp_ctr + RCU_GP_CTR);
         }
 
-        wait_for_readers();
+        wait_for_readers(force);
     }
 }
 
@@ -282,15 +291,17 @@ static void *call_rcu_thread(void *opaque)
     rcu_register_thread();
 
     for (;;) {
-        int n;
+        uint32_t state;
+        uint32_t n;
 
         /*
-         * Fetch rcu_call_count now, we only must process elements that were
+         * Fetch rcu_call_state now, we only must process elements that were
          * added before enter_qs() starts.
          */
         for (;;) {
             qemu_event_reset(&rcu_call_ready_event);
-            n = qatomic_read(&rcu_call_count);
+            state = qatomic_fetch_and(&rcu_call_state, RCU_CALL_STATE_COUNT);
+            n = state & RCU_CALL_STATE_COUNT;
             if (n) {
                 break;
             }
@@ -301,8 +312,8 @@ static void *call_rcu_thread(void *opaque)
             qemu_event_wait(&rcu_call_ready_event);
         }
 
-        enter_qs();
-        qatomic_sub(&rcu_call_count, n);
+        enter_qs(state & RCU_CALL_STATE_FORCED);
+        qatomic_sub(&rcu_call_state, n);
         bql_lock();
         while (n > 0) {
             node = try_dequeue();
@@ -329,7 +340,7 @@ void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))
 {
     node->func = func;
     enqueue(node);
-    qatomic_inc(&rcu_call_count);
+    qatomic_inc(&rcu_call_state);
     qemu_event_set(&rcu_call_ready_event);
 }
 
@@ -388,10 +399,9 @@ void drain_call_rcu(void)
      * assumed.
      */
 
-    qatomic_inc(&in_drain_call_rcu);
     call_rcu(&sync, sync_rcu_callback, rcu);
+    force_rcu();
     qemu_event_wait(&sync.complete_event);
-    qatomic_dec(&in_drain_call_rcu);
 
     if (locked) {
         bql_lock();
@@ -435,6 +445,7 @@ static void rcu_init_complete(void)
     qemu_mutex_init(&rcu_registry_lock);
     qemu_event_init(&rcu_gp_event, true);
 
+    qemu_event_init(&rcu_call_force_event, false);
     qemu_event_init(&rcu_call_ready_event, false);
 
     /* The caller is assumed to have BQL, so the call_rcu thread

-- 
2.52.0


