Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D436CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnau-0005vx-1o; Tue, 28 Oct 2025 13:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnas-0005vJ-CU
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnap-0004Pu-Bp
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7osdAW5bSf9qjwAd56pP8o2B29iR255+zUoc4/NUqo=;
 b=cDpd9MLd7Z22bF9iH9N5YoSb+X9lbZdws24l2sp8IMyPLiJgI4IfP6yjmG0gauzv2JM80I
 wjwOcMIaS5A5pSqCQN8uVPL+z2fTGjZMvWQToaLunqU9jvU3ghdss0Z/LxSudmgNePCJCt
 Dzm3oz894dkxuTGvJ9EbV4S+Ao+aiCE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-oeMyffwgMouU5wrcZdUbTw-1; Tue, 28 Oct 2025 13:34:43 -0400
X-MC-Unique: oeMyffwgMouU5wrcZdUbTw-1
X-Mimecast-MFC-AGG-ID: oeMyffwgMouU5wrcZdUbTw_1761672883
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-475c422fd70so50643925e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672882; x=1762277682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/7osdAW5bSf9qjwAd56pP8o2B29iR255+zUoc4/NUqo=;
 b=YYXj8KauXTsJuAfG29xLaTFhEK7m/eLCRAILvaBrb6f3zGkM+2KJ6OZofSkVlSunhR
 oIyFbs2pcBM8W2XNK2zu30rVa1FsXN3WCnyRPKc2xwYfSxWJyGZnDubOQim+QxI/WjsB
 3at0nV81/BycHns8TY+EYr/MMzWr9nrywEJyIsITwSL73mwWz6SPq2rC3FnMF2/0n8zN
 uzB7P9IkVr906fEGri36soEHyMI321+Td84T4yE9CWs9f42/k5KVEL6r4gLmhTG3l52X
 uAkJl/ftBI+r2zDC4/UGdXFP3ywD9XhvLlAqNqhGjiLGHfLel/gbSTw+UftaSGljLtAY
 g1Jw==
X-Gm-Message-State: AOJu0YzYSO2azGqvYX9FM8922OQTO/mrQT4ERVND7VBk1GBnmXn4zJOe
 tcxxgaHAm/5O/AZ7r/czCYcaVGgkNMv+6nbgZigde7MQhMPLa0MsrA4FS+omwAalRnzxi+ZNpMR
 3nJGq8EQP/L3KBxSLUCBgITsvsfQjyEBm0DjRKHSYUngp5IG0HEFEuf7gbzdhSA8Sqgs1a2+DAD
 uabHAyDkjSDcvLqQHrNRvmN4LuT9PxUMTj2PF0rJJb
X-Gm-Gg: ASbGncvkZlJRWEadPxzWTZd5dVfoUQLyrx07Km1dSWGUb+urgkYRfP0MCe1htUiTIBy
 7u+p4w5zR1bG8LOf3WmukoJ0hR04hzVxWMVYxR/qV4GGUkvNGSgE5mpb/5enIxuLZASUrHOpO2A
 5QCmpUecaONxTH4Jc0nBhYT9Ldi7ZHGiTQ2zmkrXcBA1mU5g7AxZFr02EAXPQI+M8sel4bepFXA
 hnTWdN3e4Us2iQHFwOnrCu9vGcCIn7o/qtWGOkFfW4V64Ow8RMR7LyK84RqNcF0PpSSFp9YlZzI
 hn5n3VwpbladmD+/ID5ktbUfVjVJ2JmSTMrQ0ayllIxxz82Ctwm1FgWZHP8LrbTr02dXEMMnCXB
 uE1fZixhdT4LpTbiLJRr6LST+ztYvvMHaU9wk63Q7fCCHSZ2zIynor+4CexVCDh2VanNg5JkD4b
 r/mFY=
X-Received: by 2002:a05:600c:8b8b:b0:471:1717:40f with SMTP id
 5b1f17b1804b1-4771e1ca084mr2207565e9.22.1761672882014; 
 Tue, 28 Oct 2025 10:34:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD8diAi5KAatEerGVhRBxHrqUc0knotgUiMBAJlIi0rSqnnoX86wT4L4Hj12X/uA1YfK/gWg==
X-Received: by 2002:a05:600c:8b8b:b0:471:1717:40f with SMTP id
 5b1f17b1804b1-4771e1ca084mr2207315e9.22.1761672881428; 
 Tue, 28 Oct 2025 10:34:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e196a9asm3885085e9.7.2025.10.28.10.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:34:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PULL 03/18] rcu: Unify force quiescent state
Date: Tue, 28 Oct 2025 18:34:15 +0100
Message-ID: <20251028173430.2180057-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

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
Link: https://lore.kernel.org/r/20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
2.51.1


