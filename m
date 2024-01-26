Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65331C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHN-0002Tl-E4; Fri, 26 Jan 2024 09:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHK-0002Oy-M3
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:58 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHI-0007yZ-GN
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:58 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-337d58942c9so555971f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279635; x=1706884435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wxNpb57lzKyDUqz5nfLTlsDm3aDJ+DN5wdvRGUfEGN4=;
 b=REzn6rKAosMrgSryymnl3TAeP4+CSShGJ/tkYAT+UII+i4u4Z5pb3rzzKf+uL0UWf3
 QnuaHL0Ip2aaKEj83ejuAs+lhQOBOqVKSP8taQlzSVRnZmrxplyYHpCFXhJadbTHt9KS
 xV0r+ASAXmbNiwv79Fq59Lc0ImJ5VdzQ5agvQYI21d112j7C4Br8adNV9E/iF1a7ciwO
 4xD53djt8WjYoe+wccvbg/lUNs3hAYbyfDNEDUlWjWM3XH1+WHOriHjwSzIWP8FUiMg6
 0SVgZPr7TG5uNkKdrHjD1xAfwXUSd1NdhwNZpGalm+0T7GVkfvWjVILbTndsa1BdBf9h
 ACKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279635; x=1706884435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxNpb57lzKyDUqz5nfLTlsDm3aDJ+DN5wdvRGUfEGN4=;
 b=BDWlOvl2mAfqFgcJ7tEuVJyszcRWT9QfzoPFNkayhxAtt83UttjB7PH26/RuZsXXe4
 +TvJ5dBOD0TwxGFWMALIybrd76o/XXiw0aY5y1k39zd4AYG2Z8JXb29PiTawxr8wlpWi
 dkwQXD044KY9KoYFkxQk60FrxvaoxMfnIQSl5e9JbUQjYcHrDlr83GnquXQtO6X5bDLJ
 oINEvNMSONylOsPLSEOjnzWYRTn/AT8AULOGlBv4ZKcD4otH+TZrzx3lAu0iNuiho2Su
 YaoyuIr2cBm53luwcbUhuKqTRRmF9m7+gbhOiqB9E7hkXrcKYaAS9fFDkOmBvl8FOXtx
 EA4Q==
X-Gm-Message-State: AOJu0YxfTj2pUbq0LpwPB8aPb7D0p14/pVjOWBFZwWUSA5SkXxskPf+a
 LPOdd3uwmKT7p7MCiZael3ReLwZ/UcZGHHG6j2w+3qilqZAS2i/zxes3Y9lRXPjEjpDToG35ZXE
 Y
X-Google-Smtp-Source: AGHT+IFUXzwvvChInzHxupbVq2/JM4/22ZXMNN5FZHhi0NwQ+f+fNlFrPkmS0YPfS6ynOIyOvKyJdA==
X-Received: by 2002:a5d:660a:0:b0:339:2ba9:dda2 with SMTP id
 n10-20020a5d660a000000b003392ba9dda2mr953308wru.116.1706279635098; 
 Fri, 26 Jan 2024 06:33:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/36] hw/arm: Build various units only once
Date: Fri, 26 Jan 2024 14:33:34 +0000
Message-Id: <20240126143341.2101237-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Various files in hw/arm/ don't require "cpu.h" anymore.
Except virt-acpi-build.c, all of them don't require any
ARM specific knowledge anymore and can be build once as
target agnostic units. Update meson accordingly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-21-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/collie.c           |  1 -
 hw/arm/gumstix.c          |  1 -
 hw/arm/integratorcp.c     |  1 -
 hw/arm/mainstone.c        |  1 -
 hw/arm/musicpal.c         |  1 -
 hw/arm/omap2.c            |  1 -
 hw/arm/omap_sx1.c         |  1 -
 hw/arm/palm.c             |  1 -
 hw/arm/spitz.c            |  1 -
 hw/arm/strongarm.c        |  1 -
 hw/arm/versatilepb.c      |  1 -
 hw/arm/vexpress.c         |  1 -
 hw/arm/virt-acpi-build.c  |  1 -
 hw/arm/xilinx_zynq.c      |  1 -
 hw/arm/xlnx-versal-virt.c |  1 -
 hw/arm/z2.c               |  1 -
 hw/arm/meson.build        | 23 ++++++++++++-----------
 17 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index a0ad1b8dc7e..eaa5c52d45a 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -17,7 +17,6 @@
 #include "hw/arm/boot.h"
 #include "hw/block/flash.h"
 #include "exec/address-spaces.h"
