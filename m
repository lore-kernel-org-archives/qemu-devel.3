Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0DEC02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 08:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgfuH-0003Fn-GI; Sat, 08 Feb 2025 03:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1tgfuE-0003FI-IE
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 03:09:38 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1tgfuB-00072h-WB
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 03:09:38 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxSOE0Eadn1lFvAA--.19206S3;
 Sat, 08 Feb 2025 16:09:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxXsUzEadnAfcFAA--.23256S2;
 Sat, 08 Feb 2025 16:09:24 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <Maobibo@loongson.cn>,
	Song Gao <gaosong@loongson.cn>
Subject: [PATCH V2] target/loongarch: fix vcpu reset command word issue
Date: Sat,  8 Feb 2025 15:48:08 +0800
Message-Id: <20250208074808.5615-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXsUzEadnAfcFAA--.23256S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
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

When the KVM_REG_LOONGARCH_VCPU_RESET command word
is sent to the kernel through the kvm_set_one_reg interface,
the parameter source needs to be a legal address,
otherwise the kernel will return an error and the command word
will fail to be sent.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Bibo Mao <Maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>
Cc: Xianglai Li <lixianglai@loongson.cn>

CHANGE:
V2<-V1:
  1.Sets the initial value of the variable and
  adds a function return value judgment and prints a log

 target/loongarch/kvm/kvm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index a3f55155b0..3f499e60ab 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -581,9 +581,14 @@ static int kvm_loongarch_get_lbt(CPUState *cs)
 void kvm_arch_reset_vcpu(CPUState *cs)
 {
     CPULoongArchState *env = cpu_env(cs);
+    int ret = 0;
+    uint64_t unused = 0;
 
     env->mp_state = KVM_MP_STATE_RUNNABLE;
-    kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, 0);
+    ret = kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, &unused);
+    if (ret) {
+        error_report("Failed to set KVM_REG_LOONGARCH_VCPU_RESET");
+    }
 }
 
 static int kvm_loongarch_get_mpstate(CPUState *cs)
-- 
2.39.1


