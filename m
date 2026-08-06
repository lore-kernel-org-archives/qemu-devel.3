Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E26C55174
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 02:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrnlV-000590-81; Wed, 05 Aug 2026 22:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wrnlS-00058m-OJ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 22:23:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wrnlP-0006Fv-Mz
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 22:23:22 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxvpsM8HNqbNwKAA--.11628S3;
 Thu, 06 Aug 2026 10:23:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJAxi8QL8HNqA1UlAA--.18159S2;
 Thu, 06 Aug 2026 10:23:08 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, lixianglai@loongson.cn, philmd@oss.qualcomm.com,
 jiaxun.yang@flygoat.com, gaosong <gaosong@loongson.cn>
Subject: [PATCH] hw/loongarch/boot: Check return value of g_strlcpy in
 init_cmdline
Date: Thu,  6 Aug 2026 10:04:10 +0800
Message-Id: <20260806020410.1869776-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxi8QL8HNqA1UlAA--.18159S2
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

From: gaosong <gaosong@loongson.cn>

If the kernel command line is longer than COMMAND_LINE_SIZE - 1, it
will be silently truncated. Check the return value of g_strlcpy and
emit a warning to avoid hard-to-debug kernel misbehavior.

Fixes: 1234567890ab ("hw/loongarch: Add boot support")
Resolves: Coverity CID 1550791
Signed-off-by: gaosong <gaosong@loongson.cn>
---
 hw/loongarch/boot.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index ef8eae237c..d91982fe86 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -212,7 +212,11 @@ static void init_cmdline(struct loongarch_boot_info *info, void *p, void *start)
     info->a0 = 1;
     info->a1 = cmdline_addr;
 
-    g_strlcpy(p, info->kernel_cmdline, COMMAND_LINE_SIZE);
+    if (g_strlcpy(p, info->kernel_cmdline, COMMAND_LINE_SIZE)
+        >= COMMAND_LINE_SIZE) {
+        warn_report("kernel command line truncated to %d bytes",
+                    COMMAND_LINE_SIZE);
+    }
 }
 
 static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
-- 
2.47.3


