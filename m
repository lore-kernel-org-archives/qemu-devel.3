Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA55C2D0A6
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPvG-0000sw-BW; Thu, 15 Oct 2026 14:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvD-0000lE-3t
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:19 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvA-0001Nu-Ku
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:18 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-91054f537ccso65370146d6.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792087875; x=1792692675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9tEI/VlpifxCpLIHjflVDNdBvw+9haRZiBYD7yczmRQ=;
 b=MLI2rj8lK1dgTLiHIyMbQNl3SJox5I7Z6YnAi45EWSu6yduXQQb73Xn8P5mmFlBsJs
 BoOlpG7Z9HoFTBUOoDfKEB76lTsdTfdbmGCtv/LKaSmRuC9RADmMeFS78CkJVPmc6fXN
 ru6IHrYYda6dyo/mTIupohY5y+ZdAF4FX+giZNR7A8bUBwnbVaixFiEX5K9OSjSJDuXf
 Y6EUCAc3Fhvu6Qsvg2UrrYEQntJ1TiiCDce9f2GYFROll/enwVIpybfooO2BBCn+JViQ
 DFH7hst3DesiNMXClFOvsxERcUEIpx7M+hHOcxvNlwvN8398BovXSWMjIdjn4Rix5vM8
 GTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087875; x=1792692675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9tEI/VlpifxCpLIHjflVDNdBvw+9haRZiBYD7yczmRQ=;
 b=mY8rRWarHNK5oSFIkw0qkAfL9xpbTfzuo6o8+iLepdjH/54a7Rmqp5wjCD5i0cisF2
 reGLmqIvdiwpD+ERMBCSiEdoFGIy7bwwUh/GVQxLQC7u1xnEtkmCCRobQaDsNPJo1os6
 4AUG+Xw8yh4w2s+QMQMC5wN/q0VDnwnpdWC7rOpxa8DZo9eFJs9HYp4J4M0DgvIi+0qH
 jpGpAIF+l+rTaBQimKAbYaLfTZ1rPJXpcF8/xLz2rgdYoeJhjfOU5ZNQVWTp5YVHGMNL
 GqqUHLlzxP/eM5jebVHa0FHpVRRk/MiVDw8GtdEropd3xYvc44l4G7GhlE5uUNcDnvif
 YHbA==
X-Gm-Message-State: AFq9FYLrufbpNRaL8c3SOldaon02lmRdGzIvK6Hcy2RKqLNj2QlNWnOb
 Wkidzvf7T/Ooe4flse6+Ptno6DS4l6x7LwwEUqRriZ23n3sH52/2RGpilcaqAbhh
X-Gm-Gg: AYBFou0Bd+Naxo02yPdrDYB3R1kKEOUdlRXsJMT1g6+YbPrqWN5DR67tMbnmW5gckHF
 tGskvW+lgjBW+uNJw3W+53bxGEUe5XJmIwK+so0trQ0F/JwXieyTBMw3a4Zs8EAPmH+3mJAbI2V
 Un/gGzMe7YyjPPYLEMI/KXSbQLzGtMC0PT9n+sBheqz0TNyYo7xszGI2tOmIiWIxZi28rDrDQn8
 5k/C6vql6xldTA0ekqm2pFU9ugTysq00GUjdL2gaHcFDympfCogJbmZ5jKqNhrcOwSiPfrrSq6C
 SryC0+Im7C1dkemg1vX49SOONcgZPTg4mrqGfZIvlUkiHK71HciDqFYadqjKb9deyPY4cGTMPhx
 q9I7j89sHm9bF7tc13b97eQ2XQISwVzUE+e00v/D6fG3B6m7L6/X11Q3wrUHTngpbc8+NwM6BUv
 8DFZem2JKPvqI+jPo3mXIra8u5hapWBTcHH36AiYpc/U8xUQsSanO/M+2D6xLXqH1MEFIKV+wI6
 iMm1Ch4YYYyCzH2+8JENOnn2c/qeEr+nfb7cXD4HCwp8oDjrRHNHpTwQTZChpAKmmebkg==
