Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC5FC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 11:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdSgz-0001Wv-RV; Thu, 30 Jan 2025 06:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdSgy-0001W9-33
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 06:26:40 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdSgw-0001jC-BB
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 06:26:39 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso6845885e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 03:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738236396; x=1738841196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y10l/HYlkhSToy5oRoIjMOJTqZRFYA42fVDeO+zru8o=;
 b=eAjTQ/pYa+pZDnE1segUvZPCgAe64h06DiCBAMUuHodK0tQI/n8idnrFQ/JzqW9ndf
 S6bJLR3HQeY1dszRYDXlgxsw52gf6OMee8UjQcKSMycrcEA99QWqqNIfDEu7pLIW3dWX
 H49jdfo6rtsM3hMAyXQteim8g/U/gc22191GLGcSnsJTm4uVSN9+p5ZFvlTr661ikiw/
 l+zDp5GZUz1YxuK4mhAB0mJdJo9feBG23NJ99o3Dur7vNgEO1z9pKnu8+yDXg/HZFLwE
 aJ6zX370pQszhzB1FMOC8RC7wBYxizsZ2pOc/015y49BQtjew9cvwCsFLPkjGIfd/GwJ
 IK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738236396; x=1738841196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y10l/HYlkhSToy5oRoIjMOJTqZRFYA42fVDeO+zru8o=;
 b=RcWgGHrJ3h/rpLUzUOM/qoSCSj7nYIX1Pv5reqOPgnID3L1S9V2acPNbN7Gh6i3O4Q
 swZ898jCQVH2JC656tCAhF+8nHcT6OVIDLwT8DApJPuAdGPSWX8LrW47y1W5VFdx2XsS
 1kL9rmkN8+/tkoTLMBFT1GhO/diiwv0ZdBGAl30iLMoL1xabxsi330tSQtCZIQ1LQ/gK
 DeNynxTbSv/VsiwvRhbcSFFZ0JL5lSHWYHJ2mEMj0wzIC8J1a1bEPL/vsxp/WZP6gGPp
 B7NQnAO7ABendZLfBmhOaoeeg3mTCfo7xcZE8jAgT1IeRfcOD3SXnK1GrO66JGF98NHr
 WXfA==
X-Gm-Message-State: AOJu0YyOjV+fqT4mjWoCbXKyxTBlxHe1SZV7TMEuPeWmvzb5a5AzMa5v
 6PVNLIfK3oEneu+kgXhLC9LfsuYYjjA897ZqkAIGAVwON+Dzoj0qJVyoPnb/vWvAbP9+EUgKfds
 s2cU=
X-Gm-Gg: ASbGncsxbOXd8ziMno74FwTSq7s+KmAUqexRRz5Jyy70l+jKdjVXA9HgT10jePbKd0N
 iywE9P+41VvxOWJhbRgomFsfdXHMsU1TivvKLz05u9SrHKBqEgMMZUkjJh30/VNgIxeC4PSGZoA
 UGQJMerb6obwRD4W/NI2jax3hCFlJyP96CkgGPHbh0jpH2ywEKMDlgGj747c4fecPRVCEP8ApZB
 ZjE9Hg+NMzLzpAFTz3D3PXboWepo/U1bpjrU4lcwHUAmj8cXtxgJvtj80RDWxDS+LFzrdzyMAnm
 nXP04TvgTzdUjT8t0pTgOAFDY5W0Hdv+ZRSAHCsFzmhN36nfk1fB3usjY+hGPfNTxQ==
X-Google-Smtp-Source: AGHT+IFfmqC/Qgvp95wL6SF1waRzN+VL0deAqBGBsd28FgWGmTNzMxKTNcHzegNvwhtkkuID0y4JWA==
X-Received: by 2002:a5d:47c8:0:b0:38c:1270:f96b with SMTP id
 ffacd0b85a97d-38c520af7a5mr5173742f8f.45.1738236396533; 
 Thu, 30 Jan 2025 03:26:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b61f1sm1719272f8f.68.2025.01.30.03.26.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 03:26:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 4/6] hw/arm/fsl-imx7: Add local 'mpcore/gic' variables
Date: Thu, 30 Jan 2025 12:26:13 +0100
Message-ID: <20250130112615.3219-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250130112615.3219-1-philmd@linaro.org>
References: <20250130112615.3219-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The A7MPCore forward the IRQs from its internal GIC.
To make the code clearer, add the 'mpcore' and 'gic'
variables.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/fsl-imx7.c | 52 +++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 004bf499376..3374018cde0 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -166,7 +166,8 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX7State *s = FSL_IMX7(dev);
-    Object *o;
+    DeviceState *mpcore = DEVICE(&s->a7mpcore);
+    DeviceState *gic;
     int i;
     qemu_irq irq;
     char name[NAME_SIZE];
