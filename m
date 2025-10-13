Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C734CCD18C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hvx-0005D6-3J; Mon, 13 Oct 2025 08:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvU-0004r6-E0
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvI-0008Ac-8B
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44LG9gRX1yYjCPty+caKSlORbFjlHp1hjLiAApQ0Evo=;
 b=IWojAQSXJpYPKTTJfUCt+WmWoNgRBl6pBtiKaxasB/q6x+O62Q46VotNOcVYmjjC34RXH9
 EfvZBqE3dYzvxJ9mJqCLRpeHx0zcPF83+7GfgqNGn5Li40rRjM0zuCY5h+Tf6TcOtZvOZf
 jyvpxnWqNvC0j5eBJHV4xu0CQ6nGkDo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-xJ-5lJ2UMbWbNkEWwAOVRA-1; Mon,
 13 Oct 2025 08:45:02 -0400
X-MC-Unique: xJ-5lJ2UMbWbNkEWwAOVRA-1
X-Mimecast-MFC-AGG-ID: xJ-5lJ2UMbWbNkEWwAOVRA_1760359501
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 136EE1955F45; Mon, 13 Oct 2025 12:45:01 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 595651800282; Mon, 13 Oct 2025 12:44:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/29] hw/arm/aspeed: Remove AspeedSoCState dependency from
 aspeed_mmio_map() API
Date: Mon, 13 Oct 2025 14:44:09 +0200
Message-ID: <20251013124421.71977-19-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

Refactor aspeed_mmio_map() to take MemoryRegion * instead of
AspeedSoCState *, making the MMIO mapping helper more generic and
decoupled from SoC state.

Update all call sites to pass s->memory (or equivalent) explicitly.
Touched files include: headers, aspeed_soc_common.c, and SoC realize
paths in AST10x0/2400/2600/27x0 (SSP/TSP) and AST2700.

This reduces coupling, improves reuse across variants, and clarifies the
API boundary between SoC state and memory mapping.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251013054334.955331-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  3 +-
 hw/arm/aspeed_ast10x0.c     | 37 ++++++++++++---------
 hw/arm/aspeed_ast2400.c     | 47 +++++++++++++++------------
 hw/arm/aspeed_ast2600.c     | 65 +++++++++++++++++++++----------------
 hw/arm/aspeed_ast27x0-ssp.c |  7 ++--
 hw/arm/aspeed_ast27x0-tsp.c |  7 ++--
 hw/arm/aspeed_ast27x0.c     | 60 +++++++++++++++++++---------------
 hw/arm/aspeed_soc_common.c  |  8 ++---
 8 files changed, 133 insertions(+), 101 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 385b657b5096..606cf6bb6193 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -308,7 +308,8 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp);
 void aspeed_soc_uart_set_chr(SerialMM *uart, int dev, int uarts_base,
                              int uarts_num, Chardev *chr);
 bool aspeed_soc_dram_init(AspeedSoCState *s, Error **errp);
-void aspeed_mmio_map(AspeedSoCState *s, SysBusDevice *dev, int n, hwaddr addr);
+void aspeed_mmio_map(MemoryRegion *memory, SysBusDevice *dev, int n,
+                     hwaddr addr);
 void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
                                    const char *name, hwaddr addr,
                                    uint64_t size);
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index dab012aa953d..caa9feb667ec 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -242,7 +242,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[ASPEED_DEV_SCU]);
 
     /* I2C */
 
@@ -251,7 +252,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_DEV_I2C]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,
+                    sc->memmap[ASPEED_DEV_I2C]);
     for (i = 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
         qemu_irq irq = qdev_get_gpio_in(DEVICE(&a->armv7m),
                                         sc->irqmap[ASPEED_DEV_I2C] + i);
@@ -263,7 +265,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i3c), 0, sc->memmap[ASPEED_DEV_I3C]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i3c), 0,
+                    sc->memmap[ASPEED_DEV_I3C]);
     for (i = 0; i < ASPEED_I3C_NR_DEVICES; i++) {
         qemu_irq irq = qdev_get_gpio_in(DEVICE(&a->armv7m),
                                         sc->irqmap[ASPEED_DEV_I3C] + i);
@@ -275,7 +278,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->peci), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
                     sc->memmap[ASPEED_DEV_PECI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
@@ -284,7 +287,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->lpc), 0, sc->memmap[ASPEED_DEV_LPC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->lpc), 0,
+                    sc->memmap[ASPEED_DEV_LPC]);
 
     /* Connect the LPC IRQ to the GIC. It is otherwise unused. */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
@@ -320,7 +324,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->timerctrl), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
         qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
