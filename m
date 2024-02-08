Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F12C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXujj-0006CR-3s; Wed, 07 Feb 2024 22:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXujf-0006AB-0g
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:05:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXujc-0004LF-7o
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8rpuPTioywxfY/ZvOjWZTcWw2/q7y++Xn+a9fof+s0=;
 b=IRern8mtjEw4YmTY/lHvnosl2OIljGIjHTh1cIE3oJ2XVMGfC/NC5RDft60cRCodXTmIau
 SIQ4r964DiJQRIXZOUuezjxRJB55bz6zfgH33EZh84aGC6llD6Udw4K4h6QPwrYplvTKNi
 J7HiBOJBZGShXXREJTt2pPD2RwTemTM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-9dDuNEYlNP2lsiH5NGSpwA-1; Wed, 07 Feb 2024 22:05:52 -0500
X-MC-Unique: 9dDuNEYlNP2lsiH5NGSpwA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3493845E63;
 Thu,  8 Feb 2024 03:05:51 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60158492BC7;
 Thu,  8 Feb 2024 03:05:48 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 06/34] migration/multifd: Drop MultiFDSendParams.normal[] array
Date: Thu,  8 Feb 2024 11:05:00 +0800
Message-ID: <20240208030528.368214-7-peterx@redhat.com>
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

From: Peter Xu <peterx@redhat.com>

This array is redundant when p->pages exists.  Now we extended the life of
p->pages to the whole period where pending_job is set, it should be safe to
always use p->pages->offset[] rather than p->normal[].  Drop the array.

Alongside, the normal_num is also redundant, which is the same to
p->pages->num.

