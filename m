Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EDCC021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzLP-0004cP-QA; Tue, 25 Feb 2025 13:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJp-0000Lf-B1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:16 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJk-0002LA-66
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:07 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38f26a82d1dso3078564f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506752; x=1741111552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NAT95TVvrYX1s1kqx9WcG2o5ihOYgWa1KrXkA2LsnDU=;
 b=PTkxr0eWjZfqcDJDENTshIVFLWCRXENz8cZWIK7hBURAyCAnNuZk8vVtzkzLU2dzWz
 pc9/txtdQ620yQMPmmykxSd/OYSGmcA1n9RyH8Qs3hbQBsBcXRo5ZB7yfZd9WH2xu6xs
 MKeY1eR1/WrzTT528xjjIcFtxSXc/9qSfKI4vl9LXgbNmGdD0azMBkOFzdXD271qhrKm
 vwdvQOv7lSUwxmOekTi2YhklM2znepQ7MuhHI/ViPf1wkSLSBBS4YQ8czmoPFpcrKasI
 k32wgR+zdnYc030j4wO4uq4XZT+csvIOeABFXjrQ3Su+abipuTf8WXFrR7y4BdfK0Y3N
 NJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506752; x=1741111552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NAT95TVvrYX1s1kqx9WcG2o5ihOYgWa1KrXkA2LsnDU=;
 b=kx7QPiDWOriPOOlcEKSW+0v1EKd0ldj1rLDsB8yoqdX3YOnZwqx/zgeOKaD3/GoMF+
 WE9su8ISa/XR6oRwcXj3rtBFUW2lwWm2JZaktNsQ4wTjqp/yexCT/xXx3uPsZ2VXj6yt
 AjnfMa+SooIsTgBrtJsqeBcx0UunIFGV4CwrdYsMF1KTlUl+6Q4KNLEazp0HY++/rjhG
 Ej6QFLkQXb85zXoqO/56U1MOLlRjGLzaiZRrw/UKanh+EJe0DocBJip9ybhLtv4IUtp6
 /J4RkOnbhiAtzhiyXs1tEkqjcaCoLx3YdLxXKrgC20iV6ltc5D5jSigCBT4fTNdTLuLD
 JRqQ==
X-Gm-Message-State: AOJu0YwFJkgFs7W81aTQty82bgbLdBOy9404fcbCn2bOPgWxV1CBCa5G
 1FZX7JYSS0nCEOBzTnqIgLgjHcsKQ/YPaXCGyMJ9O29mhuJs4ypWslXipe17rNo6pPcXVLs1Zi+
 d
X-Gm-Gg: ASbGncsRiAMFJZuRFa7N8cfLy8rRPNF/YWsQXtidtcH+8+wVXUI4E5ttvMLmqWLgCbN
 AoFGgaKKvNI0Ss/b9OdjXzPGHD4US2HykVz7FkGlJNNMGLiThgO2tz904OX2XfDFNUJS8HO3PyJ
 cK+wzzQU47TuUplk0jTZzq3eglqhsi4x+SGJJntC6kjbI7ggQkPV3jMoLEnGyyw/uHql9KyW+oM
 Hf1jCPtFIwr7NbUeiRAd3rtaPztjtjWZj58q/z3rS234g+blWOWEnUJYDTXyFFstJArq/0Lq4E4
 59GHjQWIAOrlZE9L4OovUplfMwd9Gq2S
X-Google-Smtp-Source: AGHT+IEC4V6zIw5K2OVX2fFG1aZl767gaZwMKrKKLJHmc5/4o67evNzpDBR3ORJTr4Q4L3XJvp8o7w==
X-Received: by 2002:a5d:4b51:0:b0:38f:2bd2:45d0 with SMTP id
 ffacd0b85a97d-390cc638d9emr2949177f8f.51.1740506751769; 
 Tue, 25 Feb 2025 10:05:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/43] hw/arm/fsl-imx8mp: Add USDHC storage controllers
Date: Tue, 25 Feb 2025 18:05:00 +0000
Message-ID: <20250225180510.1318207-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The USDHC emulation allows for running real-world images such as those generated
by Buildroot. Convert the board documentation accordingly instead of running a
Linux kernel with ephemeral storage.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250223114708.1780-8-shentey@gmail.com
[PMM: drop 'static const' from usdhc_table[] for GCC 7.5]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/imx8mp-evk.rst | 18 ++++++++++++------
 include/hw/arm/fsl-imx8mp.h    |  7 +++++++
 hw/arm/fsl-imx8mp.c            | 28 ++++++++++++++++++++++++++++
 hw/arm/imx8mp-evk.c            | 18 ++++++++++++++++++
 hw/arm/Kconfig                 |  1 +
 5 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 22541c54424..879c822356f 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -12,6 +12,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * Up to 4 Cortex-A53 cores
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
+ * 3 USDHC Storage Controllers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
@@ -26,18 +27,23 @@ Direct Linux Kernel Boot
 
 Probably the easiest way to get started with a whole Linux system on the machine
 is to generate an image with Buildroot. Version 2024.11.1 is tested at the time
