Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272F9C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 04:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF4KN-0007W5-2D; Thu, 06 Jun 2024 00:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sF4KF-0007Tb-92
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:02:07 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sF4KC-00013h-DB
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:02:07 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxHuu3NGFm_hEEAA--.17231S3;
 Thu, 06 Jun 2024 12:01:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxVcWzNGFmgHQWAA--.45267S6; 
 Thu, 06 Jun 2024 12:01:58 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 4/6] hw/loongarch/virt: Use MemTxAttrs interface for misc ops
Date: Thu,  6 Jun 2024 12:01:53 +0800
Message-Id: <20240606040155.2607422-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240606040155.2607422-1-gaosong@loongson.cn>
References: <20240606040155.2607422-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxVcWzNGFmgHQWAA--.45267S6
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

Use MemTxAttrs interface read_with_attrs/write_with_attrs
for virt_iocsr_misc_ops.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20240528083855.1912757-3-gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2b5ae45939..0cef33a904 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -900,37 +900,49 @@ static void virt_firmware_init(LoongArchVirtMachineState *lvms)
 }
 
 
-static void virt_iocsr_misc_write(void *opaque, hwaddr addr,
-                                  uint64_t val, unsigned size)
+static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
+                                         uint64_t val, unsigned size,
+                                         MemTxAttrs attrs)
 {
+    return MEMTX_OK;
 }
 
-static uint64_t virt_iocsr_misc_read(void *opaque, hwaddr addr, unsigned size)
+static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
+                                        uint64_t *data,
+                                        unsigned size, MemTxAttrs attrs)
 {
-    uint64_t ret;
+    uint64_t ret = 0;
 
     switch (addr) {
     case VERSION_REG:
-        return 0x11ULL;
+        ret = 0x11ULL;
+        break;
     case FEATURE_REG:
         ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | BIT(IOCSRF_CSRIPI);
         if (kvm_enabled()) {
             ret |= BIT(IOCSRF_VM);
         }
-        return ret;
+        break;
     case VENDOR_REG:
-        return 0x6e6f73676e6f6f4cULL; /* "Loongson" */
+        ret = 0x6e6f73676e6f6f4cULL; /* "Loongson" */
+        break;
     case CPUNAME_REG:
-        return 0x303030354133ULL;     /* "3A5000" */
+        ret = 0x303030354133ULL;     /* "3A5000" */
+        break;
     case MISC_FUNC_REG:
-        return BIT_ULL(IOCSRM_EXTIOI_EN);
+        ret = BIT_ULL(IOCSRM_EXTIOI_EN);
+        break;
+    default:
+        g_assert_not_reached();
     }
-    return 0ULL;
+
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


