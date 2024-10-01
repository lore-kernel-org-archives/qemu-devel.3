Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8552CEACE7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuP-0005MV-Sc; Tue, 01 Oct 2024 12:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuO-0005Kt-0b
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:32 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuK-00061v-NG
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:31 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37cd831ab06so2261598f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800767; x=1728405567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5s9Yhc6WePnm5jACFBQjH8puspUYA1WJOK7FySZGVZ4=;
 b=hOxh/w1FYiqpuoTuhmBE3tVPsNDtSgO4COdZzPgOJKYE1t08Li3TnCtWguXO0GAceB
 5ZSMkuL4PLV4VSwCrBMEPx9/GvYbgmVsjfj1Q73FcH5hx29nAA+h2tP//Lk+l1/fBgIi
 mUVA6evBAB5VDKGbRSvZLij0k2HMTeGsdwv4qPffT4XPzY/rRqFHmgNBOFTgOIMDbFys
 PdL87AHzWydoJ9dH1LeZ2wL/zJscAse4tHYMGH4BoJUQxp4qiBdtmbwLUJ31G07UT/9I
 wl+h5/FiOlUmdH9lapCZ3EUZg9Z4/s5L6Rux+dToSuJuTwZnZbN5S+L72ewq5Kr2XpOe
 VI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800767; x=1728405567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5s9Yhc6WePnm5jACFBQjH8puspUYA1WJOK7FySZGVZ4=;
 b=wukLLuAu3eNf2u3B0O+qWbY8qNBaGW02edk7gkJjdk0VwRQ9X8+pPTkgCSy7H5NYuJ
 1Din/7XX7x6l+UN4hAStedKEoLOa2WQNqLEQ99ni3POYMt3Fh3/UTfUqHPLuE0f8lEWY
 dYFTN6tkelQgXvgqhbriWplOC/I94/XuASSTVXG0j4jflP6vSn5A1vFyYU3rncwhUsVh
 o+vqfpwL2ulgv2mVq91yc5sRwjSqw8vPUk3832ornmqjpZl8xErWRl78SpT3TMLwKNlP
 /6smS3khWj0SNqxGWhZvcVyT7LSJH/DPSM38HRbU8AhbnpxJkYEYDjG56/fume+bHjci
 +jDA==
X-Gm-Message-State: AOJu0Yzh1Rwzly5VjK0ZApTkkziHTQR/smalV/G0dRYnds6PIs1EAv8W
 ZE3ES2Yxz87befKeVjJcZbl/Sj82LDlCTmLR1aWekOB+XJzHaZMNJk6uzfrAGQYxJwvU9um8JE8
 C
X-Google-Smtp-Source: AGHT+IGNYeKJgTrhl843/kdDNBkvrIdNeUlKcNLJuOYypSHYVShLVeuJN9ws4cUOiWmaQbiMckUOYA==
X-Received: by 2002:adf:e7c4:0:b0:37c:c80e:d030 with SMTP id
 ffacd0b85a97d-37cfba0a72bmr145575f8f.53.1727800767148; 
 Tue, 01 Oct 2024 09:39:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/54] hw/arm: Remove 'connex' and 'verdex' machines
Date: Tue,  1 Oct 2024 17:38:37 +0100
Message-Id: <20241001163918.1275441-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

The connex and verdex machines have been deprecated since
9.0 and so can be removed for the 9.2 release.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-10-peter.maydell@linaro.org
---
 MAINTAINERS                             |   8 --
 docs/system/arm/gumstix.rst             |  21 ----
 docs/system/target-arm.rst              |   1 -
 configs/devices/arm-softmmu/default.mak |   1 -
 hw/arm/gumstix.c                        | 141 ------------------------
 hw/arm/Kconfig                          |   8 --
 hw/arm/meson.build                      |   1 -
 7 files changed, 181 deletions(-)
 delete mode 100644 docs/system/arm/gumstix.rst
 delete mode 100644 hw/arm/gumstix.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 16de5c67e1c..329fea2bf04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -750,14 +750,6 @@ S: Maintained
 F: hw/rtc/goldfish_rtc.c
 F: include/hw/rtc/goldfish_rtc.h
 
