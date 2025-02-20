Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F5CC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JL-00079T-MH; Thu, 20 Feb 2025 11:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JJ-00077e-Na
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:01 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JH-0008FV-Rt
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:01 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43937cf2131so8109515e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068518; x=1740673318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wggfv0k+p5R2XRH3NT8ACUO9zXhFgQXepjXDV5fdS5M=;
 b=NejflO1RlNn2YfaTDKbagaEWcn9R4BtDxC3aVFNS3UeYwxSubFuAngOMXRpdnDMsM3
 nZrKPdRpioqR6CxLIdyCpkvJF9ItixlXotwcQdM9OX3u4Dlxf0nveqbB5IzN/DY2HlQX
 oGhh64HNcAN3Fq11+r5W628wPJ1za13wXRkR1EDrvMPep9bv8B73OFnybq9BH4vWDu+e
 3qQlG/UzzZBuoGOEBCGLjOm2dLwo7BvXperCAvAFRIEln+BUzwBbxjtGejPbqbahMtMC
 mcayU9g8njB5+x/roK9XsW17USYCvbpLvFpqhVVSs3qznFhAa4FXN2Usnp4vVQbG2J3t
 Xr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068518; x=1740673318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wggfv0k+p5R2XRH3NT8ACUO9zXhFgQXepjXDV5fdS5M=;
 b=FjxTAsdfNT6STWBCukOaPO4d7Ym1CgoEq+EE05m2RmljgqSbrYKOcvRMTuVBMaGzyz
 coeFycZAJvOwoK54UuwhNcED6sRsiBA97qMVvCG6s71gRQxRlwoL/US4i5dVAa7MNNU0
 DySgLUwTE0CPnRMDXe5qOS3Kp/gYT3gBLnQ2uo3evpFYMUB/q5oyPrd82k8vdJUx9kRs
 YZ1vrUHhyhr/rRLEEyEKBYYW9aKj9ZFq/h+/umesnBkXfx80tOX3KdCdJKeLVnXLPNzk
 ZlmUl6R0gSqq1F3XZpdsxcvpMwLfnPtExpezGJE4e88XsKp9rKS6Dl5F7WD0020v5099
 stGA==
X-Gm-Message-State: AOJu0YzJcJKeI9N/7QpAhtF8qescn7R15mYGyIVCWt4J2iLKlLh/vNes
 uJdsGikp5ADHlyZeVMDxk09OI7eEYxiJskyJKT8LARt1/drf9i5FP/qiFhh8j4PIibmbxGXnQjZ
 I
X-Gm-Gg: ASbGncuVU9IR5aZOnu3pS9IU9uncMupLa6OkAhQQm3n4Et6oAyxqrfwjKeMqvDf4f8/
 6DFF/XW4FWybJicWB6/BwMI8qHL77p90pYdNew+rgvHGUj6hN/+hZe6mgpA5P89M4EMeqtrbbvS
 8HbaNyqB92bucTztZzeyrXCibqsRcmshaieRaPsoYG3IJGOhGRhxuC3x+BmfpjkCcuJvhVfKztK
 48FTDEWbbqhBp4f1jYQ37YrvxbJhQPSAoFmHwRTI+Lrvq4IPGqpI002FA9NYVYIBH4S1DgmSXkX
 NgN7SZyfH1jlk++tKVV7bQ==
X-Google-Smtp-Source: AGHT+IHrWNpl+S8FW0aXyWDPfstqXdyaxBZ4WO5x/TkjjJYQ4VWkN86md1p9WBNeh5bfYrwMjfgmJA==
X-Received: by 2002:a05:600c:4f95:b0:439:8c80:6af4 with SMTP id
 5b1f17b1804b1-439a4baf45bmr23268575e9.19.1740068518336; 
 Thu, 20 Feb 2025 08:21:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/41] hw/ssi: Make flash size a property in NPCM7XX FIU
Date: Thu, 20 Feb 2025 16:21:08 +0000
Message-ID: <20250220162123.626941-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Hao Wu <wuhaotsh@google.com>

This allows different FIUs to have different flash sizes, useful
in NPCM8XX which has multiple different sized FIU modules.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Reviewed-by: Philippe Mathieu-Daude <philmd@linaro.org>
Message-id: 20250219184609.1839281-4-wuhaotsh@google.com
[PMM: flash_size must be a uint64_t to build on 32-bit hosts]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/npcm7xx_fiu.h |  1 +
 hw/arm/npcm7xx.c             |  6 ++++++
 hw/ssi/npcm7xx_fiu.c         | 16 ++++++++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/hw/ssi/npcm7xx_fiu.h b/include/hw/ssi/npcm7xx_fiu.h
