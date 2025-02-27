Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0BBC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngvq-00081S-5Z; Thu, 27 Feb 2025 11:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tngvL-0007i7-Jx; Thu, 27 Feb 2025 11:39:47 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tngv4-0006IK-TB; Thu, 27 Feb 2025 11:39:46 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A8C3C4E61AB;
 Thu, 27 Feb 2025 17:39:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id KZSbQ2Y_AU1z; Thu, 27 Feb 2025 17:39:20 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4FC144E6041; Thu, 27 Feb 2025 17:39:18 +0100 (CET)
Message-Id: <489b1be5d95d5153e924c95b0691b8b53f9ffb9e.1740673173.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1740673173.git.balaton@eik.bme.hu>
References: <cover.1740673173.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 4/5] ppc/amigaone: Add kernel and initrd support
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 27 Feb 2025 17:39:18 +0100 (CET)
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

Add support for -kernel, -initrd and -append command line options.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/amigaone.c | 113 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 5c5585d39a..04ff415a6b 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -25,11 +25,14 @@
 #include "system/qtest.h"
 #include "system/reset.h"
 #include "kvm_ppc.h"
+#include "elf.h"
 
 #include <zlib.h> /* for crc32 */
 
 #define BUS_FREQ_HZ 100000000
 
+#define INITRD_MIN_ADDR 0x600000
+
 /*
  * Firmware binary available at
  * https://www.hyperion-entertainment.com/index.php/downloads?view=files&parent=28
@@ -178,12 +181,68 @@ static const TypeInfo nvram_types[] = {
 };
 DEFINE_TYPES(nvram_types)
 
+struct boot_info {
+    hwaddr entry;
+    hwaddr stack;
+    hwaddr bd_info;
+    hwaddr initrd_start;
+    hwaddr initrd_end;
+    hwaddr cmdline_start;
+    hwaddr cmdline_end;
+};
+
+/* Board info struct from U-Boot */
+struct bd_info {
+    uint32_t bi_memstart;
+    uint32_t bi_memsize;
+    uint32_t bi_flashstart;
+    uint32_t bi_flashsize;
+    uint32_t bi_flashoffset;
+    uint32_t bi_sramstart;
+    uint32_t bi_sramsize;
+    uint32_t bi_bootflags;
+    uint32_t bi_ip_addr;
+    uint8_t  bi_enetaddr[6];
+    uint16_t bi_ethspeed;
+    uint32_t bi_intfreq;
+    uint32_t bi_busfreq;
+    uint32_t bi_baudrate;
+} QEMU_PACKED;
+
+static void create_bd_info(hwaddr addr, ram_addr_t ram_size)
+{
+    struct bd_info *bd = g_new0(struct bd_info, 1);
+
+    bd->bi_memsize =    cpu_to_be32(ram_size);
+    bd->bi_flashstart = cpu_to_be32(PROM_ADDR);
+    bd->bi_flashsize =  cpu_to_be32(1); /* match what U-Boot detects */
+    bd->bi_bootflags =  cpu_to_be32(1);
+    bd->bi_intfreq =    cpu_to_be32(11.5 * BUS_FREQ_HZ);
+    bd->bi_busfreq =    cpu_to_be32(BUS_FREQ_HZ);
+    bd->bi_baudrate =   cpu_to_be32(115200);
+
+    cpu_physical_memory_write(addr, bd, sizeof(*bd));
+}
+
 static void amigaone_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
+    CPUPPCState *env = &cpu->env;
 
     cpu_reset(CPU(cpu));
-    cpu_ppc_tb_reset(&cpu->env);
+    if (env->load_info) {
+        struct boot_info *bi = env->load_info;
+
+        env->gpr[1] = bi->stack;
+        env->gpr[2] = 1024;
+        env->gpr[3] = bi->bd_info;
+        env->gpr[4] = bi->initrd_start;
+        env->gpr[5] = bi->initrd_end;
+        env->gpr[6] = bi->cmdline_start;
+        env->gpr[7] = bi->cmdline_end;
+        env->nip = bi->entry;
+    }
+    cpu_ppc_tb_reset(env);
 }
 
 static void fix_spd_data(uint8_t *spd)
@@ -205,6 +264,8 @@ static void amigaone_init(MachineState *machine)
     I2CBus *i2c_bus;
     uint8_t *spd_data;
     DriveInfo *di;
+    hwaddr loadaddr;
+    struct boot_info *bi = NULL;
 
     /* init CPU */
     cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
@@ -301,6 +362,56 @@ static void amigaone_init(MachineState *machine)
     }
     pci_ide_create_devs(PCI_DEVICE(object_resolve_path_component(via, "ide")));
     pci_vga_init(pci_bus);
+
+    if (!machine->kernel_filename) {
+        return;
+    }
+
+    /* handle -kernel, -initrd, -append options and emulate U-Boot */
+    bi = g_new0(struct boot_info, 1);
+    cpu->env.load_info = bi;
+
+    loadaddr = MIN(machine->ram_size, 256 * MiB);
+    bi->bd_info = loadaddr - 8 * MiB;
+    create_bd_info(bi->bd_info, machine->ram_size);
+    bi->stack = bi->bd_info - 64 * KiB - 8;
+
+    if (machine->kernel_cmdline && machine->kernel_cmdline[0]) {
+        size_t len = strlen(machine->kernel_cmdline);
+
+        loadaddr = bi->bd_info + 1 * MiB;
+        cpu_physical_memory_write(loadaddr, machine->kernel_cmdline, len + 1);
+        bi->cmdline_start = loadaddr;
+        bi->cmdline_end = loadaddr + len + 1; /* including terminating '\0' */
+    }
+
+    sz = load_elf(machine->kernel_filename, NULL, NULL, NULL,
+                  &bi->entry, &loadaddr, NULL, NULL,
+                  ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
+    if (sz <= 0) {
+        sz = load_uimage(machine->kernel_filename, &bi->entry, &loadaddr,
+                         NULL, NULL, NULL);
+    }
+    if (sz <= 0) {
+        error_report("Could not load kernel '%s'",
+                     machine->kernel_filename);
+        exit(1);
+    }
+    loadaddr += sz;
+
+    if (machine->initrd_filename) {
+        loadaddr = ROUND_UP(loadaddr + 4 * MiB, 4 * KiB);
+        loadaddr = MAX(loadaddr, INITRD_MIN_ADDR);
+        sz = load_image_targphys(machine->initrd_filename, loadaddr,
+                                 bi->bd_info - loadaddr);
+        if (sz <= 0) {
+            error_report("Could not load initrd '%s'",
+                         machine->initrd_filename);
+            exit(1);
+        }
+        bi->initrd_start = loadaddr;
+        bi->initrd_end = loadaddr + sz;
+    }
 }
 
 static void amigaone_machine_init(MachineClass *mc)
-- 
2.30.9


