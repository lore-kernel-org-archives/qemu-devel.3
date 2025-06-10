Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3EBC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 08:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOu9w-0004pY-1T; Tue, 10 Jun 2025 04:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uOu9q-0004mt-3Q
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:16:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uOu9m-0000TF-9t
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:16:33 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxLGvb6Udod30SAQ--.45918S3;
 Tue, 10 Jun 2025 16:16:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxb8fT6UdojgwUAQ--.58593S8;
 Tue, 10 Jun 2025 16:16:27 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/7] hw/loongarch/virt: Remove global variables about initrd
Date: Tue, 10 Jun 2025 15:53:49 +0800
Message-Id: <20250610075350.865626-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250610075350.865626-1-gaosong@loongson.cn>
References: <20250610075350.865626-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8fT6UdojgwUAQ--.58593S8
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

Global variables initrd_offset and initrd_size records loading information
about initrd, it can be moved to structure loongarch_boot_info.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250430094738.1556670-2-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/boot.c         | 21 ++++++++++-----------
 include/hw/loongarch/boot.h |  2 ++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 9b6292eaa1..a343547acd 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -38,9 +38,6 @@ struct loongarch_linux_hdr {
 struct memmap_entry *memmap_table;
 unsigned memmap_entries;
 
-ram_addr_t initrd_offset;
-uint64_t initrd_size;
-
 static const unsigned int slave_boot_code[] = {
                   /* Configure reset ebase.                    */
     0x0400302c,   /* csrwr      $t0, LOONGARCH_CSR_EENTRY      */
@@ -121,7 +118,8 @@ static void init_efi_boot_memmap(struct efi_system_table *systab,
     }
 }
 
-static void init_efi_initrd_table(struct efi_system_table *systab,
+static void init_efi_initrd_table(struct loongarch_boot_info *info,
+                                  struct efi_system_table *systab,
                                   void *p, void *start)
 {
     efi_guid_t tbl_guid = LINUX_EFI_INITRD_MEDIA_GUID;
@@ -132,8 +130,8 @@ static void init_efi_initrd_table(struct efi_system_table *systab,
     systab->tables[1].table = (struct efi_configuration_table *)(p - start);
     systab->nr_tables = 2;
 
-    initrd_table->base = initrd_offset;
-    initrd_table->size = initrd_size;
+    initrd_table->base = info->initrd_addr;
+    initrd_table->size = info->initrd_size;
 }
 
 static void init_efi_fdt_table(struct efi_system_table *systab)
@@ -169,7 +167,7 @@ static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
     init_efi_boot_memmap(systab, p, start);
     p += ROUND_UP(sizeof(struct efi_boot_memmap) +
                   sizeof(efi_memory_desc_t) * memmap_entries, 64 * KiB);
-    init_efi_initrd_table(systab, p, start);
+    init_efi_initrd_table(info, systab, p, start);
     p += ROUND_UP(sizeof(struct efi_initrd), 64 * KiB);
     init_efi_fdt_table(systab);
 
@@ -276,8 +274,8 @@ static ram_addr_t alloc_initrd_memory(struct loongarch_boot_info *info,
 
 static int64_t load_kernel_info(struct loongarch_boot_info *info)
 {
-    uint64_t kernel_entry, kernel_low, kernel_high;
-    ssize_t kernel_size;
+    uint64_t kernel_entry, kernel_low, kernel_high, initrd_offset = 0;
+    ssize_t kernel_size, initrd_size;
 
     kernel_size = load_elf(info->kernel_filename, NULL,
                            cpu_loongarch_virt_to_phys, NULL,
@@ -313,8 +311,9 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
                          info->initrd_filename);
             exit(1);
         }
-    } else {
-        initrd_size = 0;
+
+        info->initrd_addr = initrd_offset;
+        info->initrd_size = initrd_size;
     }
 
     return kernel_entry;
diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index b3b870df1f..27399de99c 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -102,6 +102,8 @@ struct loongarch_boot_info {
     const char *kernel_cmdline;
     const char *initrd_filename;
     uint64_t a0, a1, a2;
+    uint64_t initrd_addr;
+    uint64_t initrd_size;
 };
 
 extern struct memmap_entry *memmap_table;
-- 
2.34.1


