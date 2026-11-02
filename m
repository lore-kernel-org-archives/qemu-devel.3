Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E8606B0D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UK/sGYN4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvp-0006jd-Em; Mon, 02 Nov 2026 11:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvh-0006ct-Dl
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvf-0002Ks-Hp
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hqCCEGACsEXFVhD2CLFE252vLkB+KB9Slm9XRi5vDQI=;
 b=UK/sGYN4ugkZIHKnSsIYUIDEitbsKJRpEQlUq8UctcZcTTd+TV3CjVT5OzsFmBhNQl+uYg
 shCAjhBnb/aemR/6yZoqlQQ5G/xXVsa8LEHC+q4XEJ4v5zULSUiBMzwLurA6bz+Kn82e4v
 TTyncsTh/HkHh6B2YNZBe8VTsEA8aaM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-Ub4VHNGrNPCkNfdocLCOCQ-1; Mon,
 02 Nov 2026 11:30:35 -0500
X-MC-Unique: Ub4VHNGrNPCkNfdocLCOCQ-1
X-Mimecast-MFC-AGG-ID: Ub4VHNGrNPCkNfdocLCOCQ_1793637034
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C17B1801359; Mon,  2 Nov 2026 16:30:34 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECA661956087; Mon,  2 Nov 2026 16:30:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 16/17] block/vmdk: skip RGD for stream optimized disks
Date: Mon,  2 Nov 2026 17:29:54 +0100
Message-ID: <20261102162955.268763-17-kwolf@redhat.com>
In-Reply-To: <20261102162955.268763-1-kwolf@redhat.com>
References: <20261102162955.268763-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sanne Raymaekers <sraymaek@redhat.com>

For stream optimized disks the spec notes: "The rgdOffset should be
ignored because bit 1 of the flags field is not set." Where bit 1 of the
flags field indicates a redundant grain directory (RGD).[^1]

In short, stream optimized disks should have the RGD offset set to 0,
and only write the main grain directory.

This patch also corrects the comments around the code writing the grain
directories, and it makes the error thrown when it fails to write the
backup grain directory more explicit.

[^1] Virtual Disk Format 5.0 Technical Note.

Signed-off-by: Sanne Raymaekers <sraymaek@redhat.com>
Message-ID: <20261016123750.94769-3-sraymaek@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 7ca030c5fe9..e090e122f11 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2246,8 +2246,9 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
     } else {
         header.version = 1;
     }
-    header.flags = VMDK4_FLAG_RGD | VMDK4_FLAG_NL_DETECT
-                   | (compress ? VMDK4_FLAG_COMPRESS | VMDK4_FLAG_MARKER : 0)
+    header.flags =  VMDK4_FLAG_NL_DETECT
+                   | (compress ?
+                      VMDK4_FLAG_COMPRESS | VMDK4_FLAG_MARKER : VMDK4_FLAG_RGD)
                    | (zeroed_grain ? VMDK4_FLAG_ZERO_GRAIN : 0);
     header.compressAlgorithm = compress ? VMDK4_COMPRESSION_DEFLATE : 0;
     header.capacity = filesize / BDRV_SECTOR_SIZE;
@@ -2262,8 +2263,16 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
 
     header.desc_offset = 1;
     header.desc_size = 20;
-    header.rgd_offset = header.desc_offset + header.desc_size;
-    header.gd_offset = header.rgd_offset + gd_sectors + (gt_size * gt_count);
+
+    if (compress) {
+        header.rgd_offset = 0;
+        header.gd_offset = header.desc_offset + header.desc_size;
+    } else {
+        header.rgd_offset = header.desc_offset + header.desc_size;
+        header.gd_offset =
+            header.rgd_offset + gd_sectors + (gt_size * gt_count);
+    }
+
     header.grain_offset =
         ROUND_UP(header.gd_offset + gd_sectors + (gt_size * gt_count),
                  header.granularity);
@@ -2303,21 +2312,26 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
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
+    if (!compress) {
+        for (i = 0, tmp = le64_to_cpu(header.rgd_offset) + gd_sectors;
+             i < gt_count; i++, tmp += gt_size) {
+            gd_buf[i] = cpu_to_le32(tmp);
+        }
+        ret = blk_co_pwrite(blk,
+                            le64_to_cpu(header.rgd_offset) * BDRV_SECTOR_SIZE,
+                            gd_buf_size, gd_buf, 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "failed to write VMDK backup grain directory");
+            goto exit;
+        }
     }
 
-    /* write backup grain directory */
+    /* write grain directory */
     for (i = 0, tmp = le64_to_cpu(header.gd_offset) + gd_sectors;
          i < gt_count; i++, tmp += gt_size) {
         gd_buf[i] = cpu_to_le32(tmp);
@@ -2326,7 +2340,7 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
                         gd_buf_size, gd_buf, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
-                         "failed to write VMDK backup grain directory");
+                         "failed to write VMDK grain directory");
     }
 
     ret = 0;
-- 
2.56.0


