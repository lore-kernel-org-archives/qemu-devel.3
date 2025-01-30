Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F82C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 11:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdSgv-0001VH-W9; Thu, 30 Jan 2025 06:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdSgr-0001Ss-1X
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 06:26:34 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdSgo-0001i2-Rm
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 06:26:32 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so6906105e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 03:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738236387; x=1738841187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhRlD77beLPzJcSw02NRGa4doYLPI9EP5dBJ40nCc7c=;
 b=N1FprsRioc9MNh6574cdcMnLgdauVDlNc3gUfn9U6WhmlX4Dva1CkKwxfmNLqYcX3u
 xJmq6u7977SgpExOetltkuhOcu1RbbTOx8CHw765Z5M97VHgbq59gmZKO8OfXaR1upru
 5bALRbbwW6BasizcQMxjO+qNh0poWivRuPVgwZW4Opl+Xds2mLcr49k8w7kJWP9JhUWf
 AQPhhSVGtqPHV0sfGR+291B1M9YVXTS0u2Zr9zb3pbnJecDlIOTbMrmg44VhBq8ebrKN
 8kGQIP3CnaZDvXnBGIdSAL6XExC/hYANhmzxjXTc0uGpTdheF4y1tKU8EgUzzedDPN04
 xMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738236387; x=1738841187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhRlD77beLPzJcSw02NRGa4doYLPI9EP5dBJ40nCc7c=;
 b=stbsvSP15Jd9HJchpiG4grxZuwOamY18zXDxSo/kSvf5aXbqrYfIMRu1hLHTcOjZAr
 51gj0y942gVIDQ5JAiTUQ9D/dyutNk6+eBYQVOMmwR7/Kz99IOAh15AYe9SsaE3Fvj0S
 Gf4DEsAjKc5NnilYIVctPcL9HCsECQTyHW3pi1kazRSrR0uOIWSqFpq8t+Q8ALvN1DIy
 UTjQ7v/vd/K4SuDR9i/PIp02pnBbLnqwj6JoLmcepivnIWcpWejfwJObXUaBHPuTd+lT
 3CnnfBspVaMBUWCNS1lFJmSwvbV6TBxMFoNF59/QVjT+Ri1Z7KRgAg8p3c1KTK5+NMy4
 KR1g==
X-Gm-Message-State: AOJu0YyOyrEd6JEGd+OwndB13qAkghjwAUoVIDyQSJZ9wom2YZ37kGGJ
 lyU1bp8YZiK8YTHTR24mxQYy+tkLc/5I4OF54QpLtBzJF0imzjY8HHpf9t0Qme1wNHDTSOcrqSc
 LcBU=
X-Gm-Gg: ASbGncslXjXQehumfyZRvaNheanwSMTw6JyNNqZUCmDlF+hkFf/APv8etD738VE8DBL
 tt4xXVyQ9Zcz/PcWqr6KgFrOEppMXXyl0rHKCLySYs2cIPqFqxC7kcH5y+ao8IlkHdGW4SqbY5P
 vKT9VtpPBDZgSmYLEkG+3NIWMYKpi5GeDQQuS4jNYi4VMVlIv/zVHfWU5G5wgHHpzxYCTG36jXI
 lA83didVX1prR/JBigqLtlvcKTqukTLpe9tN0CZ7Rnkif0ERbmDATM2T10AoT2+LM9H1swOQuos
 FPUb6yuiymREuUwlPAExB4ZnQ6K+qa13dXKqCUjw6ziaiPipMrsnc8ikmyChXcBlsQ==
X-Google-Smtp-Source: AGHT+IHQjhsSFHFclv5jkxUmpblxUEtfO5GGS3h65ZoInT7gOUtNMA0LSMd0ouYnsy1+PTNDZyuziQ==
X-Received: by 2002:a05:600c:450c:b0:434:ff25:199f with SMTP id
 5b1f17b1804b1-438dc4213fbmr50596475e9.26.1738236387288; 
 Thu, 30 Jan 2025 03:26:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244ef41sm20089185e9.32.2025.01.30.03.26.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 03:26:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 2/6] hw/arm/fsl-imx6: Add local 'mpcore/gic' variables
Date: Thu, 30 Jan 2025 12:26:11 +0100
Message-ID: <20250130112615.3219-3-philmd@linaro.org>
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

The A9MPCore forward the IRQs from its internal GIC.
To make the code clearer, add the 'mpcore' and 'gic'
variables.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.47.1


