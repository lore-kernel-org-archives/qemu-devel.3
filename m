Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D20CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 14:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDk3A-0006RR-TI; Mon, 05 Oct 2026 10:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xDiqi-0001oo-Sz
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xDiqY-00066K-9G
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791207313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTIOPsOuGuLttEHQLFNAUB2xZarpbe8+S67W9Ri6lT8=;
 b=YrA6V1ntKjXEMY+UT6Yo8+udbN+lQSvs7A16LYlh6cpOLCvc4HgCalf+Z3OZYedAeMsWMK
 30bZEwSGQ0IxQR35mp4j+4hw5Lyu3V06rnRDAutjx8cCFlb6EJZeOO4VCSLcuwos4I8quU
 dwJNNSHJeOfKKQLL6wiCBGiFyihQcbc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-pJEFSk_yOJ6Ha3hklnLhwQ-1; Mon, 05 Oct 2026 09:34:01 -0400
X-MC-Unique: pJEFSk_yOJ6Ha3hklnLhwQ-1
X-Mimecast-MFC-AGG-ID: pJEFSk_yOJ6Ha3hklnLhwQ_1791207241
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so14960615e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791207241; x=1791812041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HTIOPsOuGuLttEHQLFNAUB2xZarpbe8+S67W9Ri6lT8=;
 b=oMkQJTgWtnInSsIs8SxjjPwoH54IVow9QCa+yjbkFr8lsJ2ljFcAJNOOO39jxoPBnS
 Xnyq6flJR/rxw9oZmH6qlIaOoXvjdequr6e39r9D86iGAPOtT3cxQG6cOMPwOtKDTw4I
 vUSNLEsuOA9Uyof0We4hruY7W1z2/4Lhn8wToJURGkJzdoQDtxD1OTWKSK4SfRRib9TQ
 CYAgCkY3gALQ/yW388uDnUpIUzncgYzyeX1p1eswEpDzFnK15M+fP9OY8M8s68bm+0He
 wGcC6iPrSkq13lBnaXop87BJ9YvK0VX77tColfWX1ahqd9HTwLWMwLhRotD4+Uvpxysp
 m6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791207241; x=1791812041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HTIOPsOuGuLttEHQLFNAUB2xZarpbe8+S67W9Ri6lT8=;
 b=wORceTHuSVvXKWmeanSw+jngiG6L40ZkmCARXSDUIvNVzK425Fni0NrTm2nz5Qz6FM
 kkUw8x12k5HVLzYbCkCgQqGZkQOH2D+W665W8kdxUKzioNyM7SENK9U9rg0eytw5jYL5
 d8H9FQGdD+zcPDEI+JEjDR3OEEsZTXfbK+hFZb3HuLEDyVc51t70MdFMaaGyiwsyx+h0
 APzF2e75rqMzURXSEoCbJPi8ptIpCDdZxCio5hzEW8+PJ0cuHSpYukoOLd6LkqBlULhk
 LfpFAElsXutMu8KKoCR9feqgwOzK2K9zEoYOLXn35vYAyAVkaTbdSbX835e5hV1FfFja
 A/PA==
X-Gm-Message-State: AFuF++mQmPP+25CewtsqVns87IZRcNs+ejqkRroIKUsSYw7OL2D2UpLP
 rDv8JhOCKiKwkRNyJVCs06c+RLNeWqqMcsHr9KHU868kMN1rnZjFtdf0wsZ9TuLgF3PaXGTcFVO
 x8ikn1i7DDDg6k2d1hVu6ttovzndoIL+idkFJelotqK7P9MNWa5nmUn7cpRpoScSsguKkDUInZ2
 TfvZtGbNpMuxGyWeNGzMc0ngZU2R94AMDR7ZtgS/1g
