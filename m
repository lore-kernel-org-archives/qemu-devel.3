Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAD1CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 07:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utiNb-0006sC-6G; Wed, 03 Sep 2025 03:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1utiNI-0006gL-Jp
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:57:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1utiNG-0005N0-4O
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:57:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b8b8d45b3so28290915e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 00:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1756886262; x=1757491062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7mag5avFW+do0t0a1WlckVOJ6fYCC2t3DfnVJEOqkM=;
 b=VVHNG/O0zGlzDuRj+nnexINmujIJJaJFuHakLr4V5xPe5phBv8YHOMLBBJHpwZZvkf
 30wlVyRdjzx2YPql3UvvZeSaIEJx7GSGXwVgqhtKMMYw9uAZtP94yeJtI+7+ndz0h0z0
 dHAw2HCJpFNmztoM5XMwIhRPT++C4A69UM0/qIfoceOho4NRTvaSHiaOGjJSTnTU09/R
 r/B4hNcCNA/f7Qk9FfUGFqnQJvVjEu0DTfp627O6TMaLrB94pY3quFfE3mQLoBBg9MIr
 3f+981Clk1FTyryX9Zi5NKcu3kKv7wigg5rg8uoxdCChVGtPmygYOv8f064GT+f5vEf5
 TXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756886262; x=1757491062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c7mag5avFW+do0t0a1WlckVOJ6fYCC2t3DfnVJEOqkM=;
 b=kiME7m4RuMfs46Qk+pDVBziCj/29oegzM5D8ipXBeYi4UfD/uT+ooJiHAA62+npBdL
 uEO+S/RR9KC+zbj0R0JcvFvgGXkTW9h2azt3xVX6BN91q4p1n7Oy/tm3Z05jjFhg5ps8
 d3AfWtDuHv8LOsIrwljTdYCYD5QoaT/YtvBDSsJ642Cycy12LSap6CHW/gteT1CIb/UY
 /N8fh82Jbpy7q4QtyQQ+NBxwwm+oPaZFtKKqXHU98WzSUw9x3Z3crYkOYvpFJxfRLvCa
 CmWefymHmNTXVBqTqaBQJsPOmhc86pNeLXLdYy5SwFARi2NOl9V2Ql5P5lTUDFaCTEvt
 YYhQ==
X-Gm-Message-State: AOJu0YzlMllXVvUpJfPP2fAdH0f3HDdW4CGoVbGQrZxUuPCrjmJg2bpR
 Vfo0z4GYKgHWuw6INtABPIeEGyVowHe87fdwka9TSG+XuxUwV5Nvi0zfOjpdzyAYaWZB58YSn+h
 n9EA=
X-Gm-Gg: ASbGncvYN8SIByY88YHBtgPMzJqYbwKSpfuSbqlezQyeskC/zr1Oca+nm9HCeWy3oZt
 QIS6hEU+Q8OnurJCLVKp+QWih8lakPeGpbYNgblwMel/dbkbjFBjWiYK0M544C4TWKee4EBIv9J
 NmPaROLbSlOs62HCpZlkS1Q1FL4ZIUlpzqrN8w+pmLM28Ld6NPgPX52NXmLs1BiBwN3Nzkf03Ez
 BMZX938OCwSPby2FqApCaqfTjOUvIXcl5MCv3evJfPZh7m11u77fD5bGO6OikXuav2ytweqDmSa
 qbMk+ZbBDCtTyKz91lnX0cDEt3ciwGYac8lVINoo6IgfQYsvOV/IRDh4KsVq1xzFOyfIGRWPjqG
 6oN3qs9SFljer2h01et5kprA0p3ooOVAo6mxNWC4NouS8QE7yEUOn
X-Google-Smtp-Source: AGHT+IHymHFqVyEXL2NfEOtxTjsRdjNonDf9Ojrc+0nCM67ZpQJyVaxCKkBp6DBE6Ox0NAvr9Crg/w==
X-Received: by 2002:a05:600c:4f8f:b0:456:f1e:205c with SMTP id
 5b1f17b1804b1-45b85550704mr117013025e9.4.1756886262282; 
 Wed, 03 Sep 2025 00:57:42 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:80db:7c00:8880:8b9d:ac82:8ac6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7d2393sm227923335e9.3.2025.09.03.00.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 00:57:42 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 2/5] vvfat: move fat_type check prior to size setup
Date: Wed,  3 Sep 2025 09:57:18 +0200
Message-Id: <20250903075721.77623-3-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903075721.77623-1-chigot@adacore.com>
References: <20250903075721.77623-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x329.google.com
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

This allows to handle the default FAT size in a single place and make the
following part taking care only about size parameters. It will be later
moved away in a specific function.

Setting a floppy disk of 1MB is no longer possible as it was a side
effect of passing "fat-type=12". To be precise there were three cases:
 - fat-type undefined (aka default): a fat12 2MB disk
 - fat-type=16: a fat16 2Mb disk
 - fat-type=12: a fat12 1Mb disk

Now, that fat-type undefined means fat-type=2, it's no longer possible
to make that size distinction. It will be added back a bit later,
through the size parameter.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 block/vvfat.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 0220dd828b..91e4ad3158 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1190,45 +1190,51 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         memcpy(s->volume_label, "QEMU VVFAT", 10);
     }
 
-    if (floppy) {
-        /* 1.44MB or 2.88MB floppy.  2.88MB can be FAT12 (default) or FAT16. */
-        if (!s->fat_type) {
+    /* Verify FAT type  */
+    switch (s->fat_type) {
+    case 32:
+        warn_report("FAT32 has not been tested. You are welcome to do so!");
+        break;
+    case 16:
+    case 12:
+        break;
+    case 0:
+        /* Set a default type */
+        if (floppy) {
             s->fat_type = 12;
+        } else {
+            s->fat_type = 16;
+        }
+        break;
+    default:
+        error_setg(errp, "Valid FAT types are only 12, 16 and 32");
+        ret = -EINVAL;
+        goto fail;
+    }
+
+
+    if (floppy) {
+        /* 2.88MB floppy */
+        if (s->fat_type == 12) {
             secs = 36;
             s->sectors_per_cluster = 2;
         } else {
-            secs = s->fat_type == 12 ? 18 : 36;
+            secs = 36;
             s->sectors_per_cluster = 1;
         }
         cyls = 80;
         heads = 2;
     } else {
-        /* 32MB or 504MB disk*/
-        if (!s->fat_type) {
-            s->fat_type = 16;
-        }
         /* Reserver space for MBR */
         if (!qemu_opt_get_bool(opts, "no-mbr", false)) {
             s->offset_to_bootsector = 0x3f;
         }
+        /* 32MB or 504MB disk*/
         cyls = s->fat_type == 12 ? 64 : 1024;
         heads = 16;
         secs = 63;
     }
 
-    switch (s->fat_type) {
-    case 32:
-        warn_report("FAT32 has not been tested. You are welcome to do so!");
-        break;
-    case 16:
-    case 12:
-        break;
-    default:
-        error_setg(errp, "Valid FAT types are only 12, 16 and 32");
-        ret = -EINVAL;
-        goto fail;
-    }
-
 
     s->bs = bs;
 
-- 
2.34.1


