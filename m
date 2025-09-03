Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E211ACA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 07:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utiNd-0006uK-9P; Wed, 03 Sep 2025 03:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1utiNI-0006gU-Rm
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:57:49 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1utiNG-0005NE-4V
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:57:48 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45cb6d8f42cso780205e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1756886263; x=1757491063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MvWn5d6XqQ+RCyxskwcO5xPTfuSIuv1nwogU1KNBQ8=;
 b=GtGpTbhBma1nDwEoo2k83CnUOld89RjZv8DLxRLCB6EvXmlnYN0ZY8nmePvSJgAszN
 JDZTDEysrqaP0n8RJumb+3Ppr1nT1QNOjh8DeHEdrWLG4NSwrhCjQmpZ+oFdTXVYCfRd
 x3WGVDgZSM7up2BNRSXVd5hSB42VJs7XdQdoeydUgXVr3oONVYKoOLFgBR9W3lS94G/p
 7TvxesNKf/L5GVWbLoO+G2K+ZwXY+5BfRddBx4PT/DtdBpsQ6pS3GDg49AMMFOaIKDp1
 lTLp0N1jndC3ngso1neI1qNCBdigw0oPLxXKfHixoDGdRwsv5LRt4U9mnLeu1AEpmOZd
 H3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756886263; x=1757491063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MvWn5d6XqQ+RCyxskwcO5xPTfuSIuv1nwogU1KNBQ8=;
 b=bHje9LB7Gy6Kpr/f2W3jZm20uu2LUQTLVINm3bD3MZLUD2wgwgGUykSFdjoJaqC1k5
 HU1PKNy6XQzxXBCJ1SoRFnVMx1cVYJ48E12a1/a1YiyAJM0qSzFSEx/+z4H8MAsMc5SG
 IexxosaBcEYTZBvPHDzLxgW90KmjcTvaE+4ty7q5qva08LD+K0rewvhqqn6fKiG23V3p
 dqe6TAmjqzdpLq8Wx6cYCfTvsjx2cEGHZnyr0pwx9OSR/lLbjmGvpV2n+aQIKOVHlyr7
 wpT8IVtFf3PhS4VE2S9gXz52GmFtwjNxWuqtspoMjeEne43N0eNvtLLomdlR230+Wmwi
 HI1A==
X-Gm-Message-State: AOJu0YwEBDQJhYxRgtj0GpDfyHAMFYowUi0WpTuStWgaCRj5UuZmTLXR
 ypY4sZJw7AgFla9PkX3Z5jpOmhwnt9iES5+2+4kGTBFMrcEnlQP9S2PeQZ2QCl8dZCmKJwZZA1E
 bdRc=
X-Gm-Gg: ASbGncvdMXPwDEdnl2QrgmBnly2n2q+MZsUlHUxlWjKda1RcjtfdWo3PSIuM/Fk3jFH
 l+d9F6QML2Otojp2uh5qpTvFfpM4EWE7sdNn8b4QUbqeAL5qLdxeZt4SFib0VJZ48UMqiXmPTbS
 huQVPsqD3ujvEQT5Gr7IcmdtC89tShPV6dQwQebr3NP+GFvNnuYkIc61baVd8dUasI4rWDM+Uo3
 7PYk+4inT+J1z8KzOr3v0Ks8OBZbMbgwk4QSbl68LLlaZw6tHHSz6C3mICUZe383SSJ815KUp4p
 F/ZFw2wjUhvy2VIPOk+3FlmNzvV9sRc5AVVY6NTjZz7je40yZq8wpWrDReVEd613DFwgPJy6xea
 HvmmmooSnqi9r44viM2BcVbJRl+L/Gc6DL6dLTmBNtQ==
X-Google-Smtp-Source: AGHT+IFBYg85jtegp+rgc85j74OZxoHz/h7YMsDcACMjB31tKBf9twDAaWdraEPqVlP+FccJHzysPg==
X-Received: by 2002:a05:600c:5486:b0:45b:8d2a:cd09 with SMTP id
 5b1f17b1804b1-45b9bd607a7mr31567385e9.13.1756886263393; 
 Wed, 03 Sep 2025 00:57:43 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:80db:7c00:8880:8b9d:ac82:8ac6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7d2393sm227923335e9.3.2025.09.03.00.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 00:57:43 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 4/5] vvfat: move size parameters within driver structure
