Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14392CD8C9D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 02:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWmOV-0004z9-6r; Mon, 08 Jun 2026 22:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicholasrighi@gmail.com>)
 id 1wWmOQ-0004yO-Mf
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 22:40:42 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nicholasrighi@gmail.com>)
 id 1wWmOO-0002p4-SB
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 22:40:42 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-84231305a80so2682892b3a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 19:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780972839; x=1781577639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sq6/7Tj1as7K589sHSt916NnS5Zheorryj+Xj3dr6eM=;
 b=EigD/3/B8iE8WjXt7h0RyMIyR//c+H2NTkQq3bWwD0SmtxAZ2kUg2HXfbV5D2XtlBt
 eoIfG22EnhfiZEhf0JKv/SrG1hyXkllUWIIaAWLBQ5XryTlO1OA6VqbjuNWCU0DmxBIX
 uvqIRhhfbkOTFvJOKMJwDguvT7HuUfmwYcfiogOcWLUwmpL/GZmskds4jmQ8/YVNwxf+
 C3hcfcqBYfSiDzi0qL4HDFutShrWhk6mVVwkYXDEnIAik4FqDMfioBQoRD1CAJtsLaWD
 vg+qMUCUB0PKlW6urr+c8e+X7gBubY2mkkHIsz7/C73ujs1lCgHD/JwWzJWws/yvt5Ly
 b57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780972839; x=1781577639;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sq6/7Tj1as7K589sHSt916NnS5Zheorryj+Xj3dr6eM=;
 b=I5XccxRBUIUb+FKaqr06TMqba7HRw+AYTtwjVPYz64YMSTz4Lnikg6ESMp7+NajlPI
 rHurL0MOqGkMRYddA6vIRavbXsbuYuAvGJ6fcUrKVbQ0zI6PH783sXY99bGIRwRS45BN
 TKn+nBSWZmL/2BY9jt8y45mfT5LPFbMtA9fcJbCjlRC2H4ByY6d1UifjPGpWcPAwTx8S
 okftM2rA95vLvAwYOpu/hBj2r17WLHQcfPiEeq6M2AKKic2Zz9roeo6szSYozssf1LqG
 59OEXZcuSExV7msEeWjkcL9IHII4qzFHxV8S6oZY2Cn+FtXr5BfGXkVY0jzN3vnCTlzM
 5LVQ==
X-Gm-Message-State: AOJu0Yx0Jj6mBDeCTX/JNKN9QKxQcmZQx866A48AnX1SCcv6m1WjUSQt
 lBsiJPplmFcd8h1hI7fKNhkt4sYrj3zkhfDkXI0m7XY/mGWjIJFEP/I2Jt8buIxJ
X-Gm-Gg: Acq92OEqfpMxZQ5QGsWLPnj9UfbwcbD3Wb23YgypC64s76F44yOxXmKvez4SiKTtXay
 XPqnH1qSlheppn9kPuRyYFG5cZZulxkSCNQ461nwPguTT604ZtKMEsqSJF7gcD2ctn7mUcwmoKd
 TQxzH2vPy1AAgNVZZUe/9kgMLhHjH8CjpiD2jVUbeXnSW1pCkaOD6xD8z6ORiPg/GE16CyoY3I/
 8SQlA7p3w5Oa3/09SmsUcFbX6NOLOd4W40Y/jRHHQYVOa61nWHcSDCPUGskEdLcOrii+8cr+5V2
 Hsq3wM0ctA2TaNE9Z+S7x8jQLhQTCmUFtiFzQoFaCyw+SEq2HuaCK9MknKzuzEvAT3nI0KXAhq+
 vYMo9QbTmRQVkfghRTzLMcKN30Vr3e+7Af+4WejKc2KaJQnL6mIJ2KLXel2aQ1LlT4BaAXMDNef
 bITR6YL1+mf98KEe7RhJObw4myIBS5hmLdcpvSeVVozaR6aQDgRSbKx1S10U/PcqERPO0sLr6nf
 7j7zDNV8JWVcaeZLKhUYm3NQLEUbDG/TKVHWg==
X-Received: by 2002:a05:6a00:ab83:b0:842:2280:538f with SMTP id
 d2e1a72fcca58-842b0e74b30mr18534645b3a.16.1780972838791; 
 Mon, 08 Jun 2026 19:40:38 -0700 (PDT)
Received: from DESKTOP-G2FUN8N.hsd1.wa.comcast.net ([73.59.59.170])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-842828e5638sm20128838b3a.50.2026.06.08.19.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 19:40:38 -0700 (PDT)
From: Nicholas Righi <nicholasrighi@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Righi <nicholasrighi@gmail.com>
Subject: [PATCH v2] hw/arm/bcm2838: Route I2C interrupts to GIC
Date: Mon,  8 Jun 2026 19:40:27 -0700
Message-ID: <20260609024027.22140-1-nicholasrighi@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=nicholasrighi@gmail.com; helo=mail-pf1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The I2C interrupts are only routed to the legacy interrupt controller. This means
that for modern device trees that use the GIC, the interrupts don't work. This patch
adds a splitter to route the I2C interrupt to both the legacy interrupt controller and the GIC.

