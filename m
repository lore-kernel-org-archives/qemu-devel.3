Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97EBC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 21:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKPDi-0000s1-JR; Thu, 20 Jun 2024 17:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKPDh-0000rW-Bp
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 17:21:25 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKPDe-0007Fe-6a
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 17:21:25 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E393021AE4;
 Thu, 20 Jun 2024 21:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718918480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBvGieyDmAJ34lvusFrhcmfNOw8J3H9YbFb8zG91/a8=;
 b=N5K/HyMeE4CQ1VacO/UuTBbiU437XbR64wDIshEx3thrERBtDWCqCHtpG7BWA1PFZDuiuO
 N/wESbKX9YQvm9Pbhko5PNXN+fFBkjogqUZd1FSH3aZmYDinR2LKSeNCxqYiYYW6lz9+VN
 xV7HJOuV7vQYNGSGyNO8rBqPu3oTFKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718918480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBvGieyDmAJ34lvusFrhcmfNOw8J3H9YbFb8zG91/a8=;
 b=Z03eGOiHHfJUy6oOHmY5jcvg3w5PTU6ilB9P6sNYrzHsDzquS+3c37SvTYU/G07PJiAkyE
 7dRIC3XdJH53YLCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ANiUhL3T;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kI15Jf8r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718918479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBvGieyDmAJ34lvusFrhcmfNOw8J3H9YbFb8zG91/a8=;
 b=ANiUhL3TiFNoUAb3hT7lTfIr5Zwr0NAvvdGnAs66Y+5wg8iNwXcQkOxvkEIenZcwAw2WHy
 ELB/gtW2hm7Qtm3eSJVYGPgo8ZKqmZr+4P8fn4WiPvxjU8+ryMUgfKf66h56VxMNQtU3Iz
 dDEQWq/2atogZ0NgfszufILBtLgVfKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718918479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBvGieyDmAJ34lvusFrhcmfNOw8J3H9YbFb8zG91/a8=;
 b=kI15Jf8rYPHDoYVkbfTkY6BvGDpdPaYWuE2mkHqVlgdxW4DfmK1/6qt9s/qoNo0RjPGNTq
 AqeCwucQkj7l/eCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAAAC1369F;
 Thu, 20 Jun 2024 21:21:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CCksIE6ddGabYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 20 Jun 2024 21:21:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [RFC PATCH 3/7] migration/multifd: Replace p->pages with an opaque
 pointer
Date: Thu, 20 Jun 2024 18:21:07 -0300
Message-Id: <20240620212111.29319-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240620212111.29319-1-farosas@suse.de>
References: <20240620212111.29319-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E393021AE4
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

We want multifd to be able to handle more types of data than just ram
pages. To start decoupling multifd from pages, replace p->pages
(MultiFDPages_t) with a new type MultiFDSendData that hides an opaque
pointer.

The general idea here is to isolate functions that *need* to handle
MultiFDPages_t and move them in the future to multifd-ram.c, while
multifd.c will stay with only the core functions that handle
MultiFDSendData/MultiFDRecvData.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-zero-page.c |  2 +-
 migration/multifd-zlib.c      |  2 +-
 migration/multifd-zstd.c      |  2 +-
 migration/multifd.c           | 57 +++++++++++++++++++++--------------
 migration/multifd.h           | 13 ++++----
 5 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index e1b8370f88..1ad77462a4 100644
