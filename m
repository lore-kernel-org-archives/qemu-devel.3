Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BDFC87FCC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 01:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf7YF-0000m9-2S; Thu, 24 Jul 2025 21:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uf7Y9-0000PH-5O
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:48:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uf7Y5-0005FZ-R6
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:48:40 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxbeJr4oJoGpIxAQ--.61817S3;
 Fri, 25 Jul 2025 09:48:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxH8Jq4oJoGKAlAA--.8750S2;
 Fri, 25 Jul 2025 09:48:27 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn,
	lixianglai@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v2] hw/intc/loongarch_ipi: use logical CPU ID for
 kvm_ipi_access_regs
Date: Fri, 25 Jul 2025 09:25:28 +0800
Message-Id: <20250725012528.2582498-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxH8Jq4oJoGKAlAA--.8750S2
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

QEMU reboot after inserting no-configuous cpus may start failed
becaue the vcpu context may not have created on KVM, On QEMU side use logical CPU ID
for kvm_ipi_access_regs and do some check. On KVM use kvm_get_vcpu_by_id() get vcpu.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_ipi_kvm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/intc/loongarch_ipi_kvm.c b/hw/intc/loongarch_ipi_kvm.c
index 4cb3acc921..d0a2f2343f 100644
--- a/hw/intc/loongarch_ipi_kvm.c
+++ b/hw/intc/loongarch_ipi_kvm.c
@@ -23,14 +23,19 @@ static void kvm_ipi_access_regs(void *opaque, bool write)
     LoongarchIPIState *lis = LOONGARCH_IPI(opaque);
     IPICore *core;
     uint64_t attr;
-    int cpu, fd = lis->dev_fd;
+    int i, cpu, fd = lis->dev_fd;
 
     if (fd == 0) {
         return;
     }
 
-    for (cpu = 0; cpu < ipi->num_cpu; cpu++) {
-        core = &ipi->cpu[cpu];
+    for (i = 0; i < ipi->num_cpu; i++) {
+        core = &ipi->cpu[i];
+        if (core == NULL || core->cpu == NULL) {
+            continue;
+        }
+        cpu = core->cpu->cpu_index;
+
         attr = (cpu << 16) | CORE_STATUS_OFF;
         kvm_ipi_access_reg(fd, attr, &core->status, write);
 
-- 
2.43.0