X-Received: by 2002:a05:620a:7005:b0:93e:c12c:9dc5 with SMTP id
 af79cd13be357-93f01fc22c7mr1115065685a.69.1792087875143; 
 Thu, 15 Oct 2026 11:11:15 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:919:5388:4e10:5949])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91bcba45dffsm1816206d6.12.2026.10.15.11.11.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 11:11:14 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v2 2/5] hw/arm/bcm2838: enable BCM2838 RNG200
Date: Thu, 15 Oct 2026 14:11:08 -0400
Message-ID: <20261015181111.60491-3-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181111.60491-1-marcelomanzo@gmail.com>
References: <20261015181111.60491-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qv1-xf31.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Wire the BCM2838 RNG200 device (added in the previous patch) into
the SoC: instantiate it in the peripherals block, map its register
region at the real BCM2711 physical address, and connect its
interrupt through both the GIC and the legacy GPU interrupt
controller path (matching how the device's own realize() wires it,
mirroring the pattern used for the older BCM2835 RNG on raspi0-3).
Also stop raspi4b from masking out the "brcm,bcm2711-rng200"
device-tree node, now that the controller it describes is actually
implemented.

Adapted from patch 16/41 of Sergey Kambalin's Raspberry Pi 4B series
(patchwork series 829638) against current QEMU master.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2838.c                     |  4 ++++
 hw/arm/bcm2838_peripherals.c         | 17 +++++++++++++++++
 hw/arm/raspi4b.c                     |  1 -
 include/hw/arm/bcm2838_peripherals.h |  2 ++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 089af412a3..218bebc0e8 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -209,6 +209,10 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dwc2), 0,
                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DWC2));
 
+    /* Connect RNG200 to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->rng200), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_RNG200));
+
     /* Connect DMA 0-6 to the interrupt controller */
     for (int n = GIC_SPI_INTERRUPT_DMA_0; n <= GIC_SPI_INTERRUPT_DMA_6; n++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dma),
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 812b5b8480..35e2fc005c 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -35,6 +35,9 @@ static void bcm2838_peripherals_init(Object *obj)
     /* Extended Mass Media Controller 2 */
     object_initialize_child(obj, "emmc2", &s->emmc2, TYPE_SYSBUS_SDHCI);
 
+    /* Random Number Generator */
+    object_initialize_child(obj, "rng200", &s->rng200, TYPE_BCM2838_RNG200);
+
     /* GPIO */
     object_initialize_child(obj, "gpio", &s->gpio, TYPE_BCM2838_GPIO);
 
@@ -67,6 +70,8 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     MemoryRegion *mphi_mr;
     BCM2838PeripheralState *s = BCM2838_PERIPHERALS(dev);
     BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(dev);
+    MemoryRegion *rng200_mr;
+    qemu_irq rng_200_irq;
     int n;
 
     bcm_soc_peripherals_common_realize(dev, errp);
@@ -79,6 +84,18 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
                                         BCM2838_VC_PERI_LOW_BASE,
                                         &s->peri_low_mr_alias, 1);
 
+    /* Random Number Generator */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng200), errp)) {
+        return;
+    }
+
+    rng200_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng200), 0);
+    memory_region_add_subregion(&s_base->peri_mr, RNG_OFFSET, rng200_mr);
+
+    rng_200_irq = qdev_get_gpio_in_named(DEVICE(&s_base->ic),
+                                         BCM2835_IC_GPU_IRQ, INTERRUPT_RNG);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng200), 0, rng_200_irq);
+
     /* Extended Mass Media Controller 2 */
     object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
                              &error_abort);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 566d64572d..87fcba036d 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -64,7 +64,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
     /* Temporarily disable following devices until they are implemented */
     const char *nodes_to_remove[] = {
         "brcm,bcm2711-pcie",
-        "brcm,bcm2711-rng200",
         "brcm,bcm2711-thermal",
         "brcm,bcm2711-genet-v5",
     };
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 0be97e67c7..15423527e8 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -10,6 +10,7 @@
 #define BCM2838_PERIPHERALS_H
 
 #include "hw/arm/bcm2835_peripherals.h"
+#include "hw/misc/bcm2838_rng200.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
@@ -64,6 +65,7 @@ struct BCM2838PeripheralState {
     MemoryRegion peri_low_mr_alias;
     MemoryRegion mphi_mr_alias;
 
+    BCM2838Rng200State rng200;
     SDHCIState emmc2;
     BCM2838GpioState gpio;
 
-- 
2.55.0


