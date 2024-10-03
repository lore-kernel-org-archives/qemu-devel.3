Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB655CF34AD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 14:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swMOC-0004Lf-EN; Thu, 03 Oct 2024 10:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swMNQ-000471-NU
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:00:25 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swMNO-0002rV-Af
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:00:20 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37ccd81de57so617229f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 07:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727964016; x=1728568816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPD0ziR8yfL/HjZu6b/yEmmqErN3Sv3BQp33o6QEumo=;
 b=paSZkejcLJehhIKtxeAm7c6dbsEA+0qHftsZSbuKCTOOt2h23ReqjdvnTr459qqFas
 TJ6RFkql2+9bZs3+AwImySZZr4kuZsGUwxzVR/ikY5yQTCpHeWhbyT4dpu4+FFt06Gfx
 8GYfOy4/eeL1b48CCoJbucAl/E1aDZOQPB+7eQsF8qUbnjOCbkv/oUPGcljLXUwQ0mmo
 0Lh+S1A2ZKwGgVJMDVz8BQuki+EYEdUa3kaLzsdySnBhoIckdR7do1RKoh8MYcb2lszJ
 ZKUrXRfb/JhFB/Fy8XJ64qxVrQhVaUb76T20iiTqGOAdi9Bs46yFJTmmQW3NptT1RIkX
 qcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727964016; x=1728568816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPD0ziR8yfL/HjZu6b/yEmmqErN3Sv3BQp33o6QEumo=;
 b=cjkHQ7Jx6flfQLZON+hbs52XsIM3sKXaunGjnhVt+0GvAftLeLUcC3eYxdNe6vOwD+
 IpJUImSrabxkJYoFtUiaTLLzvyttyR8MbdsU7CVoPRSqDRLsBLTbdfWqd6OeQOWxi8+r
 w4ethW1ClEL0yG624enIPJDujiax8xI8PmXG5Ds9Kdlu85D/OZcdMbZ4mkE3dqJ75p8H
 kcLC1YgWGLwFRIi1ka/kkuWqCdfYrkDYNXFistfmDmTG9nD/hdUjdFgSR3dOsLOLo7U7
 ZBNQHrc+bYa0lUHxXU33okhuN543NfEl1BOh9nEGFeoxTeMqzWQdquf0DP1aeJUaDEVW
 P/VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKO71mNCBpQ6qo8AM3s3odT4B0M/YtXVSoa/v/NgY8+W4kP7mwnE52v2mY+YDW1v7Zdsh4pa9JwZzZ@nongnu.org
X-Gm-Message-State: AOJu0Yx9n0Mb9/lcBk80LGRdKIhFuZ7BA908flw2eFBAsiTM+/H63CN/
 B2GJ4QxkbqVxbJIw93Vhc3KKQyJB/r5FHs86xi1mXtkHeY7Vboila6g7ydRjRck=
X-Google-Smtp-Source: AGHT+IH5Z0RKAGC5X2uA0/Qz4r3miR4YAsUlg8Gozod07a36v2WxqNiXC10l952fNrLtXzgkADKkLw==
X-Received: by 2002:adf:a30d:0:b0:37c:f561:1130 with SMTP id
 ffacd0b85a97d-37d04a04aa2mr2286429f8f.18.1727964016185; 
 Thu, 03 Oct 2024 07:00:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d0822bc38sm1340255f8f.45.2024.10.03.07.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 07:00:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 5/6] hw/block: Remove ecc
Date: Thu,  3 Oct 2024 15:00:09 +0100
Message-Id: <20241003140010.1653808-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003140010.1653808-1-peter.maydell@linaro.org>
References: <20241003140010.1653808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

The ecc.c code was used only by the PXA2xx and OMAP2 SoC devices,
which we have removed, so it is now completely unused.