Date: Wed,  3 Sep 2025 09:57:20 +0200
Message-Id: <20250903075721.77623-5-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903075721.77623-1-chigot@adacore.com>
References: <20250903075721.77623-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32b.google.com
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
 block/vvfat.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 6b6d158a18..6526c585a2 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -310,7 +310,10 @@ typedef struct BDRVVVFATState {
 
     uint32_t offset_to_bootsector; /* 0 for floppy, 0x3f for disk */
 
+    unsigned int cylinders;
     unsigned int cluster_size;
+    unsigned int number_of_heads;
+    unsigned int sectors_per_track;
     unsigned int sectors_per_cluster;
     unsigned int sectors_per_fat;
     uint32_t last_cluster_of_root_directory;
@@ -364,7 +367,7 @@ static int sector2CHS(mbr_chs_t *chs, int spos, int cyls, int heads, int secs)
     return 0;
 }
 
-static void init_mbr(BDRVVVFATState *s, int cyls, int heads, int secs)
+static void init_mbr(BDRVVVFATState *s)
 {
     /* TODO: if the files mbr.img and bootsect.img exist, use them */
     mbr_t* real_mbr=(mbr_t*)s->first_sectors;
@@ -380,9 +383,9 @@ static void init_mbr(BDRVVVFATState *s, int cyls, int heads, int secs)
 
     /* LBA is used when partition is outside the CHS geometry */
     lba  = sector2CHS(&partition->start_CHS, s->offset_to_bootsector,
-                     cyls, heads, secs);
+                      s->cylinders, s->number_of_heads, s->sectors_per_track);
     lba |= sector2CHS(&partition->end_CHS,   s->bs->total_sectors - 1,
-                     cyls, heads, secs);
+                      s->cylinders, s->number_of_heads, s->sectors_per_track);
 
     /*LBA partitions are identified only by start/length_sector_long not by CHS*/
     partition->start_sector_long  = cpu_to_le32(s->offset_to_bootsector);
@@ -894,8 +897,7 @@ static inline off_t cluster2sector(BDRVVVFATState* s, uint32_t cluster_num)
     return s->offset_to_root_dir + s->sectors_per_cluster * cluster_num;
 }
 
-static int init_directories(BDRVVVFATState* s,
-                            const char *dirname, int heads, int secs,
+static int init_directories(BDRVVVFATState *s, const char *dirname,
                             Error **errp)
 {
     bootsector_t* bootsector;
@@ -1028,8 +1030,8 @@ static int init_directories(BDRVVVFATState* s,
     bootsector->media_type = (s->offset_to_bootsector > 0 ? 0xf8 : 0xf0);
     s->fat.pointer[0] = bootsector->media_type;
     bootsector->sectors_per_fat=cpu_to_le16(s->sectors_per_fat);
-    bootsector->sectors_per_track = cpu_to_le16(secs);
-    bootsector->number_of_heads = cpu_to_le16(heads);
+    bootsector->sectors_per_track = cpu_to_le16(s->sectors_per_track);
+    bootsector->number_of_heads = cpu_to_le16(s->number_of_heads);
     bootsector->hidden_sectors = cpu_to_le32(s->offset_to_bootsector);
     bootsector->total_sectors=cpu_to_le32(s->sector_count>0xffff?s->sector_count:0);
 
@@ -1150,7 +1152,6 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
                       Error **errp)
 {
     BDRVVVFATState *s = bs->opaque;
-    int cyls, heads, secs;
     bool floppy;
     const char *dirname, *label;
     QemuOpts *opts;
@@ -1218,23 +1219,23 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
     if (floppy) {
         /* 2.88MB floppy */
         if (s->fat_type == 12) {
-            secs = 36;
+            s->sectors_per_track = 36;
             s->sectors_per_cluster = 2;
         } else {
-            secs = 36;
+            s->sectors_per_track = 36;
             s->sectors_per_cluster = 1;
         }
-        cyls = 80;
-        heads = 2;
+        s->cylinder = 80;
+        s->number_of_heads = 2;
     } else {
         /* Reserver space for MBR */
         if (!qemu_opt_get_bool(opts, "no-mbr", false)) {
             s->offset_to_bootsector = 0x3f;
         }
         /* 32MB or 504MB disk*/
-        cyls = s->fat_type == 12 ? 64 : 1024;
-        heads = 16;
-        secs = 63;
+        s->cylinders = s->fat_type == 12 ? 64 : 1024;
+        s->number_of_heads = 16;
+        s->sectors_per_track = 63;
     }
 
 
@@ -1251,10 +1252,13 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -1275,7 +1279,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    if (init_directories(s, dirname, heads, secs, errp)) {
+    if (init_directories(s, dirname, errp)) {
         ret = -EIO;
         goto fail;
     }
@@ -1296,7 +1300,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     if (s->offset_to_bootsector > 0) {
-        init_mbr(s, cyls, heads, secs);
+        init_mbr(s);
     }
 
     qemu_co_mutex_init(&s->lock);
-- 
2.34.1


