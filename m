Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5C6CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 06:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Hac-0000pW-12; Thu, 16 Oct 2025 02:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v9HaQ-0000nH-NC
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 02:35:45 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v9HaF-0004TA-0J
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 02:35:37 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59G6YquU099261
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 16 Oct 2025 15:35:05 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Dr456ID8nj2hAPfVNzcXfjYjbtMrOIuqc1lkRDZklFs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1760596505; v=1;
 b=W00g6CQ3a8hVJfKedbJXQpnlyg1oy1RFvhHfS8nRph2dWMxDJN8d1LqDdmBBWbPO
 TwNSt5djle2TemWaSgfhgQyGkvmGalS7vXTmyr/ksXgR1U84fdf5ZZXq7fy3SZAL
 1wIBYR7j5uEWUv+aTwunj92TOoXKK+hGgw2sxNJFp5O9uT2wDKDCqWA/cFOI/9ZR
 10o1uXeAyEnxeS6vkroEhjJSYVHnKuaPTmChU5WYNeEGM4LdW6KYscmycaUq8nIs
 FokbskMK6UmPoSwRsPm0riNeRS24+uGN8PhrwOQaDEMit3zxrT7W2XqprnQIMMF2
 nf5mH31xz7Utv2vftGFP7w==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 16 Oct 2025 15:34:41 +0900
Subject: [PATCH] rcu: Unify force quiescent state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAACS8GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0NT3bT8ouRU3WSTVAPjRMukRHNDSyWg2oKi1LTMCrA50bG1tQDaRQH
 WVwAAAA==
X-Change-ID: 20251015-force-c4e03a9ba719
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Eric Blake <eblake@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
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

Borrow the concept of force quiescent state from Linux to ensure readers
remain fast during normal operation and to avoid stalls.

Background
==========

The previous implementation had four steps to begin reclamation.

1. call_rcu_thread() would wait for the first callback.

2. call_rcu_thread() would periodically poll until a decent number of
   callbacks piled up or it timed out.

3. synchronize_rcu() would statr a grace period (GP).

4. wait_for_readers() would wait for the GP to end. It would also
   trigger the force_rcu notifier to break busy loops in a read-side
   critical section if drain_call_rcu() had been called.

Problem
=======

The separation of waiting logic across these steps led to suboptimal
behavior:

The GP was delayed until call_rcu_thread() stops polling.

force_rcu was not consistently triggered when call_rcu_thread() detected
a high number of pending callbacks or a timeout. This inconsistency
sometimes led to stalls, as reported in a virtio-gpu issue where memory
unmapping was blocked[1].

wait_for_readers() imposed unnecessary overhead in non-urgent cases by
unconditionally executing qatomic_set(&index->waiting, true) and
qemu_event_reset(&rcu_gp_event), which are necessary only for expedited
synchronization.

Solution
========

Move the polling in call_rcu_thread() to wait_for_readers() to prevent
the delay of the GP. Additionally, reorganize wait_for_readers() to
distinguish between two states:

Normal State: it relies exclusively on periodic polling to detect
the end of the GP and maintains the read-side fast path.

Force Quiescent State: Whenever expediting synchronization, it always
triggers force_rcu and executes both qatomic_set(&index->waiting, true)
and qemu_event_reset(&rcu_gp_event). This avoids stalls while confining
the read-side overhead to this state.

This unified approach, inspired by the Linux RCU, ensures consistent and
efficient RCU grace period handling and confirms resolution of the
virtio-gpu issue.

[1] https://lore.kernel.org/qemu-devel/20251014111234.3190346-9-alex.bennee@linaro.org/

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 util/rcu.c | 79 ++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 28 deletions(-)

diff --git a/util/rcu.c b/util/rcu.c
index b703c86f15a3..acac9446ea98 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -43,10 +43,14 @@
 #define RCU_GP_LOCKED           (1UL << 0)
 #define RCU_GP_CTR              (1UL << 1)
 
+
+#define RCU_CALL_MIN_SIZE        30
+
 unsigned long rcu_gp_ctr = RCU_GP_LOCKED;
 
 QemuEvent rcu_gp_event;
 static int in_drain_call_rcu;
+static int rcu_call_count;
 static QemuMutex rcu_registry_lock;
 static QemuMutex rcu_sync_lock;
 
