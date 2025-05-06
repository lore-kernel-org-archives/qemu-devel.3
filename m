Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0333C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDj0-0006gW-1P; Tue, 06 May 2025 04:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1uCDiv-0006fz-Bn
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:32:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1uCDiq-0004nX-Es
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:32:20 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Ax3eICyRlo7oPWAA--.50967S3;
 Tue, 06 May 2025 16:32:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCxbsX9yBlotW+2AA--.6028S2;
 Tue, 06 May 2025 16:32:00 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>
Subject: [[PATCH V3] hw/loongarch/boot: Adjust the loading position of the
 initrd
Date: Tue,  6 May 2025 16:09:46 +0800
Message-Id: <20250506080946.817092-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxbsX9yBlotW+2AA--.6028S2
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

When only the -kernel parameter is used to load the elf kernel, the initrd
is loaded in the ram. If the initrd size is too large, the loading fails,
resulting in a VM startup failure. This patch first loads initrd near
the kernel.

When the nearby memory space of the kernel is insufficient, it tries to
load it to the starting position of high memory. If there is still not
enough, qemu will report an error and ask the user to increase the memory
space for the virtual machine to boot.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>
Cc: Xianglai Li <lixianglai@loongson.cn>

ChangeLog:
V2->V3:
1. Reduce the references to global variables related to intrd in the newly
added functions
2. Modify the format of the commit message
3. Modify the name of the function find_initrd_loadoffset to
alloc_initrd_memory

V1->V2:
If the low memory is insufficient, the initrd is directly loaded from the start
address of the high memory, and the node0 memory space is not counted. 

 hw/loongarch/boot.c | 52 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 354cf458c8..423c393f29 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -235,6 +235,45 @@ static int64_t load_loongarch_linux_image(const char *filename,
     return size;
 }
 
+static ram_addr_t alloc_initrd_memory(struct loongarch_boot_info *info,
+                uint64_t advice_start, ssize_t rd_size)
+{
+    hwaddr base, ram_size, gap, low_end;
+    ram_addr_t initrd_end, initrd_start;
+
+    base = VIRT_LOWMEM_BASE;
+    gap = VIRT_LOWMEM_SIZE;
+    initrd_start = advice_start;
+    initrd_end = initrd_start + rd_size;
+
+    ram_size = info->ram_size;
+    low_end = base + MIN(ram_size, gap);
+    if (initrd_end <= low_end) {
+        return initrd_start;
+    }
+
+    if (ram_size <= gap) {
+        error_report("The low memory too small for initial ram disk '%s',"
+             "You need to expand the ram",
+             info->initrd_filename);
+        exit(1);
+    }
+
+    /*
+     * Try to load initrd in the high memory
+     */
+    ram_size -= gap;
+    initrd_start = VIRT_HIGHMEM_BASE;
+    if (rd_size <= ram_size) {
+        return initrd_start;
+    }
+
+    error_report("The high memory too small for initial ram disk '%s',"
+         "You need to expand the ram",
+         info->initrd_filename);
+    exit(1);
+}
+
 static int64_t load_kernel_info(struct loongarch_boot_info *info)
 {
     uint64_t kernel_entry, kernel_low, kernel_high;
@@ -262,15 +301,10 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
         initrd_size = get_image_size(info->initrd_filename);
         if (initrd_size > 0) {
             initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
-
-            if (initrd_offset + initrd_size > info->ram_size) {
-                error_report("memory too small for initial ram disk '%s'",
-                             info->initrd_filename);
-                exit(1);
-            }
-
-            initrd_size = load_image_targphys(info->initrd_filename, initrd_offset,
-                                              info->ram_size - initrd_offset);
+            initrd_offset = alloc_initrd_memory(info, initrd_offset,
+                                                initrd_size);
+            initrd_size = load_image_targphys(info->initrd_filename,
+                                              initrd_offset, initrd_size);
         }
 
         if (initrd_size == (target_ulong)-1) {
-- 
2.39.1


