Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006E1C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wepGR-0003r8-TM; Wed, 01 Jul 2026 03:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wepGP-0003r0-6f
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 03:21:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wepGM-0002zQ-Ln
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 03:21:40 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxNvD4v0Rq1GEAAA--.2226S3;
 Wed, 01 Jul 2026 15:21:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxGOD2v0RqtCC6AA--.25525S2;
 Wed, 01 Jul 2026 15:21:27 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: thuth@redhat.com,
	qemu-devel@nongnu.org
Cc: maobibo@loongson.cn,
	berrange@redhat.com,
	lixianglai@loongson.cn
Subject: [PATCH] hw/intc/loongarch_dintc: Fix OOB access in DINT MMIO write
 handler
Date: Wed,  1 Jul 2026 14:54:54 +0800
Message-Id: <20260701065454.1976188-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxGOD2v0RqtCC6AA--.25525S2
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

Validate guest-controlled cpu_num before using it to index the cpu[] array
or pass to async_run_on_cpu(). Without this check, a malicious guest can
trigger a NULL pointer dereference in async_run_on_cpu() and an
out-of-bounds array access in qemu_set_irq(), causing host crash.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3616
Fixes: 0d148eaf5a3e ("hw/loongarch: Implement dintc set irq")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_dintc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
index c877a8003b..e40292887c 100644
--- a/hw/intc/loongarch_dintc.c
+++ b/hw/intc/loongarch_dintc.c
@@ -19,6 +19,7 @@
 #include "target/loongarch/cpu.h"
 #include "qemu/error-report.h"
 #include "system/hw_accel.h"
+#include "qemu/log.h"
 
 /* msg addr field */
 FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
@@ -52,7 +53,19 @@ static void loongarch_dintc_mem_write(void *opaque, hwaddr addr,
     CPUState *cs;
 
     cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
+
+    /* Validate cpu_num against the configured number of CPUs */
+    if (cpu_num >= s->num_cpu) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "loongarch-dintc: invalid cpu number%d\n", cpu_num);
+        return;
+    }
     cs = cpu_by_arch_id(cpu_num);
+    if (!cs) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "loongarch-dintc: no CPU for arch_id %d\n", cpu_num);
+        return;
+    }
     irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
 
     async_run_on_cpu(cs, do_set_vcpu_dintc_irq,
-- 
2.47.3


