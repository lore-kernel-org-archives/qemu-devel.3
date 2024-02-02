Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F45C48295
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvbD-0000oi-44; Fri, 02 Feb 2024 10:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb8-0000Re-PP
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:58 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb6-0004Z2-VS
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:58 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5112a04c7acso3670821e87.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888215; x=1707493015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e6ecdA6XprRoNkA0wb02c6VKGclESqrERe4VSdnbqBk=;
 b=LzsxvyviCi2kTBG/iVhLeILp2s+n2VAjVzl7/HEvuglzogZxrrLndYa6QL/eWURllq
 nOc5w2LhNIJuLuPprSgahdFMOO5nhIBD/UpOGaxCXRkyfTB4i9mQCbPGp9jd41bK3MQG
 cHDmnvLf92vMsiZiPSdySlAhp9b/eabOPIfTr/+NP0BjGwmDU8lsupNFbvP4Vt9wNm8G
 MMMxk6LzqPRTJW1rQki711ikpPVPvy9Uj7OyWwYlhp2H7bxdquNLDpb+inWOGi4F6a8Z
 I3dsVj8eMoHk7I5SkOkwTUFl43bcNVU1iKI3YZkP969wxr9y6pzrHAAlbLcPim6grrNl
 BUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888215; x=1707493015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6ecdA6XprRoNkA0wb02c6VKGclESqrERe4VSdnbqBk=;
 b=ju3XJfONWi/Om/Xb7+Acgqx/nVUoJXNhDBKSLcwNkdz2DmamKYIb5Q0KZYGs+jmjn1
 G1cZSMibxGWclkouOc2hFmEXDMTinGCtDwrDcFa1LsN5eYCgkq9M4sXii0CBRqtxqyAZ
 dbN+oDXofXF5x7jwvqZHdri+jETd4c5dJ1vdVNum5U4UMGZLVcjoDZjYlRXfWMz7XXPg
 AlxjmwX5JAwhSzskFNhtJhmiiNGGjulPg/Ivdm8Xwn6fs6NolidEJeRlOc5xKtRhsz5+
 kW+cwrsOBQCTjQXMmkknAIP0hDG3wfw1Vuph8WiKWw4HfyxnhbIBTEgVc82V2hgRVyuz
 lS2g==
X-Gm-Message-State: AOJu0YzKjX/z3I+DfGozMFwBItN82n4K6ludfAu6fciV1jv13V9DEQz7
 qeWICQKJpn9yAXipJLnQlhfhkV5S/+EcqQILX798/nvJ+B6b6u6P9lx/LX22cdeARnjqKwRgfgx
 R
X-Google-Smtp-Source: AGHT+IHavksK5pw5zPNT6iQaJcvadijdzn84/FbwsSXNS9NyNYmaZRrpENdNaueSB0IXmxYtChtJww==
X-Received: by 2002:a19:6912:0:b0:50e:50ee:f378 with SMTP id
 e18-20020a196912000000b0050e50eef378mr1492125lfc.65.1706888215271; 
 Fri, 02 Feb 2024 07:36:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/36] hw/arm: Connect SPI Controller to BCM2835
Date: Fri,  2 Feb 2024 15:36:37 +0000
Message-Id: <20240202153637.3710444-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Rayhan Faizel <rayhan.faizel@gmail.com>

This patch will allow the SPI controller to be accessible from BCM2835 based
boards as SPI0. SPI driver is usually disabled by default and config.txt does
not work.

Instead, dtmerge can be used to apply spi=on on a bcm2835 dtb file.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
Message-id: 20240129221807.2983148-3-rayhan.faizel@gmail.com
[PMM: indent tweak]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 hw/arm/bcm2835_peripherals.c         | 17 ++++++++++++++++-
 hw/arm/Kconfig                       |  1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index d724a2fc28a..0203bb79d8c 100644
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
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 0233038b957..d5573fd9545 100644
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
@@ -402,11 +406,22 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
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
+                       qdev_get_gpio_in_named(DEVICE(&s->ic),
+                                              BCM2835_IC_GPU_IRQ,
+                                              INTERRUPT_SPI));
+
     create_unimp(s, &s->txp, "bcm2835-txp", TXP_OFFSET, 0x1000);
     create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
     create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
     create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
-    create_unimp(s, &s->spi[0], "bcm2835-spi0", SPI0_OFFSET, 0x20);
     create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
     create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
     create_unimp(s, &s->i2c[1], "bcm2835-i2c1", BSC1_OFFSET, 0x20);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index db08a00a45b..980b14d58dc 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -429,6 +429,7 @@ config RASPI
     select PL011 # UART
     select SDHCI
     select USB_DWC2
+    select BCM2835_SPI
 
 config STM32F100_SOC
     bool
-- 
2.34.1


