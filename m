Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD51C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFWJ-0004eD-B7; Wed, 16 Jul 2025 23:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUd-0003PY-Ru; Wed, 16 Jul 2025 23:41:12 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUb-0000YT-KS; Wed, 16 Jul 2025 23:41:11 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 11:40:55 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 11:40:55 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 02/21] hw/arm/ast27x0: Move SSP coprocessor initialization
 from machine to SoC leve
Date: Thu, 17 Jul 2025 11:40:30 +0800
Message-ID: <20250717034054.1903991-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
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

In the previous design, the SSP coprocessor (aspeed27x0ssp-soc) was initialized
and realized at the machine level (e.g., AST2700FC). However, to make sure the
coprocessors can work together properly—such as using the same SRAM, sharing
the SCU, and having consistent memory remapping—we need to change how these
devices are set up.

This commit moves the SSP coprocessor initialization and realization into the
AST2700 SoC (aspeed_soc_ast2700_init() and aspeed_soc_ast2700_realize()).
By doing so, the SSP becomes a proper child of the SoC device, rather than
the machine.

This is a preparation step for future commits that will support shared SCU,
SRAM, and memory remap logic—specifically enabling PSP DRAM remap for SSP SDRAM
access.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h | 27 +++++++++++++-----------
 hw/arm/aspeed_ast27x0-fc.c  | 30 ++------------------------
 hw/arm/aspeed_ast27x0.c     | 42 +++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 40 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 217ef0eafd..2831da91ab 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -128,6 +128,19 @@ struct Aspeed2600SoCState {
 #define TYPE_ASPEED2600_SOC "aspeed2600-soc"
 OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2600SoCState, ASPEED2600_SOC)
 
+struct Aspeed27x0SSPSoCState {
+    AspeedSoCState parent;
+    AspeedINTCState intc[2];
+    UnimplementedDeviceState ipc[2];
+    UnimplementedDeviceState scuio;
+    MemoryRegion memory;
+
+    ARMv7MState armv7m;
+};
+
+#define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0SSPSoCState, ASPEED27X0SSP_SOC)
+
 struct Aspeed27x0SoCState {
     AspeedSoCState parent;
 
@@ -135,6 +148,8 @@ struct Aspeed27x0SoCState {
     AspeedINTCState intc[2];
     GICv3State gic;
     MemoryRegion dram_empty;
+
+    Aspeed27x0SSPSoCState ssp;
 };
 
 #define TYPE_ASPEED27X0_SOC "aspeed27x0-soc"
@@ -146,18 +161,6 @@ struct Aspeed10x0SoCState {
     ARMv7MState armv7m;
 };
 
-struct Aspeed27x0SSPSoCState {
-    AspeedSoCState parent;
-    AspeedINTCState intc[2];
-    UnimplementedDeviceState ipc[2];
-    UnimplementedDeviceState scuio;
-
-    ARMv7MState armv7m;
-};
-
-#define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
-OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0SSPSoCState, ASPEED27X0SSP_SOC)
-
 struct Aspeed27x0TSPSoCState {
     AspeedSoCState parent;
     AspeedINTCState intc[2];
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index e2eee6183f..c9b338fe78 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -37,14 +37,11 @@ struct Ast2700FCState {
     MemoryRegion ca35_memory;
     MemoryRegion ca35_dram;
     MemoryRegion ca35_boot_rom;
-    MemoryRegion ssp_memory;
     MemoryRegion tsp_memory;
 
-    Clock *ssp_sysclk;
     Clock *tsp_sysclk;
 
     Aspeed27x0SoCState ca35;
-    Aspeed27x0SSPSoCState ssp;
     Aspeed27x0TSPSoCState tsp;
 
     bool mmio_exec;
@@ -158,6 +155,8 @@ static void ast2700fc_ca35_init(MachineState *machine)
         return;
     }
     aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
+    aspeed_soc_uart_set_chr(ASPEED_SOC(&s->ca35.ssp), ASPEED_DEV_UART4,
+                            serial_hd(1));
     if (!qdev_realize(DEVICE(&s->ca35), NULL, &error_abort)) {
         return;
     }
@@ -196,30 +195,6 @@ static void ast2700fc_ca35_init(MachineState *machine)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
 }
 
