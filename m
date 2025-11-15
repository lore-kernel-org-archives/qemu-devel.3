Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D2DCEB2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 06:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKA97-0006fH-DP; Sat, 15 Nov 2025 01:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vKA92-0006Y1-TW
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 01:52:24 -0500
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vKA90-0008Mh-KQ
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 01:52:24 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8F33A1A14E6;
 Sat, 15 Nov 2025 07:52:21 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 585B11A21F5;
 Sat, 15 Nov 2025 07:52:21 +0100 (CET)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7B5FE18000AF;
 Sat, 15 Nov 2025 14:52:20 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv2 10/13] hw/arm/fsl-imx8mm: Adding support for General Purpose
 Timers
Date: Sat, 15 Nov 2025 12:20:56 +0530
Message-Id: <20251115065059.1884980-11-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251115065059.1884980-1-gaurav.sharma_7@nxp.com>
References: <20251115065059.1884980-1-gaurav.sharma_7@nxp.com>
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

It enables emulation of GPT in iMX8MM
Added GPT IRQ lines

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 docs/system/arm/imx8mm-evk.rst |  1 +
 hw/arm/Kconfig                 |  1 +
 hw/arm/fsl-imx8mm.c            | 53 ++++++++++++++++++++++++++++++++++
 hw/timer/imx_gpt.c             | 26 +++++++++++++++++
 include/hw/arm/fsl-imx8mm.h    | 11 +++++++
 include/hw/timer/imx_gpt.h     |  2 ++
 6 files changed, 94 insertions(+)

diff --git a/docs/system/arm/imx8mm-evk.rst b/docs/system/arm/imx8mm-evk.rst
index e2762ef333..60ebcd1394 100644
--- a/docs/system/arm/imx8mm-evk.rst
+++ b/docs/system/arm/imx8mm-evk.rst
@@ -18,6 +18,7 @@ The ``imx8mm-evk`` machine implements the following devices:
  * 6 I2C Controllers
  * 3 SPI Controllers
  * 3 Watchdogs
+ * 6 General Purpose Timers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 9498a96f30..733baea384 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -635,6 +635,7 @@ config FSL_IMX8MM
     select FSL_IMX8MM_CCM
     select IMX
     select IMX_I2C
