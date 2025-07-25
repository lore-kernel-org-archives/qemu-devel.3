Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084C3C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 08:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufDts-0006Ov-4V; Fri, 25 Jul 2025 04:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1ufDtj-0006Fy-Fq
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:35:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1ufDtf-0003WG-W6
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:35:23 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxjXLBQYNolMExAQ--.35232S3;
 Fri, 25 Jul 2025 16:35:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxdOS_QYNoKBsmAA--.64433S2;
 Fri, 25 Jul 2025 16:35:12 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn,
	lixianglai@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH] hw/intc/loongarch_ipi: Fix start fail with smp cpu < smp
 maxcpus on KVM
Date: Fri, 25 Jul 2025 16:12:13 +0800
Message-Id: <20250725081213.3867592-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxdOS_QYNoKBsmAA--.64433S2
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

QEMU start failed when smp cpu < smp maxcpus , because qemu send a NULL
cpu to KVM, this patch adds a check for kvm_ipi_access_regs() to fix it.

run with '-smp 1,maxcpus=4,sockets=4,cores=1,threads=1'

we got:
Unexpected error in kvm_device_access() at ../accel/kvm/kvm-all.c:3477:
qemu-system-loongarch64: KVM_SET_DEVICE_ATTR failed: Group 1073741825 attr 0x0000000000010000: Invalid argument

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_ipi_kvm.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/hw/intc/loongarch_ipi_kvm.c b/hw/intc/loongarch_ipi_kvm.c
index 4cb3acc921..dd4c367abf 100644
--- a/hw/intc/loongarch_ipi_kvm.c
+++ b/hw/intc/loongarch_ipi_kvm.c
@@ -23,36 +23,41 @@ static void kvm_ipi_access_regs(void *opaque, bool write)
     LoongarchIPIState *lis = LOONGARCH_IPI(opaque);
     IPICore *core;
     uint64_t attr;
-    int cpu, fd = lis->dev_fd;
+    int i, cpu_index, fd = lis->dev_fd;
 
     if (fd == 0) {
         return;
     }
 
-    for (cpu = 0; cpu < ipi->num_cpu; cpu++) {
-        core = &ipi->cpu[cpu];
-        attr = (cpu << 16) | CORE_STATUS_OFF;
+    for (i = 0; i < ipi->num_cpu; i++) {
+        core = &ipi->cpu[i];
+        if (core->cpu == NULL) {
+            continue;
+        }
+        cpu_index = i;
+
+        attr = (cpu_index << 16) | CORE_STATUS_OFF;
         kvm_ipi_access_reg(fd, attr, &core->status, write);
 
-        attr = (cpu << 16) | CORE_EN_OFF;
+        attr = (cpu_index << 16) | CORE_EN_OFF;
         kvm_ipi_access_reg(fd, attr, &core->en, write);
 
-        attr = (cpu << 16) | CORE_SET_OFF;
+        attr = (cpu_index << 16) | CORE_SET_OFF;
         kvm_ipi_access_reg(fd, attr, &core->set, write);
 
-        attr = (cpu << 16) | CORE_CLEAR_OFF;
+        attr = (cpu_index << 16) | CORE_CLEAR_OFF;
         kvm_ipi_access_reg(fd, attr, &core->clear, write);
 
-        attr = (cpu << 16) | CORE_BUF_20;
+        attr = (cpu_index << 16) | CORE_BUF_20;
         kvm_ipi_access_reg(fd, attr, &core->buf[0], write);
 
-        attr = (cpu << 16) | CORE_BUF_28;
+        attr = (cpu_index << 16) | CORE_BUF_28;
         kvm_ipi_access_reg(fd, attr, &core->buf[2], write);
 
-        attr = (cpu << 16) | CORE_BUF_30;
+        attr = (cpu_index << 16) | CORE_BUF_30;
         kvm_ipi_access_reg(fd, attr, &core->buf[4], write);
 
-        attr = (cpu << 16) | CORE_BUF_38;
+        attr = (cpu_index << 16) | CORE_BUF_38;
         kvm_ipi_access_reg(fd, attr, &core->buf[6], write);
     }
 }
-- 
2.43.0


