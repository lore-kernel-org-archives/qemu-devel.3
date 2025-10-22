Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EDBCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXzn-0001X8-IC; Wed, 22 Oct 2025 08:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXz2-0001H8-HL
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXyy-0008OM-GI
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761136223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJarjOHnzMQr4ZfDR1YaDT6/LXUlXROKNryhb0ckRQs=;
 b=PKJLWoqwajol/X1Lifur74jU7G9ku1lCZkM3UclbrTdE8e07y19uExH4LJi8UTaVMnWVwQ
 9FzADtYzB5urt6dsIxpxIPa7+xJZ5ZbgAL8d9z247u4cS84KsFFVuhFtO7B2E1FsSo9COg
 UoErXzM6mDRWq1QLCGPGRVfMjJTwpPQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-13CcXV6BPDuAXbnFzozk-w-1; Wed,
 22 Oct 2025 08:30:17 -0400
X-MC-Unique: 13CcXV6BPDuAXbnFzozk-w-1
X-Mimecast-MFC-AGG-ID: 13CcXV6BPDuAXbnFzozk-w_1761136216
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11B8618002C0; Wed, 22 Oct 2025 12:30:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F7D9180057E; Wed, 22 Oct 2025 12:30:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/16] hw/arm/ast27x0: Share single UART set across PSP, SSP,
 and TSP
Date: Wed, 22 Oct 2025 14:29:43 +0200
Message-ID: <20251022122953.877335-7-clg@redhat.com>
In-Reply-To: <20251022122953.877335-1-clg@redhat.com>
References: <20251022122953.877335-1-clg@redhat.com>
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

In the original model, each subsystem (PSP, SSP, and TSP) created its own
set of 13 UART devices, resulting in a total of 39 UART instances. However,
on real AST2700 hardware, there is only one set of 13 UARTs shared among
all processors.

This commit reworks the UART handling to correctly model the shared
hardware design. The PSP now creates the full set of 13 UART instances,
while the SSP and TSP link to the corresponding shared UART device
through object properties.

Changes include:
- Add "DEFINE_PROP_LINK("uart", ...)" and "DEFINE_PROP_INT32("uart-dev", ...)"
  to allow each coprocessor to reference a specific shared UART instance.
- Modify SSP to link to PSP’s UART4, and TSP to link to PSP’s UART7.
- Introduce "uart_alias" to remap the UART’s MMIO region into the coprocessor’s
  memory space.
- Redirect the UART interrupt to the coprocessor’s NVIC, replacing the
  default routing to the PSP’s GIC.

With this change, only one set of 13 UART devices is instantiated by the PSP,
while the SSP and TSP reuse them via aliasing and shared interrupt routing,
matching the real AST2700 hardware behavior.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251015062210.3128710-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_coprocessor.h |  6 +++---
 hw/arm/aspeed_ast27x0-fc.c          | 24 ++++++++++++------------
 hw/arm/aspeed_ast27x0-ssp.c         | 29 ++++++++++++-----------------
 hw/arm/aspeed_ast27x0-tsp.c         | 29 ++++++++++++-----------------
 hw/arm/aspeed_coprocessor_common.c  |  3 +++
 5 files changed, 42 insertions(+), 49 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index c1f2c549c323..4a50f688ecdc 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -19,13 +19,15 @@ struct AspeedCoprocessorState {
     MemoryRegion sdram;
     MemoryRegion *sram;
     MemoryRegion sram_alias;
+    MemoryRegion uart_alias;
     MemoryRegion scu_alias;
     Clock *sysclk;
 
     AspeedSCUState *scu;
     AspeedSCUState scuio;
     AspeedTimerCtrlState timerctrl;
-    SerialMM uart[ASPEED_UARTS_NUM];
+    SerialMM *uart;
+    int uart_dev;
 };
 
 #define TYPE_ASPEED_COPROCESSOR "aspeed-coprocessor"