-Gumstix
-M: Peter Maydell <peter.maydell@linaro.org>
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
-L: qemu-arm@nongnu.org
-S: Odd Fixes
-F: hw/arm/gumstix.c
-F: docs/system/arm/gumstix.rst
-
 i.MX25 PDK
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Jean-Christophe Dubois <jcd@tribudubois.net>
diff --git a/docs/system/arm/gumstix.rst b/docs/system/arm/gumstix.rst
deleted file mode 100644
index cb373139dcb..00000000000
--- a/docs/system/arm/gumstix.rst
+++ /dev/null
@@ -1,21 +0,0 @@
-Gumstix Connex and Verdex (``connex``, ``verdex``)
-==================================================
-
-These machines model the Gumstix Connex and Verdex boards.
-The Connex has a PXA255 CPU and the Verdex has a PXA270.
-
-Implemented devices:
-
- * NOR flash
- * SMC91C111 ethernet
- * Interrupt controller
- * DMA
- * Timer
- * GPIO
- * MMC/SD card
- * Fast infra-red communications port (FIR)
- * LCD controller
- * Synchronous serial ports (SPI)
- * PCMCIA interface
- * I2C
- * I2S
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index fde37385224..ddaf1675dcc 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -91,7 +91,6 @@ undocumented; you can get a complete list by running
    arm/cubieboard
    arm/emcraft-sf2
    arm/musicpal
-   arm/gumstix
    arm/mainstone
    arm/kzm
    arm/nseries
diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
index 6ed821be220..490ef4b3943 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -28,7 +28,6 @@
 # CONFIG_VEXPRESS=n
 # CONFIG_ZYNQ=n
 # CONFIG_MAINSTONE=n
-# CONFIG_GUMSTIX=n
 # CONFIG_Z2=n
 # CONFIG_NPCM7XX=n
 # CONFIG_COLLIE=n
diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
deleted file mode 100644
index 91462691531..00000000000
--- a/hw/arm/gumstix.c
+++ /dev/null
@@ -1,141 +0,0 @@
-/*
- * Gumstix Platforms
- *
- * Copyright (c) 2007 by Thorsten Zitterell <info@bitmux.org>
- *
- * Code based on spitz platform by Andrzej Zaborowski <balrog@zabor.org>
- *
- * This code is licensed under the GNU GPL v2.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-/* 
- * Example usage:
- * 
- * connex:
- * =======
- * create image:
- * # dd of=flash bs=1k count=16k if=/dev/zero
- * # dd of=flash bs=1k conv=notrunc if=u-boot.bin
- * # dd of=flash bs=1k conv=notrunc seek=256 if=rootfs.arm_nofpu.jffs2
- * start it:
- * # qemu-system-arm -M connex -pflash flash -monitor null -nographic
- *
- * verdex:
- * =======
- * create image:
- * # dd of=flash bs=1k count=32k if=/dev/zero
- * # dd of=flash bs=1k conv=notrunc if=u-boot.bin
- * # dd of=flash bs=1k conv=notrunc seek=256 if=rootfs.arm_nofpu.jffs2
- * # dd of=flash bs=1k conv=notrunc seek=31744 if=uImage
- * start it:
- * # qemu-system-arm -M verdex -pflash flash -monitor null -nographic -m 289
- */
-
-#include "qemu/osdep.h"
-#include "qemu/units.h"
-#include "qemu/error-report.h"
-#include "hw/arm/pxa.h"
-#include "net/net.h"
-#include "hw/block/flash.h"
-#include "hw/net/smc91c111.h"
-#include "hw/boards.h"
-#include "exec/address-spaces.h"
-#include "sysemu/qtest.h"
-
-#define CONNEX_FLASH_SIZE   (16 * MiB)
-#define CONNEX_RAM_SIZE     (64 * MiB)
-
-#define VERDEX_FLASH_SIZE   (32 * MiB)
-#define VERDEX_RAM_SIZE     (256 * MiB)
-
-#define FLASH_SECTOR_SIZE   (128 * KiB)
-
-static void connex_init(MachineState *machine)
-{
-    PXA2xxState *cpu;
-    DriveInfo *dinfo;
-
-    cpu = pxa255_init(CONNEX_RAM_SIZE);
-
-    dinfo = drive_get(IF_PFLASH, 0, 0);
-    if (!dinfo && !qtest_enabled()) {
-        error_report("A flash image must be given with the "
-                     "'pflash' parameter");
-        exit(1);
-    }
-
-    /* Numonyx RC28F128J3F75 */
-    pflash_cfi01_register(0x00000000, "connext.rom", CONNEX_FLASH_SIZE,
-                          dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          FLASH_SECTOR_SIZE, 2, 0, 0, 0, 0, 0);
-
-    /* Interrupt line of NIC is connected to GPIO line 36 */
-    smc91c111_init(0x04000300, qdev_get_gpio_in(cpu->gpio, 36));
-}
-
-static void verdex_init(MachineState *machine)
-{
-    PXA2xxState *cpu;
-    DriveInfo *dinfo;
-
-    cpu = pxa270_init(VERDEX_RAM_SIZE, machine->cpu_type);
-
-    dinfo = drive_get(IF_PFLASH, 0, 0);
-    if (!dinfo && !qtest_enabled()) {
-        error_report("A flash image must be given with the "
-                     "'pflash' parameter");
-        exit(1);
-    }
-
-    /* Micron RC28F256P30TFA */
-    pflash_cfi01_register(0x00000000, "verdex.rom", VERDEX_FLASH_SIZE,
-                          dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                          FLASH_SECTOR_SIZE, 2, 0, 0, 0, 0, 0);
-
-    /* Interrupt line of NIC is connected to GPIO line 99 */
-    smc91c111_init(0x04000300, qdev_get_gpio_in(cpu->gpio, 99));
-}
-
-static void connex_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-
-    mc->desc = "Gumstix Connex (PXA255)";
-    mc->init = connex_init;
-    mc->ignore_memory_transaction_failures = true;
-    mc->deprecation_reason = "machine is old and unmaintained";
-}
-
-static const TypeInfo connex_type = {
-    .name = MACHINE_TYPE_NAME("connex"),
-    .parent = TYPE_MACHINE,
-    .class_init = connex_class_init,
-};
-
-static void verdex_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-
-    mc->desc = "Gumstix Verdex Pro XL6P COMs (PXA270)";
-    mc->init = verdex_init;
-    mc->ignore_memory_transaction_failures = true;
-    mc->deprecation_reason = "machine is old and unmaintained";
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c0");
-}
-
-static const TypeInfo verdex_type = {
-    .name = MACHINE_TYPE_NAME("verdex"),
-    .parent = TYPE_MACHINE,
-    .class_init = verdex_class_init,
-};
-
-static void gumstix_machine_init(void)
-{
-    type_register_static(&connex_type);
-    type_register_static(&verdex_type);
-}
-
-type_init(gumstix_machine_init)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3261618ea74..d3e07262b14 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -184,14 +184,6 @@ config PXA2XX
     select USB_OHCI_SYSBUS
     select PCMCIA
 
-config GUMSTIX
-    bool
-    default y
-    depends on TCG && ARM
-    select PFLASH_CFI01
-    select SMC91C111
-    select PXA2XX
-
 config Z2
     bool
     default y
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index ae8d49f00f7..565d6a5f28e 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -67,7 +67,6 @@ arm_ss.add(when: 'CONFIG_XEN', if_true: files(
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_COLLIE', if_true: files('collie.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
-system_ss.add(when: 'CONFIG_GUMSTIX', if_true: files('gumstix.c'))
 system_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap2.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
-- 
2.34.1


