Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C680C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXulZ-0002L3-Fp; Wed, 07 Feb 2024 22:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXuki-00076S-Sp
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukh-0004Rn-4C
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCTnp5IEaIuBcbRgM9kMkTTMtCWI6S6885VUUuJ6pl4=;
 b=TqSQgRZ6RyOsA+xCSaWoxh2I8pvGDpFMe0SIdvoqDZCod3Igv7AXHu0ZDZlibsBSqhQSc4
 xus4D1CAFydMEB08a0S0NfaRrhBpKvQZkK0bIDBdNGdeHPooGOH6/1VGROBcDRMneZ5Pl1
 nXL79SH9x20YuSgH7/dginOrSD0Au/Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-PCI2s-kKPDm-iJxn6_Vj1w-1; Wed, 07 Feb 2024 22:07:00 -0500
X-MC-Unique: PCI2s-kKPDm-iJxn6_Vj1w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA661870821;
 Thu,  8 Feb 2024 03:06:59 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EDBF492BC7;
 Thu,  8 Feb 2024 03:06:55 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 qemu-stable <qemu-stable@nongnu.org>, Avihai Horon <avihaih@nvidia.com>,
 chenyuhui5@huawei.com
Subject: [PULL 27/34] migration/multifd: Remove p->running
Date: Thu,  8 Feb 2024 11:05:21 +0800
Message-ID: <20240208030528.368214-28-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

We currently only need p->running to avoid calling qemu_thread_join()
on a non existent thread if the thread has never been created.

However, there are at least two bugs in this logic:

1) On the sending side, p->running is set too early and
qemu_thread_create() can be skipped due to an error during TLS
handshake, leaving the flag set and leading to a crash when
multifd_send_cleanup() calls qemu_thread_join().

2) During exit, the multifd thread clears the flag while holding the
channel lock. The counterpart at multifd_send_cleanup() reads the flag
outside of the lock and might free the mutex while the multifd thread
still has it locked.

Fix the first issue by setting the flag right before creating the
thread. Rename it from p->running to p->thread_created to clarify its
usage.

Fix the second issue by not clearing the flag at the multifd thread
exit. We don't have any use for that.

Note that these bugs are straight-forward logic issues and not race
conditions. There is still a gap for races to affect this code due to
multifd_send_cleanup() being allowed to run concurrently with the
thread creation loop. This issue is solved in the next patches.

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: 29647140157a ("migration/tls: add support for multifd tls-handshake")
Reported-by: Avihai Horon <avihaih@nvidia.com>
Reported-by: chenyuhui5@huawei.com
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240206215118.6171-3-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h |  7 ++-----
 migration/multifd.c | 27 ++++++++++++---------------
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 720c9d50db..7881980ee6 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -73,6 +73,7 @@ typedef struct {
     char *name;
     /* channel thread id */
     QemuThread thread;
+    bool thread_created;
     QemuThread tls_thread;
     bool tls_thread_created;
     /* communication channel */
@@ -93,8 +94,6 @@ typedef struct {
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
 
-    /* is this channel thread running */
-    bool running;
     /* multifd flags for each packet */
     uint32_t flags;
     /*
@@ -143,6 +142,7 @@ typedef struct {
     char *name;
     /* channel thread id */
     QemuThread thread;
+    bool thread_created;
     /* communication channel */
     QIOChannel *c;
     /* packet allocated len */
@@ -157,8 +157,6 @@ typedef struct {
 
     /* this mutex protects the following parameters */
     QemuMutex mutex;
-    /* is this channel thread running */
-    bool running;
     /* should this thread finish */
     bool quit;
     /* multifd flags for each packet */
@@ -217,4 +215,3 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
 
 
 #endif
-
diff --git a/migration/multifd.c b/migration/multifd.c
index 5551711a2a..e6ac1ad6dc 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -634,7 +634,7 @@ static void multifd_send_terminate_threads(void)
             qemu_thread_join(&p->tls_thread);
         }
 
-        if (p->running) {
+        if (p->thread_created) {
             qemu_thread_join(&p->thread);
         }
     }
@@ -862,7 +862,6 @@ out:
         error_free(local_err);
     }
 
-    p->running = false;
     rcu_unregister_thread();
     migration_threads_remove(thread);
     trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_normal_pages);
@@ -953,6 +952,8 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
     migration_ioc_register_yank(ioc);
     p->registered_yank = true;
     p->c = ioc;
+
+    p->thread_created = true;
     qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
                        QEMU_THREAD_JOINABLE);
     return true;
@@ -967,7 +968,6 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
     trace_multifd_new_send_channel_async(p->id);
     if (!qio_task_propagate_error(task, &local_err)) {
         qio_channel_set_delay(ioc, false);
-        p->running = true;
         if (multifd_channel_connect(p, ioc, &local_err)) {
             return;
         }
@@ -1128,15 +1128,15 @@ void multifd_recv_cleanup(void)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
-        if (p->running) {
-            /*
-             * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
-             * however try to wakeup it without harm in cleanup phase.
-             */
-            qemu_sem_post(&p->sem_sync);
-        }
+        /*
+         * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
+         * however try to wakeup it without harm in cleanup phase.
+         */
+        qemu_sem_post(&p->sem_sync);
 
-        qemu_thread_join(&p->thread);
+        if (p->thread_created) {
+            qemu_thread_join(&p->thread);
+        }
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
         multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
@@ -1222,9 +1222,6 @@ static void *multifd_recv_thread(void *opaque)
         multifd_recv_terminate_threads(local_err);
         error_free(local_err);
     }
-    qemu_mutex_lock(&p->mutex);
-    p->running = false;
-    qemu_mutex_unlock(&p->mutex);
 
     rcu_unregister_thread();
     trace_multifd_recv_thread_end(p->id, p->packets_recved, p->total_normal_pages);
@@ -1330,7 +1327,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     p->c = ioc;
     object_ref(OBJECT(ioc));
 
-    p->running = true;
+    p->thread_created = true;
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
                        QEMU_THREAD_JOINABLE);
     qatomic_inc(&multifd_recv_state->count);
-- 
2.43.0


