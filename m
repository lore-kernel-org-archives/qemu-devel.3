Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD043CF34AD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 13:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLhnv-0001U1-Hc; Wed, 19 Nov 2025 08:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vLhnb-0001II-Qx
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:00:40 -0500
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vLhnZ-0002Bt-MR
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:00:39 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 40E4F1A3BB9;
 Wed, 19 Nov 2025 14:00:32 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C3671A0872;
 Wed, 19 Nov 2025 14:00:32 +0100 (CET)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 81FEE1800097;
 Wed, 19 Nov 2025 21:00:31 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv3 07/13] hw/arm/fsl-imx8mm: Adding support for I2C emulation
Date: Wed, 19 Nov 2025 18:30:21 +0530
Message-Id: <20251119130027.3312971-8-gaurav.sharma_7@nxp.com>
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

This can be used to test and debug I2C device drivers.
Added I2C interrupts

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 docs/system/arm/imx8mm-evk.rst |  1 +
 hw/arm/Kconfig                 |  2 ++
 hw/arm/fsl-imx8mm.c            | 27 +++++++++++++++++++++++++++
 include/hw/arm/fsl-imx8mm.h    |  8 ++++++++
 4 files changed, 38 insertions(+)

diff --git a/docs/system/arm/imx8mm-evk.rst b/docs/system/arm/imx8mm-evk.rst
index 809ff0bdb8..8500430d03 100644
--- a/docs/system/arm/imx8mm-evk.rst
+++ b/docs/system/arm/imx8mm-evk.rst
@@ -15,6 +15,7 @@ The ``imx8mm-evk`` machine implements the following devices:
  * 3 USDHC Storage Controllers
  * 1 Designware PCI Express Controller
  * 5 GPIO Controllers
+ * 6 I2C Controllers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 6df1478c4f..d442ea0624 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -629,10 +629,12 @@ config FSL_IMX8MP_EVK
 config FSL_IMX8MM
     bool
     imply PCI_DEVICES
+    imply I2C_DEVICES
     select ARM_GIC
     select FSL_IMX8MM_ANALOG
     select FSL_IMX8MM_CCM
     select IMX
+    select IMX_I2C
     select SDHCI
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index bd7976a27a..9eb02f0438 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -177,6 +177,11 @@ static void fsl_imx8mm_init(Object *obj)
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
+    for (i = 0; i < FSL_IMX8MM_NUM_I2CS; i++) {
+        g_autofree char *name = g_strdup_printf("i2c%d", i + 1);
+        object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
+    }
+
     for (i = 0; i < FSL_IMX8MM_NUM_GPIOS; i++) {
         g_autofree char *name = g_strdup_printf("gpio%d", i + 1);
         object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
@@ -355,6 +360,27 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* I2Cs */
+    for (i = 0; i < FSL_IMX8MM_NUM_I2CS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } i2c_table[FSL_IMX8MM_NUM_I2CS] = {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C1].addr, FSL_IMX8MM_I2C1_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C2].addr, FSL_IMX8MM_I2C2_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C3].addr, FSL_IMX8MM_I2C3_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C4].addr, FSL_IMX8MM_I2C4_IRQ },
+        };
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, i2c_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
+                           qdev_get_gpio_in(gicdev, i2c_table[i].irq));
+    }
+
     /* GPIOs */
     for (i = 0; i < FSL_IMX8MM_NUM_GPIOS; i++) {
         static const struct {
@@ -462,6 +488,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_GIC_DIST:
         case FSL_IMX8MM_GIC_REDIST:
         case FSL_IMX8MM_GPIO1 ... FSL_IMX8MM_GPIO5:
+        case FSL_IMX8MM_I2C1 ... FSL_IMX8MM_I2C4:
         case FSL_IMX8MM_PCIE1:
         case FSL_IMX8MM_PCIE_PHY1:
         case FSL_IMX8MM_RAM:
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index d3a2d1843f..e68dbd188b 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/gpio/imx_gpio.h"
+#include "hw/i2c/imx_i2c.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mm_analog.h"
@@ -31,6 +32,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mmState, FSL_IMX8MM)
 enum FslImx8mmConfiguration {
     FSL_IMX8MM_NUM_CPUS         = 4,
     FSL_IMX8MM_NUM_GPIOS        = 5,
+    FSL_IMX8MM_NUM_I2CS         = 4,
     FSL_IMX8MM_NUM_IRQS         = 128,
     FSL_IMX8MM_NUM_UARTS        = 4,
     FSL_IMX8MM_NUM_USDHCS       = 3,
@@ -45,6 +47,7 @@ struct FslImx8mmState {
     IMX8MMCCMState     ccm;
     IMX8MMAnalogState  analog;
     IMX7SNVSState      snvs;
+    IMXI2CState        i2c[FSL_IMX8MM_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
     SDHCIState         usdhc[FSL_IMX8MM_NUM_USDHCS];
     DesignwarePCIEHost pcie;
@@ -172,6 +175,11 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_UART3_IRQ    = 28,
     FSL_IMX8MM_UART4_IRQ    = 29,
 
+    FSL_IMX8MM_I2C1_IRQ     = 35,
+    FSL_IMX8MM_I2C2_IRQ     = 36,
+    FSL_IMX8MM_I2C3_IRQ     = 37,
+    FSL_IMX8MM_I2C4_IRQ     = 38,
+
     FSL_IMX8MM_GPIO1_LOW_IRQ  = 64,
     FSL_IMX8MM_GPIO1_HIGH_IRQ = 65,
     FSL_IMX8MM_GPIO2_LOW_IRQ  = 66,
-- 
2.34.1


