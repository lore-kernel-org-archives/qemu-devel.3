Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C642C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXR-0003zb-Gu; Mon, 20 Jan 2025 15:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXO-0003wm-Ie; Mon, 20 Jan 2025 15:38:22 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXM-0002YC-0x; Mon, 20 Jan 2025 15:38:21 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d41848901bso6588925a12.0; 
 Mon, 20 Jan 2025 12:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405498; x=1738010298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/RlRkyKHVR1O8vKzAo5o1ie72mb9H4xdcpUozdv32I=;
 b=kIfpEVAaWObALHqxzLka4XQfi1r0ULqYTmZa49rPwDaP368Oe3Ux3JXBvJBDWKOIfq
 UMfw+mMd4/Af43k3ubvdQ/WS5EOHIRV/ydeLKee+BGUkIs9A93Nz3o8FsVid4+nCZ6jV
 VLWjC2qG1eXikC48Bh074jW1JYCrpRzg0702eFxNKhl/MLIKiq42VHoYqNosiEy1WZdM
 fMd3Rhi6/NF5tySuomFvvEnBF5Rjg1JpNg+FPyjvVq9QYB/T7p9eGhBmA1IwO0wJHWHt
 CsekoPC28CdNc+yv6ICwG9SYA5v2p4d8AONWrOpWRpTIg6fnWb5VzVHSAwhe2/Rqoo+n
 yX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405498; x=1738010298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/RlRkyKHVR1O8vKzAo5o1ie72mb9H4xdcpUozdv32I=;
 b=am4nwrBzg2/zzHJD+VktgA0UXI7BazuwCkwWOAmYrCKDAWo/IL3glU7dTdI8GmeG/Y
 s23sunPYFuprhcY0oVX6+q3ThL4C6mWG/KJRS+Zpu+sYOkIR4v7da+OCsBp5fsdN1LgI
 +4YfQhfNvD4iEMFs02jk+4fFZwdvMno0Uta+UV/5bi1Q5JBw2Jn5oW7YxY1NdxiylrQa
 BUixPrDvUHW2BQJ8hSE2r+ql80mfqRCRKagVmr4bJ58rX29bm7/JHjQuSdfgfspfTwe7
 Gpmat8JaY4twuw2WJi69p7gLJYTwKwx3YcWzAPh6ci0fF/EGa5bXzK9Bk1b8FHFE7SG/
 qPMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQjRk93nG2Unau76rDMbbAGmN22kP7m91R2kNmfPoypg/jdjBHh6W2gTdjRDUE71dl8/DZr3Zzzw==@nongnu.org
X-Gm-Message-State: AOJu0Yz54sb3NdGRUnGr/bNtMgEB6e9XTcCyHEcktmrmh1Y9o2rE0fx/
 IYkN0riEXWGwIXzzM7nP61+/T8PL/nr+WwDQb50gWtSt/wtY0YBMvcx5x9lf
X-Gm-Gg: ASbGncsPIm+wUlnpN1PyC1ag3/Qy+E+RekbH+6MatYRDkngAb6EodJmEU+Q/QAZRSoE
 GQEQukHKcf2n1A8HK0nuWP9oM8RyScGcfKogIH+b2u/LWcTalukd+i3wkXIsFioAv+RU5i6rnw9
 X1/hbxzBR4qw0dZzHVF0oQjhdJ2VZ6IiZSFhhsI2DC7omlG3s0O0vZeoKQksMM5TZu0BPClt4Qu
 kqtAID0qe7WgRCysHCzZ9iRDOQC9kNRPOQOj0ADIsNTEccg/0buOjRpIHO3UynN8tenmffZou/e
 QRgFnIQMWvCutQrvzhI9bZSwU+5gyGLPa/0NMWzHV6exh0G8fS3dZ+Mv9YNb
