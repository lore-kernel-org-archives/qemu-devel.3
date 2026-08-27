Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352DAC61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 01:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzPEF-00026V-Mb; Wed, 26 Aug 2026 21:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wzPEA-000259-Fx
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 21:48:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wzPE7-0007pN-LE
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 21:48:26 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx_9Jhl49qfoYFAA--.15525S3;
 Thu, 27 Aug 2026 09:48:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCx+c1dl49q1KwTAA--.16714S3;
 Thu, 27 Aug 2026 09:48:17 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 1/3] hw/loongarch/boot: Check memory boundary in init_boot_rom()
Date: Thu, 27 Aug 2026 09:28:09 +0800
Message-Id: <20260827012811.1008381-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260827012811.1008381-1-gaosong@loongson.cn>
References: <20260827012811.1008381-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx+c1dl49q1KwTAA--.16714S3
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

When booting the Linux kernel without UEFI BIOS, QEMU needs to set the boot
param for kernel. For the LoongArch Linux kernel, it is put in structure
loongarch_boot_info, and the total size is 1MB.

Here add memory boundary checking with preparing kernel boot param in
loongarch_boot_info.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20260807070029.1171348-2-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/boot.c | 68 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index ef8eae237c..fe91ab16bd 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -173,12 +173,19 @@ static void init_efi_fdt_table(struct efi_system_table *systab)
     systab->nr_tables = 3;
 }
 
-static void init_systab(MachineState *ms,
+static void init_systab(MachineState *ms, size_t size,
                         struct loongarch_boot_info *info, void *p, void *start)
 {
     void *bp_tables_start;
     struct efi_system_table *systab = p;
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
+    size_t len;
+
+    len = ROUND_UP(sizeof(struct efi_system_table), 64 * KiB);
+    if (len > size) {
+        error_report("could not init efi_system_table");
+        exit(1);
+    }
 
     info->a2 = p - start;
 
@@ -190,29 +197,56 @@ static void init_systab(MachineState *ms,
     systab->boottime = 0;
     systab->nr_tables = 0;
 
-    p += ROUND_UP(sizeof(struct efi_system_table), 64 * KiB);
+    p += len;
+    size -= len;
 
     systab->tables = p;
     bp_tables_start = p;
 
+    len = ROUND_UP(sizeof(struct efi_boot_memmap) +
+                   sizeof(efi_memory_desc_t) * lvms->memmap_entries, 64 * KiB);
+    if (len > size) {
+        error_report("could not init efi_boot_memmap");
+        exit(1);
+    }
+
     init_efi_boot_memmap(ms, systab, p, start);
-    p += ROUND_UP(sizeof(struct efi_boot_memmap) +
-                  sizeof(efi_memory_desc_t) * lvms->memmap_entries, 64 * KiB);
+    p += len;
+    size -= len;
+
+    len = ROUND_UP(sizeof(struct efi_initrd), 64 * KiB);
+    if (len > size) {
+        error_report("could not init efi_initrd");
+        exit(1);
+    }
+
     init_efi_initrd_table(info, systab, p, start);
-    p += ROUND_UP(sizeof(struct efi_initrd), 64 * KiB);
+    p += len;
+    size -= len;
     init_efi_fdt_table(systab);
 
     systab->tables = (struct efi_configuration_table *)(bp_tables_start - start);
 }
 
-static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
+static size_t init_cmdline(struct loongarch_boot_info *info, void *p,
+                           void *start, size_t size)
 {
     hwaddr cmdline_addr = p - start;
+    size_t len;
 
     info->a0 = 1;
     info->a1 = cmdline_addr;
 
-    g_strlcpy(p, info->kernel_cmdline, COMMAND_LINE_SIZE);
+    len = g_strlcpy(p, info->kernel_cmdline, size);
+
+    /* include terminating null byte */
+    if (len < size) {
+        len += 1;
+    } else {
+        len = size;
+    }
+
+    return len;
 }
 
 static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
@@ -385,15 +419,21 @@ static void loongarch_firmware_boot(LoongArchVirtMachineState *lvms,
     fw_cfg_add_kernel_info(info, lvms->fw_cfg);
 }
 
-static void init_boot_rom(MachineState *ms,
+static void init_boot_rom(MachineState *ms, size_t size,
                           struct loongarch_boot_info *info, void *p)
 {
     void *start = p;
+    size_t len;
 
-    init_cmdline(info, p, start);
-    p += COMMAND_LINE_SIZE;
+    len = init_cmdline(info, p, start, size);
+    len = ROUND_UP(len, 64 * KiB);
+    if (len > size) {
+        error_report("could not init systab");
+        exit(1);
+    }
 
-    init_systab(ms, info, p, start);
+    p += len;
+    init_systab(ms, size - len, info, p, start);
 }
 
 static void loongarch_direct_kernel_boot(MachineState *ms,
@@ -403,6 +443,7 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
     void *p, *bp;
     int64_t kernel_addr = VIRT_FLASH0_BASE;
     uint64_t *data;
+    size_t size;
 
     if (info->kernel_filename) {
         kernel_addr = load_kernel_info(info, phys_addr_mask);
@@ -415,8 +456,9 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
     /* Load cmdline and system tables at [0 - 1 MiB] */
     p = g_malloc0(1 * MiB);
     bp = p;
-    init_boot_rom(ms, info, p);
-    rom_add_blob_fixed_as("boot_info", bp, 1 * MiB, 0, &address_space_memory);
+    size = 1 * MiB;
+    init_boot_rom(ms, size, info, p);
+    rom_add_blob_fixed_as("boot_info", bp, size, 0, &address_space_memory);
 
     /* Load slave boot code at pflash0 . */
     void *boot_code = g_malloc0(VIRT_FLASH0_SIZE);
-- 
2.55.0