X-Gm-Gg: AYBFou0SMVl9q94TfOvK9+Xi9NLg8V6spxVSPJFYjxNRfraiAUC1iWtUJFvB4wxZrcy
 pVLqdHGPIZdldVoguWN0SEKQIpsdbvqzpKtFXSZvILZF19o9SzbChUb55mETuDuO84qzWCZCfn1
 4tJeRWvkZBqXJMiuyQZ6Y6SPwjL9OAaO7uDtGqZDY+EV3ziM5SPbNT95hpXv5UjYuTRU/JsTyfI
 aTxujChJt7MShvHbHvJn/jeEZEGlkYPo53am4ZBTJ9e+xmXxh38Z/tFaNA6G/rKWjkyHU6HPfPA
 R3189V0be8gZi7wYM8/u0FhXhturKCpDWqST4sFD0JF33eeSnR3umtUUcdYQmhf6T4DGb4vSfJb
 sK42oBt3A6ELU/cJycgxbtMlMtG6ZHQzM5rZr4x215zNliBvFVeboFQLyZZCdl6J7iPC5FeXLLt
 Tbi946vcl7BSOX2upeBihk7jcJcm9zSAPl
X-Received: by 2002:a05:600c:6212:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4a0275432f7mr168676925e9.9.1791207240319; 
 Mon, 05 Oct 2026 06:34:00 -0700 (PDT)
X-Received: by 2002:a05:600c:6212:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4a0275432f7mr168676325e9.9.1791207239773; 
 Mon, 05 Oct 2026 06:33:59 -0700 (PDT)
Received: from sraymaek-thinkpadx1nanogen2.rmtbe.csb
 (2a02-1811-d30-6f00-217b-1d12-f4f3-7e56.ip6.access.telenet.be.
 [2a02:1811:d30:6f00:217b:1d12:f4f3:7e56])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a030326132sm279730405e9.0.2026.10.05.06.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 06:33:59 -0700 (PDT)
From: Sanne Raymaekers <sraymaek@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, fam@euphon.net,
 Sanne Raymaekers <sraymaek@redhat.com>
Subject: [PATCH 2/3] block/vmdk: skip RGD for stream optimized disks
Date: Mon,  5 Oct 2026 15:33:15 +0200
Message-ID: <20261005133316.198087-2-sraymaek@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005133316.198087-1-sraymaek@redhat.com>
References: <20261005133316.198087-1-sraymaek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sraymaek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 05 Oct 2026 10:52:16 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Stream optimized disks the spec notes: "The rgdOffset should be ignored
because bit 1 of the flags field is not set." Where bit 1 of the flags
field indicates a redundant grain directory (RGD).[^1]

In short, stream optimized disks should have the RGD offset set to 0,
and only write the main grain directory.

[^1] Virtual Disk Format 5.0 Technical Note.

Signed-off-by: Sanne Raymaekers <sraymaek@redhat.com>
---
 block/vmdk.c | 76 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 3cdca06fff..040f38cd1d 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2218,7 +2218,7 @@ vmdk_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
 
 static int coroutine_fn GRAPH_UNLOCKED
 vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
-                 bool zeroed_grain, Error **errp)
+                 bool zeroed_grain, bool stream_optimized, Error **errp)
 {
     int ret, i;
     VMDK4Header header;
@@ -2239,9 +2239,10 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
     } else {
         header.version = 1;
     }
-    header.flags = VMDK4_FLAG_RGD | VMDK4_FLAG_NL_DETECT
+    header.flags =  VMDK4_FLAG_NL_DETECT
                    | (compress ? VMDK4_FLAG_COMPRESS | VMDK4_FLAG_MARKER : 0)
-                   | (zeroed_grain ? VMDK4_FLAG_ZERO_GRAIN : 0);
+                   | (zeroed_grain ? VMDK4_FLAG_ZERO_GRAIN : 0)
+                   | (stream_optimized ? 0 : VMDK4_FLAG_RGD);
     header.compressAlgorithm = compress ? VMDK4_COMPRESSION_DEFLATE : 0;
     header.capacity = filesize / BDRV_SECTOR_SIZE;
     header.granularity = 128;