@@ -331,7 +335,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->adc), 0, sc->memmap[ASPEED_DEV_ADC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
+                    sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
 
@@ -341,8 +346,9 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_DEV_FMC]);
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 1,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 0,
+                    sc->memmap[ASPEED_DEV_FMC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
@@ -354,9 +360,9 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 0,
                         sc->memmap[ASPEED_DEV_SPI1 + i]);
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 1,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,
                         ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
     }
 
@@ -364,7 +370,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sbc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sbc), 0, sc->memmap[ASPEED_DEV_SBC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sbc), 0,
+                    sc->memmap[ASPEED_DEV_SBC]);
 
     /* HACE */
     object_property_set_link(OBJECT(&s->hace), "dram", OBJECT(&s->sram),
@@ -372,7 +379,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->hace), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->hace), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
@@ -387,14 +394,14 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
     }
 
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->gpio), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index 53c2a5156dd5..669075221581 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -289,13 +289,15 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[ASPEED_DEV_SCU]);
 
     /* VIC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->vic), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->vic), 0, sc->memmap[ASPEED_DEV_VIC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->vic), 0,
+                    sc->memmap[ASPEED_DEV_VIC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&a->vic), 0,
                        qdev_get_gpio_in(DEVICE(&a->cpu), ARM_CPU_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&a->vic), 1,
@@ -305,7 +307,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_DEV_RTC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->rtc), 0,
+                    sc->memmap[ASPEED_DEV_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
 
@@ -315,7 +318,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->timerctrl), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
         qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
@@ -326,7 +329,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->adc), 0, sc->memmap[ASPEED_DEV_ADC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
+                    sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
 
@@ -341,7 +345,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_DEV_I2C]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,
+                    sc->memmap[ASPEED_DEV_I2C]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_I2C));
 
@@ -349,7 +354,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->peci), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
                     sc->memmap[ASPEED_DEV_PECI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
@@ -360,8 +365,9 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_DEV_FMC]);
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 1,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 0,
+                    sc->memmap[ASPEED_DEV_FMC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
@@ -377,9 +383,9 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 0,
                         sc->memmap[ASPEED_DEV_SPI1 + i]);
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 1,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,
                         ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
     }
 
@@ -388,7 +394,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->ehci[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
@@ -398,7 +404,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sdmc), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdmc), 0,
                     sc->memmap[ASPEED_DEV_SDMC]);
 
     /* Watch dog */
@@ -411,7 +417,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
     }
 
     /* RAM  */
@@ -426,7 +432,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                         sc->memmap[ASPEED_DEV_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
@@ -436,7 +442,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->xdma), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->xdma), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->xdma), 0,
                     sc->memmap[ASPEED_DEV_XDMA]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_XDMA));
@@ -445,7 +451,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->gpio), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
@@ -454,7 +460,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sdhci), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdhci), 0,
                     sc->memmap[ASPEED_DEV_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
@@ -463,7 +469,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->lpc), 0, sc->memmap[ASPEED_DEV_LPC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->lpc), 0,
+                    sc->memmap[ASPEED_DEV_LPC]);
 
     /* Connect the LPC IRQ to the VIC */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
@@ -496,7 +503,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->hace), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->hace), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 0299d9792918..bf0ecde0514b 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -324,7 +324,7 @@ static bool aspeed_soc_ast2600_pcie_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_phy[0]), errp)) {
         return false;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie_phy[0]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->pcie_phy[0]), 0,
                     sc->memmap[ASPEED_DEV_PCIE_PHY1]);
 
     object_property_set_int(OBJECT(&s->pcie[0]), "dram-base",
@@ -335,7 +335,7 @@ static bool aspeed_soc_ast2600_pcie_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie[0]), errp)) {
         return false;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie[0]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->pcie[0]), 0,
                     sc->memmap[ASPEED_DEV_PCIE0]);
 
     irq = qdev_get_gpio_in(DEVICE(&a->a7mpcore),
@@ -414,7 +414,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                             &error_abort);
 
     sysbus_realize(SYS_BUS_DEVICE(&a->a7mpcore), &error_abort);
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->a7mpcore), 0, ASPEED_A7MPCORE_ADDR);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->a7mpcore), 0,
+                    ASPEED_A7MPCORE_ADDR);
 
     for (i = 0; i < sc->num_cpus; i++) {
         SysBusDevice *sbd = SYS_BUS_DEVICE(&a->a7mpcore);
@@ -448,13 +449,15 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[ASPEED_DEV_SCU]);
 
     /* RTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_DEV_RTC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->rtc), 0,
+                    sc->memmap[ASPEED_DEV_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
 
@@ -464,7 +467,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->timerctrl), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
         irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
@@ -475,7 +478,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->adc), 0, sc->memmap[ASPEED_DEV_ADC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
+                    sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
 
@@ -490,7 +494,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_DEV_I2C]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,
+                    sc->memmap[ASPEED_DEV_I2C]);
     for (i = 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
         irq = qdev_get_gpio_in(DEVICE(&a->a7mpcore),
                                sc->irqmap[ASPEED_DEV_I2C] + i);
@@ -502,7 +507,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->peci), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,
                     sc->memmap[ASPEED_DEV_PECI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
@@ -518,8 +523,9 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_DEV_FMC]);
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 1,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 0,
+                    sc->memmap[ASPEED_DEV_FMC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
@@ -537,9 +543,9 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 0,
                         sc->memmap[ASPEED_DEV_SPI1 + i]);
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 1,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,
                         ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
     }
 
@@ -548,7 +554,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->ehci[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
@@ -558,7 +564,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sdmc), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdmc), 0,
                     sc->memmap[ASPEED_DEV_SDMC]);
 
     /* Watch dog */
