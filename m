Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E972C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF84-0005WY-1P; Tue, 04 Feb 2025 04:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7k-0004zh-I6; Tue, 04 Feb 2025 04:21:40 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7i-00055b-GR; Tue, 04 Feb 2025 04:21:40 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so36532295e9.1; 
 Tue, 04 Feb 2025 01:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738660896; x=1739265696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+hfKYX/95ZBX8pAGwzv4H1lSS0fZN3vLc/eDigEhw0=;
 b=VXhX1kxCBCwoVIRUWkm031F7q674S8b0v4y7ZWCP2fYMJP+dl03trR/g2DZXNYOaMX
 PpKxxNAEub0r1VVpFP0y8AmTiyYwg6U60gysVmFB9BAzNv7XD4kLg12egYgwK/AjR7Xi
 UXXXWJPn35hs0/A2RZkHXiegTcxocReppdoYHxL45D1dQZD+91TJa9q0zWBAvxe5k/bl
 gMV3gTDcEBnOv0tfkTfPgYYNJcP+35DrtQFFxFuaBU1MjQU0hj6/HH4MRf3v2yVZf3ou
 OHJiWNfQxm0tbMZYbQSigAHGjG+a1Id1aUyEE7NiDjuhf2fA90ty+HWWiZUo0bewMvOV
 FwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660896; x=1739265696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+hfKYX/95ZBX8pAGwzv4H1lSS0fZN3vLc/eDigEhw0=;
 b=INMGxMNt3t1s1b828XX5yokPpEC+OTBY2yh75NjI4uO7zHqpUa+mP9hP/oidyW3gDC
 QDJO+YfNLMNSMkYh2ibQzD+O58r3xo1hqZ8oQYz7UoCgUJXJsTBJqYrRLCKlRwQetQb4
 pHhAwVuXAHtNzjetm+lpC1DU76dZGv/xjL8rkD3P6LRd0lgF8Mb5TZ2KCd3+yBb09SCM
 13iXd3xb/GS0zOme2LV8FhX5frcgL8ueKEgyNFg04ff3ZaBy1W6QX9xhiu/5v2KX1Z+1
 c871y6mE8zFKHoDv6qFdx8NbmxycRv8rj3rHF9+A7FG+OOGki2TLeT7/1/JwgHvHry1Y
 EGVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqdQlHK6HtOTbxR0zJPGafrY8Sz7AU4CC9kl5ILD0q/sGSjk79QeqmXu9z+PdfAU/VaIrUD3uyTQ==@nongnu.org
X-Gm-Message-State: AOJu0YzM1hqE69hL/dWF5cX5QpuFUm2zxDsEErItfB9uM2MhbKR7GrV/
 78t0+4gx4MVE0ExdlZeRcLzuURiQMYw/fO5t6zdzKgGZPejc5nvJvtwvLg==
X-Gm-Gg: ASbGnctWMxJau1m/eCGvZYB3z2P3AI32BBcIMuGwx6mLTUy/sLSmShSXthWWmg0Wmzb
 jvdKVMDqRDMITLUqf9xQXLNa0yO5Pr9VhBtGHe9ZLH7kDrDpEGkb87fmJXuw7Zx42lD2qHnl8LR
 QbNoiHdRRUsK+Zvxg5HLEqnowmGomQi6wGqI13XlAuweS/w0vc+DYakKiSwX14ib2IqIk5TsGTt
 F5x3gi28ooJoNtuPYCX4PX4vua/1QtWgMgy0W3WZi9MZm2SmDyPOxYM5E1pGodqiOwW2/ulS6E6
 0hH3ThFWo7vgO8+4OFWd6QtHbz8/U6BfoY7Z7G04GKAof6knbFD2zO9FjMa0WoO0LBlm0jBwrNp
 PlCHG4PDTJQ==
X-Google-Smtp-Source: AGHT+IEmCXDYd+u6D/8Bzf1Jnh+7ZMXKS0KvkRRDFBJ0E9DHhJHp8Za7iYsWzgQ65tK18oyYRtVz7g==
X-Received: by 2002:a05:600c:1391:b0:431:60ec:7a96 with SMTP id
 5b1f17b1804b1-438dc4223c4mr185174315e9.25.1738660895747; 
 Tue, 04 Feb 2025 01:21:35 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm187233595e9.3.2025.02.04.01.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 01:21:34 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 13/18] hw/arm/fsl-imx8mp: Implement gneral purpose timers
Date: Tue,  4 Feb 2025 10:21:07 +0100
Message-ID: <20250204092112.26957-14-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204092112.26957-1-shentey@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
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
index 15514055b5..9293cabb85 100644
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
index dfbdc6ac7f..975887751b 100644
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
index 6646f1c8b4..43395df628 100644
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
index 71102ac0a9..f2859f6a88 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -586,6 +586,7 @@ config FSL_IMX8MP
     select FSL_IMX8MP_CCM
     select IMX
     select IMX_I2C
+    select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
-- 
2.48.1