@@ -2255,8 +2256,15 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
 
     header.desc_offset = 1;
     header.desc_size = 20;
-    header.rgd_offset = header.desc_offset + header.desc_size;
-    header.gd_offset = header.rgd_offset + gd_sectors + (gt_size * gt_count);
+
+    if (stream_optimized) {
+        header.rgd_offset = 0;
+        header.gd_offset = header.desc_offset + header.desc_size;
+    } else {
+        header.rgd_offset = header.desc_offset + header.desc_size;
+        header.gd_offset = header.rgd_offset + gd_sectors + (gt_size * gt_count);
+    }
+
     header.grain_offset =
         ROUND_UP(header.gd_offset + gd_sectors + (gt_size * gt_count),
                  header.granularity);
@@ -2296,21 +2304,24 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
         goto exit;
     }
 
-    /* write grain directory */
+    /* write backup grain directory */
     gd_buf_size = gd_sectors * BDRV_SECTOR_SIZE;
     gd_buf = g_malloc0(gd_buf_size);
-    for (i = 0, tmp = le64_to_cpu(header.rgd_offset) + gd_sectors;
-         i < gt_count; i++, tmp += gt_size) {
-        gd_buf[i] = cpu_to_le32(tmp);
-    }
-    ret = blk_co_pwrite(blk, le64_to_cpu(header.rgd_offset) * BDRV_SECTOR_SIZE,
-                        gd_buf_size, gd_buf, 0);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "failed to write VMDK grain directory");
-        goto exit;
+
+    if (!stream_optimized) {
+        for (i = 0, tmp = le64_to_cpu(header.rgd_offset) + gd_sectors;
+             i < gt_count; i++, tmp += gt_size) {
+            gd_buf[i] = cpu_to_le32(tmp);
+        }
+        ret = blk_co_pwrite(blk, le64_to_cpu(header.rgd_offset) * BDRV_SECTOR_SIZE,
+                            gd_buf_size, gd_buf, 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "failed to write VMDK grain directory");
+            goto exit;
+        }
     }
 
-    /* write backup grain directory */
+    /* write grain directory */
     for (i = 0, tmp = le64_to_cpu(header.gd_offset) + gd_sectors;
          i < gt_count; i++, tmp += gt_size) {
         gd_buf[i] = cpu_to_le32(tmp);
@@ -2319,7 +2330,7 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
                         gd_buf_size, gd_buf, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
-                         "failed to write VMDK backup grain directory");
+                         "failed to write VMDK grain directory");
     }
 
     ret = 0;
