Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265B7C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thW3a-0007n3-2f; Mon, 10 Feb 2025 10:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2k-0007Dt-Ag
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:55 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2i-0004hb-IY
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:54 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dd91c313bso947061f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 07:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739202591; x=1739807391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P1zTV046GvXS18jMcMjoDQaPzFuj/OqreJqi8vNtLao=;
 b=S3SZvcFYxyUvL0hYIKOsSvE3R6gtVNv9TZwiq2IHwQz6iCgu3Rb4JEyeX6rreheoek
 2ntHhM6ICoGoa3A8Uu03GT02MHu5iMGyOk+g5AeDuj6L4n3crphhkkoFw894YpirCs/l
 jwHIRnmB2ezQUTQf4vHGxnsUYI9aAdUuLnNEfBttH4btTNcfr3z2GOQVm1aK1Tj+Fbb2
 7usdJMloBTw0gKZ18InZKdYwq2pvbN3l6b7x7ImHh6cYLLYPo1CLXsFzKmfO9a5jjVOc
 BVD3OJoi2F6gLYVoqUNBJn7q/Iyzs2uso119JC8iSXkQ2JDF+zK+zNgwWuIhW9r5kIQP
 4epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202591; x=1739807391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P1zTV046GvXS18jMcMjoDQaPzFuj/OqreJqi8vNtLao=;
 b=ssClIrbtfBOrwl+JFhpP1MD/3CfsPDKGRifmrGU3toW/hW74UmLV5DbrQN6ZscnliX
 4jgYEFXflLccr1itx9H7fXbiTF/nVhQnysgd2mwKETEPpJFF2X3Cbv1aP6PSNsvTwcHS
 IStO/wgPSvaBZLD8zUL5+3zwj2oTBC3BORfx95MoEDkH3KWnsUHNWvW2+vRoRZrLOrJM
 me44QZM/a1FkoBvVeo/VBxno+xOVvDTs8OE+7bs1lqplPIhfIoiTfee62qyE1NOvuIRQ
 YQXAQvESs0QI7biKdmeVA2epVcJohkfd08mCtrYmwLA6qQBLD3NvIJRagDXi+DpVTsLI
 zwqw==
X-Gm-Message-State: AOJu0YxtyT7GJMoyyQ4PtTNzpNrfVJMxQTb7b1XmwXOs5CldYdaC/O6p
 56sM9Uyu9csYj/wd9xG6u0kTiV4wvu+o1ACfPedNOecRWSLSEcOdAayMbC0HcqbQOzaMIbU/7Ay
 p
X-Gm-Gg: ASbGnct/E+l4Z1nJdvBgtwkILd9qDzrXgHcCT1Yi08lLThaZRs0BAD9RI7a/rX+oAZR
 7vO3wpZG0zaJb7MCtWExpYLN9oI+x5zYqJsk9ZuOhgFdoNr+xiva7olVxgxROoracAzaznuH9PQ
 kAgRPDbrWy7/B7UXFeHuoUm07vnAjhU/JP0ByyMn5YrHTeN/HPt5vTac9lPZOxi0Uao1b0wCydy
 JMFF2Jtm3xhcPnttFGyRKW1mHvZAI2FnnsKPfswEn2uWagFRyizEGvpfmp0gNC8zxPsMpNKvkEn
 t/kqitNE33tEt0JsnDxz
X-Google-Smtp-Source: AGHT+IEEEGPfqivm22SRXMNwi+u1DSbfTgID6gMniUbb8M1RtgAEpSl0gs88PQiERf3MWzhECuWgAg==
X-Received: by 2002:a05:6000:178a:b0:38d:c771:1a21 with SMTP id
 ffacd0b85a97d-38de41c54cbmr40332f8f.50.1739202590731; 
 Mon, 10 Feb 2025 07:49:50 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8448sm150612845e9.38.2025.02.10.07.49.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:49:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/12] hw/arm/fsl-imx6: Add local 'mpcore/gic' variables
Date: Mon, 10 Feb 2025 15:49:35 +0000
Message-Id: <20250210154942.3634878-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210154942.3634878-1-peter.maydell@linaro.org>
References: <20250210154942.3634878-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

The A9MPCore forward the IRQs from its internal GIC.
To make the code clearer, add the 'mpcore' and 'gic'
variables.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250130112615.3219-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx6.c | 52 +++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 88b9ccff493..dc86338b3a5 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -117,6 +117,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     uint16_t i;
     qemu_irq irq;
     unsigned int smp_cpus = ms->smp.cpus;
