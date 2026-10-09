Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A1ECA601D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF8UI-0006Nz-R9; Fri, 09 Oct 2026 07:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xF8UF-0006LT-NV
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xF8UE-0004M4-42
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 07:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791544201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JC+nI275e75z787S60ejsvVaEWp5q4sOLxvzrk+zmYQ=;
 b=hzGC8+OZ57azhUB1GgNygVNufhdLioZZFCpN2VSM6Pod2E1HLTnzFlVkGB0/T1067Pk7PX
 Rq7kNI26TJKXrKcynLvND1mNQIRvE3Jkj1Q7p13Cj2La8zptmPwxg3t6Dpmmkqx31DqXFK
 4Q0i0Cv/bv1OnFRfWzFskJ2MI0t+2J8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-9RRVceU0M_adcfi5cnZEng-1; Fri, 9 Oct 2026 11:09:48 +0000
X-MC-Unique: 9RRVceU0M_adcfi5cnZEng-1
X-Mimecast-MFC-AGG-ID: 9RRVceU0M_adcfi5cnZEng_1791544187
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48c46582442so3354478f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791544187; x=1792148987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JC+nI275e75z787S60ejsvVaEWp5q4sOLxvzrk+zmYQ=;
 b=MZOTlxX3kqadiI7GRRO4k87Oh9feV4bklB1SoDgBDhocgnfBE5UHKz9Cwj8B+jCPeO
 gXCo88TH+hDL5t7WzC4LaSoeoo8j47Xgaqo1NbQb8jbCcCAviS+iphDGhwEkBKppwGiA
 njqEm1VJg/RXHjp8OyWxSjOVUDka/JmriWPp7S4za21DiPIuqN6hVXe4LfE/NqB+8FOl
 8Yyqm7Q/2Cz/JgkOgiGdeDZ/s3AAMflY5gP5TwUOEclcmgVxgwD8S/h+J/k2n9XpsDUO
 IlW3x4XnKLU9YnUoQgkpA8Fpjl2y6D5G0RX+tWIPJwGBw2d5F/MuZbVqx3eoDkCMT2pK
 ygtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791544187; x=1792148987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JC+nI275e75z787S60ejsvVaEWp5q4sOLxvzrk+zmYQ=;
 b=nuJv3XT6T/hEiaWxVr22sEt8rRHM6niuLdpML8XdqqJFBPmJyujJHDQfKKeOFmUYGt
 PzkD6XHS84SToESaf41HvK9aP5uayYX6f9i0XyCx50Ehzw+nhhtfqMMqIwGLCAD2z904
 cPcZ/q90If8VXwZB9C7AarNkmXWvK33o1O4Gk26fNpXZ2g2DcBT1yI/kFcgS4JC9iBcA
 x0zGsXxIn2WqQyia3jWyyGBPgAACi0wvredo5r8EkmGCb+dZj+RXJ2HXmysYrf3bEWN+
 UKZPBuTAjBnFFqa+Z1gsNvFoflRJZe/DYASDiwOM40Ps+RQe3H0WYd2jBGB7j0wX1e1n
 CHiA==
X-Gm-Message-State: AFq9FYICkn1/dwnNSTmG6oRAfOJlGO9s5ZbIUaGNnhXmf3yJMMymUDAL
 gF4X63jmlbES/VRNPkoyrt4EogqeEUo2YsJs30LepcTVEI7HTvGVOnwsUl7wQFQarNNn+l25tOK
 SiV23fnqfIjaLfYPeioUfW0ub9sTMkiasQVlPr0bIC4wOCeQjk4e+Rsp/xOv5mJcVG62W1pwWUk
 XP9Ag8fF1NSZcdIwy2bpv6oFab7XmCa7mUKgaABd3T
X-Gm-Gg: AYBFou2qF168MRHc95lqHZLJT8LeY2deh4qYYlkno2IOD4M2OA2fhMm1afFlhlabb4I
 c7xHhWEJhEvncQV7Ll50Fzd4EGHY6egm7+zqFhdwYdX9F8/+S+9oAlNxC1/83JRZEfV5RPyDWK8
 pmSOX6ypIynwwg6UmJvjxUnUW/ljgznhpcEMUewuawwjmTFuw5oKoiC8PsA457vv3/UsE/BXSIt
 PCHwRsRgw86QAem3v1mjFoR5RempACE98tOStJO/qz1Q/PeqegatYQcjLmJHzDIMrTUtN8RVME8
 y3JjZvO1qsAqpEwlWI8llh1rdRjFFoVzXMWmVhZy3yrcOt/0YhYl6/dDs0JagtVug49FF2vATmX
 oL9CDXbnNKuBcJL3k/vx44/e6v2WKyyWNPw8KmQkYkeGjmRWxE4JYqf+r++dpP7vYqOeYqcEcm6
 wNWqbad0yKzEbd6PyKdwcWxzjfYaoDtyJ7
