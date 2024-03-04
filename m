Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8A4C54E55
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx8I-0002qz-FX; Sun, 03 Mar 2024 20:28:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7j-0002Hf-2E
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7b-0002PL-3r
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2uzSIhngj0U0fXMJpOg/NU1hFvNfpZfLtLHmfXne1e4=;
 b=ZscrWQ9E2de6a7qgvjk7P58fckaHaYfaP/yUg4cyLNqZmeZbcO4WzMbPKrI1i53+YLp86M
 nDuFQaIUplPKLAPNhT5kBoLlmz5RTIH8TyKGrHoPmOhRjjmQJEJ/EmyJfydO+hd6MeyIKr
 erOFKz8PX+n6dfqC8I9oI8uyttwlQcU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563--nbgPpXpPvKowm1IKyAQPQ-1; Sun, 03 Mar 2024 20:28:00 -0500
X-MC-Unique: -nbgPpXpPvKowm1IKyAQPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EB6D87A9F5;
 Mon,  4 Mar 2024 01:28:00 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C261440C6EBA;
 Mon,  4 Mar 2024 01:27:56 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 18/27] migration/multifd: Allow receiving pages without packets
Date: Mon,  4 Mar 2024 09:26:25 +0800
Message-ID: <20240304012634.95520-19-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
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

Currently multifd does not need to have knowledge of pages on the
receiving side because all the information needed is within the
packets that come in the stream.

We're about to add support to mapped-ram migration, which cannot use
packets because it expects the ramblock section in the migration file
to contain only the guest pages data.

Add a data structure to transfer pages between the ram migration code
and the multifd receiving threads.

We don't want to reuse MultiFDPages_t for two reasons:

a) multifd threads don't really need to know about the data they're
   receiving.

b) the receiving side has to be stopped to load the pages, which means
   we can experiment with larger granularities than page size when
   transferring data.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-16-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h |  15 ++++++
 migration/file.c    |   1 +
 migration/multifd.c | 129 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 138 insertions(+), 7 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 6a54377cc1..1be985978e 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -13,6 +13,8 @@
 #ifndef QEMU_MIGRATION_MULTIFD_H
 #define QEMU_MIGRATION_MULTIFD_H
 
+typedef struct MultiFDRecvData MultiFDRecvData;
+
 bool multifd_send_setup(void);
 void multifd_send_shutdown(void);
 int multifd_recv_setup(Error **errp);
@@ -23,6 +25,8 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
 void multifd_recv_sync_main(void);
 int multifd_send_sync_main(void);
 bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
+bool multifd_recv(void);
+MultiFDRecvData *multifd_get_recv_data(void);
 
 /* Multifd Compression flags */
 #define MULTIFD_FLAG_SYNC (1 << 0)
@@ -63,6 +67,13 @@ typedef struct {
     RAMBlock *block;
 } MultiFDPages_t;
 
