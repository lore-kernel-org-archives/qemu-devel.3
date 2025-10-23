Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE02CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 00:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBiqr-0007ou-AE; Wed, 22 Oct 2025 20:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBiqU-0007cX-B5; Wed, 22 Oct 2025 20:06:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBiqR-0004ZP-92; Wed, 22 Oct 2025 20:06:21 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 439BC5972F6;
 Thu, 23 Oct 2025 02:06:17 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 40ME9rr2LdVk; Thu, 23 Oct 2025 02:06:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 469ED5972EC; Thu, 23 Oct 2025 02:06:15 +0200 (CEST)
Message-ID: <f6633a68a72aad4fefb8d2373b52561f8ca8d41d.1761176219.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1761176219.git.balaton@eik.bme.hu>
References: <cover.1761176219.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 08/12] hw/ppc/pegasos2: Move hardware specific parts out of
 machine reset
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Date: Thu, 23 Oct 2025 02:06:15 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

Move the pegasos2 specific chipset reset out from machine reset to a
separate function and move generic parts that are not pegasos2
specific from build_fdt to machine reset so now build_fdt only
contains pegasos2 specific parts and can be renamed accordingly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/pegasos2.c | 79 ++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 2f9bd3eac5..ed3070204b 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -57,10 +57,6 @@
 
 #define BUS_FREQ_HZ 133333333
 
-#define PCI0_CFG_ADDR 0xcf8
-#define PCI1_CFG_ADDR 0xc78
-#define PCI1_IO_BASE  0xfe000000
-
 #define TYPE_PEGASOS2_MACHINE  MACHINE_TYPE_NAME("pegasos2")
 OBJECT_DECLARE_TYPE(Pegasos2MachineState, MachineClass, PEGASOS2_MACHINE)
 
@@ -82,7 +78,7 @@ struct Pegasos2MachineState {
     uint64_t initrd_size;
 };
 
-static void *build_fdt(MachineState *machine, int *fdt_size);
+static void *pegasos2_build_fdt(Pegasos2MachineState *pm, int *fdt_size);
 
 static void pegasos2_cpu_reset(void *opaque)
 {
@@ -284,6 +280,9 @@ static void pegasos2_mv_reg_write(Pegasos2MachineState *pm, uint32_t addr,
                                  MEMTXATTRS_UNSPECIFIED);
 }
 
+#define PCI0_CFG_ADDR 0xcf8
+#define PCI1_CFG_ADDR 0xc78
+
 static uint32_t pegasos2_pci_config_read(Pegasos2MachineState *pm, int bus,
                                          uint32_t addr, uint32_t len)
 {
@@ -308,23 +307,12 @@ static void pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
 
 static void pegasos2_superio_write(uint8_t addr, uint8_t val)
 {
-    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f0, &addr, 1);
-    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f1, &val, 1);
+    cpu_physical_memory_write(0xfe0003f0, &addr, 1);
+    cpu_physical_memory_write(0xfe0003f1, &val, 1);
 }
 
-static void pegasos2_machine_reset(MachineState *machine, ResetType type)
+static void pegasos2_chipset_reset(Pegasos2MachineState *pm)
 {
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
-    void *fdt;
-    uint64_t d[2];
-    int sz;
-
-    qemu_devices_reset(type);
-    if (!pm->vof) {
-        return; /* Firmware should set up machine so nothing to do */
-    }
-
-    /* Otherwise, set up devices that board firmware would normally do */
     pegasos2_mv_reg_write(pm, 0, 4, 0x28020ff);
     pegasos2_mv_reg_write(pm, 0x278, 4, 0xa31fc);
     pegasos2_mv_reg_write(pm, 0xf300, 4, 0x11ff0400);
@@ -387,6 +375,23 @@ static void pegasos2_machine_reset(MachineState *machine, ResetType type)
 
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 6) << 8) |
                               PCI_INTERRUPT_LINE, 2, 0x309);
+}
+
+static void pegasos2_machine_reset(MachineState *machine, ResetType type)
+{
+    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
+    void *fdt;
+    uint32_t c[2];
+    uint64_t d[2];
+    int sz;
+
+    qemu_devices_reset(type);
+    if (!pm->vof) {
+        return; /* Firmware should set up machine so nothing to do */
+    }
+
+    /* Otherwise, set up devices that board firmware would normally do */
+    pegasos2_chipset_reset(pm);
 
     /* Device tree and VOF set up */
     vof_init(pm->vof, machine->ram_size, &error_fatal);
@@ -405,10 +410,25 @@ static void pegasos2_machine_reset(MachineState *machine, ResetType type)
         exit(1);
     }
 
-    fdt = build_fdt(machine, &sz);
+    fdt = pegasos2_build_fdt(pm, &sz);
     if (!fdt) {
         exit(1);
     }
+
+    /* Set memory size */
+    c[0] = 0;
+    c[1] = cpu_to_be32(machine->ram_size);
+    qemu_fdt_setprop(fdt, "/memory@0", "reg", c, sizeof(c));
+
+    /* Boot parameters */
+    if (pm->initrd_addr && pm->initrd_size) {
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+                              pm->initrd_addr + pm->initrd_size);
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
+                              pm->initrd_addr);
+    }
+    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
+                            machine->kernel_cmdline ?: "");
     /* FIXME: VOF assumes entry is same as load address */
     d[0] = cpu_to_be64(pm->kernel_entry);
     d[1] = cpu_to_be64(pm->kernel_size - (pm->kernel_entry - pm->kernel_addr));
@@ -827,12 +847,10 @@ static void *load_dtb(const char *filename, int *fdt_size)
     return fdt;
 }
 
-static void *build_fdt(MachineState *machine, int *fdt_size)
+static void *pegasos2_build_fdt(Pegasos2MachineState *pm, int *fdt_size)
 {
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
     FDTInfo fi;
     PCIBus *pci_bus;
-    uint32_t cells[2];
     void *fdt = load_dtb("pegasos2.dtb", fdt_size);
 
     if (!fdt) {
@@ -840,21 +858,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     }
     qemu_fdt_setprop_string(fdt, "/", "name", "bplan,Pegasos2");
 
-    /* Set memory size */
-    cells[0] = 0;
-    cells[1] = cpu_to_be32(machine->ram_size);
-    qemu_fdt_setprop(fdt, "/memory@0", "reg", cells, 2 * sizeof(cells[0]));
-
-    /* Boot parameters */
-    if (pm->initrd_addr && pm->initrd_size) {
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
-                              pm->initrd_addr + pm->initrd_size);
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
-                              pm->initrd_addr);
-    }
-    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
-                            machine->kernel_cmdline ?: "");
-
     add_cpu_info(fdt, pm->cpu);
 
     fi.fdt = fdt;
-- 
2.41.3