@@ -39,8 +41,6 @@ struct AspeedCoprocessorClass {
     const char * const *valid_cpu_types;
     const hwaddr *memmap;
     const int *irqmap;
-    int uarts_base;
-    int uarts_num;
 };
 
 struct Aspeed27x0CoprocessorState {
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index ba43a4620760..99af87dbd7bd 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -93,6 +93,10 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
                             AST2700FC_HW_STRAP2, &error_abort);
     aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART12, sc->uarts_base,
                             sc->uarts_num, serial_hd(0));
+    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART4, sc->uarts_base,
+                            sc->uarts_num, serial_hd(1));
+    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART7, sc->uarts_base,
+                            sc->uarts_num, serial_hd(2));
     if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {
         return false;
     }
@@ -115,8 +119,6 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
 
 static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
 {
-    AspeedCoprocessorState *soc;
-    AspeedCoprocessorClass *sc;
     Ast2700FCState *s = AST2700A1FC(machine);
     AspeedSoCState *psp = ASPEED_SOC(&s->ca35);
 
@@ -132,10 +134,10 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
     object_property_set_link(OBJECT(&s->ssp), "memory",
                              OBJECT(&s->ssp_memory), &error_abort);
 
-    soc = ASPEED_COPROCESSOR(&s->ssp);
-    sc = ASPEED_COPROCESSOR_GET_CLASS(soc);
-    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART4, sc->uarts_base,
-                            sc->uarts_num, serial_hd(1));
+    object_property_set_link(OBJECT(&s->ssp), "uart",
+                             OBJECT(&psp->uart[4]), &error_abort);
+    object_property_set_int(OBJECT(&s->ssp), "uart-dev", ASPEED_DEV_UART4,
+                            &error_abort);
     object_property_set_link(OBJECT(&s->ssp), "sram",
                              OBJECT(&psp->sram), &error_abort);
     object_property_set_link(OBJECT(&s->ssp), "scu",
@@ -149,8 +151,6 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
 
 static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
 {
-    AspeedCoprocessorState *soc;
-    AspeedCoprocessorClass *sc;
     Ast2700FCState *s = AST2700A1FC(machine);
     AspeedSoCState *psp = ASPEED_SOC(&s->ca35);
 
@@ -166,10 +166,10 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
     object_property_set_link(OBJECT(&s->tsp), "memory",
                              OBJECT(&s->tsp_memory), &error_abort);
 
-    soc = ASPEED_COPROCESSOR(&s->tsp);
-    sc = ASPEED_COPROCESSOR_GET_CLASS(soc);
-    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART7, sc->uarts_base,
-                            sc->uarts_num, serial_hd(2));
+    object_property_set_link(OBJECT(&s->tsp), "uart",
+                             OBJECT(&psp->uart[7]), &error_abort);
+    object_property_set_int(OBJECT(&s->tsp), "uart-dev", ASPEED_DEV_UART7,
+                            &error_abort);
     object_property_set_link(OBJECT(&s->tsp), "sram",
                              OBJECT(&psp->sram), &error_abort);
     object_property_set_link(OBJECT(&s->tsp), "scu",
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 577a3379c6c0..d12a9b8459c2 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -133,16 +133,10 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)
 {
     Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_COPROCESSOR(obj);
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(obj);
-    AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
-    int i;
 
     object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 
-    for (i = 0; i < sc->uarts_num; i++) {
-        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
-    }
-
     object_initialize_child(obj, "intc0", &a->intc[0],
                             TYPE_ASPEED_2700SSP_INTC);
     object_initialize_child(obj, "intc1", &a->intc[1],
@@ -165,7 +159,6 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
     g_autofree char *sdram_name = NULL;
-    int uart;
     int i;
 
     if (!clock_has_source(s->sysclk)) {
@@ -244,15 +237,19 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[1]), i,
                         qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), i));
     }
+
     /* UART */
