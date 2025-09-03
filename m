Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFF3CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 07:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utiNa-0006rd-Oe; Wed, 03 Sep 2025 03:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1utiNL-0006hg-JX
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:57:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1utiNG-0005NT-F1
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:57:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45cb5492350so3348185e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1756886264; x=1757491064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0exDSeWzfnLgVKcbfnAlGaanon91bsraDsnRd+gW7CM=;
 b=BnCiOrN4j5HIvJ9W1uEFzcQ6MVFDbwfEFWUhYB7t3X7HK2fZzPfDdE2Eh/N/BYxkII
 ZcIQ4vJbNeq6DVLdTbksxCiPUIJy3/SzUg73ZwUS/U3zs6dyVfQ6ol21CFZQBkiUFPUa
 USq2L/SMkc5Cg6N84IsI2zQDUNZVydU0K8vuFL2LRTs/buijQlNPtJPYLSGFMhYiR3K1
 lzV9wfdt69+Cy1OzSU7RH6qU5YLZ3pvWTYcUjcIlsYxvu4b95qMF+YNPdr4CLoHnLyyF
 wtqZ2DWTp+UfV6uUkrmOHjRvgPlAeNaas0rZJigKNidgnBsd7a4tSYVGT9hPdysLGOcA
 FERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756886264; x=1757491064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0exDSeWzfnLgVKcbfnAlGaanon91bsraDsnRd+gW7CM=;
 b=rzq1JHD6wAuslVg2Qv6WLeGhQvjVLNxAIpNTQDDwTSzNWzjii56KaI1SPDCGBLd2rv
 0rWUVXVPpl3nRXr+kt18TNyLueWytbH3BSnsCcyQR38bfNtQB8TqzZLtft1isqIx6uwB
 W3Tt/R+cG7hDqberfEeg/h1wdgjEX7mEhOuXkLHdA5bkJVZWc6zRfooTOya2DfteRRlm
 AvIB5mTPXJO+nYFQOvESNNMl44+D6to7gKRWzU4TntxHFQo17mqKk9Ev7tjcIi4OA5tz
 2nW3wnWLiTZ3Tfn9fSmXj4LDAGPnhBNwgUZPAZvLC1p6XXyaou/1dkFUpnmT7N07hJvt
 66Ew==
X-Gm-Message-State: AOJu0Yzr1Vhz95UTCq6GLTklPgDEWAf/lmRg1FAZjyeJl/kGg9ESEIcu
 G3BO8jGjaUqFt3gU1X2I3FyKrg0wXtKHKYdcm2xmAz71pJqWnAbjd40hQe7vIHKiDIkCgGyWnmU
 KvA4=
X-Gm-Gg: ASbGncviKzI1VW7W8h7zkZU4bS2yFvRfMfCqjI7E26QVTR6DZuNFaCBawyUv15SR7O/
 PZSvg/8/kjq4x5ChhVPjPyL1xTTzT/oro43PP+6dBdnaT2LO7aUK2vqR7n6mGSLGcE9T6U/7fTW
 79M6PKg3oCoDwc2Q09QtgoOBy5IDM3YT6L0lftnT/o+7lKpWMfro3vIOU5SeY0Wv5UwBWp2K0+l
 2vftGzIbwfEdKrS4OXft/HrAsrFrGU40PHo9ui+g5HjVny2DD10y/gwvGiepOyhpbvKGpu0lf8H
 q3U6h/7xTovLp/cUIQs2uU3zTbWTJ2B2O6WZPHgUAK/Sr4QS6UAUsvCigPcGdhCo+lFPNQM6LEM
 EiGQklXGScsTrzN2qy7STOQqsqCEzyoo=
X-Google-Smtp-Source: AGHT+IErEv0qDU489Hu7ZOCZJv4PlePD6KaMfwHaHZwiYi0ntQhBm0aMK6ixqK4kWZKTh/CgWzSgkQ==
X-Received: by 2002:a05:600c:4e88:b0:45c:b56c:4183 with SMTP id
 5b1f17b1804b1-45cb56c43d1mr11171535e9.18.1756886263987; 
 Wed, 03 Sep 2025 00:57:43 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:80db:7c00:8880:8b9d:ac82:8ac6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7d2393sm227923335e9.3.2025.09.03.00.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 00:57:43 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 5/5] vvfat: add support for "size" options
