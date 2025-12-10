Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84102D3C545
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK5s-0006Z3-3k; Wed, 10 Dec 2025 08:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vTK5Z-0006Ev-6G
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:18:43 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vTK5X-0003wF-12
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date
 :Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=GGabOUTO9WQeh1STGGfiBuQHGMcGJvHW8HPHEta2uwc=; b=xZc4J6j8hekp4Bm
 mA7VSvk1UEcjr48phlbEuUw5Y8QDVyJOCldJFWNbPDf4LfVJXrDG16mX8k1wY0M9m1Y0iNlELVOpA
 doTsKgIb/TAMYRLGLuvjA/4C5naSap2w8xNHvDdNao6H8bQovRCJJOIPbplxUtt0RJi64OaNQAsxH
 Ek=;
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2] hw/riscv: Treat kernel_start_addr as vaddr
Date: Wed, 10 Dec 2025 14:21:30 +0100
Message-ID: <20251210132130.14465-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Changes kernel_start_addr from target_ulong to vaddr. Logically, the
argument represents a virtual address at which to load the kernel image,
which gets treated as a hwaddr as a fallback if elf and uimage loading
fails.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

---
v2: Updated callers of riscv_load_kernel() to use vaddr, changed return
    type of riscv_calc_kernel_start_addr().

---
 include/hw/riscv/boot.h    | 6 +++---
 hw/riscv/boot.c            | 6 +++---
 hw/riscv/microchip_pfsoc.c | 3 ++-
 hw/riscv/sifive_u.c        | 3 ++-
 hw/riscv/spike.c           | 2 +-
 hw/riscv/virt.c            | 3 ++-
 6 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 51b0e13bd3..333d932f2a 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -43,8 +43,8 @@ bool riscv_is_32bit(RISCVHartArrayState *harts);
 char *riscv_plic_hart_config_string(int hart_count);
 
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
-hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
-                                    hwaddr firmware_end_addr);
+vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
+                                   hwaddr firmware_end_addr);
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
                                     const char *default_machine_firmware,
                                     hwaddr *firmware_load_addr,
@@ -57,7 +57,7 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
                            symbol_fn_t sym_cb);
 void riscv_load_kernel(MachineState *machine,
                        RISCVBootInfo *info,
-                       target_ulong kernel_start_addr,
+                       vaddr kernel_start_addr,
                        bool load_initrd,
                        symbol_fn_t sym_cb);
 uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 75f34287ff..76b93aae46 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -74,8 +74,8 @@ void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
     info->is_32bit = riscv_is_32bit(harts);
 }
 
-hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
-                                    hwaddr firmware_end_addr) {
+vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
+                                   hwaddr firmware_end_addr) {
     if (info->is_32bit) {
         return QEMU_ALIGN_UP(firmware_end_addr, 4 * MiB);
     } else {
@@ -228,7 +228,7 @@ static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
 
 void riscv_load_kernel(MachineState *machine,
                        RISCVBootInfo *info,
-                       target_ulong kernel_start_addr,
+                       vaddr kernel_start_addr,
                        bool load_initrd,
                        symbol_fn_t sym_cb)
 {
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index a17f62cd08..bc4f409c19 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -521,7 +521,8 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     uint64_t mem_low_size, mem_high_size;
     hwaddr firmware_load_addr;
     const char *firmware_name;
-    hwaddr firmware_end_addr, kernel_start_addr;
+    hwaddr firmware_end_addr;
+    vaddr kernel_start_addr;
     uint64_t kernel_entry;
     uint64_t fdt_load_addr;
     DriveInfo *dinfo = drive_get(IF_SD, 0, 0);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a7492aa27a..2d27e925e8 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -515,7 +515,8 @@ static void sifive_u_machine_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
     hwaddr start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
-    hwaddr firmware_end_addr, kernel_start_addr;
+    hwaddr firmware_end_addr;
+    vaddr kernel_start_addr;
     const char *firmware_name;
     uint32_t start_addr_hi32 = 0x00000000;
     uint32_t fdt_load_addr_hi32 = 0x00000000;
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index b0bab3fe00..ce190f6c62 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -199,7 +199,7 @@ static void spike_board_init(MachineState *machine)
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     hwaddr firmware_end_addr = memmap[SPIKE_DRAM].base;
     hwaddr firmware_load_addr = memmap[SPIKE_DRAM].base;
-    hwaddr kernel_start_addr;
+    vaddr kernel_start_addr;
     char *firmware_name;
     uint64_t fdt_load_addr;
     uint64_t kernel_entry;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 17909206c7..aa4dd91325 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1434,7 +1434,8 @@ static void virt_machine_done(Notifier *notifier, void *data)
                                      machine_done);
     MachineState *machine = MACHINE(s);
     hwaddr start_addr = s->memmap[VIRT_DRAM].base;
-    hwaddr firmware_end_addr, kernel_start_addr;
+    hwaddr firmware_end_addr;
+    vaddr kernel_start_addr;
     const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
     uint64_t fdt_load_addr;
     uint64_t kernel_entry = 0;
-- 
2.51.0


