Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B008CCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 12:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhCR-0001EH-UI; Fri, 16 Oct 2026 08:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xHhCO-0001AK-JF
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xHhCM-0002rC-BB
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 08:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792154289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtswtFKfaEl7o67qsBWJaX7OMz7kmTugzIXPWuRcxZo=;
 b=HMZd0Yk3uH9GLwRab7fUNJ6w4juMFqCW68Qgs51FfNVVowudEUwTI2f4t/4XuUouKGABcG
 0uaPzFIyPpaAV1Rsmexj7G5rMHXVQRLS8Ug8GQDJoSowDZsuuuDmuTFVMT9dqXcCkdDBg0
 vIqcvWwi7vzl+yhnY/KmQmGcONh4GeA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-J5pN0dIQMLWmMyFHfbd4DQ-1; Fri, 16 Oct 2026 12:38:06 +0000
X-MC-Unique: J5pN0dIQMLWmMyFHfbd4DQ-1
X-Mimecast-MFC-AGG-ID: J5pN0dIQMLWmMyFHfbd4DQ_1792154285
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a0284121c6so23991285e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 05:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792154285; x=1792759085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wtswtFKfaEl7o67qsBWJaX7OMz7kmTugzIXPWuRcxZo=;
 b=IcQaFSC0crfHcuwqf2e4hsehepf+JM3hfoV71hgyjHiDLOcY6EldZeChtwwFQWZ8mV
 HxpdbmQWMrJjNh8/I+0wMGBlU++62u7ySorvgE/QRgTQvPACih15wM8Yt8z8Yt2Y/e/U
 3mwmN8JZDc43Wx+o8gDedHw2qL1HgFEiN5idmgfZJz+YnXOurua9aw48RlrHeZ/TWl73
 E6wDTdu7Q5Vg/EY4TWyhHAmy7kbZZZ6I3S6iwaGUFzwQZG0N5suuIqk1B7boE4laoaF2
 fdwrTPnxFXXPwSZbSn4xkb/YdKJdZQMDJZQjpkWDh7kDQnBbFAEQbXRJyddcClChvIC8
 EPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792154285; x=1792759085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wtswtFKfaEl7o67qsBWJaX7OMz7kmTugzIXPWuRcxZo=;
 b=Zzic4+1+91Kzbg4+DmEdcoMdB17RtDk1tQ7ry8eYeOinIEACCYMKlet5mnVZ3i6dpD
 wr75SK0JVH0q9tT2vPo3RtcPOFDjHZz8u/AkzyyoyT6xa0wACtkiiCKiIsNjNtg9cI8D
 IWklfYd5p4q7kHK3CqG3OHOJbBp4bDowFlWsxDtmJJ/rnuuHhbyhVJHeP8AOIRA+fas6
 fq9idcsgNLxZgD1eMe1flJQMzkJtErRZI3s77341LFCZDxBHnA268/ha3H26/VGNGuto
 QthltO5pYn/IRy2BSnIRhEYb7V1YaTbrPM2R1j3j1YEzDI2xc/YEaXEeeOLmPCSkckAW
 seaQ==
X-Gm-Message-State: AFq9FYLLGoBoeC/JPZobhcTjZrND9i+t5o4+f74DC/EhhXlh0ybb84aj
 qYe52IX7ox8TtAGcpzbS9wFTzdBy/L2jzkK9JxhSY8Td0J5m3K1NPKnYFeDGYNBO8tNLWQrC6Dh
 dbyehT8K2Dnlpqe+CCy7sG50SEB3XsEE6pcM5ovwmlIqHTwTJJZj5mtgFtuuYQf1xr+FD0LCdPN
 0zxbwjPRxxCQ2Tw+fqQQMk4obBy+o7qdQT/3Ma4NGB
X-Gm-Gg: AYBFou3R5dzOTWetnfRCLbwOZ0dgab3zsNMY394gTextH64r2CHkUBccdfY45Eht5p+
 D3En92rPFJyZ1Y+YQI+UWwNpoye1MF98ZsmOgxobSKRu1u8xohj++WfzDqAnoySxZzKf+tq6pNO
 llK/j3+SA5BmKBYzI0xClkM88Bi5+rOycvMDbd+iYDj51XBlFPjGhpU6y5+Pnfo84kEs8z4BLzL
 dZLnie/VBnkTrhUROlPFz0PxB1qGXNey50D1Im4i64v5H7IJ7GIbjL84Kly5D31n9cgxBjlEDrL
 QS9oHR5BXwIh/XtIqRuMZoELMtq+0mk9MBbjlGMimAf80bepDhDoIM3jb0odq7E/qT195R7HZr0
 VrewiMGBCaBPeRX/8IjO3EUPCC30pH4U3ApJcthZOaFtqPEbFW6yDn4H/YqWXfi8fFyT5SgzipJ
 sgUw7OhWxGySFV9a0YyqdEGYhf8Er3slja
X-Received: by 2002:a05:600c:1389:b0:4a1:d307:b526 with SMTP id
 5b1f17b1804b1-4a1d307b5d9mr15447225e9.0.1792154284736; 
 Fri, 16 Oct 2026 05:38:04 -0700 (PDT)
X-Received: by 2002:a05:600c:1389:b0:4a1:d307:b526 with SMTP id
 5b1f17b1804b1-4a1d307b5d9mr15446685e9.0.1792154284341; 
 Fri, 16 Oct 2026 05:38:04 -0700 (PDT)
Received: from sraymaek-thinkpadx1nanogen2.rmtbe.csb
 (2a02-1811-d30-6f00-217b-1d12-f4f3-7e56.ip6.access.telenet.be.
 [2a02:1811:d30:6f00:217b:1d12:f4f3:7e56])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4e7889sm4730097f8f.24.2026.10.16.05.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 05:38:03 -0700 (PDT)
From: Sanne Raymaekers <sraymaek@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 Sanne Raymaekers <sraymaek@redhat.com>
Subject: [PATCH v3 2/3] block/vmdk: skip RGD for stream optimized disks
Date: Fri, 16 Oct 2026 14:37:49 +0200
Message-ID: <20261016123750.94769-3-sraymaek@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016123750.94769-1-sraymaek@redhat.com>
References: <20261016123750.94769-1-sraymaek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sraymaek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
---
 block/vmdk.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 7ca030c5fe..e090e122f1 100644
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
2.55.0