@@ -182,7 +183,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
      * CPUs
      */
     for (i = 0; i < smp_cpus; i++) {
-        o = OBJECT(&s->cpu[i]);
+        Object *o = OBJECT(&s->cpu[i]);
 
         /* On uniprocessor, the CBAR is set to 0 */
         if (smp_cpus > 1) {
@@ -205,16 +206,15 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     /*
      * A7MPCORE
      */
-    object_property_set_int(OBJECT(&s->a7mpcore), "num-cpu", smp_cpus,
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->a7mpcore), "num-irq",
+    object_property_set_int(OBJECT(mpcore), "num-cpu", smp_cpus, &error_abort);
+    object_property_set_int(OBJECT(mpcore), "num-irq",
                             FSL_IMX7_MAX_IRQ + GIC_INTERNAL, &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(mpcore), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(mpcore), 0, FSL_IMX7_A7MPCORE_ADDR);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->a7mpcore), &error_abort);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, FSL_IMX7_A7MPCORE_ADDR);
-
+    gic = mpcore;
     for (i = 0; i < smp_cpus; i++) {
-        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->a7mpcore);
+        SysBusDevice *sbd = SYS_BUS_DEVICE(gic);
         DeviceState  *d   = DEVICE(qemu_get_cpu(i));
 
         irq = qdev_get_gpio_in(d, ARM_CPU_IRQ);
@@ -255,8 +255,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0, FSL_IMX7_GPTn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX7_GPTn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX7_GPTn_IRQ[i]));
     }
 
     /*
@@ -298,12 +297,10 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
                         FSL_IMX7_GPIOn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX7_GPIOn_LOW_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX7_GPIOn_LOW_IRQ[i]));
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 1,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX7_GPIOn_HIGH_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX7_GPIOn_HIGH_IRQ[i]));
     }
 
     /*
@@ -355,8 +352,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
                         FSL_IMX7_SPIn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX7_SPIn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX7_SPIn_IRQ[i]));
     }
 
     /*
@@ -381,8 +377,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, FSL_IMX7_I2Cn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX7_I2Cn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX7_I2Cn_IRQ[i]));
     }
 
     /*
@@ -416,7 +411,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, FSL_IMX7_UARTn_ADDR[i]);
 
-        irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_UARTn_IRQ[i]);
+        irq = qdev_get_gpio_in(gic, FSL_IMX7_UARTn_IRQ[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0, irq);
     }
 
@@ -454,9 +449,9 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->eth[i]), 0, FSL_IMX7_ENETn_ADDR[i]);
 
-        irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_ENET_IRQ(i, 0));
+        irq = qdev_get_gpio_in(gic, FSL_IMX7_ENET_IRQ(i, 0));
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->eth[i]), 0, irq);
-        irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_ENET_IRQ(i, 3));
+        irq = qdev_get_gpio_in(gic, FSL_IMX7_ENET_IRQ(i, 3));
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->eth[i]), 1, irq);
     }
 
@@ -483,7 +478,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
                         FSL_IMX7_USDHCn_ADDR[i]);
 
-        irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_USDHCn_IRQ[i]);
+        irq = qdev_get_gpio_in(gic, FSL_IMX7_USDHCn_IRQ[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0, irq);
     }
 
@@ -522,8 +517,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX7_WDOGn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX7_WDOGn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX7_WDOGn_IRQ[i]));
     }
 
     /*
@@ -606,11 +600,11 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTD_MSI_IRQ);
     qdev_connect_gpio_out(DEVICE(&s->pcie4_msi_irq), 0, irq);
 
-    irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTA_IRQ);
+    irq = qdev_get_gpio_in(gic, FSL_IMX7_PCI_INTA_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 0, irq);
-    irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTB_IRQ);
+    irq = qdev_get_gpio_in(gic, FSL_IMX7_PCI_INTB_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 1, irq);
-    irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTC_IRQ);
+    irq = qdev_get_gpio_in(gic, FSL_IMX7_PCI_INTC_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 2, irq);
     irq = qdev_get_gpio_in(DEVICE(&s->pcie4_msi_irq), 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 3, irq);
@@ -643,7 +637,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
                         FSL_IMX7_USBn_ADDR[i]);
 
-        irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_USBn_IRQ[i]);
+        irq = qdev_get_gpio_in(gic, FSL_IMX7_USBn_IRQ[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0, irq);
 
         snprintf(name, NAME_SIZE, "usbmisc%d", i);
-- 
2.47.1


