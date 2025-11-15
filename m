Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8EECEACFC
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 06:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKA98-0006g6-2z; Sat, 15 Nov 2025 01:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vKA94-0006bC-KG
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 01:52:26 -0500
Received: from inva021.nxp.com ([92.121.34.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vKA92-0008N3-Kl
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 01:52:26 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 792602013C7;
 Sat, 15 Nov 2025 07:52:23 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 44C47202BCC;
 Sat, 15 Nov 2025 07:52:23 +0100 (CET)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6D0701800087;
 Sat, 15 Nov 2025 14:52:22 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv2 12/13] hw/arm/fsl-imx8mm: Adding support for USB controller
Date: Sat, 15 Nov 2025 12:20:58 +0530
Message-Id: <20251115065059.1884980-13-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251115065059.1884980-1-gaurav.sharma_7@nxp.com>
References: <20251115065059.1884980-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.21;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva021.nxp.com
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

It enables emulation of USB on iMX8MM
Enables testing and debugging of USB drivers

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 docs/system/arm/imx8mm-evk.rst |  1 +
 hw/arm/Kconfig                 |  1 +
 hw/arm/fsl-imx8mm.c            | 27 +++++++++++++++++++++++++++
 include/hw/arm/fsl-imx8mm.h    |  6 ++++++
 4 files changed, 35 insertions(+)

diff --git a/docs/system/arm/imx8mm-evk.rst b/docs/system/arm/imx8mm-evk.rst
index 173f4688fb..be492424f8 100644
--- a/docs/system/arm/imx8mm-evk.rst
+++ b/docs/system/arm/imx8mm-evk.rst
@@ -15,6 +15,7 @@ The ``imx8mm-evk`` machine implements the following devices:
  * 3 USDHC Storage Controllers
  * 1 Designware PCI Express Controller
  * 1 Ethernet Controller
+ * 2 Designware USB 3 Controllers
  * 5 GPIO Controllers
  * 6 I2C Controllers
  * 3 SPI Controllers
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d41d03d728..39c63a3aea 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -640,6 +640,7 @@ config FSL_IMX8MM
     select SDHCI
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
+    select USB_DWC3
     select WDT_IMX2
 
 config FSL_IMX8MM_EVK
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 7be0bb8664..ea17d1f48b 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -199,6 +199,11 @@ static void fsl_imx8mm_init(Object *obj)
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
 
+    for (i = 0; i < FSL_IMX8MM_NUM_USBS; i++) {
+        g_autofree char *name = g_strdup_printf("usb%d", i);
+        object_initialize_child(obj, name, &s->usb[i], TYPE_USB_DWC3);
+    }
+
     for (i = 0; i < FSL_IMX8MM_NUM_ECSPIS; i++) {
         g_autofree char *name = g_strdup_printf("spi%d", i + 1);
         object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
@@ -514,6 +519,27 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
     }
 
+    /* USBs */
+    for (i = 0; i < FSL_IMX8MM_NUM_USBS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } usb_table[FSL_IMX8MM_NUM_USBS] = {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_USB1].addr, FSL_IMX8MM_USB1_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_USB2].addr, FSL_IMX8MM_USB2_IRQ },
+        };
+
+        qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "p2", 1);
+        qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "p3", 1);
+        qdev_prop_set_uint32(DEVICE(&s->usb[i].sysbus_xhci), "slots", 2);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usb[i]), errp)) {
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0, usb_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i].sysbus_xhci), 0,
+                           qdev_get_gpio_in(gicdev, usb_table[i].irq));
+    }
+
     /* ECSPIs */
     for (i = 0; i < FSL_IMX8MM_NUM_ECSPIS; i++) {
         static const struct {
@@ -618,6 +644,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_RAM:
         case FSL_IMX8MM_SNVS_HP:
         case FSL_IMX8MM_UART1 ... FSL_IMX8MM_UART4:
+        case FSL_IMX8MM_USB1 ... FSL_IMX8MM_USB2:
         case FSL_IMX8MM_USDHC1 ... FSL_IMX8MM_USDHC3:
         case FSL_IMX8MM_WDOG1 ... FSL_IMX8MM_WDOG3:
             /* device implemented and treated above */
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 356627ab82..6a0b911acf 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -24,6 +24,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
 #include "hw/timer/imx_gpt.h"
+#include "hw/usb/hcd-dwc3.h"
 #include "hw/watchdog/wdt_imx2.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -42,6 +43,7 @@ enum FslImx8mmConfiguration {
     FSL_IMX8MM_NUM_I2CS         = 4,
     FSL_IMX8MM_NUM_IRQS         = 128,
     FSL_IMX8MM_NUM_UARTS        = 4,
+    FSL_IMX8MM_NUM_USBS         = 2,
     FSL_IMX8MM_NUM_USDHCS       = 3,
     FSL_IMX8MM_NUM_WDTS         = 3,
 };
@@ -62,6 +64,7 @@ struct FslImx8mmState {
     IMXFECState        enet;
     SDHCIState         usdhc[FSL_IMX8MM_NUM_USDHCS];
     IMX2WdtState       wdt[FSL_IMX8MM_NUM_WDTS];
+    USBDWC3            usb[FSL_IMX8MM_NUM_USBS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
     OrIRQState         gpt5_gpt6_irq;
@@ -200,6 +203,9 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_I2C3_IRQ     = 37,
     FSL_IMX8MM_I2C4_IRQ     = 38,
 
+    FSL_IMX8MM_USB1_IRQ     = 40,
+    FSL_IMX8MM_USB2_IRQ     = 41,
+
     FSL_IMX8MM_GPT1_IRQ      = 55,
     FSL_IMX8MM_GPT2_IRQ      = 54,
     FSL_IMX8MM_GPT3_IRQ      = 53,
-- 
2.34.1


