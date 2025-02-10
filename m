Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FD3C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thW3p-00084t-4F; Mon, 10 Feb 2025 10:51:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2l-0007E3-CM
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:55 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2j-0004hi-9Q
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:54 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43946b5920cso6369065e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 07:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739202592; x=1739807392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GfwJRA48Ef7R/4hsGioZ2ghukFnct9ZSmvwKBNkVGKM=;
 b=PgOnuoIyyYvBhz738p9WqYiWa/c5/0OzCdbhbN3UWld3xpf3Cln6tOWBOYRUlrGz2P
 L7gqwSK4rhffS4/wTSSjap9cbHOjWeVlVYkal5GrOqESp5tCMlkHYv/JHdaEK5BrDNvy
 HSPrSi2glTqYqXoCWhR2tWwJqN9YsmTWnVwQ/77N1oaBMzCA45MS46zrS4S5PbY//Twk
 pvnzLzqEe02DKRNoDSMPMGLnuQB5skK4DE2k+0AAi9XHhp7KwHmyR5K6rthRsc5604fm
 zfC8RzdABhWlBQ3Y/lVzlVcZrareR1VUtp0MwD/lPHUWM/Pzz8YCGYAytCQ8tMhnsNTD
 wqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202592; x=1739807392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GfwJRA48Ef7R/4hsGioZ2ghukFnct9ZSmvwKBNkVGKM=;
 b=VFNFg3BXYLSJbP/KN/BYSBe+RvNA2IhOXBHt6mboVAIt1YJrbITfdqAcWYaFtIkdHG
 jSWNg1lTwoRCv/FiDg0W1Vw4jZ+nrLJH7k6QbaXFAfBjPXhV0OC0OYbhGfKps6ljSN/V
 7/bupqsMDz0vQBlW9urikCpZLZSIzCZ4L/wMjksZY5ZXkx0u0P3yhHL1cb+TtY6FeQV5
 zsWNkCTOE17OSSFwVkOTjhFdFb1zlCEXrO/nXGeJ31ktO9QuNlPwMHfbOP+zv4gbifw+
 w9hm/MGEp9BiHWIwZM1GgH8wbYfeRnFSnT/BBNLyeOYVbA1IJC/VKgiEAvKrI+exy0M3
 WdOQ==
X-Gm-Message-State: AOJu0YyxiEOnYope2qJ3WuZad2c+G3bStYRyj+zzkHyXq4z101i3Qd1s
 E3NOeDoFNdchRU3jr8dEUysh6RlgY9hWTWhOMqZbxbtFY7ia6pg3WSvUUJ76dUIhhOWOWSN05+p
 D
X-Gm-Gg: ASbGnctVGGqTvlt1A1I8tY3NX7PR6dQMGIBEbrEunwrfLwgwZOz3ECaDKaiSnTtJk03
 mNPrGITyBr6TByCqiO2RSDGq8ww6WcuwfMeYk50FfFkfGwVZAQYLLICS0Nz+0C6ehmEjEggHM+4
 sGVVUsNP3CLKQZUswLpZOH1ydbqJ/u7mM5UfbFi/zyYsWdPU3DLsoo03b8T6Z2/l+asUm6wNKli
 LVqdV4fTQ1u2fV7KZSbgzFD4kho25DTQSLfFdRb9yQVMJrBR3Y5sy88kkiTmi/VQaTkJ2lPw0zq
 4eqYNE7Dg/6c2hAVPIjc
X-Google-Smtp-Source: AGHT+IEt7QLnUkoyPQhGTB62mj0N923Vedv+sxJgvWSMP47yrsFFFgm1FhzamiBAIAVXe3QJK8V48A==
X-Received: by 2002:a5d:5085:0:b0:385:db39:2cf with SMTP id
 ffacd0b85a97d-38dc8dbf454mr7035430f8f.12.1739202591670; 
 Mon, 10 Feb 2025 07:49:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8448sm150612845e9.38.2025.02.10.07.49.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:49:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/12] hw/arm/fsl-imx6ul: Add local 'mpcore/gic' variables
Date: Mon, 10 Feb 2025 15:49:36 +0000
Message-Id: <20250210154942.3634878-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210154942.3634878-1-peter.maydell@linaro.org>
References: <20250210154942.3634878-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
variables. Rename 'd' variable as 'cpu'.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250130112615.3219-4-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx6ul.c | 64 +++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 79e4847953a..34c4aa15cd0 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -157,10 +157,12 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX6ULState *s = FSL_IMX6UL(dev);
+    DeviceState *mpcore = DEVICE(&s->a7mpcore);
     int i;
     char name[NAME_SIZE];