--- a/migration/multifd-zero-page.c
+++ b/migration/multifd-zero-page.c
@@ -46,7 +46,7 @@ static void swap_page_offset(ram_addr_t *pages_offset, int a, int b)
  */
 void multifd_send_zero_page_detect(MultiFDSendParams *p)
 {
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = p->data->opaque;
     RAMBlock *rb = pages->block;
     int i = 0;
     int j = pages->num - 1;
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 65f8aba5c8..e75e04d2c7 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -123,7 +123,7 @@ static void zlib_send_cleanup(MultiFDSendParams *p, Error **errp)
  */
 static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
 {
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = p->data->opaque;
     struct zlib_data *z = p->compress_data;
     z_stream *zs = &z->zs;
     uint32_t out_size = 0;
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index cb6075a9a5..1ba572a882 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -119,7 +119,7 @@ static void zstd_send_cleanup(MultiFDSendParams *p, Error **errp)
  */
 static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
 {
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = p->data->opaque;
     struct zstd_data *z = p->compress_data;
     int ret;
     uint32_t i;
diff --git a/migration/multifd.c b/migration/multifd.c
index 58340d9d95..55b31c4515 100644
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
@@ -110,7 +109,7 @@ void multifd_send_channel_created(void)
 
 static void multifd_set_file_bitmap(MultiFDSendParams *p)
 {
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = p->data->opaque;
 
     assert(pages->block);
 
@@ -164,7 +163,7 @@ static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
 
 static void multifd_send_prepare_iovs(MultiFDSendParams *p)
 {
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = p->data->opaque;
 
     for (int i = 0; i < pages->normal_num; i++) {
         p->iov[p->iovs_num].iov_base = pages->block->host + pages->offset[i];
@@ -411,7 +410,7 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
 void multifd_send_fill_packet(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = p->data->opaque;
     uint64_t packet_num;
     uint32_t zero_num = pages->num - pages->normal_num;
     int i;
@@ -591,7 +590,8 @@ static bool multifd_send_pages(void)
     int i;
     static int next_channel;
     MultiFDSendParams *p = NULL; /* make happy gcc */
-    MultiFDPages_t *pages = multifd_send_state->pages;
+    MultiFDPages_t *channel_pages;
+    MultiFDSendData *data = multifd_send_state->data;
 
     if (multifd_send_should_exit()) {
         return false;
@@ -626,11 +626,14 @@ static bool multifd_send_pages(void)
      * qatomic_store_release() in multifd_send_thread().
      */
     smp_mb_acquire();
-    assert(!p->pages->num);
-    multifd_send_state->pages = p->pages;
-    p->pages = pages;
+
+    channel_pages = p->data->opaque;
+    assert(!channel_pages->num);
+
+    multifd_send_state->data = p->data;
+    p->data = data;
     /*
-     * Making sure p->pages is setup before marking pending_job=true. Pairs
+     * Making sure p->data is setup before marking pending_job=true. Pairs
      * with the qatomic_load_acquire() in multifd_send_thread().
      */
     qatomic_store_release(&p->pending_job, true);
@@ -660,7 +663,7 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
     MultiFDPages_t *pages;
 
 retry:
-    pages = multifd_send_state->pages;
+    pages = multifd_send_state->data->opaque;
 
     /* If the queue is empty, we can already enqueue now */
     if (multifd_queue_empty(pages)) {
@@ -790,8 +793,10 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     qemu_sem_destroy(&p->sem_sync);
     g_free(p->name);
     p->name = NULL;
-    multifd_pages_clear(p->pages);
-    p->pages = NULL;
+    multifd_pages_clear(p->data->opaque);
+    p->data->opaque = NULL;
+    g_free(p->data);
+    p->data = NULL;
     p->packet_len = 0;
     g_free(p->packet);
     p->packet = NULL;
@@ -808,8 +813,10 @@ static void multifd_send_cleanup_state(void)
     qemu_sem_destroy(&multifd_send_state->channels_ready);
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
-    multifd_pages_clear(multifd_send_state->pages);
-    multifd_send_state->pages = NULL;
+    multifd_pages_clear(multifd_send_state->data->opaque);
+    multifd_send_state->data->opaque = NULL;
+    g_free(multifd_send_state->data);
+    multifd_send_state->data = NULL;
     g_free(multifd_send_state);
     multifd_send_state = NULL;
 }
@@ -858,11 +865,13 @@ int multifd_send_sync_main(void)
 {
     int i;
     bool flush_zero_copy;
+    MultiFDPages_t *pages;
 
     if (!migrate_multifd()) {
         return 0;
     }
-    if (multifd_send_state->pages->num) {
+    pages = multifd_send_state->data->opaque;
+    if (pages->num) {
         if (!multifd_send_pages()) {
             error_report("%s: multifd_send_pages fail", __func__);
             return -1;
@@ -937,11 +946,11 @@ static void *multifd_send_thread(void *opaque)
         }
 
         /*
-         * Read pending_job flag before p->pages.  Pairs with the
+         * Read pending_job flag before p->data.  Pairs with the
          * qatomic_store_release() in multifd_send_pages().
          */
         if (qatomic_load_acquire(&p->pending_job)) {
-            MultiFDPages_t *pages = p->pages;
+            MultiFDPages_t *pages = p->data->opaque;
 
             p->iovs_num = 0;
             assert(pages->num);
@@ -953,7 +962,7 @@ static void *multifd_send_thread(void *opaque)
 
             if (migrate_mapped_ram()) {
                 ret = file_write_ramblock_iov(p->c, p->iov, p->iovs_num,
-                                              pages, &local_err);
+                                              p->data->opaque, &local_err);
             } else {
                 ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num,
                                                   NULL, 0, p->write_flags,
@@ -973,7 +982,7 @@ static void *multifd_send_thread(void *opaque)
             p->next_packet_size = 0;
 
             /*
-             * Making sure p->pages is published before saying "we're
+             * Making sure p->data is published before saying "we're
              * free".  Pairs with the smp_mb_acquire() in
              * multifd_send_pages().
              */
@@ -1169,7 +1178,8 @@ bool multifd_send_setup(void)
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
-    multifd_send_state->pages = multifd_pages_init(page_count);
+    multifd_send_state->data = g_new0(MultiFDSendData, 1);
+    multifd_send_state->data->opaque = multifd_pages_init(page_count);
     qemu_sem_init(&multifd_send_state->channels_created, 0);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
     qatomic_set(&multifd_send_state->exiting, 0);
@@ -1181,7 +1191,8 @@ bool multifd_send_setup(void)
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
         p->id = i;
-        p->pages = multifd_pages_init(page_count);
+        p->data = g_new0(MultiFDSendData, 1);
+        p->data->opaque = multifd_pages_init(page_count);
 
         if (use_packets) {
             p->packet_len = sizeof(MultiFDPacket_t)
@@ -1684,7 +1695,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
 
 bool multifd_send_prepare_common(MultiFDSendParams *p)
 {
-    MultiFDPages_t *pages = p->pages;
+    MultiFDPages_t *pages = p->data->opaque;
     multifd_send_zero_page_detect(p);
 
     if (!pages->normal_num) {
diff --git a/migration/multifd.h b/migration/multifd.h
index 0ecd6f47d7..2029bfd80a 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -16,6 +16,7 @@
 #include "ram.h"
 
 typedef struct MultiFDRecvData MultiFDRecvData;
+typedef struct MultiFDSendData MultiFDSendData;
 
 bool multifd_send_setup(void);
 void multifd_send_shutdown(void);
@@ -89,6 +90,11 @@ struct MultiFDRecvData {
     off_t file_offset;
 };
 
+struct MultiFDSendData {
+    void *opaque;
+    size_t size;
+};
+
 typedef struct {
     /* Fields are only written at creating/deletion time */
     /* No lock required for them, they are read only */
@@ -131,12 +137,7 @@ typedef struct {
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


