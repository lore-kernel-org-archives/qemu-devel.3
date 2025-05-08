Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FDDC3ABC3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 02:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCqnG-0002pK-8L; Wed, 07 May 2025 22:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uCqnE-0002os-K8; Wed, 07 May 2025 22:15:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uCqnC-0003i7-PI; Wed, 07 May 2025 22:15:24 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22e730c05ddso5165625ad.2; 
 Wed, 07 May 2025 19:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746670521; x=1747275321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6biUSIsPzsQyImSoRkB97aDVQZkOBWG2G0BZKEhAFWg=;
 b=nSfjoEM0dtRP0sAHBF5hMG8u9BtjpvoxAFR0CgUNDUpvgNNjheb/ANEgnx3WILLvi4
 l4jUTPxhftINd0/wa/z794Bh0RY3UjaDbOcLrApzUiddvf/qH0bc8BWBFk7edqdPgSSU
 DWtTpKiAlqzzAJf1Q9IKYFg7I3g9qyRHMyRbqHm5z4pCfBRteFHNGU7L/YGFsKPl9BsW
 55pXwGglUkokXg5AdL57sptmX8kAgc3ZW+ktHmDszDO7l0XOMQmj3zOvufwh0Ka/JsOt
 nFvZDdA2DI0URlURllzJZccIDwqn0clrsbuMzRKQlWnw8gYtwSECbE4j/MwvicsJpQvM
 /CKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746670521; x=1747275321;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6biUSIsPzsQyImSoRkB97aDVQZkOBWG2G0BZKEhAFWg=;
 b=EpH1VcRSBBkXG0MA2st7/j6XzbbLgKt3HdG2M0iRFzmyyJ/TpbzfUMvbG+4Rigte/t
 PckhmIra0ofYN8I6K756DHwPIbUCeAG+GM1mOQ2NkB60l4OH0otFC2NvJvXQl2xBVTeN
 NFzbCNXvkSYlsJUaX9u0Agg1+HFGkRQm+uHRcY/1KLsFNhcv+n1cL00pIKIy1nE6+tZ/
 77QPoeCUacLjIVv3xK/XQP29DuuzWtcWytsxmcENY+xKTN/OO8mQlD3ZluyDIt85H28Y
 X0OsJNA+HzAy2oqhzd6K38r0fLc6kpxYVkieGSJV4Md0DfrsFqorWV5MPnnX3GIihyaF
 n/MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxwdzdgx/NGI/gj9pM2Gwl7ahImMLXKka37TObz52lELQ05KSvknWDIB0jkscjMdZJSTew21qXL/SA@nongnu.org
X-Gm-Message-State: AOJu0YymVX8D5SPgIU/H2GYQVxOXhOgF2p+WuHtxOLGhrVrUY22EzT/8
 2e2eTQKKf+Hn+2q24OHYmE+cVGUj3i8af+bIPQ5H4ObWCcGDxs3y
X-Gm-Gg: ASbGncvIvQkQTANt3OH6A7qD1qkElr586OZIw4ATXVaFf1k5kxhmAJF0jaodshIEXtl
 0aAhMSWKSfQC6nz9DWD487RX6iOd8u4ItIye+5uOy5R2d/QtCEHQvu6Q43n+D8J44T2C3Qtyclq
 9ekne+m0l3E37s5OnNGNRSYmOnC3uExoeEmiyr+EK0pAvfzGzkNDyQCe1aNCsD112PtiwOHUJzs
 ksmrqw0kFUnuILxdMlyDR18DymjbAbq4yg5ArJObfaZ+pJyqfuMMFBtnE5z955KdMOIy3qb8VY5
 kts3etr2+W1g7aPAS2ZpO1lvkAYYdN1SUcvuLsfSfet4zob7QQCpSUskQYLKIEfFMMFcz1k91wD
 QIqVzqYjj
X-Google-Smtp-Source: AGHT+IG+Bd7a8HzndVSBce7zuzFUK/ybIJed1NXkiMwG0gGzt8Kja/JWbI5OVjG6Ym4cLwgSTKMMKg==
X-Received: by 2002:a17:902:f60e:b0:223:33cb:335f with SMTP id
 d9443c01a7336-22e8560cf20mr22737035ad.3.1746670520821; 
 Wed, 07 May 2025 19:15:20 -0700 (PDT)
Received: from hcdev-d520mt.. (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eae2asm101692795ad.39.2025.05.07.19.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 19:15:20 -0700 (PDT)
From: Tim Lee <timlee660101@gmail.com>
To: peter.maydell@linaro.org, wuhaotsh@google.com, kfting@nuvoton.com,
 chli30@nuvoton.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Tim Lee <timlee660101@gmail.com>
Subject: [v2] hw/arm/npcm8xx_boards: Add auto zero flash image and device part
 number
Date: Thu,  8 May 2025 10:15:10 +0800
Message-Id: <20250508021510.2959328-1-timlee660101@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=timlee660101@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Fix flash device part number to `mx66l1g45g` according image-bmc run on npcm8xx
evb board (SPIFlash...SF: Detected mx66l1g45g, total 128 MiB)

And add auto zero flash image size to resolve error below after executing
`./qemu-system-aarch64 -machine npcm845-evb -drive file=image-bmc`

Error message:
qemu-system-aarch64: mx66l1g45g device '/machine/unattached/device[73]'
requires 134217728 bytes, mtd0 block backend provides 67108864 bytes

Tested:
Build passes and runs ./qemu-system-aarch64 -machine npcm845-evb normally

Signed-off-by: Tim Lee <timlee660101@gmail.com>
---
Changes since v1:
- Add a statement that checks whether the storage is writable

 hw/arm/npcm8xx_boards.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 3fb8478e72..79295a586c 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -27,6 +27,7 @@
 #include "qemu/error-report.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "system/block-backend.h"
 
 #define NPCM845_EVB_POWER_ON_STRAPS 0x000017ff
 
@@ -59,10 +60,26 @@ static void npcm8xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
 {
     DeviceState *flash;
     qemu_irq flash_cs;
+    BlockBackend *blk;
+    BlockDriverState *bs;
+    uint64_t blk_size, perm, shared_perm;
 
     flash = qdev_new(flash_type);
     if (dinfo) {
         qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
+        blk = blk_by_legacy_dinfo(dinfo);
+        bs = blk_bs(blk);
+        blk_size = blk_getlength(blk);
+
+        if (!bdrv_is_read_only(bs)) {
+            if (blk_size < fiu->flash_size) {
+                blk_get_perm(blk, &perm, &shared_perm);
+                blk_set_perm(blk, BLK_PERM_ALL, BLK_PERM_ALL, &error_abort);
+                blk_truncate(blk, fiu->flash_size, true, PREALLOC_MODE_OFF,
+                             BDRV_REQ_ZERO_WRITE, &error_abort);
+                blk_set_perm(blk, perm, shared_perm, &error_abort);
+            }
+        }
     }
     qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);
 
@@ -194,7 +211,8 @@ static void npcm845_evb_init(MachineState *machine)
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
     npcm8xx_load_bootrom(machine, soc);
-    npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
+    npcm8xx_connect_flash(&soc->fiu[0], 0, "mx66l1g45g",
+                          drive_get(IF_MTD, 0, 0));
     npcm845_evb_i2c_init(soc);
     npcm845_evb_fan_init(NPCM8XX_MACHINE(machine), soc);
     npcm8xx_load_kernel(machine, soc);
-- 
2.34.1


