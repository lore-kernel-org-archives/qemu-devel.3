Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5DCC021B3
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASd-0000C5-Gl; Sun, 23 Feb 2025 06:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASW-0000AS-P9; Sun, 23 Feb 2025 06:47:44 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASU-0005yQ-QU; Sun, 23 Feb 2025 06:47:44 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab7483b9bf7so571437866b.3; 
 Sun, 23 Feb 2025 03:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311261; x=1740916061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqFgfbyWk93oKjQXyndCb1rFIwimZHIVhvendeNJn78=;
 b=UJ1DR3vWbblDzEvFUTi7gzRE0shGBHq7wJic/N2skpO5uzp12E8oz2IJycrTXzQ11g
 82sT1s+LfcGqH/r+w7trFGaBoiTyCYdAtvM5F6qvfnGRphf9hgL0m3waZ2NfMS4n6SZK
 4S+OLCy4BkFEKrZViHwMRsUM+FSBDEPPBY0LZ5Ngsjd6VvM9UpG9lmarN6oZEvzMbyec
 MHhsQEDl9cboOMkppozAU3TS1rwGpr0IR/mPWQS8O27g2UZAEyGdzhnEuIDpUd4pAQgK
 QF5nT1Cg7LRzgbd9j1qqPvq61RmRAoVwN92d8eSULGYoIpPbXHSbUCJ7uHJzmaStT9rW
 CxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311261; x=1740916061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqFgfbyWk93oKjQXyndCb1rFIwimZHIVhvendeNJn78=;
 b=b4cJ2HLmT3Y3aETFxOnGWnt4+Li7xhLu8EJZd7U2WnEN1d0PR255klOYdQVpcQBiRh
 cB7ltmk16hc4ZBmbgIa+V4H/J9czkuhHk8ya59jXokKe+PShro/3pFHyRtn4cETwyudZ
 BZ4l7wygETUnDFbFG5mCzFuPqo1uoFzDWaN7FqCKmo0RN5k+8r1QUb9Uxtujo/bdyCx1
 GnkXmeA+cnELE04vJIWPw0+wlViohZuNSzRZ3qnnLtQuO2r7eOEE4pxy/M8b5aT2ipET
 r/eZJf4mdkbOGX4lDv1mnpCTlG8cNISASXYAj2VFr36THeTawgxCPcz+ncILPMKg0HUG
 56cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3DPJ5v5xYfcrIHCRXp/5rfelcEWHFiRRqqeXQwCT1n0P9mHYHDxLxfpl23Kg2B28XkCyDDBfhag==@nongnu.org
X-Gm-Message-State: AOJu0YyupJPmDP2y0fAGdwTpGiA5NMPcTJdbtZbc+qB1KsYutyrazQBG
 SsZsm89ElBX2rIrP+E1bwG/Pfg/F6g8rc/ffy1lPHHyrNDkFxNAhWDb+Dw==
X-Gm-Gg: ASbGncsuVzG3coRiXjQoDr5vAx6JB8ChOfCJeuN1tv4W1qX8i1Pnt93B3YCLUpQPUNI
 Cnp2M/veI2aq9XyvxyBaD7iJLAmS9RhsDTRn3o7Ae5Pqhmm+QF1jZSbwAUsRVGGlDB7FxKJ9hxr
 yw1Qmm+UyGnLILZkryL6ZQKuxMs1ePmOErUuXyh1a9woq7COHksVGZ5CaZIgBWNEH2+Ezbf8RoW
 OvrVzrB1IqKZLty7IU+48dKdSAesVnNDVhqBNna9MXjVbzwD/PNjXVGC67+arn33D9LK3BDHVNi
 sKgyobcBOJaC9ypTu54M/SuPEPM73QKh8sUeuJ4rtz5dmBPTsO0b3EUOfvWJFmJASjgmC7yuINb
 UwtmlEBbc7YdV
X-Google-Smtp-Source: AGHT+IEKmTI18RHBSx2hlepR+8EA/I79tlZnHJaXYpN7DvfoUUB1p5rzo69MQuBeeqcWuVLu8OnB4g==
X-Received: by 2002:a17:907:1b26:b0:aa6:af66:7c89 with SMTP id
 a640c23a62f3a-abc099b83a3mr1027246966b.5.1740311260420; 
 Sun, 23 Feb 2025 03:47:40 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:39 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 13/18] hw/arm/fsl-imx8mp: Implement general purpose timers
Date: Sun, 23 Feb 2025 12:47:03 +0100
Message-ID: <20250223114708.1780-14-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 904de9aa7d..4b195c917f 100644
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
index 0e031b8c5e..dcf67c5889 100644
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
index 98ac93a23f..4e83895b91 100644
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
2.48.1


