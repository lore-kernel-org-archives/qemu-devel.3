Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73CDC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 16:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riGvM-0007D0-06; Thu, 07 Mar 2024 11:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1riGvI-0007AG-HI
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:48:48 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1riGvC-0002VC-5E
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:48:46 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxmfDm7+llGAEWAA--.54988S3;
 Fri, 08 Mar 2024 00:48:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxnhPj7+llNmpQAA--.27604S10; 
 Fri, 08 Mar 2024 00:48:38 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 08/17] hw/loongarch: Init efi_fdt table
Date: Fri,  8 Mar 2024 00:48:26 +0800
Message-Id: <20240307164835.300412-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240307164835.300412-1-gaosong@loongson.cn>
References: <20240307164835.300412-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxnhPj7+llNmpQAA--.27604S10
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240301093839.663947-9-gaosong@loongson.cn>
---
 hw/loongarch/boot.c         | 11 +++++++++++
 include/hw/loongarch/boot.h |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 6126a37858..c6c6e6d194 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -112,6 +112,16 @@ static void init_efi_initrd_table(struct efi_system_table *systab,
     initrd_table->size = initrd_size;
 }
 
+static void init_efi_fdt_table(struct efi_system_table *systab)
+{
+    efi_guid_t tbl_guid = DEVICE_TREE_GUID;
+
+    /* efi_configuration_table 3 */
+    guidcpy(&systab->tables[2].guid, &tbl_guid);
+    systab->tables[2].table = (void *)0x100000; /* fdt_base 1MiB */
+    systab->nr_tables = 3;
+}
+
 static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
 {
     void *bp_tables_start;
@@ -137,6 +147,7 @@ static void init_systab(struct loongarch_boot_info *info, void *p, void *start)
                   sizeof(efi_memory_desc_t) * memmap_entries, 64);
     init_efi_initrd_table(systab, p, start);
     p += ROUND_UP(sizeof(struct efi_initrd), 64);
+    init_efi_fdt_table(systab);
 
     systab->tables = (struct efi_configuration_table *)(bp_tables_start - start);
 }
diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index ddcb279874..9de673a0fd 100644
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
-- 
2.34.1


