Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C45C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUfc-00028S-UQ; Mon, 29 Jan 2024 11:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUUfb-0001xZ-52; Mon, 29 Jan 2024 11:39:39 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUUfW-0001d0-E3; Mon, 29 Jan 2024 11:39:38 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-290d59df3f0so2276285a91.2; 
 Mon, 29 Jan 2024 08:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706546372; x=1707151172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mBJNDAZyqhEZv/OjyuM8FGpJdQYjztNc0WQPIUrUC+c=;
 b=UzSf0LSHyUs1j3VREbI/fcsLFSrnUqzoyBFc5taUxLtvkHuiVkwQCbmdaUENBoOoUy
 zs1Hl0yU0A897EjCn61q/p7kGqRu68881/3M290f6Csg8KwkdoMG7Nr2dBMyPFttwfuA
 ZI7SsHFor58B/LIvv2iETXTYHziRlfr8rUAO+xhvVOe4Ez2x1MTrSxRrknqP0D84yxRp
 93c2VdQK3iiT5F8He4eR01pQCGbS+GbBuP1tkB2spD+ULvx6sIBwR/7KeKNzi0DyQS24
 91gHb+Z65jaG0cvzGZPmPeRKzXsA98hPtTx+5ejvgodgErrhVhpyY4EwTEY70d+6LNwt
 ocFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546372; x=1707151172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mBJNDAZyqhEZv/OjyuM8FGpJdQYjztNc0WQPIUrUC+c=;
 b=hYm5fhOZcX1rxaBq1SZXmUdgGf07vRGhOZExOawnpdCZNtxBHMEFjvGprjftyzFcCb
 I+rOpGz6pIqIA36dDsLjjyTyupz1iDAJFUP5UDlmaQmitjjOcoDI0RtVohk/i4C44FGc
 Ax5MwijM/LBsAjWodjdBB9xgpP7aMuo+FTyNxOagtXi1Vh7L/aePdhPTT6G6MrjIHSfR
 Mf0K3uJe5CEGk7KxEmxZMbwtcQIbjLHnRNySwcq09ex4hgYmw4vV8OAAD9D3a8lmU8ox
 EXjwuDK9RKnD5b0Svcp1dTHW3hLvWyeGFMwY9gi6huRmGxEsYdlQt3NeJV8cMNl3v1fr
 O57A==
X-Gm-Message-State: AOJu0YxlwURkrDS5XKLnFJz3OsQ43+SQjqDi82y3UjD43F6azJagKpCZ
 Znr1SNlyM5pKbVDXKzhyiIciW2R7rwQTEerY7QUKZ+HpHA4VrQ1mH4dueYOstK2sNA==
X-Google-Smtp-Source: AGHT+IGtl2phWThBQTIh+W+RtcKvmtXFrFRAkIox4clnfzbyNyjx00Yi26Q9mBIGKCDjNe+Ol+lHng==
X-Received: by 2002:a17:90a:a384:b0:293:e476:78d4 with SMTP id
 x4-20020a17090aa38400b00293e47678d4mr3747162pjp.16.1706546372375; 
 Mon, 29 Jan 2024 08:39:32 -0800 (PST)
Received: from localhost.localdomain ([49.47.195.100])
 by smtp.gmail.com with ESMTPSA id
 nb5-20020a17090b35c500b0029464b5fcdbsm6107239pjb.42.2024.01.29.08.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 08:39:32 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: rayhan.faizel@gmail.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v3 2/2] hw/arm: Connect SPI Controller to BCM2835
Date: Mon, 29 Jan 2024 22:08:03 +0530
Message-Id: <20240129163801.2790257-3-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129163801.2790257-1-rayhan.faizel@gmail.com>
References: <20240129163801.2790257-1-rayhan.faizel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-pj1-x1031.google.com
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

Instead, dtmerge can be used to apply spi=on on a bcm2835 dts file.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 hw/arm/Kconfig                       |  1 +
 hw/arm/bcm2835_peripherals.c         | 17 ++++++++++++++---
 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 3 files changed, 17 insertions(+), 4 deletions(-)

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
index 0233038b95..f259da64f7 100644
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
@@ -399,14 +403,21 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_add_subregion(&s->peri_mr, PM_OFFSET,
-                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->powermgt), 0));
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


