Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F87C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 08:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOu9v-0004p4-Jr; Tue, 10 Jun 2025 04:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uOu9r-0004n9-VB
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:16:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uOu9n-0000Tc-Lh
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:16:35 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxTOLc6UdoeX0SAQ--.4943S3;
 Tue, 10 Jun 2025 16:16:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxb8fT6UdojgwUAQ--.58593S9;
 Tue, 10 Jun 2025 16:16:27 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 7/7] hw/loongarch/virt: Remove global variables about memmap
 tables
Date: Tue, 10 Jun 2025 15:53:50 +0800
Message-Id: <20250610075350.865626-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250610075350.865626-1-gaosong@loongson.cn>
References: <20250610075350.865626-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8fT6UdojgwUAQ--.58593S9
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
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

From: Bibo Mao <maobibo@loongson.cn>

Global variables memmap_table and memmap_entries stores UEFI memory
map table informations. It can be moved into structure
LoongArchVirtMachineState.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20250430094738.1556670-3-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/boot.c         | 31 +++++++++++++++++++------------
 hw/loongarch/virt.c         | 23 ++++++++++++++++-------
 include/hw/loongarch/boot.h |  3 ---
 include/hw/loongarch/virt.h |  2 ++
 4 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index a343547acd..14d6c52d4e 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -35,9 +35,6 @@ struct loongarch_linux_hdr {
     uint32_t pe_header_offset;
 } QEMU_PACKED;
 
-struct memmap_entry *memmap_table;
-unsigned memmap_entries;
-
 static const unsigned int slave_boot_code[] = {
                   /* Configure reset ebase.                    */
     0x0400302c,   /* csrwr      $t0, LOONGARCH_CSR_EENTRY      */
@@ -91,12 +88,16 @@ static inline void *guidcpy(void *dst, const void *src)
     return memcpy(dst, src, sizeof(efi_guid_t));
 }
 
