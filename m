Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED3BC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx8R-0003L4-3K; Sun, 03 Mar 2024 20:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7e-00027b-NN
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7a-0002PF-7S
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptd8Yo7Ufse7uyww/jr7ItOQkXfk12UqfbcC3vvU2yI=;
 b=iiF4sDFfx7yvdPxYdUjU4kDeU7BfLfFnOriP+bdiiM4LiI4vZqxD4SnOfcNoIwGCeZT5Q2
 leYCIWhzh35Kd9CvJrJAl/sDKQLYjFZ5IF8lGAmpxirnJhkUjI0g9orCXJH2D/20S5SRAP
 CisDpEX/es+PSpjmwIEVOYVB+Zx6+pw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-Jv2rxVyUMFyRcRWLBlvjXQ-1; Sun, 03 Mar 2024 20:27:56 -0500
X-MC-Unique: Jv2rxVyUMFyRcRWLBlvjXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2E0785A589;
 Mon,  4 Mar 2024 01:27:55 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78A8F40C6EBA;
 Mon,  4 Mar 2024 01:27:52 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 17/27] migration/multifd: Allow multifd without packets
Date: Mon,  4 Mar 2024 09:26:24 +0800
Message-ID: <20240304012634.95520-18-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For the upcoming support to the new 'mapped-ram' migration stream
format, we cannot use multifd packets because each write into the
ramblock section in the migration file is expected to contain only the
guest pages. They are written at their respective offsets relative to
the ramblock section header.

There is no space for the packet information and the expected gains
from the new approach come partly from being able to write the pages
sequentially without extraneous data in between.

The new format also simply doesn't need the packets and all necessary
information can be taken from the standard migration headers with some
(future) changes to multifd code.

Use the presence of the mapped-ram capability to decide whether to
send packets.

This only moves code under multifd_use_packets(), it has no effect for
now as mapped-ram cannot yet be enabled with multifd.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-15-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 175 +++++++++++++++++++++++++++++---------------
 1 file changed, 114 insertions(+), 61 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 3a8520097b..8c43424c81 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -92,6 +92,11 @@ struct {
     MultiFDMethods *ops;
 } *multifd_recv_state;
 
