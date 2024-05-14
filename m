Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AADC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 02:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6iGG-0004ad-2q; Mon, 13 May 2024 22:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s6iGD-0004aQ-Fs
 for qemu-devel@nongnu.org; Mon, 13 May 2024 22:51:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s6iGA-00057k-Lh
 for qemu-devel@nongnu.org; Mon, 13 May 2024 22:51:25 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxiPCd0UJmNYEMAA--.30288S3;
 Tue, 14 May 2024 10:51:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx0VWd0UJm48wdAA--.36788S2; 
 Tue, 14 May 2024 10:51:09 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] hw/loongarch: Add VM mode in IOCSR feature register in kvm
 mode
Date: Tue, 14 May 2024 10:51:09 +0800
Message-Id: <20240514025109.3238398-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx0VWd0UJm48wdAA--.36788S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
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

If VM runs in kvm mode, VM mode is added in IOCSR feature register.
So guest can detect kvm hypervisor type and enable possible pv functions.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index d87d9be576..44bcf25aee 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -10,6 +10,7 @@
 #include "qapi/error.h"
 #include "hw/boards.h"
 #include "hw/char/serial.h"
+#include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
 #include "sysemu/runstate.h"
@@ -840,18 +841,23 @@ static void virt_iocsr_misc_write(void *opaque, hwaddr addr,
 
 static uint64_t virt_iocsr_misc_read(void *opaque, hwaddr addr, unsigned size)
 {
+    uint64_t ret;
+
     switch (addr) {
     case VERSION_REG:
         return 0x11ULL;
     case FEATURE_REG:
-        return 1ULL << IOCSRF_MSI | 1ULL << IOCSRF_EXTIOI |
-               1ULL << IOCSRF_CSRIPI;
+        ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | BIT(IOCSRF_CSRIPI);
+        if (kvm_enabled()) {
+            ret |= BIT(IOCSRF_VM);
+        }
+        return ret;
     case VENDOR_REG:
         return 0x6e6f73676e6f6f4cULL; /* "Loongson" */
     case CPUNAME_REG:
         return 0x303030354133ULL;     /* "3A5000" */
     case MISC_FUNC_REG:
-        return 1ULL << IOCSRM_EXTIOI_EN;
+        return BIT_ULL(IOCSRM_EXTIOI_EN);
     }
     return 0ULL;
 }
-- 
2.39.3


