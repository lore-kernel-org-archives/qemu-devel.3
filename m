Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEC2C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OwC-00073l-Fn; Tue, 21 May 2024 08:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s9Ow4-0006n2-3Z
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:49:44 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s9Ovy-00055n-UO
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:49:43 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxSepfmExmcEkCAA--.1543S3;
 Tue, 21 May 2024 20:49:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxusZdmExmqDkEAA--.12666S5; 
 Tue, 21 May 2024 20:49:35 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] hw/loongarch/virt: Use MemTxAttrs interface for misc
 ops
Date: Tue, 21 May 2024 20:32:25 +0800
Message-Id: <20240521123225.231072-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240521123225.231072-1-gaosong@loongson.cn>
References: <20240521123225.231072-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxusZdmExmqDkEAA--.12666S5
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

Use MemTxAttrs interface read_with_attrs/write_with_attrs
for virt_iocsr_misc_ops.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e7edc6c9f9..0ab2b6860a 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -866,8 +866,9 @@ static void virt_firmware_init(LoongArchVirtMachineState *lvms)
     }
 }
 
-static void virt_iocsr_misc_write(void *opaque, hwaddr addr,
-                                  uint64_t val, unsigned size)
+static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
+                                         uint64_t val, unsigned size,
+                                         MemTxAttrs attrs)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(opaque);
     uint64_t features;
@@ -875,12 +876,12 @@ static void virt_iocsr_misc_write(void *opaque, hwaddr addr,
     switch (addr) {
     case MISC_FUNC_REG:
         if (!virt_is_veiointc_enabled(lvms)) {
-            return;
+            return MEMTX_OK;
         }
 
         features = address_space_ldl(&lvms->as_iocsr,
                                      EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
-                                     MEMTXATTRS_UNSPECIFIED, NULL);
+                                     attrs, NULL);
         if (val & BIT_ULL(IOCSRM_EXTIOI_EN)) {
             features |= BIT(EXTIOI_ENABLE);
         }
@@ -890,11 +891,15 @@ static void virt_iocsr_misc_write(void *opaque, hwaddr addr,
 
         address_space_stl(&lvms->as_iocsr,
                           EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
-                          features, MEMTXATTRS_UNSPECIFIED, NULL);
+                          features, attrs, NULL);
     }
+
+    return MEMTX_OK;
 }
 
-static uint64_t virt_iocsr_misc_read(void *opaque, hwaddr addr, unsigned size)
+static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
+                                        uint64_t *data,
+                                        unsigned size, MemTxAttrs attrs)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(opaque);
     uint64_t ret = 0;
@@ -924,7 +929,7 @@ static uint64_t virt_iocsr_misc_read(void *opaque, hwaddr addr, unsigned size)
 
         features = address_space_ldl(&lvms->as_iocsr,
                                      EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
-                                     MEMTXATTRS_UNSPECIFIED, NULL);
+                                     attrs, NULL);
         if (features & BIT(EXTIOI_ENABLE)) {
             ret |= BIT_ULL(IOCSRM_EXTIOI_EN);
         }
@@ -933,12 +938,13 @@ static uint64_t virt_iocsr_misc_read(void *opaque, hwaddr addr, unsigned size)
         }
     }
 
-    return ret;
+    *data = ret;
+    return MEMTX_OK;
 }
 
 static const MemoryRegionOps virt_iocsr_misc_ops = {
-    .read  = virt_iocsr_misc_read,
-    .write = virt_iocsr_misc_write,
+    .read_with_attrs  = virt_iocsr_misc_read,
+    .write_with_attrs = virt_iocsr_misc_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
-- 
2.34.1


