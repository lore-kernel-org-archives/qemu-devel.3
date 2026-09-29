Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1FFCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUeh-0006xM-VE; Tue, 29 Sep 2026 06:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUeg-0006x5-5t
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:46 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUee-00087z-H5
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:45 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843c3ea1f6so2179323f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676103; x=1791280903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xINePJIRXNKMnUd9OUs615HAdFRt0Nl+Akf6sHOm/9Y=;
 b=XB3q/XqQWxaO/n1O+c++0DfFBTgcV232JRmkSnNucftYvA0BwIpQmP6dE1GqD0PEut
 mF/ZaR82U2ZyX6VFKTYWtp+ZzDLjSTFQrF4O/rl3Er9vo0C567UnZmZ9jNDMq0Gpc7kA
 D85x3LqFdN6CoiaXG1wYuYZQNmZoEIEtBcPAcbeZ/QOxiVURZQ+RRFLJsKTIB7KW7Cps
 pTMnTpNh8x5kgc0jLfy8142UFfdWbMfwu70CkbIp+JzDinsWYflxyDzbrmkhhuIjklLO
 J1s8Jz+qfiwP6+oc/JzeYrdesXDlJRkAVLvSKyYlnTXgtZILnp4FFlc3YO+oWDRWu0d5
 1Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676103; x=1791280903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xINePJIRXNKMnUd9OUs615HAdFRt0Nl+Akf6sHOm/9Y=;
 b=UgxNZ6SUyhRnRjq2Hs5/oddZdsZonY9Bm8ggQEYn7+vMP6oJNrZ+1WrrCtRTa8wVBj
 LkufYBrWkc8Uv8ISyxskwJvAIQ+eau/zhoBhmqbA6mgLT5/FHOF+D3fOYJuQHRX8G/TY
 19fO9lisxGC8Ci4nWh3zPp/F1tCbXuLvUdOgdVAO1IG0R53WQ+pmpeMcdpz1TdFYikvF
 HkHa2xlOTykfNZl+2K2J9pLdkzpFV1TgkrRD6dREiSpjiJz+b2NjhXsCj3tBGLqXCZqL
 qi837sIiejYUkm2A1gnsUuT/hZK6jOkvrPmBSJUrg/SMBAOov8THDbq1C93DfTjN31AY
 U+TA==
X-Gm-Message-State: AFq9FYL2Y0zFzkp9I7Ag6X90mmHbet9udJluFTSGQ6oAcVxKdjHl2HwY
 tIxHt+axnwGKkqrJsBhJxC9MG6FO21DqgSu1OikRjV0mPunbsShxmRI/GPCesWFGCc581gqmWkG
 n1HpW
X-Gm-Gg: AYBFou3JjW+LIPqcX4SuzG4uU9ri5OenlwlW3GbhO57CPr2BZ8IvPVIbkcaIOn/uSSv
 IYfW5nDo4eCwZ20cpFwLrRF3I7GCPXCw7vOw4NcIOQHBG47JY9vCQkrue+heYR/Be6l3s9+Lci0
 hZg3/kNk5RBTaxAZg6aGW/HHahs+hUGx6x7+LQOFrF3p4qOqeJWCc8J2tk0rJzIl2nnF1NMIL12
 Ok0lGVuFLa1KgdvRqQsEK0y2RsMzCrmoIMH9V6FOuBqeTRSNdvS69gO4sHXDVm/a8utIqYtlqna
 sgYqIrzK59COtoEsNEYkzmH5MCEpFwJol415x9mSP3X1OcF5fmx7dFjrOIvUQ2QBIrtOTroWfMB
 4/Wt1dZrfzP1t4SA/XkBTRxftci5taMneAWbyUEXZxOp22/lgZWSlg21bBSvJ6BlW3aaCpEJbra
 hZllGpgG1G0sD5zt8qtxcecZo7jiqoMfo7IcuYAdHHRIYLlz5hcJdPfCbVnTCtOefwUksIDRxRO
 /ODRi2tx7rtx8j8JOPlHuPFExqHTCFXIbV/jna/T4rw+dG5MYpjOwVWHNpEdCD34E2B8JKUh6VL
 cRs3YGK3larLoQ==
