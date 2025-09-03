Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78D6CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 07:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utiNc-0006sm-3C; Wed, 03 Sep 2025 03:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1utiNK-0006h8-43
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:57:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1utiNG-0005N7-E9
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:57:49 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3d1bf79d7acso2298680f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 00:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1756886263; x=1757491063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKDt9NbbQt4YL2i2ghhzO4DBHVA7LMjZYIaUTZlT55U=;
 b=MoiIKnXoETPkKwjp/Z+DRaPf2FuteV+FrB682JpLlXcx3kwCtYmymkMG6+l/r/2b1K
 i9ocEfiBceNgieob4LcfeXLZQAg6QB9F6ZkC3ZcjHS1o9vfLoIrf8HBHeH0/iSbxy8Mj
 H6mT9audAfZfadm9q03vNDZ/WHaktrJduxQIUed+F9Xnc0H7oSrv3NT5fzp3QDY1n/lu
 K7VvGXiyzPQ+f/i3kv/jW90QNb87LZ41RtmuVBd8qzF0YdYuXPkJh52ZedK5k69wLZeu
 TFWc/+ZGmfX8RkLNJo/ZtvQL6y1GhzP686iUYmMgGz9v+/2Pi/K+vGMAc3fqUc05Tzfe
 UaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756886263; x=1757491063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LKDt9NbbQt4YL2i2ghhzO4DBHVA7LMjZYIaUTZlT55U=;
 b=iZESc0mzNA0vElIzezmZhdQfUYK6g/VgrVt1fc3FEAITq2RlRmwzGJen90uZyB8Q0k
 J12yrPrN1R9WJXu/uGdhZaN1sBx+4Ueh87sbOEUh3CriVHiPT+5QvrMXGawAHwn2pPoa
 XIQL75Fcarp+HefIiq6JdAT5LBEXtfkUueQHU5lG7gaFV0c/fmhQ4OQHSg+Xh1yp/vi2
 GsXx60Rf0XEF2z1mzcHNJ8zfALR+iRoaKq96ATfL9PjiJKYTOgN5PKABtPyVP27EaDUb
 DaDpB27tKFYx4QTB8C6wwB2CPMT+E1Uq0+UUw32kffU2fr4RNzKj3xggmHbgxh4PecGY
 bdOQ==
X-Gm-Message-State: AOJu0YysMmn2w2BQminb5e88o2IpH9NTrbU6vg7KJbKz1GfvJIfreXkP
 3bAydPUJK1k9AS0MxAoOErIZf7Nk4E3S6aMGg6IXbJCjJzNTm5lmhYKAapYSGxbcM1kPFBi6oA4
 Rp1U=
X-Gm-Gg: ASbGncv5FORqTapSTVGycVB90wYWCqwXWWQjETaOl+eQADQ7vUlm6CjAmKL5NKXmUg8
 wujbZcTEBnLMV5lumuZlSkZ8CErY3PcG71OSoRVgbbxBr6cMd2VaaMqcb/g9s/aoH3VOWh/lggq
 tIKAV1tORs+LVSuB0iCZAkvyRVtIEvE8HYK/qMQQbSwIRBaiqxx0zVwsF6XOXMGjvHQ0HByRjci
 CTx5y9tugwc+SMblRGut2H8aVfn28Dl3aT7N2jR9PVIZf7ZCmZZ5AuBW8BHeZL1umGiM8nxeov/
 MuhqZ1m+1oYV1A16mvSZuQlfmjL9+xqAQLhjZeJ5SOxof5+DTwKgm1Dn8VAvMK/mad5ijHEYm6c
 JgW3GlumN5fYDIfnM660O/3oZoX26KuYc9e2adaqVZQ==
X-Google-Smtp-Source: AGHT+IEhtyqWymREAN5C48vsH4ddzrdoo+5K6a4GShj3M7XfKLyMmdxw1qJc1G6ITMRodDyYlYjL1A==
X-Received: by 2002:a05:6000:420e:b0:3c9:f8a:f257 with SMTP id
 ffacd0b85a97d-3d1e05b5facmr11247699f8f.50.1756886262858; 
 Wed, 03 Sep 2025 00:57:42 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:80db:7c00:8880:8b9d:ac82:8ac6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7d2393sm227923335e9.3.2025.09.03.00.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 00:57:42 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 3/5] vvfat: add a define for SECTOR_SIZE
Date: Wed,  3 Sep 2025 09:57:19 +0200
Message-Id: <20250903075721.77623-4-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903075721.77623-1-chigot@adacore.com>
References: <20250903075721.77623-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This makes those 0x200 far clearer.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 block/vvfat.c | 60 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 91e4ad3158..6b6d158a18 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -75,6 +75,8 @@ static void checkpoint(void);
  */
 #define BOOTSECTOR_OEM_NAME "MSWIN4.1"
 
