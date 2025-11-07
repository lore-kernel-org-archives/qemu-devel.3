Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE2CCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 14:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHNqO-0003YP-G8; Fri, 07 Nov 2025 09:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vHNqL-0003SW-3C
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:53:37 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vHNqH-0001uY-VR
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:53:36 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47109187c32so4081725e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 06:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1762527212; x=1763132012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnnIZZzxrg/0dXW75jADfy3TeL2WXsF9KtnuDUVrdxk=;
 b=MH+2EthPfK/Gpb2I8Ff27CMdwuV1YZqvpBNLeAl4TdvYwcACqFH3VOny3RgN6JnlPc
 yJGEQhGutXZQc3mIAPK3KwoWCBhloKog/ykD3V9hjBb+r5aHbdgJH8fyHo9un0kdiUD4
 3oyA/knSHzgvTPuQGboJqlwQKdGQoNTzhP1ohGIHUd3m6HiO7qwUafqOWN+4VTBl5MTG
 uAvSEr8peVcb7breAZCioQ1I/JRutl5gfDhso98G7wOHAEvCXmlNZoZLhidKi8C6uxWa
 Fdzo3ARA7AzaEiqiTfpN9hMW9WZ6M2uCsw9v9CltKmdovIzk7m9sW4ho7DxrGH0Thcd3
 VGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762527212; x=1763132012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gnnIZZzxrg/0dXW75jADfy3TeL2WXsF9KtnuDUVrdxk=;
 b=QfQ4W7GoEeTqOoAjgs6YGt+V2qYq9BqHoWV4eHVv/JF+/IDdiz3nOM6n3A7tYo7Kqw
 I95Q6FD62ErYMnj130+zXCqjfkcpGED+7dfon7jqQZYHdgDisVEeUAQK1NnLe+SQFP2B
 2cAcH38gCtHbntxZ4yMAzyKJgWLrI0aNx8zHeE6iYo9p4BIL3EyTPJJ53UpYRxJF9w1K
 bOLk67t0ids3b7l3TLyfKI1VAJC5UIPiHsABIXJX0JKKC4dCLPGxW4Aw5sd3mEvwMS8z
 6Su6ulWoTVufniItVRkGWn3z3VAQ145OcryjGqFS9vInFo0ZhuphrtCAJtK+O5YGNNu2
 /zyg==
X-Gm-Message-State: AOJu0YyC5+UqF5bmPiogds1xUHNm0JOdiKq//jAfH/dyXvwEZOR8B243
 SG9qqhjBDAeAQ4pkujlH9wL0b3rohkvZnL5INQgMLsbh6Mw6ZQoGXB91EOubeZVB0A==
X-Gm-Gg: ASbGncu0hhRlzr6z41pIC48/+3ysCUrnSbE2CryQGQtt1lw+emrb1no/A3fu28rkbyZ
 c51ecTk/1jpt7nSVhGzSAYMD1RnfDJ/ZKcx6gh/MsXMNSxJonC8DvEPqgDR6HoAqeSGxgJS/5tq
 eBMd90mXIi6eGhW02KgWWrv255kLtVJqvpiXhFrzXCiKcCzpxO9Zflgu56FNTDZJ4lMfppCnXAh
 ZlkHARNOrWWxqIdsymKA2xAUuNnCUQX7rYG2be7dvzQZz3L/edKwboNQScN2i8zS4ysRazaarFf
 8s1dW+awbJqVPbxWAvA7rZDwuhUGeu62Wn7OJc6duTQjhG+fGXjNiIqffwW0kyCOIrx371bZbFT
 +zwxVEU8Yq7X5bpm5SbsgenQDhsv7/QEAacrE9e2U57WH1D8K7nVV0wXlRXEhhmvxtNoeK5p7mz
 ncptEQkRM=
X-Google-Smtp-Source: AGHT+IEpcXszXx+2TG4UQZDOYkXVl7MsuvP3Jc0YE5nIAU7Oqtwr/EfdNU300Y011Frkd5R2N2gT5g==
X-Received: by 2002:a05:600c:45c3:b0:477:259c:dbd7 with SMTP id
 5b1f17b1804b1-4776bc92cf8mr28094225e9.12.1762527212449; 
 Fri, 07 Nov 2025 06:53:32 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:80db:7c00:e453:acd:db85:b66e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe63e131sm5922435f8f.20.2025.11.07.06.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:53:32 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 3/5] vvfat: add a define for VVFAT_SECTOR_BITS and
 VVFAT_SECTOR_SIZE
Date: Fri,  7 Nov 2025 15:53:25 +0100
Message-ID: <20251107145327.539481-4-chigot@adacore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107145327.539481-1-chigot@adacore.com>
References: <20251107145327.539481-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32a.google.com
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
index d8c8d44f16..1c51dfa561 100644
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
@@ -1313,7 +1317,7 @@ fail:
 
 static void vvfat_refresh_limits(BlockDriverState *bs, Error **errp)
 {
-    bs->bl.request_alignment = BDRV_SECTOR_SIZE; /* No sub-sector I/O */
+    bs->bl.request_alignment = VVFAT_SECTOR_SIZE; /* No sub-sector I/O */
 }
 
 static inline void vvfat_close_current_file(BDRVVVFATState *s)
