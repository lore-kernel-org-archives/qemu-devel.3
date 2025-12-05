Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466E9D2E008
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 05:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vROX7-0008Kc-Gd; Fri, 05 Dec 2025 00:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vROWm-0008H6-GL
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 00:38:49 -0500
Received: from inva021.nxp.com ([92.121.34.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vROWf-0005Kx-SC
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 00:38:44 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BAFCB20160C;
 Fri,  5 Dec 2025 06:38:24 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9242B20160F;
 Fri,  5 Dec 2025 06:38:24 +0100 (CET)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0C40F1800083;
 Fri,  5 Dec 2025 13:38:24 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>
Subject: [PATCHv4 10/15] hw/arm/fsl-imx8mm: Adding support for SPI controller
Date: Fri,  5 Dec 2025 11:08:14 +0530
Message-Id: <20251205053819.2021772-11-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
References: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
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

It enables emulation of ECSPI in iMX8MM
Added SPI IRQ lines

Reviewed-by: Philippe Mathieu-Daude <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 docs/system/arm/imx8mm-evk.rst |  1 +
 hw/arm/fsl-imx8mm.c            | 26 ++++++++++++++++++++++++++
 include/hw/arm/fsl-imx8mm.h    |  7 +++++++
 3 files changed, 34 insertions(+)

diff --git a/docs/system/arm/imx8mm-evk.rst b/docs/system/arm/imx8mm-evk.rst
index 8500430d03..fb74950e28 100644
--- a/docs/system/arm/imx8mm-evk.rst
+++ b/docs/system/arm/imx8mm-evk.rst
@@ -16,6 +16,7 @@ The ``imx8mm-evk`` machine implements the following devices:
  * 1 Designware PCI Express Controller
  * 5 GPIO Controllers
  * 6 I2C Controllers
+ * 3 SPI Controllers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 96e9f9f56a..6b5b769733 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -195,6 +195,11 @@ static void fsl_imx8mm_init(Object *obj)
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
 
+    for (i = 0; i < FSL_IMX8MM_NUM_ECSPIS; i++) {
+        g_autofree char *name = g_strdup_printf("spi%d", i + 1);
+        object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
+    }
+
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
     object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
                             TYPE_FSL_IMX8M_PCIE_PHY);
@@ -454,6 +459,26 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, usdhc_table[i].irq));
     }
 
+    /* ECSPIs */
+    for (i = 0; i < FSL_IMX8MM_NUM_ECSPIS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } spi_table[FSL_IMX8MM_NUM_ECSPIS] = {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_ECSPI1].addr, FSL_IMX8MM_ECSPI1_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_ECSPI2].addr, FSL_IMX8MM_ECSPI2_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_ECSPI3].addr, FSL_IMX8MM_ECSPI3_IRQ },
+        };
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                           qdev_get_gpio_in(gicdev, spi_table[i].irq));
+    }
+
     /* SNVS */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
         return;
@@ -493,6 +518,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_GIC_DIST:
         case FSL_IMX8MM_GIC_REDIST:
         case FSL_IMX8MM_GPIO1 ... FSL_IMX8MM_GPIO5:
+        case FSL_IMX8MM_ECSPI1 ... FSL_IMX8MM_ECSPI3:
         case FSL_IMX8MM_I2C1 ... FSL_IMX8MM_I2C4:
         case FSL_IMX8MM_PCIE1:
         case FSL_IMX8MM_PCIE_PHY1:
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 16effacc43..33fbfb72da 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -21,6 +21,7 @@
 #include "hw/pci-host/designware.h"
 #include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
+#include "hw/ssi/imx_spi.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -32,6 +33,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mmState, FSL_IMX8MM)
 
 enum FslImx8mmConfiguration {
     FSL_IMX8MM_NUM_CPUS         = 4,
+    FSL_IMX8MM_NUM_ECSPIS       = 3,
     FSL_IMX8MM_NUM_GPIOS        = 5,
     FSL_IMX8MM_NUM_I2CS         = 4,
     FSL_IMX8MM_NUM_IRQS         = 128,
@@ -48,6 +50,7 @@ struct FslImx8mmState {
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
+    IMXSPIState        spi[FSL_IMX8MM_NUM_ECSPIS];
     IMXI2CState        i2c[FSL_IMX8MM_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
     SDHCIState         usdhc[FSL_IMX8MM_NUM_USDHCS];
@@ -176,6 +179,10 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_UART3_IRQ    = 28,
     FSL_IMX8MM_UART4_IRQ    = 29,
 
+    FSL_IMX8MM_ECSPI1_IRQ   = 31,
+    FSL_IMX8MM_ECSPI2_IRQ   = 32,
+    FSL_IMX8MM_ECSPI3_IRQ   = 33,
+
     FSL_IMX8MM_I2C1_IRQ     = 35,
     FSL_IMX8MM_I2C2_IRQ     = 36,
     FSL_IMX8MM_I2C3_IRQ     = 37,
-- 
2.34.1


