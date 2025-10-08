Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00279CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 03:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6KlU-0001vR-BL; Tue, 07 Oct 2025 23:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6KlQ-0001uh-99; Tue, 07 Oct 2025 23:22:52 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6KlO-0000T8-9b; Tue, 07 Oct 2025 23:22:51 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 8 Oct
 2025 11:22:12 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 8 Oct 2025 11:22:12 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 11/16] hw/arm/aspeed_ast27x0-tsp: Make AST27x0 TSP inherit
 from AspeedCoprocessor instead of AspeedSoC
Date: Wed, 8 Oct 2025 11:21:56 +0800
Message-ID: <20251008032207.593353-12-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008032207.593353-1-jamin_lin@aspeedtech.com>
References: <20251008032207.593353-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Refactor the AST27x0 TSP implementation to derive from the newly introduced
AspeedCoprocessor base class rather than AspeedSoC. The AspeedSoC class
includes SoC-level infrastructure and peripheral definitions that are not
applicable to lightweight coprocessor subsystems such as TSP, resulting in
unnecessary coupling and complexity.

This change moves the Aspeed27x0TSPSoCState structure definition into
aspeed_coprocessor.h and updates all related references in
aspeed_ast27x0-tsp.c and aspeed_ast27x0-fc.c to use
AspeedCoprocessorState and AspeedCoprocessorClass.

Key updates include:

- Replace inheritance from AspeedSoC -> AspeedCoprocessor.
- Update type casts and macros from ASPEED_SOC_* to ASPEED_COPROCESSOR_*

This refactor improves modularity, reduces memory footprint, and prepares
for future coprocessor variants to share a lighter-weight common base.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_coprocessor.h | 12 ++++++++++++
 include/hw/arm/aspeed_soc.h         | 12 ------------
 hw/arm/aspeed_ast27x0-fc.c          |  8 ++++----
 hw/arm/aspeed_ast27x0-tsp.c         | 29 ++++++++++++-----------------
 4 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index 927e8675b0..2c10327456 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -54,4 +54,16 @@ struct Aspeed27x0SSPSoCState {
 #define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
 OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0SSPSoCState, ASPEED27X0SSP_SOC)
 
+struct Aspeed27x0TSPSoCState {
+    AspeedCoprocessorState parent;
+    AspeedINTCState intc[2];
+    UnimplementedDeviceState ipc[2];
+    UnimplementedDeviceState scuio;
+
+    ARMv7MState armv7m;
+};
+
+#define TYPE_ASPEED27X0TSP_SOC "aspeed27x0tsp-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0TSPSoCState, ASPEED27X0TSP_SOC)
+
 #endif /* ASPEED_COPROCESSOR_H */
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index b100a404f1..b6485f3d9c 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -153,18 +153,6 @@ struct Aspeed10x0SoCState {
     ARMv7MState armv7m;
 };
 
-struct Aspeed27x0TSPSoCState {
-    AspeedSoCState parent;
-    AspeedINTCState intc[2];
-    UnimplementedDeviceState ipc[2];
-    UnimplementedDeviceState scuio;
-
-    ARMv7MState armv7m;
-};
-
-#define TYPE_ASPEED27X0TSP_SOC "aspeed27x0tsp-soc"
-OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0TSPSoCState, ASPEED27X0TSP_SOC)
-
 #define TYPE_ASPEED10X0_SOC "aspeed10x0-soc"
 OBJECT_DECLARE_SIMPLE_TYPE(Aspeed10x0SoCState, ASPEED10X0_SOC)
 
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 4315e8da98..b34cd54e4e 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -142,8 +142,8 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
 
 static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
 {
-    AspeedSoCState *soc;
-    AspeedSoCClass *sc;
+    AspeedCoprocessorState *soc;
+    AspeedCoprocessorClass *sc;
     Ast2700FCState *s = AST2700A1FC(machine);
     s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
     clock_set_hz(s->tsp_sysclk, 200000000ULL);
@@ -156,8 +156,8 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
     object_property_set_link(OBJECT(&s->tsp), "memory",
                              OBJECT(&s->tsp_memory), &error_abort);
 
-    soc = ASPEED_SOC(&s->tsp);
-    sc = ASPEED_SOC_GET_CLASS(soc);
+    soc = ASPEED_COPROCESSOR(&s->tsp);
+    sc = ASPEED_COPROCESSOR_GET_CLASS(soc);
     aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART7, sc->uarts_base,
                             sc->uarts_num, serial_hd(2));
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 28376b3338..8b13ab526d 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -14,6 +14,7 @@
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
+#include "hw/arm/aspeed_coprocessor.h"
 
 #define AST2700_TSP_RAM_SIZE (32 * MiB)
 
