Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539A6C19F53
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 09:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s10WF-00041t-RN; Sun, 28 Apr 2024 05:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s10WA-0003fC-Gi
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:08:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s10W7-0004Gz-Ed
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:08:18 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxV+n9ES5m5FkEAA--.3514S3;
 Sun, 28 Apr 2024 17:08:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxpFb1ES5mmCgIAA--.5818S10; 
 Sun, 28 Apr 2024 17:08:13 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 08/17] hw/loongarch: Init efi_fdt table
Date: Sun, 28 Apr 2024 16:51:08 +0800
Message-Id: <20240428085117.2422473-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240428085117.2422473-1-gaosong@loongson.cn>
References: <20240428085117.2422473-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxpFb1ES5mmCgIAA--.5818S10
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
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

The efi_system_table adds a efi_fdt configuration table.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20240426091551.2397867-9-gaosong@loongson.cn>
---
 hw/loongarch/boot.c         | 11 +++++++++++
 hw/loongarch/virt.c         |  6 ++----
 include/hw/loongarch/boot.h |  4 ++++
 include/hw/loongarch/virt.h |  2 ++
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 1f6cb8ddd7..82d171c318 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -113,6 +113,16 @@ static void init_efi_initrd_table(struct efi_system_table *systab,
     initrd_table->size = initrd_size;
 }
 
+static void init_efi_fdt_table(struct efi_system_table *systab)
+{
+    efi_guid_t tbl_guid = DEVICE_TREE_GUID;
+
+    /* efi_configuration_table 3 */
+    guidcpy(&systab->tables[2].guid, &tbl_guid);
+    systab->tables[2].table = (void *)FDT_BASE;
+    systab->nr_tables = 3;
+}
+
 static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
 {
     void *bp_tables_start;
@@ -138,6 +148,7 @@ static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
                   sizeof(efi_memory_desc_t) * memmap_entries, 64 * KiB);
     init_efi_initrd_table(systab, p, start);
     p += ROUND_UP(sizeof(struct efi_initrd), 64 * KiB);
+    init_efi_fdt_table(systab);
 
     systab->tables = (struct efi_configuration_table *)(bp_tables_start - start);
 }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 708aa8bc60..42e5df8a24 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -727,7 +727,6 @@ static void loongarch_init(MachineState *machine)
     int nb_numa_nodes = machine->numa_state->num_nodes;
     NodeInfo *numa_info = machine->numa_state->nodes;
     int i;
-    hwaddr fdt_base;
     const CPUArchIdList *possible_cpus;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     CPUState *cpu;
@@ -857,12 +856,11 @@ static void loongarch_init(MachineState *machine)
      * Put the FDT into the memory map as a ROM image: this will ensure
      * the FDT is copied again upon reset, even if addr points into RAM.
      */
-    fdt_base = 1 * MiB;
     qemu_fdt_dumpdtb(machine->fdt, lams->fdt_size);
-    rom_add_blob_fixed_as("fdt", machine->fdt, lams->fdt_size, fdt_base,
+    rom_add_blob_fixed_as("fdt", machine->fdt, lams->fdt_size, FDT_BASE,
                           &address_space_memory);
     qemu_register_reset_nosnapshotload(qemu_fdt_randomize_seeds,
-            rom_ptr_for_as(&address_space_memory, fdt_base, lams->fdt_size));
+            rom_ptr_for_as(&address_space_memory, FDT_BASE, lams->fdt_size));
 
     lams->bootinfo.ram_size = ram_size;
     loongarch_load_kernel(machine, &lams->bootinfo);
diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index 42d1ee3663..4ebcc89dcf 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -34,6 +34,10 @@ typedef struct {
         EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, \
                  0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
 
+#define DEVICE_TREE_GUID \
+        EFI_GUID(0xb1b621d5, 0xf19c, 0x41a5,  0x83, 0x0b, \
+                 0xd9, 0x15, 0x2c, 0x69, 0xaa, 0xe0)
+
 struct efi_config_table {
     efi_guid_t guid;
     uint64_t *ptr;
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 8a9fe4053d..4e14bf6060 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -35,6 +35,8 @@
 
 #define COMMAND_LINE_SIZE       512
 
+#define FDT_BASE                0x100000
+
 extern struct memmap_entry *memmap_table;
 extern unsigned memmap_entries;
 
-- 
2.25.1


