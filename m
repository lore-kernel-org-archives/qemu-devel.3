Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE16CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Q4-0005gI-Q8; Tue, 07 Oct 2025 10:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Q2-0005fJ-JW
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Po-000293-SP
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:57 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so66612265e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846301; x=1760451101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XvGfX+mVa3O6gDu3cmy3CeWTMPWFcZ3+R6tHUaiLbSs=;
 b=z1Je3k3dprtteKgvzqiloh8z9AAgRmjCRKmyS2lFB++mzuedvrzocFYPAuU6ZLaGbH
 mJplGTJVuvu/W8WdUZKkFa6mWnkIlsgrkE3ydYl6dqWlBK9j6676CztJ4h3z1w5XdNSn
 NoHxULagEjZ2jOk/GzxHmsvZllw8UNScfstwOe8qKLAyZnElhGCD4bxd8Ho9pJv4SAmS
 akfQnyrmhWCuAycAGoe0Am6cpY1gBkYxg6N/IrjUUI6cVu0+W5FHyfo383+mTBXwhWKM
 fspGD7wBcwQGbm7V4M+CAlHIUstYQv6+qM8Nzkts2q0L2ArA5nWOymGSdmr5LCaTG7S3
 Nd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846301; x=1760451101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XvGfX+mVa3O6gDu3cmy3CeWTMPWFcZ3+R6tHUaiLbSs=;
 b=OwGA820ITAzMPoUj4R3xzbHe21GccGZ4RHkFjbKxfDR4bMvwKWK91FsSdMSALUimeE
 ePAasKtJCPUZPuV12ZaoAB76rdIpzfMcHfIOO3FdFM0OKfCTiEYNV058kXw6TvH1Jsej
 mvcg6/NuBq1izd+RsWhal244ueeYJS1ZJH1WkUE0UGsdxMpwIjnJk9t4m4fKde7upv+S
 J8Tfloa47/36Zmc1sZGU2tTdBxm2fS1vl5Dw547UpbkLZObbMWH4cOGfu6tSyHzEfprM
 Xji2YHGyEpWIEhd2xYFYDS79UKRz3YMNgqwy0jM8TNvPeueFeRLQL56pDUz8ervjlVp8
 B/ow==
X-Gm-Message-State: AOJu0Yw4eKEjIrt4L9BlZbnzVu9w54FQl4mzoDFdpZEMAwa0kjDbO2Hs
 z/1+m6ELPUcAzfnEjGmNofagQgAZiq1VqMTkqfC2zMM4YA3uMbo8FSyoWkfJSHuZZ8lFpiF+Mwk
 c6juh
X-Gm-Gg: ASbGnctZroEk7f9xTXgCtjIMFhBQoSSZXGNw8NOO42Vq9LJGmfvBvRSKspri6MVSwV8
 uvK31m2S0xxplqPGrLUxu+rsxmk/X/yG1Y2/IndXRMTC/G0jcwtFe0hs+4BFndeuUXuN5Dmvo7P
 7XSktfWgZyNfmkyO1z6PKXu5kCWjS1bU3EGuA31bohO/vfSX5v1cKdH7Tx+m6LepmxF+H0NbKKg
 xYOH12bJ2bTFmgu6VK+9nRdb24L2cHOLZdlNDDJhMjQv8oxjYNPAHbKkAcWXnib2uITpv6SDqMl
 v4BD5PTiuDCtVnBCLG3FdJTP+1ZnnXnn0J7DuFyMA3nOuaEncoDv9I2g2hquFbSZw/0iSk5QTew
 Rygb7RerL2Q2Z98j23VdVoiu0HNR9nxRzVYYffOR7NjpiEqkXTERbEgWB+jPLZNJKTlI=
X-Google-Smtp-Source: AGHT+IF7orwAreTm0DMqDK3XDnHBrSE5BJntiZF7qxuwCpI5z3oEE4WYZT0WFi4jpV15h0N8NbbOrA==
X-Received: by 2002:a05:600c:8b6e:b0:46e:4499:ba30 with SMTP id
 5b1f17b1804b1-46e71153ad0mr129421265e9.30.1759846300838; 
 Tue, 07 Oct 2025 07:11:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/62] hw/arm/xlnx-versal: PMC IOU SCLR: refactor creation
Date: Tue,  7 Oct 2025 15:10:34 +0100
Message-ID: <20251007141123.3239867-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Luc Michel <luc.michel@amd.com>

Refactor the PMC IOU SLCR device creation using the VersalMap structure.
This is the first user of a shared IRQ using an OR gate. The OSPI
controller is reconnected to the SLCR.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-14-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  5 ----
 hw/arm/xlnx-versal.c         | 48 +++++++++++++++++++++---------------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index b7ef255d6fd..78442e6c2c5 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -21,7 +21,6 @@
 #include "qom/object.h"
 #include "hw/nvram/xlnx-bbram.h"
 #include "hw/misc/xlnx-versal-crl.h"
-#include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 #include "hw/misc/xlnx-versal-trng.h"
 #include "net/can_emu.h"
 #include "hw/misc/xlnx-versal-cfu.h"
