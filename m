Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA85C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 15:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfLl5-0006eD-Pe; Wed, 28 Feb 2024 10:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLl4-0006dA-6x
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:22:10 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLkz-0005Bh-E7
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:22:09 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 243981F79A;
 Wed, 28 Feb 2024 15:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2su3CKh6QieskfrMHLvcCoIW+mnptu0PCnlMMx6ZpY=;
 b=r4z0MQv16t89h3pLlFehhPbxK1OMgtjSyHWgMN7KpVtUYrMSW2t3m+lxKxmotw+T12/Y/G
 hYVTyJz8CMmW9z/x/bFvGIFRELMCvRfwJDUvZO8CY7sFmoXCjvVWg7P3pavKo2O2dj6NDY
 krFxgLfGY4ZuKh0jMJ/8HLxjD164n6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133724;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2su3CKh6QieskfrMHLvcCoIW+mnptu0PCnlMMx6ZpY=;
 b=aBrHHnNVefX3zHw9fyPURi6prYIOQrkyc31k1/lG0LdqmG3OmLMer6DmZOfaGE/olmqkcz
 zx7cYc3QmScJCoBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2su3CKh6QieskfrMHLvcCoIW+mnptu0PCnlMMx6ZpY=;
 b=r4z0MQv16t89h3pLlFehhPbxK1OMgtjSyHWgMN7KpVtUYrMSW2t3m+lxKxmotw+T12/Y/G
 hYVTyJz8CMmW9z/x/bFvGIFRELMCvRfwJDUvZO8CY7sFmoXCjvVWg7P3pavKo2O2dj6NDY
 krFxgLfGY4ZuKh0jMJ/8HLxjD164n6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133724;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2su3CKh6QieskfrMHLvcCoIW+mnptu0PCnlMMx6ZpY=;
 b=aBrHHnNVefX3zHw9fyPURi6prYIOQrkyc31k1/lG0LdqmG3OmLMer6DmZOfaGE/olmqkcz
 zx7cYc3QmScJCoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8463E13A5D;
 Wed, 28 Feb 2024 15:22:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eJmGEppP32UPAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Feb 2024 15:22:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v5 14/23] migration/multifd: Allow multifd without packets
Date: Wed, 28 Feb 2024 12:21:18 -0300
Message-Id: <20240228152127.18769-15-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240228152127.18769-1-farosas@suse.de>
References: <20240228152127.18769-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r4z0MQv1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aBrHHnNV
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 243981F79A
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- added multifd_send_prepare_iovs
- posted channels_created at file.c as well
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
2.35.3


