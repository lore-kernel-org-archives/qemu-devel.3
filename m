Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687EBCCD1AB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 00:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBiqn-0007m5-6t; Wed, 22 Oct 2025 20:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBiqZ-0007gd-Vd; Wed, 22 Oct 2025 20:06:28 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBiqV-0004aW-8j; Wed, 22 Oct 2025 20:06:27 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8F5E95972EB;
 Thu, 23 Oct 2025 02:06:21 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id JXUT3D_LZhLc; Thu, 23 Oct 2025 02:06:19 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 82AB95972E3; Thu, 23 Oct 2025 02:06:19 +0200 (CEST)
Message-ID: <d2d7f173dbd436b47382f384d5a93eb7e713424e.1761176219.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1761176219.git.balaton@eik.bme.hu>
References: <cover.1761176219.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 12/12] hw/ppc/pegasos2: Add VOF support for pegasos1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Date: Thu, 23 Oct 2025 02:06:19 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When running without firmware ROM using Virtual Open Firmware we need
to do some hardware initialisation and provide the device tree as the
machine firmware would normally do.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 MAINTAINERS              |   1 +
 hw/ppc/pegasos2.c        | 140 +++++++++++++++++++++++++++++++++------
 pc-bios/dtb/meson.build  |   1 +
 pc-bios/dtb/pegasos1.dtb | Bin 0 -> 857 bytes
 pc-bios/dtb/pegasos1.dts | 125 ++++++++++++++++++++++++++++++++++
 5 files changed, 246 insertions(+), 21 deletions(-)
 create mode 100644 pc-bios/dtb/pegasos1.dtb
 create mode 100644 pc-bios/dtb/pegasos1.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index 36eef27b41..684d7a5b37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1652,6 +1652,7 @@ F: hw/ppc/pegasos2.c
 F: hw/pci-host/mv64361.c
 F: hw/pci-host/mv643xx.h
 F: include/hw/pci-host/mv64361.h
+F: pc-bios/dtb/pegasos[12].dt[sb]
 
 amigaone
 M: BALATON Zoltan <balaton@eik.bme.hu>
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index a11f3c99ed..93696ed381 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -84,6 +84,7 @@ struct PegasosMachineState {
     uint64_t initrd_size;
 };
 
+static void *pegasos1_build_fdt(PegasosMachineState *pm, int *fdt_size);
 static void *pegasos2_build_fdt(PegasosMachineState *pm, int *fdt_size);
 
 static void pegasos_cpu_reset(void *opaque)
@@ -314,6 +315,82 @@ static void pegasos_init(MachineState *machine)
     }
 }
 
