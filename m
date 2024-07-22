Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E344C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 18:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVxJv-0003D6-Sb; Mon, 22 Jul 2024 13:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVxJu-00037I-DK
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:59:34 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sVxJo-00037P-GW
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:59:33 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D839E1FB42;
 Mon, 22 Jul 2024 17:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721671166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HN9/IQFX1axqLwfA8q+DCIUChYwXgxrYqTMU0Ie3HHM=;
 b=DLR5AXwJUnMUpGcHBEE9AHSnX7cUFyr0hH6rDO50nM9cjChCI3SGdXpSuji9YDpJS5/3VD
 9ZuoQIDm9YYUOaRFvfxXKyWqZgFTZdWMxc5j4qodOE+vxh7XW1N0cZ7SEtmfu1b6Dmg4xJ
 gL8s7c0tiv7wTIWhVw5MJo6rrvgmwh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721671166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HN9/IQFX1axqLwfA8q+DCIUChYwXgxrYqTMU0Ie3HHM=;
 b=N+7XNe+GMGQnlf4q5c+KVK4vqEzUfCwEiJgkceMoUSJpOMSfYEoAci4LWtMjJwQgMqkCSn
 ujcGz30I1V7ni0Dg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DLR5AXwJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N+7XNe+G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721671166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HN9/IQFX1axqLwfA8q+DCIUChYwXgxrYqTMU0Ie3HHM=;
 b=DLR5AXwJUnMUpGcHBEE9AHSnX7cUFyr0hH6rDO50nM9cjChCI3SGdXpSuji9YDpJS5/3VD
 9ZuoQIDm9YYUOaRFvfxXKyWqZgFTZdWMxc5j4qodOE+vxh7XW1N0cZ7SEtmfu1b6Dmg4xJ
 gL8s7c0tiv7wTIWhVw5MJo6rrvgmwh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721671166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HN9/IQFX1axqLwfA8q+DCIUChYwXgxrYqTMU0Ie3HHM=;
 b=N+7XNe+GMGQnlf4q5c+KVK4vqEzUfCwEiJgkceMoUSJpOMSfYEoAci4LWtMjJwQgMqkCSn
 ujcGz30I1V7ni0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0E1213996;
 Mon, 22 Jul 2024 17:59:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IH7BHf2dnmYnCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Jul 2024 17:59:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [RFC PATCH v2 5/9] migration/multifd: Replace p->pages with an union
 pointer
Date: Mon, 22 Jul 2024 14:59:10 -0300
Message-Id: <20240722175914.24022-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722175914.24022-1-farosas@suse.de>
References: <20240722175914.24022-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.19 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D839E1FB42
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Bar: /
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

We want multifd to be able to handle more types of data than just ram
pages. To start decoupling multifd from pages, replace p->pages
(MultiFDPages_t) with the new type MultiFDSendData that hides the
client payload inside an union.

The general idea here is to isolate functions that *need* to handle
MultiFDPages_t and move them in the future to multifd-ram.c, while
multifd.c will stay with only the core functions that handle
MultiFDSendData/MultiFDRecvData.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-qpl.c       |  6 +--
 migration/multifd-uadk.c      |  2 +-
 migration/multifd-zero-page.c |  2 +-
 migration/multifd-zlib.c      |  2 +-
 migration/multifd-zstd.c      |  2 +-
 migration/multifd.c           | 84 +++++++++++++++++++++--------------
 migration/multifd.h           |  7 +--
 7 files changed, 58 insertions(+), 47 deletions(-)

diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index f8c84c52cf..17ca16824d 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -404,7 +404,7 @@ retry:
 static void multifd_qpl_compress_pages_slow_path(MultiFDSendParams *p)
 {
     QplData *qpl = p->compress_data;
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = &p->data->u.ram;
     uint32_t size = p->page_size;
     qpl_job *job = qpl->sw_job;
     uint8_t *zbuf = qpl->zbuf;
@@ -435,7 +435,7 @@ static void multifd_qpl_compress_pages_slow_path(MultiFDSendParams *p)
 static void multifd_qpl_compress_pages(MultiFDSendParams *p)
 {
     QplData *qpl = p->compress_data;
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = &p->data->u.ram;
     uint32_t size = p->page_size;
     QplHwJob *hw_job;
     uint8_t *buf;
@@ -499,7 +499,7 @@ static void multifd_qpl_compress_pages(MultiFDSendParams *p)
 static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error **errp)
 {
     QplData *qpl = p->compress_data;
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = &p->data->u.ram;
     uint32_t len = 0;
 
     if (!multifd_send_prepare_common(p)) {
diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index b8ba3cd9c1..a561988d2f 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -174,7 +174,7 @@ static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
     uint32_t hdr_size;
     uint8_t *buf = uadk_data->buf;
     int ret = 0;
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = &p->data->u.ram;
 
     if (!multifd_send_prepare_common(p)) {
         goto out;
diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index e1b8370f88..efc0424f74 100644
--- a/migration/multifd-zero-page.c
+++ b/migration/multifd-zero-page.c
@@ -46,7 +46,7 @@ static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
  */
 void multifd_send_zero_page_detect(MultiFDSendParams *p)
 {
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = &p->data->u.ram;
     RAMBlock *rb = pages->block;
     int i = 0;
     int j = pages->num - 1;
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 65f8aba5c8..cec552e9b4 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -123,7 +123,7 @@ static void zlib_send_cleanup(MultiFDSendParams *p, Error **errp)
  */
 static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
 {
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = &p->data->u.ram;
     struct zlib_data *z = p->compress_data;
     z_stream *zs = &z->zs;
     uint32_t out_size = 0;
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index cb6075a9a5..ff72c6d90a 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -119,7 +119,7 @@ static void zstd_send_cleanup(MultiFDSendParams *p, Error **errp)
  */
 static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
 {
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = &p->data->u.ram;
     struct zstd_data *z = p->compress_data;
     int ret;
     uint32_t i;
diff --git a/migration/multifd.c b/migration/multifd.c
index 440319b361..f64b053e44 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -49,8 +49,7 @@ typedef struct {
 
 struct {
     MultiFDSendParams *params;
-    /* array of pages to sent */
-    MultiFDPages_t *pages;
+    MultiFDSendData *data;
     /*
      * Global number of generated multifd packets.
      *
@@ -98,6 +97,27 @@ struct {
     MultiFDMethods *ops;
 } *multifd_recv_state;
 
+static size_t multifd_ram_payload_size(void)
+{
+    uint32_t n = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+
+    return sizeof(MultiFDPages_t) + n * sizeof(ram_addr_t);
+}
+
+static MultiFDSendData *multifd_send_data_alloc(void)
+{
+    size_t max_payload_size;
+
+    /*
+     * MultiFDPages_t carries extra data as a flexible array
+     * member. When adding new payload types, change this to use the
+     * larger between multifd_ram_payload_size() and the new type(s).
+     */
+    max_payload_size = multifd_ram_payload_size();
+
+    return g_malloc0(sizeof(MultiFDPayloadType) + max_payload_size);
+}
+
 static bool multifd_use_packets(void)
 {
     return !migrate_mapped_ram();
@@ -110,7 +130,7 @@ void multifd_send_channel_created(void)
 
 static void multifd_set_file_bitmap(MultiFDSendParams *p)
 {
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = &p->data->u.ram;
 
     assert(pages->block);
 
@@ -164,7 +184,7 @@ static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
 
 static void multifd_send_prepare_iovs(MultiFDSendParams *p)
 {
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = &p->data->u.ram;
 
     for (int i = 0; i < pages->normal_num; i++) {
         p->iov[p->iovs_num].iov_base = pages->block->host + pages->offset[i];
@@ -389,17 +409,10 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
     return msg.id;
 }
 
-static void multifd_pages_clear(MultiFDPages_t *pages)
-{
-    multifd_pages_reset(pages);
-    pages->allocated = 0;
-    g_free(pages);
-}
-
 void multifd_send_fill_packet(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = &p->data->u.ram;
     uint64_t packet_num;
     uint32_t zero_num = pages->num - pages->normal_num;
     int i;
@@ -579,7 +592,7 @@ static bool multifd_send_pages(void)
     int i;
     static int next_channel;
     MultiFDSendParams *p = NULL; /* make happy gcc */
-    MultiFDPages_t *pages = multifd_send_state->pages;
+    MultiFDSendData *tmp;
 
     if (multifd_send_should_exit()) {
         return false;
@@ -614,11 +627,14 @@ static bool multifd_send_pages(void)
      * qatomic_store_release() in multifd_send_thread().
      */
     smp_mb_acquire();
-    assert(!p->pages->num);
-    multifd_send_state->pages = p->pages;
-    p->pages = pages;
+
+    assert(!p->data->u.ram.num);
+
+    tmp = multifd_send_state->data;
+    multifd_send_state->data = p->data;
+    p->data = tmp;
     /*
-     * Making sure p->pages is setup before marking pending_job=true. Pairs
+     * Making sure p->data is setup before marking pending_job=true. Pairs
      * with the qatomic_load_acquire() in multifd_send_thread().
      */
     qatomic_store_release(&p->pending_job, true);
@@ -648,7 +664,7 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
     MultiFDPages_t *pages;
 
 retry:
-    pages = multifd_send_state->pages;
+    pages = &multifd_send_state->data->u.ram;
 
     /* If the queue is empty, we can already enqueue now */
     if (multifd_queue_empty(pages)) {
@@ -778,8 +794,8 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     qemu_sem_destroy(&p->sem_sync);
     g_free(p->name);
     p->name = NULL;
-    multifd_pages_clear(p->pages);
-    p->pages = NULL;
+    g_free(p->data);
+    p->data = NULL;
     p->packet_len = 0;
     g_free(p->packet);
     p->packet = NULL;
@@ -796,8 +812,8 @@ static void multifd_send_cleanup_state(void)
     qemu_sem_destroy(&multifd_send_state->channels_ready);
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
-    multifd_pages_clear(multifd_send_state->pages);
-    multifd_send_state->pages = NULL;
+    g_free(multifd_send_state->data);
+    multifd_send_state->data = NULL;
     g_free(multifd_send_state);
     multifd_send_state = NULL;
 }
@@ -846,11 +862,13 @@ int multifd_send_sync_main(void)
 {
     int i;
     bool flush_zero_copy;
+    MultiFDPages_t *pages;
 
     if (!migrate_multifd()) {
         return 0;
     }
-    if (multifd_send_state->pages->num) {
+    pages = &multifd_send_state->data->u.ram;
+    if (pages->num) {
         if (!multifd_send_pages()) {
             error_report("%s: multifd_send_pages fail", __func__);
             return -1;
@@ -925,11 +943,11 @@ static void *multifd_send_thread(void *opaque)
         }
 
         /*
-         * Read pending_job flag before p->pages.  Pairs with the
+         * Read pending_job flag before p->data.  Pairs with the
          * qatomic_store_release() in multifd_send_pages().
          */
         if (qatomic_load_acquire(&p->pending_job)) {
-            MultiFDPages_t *pages = p->pages;
+            MultiFDPages_t *pages = &p->data->u.ram;
 
             p->iovs_num = 0;
             assert(pages->num);
@@ -941,7 +959,7 @@ static void *multifd_send_thread(void *opaque)
 
             if (migrate_mapped_ram()) {
                 ret = file_write_ramblock_iov(p->c, p->iov, p->iovs_num,
-                                              pages, &local_err);
+                                              &p->data->u.ram, &local_err);
             } else {
                 ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num,
                                                   NULL, 0, p->write_flags,
@@ -961,7 +979,7 @@ static void *multifd_send_thread(void *opaque)
             p->next_packet_size = 0;
 
             /*
-             * Making sure p->pages is published before saying "we're
+             * Making sure p->data is published before saying "we're
              * free".  Pairs with the smp_mb_acquire() in
              * multifd_send_pages().
              */
@@ -1157,9 +1175,8 @@ bool multifd_send_setup(void)
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
-    multifd_send_state->pages = g_malloc0(sizeof(MultiFDPages_t) +
-                                          page_count * sizeof(ram_addr_t));
-    multifd_send_state->pages->allocated = page_count;
+    multifd_send_state->data = multifd_send_data_alloc();
+    multifd_send_state->data->u.ram.allocated = page_count;
     qemu_sem_init(&multifd_send_state->channels_created, 0);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
     qatomic_set(&multifd_send_state->exiting, 0);
@@ -1171,9 +1188,8 @@ bool multifd_send_setup(void)
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
         p->id = i;
-        p->pages = g_malloc0(sizeof(MultiFDPages_t) +
-                             page_count * sizeof(ram_addr_t));
-        p->pages->allocated = page_count;
+        p->data = multifd_send_data_alloc();
+        p->data->u.ram.allocated = page_count;
         if (use_packets) {
             p->packet_len = sizeof(MultiFDPacket_t)
                           + sizeof(uint64_t) * page_count;
@@ -1675,7 +1691,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
 
 bool multifd_send_prepare_common(MultiFDSendParams *p)
 {
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = &p->data->u.ram;
     multifd_send_zero_page_detect(p);
 
     if (!pages->normal_num) {
diff --git a/migration/multifd.h b/migration/multifd.h
index 12d4247e23..c9c01579a0 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -155,12 +155,7 @@ typedef struct {
      */
     bool pending_job;
     bool pending_sync;
-    /* array of pages to sent.
-     * The owner of 'pages' depends of 'pending_job' value:
-     * pending_job == 0 -> migration_thread can use it.
-     * pending_job != 0 -> multifd_channel can use it.
-     */
-    MultiFDPages_t *pages;
+    MultiFDSendData *data;
 
     /* thread local variables. No locking required */
 
-- 
2.35.3


