Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68572C79F87
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 12:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck8i-0003uD-3E; Mon, 05 Jan 2026 07:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8Q-0003mL-Hj
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8O-0007w2-Dh
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCqeB5q4nk1qZZKh3AiuHmU774j78tSilI9/XgQofrQ=;
 b=AfzKWjEHwCxH9hgVB2VYsotZhx3I3TgB1NZMxC1aHKaIlSPn0xme1aGz/dTklYKRvns6S+
 8LX3rxTH8Bw3iWu3ZGapJCMhDUK23r+y87dGIQbMcn7uKxPvvqiw46pCi97+7qqlVSvzSm
 5GSqIp9FrzwITluM5fTgef8yBO5MMTw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-voe8wOatMe6uHFnH72c_Uw-1; Mon,
 05 Jan 2026 07:56:28 -0500
X-MC-Unique: voe8wOatMe6uHFnH72c_Uw-1
X-Mimecast-MFC-AGG-ID: voe8wOatMe6uHFnH72c_Uw_1767617787
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA1011800610; Mon,  5 Jan 2026 12:56:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 200BB19560A7; Mon,  5 Jan 2026 12:56:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/36] hw/arm/aspeed_ast10x0: Add common realize function for
 AST10x0 SoCs
Date: Mon,  5 Jan 2026 13:55:42 +0100
Message-ID: <20260105125613.622667-6-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Introduce a new common realize function aspeed_soc_ast10x0_realize()
for AST10x0 series SoCs. The shared initialization and realization logic
is now placed in this common function to improve code reuse and reduce
duplication between different SoCs in the same family.

The AST1030 realization function aspeed_soc_ast1030_realize() is
updated to call the new common routine and then perform realization of
its own specific devices such as LPC and PECI, which are not present on
future SoCs like AST1060.

This refactor simplifies maintenance and prepares the framework for
adding AST1060 support.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251112030553.291734-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast10x0.c | 128 ++++++++++++++++++++++------------------
 1 file changed, 70 insertions(+), 58 deletions(-)

diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 1dd1a95ea5bd..72a8c78ff890 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -190,10 +190,9 @@ static void aspeed_soc_ast1030_init(Object *obj)
     object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
 }
 
-static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
+static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
 {
-    Aspeed10x0SoCState *a = ASPEED10X0_SOC(dev_soc);
-    AspeedSoCState *s = ASPEED_SOC(dev_soc);
+    AspeedSoCState *s = ASPEED_SOC(a);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     DeviceState *armv7m;
     Error *err = NULL;
@@ -203,7 +202,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
 
     if (!clock_has_source(s->sysclk)) {
         error_setg(errp, "sysclk clock must be wired up by the board code");
-        return;
+        return false;
     }
 
     /* General I/O memory space to catch all unimplemented device */
@@ -216,7 +215,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
                                   "aspeed.sbc", sc->memmap[ASPEED_DEV_SBC],
                                   0x40000);
 
-    /* AST1030 CPU Core */
+    /* AST10x0 CPU Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
     qdev_prop_set_string(armv7m, "cpu-type",
@@ -232,7 +231,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size, &err);
     if (err != NULL) {
         error_propagate(errp, err);
-        return;
+        return false;
     }
     memory_region_add_subregion(s->memory,
                                 sc->memmap[ASPEED_DEV_SRAM],
@@ -241,14 +240,14 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
                            sc->secsram_size, &err);
     if (err != NULL) {
         error_propagate(errp, err);
-        return;
+        return false;
     }
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SECSRAM],
                                 &s->secsram);
 
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
                     sc->memmap[ASPEED_DEV_SCU]);
@@ -258,7 +257,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(&s->sram),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,
                     sc->memmap[ASPEED_DEV_I2C]);
@@ -271,7 +270,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
 
     /* I3C */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i3c), 0,
                     sc->memmap[ASPEED_DEV_I3C]);
@@ -282,50 +281,11 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i3c.devices[i]), 0, irq);
     }
 
-    /* PECI */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
-        return;
-    }
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
-                    sc->memmap[ASPEED_DEV_PECI]);
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
-                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_PECI));
-
-    /* LPC */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
-        return;
-    }
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->lpc), 0,
-                    sc->memmap[ASPEED_DEV_LPC]);
-
-    /* Connect the LPC IRQ to the GIC. It is otherwise unused. */
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
-                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_LPC));
-
-    /*
-     * On the AST1030 LPC subdevice IRQs are connected straight to the GIC.
-     */
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_1,
-                       qdev_get_gpio_in(DEVICE(&a->armv7m),
-                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_1));
-
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_2,
-                       qdev_get_gpio_in(DEVICE(&a->armv7m),
-                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_2));
-
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_3,
-                       qdev_get_gpio_in(DEVICE(&a->armv7m),
-                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_3));
-
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_4,
-                       qdev_get_gpio_in(DEVICE(&a->armv7m),
-                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_4));
-
     /* UART */
     for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
         if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
                                      sc->memmap[uart], errp)) {
-            return;
+            return false;
         }
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
                            aspeed_soc_ast1030_get_irq(s, uart));
@@ -335,7 +295,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
@@ -346,7 +306,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
 
     /* ADC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
                     sc->memmap[ASPEED_DEV_ADC]);
@@ -357,7 +317,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(&s->sram),
             &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 0,
                     sc->memmap[ASPEED_DEV_FMC]);
@@ -371,7 +331,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
         object_property_set_link(OBJECT(&s->spi[i]), "dram",
                                  OBJECT(&s->sram), &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
-            return;
+            return false;
         }
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 0,
                         sc->memmap[ASPEED_DEV_SPI1 + i]);
@@ -383,7 +343,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
 
     /* Secure Boot Controller */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sbc), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sbc), 0,
                     sc->memmap[ASPEED_DEV_SBC]);
@@ -392,7 +352,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     object_property_set_link(OBJECT(&s->hace), "dram", OBJECT(&s->sram),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->hace), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
@@ -407,14 +367,14 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
         object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu),
                                  &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
-            return;
+            return false;
         }
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
     }
 
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
-        return;
+        return false;
     }
     aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
@@ -442,6 +402,58 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[1]),
                                   "aspeed.jtag",
                                   sc->memmap[ASPEED_DEV_JTAG1], 0x20);
+
+    return true;
+}
+
+static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
+{
+    Aspeed10x0SoCState *a = ASPEED10X0_SOC(dev_soc);
+    AspeedSoCState *s = ASPEED_SOC(dev_soc);
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+
+    if (!aspeed_soc_ast10x0_realize(a, errp)) {
+        return;
+    }
+
+    /* PECI */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
+                    sc->memmap[ASPEED_DEV_PECI]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
+                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_PECI));
+
+    /* LPC */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->lpc), 0,
+                    sc->memmap[ASPEED_DEV_LPC]);
+
+    /* Connect the LPC IRQ to the GIC. It is otherwise unused. */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
+                       aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_LPC));
+
+    /*
+     * On the AST1030 LPC subdevice IRQs are connected straight to the GIC.
+     */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_1,
+                       qdev_get_gpio_in(DEVICE(&a->armv7m),
+                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_1));
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_2,
+                       qdev_get_gpio_in(DEVICE(&a->armv7m),
+                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_2));
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_3,
+                       qdev_get_gpio_in(DEVICE(&a->armv7m),
+                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_3));
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_4,
+                       qdev_get_gpio_in(DEVICE(&a->armv7m),
+                                sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_4));
 }
 
 static void aspeed_soc_ast1030_class_init(ObjectClass *klass, const void *data)
-- 
2.52.0


