Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F51FCFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 14:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOcvC-0005uw-81; Thu, 27 Nov 2025 09:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vOcv8-0005ia-6g
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:24:30 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vOcv6-0006nB-Gu
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:24:29 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42b32900c8bso634689f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 06:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1764253467; x=1764858267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UyvHnJ6oHl1zC+JyET4uSk+rALdJgL29skdh/h9NP3I=;
 b=Zl8FKdEfo5KbgAsrHbJ4WCsTA62D2+u4IxA/7P3FTz7CwvQUDd1Srk/qMckjVVEiDX
 ZOKv58D8xjMyJXZixoZYwH65bfZoa78qBcB67CSbwXgnI7V3ZFVX88fDHTtvDGclipKY
 seCIB8A6Re+cAY6ZPXqHs9/URoUGACMAVu5sebXAYEbB00vEDePlTQyfoVGSBgk3C6bX
 cV8HG0OPCrR/lYTLlByUlpd03XM78NEz7Y9K0AKIOyTlxSxiMPy6q3kHUnW1QZHL9cfe
 6NMPMAgHUqfI0EXnQ5kLjAOtHNGvkKwJMCnva1YK/eKf7fPmZY+kKQ6a9ETaY8639LrF
 DO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764253467; x=1764858267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UyvHnJ6oHl1zC+JyET4uSk+rALdJgL29skdh/h9NP3I=;
 b=Biw4aXGMqfMTmXSP8DadKFfIUCryJvcpOMjWy2wn314d422czcDS5NBorSurmFVYJy
 UwEC51GE/c/o3EOb0m1uExVj6e7nb4QFA3nUe0njxlwwqKIcyeQGMNSRvabf9gIyhME1
 t60TtqLirPOvQOQbc6+8Z0W6gs60p0j03rv1/tNKYWIVRQU1MxVdkltr9wJs1s9zF/dR
 ElZnT7TphpVqwyy6NWmkwz+NH7vZFiLFAAUubza7igE1tcJ/22E3s2HsukZ8TUdyjJIc
 MfvT6Kx1kP36nosZ5xv0t61Bmq9DFu+xH69JoyJ5djr3M3Hgqk9iCNxY1MTF/6ChaMg5
 hpdA==
X-Gm-Message-State: AOJu0YwxljSUwqndvbWpStnMF8e1dxtwP/xXZZwqTILnwI7NhZXltQ1V
 7FbhmfkD9uSBPL9PBZ+z7ecazZtCYA1uniaFnjD5y3JJzTUrJ4+E/guDqKGo35Q26w==
X-Gm-Gg: ASbGncvQsuIDZ+dNysxr2Jf1CMFGVZUM//ROGddy4QWcIr8iuZQyZDsvQ5lNbHFS/S2
 S5RD19wSFjcBDtm9S9fpQINUUcwIZJcX8NJaSTP7UV2FCnu5zF7S2dtZ42HCf5AtvOGxqxsnuFW
 Cco9E9F9KQS4sC9Z71Teioo2zlClKQRX2AXu0baFhKSogRkizAqQd8Q/FHIFG1XXZyT0j+aIZ4a
 0l6IaF2T1yhlvuS1toyt10uH+Cit1Ckb1xwpoQNoXMcdwC9aDBst/P+sUpxW2vPnYYZYM0buEUQ
 XvbHScrtoXtXlD5/oexTm0vbYTFcq/mqMkWf9BxMtO58kxEgw71sijgrh4ArmWy9dA+hDh5MJF2
 99MBQM+cajuzhL57WeYmIFodS1hQFKhaa3zrIM8w6qKvcH2uOh/RFbiIwPvE1SrBiID/SwH+kYn
 K+RzBKmV5ed2yO
X-Google-Smtp-Source: AGHT+IFmPHyhy5tDE3OSx73cTtJYxk9DD0PBtSFTWar6LORVKYa6nVAX+6ZeL7tl3c8Ma0T4DWa+qw==
X-Received: by 2002:a05:6000:2681:b0:42b:4177:7139 with SMTP id
 ffacd0b85a97d-42cc1d520famr25070105f8f.46.1764253467029; 
 Thu, 27 Nov 2025 06:24:27 -0800 (PST)
Received: from chigot-Dell.. ([2a01:e0a:ca1:4970:e598:a2f0:7cc0:4392])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a2easm4148996f8f.23.2025.11.27.06.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 06:24:26 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v3 4/5] vvfat: move size parameters within driver structure
Date: Thu, 27 Nov 2025 15:24:16 +0100
Message-ID: <20251127142417.710094-5-chigot@adacore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127142417.710094-1-chigot@adacore.com>
References: <20251127142417.710094-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x42f.google.com
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

At the same time, rename them to match bootsector fields.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 block/vvfat.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 6b038067a2..4e698f1ca7 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -312,7 +312,10 @@ typedef struct BDRVVVFATState {
     /* 0x3f for partitioned disk, 0x0 otherwise */
     uint32_t offset_to_bootsector;
 
+    unsigned int cylinders;
     unsigned int cluster_size;
+    unsigned int number_of_heads;
+    unsigned int sectors_per_track;
     unsigned int sectors_per_cluster;
     unsigned int sectors_per_fat;
     uint32_t last_cluster_of_root_directory;
@@ -366,7 +369,7 @@ static int sector2CHS(mbr_chs_t *chs, int spos, int cyls, int heads, int secs)
     return 0;
 }
 
