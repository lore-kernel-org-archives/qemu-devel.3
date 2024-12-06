Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0619BE7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 00:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJLtO-00056o-Jv; Thu, 05 Dec 2024 19:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takeshibaconsuzuki@gmail.com>)
 id 1tJLtM-00056P-39; Thu, 05 Dec 2024 19:08:20 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takeshibaconsuzuki@gmail.com>)
 id 1tJLtK-0000fK-99; Thu, 05 Dec 2024 19:08:19 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5f1d1fdb328so423618eaf.3; 
 Thu, 05 Dec 2024 16:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733443696; x=1734048496; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Wui8MJ22WEMSJ4dKXTOKhXCd0e/cs43WDijGmkD/eL4=;
 b=exlS51rh/5EemMrP/W9XABKeNhtmhL16EC4yHyZCz20gmww4efCFusiJ+Nx/X32n8+
 pFDdxonfUcpVFy9cPlPYKX7TQvMrWbQY1/SOpz/svCri9sw1VsV+ogKnab2A+0CfiQQl
 NejOWNN/BT9Slz1SBpVsxhetg1c7lzQiaLro9mkNsVYCggu10IqG/y8YJhQg7Djl33mJ
 5whZD8PiCDQVYptHgtsJ40872XkCnnt1geqFEB/BkO0FlSitzBdpc//Rr/Sq6IzL8Fh6
 L3XMlg5fo3koXoFjfrHmPtBHUDuC/Mgpt0APgSq0dw+FNrKSq7G26EqhN5nnulUZuuXc
 U6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733443696; x=1734048496;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wui8MJ22WEMSJ4dKXTOKhXCd0e/cs43WDijGmkD/eL4=;
 b=UObyGYP1LpSTq2H8GMUzhLox03cMHMnyc41uzz4bKDzCRIc2lB876jaKbxEEiunrYf
 Zy/axTxCYrJDl40excksAtmjUClzvXZTnLJlML6l2WBNKWDuxjZOe0WBCV6ciWcdZkTZ
 uvVu6YN8HPqE/CBU/KAUBfrFWB6o8JFqW3/KPGSUtxsJGwoIQOXLYEfVVNaKiHncnMHT
 Ynak//WiV+nUoV53M6kzmj04vhJyYznnRgu/pscSM9hrK428uTOWWLfVRxv51EU/BvuD
 rLMB4fdNlD3qxbssMoDan7SDVxsKva8hsowJPXcqEuXinbLIFlJ4uZSgO5jCmbX9/byB
 uAiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5tBDyhB7zSosn1W+OUdHRc31tulGIJqik3bMD9p+Gs+LZIqMCcg7bFKxuYupn1hsPeL4R1K2IwkuM@nongnu.org
X-Gm-Message-State: AOJu0YxWCBzAxMznXZ3a5LPxwFV5Hh5W4wESoNb/1u5pOtITOjkyHAPY
 HQvUik85rOI9oBV3ELrzmu83OHmayoWdXc1tvgXy0JhtfZQQKAF4yMktr13M
X-Gm-Gg: ASbGnctJ9Ue+k9G9tQbTzs1yJoGtZH6SQkRbc7HLHCh7I/OtTyUUnf0nPhLz4Lc1xeQ
 kR9pt8yKB08PKRI/MwRYW/SDsZKxRCAv758nCzuPMk2KVSMOZs1RB7ZGOM+2z3T7bhFc/EAooS0
 J1dad3RSDHFSHg/+SOV/aKL41tawTgb5IF9LQT2LpONI/RVKW5IS5OEYwR5q6ASkflU806uZ5TM
 VBJbOk9yNZ9LBg8EKYiJ2zJLkOtcFg2Jaw37dMpXAZTkZuYSjzPRSys3mSzJQVovd1oWv8yG1aD
 d9XU4x8WAOBC1b39kog=
X-Google-Smtp-Source: AGHT+IESix98SC+a14ZgIUJqAgTgyoYZYAXQRLy9i1FNLKRj0oxfZFGegYofpwfwijkY4RN1zoDigg==
X-Received: by 2002:a05:6830:628b:b0:71d:40b6:2ba8 with SMTP id
 46e09a7af769-71dcf553372mr484839a34.22.1733443696259; 
 Thu, 05 Dec 2024 16:08:16 -0800 (PST)
Received: from takeshi-suzuki-dev01.colo.rubrik.com ([104.171.196.13])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2793046d9sm486212eaf.30.2024.12.05.16.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 16:08:15 -0800 (PST)
From: Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
To: qemu-devel@nongnu.org
Cc: codyprime@gmail.com, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
Subject: [PATCH v2 1/3] Add RW support for 4k sector size vhdx
Date: Thu,  5 Dec 2024 16:07:49 -0800
Message-Id: <20241206000751.34694-2-takeshibaconsuzuki@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241206000751.34694-1-takeshibaconsuzuki@gmail.com>
References: <20241206000751.34694-1-takeshibaconsuzuki@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=takeshibaconsuzuki@gmail.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
---
 block/vhdx.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index 5aa1a13506..495ddc2815 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -824,8 +824,8 @@ vhdx_parse_metadata(BlockDriverState *bs, BDRVVHDXState *s)
         goto exit;
     }
 