@@ -76,15 +80,29 @@ static void wait_for_readers(void)
 {
     ThreadList qsreaders = QLIST_HEAD_INITIALIZER(qsreaders);
     struct rcu_reader_data *index, *tmp;
+    int sleeps = 0;
+    bool forced = false;
 
     for (;;) {
-        /* We want to be notified of changes made to rcu_gp_ongoing
-         * while we walk the list.
+        /*
+         * Force the grace period to end and wait for it if any of the
+         * following heuristical conditions are satisfied:
+         * - A decent number of callbacks piled up.
+         * - It timed out.
+         * - It is in a drain_call_rcu() call.
+         *
+         * Otherwise, periodically poll the grace period, hoping it ends
+         * promptly.
          */
-        qemu_event_reset(&rcu_gp_event);
+        if (!forced &&
+            (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
+             sleeps >= 5 || qatomic_read(&in_drain_call_rcu))) {
+            forced = true;
 
-        QLIST_FOREACH(index, &registry, node) {
-            qatomic_set(&index->waiting, true);
+            QLIST_FOREACH(index, &registry, node) {
+                notifier_list_notify(&index->force_rcu, NULL);
+                qatomic_set(&index->waiting, true);
+            }
         }
 
         /* Here, order the stores to index->waiting before the loads of
@@ -106,8 +124,6 @@ static void wait_for_readers(void)
                  * get some extra futex wakeups.
                  */
                 qatomic_set(&index->waiting, false);
-            } else if (qatomic_read(&in_drain_call_rcu)) {
-                notifier_list_notify(&index->force_rcu, NULL);
             }
         }
 
@@ -115,7 +131,8 @@ static void wait_for_readers(void)
             break;
         }
 
-        /* Wait for one thread to report a quiescent state and try again.
+        /*
+         * Sleep for a while and try again.
          * Release rcu_registry_lock, so rcu_(un)register_thread() doesn't
          * wait too much time.
          *
@@ -133,7 +150,20 @@ static void wait_for_readers(void)
          * rcu_registry_lock is released.
          */
         qemu_mutex_unlock(&rcu_registry_lock);
-        qemu_event_wait(&rcu_gp_event);
+
+        if (forced) {
+            qemu_event_wait(&rcu_gp_event);
+
+            /*
+             * We want to be notified of changes made to rcu_gp_ongoing
+             * while we walk the list.
+             */
+            qemu_event_reset(&rcu_gp_event);
+        } else {
+            g_usleep(10000);
+            sleeps++;
+        }
+
         qemu_mutex_lock(&rcu_registry_lock);
     }
 
@@ -173,15 +203,11 @@ void synchronize_rcu(void)
     }
 }
 
-
-#define RCU_CALL_MIN_SIZE        30
-
 /* Multi-producer, single-consumer queue based on urcu/static/wfqueue.h
  * from liburcu.  Note that head is only used by the consumer.
  */
 static struct rcu_head dummy;
 static struct rcu_head *head = &dummy, **tail = &dummy.next;
-static int rcu_call_count;
 static QemuEvent rcu_call_ready_event;
 
 static void enqueue(struct rcu_head *node)
@@ -259,30 +285,27 @@ static void *call_rcu_thread(void *opaque)
     rcu_register_thread();
 
     for (;;) {
-        int tries = 0;
-        int n = qatomic_read(&rcu_call_count);
+        int n;
 
-        /* Heuristically wait for a decent number of callbacks to pile up.
+        /*
          * Fetch rcu_call_count now, we only must process elements that were
          * added before synchronize_rcu() starts.
          */
-        while (n == 0 || (n < RCU_CALL_MIN_SIZE && ++tries <= 5)) {
-            g_usleep(10000);
-            if (n == 0) {
-                qemu_event_reset(&rcu_call_ready_event);
-                n = qatomic_read(&rcu_call_count);
-                if (n == 0) {
+        for (;;) {
+            qemu_event_reset(&rcu_call_ready_event);
+            n = qatomic_read(&rcu_call_count);
+            if (n) {
+                break;
+            }
+
 #if defined(CONFIG_MALLOC_TRIM)
-                    malloc_trim(4 * 1024 * 1024);
+            malloc_trim(4 * 1024 * 1024);
 #endif
-                    qemu_event_wait(&rcu_call_ready_event);
-                }
-            }
-            n = qatomic_read(&rcu_call_count);
+            qemu_event_wait(&rcu_call_ready_event);
         }
 
-        qatomic_sub(&rcu_call_count, n);
         synchronize_rcu();
+        qatomic_sub(&rcu_call_count, n);
         bql_lock();
         while (n > 0) {
             node = try_dequeue();

---
base-commit: 0dc905ac306c68649e05cdaf8434123c8f917b41
change-id: 20251015-force-c4e03a9ba719

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