Date: Wed,  3 Sep 2025 09:57:21 +0200
Message-Id: <20250903075721.77623-6-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903075721.77623-1-chigot@adacore.com>
References: <20250903075721.77623-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32c.google.com
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

This allows more flexibility to vvfat backend. The value for "Number of
Heads" and "Sectors per track" are based on SD specifications Part 2.

Some limitations remains, the size parameter is recognized only when
"format=vvfat" is passed. In particular, "format=raw,size=xxx" is
keeping the previously hardcoded value: 504MB for FAT16 and 32 MB for
FAT12. FAT32 has not been adjusted and thus still default to 504MB.

Moreover, for flopyy, size=1M is creating a disk 1.44 MB, and size=2M a
disk of 2.88 MB. This avoids having to worry about float operations.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 block/vvfat.c | 165 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 141 insertions(+), 24 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 6526c585a2..4537c39d5c 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1091,6 +1091,11 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "Do not add a Master Boot Record on this disk",
         },
+        {
+            .name = BLOCK_OPT_SIZE,
+            .type = QEMU_OPT_SIZE,
+            .help = "Virtual disk size"
+        },
         { /* end of list */ }
     },
 };
@@ -1148,10 +1153,141 @@ static void vvfat_parse_filename(const char *filename, QDict *options,
     qdict_put_bool(options, "no-mbr", no_mbr);
 }
 
