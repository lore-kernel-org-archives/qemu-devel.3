Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F345CD5B868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 19:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVEQO-0001DS-Ld; Mon, 15 Dec 2025 14:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVEQK-00015A-Ea
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 14:40:00 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVEQG-0006Xe-NB
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 14:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=HcWMXvSmeIdUFWVSFmOjfUE4O2I5xiUpgz8v30Mi418=; b=q0dIweG4oTa/WL2
 Jh12OUE+P8lq/7rcp7PWYgGZ8eo3/0qTua76k2fyIk5dCHwgVbHHXxAcOUhvQnpzWXt0O4Je26rpC
 7QHheFSFTG9mJEjQtBDrlVpQeQ31b/KpYV1SSjZ/iWt4RzFiE7Q77S1Fj3qq5Y4pjjWH9bFXhelW1
 Gw=;
Date: Mon, 15 Dec 2025 20:42:54 +0100
Subject: [PATCH v2 5/7] hw/loongarch: Use loongarch_palen_mask()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-phys_addr-v2-5-633aa1d922cd@rev.ng>
References: <20251215-phys_addr-v2-0-633aa1d922cd@rev.ng>
In-Reply-To: <20251215-phys_addr-v2-0-633aa1d922cd@rev.ng>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
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

Replaces remaining uses of TARGET_PHYS_ADDR_SPACE_BITS with
runtime calls to loongarch_palen_mask() to fetch the physical
address mask from the cpucfg PALEN field.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/hw/loongarch/boot.h |  3 ++-
 hw/loongarch/boot.c         | 28 ++++++++++++++++------------
 hw/loongarch/virt.c         |  5 ++++-
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index 9819f7fbe3..4984322f75 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -113,6 +113,7 @@ struct memmap_entry {
     uint32_t reserved;
 };
 
-void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info);
+void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info,
+                           uint64_t phys_addr_mask);
 
 #endif /* HW_LOONGARCH_BOOT_H */
diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 8857a04998..d18aa575ba 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -217,10 +217,12 @@ static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
 
 static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
 {
-    return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
+    uint64_t *phys_addr_mask = opaque;
+    return addr & *phys_addr_mask;
 }
 
 static int64_t load_loongarch_linux_image(const char *filename,
+                                          uint64_t phys_addr_mask,
                                           uint64_t *kernel_entry,
                                           uint64_t *kernel_low,
                                           uint64_t *kernel_high)
@@ -251,10 +253,8 @@ static int64_t load_loongarch_linux_image(const char *filename,
     }
 
     /* Early kernel versions may have those fields in virtual address */
-    *kernel_entry = extract64(le64_to_cpu(hdr->kernel_entry),
-                              0, TARGET_PHYS_ADDR_SPACE_BITS);
-    *kernel_low = extract64(le64_to_cpu(hdr->load_offset),
-                            0, TARGET_PHYS_ADDR_SPACE_BITS);
+    *kernel_entry = le64_to_cpu(hdr->kernel_entry) & phys_addr_mask;
+    *kernel_low = le64_to_cpu(hdr->load_offset) & phys_addr_mask;
     *kernel_high = *kernel_low + size;
 
     rom_add_blob_fixed(filename, buffer, size, *kernel_low);
@@ -303,19 +303,21 @@ static ram_addr_t alloc_initrd_memory(struct loongarch_boot_info *info,
     exit(1);
 }
 
-static int64_t load_kernel_info(struct loongarch_boot_info *info)
+static int64_t load_kernel_info(struct loongarch_boot_info *info,
+                                uint64_t phys_addr_mask)
 {
     uint64_t kernel_entry, kernel_low, kernel_high, initrd_offset = 0;
     ssize_t kernel_size;
 
     kernel_size = load_elf(info->kernel_filename, NULL,
-                           cpu_loongarch_virt_to_phys, NULL,
+                           cpu_loongarch_virt_to_phys, &phys_addr_mask,
                            &kernel_entry, &kernel_low,
                            &kernel_high, NULL, ELFDATA2LSB,
                            EM_LOONGARCH, 1, 0);
-    kernel_entry = cpu_loongarch_virt_to_phys(NULL, kernel_entry);
+    kernel_entry = cpu_loongarch_virt_to_phys(&phys_addr_mask, kernel_entry);
     if (kernel_size < 0) {
         kernel_size = load_loongarch_linux_image(info->kernel_filename,
+                                                 phys_addr_mask,
                                                  &kernel_entry, &kernel_low,
                                                  &kernel_high);
     }
@@ -395,14 +397,15 @@ static void init_boot_rom(MachineState *ms,
 }
 
 static void loongarch_direct_kernel_boot(MachineState *ms,
-                                         struct loongarch_boot_info *info)
+                                         struct loongarch_boot_info *info,
+                                         uint64_t phys_addr_mask)
 {
     void *p, *bp;
     int64_t kernel_addr = VIRT_FLASH0_BASE;
     uint64_t *data;
 
     if (info->kernel_filename) {
-        kernel_addr = load_kernel_info(info);
+        kernel_addr = load_kernel_info(info, phys_addr_mask);
     } else {
         if (!qtest_enabled()) {
             warn_report("No kernel provided, booting from flash drive.");
@@ -429,7 +432,8 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
     g_free(bp);
 }
 
-void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
+void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info,
+                           uint64_t phys_addr_mask)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
 
@@ -440,6 +444,6 @@ void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
     if (lvms->bios_loaded) {
         loongarch_firmware_boot(lvms, info);
     } else {
-        loongarch_direct_kernel_boot(ms, info);
+        loongarch_direct_kernel_boot(ms, info, phys_addr_mask);
     }
 }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 49434ad182..e3e61903b0 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -33,6 +33,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/loongarch/fw_cfg.h"
 #include "target/loongarch/cpu.h"
+#include "target/loongarch/cpu-mmu.h"
 #include "hw/firmware/smbios.h"
 #include "qapi/qapi-visit-common.h"
 #include "hw/acpi/generic_event_device.h"
@@ -785,6 +786,7 @@ static void virt_init(MachineState *machine)
     hwaddr base, size, ram_size = machine->ram_size;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     Object *cpuobj;
+    uint64_t phys_addr_mask = 0;
 
     if (!cpu_model) {
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
@@ -872,7 +874,8 @@ static void virt_init(MachineState *machine)
     qemu_register_powerdown_notifier(&lvms->powerdown_notifier);
 
     lvms->bootinfo.ram_size = ram_size;
-    loongarch_load_kernel(machine, &lvms->bootinfo);
+    phys_addr_mask = loongarch_palen_mask(&LOONGARCH_CPU(first_cpu)->env);
+    loongarch_load_kernel(machine, &lvms->bootinfo, phys_addr_mask);
 }
 
 static void virt_get_acpi(Object *obj, Visitor *v, const char *name,

-- 
2.51.0


