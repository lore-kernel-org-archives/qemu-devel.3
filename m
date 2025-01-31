Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2421C02192
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyFO-0004aO-1m; Fri, 31 Jan 2025 16:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEw-0003zA-17
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:53 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEt-00080G-UH
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:49 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3862f32a33eso1117190f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357666; x=1738962466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q41kF9LgoBzRCfJNt+CSBeq/VMhGxdw7fo0GoRWO1As=;
 b=NGE+sNmr6JRn4fRmIgAjcn2cGEKKT0IsJsVbLR866NbE27uHMNFYY2ZYeP6JWB4+3f
 HOjraJY0S6GsRZ+XWSFFUlfnGN8rUyQSOUb3Q9AFdcQsU+NLIZwJuI5ruCNGdI0ctaER
 Wexa04QqdDZWaS4x+5wcDzvQTK4MIzgnFv1st30kg2vBxz9KOwpkbpw1PPlEBV3ohjP3
 gg+whBYttgxaw25fXNYTifsbeyxUtcY8aaok7iUAMmC4nL+i9kMGKlr/5GJjUCXC6sn4
 i6zpQuZEhBYN5kaNZbO0mYnHrM6xc+YAexaSQpxlWa887tRkaSG2DVERIqooK+Vf7qsb
 ugig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357666; x=1738962466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q41kF9LgoBzRCfJNt+CSBeq/VMhGxdw7fo0GoRWO1As=;
 b=t7xTOTTmJ6KlIe11KlqQw4ZT+4uFsohnDHJf9A2jjJZH714u1j5r83YEbzowdKPHr0
 ET5ASVSg9CPGI/UZCXs6/LUXC5/hlPj9pxqAlJm3JnVX2da+I3nMr8Ard42Ly5GK1KIw
 Kq3CeOVpj6WAQDksr0YB/ymQNO+wDnqMqpEqQuUugRb3YmqHBzFCaGvuSp78w+bIAtQ1
 ZYJt4B91N4K98WV7Ah5v0Ah8QTNhGsPpLGkjFfvpLWDKsArBFp1TfHrjetEcg53nHNRh
 DvsRNyRkl37+QZ6A8MSb1yYHg5IXo6f/h2gwbP8ltuOx5/JWxkIoA16vohIhegH+o0+d
 Odnw==
X-Gm-Message-State: AOJu0YyDWPbGbfdihf7P/Mt1d0MzSWsGD2Idx/2wiYPSDY9EOr0BHRG9
 RksjZEIQCMkNM5n52KihJg9Q5qzXlAvBwVj7DI5KWvV9fZFMFLO+XE/CL3VU/+rNpH6TULQFlJH
 fM90=
X-Gm-Gg: ASbGncspfIX6wNxn07NXjHTApbrXKKKQTdb/SHvj3KhRe14ZKo4W7g0u0jicw6HVFVw
 lJKB0Xac0lC34/WT1QWLObUQnBzXGAf98NSSFNmtL29ZJLtME+M2MOVUM3XgAmJDFsKnPrXYxc5
 Ev5MWE7TkVeW1A5lZcDoP14X8fYeRcDqB0cmOzdQH+ozBcFnkRTYAy7bQmDTfHkHHGGIP1EnFDS
 pIDgzzC4R367MGj874/ecCNfQCW9l7sLnNqwrVRGP1Yr/Bp+zMCAtfyj7SkT9M/1NpUwQWGZjgf
 1BCLCAVKNey6/DPE/bWq+JmoYq/vlN8UD994Fwl79xPEBIEo2JsQk5Lr3BLh74CTdA==
X-Google-Smtp-Source: AGHT+IEJ/1Zl7byyR7cLni8lU7uFN5y+imbzzFfaJRVS59j1t2UlYtaM+pGSx2fY8nqSsRJLFQF/ig==
X-Received: by 2002:a05:6000:188b:b0:385:f2a2:50df with SMTP id
 ffacd0b85a97d-38c5195f498mr12239186f8f.27.1738357665967; 
 Fri, 31 Jan 2025 13:07:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c139f15sm5640733f8f.59.2025.01.31.13.07.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:07:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/36] hw/sd/omap_mmc: Convert to SDBus API
Date: Fri, 31 Jan 2025 22:05:12 +0100
Message-ID: <20250131210520.85874-30-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Convert the OMAP MMC controller to the new SDBus API:
 * the controller creates an SDBus bus
 * instead of sd_foo functions on the SDState object, call
   sdbus_foo functions on the SDBus
 * the board code creates a proper TYPE_SD_CARD object and attaches
   it to the controller's SDBus, instead of the controller creating
   a card directly via sd_init() that never gets attached to any bus
 * because the SD card object is on a bus, it gets reset automatically
   by the "traverse the qbus tree resetting things" code, and we don't
   need to manually reset the card from the controller reset function

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250128104519.3981448-5-peter.maydell@linaro.org>
[PMD: Include "hw/sd/sd.h" instead of "hw/sd/sdcard_legacy.h",
      create bus in omap_mmc_initfn() instead of omap_mmc_realize()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/omap.h |  1 -
 hw/arm/omap1.c        | 10 +++++++++-
 hw/sd/omap_mmc.c      | 31 ++++++++++---------------------
 3 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 7d1a1afc4f8..d20c55a8957 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -534,7 +534,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(OMAPMMCState, OMAP_MMC)
 
 DeviceState *omap_mmc_init(hwaddr base,
                            MemoryRegion *sysmem,
-                           BlockBackend *blk,
                            qemu_irq irq, qemu_irq dma[], omap_clk clk);
 
 /* omap_i2c.c */
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index ea07b9aa31e..15ba0a0d0c4 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -29,6 +29,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/omap.h"
+#include "hw/sd/sd.h"
 #include "system/blockdev.h"
 #include "system/system.h"
 #include "hw/arm/soc_dma.h"
@@ -3981,11 +3982,18 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
         warn_report("missing SecureDigital device");
     }
     s->mmc = omap_mmc_init(0xfffb7800, system_memory,
-                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                            qdev_get_gpio_in(s->ih[1], OMAP_INT_OQN),
                            &s->drq[OMAP_DMA_MMC_TX],
                     omap_findclk(s, "mmc_ck"));
 