+static void pegasos_superio_write(uint8_t addr, uint8_t val)
+{
+    cpu_physical_memory_write(0xfe0003f0, &addr, 1);
+    cpu_physical_memory_write(0xfe0003f1, &val, 1);
+}
+
+static void pegasos1_pci_config_write(PegasosMachineState *pm, int bus,
+                                      uint32_t addr, uint32_t len, uint32_t val)
+{
+    addr |= BIT(31);
+    cpu_physical_memory_write(0xfec00cf8, &addr, 4);
+    cpu_physical_memory_write(0xfee00cfc, &val, len);
+}
+
+static void pegasos1_chipset_reset(PegasosMachineState *pm)
+{
+    uint8_t elcr = 0x2e;
+    cpu_physical_memory_write(0xfe0004d1, &elcr, sizeof(elcr));
+
+    pegasos1_pci_config_write(pm, 0, PCI_COMMAND, 2, PCI_COMMAND_IO |
+                              PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
+
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 0) << 8) |
+                              PCI_INTERRUPT_LINE, 2, 0x9);
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 0) << 8) |
+                              0x50, 1, 0x6);
+    pegasos_superio_write(0xf4, 0xbe);
+    pegasos_superio_write(0xf6, 0xef);
+    pegasos_superio_write(0xf7, 0xfc);
+    pegasos_superio_write(0xf2, 0x14);
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 0) << 8) |
+                              0x51, 1, 0x3d);
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 0) << 8) |
+                              0x55, 1, 0x90);
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 0) << 8) |
+                              0x56, 1, 0x99);
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 0) << 8) |
+                              0x57, 1, 0x90);
+
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 1) << 8) |
+                              PCI_INTERRUPT_LINE, 2, 0x10e);
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 1) << 8) |
+                              PCI_CLASS_PROG, 1, 0xf);
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 1) << 8) |
+                              0x40, 1, 0xb);
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 1) << 8) |
+                              0x50, 4, 0x17171717);
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 1) << 8) |
+                              PCI_COMMAND, 2, 0x87);
+
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 2) << 8) |
+                              PCI_INTERRUPT_LINE, 2, 0x409);
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 2) << 8) |
+                              PCI_COMMAND, 2, 0x7);
+
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 3) << 8) |
+                              PCI_INTERRUPT_LINE, 2, 0x409);
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 3) << 8) |
+                              PCI_COMMAND, 2, 0x7);
+
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 4) << 8) |
+                              PCI_INTERRUPT_LINE, 2, 0x9);
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 4) << 8) |
+                              0x48, 4, 0x2001);
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 4) << 8) |
+                              0x41, 1, 0);
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 4) << 8) |
+                              0x90, 4, 0x1000);
+
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 5) << 8) |
+                              PCI_INTERRUPT_LINE, 2, 0x309);
+
+    pegasos1_pci_config_write(pm, 0, (PCI_DEVFN(7, 6) << 8) |
+                              PCI_INTERRUPT_LINE, 2, 0x309);
+}
+
 static uint32_t pegasos2_mv_reg_read(PegasosMachineState *pm,
                                      uint32_t addr, uint32_t len)
 {
@@ -357,12 +434,6 @@ static void pegasos2_pci_config_write(PegasosMachineState *pm, int bus,
     pegasos2_mv_reg_write(pm, pcicfg + 4, len, val);
 }
 
-static void pegasos2_superio_write(uint8_t addr, uint8_t val)
-{
-    cpu_physical_memory_write(0xfe0003f0, &addr, 1);
-    cpu_physical_memory_write(0xfe0003f1, &val, 1);
-}
-
 static void pegasos2_chipset_reset(PegasosMachineState *pm)
 {
     pegasos2_mv_reg_write(pm, 0, 4, 0x28020ff);
@@ -379,10 +450,10 @@ static void pegasos2_chipset_reset(PegasosMachineState *pm)
                               PCI_INTERRUPT_LINE, 2, 0x9);
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
                               0x50, 1, 0x6);
-    pegasos2_superio_write(0xf4, 0xbe);
-    pegasos2_superio_write(0xf6, 0xef);
-    pegasos2_superio_write(0xf7, 0xfc);
-    pegasos2_superio_write(0xf2, 0x14);
+    pegasos_superio_write(0xf4, 0xbe);
+    pegasos_superio_write(0xf6, 0xef);
+    pegasos_superio_write(0xf7, 0xfc);
+    pegasos_superio_write(0xf2, 0x14);
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
                               0x50, 1, 0x2);
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
@@ -432,7 +503,7 @@ static void pegasos2_chipset_reset(PegasosMachineState *pm)
 static void pegasos_machine_reset(MachineState *machine, ResetType type)
 {
     PegasosMachineState *pm = PEGASOS_MACHINE(machine);
-    void *fdt;
+    void *fdt = NULL;
     uint32_t c[2];
     uint64_t d[2];
     int sz;
@@ -440,13 +511,22 @@ static void pegasos_machine_reset(MachineState *machine, ResetType type)
     qemu_devices_reset(type);
     if (!pm->vof) {
         return; /* Firmware should set up machine so nothing to do */
-    } else if (pm->type == PEGASOS1) {
-        error_report("VOF is not supported by this machine");
-        exit(1);
     }
 
     /* Otherwise, set up devices that board firmware would normally do */
-    pegasos2_chipset_reset(pm);
+    switch (pm->type) {
+    case PEGASOS1:
+        pegasos1_chipset_reset(pm);
+        fdt = pegasos1_build_fdt(pm, &sz);
+        break;
+    case PEGASOS2:
+        pegasos2_chipset_reset(pm);
+        fdt = pegasos2_build_fdt(pm, &sz);
+        break;
+    }
+    if (!fdt) {
+        exit(1);
+    }
 
     /* Device tree and VOF set up */
     vof_init(pm->vof, machine->ram_size, &error_fatal);
@@ -465,11 +545,6 @@ static void pegasos_machine_reset(MachineState *machine, ResetType type)
         exit(1);
     }
 
