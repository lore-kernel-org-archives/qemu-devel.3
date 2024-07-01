Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE672C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZH-0000mp-02; Mon, 01 Jul 2024 12:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ4-0000fW-D9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJYz-0005PX-0w
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:37 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42564a0d3ceso20398315e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850051; x=1720454851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nBC68qSnOqe/t92MltF2syiNU9SSpcqCVp8DGlNvqpI=;
 b=WuaBfAhyiTenmafgBTqQw5MtYuqtk5TAOYpMaSce4A58cWQm73f0VTlyqrS8/rFrpn
 rqFa1gWanfWgmlCXonNnVVaxhL3xf9y00PVKEqlgCcgrW2nvNH5ucHtnSm9/qD6f18fG
 WWfOyEgSdR7aRiDwh/kX92A036YXNQnujsWsbzq+feWfk1E2iPW6P/im+8Y/itg/a4Vq
 v/pzGKePwmdYnsrBRzgOTtrObGd3NbOX1BuEzznLl+FaIJyFZV2ODiY7EKkpiaLfYepC
 tmNWWMQn9cCztz+gEA7QbTD4cmIZAvbjB+0lbCynd+G06cK5igy0HNRrl2B3ngVEFKci
 sAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850051; x=1720454851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBC68qSnOqe/t92MltF2syiNU9SSpcqCVp8DGlNvqpI=;
 b=H8di7AL51SSf7MqK1Elxx00pAejs0Eo88z++Ow5e/tISGzQf80/nyI3ZMnVjedISGi
 yYlaNMDfusXyMyqAMdDkEZ1vNUw5L+iVcuNmvq4TkLYM0g5pC/L0TowZ5IHBuXweFEbT
 lhghlr3X/QS129V2mbJPcipcqik8UunFDq4TDi5SdcKD3JldOodsfBFOhjKY+cYxSSg5
 6kCqdcaxXnLkPM/ZuV1COQVhNs3rA4gsNE/D6uoz0mKI/ZI8gVqXMs4aQ1RlYCHeCIW2
 KJida4j9qcYVeaY5jI7ycLiUHC967MGCJyuYLl8eykJt7xz3ZuoDKX5UxqhcDMts7SNu
 35UQ==
X-Gm-Message-State: AOJu0Yw+7Wf3qMZuAjIoSYyao8a80A7bn63UpuFGWNJgztkNNEa+qaBP
 iw2PeaIKaI5rSgbpy5r2PiVpvRScuarCDhs6wdR48mhh9kuDASreB98ii8vGEk0jTi6BYJY6I+n
 Y7as=
X-Google-Smtp-Source: AGHT+IESx5aaBWKeIve9Wi4zlu/G/B1j77ujUjbVxbmB8/C2czdjkq8UomZbNmyIfO3GodZhPMT6Zw==
X-Received: by 2002:a05:600c:c88:b0:421:5609:115d with SMTP id
 5b1f17b1804b1-4257a074875mr34605385e9.41.1719850051208; 
 Mon, 01 Jul 2024 09:07:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/29] hw/arm: Connect OTP device to BCM2835
Date: Mon,  1 Jul 2024 17:07:02 +0100
Message-Id: <20240701160729.1910763-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Rayhan Faizel <rayhan.faizel@gmail.com>

Replace stubbed OTP memory region with the new OTP device.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 hw/arm/bcm2835_peripherals.c         | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 636203baa5a..1eeaeec9e0e 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -33,6 +33,7 @@
 #include "hw/usb/hcd-dwc2.h"
 #include "hw/ssi/bcm2835_spi.h"
 #include "hw/i2c/bcm2835_i2c.h"
+#include "hw/nvram/bcm2835_otp.h"
 #include "hw/misc/unimp.h"
 #include "qom/object.h"
 
@@ -71,7 +72,7 @@ struct BCMSocPeripheralBaseState {
     BCM2835SPIState spi[1];
     BCM2835I2CState i2c[3];
     OrIRQState orgated_i2c_irq;
-    UnimplementedDeviceState otp;
+    BCM2835OTPState otp;
     UnimplementedDeviceState dbus;
     UnimplementedDeviceState ave0;
     UnimplementedDeviceState v3d;
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 1695d8b453a..7d735bb56cf 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -116,6 +116,10 @@ static void raspi_peripherals_base_init(Object *obj)
     object_property_add_const_link(OBJECT(&s->fb), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr));
 
+    /* OTP */
+    object_initialize_child(obj, "bcm2835-otp", &s->otp,
+                            TYPE_BCM2835_OTP);
+
     /* Property channel */
     object_initialize_child(obj, "property", &s->property,
                             TYPE_BCM2835_PROPERTY);
@@ -374,6 +378,14 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fb), 0,
                        qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_FB));
 
+    /* OTP */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->otp), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, OTP_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->otp), 0));
+
     /* Property channel */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->property), errp)) {
         return;
@@ -500,7 +512,6 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
     create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
     create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
     create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
-    create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
     create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
     create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
     create_unimp(s, &s->v3d, "bcm2835-v3d", V3D_OFFSET, 0x1000);
-- 
2.34.1


