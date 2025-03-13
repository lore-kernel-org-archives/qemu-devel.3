Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEFAC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 05:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsbOu-00056a-OY; Thu, 13 Mar 2025 01:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tsbOb-0004t0-6g; Thu, 13 Mar 2025 01:46:17 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tsbOZ-0005Ve-Cb; Thu, 13 Mar 2025 01:46:16 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 13 Mar
 2025 13:40:24 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 13 Mar 2025 13:40:24 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <yunlin.tang@aspeedtech.com>
Subject: [PATCH 10/13] hw/arm: Introduce ASPEED AST2700 a1 full core machine
Date: Thu, 13 Mar 2025 13:40:14 +0800
Message-ID: <20250313054020.2583556-11-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313054020.2583556-1-steven_lee@aspeedtech.com>
References: <20250313054020.2583556-1-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=steven_lee@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Steven Lee <steven_lee@aspeedtech.com>
From:  Steven Lee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

- Added new machine type `ast2700fc-a1` with full core support.
- Defined `Ast2700a1FCState` structure for the new machine type.
- Implemented initialization functions for CA35, SSP, and TSP components.
- Updated `ast2700fc_types` to include the new machine type.
- Set machine class properties for `ast2700fc-a1`.
- Add alias `ast2700fc` for a1 machine.

Test Step:
- Download ast2700-default-obmc.tar.gz from AspeedTech-BMC OpenBmc
  release page.
- Run the following QEMU command:

  ```
  IMGDIR=~/path/to/image
  UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)

  ./qemu-system-aarch64 -machine ast2700fc \
  -device loader,force-raw=on,addr=0x400000000,file=${IMGDIR}/u-boot-nodtb.bin \
  -device loader,force-raw=on,addr=$((0x400000000 + ${UBOOT_SIZE})),file=${IMGDIR}/u-boot.dtb \
  -device loader,force-raw=on,addr=0x430000000,file=${IMGDIR}/bl31.bin \
  -device loader,force-raw=on,addr=0x430080000,file=${IMGDIR}/tee-raw.bin \
  -device loader,cpu-num=0,addr=0x430000000 \
  -device loader,cpu-num=1,addr=0x430000000 \
  -device loader,cpu-num=2,addr=0x430000000 \
  -device loader,cpu-num=3,addr=0x430000000 \
  -device loader,file=${IMGDIR}/ast2700-ssp.elf,cpu-num=4 \
  -device loader,file=${IMGDIR}/ast2700-tsp.elf,cpu-num=5 \
  -drive file=${IMGDIR}/image-bmc,if=mtd,format=raw \
  -serial pty -serial pty -serial pty \
  -snapshot \
  -S -nographic
  ```

- After starting QEMU, serial devices will be redirected:

  char device redirected to /dev/pts/51 (label serial0)
  char device redirected to /dev/pts/52 (label serial1)
  char device redirected to /dev/pts/53 (label serial2)

- serial0 is the console for the four Cortex-A35 primary processors,
  serial1 and serial2 are the consoles for the two Cortex-M4 coprocessors.

- Connect to the consoles using a terminal emulator.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
Change-Id: I1e7645a4689859fdd41be2a734909975ba04a1f9
---
 hw/arm/aspeed_ast27x0-fc.c | 150 +++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index d03a1b5f1e..1c4895e9d1 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -25,6 +25,8 @@
 
 #define TYPE_AST2700A0FC MACHINE_TYPE_NAME("ast2700fc-a0")
 OBJECT_DECLARE_SIMPLE_TYPE(Ast2700a0FCState, AST2700A0FC);
+#define TYPE_AST2700A1FC MACHINE_TYPE_NAME("ast2700fc-a1")
+OBJECT_DECLARE_SIMPLE_TYPE(Ast2700a1FCState, AST2700A1FC);
 
 static struct arm_boot_info ast2700fc_board_info = {
     .board_id = -1, /* device-tree-only board */
@@ -48,6 +50,24 @@ struct Ast2700a0FCState {
     bool mmio_exec;
 };
 
+struct Ast2700a1FCState {
+    MachineState parent_obj;
+
+    MemoryRegion ca35_memory;
+    MemoryRegion ca35_dram;
+    MemoryRegion ssp_memory;
+    MemoryRegion tsp_memory;
+
+    Clock *ssp_sysclk;
+    Clock *tsp_sysclk;
+
+    Aspeed27x0SoCState ca35;
+    Aspeed27x0SSPSoCState ssp;
+    Aspeed27x0TSPSoCState tsp;
+
+    bool mmio_exec;
+};
+
 #define AST2700FC_BMC_RAM_SIZE (2 * GiB)
 #define AST2700FC_CM4_DRAM_SIZE (32 * MiB)
 
@@ -112,6 +132,63 @@ static void ast2700a0fc_ca35_init(MachineState *machine)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
 }
 
