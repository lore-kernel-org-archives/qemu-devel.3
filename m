Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB112CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 14:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOcvA-0005re-F7; Thu, 27 Nov 2025 09:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vOcv8-0005iD-2H
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:24:30 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vOcv5-0006mh-Nm
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:24:29 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42b31507ed8so859746f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 06:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1764253466; x=1764858266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6VrcdcLzzXZfY7cDeFmaKqwoc/P/gxx140XIDfVQGE=;
 b=P2iFht3cmVCPB3SS8JVXPbVR9Fofo7qDPSEnfxt6ImSTq+XuXp4VjdFwWekiFyRLLf
 oO8tf5tiC8SkXDdxsSM6VBQ0gryRuVHxCI12rOP0eCD91rb+fK0Fnv5GFRO7ZYccqVJa
 yYoBp/Aw2lCaymg4IX125OkvZG7sWjjnXc5v4r1meeSQKriQwkQkFxafvsX9vMU8HtoG
 E9WouszgCJ1fOQGVinGPUOv0WEodqark3mK5pi7SwTxu4i9PV8ozmHf4kZucnVhnZVK5
 1sAD9Brt0TTjMhbEMS80Ke0Wer/C6xcxIzQlZihJOMTPM7GlJ8C9ipMu7oHqhfQ8EFvW
 XqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764253466; x=1764858266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V6VrcdcLzzXZfY7cDeFmaKqwoc/P/gxx140XIDfVQGE=;
 b=Zd0LAl6ry2N3Iy8rEBb0hnW17Q1tURhyLSycjtdCyK/JaswgyrcJNWNr5/sdbI1AaW
 D3oqWcP41NzplW6FYzOYawecCVQuX1BxzXB6r+iTMSs/modftojXuVl0qykyoGnx0e2v
 02xgxSR4f+rWS3WQ8NnQG2YoraV8QjJ1oNEr3VKU5q1SuEDosCwtdp/DZSeSyt5XHK28
 jKiLVOGu1mmG0AEojyjnoAvWnKNGPTz/L0LK2nc2P+b34zBMqnoBi8UujPm1Ts/eHL3n
 mFLoogVM3zWMQNRud4yaIW/cN4fVmKL0U0Ci9gEAV0aaj++0GpWhRYyNSv9WrGX+5DR0
 qFlg==
X-Gm-Message-State: AOJu0Yy6Wp5Iz8AUniLDsFJdfvdBUxwOqVJBpc+R+J3+1id9U3pliNLJ
 HcDd1q3YT/RrSFXL+EtKEAdN6owz08aIOISk3MXTeThP5tCnve+Nu+2dqEU/IKFAfA==
X-Gm-Gg: ASbGncu9YBoiPDrl7er81M0qPU+Bv7pt12njZoLR7/B4iHwUZkrQ23lF9zuPRur01B7
 EvHarHymDMccCCQgVzwanFGDM9VbhNoldPBVsKqo/vo/8Gztq7+0gwHSAy+Y1dDpaCNUjl7S+rA
 HNZPr8pHDey6U+EiprEvzk9EwKJNiUC7f0U1NOqp7JoBKJx80keEHtgOCnVRMelAG1iy0rPNAuK
 zVBQCU9FWalH8owL/iO7vaOr3WlF+1UuXkDrKLk5665CxzOY8y0O1ar0ljtvR6VL4g/EPDspPj7
 uuSIEloWXajjQ7A07MK4JQQ1dQAwxqet83NOmh1ntdGj9F9QHwbKYYPORO/CG/DI3JqdAIf3zNA
 Z1AullYNRxl9A8eBbAJ/nUxKe9cK+VXk5AkXOec2eYR68qqCG5UIM3xw6h/Kg08b8dKQUlrTQ3I
 LDHZF0nAssMT8D
X-Google-Smtp-Source: AGHT+IEijdoH1Zm1vEUNN8clgPnF85kUIylmBhwWOeTRyNuXxr2FDDTlpmZ7yumJg9xOxYChzb99DQ==
X-Received: by 2002:a05:6000:26c2:b0:42b:3746:3b82 with SMTP id
 ffacd0b85a97d-42e0f3623d5mr12422172f8f.54.1764253466214; 
 Thu, 27 Nov 2025 06:24:26 -0800 (PST)
