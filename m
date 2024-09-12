Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E799FEED602
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 13:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sojZm-0003G1-1e; Thu, 12 Sep 2024 09:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sojZg-00030l-RI
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:09:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sojZd-0004pZ-0S
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:09:26 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxTOoB6OJm6eQFAA--.13699S3;
 Thu, 12 Sep 2024 21:09:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front2 (Coremail) with SMTP id qciowMDxl8Xr5+JmR8MFAA--.9219S5;
 Thu, 12 Sep 2024 21:09:20 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 3/7] target/loongarch/kvm: Add vCPU reset function
Date: Thu, 12 Sep 2024 20:51:28 +0800
Message-Id: <20240912125132.268802-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240912125132.268802-1-gaosong@loongson.cn>
References: <20240912125132.268802-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowMDxl8Xr5+JmR8MFAA--.9219S5
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

From: Bibo Mao <maobibo@loongson.cn>

KVM provides interface KVM_REG_LOONGARCH_VCPU_RESET to reset vCPU,
it can be used to clear internal state about kvm kernel. vCPU reset
function is added here for kvm mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240822022827.2273534-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c               | 2 +-
 target/loongarch/kvm/kvm.c           | 5 ++++-
 target/loongarch/kvm/kvm_loongarch.h | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 115922113a..6a569285b8 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -577,7 +577,7 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
     memset(env->tlb, 0, sizeof(env->tlb));
 #endif
     if (kvm_enabled()) {
-        kvm_arch_reset_vcpu(env);
+        kvm_arch_reset_vcpu(cs);
     }
 #endif
 
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index e1be6a6959..4786cd5efa 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -476,9 +476,12 @@ static int kvm_loongarch_put_regs_fp(CPUState *cs)
     return ret;
 }
 
-void kvm_arch_reset_vcpu(CPULoongArchState *env)
+void kvm_arch_reset_vcpu(CPUState *cs)
 {
+    CPULoongArchState *env = cpu_env(cs);
+
     env->mp_state = KVM_MP_STATE_RUNNABLE;
+    kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, 0);
 }
 
 static int kvm_loongarch_get_mpstate(CPUState *cs)
diff --git a/target/loongarch/kvm/kvm_loongarch.h b/target/loongarch/kvm/kvm_loongarch.h
index d945b6bb82..1051a341ec 100644
--- a/target/loongarch/kvm/kvm_loongarch.h
+++ b/target/loongarch/kvm/kvm_loongarch.h
@@ -11,6 +11,6 @@
 #define QEMU_KVM_LOONGARCH_H
 
 int  kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level);
-void kvm_arch_reset_vcpu(CPULoongArchState *env);
+void kvm_arch_reset_vcpu(CPUState *cs);
 
 #endif
-- 
2.34.1