-static void init_mbr(BDRVVVFATState *s, int cyls, int heads, int secs)
+static void init_mbr(BDRVVVFATState *s)
 {
     /* TODO: if the files mbr.img and bootsect.img exist, use them */
     mbr_t* real_mbr=(mbr_t*)s->first_sectors;
@@ -382,9 +385,9 @@ static void init_mbr(BDRVVVFATState *s, int cyls, int heads, int secs)
 
     /* LBA is used when partition is outside the CHS geometry */
     lba  = sector2CHS(&partition->start_CHS, s->offset_to_bootsector,
-                     cyls, heads, secs);
+                      s->cylinders, s->number_of_heads, s->sectors_per_track);
     lba |= sector2CHS(&partition->end_CHS,   s->bs->total_sectors - 1,
-                     cyls, heads, secs);
+                      s->cylinders, s->number_of_heads, s->sectors_per_track);
 
     /*LBA partitions are identified only by start/length_sector_long not by CHS*/
     partition->start_sector_long  = cpu_to_le32(s->offset_to_bootsector);
@@ -896,8 +899,7 @@ static inline off_t cluster2sector(BDRVVVFATState* s, uint32_t cluster_num)
     return s->offset_to_root_dir + s->sectors_per_cluster * cluster_num;
 }
 
-static int init_directories(BDRVVVFATState* s,
-                            const char *dirname, int heads, int secs,
+static int init_directories(BDRVVVFATState *s, const char *dirname,
                             Error **errp)
 {
     bootsector_t* bootsector;
@@ -1031,8 +1033,8 @@ static int init_directories(BDRVVVFATState* s,
     bootsector->media_type = (s->offset_to_bootsector > 0 ? 0xf8 : 0xf0);
     s->fat.pointer[0] = bootsector->media_type;
     bootsector->sectors_per_fat=cpu_to_le16(s->sectors_per_fat);
-    bootsector->sectors_per_track = cpu_to_le16(secs);
-    bootsector->number_of_heads = cpu_to_le16(heads);
+    bootsector->sectors_per_track = cpu_to_le16(s->sectors_per_track);
+    bootsector->number_of_heads = cpu_to_le16(s->number_of_heads);
     bootsector->hidden_sectors = cpu_to_le32(s->offset_to_bootsector);
     bootsector->total_sectors=cpu_to_le32(s->sector_count>0xffff?s->sector_count:0);
 
@@ -1147,7 +1149,6 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
                       Error **errp)
 {
     BDRVVVFATState *s = bs->opaque;
-    int cyls, heads, secs;
     bool floppy, partitioned;
     const char *dirname, *label;
     QemuOpts *opts;
@@ -1218,14 +1219,14 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 
     if (floppy) {
         /* Choose floppy size. 1440 KiB for FAT 12, 2880 KiB for FAT-16 */
-        secs = s->fat_type == 12 ? 18 : 36;
-        cyls = 80;
-        heads = 2;
+        s->sectors_per_track = s->fat_type == 12 ? 18 : 36;
+        s->cylinders = 80;
+        s->number_of_heads = 2;
     } else {
         /* 32MB or 504MB disk*/
-        cyls = s->fat_type == 12 ? 64 : 1024;
-        heads = 16;
-        secs = 63;
+        s->cylinders = s->fat_type == 12 ? 64 : 1024;
+        s->number_of_heads = 16;
+        s->sectors_per_track = 63;
     }
 
     /* Reserver space for MBR */
@@ -1246,10 +1247,13 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
     s->downcase_short_names = 1;
 
     DLOG(fprintf(stderr, "vvfat %s chs %d,%d,%d\n",
-                 dirname, cyls, heads, secs));
+                 dirname, s->cylinders, s->number_of_heads,
+                 s->sectors_per_track));
 
-    s->sector_count = cyls * heads * secs - s->offset_to_bootsector;
-    bs->total_sectors = cyls * heads * secs;
+    s->sector_count = s->cylinders * s->number_of_heads *
+        s->sectors_per_track - s->offset_to_bootsector;
+    bs->total_sectors = s->cylinders * s->number_of_heads *
+        s->sectors_per_track;
 
     if (qemu_opt_get_bool(opts, "rw", false)) {
         if (!bdrv_is_read_only(bs)) {
@@ -1270,7 +1274,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    if (init_directories(s, dirname, heads, secs, errp)) {
+    if (init_directories(s, dirname, errp)) {
         ret = -EIO;
         goto fail;
     }
@@ -1291,7 +1295,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     if (s->offset_to_bootsector > 0) {
-        init_mbr(s, cyls, heads, secs);
+        init_mbr(s);
     }
 
     qemu_co_mutex_init(&s->lock);
-- 
2.43.0