@@ -2330,8 +2341,8 @@ exit:
 
 static int coroutine_fn GRAPH_UNLOCKED
 vmdk_create_extent(const char *filename, int64_t filesize, bool flat,
-                   bool compress, bool zeroed_grain, BlockBackend **pbb,
-                   QemuOpts *opts, Error **errp)
+                   bool compress, bool zeroed_grain, bool stream_optimized,
+                   BlockBackend **pbb, QemuOpts *opts, Error **errp)
 {
     int ret;
     BlockBackend *blk = NULL;
@@ -2351,7 +2362,8 @@ vmdk_create_extent(const char *filename, int64_t filesize, bool flat,
 
     blk_set_allow_write_beyond_eof(blk, true);
 
-    ret = vmdk_init_extent(blk, filesize, flat, compress, zeroed_grain, errp);
+    ret = vmdk_init_extent(blk, filesize, flat, compress, zeroed_grain, stream_optimized,
+                           errp);
 exit:
     if (blk) {
         if (pbb) {
@@ -2411,8 +2423,8 @@ static int filename_decompose(const char *filename, char *path, char *prefix,
  */
 typedef BlockBackend * coroutine_fn GRAPH_UNLOCKED_PTR
     (*vmdk_create_extent_fn)(int64_t size, int idx, bool flat, bool split,
-                             bool compress, bool zeroed_grain, void *opaque,
-                             Error **errp);
+                             bool compress, bool zeroed_grain, bool stream_optimized,
+                             void *opaque, Error **errp);
 
 static void vmdk_desc_add_extent(GString *desc,
                                  const char *extent_line_fmt,
@@ -2534,6 +2546,7 @@ vmdk_co_do_create(int64_t size,
     }
     /* Get the descriptor file BDS */
     blk = extent_fn(created_size, 0, flat, split, compress, zeroed_grain,
+                    subformat == BLOCKDEV_VMDK_SUBFORMAT_STREAMOPTIMIZED,
                     opaque, errp);
     if (!blk) {
         ret = -EIO;
@@ -2586,8 +2599,9 @@ vmdk_co_do_create(int64_t size,
     extent_idx = 1;
     while (created_size < size) {
         int64_t cur_size = MIN(size - created_size, extent_size);
-        extent_blk = extent_fn(cur_size, extent_idx, flat, split, compress,
-                               zeroed_grain, opaque, errp);
+        extent_blk = extent_fn(cur_size, extent_idx, flat, split, compress, zeroed_grain,
+                               subformat == BLOCKDEV_VMDK_SUBFORMAT_STREAMOPTIMIZED,
+                               opaque, errp);
         if (!extent_blk) {
             ret = -EINVAL;
             goto exit;
@@ -2601,6 +2615,7 @@ vmdk_co_do_create(int64_t size,
 
     /* Check whether we got excess extents */
     extent_blk = extent_fn(-1, extent_idx, flat, split, compress, zeroed_grain,
+                           subformat == BLOCKDEV_VMDK_SUBFORMAT_STREAMOPTIMIZED,
                            opaque, NULL);
     if (extent_blk) {
         blk_co_unref(extent_blk);
@@ -2661,8 +2676,8 @@ typedef struct {
 
 static BlockBackend * coroutine_fn GRAPH_UNLOCKED
 vmdk_co_create_opts_cb(int64_t size, int idx, bool flat, bool split,
-                       bool compress, bool zeroed_grain, void *opaque,
-                       Error **errp)
+                       bool compress, bool zeroed_grain, bool stream_optimized,
+                       void *opaque, Error **errp)
 {
     BlockBackend *blk = NULL;
     BlockDriverState *bs = NULL;
@@ -2691,8 +2706,8 @@ vmdk_co_create_opts_cb(int64_t size, int idx, bool flat, bool split,
     g_free(rel_filename);
 
     if (vmdk_create_extent(ext_filename, size,
-                           flat, compress, zeroed_grain, &blk, data->opts,
-                           errp)) {
+                           flat, compress, zeroed_grain, stream_optimized, &blk,
+                           data->opts, errp)) {
         goto exit;
     }
     bdrv_co_unref(bs);
@@ -2812,7 +2827,7 @@ exit:
 
 static BlockBackend * coroutine_fn GRAPH_UNLOCKED
 vmdk_co_create_cb(int64_t size, int idx, bool flat, bool split, bool compress,
-                  bool zeroed_grain, void *opaque, Error **errp)
+                  bool zeroed_grain, bool stream_optimized, void *opaque, Error **errp)
 {
     int ret;
     BlockDriverState *bs;
@@ -2852,7 +2867,8 @@ vmdk_co_create_cb(int64_t size, int idx, bool flat, bool split, bool compress,
     bdrv_co_unref(bs);
 
     if (size != -1) {
-        ret = vmdk_init_extent(blk, size, flat, compress, zeroed_grain, errp);
+        ret = vmdk_init_extent(blk, size, flat, compress, zeroed_grain, stream_optimized,
+                               errp);
         if (ret) {
             blk_co_unref(blk);
             blk = NULL;
-- 
2.55.0


