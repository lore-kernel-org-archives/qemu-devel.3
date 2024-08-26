Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBFCC5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 19:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sifmT-0006lH-PP; Mon, 26 Aug 2024 15:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sifmR-0006c0-FQ
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:53:35 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sifmN-0002Ca-La
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:53:35 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DA431F8B2;
 Mon, 26 Aug 2024 19:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724702010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m20m0r4QWCLMsSs8oz0T1IcCV7Rz+rDYdRTAHBTA5V0=;
 b=jSa2Ou6aomDVUPYAp1R3ybcq+Ns84nSHGM2P6JmVOHbXfRwXUJpxABWWrzFYGSzoZcWRUD
 DVFbc9wggaY18QaP41mOOYxFmFl52Jie5ZRtgQ/COzeII/9VSAK0pQC4X3U4fEZD3uUZNL
 7bwU1WFkXhqsDkUKOUW+sV3zuyzreZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724702010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m20m0r4QWCLMsSs8oz0T1IcCV7Rz+rDYdRTAHBTA5V0=;
 b=m+mwulLrlPyDT9silSUv2RJYrLIQ/RM8Ke/I4XOAN0EqjNr8G1hVkYmaKoYufQKafb5WrX
 qbFr6qy/1KSxEsCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724702010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m20m0r4QWCLMsSs8oz0T1IcCV7Rz+rDYdRTAHBTA5V0=;
 b=jSa2Ou6aomDVUPYAp1R3ybcq+Ns84nSHGM2P6JmVOHbXfRwXUJpxABWWrzFYGSzoZcWRUD
 DVFbc9wggaY18QaP41mOOYxFmFl52Jie5ZRtgQ/COzeII/9VSAK0pQC4X3U4fEZD3uUZNL
 7bwU1WFkXhqsDkUKOUW+sV3zuyzreZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724702010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m20m0r4QWCLMsSs8oz0T1IcCV7Rz+rDYdRTAHBTA5V0=;
 b=m+mwulLrlPyDT9silSUv2RJYrLIQ/RM8Ke/I4XOAN0EqjNr8G1hVkYmaKoYufQKafb5WrX
 qbFr6qy/1KSxEsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B06FC1398D;
 Mon, 26 Aug 2024 19:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0ByHHTjdzGY5PQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Aug 2024 19:53:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 02/18] migration/multifd: Inline page_size and page_count
Date: Mon, 26 Aug 2024 16:53:06 -0300
Message-Id: <20240826195322.16532-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240826195322.16532-1-farosas@suse.de>
References: <20240826195322.16532-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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

The MultiFD*Params structures are for per-channel data. Constant
values should not be there because that needlessly wastes cycles and
storage. The page_size and page_count fall into this category so move
them inline in multifd.h.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-qpl.c       | 10 +++++++---
 migration/multifd-uadk.c      | 36 ++++++++++++++++++++---------------
 migration/multifd-zero-page.c |  4 ++--
 migration/multifd-zlib.c      | 14 ++++++++------
 migration/multifd-zstd.c      | 11 ++++++-----
 migration/multifd.c           | 33 ++++++++++++++++----------------
 migration/multifd.h           | 18 ++++++++++--------
 7 files changed, 71 insertions(+), 55 deletions(-)

diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index f8c84c52cf..db60c05795 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -233,8 +233,10 @@ static void multifd_qpl_deinit(QplData *qpl)
 static int multifd_qpl_send_setup(MultiFDSendParams *p, Error **errp)
 {
     QplData *qpl;
+    uint32_t page_size = multifd_ram_page_size();
+    uint32_t page_count = multifd_ram_page_count();
 
-    qpl = multifd_qpl_init(p->page_count, p->page_size, errp);
+    qpl = multifd_qpl_init(page_count, page_size, errp);
     if (!qpl) {
         return -1;
     }
@@ -245,7 +247,7 @@ static int multifd_qpl_send_setup(MultiFDSendParams *p, Error **errp)
      * additional two IOVs are used to store packet header and compressed data
      * length
      */
-    p->iov = g_new0(struct iovec, p->page_count + 2);
+    p->iov = g_new0(struct iovec, page_count + 2);
     return 0;
 }
 
