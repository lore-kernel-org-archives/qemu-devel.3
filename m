Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8BACAC5B7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 06:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1fYo-0008S7-7E; Thu, 25 Sep 2025 02:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v1fYX-00083E-Df
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 02:34:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v1fXu-0000Uk-A9
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 02:33:59 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxLvAx4tRo2WsOAA--.30978S3;
 Thu, 25 Sep 2025 14:33:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJBxpeQq4tRoj+iuAA--.30453S10;
 Thu, 25 Sep 2025 14:33:20 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 08/11] hw/loongarch: Implement dintc set irq
Date: Thu, 25 Sep 2025 14:09:33 +0800
Message-Id: <20250925060936.898618-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250925060936.898618-1-gaosong@loongson.cn>
References: <20250925060936.898618-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpeQq4tRoj+iuAA--.30453S10
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
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

Implement dintc set irq and update CSR_MSGIS.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20250916122109.749813-9-gaosong@loongson.cn>
---
 hw/intc/loongarch_dintc.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
index 598c666ec6..08e70a0a0a 100644
--- a/hw/intc/loongarch_dintc.c
+++ b/hw/intc/loongarch_dintc.c
@@ -16,6 +16,14 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "hw/qdev-properties.h"
+#include "target/loongarch/cpu.h"
+#include "qemu/error-report.h"
+#include "system/hw_accel.h"
+
+/* msg addr field */
+FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
+FIELD(MSG_ADDR, CPU_NUM, 12, 8)
+FIELD(MSG_ADDR, FIX, 28, 12)
 
 static uint64_t loongarch_dintc_mem_read(void *opaque,
                                         hwaddr addr, unsigned size)
@@ -23,13 +31,33 @@ static uint64_t loongarch_dintc_mem_read(void *opaque,
     return 0;
 }
 
+static void do_set_vcpu_dintc_irq(CPUState *cs, run_on_cpu_data data)
+{
+    int irq = data.host_int;
+    CPULoongArchState *env;
+
+    env = &LOONGARCH_CPU(cs)->env;
+    cpu_synchronize_state(cs);
+    set_bit(irq, &env->CSR_MSGIS[0]);
+}
+
 static void loongarch_dintc_mem_write(void *opaque, hwaddr addr,
                                      uint64_t val, unsigned size)
 {
-    return;
+    int irq_num, cpu_num = 0;
+    LoongArchDINTCState *s = LOONGARCH_DINTC(opaque);
+    uint64_t msg_addr = addr + VIRT_DINTC_BASE;
+    CPUState *cs;
+
+    cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
+    cs = cpu_by_arch_id(cpu_num);
+    irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
+
+    async_run_on_cpu(cs, do_set_vcpu_dintc_irq,
+                         RUN_ON_CPU_HOST_INT(irq_num));
+    qemu_set_irq(s->cpu[cpu_num].parent_irq, 1);
 }
 
-
 static const MemoryRegionOps loongarch_dintc_ops = {
     .read = loongarch_dintc_mem_read,
     .write = loongarch_dintc_mem_write,
-- 
2.47.0