Received: from chigot-Dell.. ([2a01:e0a:ca1:4970:e598:a2f0:7cc0:4392])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a2easm4148996f8f.23.2025.11.27.06.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 06:24:25 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v3 3/5] vvfat: add a define for VVFAT_SECTOR_BITS and
 VVFAT_SECTOR_SIZE
Date: Thu, 27 Nov 2025 15:24:15 +0100
Message-ID: <20251127142417.710094-4-chigot@adacore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127142417.710094-1-chigot@adacore.com>
References: <20251127142417.710094-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This removes some hardcoded 0x200 making them far clearer.

This also renames some BDRV_SECTOR_* constants that were introduced
during the transitions for sector-based to bytes-based block interfaces.
While they have the same values, the BDRV_SECTOR_* constants are
unrelated to the VVFAT sectors.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 block/vvfat.c | 119 ++++++++++++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 53 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index baf04e678b..6b038067a2 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -75,6 +75,9 @@ static void checkpoint(void);
  */
 #define BOOTSECTOR_OEM_NAME "MSWIN4.1"
 
+#define VVFAT_SECTOR_BITS 9
+#define VVFAT_SECTOR_SIZE (1ULL << VVFAT_SECTOR_BITS)
+
 #define DIR_DELETED 0xe5
 #define DIR_KANJI DIR_DELETED
 #define DIR_KANJI_FAKE 0x05
@@ -300,7 +303,7 @@ static void print_mapping(const struct mapping_t* mapping);
 typedef struct BDRVVVFATState {
     CoMutex lock;
     BlockDriverState* bs; /* pointer to parent */
-    unsigned char first_sectors[0x40*0x200];
+    unsigned char first_sectors[0x40 * VVFAT_SECTOR_SIZE];
 
     int fat_type; /* 16 or 32 */
     array_t fat,directory,mapping;
@@ -690,11 +693,11 @@ static inline void init_fat(BDRVVVFATState* s)
     if (s->fat_type == 12) {
         array_init(&(s->fat),1);
         array_ensure_allocated(&(s->fat),
-                s->sectors_per_fat * 0x200 * 3 / 2 - 1);
+                s->sectors_per_fat * VVFAT_SECTOR_SIZE * 3 / 2 - 1);
     } else {
         array_init(&(s->fat),(s->fat_type==32?4:2));
         array_ensure_allocated(&(s->fat),
-                s->sectors_per_fat * 0x200 / s->fat.item_size - 1);
+                s->sectors_per_fat * VVFAT_SECTOR_SIZE / s->fat.item_size - 1);
     }
     memset(s->fat.pointer,0,s->fat.size);
 
