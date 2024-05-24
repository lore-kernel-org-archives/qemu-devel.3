Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01641C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 12:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sATj9-0002ll-RC; Fri, 24 May 2024 08:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATj7-0002ki-Bs; Fri, 24 May 2024 08:08:49 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATj4-0006ZR-Jo; Fri, 24 May 2024 08:08:49 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATj0-000J16-0T; Fri, 24 May 2024 14:08:42 +0200
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sATj0-000C70-2k; Fri, 24 May 2024 14:08:42 +0200
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id BB3314801F5;
 Fri, 24 May 2024 14:08:41 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id uYhxV0xiVvZG; Fri, 24 May 2024 14:08:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 530C14800E9;
 Fri, 24 May 2024 14:08:41 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id xN--LMYVylgN; Fri, 24 May 2024 14:08:41 +0200 (CEST)
Received: from zimbra.eb.localhost (unknown [192.168.96.242])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id 1EBCF4801E3;
 Fri, 24 May 2024 14:08:41 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/2] hw/arm/xilinx_zynq: Support up to two CPU cores
Date: Fri, 24 May 2024 14:08:37 +0200
Message-Id: <20240524120837.10057-3-sebastian.huber@embedded-brains.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240524120837.10057-1-sebastian.huber@embedded-brains.de>
References: <20240524120837.10057-1-sebastian.huber@embedded-brains.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.3/27285/Fri May 24 10:30:55 2024)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Zynq 7000 SoCs contain two Arm Cortex-A9 MPCore (the Zynq 7000S have =
only
one core).  Add support for up to two simulated cores.

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
---
 hw/arm/xilinx_zynq.c | 54 +++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 0abb62f131..ac30026040 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -84,9 +84,12 @@ static const int dma_irqs[8] =3D {
     0xe3401000 + ARMV7_IMM16(extract32((val), 16, 16)), /* movt r1 ... *=
/ \
     0xe5801000 + (addr)
=20
+#define ZYNQ_MAX_CPUS 2
+
 struct ZynqMachineState {
     MachineState parent;
     Clock *ps_clk;
+    ARMCPU *cpu[ZYNQ_MAX_CPUS];
 };
=20
 static void zynq_write_board_setup(ARMCPU *cpu,
@@ -176,13 +179,13 @@ static inline int zynq_init_spi_flashes(uint32_t ba=
se_addr, qemu_irq irq,
 static void zynq_init(MachineState *machine)
 {
     ZynqMachineState *zynq_machine =3D ZYNQ_MACHINE(machine);
-    ARMCPU *cpu;
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *ocm_ram =3D g_new(MemoryRegion, 1);
     DeviceState *dev, *slcr;
     SysBusDevice *busdev;
     qemu_irq pic[64];
     int n;
+    unsigned int smp_cpus =3D machine->smp.cpus;
=20
     /* max 2GB ram */
     if (machine->ram_size > 2 * GiB) {
@@ -190,21 +193,26 @@ static void zynq_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
=20
-    cpu =3D ARM_CPU(object_new(machine->cpu_type));
+    for (n =3D 0; n < smp_cpus; n++) {
+        Object *cpuobj =3D object_new(machine->cpu_type);
=20
-    /* By default A9 CPUs have EL3 enabled.  This board does not
-     * currently support EL3 so the CPU EL3 property is disabled before
-     * realization.
-     */
-    if (object_property_find(OBJECT(cpu), "has_el3")) {
-        object_property_set_bool(OBJECT(cpu), "has_el3", false, &error_f=
atal);
-    }
+        /*
+         * By default A9 CPUs have EL3 enabled.  This board does not cur=
rently
+         * support EL3 so the CPU EL3 property is disabled before realiz=
ation.
+         */
+        if (object_property_find(cpuobj, "has_el3")) {
+            object_property_set_bool(cpuobj, "has_el3", false, &error_fa=
tal);
+        }
=20
-    object_property_set_int(OBJECT(cpu), "midr", ZYNQ_BOARD_MIDR,
-                            &error_fatal);
-    object_property_set_int(OBJECT(cpu), "reset-cbar", MPCORE_PERIPHBASE=
,
-                            &error_fatal);
-    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
+        object_property_set_int(cpuobj, "midr", ZYNQ_BOARD_MIDR,
+                                &error_fatal);
+        object_property_set_int(cpuobj, "reset-cbar", MPCORE_PERIPHBASE,
+                                &error_fatal);
+
+        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
+
+        zynq_machine->cpu[n] =3D ARM_CPU(cpuobj);
+    }
=20
     /* DDR remapped to address zero.  */
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
@@ -237,15 +245,19 @@ static void zynq_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
=20
     dev =3D qdev_new(TYPE_A9MPCORE_PRIV);
-    qdev_prop_set_uint32(dev, "num-cpu", 1);
+    qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
     busdev =3D SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
+    zynq_binfo.gic_cpu_if_addr =3D MPCORE_PERIPHBASE + 0x100;
     sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
-    sysbus_connect_irq(busdev, 0,
-                       qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));
-    sysbus_connect_irq(busdev, 1,
-                       qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_FIQ));
+    for (n =3D 0; n < smp_cpus; n++) {
+        DeviceState *cpudev =3D DEVICE(OBJECT(zynq_machine->cpu[n]));
+        sysbus_connect_irq(busdev, (2 * n) + 0,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(busdev, (2 * n) + 1,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+    }
=20
     for (n =3D 0; n < 64; n++) {
         pic[n] =3D qdev_get_gpio_in(dev, n);
@@ -350,7 +362,7 @@ static void zynq_init(MachineState *machine)
     zynq_binfo.board_setup_addr =3D BOARD_SETUP_ADDR;
     zynq_binfo.write_board_setup =3D zynq_write_board_setup;
=20
-    arm_load_kernel(cpu, machine, &zynq_binfo);
+    arm_load_kernel(zynq_machine->cpu[0], machine, &zynq_binfo);
 }
=20
 static void zynq_machine_class_init(ObjectClass *oc, void *data)
@@ -362,7 +374,7 @@ static void zynq_machine_class_init(ObjectClass *oc, =
void *data)
     MachineClass *mc =3D MACHINE_CLASS(oc);
     mc->desc =3D "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init =3D zynq_init;
-    mc->max_cpus =3D 1;
+    mc->max_cpus =3D ZYNQ_MAX_CPUS;
     mc->no_sdcard =3D 1;
     mc->ignore_memory_transaction_failures =3D true;
     mc->valid_cpu_types =3D valid_cpu_types;
--=20
2.35.3


