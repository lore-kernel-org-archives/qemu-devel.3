Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAABC02193
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcj6c-0001Jz-Ej; Tue, 28 Jan 2025 05:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj65-0001A5-Jj
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:39 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj5z-0003Wy-SJ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:31 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361f796586so59796085e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 02:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738061126; x=1738665926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJjNi5BZ7mcnb7aQo8EZDoTwnCfEh31OBc5WYUuoav8=;
 b=c0768Urk5oWd94LArugm4RbjpWTKd0ATVHChZTlS17NkKaurgW8gTFLZ0HHCgRLYft
 bQhAb/4QN3cIT98kMrlMWd4fiNDpe9nzd1u9+19OGPtO0stPMPrkmd1rhMbuzYaZ4QbX
 8LW65LoBQqgnhdH243//wpla1kUDXtvHquBhi2ZoyRmuua3vlmUoDo5tVK0esSheaHte
 /9skiOKMqREr+FCvC+IUTGGvEjPmXOxBc6XLO0vilHDJjIc4B2bsokIKnE4h0APEhvt4
 ShHq5AwLjVpNuan9aXkhm2NoTFXfm6q/oAVhiRZB1FwDdM8PttStqZrsRfrqN38ks6lD
 hfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738061126; x=1738665926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJjNi5BZ7mcnb7aQo8EZDoTwnCfEh31OBc5WYUuoav8=;
 b=Jr11xek6bgfJpXvLaLltFZE/vHdCxjqqwmaXnhA2jblkGddtUEJlQFYSU5Rl346tdl
 pfoMJs6HhsdMdr18VjOlA6NC2KtETbymNbgR7k6PTDXOxnCYKfJ7tQxXQmKezjR98oMl
 ZhJSz6jn8adrsnwlrUWpD6Ivy7K2Vg3vIPTyMjLtc12VvrhyUDmaCezjdMMa1tjXLCI3
 bQ3vvhVbFsiBAhAKbp7IGLORL035JdQRbrplFOuLGQmHhrZlKjyh2k6KS/oA+cYHk31Y
 BAnHxqlogxVopsry26TPaMVLyW72oExT4JE7tNYGgunLVowooUUautgIGhV8HwMwf13j
 1wDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUus8XQgrLcWlSDyaWm4oBnHvUgTLCwcUFUL/cZzu8KUIyps3T+h29vcXe+t6GDLnIYg9GBz55GDiYD@nongnu.org
X-Gm-Message-State: AOJu0YxkkODZhMOE8XMpz1y+BmwYu+whmvv5n3+EKZFxdgxMAY8Aa90R
 YlEEsW/1TIlr9/HOfK2vVHXC0q+c5CH3NqbrlOPLlQ/fhtcrPPuuQXsWIcJu0D0=
X-Gm-Gg: ASbGnctOpY3cUjLTgh9hIW6HDVu2rdAfuKPgMZiiLXk7tmHryCjhzRBmLgKkf8UFQoV
 Uya8NxVaCEa7CqFRXlNPF467UM+P+ypAGRHZPe1EY0VqcPXluqOAicvGQKfsKUZOQ9ShOE8EqBN
 Un+lPe7RsxsTc+pIRvah79WPOGuutYb/G3gLqlYzRssRxuisRz1ugzKT25lxRAsBHCrgTutWuYD
 u9nHq+SgTkFopKbFtHR/LgYQdBmQYZcNKBmdyv7B1O2UjNwXnIyyOZDgaFtMeVQ+ay5r851uZvQ
 HTHqTbZDANWgIOk7tPMt
X-Google-Smtp-Source: AGHT+IFyEoGh8VTglXIUSHLVwUPwUkq9rIhLJJXEin6fnNArZA+7ryCGz2vFobQJEmwidumuUJPL4Q==
X-Received: by 2002:a5d:6d86:0:b0:388:c75d:be97 with SMTP id
 ffacd0b85a97d-38bf564960cmr40457824f8f.11.1738061126031; 
 Tue, 28 Jan 2025 02:45:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c418esm13920133f8f.95.2025.01.28.02.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 02:45:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 04/11] hw/sd/omap_mmc: Convert to SDBus API
Date: Tue, 28 Jan 2025 10:45:12 +0000
Message-Id: <20250128104519.3981448-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128104519.3981448-1-peter.maydell@linaro.org>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
---
 include/hw/arm/omap.h |  1 -
 hw/arm/omap1.c        | 10 +++++++++-
 hw/sd/omap_mmc.c      | 30 ++++++++++--------------------
 3 files changed, 19 insertions(+), 22 deletions(-)

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
index d497e31a6c5..46fdeac1121 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -30,13 +30,14 @@
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
 
@@ -643,6 +630,9 @@ static void omap_mmc_initfn(Object *obj)
 
 static void omap_mmc_realize(DeviceState *dev, Error **errp)
 {
+    OMAPMMCState *s = OMAP_MMC(dev);
+
+    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS, dev, "sd-bus");
 }
 
 static void omap_mmc_class_init(ObjectClass *oc, void *data)
-- 
2.34.1


