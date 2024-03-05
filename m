Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8993C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVEo-0001Vq-Pi; Tue, 05 Mar 2024 08:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVE0-0000xQ-DW
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:09 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDl-0005xA-Ku
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:56 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-412e4619e5eso14927335e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646760; x=1710251560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0JKYOkSiA03lg7OUJXJjM4ddPzSRWI5RZ/kNlzuzX60=;
 b=D1rcJLyeQ2PiUOb2D30FgExMbMZEtXlwhqSpalXn3ERQ5TXA3s+ncI3y0cNy8oaAXg
 kB/ShYrsZ5H79i2IOyphOipciU9uLAtQO7v0KDDapyLfpLKVk4wcAw8r5mrI0uE9bXkC
 Y6aFUkrfS9NY/Ege83WRjq/1L+m/Kt469GPiR6JddWA53oN4wfdKTLzzoWuaCT5MKW9Y
 srDwqFEasKzhlRls5FM7jwY9dcXCWtyvOttnfi0DYC3lPB9bDEDuonz8EbZAScb7N/4L
 BVBbCrOY9KeDql/UZw5srhW6RFdxwdmjGUqdV1VrmrcfP+6sxr13QPiWq9jSdCo/KqSb
 L2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646760; x=1710251560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JKYOkSiA03lg7OUJXJjM4ddPzSRWI5RZ/kNlzuzX60=;
 b=qd0PisARcNy+KV1+QZ9TgZb08dCzW+JZw+3nVtpOLOw2Cr+sYbkCUUuEaSYNdQ6VPy
 JP1q47U3/Nc1+ONRNqzizLP0+v4EM+D0IbKyXP59ZhGGe8e6lTRHCsWK88HoMn8kh9Vn
 K2LveXHGHoxArToTvy5UCdfTnFc9xYx+1ulnYvXjXQtBbXyi5WbDGLLFVMZr0ldsh+1T
 z2uALbU6rsVa2Ru8/hFEH3qNe7TVWZd9dnA66TGxBFJhi3oCyAGDBzMrvJT9PKHjeClL
 DfRzWlkTdUfxTVYDbdsc/tN0LaL/7l62dRzfgPBZ2tQ5irCYNElmrUN68YKAMdgipZkl
 7yQg==
X-Gm-Message-State: AOJu0Yw56zWkxW4Jhuv7EUhQXe0sEnBvOqyWMqQcD+L6ZEeSJaTWEivg
 YODMxQe8rqv+AxpRAHF764nUtSYuSn3Q/fl+I1aNfllaCWJkIyeOxVnq3Zdu7TSkBiFNbF9RIEp
 C
X-Google-Smtp-Source: AGHT+IESMTb40rfLN+eVEomIVwYgZ4YAgp6J+3yvU2V0IpDUkQd3CxwMbmy4mywL0soppmyaB6r69w==
X-Received: by 2002:adf:db0f:0:b0:33e:c9b:396d with SMTP id
 s15-20020adfdb0f000000b0033e0c9b396dmr10725192wri.8.1709646759722; 
 Tue, 05 Mar 2024 05:52:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/20] hw/arm: Connect BSC to BCM2835 board as I2C0,
 I2C1 and I2C2
Date: Tue,  5 Mar 2024 13:52:19 +0000
Message-Id: <20240305135237.3111642-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Rayhan Faizel <rayhan.faizel@gmail.com>

BCM2835 has three I2C controllers. All of them share the same interrupt line.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240224191038.2409945-3-rayhan.faizel@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2835_peripherals.h |  4 ++-
 hw/arm/bcm2835_peripherals.c         | 45 ++++++++++++++++++++++++++--
 hw/arm/Kconfig                       |  1 +
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 1fc96218f82..636203baa5a 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -32,6 +32,7 @@
 #include "hw/timer/bcm2835_systmr.h"
 #include "hw/usb/hcd-dwc2.h"
 #include "hw/ssi/bcm2835_spi.h"
