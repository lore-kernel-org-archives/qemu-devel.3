Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E59BCF3188
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 22:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svl8e-0006vh-2l; Tue, 01 Oct 2024 18:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1svl8R-0006nh-10; Tue, 01 Oct 2024 18:14:24 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1svl8P-0002Vs-D2; Tue, 01 Oct 2024 18:14:22 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5398e4ae9efso3912745e87.1; 
 Tue, 01 Oct 2024 15:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727820859; x=1728425659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQfnOFKsLke9PGZY3xHJ5OCP2G5CKFOm2KdnDB6NsK8=;
 b=HPbu7zB+pKGyxuGimT2qU2K9p4oK05SIka9C55JEZyDr69adr1fYLmouFSxDNgErrq
 rb9nUN/U5sW+5zYdBrTfz0wqU1tcppdia+1fAfRQjpBZyZBHFho06L6bqSSarcDLwdH8
 4lSSacw3uaTBHa3xPlveJJYNsYmoOAAdIG93Gir3/R61VGFZd40JQaB9BCtQGpp8EISu
 rBXzeXo6s4wVfLvggH9CIr6m+X8njx6qqjUOqwN8AiRMUSZGeKAVL0fY4EuDRxSRdRWd
 MSMhRZWWl1g3BQCldU36CnfVywIMaF58EenC3Zz/RAmTv/nJvxOSb7VW/R4f4r1wuz2Y
 8fWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727820859; x=1728425659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pQfnOFKsLke9PGZY3xHJ5OCP2G5CKFOm2KdnDB6NsK8=;
 b=PYIK66FkHmA4DzPtemGP3ZdLBRU/BWSGLa1qmmm+fCrMWQwDOU+B2swOxbZlMHWxBf
 u8pQux8Q4rsisfiVs8jac80GTO7dHu8dJaqN5QPIJRgjnWjOqaAY5J9dr75xqmCaW7xS
 MLlzIdQD7HrPcFgE6Lcth8ieF8k/uEtZpYkKcufBK3jnXknlHdVw6nqsjZyW9yMOlEE+
 jdEZTHq59Bbm2ztj/huuHEOPcbOgVgxytWh8bB/29Ef7jpQBLDDCBn6TWWe8Ho/KRdO9
 9RA8jxUd0ZYdWv0gydVhCC6PustNakvYJmLV8Du97zpAfuoBW2+QXxPI5p+hpkRaKYg/
 1SVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvFq2uIznDoWFzngUT2mK3Pn6up3sr2axi8Yt4N6fhCNnVlrdtygTAfaiJbtlHZ9Bq4gC9nu3INw==@nongnu.org
X-Gm-Message-State: AOJu0Yyi62DvFvCrm3vixUeTU/n54NzkqAvhX0D/EFmP3bGHSqVWwVMQ
 +90OHaFxjC7oHMCvX2gnxE1nKYlo8aRjz9T5XZOgW89CiXTO4FZ2
X-Google-Smtp-Source: AGHT+IGgQPT81Kk6Kf6VWHTVupdLzG2BRc57M261oOXT1Iv3CNO8VKHfnHjrZMNp6SaLKnpaerP/mQ==
X-Received: by 2002:a05:6512:304d:b0:539:9548:41a6 with SMTP id
 2adb3069b0e04-539a07afd0bmr417406e87.61.1727820858321; 
 Tue, 01 Oct 2024 15:14:18 -0700 (PDT)
Received: from penguin.lxd (c-d17271d5.018-186-73746f22.bbcust.telenor.se.
 [213.113.114.209]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53992ca4683sm964813e87.124.2024.10.01.15.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 15:14:17 -0700 (PDT)
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
X-Google-Original-From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
To: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [PATCH v2 2/2] {hw/arm,docs/system/arm}: Add SPI to Allwinner A10
Date: Wed,  2 Oct 2024 00:13:49 +0200
Message-Id: <20241001221349.8319-3-strahinja.p.jankovic@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001221349.8319-1-strahinja.p.jankovic@gmail.com>
References: <20241001221349.8319-1-strahinja.p.jankovic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-lf1-x12f.google.com
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

The Allwinner A10 SPI controller is added to the Allwinner A10
description, so it is available when Cubieboard is emulated.

Update the documentation for Cubieboard to indicate SPI availability.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
 docs/system/arm/cubieboard.rst | 1 +
 hw/arm/Kconfig                 | 1 +
 hw/arm/allwinner-a10.c         | 8 ++++++++
 include/hw/arm/allwinner-a10.h | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/docs/system/arm/cubieboard.rst b/docs/system/arm/cubieboard.rst
index 58c4a2d3ea..90d24c73a1 100644
--- a/docs/system/arm/cubieboard.rst
+++ b/docs/system/arm/cubieboard.rst
@@ -15,4 +15,5 @@ Emulated devices:
 - USB controller
 - SATA controller
 - TWI (I2C) controller
+- SPI controller
 - Watchdog timer
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1ad60da7aa..933b0a059c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -398,6 +398,7 @@ config ALLWINNER_A10
     select ALLWINNER_WDT
     select ALLWINNER_EMAC
     select ALLWINNER_I2C
+    select ALLWINNER_A10_SPI
     select AXP2XX_PMU
     select SERIAL
     select UNIMP
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 57d5d80159..30852dd038 100644
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
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 67a9a17b86..e5815b0d12 100644
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
-- 
2.39.5


