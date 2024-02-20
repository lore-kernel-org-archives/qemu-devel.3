Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55BAC54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYoq-0003fF-Mz; Tue, 20 Feb 2024 17:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYom-0003YB-Iz
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:29 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYok-0006MD-9D
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:28 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B8DF22260;
 Tue, 20 Feb 2024 22:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=roA3OXpZofT2fbHnP+m3tl4hTXx3L+tbHCf+EzzaWDE=;
 b=wJEvdIbU2iY4lIivQhQHQMja2xX+cLghPmjqLUkdXXwtmvFJS75Iyrh86KAy+OF09Y0pML
 an5eiZ692AGdN7NSVf9b50GR0U5TRm96Zb4vaRH4pNmJTNjnGfxJvm4z9KYMOhhxCBlg63
 dpdLir6Abyf9RLDVpm153ReNUK4LroU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=roA3OXpZofT2fbHnP+m3tl4hTXx3L+tbHCf+EzzaWDE=;
 b=j0r4Cqd5E2b1d95eSjWsnUJ312xx7wocuxE2WFmvXzMxlGQqXGDrRXRHmrHlxJGuVUYWUr
 rDF6KWLU4B0himDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=roA3OXpZofT2fbHnP+m3tl4hTXx3L+tbHCf+EzzaWDE=;
 b=wJEvdIbU2iY4lIivQhQHQMja2xX+cLghPmjqLUkdXXwtmvFJS75Iyrh86KAy+OF09Y0pML
 an5eiZ692AGdN7NSVf9b50GR0U5TRm96Zb4vaRH4pNmJTNjnGfxJvm4z9KYMOhhxCBlg63
 dpdLir6Abyf9RLDVpm153ReNUK4LroU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=roA3OXpZofT2fbHnP+m3tl4hTXx3L+tbHCf+EzzaWDE=;
 b=j0r4Cqd5E2b1d95eSjWsnUJ312xx7wocuxE2WFmvXzMxlGQqXGDrRXRHmrHlxJGuVUYWUr
 rDF6KWLU4B0himDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8852139D0;
 Tue, 20 Feb 2024 22:42:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gDK/H84q1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 18/34] migration/multifd: Allow multifd without packets
Date: Tue, 20 Feb 2024 19:41:22 -0300
Message-Id: <20240220224138.24759-19-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wJEvdIbU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=j0r4Cqd5
X-Spamd-Result: default: False [1.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5];
 R_RATELIMIT(0.00)[to_ip_from(RLi3368pnyb3ujpcs6u1hud8b3)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5B8DF22260
X-Spamd-Bar: +
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

For the upcoming support to the new 'fixed-ram' migration stream
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

Use the presence of the fixed-ram capability to decide whether to send
packets.

This only moves code under multifd_use_packets(), it has no effect for
now as fixed-ram cannot yet be enabled with multifd.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 188 +++++++++++++++++++++++++++-----------------
 1 file changed, 117 insertions(+), 71 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 5a38cb222f..0a5279314d 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -92,6 +92,11 @@ struct {
     MultiFDMethods *ops;
 } *multifd_recv_state;
 
+static bool multifd_use_packets(void)
+{
+    return !migrate_fixed_ram();
+}
+
 /* Multifd without compression */
 
 /**
@@ -136,10 +141,11 @@ static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
 static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
 {
     bool use_zero_copy_send = migrate_zero_copy_send();
+    bool use_packets = multifd_use_packets();
     MultiFDPages_t *pages = p->pages;
     int ret;
 
-    if (!use_zero_copy_send) {
+    if (!use_zero_copy_send && use_packets) {
         /*
          * Only !zerocopy needs the header in IOV; zerocopy will
          * send it separately.
@@ -156,14 +162,16 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
     p->next_packet_size = pages->num * p->page_size;
     p->flags |= MULTIFD_FLAG_NOCOMP;
 
-    multifd_send_fill_packet(p);
+    if (use_packets) {
+        multifd_send_fill_packet(p);
 
-    if (use_zero_copy_send) {
-        /* Send header first, without zerocopy */
-        ret = qio_channel_write_all(p->c, (void *)p->packet,
-                                    p->packet_len, errp);
-        if (ret != 0) {
-            return -1;
+        if (use_zero_copy_send) {
+            /* Send header first, without zerocopy */
+            ret = qio_channel_write_all(p->c, (void *)p->packet,
+                                        p->packet_len, errp);
+            if (ret != 0) {
+                return -1;
+            }
         }
     }
 
@@ -215,11 +223,16 @@ static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
                    p->id, flags, MULTIFD_FLAG_NOCOMP);
         return -1;
     }
-    for (int i = 0; i < p->normal_num; i++) {
-        p->iov[i].iov_base = p->host + p->normal[i];
-        p->iov[i].iov_len = p->page_size;
+
+    if (multifd_use_packets()) {
+        for (int i = 0; i < p->normal_num; i++) {
+            p->iov[i].iov_base = p->host + p->normal[i];
+            p->iov[i].iov_len = p->page_size;
+        }
+        return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
     }
-    return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
+
+    return 0;
 }
 
 static MultiFDMethods multifd_nocomp_ops = {
@@ -799,15 +812,18 @@ static void *multifd_send_thread(void *opaque)
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
@@ -858,16 +874,20 @@ static void *multifd_send_thread(void *opaque)
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
@@ -1016,6 +1036,7 @@ bool multifd_send_setup(void)
     Error *local_err = NULL;
     int thread_count, ret = 0;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    bool use_packets = multifd_use_packets();
     uint8_t i;
 
     if (!migrate_multifd()) {
@@ -1038,27 +1059,35 @@ bool multifd_send_setup(void)
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
         multifd_new_send_channel_create(p);
     }
 
-    /*
-     * Wait until channel creation has started for all channels. The
-     * creation can still fail, but no more channels will be created
-     * past this point.
-     */
-    for (i = 0; i < thread_count; i++) {
-        qemu_sem_wait(&multifd_send_state->channels_created);
+    if (use_packets) {
+        /*
+         * Wait until channel creation has started for all channels. The
+         * creation can still fail, but no more channels will be created
+         * past this point.
+         */
+        for (i = 0; i < thread_count; i++) {
+            qemu_sem_wait(&multifd_send_state->channels_created);
+        }
     }
 
     for (i = 0; i < thread_count; i++) {
@@ -1108,7 +1137,9 @@ static void multifd_recv_terminate_threads(Error *err)
          * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
          * however try to wakeup it without harm in cleanup phase.
          */
-        qemu_sem_post(&p->sem_sync);
+        if (multifd_use_packets()) {
+            qemu_sem_post(&p->sem_sync);
+        }
 
         /*
          * We could arrive here for two reasons:
@@ -1182,7 +1213,7 @@ void multifd_recv_sync_main(void)
 {
     int i;
 
-    if (!migrate_multifd()) {
+    if (!migrate_multifd() || !multifd_use_packets()) {
         return;
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
@@ -1209,13 +1240,14 @@ static void *multifd_recv_thread(void *opaque)
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
 
@@ -1223,25 +1255,27 @@ static void *multifd_recv_thread(void *opaque)
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
@@ -1249,9 +1283,11 @@ static void *multifd_recv_thread(void *opaque)
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
 
@@ -1270,6 +1306,7 @@ int multifd_recv_setup(Error **errp)
 {
     int thread_count;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    bool use_packets = multifd_use_packets();
     uint8_t i;
 
     /*
@@ -1294,9 +1331,12 @@ int multifd_recv_setup(Error **errp)
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
@@ -1340,18 +1380,24 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
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