@@ -106,9 +107,9 @@ static struct nvic_intc_irq_info ast2700_tsp_intcmap[] = {
 
 static qemu_irq aspeed_soc_ast27x0tsp_get_irq(void *ctx, int dev)
 {
-    AspeedSoCState *s = (AspeedSoCState *)ctx;
+    AspeedCoprocessorState *s = (AspeedCoprocessorState *)ctx;
     Aspeed27x0TSPSoCState *a = ASPEED27X0TSP_SOC(s);
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
 
     int or_idx;
     int idx;
@@ -130,8 +131,8 @@ static qemu_irq aspeed_soc_ast27x0tsp_get_irq(void *ctx, int dev)
 static void aspeed_soc_ast27x0tsp_init(Object *obj)
 {
     Aspeed27x0TSPSoCState *a = ASPEED27X0TSP_SOC(obj);
-    AspeedSoCState *s = ASPEED_SOC(obj);
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    AspeedCoprocessorState *s = ASPEED_COPROCESSOR(obj);
+    AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     int i;
 
     object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
@@ -161,8 +162,8 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)
 static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
 {
     Aspeed27x0TSPSoCState *a = ASPEED27X0TSP_SOC(dev_soc);
-    AspeedSoCState *s = ASPEED_SOC(dev_soc);
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
+    AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
     g_autofree char *sram_name = NULL;
     int uart;
@@ -186,8 +187,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     sram_name = g_strdup_printf("aspeed.dram.%d",
                                 CPU(a->armv7m.cpu)->cpu_index);
 
-    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size,
-                                errp)) {
+    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name,
+                                AST2700_TSP_RAM_SIZE, errp)) {
         return;
     }
     memory_region_add_subregion(s->memory,
@@ -269,31 +270,25 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass, const void *dat
         NULL
     };
     DeviceClass *dc = DEVICE_CLASS(klass);
-    AspeedSoCClass *sc = ASPEED_SOC_CLASS(dc);
+    AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_CLASS(dc);
 
-    /* Reason: The Aspeed SoC can only be instantiated from a board */
+    /* Reason: The Aspeed Coprocessor can only be instantiated from a board */
     dc->user_creatable = false;
     dc->realize = aspeed_soc_ast27x0tsp_realize;
 
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev = AST2700_A1_SILICON_REV;
-    sc->sram_size = AST2700_TSP_RAM_SIZE;
-    sc->spis_num = 0;
-    sc->ehcis_num = 0;
-    sc->wdts_num = 0;
-    sc->macs_num = 0;
     sc->uarts_num = 13;
     sc->uarts_base = ASPEED_DEV_UART0;
     sc->irqmap = aspeed_soc_ast27x0tsp_irqmap;
     sc->memmap = aspeed_soc_ast27x0tsp_memmap;
-    sc->num_cpus = 1;
     sc->get_irq = aspeed_soc_ast27x0tsp_get_irq;
 }
 
 static const TypeInfo aspeed_soc_ast27x0tsp_types[] = {
     {
         .name           = TYPE_ASPEED27X0TSP_SOC,
-        .parent         = TYPE_ASPEED_SOC,
+        .parent         = TYPE_ASPEED_COPROCESSOR,
         .instance_size  = sizeof(Aspeed27x0TSPSoCState),
         .instance_init  = aspeed_soc_ast27x0tsp_init,
         .class_init     = aspeed_soc_ast27x0tsp_class_init,
-- 
2.43.0


