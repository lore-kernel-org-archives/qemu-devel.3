Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C457CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8HvQ-0004oD-JJ; Mon, 13 Oct 2025 08:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvP-0004md-Ci
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvJ-0008Bc-Hl
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jdcuTtv3GtelBi1Eyq/x52H6yVAK2KRf0s4RoIRaUOI=;
 b=felo8vql4GBQDkcoJAYPcj97pZY/vRfvV40Nsq+B6HClrc0Kjr3lBjnHxOoggbT8FAg7NF
 EZBLuCPrVfCFpSuR5leo62TYTLdgIS4w563DpmWCuiinc0GfeUQXQCyUqooy1qT0NGVIhj
 9bZIDq/gtRmhtN8d7SGZBPRY2U/iD4U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-tmCOMAeOOP2A9HvjP-UTAw-1; Mon,
 13 Oct 2025 08:45:05 -0400
X-MC-Unique: tmCOMAeOOP2A9HvjP-UTAw-1
X-Mimecast-MFC-AGG-ID: tmCOMAeOOP2A9HvjP-UTAw_1760359505
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8DC219560B7; Mon, 13 Oct 2025 12:45:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 755781800446; Mon, 13 Oct 2025 12:45:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/29] hw/arm/aspeed: Remove AspeedSoCState dependency from
 aspeed_soc_uart_realize() API
Date: Mon, 13 Oct 2025 14:44:11 +0200
Message-ID: <20251013124421.71977-21-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Refactor aspeed_soc_uart_realize() to take MemoryRegion *, SerialMM *,
and MMIO base addr instead of AspeedSoCState *, decoupling the helper
from SoC state and making it reusable per-UART.

The helper now realizes a single UART instance and maps its MMIO.
IRQ wiring and iteration over all UARTs are moved to callers.

Update call sites in AST1030, AST2400, AST2600, AST27x0 SSP/TSP, and
AST2700 to loop over UARTs, call the new helper, and connect IRQ via
aspeed_soc_get_irq().

This simplifies the UART realize path and reduces cross-module coupling.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251013054334.955331-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  3 ++-
 hw/arm/aspeed_ast10x0.c     | 10 ++++++++--
 hw/arm/aspeed_ast2400.c     | 10 ++++++++--
 hw/arm/aspeed_ast2600.c     | 10 ++++++++--
 hw/arm/aspeed_ast27x0-ssp.c | 10 ++++++++--
 hw/arm/aspeed_ast27x0-tsp.c | 10 ++++++++--
 hw/arm/aspeed_ast27x0.c     | 10 ++++++++--
 hw/arm/aspeed_soc_common.c  | 28 ++++++++++------------------
 8 files changed, 60 insertions(+), 31 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 957362b88d06..47341ea2fdbc 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -304,7 +304,8 @@ enum {
 
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
 qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
-bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp);
+bool aspeed_soc_uart_realize(MemoryRegion *memory, SerialMM *smm,
+                             const hwaddr addr, Error **errp);
 void aspeed_soc_uart_set_chr(SerialMM *uart, int dev, int uarts_base,
                              int uarts_num, Chardev *chr);
 bool aspeed_soc_dram_init(AspeedSoCState *s, Error **errp);
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index e861b6dad699..ff781379c10e 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -192,6 +192,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     DeviceState *armv7m;
     Error *err = NULL;
+    int uart;
     int i;
     g_autofree char *sram_name = NULL;
 
@@ -316,8 +317,13 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
                                 sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_4));
 
     /* UART */
-    if (!aspeed_soc_uart_realize(s, errp)) {
-        return;
+    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
+        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
+                                     sc->memmap[uart], errp)) {
+            return;
+        }
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           aspeed_soc_get_irq(s, uart));
     }
 
     /* Timer */
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index e0604851a558..8d4d6564c7ad 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -251,6 +251,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     g_autofree char *sram_name = NULL;
+    int uart;
 
     /* Default boot region (SPI memory or ROMs) */
     memory_region_init(&s->spi_boot_container, OBJECT(s),
@@ -337,8 +338,13 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
 
     /* UART */
-    if (!aspeed_soc_uart_realize(s, errp)) {
-        return;
+    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
+        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
+                                     sc->memmap[uart], errp)) {
+            return;
+        }
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           aspeed_soc_get_irq(s, uart));
     }
 
     /* I2C */
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index ed0985a16e08..f508bf53e71d 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -362,6 +362,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     qemu_irq irq;
     g_autofree char *sram_name = NULL;
