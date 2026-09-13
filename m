Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F99C88E5C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 18:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5omM-0005kH-Vl; Sun, 13 Sep 2026 14:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1x5omB-0005i4-NX
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 14:18:04 -0400
Received: from mail-lr2-x10.google.com ([2a00:1450:4864:38::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1x5om9-00022g-IH
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 14:18:03 -0400
Received: by mail-lr2-x10.google.com with SMTP id
 38308e7fff4ca-3a2ff176d5eso12477431fa.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789323480; x=1789928280; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0HzlsMupkT43STyFi+zWkNuXYuyJLKJmneYJJfz5S2w=;
 b=q/CGLTR1J0WnvYWqhEiyaImmUIDO1gMeFTAAgoBeGnkZ5vW2Gyntlflcr1OKnXUL6Y
 doHwu+eFkbKFwOvC2Wo1ioRLGfwpN3FlGJwqayYzsVnh00g7hNJwSJy5AhIepswV5tIQ
 RcpWkg1OjJVzpIB5XMD1bY9I7GjmfFvRaC/4ttouXerYCmwOtZF4RyC+bwgdE0HOyQmQ
 GFuM8KEWjuqdAFGvvd8NPOpPm4qZhFEQZsaagDwxs1yPcC2UcmzqbOGBtU2gyIbvoU0/
 gTk0VR23m5WcswIEwJif1m7wr7TqIabiHplsdA4alYOUI11QLvxc+TQinJlQuw/IWQzk
 5DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789323480; x=1789928280;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0HzlsMupkT43STyFi+zWkNuXYuyJLKJmneYJJfz5S2w=;
 b=aTeyXKMhUiUoQqhJVYOILyILELstapnrecH0D1lUgX+cP12CpXkpxqM1Dluyo9stLb
 L2MjahQIVkTc95bfTMbQvuGX6Sr+8wx8GAwcPtUitP55v21zTKgFXkKsQr08BggTcaH7
 lG6la0S79cGh5iJ1srdopgQYFTY2sgeyBgR5qOMHWvmI/xxpJZvB/WHM2W8IqLnprCp7
 OQJT2j+dTnDhU71jSqcCNOLJ6IlCCYPitHYFw/AGI1w1qmr/xaRewS2j1WgtAi0nOXhj
 7RKG0AoibuajEGsvfpeR1juvivQRifVgTBBu0xFrSJboZNfuMVabXSixo+Fvlwg5yDXw
 V07Q==
X-Gm-Message-State: AFuF++nCFbYR06ODh/ZzKKANTriSsjYIL30YgDsQ/TaFX/Sn6PoFNohx
 gBlJSMfrywHJ6x/MWiBf7HXFp0xlywnPyU5awj3uWLtj/+frGVF0/9i9m3ysPsoVxCE=
X-Gm-Gg: AYBFou0IIBS29H6OYSvKl4er9ZlxREzpwlh2OY6mWC8EIr67y9xHJmS+Co+q2LzT/v/
 IjBHGkxLTqAV74n+BFHvK8BhXTo7rdRQv0xKlkYLfpdU55gNvhD/zuLGJ1vWoiqJLI1Qdig+TEr
 DvUeWqPlZ1nYkxfFSgVTkYZkN8plDZbnY3iKnpDmGZ2CO+INkk7xPtjZfOYfbb9vpVKK0Cmb1Wj
 +xBpIRv8myav6bVTMnIZLMfFEQFpOne1lFirU7UBcFplwnfRahVhCctvMzMa9ablgNlo5rf8PG4
 wQeyssdUsX1r7QOV2tDF03onJBXU2XJFYRcCruH3UYKmUoy7aHpU/djrS0V9YlHUK/iMgzDsihQ
 OJjPfu+7cAQMD8AFUZjZFvp32gpbj3Z0ElAYNnqzwkKIx1gxO7h5Gu0nKcDwqyTcuR9xWaYj0nf
 7Iq8cUghJeGqSbrn5P52gowFhaW4ZmTHFYiqi7VaWsKBtxH22L5owz95TQAViUdjgrCG3/RAUkV
 l/xng4LRVlJrVPtaz0aULh+s1MoISrbtXQCUBglr3gM/NxhLCjUboh7eAI=
X-Received: by 2002:a05:651c:1503:b0:3a4:99ed:beac with SMTP id
 38308e7fff4ca-3a5a51c9fc4mr37246061fa.4.1789323479624; 
 Sun, 13 Sep 2026 11:17:59 -0700 (PDT)
Received: from [192.168.31.141] (213-65-111-204-no600.tbcn.telia.com.
 [213.65.111.204]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5a3326aecsm21122951fa.19.2026.09.13.11.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 11:17:59 -0700 (PDT)
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Date: Sun, 13 Sep 2026 20:17:31 +0200
Subject: [PATCH v3 2/3] hw/arm: Add GPIO to Allwinner A10 model
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-allwinner-gpio-v3-2-a9affa474b3b@gmail.com>
References: <20260913-allwinner-gpio-v3-0-a9affa474b3b@gmail.com>
In-Reply-To: <20260913-allwinner-gpio-v3-0-a9affa474b3b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Jack wang <163wangjack@gmail.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:38::10;
 envelope-from=strahinja.p.jankovic@gmail.com; helo=mail-lr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The Allwinner A10 GPIO is added to the Allwinner A10
description, so it is available when Cubieboard is emulated.

Update the documentation for Cubieboard to indicate GPIO availability.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/cubieboard.rst | 1 +
 hw/arm/Kconfig                 | 1 +
 hw/arm/allwinner-a10.c         | 8 ++++++++
 include/hw/arm/allwinner-a10.h | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/docs/system/arm/cubieboard.rst b/docs/system/arm/cubieboard.rst
index 90d24c73a1..ee9f489ead 100644
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
index eae06369b0..4445f16f45 100644
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
index 66f30757dd..66fe484ae0 100644
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
index 445ba1be21..8b7736c7bd 100644
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
2.55.0


