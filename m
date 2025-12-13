Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DAFD59F70
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Dec 2025 05:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUIOG-00062L-8M; Sat, 13 Dec 2025 00:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vUIO9-00060z-PG
 for qemu-devel@nongnu.org; Sat, 13 Dec 2025 00:41:54 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vUIO5-0002lu-T7
 for qemu-devel@nongnu.org; Sat, 13 Dec 2025 00:41:53 -0500
Received: from [10.200.7.128] (fs96f9c361.tkyc007.ap.nuro.jp [150.249.195.97])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BD5fMh8021206
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 13 Dec 2025 14:41:36 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ZLXa1OkhAl18Vfmyy2upXDtKbUIi9Uc/X1KonrMu2bQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1765604496; v=1;
 b=qU6zrTB4nDVLezVFhzQ8Ir0gjUJaVGu+s/gptKvZw8QDqKxcoA0pgQILnZ5na2sj
 E8bRuZaDmgKb4y8/z7mpwiPu6U5ZS1KZ3Q8I/d3c/vw96PZgs7iKEPn6AU3T9Q7w
 Ew4OEA/mC4pBYO+FSXm0/EtL0bOWP9LXg0i/dHyPKlLdb18uLUl/IohPVdu1I0Ig
 Tnw5VcjWC8nfH+0neqjxhGlpTPSbEKVP54lps3vKw9OXqm6XX9uqcfYUixyScQm8
 BADp5Y4TQuFTteOOnRCFGUux9X96pjKaHG004CEmN/VnwmUYbeKV60WmuJZb6aSX
 Khh/pQS7spHXEloN3ZW/6g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 13 Dec 2025 14:41:23 +0900
Subject: [PATCH v2 4/6] rcu: Use call_rcu() in synchronize_rcu()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251213-force_rcu-v2-4-1de1ca84c6d6@rsg.ci.i.u-tokyo.ac.jp>
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

Previously, synchronize_rcu() was a single-threaded implementation that
is protected with a mutex. It was used only in the RCU thread and tests,
and real users instead use call_rcu(), which relies on the RCU thread.

The usage of synchronize_rcu() in tests did not accurately represent
real use cases because it caused locking with the mutex, which never
happened in real use cases, and it did not exercise the logic in the
RCU thread.

Add a new implementation of synchronize_rcu() which uses call_rcu() to
represent real use cases in tests. The old synchronize_rcu() is now
renamed to enter_qs() and only used in the RCU thread, making the mutex
unnecessary.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 util/rcu.c | 51 +++++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/util/rcu.c b/util/rcu.c
index acac9446ea98..3c4af9d213c8 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -38,7 +38,7 @@
 
 /*
  * Global grace period counter.  Bit 0 is always one in rcu_gp_ctr.
- * Bits 1 and above are defined in synchronize_rcu.
+ * Bits 1 and above are defined in enter_qs().
  */
 #define RCU_GP_LOCKED           (1UL << 0)
 #define RCU_GP_CTR              (1UL << 1)
@@ -52,7 +52,6 @@ QemuEvent rcu_gp_event;
 static int in_drain_call_rcu;
 static int rcu_call_count;
 static QemuMutex rcu_registry_lock;
-static QemuMutex rcu_sync_lock;
 
 /*
  * Check whether a quiescent state was crossed between the beginning of
@@ -111,7 +110,7 @@ static void wait_for_readers(void)
          *
          * If this is the last iteration, this barrier also prevents
          * frees from seeping upwards, and orders the two wait phases
-         * on architectures with 32-bit longs; see synchronize_rcu().
+         * on architectures with 32-bit longs; see enter_qs().
          */
         smp_mb_global();
 
@@ -137,9 +136,9 @@ static void wait_for_readers(void)
          * wait too much time.
          *
          * rcu_register_thread() may add nodes to &registry; it will not
-         * wake up synchronize_rcu, but that is okay because at least another
+         * wake up enter_qs(), but that is okay because at least another
          * thread must exit its RCU read-side critical section before
