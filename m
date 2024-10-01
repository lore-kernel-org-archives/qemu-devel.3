Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320A6CEACE9
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuQ-0005N1-IS; Tue, 01 Oct 2024 12:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuN-0005Kj-6G
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuI-00060y-Aj
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:30 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37cc4e718ecso3888808f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800765; x=1728405565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QS5VUFZze4DtRxkCnXaAv9FBrweTonMWmzjs2iXm2ok=;
 b=uSnX3AEBBK2DfVEfvaFhu2BrRV7u1qMc9JhY1TbD7QBYNcnL0Otk8GYQ5z4Xls8tfz
 MthTndxtuCslMJGnwmJzHC2SxnmNAzKfUCew2lN1Ih5LqeFHqYdeE+1e2hyhGBGCVWyK
 O4lLRvt9DVpqotg043e/IBxEmmOPAH5j5KzfsYZ5QCSqqCb3wJbq4rL+JaldJDjLYIec
 7fEhtDTjgUiv16r5olbsqD8CliAtjiUTEr53zVE5aODB+J2iIN1HTUH/uh/QJ9d0f2Po
 Y4ps+Zzzbh+/XTDioX/qL+tqOfvmUVQBwOEiWOWHVP308KtrujoJMot36XbpudebF28L
 uoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800765; x=1728405565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QS5VUFZze4DtRxkCnXaAv9FBrweTonMWmzjs2iXm2ok=;
 b=Hpc+LuSP98npJQqSICvLo1+F0ElHF+lQ1TACW9qfL6EFk6s78VEkj6xF8Z/Kq0UxmA
 FQhYLUtmJFsqYAVwf+vmqVeuR5NK2MIB9EHMfbPJKbohBoln73Pqr1bJlpQm9wOAP04L
 M8BAnABirxfOQXtxuw0odjC7rxzb4gaZsqgr6gbfpKE90nlirxNiZWGVgfkwmKGFvmjD
 1ALAAa2kLAp4Ok5w8w6iV6Dq94lJbQBxXvbJVPuFt1Ys6szlgh22zETN0xASKh310CXZ
 zr9xlYTxbAgx4VKiTlb9VjucCsteoadoAPnEpz2/SKnE3aGeSNHGbDyjIFP3DR08JXAq
 26gw==
X-Gm-Message-State: AOJu0YyggerSYq+S/Y1vGUmA3PjLmaA3+v5JBQaYkX6KAPXViV2DKqjt
 pe1tqH9Z+jspsVBV5dot101ylsbNQ+qNqmXz0Wgw3f5TsBIWLZ2g0RZ/EXKxOzel9dd8KThMRnV
 f
X-Google-Smtp-Source: AGHT+IFjbBD5N3pRoC6k58TR15gYEXeCAN9sGQ9HozktFKoelMe/Ujik6go5UU7uukzcm6S15EroSg==
X-Received: by 2002:adf:9bd8:0:b0:37c:d2d9:f3f0 with SMTP id
 ffacd0b85a97d-37cfb8b9790mr162775f8f.16.1727800764308; 
 Tue, 01 Oct 2024 09:39:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/54] hw/arm: Remove deprecated akita, borzoi, spitz, terrier,
 tosa boards
Date: Tue,  1 Oct 2024 17:38:32 +0100
Message-Id: <20241001163918.1275441-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

The Sharp XScale-based PDA board models akita, borzoi, spitz,
terrier, and tosa were all deprecated in 9.0, so our deprecation
cycle permits removing them for the 9.2 release.

Remove the source files for the board models themselves, and their
documentation. There were no tests for these boards.

We will move the text describing the dropped boards from
deprecated.rst to removed-features.rst when we've cleaned up all the
boards it lists.  Device models used only by removed board models
will be removed in separate commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-2-peter.maydell@linaro.org
---
 MAINTAINERS                             |    3 -
 docs/system/arm/xscale.rst              |   35 -
 docs/system/target-arm.rst              |    1 -
 configs/devices/arm-softmmu/default.mak |    2 -
 hw/arm/spitz.c                          | 1284 -----------------------
 hw/arm/tosa.c                           |  327 ------
 hw/arm/Kconfig                          |   23 -
 hw/arm/meson.build                      |    2 -
 8 files changed, 1677 deletions(-)
 delete mode 100644 docs/system/arm/xscale.rst
 delete mode 100644 hw/arm/spitz.c
 delete mode 100644 hw/arm/tosa.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7113abeea5c..0c03c612cfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -934,8 +934,6 @@ M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/mainstone.c