+#include "hw/i2c/bcm2835_i2c.h"
 #include "hw/misc/unimp.h"
 #include "qom/object.h"
 
@@ -68,7 +69,8 @@ struct BCMSocPeripheralBaseState {
     BCM2835SDHostState sdhost;
     UnimplementedDeviceState i2s;
     BCM2835SPIState spi[1];
-    UnimplementedDeviceState i2c[3];
+    BCM2835I2CState i2c[3];
+    OrIRQState orgated_i2c_irq;
     UnimplementedDeviceState otp;
     UnimplementedDeviceState dbus;
     UnimplementedDeviceState ave0;
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index a0bbe76f264..1695d8b453a 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -30,6 +30,9 @@
 #define SEPARATE_DMA_IRQ_MAX 10
 #define ORGATED_DMA_IRQ_COUNT 4
 
+/* All three I2C controllers share the same IRQ */
+#define ORGATED_I2C_IRQ_COUNT 3
+
 void create_unimp(BCMSocPeripheralBaseState *ps,
                   UnimplementedDeviceState *uds,
                   const char *name, hwaddr ofs, hwaddr size)
@@ -157,6 +160,19 @@ static void raspi_peripherals_base_init(Object *obj)
     /* SPI */
     object_initialize_child(obj, "bcm2835-spi0", &s->spi[0],
                             TYPE_BCM2835_SPI);
+
+    /* I2C */
+    object_initialize_child(obj, "bcm2835-i2c0", &s->i2c[0],
+                            TYPE_BCM2835_I2C);
+    object_initialize_child(obj, "bcm2835-i2c1", &s->i2c[1],
+                            TYPE_BCM2835_I2C);
+    object_initialize_child(obj, "bcm2835-i2c2", &s->i2c[2],
+                            TYPE_BCM2835_I2C);
+
+    object_initialize_child(obj, "orgated-i2c-irq",
+                            &s->orgated_i2c_irq, TYPE_OR_IRQ);
+    object_property_set_int(OBJECT(&s->orgated_i2c_irq), "num-lines",
+                            ORGATED_I2C_IRQ_COUNT, &error_abort);
 }
 
 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
@@ -453,14 +469,37 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
                                               BCM2835_IC_GPU_IRQ,
                                               INTERRUPT_SPI));
 
+    /* I2C */
+    for (n = 0; n < 3; n++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[n]), errp)) {
+            return;
+        }
+    }
+
+    memory_region_add_subregion(&s->peri_mr, BSC0_OFFSET,
+            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i2c[0]), 0));
+    memory_region_add_subregion(&s->peri_mr, BSC1_OFFSET,
+            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i2c[1]), 0));
+    memory_region_add_subregion(&s->peri_mr, BSC2_OFFSET,
+            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i2c[2]), 0));
+
+    if (!qdev_realize(DEVICE(&s->orgated_i2c_irq), NULL, errp)) {
+        return;
+    }
+    for (n = 0; n < ORGATED_I2C_IRQ_COUNT; n++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[n]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->orgated_i2c_irq), n));
+    }
+    qdev_connect_gpio_out(DEVICE(&s->orgated_i2c_irq), 0,
+                          qdev_get_gpio_in_named(DEVICE(&s->ic),
+                                                 BCM2835_IC_GPU_IRQ,
+                                                 INTERRUPT_I2C));
+
     create_unimp(s, &s->txp, "bcm2835-txp", TXP_OFFSET, 0x1000);
     create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
     create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
     create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
     create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
-    create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
-    create_unimp(s, &s->i2c[1], "bcm2835-i2c1", BSC1_OFFSET, 0x20);
-    create_unimp(s, &s->i2c[2], "bcm2835-i2c2", BSC2_OFFSET, 0x20);
     create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
     create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
     create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7caebdd98e1..3c157376844 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -438,6 +438,7 @@ config RASPI
     select SDHCI
     select USB_DWC2
     select BCM2835_SPI
+    select BCM2835_I2C
 
 config STM32F100_SOC
     bool
-- 
2.34.1


