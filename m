Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA74E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 07:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUhfI-0001V1-9N; Mon, 06 Jan 2025 02:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tUhfC-0001U5-M9
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 02:36:38 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tUhf9-00066A-RX
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 02:36:38 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx_3P8h3tn4IVeAA--.479S3;
 Mon, 06 Jan 2025 15:36:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxzsX7h3tnJDQWAA--.21955S5;
 Mon, 06 Jan 2025 15:36:28 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] hw/intc/loongarch_extioi: Add irq routing support from
 physical id
Date: Mon,  6 Jan 2025 15:36:27 +0800
Message-Id: <20250106073627.3403177-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250106073627.3403177-1-maobibo@loongson.cn>
References: <20250106073627.3403177-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxzsX7h3tnJDQWAA--.21955S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
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

The simliar with IPI interrupt controller, physical cpu id is used
for irq routing for extioi interrupt controller.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index d18f47def7..f3055ec4d2 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -15,6 +15,23 @@
 #include "hw/intc/loongarch_extioi.h"
 #include "trace.h"
 
+static int extioi_get_index_from_archid(LoongArchExtIOICommonState *s,
+                                        uint64_t arch_id)
+{
+    int i;
+
+    for (i = 0; i < s->num_cpu; i++) {
+        if (s->cpu[i].arch_id == arch_id) {
+            break;
+        }
+    }
+
+    if ((i < s->num_cpu) && s->cpu[i].cpu) {
+        return i;
+    }
+
+    return -1;
+}
 
 static void extioi_update_irq(LoongArchExtIOICommonState *s, int irq, int level)
 {
@@ -125,7 +142,7 @@ static inline void extioi_enable_irq(LoongArchExtIOICommonState *s, int index,\
 static inline void extioi_update_sw_coremap(LoongArchExtIOICommonState *s,
                                             int irq, uint64_t val, bool notify)
 {
-    int i, cpu;
+    int i, cpu, cpuid;
 
     /*
      * loongarch only support little endian,
@@ -134,12 +151,17 @@ static inline void extioi_update_sw_coremap(LoongArchExtIOICommonState *s,
     val = cpu_to_le64(val);
 
     for (i = 0; i < 4; i++) {
-        cpu = val & 0xff;
+        cpuid = val & 0xff;
         val = val >> 8;
 
         if (!(s->status & BIT(EXTIOI_ENABLE_CPU_ENCODE))) {
-            cpu = ctz32(cpu);
-            cpu = (cpu >= 4) ? 0 : cpu;
+            cpuid = ctz32(cpuid);
+            cpuid = (cpuid >= 4) ? 0 : cpuid;
+        }
+
+        cpu = extioi_get_index_from_archid(s, cpuid);
+        if (cpu < 0) {
+            continue;
         }
 
         if (s->sw_coremap[irq + i] == cpu) {
-- 
2.39.3


