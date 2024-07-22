Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BC4C3DA63
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 18:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVxK0-0003U2-4T; Mon, 22 Jul 2024 13:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVxJy-0003PY-Rn
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:59:38 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVxJv-000386-UQ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:59:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6B4CD21B8C;
 Mon, 22 Jul 2024 17:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721671173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6BPhaF+EZHTqmz/osYdJ7aHl1MRXlZSXHJwyPxwg10=;
 b=sTn+bC6CoapCX/rlFoeIGh3EWc3nT7NNaCm5dmEKjbhz6mjucjDluqHiOHw2MNPY/lioLz
 QVKWLfOl59XQcSRfFa8Dr17PMMH8UJiA8AOReUfILNqmePul2Ccd6s+jP6N8Cw8uUMgpKR
 AV3Y9HAKcd4PBgVH9s3Hy11Lkks/oQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721671173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6BPhaF+EZHTqmz/osYdJ7aHl1MRXlZSXHJwyPxwg10=;
 b=9fFa3i3ODvk3TYCo2Q/EJgvVGftmXH1YV6FtquxMoZ5/qsG+SWsfRplk9EQpiNZPypz3ng
 8TFR4Srk4RC4IABQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sTn+bC6C;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9fFa3i3O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721671173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6BPhaF+EZHTqmz/osYdJ7aHl1MRXlZSXHJwyPxwg10=;
 b=sTn+bC6CoapCX/rlFoeIGh3EWc3nT7NNaCm5dmEKjbhz6mjucjDluqHiOHw2MNPY/lioLz
 QVKWLfOl59XQcSRfFa8Dr17PMMH8UJiA8AOReUfILNqmePul2Ccd6s+jP6N8Cw8uUMgpKR
 AV3Y9HAKcd4PBgVH9s3Hy11Lkks/oQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721671173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6BPhaF+EZHTqmz/osYdJ7aHl1MRXlZSXHJwyPxwg10=;
 b=9fFa3i3ODvk3TYCo2Q/EJgvVGftmXH1YV6FtquxMoZ5/qsG+SWsfRplk9EQpiNZPypz3ng
 8TFR4Srk4RC4IABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4148113996;
 Mon, 22 Jul 2024 17:59:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cF9lAgSenmYnCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Jul 2024 17:59:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [RFC PATCH v2 9/9] migration/multifd: Replace
 multifd_send_state->pages with client data