@@ -902,19 +905,19 @@ static int init_directories(BDRVVVFATState* s,
     unsigned int i;
     unsigned int cluster;
 
-    memset(&(s->first_sectors[0]),0,0x40*0x200);
+    memset(&(s->first_sectors[0]), 0 , 0x40 * VVFAT_SECTOR_SIZE);
 
-    s->cluster_size=s->sectors_per_cluster*0x200;
+    s->cluster_size = s->sectors_per_cluster * VVFAT_SECTOR_SIZE;
     s->cluster_buffer=g_malloc(s->cluster_size);
 
     /*
-     * The formula: sc = spf+1+spf*spc*(512*8/fat_type),
+     * The formula: sc = spf+1+spf*spc*(VVFAT_SECTOR_SIZE*8/fat_type),
      * where sc is sector_count,
      * spf is sectors_per_fat,
      * spc is sectors_per_clusters, and
      * fat_type = 12, 16 or 32.
      */
-    i = 1+s->sectors_per_cluster*0x200*8/s->fat_type;
+    i = 1 + s->sectors_per_cluster * VVFAT_SECTOR_SIZE * 8 / s->fat_type;
     s->sectors_per_fat=(s->sector_count+i)/i; /* round up */
 
     s->offset_to_fat = s->offset_to_bootsector + 1;
@@ -1012,12 +1015,13 @@ static int init_directories(BDRVVVFATState* s,
     s->current_mapping = NULL;
 
     bootsector = (bootsector_t *)(s->first_sectors
-                                  + s->offset_to_bootsector * 0x200);
+                                  + s->offset_to_bootsector
+                                  * VVFAT_SECTOR_SIZE);
     bootsector->jump[0]=0xeb;
     bootsector->jump[1]=0x3e;
     bootsector->jump[2]=0x90;
     memcpy(bootsector->name, BOOTSECTOR_OEM_NAME, 8);
-    bootsector->sector_size=cpu_to_le16(0x200);
+    bootsector->sector_size = cpu_to_le16(VVFAT_SECTOR_SIZE);
     bootsector->sectors_per_cluster=s->sectors_per_cluster;
     bootsector->reserved_sectors=cpu_to_le16(1);
     bootsector->number_of_fats=0x2; /* number of FATs */
@@ -1310,7 +1314,7 @@ fail:
 
 static void vvfat_refresh_limits(BlockDriverState *bs, Error **errp)
 {
-    bs->bl.request_alignment = BDRV_SECTOR_SIZE; /* No sub-sector I/O */
+    bs->bl.request_alignment = VVFAT_SECTOR_SIZE; /* No sub-sector I/O */
 }
 
 static inline void vvfat_close_current_file(BDRVVVFATState *s)
@@ -1496,21 +1500,23 @@ vvfat_read(BlockDriverState *bs, int64_t sector_num, uint8_t *buf, int nb_sector
         if (s->qcow) {
             int64_t n;
             int ret;
-            ret = bdrv_co_is_allocated(s->qcow->bs, sector_num * BDRV_SECTOR_SIZE,
-                                       (nb_sectors - i) * BDRV_SECTOR_SIZE, &n);
+            ret = bdrv_co_is_allocated(s->qcow->bs,
+                                       sector_num * VVFAT_SECTOR_SIZE,
+                                       (nb_sectors - i) * VVFAT_SECTOR_SIZE,
+                                       &n);
             if (ret < 0) {
                 return ret;
             }
             if (ret) {
                 DLOG(fprintf(stderr, "sectors %" PRId64 "+%" PRId64
                              " allocated\n", sector_num,
-                             n >> BDRV_SECTOR_BITS));
-                if (bdrv_co_pread(s->qcow, sector_num * BDRV_SECTOR_SIZE, n,
-                                  buf + i * 0x200, 0) < 0) {
+                             n >> VVFAT_SECTOR_BITS));
+                if (bdrv_co_pread(s->qcow, sector_num * VVFAT_SECTOR_SIZE,
+                                  n, buf + i * VVFAT_SECTOR_SIZE, 0) < 0) {
                     return -1;
                 }
-                i += (n >> BDRV_SECTOR_BITS) - 1;
-                sector_num += (n >> BDRV_SECTOR_BITS) - 1;
+                i += (n >> VVFAT_SECTOR_BITS) - 1;
+                sector_num += (n >> VVFAT_SECTOR_BITS) - 1;
                 continue;
             }
             DLOG(fprintf(stderr, "sector %" PRId64 " not allocated\n",
@@ -1518,19 +1524,20 @@ vvfat_read(BlockDriverState *bs, int64_t sector_num, uint8_t *buf, int nb_sector
         }
         if (sector_num < s->offset_to_root_dir) {
             if (sector_num < s->offset_to_fat) {
-                memcpy(buf + i * 0x200,
-                       &(s->first_sectors[sector_num * 0x200]),
-                       0x200);
+                memcpy(buf + i * VVFAT_SECTOR_SIZE,
+                       &(s->first_sectors[sector_num * VVFAT_SECTOR_SIZE]),
+                       VVFAT_SECTOR_SIZE);
             } else if (sector_num < s->offset_to_fat + s->sectors_per_fat) {
-                memcpy(buf + i * 0x200,
-                       &(s->fat.pointer[(sector_num
-                                       - s->offset_to_fat) * 0x200]),
-                       0x200);
+                memcpy(buf + i * VVFAT_SECTOR_SIZE,
+                       &(s->fat.pointer[(sector_num - s->offset_to_fat)
+                                        * VVFAT_SECTOR_SIZE]),
+                       VVFAT_SECTOR_SIZE);
             } else if (sector_num < s->offset_to_root_dir) {
-                memcpy(buf + i * 0x200,
+                memcpy(buf + i * VVFAT_SECTOR_SIZE,
                        &(s->fat.pointer[(sector_num - s->offset_to_fat
-                                       - s->sectors_per_fat) * 0x200]),
-                       0x200);
+                                         - s->sectors_per_fat)
+                                        * VVFAT_SECTOR_SIZE]),
+                       VVFAT_SECTOR_SIZE);
             }
         } else {
             uint32_t sector = sector_num - s->offset_to_root_dir,
@@ -1538,10 +1545,12 @@ vvfat_read(BlockDriverState *bs, int64_t sector_num, uint8_t *buf, int nb_sector
             cluster_num=sector/s->sectors_per_cluster;
             if(cluster_num > s->cluster_count || read_cluster(s, cluster_num) != 0) {
                 /* LATER TODO: strict: return -1; */
-                memset(buf+i*0x200,0,0x200);
+                memset(buf + i * VVFAT_SECTOR_SIZE, 0, VVFAT_SECTOR_SIZE);
                 continue;
             }
-            memcpy(buf+i*0x200,s->cluster+sector_offset_in_cluster*0x200,0x200);
+            memcpy(buf + i * VVFAT_SECTOR_SIZE,
+                   s->cluster + sector_offset_in_cluster * VVFAT_SECTOR_SIZE,
+                   VVFAT_SECTOR_SIZE);
         }
     }
     return 0;
@@ -1553,12 +1562,12 @@ vvfat_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
 {
     int ret;
     BDRVVVFATState *s = bs->opaque;
-    uint64_t sector_num = offset >> BDRV_SECTOR_BITS;
-    int nb_sectors = bytes >> BDRV_SECTOR_BITS;
+    uint64_t sector_num = offset >> VVFAT_SECTOR_BITS;
+    int nb_sectors = bytes >> VVFAT_SECTOR_BITS;
     void *buf;
 
-    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(offset, VVFAT_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, VVFAT_SECTOR_SIZE));
 
     buf = g_try_malloc(bytes);
     if (bytes && buf == NULL) {
@@ -1824,8 +1833,8 @@ cluster_was_modified(BDRVVVFATState *s, uint32_t cluster_num)
     for (i = 0; !was_modified && i < s->sectors_per_cluster; i++) {
         was_modified = bdrv_co_is_allocated(s->qcow->bs,
                                             (cluster2sector(s, cluster_num) +
-                                             i) * BDRV_SECTOR_SIZE,
-                                            BDRV_SECTOR_SIZE, NULL);
+                                             i) * VVFAT_SECTOR_SIZE,
+                                            VVFAT_SECTOR_SIZE, NULL);
     }
 
     /*
@@ -1979,8 +1988,8 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
                     int res;
 
                     res = bdrv_co_is_allocated(s->qcow->bs,
-                                               (offs + i) * BDRV_SECTOR_SIZE,
-                                               BDRV_SECTOR_SIZE, NULL);
+                                               (offs + i) * VVFAT_SECTOR_SIZE,
+                                               VVFAT_SECTOR_SIZE, NULL);
                     if (res < 0) {
                         return -1;
                     }
@@ -1989,9 +1998,9 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
                         if (res) {
                             return -1;
                         }
-                        res = bdrv_co_pwrite(s->qcow, offs * BDRV_SECTOR_SIZE,
-                                             BDRV_SECTOR_SIZE, s->cluster_buffer,
-                                             0);
+                        res = bdrv_co_pwrite(s->qcow, offs * VVFAT_SECTOR_SIZE,
+                                             VVFAT_SECTOR_SIZE,
+                                             s->cluster_buffer, 0);
                         if (res < 0) {
                             return -2;
                         }
@@ -2169,7 +2178,7 @@ DLOG(checkpoint());
      * - if all is fine, return number of used clusters
      */
     if (s->fat2 == NULL) {
-        int size = 0x200 * s->sectors_per_fat;
+        int size = VVFAT_SECTOR_SIZE * s->sectors_per_fat;
         s->fat2 = g_malloc(size);
         memcpy(s->fat2, s->fat.pointer, size);
     }
