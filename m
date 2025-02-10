Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BF9C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thW3d-0007wT-0b; Mon, 10 Feb 2025 10:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2n-0007Eh-3W
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:57 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2l-0004hu-5R
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:56 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso45148765e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 07:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739202593; x=1739807393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C5heOUGneotf5f/UOG2KrqgfCQsXkzBU9Lgw0sQAJEA=;
 b=a5EvWjUI6yrJ/FeG9V1ub5stDrNBZUbKhKtZzmCxliPUlfhJwIv67Jv6jvh9U1P0Am
 lll0sKnR/vEGkD21z4s6hbRDNqWSgZV0AfidMI1pvB7n35cKSOev/4wIgmYSg5urA8u1
 dLgTAMOYJuTAOFXNlq3vdXPMRmb/15yb4w+DklozddKLPfVXyoXJ+G3CicVpQG+BGrHP
 BGTdbFedg99dH/0k3RF6uwwItjYrBdOm9zR97Lm6Alr4PK9nf1S+MWf+zs6nT4FPMqCZ
 4y9gONnWXj1DBjUG1Ugb68VYA2KFqL4iJou9c/1gh4Z/V5n1LD/hviY7BP9H2ZUnGSad
 k6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202593; x=1739807393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5heOUGneotf5f/UOG2KrqgfCQsXkzBU9Lgw0sQAJEA=;
 b=fCqHjkXo/qdEy0hUW7qhrMl7fcSWlfdXhVVWnt1qfKh15QPKtCDX+6YDopoiR1MeBH
 VAkDjTHFEBMCZnrB/Sw67KlsmURuc5ZN/qTGFWksujfqIqjmewb87DYRVSC2ZOaeauk6
 8eAgnCxHyg97KVpsUGR5/Pu2Wg0k2aSx1EaYaiIRNvDGOW33MTY4oaYYtdVRjYBDU4fD
 PURF2pqD0cgrhlhgohFcy0c+FXJ5jjcubOImZs7uO6RiyZveA44PlLg7QNBg6e/CT1lf
 PpIrDx5GC/wsNCpD9GeoXXmXm0c3vaZz+3CURExUJawU48NrumQreTHruf9fbkuJDhaC
 Mkfg==
X-Gm-Message-State: AOJu0Yz0x/UMdiulz3PUgRw/mQFMryMonhhruokWK2LfaIvPeh4Od60n
 UBZn6R4hqrhdaxvfXPLqym2Q9gIU96ppTTelI++W0e8C/k/RakCeFIl3HPFrbr76M31vVMDczGy
 +
X-Gm-Gg: ASbGncujBpf/SUG1oot4vMEdtgPp/x+XqCyfR7NOXJJy1Tdc2A6K88UFu7bBj4QN7xj
 ATXp7as+Nq1T2pDjLH/jmomnsc35h7954ciW7URpFBLK2W2rFB5TfHor6GUkJLN4bTS43vmljjY
 QPz42XP6h5MZXKO0medpXuZuWZkPmPjS8B7cju9GI3IAeX0vWn4Zx1sDGXcTPKVR3bJT6V8BNvE
 yog2zVvVeDcwGpRqch5nf3ci0HoFMRKn9+IJPI4nSxn2NHD/uK7/IbKfi14N264xDIWXjasQMDo
 PETbvkke++9RPNRkJ+ZL
X-Google-Smtp-Source: AGHT+IGFNTQNRd9xmoW3Yd9Z7r81Lk1T+20ykM3vgSfrySpSbU66jBvyLvZTbTQzA/NdQPDV4h/LGQ==
X-Received: by 2002:a05:600c:1e25:b0:436:17e4:ad4c with SMTP id
 5b1f17b1804b1-43924972ce9mr110357145e9.6.1739202592647; 
 Mon, 10 Feb 2025 07:49:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8448sm150612845e9.38.2025.02.10.07.49.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:49:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] hw/arm/fsl-imx7: Add local 'mpcore/gic' variables
Date: Mon, 10 Feb 2025 15:49:37 +0000
Message-Id: <20250210154942.3634878-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210154942.3634878-1-peter.maydell@linaro.org>
References: <20250210154942.3634878-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The A7MPCore forward the IRQs from its internal GIC.
To make the code clearer, add the 'mpcore' and 'gic'
variables.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250130112615.3219-5-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.34.1