@@ -571,7 +577,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
     }
 
     /* RAM */
@@ -586,7 +592,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                         sc->memmap[ASPEED_DEV_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
@@ -597,7 +603,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->mii[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->mii[i]), 0,
                         sc->memmap[ASPEED_DEV_MII1 + i]);
     }
 
@@ -605,7 +611,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->xdma), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->xdma), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->xdma), 0,
                     sc->memmap[ASPEED_DEV_XDMA]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_XDMA));
@@ -614,7 +620,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->gpio), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
@@ -622,7 +628,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio_1_8v), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
                     sc->memmap[ASPEED_DEV_GPIO_1_8V]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_GPIO_1_8V));
@@ -631,7 +637,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sdhci), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdhci), 0,
                     sc->memmap[ASPEED_DEV_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
@@ -640,7 +646,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->emmc), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->emmc), 0,
                     sc->memmap[ASPEED_DEV_EMMC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_EMMC));
@@ -649,7 +655,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->lpc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->lpc), 0, sc->memmap[ASPEED_DEV_LPC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->lpc), 0,
+                    sc->memmap[ASPEED_DEV_LPC]);
 
     /* Connect the LPC IRQ to the GIC. It is otherwise unused. */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 0,
@@ -685,7 +692,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->hace), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->hace), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
@@ -694,7 +701,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i3c), 0, sc->memmap[ASPEED_DEV_I3C]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i3c), 0,
+                    sc->memmap[ASPEED_DEV_I3C]);
     for (i = 0; i < ASPEED_I3C_NR_DEVICES; i++) {
         irq = qdev_get_gpio_in(DEVICE(&a->a7mpcore),
                                sc->irqmap[ASPEED_DEV_I3C] + i);
@@ -706,14 +714,15 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sbc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sbc), 0, sc->memmap[ASPEED_DEV_SBC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sbc), 0,
+                    sc->memmap[ASPEED_DEV_SBC]);
 
     /* FSI */
     for (i = 0; i < ASPEED_FSI_NUM; i++) {
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->fsi[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fsi[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fsi[i]), 0,
                         sc->memmap[ASPEED_DEV_FSI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->fsi[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_DEV_FSI1 + i));
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 490e98b924df..83cf3c14b6c3 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -196,14 +196,15 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[ASPEED_DEV_SCU]);
 
     /* INTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
         return;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[0]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[0]), 0,
                     sc->memmap[ASPEED_DEV_INTC]);
 
     /* INTCIO */
@@ -211,7 +212,7 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[1]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[1]), 0,
                     sc->memmap[ASPEED_DEV_INTCIO]);
 
     /* irq source orgates -> INTC0 */
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index d83f90ef00ce..86aa56560898 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -196,14 +196,15 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[ASPEED_DEV_SCU]);
 
     /* INTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
         return;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[0]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[0]), 0,
                     sc->memmap[ASPEED_DEV_INTC]);
 
     /* INTCIO */
@@ -211,7 +212,7 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[1]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[1]), 0,
                     sc->memmap[ASPEED_DEV_INTCIO]);
 
     /* irq source orgates -> INTC */
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 2f018e9e588a..8db67dc806ac 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -589,9 +589,9 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
         return false;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->gic), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->gic), 0,
                     sc->memmap[ASPEED_GIC_DIST]);
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->gic), 1,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->gic), 1,
                     sc->memmap[ASPEED_GIC_REDIST]);
 
     for (i = 0; i < sc->num_cpus; i++) {
@@ -647,7 +647,7 @@ static bool aspeed_soc_ast2700_pcie_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_phy[i]), errp)) {
             return false;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie_phy[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->pcie_phy[i]), 0,
                         sc->memmap[ASPEED_DEV_PCIE_PHY0 + i]);
 
         object_property_set_int(OBJECT(&s->pcie[i]), "dram-base",
@@ -658,7 +658,7 @@ static bool aspeed_soc_ast2700_pcie_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie[i]), errp)) {
             return false;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->pcie[i]), 0,
                         sc->memmap[ASPEED_DEV_PCIE0 + i]);
         irq = aspeed_soc_get_irq(s, ASPEED_DEV_PCIE0 + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie[i].rc), 0, irq);
