Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520EBCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZFG-0005zF-R4; Tue, 16 Jun 2026 15:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8R-0004hq-VY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:46 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8L-00015k-6u
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:40 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-46019edc13dso2389662f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636850; x=1782241650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DDFEDfApovF7jVMAHqKHtDSTTw1A8a353M/NBq8GCgA=;
 b=zXQH8tgmHKux/vaqd51tvBaNn1iLMjVEgPs6xL6d6g1CPSHyBMnPhfJx749T1jNK1n
 GFe2PkVvgbBZsfLRr9EHlgGT9dlW6gsFVq1oollGahDxb3xnzxyS8Q4GBC2VMFvrTzqr
 AMri4VkYpElxw3VzjJ05/wSvljnuNGmm0loGayAIiVXYf8n9Y+SsTIhx0iismcgxi2Q0
 TE69/03kzqOX+TqPgi3aqfWIHvzlXKuDA8DR2d0NKiw++DDDsugCPtcV1oWCJGhKBK5T
 8/lgQNNXtSjDKbFakl5YN6WBuF7dNxP3pYlK7rb3aJyXV6wbakZMdGBVBHb0kTUYmjR4
 aTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636850; x=1782241650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DDFEDfApovF7jVMAHqKHtDSTTw1A8a353M/NBq8GCgA=;
 b=T5h1rSsb+CrSMOrKdH4cOl8pxWU59pBtJ4MSx9x4BX3LUIjpT9WGE/oRKOEOApPdPa
 dOdzyk/dqxVp2FJsMkXxyjRmE+OJr+04YF5VLCnjIJpPRY6ECzeMC6eQYDvdZMHdfJiV
 MpXaySxOMVE6ui3jzNtPsmH8DdYqHL0EjHv+1Azfjko2Y5mxvS+jHN3BS96GYPKjxt29
 eJ3nWEguHN1SH/EPwN9XvkAxDhx6AjR4RYdjSRfxgtTToxVvMSO6nqIM7OHhREKEpQP5
 9BC3CMvDx8u5FTkYz8rnEobmlvp6Ry6xEjDqg6PGbzb5Z0kzxaiVrPmeWkwNPlpR3i+3
 eDgw==
X-Gm-Message-State: AOJu0Ywnhz+dwmPC/Qn3t4qGk2lPpbTlkU050tvvBQoHToAhwaouS+IW
 PvLB/Oy2rk3s5n8SaG+hMKrbEIFbismZm+Ic1qpbdhL6j4pSB7jFlfzOKgEiEhsiP2uHaputoq6
 p98Yj
X-Gm-Gg: Acq92OEmCNiXPMutNYU86ZUokXCLMhFNBtezY5bWy9ehaAwHvZatdb3KRatHgKNN4kF
 yOqp77vhKlMCUxD0mOrp44wL95V85Lu7xL9P26kwQeXKxm+aJtmL72bIzCRMXNy2vftrg4Q/p6l
 CjixoQ6Pp5C5CrXVmNO3LaDez6pGiG5eqcvBkX4723VO2cEUUCyZwG8tuWm3QlaOI913v8MYggC
 zyykO6vE/v/po4winc9TkXg720rVdQKmn5nHJwlOETbaUCNsWwaGI2b37HMcF6hSLgo+mjcpT5B
 ucNm65J2w03evVLxi57FF5DhFLZPnURhXo7v3Sc6x1smVIenpCtohwEHhf2o9iPgD5eZb30zwLb
 4i8MdlMboxLQRfT88wi6TzAf6jl3OYYyIndVJ9EvS9Y5xaYrQJx4rVTjaDYKpwBUAtn8sEYg19L
 ShftDwTmBW2jRdi1qBps370K3u4gjhAkTtck0dqfJ2OR9D3vIRrCi5et+YcaYFp0vuDMYonheT6
 XpazaY2wsgaXKx+P/qonQfTRKXBo9B+
X-Received: by 2002:a05:6000:4007:b0:45e:f3b2:122a with SMTP id
 ffacd0b85a97d-46240cf969emr1017103f8f.26.1781636850116; 
 Tue, 16 Jun 2026 12:07:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/61] hw/arm/bcm2838: Route I2C interrupts to GIC
Date: Tue, 16 Jun 2026 20:06:20 +0100
Message-ID: <20260616190639.3462006-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Nicholas Righi <nicholasrighi@gmail.com>

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
Message-id: 20260609024027.22140-1-nicholasrighi@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


