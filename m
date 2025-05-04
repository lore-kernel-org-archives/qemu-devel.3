Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9B1C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 16:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBbmd-0004sI-C4; Sun, 04 May 2025 12:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uBbmb-0004p0-Li; Sun, 04 May 2025 12:01:37 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uBbmY-0004AN-0U; Sun, 04 May 2025 12:01:37 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AE03155D21A;
 Sun, 04 May 2025 18:01:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id s2T_LI7CItth; Sun,  4 May 2025 18:01:28 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B2D5555D234; Sun, 04 May 2025 18:01:28 +0200 (CEST)
Message-ID: <4ca4f71bf661923d9a91b7e6776a0e40726e2337.1746374076.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1746374076.git.balaton@eik.bme.hu>
References: <cover.1746374076.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 02/16] hw/pci-host/raven: Revert "raven: Move BIOS loading
 from board code to PCI host"
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Sun, 04 May 2025 18:01:28 +0200 (CEST)
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

This reverts commit d0b25425749d5525b2ba6d9d966d8800a5643b35.

Loading firmware from the PCI host is unusual and raven is only used
by one board so this does not simplify anything but rather complicates
it. Revert to loading firmware from board code as that is the usual
way and also because raven has nothing to do with ROM so it is not a
good place for this.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/pci-host/raven.c | 55 ---------------------------------------------
 hw/ppc/prep.c       | 27 ++++++++++++++++++++--
 2 files changed, 25 insertions(+), 57 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index b78a8f32d3..f8c0be5d21 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -24,7 +24,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
@@ -35,9 +34,7 @@
 #include "migration/vmstate.h"
 #include "hw/intc/i8259.h"
 #include "hw/irq.h"
-#include "hw/loader.h"
 #include "hw/or-irq.h"
-#include "elf.h"
 #include "qom/object.h"
 
 #define TYPE_RAVEN_PCI_DEVICE "raven"
@@ -47,10 +44,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(RavenPCIState, RAVEN_PCI_DEVICE)
 
 struct RavenPCIState {
     PCIDevice dev;
-
-    uint32_t elf_machine;
-    char *bios_name;
-    MemoryRegion bios;
 };
 
 typedef struct PRePPCIState PREPPCIState;
@@ -77,8 +70,6 @@ struct PRePPCIState {
     int contiguous_map;
 };
 
-#define BIOS_SIZE (1 * MiB)
-
 #define PCI_IO_BASE_ADDR    0x80000000  /* Physical address on main bus */
 
 static inline uint32_t raven_pci_io_config(hwaddr addr)
@@ -333,48 +324,9 @@ static void raven_pcihost_initfn(Object *obj)
 
 static void raven_realize(PCIDevice *d, Error **errp)
 {
-    RavenPCIState *s = RAVEN_PCI_DEVICE(d);
-    char *filename;
-    int bios_size = -1;
-
     d->config[PCI_CACHE_LINE_SIZE] = 0x08;
     d->config[PCI_LATENCY_TIMER] = 0x10;
     d->config[PCI_CAPABILITY_LIST] = 0x00;
-
-    if (!memory_region_init_rom_nomigrate(&s->bios, OBJECT(s), "bios",
-                                          BIOS_SIZE, errp)) {
-        return;
-    }
-    memory_region_add_subregion(get_system_memory(), (uint32_t)(-BIOS_SIZE),
-                                &s->bios);
-    if (s->bios_name) {
-        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, s->bios_name);
-        if (filename) {
-            if (s->elf_machine != EM_NONE) {
-                bios_size = load_elf(filename, NULL, NULL, NULL, NULL,
-                                     NULL, NULL, NULL,
-                                     ELFDATA2MSB, s->elf_machine, 0, 0);
-            }
-            if (bios_size < 0) {
-                bios_size = get_image_size(filename);
-                if (bios_size > 0 && bios_size <= BIOS_SIZE) {
-                    hwaddr bios_addr;
-                    bios_size = (bios_size + 0xfff) & ~0xfff;
-                    bios_addr = (uint32_t)(-BIOS_SIZE);
-                    bios_size = load_image_targphys(filename, bios_addr,
-                                                    bios_size);
-                }
-            }
-        }
-        g_free(filename);
-        if (bios_size < 0 || bios_size > BIOS_SIZE) {
-            memory_region_del_subregion(get_system_memory(), &s->bios);
-            error_setg(errp, "Could not load bios image '%s'", s->bios_name);
-            return;
-        }
-    }
-
-    vmstate_register_ram_global(&s->bios);
 }
 
 static const VMStateDescription vmstate_raven = {
@@ -417,19 +369,12 @@ static const TypeInfo raven_info = {
     },
 };
 
-static const Property raven_pcihost_properties[] = {
-    DEFINE_PROP_UINT32("elf-machine", PREPPCIState, pci_dev.elf_machine,
-                       EM_NONE),
-    DEFINE_PROP_STRING("bios-name", PREPPCIState, pci_dev.bios_name),
-};
-
 static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->realize = raven_pcihost_realizefn;
-    device_class_set_props(dc, raven_pcihost_properties);
     dc->fw_name = "pci";
 }
 
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 739526335c..982e40e53e 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -35,6 +35,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
+#include "qemu/datadir.h"
 #include "hw/loader.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/isa/pc87312.h"
@@ -55,6 +56,8 @@
 #define KERNEL_LOAD_ADDR 0x01000000
 #define INITRD_LOAD_ADDR 0x01800000
 
+#define BIOS_ADDR         0xfff00000
+#define BIOS_SIZE         (1 * MiB)
 #define NVRAM_SIZE        0x2000
 
 static void fw_cfg_boot_set(void *opaque, const char *boot_device,
@@ -241,6 +244,9 @@ static void ibm_40p_init(MachineState *machine)
     ISADevice *isa_dev;
     ISABus *isa_bus;
     void *fw_cfg;
+    MemoryRegion *bios = g_new(MemoryRegion, 1);
+    char *filename;
+    ssize_t bios_size = -1;
     uint32_t kernel_base = 0, initrd_base = 0;
     long kernel_size = 0, initrd_size = 0;
     char boot_device;
@@ -263,10 +269,27 @@ static void ibm_40p_init(MachineState *machine)
     cpu_ppc_tb_init(env, 100UL * 1000UL * 1000UL);
     qemu_register_reset(ppc_prep_reset, cpu);
 
+    /* allocate and load firmware */
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    if (!filename) {
+        error_report("Could not find bios image '%s'", bios_name);
+        exit(1);
+    }
+    memory_region_init_rom(bios, NULL, "bios", BIOS_SIZE, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), BIOS_ADDR, bios);
+    bios_size = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+                         ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
+    if (bios_size < 0) {
+        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE);
+    }
+    if (bios_size < 0 || bios_size > BIOS_SIZE) {
+        error_report("Could not load bios image '%s'", filename);
+        return;
+    }
+    g_free(filename);
+
     /* PCI host */
     dev = qdev_new("raven-pcihost");
-    qdev_prop_set_string(dev, "bios-name", bios_name);
-    qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);
     pcihost = SYS_BUS_DEVICE(dev);
     object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev));
     sysbus_realize_and_unref(pcihost, &error_fatal);
-- 
2.41.3