X-Received: by 2002:a05:6000:41c8:b0:488:8132:141b with SMTP id
 ffacd0b85a97d-48dba9bdc8bmr2969757f8f.20.1791544187112; 
 Fri, 09 Oct 2026 04:09:47 -0700 (PDT)
X-Received: by 2002:a05:6000:41c8:b0:488:8132:141b with SMTP id
 ffacd0b85a97d-48dba9bdc8bmr2969634f8f.20.1791544185715; 
 Fri, 09 Oct 2026 04:09:45 -0700 (PDT)
Received: from sraymaek-thinkpadx1nanogen2.rmtbe.csb
 (2a02-1811-d30-6f00-217b-1d12-f4f3-7e56.ip6.access.telenet.be.
 [2a02:1811:d30:6f00:217b:1d12:f4f3:7e56])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db94e530esm3295680f8f.13.2026.10.09.04.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 04:09:45 -0700 (PDT)
From: Sanne Raymaekers <sraymaek@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 Sanne Raymaekers <sraymaek@redhat.com>
Subject: [PATCH v2 2/3] block/vmdk: skip RGD for stream optimized disks
Date: Fri,  9 Oct 2026 13:09:04 +0200
Message-ID: <20261009110905.905070-3-sraymaek@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009110905.905070-1-sraymaek@redhat.com>
References: <20261009110905.905070-1-sraymaek@redhat.com>
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

Stream optimized disks the spec notes: "The rgdOffset should be ignored
because bit 1 of the flags field is not set." Where bit 1 of the flags
field indicates a redundant grain directory (RGD).[^1]

In short, stream optimized disks should have the RGD offset set to 0,
and only write the main grain directory.

This patch also corrects the comments around the code writing the grain
directories, and it makes the error thrown when it fails to write the
backup grain directory more explicit.

[^1] Virtual Disk Format 5.0 Technical Note.

Signed-off-by: Sanne Raymaekers <sraymaek@redhat.com>
---
 block/vmdk.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index c70c73515c..68eebd4a78 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2244,8 +2244,8 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
     } else {
         header.version = 1;
     }
-    header.flags = VMDK4_FLAG_RGD | VMDK4_FLAG_NL_DETECT
-                   | (compress ? VMDK4_FLAG_COMPRESS | VMDK4_FLAG_MARKER : 0)
+    header.flags =  VMDK4_FLAG_NL_DETECT
+                   | (compress ? VMDK4_FLAG_COMPRESS | VMDK4_FLAG_MARKER : VMDK4_FLAG_RGD)
                    | (zeroed_grain ? VMDK4_FLAG_ZERO_GRAIN : 0);
     header.compressAlgorithm = compress ? VMDK4_COMPRESSION_DEFLATE : 0;
     header.capacity = filesize / BDRV_SECTOR_SIZE;
@@ -2260,8 +2260,15 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
 
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
+        header.gd_offset = header.rgd_offset + gd_sectors + (gt_size * gt_count);
+    }
+
     header.grain_offset =
         ROUND_UP(header.gd_offset + gd_sectors + (gt_size * gt_count),
                  header.granularity);
@@ -2301,21 +2308,24 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
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
+        ret = blk_co_pwrite(blk, le64_to_cpu(header.rgd_offset) * BDRV_SECTOR_SIZE,
+                            gd_buf_size, gd_buf, 0);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "failed to write VMDK backup grain directory");
+            goto exit;
+        }
     }
 
-    /* write backup grain directory */
+    /* write grain directory */
     for (i = 0, tmp = le64_to_cpu(header.gd_offset) + gd_sectors;
          i < gt_count; i++, tmp += gt_size) {
         gd_buf[i] = cpu_to_le32(tmp);
@@ -2324,7 +2334,7 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
                         gd_buf_size, gd_buf, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
-                         "failed to write VMDK backup grain directory");
+                         "failed to write VMDK grain directory");
     }
 
     ret = 0;
@@ -2591,8 +2601,8 @@ vmdk_co_do_create(int64_t size,
     extent_idx = 1;
     while (created_size < size) {
         int64_t cur_size = MIN(size - created_size, extent_size);
-        extent_blk = extent_fn(cur_size, extent_idx, flat, split, compress,
-                               zeroed_grain, opaque, errp);
+        extent_blk = extent_fn(cur_size, extent_idx, flat, split, compress, zeroed_grain,
+                               opaque, errp);
         if (!extent_blk) {
             ret = -EINVAL;
             goto exit;
-- 
2.55.0