-         * synchronize_rcu is done.  The next iteration of the loop will
+         * enter_qs() is done.  The next iteration of the loop will
          * move the new thread's rcu_reader from &registry to &qsreaders,
          * because rcu_gp_ongoing() will return false.
          *
@@ -171,10 +170,8 @@ static void wait_for_readers(void)
     QLIST_SWAP(&registry, &qsreaders, node);
 }
 
-void synchronize_rcu(void)
+static void enter_qs(void)
 {
-    QEMU_LOCK_GUARD(&rcu_sync_lock);
-
     /* Write RCU-protected pointers before reading p_rcu_reader->ctr.
      * Pairs with smp_mb_placeholder() in rcu_read_lock().
      *
@@ -289,7 +286,7 @@ static void *call_rcu_thread(void *opaque)
 
         /*
          * Fetch rcu_call_count now, we only must process elements that were
-         * added before synchronize_rcu() starts.
+         * added before enter_qs() starts.
          */
         for (;;) {
             qemu_event_reset(&rcu_call_ready_event);
@@ -304,7 +301,7 @@ static void *call_rcu_thread(void *opaque)
             qemu_event_wait(&rcu_call_ready_event);
         }
 
-        synchronize_rcu();
+        enter_qs();
         qatomic_sub(&rcu_call_count, n);
         bql_lock();
         while (n > 0) {
@@ -337,15 +334,24 @@ void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))
 }
 
 
-struct rcu_drain {
+typedef struct Sync {
     struct rcu_head rcu;
-    QemuEvent drain_complete_event;
-};
+    QemuEvent complete_event;
+} Sync;
 
-static void drain_rcu_callback(struct rcu_head *node)
+static void sync_rcu_callback(Sync *sync)
 {
-    struct rcu_drain *event = (struct rcu_drain *)node;
-    qemu_event_set(&event->drain_complete_event);
+    qemu_event_set(&sync->complete_event);
+}
+
+void synchronize_rcu(void)
+{
+    Sync sync;
+
+    qemu_event_init(&sync.complete_event, false);
+    call_rcu(&sync, sync_rcu_callback, rcu);
+    qemu_event_wait(&sync.complete_event);
+    qemu_event_destroy(&sync.complete_event);
 }
 
 /*
@@ -359,11 +365,11 @@ static void drain_rcu_callback(struct rcu_head *node)
 
 void drain_call_rcu(void)
 {
-    struct rcu_drain rcu_drain;
+    Sync sync;
     bool locked = bql_locked();
 
-    memset(&rcu_drain, 0, sizeof(struct rcu_drain));
-    qemu_event_init(&rcu_drain.drain_complete_event, false);
+    memset(&sync, 0, sizeof(sync));
+    qemu_event_init(&sync.complete_event, false);
 
     if (locked) {
         bql_unlock();
@@ -383,8 +389,8 @@ void drain_call_rcu(void)
      */
 
     qatomic_inc(&in_drain_call_rcu);
-    call_rcu1(&rcu_drain.rcu, drain_rcu_callback);
-    qemu_event_wait(&rcu_drain.drain_complete_event);
+    call_rcu(&sync, sync_rcu_callback, rcu);
+    qemu_event_wait(&sync.complete_event);
     qatomic_dec(&in_drain_call_rcu);
 
     if (locked) {
@@ -427,7 +433,6 @@ static void rcu_init_complete(void)
     QemuThread thread;
 
     qemu_mutex_init(&rcu_registry_lock);
-    qemu_mutex_init(&rcu_sync_lock);
     qemu_event_init(&rcu_gp_event, true);
 
     qemu_event_init(&rcu_call_ready_event, false);
@@ -460,7 +465,6 @@ static void rcu_init_lock(void)
         return;
     }
 
-    qemu_mutex_lock(&rcu_sync_lock);
     qemu_mutex_lock(&rcu_registry_lock);
 }
 
@@ -471,7 +475,6 @@ static void rcu_init_unlock(void)
     }
 
     qemu_mutex_unlock(&rcu_registry_lock);
-    qemu_mutex_unlock(&rcu_sync_lock);
 }
 
 static void rcu_init_child(void)

-- 
2.52.0