X-Received: by 2002:a5d:5d0c:0:b0:487:1f7:f506 with SMTP id
 ffacd0b85a97d-488835f2adamr22759461f8f.11.1790676102832; 
 Tue, 29 Sep 2026 03:01:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/37] hw/arm: Add GPIO to Allwinner A10 model
Date: Tue, 29 Sep 2026 11:00:59 +0100
Message-ID: <20260929100133.2598676-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>

The Allwinner A10 GPIO is added to the Allwinner A10
description, so it is available when Cubieboard is emulated.

Update the documentation for Cubieboard to indicate GPIO availability.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260915-allwinner-gpio-v4-2-b1ee1d09c9fd@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/cubieboard.rst | 1 +
 hw/arm/Kconfig                 | 1 +
 hw/arm/allwinner-a10.c         | 8 ++++++++
 include/hw/arm/allwinner-a10.h | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/docs/system/arm/cubieboard.rst b/docs/system/arm/cubieboard.rst
index 90d24c73a13..ee9f489ead2 100644
--- a/docs/system/arm/cubieboard.rst
+++ b/docs/system/arm/cubieboard.rst
@@ -12,6 +12,7 @@ Emulated devices:
 - RTC
 - EMAC
 - SDHCI
+- GPIO
 - USB controller
 - SATA controller
 - TWI (I2C) controller
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index eae06369b02..4445f16f451 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -295,6 +295,7 @@ config ALLWINNER_A10
     select ALLWINNER_EMAC
     select ALLWINNER_I2C
     select ALLWINNER_A10_SPI
+    select ALLWINNER_GPIO
     select AXP2XX_PMU
     select SERIAL_MM
     select UNIMP
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 66f30757dd5..66fe484ae0e 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -41,6 +41,7 @@
 #define AW_A10_EHCI_BASE        0x01c14000
 #define AW_A10_OHCI_BASE        0x01c14400
 #define AW_A10_SATA_BASE        0x01c18000
+#define AW_A10_GPIO_BASE        0x01c20800
 #define AW_A10_WDT_BASE         0x01c20c90
 #define AW_A10_RTC_BASE         0x01c20d00
 #define AW_A10_I2C0_BASE        0x01c2ac00
@@ -83,6 +84,8 @@ static void aw_a10_init(Object *obj)
 
     object_initialize_child(obj, "spi0", &s->spi0, TYPE_AW_A10_SPI);
 
+    object_initialize_child(obj, "gpio", &s->gpio, TYPE_AW_GPIO);
+
     for (size_t i = 0; i < AW_A10_NUM_USB; i++) {
         object_initialize_child(obj, "ehci[*]", &s->ehci[i],
                                 TYPE_PLATFORM_EHCI);
@@ -203,6 +206,11 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi0), 0, AW_A10_SPI0_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi0), 0, qdev_get_gpio_in(dev, 10));
 
+    /* GPIO */
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, AW_A10_GPIO_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0, qdev_get_gpio_in(dev, 28));
+
     /* WDT */
     sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &error_fatal);
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->wdt), 0, AW_A10_WDT_BASE, 1);
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 445ba1be212..8b7736c7bd1 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -13,6 +13,7 @@
 #include "hw/misc/allwinner-a10-dramc.h"
 #include "hw/i2c/allwinner-i2c.h"
 #include "hw/ssi/allwinner-a10-spi.h"
+#include "hw/gpio/allwinner-gpio.h"
 #include "hw/watchdog/allwinner-wdt.h"
 #include "system/block-backend.h"
 
@@ -42,6 +43,7 @@ struct AwA10State {
     AwSdHostState mmc0;
     AWI2CState i2c0;
     AWA10SPIState spi0;
+    AWGPIOState gpio;
     AwRtcState rtc;
     AwWdtState wdt;
     MemoryRegion sram_a;
-- 
2.43.0