-    SysBusDevice *sbd;
-    DeviceState *d;
+    DeviceState *gic;
+    SysBusDevice *gicsbd;
+    DeviceState *cpu;
 
     if (ms->smp.cpus > 1) {
         error_setg(errp, "%s: Only a single CPU is supported (%d requested)",
@@ -173,19 +175,19 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * A7MPCORE
      */
-    object_property_set_int(OBJECT(&s->a7mpcore), "num-cpu", 1, &error_abort);
-    object_property_set_int(OBJECT(&s->a7mpcore), "num-irq",
+    object_property_set_int(OBJECT(mpcore), "num-cpu", 1, &error_abort);
+    object_property_set_int(OBJECT(mpcore), "num-irq",
                             FSL_IMX6UL_MAX_IRQ + GIC_INTERNAL, &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->a7mpcore), &error_abort);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, FSL_IMX6UL_A7MPCORE_ADDR);
+    sysbus_realize(SYS_BUS_DEVICE(mpcore), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(mpcore), 0, FSL_IMX6UL_A7MPCORE_ADDR);
 
-    sbd = SYS_BUS_DEVICE(&s->a7mpcore);
-    d = DEVICE(&s->cpu);
-
-    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(d, ARM_CPU_IRQ));
-    sysbus_connect_irq(sbd, 1, qdev_get_gpio_in(d, ARM_CPU_FIQ));
-    sysbus_connect_irq(sbd, 2, qdev_get_gpio_in(d, ARM_CPU_VIRQ));
-    sysbus_connect_irq(sbd, 3, qdev_get_gpio_in(d, ARM_CPU_VFIQ));
+    gic = mpcore;
+    gicsbd = SYS_BUS_DEVICE(gic);
+    cpu = DEVICE(&s->cpu);
+    sysbus_connect_irq(gicsbd, 0, qdev_get_gpio_in(cpu, ARM_CPU_IRQ));
+    sysbus_connect_irq(gicsbd, 1, qdev_get_gpio_in(cpu, ARM_CPU_FIQ));
+    sysbus_connect_irq(gicsbd, 2, qdev_get_gpio_in(cpu, ARM_CPU_VIRQ));
+    sysbus_connect_irq(gicsbd, 3, qdev_get_gpio_in(cpu, ARM_CPU_VFIQ));
 
     /*
      * A7MPCORE DAP
@@ -244,8 +246,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                         FSL_IMX6UL_GPTn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_GPTn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_GPTn_IRQ[i]));
     }
 
     /*
@@ -269,8 +270,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                         FSL_IMX6UL_EPITn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->epit[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_EPITn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_EPITn_IRQ[i]));
     }
 
     /*
@@ -307,12 +307,10 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                         FSL_IMX6UL_GPIOn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_GPIOn_LOW_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_GPIOn_LOW_IRQ[i]));
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 1,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_GPIOn_HIGH_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_GPIOn_HIGH_IRQ[i]));
     }
 
     /*
@@ -366,8 +364,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                         FSL_IMX6UL_SPIn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_SPIn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_SPIn_IRQ[i]));
     }
 
     /*
@@ -392,8 +389,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, FSL_IMX6UL_I2Cn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_I2Cn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_I2Cn_IRQ[i]));
     }
 
     /*
@@ -430,8 +426,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                         FSL_IMX6UL_UARTn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_UARTn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_UARTn_IRQ[i]));
     }
 
     /*
@@ -480,12 +475,10 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                         FSL_IMX6UL_ENETn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->eth[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_ENETn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_ENETn_IRQ[i]));
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->eth[i]), 1,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_ENETn_TIMER_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_ENETn_TIMER_IRQ[i]));
     }
 
     /*
@@ -521,8 +514,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usb[i]), 0,
                         FSL_IMX6UL_USB02_USBn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usb[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_USBn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_USBn_IRQ[i]));
     }
 
     /*
@@ -547,8 +539,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                         FSL_IMX6UL_USDHCn_ADDR[i]);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_USDHCn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_USDHCn_IRQ[i]));
     }
 
     /*
@@ -580,8 +571,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
                         FSL_IMX6UL_WDOGn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
-                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
-                                            FSL_IMX6UL_WDOGn_IRQ[i]));
+                           qdev_get_gpio_in(gic, FSL_IMX6UL_WDOGn_IRQ[i]));
     }
 
     /*
-- 
2.34.1