+static bool multifd_use_packets(void)
+{
+    return !migrate_mapped_ram();
+}
+
 /* Multifd without compression */
 
 /**
@@ -122,6 +127,19 @@ static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
     return;
 }
 
+static void multifd_send_prepare_iovs(MultiFDSendParams *p)
+{
+    MultiFDPages_t *pages = p->pages;
+
+    for (int i = 0; i < pages->num; i++) {
+        p->iov[p->iovs_num].iov_base = pages->block->host + pages->offset[i];
+        p->iov[p->iovs_num].iov_len = p->page_size;
+        p->iovs_num++;
+    }
+
+    p->next_packet_size = pages->num * p->page_size;
+}
+
 /**
  * nocomp_send_prepare: prepare date to be able to send
  *
@@ -136,9 +154,13 @@ static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
 static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
 {
     bool use_zero_copy_send = migrate_zero_copy_send();
-    MultiFDPages_t *pages = p->pages;
     int ret;
 
+    if (!multifd_use_packets()) {
+        multifd_send_prepare_iovs(p);
+        return 0;
+    }
+
     if (!use_zero_copy_send) {
         /*
          * Only !zerocopy needs the header in IOV; zerocopy will
@@ -147,13 +169,7 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
         multifd_send_prepare_header(p);
     }
 
-    for (int i = 0; i < pages->num; i++) {
-        p->iov[p->iovs_num].iov_base = pages->block->host + pages->offset[i];
-        p->iov[p->iovs_num].iov_len = p->page_size;
-        p->iovs_num++;
-    }
-
-    p->next_packet_size = pages->num * p->page_size;
+    multifd_send_prepare_iovs(p);
     p->flags |= MULTIFD_FLAG_NOCOMP;
 
     multifd_send_fill_packet(p);
@@ -208,7 +224,13 @@ static void nocomp_recv_cleanup(MultiFDRecvParams *p)
  */
 static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
 {
-    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+    uint32_t flags;
+
+    if (!multifd_use_packets()) {
+        return 0;
+    }
+
+    flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
 
     if (flags != MULTIFD_FLAG_NOCOMP) {
         error_setg(errp, "multifd %u: flags received %x flags expected %x",
@@ -795,15 +817,18 @@ static void *multifd_send_thread(void *opaque)
     MigrationThread *thread = NULL;
     Error *local_err = NULL;
     int ret = 0;
+    bool use_packets = multifd_use_packets();
 
     thread = migration_threads_add(p->name, qemu_get_thread_id());
 
     trace_multifd_send_thread_start(p->id);
     rcu_register_thread();
 
-    if (multifd_send_initial_packet(p, &local_err) < 0) {
-        ret = -1;
-        goto out;
+    if (use_packets) {
+        if (multifd_send_initial_packet(p, &local_err) < 0) {
+            ret = -1;
+            goto out;
+        }
     }
 
     while (true) {
@@ -854,16 +879,20 @@ static void *multifd_send_thread(void *opaque)
              * it doesn't require explicit memory barriers.
              */
             assert(qatomic_read(&p->pending_sync));
-            p->flags = MULTIFD_FLAG_SYNC;
-            multifd_send_fill_packet(p);
-            ret = qio_channel_write_all(p->c, (void *)p->packet,
-                                        p->packet_len, &local_err);
-            if (ret != 0) {
-                break;
+
+            if (use_packets) {
+                p->flags = MULTIFD_FLAG_SYNC;
+                multifd_send_fill_packet(p);
+                ret = qio_channel_write_all(p->c, (void *)p->packet,
+                                            p->packet_len, &local_err);
+                if (ret != 0) {
+                    break;
+                }
+                /* p->next_packet_size will always be zero for a SYNC packet */
+                stat64_add(&mig_stats.multifd_bytes, p->packet_len);
+                p->flags = 0;
             }
-            /* p->next_packet_size will always be zero for a SYNC packet */
-            stat64_add(&mig_stats.multifd_bytes, p->packet_len);
-            p->flags = 0;
+
             qatomic_set(&p->pending_sync, false);
             qemu_sem_post(&p->sem_sync);
         }
@@ -1018,6 +1047,7 @@ bool multifd_send_setup(void)
     Error *local_err = NULL;
     int thread_count, ret = 0;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    bool use_packets = multifd_use_packets();
     uint8_t i;
 
     if (!migrate_multifd()) {
@@ -1040,14 +1070,20 @@ bool multifd_send_setup(void)
         qemu_sem_init(&p->sem_sync, 0);
         p->id = i;
         p->pages = multifd_pages_init(page_count);
-        p->packet_len = sizeof(MultiFDPacket_t)
-                      + sizeof(uint64_t) * page_count;
-        p->packet = g_malloc0(p->packet_len);
-        p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
-        p->packet->version = cpu_to_be32(MULTIFD_VERSION);
+
+        if (use_packets) {
+            p->packet_len = sizeof(MultiFDPacket_t)
+                          + sizeof(uint64_t) * page_count;
+            p->packet = g_malloc0(p->packet_len);
+            p->packet->magic = cpu_to_be32(MULTIFD_MAGIC);
+            p->packet->version = cpu_to_be32(MULTIFD_VERSION);
+
+            /* We need one extra place for the packet header */
+            p->iov = g_new0(struct iovec, page_count + 1);
+        } else {
+            p->iov = g_new0(struct iovec, page_count);
+        }
         p->name = g_strdup_printf("multifdsend_%d", i);
-        /* We need one extra place for the packet header */
-        p->iov = g_new0(struct iovec, page_count + 1);
         p->page_size = qemu_target_page_size();
         p->page_count = page_count;
         p->write_flags = 0;
@@ -1110,7 +1146,9 @@ static void multifd_recv_terminate_threads(Error *err)
          * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
          * however try to wakeup it without harm in cleanup phase.
          */
-        qemu_sem_post(&p->sem_sync);
+        if (multifd_use_packets()) {
+            qemu_sem_post(&p->sem_sync);
+        }
 
         /*
          * We could arrive here for two reasons:
@@ -1185,7 +1223,7 @@ void multifd_recv_sync_main(void)
     int thread_count = migrate_multifd_channels();
     int i;
 
-    if (!migrate_multifd()) {
+    if (!migrate_multifd() || !multifd_use_packets()) {
         return;
     }
 
@@ -1220,13 +1258,14 @@ static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p = opaque;
     Error *local_err = NULL;
+    bool use_packets = multifd_use_packets();
     int ret;
 
     trace_multifd_recv_thread_start(p->id);
     rcu_register_thread();
 
     while (true) {
-        uint32_t flags;
+        uint32_t flags = 0;
         bool has_data = false;
         p->normal_num = 0;
 
@@ -1234,25 +1273,27 @@ static void *multifd_recv_thread(void *opaque)
             break;
         }
 
-        ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
-                                       p->packet_len, &local_err);
-        if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
-            break;
-        }
+        if (use_packets) {
+            ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
+                                           p->packet_len, &local_err);
+            if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
+                break;
+            }
 
-        qemu_mutex_lock(&p->mutex);
-        ret = multifd_recv_unfill_packet(p, &local_err);
-        if (ret) {
+            qemu_mutex_lock(&p->mutex);
+            ret = multifd_recv_unfill_packet(p, &local_err);
+            if (ret) {
+                qemu_mutex_unlock(&p->mutex);
+                break;
+            }
+
+            flags = p->flags;
+            /* recv methods don't know how to handle the SYNC flag */
+            p->flags &= ~MULTIFD_FLAG_SYNC;
+            has_data = !!p->normal_num;
             qemu_mutex_unlock(&p->mutex);
-            break;
         }
 
-        flags = p->flags;
-        /* recv methods don't know how to handle the SYNC flag */
-        p->flags &= ~MULTIFD_FLAG_SYNC;
-        has_data = !!p->normal_num;
-        qemu_mutex_unlock(&p->mutex);
-
         if (has_data) {
             ret = multifd_recv_state->ops->recv(p, &local_err);
             if (ret != 0) {
@@ -1260,9 +1301,11 @@ static void *multifd_recv_thread(void *opaque)
             }
         }
 
-        if (flags & MULTIFD_FLAG_SYNC) {
-            qemu_sem_post(&multifd_recv_state->sem_sync);
-            qemu_sem_wait(&p->sem_sync);
+        if (use_packets) {
+            if (flags & MULTIFD_FLAG_SYNC) {
+                qemu_sem_post(&multifd_recv_state->sem_sync);
+                qemu_sem_wait(&p->sem_sync);
+            }
         }
     }
 
@@ -1281,6 +1324,7 @@ int multifd_recv_setup(Error **errp)
 {
     int thread_count;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    bool use_packets = multifd_use_packets();
     uint8_t i;
 
     /*
@@ -1305,9 +1349,12 @@ int multifd_recv_setup(Error **errp)
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem_sync, 0);
         p->id = i;
-        p->packet_len = sizeof(MultiFDPacket_t)
-                      + sizeof(uint64_t) * page_count;
-        p->packet = g_malloc0(p->packet_len);
+
+        if (use_packets) {
+            p->packet_len = sizeof(MultiFDPacket_t)
+                + sizeof(uint64_t) * page_count;
+            p->packet = g_malloc0(p->packet_len);
+        }
         p->name = g_strdup_printf("multifdrecv_%d", i);
         p->iov = g_new0(struct iovec, page_count);
         p->normal = g_new0(ram_addr_t, page_count);
@@ -1351,18 +1398,24 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
 {
     MultiFDRecvParams *p;
     Error *local_err = NULL;
+    bool use_packets = multifd_use_packets();
     int id;
 
-    id = multifd_recv_initial_packet(ioc, &local_err);
-    if (id < 0) {
-        multifd_recv_terminate_threads(local_err);
-        error_propagate_prepend(errp, local_err,
-                                "failed to receive packet"
-                                " via multifd channel %d: ",
-                                qatomic_read(&multifd_recv_state->count));
-        return;
+    if (use_packets) {
+        id = multifd_recv_initial_packet(ioc, &local_err);
+        if (id < 0) {
+            multifd_recv_terminate_threads(local_err);
+            error_propagate_prepend(errp, local_err,
+                                    "failed to receive packet"
+                                    " via multifd channel %d: ",
+                                    qatomic_read(&multifd_recv_state->count));
+            return;
+        }
+        trace_multifd_recv_new_channel(id);
+    } else {
+        /* next patch gives this a meaningful value */
+        id = 0;
     }
-    trace_multifd_recv_new_channel(id);
 
     p = &multifd_recv_state->params[id];
     if (p->c != NULL) {
-- 
2.44.0