-    fdt = pegasos2_build_fdt(pm, &sz);
-    if (!fdt) {
-        exit(1);
-    }
-
     /* Set memory size */
     c[0] = 0;
     c[1] = cpu_to_be32(machine->ram_size);
@@ -761,6 +836,8 @@ static struct {
     const char *name;
     void (*dtf)(PCIBus *bus, PCIDevice *d, FDTInfo *fi);
 } device_map[] = {
+    { "pci10cc,660", "host", NULL },
+    { "pci10cc,661", "host", NULL },
     { "pci11ab,6460", "host", NULL },
     { "pci1106,571", "ide", dt_ide },
     { "pci1106,3044", "firewire", NULL },
@@ -846,7 +923,7 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
         qemu_fdt_setprop_cell(fi->fdt, node->str, "interrupts",
                               pci_get_byte(&d->config[PCI_INTERRUPT_PIN]));
     }
-    /* Pegasos2 firmware has subsystem-id amd subsystem-vendor-id swapped */
+    /* Pegasos firmware has subsystem-id and subsystem-vendor-id swapped */
     qemu_fdt_setprop_cell(fi->fdt, node->str, "subsystem-vendor-id",
                           pci_get_word(&d->config[PCI_SUBSYSTEM_ID]));
     qemu_fdt_setprop_cell(fi->fdt, node->str, "subsystem-id",
@@ -934,6 +1011,27 @@ static void *load_dtb(const char *filename, int *fdt_size)
     return fdt;
 }
 
