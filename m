Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA39E83856
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 06:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsEfr-0006Yg-DB; Tue, 17 Feb 2026 01:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vsEfp-0006Wj-EK
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 01:35:05 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vsEfn-0004T5-AB
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 01:35:05 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61H6Yfkh030238
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 17 Feb 2026 15:34:43 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=H6ljr/jVCWKO176X63ceZZm1uT0oaOP95joZ3kpX6PE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1771310083; v=1;
 b=I6ibcv2tH/cxK1WAVj7w1vVYPuCyblBvxIhjoB9Ie8jdOVkH7Iz7UCpjek2k267A
 q6TfDi5WVhibb4on388be7fReS4UQm688TGNFlLJa3PH10VyPS+hDwfARpF9Frqy
 QaDlfw6tPYGcmGBKRpiT5tcWj0D6jsjWLhRiK5nzbSJFFCiqV09v4HBo3sIA/lbL
 dG9N6i85rjXDJu1s8Komvd2367xxxekagRoJKZT4/RjsFHzT+LW9GOFxr2hBGqrK
 EY0Fg9BvbfekKXaGftjg8PRJIzujRhtQN+ZSU8JUEO7amNED8e5FbHFXaNQlUVOI
 ImkI4FP8N7rnaty3Gn3BiA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 17 Feb 2026 15:34:30 +0900
Subject: [PATCH 2/2] Reapply "rcu: Unify force quiescent state"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-alpha-v1-2-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
References: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-67ece
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

This reverts commit ddb4d9d1748681cfde824d765af6cda4334fcce3.

The commit says:
> This reverts commit 55d98e3edeeb17dd8445db27605d2b34f4c3ba85.
>
> The commit introduced a regression in the replay functional test
> on alpha (tests/functional/alpha/test_replay.py), that causes CI
> failures regularly. Thus revert this change until someone has
> figured out what is going wrong here.

Reapply the change as alpha is fixed.

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

-- 
2.53.0