Testing

Add these lines to QEMU invocation

-drive if=none,id=i2c_storage,format=raw,file=eeprom.bin \
-device at24c-eeprom,bus=i2c-bus.1,address=0x50,drive=i2c_storage,rom-size=4096 \

note: eeprom.bin is all zeros

Before this change, running i2c get to read from EEPROM would result in this

i2cget -y 1 0x50
Error: Read failed

After this change, running i2c to read from EEPROM results in this

i2cget -y 1 0x50
0x00

The eeprom can now also be enabled in the device tree. Before the
eeprom driver load would fail due to the read failing

ls -l /sys/bus/i2c/devices/i2c-1/1-0050/ | grep -i eeprom
-rw------- 1 root root 4096 May 17 16:57 eeprom

Signed-off-by: Nicholas Righi <nicholasrighi@gmail.com>
---
Changes v1 -> v2:
    - Use a splitter to route the OR gated i2c interrupt to both the
      legacy interrupt controller and the GIC, instead of just replacing
      the legacy routing with the GIC routing
---
 hw/arm/bcm2835_peripherals.c         | 9 +++++++++
 hw/arm/bcm2838.c                     | 4 ++++
 include/hw/arm/bcm2835_peripherals.h | 2 ++
 include/hw/arm/bcm2838_peripherals.h | 1 +
 4 files changed, 16 insertions(+)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 8a1e72dfab..558c180df9 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -179,6 +179,8 @@ static void raspi_peripherals_base_init(Object *obj)
                             &s->orgated_i2c_irq, TYPE_OR_IRQ);
     object_property_set_int(OBJECT(&s->orgated_i2c_irq), "num-lines",
                             ORGATED_I2C_IRQ_COUNT, &error_abort);
+    object_initialize_child(obj, "orgated-i2c-irq-splitter",
+                            &s->orgated_i2c_irq_splitter, TYPE_SPLIT_IRQ);
 }
 
 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
@@ -504,7 +506,14 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[n]), 0,
                            qdev_get_gpio_in(DEVICE(&s->orgated_i2c_irq), n));
     }
+
+    qdev_prop_set_uint32(DEVICE(&s->orgated_i2c_irq_splitter), "num-lines", 2);
+    if (!qdev_realize(DEVICE(&s->orgated_i2c_irq_splitter), NULL, errp)) {
+        return;
+    }
     qdev_connect_gpio_out(DEVICE(&s->orgated_i2c_irq), 0,
+                          qdev_get_gpio_in(DEVICE(&s->orgated_i2c_irq_splitter), 0));
+    qdev_connect_gpio_out(DEVICE(&s->orgated_i2c_irq_splitter), 0,
                           qdev_get_gpio_in_named(DEVICE(&s->ic),
                                                  BCM2835_IC_GPU_IRQ,
                                                  INTERRUPT_I2C));
diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index c14a854046..089af412a3 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -184,6 +184,10 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->aux), 0,
                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_AUX_UART1));
 
+    /* Connect the I2C interrupt to the interrupt controller */
+    qdev_connect_gpio_out(DEVICE(&ps_base->orgated_i2c_irq_splitter), 1,
+                          qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_I2C));
+
     /* Connect VC mailbox to the interrupt controller */
     sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->mboxes), 0,
                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_MBOX));
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index bf35bb18e5..4f356f4643 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -33,6 +33,7 @@
 #include "hw/usb/hcd-dwc2.h"
 #include "hw/ssi/bcm2835_spi.h"
 #include "hw/i2c/bcm2835_i2c.h"
+#include "hw/core/split-irq.h"
 #include "hw/nvram/bcm2835_otp.h"
 #include "hw/misc/unimp.h"
 #include "qom/object.h"
@@ -72,6 +73,7 @@ struct BCMSocPeripheralBaseState {
     BCM2835SPIState spi[1];
     BCM2835I2CState i2c[3];
     OrIRQState orgated_i2c_irq;
+    SplitIRQ orgated_i2c_irq_splitter;
     BCM2835OTPState otp;
     UnimplementedDeviceState dbus;
     UnimplementedDeviceState ave0;
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 7ee1bd066f..0be97e67c7 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -22,6 +22,7 @@
 #define GIC_SPI_INTERRUPT_DMA_7_8      87
 #define GIC_SPI_INTERRUPT_DMA_9_10     88
 #define GIC_SPI_INTERRUPT_AUX_UART1    93
+#define GIC_SPI_INTERRUPT_I2C          117
 #define GIC_SPI_INTERRUPT_SDHOST       120
 #define GIC_SPI_INTERRUPT_UART0        121
 #define GIC_SPI_INTERRUPT_RNG200       125
-- 
2.54.0


