Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C634CC83F35
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFVh-0003p5-A3; Wed, 16 Jul 2025 23:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUg-0003ST-MQ; Wed, 16 Jul 2025 23:41:14 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUe-0000YT-OO; Wed, 16 Jul 2025 23:41:14 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 11:40:56 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 11:40:56 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 03/21] hw/arm/ast27x0: Move TSP coprocessor initialization
 from machine to SoC leve
Date: Thu, 17 Jul 2025 11:40:31 +0800
Message-ID: <20250717034054.1903991-4-jamin_lin@aspeedtech.com>
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

In the previous design, the TSP coprocessor (aspeed27x0tsp-soc) was initialized
and realized at the machine level (e.g., AST2700FC). To allow proper
integration between coprocessors—such as shared use of SRAM, SCU, and memory
remap configuration—this commit moves TSP initialization into the AST2700 SoC.

By handling TSP initialization and realization at the SoC level, it becomes
easier to manage device ordering and ensure correct dependencies between
coprocessors and controllers. It also reflects the hardware design more
accurately, as these processors belong to the SoC, not the board.

Benefits of this change:
- TSP can share SCU, SRAM, and memory regions with other SoC devices.
- Centralizes coprocessor setup logic under SoC for better maintenance.
- Simplifies machine-level code in "aspeed_ast27x0-fc.c".

This is part of ongoing work to support shared SCU, SRAM, and memory remap
handling across PSP, SSP, and TSP. Future commits will add memory remap
mechanisms and tightly integrated SoC controller coordination.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h | 26 ++++++++++++++------------
 hw/arm/aspeed_ast27x0-fc.c  | 32 ++------------------------------
 hw/arm/aspeed_ast27x0.c     | 28 ++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 2831da91ab..3dd317cfee 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -141,6 +141,19 @@ struct Aspeed27x0SSPSoCState {
 #define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
 OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0SSPSoCState, ASPEED27X0SSP_SOC)
 
+struct Aspeed27x0TSPSoCState {
+    AspeedSoCState parent;
+    AspeedINTCState intc[2];
+    UnimplementedDeviceState ipc[2];
+    UnimplementedDeviceState scuio;
+    MemoryRegion memory;
+
+    ARMv7MState armv7m;
+};
+
+#define TYPE_ASPEED27X0TSP_SOC "aspeed27x0tsp-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0TSPSoCState, ASPEED27X0TSP_SOC)
+
 struct Aspeed27x0SoCState {
     AspeedSoCState parent;
 
@@ -150,6 +163,7 @@ struct Aspeed27x0SoCState {
     MemoryRegion dram_empty;
 
     Aspeed27x0SSPSoCState ssp;
+    Aspeed27x0TSPSoCState tsp;
 };
 
 #define TYPE_ASPEED27X0_SOC "aspeed27x0-soc"
@@ -161,18 +175,6 @@ struct Aspeed10x0SoCState {
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
index c9b338fe78..eb25a2635b 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -37,18 +37,13 @@ struct Ast2700FCState {
     MemoryRegion ca35_memory;
     MemoryRegion ca35_dram;
     MemoryRegion ca35_boot_rom;
-    MemoryRegion tsp_memory;
-
-    Clock *tsp_sysclk;
 
     Aspeed27x0SoCState ca35;
-    Aspeed27x0TSPSoCState tsp;
 
     bool mmio_exec;
 };
 
 #define AST2700FC_BMC_RAM_SIZE (1 * GiB)
-#define AST2700FC_CM4_DRAM_SIZE (32 * MiB)
 
 #define AST2700FC_HW_STRAP1 0x000000C0
 #define AST2700FC_HW_STRAP2 0x00000003
@@ -157,6 +152,8 @@ static void ast2700fc_ca35_init(MachineState *machine)
     aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
     aspeed_soc_uart_set_chr(ASPEED_SOC(&s->ca35.ssp), ASPEED_DEV_UART4,
                             serial_hd(1));
+    aspeed_soc_uart_set_chr(ASPEED_SOC(&s->ca35.tsp), ASPEED_DEV_UART7,
+                            serial_hd(2));
     if (!qdev_realize(DEVICE(&s->ca35), NULL, &error_abort)) {
         return;
     }
@@ -195,34 +192,9 @@ static void ast2700fc_ca35_init(MachineState *machine)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
 }
 
-static void ast2700fc_tsp_init(MachineState *machine)
-{
-    AspeedSoCState *soc;
-    Ast2700FCState *s = AST2700A1FC(machine);
-    s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
-    clock_set_hz(s->tsp_sysclk, 200000000ULL);
-
-    object_initialize_child(OBJECT(s), "tsp", &s->tsp, TYPE_ASPEED27X0TSP_SOC);
-    memory_region_init(&s->tsp_memory, OBJECT(&s->tsp), "tsp-memory",
-                       UINT64_MAX);
-
-    qdev_connect_clock_in(DEVICE(&s->tsp), "sysclk", s->tsp_sysclk);
-    if (!object_property_set_link(OBJECT(&s->tsp), "memory",
-                                  OBJECT(&s->tsp_memory), &error_abort)) {
-        return;
-    }
-
-    soc = ASPEED_SOC(&s->tsp);
-    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART7, serial_hd(2));
-    if (!qdev_realize(DEVICE(&s->tsp), NULL, &error_abort)) {
-        return;
-    }
-}
-
 static void ast2700fc_init(MachineState *machine)
 {
     ast2700fc_ca35_init(machine);
-    ast2700fc_tsp_init(machine);
 }
 
 static void ast2700fc_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index ffbc32fef2..665627f788 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -433,6 +433,7 @@ static void aspeed_soc_ast2700_init(Object *obj)
     /* Coprocessors */
     if (mc->default_cpus > sc->num_cpus) {
         object_initialize_child(obj, "ssp", &a->ssp, TYPE_ASPEED27X0SSP_SOC);
+        object_initialize_child(obj, "tsp", &a->tsp, TYPE_ASPEED27X0TSP_SOC);
     }
 
     object_initialize_child(obj, "gic", &a->gic, gicv3_class_name());
@@ -643,6 +644,30 @@ static bool aspeed_soc_ast2700_ssp_realize(DeviceState *dev, Error **errp)
     return true;
 }
 
+static bool aspeed_soc_ast2700_tsp_realize(DeviceState *dev, Error **errp)
+{
+    Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
+    AspeedSoCState *s = ASPEED_SOC(dev);
+    Clock *sysclk;
+
+    sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
+    clock_set_hz(sysclk, 200000000ULL);
+    qdev_connect_clock_in(DEVICE(&a->tsp), "sysclk", sysclk);
+
+    memory_region_init(&a->tsp.memory, OBJECT(&a->tsp), "tsp-memory",
+                       UINT64_MAX);
+    if (!object_property_set_link(OBJECT(&a->tsp), "memory",
+                                  OBJECT(&a->tsp.memory), &error_abort)) {
+        return false;
+    }
+
+    if (!qdev_realize(DEVICE(&a->tsp), NULL, &error_abort)) {
+        return false;
+    }
+
+    return true;
+}
+
 static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
 {
     int i;
@@ -759,6 +784,9 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         if (!aspeed_soc_ast2700_ssp_realize(dev, errp)) {
             return;
         }
+        if (!aspeed_soc_ast2700_tsp_realize(dev, errp)) {
+            return;
+        }
     }
 
     /* UART */
-- 
2.43.0