-#include "cpu.h"
 #include "qom/object.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index 2ca4140c9fc..3f2bcaa24e4 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -44,7 +44,6 @@
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
-#include "cpu.h"
 
 #define CONNEX_FLASH_SIZE   (16 * MiB)
 #define CONNEX_RAM_SIZE     (64 * MiB)
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 5600616a4dd..793262eca8c 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -9,7 +9,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/boards.h"
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index 68329c46178..fc14e050608 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -23,7 +23,6 @@
 #include "hw/block/flash.h"
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
-#include "cpu.h"
 
 /* Device addresses */
 #define MST_FPGA_PHYS	0x08000000
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index a2d25139e20..0fe0160b48b 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -12,7 +12,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index f159fb73ea9..d9683276c68 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "cpu.h"
 #include "exec/address-spaces.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/qtest.h"
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 4bf1579f8c1..62d7915fb8f 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -35,7 +35,6 @@
 #include "hw/block/flash.h"
 #include "sysemu/qtest.h"
 #include "exec/address-spaces.h"
-#include "cpu.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index b86f2c331bb..8c4c8316140 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -29,7 +29,6 @@
 #include "hw/input/tsc2xxx.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
-#include "cpu.h"
 #include "qemu/cutils.h"
 #include "qom/object.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 1d680b61e24..643a02b1807 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -33,7 +33,6 @@
 #include "hw/adc/max111x.h"
 #include "migration/vmstate.h"
 #include "exec/address-spaces.h"
-#include "cpu.h"
 #include "qom/object.h"
 #include "audio/audio.h"
 
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 75637869cba..7fd99a0f144 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -28,7 +28,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 15b5ed0cedc..1d813aa23b5 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -9,7 +9,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 49dbcdcbf0c..f1b45245d5d 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
-#include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 43ccc60f43c..17aeec7a6f5 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -32,7 +32,6 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/core/cpu.h"
-#include "target/arm/cpu.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
 #include "hw/nvram/fw_cfg_acpi.h"
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 5809fc32af9..66d0de139f2 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -18,7 +18,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "net/net.h"
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 29f4d2c2dce..94942c55dff 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -16,7 +16,6 @@
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "hw/arm/fdt.h"
-#include "cpu.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/xlnx-versal.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 83741a49092..a67fba2cfd2 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -25,7 +25,6 @@
 #include "hw/audio/wm8750.h"
 #include "audio/audio.h"
 #include "exec/address-spaces.h"
-#include "cpu.h"
 #include "qom/object.h"
 #include "qapi/error.h"
 
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index bb92b27db3e..c4017790670 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -9,23 +9,14 @@ arm_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
 arm_ss.add(when: 'CONFIG_MAINSTONE', if_true: files('mainstone.c'))
 arm_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
 arm_ss.add(when: 'CONFIG_MUSICPAL', if_true: files('musicpal.c'))
-arm_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
 arm_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
 arm_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
 arm_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
 arm_ss.add(when: 'CONFIG_NSERIES', if_true: files('nseries.c'))
-arm_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
-arm_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
-arm_ss.add(when: 'CONFIG_GUMSTIX', if_true: files('gumstix.c'))
-arm_ss.add(when: 'CONFIG_SPITZ', if_true: files('spitz.c'))
-arm_ss.add(when: 'CONFIG_Z2', if_true: files('z2.c'))
 arm_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
 arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
 arm_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
 arm_ss.add(when: 'CONFIG_STM32VLDISCOVERY', if_true: files('stm32vldiscovery.c'))
-arm_ss.add(when: 'CONFIG_COLLIE', if_true: files('collie.c'))
-arm_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
-arm_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 arm_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xilinx_zynq.c'))
 arm_ss.add(when: 'CONFIG_SABRELITE', if_true: files('sabrelite.c'))
 
@@ -33,8 +24,7 @@ arm_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m.c'))
 arm_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210.c'))
 arm_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx.c', 'pxa2xx_gpio.c', 'pxa2xx_pic.c'))
 arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic.c'))
-arm_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c', 'omap2.c'))
-arm_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
+arm_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubieboard.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
@@ -69,8 +59,19 @@ arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
+system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
+system_ss.add(when: 'CONFIG_COLLIE', if_true: files('collie.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
+system_ss.add(when: 'CONFIG_GUMSTIX', if_true: files('gumstix.c'))
+system_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
+system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap2.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
+system_ss.add(when: 'CONFIG_SPITZ', if_true: files('spitz.c'))
+system_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
+system_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 system_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
+system_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
+system_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
+system_ss.add(when: 'CONFIG_Z2', if_true: files('z2.c'))
 
 hw_arch += {'arm': arm_ss}
-- 
2.34.1