@@ -534,8 +536,10 @@ out:
 static int multifd_qpl_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
     QplData *qpl;
+    uint32_t page_size = multifd_ram_page_size();
+    uint32_t page_count = multifd_ram_page_count();
 
-    qpl = multifd_qpl_init(p->page_count, p->page_size, errp);
+    qpl = multifd_qpl_init(page_count, page_size, errp);
     if (!qpl) {
         return -1;
     }
diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index b8ba3cd9c1..1ed1c6afe6 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -114,8 +114,10 @@ static void multifd_uadk_uninit_sess(struct wd_data *wd)
 static int multifd_uadk_send_setup(MultiFDSendParams *p, Error **errp)
 {
     struct wd_data *wd;
+    uint32_t page_size = multifd_ram_page_size();
+    uint32_t page_count = multifd_ram_page_count();
 
-    wd = multifd_uadk_init_sess(p->page_count, p->page_size, true, errp);
+    wd = multifd_uadk_init_sess(page_count, page_size, true, errp);
     if (!wd) {
         return -1;
     }
@@ -128,7 +130,7 @@ static int multifd_uadk_send_setup(MultiFDSendParams *p, Error **errp)
      * length
      */
 
-    p->iov = g_new0(struct iovec, p->page_count + 2);
+    p->iov = g_new0(struct iovec, page_count + 2);
     return 0;
 }
 
@@ -172,6 +174,7 @@ static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
 {
     struct wd_data *uadk_data = p->compress_data;
     uint32_t hdr_size;
+    uint32_t page_size = multifd_ram_page_size();
     uint8_t *buf = uadk_data->buf;
     int ret = 0;
     MultiFDPages_t *pages = p->pages;
@@ -188,7 +191,7 @@ static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
         struct wd_comp_req creq = {
             .op_type = WD_DIR_COMPRESS,
             .src     = pages->block->host + pages->offset[i],
-            .src_len = p->page_size,
+            .src_len = page_size,
             .dst     = buf,
             /* Set dst_len to double the src in case compressed out >= page_size */
             .dst_len = p->page_size * 2,
@@ -201,7 +204,7 @@ static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
                            p->id, ret, creq.status);
                 return -1;
             }
-            if (creq.dst_len < p->page_size) {
+            if (creq.dst_len < page_size) {
                 uadk_data->buf_hdr[i] = cpu_to_be32(creq.dst_len);
                 prepare_next_iov(p, buf, creq.dst_len);
                 buf += creq.dst_len;
@@ -213,11 +216,11 @@ static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
          * than page_size as well because at the receive end we can skip the
          * decompression. But it is tricky to find the right number here.
          */
-        if (!uadk_data->handle || creq.dst_len >= p->page_size) {
-            uadk_data->buf_hdr[i] = cpu_to_be32(p->page_size);
+        if (!uadk_data->handle || creq.dst_len >= page_size) {
+            uadk_data->buf_hdr[i] = cpu_to_be32(page_size);
             prepare_next_iov(p, pages->block->host + pages->offset[i],
-                             p->page_size);
-            buf += p->page_size;
+                             page_size);
+            buf += page_size;
         }
     }
 out:
@@ -239,8 +242,10 @@ out:
 static int multifd_uadk_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
     struct wd_data *wd;
+    uint32_t page_size = multifd_ram_page_size();
+    uint32_t page_count = multifd_ram_page_count();
 
-    wd = multifd_uadk_init_sess(p->page_count, p->page_size, false, errp);
+    wd = multifd_uadk_init_sess(page_count, page_size, false, errp);
     if (!wd) {
         return -1;
     }
@@ -281,6 +286,7 @@ static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
     uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
     uint32_t hdr_len = p->normal_num * sizeof(uint32_t);
     uint32_t data_len = 0;
+    uint32_t page_size = multifd_ram_page_size();
     uint8_t *buf = uadk_data->buf;
     int ret = 0;
 
@@ -307,7 +313,7 @@ static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
     for (int i = 0; i < p->normal_num; i++) {
         uadk_data->buf_hdr[i] = be32_to_cpu(uadk_data->buf_hdr[i]);
         data_len += uadk_data->buf_hdr[i];
-        assert(uadk_data->buf_hdr[i] <= p->page_size);
+        assert(uadk_data->buf_hdr[i] <= page_size);
     }
 
     /* read compressed data */
@@ -323,12 +329,12 @@ static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
             .src     = buf,
             .src_len = uadk_data->buf_hdr[i],
             .dst     = p->host + p->normal[i],
-            .dst_len = p->page_size,
+            .dst_len = page_size,
         };
 