@@ -2566,7 +2575,8 @@ commit_one_file(BDRVVVFATState* s, int dir_index, uint32_t offset)
                 (size > offset && c >=2 && !fat_eof(s, c)));
 
         ret = vvfat_read(s->bs, cluster2sector(s, c),
-            (uint8_t*)cluster, DIV_ROUND_UP(rest_size, 0x200));
+                         (uint8_t *)cluster,
+                         DIV_ROUND_UP(rest_size, VVFAT_SECTOR_SIZE));
 
         if (ret < 0) {
             qemu_close(fd);
@@ -2945,7 +2955,7 @@ static int coroutine_fn GRAPH_RDLOCK do_commit(BDRVVVFATState* s)
     }
 
     /* copy FAT (with bdrv_pread) */
-    memcpy(s->fat.pointer, s->fat2, 0x200 * s->sectors_per_fat);
+    memcpy(s->fat.pointer, s->fat2, VVFAT_SECTOR_SIZE * s->sectors_per_fat);
 
     /* recurse direntries from root (using bs->bdrv_pread) */
     ret = commit_direntries(s, 0, -1);
@@ -3009,14 +3019,15 @@ DLOG(checkpoint());
          * used to mark volume dirtiness
          */
         unsigned char *bootsector = s->first_sectors
