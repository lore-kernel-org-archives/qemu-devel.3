Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28361C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 11:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdSgx-0001Vm-37; Thu, 30 Jan 2025 06:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdSgt-0001Tu-9n
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 06:26:36 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdSgr-0001iQ-KY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 06:26:35 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so366227f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 03:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738236392; x=1738841192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMrvsV6YgWPBIsyDxMy+6e6ZqNU6ujpKBkumGUjGbfo=;
 b=C8F58iJ+JLVHoKWVOHLKC7S8SNSNX1urb7E8GJhX60tHJDWwl4vq4vB3CebNlsHQnx
 M+EEsS/A+LnAm3hoThbkXgT5A2DT+iC2/nUtqz04/LnnewvVKbE7iDcasllwjRmgapwg
 2Htlea/K5lDNg7BLrRbsyv9xvSPM6HvacV/LyirP8zhf4hVrwpbVxwelc5gH+Cl155Wi
 XcRpZXmGdJ6YOZc5Jz741uh3DLBkwkCX/k2oOBeMIWVVX7fcNR/TODUZpl6JOfKHk1YX
 OVPf+/Qu478V/xKxz/rL+wWIQDzePqr5Bkt6nLE/Q41YysccZ68L/1pQIVycSiiLVqps
 6RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738236392; x=1738841192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMrvsV6YgWPBIsyDxMy+6e6ZqNU6ujpKBkumGUjGbfo=;
 b=rnXKWvyYfIT5Fl4uKpscM9dOma94GTrXDpybMVetMQeyvV1xn41ORKPEr2MGKOcSDF
 pxrF+l7024C65T0umGQeioHT65T6qVXfHhY3Br1CsuhxH+lMy+AGSW5sBkiRKHA4x5JY
 t6z6W0aDfWptk0PCxBzeBow6nw28AMnzQ8WJTnl4iggwNSxzMSywsKhfvqSqElsQP1Vw
 RFMqmIHWOUG/qMGNCI9FJWT1nhlaEgwo48qTXbGtKPZOCwpDdcxAHtGLmxl7h0DW9I5c
 vz6x1cZF7YUzv2m5+pP7GA6XOooGa3OFYO3ZMAaxfLt1BJOxODUEvMaWPHeU8pY6CItk
 nOXg==
X-Gm-Message-State: AOJu0YwNiouBUQ/VJUu6QTEDfbFawL7GHuQBKotuqaBCDrTp8MkrTlhB
 cVYWXnpmjsi2k8v09pqZFbRIrSx7PAFUqew8u6Xi8jqrua4mLYwcDvSbtt7USV+wBl0GCBw0hCa
 Y/gI=
X-Gm-Gg: ASbGnculn70j5HH2BCreodx1NZjwqJZtkiwK4EuQQDbKAqYyDPU5F8pldCP5NznZStE
 4dYbi0pqgpu9oVV+HG4r01hZ4807kcgFA9qG16RVDThk4X1NDO0UiT00GhgXj0A0JXkrI8yHMaZ
 7rPmvgKjbRc8e4xP9TC03Xqyk0Q+vkdbbgy0NRyn9Win/F98gTQZZokY7STKz+hzmAM/kgzTwOK
 2iaOCC70NxSDpFhUQ/EDUzsaNniV7NYpV9/K0vX0LKvSVEF9a48kLSdeV+m4fwUCKMiI+8NRj4V
 PbBw4rEKeyKlv3H0ynYcCo2Jf7AdyUqADF1nQCdtJZqNupKsvqsy8G0X4WyVgzLPvA==
X-Google-Smtp-Source: AGHT+IH5j6d3L7fdyiNSNcmgncNdi4XYYk5uf6PeOp49r2djUWWJpAkBhOklwXtbu0jAaY/uFW/cvA==
X-Received: by 2002:a5d:4311:0:b0:38b:ee01:ae2 with SMTP id
 ffacd0b85a97d-38c5a96bbcemr1691798f8f.10.1738236391831; 
 Thu, 30 Jan 2025 03:26:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d443esm20516545e9.1.2025.01.30.03.26.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 03:26:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 3/6] hw/arm/fsl-imx6ul: Add local 'mpcore/gic' variables
Date: Thu, 30 Jan 2025 12:26:12 +0100
Message-ID: <20250130112615.3219-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250130112615.3219-1-philmd@linaro.org>
References: <20250130112615.3219-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
variables. Rename 'd' variable as 'cpu'.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.47.1