Note that hw/misc/eccmemctl.c does not in fact use any of the
code frome ecc.c, so that KConfig dependency was incorrect.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/block/flash.h | 11 -----
 hw/block/ecc.c           | 91 ----------------------------------------
 hw/arm/Kconfig           |  1 -
 hw/block/Kconfig         |  3 --
 hw/block/meson.build     |  1 -
 hw/misc/Kconfig          |  1 -
 6 files changed, 108 deletions(-)
 delete mode 100644 hw/block/ecc.c

diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index b985c825a01..5fd67f5bb79 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -62,17 +62,6 @@ uint32_t nand_getbuswidth(DeviceState *dev);
 #define NAND_MFR_HYNIX      0xad
 #define NAND_MFR_MICRON     0x2c
 
-/* ecc.c */
-typedef struct {
-    uint8_t cp;     /* Column parity */
-    uint16_t lp[2]; /* Line parity */
-    uint16_t count;
-} ECCState;
-
-uint8_t ecc_digest(ECCState *s, uint8_t sample);
-void ecc_reset(ECCState *s);
-extern const VMStateDescription vmstate_ecc_state;
-
 /* m25p80.c */
 
 #define TYPE_M25P80 "m25p80-generic"
diff --git a/hw/block/ecc.c b/hw/block/ecc.c
deleted file mode 100644
index ed889a4184f..00000000000
--- a/hw/block/ecc.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * Calculate Error-correcting Codes. Used by NAND Flash controllers
- * (not by NAND chips).
- *
- * Copyright (c) 2006 Openedhand Ltd.
- * Written by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This code is licensed under the GNU GPL v2.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "migration/vmstate.h"
-#include "hw/block/flash.h"
-
-/*
- * Pre-calculated 256-way 1 byte column parity.  Table borrowed from Linux.
- */
-static const uint8_t nand_ecc_precalc_table[] = {
-    0x00, 0x55, 0x56, 0x03, 0x59, 0x0c, 0x0f, 0x5a,
-    0x5a, 0x0f, 0x0c, 0x59, 0x03, 0x56, 0x55, 0x00,
-    0x65, 0x30, 0x33, 0x66, 0x3c, 0x69, 0x6a, 0x3f,
-    0x3f, 0x6a, 0x69, 0x3c, 0x66, 0x33, 0x30, 0x65,
-    0x66, 0x33, 0x30, 0x65, 0x3f, 0x6a, 0x69, 0x3c,
-    0x3c, 0x69, 0x6a, 0x3f, 0x65, 0x30, 0x33, 0x66,
-    0x03, 0x56, 0x55, 0x00, 0x5a, 0x0f, 0x0c, 0x59,
-    0x59, 0x0c, 0x0f, 0x5a, 0x00, 0x55, 0x56, 0x03,
-    0x69, 0x3c, 0x3f, 0x6a, 0x30, 0x65, 0x66, 0x33,
-    0x33, 0x66, 0x65, 0x30, 0x6a, 0x3f, 0x3c, 0x69,
-    0x0c, 0x59, 0x5a, 0x0f, 0x55, 0x00, 0x03, 0x56,
-    0x56, 0x03, 0x00, 0x55, 0x0f, 0x5a, 0x59, 0x0c,
-    0x0f, 0x5a, 0x59, 0x0c, 0x56, 0x03, 0x00, 0x55,
-    0x55, 0x00, 0x03, 0x56, 0x0c, 0x59, 0x5a, 0x0f,
-    0x6a, 0x3f, 0x3c, 0x69, 0x33, 0x66, 0x65, 0x30,
-    0x30, 0x65, 0x66, 0x33, 0x69, 0x3c, 0x3f, 0x6a,
-    0x6a, 0x3f, 0x3c, 0x69, 0x33, 0x66, 0x65, 0x30,
-    0x30, 0x65, 0x66, 0x33, 0x69, 0x3c, 0x3f, 0x6a,
-    0x0f, 0x5a, 0x59, 0x0c, 0x56, 0x03, 0x00, 0x55,
-    0x55, 0x00, 0x03, 0x56, 0x0c, 0x59, 0x5a, 0x0f,
-    0x0c, 0x59, 0x5a, 0x0f, 0x55, 0x00, 0x03, 0x56,
-    0x56, 0x03, 0x00, 0x55, 0x0f, 0x5a, 0x59, 0x0c,
-    0x69, 0x3c, 0x3f, 0x6a, 0x30, 0x65, 0x66, 0x33,
-    0x33, 0x66, 0x65, 0x30, 0x6a, 0x3f, 0x3c, 0x69,
-    0x03, 0x56, 0x55, 0x00, 0x5a, 0x0f, 0x0c, 0x59,
-    0x59, 0x0c, 0x0f, 0x5a, 0x00, 0x55, 0x56, 0x03,
-    0x66, 0x33, 0x30, 0x65, 0x3f, 0x6a, 0x69, 0x3c,
-    0x3c, 0x69, 0x6a, 0x3f, 0x65, 0x30, 0x33, 0x66,
-    0x65, 0x30, 0x33, 0x66, 0x3c, 0x69, 0x6a, 0x3f,
-    0x3f, 0x6a, 0x69, 0x3c, 0x66, 0x33, 0x30, 0x65,
-    0x00, 0x55, 0x56, 0x03, 0x59, 0x0c, 0x0f, 0x5a,
-    0x5a, 0x0f, 0x0c, 0x59, 0x03, 0x56, 0x55, 0x00,
-};
-
-/* Update ECC parity count.  */
-uint8_t ecc_digest(ECCState *s, uint8_t sample)
-{
-    uint8_t idx = nand_ecc_precalc_table[sample];
-
-    s->cp ^= idx & 0x3f;
-    if (idx & 0x40) {
-        s->lp[0] ^= ~s->count;
-        s->lp[1] ^= s->count;
-    }
-    s->count ++;
-
-    return sample;
-}
-
-/* Reinitialise the counters.  */
-void ecc_reset(ECCState *s)
-{
-    s->lp[0] = 0x0000;
-    s->lp[1] = 0x0000;
-    s->cp = 0x00;
-    s->count = 0;
-}
-
-/* Save/restore */
-const VMStateDescription vmstate_ecc_state = {
-    .name = "ecc-state",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(cp, ECCState),
-        VMSTATE_UINT16_ARRAY(lp, ECCState, 2),
-        VMSTATE_UINT16(count, ECCState),
-        VMSTATE_END_OF_LIST(),
-    },
-};
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index a70ceff504b..7b19a9559f6 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -146,7 +146,6 @@ config OMAP
     bool
     select FRAMEBUFFER
     select I2C