-F: hw/arm/spitz.c
-F: hw/arm/tosa.c
 F: hw/arm/z2.c
 F: hw/*/pxa2xx*
 F: hw/display/tc6393xb.c
@@ -948,7 +946,6 @@ F: include/hw/adc/max111x.h
 F: include/hw/arm/pxa.h
 F: include/hw/arm/sharpsl.h
 F: include/hw/display/tc6393xb.h
-F: docs/system/arm/xscale.rst
 F: docs/system/arm/mainstone.rst
 
 SABRELITE / i.MX6
diff --git a/docs/system/arm/xscale.rst b/docs/system/arm/xscale.rst
deleted file mode 100644
index e239136c3c7..00000000000
--- a/docs/system/arm/xscale.rst
+++ /dev/null
@@ -1,35 +0,0 @@
-Sharp XScale-based PDA models (``akita``, ``borzoi``, ``spitz``, ``terrier``, ``tosa``)
-=======================================================================================
-
-The Sharp Zaurus are PDAs based on XScale, able to run Linux ('SL series').
-
-The SL-6000 (\"Tosa\"), released in 2005, uses a PXA255 System-on-chip.
-
-The SL-C3000 (\"Spitz\"), SL-C1000 (\"Akita\"), SL-C3100 (\"Borzoi\") and
-SL-C3200 (\"Terrier\") use a PXA270.
-
-The clamshell PDA models emulation includes the following peripherals:
-
--  Intel PXA255/PXA270 System-on-chip (ARMv5TE core)
-
--  NAND Flash memory - not in \"Tosa\"
-
--  IBM/Hitachi DSCM microdrive in a PXA PCMCIA slot - not in \"Akita\"
-
--  On-chip OHCI USB controller - not in \"Tosa\"
-
--  On-chip LCD controller
-
--  On-chip Real Time Clock
-
--  TI ADS7846 touchscreen controller on SSP bus
-
--  Maxim MAX1111 analog-digital converter on |I2C| bus
-
--  GPIO-connected keyboard controller and LEDs
-
--  Secure Digital card connected to PXA MMC/SD host
-
--  Three on-chip UARTs
-
--  WM8750 audio CODEC on |I2C| and |I2S| buses
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 7b992722846..326b69502b5 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -101,7 +101,6 @@ undocumented; you can get a complete list by running
    arm/orangepi
    arm/palm
    arm/raspi
-   arm/xscale
    arm/collie
    arm/sx1
    arm/stellaris
diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
index 31f77c20269..4cbe04ffbf1 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -30,8 +30,6 @@
 # CONFIG_ZYNQ=n
 # CONFIG_MAINSTONE=n
 # CONFIG_GUMSTIX=n
-# CONFIG_SPITZ=n
-# CONFIG_TOSA=n
 # CONFIG_Z2=n
 # CONFIG_NPCM7XX=n
 # CONFIG_COLLIE=n
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
deleted file mode 100644
index 62cd55ba914..00000000000
--- a/hw/arm/spitz.c
+++ /dev/null
@@ -1,1284 +0,0 @@
-/*
- * PXA270-based Clamshell PDA platforms.
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
-#include "qapi/error.h"
-#include "hw/arm/pxa.h"
-#include "hw/arm/boot.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
-#include "hw/pcmcia.h"
-#include "hw/qdev-properties.h"
-#include "hw/i2c/i2c.h"
-#include "hw/irq.h"
-#include "hw/ssi/ssi.h"
-#include "hw/block/flash.h"
-#include "qemu/timer.h"
-#include "qemu/log.h"
-#include "hw/arm/sharpsl.h"
-#include "ui/console.h"
-#include "hw/audio/wm8750.h"
-#include "audio/audio.h"
-#include "hw/boards.h"
-#include "hw/sysbus.h"
-#include "hw/adc/max111x.h"
-#include "migration/vmstate.h"
-#include "exec/address-spaces.h"
-#include "qom/object.h"
-#include "audio/audio.h"
-
-enum spitz_model_e { spitz, akita, borzoi, terrier };
-
-struct SpitzMachineClass {
-    MachineClass parent;
-    enum spitz_model_e model;
-    int arm_id;
-};
-
-struct SpitzMachineState {
-    MachineState parent;
-    PXA2xxState *mpu;
-    DeviceState *mux;
-    DeviceState *lcdtg;
-    DeviceState *ads7846;
-    DeviceState *max1111;
-    DeviceState *scp0;
-    DeviceState *scp1;
-    DeviceState *misc_gpio;
-};
-
-#define TYPE_SPITZ_MACHINE "spitz-common"
-OBJECT_DECLARE_TYPE(SpitzMachineState, SpitzMachineClass, SPITZ_MACHINE)
-
-#define zaurus_printf(format, ...)                              \
-    fprintf(stderr, "%s: " format, __func__, ##__VA_ARGS__)
-
-/* Spitz Flash */
-#define FLASH_BASE              0x0c000000
-#define FLASH_ECCLPLB           0x00    /* Line parity 7 - 0 bit */
-#define FLASH_ECCLPUB           0x04    /* Line parity 15 - 8 bit */
-#define FLASH_ECCCP             0x08    /* Column parity 5 - 0 bit */
-#define FLASH_ECCCNTR           0x0c    /* ECC byte counter */
-#define FLASH_ECCCLRR           0x10    /* Clear ECC */
-#define FLASH_FLASHIO           0x14    /* Flash I/O */
-#define FLASH_FLASHCTL          0x18    /* Flash Control */
-
-#define FLASHCTL_CE0            (1 << 0)
-#define FLASHCTL_CLE            (1 << 1)
-#define FLASHCTL_ALE            (1 << 2)
-#define FLASHCTL_WP             (1 << 3)
-#define FLASHCTL_CE1            (1 << 4)
-#define FLASHCTL_RYBY           (1 << 5)
-#define FLASHCTL_NCE            (FLASHCTL_CE0 | FLASHCTL_CE1)
-
-#define TYPE_SL_NAND "sl-nand"
-OBJECT_DECLARE_SIMPLE_TYPE(SLNANDState, SL_NAND)
-
-struct SLNANDState {
-    SysBusDevice parent_obj;
-
-    MemoryRegion iomem;
-    DeviceState *nand;
-    uint8_t ctl;
-    uint8_t manf_id;
-    uint8_t chip_id;
-    ECCState ecc;
-};
-
-static uint64_t sl_read(void *opaque, hwaddr addr, unsigned size)
-{
-    SLNANDState *s = (SLNANDState *) opaque;
-    int ryby;
-
-    switch (addr) {
-#define BSHR(byte, from, to)    ((s->ecc.lp[byte] >> (from - to)) & (1 << to))
-    case FLASH_ECCLPLB:
-        return BSHR(0, 4, 0) | BSHR(0, 5, 2) | BSHR(0, 6, 4) | BSHR(0, 7, 6) |
-                BSHR(1, 4, 1) | BSHR(1, 5, 3) | BSHR(1, 6, 5) | BSHR(1, 7, 7);
-
-#define BSHL(byte, from, to)    ((s->ecc.lp[byte] << (to - from)) & (1 << to))
-    case FLASH_ECCLPUB:
-        return BSHL(0, 0, 0) | BSHL(0, 1, 2) | BSHL(0, 2, 4) | BSHL(0, 3, 6) |
-                BSHL(1, 0, 1) | BSHL(1, 1, 3) | BSHL(1, 2, 5) | BSHL(1, 3, 7);
-
-    case FLASH_ECCCP:
-        return s->ecc.cp;
-
-    case FLASH_ECCCNTR:
-        return s->ecc.count & 0xff;
-
-    case FLASH_FLASHCTL:
-        nand_getpins(s->nand, &ryby);
-        if (ryby)
-            return s->ctl | FLASHCTL_RYBY;
-        else
-            return s->ctl;
-
-    case FLASH_FLASHIO:
-        if (size == 4) {
-            return ecc_digest(&s->ecc, nand_getio(s->nand)) |
-                (ecc_digest(&s->ecc, nand_getio(s->nand)) << 16);
-        }
-        return ecc_digest(&s->ecc, nand_getio(s->nand));
-
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "sl_read: bad register offset 0x%02" HWADDR_PRIx "\n",
-                      addr);
-    }
-    return 0;
-}
-
-static void sl_write(void *opaque, hwaddr addr,
-                     uint64_t value, unsigned size)
-{
-    SLNANDState *s = (SLNANDState *) opaque;
-
-    switch (addr) {
-    case FLASH_ECCCLRR:
-        /* Value is ignored.  */
-        ecc_reset(&s->ecc);
-        break;
-
-    case FLASH_FLASHCTL:
-        s->ctl = value & 0xff & ~FLASHCTL_RYBY;
-        nand_setpins(s->nand,
-                        s->ctl & FLASHCTL_CLE,
-                        s->ctl & FLASHCTL_ALE,
-                        s->ctl & FLASHCTL_NCE,
-                        s->ctl & FLASHCTL_WP,
-                        0);
-        break;
-
-    case FLASH_FLASHIO:
-        nand_setio(s->nand, ecc_digest(&s->ecc, value & 0xff));
-        break;
-
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "sl_write: bad register offset 0x%02" HWADDR_PRIx "\n",
-                      addr);
-    }
-}
-
-enum {
-    FLASH_128M,
-    FLASH_1024M,
-};
-
-static const MemoryRegionOps sl_ops = {
-    .read = sl_read,
-    .write = sl_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-static void sl_flash_register(PXA2xxState *cpu, int size)
-{
-    DeviceState *dev;
-
-    dev = qdev_new(TYPE_SL_NAND);
-
-    qdev_prop_set_uint8(dev, "manf_id", NAND_MFR_SAMSUNG);
-    if (size == FLASH_128M)
-        qdev_prop_set_uint8(dev, "chip_id", 0x73);
-    else if (size == FLASH_1024M)
-        qdev_prop_set_uint8(dev, "chip_id", 0xf1);
-
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, FLASH_BASE);
-}
-
-static void sl_nand_init(Object *obj)
-{
-    SLNANDState *s = SL_NAND(obj);
-    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
-
-    s->ctl = 0;
-
-    memory_region_init_io(&s->iomem, obj, &sl_ops, s, "sl", 0x40);
-    sysbus_init_mmio(dev, &s->iomem);
-}
-
-static void sl_nand_realize(DeviceState *dev, Error **errp)
-{
-    SLNANDState *s = SL_NAND(dev);
-    DriveInfo *nand;
-
-    /* FIXME use a qdev drive property instead of drive_get() */
-    nand = drive_get(IF_MTD, 0, 0);
-    s->nand = nand_init(nand ? blk_by_legacy_dinfo(nand) : NULL,
-                        s->manf_id, s->chip_id);
-}
-
-/* Spitz Keyboard */
-
-#define SPITZ_KEY_STROBE_NUM    11
-#define SPITZ_KEY_SENSE_NUM     7
-
-static const int spitz_gpio_key_sense[SPITZ_KEY_SENSE_NUM] = {
-    12, 17, 91, 34, 36, 38, 39
-};
-
-static const int spitz_gpio_key_strobe[SPITZ_KEY_STROBE_NUM] = {
-    88, 23, 24, 25, 26, 27, 52, 103, 107, 108, 114
-};
-
-/* Eighth additional row maps the special keys */
-static int spitz_keymap[SPITZ_KEY_SENSE_NUM + 1][SPITZ_KEY_STROBE_NUM] = {
-    { 0x1d, 0x02, 0x04, 0x06, 0x07, 0x08, 0x0a, 0x0b, 0x0e, 0x3f, 0x40 },
-    {  -1 , 0x03, 0x05, 0x13, 0x15, 0x09, 0x17, 0x18, 0x19, 0x41, 0x42 },
-    { 0x0f, 0x10, 0x12, 0x14, 0x22, 0x16, 0x24, 0x25,  -1 ,  -1 ,  -1  },
-    { 0x3c, 0x11, 0x1f, 0x21, 0x2f, 0x23, 0x32, 0x26,  -1 , 0x36,  -1  },
-    { 0x3b, 0x1e, 0x20, 0x2e, 0x30, 0x31, 0x34,  -1 , 0x1c, 0x2a,  -1  },
-    { 0x44, 0x2c, 0x2d, 0x0c, 0x39, 0x33,  -1 , 0x48,  -1 ,  -1 , 0x38 },
-    { 0x37, 0x3d,  -1 , 0x45, 0x57, 0x58, 0x4b, 0x50, 0x4d,  -1 ,  -1  },
-    { 0x52, 0x43, 0x01, 0x47, 0x49,  -1 ,  -1 ,  -1 ,  -1 ,  -1 ,  -1  },
-};
-
-#define SPITZ_GPIO_AK_INT       13      /* Remote control */
-#define SPITZ_GPIO_SYNC                 16      /* Sync button */
-#define SPITZ_GPIO_ON_KEY       95      /* Power button */
-#define SPITZ_GPIO_SWA          97      /* Lid */
-#define SPITZ_GPIO_SWB          96      /* Tablet mode */
-
-/* The special buttons are mapped to unused keys */
-static const int spitz_gpiomap[5] = {
-    SPITZ_GPIO_AK_INT, SPITZ_GPIO_SYNC, SPITZ_GPIO_ON_KEY,
-    SPITZ_GPIO_SWA, SPITZ_GPIO_SWB,
-};
-
-#define TYPE_SPITZ_KEYBOARD "spitz-keyboard"
-OBJECT_DECLARE_SIMPLE_TYPE(SpitzKeyboardState, SPITZ_KEYBOARD)
-
-struct SpitzKeyboardState {
-    SysBusDevice parent_obj;
-
-    qemu_irq sense[SPITZ_KEY_SENSE_NUM];
-    qemu_irq gpiomap[5];
-    int keymap[0x80];
-    uint16_t keyrow[SPITZ_KEY_SENSE_NUM];
-    uint16_t strobe_state;
-    uint16_t sense_state;
-
-    uint16_t pre_map[0x100];
-    uint16_t modifiers;
-    uint16_t imodifiers;
-    uint8_t fifo[16];
-    int fifopos, fifolen;
-    QEMUTimer *kbdtimer;
-};
-
-static void spitz_keyboard_sense_update(SpitzKeyboardState *s)
-{
-    int i;
-    uint16_t strobe, sense = 0;
-    for (i = 0; i < SPITZ_KEY_SENSE_NUM; i ++) {
-        strobe = s->keyrow[i] & s->strobe_state;
-        if (strobe) {
-            sense |= 1 << i;
-            if (!(s->sense_state & (1 << i)))
-                qemu_irq_raise(s->sense[i]);
-        } else if (s->sense_state & (1 << i))
-            qemu_irq_lower(s->sense[i]);
-    }
-
-    s->sense_state = sense;
-}
-
-static void spitz_keyboard_strobe(void *opaque, int line, int level)
-{
-    SpitzKeyboardState *s = (SpitzKeyboardState *) opaque;
-
-    if (level)
-        s->strobe_state |= 1 << line;
-    else
-        s->strobe_state &= ~(1 << line);
-    spitz_keyboard_sense_update(s);
-}
-
-static void spitz_keyboard_keydown(SpitzKeyboardState *s, int keycode)
-{
-    int spitz_keycode = s->keymap[keycode & 0x7f];
-    if (spitz_keycode == -1)
-        return;
-
-    /* Handle the additional keys */
-    if ((spitz_keycode >> 4) == SPITZ_KEY_SENSE_NUM) {
-        qemu_set_irq(s->gpiomap[spitz_keycode & 0xf], (keycode < 0x80));
-        return;
-    }
-
-    if (keycode & 0x80)
-        s->keyrow[spitz_keycode >> 4] &= ~(1 << (spitz_keycode & 0xf));
-    else
-        s->keyrow[spitz_keycode >> 4] |= 1 << (spitz_keycode & 0xf);
-
-    spitz_keyboard_sense_update(s);
-}
-
-#define SPITZ_MOD_SHIFT   (1 << 7)
-#define SPITZ_MOD_CTRL    (1 << 8)
-#define SPITZ_MOD_FN      (1 << 9)
-
-#define QUEUE_KEY(c)    s->fifo[(s->fifopos + s->fifolen ++) & 0xf] = c
-
-static void spitz_keyboard_handler(void *opaque, int keycode)
-{
-    SpitzKeyboardState *s = opaque;
-    uint16_t code;
-    int mapcode;
-    switch (keycode) {
-    case 0x2a:  /* Left Shift */
-        s->modifiers |= 1;
-        break;
-    case 0xaa:
-        s->modifiers &= ~1;
-        break;
-    case 0x36:  /* Right Shift */
-        s->modifiers |= 2;
-        break;
-    case 0xb6:
-        s->modifiers &= ~2;
-        break;
-    case 0x1d:  /* Control */
-        s->modifiers |= 4;
-        break;
-    case 0x9d:
-        s->modifiers &= ~4;
-        break;
-    case 0x38:  /* Alt */
-        s->modifiers |= 8;
-        break;
-    case 0xb8:
-        s->modifiers &= ~8;
-        break;
-    }
-
-    code = s->pre_map[mapcode = ((s->modifiers & 3) ?
-            (keycode | SPITZ_MOD_SHIFT) :
-            (keycode & ~SPITZ_MOD_SHIFT))];
-
-    if (code != mapcode) {
-#if 0
-        if ((code & SPITZ_MOD_SHIFT) && !(s->modifiers & 1)) {
-            QUEUE_KEY(0x2a | (keycode & 0x80));
-        }
-        if ((code & SPITZ_MOD_CTRL) && !(s->modifiers & 4)) {
-            QUEUE_KEY(0x1d | (keycode & 0x80));
-        }
-        if ((code & SPITZ_MOD_FN) && !(s->modifiers & 8)) {
-            QUEUE_KEY(0x38 | (keycode & 0x80));
-        }
-        if ((code & SPITZ_MOD_FN) && (s->modifiers & 1)) {
-            QUEUE_KEY(0x2a | (~keycode & 0x80));
-        }
-        if ((code & SPITZ_MOD_FN) && (s->modifiers & 2)) {
-            QUEUE_KEY(0x36 | (~keycode & 0x80));
-        }
-#else
-        if (keycode & 0x80) {
-            if ((s->imodifiers & 1   ) && !(s->modifiers & 1))
-                QUEUE_KEY(0x2a | 0x80);
-            if ((s->imodifiers & 4   ) && !(s->modifiers & 4))
-                QUEUE_KEY(0x1d | 0x80);
-            if ((s->imodifiers & 8   ) && !(s->modifiers & 8))
-                QUEUE_KEY(0x38 | 0x80);
-            if ((s->imodifiers & 0x10) && (s->modifiers & 1))
-                QUEUE_KEY(0x2a);
-            if ((s->imodifiers & 0x20) && (s->modifiers & 2))
-                QUEUE_KEY(0x36);
-            s->imodifiers = 0;
-        } else {
-            if ((code & SPITZ_MOD_SHIFT) &&
-                !((s->modifiers | s->imodifiers) & 1)) {
-                QUEUE_KEY(0x2a);
-                s->imodifiers |= 1;
-            }
-            if ((code & SPITZ_MOD_CTRL) &&
-                !((s->modifiers | s->imodifiers) & 4)) {
-                QUEUE_KEY(0x1d);
-                s->imodifiers |= 4;
-            }
-            if ((code & SPITZ_MOD_FN) &&
-                !((s->modifiers | s->imodifiers) & 8)) {
-                QUEUE_KEY(0x38);
-                s->imodifiers |= 8;
-            }
-            if ((code & SPITZ_MOD_FN) && (s->modifiers & 1) &&
-                            !(s->imodifiers & 0x10)) {
-                QUEUE_KEY(0x2a | 0x80);
-                s->imodifiers |= 0x10;
-            }
-            if ((code & SPITZ_MOD_FN) && (s->modifiers & 2) &&
-                            !(s->imodifiers & 0x20)) {
-                QUEUE_KEY(0x36 | 0x80);
-                s->imodifiers |= 0x20;
-            }
-        }
-#endif
-    }
-
-    QUEUE_KEY((code & 0x7f) | (keycode & 0x80));
-}
-
-static void spitz_keyboard_tick(void *opaque)
-{
-    SpitzKeyboardState *s = (SpitzKeyboardState *) opaque;
-
-    if (s->fifolen) {
-        spitz_keyboard_keydown(s, s->fifo[s->fifopos ++]);
-        s->fifolen --;
-        if (s->fifopos >= 16)
-            s->fifopos = 0;
-    }
-
-    timer_mod(s->kbdtimer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                   NANOSECONDS_PER_SECOND / 32);
-}
-
-static void spitz_keyboard_pre_map(SpitzKeyboardState *s)
-{
-    int i;
-    for (i = 0; i < 0x100; i ++)
-        s->pre_map[i] = i;
-    s->pre_map[0x02 | SPITZ_MOD_SHIFT] = 0x02 | SPITZ_MOD_SHIFT; /* exclam */
-    s->pre_map[0x28 | SPITZ_MOD_SHIFT] = 0x03 | SPITZ_MOD_SHIFT; /* quotedbl */
-    s->pre_map[0x04 | SPITZ_MOD_SHIFT] = 0x04 | SPITZ_MOD_SHIFT; /* # */
-    s->pre_map[0x05 | SPITZ_MOD_SHIFT] = 0x05 | SPITZ_MOD_SHIFT; /* dollar */
-    s->pre_map[0x06 | SPITZ_MOD_SHIFT] = 0x06 | SPITZ_MOD_SHIFT; /* percent */
-    s->pre_map[0x08 | SPITZ_MOD_SHIFT] = 0x07 | SPITZ_MOD_SHIFT; /* ampersand */
-    s->pre_map[0x28]                   = 0x08 | SPITZ_MOD_SHIFT; /* ' */
-    s->pre_map[0x0a | SPITZ_MOD_SHIFT] = 0x09 | SPITZ_MOD_SHIFT; /* ( */
-    s->pre_map[0x0b | SPITZ_MOD_SHIFT] = 0x0a | SPITZ_MOD_SHIFT; /* ) */
-    s->pre_map[0x29 | SPITZ_MOD_SHIFT] = 0x0b | SPITZ_MOD_SHIFT; /* tilde */
-    s->pre_map[0x03 | SPITZ_MOD_SHIFT] = 0x0c | SPITZ_MOD_SHIFT; /* at */
-    s->pre_map[0xd3]                   = 0x0e | SPITZ_MOD_FN;    /* Delete */
-    s->pre_map[0x3a]                   = 0x0f | SPITZ_MOD_FN;    /* Caps_Lock */
-    s->pre_map[0x07 | SPITZ_MOD_SHIFT] = 0x11 | SPITZ_MOD_FN;    /* ^ */
-    s->pre_map[0x0d]                   = 0x12 | SPITZ_MOD_FN;    /* equal */
-    s->pre_map[0x0d | SPITZ_MOD_SHIFT] = 0x13 | SPITZ_MOD_FN;    /* plus */
-    s->pre_map[0x1a]                   = 0x14 | SPITZ_MOD_FN;    /* [ */
-    s->pre_map[0x1b]                   = 0x15 | SPITZ_MOD_FN;    /* ] */
-    s->pre_map[0x1a | SPITZ_MOD_SHIFT] = 0x16 | SPITZ_MOD_FN;    /* { */
-    s->pre_map[0x1b | SPITZ_MOD_SHIFT] = 0x17 | SPITZ_MOD_FN;    /* } */
-    s->pre_map[0x27]                   = 0x22 | SPITZ_MOD_FN;    /* semicolon */
-    s->pre_map[0x27 | SPITZ_MOD_SHIFT] = 0x23 | SPITZ_MOD_FN;    /* colon */
-    s->pre_map[0x09 | SPITZ_MOD_SHIFT] = 0x24 | SPITZ_MOD_FN;    /* asterisk */
-    s->pre_map[0x2b]                   = 0x25 | SPITZ_MOD_FN;    /* backslash */
-    s->pre_map[0x2b | SPITZ_MOD_SHIFT] = 0x26 | SPITZ_MOD_FN;    /* bar */
-    s->pre_map[0x0c | SPITZ_MOD_SHIFT] = 0x30 | SPITZ_MOD_FN;    /* _ */
-    s->pre_map[0x33 | SPITZ_MOD_SHIFT] = 0x33 | SPITZ_MOD_FN;    /* less */
-    s->pre_map[0x35]                   = 0x33 | SPITZ_MOD_SHIFT; /* slash */
-    s->pre_map[0x34 | SPITZ_MOD_SHIFT] = 0x34 | SPITZ_MOD_FN;    /* greater */
-    s->pre_map[0x35 | SPITZ_MOD_SHIFT] = 0x34 | SPITZ_MOD_SHIFT; /* question */
-    s->pre_map[0x49]                   = 0x48 | SPITZ_MOD_FN;    /* Page_Up */
-    s->pre_map[0x51]                   = 0x50 | SPITZ_MOD_FN;    /* Page_Down */
-
-    s->modifiers = 0;
-    s->imodifiers = 0;
-    s->fifopos = 0;
-    s->fifolen = 0;
-}
-
-#undef SPITZ_MOD_SHIFT
-#undef SPITZ_MOD_CTRL
-#undef SPITZ_MOD_FN
-
-static int spitz_keyboard_post_load(void *opaque, int version_id)
-{
-    SpitzKeyboardState *s = (SpitzKeyboardState *) opaque;
-
-    /* Release all pressed keys */
-    memset(s->keyrow, 0, sizeof(s->keyrow));
-    spitz_keyboard_sense_update(s);
-    s->modifiers = 0;
-    s->imodifiers = 0;
-    s->fifopos = 0;
-    s->fifolen = 0;
-
-    return 0;
-}
-
-static void spitz_keyboard_register(PXA2xxState *cpu)
-{
-    int i;
-    DeviceState *dev;
-    SpitzKeyboardState *s;
-
-    dev = sysbus_create_simple(TYPE_SPITZ_KEYBOARD, -1, NULL);
-    s = SPITZ_KEYBOARD(dev);
-
-    for (i = 0; i < SPITZ_KEY_SENSE_NUM; i ++)
-        qdev_connect_gpio_out(dev, i, qdev_get_gpio_in(cpu->gpio, spitz_gpio_key_sense[i]));
-
-    for (i = 0; i < 5; i ++)
-        s->gpiomap[i] = qdev_get_gpio_in(cpu->gpio, spitz_gpiomap[i]);
-
-    if (!graphic_rotate)
-        s->gpiomap[4] = qemu_irq_invert(s->gpiomap[4]);
-
-    for (i = 0; i < 5; i++)
-        qemu_set_irq(s->gpiomap[i], 0);
-
-    for (i = 0; i < SPITZ_KEY_STROBE_NUM; i ++)
-        qdev_connect_gpio_out(cpu->gpio, spitz_gpio_key_strobe[i],
-                qdev_get_gpio_in(dev, i));
-
-    timer_mod(s->kbdtimer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
-
-    qemu_add_kbd_event_handler(spitz_keyboard_handler, s);
-}
-
-static void spitz_keyboard_init(Object *obj)
-{
-    DeviceState *dev = DEVICE(obj);
-    SpitzKeyboardState *s = SPITZ_KEYBOARD(obj);
-    int i, j;
-
-    for (i = 0; i < 0x80; i ++)
-        s->keymap[i] = -1;
-    for (i = 0; i < SPITZ_KEY_SENSE_NUM + 1; i ++)
-        for (j = 0; j < SPITZ_KEY_STROBE_NUM; j ++)
-            if (spitz_keymap[i][j] != -1)
-                s->keymap[spitz_keymap[i][j]] = (i << 4) | j;
-
-    spitz_keyboard_pre_map(s);
-
-    qdev_init_gpio_in(dev, spitz_keyboard_strobe, SPITZ_KEY_STROBE_NUM);
-    qdev_init_gpio_out(dev, s->sense, SPITZ_KEY_SENSE_NUM);
-}
-
-static void spitz_keyboard_realize(DeviceState *dev, Error **errp)
-{
-    SpitzKeyboardState *s = SPITZ_KEYBOARD(dev);
-    s->kbdtimer = timer_new_ns(QEMU_CLOCK_VIRTUAL, spitz_keyboard_tick, s);
-}
-
-/* LCD backlight controller */
-
-#define LCDTG_RESCTL    0x00
-#define LCDTG_PHACTRL   0x01
-#define LCDTG_DUTYCTRL  0x02
-#define LCDTG_POWERREG0         0x03
-#define LCDTG_POWERREG1         0x04
-#define LCDTG_GPOR3     0x05
-#define LCDTG_PICTRL    0x06
-#define LCDTG_POLCTRL   0x07
-
-#define TYPE_SPITZ_LCDTG "spitz-lcdtg"
-OBJECT_DECLARE_SIMPLE_TYPE(SpitzLCDTG, SPITZ_LCDTG)
-
-struct SpitzLCDTG {
-    SSIPeripheral ssidev;
-    uint32_t bl_intensity;
-    uint32_t bl_power;
-};
-
-static void spitz_bl_update(SpitzLCDTG *s)
-{
-    if (s->bl_power && s->bl_intensity)
-        zaurus_printf("LCD Backlight now at %u/63\n", s->bl_intensity);
-    else
-        zaurus_printf("LCD Backlight now off\n");
-}
-
-static inline void spitz_bl_bit5(void *opaque, int line, int level)
-{
-    SpitzLCDTG *s = opaque;
-    int prev = s->bl_intensity;
-
-    if (level)
-        s->bl_intensity &= ~0x20;
-    else
-        s->bl_intensity |= 0x20;
-
-    if (s->bl_power && prev != s->bl_intensity)
-        spitz_bl_update(s);
-}
-
-static inline void spitz_bl_power(void *opaque, int line, int level)
-{
-    SpitzLCDTG *s = opaque;
-    s->bl_power = !!level;
-    spitz_bl_update(s);
-}
-
-static uint32_t spitz_lcdtg_transfer(SSIPeripheral *dev, uint32_t value)
-{
-    SpitzLCDTG *s = SPITZ_LCDTG(dev);
-    int addr;
-    addr = value >> 5;
-    value &= 0x1f;
-
-    switch (addr) {
-    case LCDTG_RESCTL:
-        if (value)
-            zaurus_printf("LCD in QVGA mode\n");
-        else
-            zaurus_printf("LCD in VGA mode\n");
-        break;
-
-    case LCDTG_DUTYCTRL:
-        s->bl_intensity &= ~0x1f;
-        s->bl_intensity |= value;
-        if (s->bl_power)
-            spitz_bl_update(s);
-        break;
-
-    case LCDTG_POWERREG0:
-        /* Set common voltage to M62332FP */
-        break;
-    }
-    return 0;
-}
-
-static void spitz_lcdtg_realize(SSIPeripheral *ssi, Error **errp)
-{
-    SpitzLCDTG *s = SPITZ_LCDTG(ssi);
-    DeviceState *dev = DEVICE(s);
-
-    s->bl_power = 0;
-    s->bl_intensity = 0x20;
-
-    qdev_init_gpio_in_named(dev, spitz_bl_bit5, "bl_bit5", 1);
-    qdev_init_gpio_in_named(dev, spitz_bl_power, "bl_power", 1);
-}
-
-/* SSP devices */
-
-#define CORGI_SSP_PORT          2
-
-#define SPITZ_GPIO_LCDCON_CS    53
-#define SPITZ_GPIO_ADS7846_CS   14
-#define SPITZ_GPIO_MAX1111_CS   20
-#define SPITZ_GPIO_TP_INT       11
-
-#define TYPE_CORGI_SSP "corgi-ssp"
-OBJECT_DECLARE_SIMPLE_TYPE(CorgiSSPState, CORGI_SSP)
-
-/* "Demux" the signal based on current chipselect */
-struct CorgiSSPState {
-    SSIPeripheral ssidev;
-    SSIBus *bus[3];
-    uint32_t enable[3];
-};
-
-static uint32_t corgi_ssp_transfer(SSIPeripheral *dev, uint32_t value)
-{
-    CorgiSSPState *s = CORGI_SSP(dev);
-    int i;
-
-    for (i = 0; i < 3; i++) {
-        if (s->enable[i]) {
-            return ssi_transfer(s->bus[i], value);
-        }
-    }
-    return 0;
-}
-
-static void corgi_ssp_gpio_cs(void *opaque, int line, int level)
-{
-    CorgiSSPState *s = (CorgiSSPState *)opaque;
-    assert(line >= 0 && line < 3);
-    s->enable[line] = !level;
-}
-
-#define MAX1111_BATT_VOLT       1
-#define MAX1111_BATT_TEMP       2
-#define MAX1111_ACIN_VOLT       3
-
-#define SPITZ_BATTERY_TEMP      0xe0    /* About 2.9V */
-#define SPITZ_BATTERY_VOLT      0xd0    /* About 4.0V */
-#define SPITZ_CHARGEON_ACIN     0x80    /* About 5.0V */
-
-static void corgi_ssp_realize(SSIPeripheral *d, Error **errp)
-{
-    DeviceState *dev = DEVICE(d);
-    CorgiSSPState *s = CORGI_SSP(d);
-
-    qdev_init_gpio_in(dev, corgi_ssp_gpio_cs, 3);
-    s->bus[0] = ssi_create_bus(dev, "ssi0");
-    s->bus[1] = ssi_create_bus(dev, "ssi1");
-    s->bus[2] = ssi_create_bus(dev, "ssi2");
-}
-
-static void spitz_ssp_attach(SpitzMachineState *sms)
-{
-    void *bus;
-
-    sms->mux = ssi_create_peripheral(sms->mpu->ssp[CORGI_SSP_PORT - 1],
-                                     TYPE_CORGI_SSP);
-
-    bus = qdev_get_child_bus(sms->mux, "ssi0");
-    sms->lcdtg = ssi_create_peripheral(bus, TYPE_SPITZ_LCDTG);
-
-    bus = qdev_get_child_bus(sms->mux, "ssi1");
-    sms->ads7846 = ssi_create_peripheral(bus, "ads7846");
-    qdev_connect_gpio_out(sms->ads7846, 0,
-                          qdev_get_gpio_in(sms->mpu->gpio, SPITZ_GPIO_TP_INT));
-
-    bus = qdev_get_child_bus(sms->mux, "ssi2");
-    sms->max1111 = qdev_new(TYPE_MAX_1111);
-    qdev_prop_set_uint8(sms->max1111, "input1" /* BATT_VOLT */,
-                        SPITZ_BATTERY_VOLT);
-    qdev_prop_set_uint8(sms->max1111, "input2" /* BATT_TEMP */, 0);
-    qdev_prop_set_uint8(sms->max1111, "input3" /* ACIN_VOLT */,
-                        SPITZ_CHARGEON_ACIN);
-    ssi_realize_and_unref(sms->max1111, bus, &error_fatal);
-
-    qdev_connect_gpio_out(sms->mpu->gpio, SPITZ_GPIO_LCDCON_CS,
-                        qdev_get_gpio_in(sms->mux, 0));
-    qdev_connect_gpio_out(sms->mpu->gpio, SPITZ_GPIO_ADS7846_CS,
-                        qdev_get_gpio_in(sms->mux, 1));
-    qdev_connect_gpio_out(sms->mpu->gpio, SPITZ_GPIO_MAX1111_CS,
-                        qdev_get_gpio_in(sms->mux, 2));
-}
-
-/* CF Microdrive */
-
-static void spitz_microdrive_attach(PXA2xxState *cpu, int slot)
-{
-    PCMCIACardState *md;
-    DriveInfo *dinfo;
-
-    dinfo = drive_get(IF_IDE, 0, 0);
-    if (!dinfo || dinfo->media_cd)
-        return;
-    md = dscm1xxxx_init(dinfo);
-    pxa2xx_pcmcia_attach(cpu->pcmcia[slot], md);
-}
-
-/* Wm8750 and Max7310 on I2C */
-
-#define AKITA_MAX_ADDR  0x18
-#define SPITZ_WM_ADDRL  0x1b
-#define SPITZ_WM_ADDRH  0x1a
-
-#define SPITZ_GPIO_WM   5
-
-static void spitz_wm8750_addr(void *opaque, int line, int level)
-{
-    I2CSlave *wm = (I2CSlave *) opaque;
-    if (level)
-        i2c_slave_set_address(wm, SPITZ_WM_ADDRH);
-    else
-        i2c_slave_set_address(wm, SPITZ_WM_ADDRL);
-}
-
-static void spitz_i2c_setup(MachineState *machine, PXA2xxState *cpu)
-{
-    /* Attach the CPU on one end of our I2C bus.  */
-    I2CBus *bus = pxa2xx_i2c_bus(cpu->i2c[0]);
-
-    /* Attach a WM8750 to the bus */
-    I2CSlave *i2c_dev = i2c_slave_new(TYPE_WM8750, 0);
-    DeviceState *wm = DEVICE(i2c_dev);
-
-    if (machine->audiodev) {
-        qdev_prop_set_string(wm, "audiodev", machine->audiodev);
-    }
-    i2c_slave_realize_and_unref(i2c_dev, bus, &error_abort);
-
-    spitz_wm8750_addr(wm, 0, 0);
-    qdev_connect_gpio_out(cpu->gpio, SPITZ_GPIO_WM,
-                          qemu_allocate_irq(spitz_wm8750_addr, wm, 0));
-    /* .. and to the sound interface.  */
-    cpu->i2s->opaque = wm;
-    cpu->i2s->codec_out = wm8750_dac_dat;
-    cpu->i2s->codec_in = wm8750_adc_dat;
-    wm8750_data_req_set(wm, cpu->i2s->data_req, cpu->i2s);
-}
-
-static void spitz_akita_i2c_setup(PXA2xxState *cpu)
-{
-    /* Attach a Max7310 to Akita I2C bus.  */
-    i2c_slave_create_simple(pxa2xx_i2c_bus(cpu->i2c[0]), "max7310",
-                     AKITA_MAX_ADDR);
-}
-
-/* Other peripherals */
-
-/*
- * Encapsulation of some miscellaneous GPIO line behaviour for the Spitz boards.
- *
- * QEMU interface:
- *  + named GPIO inputs "green-led", "orange-led", "charging", "discharging":
- *    these currently just print messages that the line has been signalled
- *  + named GPIO input "adc-temp-on": set to cause the battery-temperature
- *    value to be passed to the max111x ADC
- *  + named GPIO output "adc-temp": the ADC value, to be wired up to the max111x
- */
-#define TYPE_SPITZ_MISC_GPIO "spitz-misc-gpio"
-OBJECT_DECLARE_SIMPLE_TYPE(SpitzMiscGPIOState, SPITZ_MISC_GPIO)
-
-struct SpitzMiscGPIOState {
-    SysBusDevice parent_obj;
-
-    qemu_irq adc_value;
-};
-
-static void spitz_misc_charging(void *opaque, int n, int level)
-{
-    zaurus_printf("Charging %s.\n", level ? "off" : "on");
-}
-
-static void spitz_misc_discharging(void *opaque, int n, int level)
-{
-    zaurus_printf("Discharging %s.\n", level ? "off" : "on");
-}
-
-static void spitz_misc_green_led(void *opaque, int n, int level)
-{
-    zaurus_printf("Green LED %s.\n", level ? "off" : "on");
-}
-
-static void spitz_misc_orange_led(void *opaque, int n, int level)
-{
-    zaurus_printf("Orange LED %s.\n", level ? "off" : "on");
-}
-
-static void spitz_misc_adc_temp(void *opaque, int n, int level)
-{
-    SpitzMiscGPIOState *s = SPITZ_MISC_GPIO(opaque);
-    int batt_temp = level ? SPITZ_BATTERY_TEMP : 0;
-
-    qemu_set_irq(s->adc_value, batt_temp);
-}
-
-static void spitz_misc_gpio_init(Object *obj)
-{
-    SpitzMiscGPIOState *s = SPITZ_MISC_GPIO(obj);
-    DeviceState *dev = DEVICE(obj);
-
-    qdev_init_gpio_in_named(dev, spitz_misc_charging, "charging", 1);
-    qdev_init_gpio_in_named(dev, spitz_misc_discharging, "discharging", 1);
-    qdev_init_gpio_in_named(dev, spitz_misc_green_led, "green-led", 1);
-    qdev_init_gpio_in_named(dev, spitz_misc_orange_led, "orange-led", 1);
-    qdev_init_gpio_in_named(dev, spitz_misc_adc_temp, "adc-temp-on", 1);
-
-    qdev_init_gpio_out_named(dev, &s->adc_value, "adc-temp", 1);
-}
-
-#define SPITZ_SCP_LED_GREEN             1
-#define SPITZ_SCP_JK_B                  2
-#define SPITZ_SCP_CHRG_ON               3
-#define SPITZ_SCP_MUTE_L                4
-#define SPITZ_SCP_MUTE_R                5
-#define SPITZ_SCP_CF_POWER              6
-#define SPITZ_SCP_LED_ORANGE            7
-#define SPITZ_SCP_JK_A                  8
-#define SPITZ_SCP_ADC_TEMP_ON           9
-#define SPITZ_SCP2_IR_ON                1
-#define SPITZ_SCP2_AKIN_PULLUP          2
-#define SPITZ_SCP2_BACKLIGHT_CONT       7
-#define SPITZ_SCP2_BACKLIGHT_ON                 8
-#define SPITZ_SCP2_MIC_BIAS             9
-
-static void spitz_scoop_gpio_setup(SpitzMachineState *sms)
-{
-    DeviceState *miscdev = sysbus_create_simple(TYPE_SPITZ_MISC_GPIO, -1, NULL);
-
-    sms->misc_gpio = miscdev;
-
-    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_CHRG_ON,
-                          qdev_get_gpio_in_named(miscdev, "charging", 0));
-    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_JK_B,
-                          qdev_get_gpio_in_named(miscdev, "discharging", 0));
-    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_LED_GREEN,
-                          qdev_get_gpio_in_named(miscdev, "green-led", 0));
-    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_LED_ORANGE,
-                          qdev_get_gpio_in_named(miscdev, "orange-led", 0));
-    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_ADC_TEMP_ON,
-                          qdev_get_gpio_in_named(miscdev, "adc-temp-on", 0));
-    qdev_connect_gpio_out_named(miscdev, "adc-temp", 0,
-                                qdev_get_gpio_in(sms->max1111, MAX1111_BATT_TEMP));
-
-    if (sms->scp1) {
-        qdev_connect_gpio_out(sms->scp1, SPITZ_SCP2_BACKLIGHT_CONT,
-                              qdev_get_gpio_in_named(sms->lcdtg, "bl_bit5", 0));
-        qdev_connect_gpio_out(sms->scp1, SPITZ_SCP2_BACKLIGHT_ON,
-                              qdev_get_gpio_in_named(sms->lcdtg, "bl_power", 0));
-    }
-}
-
-#define SPITZ_GPIO_HSYNC                22
-#define SPITZ_GPIO_SD_DETECT            9
-#define SPITZ_GPIO_SD_WP                81
-#define SPITZ_GPIO_ON_RESET             89
-#define SPITZ_GPIO_BAT_COVER            90
-#define SPITZ_GPIO_CF1_IRQ              105
-#define SPITZ_GPIO_CF1_CD               94
-#define SPITZ_GPIO_CF2_IRQ              106
-#define SPITZ_GPIO_CF2_CD               93
-
-static int spitz_hsync;
-
-static void spitz_lcd_hsync_handler(void *opaque, int line, int level)
-{
-    PXA2xxState *cpu = (PXA2xxState *) opaque;
-    qemu_set_irq(qdev_get_gpio_in(cpu->gpio, SPITZ_GPIO_HSYNC), spitz_hsync);
-    spitz_hsync ^= 1;
-}
-
-static void spitz_reset(void *opaque, int line, int level)
-{
-    if (level) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    }
-}
-
-static void spitz_gpio_setup(PXA2xxState *cpu, int slots)
-{
-    qemu_irq lcd_hsync;
-    qemu_irq reset;
-
-    /*
-     * Bad hack: We toggle the LCD hsync GPIO on every GPIO status
-     * read to satisfy broken guests that poll-wait for hsync.
-     * Simulating a real hsync event would be less practical and
-     * wouldn't guarantee that a guest ever exits the loop.
-     */
-    spitz_hsync = 0;
-    lcd_hsync = qemu_allocate_irq(spitz_lcd_hsync_handler, cpu, 0);
-    pxa2xx_gpio_read_notifier(cpu->gpio, lcd_hsync);
-    pxa2xx_lcd_vsync_notifier(cpu->lcd, lcd_hsync);
-
-    /* MMC/SD host */
-    pxa2xx_mmci_handlers(cpu->mmc,
-                    qdev_get_gpio_in(cpu->gpio, SPITZ_GPIO_SD_WP),
-                    qdev_get_gpio_in(cpu->gpio, SPITZ_GPIO_SD_DETECT));
-
-    /* Battery lock always closed */
-    qemu_irq_raise(qdev_get_gpio_in(cpu->gpio, SPITZ_GPIO_BAT_COVER));
-
-    /* Handle reset */
-    reset = qemu_allocate_irq(spitz_reset, cpu, 0);
-    qdev_connect_gpio_out(cpu->gpio, SPITZ_GPIO_ON_RESET, reset);
-
-    /* PCMCIA signals: card's IRQ and Card-Detect */
-    if (slots >= 1)
-        pxa2xx_pcmcia_set_irq_cb(cpu->pcmcia[0],
-                        qdev_get_gpio_in(cpu->gpio, SPITZ_GPIO_CF1_IRQ),
-                        qdev_get_gpio_in(cpu->gpio, SPITZ_GPIO_CF1_CD));
-    if (slots >= 2)
-        pxa2xx_pcmcia_set_irq_cb(cpu->pcmcia[1],
-                        qdev_get_gpio_in(cpu->gpio, SPITZ_GPIO_CF2_IRQ),
-                        qdev_get_gpio_in(cpu->gpio, SPITZ_GPIO_CF2_CD));
-}
-
-/* Board init.  */
-#define SPITZ_RAM       0x04000000
-#define SPITZ_ROM       0x00800000
-
-static struct arm_boot_info spitz_binfo = {
-    .loader_start = PXA2XX_SDRAM_BASE,
-    .ram_size = 0x04000000,
-};
-
-static void spitz_common_init(MachineState *machine)
-{
-    SpitzMachineClass *smc = SPITZ_MACHINE_GET_CLASS(machine);
-    SpitzMachineState *sms = SPITZ_MACHINE(machine);
-    enum spitz_model_e model = smc->model;
-    PXA2xxState *mpu;
-    MemoryRegion *rom = g_new(MemoryRegion, 1);
-
-    /* Setup CPU & memory */
-    mpu = pxa270_init(spitz_binfo.ram_size, machine->cpu_type);
-    sms->mpu = mpu;
-
-    sl_flash_register(mpu, (model == spitz) ? FLASH_128M : FLASH_1024M);
-
-    memory_region_init_rom(rom, NULL, "spitz.rom", SPITZ_ROM, &error_fatal);
-    memory_region_add_subregion(get_system_memory(), 0, rom);
-
-    /* Setup peripherals */
-    spitz_keyboard_register(mpu);
-
-    spitz_ssp_attach(sms);
-
-    sms->scp0 = sysbus_create_simple("scoop", 0x10800000, NULL);
-    if (model != akita) {
-        sms->scp1 = sysbus_create_simple("scoop", 0x08800040, NULL);
-    } else {
-        sms->scp1 = NULL;
-    }
-
-    spitz_scoop_gpio_setup(sms);
-
-    spitz_gpio_setup(mpu, (model == akita) ? 1 : 2);
-
-    spitz_i2c_setup(machine, mpu);
-
-    if (model == akita)
-        spitz_akita_i2c_setup(mpu);
-
-    if (model == terrier)
-        /* A 6.0 GB microdrive is permanently sitting in CF slot 1.  */
-        spitz_microdrive_attach(mpu, 1);
-    else if (model != akita)
-        /* A 4.0 GB microdrive is permanently sitting in CF slot 0.  */
-        spitz_microdrive_attach(mpu, 0);
-
-    spitz_binfo.board_id = smc->arm_id;
-    arm_load_kernel(mpu->cpu, machine, &spitz_binfo);
-    sl_bootparam_write(SL_PXA_PARAM_BASE);
-}
-
-static void spitz_common_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-
-    mc->block_default_type = IF_IDE;
-    mc->ignore_memory_transaction_failures = true;
-    mc->init = spitz_common_init;
-    mc->deprecation_reason = "machine is old and unmaintained";
-
-    machine_add_audiodev_property(mc);
-}
-
-static const TypeInfo spitz_common_info = {
-    .name = TYPE_SPITZ_MACHINE,
-    .parent = TYPE_MACHINE,
-    .abstract = true,
-    .instance_size = sizeof(SpitzMachineState),
-    .class_size = sizeof(SpitzMachineClass),
-    .class_init = spitz_common_class_init,
-};
-
-static void akitapda_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    SpitzMachineClass *smc = SPITZ_MACHINE_CLASS(oc);
-
-    mc->desc = "Sharp SL-C1000 (Akita) PDA (PXA270)";
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c0");
-    smc->model = akita;
-    smc->arm_id = 0x2e8;
-}
-
-static const TypeInfo akitapda_type = {
-    .name = MACHINE_TYPE_NAME("akita"),
-    .parent = TYPE_SPITZ_MACHINE,
-    .class_init = akitapda_class_init,
-};
-
-static void spitzpda_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    SpitzMachineClass *smc = SPITZ_MACHINE_CLASS(oc);
-
-    mc->desc = "Sharp SL-C3000 (Spitz) PDA (PXA270)";
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c0");
-    smc->model = spitz;
-    smc->arm_id = 0x2c9;
-}
-
-static const TypeInfo spitzpda_type = {
-    .name = MACHINE_TYPE_NAME("spitz"),
-    .parent = TYPE_SPITZ_MACHINE,
-    .class_init = spitzpda_class_init,
-};
-
-static void borzoipda_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    SpitzMachineClass *smc = SPITZ_MACHINE_CLASS(oc);
-
-    mc->desc = "Sharp SL-C3100 (Borzoi) PDA (PXA270)";
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c0");
-    smc->model = borzoi;
-    smc->arm_id = 0x33f;
-}
-
-static const TypeInfo borzoipda_type = {
-    .name = MACHINE_TYPE_NAME("borzoi"),
-    .parent = TYPE_SPITZ_MACHINE,
-    .class_init = borzoipda_class_init,
-};
-
-static void terrierpda_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    SpitzMachineClass *smc = SPITZ_MACHINE_CLASS(oc);
-
-    mc->desc = "Sharp SL-C3200 (Terrier) PDA (PXA270)";
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c5");
-    smc->model = terrier;
-    smc->arm_id = 0x33f;
-}
-
-static const TypeInfo terrierpda_type = {
-    .name = MACHINE_TYPE_NAME("terrier"),
-    .parent = TYPE_SPITZ_MACHINE,
-    .class_init = terrierpda_class_init,
-};
-
-static void spitz_machine_init(void)
-{
-    type_register_static(&spitz_common_info);
-    type_register_static(&akitapda_type);
-    type_register_static(&spitzpda_type);
-    type_register_static(&borzoipda_type);
-    type_register_static(&terrierpda_type);
-}
-
-type_init(spitz_machine_init)
-
-static bool is_version_0(void *opaque, int version_id)
-{
-    return version_id == 0;
-}
-
-static const VMStateDescription vmstate_sl_nand_info = {
-    .name = "sl-nand",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT8(ctl, SLNANDState),
-        VMSTATE_STRUCT(ecc, SLNANDState, 0, vmstate_ecc_state, ECCState),
-        VMSTATE_END_OF_LIST(),
-    },
-};
-
-static Property sl_nand_properties[] = {
-    DEFINE_PROP_UINT8("manf_id", SLNANDState, manf_id, NAND_MFR_SAMSUNG),
-    DEFINE_PROP_UINT8("chip_id", SLNANDState, chip_id, 0xf1),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void sl_nand_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->vmsd = &vmstate_sl_nand_info;
-    device_class_set_props(dc, sl_nand_properties);
-    dc->realize = sl_nand_realize;
-    /* Reason: init() method uses drive_get() */
-    dc->user_creatable = false;
-}
-
-static const TypeInfo sl_nand_info = {
-    .name          = TYPE_SL_NAND,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SLNANDState),
-    .instance_init = sl_nand_init,
-    .class_init    = sl_nand_class_init,
-};
-
-static const VMStateDescription vmstate_spitz_kbd = {
-    .name = "spitz-keyboard",
-    .version_id = 1,
-    .minimum_version_id = 0,
-    .post_load = spitz_keyboard_post_load,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT16(sense_state, SpitzKeyboardState),
-        VMSTATE_UINT16(strobe_state, SpitzKeyboardState),
-        VMSTATE_UNUSED_TEST(is_version_0, 5),
-        VMSTATE_END_OF_LIST(),
-    },
-};
-
-static void spitz_keyboard_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->vmsd = &vmstate_spitz_kbd;
-    dc->realize = spitz_keyboard_realize;
-}
-
-static const TypeInfo spitz_keyboard_info = {
-    .name          = TYPE_SPITZ_KEYBOARD,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SpitzKeyboardState),
-    .instance_init = spitz_keyboard_init,
-    .class_init    = spitz_keyboard_class_init,
-};
-
-static const VMStateDescription vmstate_corgi_ssp_regs = {
-    .name = "corgi-ssp",
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .fields = (const VMStateField[]) {
-        VMSTATE_SSI_PERIPHERAL(ssidev, CorgiSSPState),
-        VMSTATE_UINT32_ARRAY(enable, CorgiSSPState, 3),
-        VMSTATE_END_OF_LIST(),
-    }
-};
-
-static void corgi_ssp_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
-
-    k->realize = corgi_ssp_realize;
-    k->transfer = corgi_ssp_transfer;
-    dc->vmsd = &vmstate_corgi_ssp_regs;
-}
-
-static const TypeInfo corgi_ssp_info = {
-    .name          = TYPE_CORGI_SSP,
-    .parent        = TYPE_SSI_PERIPHERAL,
-    .instance_size = sizeof(CorgiSSPState),
-    .class_init    = corgi_ssp_class_init,
-};
-
-static const VMStateDescription vmstate_spitz_lcdtg_regs = {
-    .name = "spitz-lcdtg",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_SSI_PERIPHERAL(ssidev, SpitzLCDTG),
-        VMSTATE_UINT32(bl_intensity, SpitzLCDTG),
-        VMSTATE_UINT32(bl_power, SpitzLCDTG),
-        VMSTATE_END_OF_LIST(),
-    }
-};
-
-static void spitz_lcdtg_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
-
-    k->realize = spitz_lcdtg_realize;
-    k->transfer = spitz_lcdtg_transfer;
-    dc->vmsd = &vmstate_spitz_lcdtg_regs;
-}
-
-static const TypeInfo spitz_lcdtg_info = {
-    .name          = TYPE_SPITZ_LCDTG,
-    .parent        = TYPE_SSI_PERIPHERAL,
-    .instance_size = sizeof(SpitzLCDTG),
-    .class_init    = spitz_lcdtg_class_init,
-};
-
-static const TypeInfo spitz_misc_gpio_info = {
-    .name = TYPE_SPITZ_MISC_GPIO,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SpitzMiscGPIOState),
-    .instance_init = spitz_misc_gpio_init,
-    /*
-     * No class_init required: device has no internal state so does not
-     * need to set up reset or vmstate, and does not have a realize method.
-     */
-};
-
-static void spitz_register_types(void)
-{
-    type_register_static(&corgi_ssp_info);
-    type_register_static(&spitz_lcdtg_info);
-    type_register_static(&spitz_keyboard_info);
-    type_register_static(&sl_nand_info);
-    type_register_static(&spitz_misc_gpio_info);
-}
-
-type_init(spitz_register_types)
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
deleted file mode 100644
index 5891f6064f9..00000000000
--- a/hw/arm/tosa.c
+++ /dev/null
@@ -1,327 +0,0 @@
-/* vim:set shiftwidth=4 ts=4 et: */
-/*
- * PXA255 Sharp Zaurus SL-6000 PDA platform
- *
- * Copyright (c) 2008 Dmitry Baryshkov
- *
- * Code based on spitz platform by Andrzej Zaborowski <balrog@zabor.org>
- * This code is licensed under the GNU GPL v2.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "sysemu/runstate.h"
-#include "hw/arm/pxa.h"
-#include "hw/arm/boot.h"
-#include "hw/arm/sharpsl.h"
-#include "hw/pcmcia.h"
-#include "hw/boards.h"
-#include "hw/display/tc6393xb.h"
-#include "hw/i2c/i2c.h"
-#include "hw/irq.h"
-#include "hw/ssi/ssi.h"
-#include "hw/sysbus.h"
-#include "hw/misc/led.h"
-#include "exec/address-spaces.h"
-#include "qom/object.h"
-
-#define TOSA_RAM 0x04000000
-#define TOSA_ROM 0x00800000
-
-#define TOSA_GPIO_USB_IN                (5)
-#define TOSA_GPIO_nSD_DETECT            (9)
-#define TOSA_GPIO_ON_RESET              (19)
-#define TOSA_GPIO_CF_IRQ                (21)    /* CF slot0 Ready */
-#define TOSA_GPIO_CF_CD                 (13)
-#define TOSA_GPIO_TC6393XB_INT          (15)
-#define TOSA_GPIO_JC_CF_IRQ             (36)    /* CF slot1 Ready */
-
-#define TOSA_SCOOP_GPIO_BASE            1
-#define TOSA_GPIO_IR_POWERDWN           (TOSA_SCOOP_GPIO_BASE + 2)
-#define TOSA_GPIO_SD_WP                 (TOSA_SCOOP_GPIO_BASE + 3)
-#define TOSA_GPIO_PWR_ON                (TOSA_SCOOP_GPIO_BASE + 4)
-
-#define TOSA_SCOOP_JC_GPIO_BASE         1
-#define TOSA_GPIO_BT_LED                (TOSA_SCOOP_JC_GPIO_BASE + 0)
-#define TOSA_GPIO_NOTE_LED              (TOSA_SCOOP_JC_GPIO_BASE + 1)
-#define TOSA_GPIO_CHRG_ERR_LED          (TOSA_SCOOP_JC_GPIO_BASE + 2)
-#define TOSA_GPIO_TC6393XB_L3V_ON       (TOSA_SCOOP_JC_GPIO_BASE + 5)
-#define TOSA_GPIO_WLAN_LED              (TOSA_SCOOP_JC_GPIO_BASE + 7)
-
-#define DAC_BASE 0x4e
-#define DAC_CH1 0
-#define DAC_CH2 1
-
-static void tosa_microdrive_attach(PXA2xxState *cpu)
-{
-    PCMCIACardState *md;
-    DriveInfo *dinfo;
-
-    dinfo = drive_get(IF_IDE, 0, 0);
-    if (!dinfo || dinfo->media_cd)
-        return;
-    md = dscm1xxxx_init(dinfo);
-    pxa2xx_pcmcia_attach(cpu->pcmcia[0], md);
-}
-
-/*
- * Encapsulation of some GPIO line behaviour for the Tosa board
- *
- * QEMU interface:
- *  + named GPIO inputs "leds[0..3]": assert to light LEDs
- *  + named GPIO input "reset": when asserted, resets the system
- */
-
-#define TYPE_TOSA_MISC_GPIO "tosa-misc-gpio"
-OBJECT_DECLARE_SIMPLE_TYPE(TosaMiscGPIOState, TOSA_MISC_GPIO)
-
-struct TosaMiscGPIOState {
-    SysBusDevice parent_obj;
-};
-
-static void tosa_reset(void *opaque, int line, int level)
-{
-    if (level) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    }
-}
-
-static void tosa_misc_gpio_init(Object *obj)
-{
-    DeviceState *dev = DEVICE(obj);
-
-    qdev_init_gpio_in_named(dev, tosa_reset, "reset", 1);
-}
-
-static void tosa_gpio_setup(PXA2xxState *cpu,
-                DeviceState *scp0,
-                DeviceState *scp1,
-                TC6393xbState *tmio)
-{
-    DeviceState *misc_gpio;
-    LEDState *led[4];
-
-    misc_gpio = sysbus_create_simple(TYPE_TOSA_MISC_GPIO, -1, NULL);
-
-    /* MMC/SD host */
-    pxa2xx_mmci_handlers(cpu->mmc,
-                    qdev_get_gpio_in(scp0, TOSA_GPIO_SD_WP),
-                    qemu_irq_invert(qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_nSD_DETECT)));
-
-    /* Handle reset */
-    qdev_connect_gpio_out(cpu->gpio, TOSA_GPIO_ON_RESET,
-                          qdev_get_gpio_in_named(misc_gpio, "reset", 0));
-
-    /* PCMCIA signals: card's IRQ and Card-Detect */
-    pxa2xx_pcmcia_set_irq_cb(cpu->pcmcia[0],
-                        qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_CF_IRQ),
-                        qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_CF_CD));
-
-    pxa2xx_pcmcia_set_irq_cb(cpu->pcmcia[1],
-                        qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_JC_CF_IRQ),
-                        NULL);
-
-    led[0] = led_create_simple(OBJECT(misc_gpio), GPIO_POLARITY_ACTIVE_HIGH,
-                               LED_COLOR_BLUE, "bluetooth");
-    led[1] = led_create_simple(OBJECT(misc_gpio), GPIO_POLARITY_ACTIVE_HIGH,
-                               LED_COLOR_GREEN, "note");
-    led[2] = led_create_simple(OBJECT(misc_gpio), GPIO_POLARITY_ACTIVE_HIGH,
-                               LED_COLOR_AMBER, "charger-error");
-    led[3] = led_create_simple(OBJECT(misc_gpio), GPIO_POLARITY_ACTIVE_HIGH,
-                               LED_COLOR_GREEN, "wlan");
-
-    qdev_connect_gpio_out(scp1, TOSA_GPIO_BT_LED,
-                          qdev_get_gpio_in(DEVICE(led[0]), 0));
-    qdev_connect_gpio_out(scp1, TOSA_GPIO_NOTE_LED,
-                          qdev_get_gpio_in(DEVICE(led[1]), 0));
-    qdev_connect_gpio_out(scp1, TOSA_GPIO_CHRG_ERR_LED,
-                          qdev_get_gpio_in(DEVICE(led[2]), 0));
-    qdev_connect_gpio_out(scp1, TOSA_GPIO_WLAN_LED,
-                          qdev_get_gpio_in(DEVICE(led[3]), 0));
-
-    qdev_connect_gpio_out(scp1, TOSA_GPIO_TC6393XB_L3V_ON, tc6393xb_l3v_get(tmio));
-
-    /* UDC Vbus */
-    qemu_irq_raise(qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_USB_IN));
-}
-
-static uint32_t tosa_ssp_tansfer(SSIPeripheral *dev, uint32_t value)
-{
-    fprintf(stderr, "TG: %u %02x\n", value >> 5, value & 0x1f);
-    return 0;
-}
-
-static void tosa_ssp_realize(SSIPeripheral *dev, Error **errp)
-{
-    /* Nothing to do.  */
-}
-
-#define TYPE_TOSA_DAC "tosa_dac"
-OBJECT_DECLARE_SIMPLE_TYPE(TosaDACState, TOSA_DAC)
-
-struct TosaDACState {
-    I2CSlave parent_obj;
-
-    int len;
-    char buf[3];
-};
-
-static int tosa_dac_send(I2CSlave *i2c, uint8_t data)
-{
-    TosaDACState *s = TOSA_DAC(i2c);
-
-    s->buf[s->len] = data;
-    if (s->len ++ > 2) {
-#ifdef VERBOSE
-        fprintf(stderr, "%s: message too long (%i bytes)\n", __func__, s->len);
-#endif
-        return 1;
-    }
-
-    if (s->len == 2) {
-        fprintf(stderr, "dac: channel %d value 0x%02x\n",
-                s->buf[0], s->buf[1]);
-    }
-
-    return 0;
-}
-
-static int tosa_dac_event(I2CSlave *i2c, enum i2c_event event)
-{
-    TosaDACState *s = TOSA_DAC(i2c);
-
-    s->len = 0;
-    switch (event) {
-    case I2C_START_SEND:
-        break;
-    case I2C_START_RECV:
-        printf("%s: recv not supported!!!\n", __func__);
-        break;
-    case I2C_FINISH:
-#ifdef VERBOSE
-        if (s->len < 2)
-            printf("%s: message too short (%i bytes)\n", __func__, s->len);
-        if (s->len > 2)
-            printf("%s: message too long\n", __func__);
-#endif
-        break;
-    default:
-        break;
-    }
-
-    return 0;
-}
-
-static uint8_t tosa_dac_recv(I2CSlave *s)
-{
-    printf("%s: recv not supported!!!\n", __func__);
-    return 0xff;
-}
-
-static void tosa_tg_init(PXA2xxState *cpu)
-{
-    I2CBus *bus = pxa2xx_i2c_bus(cpu->i2c[0]);
-    i2c_slave_create_simple(bus, TYPE_TOSA_DAC, DAC_BASE);
-    ssi_create_peripheral(cpu->ssp[1], "tosa-ssp");
-}
-
-
-static struct arm_boot_info tosa_binfo = {
-    .loader_start = PXA2XX_SDRAM_BASE,
-    .ram_size = 0x04000000,
-};
-
-static void tosa_init(MachineState *machine)
-{
-    MemoryRegion *address_space_mem = get_system_memory();
-    MemoryRegion *rom = g_new(MemoryRegion, 1);
-    PXA2xxState *mpu;
-    TC6393xbState *tmio;
-    DeviceState *scp0, *scp1;
-
-    mpu = pxa255_init(tosa_binfo.ram_size);
-
-    memory_region_init_rom(rom, NULL, "tosa.rom", TOSA_ROM, &error_fatal);
-    memory_region_add_subregion(address_space_mem, 0, rom);
-
-    tmio = tc6393xb_init(address_space_mem, 0x10000000,
-            qdev_get_gpio_in(mpu->gpio, TOSA_GPIO_TC6393XB_INT));
-
-    scp0 = sysbus_create_simple("scoop", 0x08800000, NULL);
-    scp1 = sysbus_create_simple("scoop", 0x14800040, NULL);
-
-    tosa_gpio_setup(mpu, scp0, scp1, tmio);
-
-    tosa_microdrive_attach(mpu);
-
-    tosa_tg_init(mpu);
-
-    tosa_binfo.board_id = 0x208;
-    arm_load_kernel(mpu->cpu, machine, &tosa_binfo);
-    sl_bootparam_write(SL_PXA_PARAM_BASE);
-}
-
-static void tosapda_machine_init(MachineClass *mc)
-{
-    mc->desc = "Sharp SL-6000 (Tosa) PDA (PXA255)";
-    mc->init = tosa_init;
-    mc->block_default_type = IF_IDE;
-    mc->ignore_memory_transaction_failures = true;
-    mc->deprecation_reason = "machine is old and unmaintained";
-}
-
-DEFINE_MACHINE("tosa", tosapda_machine_init)
-
-static void tosa_dac_class_init(ObjectClass *klass, void *data)
-{
-    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
-
-    k->event = tosa_dac_event;
-    k->recv = tosa_dac_recv;
-    k->send = tosa_dac_send;
-}
-
-static const TypeInfo tosa_dac_info = {
-    .name          = TYPE_TOSA_DAC,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_size = sizeof(TosaDACState),
-    .class_init    = tosa_dac_class_init,
-};
-
-static void tosa_ssp_class_init(ObjectClass *klass, void *data)
-{
-    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
-
-    k->realize = tosa_ssp_realize;
-    k->transfer = tosa_ssp_tansfer;
-}
-
-static const TypeInfo tosa_ssp_info = {
-    .name          = "tosa-ssp",
-    .parent        = TYPE_SSI_PERIPHERAL,
-    .instance_size = sizeof(SSIPeripheral),
-    .class_init    = tosa_ssp_class_init,
-};
-
-static const TypeInfo tosa_misc_gpio_info = {
-    .name          = TYPE_TOSA_MISC_GPIO,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(TosaMiscGPIOState),
-    .instance_init = tosa_misc_gpio_init,
-    /*
-     * No class init required: device has no internal state so does not
-     * need to set up reset or vmstate, and has no realize method.
-     */
-};
-
-static void tosa_register_types(void)
-{
-    type_register_static(&tosa_dac_info);
-    type_register_static(&tosa_ssp_info);
-    type_register_static(&tosa_misc_gpio_info);
-}
-
-type_init(tosa_register_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1ad60da7aa2..32c5e601d1c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -199,29 +199,6 @@ config GUMSTIX
     select SMC91C111
     select PXA2XX
 
-config TOSA
-    bool
-    default y
-    depends on TCG && ARM
-    select ZAURUS  # scoop
-    select MICRODRIVE
-    select PXA2XX
-    select LED
-
-config SPITZ
-    bool
-    default y
-    depends on TCG && ARM
-    select ADS7846 # touch-screen controller
-    select MAX111X # A/D converter
-    select WM8750  # audio codec
-    select MAX7310 # GPIO expander
-    select ZAURUS  # scoop
-    select NAND    # memory
-    select ECC     # Error-correcting for NAND
-    select MICRODRIVE
-    select PXA2XX
-
 config Z2
     bool
     default y
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 4059d0be2ea..5848887be17 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -73,10 +73,8 @@ system_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap2.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_peripherals.c'))
-system_ss.add(when: 'CONFIG_SPITZ', if_true: files('spitz.c'))
 system_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
 system_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
-system_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
 system_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 system_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 system_ss.add(when: 'CONFIG_Z2', if_true: files('z2.c'))
-- 
2.34.1


