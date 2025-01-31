Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD55C02194
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyF5-0003vT-6p; Fri, 31 Jan 2025 16:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEg-0003G9-Fg
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:35 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEe-0007yV-GS
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:34 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so24928355e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357651; x=1738962451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CI3fJcIwv6F5yUs6Iv79OMCJfAeeRwik7915FGrttBI=;
 b=rEt06LynfGHe4Guj8QTrSUZEppvAfhBidMPsLAZ0rQqJ1hzEacpAXq9+CeLTYKD7Xx
 1syXWW4FvT9NVBEAi8pO2V5Txpf6CPIiuN2+e1fHoNoniP2w7xc3O7gsXE3715flf4t4
 lFvdm/GTwucuoamH9yDAal3pL4npwMGGzKMolxRCjQBxHrmcJxlu2SNNnkfKOTFBAITf
 nzEbh/Quuq2C9Q66fGnskwH32FHr+ZpwEDA8Vt3RQCoccJzbptx3Fa2keHYYfEJYgpUU
 eo51qk1s+hOfZUKXk+OACqdNze33xR6dJigwkmKTDqxzAh9TXkc4HH2DsKUyAP6Il3UE
 WxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357651; x=1738962451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CI3fJcIwv6F5yUs6Iv79OMCJfAeeRwik7915FGrttBI=;
 b=tzD8Jsveva1W4Ld0DNVZfc1WA/pzg52qvAbTGrsUs3sDyj+jMTxqsg21q5mLor02fO
 A4oXt6a+wJoZeaiEytK7FrsOA85b8Smmz11rGNH2IjKvwP4WxWiNNUojfwF1mSZPgU8l
 1LFuW48wbrqkmDDK3xnr0w7cDBenjMBPg+U6CyEevsl+xVbesz+5YHYollFXxhY0FKDY
 sYgA2gSLS0nsgdV98OyriBZti1Q0XtRwlXt/aNY05pTv6IRdnnEanpG7Z4qh2iLs9RLI
 4YDOrnRLhRErDnpymvZdBmTw8tyg43OB5uf/gom72EGDjS2xF9tZmNc75/epOEso0luh
 tENA==
X-Gm-Message-State: AOJu0Yy/67Z1pjlkYYzzSBRRGKs1tn/c13s42GRH9oAozJZQfM7UuB1K
 MaVxQ0zVHiUtBDnkNFWtlRTv3bEkYR+DJHlnnpgM4eOn/ppF2L/XzT8LI9+isftJxc8i3P6yahw
 gkBo=
X-Gm-Gg: ASbGncsCLj2eW4aUs9nYHuYOPaKlWarXqZkA8xsUOxGXK691VGmInbjcY5vaXXHLxGc
 aV3JAVGLxmlyjkw7k3FeYVJBj8EkSHicErIcCaKr3VHFBR47G80824DBW+n8gZH0Sv3SNGfv7T9
 D1NYl34uQ23UWgbDSFHPuKvXY5V58bkEkB5nScFFtBlkK0904JwdSjq5SEhTaXDKDWdydl36N7/
 PQR6Mj+zeupTvkFSwBWBCBwYQobNYngcphQdg4u3eNBuApwzlAsCY51ubMpbLbMLOSV7pZHjxIB
 6aZmOB/IkqzJX9Vil1sYUbSof8i+I8rK1LuJMlWaDJ4BN6z8nmGa8M1ck0DHj9o9hg==
X-Google-Smtp-Source: AGHT+IFoTD1sgynSL111p4mYKna9uh0kOurQLNp4GBb+ts4/konv0H6QitdCc+J7g7fKN1xN4qiuHQ==
X-Received: by 2002:a05:600c:3c9f:b0:438:a240:c63 with SMTP id
 5b1f17b1804b1-438dc3aa55emr117422865e9.2.1738357650656; 
 Fri, 31 Jan 2025 13:07:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23deddcsm66098885e9.14.2025.01.31.13.07.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:07:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/36] hw/sd/omap_mmc: Do a minimal conversion to QDev
Date: Fri, 31 Jan 2025 22:05:09 +0100
Message-ID: <20250131210520.85874-27-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Do a minimal conversion of the omap_mmc device model to QDev.

In this commit we do the bare minimum to produce a working device:
 * add the SysBusDevice parent_obj and the usual type boilerplate
 * omap_mmc_init() now returns a DeviceState*
 * reset is handled by sysbus reset, so the SoC reset function
   doesn't need to call omap_mmc_reset() any more
 * code that should obviously be in init/realize is moved there
   from omap_mmc_init()

