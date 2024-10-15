Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79710CFC286
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewZ-0006gc-1j; Tue, 15 Oct 2024 06:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewV-0006dl-Dp
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:19 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewS-0005wN-Ix
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:19 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d4c482844so2984285f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988695; x=1729593495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=47U5s28OGpM6bb1dLZ8yiy3hyxHlTkKckKzJhK7slhA=;
 b=CStta/v55clxwg3Dw7yEeLQSO9QKJ+IOTroZSS9YqjT/ryUCe5UnYjDiAxiEQU4fbk
 +evzGzpxwINRQzF+gBA25odwXA4FpScTfiAAvN0aBhv2b5hTvcF9Qk4Vd+kESqQGqrwY
 fn5kInQhfNy4GQj69vl7TBZKTuk0IdfMd+avM1sDLCGXLspem75ZPYBCOl1y8/WDLenw
 byIZVCg2qJTKej9lwtX5rJ+Y6QJzL5b4jd4myugwvZhVleHfZdZwG2JLssQ9fLjxStyq
 TWzza6B9KDQUtqWUBv8SSQVyQ9YoyRB1DKVf0Y7gtAWrx6/16ZeJHlMrqa+UjZRkJTCz
 iyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988695; x=1729593495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47U5s28OGpM6bb1dLZ8yiy3hyxHlTkKckKzJhK7slhA=;
 b=NO0rkeSYbsKONNBCHeFuGGpxqiFTlwO0j55c74Ov5I5EOWCYE8W6e0mTIv6eT6dpCW
 6ohBXWQhOUB2ySkJxOcp7j5mzj6uhtqoFMSmD+4uAezDHhzR73giZ5dHauMZhEAICauq
 nuYCVp3f/uG37+GRsNigIkrv5/QycPp0CgYyztoqlhgkO15h+Sh+BUBiFFpTvg/JC3Zq
 Sowq5+qXk3yZvfhvdWrcWsXRCXTcbrSZaUSU5vFpn1vhsfqcTcC0c2MbCSUcLO9doYCd
 icKBk2gRbqhHCel/wP1tkeFC2MKpS+G7vCX+kC8ULFYcehP/a/W3qite+BwswKXVTtPW
 hzmQ==
X-Gm-Message-State: AOJu0YwIsc+5oDJpKDgr4ffc5YyXPgLusaeJ01jeu57+FWyup6j3Ioc3
 TFjrCW/Ut9L2V0JbhiFYljRVWotu+1ijE8Ta/lC9CgtFX8cdyTTyb1bWTW0e3iOC8J63DbxZEqp
 A
X-Google-Smtp-Source: AGHT+IEWWJGsHfwT19gc6X2RLDIqmcV97E8LnXyiVVSh9cILRqighVdtYm37VqvUazW0TS+bVnmqJg==
X-Received: by 2002:adf:e78d:0:b0:37d:4894:6895 with SMTP id
 ffacd0b85a97d-37d551e432cmr10975035f8f.15.1728988695058; 
 Tue, 15 Oct 2024 03:38:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/28] hw/arm: Add SPI to Allwinner A10
Date: Tue, 15 Oct 2024 11:37:51 +0100
Message-Id: <20241015103808.133024-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Strahinja Jankovic <strahinjapjankovic@gmail.com>

The Allwinner A10 SPI controller is added to the Allwinner A10
description, so it is available when Cubieboard is emulated.

Update the documentation for Cubieboard to indicate SPI availability.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Message-id: 20241001221349.8319-3-strahinja.p.jankovic@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/cubieboard.rst | 1 +
 include/hw/arm/allwinner-a10.h | 2 ++
 hw/arm/allwinner-a10.c         | 8 ++++++++
 hw/arm/Kconfig                 | 1 +
 4 files changed, 12 insertions(+)

diff --git a/docs/system/arm/cubieboard.rst b/docs/system/arm/cubieboard.rst
index 58c4a2d3ea6..90d24c73a13 100644
--- a/docs/system/arm/cubieboard.rst
+++ b/docs/system/arm/cubieboard.rst
@@ -15,4 +15,5 @@ Emulated devices:
 - USB controller
 - SATA controller
 - TWI (I2C) controller
+- SPI controller
 - Watchdog timer
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 67a9a17b862..e5815b0d12b 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -12,6 +12,7 @@
 #include "hw/misc/allwinner-a10-ccm.h"
 #include "hw/misc/allwinner-a10-dramc.h"
 #include "hw/i2c/allwinner-i2c.h"
+#include "hw/ssi/allwinner-a10-spi.h"
 #include "hw/watchdog/allwinner-wdt.h"
 #include "sysemu/block-backend.h"
 
@@ -40,6 +41,7 @@ struct AwA10State {
     AllwinnerAHCIState sata;
     AwSdHostState mmc0;
     AWI2CState i2c0;
+    AWA10SPIState spi0;
     AwRtcState rtc;
     AwWdtState wdt;
     MemoryRegion sram_a;
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 08cdff61e46..9eb1aa73662 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -35,6 +35,7 @@
 #define AW_A10_PIC_REG_BASE     0x01c20400
 #define AW_A10_PIT_REG_BASE     0x01c20c00
 #define AW_A10_UART0_REG_BASE   0x01c28000
+#define AW_A10_SPI0_BASE        0x01c05000
 #define AW_A10_EMAC_BASE        0x01c0b000
 #define AW_A10_EHCI_BASE        0x01c14000
 #define AW_A10_OHCI_BASE        0x01c14400
@@ -80,6 +81,8 @@ static void aw_a10_init(Object *obj)
 
     object_initialize_child(obj, "i2c0", &s->i2c0, TYPE_AW_I2C);
 
+    object_initialize_child(obj, "spi0", &s->spi0, TYPE_AW_A10_SPI);
+
     for (size_t i = 0; i < AW_A10_NUM_USB; i++) {
         object_initialize_child(obj, "ehci[*]", &s->ehci[i],
                                 TYPE_PLATFORM_EHCI);
@@ -195,6 +198,11 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c0), 0, AW_A10_I2C0_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c0), 0, qdev_get_gpio_in(dev, 7));
 
+    /* SPI */
+    sysbus_realize(SYS_BUS_DEVICE(&s->spi0), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi0), 0, AW_A10_SPI0_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi0), 0, qdev_get_gpio_in(dev, 10));
+
     /* WDT */
     sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &error_fatal);
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->wdt), 0, AW_A10_WDT_BASE, 1);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f1e981622a1..0d658ead093 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -328,6 +328,7 @@ config ALLWINNER_A10
     select ALLWINNER_WDT
     select ALLWINNER_EMAC
     select ALLWINNER_I2C
+    select ALLWINNER_A10_SPI
     select AXP2XX_PMU
     select SERIAL_MM
     select UNIMP
-- 
2.34.1


