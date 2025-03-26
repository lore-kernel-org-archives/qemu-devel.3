Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479BBC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 12:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txPSq-0007hx-UA; Wed, 26 Mar 2025 08:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1txPSn-0007gz-In
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:02:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1txPSj-0002Fd-JG
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:02:29 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxLGvK7ONnNQenAA--.17658S3;
 Wed, 26 Mar 2025 20:02:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxb8fJ7ONn2XRhAA--.26895S2;
 Wed, 26 Mar 2025 20:02:17 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH V2] hw/loongarch/boot: Adjust the loading position of the
 initrd
Date: Wed, 26 Mar 2025 19:40:35 +0800
Message-Id: <20250326114035.712130-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8fJ7ONn2XRhAA--.26895S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When only the -kernel parameter is used to load the elf kernel,
the initrd is loaded in the ram. If the initrd size is too large,
the loading fails, resulting in a VM startup failure.
This patch first loads initrd near the kernel.
When the nearby memory space of the kernel is insufficient,
it tries to load it to the starting position of high memory.
If there is still not enough, qemu will report an error
and ask the user to increase the memory space for the
virtual machine to boot.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>
Cc: Xianglai Li <lixianglai@loongson.cn>

ChangeLog:
V1->V2:
If the low memory is insufficient, the initrd is directly loaded
from the start address of the high memory, and the node0 memory space is not counted.

 hw/loongarch/boot.c | 53 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 354cf458c8..c24edfeb59 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -235,6 +235,48 @@ static int64_t load_loongarch_linux_image(const char *filename,
     return size;
 }
 
+static void find_initrd_loadoffset(struct loongarch_boot_info *info,
+                uint64_t kernel_high, ssize_t kernel_size)
+{
+    hwaddr base, size, gap, low_end;
+    ram_addr_t initrd_end, initrd_start;
+
+    base = VIRT_LOWMEM_BASE;
+    gap = VIRT_LOWMEM_SIZE;
+    initrd_start = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
+    initrd_end = initrd_start + initrd_size;
+
+    size = info->ram_size;
+    low_end = base + MIN(size, gap);
+    if (initrd_end <= low_end) {
+        initrd_offset = initrd_start;
+        return ;
+    }
+
+    if (size <= gap) {
+        error_report("The low memory too small for initial ram disk '%s',"
+             "You need to expand the memory space",
+             info->initrd_filename);
+        exit(1);
+    }
+
+    /*
+     * Try to load initrd in the high memory
+     */
+    size -= gap;
+    base = VIRT_HIGHMEM_BASE;
+    initrd_start = ROUND_UP(base, 64 * KiB);
+    if (initrd_size <= size) {
+        initrd_offset = initrd_start;
+        return ;
+    }
+
+    error_report("The high memory too small for initial ram disk '%s',"
+         "You need to expand the memory space",
+         info->initrd_filename);
+    exit(1);
+}
+
 static int64_t load_kernel_info(struct loongarch_boot_info *info)
 {
     uint64_t kernel_entry, kernel_low, kernel_high;
@@ -261,16 +303,9 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
     if (info->initrd_filename) {
         initrd_size = get_image_size(info->initrd_filename);
         if (initrd_size > 0) {
-            initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
-
-            if (initrd_offset + initrd_size > info->ram_size) {
-                error_report("memory too small for initial ram disk '%s'",
-                             info->initrd_filename);
-                exit(1);
-            }
-
+            find_initrd_loadoffset(info, kernel_high, kernel_size);
             initrd_size = load_image_targphys(info->initrd_filename, initrd_offset,
-                                              info->ram_size - initrd_offset);
+                                              initrd_size);
         }
 
         if (initrd_size == (target_ulong)-1) {
-- 
2.39.1