+struct MultiFDRecvData {
+    void *opaque;
+    size_t size;
+    /* for preadv */
+    off_t file_offset;
+};
+
 typedef struct {
     /* Fields are only written at creating/deletion time */
     /* No lock required for them, they are read only */
@@ -152,6 +163,8 @@ typedef struct {
 
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
+    /* sem where to wait for more work */
+    QemuSemaphore sem;
 
     /* this mutex protects the following parameters */
     QemuMutex mutex;
@@ -161,6 +174,8 @@ typedef struct {
     uint32_t flags;
     /* global number of generated multifd packets */
     uint64_t packet_num;
+    int pending_job;
+    MultiFDRecvData *data;
 
     /* thread local variables. No locking required */
 
diff --git a/migration/file.c b/migration/file.c
index 5d4975f43e..22d052a71f 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/ramblock.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "channel.h"
diff --git a/migration/multifd.c b/migration/multifd.c
index 8c43424c81..d470af73ba 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -81,9 +81,13 @@ struct {
 
 struct {
     MultiFDRecvParams *params;
+    MultiFDRecvData *data;
     /* number of created threads */
     int count;
-    /* syncs main thread and channels */
+    /*
+     * This is always posted by the recv threads, the migration thread
+     * uses it to wait for recv threads to finish assigned tasks.
+     */
     QemuSemaphore sem_sync;
     /* global number of generated multifd packets */
     uint64_t packet_num;
@@ -1119,6 +1123,57 @@ bool multifd_send_setup(void)
     return true;
 }
 
+bool multifd_recv(void)
+{
+    int i;
+    static int next_recv_channel;
+    MultiFDRecvParams *p = NULL;
+    MultiFDRecvData *data = multifd_recv_state->data;
+
+    /*
+     * next_channel can remain from a previous migration that was
+     * using more channels, so ensure it doesn't overflow if the
+     * limit is lower now.
+     */
+    next_recv_channel %= migrate_multifd_channels();
+    for (i = next_recv_channel;; i = (i + 1) % migrate_multifd_channels()) {
+        if (multifd_recv_should_exit()) {
+            return false;
+        }
+
+        p = &multifd_recv_state->params[i];
+
+        if (qatomic_read(&p->pending_job) == false) {
+            next_recv_channel = (i + 1) % migrate_multifd_channels();
+            break;
+        }
+    }
+
+    /*
+     * Order pending_job read before manipulating p->data below. Pairs
+     * with qatomic_store_release() at multifd_recv_thread().
+     */
+    smp_mb_acquire();
+
+    assert(!p->data->size);
+    multifd_recv_state->data = p->data;
+    p->data = data;
+
+    /*
+     * Order p->data update before setting pending_job. Pairs with
+     * qatomic_load_acquire() at multifd_recv_thread().
+     */
+    qatomic_store_release(&p->pending_job, true);
+    qemu_sem_post(&p->sem);
+
+    return true;
+}
+
+MultiFDRecvData *multifd_get_recv_data(void)
+{
+    return multifd_recv_state->data;
+}
+
 static void multifd_recv_terminate_threads(Error *err)
 {
     int i;
@@ -1143,11 +1198,26 @@ static void multifd_recv_terminate_threads(Error *err)
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
         /*
-         * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
-         * however try to wakeup it without harm in cleanup phase.
+         * The migration thread and channels interact differently
+         * depending on the presence of packets.
          */
         if (multifd_use_packets()) {
+            /*
+             * The channel receives as long as there are packets. When
+             * packets end (i.e. MULTIFD_FLAG_SYNC is reached), the
+             * channel waits for the migration thread to sync. If the
+             * sync never happens, do it here.
+             */
             qemu_sem_post(&p->sem_sync);
+        } else {
+            /*
+             * The channel waits for the migration thread to give it
+             * work. When the migration thread runs out of work, it
+             * releases the channel and waits for any pending work to
+             * finish. If we reach here (e.g. due to error) before the
+             * work runs out, release the channel.
+             */
+            qemu_sem_post(&p->sem);
         }
 
         /*
@@ -1176,6 +1246,7 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
     p->c = NULL;
     qemu_mutex_destroy(&p->mutex);
     qemu_sem_destroy(&p->sem_sync);
+    qemu_sem_destroy(&p->sem);
     g_free(p->name);
     p->name = NULL;
     p->packet_len = 0;
@@ -1193,6 +1264,8 @@ static void multifd_recv_cleanup_state(void)
     qemu_sem_destroy(&multifd_recv_state->sem_sync);
     g_free(multifd_recv_state->params);
     multifd_recv_state->params = NULL;
+    g_free(multifd_recv_state->data);
+    multifd_recv_state->data = NULL;
     g_free(multifd_recv_state);
     multifd_recv_state = NULL;
 }
@@ -1269,11 +1342,11 @@ static void *multifd_recv_thread(void *opaque)
         bool has_data = false;
         p->normal_num = 0;
 
-        if (multifd_recv_should_exit()) {
-            break;
-        }
-
         if (use_packets) {
+            if (multifd_recv_should_exit()) {
+                break;
+            }
+
             ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
                                            p->packet_len, &local_err);
             if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
@@ -1292,6 +1365,30 @@ static void *multifd_recv_thread(void *opaque)
             p->flags &= ~MULTIFD_FLAG_SYNC;
             has_data = !!p->normal_num;
             qemu_mutex_unlock(&p->mutex);
+        } else {
+            /*
+             * No packets, so we need to wait for the vmstate code to
+             * give us work.
+             */
+            qemu_sem_wait(&p->sem);
+
+            if (multifd_recv_should_exit()) {
+                break;
+            }
+
+            /* pairs with qatomic_store_release() at multifd_recv() */
+            if (!qatomic_load_acquire(&p->pending_job)) {
+                /*
+                 * Migration thread did not send work, this is
+                 * equivalent to pending_sync on the sending
+                 * side. Post sem_sync to notify we reached this
+                 * point.
+                 */
+                qemu_sem_post(&multifd_recv_state->sem_sync);
+                continue;
+            }
+
+            has_data = !!p->data->size;
         }
 
         if (has_data) {
@@ -1306,6 +1403,15 @@ static void *multifd_recv_thread(void *opaque)
                 qemu_sem_post(&multifd_recv_state->sem_sync);
                 qemu_sem_wait(&p->sem_sync);
             }
+        } else {
+            p->total_normal_pages += p->data->size / qemu_target_page_size();
+            p->data->size = 0;
+            /*
+             * Order data->size update before clearing
+             * pending_job. Pairs with smp_mb_acquire() at
+             * multifd_recv().
+             */
+            qatomic_store_release(&p->pending_job, false);
         }
     }
 
@@ -1338,6 +1444,10 @@ int multifd_recv_setup(Error **errp)
     thread_count = migrate_multifd_channels();
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
+
+    multifd_recv_state->data = g_new0(MultiFDRecvData, 1);
+    multifd_recv_state->data->size = 0;
+
     qatomic_set(&multifd_recv_state->count, 0);
     qatomic_set(&multifd_recv_state->exiting, 0);
     qemu_sem_init(&multifd_recv_state->sem_sync, 0);
@@ -1348,8 +1458,13 @@ int multifd_recv_setup(Error **errp)
 
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem_sync, 0);
+        qemu_sem_init(&p->sem, 0);
+        p->pending_job = false;
         p->id = i;
 
+        p->data = g_new0(MultiFDRecvData, 1);
+        p->data->size = 0;
+
         if (use_packets) {
             p->packet_len = sizeof(MultiFDPacket_t)
                 + sizeof(uint64_t) * page_count;
-- 
2.44.0


