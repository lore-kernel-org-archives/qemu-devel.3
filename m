Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01436CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 06:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8uus-0001An-JV; Wed, 15 Oct 2025 02:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8uuj-00014H-DG; Wed, 15 Oct 2025 02:23:12 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8uuf-0002xW-Oi; Wed, 15 Oct 2025 02:23:09 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 15 Oct
 2025 14:22:12 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 15 Oct 2025 14:22:12 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 05/12] hw/arm/ast27x0: Share single SCU instance across PSP, SSP,
 and TSP
Date: Wed, 15 Oct 2025 14:22:00 +0800
Message-ID: <20251015062210.3128710-6-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
References: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

AST2700 has a single SCU hardware block, memory-mapped at
0x12C02000–0x12C03FFF from the perspective of the main CA35 processor (PSP).
The SSP and TSP coprocessors access this same SCU block at different
addresses: 0x72C02000–0x72C03FFF.

Previously, each subsystem (PSP, SSP, and TSP) instantiated its own SCU
device, resulting in three independent SCU instances in the QEMU model.
In real hardware, however, only a single SCU exists and is shared among
all processors.

This commit reworks the SCU model to correctly reflect the hardware
behavior by allowing SSP and TSP to reference the PSP’s SCU instance.
The following changes are introduced:

- Add a scu property to AspeedCoprocessorState for linking the
  coprocessor to the PSP’s SCU instance.
- Replace per-coprocessor SCU instantiation with a shared SCU link.
- Add "MemoryRegion scu_alias" to model address remapping for SSP and TSP.
- Create SCU alias regions in both SSP and TSP coprocessors and map
  them at 0x72C02000 to mirror the PSP’s SCU registers.
- Ensure the SCU device in PSP is realized before SSP/TSP alias setup.

With this change, PSP, SSP, and TSP now share a consistent SCU state,
matching the single-SCU hardware design of AST2700.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_coprocessor.h |  4 ++--
 hw/arm/aspeed_ast27x0-fc.c          |  4 ++++
 hw/arm/aspeed_ast27x0-ssp.c         | 13 +++++--------
 hw/arm/aspeed_ast27x0-tsp.c         | 13 +++++--------
 hw/arm/aspeed_coprocessor_common.c  |  2 ++
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index d9a5f517d7..c1f2c549c3 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -19,9 +19,10 @@ struct AspeedCoprocessorState {
     MemoryRegion sdram;
     MemoryRegion *sram;
     MemoryRegion sram_alias;
+    MemoryRegion scu_alias;
     Clock *sysclk;
 
-    AspeedSCUState scu;
+    AspeedSCUState *scu;
     AspeedSCUState scuio;
     AspeedTimerCtrlState timerctrl;
     SerialMM uart[ASPEED_UARTS_NUM];
@@ -36,7 +37,6 @@ struct AspeedCoprocessorClass {
 
     /** valid_cpu_types: NULL terminated array of a single CPU type. */
     const char * const *valid_cpu_types;
-    uint32_t silicon_rev;
     const hwaddr *memmap;
     const int *irqmap;
     int uarts_base;
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index dfac7d1e17..ba43a46207 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -138,6 +138,8 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
                             sc->uarts_num, serial_hd(1));
     object_property_set_link(OBJECT(&s->ssp), "sram",
                              OBJECT(&psp->sram), &error_abort);
+    object_property_set_link(OBJECT(&s->ssp), "scu",
+                             OBJECT(&psp->scu), &error_abort);
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
         return false;
     }
@@ -170,6 +172,8 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
                             sc->uarts_num, serial_hd(2));
     object_property_set_link(OBJECT(&s->tsp), "sram",
                              OBJECT(&psp->sram), &error_abort);
+    object_property_set_link(OBJECT(&s->tsp), "scu",
+                             OBJECT(&psp->scu), &error_abort);
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
         return false;
     }
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 66c4ef6d1b..577a3379c6 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -137,9 +137,7 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)
     int i;
 
     object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
-    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
-    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
 
     for (i = 0; i < sc->uarts_num; i++) {
         object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
@@ -203,11 +201,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
                                 &s->sram_alias);
 
     /* SCU */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
-        return;
-    }
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
-                    sc->memmap[ASPEED_DEV_SCU]);
+    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",
+                             &s->scu->iomem, 0,
+                             memory_region_size(&s->scu->iomem));
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
+                                &s->scu_alias);
 
     /* INTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
@@ -285,7 +283,6 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
     dc->realize = aspeed_soc_ast27x0ssp_realize;
 
     sc->valid_cpu_types = valid_cpu_types;
-    sc->silicon_rev = AST2700_A1_SILICON_REV;
     sc->uarts_num = 13;
     sc->uarts_base = ASPEED_DEV_UART0;
     sc->irqmap = aspeed_soc_ast27x0ssp_irqmap;
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 56b68adf54..a7c141678f 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -137,9 +137,7 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)
     int i;
 
     object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
-    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
-    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
 
     for (i = 0; i < sc->uarts_num; i++) {
         object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
@@ -203,11 +201,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
                                 &s->sram_alias);
 
     /* SCU */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
-        return;
-    }
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
-                    sc->memmap[ASPEED_DEV_SCU]);
+    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",
+                             &s->scu->iomem, 0,
+                             memory_region_size(&s->scu->iomem));
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
+                                &s->scu_alias);
 
     /* INTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
@@ -285,7 +283,6 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,
     dc->realize = aspeed_soc_ast27x0tsp_realize;
 
     sc->valid_cpu_types = valid_cpu_types;
-    sc->silicon_rev = AST2700_A1_SILICON_REV;
     sc->uarts_num = 13;
     sc->uarts_base = ASPEED_DEV_UART0;
     sc->irqmap = aspeed_soc_ast27x0tsp_irqmap;
diff --git a/hw/arm/aspeed_coprocessor_common.c b/hw/arm/aspeed_coprocessor_common.c
index 8322ad5eb5..14e26bbe23 100644
--- a/hw/arm/aspeed_coprocessor_common.c
+++ b/hw/arm/aspeed_coprocessor_common.c
@@ -27,6 +27,8 @@ static const Property aspeed_coprocessor_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_LINK("sram", AspeedCoprocessorState, sram, TYPE_MEMORY_REGION,
                      MemoryRegion *),
+    DEFINE_PROP_LINK("scu", AspeedCoprocessorState, scu, TYPE_ASPEED_SCU,
+                     AspeedSCUState *),
 };
 
 static void aspeed_coprocessor_class_init(ObjectClass *oc, const void *data)
-- 
2.43.0