-                                    + s->offset_to_bootsector * 0x200;
+                                    + s->offset_to_bootsector
+                                    * VVFAT_SECTOR_SIZE;
         /*
          * LATER TODO: if FAT32, this is wrong (see init_directories(),
          * which always creates a FAT16 bootsector)
          */
         const int reserved1_offset = offsetof(bootsector_t, u.fat16.reserved1);
 
-        for (i = 0; i < 0x200; i++) {
+        for (i = 0; i < VVFAT_SECTOR_SIZE; i++) {
             if (i != reserved1_offset && bootsector[i] != buf[i]) {
                 fprintf(stderr, "Tried to write to protected bootsector\n");
                 return -1;
@@ -3071,7 +3082,9 @@ DLOG(checkpoint());
                     end = sector_num + nb_sectors;
                 dir_index  = mapping->dir_index +
                     0x10 * (begin - mapping->begin * s->sectors_per_cluster);
-                direntries = (direntry_t*)(buf + 0x200 * (begin - sector_num));
+                direntries =
+                    (direntry_t *)(buf + VVFAT_SECTOR_SIZE
+                                   * (begin - sector_num));
 
                 for (k = 0; k < (end - begin) * 0x10; k++) {
                     /* no access to the direntry of a read-only file */
@@ -3097,8 +3110,8 @@ DLOG(checkpoint());
      * Use qcow backend. Commit later.
      */
 DLOG(fprintf(stderr, "Write to qcow backend: %d + %d\n", (int)sector_num, nb_sectors));
-    ret = bdrv_co_pwrite(s->qcow, sector_num * BDRV_SECTOR_SIZE,
-                         nb_sectors * BDRV_SECTOR_SIZE, buf, 0);
+    ret = bdrv_co_pwrite(s->qcow, sector_num * VVFAT_SECTOR_SIZE,
+                         nb_sectors * VVFAT_SECTOR_SIZE, buf, 0);
     if (ret < 0) {
         fprintf(stderr, "Error writing to qcow backend\n");
         return ret;
@@ -3124,12 +3137,12 @@ vvfat_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
 {
     int ret;
     BDRVVVFATState *s = bs->opaque;
-    uint64_t sector_num = offset >> BDRV_SECTOR_BITS;
-    int nb_sectors = bytes >> BDRV_SECTOR_BITS;
+    uint64_t sector_num = offset >> VVFAT_SECTOR_BITS;
+    int nb_sectors = bytes >> VVFAT_SECTOR_BITS;
     void *buf;
 
-    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(offset, VVFAT_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, VVFAT_SECTOR_SIZE));
 
     buf = g_try_malloc(bytes);
     if (bytes && buf == NULL) {
@@ -3195,7 +3208,7 @@ static int enable_write_target(BlockDriverState *bs, Error **errp)
 
     opts = qemu_opts_create(bdrv_qcow->create_opts, NULL, 0, &error_abort);
     qemu_opt_set_number(opts, BLOCK_OPT_SIZE,
-                        bs->total_sectors * BDRV_SECTOR_SIZE, &error_abort);
+                        bs->total_sectors * VVFAT_SECTOR_SIZE, &error_abort);
     qemu_opt_set(opts, BLOCK_OPT_BACKING_FILE, "fat:", &error_abort);
 
     ret = bdrv_create(bdrv_qcow, s->qcow_filename, opts, errp);
-- 
2.43.0