@@ -84,10 +83,6 @@ struct Versal {
 
     /* The Platform Management Controller subsystem.  */
     struct {
-        struct {
-            XlnxVersalPmcIouSlcr slcr;
-        } iou;
-
         XlnxZynqMPRTC rtc;
         XlnxVersalTRng trng;
         XlnxBBRam bbram;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index d3a084a0639..e71c774e72e 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -35,6 +35,7 @@
 #include "hw/usb/xlnx-usb-subsystem.h"
 #include "hw/nvram/xlnx-versal-efuse.h"
 #include "hw/ssi/xlnx-versal-ospi.h"
+#include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -116,6 +117,8 @@ typedef struct VersalMap {
         uint64_t dma_dst;
         int irq;
     } ospi;
+
+    VersalSimplePeriphMap pmc_iou_slcr;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
@@ -156,6 +159,8 @@ static const VersalMap VERSAL_MAP = {
         .dma_src = 0xf1011000, .dma_dst = 0xf1011800,
         .irq = 124,
     },
+
+    .pmc_iou_slcr = { 0xf1060000, OR_IRQ(121, 0) },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
@@ -870,21 +875,24 @@ static void versal_create_efuse(Versal *s,
     versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(ctrl), 0, map->irq);
 }
 
-static void versal_create_pmc_iou_slcr(Versal *s, qemu_irq *pic)
+static DeviceState *versal_create_pmc_iou_slcr(Versal *s,
+                                               const VersalSimplePeriphMap *map)
 {
     SysBusDevice *sbd;
+    DeviceState *dev;
 
-    object_initialize_child(OBJECT(s), "versal-pmc-iou-slcr", &s->pmc.iou.slcr,
-                            TYPE_XILINX_VERSAL_PMC_IOU_SLCR);
+    dev = qdev_new(TYPE_XILINX_VERSAL_PMC_IOU_SLCR);
+    object_property_add_child(OBJECT(s), "pmc-iou-slcr", OBJECT(dev));
 
-    sbd = SYS_BUS_DEVICE(&s->pmc.iou.slcr);
-    sysbus_realize(sbd, &error_fatal);
+    sbd = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sbd, &error_fatal);
 
-    memory_region_add_subregion(&s->mr_ps, MM_PMC_PMC_IOU_SLCR,
+    memory_region_add_subregion(&s->mr_ps, map->addr,
                                 sysbus_mmio_get_region(sbd, 0));
 
-    sysbus_connect_irq(sbd, 0,
-                       qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 2));
+    versal_sysbus_connect_irq(s, sbd, 0, map->irq);
+
+    return dev;
 }
 
 static DeviceState *versal_create_ospi(Versal *s,
@@ -1210,6 +1218,7 @@ static void versal_unimp_irq_parity_imr(void *opaque, int n, int level)
 
 static void versal_unimp(Versal *s)
 {
+    DeviceState *slcr;
     qemu_irq gpio_in;
 
     versal_unimp_area(s, "psm", &s->mr_ps,
@@ -1232,23 +1241,18 @@ static void versal_unimp(Versal *s)
     qdev_init_gpio_in_named(DEVICE(s), versal_unimp_irq_parity_imr,
                             "irq-parity-imr-dummy", 1);
 
+    slcr = DEVICE(versal_get_child(s, "pmc-iou-slcr"));
     gpio_in = qdev_get_gpio_in_named(DEVICE(s), "sd-emmc-sel-dummy", 0);
-    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr), "sd-emmc-sel", 0,
-                                gpio_in);
+    qdev_connect_gpio_out_named(slcr, "sd-emmc-sel", 0, gpio_in);
 
     gpio_in = qdev_get_gpio_in_named(DEVICE(s), "sd-emmc-sel-dummy", 1);
-    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr), "sd-emmc-sel", 1,
-                                gpio_in);
+    qdev_connect_gpio_out_named(slcr, "sd-emmc-sel", 1, gpio_in);
 
     gpio_in = qdev_get_gpio_in_named(DEVICE(s), "qspi-ospi-mux-sel-dummy", 0);
-    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr),
-                                "qspi-ospi-mux-sel", 0,
-                                gpio_in);
+    qdev_connect_gpio_out_named(slcr, "qspi-ospi-mux-sel", 0, gpio_in);
 
     gpio_in = qdev_get_gpio_in_named(DEVICE(s), "irq-parity-imr-dummy", 0);
-    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr),
-                                SYSBUS_DEVICE_GPIO_IRQ, 0,
-                                gpio_in);
+    qdev_connect_gpio_out_named(slcr, SYSBUS_DEVICE_GPIO_IRQ, 0, gpio_in);
 }
 
 static uint32_t fdt_add_clk_node(Versal *s, const char *name,
@@ -1271,6 +1275,7 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
+    DeviceState *slcr, *ospi;
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
     Object *container;
     const VersalMap *map = versal_get_map(s);
@@ -1323,13 +1328,16 @@ static void versal_realize(DeviceState *dev, Error **errp)
     }
 
     versal_create_efuse(s, &map->efuse);
-    versal_create_ospi(s, &map->ospi);
+    ospi = versal_create_ospi(s, &map->ospi);
+    slcr = versal_create_pmc_iou_slcr(s, &map->pmc_iou_slcr);
 
+    qdev_connect_gpio_out_named(slcr, "ospi-mux-sel", 0,
+                                qdev_get_gpio_in_named(ospi,
+                                                       "ospi-mux-sel", 0));
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
     versal_create_bbram(s, pic);
-    versal_create_pmc_iou_slcr(s, pic);
     versal_create_crl(s, pic);
     versal_create_cfu(s, pic);
     versal_map_ddr(s);
-- 
2.43.0