We leave various pieces of cleanup to later commits:
 * rationalizing 'struct omap_mmc_s *' to 'OMAPMMCState *'
 * using gpio lines rather than having omap_mmc_init() directly
   set s->irq, s->dma
 * switching away from the legacy SD API and instead having
   the SD card plugged into a bus

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250128104519.3981448-2-peter.maydell@linaro.org>
[PMD: Do not add omap_mmc_realize()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/omap.h | 15 +++++----
 hw/arm/omap1.c        |  1 -
 hw/sd/omap_mmc.c      | 77 ++++++++++++++++++++++++++++++++++---------
 3 files changed, 70 insertions(+), 23 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 420ed1d5735..6339c5a581e 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -529,12 +529,13 @@ struct omap_lcd_panel_s *omap_lcdc_init(MemoryRegion *sysmem,
                                         omap_clk clk);
 
 /* omap_mmc.c */
-struct omap_mmc_s;
-struct omap_mmc_s *omap_mmc_init(hwaddr base,
-                MemoryRegion *sysmem,
-                BlockBackend *blk,
-                qemu_irq irq, qemu_irq dma[], omap_clk clk);
-void omap_mmc_reset(struct omap_mmc_s *s);
+#define TYPE_OMAP_MMC "omap-mmc"
+OBJECT_DECLARE_SIMPLE_TYPE(omap_mmc_s, OMAP_MMC)
+
+DeviceState *omap_mmc_init(hwaddr base,
+                           MemoryRegion *sysmem,
+                           BlockBackend *blk,
+                           qemu_irq irq, qemu_irq dma[], omap_clk clk);
 
 /* omap_i2c.c */
 I2CBus *omap_i2c_bus(DeviceState *omap_i2c);
@@ -601,7 +602,7 @@ struct omap_mpu_state_s {
     /* MPU public TIPB peripherals */
     struct omap_32khz_timer_s *os_timer;
 
-    struct omap_mmc_s *mmc;
+    DeviceState *mmc;
 
     struct omap_mpuio_s *mpuio;
 
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index f3a0ac40e48..ea07b9aa31e 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3716,7 +3716,6 @@ static void omap1_mpu_reset(void *opaque)
     omap_uart_reset(mpu->uart[0]);
     omap_uart_reset(mpu->uart[1]);
     omap_uart_reset(mpu->uart[2]);
-    omap_mmc_reset(mpu->mmc);
     omap_mpuio_reset(mpu->mpuio);
     omap_uwire_reset(mpu->microwire);
     omap_pwl_reset(mpu->pwl);
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 1d4e30e6b7b..fec2cfd4d66 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -21,11 +21,15 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qapi/error.h"
 #include "hw/irq.h"
+#include "hw/sysbus.h"
 #include "hw/arm/omap.h"
 #include "hw/sd/sdcard_legacy.h"
 
-struct omap_mmc_s {
+typedef struct omap_mmc_s {
+    SysBusDevice parent_obj;
+
     qemu_irq irq;
     qemu_irq *dma;
     qemu_irq coverswitch;
@@ -66,7 +70,7 @@ struct omap_mmc_s {
     int cdet_enable;
     int cdet_state;
     qemu_irq cdet;
-};
+} OMAPMMCState;
 
 static void omap_mmc_interrupts_update(struct omap_mmc_s *s)
 {
@@ -297,7 +301,7 @@ static void omap_mmc_pseudo_reset(struct omap_mmc_s *host)
     host->fifo_len = 0;
 }
 
-void omap_mmc_reset(struct omap_mmc_s *host)
+static void omap_mmc_reset(struct omap_mmc_s *host)
 {
     host->last_cmd = 0;
     memset(host->rsp, 0, sizeof(host->rsp));
@@ -328,7 +332,9 @@ void omap_mmc_reset(struct omap_mmc_s *host)
      * into any bus, and we must reset it manually. When omap_mmc is
      * QOMified this must move into the QOM reset function.
      */
-    device_cold_reset(DEVICE(host->card));
+    if (host->card) {
+        device_cold_reset(DEVICE(host->card));
+    }
 }
 
 static uint64_t omap_mmc_read(void *opaque, hwaddr offset, unsigned size)
@@ -583,29 +589,70 @@ static const MemoryRegionOps omap_mmc_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-struct omap_mmc_s *omap_mmc_init(hwaddr base,
-                MemoryRegion *sysmem,
-                BlockBackend *blk,
-                qemu_irq irq, qemu_irq dma[], omap_clk clk)
+DeviceState *omap_mmc_init(hwaddr base,
+                           MemoryRegion *sysmem,
+                           BlockBackend *blk,
+                           qemu_irq irq, qemu_irq dma[], omap_clk clk)
 {
-    struct omap_mmc_s *s = g_new0(struct omap_mmc_s, 1);
+    DeviceState *dev;
+    OMAPMMCState *s;
+
+    dev = qdev_new(TYPE_OMAP_MMC);
+    s = OMAP_MMC(dev);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     s->irq = irq;
     s->dma = dma;
     s->clk = clk;
-    s->lines = 1;	/* TODO: needs to be settable per-board */
-    s->rev = 1;
 
-    memory_region_init_io(&s->iomem, NULL, &omap_mmc_ops, s, "omap.mmc", 0x800);
-    memory_region_add_subregion(sysmem, base, &s->iomem);
+    memory_region_add_subregion(sysmem, base,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(s), 0));
 
     /* Instantiate the storage */
     s->card = sd_init(blk, false);
     if (s->card == NULL) {
         exit(1);
     }
+    return dev;
+}
+
+static void omap_mmc_reset_hold(Object *obj, ResetType type)
+{
+    OMAPMMCState *s = OMAP_MMC(obj);
 
     omap_mmc_reset(s);
-
-    return s;
 }
+
+static void omap_mmc_initfn(Object *obj)
+{
+    OMAPMMCState *s = OMAP_MMC(obj);
+
+    /* In theory these could be settable per-board */
+    s->lines = 1;
+    s->rev = 1;
+
+    memory_region_init_io(&s->iomem, obj, &omap_mmc_ops, s, "omap.mmc", 0x800);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+}
+
+static void omap_mmc_class_init(ObjectClass *oc, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    rc->phases.hold = omap_mmc_reset_hold;
+}
+
+static const TypeInfo omap_mmc_info = {
+    .name = TYPE_OMAP_MMC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(OMAPMMCState),
+    .instance_init = omap_mmc_initfn,
+    .class_init = omap_mmc_class_init,
+};
+
+static void omap_mmc_register_types(void)
+{
+    type_register_static(&omap_mmc_info);
+}
+
+type_init(omap_mmc_register_types)
-- 
2.47.1