+#define SECTOR_SIZE 0x200
+
 #define DIR_DELETED 0xe5
 #define DIR_KANJI DIR_DELETED
 #define DIR_KANJI_FAKE 0x05
@@ -300,7 +302,7 @@ static void print_mapping(const struct mapping_t* mapping);
 typedef struct BDRVVVFATState {
     CoMutex lock;
     BlockDriverState* bs; /* pointer to parent */
-    unsigned char first_sectors[0x40*0x200];
+    unsigned char first_sectors[0x40 * SECTOR_SIZE];
 
     int fat_type; /* 16 or 32 */
     array_t fat,directory,mapping;
@@ -689,11 +691,11 @@ static inline void init_fat(BDRVVVFATState* s)
     if (s->fat_type == 12) {
         array_init(&(s->fat),1);
         array_ensure_allocated(&(s->fat),
-                s->sectors_per_fat * 0x200 * 3 / 2 - 1);
+                s->sectors_per_fat * SECTOR_SIZE * 3 / 2 - 1);
     } else {
         array_init(&(s->fat),(s->fat_type==32?4:2));
         array_ensure_allocated(&(s->fat),
-                s->sectors_per_fat * 0x200 / s->fat.item_size - 1);
+                s->sectors_per_fat * SECTOR_SIZE / s->fat.item_size - 1);
     }
     memset(s->fat.pointer,0,s->fat.size);
 
@@ -901,19 +903,19 @@ static int init_directories(BDRVVVFATState* s,
     unsigned int i;
     unsigned int cluster;
 
-    memset(&(s->first_sectors[0]),0,0x40*0x200);
+    memset(&(s->first_sectors[0]), 0 , 0x40 * SECTOR_SIZE);
 
-    s->cluster_size=s->sectors_per_cluster*0x200;
+    s->cluster_size = s->sectors_per_cluster * SECTOR_SIZE;
     s->cluster_buffer=g_malloc(s->cluster_size);
 
     /*
-     * The formula: sc = spf+1+spf*spc*(512*8/fat_type),
+     * The formula: sc = spf+1+spf*spc*(SECTOR_SIZE*8/fat_type),
      * where sc is sector_count,
      * spf is sectors_per_fat,
      * spc is sectors_per_clusters, and
      * fat_type = 12, 16 or 32.
      */
-    i = 1+s->sectors_per_cluster*0x200*8/s->fat_type;
+    i = 1 + s->sectors_per_cluster * SECTOR_SIZE * 8 / s->fat_type;
     s->sectors_per_fat=(s->sector_count+i)/i; /* round up */
 
     s->offset_to_fat = s->offset_to_bootsector + 1;
@@ -1011,12 +1013,12 @@ static int init_directories(BDRVVVFATState* s,
     s->current_mapping = NULL;
 
     bootsector = (bootsector_t *)(s->first_sectors
-                                  + s->offset_to_bootsector * 0x200);
+                                  + s->offset_to_bootsector * SECTOR_SIZE);
     bootsector->jump[0]=0xeb;
     bootsector->jump[1]=0x3e;
     bootsector->jump[2]=0x90;
     memcpy(bootsector->name, BOOTSECTOR_OEM_NAME, 8);
-    bootsector->sector_size=cpu_to_le16(0x200);
+    bootsector->sector_size = cpu_to_le16(SECTOR_SIZE);
     bootsector->sectors_per_cluster=s->sectors_per_cluster;
     bootsector->reserved_sectors=cpu_to_le16(1);
     bootsector->number_of_fats=0x2; /* number of FATs */
@@ -1513,7 +1515,7 @@ vvfat_read(BlockDriverState *bs, int64_t sector_num, uint8_t *buf, int nb_sector
                              " allocated\n", sector_num,
                              n >> BDRV_SECTOR_BITS));
                 if (bdrv_co_pread(s->qcow, sector_num * BDRV_SECTOR_SIZE, n,
-                                  buf + i * 0x200, 0) < 0) {
+                                  buf + i * SECTOR_SIZE, 0) < 0) {
                     return -1;
                 }
                 i += (n >> BDRV_SECTOR_BITS) - 1;