This doesn't apply to recv side, because there's no extra buffering on recv
side, so p->normal[] array is still needed.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240202102857.110210-6-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h      |  4 ----
 migration/multifd-zlib.c |  7 ++++---
 migration/multifd-zstd.c |  7 ++++---
 migration/multifd.c      | 33 +++++++++++++--------------------
 4 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 7c040cb85a..3920bdbcf1 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -122,10 +122,6 @@ typedef struct {
     struct iovec *iov;
     /* number of iovs used */
     uint32_t iovs_num;
-    /* Pages that are not zero */
-    ram_addr_t *normal;
-    /* num of non zero pages */
-    uint32_t normal_num;
     /* used for compression methods */
     void *data;
 }  MultiFDSendParams;
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 37ce48621e..100809abc1 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -116,17 +116,18 @@ static void zlib_send_cleanup(MultiFDSendParams *p, Error **errp)
  */
 static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
 {
+    MultiFDPages_t *pages = p->pages;
     struct zlib_data *z = p->data;
     z_stream *zs = &z->zs;
     uint32_t out_size = 0;
     int ret;
     uint32_t i;
 
-    for (i = 0; i < p->normal_num; i++) {
+    for (i = 0; i < pages->num; i++) {
         uint32_t available = z->zbuff_len - out_size;
         int flush = Z_NO_FLUSH;
 
-        if (i == p->normal_num - 1) {
+        if (i == pages->num - 1) {
             flush = Z_SYNC_FLUSH;
         }
 
@@ -135,7 +136,7 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
          * with compression. zlib does not guarantee that this is safe,
          * therefore copy the page before calling deflate().
          */
-        memcpy(z->buf, p->pages->block->host + p->normal[i], p->page_size);
+        memcpy(z->buf, p->pages->block->host + pages->offset[i], p->page_size);
         zs->avail_in = p->page_size;
         zs->next_in = z->buf;
 
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index b471daadcd..2023edd8cc 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -113,6 +113,7 @@ static void zstd_send_cleanup(MultiFDSendParams *p, Error **errp)
  */
 static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
 {
+    MultiFDPages_t *pages = p->pages;
     struct zstd_data *z = p->data;
     int ret;
     uint32_t i;
@@ -121,13 +122,13 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
     z->out.size = z->zbuff_len;
     z->out.pos = 0;
 
-    for (i = 0; i < p->normal_num; i++) {
+    for (i = 0; i < pages->num; i++) {
         ZSTD_EndDirective flush = ZSTD_e_continue;
 
-        if (i == p->normal_num - 1) {
+        if (i == pages->num - 1) {
             flush = ZSTD_e_flush;
         }
-        z->in.src = p->pages->block->host + p->normal[i];
+        z->in.src = p->pages->block->host + pages->offset[i];
         z->in.size = p->page_size;
         z->in.pos = 0;
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 5633ac245a..8bb1fd95cf 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -90,13 +90,13 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
 {
     MultiFDPages_t *pages = p->pages;
 
-    for (int i = 0; i < p->normal_num; i++) {
-        p->iov[p->iovs_num].iov_base = pages->block->host + p->normal[i];
+    for (int i = 0; i < pages->num; i++) {
+        p->iov[p->iovs_num].iov_base = pages->block->host + pages->offset[i];
         p->iov[p->iovs_num].iov_len = p->page_size;
         p->iovs_num++;
     }
 
-    p->next_packet_size = p->normal_num * p->page_size;
+    p->next_packet_size = pages->num * p->page_size;
     p->flags |= MULTIFD_FLAG_NOCOMP;
     return 0;
 }
@@ -269,21 +269,22 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
 static void multifd_send_fill_packet(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
+    MultiFDPages_t *pages = p->pages;
     int i;
 
     packet->flags = cpu_to_be32(p->flags);
     packet->pages_alloc = cpu_to_be32(p->pages->allocated);
-    packet->normal_pages = cpu_to_be32(p->normal_num);
+    packet->normal_pages = cpu_to_be32(pages->num);
     packet->next_packet_size = cpu_to_be32(p->next_packet_size);
     packet->packet_num = cpu_to_be64(p->packet_num);
 
-    if (p->pages->block) {
-        strncpy(packet->ramblock, p->pages->block->idstr, 256);
+    if (pages->block) {
+        strncpy(packet->ramblock, pages->block->idstr, 256);
     }
 
-    for (i = 0; i < p->normal_num; i++) {
+    for (i = 0; i < pages->num; i++) {
         /* there are architectures where ram_addr_t is 32 bit */
-        uint64_t temp = p->normal[i];
+        uint64_t temp = pages->offset[i];
 
         packet->offset[i] = cpu_to_be64(temp);
     }
@@ -570,8 +571,6 @@ void multifd_save_cleanup(void)
         p->packet = NULL;
         g_free(p->iov);
         p->iov = NULL;
-        g_free(p->normal);
-        p->normal = NULL;
         multifd_send_state->ops->send_cleanup(p, &local_err);
         if (local_err) {
             migrate_set_error(migrate_get_current(), local_err);
@@ -688,8 +687,8 @@ static void *multifd_send_thread(void *opaque)
 
         if (p->pending_job) {
             uint64_t packet_num = p->packet_num;
+            MultiFDPages_t *pages = p->pages;
             uint32_t flags;
-            p->normal_num = 0;
 
             if (use_zero_copy_send) {
                 p->iovs_num = 0;
@@ -697,12 +696,7 @@ static void *multifd_send_thread(void *opaque)
                 p->iovs_num = 1;
             }
 
-            for (int i = 0; i < p->pages->num; i++) {
-                p->normal[p->normal_num] = p->pages->offset[i];
-                p->normal_num++;
-            }
-
-            if (p->normal_num) {
+            if (pages->num) {
                 ret = multifd_send_state->ops->send_prepare(p, &local_err);
                 if (ret != 0) {
                     qemu_mutex_unlock(&p->mutex);
@@ -713,10 +707,10 @@ static void *multifd_send_thread(void *opaque)
             flags = p->flags;
             p->flags = 0;
             p->num_packets++;
-            p->total_normal_pages += p->normal_num;
+            p->total_normal_pages += pages->num;
             qemu_mutex_unlock(&p->mutex);
 
-            trace_multifd_send(p->id, packet_num, p->normal_num, flags,
+            trace_multifd_send(p->id, packet_num, pages->num, flags,
                                p->next_packet_size);
 
             if (use_zero_copy_send) {
@@ -924,7 +918,6 @@ int multifd_save_setup(Error **errp)
         p->name = g_strdup_printf("multifdsend_%d", i);
         /* We need one extra place for the packet header */
         p->iov = g_new0(struct iovec, page_count + 1);
-        p->normal = g_new0(ram_addr_t, page_count);
         p->page_size = qemu_target_page_size();
         p->page_count = page_count;
 
-- 
2.43.0


