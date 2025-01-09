Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D63CE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVmUs-00045b-GR; Thu, 09 Jan 2025 01:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tVmUp-00044N-Fr
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:58:23 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tVmUm-0000T1-BK
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:58:23 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx++GCc39nTXBgAA--.57608S3;
 Thu, 09 Jan 2025 14:58:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxXMV8c39nCtkaAA--.46678S4;
 Thu, 09 Jan 2025 14:58:07 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 2/6] hw/loongarch/boot: Support Linux raw boot image
Date: Thu,  9 Jan 2025 14:58:00 +0800
Message-Id: <20250109065804.1569654-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250109065804.1569654-1-maobibo@loongson.cn>
References: <20250109065804.1569654-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxXMV8c39nCtkaAA--.46678S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Support booting such image by parsing header as per Linux's
specification [1].

This enabled booting vmlinux.efi/vmlinuz.efi shipped by
distros without supplying BIOS.

[1]: https://docs.kernel.org/arch/loongarch/booting.html

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/boot.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 48154cdce6..241c0eef1f 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -15,6 +15,26 @@
 #include "system/reset.h"
 #include "system/qtest.h"
 
+/*
+ * Linux Image Format
+ * https://docs.kernel.org/arch/loongarch/booting.html
+ */
+#define LINUX_PE_MAGIC  0x818223cd
+#define MZ_MAGIC        0x5a4d /* "MZ" */
+
+struct loongarch_linux_hdr {
+    uint32_t mz_magic;
+    uint32_t res0;
+    uint64_t kernel_entry;
+    uint64_t kernel_size;
+    uint64_t load_offset;
+    uint64_t res1;
+    uint64_t res2;
+    uint64_t res3;
+    uint32_t linux_pe_magic;
+    uint32_t pe_header_offset;
+} QEMU_PACKED;
+
 struct memmap_entry *memmap_table;
 unsigned memmap_entries;
 
@@ -171,6 +191,50 @@ static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
     return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
 }
 
+static int64_t load_loongarch_linux_image(const char *filename,
+                                          uint64_t *kernel_entry,
+                                          uint64_t *kernel_low,
+                                          uint64_t *kernel_high)
+{
+    gsize len;
+    ssize_t size;
+    uint8_t *buffer;
+    struct loongarch_linux_hdr *hdr;
+
+    /* Load as raw file otherwise */
+    if (!g_file_get_contents(filename, (char **)&buffer, &len, NULL)) {
+        return -1;
+    }
+    size = len;
+
+    /* Unpack the image if it is a EFI zboot image */
+    if (unpack_efi_zboot_image(&buffer, &size) < 0) {
+        g_free(buffer);
+        return -1;
+    }
+
+    hdr = (struct loongarch_linux_hdr *)buffer;
+
+    if (extract32(le32_to_cpu(hdr->mz_magic), 0, 16) != MZ_MAGIC ||
+        le32_to_cpu(hdr->linux_pe_magic) != LINUX_PE_MAGIC) {
+        g_free(buffer);
+        return -1;
+    }
+
+    /* Early kernel versions may have those fields in virtual address */
+    *kernel_entry = extract64(le64_to_cpu(hdr->kernel_entry),
+                              0, TARGET_PHYS_ADDR_SPACE_BITS);
+    *kernel_low = extract64(le64_to_cpu(hdr->load_offset),
+                            0, TARGET_PHYS_ADDR_SPACE_BITS);
+    *kernel_high = *kernel_low + size;
+
+    rom_add_blob_fixed(filename, buffer, size, *kernel_low);
+
+    g_free(buffer);
+
+    return size;
+}
+
 static int64_t load_kernel_info(struct loongarch_boot_info *info)
 {
     uint64_t kernel_entry, kernel_low, kernel_high;
@@ -181,6 +245,11 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
                            &kernel_entry, &kernel_low,
                            &kernel_high, NULL, 0,
                            EM_LOONGARCH, 1, 0);
+    if (kernel_size < 0) {
+        kernel_size = load_loongarch_linux_image(info->kernel_filename,
+                                                 &kernel_entry, &kernel_low,
+                                                 &kernel_high);
+    }
 
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
-- 
2.43.5