+static void ast2700a1fc_ca35_init(MachineState *machine)
+{
+    Ast2700a1FCState *s = AST2700A1FC(machine);
+    AspeedSoCState *soc;
+    AspeedSoCClass *sc;
+
+    object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a1");
+    soc = ASPEED_SOC(&s->ca35);
+    sc = ASPEED_SOC_GET_CLASS(soc);
+
+    memory_region_init(&s->ca35_memory, OBJECT(&s->ca35), "ca35-memory",
+                       UINT64_MAX);
+
+    if (!memory_region_init_ram(&s->ca35_dram, OBJECT(&s->ca35), "ca35-dram",
+                                AST2700FC_BMC_RAM_SIZE, &error_abort)) {
+        return;
+    }
+    if (!object_property_set_link(OBJECT(&s->ca35), "memory",
+                                  OBJECT(&s->ca35_memory),
+                                  &error_abort)) {
+        return;
+    };
+    if (!object_property_set_link(OBJECT(&s->ca35), "dram",
+                                  OBJECT(&s->ca35_dram), &error_abort)) {
+        return;
+    }
+    if (!object_property_set_int(OBJECT(&s->ca35), "ram-size",
+                                 AST2700FC_BMC_RAM_SIZE, &error_abort)) {
+        return;
+    }
+    if (!object_property_set_int(OBJECT(&s->ca35), "hw-strap1",
+                                 AST2700FC_HW_STRAP1, &error_abort)) {
+        return;
+    }
+    if (!object_property_set_int(OBJECT(&s->ca35), "hw-strap2",
+                                 AST2700FC_HW_STRAP2, &error_abort)) {
+        return;
+    }
+    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
+    if (!qdev_realize(DEVICE(&s->ca35), NULL, &error_abort)) {
+        return;
+    }
+
+    /*
+     * AST2700 EVB has a LM75 temperature sensor on I2C bus 0 at address 0x4d.
+     */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "tmp105", 0x4d);
+
+    aspeed_board_init_flashes(&soc->fmc, AST2700FC_FMC_MODEL, 2, 0);
+    aspeed_board_init_flashes(&soc->spi[0], AST2700FC_SPI_MODEL, 1, 2);
+
+    ast2700fc_board_info.ram_size = machine->ram_size;
+    ast2700fc_board_info.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
+
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
+}
+
 static void ast2700a0fc_ssp_init(MachineState *machine)
 {
     AspeedSoCState *soc;
@@ -136,6 +213,30 @@ static void ast2700a0fc_ssp_init(MachineState *machine)
     }
 }
 
+static void ast2700a1fc_ssp_init(MachineState *machine)
+{
+    AspeedSoCState *soc;
+    Ast2700a1FCState *s = AST2700A1FC(machine);
+    s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
+    clock_set_hz(s->ssp_sysclk, 200000000ULL);
+
+    object_initialize_child(OBJECT(s), "ssp", &s->ssp, "ast2700ssp-a1");
+    memory_region_init(&s->ssp_memory, OBJECT(&s->ssp), "ssp-memory",
+                       UINT64_MAX);
+
+    qdev_connect_clock_in(DEVICE(&s->ssp), "sysclk", s->ssp_sysclk);
+    if (!object_property_set_link(OBJECT(&s->ssp), "memory",
+                                  OBJECT(&s->ssp_memory), &error_abort)) {
+        return;
+    }
+
+    soc = ASPEED_SOC(&s->ssp);
+    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(1));
+    if (!qdev_realize(DEVICE(&s->ssp), NULL, &error_abort)) {
+        return;
+    }
+}
+
 static void ast2700a0fc_tsp_init(MachineState *machine)
 {
     AspeedSoCState *soc;
@@ -160,6 +261,30 @@ static void ast2700a0fc_tsp_init(MachineState *machine)
     }
 }
 
+static void ast2700a1fc_tsp_init(MachineState *machine)
+{
+    AspeedSoCState *soc;
+    Ast2700a1FCState *s = AST2700A1FC(machine);
+    s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
+    clock_set_hz(s->tsp_sysclk, 200000000ULL);
+
+    object_initialize_child(OBJECT(s), "tsp", &s->tsp, "ast2700tsp-a1");
+    memory_region_init(&s->tsp_memory, OBJECT(&s->tsp), "tsp-memory",
+                       UINT64_MAX);
+
+    qdev_connect_clock_in(DEVICE(&s->tsp), "sysclk", s->tsp_sysclk);
+    if (!object_property_set_link(OBJECT(&s->tsp), "memory",
+                                  OBJECT(&s->tsp_memory), &error_abort)) {
+        return;
+    }
+
+    soc = ASPEED_SOC(&s->tsp);
+    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART7, serial_hd(2));
+    if (!qdev_realize(DEVICE(&s->tsp), NULL, &error_abort)) {
+        return;
+    }
+}
+
 static void ast2700a0fc_init(MachineState *machine)
 {
     ast2700a0fc_ca35_init(machine);
@@ -167,6 +292,13 @@ static void ast2700a0fc_init(MachineState *machine)
     ast2700a0fc_tsp_init(machine);
 }
 
+static void ast2700a1fc_init(MachineState *machine)
+{
+    ast2700a1fc_ca35_init(machine);
+    ast2700a1fc_ssp_init(machine);
+    ast2700a1fc_tsp_init(machine);
+}
+
 static void ast2700a0fc_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -178,6 +310,18 @@ static void ast2700a0fc_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = mc->max_cpus = mc->default_cpus = 6;
 }
 
+static void ast2700a1fc_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->alias = "ast2700fc";
+    mc->desc = "ast2700-a1 full core support";
+    mc->init = ast2700a1fc_init;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->min_cpus = mc->max_cpus = mc->default_cpus = 6;
+}
+
 static const TypeInfo ast2700fc_types[] = {
     {
         .name           = MACHINE_TYPE_NAME("ast2700fc-a0"),
@@ -185,6 +329,12 @@ static const TypeInfo ast2700fc_types[] = {
         .class_init     = ast2700a0fc_class_init,
         .instance_size  = sizeof(Ast2700a0FCState),
     },
+    {
+        .name           = MACHINE_TYPE_NAME("ast2700fc-a1"),
+        .parent         = TYPE_MACHINE,
+        .class_init     = ast2700a1fc_class_init,
+        .instance_size  = sizeof(Ast2700a1FCState),
+    },
 };
 
 DEFINE_TYPES(ast2700fc_types)
-- 
2.34.1