@@ -719,7 +719,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[0]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[0]), 0,
                     sc->memmap[ASPEED_DEV_INTC]);
 
     /* INTCIO */
@@ -727,7 +727,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[1]), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[1]), 0,
                     sc->memmap[ASPEED_DEV_INTCIO]);
 
     /* irq sources -> orgates -> INTC */
@@ -777,13 +777,14 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
+                    sc->memmap[ASPEED_DEV_SCU]);
 
     /* SCU1 */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scuio), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scuio), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scuio), 0,
                     sc->memmap[ASPEED_DEV_SCUIO]);
 
     /* UART */
@@ -800,8 +801,9 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_DEV_FMC]);
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fmc), 1,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 0,
+                    sc->memmap[ASPEED_DEV_FMC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->fmc), 1,
                     ASPEED_SMC_GET_CLASS(&s->fmc)->flash_window_base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fmc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_FMC));
@@ -819,9 +821,9 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 0,
                         sc->memmap[ASPEED_DEV_SPI0 + i]);
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 1,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,
                         ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
     }
 
@@ -830,7 +832,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->ehci[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_DEV_EHCI1 + i));
@@ -848,7 +850,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sdmc), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdmc), 0,
                     sc->memmap[ASPEED_DEV_SDMC]);
 
     /* RAM */
@@ -865,7 +867,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                         sc->memmap[ASPEED_DEV_ETH1 + i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_DEV_ETH1 + i));
@@ -876,7 +878,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->mii[i]), 0,
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->mii[i]), 0,
                         sc->memmap[ASPEED_DEV_MII1 + i]);
     }
 
@@ -890,26 +892,28 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
             return;
         }
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->wdt[i]), 0, wdt_offset);
     }
 
     /* SLI */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sli), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sli), 0, sc->memmap[ASPEED_DEV_SLI]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sli), 0,
+                    sc->memmap[ASPEED_DEV_SLI]);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sliio), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sliio), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sliio), 0,
                     sc->memmap[ASPEED_DEV_SLIIO]);
 
     /* ADC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->adc), 0, sc->memmap[ASPEED_DEV_ADC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->adc), 0,
+                    sc->memmap[ASPEED_DEV_ADC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
 
@@ -919,7 +923,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_DEV_I2C]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->i2c), 0,
+                    sc->memmap[ASPEED_DEV_I2C]);
     for (i = 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
         /*
          * The AST2700 I2C controller has one source INTC per bus.
@@ -948,7 +953,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->gpio), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->gpio), 0,
                     sc->memmap[ASPEED_DEV_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
@@ -957,7 +962,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_DEV_RTC]);
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->rtc), 0,
+                    sc->memmap[ASPEED_DEV_RTC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_RTC));
 
@@ -965,7 +971,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sdhci), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->sdhci), 0,
                     sc->memmap[ASPEED_DEV_SDHCI]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
@@ -974,7 +980,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->emmc), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->emmc), 0,
                     sc->memmap[ASPEED_DEV_EMMC]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_EMMC));
@@ -985,7 +991,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->timerctrl), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->timerctrl), 0,
                     sc->memmap[ASPEED_DEV_TIMER1]);
     for (i = 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
         irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
@@ -998,7 +1004,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->hace), errp)) {
         return;
     }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->hace), 0,
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->hace), 0,
                     sc->memmap[ASPEED_DEV_HACE]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 16c7c4bb78d4..ca4e589dce85 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -53,7 +53,7 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
         }
 
         sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0, aspeed_soc_get_irq(s, uart));
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(smm), 0, sc->memmap[uart]);
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(smm), 0, sc->memmap[uart]);
     }
 
     return true;
@@ -111,10 +111,10 @@ bool aspeed_soc_dram_init(AspeedSoCState *s, Error **errp)
     return true;
 }
 
-void aspeed_mmio_map(AspeedSoCState *s, SysBusDevice *dev, int n, hwaddr addr)
+void aspeed_mmio_map(MemoryRegion *memory, SysBusDevice *dev, int n,
+                     hwaddr addr)
 {
-    memory_region_add_subregion(s->memory, addr,
-                                sysbus_mmio_get_region(dev, n));
+    memory_region_add_subregion(memory, addr, sysbus_mmio_get_region(dev, n));
 }
 
 void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
-- 
2.51.0