@@ -1525,19 +1527,19 @@ vvfat_read(BlockDriverState *bs, int64_t sector_num, uint8_t *buf, int nb_sector
         }
         if (sector_num < s->offset_to_root_dir) {
             if (sector_num < s->offset_to_fat) {
-                memcpy(buf + i * 0x200,
-                       &(s->first_sectors[sector_num * 0x200]),
-                       0x200);
+                memcpy(buf + i * SECTOR_SIZE,
+                       &(s->first_sectors[sector_num * SECTOR_SIZE]),
+                       SECTOR_SIZE);
             } else if (sector_num < s->offset_to_fat + s->sectors_per_fat) {
-                memcpy(buf + i * 0x200,
+                memcpy(buf + i * SECTOR_SIZE,
                        &(s->fat.pointer[(sector_num
-                                       - s->offset_to_fat) * 0x200]),
-                       0x200);
+                                       - s->offset_to_fat) * SECTOR_SIZE]),
+                       SECTOR_SIZE);
             } else if (sector_num < s->offset_to_root_dir) {
-                memcpy(buf + i * 0x200,
+                memcpy(buf + i * SECTOR_SIZE,
                        &(s->fat.pointer[(sector_num - s->offset_to_fat
-                                       - s->sectors_per_fat) * 0x200]),
-                       0x200);
+                                       - s->sectors_per_fat) * SECTOR_SIZE]),
+                       SECTOR_SIZE);
             }
         } else {
             uint32_t sector = sector_num - s->offset_to_root_dir,
@@ -1545,10 +1547,12 @@ vvfat_read(BlockDriverState *bs, int64_t sector_num, uint8_t *buf, int nb_sector
             cluster_num=sector/s->sectors_per_cluster;
             if(cluster_num > s->cluster_count || read_cluster(s, cluster_num) != 0) {
                 /* LATER TODO: strict: return -1; */
-                memset(buf+i*0x200,0,0x200);
+                memset(buf + i * SECTOR_SIZE, 0, SECTOR_SIZE);
                 continue;
             }
-            memcpy(buf+i*0x200,s->cluster+sector_offset_in_cluster*0x200,0x200);
+            memcpy(buf + i * SECTOR_SIZE,
+                   s->cluster + sector_offset_in_cluster * SECTOR_SIZE,
+                   SECTOR_SIZE);
         }
     }
     return 0;
@@ -2176,7 +2180,7 @@ DLOG(checkpoint());
      * - if all is fine, return number of used clusters
      */
     if (s->fat2 == NULL) {
-        int size = 0x200 * s->sectors_per_fat;
+        int size = SECTOR_SIZE * s->sectors_per_fat;
         s->fat2 = g_malloc(size);
         memcpy(s->fat2, s->fat.pointer, size);
     }
@@ -2573,7 +2577,8 @@ commit_one_file(BDRVVVFATState* s, int dir_index, uint32_t offset)
                 (size > offset && c >=2 && !fat_eof(s, c)));
 
         ret = vvfat_read(s->bs, cluster2sector(s, c),
-            (uint8_t*)cluster, DIV_ROUND_UP(rest_size, 0x200));
+                         (uint8_t *)cluster,
+                         DIV_ROUND_UP(rest_size, SECTOR_SIZE));
 
         if (ret < 0) {
             qemu_close(fd);
@@ -2952,7 +2957,7 @@ static int coroutine_fn GRAPH_RDLOCK do_commit(BDRVVVFATState* s)
     }
 
     /* copy FAT (with bdrv_pread) */
-    memcpy(s->fat.pointer, s->fat2, 0x200 * s->sectors_per_fat);
+    memcpy(s->fat.pointer, s->fat2, SECTOR_SIZE * s->sectors_per_fat);
 
     /* recurse direntries from root (using bs->bdrv_pread) */
     ret = commit_direntries(s, 0, -1);
@@ -3016,14 +3021,14 @@ DLOG(checkpoint());
          * used to mark volume dirtiness
          */
         unsigned char *bootsector = s->first_sectors
-                                    + s->offset_to_bootsector * 0x200;
+                                    + s->offset_to_bootsector * SECTOR_SIZE;
         /*
          * LATER TODO: if FAT32, this is wrong (see init_directories(),
          * which always creates a FAT16 bootsector)
          */
         const int reserved1_offset = offsetof(bootsector_t, u.fat16.reserved1);
 
-        for (i = 0; i < 0x200; i++) {
+        for (i = 0; i < SECTOR_SIZE; i++) {
             if (i != reserved1_offset && bootsector[i] != buf[i]) {
                 fprintf(stderr, "Tried to write to protected bootsector\n");
                 return -1;
@@ -3078,7 +3083,8 @@ DLOG(checkpoint());
                     end = sector_num + nb_sectors;
                 dir_index  = mapping->dir_index +
                     0x10 * (begin - mapping->begin * s->sectors_per_cluster);
-                direntries = (direntry_t*)(buf + 0x200 * (begin - sector_num));
+                direntries =
+                    (direntry_t *)(buf + SECTOR_SIZE * (begin - sector_num));
 
                 for (k = 0; k < (end - begin) * 0x10; k++) {
                     /* no access to the direntry of a read-only file */
-- 
2.34.1