+    int uart;
 
     /* Default boot region (SPI memory or ROMs) */
     memory_region_init(&s->spi_boot_container, OBJECT(s),
@@ -488,8 +489,13 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_DEV_ADC));
 
     /* UART */
-    if (!aspeed_soc_uart_realize(s, errp)) {
-        return;
+    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
+        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
+                                     sc->memmap[uart], errp)) {
+            return;
+        }
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           aspeed_soc_get_irq(s, uart));
     }
 
     /* I2C */
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 99a3de15b56c..7420ae04acb5 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -164,6 +164,7 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     DeviceState *armv7m;
     g_autofree char *sram_name = NULL;
+    int uart;
     int i;
 
     if (!clock_has_source(s->sysclk)) {
@@ -237,8 +238,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
                         qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), i));
     }
     /* UART */
-    if (!aspeed_soc_uart_realize(s, errp)) {
-        return;
+    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
+        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
+                                     sc->memmap[uart], errp)) {
+            return;
+        }
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           aspeed_soc_get_irq(s, uart));
     }
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 568d7555e26e..b764147a3313 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -164,6 +164,7 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     DeviceState *armv7m;
     g_autofree char *sram_name = NULL;
+    int uart;
     int i;
 
     if (!clock_has_source(s->sysclk)) {
@@ -237,8 +238,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
                         qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), i));
     }
     /* UART */
-    if (!aspeed_soc_uart_realize(s, errp)) {
-        return;
+    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
+        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
+                                     sc->memmap[uart], errp)) {
+            return;
+        }
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           aspeed_soc_get_irq(s, uart));
     }
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 9b645c6c5502..96882b875548 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -687,6 +687,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     AspeedINTCClass *icio = ASPEED_INTC_GET_CLASS(&a->intc[1]);
     g_autofree char *name = NULL;
     qemu_irq irq;
+    int uart;
 
     /* Default boot region (SPI memory or ROMs) */
     memory_region_init(&s->spi_boot_container, OBJECT(s),
@@ -788,8 +789,13 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                     sc->memmap[ASPEED_DEV_SCUIO]);
 
     /* UART */
-    if (!aspeed_soc_uart_realize(s, errp)) {
-        return;
+    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
+        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
+                                     sc->memmap[uart], errp)) {
+            return;
+        }
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
+                           aspeed_soc_get_irq(s, uart));
     }
 
     /* FMC, The number of CS is set at the board level */
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index e7d0a9c2909a..a785a50609e3 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -35,27 +35,19 @@ qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev)
     return ASPEED_SOC_GET_CLASS(s)->get_irq(s, dev);
 }
 
-bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
+bool aspeed_soc_uart_realize(MemoryRegion *memory, SerialMM *smm,
+                             const hwaddr addr, Error **errp)
 {
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    SerialMM *smm;
-
-    for (int i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
-        smm = &s->uart[i];
-
-        /* Chardev property is set by the machine. */
-        qdev_prop_set_uint8(DEVICE(smm), "regshift", 2);
-        qdev_prop_set_uint32(DEVICE(smm), "baudbase", 38400);
-        qdev_set_legacy_instance_id(DEVICE(smm), sc->memmap[uart], 2);
-        qdev_prop_set_uint8(DEVICE(smm), "endianness", DEVICE_LITTLE_ENDIAN);
-        if (!sysbus_realize(SYS_BUS_DEVICE(smm), errp)) {
-            return false;
-        }
-
-        sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0, aspeed_soc_get_irq(s, uart));
-        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(smm), 0, sc->memmap[uart]);
+    /* Chardev property is set by the machine. */
+    qdev_prop_set_uint8(DEVICE(smm), "regshift", 2);
+    qdev_prop_set_uint32(DEVICE(smm), "baudbase", 38400);
+    qdev_set_legacy_instance_id(DEVICE(smm), addr, 2);
+    qdev_prop_set_uint8(DEVICE(smm), "endianness", DEVICE_LITTLE_ENDIAN);
+    if (!sysbus_realize(SYS_BUS_DEVICE(smm), errp)) {
+        return false;
     }
 
+    aspeed_mmio_map(memory, SYS_BUS_DEVICE(smm), 0, addr);
     return true;
 }
 
-- 
2.51.0