+static void vvfat_get_size_parameters(uint64_t size, BDRVVVFATState *s,
+                                      bool floppy, Error **errp)
+{
+    if (floppy) {
+        /*
+         * Floppy emulation only supports 1.44 MB or 2.88 MB (default).
+         * In order to avoid floating operations ambiguity, 1 MB is
+         * recognized for 1.44 MB and 2 MB for 2.88 MB.
+         */
+        if (!size) {
+            size = 2 * 1024 * 1024;
+        } else {
+            if (size == 1024 * 1024 && s->fat_type == 16) {
+                error_setg(errp,
+                           "floppy FAT16 unsupported size; only support 2M "
+                           "(for an effective size of 2.88 MB)");
+            } else if (size != 2 * 1024 * 1024 && size != 1024 * 1024) {
+                error_setg(errp,
+                           "floppy unsupported size; should be 1MB (for "
+                           "an effective size of 1.44 MB) or 2.88M (for "
+                           "2.88MB)");
+            }
+        }
+
+        if (s->fat_type == 12) {
+            if (size == 2 * 1024 * 1024) {
+                s->sectors_per_cluster = 2;
+            } else {
+                s->sectors_per_cluster = 1;
+            }
+        } else {
+            s->sectors_per_cluster = 1;
+        }
+
+        s->sectors_per_track = 36;
+        s->cylinders = 80;
+        s->number_of_heads = 2;
+    } else {
+        /* LATER TODO: if FAT32, adjust */
+        s->sectors_per_cluster = 0x10;
+
+        switch (s->fat_type) {
+        case 12:
+
+            /* Default is 32 MB */
+            if (!size) {
+                size = 32 * 1024 * 1024;
+            } else if (size > 32 * 1024 * 1024) {
+                error_setg(errp, "FAT12 unsupported size; higher than 32Mb");
+            }
+
+            s->cylinders = 64;
+
+            /*
+             * Based on CHS Recommandation table:
+             *  Card Capacity | Number of Headers | Sectors per track
+             *     ~ 2 MB     |         4         |       16
+             *     ~ 4 MB     |         8         |       16
+             *     ~ 8 MB     |        16         |       16
+             *     ~ 16 MB    |         2         |       32
+             *     ~ 32 MB    |         4         |       32
+             *
+             * For 2 MB, SD is recommending heads = 2 and sectors = 16, but
+             * this requires a different number of cylinders. Thus, it was
+             * adjusted to keep this number constant.
+             */
+            if (size <= 8 * 1024 * 1024) {
+                s->sectors_per_track = 16;
+            } else {
+                s->sectors_per_track = 32;
+            }
+
+            /*
+             * The formula between the size (in bytes) and the parameters are:
+             *  size = SECTOR_SIZE * sectors_per_track * number_of_headers *
+             *         cylinders
+             */
+            s->number_of_heads = size / s->sectors_per_track /
+                SECTOR_SIZE / s->cylinders;
+            return;
+
+        case 16:
+            /* Default is 504 MB */
+            if (!size) {
+                size = 504 * 1024 * 1024;
+            } else if (size / 1024 > 4 * 1024 * 1024) {
+                error_setg(errp, "FAT16 unsupported size; higher than 4Gb");
+            }
+
+            s->cylinders = 1024;
+
+            /*
+             * Based on CHS Recommandation table:
+             *  Card Capacity | Number of Headers | Sectors per track
+             *     ~64 MB     |         4         |       32
+             *     ~128 MB    |         8         |       32
+             *     ~256 MB    |        16         |       32
+             *     ~504 MB    |        16         |       63
+             *    ~1008 MB    |        32         |       63
+             *    ~2016 MB    |        64         |       63
+             */
+            if (size <= 256 * 1024 * 1024) {
+                s->sectors_per_track = 32;
+            } else {
+                s->sectors_per_track = 63;
+            }
+
+            /*
+             * The formula between the size (in bytes) and the parameters are:
+             *  size = SECTOR_SIZE * sectors_per_track * number_of_headers *
+             *         cylinders
+             */
+            s->number_of_heads = size / s->sectors_per_track /
+                SECTOR_SIZE / s->cylinders;
+            return;
+
+        case 32:
+            /* TODO FAT32 adjust  */
+            if (size) {
+                warn_report("size parameters not supported with FAT32;"
+                            "default to 504MB.");
+            }
+            s->cylinders = 1024;
+            s->number_of_heads = 16;
+            s->sectors_per_track = 63;
+            return;
+        }
+    }
+}
+
 static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
                       Error **errp)
 {
     BDRVVVFATState *s = bs->opaque;
+    uint64_t size;
     bool floppy;
     const char *dirname, *label;
     QemuOpts *opts;
@@ -1178,6 +1314,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->fat_type = qemu_opt_get_number(opts, "fat-type", 0);
     floppy = qemu_opt_get_bool(opts, "floppy", false);
+    size = qemu_opt_get_size_del(opts, "size", 0);
 
     memset(s->volume_label, ' ', sizeof(s->volume_label));
     label = qemu_opt_get(opts, "label");
@@ -1215,35 +1352,15 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    vvfat_get_size_parameters(size, s, floppy, errp);
 
-    if (floppy) {
-        /* 2.88MB floppy */
-        if (s->fat_type == 12) {
-            s->sectors_per_track = 36;
-            s->sectors_per_cluster = 2;
-        } else {
-            s->sectors_per_track = 36;
-            s->sectors_per_cluster = 1;
-        }
-        s->cylinder = 80;
-        s->number_of_heads = 2;
-    } else {
-        /* Reserver space for MBR */
-        if (!qemu_opt_get_bool(opts, "no-mbr", false)) {
-            s->offset_to_bootsector = 0x3f;
-        }
-        /* 32MB or 504MB disk*/
-        s->cylinders = s->fat_type == 12 ? 64 : 1024;
-        s->number_of_heads = 16;
-        s->sectors_per_track = 63;
+    /* Reserver space for MBR */
+    if (!floppy && !qemu_opt_get_bool(opts, "no-mbr", false)) {
+        s->offset_to_bootsector = 0x3f;
     }
 
-
     s->bs = bs;
 
-    /* LATER TODO: if FAT32, adjust */
-    s->sectors_per_cluster=0x10;
-
     s->current_cluster=0xffffffff;
 
     s->qcow = NULL;
-- 
2.34.1


