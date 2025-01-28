Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC78C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcj6M-0001An-30; Tue, 28 Jan 2025 05:45:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj5y-00017X-LQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:27 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj5w-0003VC-8g
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:25 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3862a921123so3644476f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 02:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738061123; x=1738665923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcfm9SzMz6jhWF/u427K9kqe8ff3/Kqz7PzZhpvPw/Y=;
 b=lvyySGqt7lq0rbSP8bQWG3D5JJIQnha6WDTbS8f0gBhdSET/XKxZplK/03361iLEFO
 msXZg2uPBynKxEACiheUD1pp1izqqup8wE5URbY3mSjvGekeIYGNdvQ56ulpyG9qCgrP
 y9p+yWyYOWJ10OtWvT99IM3EVClFevyAE8052nk0EJEOTQJhdejcn1NvTEcWbkRAR40O
 1RepAY8vH9n4SmCN6qTlPYeDfQKwpNXcF60fT5unb9kYsMMWqE1tcvCDo1x988YDFVPK
 SpHAAgYW/7mQHFCbbM7Q9WPpoTysvMw6ss/dkhDP1NN8GydyXRrcqOufSjhVWMdt/+YJ
 f4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738061123; x=1738665923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcfm9SzMz6jhWF/u427K9kqe8ff3/Kqz7PzZhpvPw/Y=;
 b=S97vQbNUlEYyHOeB55Cnx3CdFVHycPCvSu/nbsALT97W+EV0jAg+n2eGR1ZT+XS1k+
 1RuVpOSSKCKkqn9zDB8119OuJDLnF/SKEIsTaRv5fmYdgIOYZYOTxkhSl03MFFNYDIFE
 PbgnMS9CGVARAkQJnG9RPn1f15dChrOdeVUsKFG4AceyV9gkUEkquTcYZvw4MqBenHCw
 XuUOJ0msxjK0+SCa/12M6SPXDds4+wq9TRV3JHV/bJaFmK702PrwsGPI+JguIiPkkJFo
 JNIf7eSUGTzzMxTsDPrpaERd1/ewWaQRZejw+INoi1aDxWTzX7KL7SpIb7MPcJ1KeG/8
 +EBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVujrImU4QuyDYf/M5sbXjf3OUkjTrt7CKrcNC+q8jWLGEqV+Dt/lcU2B3G18aI8atWKZNiJEtiTs8m@nongnu.org
X-Gm-Message-State: AOJu0YwIiVa6GZBev/Z8Wx0u7ECLgGUuitmFnk9Tch+54ON2u07OsKuO
 KtaUC6OQGISON++jL3G0VjWEA0DRrLQJWfGVnj7mjyQH4sHObX4ssvQhG27RpAU=
X-Gm-Gg: ASbGnctO0Voa2SsST3+tCl60ew3d9z8aGzDDSOPu9Gj4tbiQTTR8XVltvtTVH8BMpR7
 6GdIbiYRi7lzIZJnId9d5Awjiqx2o8sSDt0P8cvVaHj3dcGi8xyvmecU/PAOIEn6jRh1TBrNnCJ
 udO88Tsy7VGdWPn493YxOQu4n3EqR6ytULQsQD0VECdbR56hEKnciPfkBSwt3C4d+V9yCO6vrOA
 WQqO00TMJJ9A5esq45L3kNXiwIqRMMWVoVdrvi2nwCYDz7xnE+tWV0h8CPjnN9CU890o6KDDZn3
 1Fh3CjGYUpPYeHwN39is
X-Google-Smtp-Source: AGHT+IEFPn5TsGYOw3BklNr6kxn9l6B1DBvNSKo4fKI3KtM7KPlKliQuFmRwIGpyTm8wIsImwOJ/FQ==
X-Received: by 2002:a05:6000:1849:b0:38a:8888:c0b6 with SMTP id
 ffacd0b85a97d-38bf57bfcf5mr46327535f8f.51.1738061122744; 
 Tue, 28 Jan 2025 02:45:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c418esm13920133f8f.95.2025.01.28.02.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 02:45:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 01/11] hw/sd/omap_mmc: Do a minimal conversion to QDev
Date: Tue, 28 Jan 2025 10:45:09 +0000
Message-Id: <20250128104519.3981448-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128104519.3981448-1-peter.maydell@linaro.org>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
---
 include/hw/arm/omap.h | 15 ++++----
 hw/arm/omap1.c        |  1 -
 hw/sd/omap_mmc.c      | 83 +++++++++++++++++++++++++++++++++++--------
 3 files changed, 76 insertions(+), 23 deletions(-)

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
index 1d4e30e6b7b..9cba437f74e 100644
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
@@ -583,29 +589,76 @@ static const MemoryRegionOps omap_mmc_ops = {
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
+static void omap_mmc_realize(DeviceState *dev, Error **errp)
+{
+}
+
+static void omap_mmc_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    rc->phases.hold = omap_mmc_reset_hold;
+    dc->realize = omap_mmc_realize;
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
2.34.1


