Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E33C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzMN-0000F7-Rf; Tue, 25 Feb 2025 13:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJu-0000PT-SK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:18 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJp-0002Nc-Cs
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:14 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so3400820f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506758; x=1741111558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MyKnDsd8xnvJ2V5qWElitBF/e51K36HkS3JSSEZrPo4=;
 b=uZoZOfg/WRTAJigKb1f0BEBK4u9N4kaQRnK576R5mKcR93/+EHL2B2O74bd/CptzSU
 Zvle65bx0breEIiNM0lc/Kwj4dTdJ2vwoblXYx4bsXpSg47+l+k/XoaMwMEDAaQqylLU
 1zN+D6BXu7dxVXWdpT4CN0Ibb0fP//tFircG524FE2OFVIUGjULCNBACzVhodfI/rH0T
 QiiULRNk5s4C+Kf8KjeTtbyFh0ZQUy9jx4MnomsmMizYI92F/LwjU1FzTfBhPsm4+FPV
 Our0mpNfw0W5LfEomAJVyh10VKP4bzCm/Xq0LsjAyaj9HeKNw5UZjKtaOFPVYNSsCWFn
 9WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506758; x=1741111558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MyKnDsd8xnvJ2V5qWElitBF/e51K36HkS3JSSEZrPo4=;
 b=IhKpMrFS1EHpShbqnIr2XZFBcvaweYrjLT8LZGcWQoO7Hu9Ea+sgOqQN/qhp0LCaQF
 i9kDXvP3lNzZYUk7ohIvQsn9fKMXPg+p2a6zJKAY+XmO1kGEZsuX8P1izgn9IFaGC10a
 vmV4GF0FL0P9y4Dy+ohmR5SnCUYFN3zQzCACkhYO2t8KG+MitkKzMcUeaZa+TzB7sZdi
 yJnP3p2bTRvi3F+SzCID/8RHRuMiCKEsHYtN8m0zb2mygMpm7hVn1UMZ3+qKdIasdTQE
 KQLH9MjvuZaQ3zhq7K92LLcvTbM2a3FWnSDWfB9uhATGwybuMjB372JppkjgztAlPUfb
 po9w==
X-Gm-Message-State: AOJu0YyX1yOpLdaDwgUV0i3XFLKRCPtao0eQvuj1+icuPYBmDKIj666F
 WarN8kg0/AcMIggTJeVtACe9SpJ2SvOvOCra96OI/IWM3yB5Q0QRTzYBElTsrhToP+2XjyZaMp6
 +
X-Gm-Gg: ASbGncvEnrDLM4SvvTMnjl8w7lG8zqY00n90pwRq+5ECJmXV21jHlRSXbyAZuzdmqcH
 c5Qay+7cu4RnhOLGn+h0BEMbuZ+oPralACEFOWQNuKC8CKNdCf+sBZkBDGMh0cn3LtywugxiJHh
 ekYsV1wSYEfUAabG593RgeoUhIToGXYA+rGsJ150uJjBSyR9QUMPtR5tsIVVzSWtXkifMqjZ62D
 A/KDvDIJyKUpSO07foehdHI9atHWyAlMVVYxSZUsBRBDVMffCmzULjL9uKOVxs1IH0RoSX6vClY
 BgAXyVRWCL3GsXg17isMERZ9VGqttrri
X-Google-Smtp-Source: AGHT+IESd/zjqTdWGNTA30LAd4cOAgZYg7R2ZmhHesvbglj5TQQzx/Taz/NFR0kWDtK2rcaHKE/OGQ==
X-Received: by 2002:a05:6000:2a5:b0:38c:617c:ee2f with SMTP id
 ffacd0b85a97d-390d4f3ba5cmr207142f8f.13.1740506757512; 
 Tue, 25 Feb 2025 10:05:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/43] hw/arm/fsl-imx8mp: Implement general purpose timers
Date: Tue, 25 Feb 2025 18:05:06 +0000
Message-ID: <20250225180510.1318207-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250223114708.1780-14-shentey@gmail.com
[PMM: drop static const from gpt_attrs for GCC 7.5]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    | 11 +++++++
 include/hw/timer/imx_gpt.h     |  1 +
 hw/arm/fsl-imx8mp.c            | 53 ++++++++++++++++++++++++++++++++++
 hw/timer/imx_gpt.c             | 25 ++++++++++++++++
 hw/arm/Kconfig                 |  1 +
 6 files changed, 92 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 904de9aa7df..4b195c917f6 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -18,6 +18,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 6 I2C Controllers
  * 3 SPI Controllers
  * 3 Watchdogs
+ * 6 General Purpose Timers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index dfbdc6ac7f2..975887751bc 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -17,10 +17,12 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/or-irq.h"
 #include "hw/pci-host/designware.h"
 #include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
+#include "hw/timer/imx_gpt.h"
 #include "hw/watchdog/wdt_imx2.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -35,6 +37,7 @@ enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CPUS         = 4,
     FSL_IMX8MP_NUM_ECSPIS       = 3,
     FSL_IMX8MP_NUM_GPIOS        = 5,