-        if (uadk_data->buf_hdr[i] == p->page_size) {
-            memcpy(p->host + p->normal[i], buf, p->page_size);
-            buf += p->page_size;
+        if (uadk_data->buf_hdr[i] == page_size) {
+            memcpy(p->host + p->normal[i], buf, page_size);
+            buf += page_size;
             continue;
         }
 
@@ -344,7 +350,7 @@ static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
                        p->id, ret, creq.status);
             return -1;
         }
-        if (creq.dst_len != p->page_size) {
+        if (creq.dst_len != page_size) {
             error_setg(errp, "multifd %u: decompressed length error", p->id);
             return -1;
         }
diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index e1b8370f88..cc624e36b3 100644
--- a/migration/multifd-zero-page.c
+++ b/migration/multifd-zero-page.c
@@ -63,7 +63,7 @@ void multifd_send_zero_page_detect(MultiFDSendParams *p)
     while (i <= j) {
         uint64_t offset = pages->offset[i];
 
-        if (!buffer_is_zero(rb->host + offset, p->page_size)) {
+        if (!buffer_is_zero(rb->host + offset, multifd_ram_page_size())) {
             i++;
             continue;
         }
@@ -81,7 +81,7 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
     for (int i = 0; i < p->zero_num; i++) {
         void *page = p->host + p->zero[i];
         if (ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
-            memset(page, 0, p->page_size);
+            memset(page, 0, multifd_ram_page_size());
         } else {
             ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
         }
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 65f8aba5c8..e47d7f70dc 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -127,6 +127,7 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
     struct zlib_data *z = p->compress_data;
     z_stream *zs = &z->zs;
     uint32_t out_size = 0;
+    uint32_t page_size = multifd_ram_page_size();
     int ret;
     uint32_t i;
 
@@ -147,8 +148,8 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
          * with compression. zlib does not guarantee that this is safe,
          * therefore copy the page before calling deflate().
          */
-        memcpy(z->buf, pages->block->host + pages->offset[i], p->page_size);
-        zs->avail_in = p->page_size;
+        memcpy(z->buf, pages->block->host + pages->offset[i], page_size);
+        zs->avail_in = page_size;
         zs->next_in = z->buf;
 
         zs->avail_out = available;
@@ -260,7 +261,8 @@ static int zlib_recv(MultiFDRecvParams *p, Error **errp)
     uint32_t in_size = p->next_packet_size;
     /* we measure the change of total_out */
     uint32_t out_size = zs->total_out;
-    uint32_t expected_size = p->normal_num * p->page_size;
+    uint32_t page_size = multifd_ram_page_size();
+    uint32_t expected_size = p->normal_num * page_size;
     uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
     int ret;
     int i;
@@ -296,7 +298,7 @@ static int zlib_recv(MultiFDRecvParams *p, Error **errp)
             flush = Z_SYNC_FLUSH;
         }
 
-        zs->avail_out = p->page_size;
+        zs->avail_out = page_size;
         zs->next_out = p->host + p->normal[i];
 
         /*
@@ -310,8 +312,8 @@ static int zlib_recv(MultiFDRecvParams *p, Error **errp)
         do {
             ret = inflate(zs, flush);
         } while (ret == Z_OK && zs->avail_in
-                             && (zs->total_out - start) < p->page_size);
-        if (ret == Z_OK && (zs->total_out - start) < p->page_size) {
+                             && (zs->total_out - start) < page_size);
+        if (ret == Z_OK && (zs->total_out - start) < page_size) {
             error_setg(errp, "multifd %u: inflate generated too few output",
                        p->id);
             return -1;
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index cb6075a9a5..1812fd1b48 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -139,7 +139,7 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
             flush = ZSTD_e_flush;
         }
         z->in.src = pages->block->host + pages->offset[i];
-        z->in.size = p->page_size;
+        z->in.size = multifd_ram_page_size();
         z->in.pos = 0;
 
         /*
@@ -254,7 +254,8 @@ static int zstd_recv(MultiFDRecvParams *p, Error **errp)
 {
     uint32_t in_size = p->next_packet_size;
     uint32_t out_size = 0;
-    uint32_t expected_size = p->normal_num * p->page_size;
+    uint32_t page_size = multifd_ram_page_size();
+    uint32_t expected_size = p->normal_num * page_size;
     uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
     struct zstd_data *z = p->compress_data;
     int ret;
@@ -286,7 +287,7 @@ static int zstd_recv(MultiFDRecvParams *p, Error **errp)
     for (i = 0; i < p->normal_num; i++) {
         ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
         z->out.dst = p->host + p->normal[i];
-        z->out.size = p->page_size;
+        z->out.size = page_size;
         z->out.pos = 0;
 
         /*
@@ -300,8 +301,8 @@ static int zstd_recv(MultiFDRecvParams *p, Error **errp)
         do {
             ret = ZSTD_decompressStream(z->zds, &z->out, &z->in);
         } while (ret > 0 && (z->in.size - z->in.pos > 0)
-                         && (z->out.pos < p->page_size));
-        if (ret > 0 && (z->out.pos < p->page_size)) {
+                         && (z->out.pos < page_size));
+        if (ret > 0 && (z->out.pos < page_size)) {
             error_setg(errp, "multifd %u: decompressStream buffer too small",
                        p->id);
             return -1;
diff --git a/migration/multifd.c b/migration/multifd.c
index 0bd9c2253e..3dfed8a005 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -133,15 +133,17 @@ static void multifd_set_file_bitmap(MultiFDSendParams *p)
  */
 static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
 {
+    uint32_t page_count = multifd_ram_page_count();
+
     if (migrate_zero_copy_send()) {
         p->write_flags |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
     }
 
     if (multifd_use_packets()) {
         /* We need one extra place for the packet header */
-        p->iov = g_new0(struct iovec, p->page_count + 1);
+        p->iov = g_new0(struct iovec, page_count + 1);
     } else {
-        p->iov = g_new0(struct iovec, p->page_count);
+        p->iov = g_new0(struct iovec, page_count);
     }
 
     return 0;
@@ -165,14 +167,15 @@ static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
 static void multifd_send_prepare_iovs(MultiFDSendParams *p)
 {
     MultiFDPages_t *pages = p->pages;
+    uint32_t page_size = multifd_ram_page_size();
 
     for (int i = 0; i < pages->normal_num; i++) {
         p->iov[p->iovs_num].iov_base = pages->block->host + pages->offset[i];
-        p->iov[p->iovs_num].iov_len = p->page_size;
+        p->iov[p->iovs_num].iov_len = page_size;
         p->iovs_num++;
     }
 
-    p->next_packet_size = pages->normal_num * p->page_size;
+    p->next_packet_size = pages->normal_num * page_size;
 }
 
 /**
@@ -237,7 +240,7 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
  */
 static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
-    p->iov = g_new0(struct iovec, p->page_count);
+    p->iov = g_new0(struct iovec, multifd_ram_page_count());
     return 0;
 }
 
@@ -288,7 +291,7 @@ static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
 
     for (int i = 0; i < p->normal_num; i++) {
         p->iov[i].iov_base = p->host + p->normal[i];
-        p->iov[i].iov_len = p->page_size;
+        p->iov[i].iov_len = multifd_ram_page_size();
         ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
     }
     return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
@@ -447,6 +450,8 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
 static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
 {
     MultiFDPacket_t *packet = p->packet;
+    uint32_t page_count = multifd_ram_page_count();
+    uint32_t page_size = multifd_ram_page_size();
     int i;
 
     packet->magic = be32_to_cpu(packet->magic);
@@ -472,10 +477,10 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
      * If we received a packet that is 100 times bigger than expected
      * just stop migration.  It is a magic number.
      */
-    if (packet->pages_alloc > p->page_count) {
+    if (packet->pages_alloc > page_count) {
         error_setg(errp, "multifd: received packet "
                    "with size %u and expected a size of %u",
-                   packet->pages_alloc, p->page_count) ;
+                   packet->pages_alloc, page_count) ;
         return -1;
     }
 
@@ -521,7 +526,7 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     for (i = 0; i < p->normal_num; i++) {
         uint64_t offset = be64_to_cpu(packet->offset[i]);
 
-        if (offset > (p->block->used_length - p->page_size)) {
+        if (offset > (p->block->used_length - page_size)) {
             error_setg(errp, "multifd: offset too long %" PRIu64
                        " (max " RAM_ADDR_FMT ")",
                        offset, p->block->used_length);
@@ -533,7 +538,7 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     for (i = 0; i < p->zero_num; i++) {
         uint64_t offset = be64_to_cpu(packet->offset[p->normal_num + i]);
 
-        if (offset > (p->block->used_length - p->page_size)) {
+        if (offset > (p->block->used_length - page_size)) {
             error_setg(errp, "multifd: offset too long %" PRIu64
                        " (max " RAM_ADDR_FMT ")",
                        offset, p->block->used_length);
@@ -1157,7 +1162,7 @@ bool multifd_send_setup(void)
 {
     MigrationState *s = migrate_get_current();
     int thread_count, ret = 0;
-    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    uint32_t page_count = multifd_ram_page_count();
     bool use_packets = multifd_use_packets();
     uint8_t i;
 
@@ -1191,8 +1196,6 @@ bool multifd_send_setup(void)
             p->packet->version = cpu_to_be32(MULTIFD_VERSION);
         }
         p->name = g_strdup_printf("mig/src/send_%d", i);
-        p->page_size = qemu_target_page_size();
-        p->page_count = page_count;
         p->write_flags = 0;
 
         if (!multifd_new_send_channel_create(p, &local_err)) {
@@ -1569,7 +1572,7 @@ static void *multifd_recv_thread(void *opaque)
 int multifd_recv_setup(Error **errp)
 {
     int thread_count;
-    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    uint32_t page_count = multifd_ram_page_count();
     bool use_packets = multifd_use_packets();
     uint8_t i;
 
@@ -1613,8 +1616,6 @@ int multifd_recv_setup(Error **errp)
         p->name = g_strdup_printf("mig/dst/recv_%d", i);
         p->normal = g_new0(ram_addr_t, page_count);
         p->zero = g_new0(ram_addr_t, page_count);
-        p->page_count = page_count;
-        p->page_size = qemu_target_page_size();
     }
 
     for (i = 0; i < thread_count; i++) {
diff --git a/migration/multifd.h b/migration/multifd.h
index 0ecd6f47d7..a2bba23af9 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -13,6 +13,7 @@
 #ifndef QEMU_MIGRATION_MULTIFD_H
 #define QEMU_MIGRATION_MULTIFD_H
 
+#include "exec/target_page.h"
 #include "ram.h"
 
 typedef struct MultiFDRecvData MultiFDRecvData;
@@ -106,10 +107,6 @@ typedef struct {
     QIOChannel *c;
     /* packet allocated len */
     uint32_t packet_len;
-    /* guest page size */
-    uint32_t page_size;
-    /* number of pages in a full packet */
-    uint32_t page_count;
     /* multifd flags for sending ram */
     int write_flags;
 
@@ -173,10 +170,6 @@ typedef struct {
     QIOChannel *c;
     /* packet allocated len */
     uint32_t packet_len;
-    /* guest page size */
-    uint32_t page_size;
-    /* number of pages in a full packet */
-    uint32_t page_count;
 
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
@@ -254,4 +247,13 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
 
 void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
 
+static inline uint32_t multifd_ram_page_size(void)
+{
+    return qemu_target_page_size();
+}
+
+static inline uint32_t multifd_ram_page_count(void)
+{
+    return MULTIFD_PACKET_SIZE / qemu_target_page_size();
+}
 #endif
-- 
2.35.3