X-Google-Smtp-Source: AGHT+IE30PxtPN575IXFvUf/MmURuGvq62avU6T0Y9HlV+k4ae2PRCvf1meBqYhl92ovvwUV32mPoQ==
X-Received: by 2002:a05:6402:2551:b0:5d3:d8e7:d6d2 with SMTP id
 4fb4d7f45d1cf-5da0bac2e69mr20300346a12.1.1737405497655; 
 Mon, 20 Jan 2025 12:38:17 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:16 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 14/21] hw/arm/fsl-imx8mp: Implement gneral purpose timers
Date: Mon, 20 Jan 2025 21:37:41 +0100
Message-ID: <20250120203748.4687-15-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    | 11 +++++++
 include/hw/timer/imx_gpt.h     |  1 +
 hw/arm/fsl-imx8mp.c            | 53 ++++++++++++++++++++++++++++++++++
 hw/timer/imx_gpt.c             | 25 ++++++++++++++++
 hw/arm/Kconfig                 |  1 +
 6 files changed, 92 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 4f964a715f..8a17b170c0 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -19,6 +19,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 6 I2C Controllers
  * 3 SPI Controllers
  * 3 Watchdogs
+ * 6 General Purpose Timers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 81948a2a5e..bceaf1ffd6 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -16,10 +16,12 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/misc/imx7_snvs.h"
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
@@ -34,6 +36,7 @@ enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CPUS         = 4,
     FSL_IMX8MP_NUM_ECSPIS       = 3,
     FSL_IMX8MP_NUM_GPIOS        = 5,
+    FSL_IMX8MP_NUM_GPTS         = 6,
     FSL_IMX8MP_NUM_I2CS         = 6,
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
@@ -46,6 +49,7 @@ struct FslImx8mpState {
 
     ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
     GICv3State         gic;
+    IMXGPTState        gpt[FSL_IMX8MP_NUM_GPTS];
     IMXGPIOState       gpio[FSL_IMX8MP_NUM_GPIOS];
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
@@ -57,6 +61,7 @@ struct FslImx8mpState {
     IMX2WdtState       wdt[FSL_IMX8MP_NUM_WDTS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
+    OrIRQState         gpt5_gpt6_irq;
 };
 
 enum FslImx8mpMemoryRegions {
@@ -223,6 +228,12 @@ enum FslImx8mpIrqs {
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
index 5a1230da35..5488f7e4df 100644
--- a/include/hw/timer/imx_gpt.h
+++ b/include/hw/timer/imx_gpt.h
@@ -80,6 +80,7 @@
 #define TYPE_IMX6_GPT "imx6.gpt"
 #define TYPE_IMX6UL_GPT "imx6ul.gpt"
 #define TYPE_IMX7_GPT "imx7.gpt"
+#define TYPE_IMX8MP_GPT "imx8mp.gpt"
 
 #define TYPE_IMX_GPT TYPE_IMX25_GPT
 
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 2e0cd4e911..c40811d078 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -211,6 +211,13 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_GPTS; i++) {
+        snprintf(name, NAME_SIZE, "gpt%d", i + 1);
+        object_initialize_child(obj, name, &s->gpt[i], TYPE_IMX8MP_GPT);
+    }
+    object_initialize_child(obj, "gpt5-gpt6-irq", &s->gpt5_gpt6_irq,
+                            TYPE_OR_IRQ);
+
     for (i = 0; i < FSL_IMX8MP_NUM_I2CS; i++) {
         snprintf(name, NAME_SIZE, "i2c%d", i + 1);
         object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
@@ -379,6 +386,52 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
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
+        static const hwaddr gpt_addrs[FSL_IMX8MP_NUM_GPTS] = {
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
         static const struct {
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 11eca9fa4d..200a89225b 100644
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
index a1910db717..8ebcf3339e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -585,6 +585,7 @@ config FSL_IMX8MP
     select ARM_GIC
     select IMX
     select IMX_I2C
+    select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
-- 
2.48.1


