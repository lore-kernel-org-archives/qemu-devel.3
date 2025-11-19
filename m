Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886A9CF34A1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 13:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLho6-0001aV-Kc; Wed, 19 Nov 2025 08:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vLhnZ-0001Hf-Nx
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:00:39 -0500
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vLhnW-0002Ae-62
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:00:37 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 92A571A3BCD;
 Wed, 19 Nov 2025 14:00:31 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B6701A3BC8;
 Wed, 19 Nov 2025 14:00:31 +0100 (CET)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7E2801800253;
 Wed, 19 Nov 2025 21:00:30 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv3 04/13] hw/arm/fsl-imx8mm: Adding support for USDHC storage
 controllers
Date: Wed, 19 Nov 2025 18:30:18 +0530
Message-Id: <20251119130027.3312971-5-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.13;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva020.nxp.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It enables emulation of SD/MMC cards through a virtual SDHCI interface
The emulated SDHCI controller allows guest OS to use emulated storage as
a standard block device.
This will allow running the images such as those generated
by Buildroot.

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 docs/system/arm/imx8mm-evk.rst |  1 +
 hw/arm/Kconfig                 |  1 +
 hw/arm/fsl-imx8mm.c            | 25 +++++++++++++++++++++++++
 hw/arm/imx8mm-evk.c            | 17 +++++++++++++++++
 include/hw/arm/fsl-imx8mm.h    |  7 +++++++
 5 files changed, 51 insertions(+)

diff --git a/docs/system/arm/imx8mm-evk.rst b/docs/system/arm/imx8mm-evk.rst
index 231dae6624..f379a1cc97 100644
--- a/docs/system/arm/imx8mm-evk.rst
+++ b/docs/system/arm/imx8mm-evk.rst
@@ -12,6 +12,7 @@ The ``imx8mm-evk`` machine implements the following devices:
  * Up to 4 Cortex-A53 cores
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
+ * 3 USDHC Storage Controllers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 314ffcd315..b5eb6553f5 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -632,6 +632,7 @@ config FSL_IMX8MM
     select FSL_IMX8MM_ANALOG
     select FSL_IMX8MM_CCM
     select IMX
+    select SDHCI
 
 config FSL_IMX8MM_EVK
     bool
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 4ca5dd0af1..0c42fd16f2 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -177,6 +177,10 @@ static void fsl_imx8mm_init(Object *obj)
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
+    for (i = 0; i < FSL_IMX8MM_NUM_USDHCS; i++) {
+        g_autofree char *name = g_strdup_printf("usdhc%d", i + 1);
+        object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
+    }
 }
 
 static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
@@ -342,6 +346,26 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* USDHCs */
+    for (i = 0; i < FSL_IMX8MM_NUM_USDHCS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } usdhc_table[FSL_IMX8MM_NUM_USDHCS] = {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_USDHC1].addr, FSL_IMX8MM_USDHC1_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_USDHC2].addr, FSL_IMX8MM_USDHC2_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_USDHC3].addr, FSL_IMX8MM_USDHC3_IRQ },
+        };
+
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
@@ -359,6 +383,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_RAM:
         case FSL_IMX8MM_SNVS_HP:
         case FSL_IMX8MM_UART1 ... FSL_IMX8MM_UART4:
+        case FSL_IMX8MM_USDHC1 ... FSL_IMX8MM_USDHC3:
             /* device implemented and treated above */
             break;
 
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 82751dad7d..1366f84d4a 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -83,6 +83,23 @@ static void imx8mm_evk_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MM_RAM_START,
                                 machine->ram);
 
+    for (int i = 0; i < FSL_IMX8MM_NUM_USDHCS; i++) {
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
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 4fd11798a5..985a0a5571 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -15,6 +15,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mm_analog.h"
 #include "hw/misc/imx8mm_ccm.h"
+#include "hw/sd/sdhci.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -28,6 +29,7 @@ enum FslImx8mmConfiguration {
     FSL_IMX8MM_NUM_CPUS         = 4,
     FSL_IMX8MM_NUM_IRQS         = 128,
     FSL_IMX8MM_NUM_UARTS        = 4,
+    FSL_IMX8MM_NUM_USDHCS       = 3,
 };
 
 struct FslImx8mmState {
@@ -39,6 +41,7 @@ struct FslImx8mmState {
     IMX8MMAnalogState  analog;
     IMX7SNVSState      snvs;
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
+    SDHCIState         usdhc[FSL_IMX8MM_NUM_USDHCS];
 };
 
 enum FslImx8mmMemoryRegions {
@@ -153,6 +156,10 @@ enum FslImx8mmMemoryRegions {
 };
 
 enum FslImx8mmIrqs {
+    FSL_IMX8MM_USDHC1_IRQ   = 22,
+    FSL_IMX8MM_USDHC2_IRQ   = 23,
+    FSL_IMX8MM_USDHC3_IRQ   = 24,
+
     FSL_IMX8MM_UART1_IRQ    = 26,
     FSL_IMX8MM_UART2_IRQ    = 27,
     FSL_IMX8MM_UART3_IRQ    = 28,
-- 
2.34.1