-    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
-        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
-                                     sc->memmap[uart], errp)) {
-            return;
-        }
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
-                           aspeed_soc_ast27x0ssp_get_irq(s, uart));
-    }
+    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias",
+                             &s->uart->serial.io, 0,
+                             memory_region_size(&s->uart->serial.io));
+    memory_region_add_subregion(s->memory, sc->memmap[s->uart_dev],
+                                &s->uart_alias);
+    /*
+     * Redirect the UART interrupt to the NVIC, replacing the default routing
+     * to the PSP's GIC.
+     */
+    sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,
+                       aspeed_soc_ast27x0ssp_get_irq(s, s->uart_dev));
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
                                   "aspeed.timerctrl",
@@ -283,8 +280,6 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
     dc->realize = aspeed_soc_ast27x0ssp_realize;
 
     sc->valid_cpu_types = valid_cpu_types;
-    sc->uarts_num = 13;
-    sc->uarts_base = ASPEED_DEV_UART0;
     sc->irqmap = aspeed_soc_ast27x0ssp_irqmap;
     sc->memmap = aspeed_soc_ast27x0ssp_memmap;
 }
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index a7c141678fc2..5b75e1420639 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -133,16 +133,10 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)
 {
     Aspeed27x0CoprocessorState *a = ASPEED27X0TSP_COPROCESSOR(obj);
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(obj);
-    AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
-    int i;
 
     object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 
-    for (i = 0; i < sc->uarts_num; i++) {
-        object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
-    }
-
     object_initialize_child(obj, "intc0", &a->intc[0],
                             TYPE_ASPEED_2700TSP_INTC);
     object_initialize_child(obj, "intc1", &a->intc[1],
@@ -165,7 +159,6 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
     g_autofree char *sdram_name = NULL;
-    int uart;
     int i;
 
     if (!clock_has_source(s->sysclk)) {
@@ -244,15 +237,19 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[1]), i,
                         qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), i));
     }
+
     /* UART */
-    for (i = 0, uart = sc->uarts_base; i < sc->uarts_num; i++, uart++) {
-        if (!aspeed_soc_uart_realize(s->memory, &s->uart[i],
-                                     sc->memmap[uart], errp)) {
-            return;
-        }
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
-                           aspeed_soc_ast27x0tsp_get_irq(s, uart));
-    }
+    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias",
+                             &s->uart->serial.io, 0,
+                             memory_region_size(&s->uart->serial.io));
+    memory_region_add_subregion(s->memory, sc->memmap[s->uart_dev],
+                                &s->uart_alias);
+    /*
+     * Redirect the UART interrupt to the NVIC, replacing the default routing
+     * to the PSP's GIC.
+     */
+    sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,
+                       aspeed_soc_ast27x0tsp_get_irq(s, s->uart_dev));
 
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
                                   "aspeed.timerctrl",
@@ -283,8 +280,6 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,
     dc->realize = aspeed_soc_ast27x0tsp_realize;
 
     sc->valid_cpu_types = valid_cpu_types;
-    sc->uarts_num = 13;
-    sc->uarts_base = ASPEED_DEV_UART0;
     sc->irqmap = aspeed_soc_ast27x0tsp_irqmap;
     sc->memmap = aspeed_soc_ast27x0tsp_memmap;
 }
diff --git a/hw/arm/aspeed_coprocessor_common.c b/hw/arm/aspeed_coprocessor_common.c
index 14e26bbe234e..f037d5b573fd 100644
--- a/hw/arm/aspeed_coprocessor_common.c
+++ b/hw/arm/aspeed_coprocessor_common.c
@@ -29,6 +29,9 @@ static const Property aspeed_coprocessor_properties[] = {
                      MemoryRegion *),
     DEFINE_PROP_LINK("scu", AspeedCoprocessorState, scu, TYPE_ASPEED_SCU,
                      AspeedSCUState *),
+    DEFINE_PROP_LINK("uart", AspeedCoprocessorState, uart, TYPE_SERIAL_MM,
+                     SerialMM *),
+    DEFINE_PROP_INT32("uart-dev", AspeedCoprocessorState, uart_dev, 0),
 };
 
 static void aspeed_coprocessor_class_init(ObjectClass *oc, const void *data)
-- 
2.51.0