-    select ECC
     select NAND
     select PFLASH_CFI01
     select SD
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index e67a6fd8af7..a898e04f03b 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -22,9 +22,6 @@ config PFLASH_CFI01
 config PFLASH_CFI02
     bool
 
-config ECC
-    bool
-
 config VIRTIO_BLK
     bool
     default y
diff --git a/hw/block/meson.build b/hw/block/meson.build
index 999a93d900f..16a51bf8e21 100644
--- a/hw/block/meson.build
+++ b/hw/block/meson.build
@@ -3,7 +3,6 @@ system_ss.add(files(
   'cdrom.c',
   'hd-geometry.c'
 ))
-system_ss.add(when: 'CONFIG_ECC', if_true: files('ecc.c'))
 system_ss.add(when: 'CONFIG_FDC', if_true: files('fdc.c'))
 system_ss.add(when: 'CONFIG_FDC_ISA', if_true: files('fdc-isa.c'))
 system_ss.add(when: 'CONFIG_FDC_SYSBUS', if_true: files('fdc-sysbus.c'))
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1e08785b832..8568aaa2293 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -74,7 +74,6 @@ config IVSHMEM_DEVICE
 
 config ECCMEMCTL
     bool
-    select ECC
 
 config IMX
     bool
-- 
2.34.1