-static void ast2700fc_ssp_init(MachineState *machine)
-{
-    AspeedSoCState *soc;
-    Ast2700FCState *s = AST2700A1FC(machine);
-    s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
-    clock_set_hz(s->ssp_sysclk, 200000000ULL);
-
-    object_initialize_child(OBJECT(s), "ssp", &s->ssp, TYPE_ASPEED27X0SSP_SOC);
-    memory_region_init(&s->ssp_memory, OBJECT(&s->ssp), "ssp-memory",
-                       UINT64_MAX);
-
-    qdev_connect_clock_in(DEVICE(&s->ssp), "sysclk", s->ssp_sysclk);
-    if (!object_property_set_link(OBJECT(&s->ssp), "memory",
-                                  OBJECT(&s->ssp_memory), &error_abort)) {
-        return;
-    }
-
-    soc = ASPEED_SOC(&s->ssp);
-    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(1));
-    if (!qdev_realize(DEVICE(&s->ssp), NULL, &error_abort)) {
-        return;
-    }
-}
-
 static void ast2700fc_tsp_init(MachineState *machine)
 {
     AspeedSoCState *soc;
@@ -247,7 +222,6 @@ static void ast2700fc_tsp_init(MachineState *machine)
 static void ast2700fc_init(MachineState *machine)
 {
     ast2700fc_ca35_init(machine);
-    ast2700fc_ssp_init(machine);
     ast2700fc_tsp_init(machine);
 }
 
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 6aa3841b69..ffbc32fef2 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -22,6 +22,8 @@
 #include "hw/intc/arm_gicv3.h"
 #include "qobject/qlist.h"
 #include "qemu/log.h"
+#include "hw/qdev-clock.h"
+#include "hw/boards.h"
 
 #define AST2700_SOC_IO_SIZE          0x00FE0000
 #define AST2700_SOC_IOMEM_SIZE       0x01000000
@@ -410,6 +412,8 @@ static bool aspeed_soc_ast2700_dram_init(DeviceState *dev, Error **errp)
 
 static void aspeed_soc_ast2700_init(Object *obj)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(obj);
     AspeedSoCState *s = ASPEED_SOC(obj);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
@@ -426,6 +430,11 @@ static void aspeed_soc_ast2700_init(Object *obj)
                                 aspeed_soc_cpu_type(sc));
     }
 
+    /* Coprocessors */
+    if (mc->default_cpus > sc->num_cpus) {
+        object_initialize_child(obj, "ssp", &a->ssp, TYPE_ASPEED27X0SSP_SOC);
+    }
+
     object_initialize_child(obj, "gic", &a->gic, gicv3_class_name());
 
     object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);
@@ -610,9 +619,35 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
     return true;
 }
 
+static bool aspeed_soc_ast2700_ssp_realize(DeviceState *dev, Error **errp)
+{
+    Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
+    AspeedSoCState *s = ASPEED_SOC(dev);
+    Clock *sysclk;
+
+    sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
+    clock_set_hz(sysclk, 200000000ULL);
+    qdev_connect_clock_in(DEVICE(&a->ssp), "sysclk", sysclk);
+
+    memory_region_init(&a->ssp.memory, OBJECT(&a->ssp), "ssp-memory",
+                       UINT64_MAX);
+    if (!object_property_set_link(OBJECT(&a->ssp), "memory",
+                                  OBJECT(&a->ssp.memory), &error_abort)) {
+        return false;
+    }
+
+    if (!qdev_realize(DEVICE(&a->ssp), NULL, &error_abort)) {
+        return false;
+    }
+
+    return true;
+}
+
 static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
 {
     int i;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
@@ -719,6 +754,13 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scuio), 0,
                     sc->memmap[ASPEED_DEV_SCUIO]);
 
+    /* Coprocessors */
+    if (mc->default_cpus > sc->num_cpus) {
+        if (!aspeed_soc_ast2700_ssp_realize(dev, errp)) {
+            return;
+        }
+    }
+
     /* UART */
     if (!aspeed_soc_uart_realize(s, errp)) {
         return;
-- 
2.43.0