-    /* Currently we only support 512 */
-    if (s->logical_sector_size != 512) {
+    /* Currently we only support 512 and 4096 */
+    if (s->logical_sector_size != 512 && s->logical_sector_size != 4096) {
         ret = -ENOTSUP;
         goto exit;
     }
@@ -1060,7 +1060,7 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
 
     /* the VHDX spec dictates that virtual_disk_size is always a multiple of
      * logical_sector_size */
-    bs->total_sectors = s->virtual_disk_size >> s->logical_sector_size_bits;
+    bs->total_sectors = s->virtual_disk_size >> BDRV_SECTOR_BITS;
 
     vhdx_calc_bat_entries(s);
 
@@ -1178,11 +1178,52 @@ vhdx_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 }
 
 
+/*
+ * Converts bdrv sectors to sectors of s->logical_sector_size.
+ */
+static void bdrv_sectors_to_sectors(const int64_t bdrv_sector_num,
+                                    const int bdrv_nb_sectors,
+                                    const BDRVVHDXState *const s,
+                                    int64_t * const out_sector_num,
+                                    int * const out_nb_sectors,
+                                    /* in bytes */
+                                    int * const out_begin_skip,
+                                    /* in bytes */
+                                    int * const out_end_skip) {
+    if (bdrv_nb_sectors == 0) {
+        *out_nb_sectors = 0;
+        return;
+    }
+    const int64_t begin_off = bdrv_sector_num * BDRV_SECTOR_SIZE;
+    const int64_t sector_num = begin_off >> s->logical_sector_size_bits;
+    const int begin_skip = begin_off - sector_num * s->logical_sector_size;
+    const int64_t end_off = (bdrv_sector_num + bdrv_nb_sectors) *
+                            BDRV_SECTOR_SIZE;
+    const int64_t end_sector_num = (end_off + s->logical_sector_size - 1) >>
+                                   s->logical_sector_size_bits;
+    const int end_skip = end_sector_num * s->logical_sector_size - end_off;
+    const int nb_sectors = end_sector_num - sector_num;
+    *out_sector_num = sector_num;
+    *out_nb_sectors = nb_sectors;
+    *out_begin_skip = begin_skip;
+    *out_end_skip = end_skip;
+}
+
+
 static int coroutine_fn GRAPH_RDLOCK
 vhdx_co_readv(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
               QEMUIOVector *qiov)
 {
     BDRVVHDXState *s = bs->opaque;
+    int begin_skip, end_skip;
+    bdrv_sectors_to_sectors(sector_num,
+                            nb_sectors,
+                            s,
+                            &sector_num,
+                            &nb_sectors,
+                            &begin_skip,
+                            &end_skip);
+
     int ret = 0;
     VHDXSectorInfo sinfo;
     uint64_t bytes_done = 0;
@@ -1216,9 +1257,16 @@ vhdx_co_readv(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
                 qemu_iovec_memset(&hd_qiov, 0, 0, sinfo.bytes_avail);
                 break;
             case PAYLOAD_BLOCK_FULLY_PRESENT:
+                if (bytes_done == 0) {
+                    sinfo.file_offset += begin_skip;
+                    sinfo.bytes_avail -= begin_skip;
+                }
+                if (nb_sectors - sinfo.sectors_avail <= 0) {
+                    sinfo.bytes_avail -= end_skip;
+                }
                 qemu_co_mutex_unlock(&s->lock);
                 ret = bdrv_co_preadv(bs->file, sinfo.file_offset,
-                                     sinfo.sectors_avail * BDRV_SECTOR_SIZE,
+                                     sinfo.bytes_avail,
                                      &hd_qiov, 0);
                 qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
@@ -1336,8 +1384,17 @@ static int coroutine_fn GRAPH_RDLOCK
 vhdx_co_writev(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
                QEMUIOVector *qiov, int flags)
 {
-    int ret = -ENOTSUP;
     BDRVVHDXState *s = bs->opaque;
+    int begin_skip, end_skip;
+    bdrv_sectors_to_sectors(sector_num,
+                            nb_sectors,
+                            s,
+                            &sector_num,
+                            &nb_sectors,
+                            &begin_skip,
+                            &end_skip);
+
+    int ret = -ENOTSUP;
     VHDXSectorInfo sinfo;
     uint64_t bytes_done = 0;
     uint64_t bat_entry = 0;
@@ -1451,9 +1508,16 @@ vhdx_co_writev(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
                                       sinfo.bytes_avail);
                 }
                 /* block exists, so we can just overwrite it */
+                if (bytes_done == 0) {
+                    sinfo.file_offset += begin_skip;
+                    sinfo.bytes_avail -= begin_skip;
+                }
+                if (nb_sectors - sinfo.sectors_avail <= 0) {
+                    sinfo.bytes_avail -= end_skip;
+                }
                 qemu_co_mutex_unlock(&s->lock);
                 ret = bdrv_co_pwritev(bs->file, sinfo.file_offset,
-                                      sectors_to_write * BDRV_SECTOR_SIZE,
+                                      sinfo.bytes_avail,
                                       &hd_qiov, 0);
                 qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
-- 
2.17.1