@@ -1499,21 +1503,23 @@ vvfat_read(BlockDriverState *bs, int64_t sector_num, uint8_t *buf, int nb_sector
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
@@ -1521,19 +1527,20 @@ vvfat_read(BlockDriverState *bs, int64_t sector_num, uint8_t *buf, int nb_sector
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
@@ -1541,10 +1548,12 @@ vvfat_read(BlockDriverState *bs, int64_t sector_num, uint8_t *buf, int nb_sector
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
@@ -1556,12 +1565,12 @@ vvfat_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
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
@@ -1827,8 +1836,8 @@ cluster_was_modified(BDRVVVFATState *s, uint32_t cluster_num)
     for (i = 0; !was_modified && i < s->sectors_per_cluster; i++) {
         was_modified = bdrv_co_is_allocated(s->qcow->bs,
                                             (cluster2sector(s, cluster_num) +
-                                             i) * BDRV_SECTOR_SIZE,
-                                            BDRV_SECTOR_SIZE, NULL);
+                                             i) * VVFAT_SECTOR_SIZE,
+                                            VVFAT_SECTOR_SIZE, NULL);
     }
 
     /*
@@ -1982,8 +1991,8 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
                     int res;
 
                     res = bdrv_co_is_allocated(s->qcow->bs,
-                                               (offs + i) * BDRV_SECTOR_SIZE,
-                                               BDRV_SECTOR_SIZE, NULL);
+                                               (offs + i) * VVFAT_SECTOR_SIZE,
+                                               VVFAT_SECTOR_SIZE, NULL);
                     if (res < 0) {
                         return -1;
                     }
@@ -1992,9 +2001,9 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
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
@@ -2172,7 +2181,7 @@ DLOG(checkpoint());
      * - if all is fine, return number of used clusters
      */
     if (s->fat2 == NULL) {
-        int size = 0x200 * s->sectors_per_fat;
+        int size = VVFAT_SECTOR_SIZE * s->sectors_per_fat;
         s->fat2 = g_malloc(size);
         memcpy(s->fat2, s->fat.pointer, size);
     }
@@ -2569,7 +2578,8 @@ commit_one_file(BDRVVVFATState* s, int dir_index, uint32_t offset)
                 (size > offset && c >=2 && !fat_eof(s, c)));
 
         ret = vvfat_read(s->bs, cluster2sector(s, c),
-            (uint8_t*)cluster, DIV_ROUND_UP(rest_size, 0x200));
+                         (uint8_t *)cluster,
+                         DIV_ROUND_UP(rest_size, VVFAT_SECTOR_SIZE));
 
         if (ret < 0) {
             qemu_close(fd);
@@ -2948,7 +2958,7 @@ static int coroutine_fn GRAPH_RDLOCK do_commit(BDRVVVFATState* s)
     }
 
     /* copy FAT (with bdrv_pread) */
-    memcpy(s->fat.pointer, s->fat2, 0x200 * s->sectors_per_fat);
+    memcpy(s->fat.pointer, s->fat2, VVFAT_SECTOR_SIZE * s->sectors_per_fat);
 
     /* recurse direntries from root (using bs->bdrv_pread) */
     ret = commit_direntries(s, 0, -1);
@@ -3012,14 +3022,15 @@ DLOG(checkpoint());
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
@@ -3074,7 +3085,9 @@ DLOG(checkpoint());
                     end = sector_num + nb_sectors;
                 dir_index  = mapping->dir_index +
                     0x10 * (begin - mapping->begin * s->sectors_per_cluster);
-                direntries = (direntry_t*)(buf + 0x200 * (begin - sector_num));
+                direntries =
+                    (direntry_t *)(buf + VVFAT_SECTOR_SIZE
+                                   * (begin - sector_num));
 
                 for (k = 0; k < (end - begin) * 0x10; k++) {
                     /* no access to the direntry of a read-only file */
@@ -3100,8 +3113,8 @@ DLOG(checkpoint());
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
@@ -3127,12 +3140,12 @@ vvfat_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
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
@@ -3198,7 +3211,7 @@ static int enable_write_target(BlockDriverState *bs, Error **errp)
 
     opts = qemu_opts_create(bdrv_qcow->create_opts, NULL, 0, &error_abort);
     qemu_opt_set_number(opts, BLOCK_OPT_SIZE,
-                        bs->total_sectors * BDRV_SECTOR_SIZE, &error_abort);
+                        bs->total_sectors * VVFAT_SECTOR_SIZE, &error_abort);
     qemu_opt_set(opts, BLOCK_OPT_BACKING_FILE, "fat:", &error_abort);
 
     ret = bdrv_create(bdrv_qcow, s->qcow_filename, opts, errp);
-- 
2.43.0


