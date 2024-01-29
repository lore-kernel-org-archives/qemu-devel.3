Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64835C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 22:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUZyx-00016D-Es; Mon, 29 Jan 2024 17:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUZyw-000160-7G; Mon, 29 Jan 2024 17:19:58 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUZyu-0000mu-IL; Mon, 29 Jan 2024 17:19:57 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6dde5d308c6so2231029a34.0; 
 Mon, 29 Jan 2024 14:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706566794; x=1707171594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZcGi/Mj/JFxvcBR5sflXEQbX73rifjp+JmFM1JHIyqs=;
 b=OUwHotqRz4KwaC9Z/k1q6aM5Vo3bG7XPkjW8rHzIfLKdmbKheenZCLCcbBp1pmhJwP
 TQ4OtcvibI9bfUXSAAXKp8g1Eow7UbZ2wv4xnIwOtTqV1o4AO/totvsQQl4bf7tsIjSz
 fd+UOv0RtFOwo0V7sybSvAMlfrJhh7ZsN6rWu0n2fddL8t+Ak2S0hS1BJFxxTsGGHHXx
 X6FU5petxbYnW/aV/1i/TH92q8yGROecYTOUiMuJ37T3rG/fn18opW6OzlRnry3i7E3M
 0mvJHgNPMEVLn6UrUMnESYa0mkJoQZU8oWzibighuHPpRAUI/7k6UFIIMUmbjN25k2I8
 cxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706566794; x=1707171594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZcGi/Mj/JFxvcBR5sflXEQbX73rifjp+JmFM1JHIyqs=;
 b=tM4xWKJ10eZyV9tqO2OzsnFBe2dw2C1UFpZC3ZiAlB79WtYg/cpPoOOJWYkHw+GtxX
 HMXGbOj2Bfru5XgIOR9SvhihuDPTc/67aiS4JPzy0k6/Ex0AP6OZ3r9epxglluu+x1Vk
 Ueqot422uI49ZLS5ARZKGjcxbJeHCQQWnCzqRR4nbnSJUtr6sENtL9OsywjLa3K6vug5
 NvkIPajQLobJLVboMPOjArmOo9L9sN92Q71DUs/eW6l+zuIhtBDb2rblrH+NDQl6BtjV
 1jUq8a99BucJWwMi4j3O2nyIff0Q4bt6+moQ0OYVDcgOyb/erTDl/KcAxPk8l8kMlX5T
 1Wpw==
X-Gm-Message-State: AOJu0YzAcWwtHzuUvqIMUO+4hWiFimqUuqZ3HcfMxi1+ipCtxBrgAjwI
 ThB1neTYTHW2X4nKuBQOb2U1p0o9a2obSMtM1knth2b1Kwn+MphPNxSpf/J6CsJMDg==
X-Google-Smtp-Source: AGHT+IH2y2opMCWZU/1GKNiCchHPgO8PgaQ0B86wEeyjnNbLm1IiyuU3tSyDabvZZ4XksCW+l4iI0w==
X-Received: by 2002:a05:6358:5e0d:b0:176:5918:c3c6 with SMTP id
 q13-20020a0563585e0d00b001765918c3c6mr3837439rwn.9.1706566794465; 
 Mon, 29 Jan 2024 14:19:54 -0800 (PST)
Received: from localhost.localdomain ([49.47.195.100])
 by smtp.gmail.com with ESMTPSA id
 r19-20020aa78453000000b006ddc1ae04eesm6353084pfn.192.2024.01.29.14.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 14:19:54 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, alistair@alistair23.me,
 pbonzini@redhat.com, qemu-arm@nongnu.org,
 Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH v4 2/2] hw/arm: Connect SPI Controller to BCM2835
Date: Tue, 30 Jan 2024 03:48:08 +0530
Message-Id: <20240129221807.2983148-3-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129221807.2983148-1-rayhan.faizel@gmail.com>
References: <20240129221807.2983148-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch will allow the SPI controller to be accessible from BCM2835 based
boards as SPI0. SPI driver is usually disabled by default and config.txt does
not work.

Instead, dtmerge can be used to apply spi=on on a bcm2835 dtb file.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 hw/arm/Kconfig                       |  1 +
 hw/arm/bcm2835_peripherals.c         | 16 +++++++++++++++-
 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 218b454e97..c8e0f2d78c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -425,6 +425,7 @@ config RASPI
     select PL011 # UART
     select SDHCI
     select USB_DWC2
+    select BCM2835_SPI
 
 config STM32F100_SOC
     bool
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 0233038b95..6b94bffb9b 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -144,6 +144,10 @@ static void bcm2835_peripherals_init(Object *obj)
     /* Power Management */
     object_initialize_child(obj, "powermgt", &s->powermgt,
                             TYPE_BCM2835_POWERMGT);
+
+    /* SPI */
+    object_initialize_child(obj, "bcm2835-spi0", &s->spi[0],
+                            TYPE_BCM2835_SPI);
 }
 
 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
@@ -402,11 +406,21 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->peri_mr, PM_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->powermgt), 0));
 
+    /* SPI */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[0]), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, SPI0_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi[0]), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[0]), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_SPI));
+
     create_unimp(s, &s->txp, "bcm2835-txp", TXP_OFFSET, 0x1000);
     create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
     create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
     create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
-    create_unimp(s, &s->spi[0], "bcm2835-spi0", SPI0_OFFSET, 0x20);
     create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
     create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
     create_unimp(s, &s->i2c[1], "bcm2835-i2c1", BSC1_OFFSET, 0x20);
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index d724a2fc28..0203bb79d8 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -31,6 +31,7 @@
 #include "hw/gpio/bcm2835_gpio.h"
 #include "hw/timer/bcm2835_systmr.h"
 #include "hw/usb/hcd-dwc2.h"
+#include "hw/ssi/bcm2835_spi.h"
 #include "hw/misc/unimp.h"
 #include "qom/object.h"
 
@@ -66,7 +67,7 @@ struct BCM2835PeripheralState {
     BCM2835GpioState gpio;
     Bcm2835ThermalState thermal;
     UnimplementedDeviceState i2s;
-    UnimplementedDeviceState spi[1];
+    BCM2835SPIState spi[1];
     UnimplementedDeviceState i2c[3];
     UnimplementedDeviceState otp;
     UnimplementedDeviceState dbus;
-- 
2.34.1