+    select OR_IRQ
     select SDHCI
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 0a3e057bf3..e5599b1c48 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -177,6 +177,13 @@ static void fsl_imx8mm_init(Object *obj)
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
+    for (i = 0; i < FSL_IMX8MM_NUM_GPTS; i++) {
+        g_autofree char *name = g_strdup_printf("gpt%d", i + 1);
+        object_initialize_child(obj, name, &s->gpt[i], TYPE_IMX8MM_GPT);
+    }
+    object_initialize_child(obj, "gpt5-gpt6-irq", &s->gpt5_gpt6_irq,
+                            TYPE_OR_IRQ);
+
     for (i = 0; i < FSL_IMX8MM_NUM_I2CS; i++) {
         g_autofree char *name = g_strdup_printf("i2c%d", i + 1);
         object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
@@ -370,6 +377,52 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* GPTs */
+    object_property_set_int(OBJECT(&s->gpt5_gpt6_irq), "num-lines", 2,
+                            &error_abort);
+    if (!qdev_realize(DEVICE(&s->gpt5_gpt6_irq), NULL, errp)) {
+        return;
+    }
+
+    qdev_connect_gpio_out(DEVICE(&s->gpt5_gpt6_irq), 0,
+                          qdev_get_gpio_in(gicdev, FSL_IMX8MM_GPT5_GPT6_IRQ));
+
+    for (i = 0; i < FSL_IMX8MM_NUM_GPTS; i++) {
+        hwaddr gpt_addrs[FSL_IMX8MM_NUM_GPTS] = {
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT1].addr,
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT2].addr,
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT3].addr,
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT4].addr,
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT5].addr,
+            fsl_imx8mm_memmap[FSL_IMX8MM_GPT6].addr,
+        };
+
+        s->gpt[i].ccm = IMX_CCM(&s->ccm);
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0, gpt_addrs[i]);
+
+        if (i < FSL_IMX8MM_NUM_GPTS - 2) {
+            static const unsigned int gpt_irqs[FSL_IMX8MM_NUM_GPTS - 2] = {
+                FSL_IMX8MM_GPT1_IRQ,
+                FSL_IMX8MM_GPT2_IRQ,
+                FSL_IMX8MM_GPT3_IRQ,
+                FSL_IMX8MM_GPT4_IRQ,
+            };
+
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
+                               qdev_get_gpio_in(gicdev, gpt_irqs[i]));
+        } else {
+            int irq = i - FSL_IMX8MM_NUM_GPTS + 2;
+
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
+                               qdev_get_gpio_in(DEVICE(&s->gpt5_gpt6_irq), irq));
+        }
+    }
+
     /* I2Cs */
     for (i = 0; i < FSL_IMX8MM_NUM_I2CS; i++) {
         static const struct {
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 8c7cbfdeac..5eba637f7d 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -6,6 +6,7 @@
  * Originally written by Hans Jiang
  * Updated by Peter Chubb
  * Updated by Jean-Christophe Dubois <jcd@tribudubois.net>
+ * Updated by Gaurav Sharma <gaurav.sharma_7@nxp.com>
  *
  * This code is licensed under GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
@@ -137,6 +138,17 @@ static const IMXClk imx8mp_gpt_clocks[] = {
     CLK_NONE,      /* 111 not defined */
 };
 
+static const IMXClk imx8mm_gpt_clocks[] = {
+    CLK_NONE,      /* 000 No clock source */
+    CLK_IPG,       /* 001 ipg_clk, 532MHz */
+    CLK_IPG_HIGH,  /* 010 ipg_clk_highfreq */
+    CLK_EXT,       /* 011 External clock */
+    CLK_32k,       /* 100 ipg_clk_32k */
+    CLK_HIGH,      /* 101 ipg_clk_16M */
+    CLK_NONE,      /* 110 not defined */
+    CLK_NONE,      /* 111 not defined */
+};
+
 /* Must be called from within ptimer_transaction_begin/commit block */
 static void imx_gpt_set_freq(IMXGPTState *s)
 {
@@ -570,6 +582,13 @@ static void imx8mp_gpt_init(Object *obj)
     s->clocks = imx8mp_gpt_clocks;
 }
 
+static void imx8mm_gpt_init(Object *obj)
+{
+    IMXGPTState *s = IMX_GPT(obj);
+
+    s->clocks = imx8mm_gpt_clocks;
+}
+
 static const TypeInfo imx25_gpt_info = {
     .name = TYPE_IMX25_GPT,
     .parent = TYPE_SYS_BUS_DEVICE,
@@ -608,6 +627,12 @@ static const TypeInfo imx8mp_gpt_info = {
     .instance_init = imx8mp_gpt_init,
 };
 
+static const TypeInfo imx8mm_gpt_info = {
+    .name = TYPE_IMX8MM_GPT,
+    .parent = TYPE_IMX25_GPT,
+    .instance_init = imx8mm_gpt_init,
+};
+
 static void imx_gpt_register_types(void)
 {
     type_register_static(&imx25_gpt_info);
@@ -616,6 +641,7 @@ static void imx_gpt_register_types(void)
     type_register_static(&imx6ul_gpt_info);
     type_register_static(&imx7_gpt_info);
     type_register_static(&imx8mp_gpt_info);
+    type_register_static(&imx8mm_gpt_info);
 }
 
 type_init(imx_gpt_register_types)
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 7107e932c6..6b70be81d2 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -17,10 +17,12 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mm_analog.h"
 #include "hw/misc/imx8mm_ccm.h"
+#include "hw/or-irq.h"
 #include "hw/pci-host/designware.h"
 #include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
+#include "hw/timer/imx_gpt.h"
 #include "hw/watchdog/wdt_imx2.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -35,6 +37,7 @@ enum FslImx8mmConfiguration {
     FSL_IMX8MM_NUM_CPUS         = 4,
     FSL_IMX8MM_NUM_ECSPIS       = 3,
     FSL_IMX8MM_NUM_GPIOS        = 5,
+    FSL_IMX8MM_NUM_GPTS         = 6,
     FSL_IMX8MM_NUM_I2CS         = 4,
     FSL_IMX8MM_NUM_IRQS         = 128,
     FSL_IMX8MM_NUM_UARTS        = 4,
@@ -47,6 +50,7 @@ struct FslImx8mmState {
 
     ARMCPU             cpu[FSL_IMX8MM_NUM_CPUS];
     GICv3State         gic;
+    IMXGPTState        gpt[FSL_IMX8MM_NUM_GPTS];
     IMXGPIOState       gpio[FSL_IMX8MM_NUM_GPIOS];
     IMX8MMCCMState     ccm;
     IMX8MMAnalogState  analog;
@@ -58,6 +62,7 @@ struct FslImx8mmState {
     IMX2WdtState       wdt[FSL_IMX8MM_NUM_WDTS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
+    OrIRQState         gpt5_gpt6_irq;
 };
 
 enum FslImx8mmMemoryRegions {
@@ -190,6 +195,12 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_I2C3_IRQ     = 37,
     FSL_IMX8MM_I2C4_IRQ     = 38,
 
+    FSL_IMX8MM_GPT1_IRQ      = 55,
+    FSL_IMX8MM_GPT2_IRQ      = 54,
+    FSL_IMX8MM_GPT3_IRQ      = 53,
+    FSL_IMX8MM_GPT4_IRQ      = 52,
+    FSL_IMX8MM_GPT5_GPT6_IRQ = 51,
+
     FSL_IMX8MM_GPIO1_LOW_IRQ  = 64,
     FSL_IMX8MM_GPIO1_HIGH_IRQ = 65,
     FSL_IMX8MM_GPIO2_LOW_IRQ  = 66,
diff --git a/include/hw/timer/imx_gpt.h b/include/hw/timer/imx_gpt.h
index 5488f7e4df..379ee5de75 100644
--- a/include/hw/timer/imx_gpt.h
+++ b/include/hw/timer/imx_gpt.h
@@ -6,6 +6,7 @@
  * Originally written by Hans Jiang
  * Updated by Peter Chubb
  * Updated by Jean-Christophe Dubois <jcd@tribudubois.net>
+ * Updated by Gaurav Sharma <gaurav.sharma_7@nxp.com>
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -81,6 +82,7 @@
 #define TYPE_IMX6UL_GPT "imx6ul.gpt"
 #define TYPE_IMX7_GPT "imx7.gpt"
 #define TYPE_IMX8MP_GPT "imx8mp.gpt"
+#define TYPE_IMX8MM_GPT "imx8mm.gpt"
 
 #define TYPE_IMX_GPT TYPE_IMX25_GPT
 
-- 
2.34.1