-of writing and involves two steps. First run the following commands in the
+of writing and involves three steps. First run the following commands in the
 toplevel directory of the Buildroot source tree:
 
 .. code-block:: bash
 
-  $ echo "BR2_TARGET_ROOTFS_CPIO=y" >> configs/freescale_imx8mpevk_defconfig
   $ make freescale_imx8mpevk_defconfig
   $ make
 
 Once finished successfully there is an ``output/image`` subfolder. Navigate into
-it and patch the device tree with the following commands which will remove the
-``cpu-idle-states`` properties from CPU nodes:
+it and resize the SD card image to a power of two:
+
+.. code-block:: bash
+
+  $ qemu-img resize sdcard.img 256M
+
+Finally, the device tree needs to be patched with the following commands which
+will remove the ``cpu-idle-states`` properties from CPU nodes:
 
 .. code-block:: bash
 
@@ -52,5 +58,5 @@ Now that everything is prepared the machine can be started as follows:
       -display none -serial null -serial stdio \
       -kernel Image \
       -dtb imx8mp-evk-patched.dtb \
-      -initrd rootfs.cpio \
-      -append "root=/dev/ram"
+      -append "root=/dev/mmcblk2p2" \
+      -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 26e24e99a15..349d55ca88d 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -15,6 +15,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/sd/sdhci.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -28,6 +29,7 @@ enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CPUS         = 4,
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
+    FSL_IMX8MP_NUM_USDHCS       = 3,
 };
 
 struct FslImx8mpState {
@@ -39,6 +41,7 @@ struct FslImx8mpState {
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
+    SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
 };
 
 enum FslImx8mpMemoryRegions {
@@ -184,6 +187,10 @@ enum FslImx8mpMemoryRegions {
 };
 
 enum FslImx8mpIrqs {
+    FSL_IMX8MP_USDHC1_IRQ   = 22,
+    FSL_IMX8MP_USDHC2_IRQ   = 23,
+    FSL_IMX8MP_USDHC3_IRQ   = 24,
+
     FSL_IMX8MP_UART1_IRQ    = 26,
     FSL_IMX8MP_UART2_IRQ    = 27,
     FSL_IMX8MP_UART3_IRQ    = 28,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 18c9c54ddc6..da9eaeb6ff0 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -207,6 +207,11 @@ static void fsl_imx8mp_init(Object *obj)
         g_autofree char *name = g_strdup_printf("uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
+
+    for (i = 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
+        g_autofree char *name = g_strdup_printf("usdhc%d", i + 1);
+        object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
+    }
 }
 
 static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
@@ -346,6 +351,28 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* USDHCs */
+    for (i = 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
+        struct {
+            hwaddr addr;
+            unsigned int irq;
+        } usdhc_table[FSL_IMX8MP_NUM_USDHCS] = {
+            { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC1].addr, FSL_IMX8MP_USDHC1_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC2].addr, FSL_IMX8MP_USDHC2_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC3].addr, FSL_IMX8MP_USDHC3_IRQ },
+        };
+
+        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
+                                 SDHCI_VENDOR_IMX, &error_abort);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0, usdhc_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
+                           qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
+    }
+
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
         return;
@@ -363,6 +390,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_RAM:
         case FSL_IMX8MP_SNVS_HP:
         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
+        case FSL_IMX8MP_USDHC1 ... FSL_IMX8MP_USDHC3:
             /* device implemented and treated above */
             break;
 
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 2756d4c21c8..27d9e9e8eed 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -11,6 +11,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/fsl-imx8mp.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "system/qtest.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -40,6 +41,23 @@ static void imx8mp_evk_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
                                 machine->ram);
 
+    for (int i = 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
+        BusState *bus;
+        DeviceState *carddev;
+        BlockBackend *blk;
+        DriveInfo *di = drive_get(IF_SD, i, 0);
+
+        if (!di) {
+            continue;
+        }
+
+        blk = blk_by_legacy_dinfo(di);
+        bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
+        carddev = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
+        qdev_realize_and_unref(carddev, bus, &error_fatal);
+    }
+
     if (!qtest_enabled()) {
         arm_load_kernel(&s->cpu[0], machine, &boot_info);
     }
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f77c451ba39..d2dda3213db 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -599,6 +599,7 @@ config FSL_IMX8MP
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
+    select SDHCI
     select UNIMP
 
 config FSL_IMX8MP_EVK
-- 
2.43.0


