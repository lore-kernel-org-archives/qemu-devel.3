Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC264C5AC82
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 07:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsEY0-0001XU-Km; Fri, 07 Aug 2026 02:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wsEXx-0001X3-Ak
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:59:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wsEXt-0008Au-Cs
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 02:59:12 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxfZs3gnVqszgLAA--.12610S3;
 Fri, 07 Aug 2026 14:59:03 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJAxjgc2gnVqX8gmAA--.7931S3;
 Fri, 07 Aug 2026 14:59:02 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/loongarch/boot: Check memory boundary in
 init_boot_rom()
Date: Fri,  7 Aug 2026 15:00:28 +0800
Message-ID: <20260807070029.1171348-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807070029.1171348-1-maobibo@loongson.cn>
References: <20260807070029.1171348-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxjgc2gnVqX8gmAA--.7931S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFyUKF4DKr1xXw1rXrWkAFc_yoWrZr1rpF
 y5Zr95Jrs5JrsrWr97t34j9Fs3Jr1xG3WaqasrXryFkF1UJr1UWF4vv342vFyDtan5KF1F
 vFnYva42gF47JwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

When booting the Linux kernel without UEFI BIOS, QEMU needs to set the boot
param for kernel. For the LoongArch Linux kernel, it is put in structure
loongarch_boot_info, and the total size is 1MB.

Here add memory boundary checking with preparing kernel boot param in
loongarch_boot_info.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
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
2.54.0


