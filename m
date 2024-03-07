Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10176C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 15:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riFg2-000699-Ck; Thu, 07 Mar 2024 10:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1riFft-00067o-9r
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:28:50 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1riFfn-0005dj-05
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:28:48 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxVfEn3ellCfgVAA--.54852S3;
 Thu, 07 Mar 2024 23:28:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxdMwk3ellNlBQAA--.33344S4; 
 Thu, 07 Mar 2024 23:28:39 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL v2 02/17] hw/loongarch: Add load initrd
Date: Thu,  7 Mar 2024 23:28:20 +0800
Message-Id: <20240307152835.299233-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240307152835.299233-1-gaosong@loongson.cn>
References: <20240307152835.299233-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxdMwk3ellNlBQAA--.33344S4
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

we load initrd ramdisk after kernel_high address

Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240301093839.663947-3-gaosong@loongson.cn>
---
 hw/loongarch/boot.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 0f2bc15fdf..3075c276d4 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -21,7 +21,8 @@ static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
 
 static int64_t load_kernel_info(struct loongarch_boot_info *info)
 {
-    uint64_t kernel_entry, kernel_low, kernel_high;
+    uint64_t kernel_entry, kernel_low, kernel_high, initrd_size;
+    ram_addr_t initrd_offset;
     ssize_t kernel_size;
 
     kernel_size = load_elf(info->kernel_filename, NULL,
@@ -36,6 +37,32 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
                      load_elf_strerror(kernel_size));
         exit(1);
     }
+
+    if (info->initrd_filename) {
+        initrd_size = get_image_size(info->initrd_filename);
+        if (initrd_size > 0) {
+            initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
+
+            if (initrd_offset + initrd_size > info->ram_size) {
+                error_report("memory too small for initial ram disk '%s'",
+                             info->initrd_filename);
+                exit(1);
+            }
+
+            initrd_size = load_image_targphys(info->initrd_filename, initrd_offset,
+                                              info->ram_size - initrd_offset);
+        }
+
+        if (initrd_size == (target_ulong)-1) {
+            error_report("could not load initial ram disk '%s'",
+                         info->initrd_filename);
+            exit(1);
+        }
+    } else {
+        error_report("Need initrd!");
+        exit(1);
+    }
+
     return kernel_entry;
 }
 
-- 
2.34.1


