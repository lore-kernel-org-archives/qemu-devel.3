Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68D3CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 12:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu9Ib-0004zr-5n; Thu, 04 Sep 2025 08:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uu9IV-0004yG-OR
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 08:42:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uu9IB-0007wO-V0
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 08:42:36 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cxbb8gibloAaoGAA--.13037S3;
 Thu, 04 Sep 2025 20:42:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxdOQbiblo4QJ+AA--.6028S10;
 Thu, 04 Sep 2025 20:42:08 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v6 08/11] hw/loongarch: Implement avec set irq
Date: Thu,  4 Sep 2025 20:18:37 +0800
Message-Id: <20250904121840.2023683-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250904121840.2023683-1-gaosong@loongson.cn>
References: <20250904121840.2023683-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxdOQbiblo4QJ+AA--.6028S10
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Implement avec set irq and update CSR_MSIS.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_avec.c         | 58 ++++++++++++++++++++++++++++++--
 include/hw/intc/loongarch_avec.h |  3 ++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
index 1f9f376898..03a20a7b60 100644
--- a/hw/intc/loongarch_avec.c
+++ b/hw/intc/loongarch_avec.c
@@ -16,6 +16,13 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "hw/qdev-properties.h"
+#include "target/loongarch/cpu.h"
+#include "qemu/error-report.h"
+
+/* msg addr field */
+FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
+FIELD(MSG_ADDR, CPU_NUM, 12, 8)
+FIELD(MSG_ADDR, FIX, 28, 12)
 
 static uint64_t loongarch_avec_mem_read(void *opaque,
                                         hwaddr addr, unsigned size)
@@ -23,13 +30,60 @@ static uint64_t loongarch_avec_mem_read(void *opaque,
     return 0;
 }
 
+static void do_set_vcpu_avec_irq(CPUState *cs, run_on_cpu_data data)
+{
+    AVECCore *core = data.host_ptr;
+    CPULoongArchState *env;
+
+    assert(cs->cpu_index == core->dest_cpu);
+    env = &LOONGARCH_CPU(cs)->env;
+    if (core->level) {
+        set_bit(core->pending, &env->CSR_MSGIS[core->pending / 64]);
+    }
+    g_free(core);
+}
+
+
+static void avec_update_csr(AVECCore *core, int cpu_num,
+                            int irq_num, int level)
+{
+    CPUState *cs = qemu_get_cpu(cpu_num);
+
+    core->pending = irq_num;
+    core->dest_cpu = cpu_num;
+    core->level = level;
+    async_run_on_cpu(cs, do_set_vcpu_avec_irq,
+                         RUN_ON_CPU_HOST_PTR(core));
+}
+
+static void avec_set_irq(LoongArchAVECState *s, int cpu_num,
+                         int irq_num, int level)
+{
+    AVECCore *core;
+
+    core = g_new(AVECCore, 1);
+
+    if (level) {
+        avec_update_csr(core, cpu_num, irq_num, level);
+    }
+    qemu_set_irq(s->cpu[cpu_num].parent_irq, level);
+}
+
 static void loongarch_avec_mem_write(void *opaque, hwaddr addr,
                                      uint64_t val, unsigned size)
 {
-    return;
+    int irq_num, cpu_num = 0;
+    LoongArchAVECState *s = LOONGARCH_AVEC(opaque);
+    uint64_t msg_addr = addr + VIRT_AVEC_BASE;
+    CPUState *cs;
+
+    cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
+    cs = cpu_by_arch_id(cpu_num);
+    cpu_num = cs->cpu_index;
+    irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
+    avec_set_irq(s, cpu_num, irq_num, 1);
 }
 
-
 static const MemoryRegionOps loongarch_avec_ops = {
     .read = loongarch_avec_mem_read,
     .write = loongarch_avec_mem_write,
diff --git a/include/hw/intc/loongarch_avec.h b/include/hw/intc/loongarch_avec.h
index 3e8cf7d2c1..83656f8df4 100644
--- a/include/hw/intc/loongarch_avec.h
+++ b/include/hw/intc/loongarch_avec.h
@@ -18,6 +18,9 @@ OBJECT_DECLARE_TYPE(LoongArchAVECState, LoongArchAVECClass, LOONGARCH_AVEC)
 typedef struct AVECCore {
     CPUState *cpu;
     qemu_irq parent_irq;
+    uint64_t pending;
+    uint64_t dest_cpu;
+    bool   level;
     uint64_t arch_id;
 } AVECCore;
 
-- 
2.41.0