Date: Mon, 22 Jul 2024 14:59:14 -0300
Message-Id: <20240722175914.24022-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722175914.24022-1-farosas@suse.de>
References: <20240722175914.24022-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6B4CD21B8C
X-Spamd-Result: default: False [-2.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Multifd currently has a simple scheduling mechanism that distributes
work to the various channels by keeping storage space within each
channel and an extra space that is given to the client. Each time the
client fills the space with data and calls into multifd, that space is
given to the next idle channel and a free storage space is taken from
the channel and given to client for the next iteration.

This means we always need (#multifd_channels + 1) memory slots to
operate multifd.

This is fine, except that the presence of this one extra memory slot
doesn't allow different types of payloads to be processed at the same
time in different channels, i.e. the data type of
multifd_send_state->pages needs to be the same as p->pages.

For each new data type different from MultiFDPage_t that is to be
handled, this logic would need to be duplicated by adding new fields
to multifd_send_state, to the channels and to multifd_send_pages().

Fix this situation by moving the extra slot into the client and using
only the generic type MultiFDSendData in the multifd core.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 58 ++++++++++++++++++++++++++++-----------------
 migration/multifd.h |  2 ++
 migration/ram.c     |  1 +
 3 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 4394ca6ade..0a85951d58 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -49,7 +49,6 @@ typedef struct {
 
 struct {
     MultiFDSendParams *params;
-    MultiFDSendData *data;
     /*
      * Global number of generated multifd packets.
      *
@@ -97,6 +96,8 @@ struct {
     MultiFDMethods *ops;
 } *multifd_recv_state;
 
+/* TODO: move these to multifd-ram.c */
+static MultiFDSendData *multifd_ram_send;
 static size_t multifd_ram_payload_size(void)
 {
     uint32_t n = MULTIFD_PACKET_SIZE / qemu_target_page_size();
@@ -118,6 +119,14 @@ static MultiFDSendData *multifd_send_data_alloc(void)
     return g_malloc0(sizeof(MultiFDPayloadType) + max_payload_size);
 }
 
+void multifd_ram_save_setup(void)
+{
+    uint32_t n = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+
+    multifd_ram_send = multifd_send_data_alloc();
+    multifd_ram_send->u.ram.allocated = n;
+}
+
 static bool multifd_use_packets(void)
 {
     return !migrate_mapped_ram();
@@ -620,7 +629,7 @@ static void multifd_send_kick_main(MultiFDSendParams *p)
  *
  * Returns true if succeed, false otherwise.
  */
-static bool multifd_send_pages(void)
+static bool multifd_send(MultiFDSendData **send_data)
 {
     int i;
     static int next_channel;
@@ -661,11 +670,16 @@ static bool multifd_send_pages(void)
      */
     smp_mb_acquire();
 
-    assert(!p->data->u.ram.num);
+    assert(multifd_payload_empty(p->data));
 
-    tmp = multifd_send_state->data;
-    multifd_send_state->data = p->data;
+    /*
+     * Swap the pointers. The channel gets the client data for
+     * transferring and the client gets back an unused data slot.
+     */
+    tmp = *send_data;
+    *send_data = p->data;
     p->data = tmp;
+
     /*
      * Making sure p->data is setup before marking pending_job=true. Pairs
      * with the qatomic_load_acquire() in multifd_send_thread().
@@ -697,7 +711,12 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
     MultiFDPages_t *pages;
 
 retry:
-    pages = &multifd_send_state->data->u.ram;
+    pages = &multifd_ram_send->u.ram;
+
+    if (multifd_payload_empty(multifd_ram_send)) {
+        multifd_pages_reset(pages);
+        multifd_set_payload_type(multifd_ram_send, MULTIFD_PAYLOAD_RAM);
+    }
 
     /* If the queue is empty, we can already enqueue now */
     if (multifd_queue_empty(pages)) {
@@ -715,7 +734,7 @@ retry:
      * After flush, always retry.
      */
     if (pages->block != block || multifd_queue_full(pages)) {
-        if (!multifd_send_pages()) {
+        if (!multifd_send(&multifd_ram_send)) {
             return false;
         }
         goto retry;
@@ -833,6 +852,8 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     g_free(p->packet);
     p->packet = NULL;
     multifd_send_state->ops->send_cleanup(p, errp);
+    g_free(p->data);
+    p->data = NULL;
 
     return *errp == NULL;
 }
@@ -845,8 +866,6 @@ static void multifd_send_cleanup_state(void)
     qemu_sem_destroy(&multifd_send_state->channels_ready);
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
-    g_free(multifd_send_state->data);
-    multifd_send_state->data = NULL;
     g_free(multifd_send_state);
     multifd_send_state = NULL;
 }
@@ -895,15 +914,14 @@ int multifd_send_sync_main(void)
 {
     int i;
     bool flush_zero_copy;
-    MultiFDPages_t *pages;
 
     if (!migrate_multifd()) {
         return 0;
     }
-    pages = &multifd_send_state->data->u.ram;
-    if (pages->num) {
-        if (!multifd_send_pages()) {
-            error_report("%s: multifd_send_pages fail", __func__);
+
+    if (!multifd_payload_empty(multifd_ram_send)) {
+        if (!multifd_send(&multifd_ram_send)) {
+            error_report("%s: multifd_send fail", __func__);
             return -1;
         }
     }
@@ -977,13 +995,11 @@ static void *multifd_send_thread(void *opaque)
 
         /*
          * Read pending_job flag before p->data.  Pairs with the
-         * qatomic_store_release() in multifd_send_pages().
+         * qatomic_store_release() in multifd_send().
          */
         if (qatomic_load_acquire(&p->pending_job)) {
-            MultiFDPages_t *pages = &p->data->u.ram;
-
             p->iovs_num = 0;
-            assert(pages->num);
+            assert(!multifd_payload_empty(p->data));
 
             ret = multifd_send_state->ops->send_prepare(p, &local_err);
             if (ret != 0) {
@@ -1006,13 +1022,13 @@ static void *multifd_send_thread(void *opaque)
             stat64_add(&mig_stats.multifd_bytes,
                        p->next_packet_size + p->packet_len);
 
-            multifd_pages_reset(pages);
             p->next_packet_size = 0;
+            multifd_set_payload_type(p->data, MULTIFD_PAYLOAD_NONE);
 
             /*
              * Making sure p->data is published before saying "we're
              * free".  Pairs with the smp_mb_acquire() in
-             * multifd_send_pages().
+             * multifd_send().
              */
             qatomic_store_release(&p->pending_job, false);
         } else {
@@ -1206,8 +1222,6 @@ bool multifd_send_setup(void)
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
-    multifd_send_state->data = multifd_send_data_alloc();
-    multifd_send_state->data->u.ram.allocated = page_count;
     qemu_sem_init(&multifd_send_state->channels_created, 0);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
     qatomic_set(&multifd_send_state->exiting, 0);
diff --git a/migration/multifd.h b/migration/multifd.h
index c9c01579a0..04c000f435 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -113,6 +113,8 @@ static inline void multifd_set_payload_type(MultiFDSendData *data,
     data->type = type;
 }
 
+void multifd_ram_save_setup(void);
+
 typedef struct {
     /* Fields are only written at creating/deletion time */
     /* No lock required for them, they are read only */
diff --git a/migration/ram.c b/migration/ram.c
index edec1a2d07..2b90396b3c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3058,6 +3058,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
     migration_ops = g_malloc0(sizeof(MigrationOps));
 
     if (migrate_multifd()) {
+        multifd_ram_save_setup();
         migration_ops->ram_save_target_page = ram_save_target_page_multifd;
     } else {
         migration_ops->ram_save_target_page = ram_save_target_page_legacy;
-- 
2.35.3