index a3a17042896..7ebd422ca6c 100644
--- a/include/hw/ssi/npcm7xx_fiu.h
+++ b/include/hw/ssi/npcm7xx_fiu.h
@@ -60,6 +60,7 @@ struct NPCM7xxFIUState {
     int32_t cs_count;
     int32_t active_cs;
     qemu_irq *cs_lines;
+    uint64_t flash_size;
     NPCM7xxFIUFlash *flash;
 
     SSIBus *spi;
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 386b2c35e9b..2d6e08b72ba 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -292,17 +292,21 @@ static const struct {
     hwaddr regs_addr;
     int cs_count;
     const hwaddr *flash_addr;
+    size_t flash_size;
 } npcm7xx_fiu[] = {
     {
         .name = "fiu0",
         .regs_addr = 0xfb000000,
         .cs_count = ARRAY_SIZE(npcm7xx_fiu0_flash_addr),
         .flash_addr = npcm7xx_fiu0_flash_addr,
+        .flash_size = 128 * MiB,
+
     }, {
         .name = "fiu3",
         .regs_addr = 0xc0000000,
         .cs_count = ARRAY_SIZE(npcm7xx_fiu3_flash_addr),
         .flash_addr = npcm7xx_fiu3_flash_addr,
+        .flash_size = 128 * MiB,
     },
 };
 
@@ -735,6 +739,8 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
 
         object_property_set_int(OBJECT(sbd), "cs-count",
                                 npcm7xx_fiu[i].cs_count, &error_abort);
+        object_property_set_int(OBJECT(sbd), "flash-size",
+                                npcm7xx_fiu[i].flash_size, &error_abort);
         sysbus_realize(sbd, &error_abort);
 
         sysbus_mmio_map(sbd, 0, npcm7xx_fiu[i].regs_addr);
diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index 21fc4890383..8df4bec3f17 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -29,7 +29,7 @@
 #include "trace.h"
 
 /* Up to 128 MiB of flash may be accessed directly as memory. */
-#define NPCM7XX_FIU_FLASH_WINDOW_SIZE (128 * MiB)
+#define NPCM7XX_FIU_MAX_FLASH_WINDOW_SIZE (128 * MiB)
 
 /* Each module has 4 KiB of register space. Only a fraction of it is used. */
 #define NPCM7XX_FIU_CTRL_REGS_SIZE (4 * KiB)
@@ -507,6 +507,17 @@ static void npcm7xx_fiu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->flash_size == 0) {
+        error_setg(errp, "%s: flash size must be set", dev->canonical_path);
+        return;
+    }
+
+    if (s->flash_size > NPCM7XX_FIU_MAX_FLASH_WINDOW_SIZE) {
+        error_setg(errp, "%s: flash size should not exceed 128 MiB",
+                   dev->canonical_path);
+        return;
+    }
+
     s->spi = ssi_create_bus(dev, "spi");
     s->cs_lines = g_new0(qemu_irq, s->cs_count);
     qdev_init_gpio_out_named(DEVICE(s), s->cs_lines, "cs", s->cs_count);
@@ -525,7 +536,7 @@ static void npcm7xx_fiu_realize(DeviceState *dev, Error **errp)
         flash->fiu = s;
         memory_region_init_io(&flash->direct_access, OBJECT(s),
                               &npcm7xx_fiu_flash_ops, &s->flash[i], "flash",
-                              NPCM7XX_FIU_FLASH_WINDOW_SIZE);
+                              s->flash_size);
         sysbus_init_mmio(sbd, &flash->direct_access);
     }
 }
@@ -543,6 +554,7 @@ static const VMStateDescription vmstate_npcm7xx_fiu = {
 
 static const Property npcm7xx_fiu_properties[] = {
     DEFINE_PROP_INT32("cs-count", NPCM7xxFIUState, cs_count, 0),
+    DEFINE_PROP_SIZE("flash-size", NPCM7xxFIUState, flash_size, 0),
 };
 
 static void npcm7xx_fiu_class_init(ObjectClass *klass, void *data)
-- 
2.43.0