+    FSL_IMX8MP_NUM_GPTS         = 6,
     FSL_IMX8MP_NUM_I2CS         = 6,
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
@@ -47,6 +50,7 @@ struct FslImx8mpState {
 
     ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
     GICv3State         gic;
+    IMXGPTState        gpt[FSL_IMX8MP_NUM_GPTS];
     IMXGPIOState       gpio[FSL_IMX8MP_NUM_GPIOS];
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
@@ -58,6 +62,7 @@ struct FslImx8mpState {
     IMX2WdtState       wdt[FSL_IMX8MP_NUM_WDTS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
+    OrIRQState         gpt5_gpt6_irq;
 };
 
 enum FslImx8mpMemoryRegions {
@@ -224,6 +229,12 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_I2C3_IRQ     = 37,
     FSL_IMX8MP_I2C4_IRQ     = 38,
 
+    FSL_IMX8MP_GPT1_IRQ      = 55,
+    FSL_IMX8MP_GPT2_IRQ      = 54,
+    FSL_IMX8MP_GPT3_IRQ      = 53,
+    FSL_IMX8MP_GPT4_IRQ      = 52,
+    FSL_IMX8MP_GPT5_GPT6_IRQ = 51,
+
     FSL_IMX8MP_GPIO1_LOW_IRQ  = 64,
     FSL_IMX8MP_GPIO1_HIGH_IRQ = 65,
     FSL_IMX8MP_GPIO2_LOW_IRQ  = 66,
diff --git a/include/hw/timer/imx_gpt.h b/include/hw/timer/imx_gpt.h
index 5a1230da35e..5488f7e4df5 100644
--- a/include/hw/timer/imx_gpt.h
+++ b/include/hw/timer/imx_gpt.h
@@ -80,6 +80,7 @@
 #define TYPE_IMX6_GPT "imx6.gpt"
 #define TYPE_IMX6UL_GPT "imx6ul.gpt"
 #define TYPE_IMX7_GPT "imx7.gpt"
+#define TYPE_IMX8MP_GPT "imx8mp.gpt"
 
 #define TYPE_IMX_GPT TYPE_IMX25_GPT
 
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 762f2a52d8d..185c32ee587 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -208,6 +208,13 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_GPTS; i++) {
+        g_autofree char *name = g_strdup_printf("gpt%d", i + 1);
+        object_initialize_child(obj, name, &s->gpt[i], TYPE_IMX8MP_GPT);
+    }
+    object_initialize_child(obj, "gpt5-gpt6-irq", &s->gpt5_gpt6_irq,
+                            TYPE_OR_IRQ);
+
     for (i = 0; i < FSL_IMX8MP_NUM_I2CS; i++) {
         g_autofree char *name = g_strdup_printf("i2c%d", i + 1);
         object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
@@ -375,6 +382,52 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
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
+                          qdev_get_gpio_in(gicdev, FSL_IMX8MP_GPT5_GPT6_IRQ));
+
+    for (i = 0; i < FSL_IMX8MP_NUM_GPTS; i++) {
+        hwaddr gpt_addrs[FSL_IMX8MP_NUM_GPTS] = {
+            fsl_imx8mp_memmap[FSL_IMX8MP_GPT1].addr,
+            fsl_imx8mp_memmap[FSL_IMX8MP_GPT2].addr,
+            fsl_imx8mp_memmap[FSL_IMX8MP_GPT3].addr,
+            fsl_imx8mp_memmap[FSL_IMX8MP_GPT4].addr,
+            fsl_imx8mp_memmap[FSL_IMX8MP_GPT5].addr,
+            fsl_imx8mp_memmap[FSL_IMX8MP_GPT6].addr,
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
+        if (i < FSL_IMX8MP_NUM_GPTS - 2) {
+            static const unsigned int gpt_irqs[FSL_IMX8MP_NUM_GPTS - 2] = {
+                FSL_IMX8MP_GPT1_IRQ,
+                FSL_IMX8MP_GPT2_IRQ,
+                FSL_IMX8MP_GPT3_IRQ,
+                FSL_IMX8MP_GPT4_IRQ,
+            };
+
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
+                               qdev_get_gpio_in(gicdev, gpt_irqs[i]));
+        } else {
+            int irq = i - FSL_IMX8MP_NUM_GPTS + 2;
+
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
+                               qdev_get_gpio_in(DEVICE(&s->gpt5_gpt6_irq), irq));
+        }
+    }
+
     /* I2Cs */
     for (i = 0; i < FSL_IMX8MP_NUM_I2CS; i++) {
         struct {
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 11eca9fa4df..200a89225bb 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -126,6 +126,17 @@ static const IMXClk imx7_gpt_clocks[] = {
     CLK_NONE,      /* 111 not defined */
 };
 
+static const IMXClk imx8mp_gpt_clocks[] = {
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
@@ -552,6 +563,13 @@ static void imx7_gpt_init(Object *obj)
     s->clocks = imx7_gpt_clocks;
 }
 
+static void imx8mp_gpt_init(Object *obj)
+{
+    IMXGPTState *s = IMX_GPT(obj);
+
+    s->clocks = imx8mp_gpt_clocks;
+}
+
 static const TypeInfo imx25_gpt_info = {
     .name = TYPE_IMX25_GPT,
     .parent = TYPE_SYS_BUS_DEVICE,
@@ -584,6 +602,12 @@ static const TypeInfo imx7_gpt_info = {
     .instance_init = imx7_gpt_init,
 };
 
+static const TypeInfo imx8mp_gpt_info = {
+    .name = TYPE_IMX8MP_GPT,
+    .parent = TYPE_IMX25_GPT,
+    .instance_init = imx8mp_gpt_init,
+};
+
 static void imx_gpt_register_types(void)
 {
     type_register_static(&imx25_gpt_info);
@@ -591,6 +615,7 @@ static void imx_gpt_register_types(void)
     type_register_static(&imx6_gpt_info);
     type_register_static(&imx6ul_gpt_info);
     type_register_static(&imx7_gpt_info);
+    type_register_static(&imx8mp_gpt_info);
 }
 
 type_init(imx_gpt_register_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 98ac93a23fc..4e83895b915 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -602,6 +602,7 @@ config FSL_IMX8MP
     select FSL_IMX8MP_CCM
     select IMX
     select IMX_I2C
+    select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
-- 
2.43.0


