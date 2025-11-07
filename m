Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B86CCFA18
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 14:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHNqO-0003Z8-U5; Fri, 07 Nov 2025 09:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vHNqM-0003To-MO
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:53:39 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vHNqK-0001uk-Aa
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:53:38 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-429b7eecf7cso616320f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 06:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1762527213; x=1763132013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NgRV3D7A6AU7eoGPkfrJPq4UVKzASaP5OU2HV5V5XwY=;
 b=MzAChgCbhm8idL0k5WIWQHcq52R5Pq4rLEpXJVuYi2ApCI3bQnrPl7nuB7+f+a3ohN
 xrblK1x30ShjOpy+VMqxdbrx7TENRkvySkCChuq/E8K5Hmyj6DnIgu8NqPNeqk0BuNrT
 RQjX4tkqiZWAUoZWZReA3DKUo1zf5NhGPPDuHVcenA/Xc4MRMOEovRs0gagbiJceQimV
 7uGt2od57Fi45lxR9oDJ6NQ30+VgTX7iHxkZxbHfylXX38IL9p3FLtWNkS2Wav706NBb
 OGcqW3/NXvG6oPn/5kF+wC4NYTI3yLCJnaaB6BpMcd33jW0lEV2lzb+3T14XELOXPN7s
 3CHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762527213; x=1763132013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NgRV3D7A6AU7eoGPkfrJPq4UVKzASaP5OU2HV5V5XwY=;
 b=Fof99qBelkgN72k8zuBx3KOEo8Yy7NigGE558MHeVWE20FkAISZHt3gSbRVzXByKzU
 353aleC+Rf5F8hcRNdIJkEu1qK0r4pxl0C5gWl2BiFdTWco1JBvOiUhYvtJoEZ4DO4Aw
 mFdnRKP7g4LYQL1n9w3q0rClChe4Rq1/0Gx0jDZqqZ8AH9iYiDfKMe1CZrhnK53IQWMf
 E17jh2DLjTTLY2bLoVACgDkad+82nIFUW/cMZ5WhZDxBcTlQvcoKegmAWTJWAozEEqsn
 jq8HkVNdA3wmYoQwrdf1AgR2OpYlWZwuyc0kUT1whv3G+c+pco4CjoKrEuJuytV1hgib
 Pk0Q==
X-Gm-Message-State: AOJu0YyC1Likl2vDH78Z0a3hqdw46hAtICunbNHc/X3MUyeNVtbBjoM2
 O0kqEg8AVkD7ksglIsSw4/7LJzPVEsrFeXeiwY4jpS9ZFtPBh8xRDSi1REwlP594mw==
X-Gm-Gg: ASbGncuJ+XMpp20TuaRTfkF+zb984p7v5lOYzE9+oeCx886+c9uaUD9mj7wes95S25N
 2IyXDyZSOJvcw2jzoFQOWf4TSLug9Uo3VcpDq6gNcrFnyC/htNEJ+/w7OD2hhOH3x9oXjkFFYG1
 xu6PQLajKfuKrv/FYZ9a1SoDzY6c7Lu4yX2c7jvI8vx1j7mCaCk0C0ltk29lWOL62jxt295W3pD
 IM1ioVLS23KiLSaRC9pftFQ+UcPAkQCyWKlcmdbJaVkz9QqXSQCJxV/LuLWRyOESBD1NhTH13Bp
 GMnt4ybHr+xQufe/t4yzVtXGyRMzdYBT1y2PL/6fG+8I/9wJR8M9U8RWM4MQBZ4dHvfv8o5S0ry
 ldl2GKS1U3vvOKsAzajQdMqtwMxL5l24nUReGfUpHHe4s7AcgEsGHK9D5OK3lM8SC+bBVSKuFWD
 1QMZFrWBU=
X-Google-Smtp-Source: AGHT+IE9lrmPZkbZj+aG13ojPgDeArQzWU0HveRwgo8YI6t+ocODNiDJQTZqUO9jvYS6iotXoOQQ4w==
X-Received: by 2002:a5d:5f83:0:b0:429:c6ba:d94e with SMTP id
 ffacd0b85a97d-42b26f689c6mr2243709f8f.12.1762527213269; 
 Fri, 07 Nov 2025 06:53:33 -0800 (PST)
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
Subject: [PATCH v2 4/5] vvfat: move size parameters within driver structure
Date: Fri,  7 Nov 2025 15:53:26 +0100
Message-ID: <20251107145327.539481-5-chigot@adacore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107145327.539481-1-chigot@adacore.com>
References: <20251107145327.539481-1-chigot@adacore.com>
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

At the same time, rename them to match bootsector fields.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 block/vvfat.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 1c51dfa561..b0e591e35e 100644
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
 
@@ -1154,7 +1156,6 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
                       Error **errp)
 {
     BDRVVVFATState *s = bs->opaque;
-    int cyls, heads, secs;
     bool floppy;
     const char *dirname, *label;
     QemuOpts *opts;
@@ -1221,18 +1222,18 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 
     if (floppy) {
         /* Choose floppy size. 1440 KiB for FAT 12, 2880 KiB for FAT-16 */
-        secs = s->fat_type == 12 ? 18 : 36;
-        cyls = 80;
-        heads = 2;
+        s->sectors_per_track = s->fat_type == 12 ? 18 : 36;
+        s->cylinders = 80;
+        s->number_of_heads = 2;
     } else {
         /* Reserver space for MBR */
         if (qemu_opt_get_bool(opts, "partitioned", true)) {
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
 
 
@@ -1249,10 +1250,13 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -1273,7 +1277,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    if (init_directories(s, dirname, heads, secs, errp)) {
+    if (init_directories(s, dirname, errp)) {
         ret = -EIO;
         goto fail;
     }
@@ -1294,7 +1298,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     if (s->offset_to_bootsector > 0) {
-        init_mbr(s, cyls, heads, secs);
+        init_mbr(s);
     }
 
     qemu_co_mutex_init(&s->lock);
-- 
2.43.0