+static void *pegasos1_build_fdt(PegasosMachineState *pm, int *fdt_size)
+{
+    FDTInfo fi;
+    PCIBus *pci_bus;
+    void *fdt = load_dtb("pegasos1.dtb", fdt_size);
+
+    if (!fdt) {
+        return NULL;
+    }
+    qemu_fdt_setprop_string(fdt, "/", "name", "bplan,Pegasos");
+
+    add_cpu_info(fdt, pm->cpu, pm->bus_freq_hz);
+
+    fi.fdt = fdt;
+    fi.path = "/pci@80000000";
+    pci_bus = PCI_BUS(qdev_get_child_bus(pm->nb, "pci.0"));
+    pci_for_each_device_reverse(pci_bus, 0, add_pci_device, &fi);
+
+    return fdt;
+}
+
 static void *pegasos2_build_fdt(PegasosMachineState *pm, int *fdt_size)
 {
     FDTInfo fi;
diff --git a/pc-bios/dtb/meson.build b/pc-bios/dtb/meson.build
index f14648f3a4..81bdd7580e 100644
--- a/pc-bios/dtb/meson.build
+++ b/pc-bios/dtb/meson.build
@@ -1,6 +1,7 @@
 dtbs = [
   'bamboo.dtb',
   'canyonlands.dtb',
+  'pegasos1.dtb',
   'pegasos2.dtb',
   'petalogix-ml605.dtb',
   'petalogix-s3adsp1800.dtb',
diff --git a/pc-bios/dtb/pegasos1.dtb b/pc-bios/dtb/pegasos1.dtb
new file mode 100644
index 0000000000000000000000000000000000000000..3b863b25288a59bcede9459ff42afad713dde741
GIT binary patch
literal 857
zcmZ8fO>Yx15OvxjK&T3w=^-c=RCQ5Ogp}S|g(^KkM8yI1P<g$Rbd_D(wKuI&2~qwB
z2PCfWU-%<P`~ZlU=k<oRBR$W&=lQVL`*U;oONjLkLWqG7Yv0*FXFOp%X25>1Ue)2P
zwH4Vq`;8bw1HZ>;t21Y#4($Qs>6oU{8xI*8@T`9T8sbOnw^Lh4-5HhX(Mm_{-ksVl
z)<#k543FN8J7aT6ZanN9FMLHMid)8#w$22?9P@Cm<{Ue{7yY!q`;sNG#%QTC<4J?o
zyrj~&#eOd+b^U#g+qE9l=58l32d?gA=i#Evk%Mn^%78T-ar4cvKZ`unPh?(rIUyvm
zp(f1s<Z@XAE#z61?+<#l1@(XbHt#{YIS+BeaUS$&_<8Hk*Y`L0=jCr^^*-L<<eHaH
z3^vr@g}yXD0>mX2*md1FhM>Vd@`{15zY&OI5A?*GZ_uJ49eCK4S?0+5L{U+Ak<mr2
z=(Ji`5~azg5RMg}8!d)!UmuPR-|SqF&Wu~p)JT`DSVmsC+*T-XG!<Q+Us3GcRd_p9
s7&S{Kj?U+#)j|w*U+pEiuE@E$trDqb+FTZtO-VSZr{qOC_eluFKX>nfX#fBK

literal 0
HcmV?d00001

diff --git a/pc-bios/dtb/pegasos1.dts b/pc-bios/dtb/pegasos1.dts
new file mode 100644
index 0000000000..e5ef9db866
--- /dev/null
+++ b/pc-bios/dtb/pegasos1.dts
@@ -0,0 +1,125 @@
+/*
+ * QEMU Pegasos1 Device Tree Source
+ *
+ * Copyright 2025 BALATON Zoltan
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This is partial source, more info will be filled in by board code.
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	device_type = "chrp";
+	model = "Pegasos";
+	revision = "1A";
+	CODEGEN,vendor = "bplan GmbH";
+	CODEGEN,board = "Pegasos";
+	CODEGEN,description = "Pegasos CHRP PowerPC System";
+
+	openprom {
+		model = "Pegasos,0.1b123";
+	};
+
+	chosen {
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0 0>;
+	};
+
+	cpus {
+		#size-cells	= <0>;
+		#address-cells	= <1>;
+		#cpus		= <1>;
+	};
+
+	failsafe {
+		device_type = "serial";
+	};
+
+	pci@80000000 {
+		device_type = "pci";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		clock-frequency = <33333333>;
+		8259-interrupt-acknowledge = <0xfef00000>;
+		reg = <0x80000000 0x7f000000>;
+		ranges = <0x01000000 0 0x00000000 0xfe000000 0 0x00800000
+			  0x02000000 0 0x80000000 0x80000000 0 0x7d000000
+			  0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>;
+		bus-range = <0 0>;
+
+		isa@7 {
+			vendor-id	= <0x1106>;
+			device-id	= <0x8231>;
+			revision-id	= <0x10>;
+			class-code	= <0x60100>;
+			/* Pegasos firmware has subsystem-id and */
+			/* subsystem-vendor-id swapped */
+			subsystem-id	= <0x1af4>;
+			subsystem-vendor-id = <0x1100>;
+			reg = <0x3800 0 0 0 0>;
+			device_type	= "isa";
+			#address-cells	= <2>;
+			#size-cells	= <1>;
+			eisa-slots	= <0>;
+			clock-frequency	= <8333333>;
+			slot-names	= <0>;
+
+			serial@i2f8 {
+				device_type	= "serial";
+				reg		= <1 0x2f8 8>;
+				interrupts	= <3 0>;
+				clock-frequency	= <0>;
+			};
+
+			8042@i60 {
+				device_type	= "";
+				reg		= <1 0x60 5>;
+				clock-frequency	= <0>;
+				interrupt-controller = "";
+				#address-cells	= <1>;
+				#size-cells	= <0>;
+				#interrupt-cells = <2>;
+
+			};
+
+			keyboard@i60 {
+				device_type	= "keyboard";
+				reg		= <1 0x60 5>;
+				interrupts	= <1 0>;
+			};
+
+			rtc@i70 {
+				device_type	= "rtc";
+				reg		= <1 0x70 2>;
+				interrupts	= <8 0>;
+				clock-frequency	= <0>;
+				compatible	= "ds1385-rtc";
+			};
+
+			timer@i40 {
+				device_type	= "timer";
+				reg		= <1 0x40 8>;
+				clock-frequency	= <0>;
+			};
+
+			fdc@i3f0 {
+				device_type	= "fdc";
+				reg		= <1 0x3f0 8>;
+				interrupts	= <6 0>;
+				clock-frequency	= <0>;
+			};
+
+			lpt@i3bc {
+				device_type	= "lpt";
+				reg		= <1 0x3bc 8>;
+				interrupts	= <7 0>;
+				clock-frequency	= <0>;
+			};
+		};
+	};
+};
-- 
2.41.3


