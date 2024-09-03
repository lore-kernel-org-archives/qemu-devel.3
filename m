Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59383CD3448
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW4z-0006RD-H6; Tue, 03 Sep 2024 12:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4n-0005ep-EQ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:18 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4i-0002jI-PZ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:16 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-53438aa64a4so6717039e87.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379691; x=1725984491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kb2hlNOkuGqsXxdmbrthsU/1g1vBxCB4j6840EtQwyY=;
 b=WajZzY5nG4iXstZ2ezhqOrVe+NcVtzKL5TnaWGFCyKsC1q9SCkubW+dlonKU9nLIWK
 diObgU0h2ggcJv6HffYAdYdDS0k1kjbqmq7fmjU7nfns0Y2vUBlEOTmjwlWe6WSpccDs
 Xy5pO89bWSgQTIgSSzT2K752vYCb6APYzlO9hyRu5EcRDRj0tjCxo3veOY07tJzFry86
 TChXbm85RHInX0BSkS9YY8odgC4qQu8GMq4/g/taxddkUVhM/eVvDo33eHL90AUMQ14k
 fdwn3FlIWpFqe1XLdCYvrQIC6Mvr2qHflpcYY+4l32LWLb4W+5wmuZqv14HLpg1FllQq
 C2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379691; x=1725984491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kb2hlNOkuGqsXxdmbrthsU/1g1vBxCB4j6840EtQwyY=;
 b=dhOYl3Kmpa1/dUkgynv/llRZ90ZD+LdYQ2Mt4sD3im2TMqm9eEBOg1FG/lglL4DNtj
 oShqG4xi8fcBEOgx966TQDBKbG9nJJY+dYbV3xa82dmx4cCK1eAJCBT5Dus5GbRHEJZu
 5Ur5G5gSMcGwQYRaOPQoupGgk5oIdirCpTnJw6bsXcHtK5gmJmWZrfZ5pk2C6rQR0+48
 FlefGmu4VCfSeb3WNreIURS3q1o+Qypi3IHBi5uZwQcedQNE/48CIzsfAoj+13wDoxEM
 9s8j9ipPtx27V1lhhULCjzbBnf0LpCfo9dFt2yBo4u48vhaaAjH+TYUGU6Zvjs3rQUtp
 kqHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF4WUE3ELbXeLwcsOiCMlRI1s2YrNVrncUZAvfhLL8cqHyA9fA9FrNwkLBf2uUUr7rCRsHgUcRdmG/@nongnu.org
X-Gm-Message-State: AOJu0Yyd4YHcSwAq8+y9gOBg55aCkdvDFOIGypzviX5+hzyXIbH/Z2Gf
 kwdyR9pDWcj8qhmu8+OwGK54Ba7L9clCDtsCYGsobraFpp5Na46JdThpAbc1v5e0hvovIBwFgE8
 C
X-Google-Smtp-Source: AGHT+IHrm2DsB4tKBWaFfPgtNsz4fOEYgQGYNQvN6Bq1pK/ghza3nG7qCHbXTGt2GSp1y3oNNzzMdg==
X-Received: by 2002:a05:6512:2346:b0:52c:dc25:d706 with SMTP id
 2adb3069b0e04-53546b9b8e8mr10968870e87.52.1725379690624; 
 Tue, 03 Sep 2024 09:08:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 09/53] hw/arm: Remove 'connex' and 'verdex' machines
Date: Tue,  3 Sep 2024 17:07:07 +0100
Message-Id: <20240903160751.4100218-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index cf297e6d626..13685711f61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -743,14 +743,6 @@ S: Maintained
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
index 4a8fd54586b..7b474ad518b 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -64,7 +64,6 @@ arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_COLLIE', if_true: files('collie.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
-system_ss.add(when: 'CONFIG_GUMSTIX', if_true: files('gumstix.c'))
 system_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap2.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
-- 
2.34.1


