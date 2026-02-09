Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB78DE81BA4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 12:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpPzj-0005Xy-1y; Mon, 09 Feb 2026 07:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vpPzh-0005XZ-Dr
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 07:03:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vpPzc-0002xB-9X
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 07:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770638628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xMCydgfIPpqOETrc37JeDj/GO13UP8fDuVr45Cb/DVI=;
 b=A+GhBU2ACUIufFykEy8VNozrJLEI4rF9fxT47QzCqhXdZtE3zcasznBaqh9Oj19yu99KOJ
 S1TiLg5daiEbigiztc4zgKdzvuRqoK2p+PffXszId1c0zcE7OLUllYFmiyQqyxCX0V8DUv
 hqlYHDa0su/eeEnOf9iWcXTey7x5duc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-ypJ-M_vbNMymdt2Da-qp_A-1; Mon,
 09 Feb 2026 07:03:47 -0500
X-MC-Unique: ypJ-M_vbNMymdt2Da-qp_A-1
X-Mimecast-MFC-AGG-ID: ypJ-M_vbNMymdt2Da-qp_A_1770638626
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13BB119560B0; Mon,  9 Feb 2026 12:03:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.227])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1115118003F6; Mon,  9 Feb 2026 12:03:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH] Revert "rcu: Unify force quiescent state"
Date: Mon,  9 Feb 2026 13:03:36 +0100
Message-ID: <20260209120336.41454-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

This reverts commit 55d98e3edeeb17dd8445db27605d2b34f4c3ba85.

The commit introduced a regression in the replay functional test
on alpha (tests/functional/alpha/test_replay.py), that causes CI
failures regularly. Thus revert this change until someone has
figured out what is going wrong here.

Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3197
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 I just hit this again in the CI:
 https://gitlab.com/thuth/qemu/-/jobs/13018713844
 ... it's annoying, so I'd like to suggest to revert the offending
 patch 'til someone fixed this.

 util/rcu.c | 79 +++++++++++++++++++-----------------------------------
 1 file changed, 28 insertions(+), 51 deletions(-)

diff --git a/util/rcu.c b/util/rcu.c
index acac9446ea9..b703c86f15a 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -43,14 +43,10 @@
 #define RCU_GP_LOCKED           (1UL << 0)
 #define RCU_GP_CTR              (1UL << 1)
 
-
-#define RCU_CALL_MIN_SIZE        30
-
 unsigned long rcu_gp_ctr = RCU_GP_LOCKED;
 
 QemuEvent rcu_gp_event;
 static int in_drain_call_rcu;
-static int rcu_call_count;
 static QemuMutex rcu_registry_lock;
 static QemuMutex rcu_sync_lock;
 
@@ -80,29 +76,15 @@ static void wait_for_readers(void)
 {
     ThreadList qsreaders = QLIST_HEAD_INITIALIZER(qsreaders);
     struct rcu_reader_data *index, *tmp;
-    int sleeps = 0;
-    bool forced = false;
 
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
+        /* We want to be notified of changes made to rcu_gp_ongoing
+         * while we walk the list.
          */
-        if (!forced &&
-            (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
-             sleeps >= 5 || qatomic_read(&in_drain_call_rcu))) {
-            forced = true;
+        qemu_event_reset(&rcu_gp_event);
 
-            QLIST_FOREACH(index, &registry, node) {
-                notifier_list_notify(&index->force_rcu, NULL);
-                qatomic_set(&index->waiting, true);
-            }
+        QLIST_FOREACH(index, &registry, node) {
+            qatomic_set(&index->waiting, true);
         }
 
         /* Here, order the stores to index->waiting before the loads of
@@ -124,6 +106,8 @@ static void wait_for_readers(void)
                  * get some extra futex wakeups.
                  */
                 qatomic_set(&index->waiting, false);
+            } else if (qatomic_read(&in_drain_call_rcu)) {
+                notifier_list_notify(&index->force_rcu, NULL);
             }
         }
 
@@ -131,8 +115,7 @@ static void wait_for_readers(void)
             break;
         }
 
-        /*
-         * Sleep for a while and try again.
+        /* Wait for one thread to report a quiescent state and try again.
          * Release rcu_registry_lock, so rcu_(un)register_thread() doesn't
          * wait too much time.
          *
@@ -150,20 +133,7 @@ static void wait_for_readers(void)
          * rcu_registry_lock is released.
          */
         qemu_mutex_unlock(&rcu_registry_lock);
-
-        if (forced) {
-            qemu_event_wait(&rcu_gp_event);
-
-            /*
-             * We want to be notified of changes made to rcu_gp_ongoing
-             * while we walk the list.
-             */
-            qemu_event_reset(&rcu_gp_event);
-        } else {
-            g_usleep(10000);
-            sleeps++;
-        }
-
+        qemu_event_wait(&rcu_gp_event);
         qemu_mutex_lock(&rcu_registry_lock);
     }
 
@@ -203,11 +173,15 @@ void synchronize_rcu(void)
     }
 }
 
+
+#define RCU_CALL_MIN_SIZE        30
+
 /* Multi-producer, single-consumer queue based on urcu/static/wfqueue.h
  * from liburcu.  Note that head is only used by the consumer.
  */
 static struct rcu_head dummy;
 static struct rcu_head *head = &dummy, **tail = &dummy.next;
+static int rcu_call_count;
 static QemuEvent rcu_call_ready_event;
 
 static void enqueue(struct rcu_head *node)
@@ -285,27 +259,30 @@ static void *call_rcu_thread(void *opaque)
     rcu_register_thread();
 
     for (;;) {
-        int n;
+        int tries = 0;
+        int n = qatomic_read(&rcu_call_count);
 
-        /*
+        /* Heuristically wait for a decent number of callbacks to pile up.
          * Fetch rcu_call_count now, we only must process elements that were
          * added before synchronize_rcu() starts.
          */
-        for (;;) {
-            qemu_event_reset(&rcu_call_ready_event);
-            n = qatomic_read(&rcu_call_count);
-            if (n) {
-                break;
-            }
-
+        while (n == 0 || (n < RCU_CALL_MIN_SIZE && ++tries <= 5)) {
+            g_usleep(10000);
+            if (n == 0) {
+                qemu_event_reset(&rcu_call_ready_event);
+                n = qatomic_read(&rcu_call_count);
+                if (n == 0) {
 #if defined(CONFIG_MALLOC_TRIM)
-            malloc_trim(4 * 1024 * 1024);
+                    malloc_trim(4 * 1024 * 1024);
 #endif
-            qemu_event_wait(&rcu_call_ready_event);
+                    qemu_event_wait(&rcu_call_ready_event);
+                }
+            }
+            n = qatomic_read(&rcu_call_count);
         }
 
-        synchronize_rcu();
         qatomic_sub(&rcu_call_count, n);
+        synchronize_rcu();
         bql_lock();
         while (n > 0) {
             node = try_dequeue();
-- 
2.52.0