-static void init_efi_boot_memmap(struct efi_system_table *systab,
+static void init_efi_boot_memmap(MachineState *ms,
+                                 struct efi_system_table *systab,
                                  void *p, void *start)
 {
     unsigned i;
     struct efi_boot_memmap *boot_memmap = p;
     efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
+    struct memmap_entry *memmap_table;
+    unsigned int memmap_entries;
 
     /* efi_configuration_table 1 */
     guidcpy(&systab->tables[0].guid, &tbl_guid);
@@ -108,6 +109,8 @@ static void init_efi_boot_memmap(struct efi_system_table *systab,
     boot_memmap->map_size = 0;
 
     efi_memory_desc_t *map = p + sizeof(struct efi_boot_memmap);
+    memmap_table = lvms->memmap_table;
+    memmap_entries = lvms->memmap_entries;
     for (i = 0; i < memmap_entries; i++) {
         map = (void *)boot_memmap + sizeof(*map);
         map[i].type = memmap_table[i].type;
@@ -144,10 +147,12 @@ static void init_efi_fdt_table(struct efi_system_table *systab)
     systab->nr_tables = 3;
 }
 
-static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
+static void init_systab(MachineState *ms,
+                        struct loongarch_boot_info *info, void *p, void *start)
 {
     void *bp_tables_start;
     struct efi_system_table *systab = p;
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
 
     info->a2 = p - start;
 
@@ -164,9 +169,9 @@ static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
     systab->tables = p;
     bp_tables_start = p;
 
-    init_efi_boot_memmap(systab, p, start);
+    init_efi_boot_memmap(ms, systab, p, start);
     p += ROUND_UP(sizeof(struct efi_boot_memmap) +
-                  sizeof(efi_memory_desc_t) * memmap_entries, 64 * KiB);
+                  sizeof(efi_memory_desc_t) * lvms->memmap_entries, 64 * KiB);
     init_efi_initrd_table(info, systab, p, start);
     p += ROUND_UP(sizeof(struct efi_initrd), 64 * KiB);
     init_efi_fdt_table(systab);
@@ -368,17 +373,19 @@ static void loongarch_firmware_boot(LoongArchVirtMachineState *lvms,
     fw_cfg_add_kernel_info(info, lvms->fw_cfg);
 }
 
-static void init_boot_rom(struct loongarch_boot_info *info, void *p)
+static void init_boot_rom(MachineState *ms,
+                          struct loongarch_boot_info *info, void *p)
 {
     void *start = p;
 
     init_cmdline(info, p, start);
     p += COMMAND_LINE_SIZE;
 
-    init_systab(info, p, start);
+    init_systab(ms, info, p, start);
 }
 
-static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
+static void loongarch_direct_kernel_boot(MachineState *ms,
+                                         struct loongarch_boot_info *info)
 {
     void *p, *bp;
     int64_t kernel_addr = VIRT_FLASH0_BASE;
@@ -396,7 +403,7 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
     /* Load cmdline and system tables at [0 - 1 MiB] */
     p = g_malloc0(1 * MiB);
     bp = p;
-    init_boot_rom(info, p);
+    init_boot_rom(ms, info, p);
     rom_add_blob_fixed_as("boot_info", bp, 1 * MiB, 0, &address_space_memory);
 
     /* Load slave boot code at pflash0 . */
@@ -436,6 +443,6 @@ void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
     if (lvms->bios_loaded) {
         loongarch_firmware_boot(lvms, info);
     } else {
-        loongarch_direct_kernel_boot(info);
+        loongarch_direct_kernel_boot(ms, info);
     }
 }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index a3d449ca8b..34dfbd13e5 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -172,8 +172,15 @@ static void virt_powerdown_req(Notifier *notifier, void *opaque)
     acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
 }
 
-static void memmap_add_entry(uint64_t address, uint64_t length, uint32_t type)
+static void memmap_add_entry(MachineState *ms, uint64_t address,
+                             uint64_t length, uint32_t type)
 {
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
+    struct memmap_entry *memmap_table;
+    unsigned int memmap_entries;
+
+    memmap_table = lvms->memmap_table;
+    memmap_entries = lvms->memmap_entries;
     /* Ensure there are no duplicate entries. */
     for (unsigned i = 0; i < memmap_entries; i++) {
         assert(memmap_table[i].address != address);
@@ -186,6 +193,8 @@ static void memmap_add_entry(uint64_t address, uint64_t length, uint32_t type)
     memmap_table[memmap_entries].type = cpu_to_le32(type);
     memmap_table[memmap_entries].reserved = 0;
     memmap_entries++;
+    lvms->memmap_table = memmap_table;
+    lvms->memmap_entries = memmap_entries;
 }
 
 static DeviceState *create_acpi_ged(DeviceState *pch_pic,
@@ -623,13 +632,13 @@ static void fw_cfg_add_memory(MachineState *ms)
     }
 
     if (size >= gap) {
-        memmap_add_entry(base, gap, 1);
+        memmap_add_entry(ms, base, gap, 1);
         size -= gap;
         base = VIRT_HIGHMEM_BASE;
     }
 
     if (size) {
-        memmap_add_entry(base, size, 1);
+        memmap_add_entry(ms, base, size, 1);
         base += size;
     }
 
@@ -644,7 +653,7 @@ static void fw_cfg_add_memory(MachineState *ms)
          * lowram:  [base, +(gap - numa_info[0].node_mem))
          * highram: [VIRT_HIGHMEM_BASE, +(ram_size - gap))
          */
-        memmap_add_entry(base, gap - numa_info[0].node_mem, 1);
+        memmap_add_entry(ms, base, gap - numa_info[0].node_mem, 1);
         size = ram_size - gap;
         base = VIRT_HIGHMEM_BASE;
     } else {
@@ -652,7 +661,7 @@ static void fw_cfg_add_memory(MachineState *ms)
     }
 
     if (size) {
-        memmap_add_entry(base, size, 1);
+        memmap_add_entry(ms, base, size, 1);
     }
 }
 
@@ -738,8 +747,8 @@ static void virt_init(MachineState *machine)
     rom_set_fw(lvms->fw_cfg);
     if (lvms->fw_cfg != NULL) {
         fw_cfg_add_file(lvms->fw_cfg, "etc/memmap",
-                        memmap_table,
-                        sizeof(struct memmap_entry) * (memmap_entries));
+                        lvms->memmap_table,
+                        sizeof(struct memmap_entry) * lvms->memmap_entries);
     }
 
     /* Initialize the IO interrupt subsystem */
diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index 27399de99c..9819f7fbe3 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -106,9 +106,6 @@ struct loongarch_boot_info {
     uint64_t initrd_size;
 };
 
-extern struct memmap_entry *memmap_table;
-extern unsigned memmap_entries;
-
 struct memmap_entry {
     uint64_t address;
     uint64_t length;
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 2b7d19953f..602feab0f0 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -63,6 +63,8 @@ struct LoongArchVirtMachineState {
     struct loongarch_boot_info bootinfo;
     DeviceState *ipi;
     DeviceState *extioi;
+    struct memmap_entry *memmap_table;
+    unsigned int memmap_entries;
 };
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
-- 
2.34.1


