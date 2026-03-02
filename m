Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E19D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyyQ-0003zz-LX; Mon, 02 Mar 2026 03:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxP-0003MF-0Q
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxN-0002GL-9S
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=szx0I80Lf0BuHe9FbaGyt5toyYxnG/9fgTe5KnAGYFc=;
 b=VwFagnRw0ofBEzz9J/pILS84hvHyD65gyizPGUU74nt534DFFURg+rLfnagann+8rs8gKH
 5H5SGWg2Q9T4E92OlQPSPKsUUi4t5L19/9GlTfnMR/71TfpHnUag05recrL7FsiKZm/cko
 AkAtYDteb4NniHLg7M5o4CYWfx7ih+o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-VkLSma64MQ6d-AQb__D_fA-1; Mon, 02 Mar 2026 03:48:47 -0500
X-MC-Unique: VkLSma64MQ6d-AQb__D_fA-1
X-Mimecast-MFC-AGG-ID: VkLSma64MQ6d-AQb__D_fA_1772441326
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48379489438so39519575e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441326; x=1773046126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szx0I80Lf0BuHe9FbaGyt5toyYxnG/9fgTe5KnAGYFc=;
 b=exs518QRdMSqABx1ezYJsFhcFE6nZ4/Lm30Tm2Ux+lcwYI35jQpqm3Rpb29EJF3cdT
 BhFElCWnq8RuZu2ELaaYZXTVmFi2ku0JGUVv6KT4r9e8fEluBcT1ShU/5eHdLMqUJQAV
 /82sfnUzkc1/f4ypnpL2uiXFqnyZOi8TN+Ei+k8v0lKMvisQEZq9FvBSI7pjMgyhbax/
 KWnZ4Ailc8+taU+IB0qQWeYq2J1hK7Qb8+V4mY+y+6J5+CZOqf8pRJ1CqC76DwF/+d7/
 KSuZwTDdjab03LYlg2EMtnGIY/AvJQeHTHZAT9ec7gqVXBH9RkDW+CQn5BJIRpG4A+Ey
 bLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441326; x=1773046126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=szx0I80Lf0BuHe9FbaGyt5toyYxnG/9fgTe5KnAGYFc=;
 b=trQ2/s2YaiRbtwFTg5zfJswOGJ7HYJMOoxU5z4hKJ6iu45RsiEJK12jGLJzlCMQYgA
 DuLqCl/NeWSBV7HEVCmG9EfVo3SXDqlcvjCE16lY+xrVpdT53ipCJB25eczAj1mIsc5L
 FYbtNydEhg3/Ml5ZNvAn+41hou/w14Jv2IiMms8t40jKcyC4rN2n9U60vrxWZdoYiFzE
 y3jGW7TLsjPlrhL0fQiZnbuCplCnO72gAfboc8gIaywUODP2CI4MvG+CSYCfjFFErgvq
 DKX2MHGRgcuyNjpkZwvGSV+bMxya3Zz+Ry+T7tXUdg4ARcLAUUTYopen4Ea0Yk1M/RoV
 ghJg==
X-Gm-Message-State: AOJu0YyPji5Ks+hC6FcbY+VWxigoxG8o+ywsMSg6dLT+1dDUelliWLdA
 a9GDaTpxjSJ7Gm3rfyjHonsKjtScCSqxM7XdDtGNwfI/hUoVmx3L10X1hcGKVyVu1fCIO16Hhdn
 4jgw0xz+hvLEPZtxflV9wkzB9QR+PlXbXG8u8KANCRHmo3E6JaTQ6pU3VQUbg43t9Dm/EAfPlJJ
 kllHblrNMHYbN7IiFqOl2SmMohwbdTydfjD2/x8cDG
X-Gm-Gg: ATEYQzwwd+MWmgg1EpGa1r4qjEE9gvSX1FYjW1IOz6tl2BjMVJs5zlsxiOoFR2AGaKH
 689XgDkQgC2x9/WO9xUkRmxSi4fnQMEu/UVnu5w2w2fOh4wQlYjF0udV1glf/I4nlrd1d3HmOQX
 tSKf/QFKhWP26DL7WrTaS5ZEtUPj2tvltz6XiI3XmvEKIsZcCu0adFtQfW+altIXcFur4HrrM3y
 X133W8xGsoF7M6S0Fp+29olXdFITxZ3R0GjyHlDEI/wosjFUv9jg6IcKPAEXIgB6fdppZox10s1
 zBT+AR55VohJ8MA1NlQU7Zinwwnbe4HaEgfdF16lSRCP3l8C/XhUpDJA4Yx8wBjRaDZyB+b569C
 /AEO7Fj74hY2mE8FgwbWnJcMT8BbL1c06G9ndfBilhDUmFbNUwDXUVxf6W7po3B0qcnowJA3Ius
 wyZNFnmDALiix9Mgo9yxlH4itWq9g=
X-Received: by 2002:a05:600c:a47:b0:483:4807:210c with SMTP id
 5b1f17b1804b1-483c9bfa181mr202180495e9.24.1772441325821; 
 Mon, 02 Mar 2026 00:48:45 -0800 (PST)
X-Received: by 2002:a05:600c:a47:b0:483:4807:210c with SMTP id
 5b1f17b1804b1-483c9bfa181mr202179925e9.24.1772441325247; 
 Mon, 02 Mar 2026 00:48:45 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb77466sm165991045e9.5.2026.03.02.00.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 088/102] Reapply "rcu: Unify force quiescent state"
Date: Mon,  2 Mar 2026 09:47:34 +0100
Message-ID: <20260302084749.474955-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

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
Link: https://lore.kernel.org/r/20260217-alpha-v1-2-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/rcu.c | 81 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 29 deletions(-)

diff --git a/util/rcu.c b/util/rcu.c
index b703c86f15a..acac9446ea9 100644
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
-#if defined(CONFIG_MALLOC_TRIM)
-                    malloc_trim(4 * 1024 * 1024);
-#endif
-                    qemu_event_wait(&rcu_call_ready_event);
-                }
-            }
+        for (;;) {
+            qemu_event_reset(&rcu_call_ready_event);
             n = qatomic_read(&rcu_call_count);
+            if (n) {
+                break;
+            }
+
+#if defined(CONFIG_MALLOC_TRIM)
+            malloc_trim(4 * 1024 * 1024);
+#endif
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


