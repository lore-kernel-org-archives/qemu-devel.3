Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075F0C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 03:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjsGL-0001WC-TQ; Sun, 16 Feb 2025 22:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tjsGB-0001SS-GS
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 22:57:31 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tjsG7-0006r2-NV
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 22:57:31 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxeXGfs7JnrV54AA--.11124S3;
 Mon, 17 Feb 2025 11:57:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxn8Wfs7JnbXwXAA--.24352S3;
 Mon, 17 Feb 2025 11:57:19 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org,
	lixianglai <lixianglai@loongson.cn>
Subject: [PATCH 1/8] target/loongarch: Add post init function for kvm mode
Date: Mon, 17 Feb 2025 11:57:11 +0800
Message-Id: <20250217035718.3977137-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250217035718.3977137-1-maobibo@loongson.cn>
References: <20250217035718.3977137-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8Wfs7JnbXwXAA--.24352S3
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

Some features such as LBT and PMU are implemented in kvm mode,
With para-virt features in future, post init function is added
for kvm mode, so that property for these features will be created
in kvm post init function.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c               | 2 +-
 target/loongarch/kvm/kvm.c           | 4 ++++
 target/loongarch/kvm/kvm_loongarch.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index e91f4a5239..40f753167f 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -759,7 +759,7 @@ void loongarch_cpu_post_init(Object *obj)
                                  loongarch_set_pmu);
         object_property_set_description(obj, "pmu",
                                    "Set off to performance monitor unit.");
-
+        kvm_loongarch_cpu_post_init(cpu);
     } else {
         cpu->lbt = ON_OFF_AUTO_OFF;
         cpu->pmu = ON_OFF_AUTO_OFF;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index a3f55155b0..516aba180f 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1009,6 +1009,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return ret;
 }
 
+void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
+{
+}
+
 int kvm_arch_destroy_vcpu(CPUState *cs)
 {
     return 0;
diff --git a/target/loongarch/kvm/kvm_loongarch.h b/target/loongarch/kvm/kvm_loongarch.h
index 1051a341ec..23793f2198 100644
--- a/target/loongarch/kvm/kvm_loongarch.h
+++ b/target/loongarch/kvm/kvm_loongarch.h
@@ -11,6 +11,7 @@
 #define QEMU_KVM_LOONGARCH_H
 
 int  kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level);
+void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu);
 void kvm_arch_reset_vcpu(CPUState *cs);
 
 #endif
-- 
2.39.3