+    DeviceState *mpcore = DEVICE(&s->a9mpcore);
+    DeviceState *gic;
 
     if (smp_cpus > FSL_IMX6_NUM_CPUS) {
         error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
@@ -143,21 +145,21 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    object_property_set_int(OBJECT(&s->a9mpcore), "num-cpu", smp_cpus,
-                            &error_abort);
+    object_property_set_int(OBJECT(mpcore), "num-cpu", smp_cpus, &error_abort);
 
-    object_property_set_int(OBJECT(&s->a9mpcore), "num-irq",
+    object_property_set_int(OBJECT(mpcore), "num-irq",
                             FSL_IMX6_MAX_IRQ + GIC_INTERNAL, &error_abort);
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), errp)) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(mpcore), errp)) {
         return;
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->a9mpcore), 0, FSL_IMX6_A9MPCORE_ADDR);
+    sysbus_mmio_map(SYS_BUS_DEVICE(mpcore), 0, FSL_IMX6_A9MPCORE_ADDR);
 
+    gic = mpcore;
     for (i = 0; i < smp_cpus; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->a9mpcore), i,
+        sysbus_connect_irq(SYS_BUS_DEVICE(gic), i,
                            qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_IRQ));
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->a9mpcore), i + smp_cpus,
+        sysbus_connect_irq(SYS_BUS_DEVICE(gic), i + smp_cpus,
                            qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_FIQ));
     }
 
@@ -195,8 +197,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            serial_table[i].irq));
+                           qdev_get_gpio_in(gic, serial_table[i].irq));
     }
 
     s->gpt.ccm = IMX_CCM(&s->ccm);
@@ -207,8 +208,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt), 0, FSL_IMX6_GPT_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt), 0,
-                       qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                        FSL_IMX6_GPT_IRQ));
+                       qdev_get_gpio_in(gic, FSL_IMX6_GPT_IRQ));
 
     /* Initialize all EPIT timers */
     for (i = 0; i < FSL_IMX6_NUM_EPITS; i++) {
@@ -228,8 +228,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->epit[i]), 0, epit_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->epit[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            epit_table[i].irq));
+                           qdev_get_gpio_in(gic, epit_table[i].irq));
     }
 
     /* Initialize all I2C */
@@ -249,8 +248,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, i2c_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            i2c_table[i].irq));
+                           qdev_get_gpio_in(gic, i2c_table[i].irq));
     }
 
     /* Initialize all GPIOs */
@@ -307,11 +305,9 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            gpio_table[i].irq_low));
+                           qdev_get_gpio_in(gic, gpio_table[i].irq_low));
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 1,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            gpio_table[i].irq_high));
+                           qdev_get_gpio_in(gic, gpio_table[i].irq_high));
     }
 
     /* Initialize all SDHC */
@@ -338,8 +334,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->esdhc[i]), 0, esdhc_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->esdhc[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            esdhc_table[i].irq));
+                           qdev_get_gpio_in(gic, esdhc_table[i].irq));
     }
 
     /* USB */
@@ -360,8 +355,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
                         FSL_IMX6_USBOH3_USB_ADDR + i * 0x200);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            FSL_IMX6_USBn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6_USBn_IRQ[i]));
     }
 
     /* Initialize all ECSPI */
@@ -384,8 +378,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_table[i].addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            spi_table[i].irq));
+                           qdev_get_gpio_in(gic, spi_table[i].irq));
     }
 
     object_property_set_uint(OBJECT(&s->eth), "phy-num", s->phy_num,
@@ -396,11 +389,9 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->eth), 0, FSL_IMX6_ENET_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->eth), 0,
-                       qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                        FSL_IMX6_ENET_MAC_IRQ));
+                       qdev_get_gpio_in(gic, FSL_IMX6_ENET_MAC_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->eth), 1,
-                       qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                        FSL_IMX6_ENET_MAC_1588_IRQ));
+                       qdev_get_gpio_in(gic, FSL_IMX6_ENET_MAC_1588_IRQ));
 
     /*
      * SNVS
@@ -427,8 +418,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX6_WDOGn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
-                                            FSL_IMX6_WDOGn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6_WDOGn_IRQ[i]));
     }
 
     /*
-- 
2.34.1