+    if (dinfo) {
+        DeviceState *card = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+        qdev_realize_and_unref(card, qdev_get_child_bus(s->mmc, "sd-bus"),
+                               &error_fatal);
+    }
+
     s->mpuio = omap_mpuio_init(system_memory, 0xfffb5000,
                                qdev_get_gpio_in(s->ih[1], OMAP_INT_KEYBOARD),
                                qdev_get_gpio_in(s->ih[1], OMAP_INT_MPUIO),
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 43203a76c58..1bc8290f9d6 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -25,18 +25,19 @@
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/arm/omap.h"
-#include "hw/sd/sdcard_legacy.h"
+#include "hw/sd/sd.h"
 
 typedef struct OMAPMMCState {
     SysBusDevice parent_obj;
 
+    SDBus sdbus;
+
     qemu_irq irq;
     qemu_irq dma_tx_gpio;
     qemu_irq dma_rx_gpio;
     qemu_irq coverswitch;
     MemoryRegion iomem;
     omap_clk clk;
-    SDState *card;
     uint16_t last_cmd;
     uint16_t sdio;
     uint16_t rsp[8];
@@ -158,7 +159,7 @@ static void omap_mmc_command(OMAPMMCState *host, int cmd, int dir,
     request.arg = host->arg;
     request.crc = 0; /* FIXME */
 
-    rsplen = sd_do_command(host->card, &request, response);
+    rsplen = sdbus_do_command(&host->sdbus, &request, response);
 
     /* TODO: validate CRCs */
     switch (resptype) {
@@ -247,10 +248,10 @@ static void omap_mmc_transfer(OMAPMMCState *host)
             if (host->fifo_len > host->af_level)
                 break;
 
-            value = sd_read_byte(host->card);
+            value = sdbus_read_byte(&host->sdbus);
             host->fifo[(host->fifo_start + host->fifo_len) & 31] = value;
             if (-- host->blen_counter) {
-                value = sd_read_byte(host->card);
+                value = sdbus_read_byte(&host->sdbus);
                 host->fifo[(host->fifo_start + host->fifo_len) & 31] |=
                         value << 8;
                 host->blen_counter --;
@@ -262,10 +263,10 @@ static void omap_mmc_transfer(OMAPMMCState *host)
                 break;
 
             value = host->fifo[host->fifo_start] & 0xff;
-            sd_write_byte(host->card, value);
+            sdbus_write_byte(&host->sdbus, value);
             if (-- host->blen_counter) {
                 value = host->fifo[host->fifo_start] >> 8;
-                sd_write_byte(host->card, value);
+                sdbus_write_byte(&host->sdbus, value);
                 host->blen_counter --;
             }
 
@@ -328,14 +329,6 @@ static void omap_mmc_reset(OMAPMMCState *host)
     host->clkdiv = 0;
 
     omap_mmc_pseudo_reset(host);
-
-    /* Since we're still using the legacy SD API the card is not plugged
-     * into any bus, and we must reset it manually. When omap_mmc is
-     * QOMified this must move into the QOM reset function.
-     */
-    if (host->card) {
-        device_cold_reset(DEVICE(host->card));
-    }
 }
 
 static uint64_t omap_mmc_read(void *opaque, hwaddr offset, unsigned size)
@@ -592,7 +585,6 @@ static const MemoryRegionOps omap_mmc_ops = {
 
 DeviceState *omap_mmc_init(hwaddr base,
                            MemoryRegion *sysmem,
-                           BlockBackend *blk,
                            qemu_irq irq, qemu_irq dma[], omap_clk clk)
 {
     DeviceState *dev;
@@ -610,11 +602,6 @@ DeviceState *omap_mmc_init(hwaddr base,
     qdev_connect_gpio_out_named(dev, "dma-rx", 0, dma[1]);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
 
-    /* Instantiate the storage */
-    s->card = sd_init(blk, false);
-    if (s->card == NULL) {
-        exit(1);
-    }
     return dev;
 }
 
@@ -639,6 +626,8 @@ static void omap_mmc_initfn(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
     qdev_init_gpio_out_named(DEVICE(obj), &s->dma_tx_gpio, "dma-tx", 1);
     qdev_init_gpio_out_named(DEVICE(obj), &s->dma_rx_gpio, "dma-rx", 1);
+
+    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS, DEVICE(obj), "sd-bus");
 }
 
 static void omap_mmc_class_init(ObjectClass *oc, void *data)
-- 
2.47.1


