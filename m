Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BABC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmtcx-0003tj-PP; Tue, 25 Feb 2025 07:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tmtcO-0003jc-LP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:01:02 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tmtcJ-0006Vh-6V
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:00:55 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxvnLusL1nMBaCAA--.27006S3;
 Tue, 25 Feb 2025 20:00:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxLsfpsL1n2uMnAA--.19507S6;
 Tue, 25 Feb 2025 20:00:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 04/11] target/loongarch: Add post init function for kvm mode
Date: Tue, 25 Feb 2025 20:00:34 +0800
Message-Id: <20250225120041.1652869-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250225120041.1652869-1-maobibo@loongson.cn>
References: <20250225120041.1652869-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsfpsL1n2uMnAA--.19507S6
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
With paravirt features in future, post init function is added
for kvm mode, so that property for these features will be created
in kvm post init function.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c     | 2 +-
 target/loongarch/cpu.h     | 8 ++++++++
 target/loongarch/kvm/kvm.c | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f203fcc7d7..012fcfbfda 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -765,7 +765,7 @@ void loongarch_cpu_post_init(Object *obj)
                                  loongarch_set_pmu);
         object_property_set_description(obj, "pmu",
                                    "Set off to performance monitor unit.");
-
+        kvm_loongarch_cpu_post_init(cpu);
     } else {
         cpu->lbt = ON_OFF_AUTO_OFF;
         cpu->pmu = ON_OFF_AUTO_OFF;
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index f2a23b7a43..74dffcb552 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -491,4 +491,12 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
 
 void loongarch_cpu_post_init(Object *obj);
 
+#ifdef CONFIG_KVM
+void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu);
+#else
+static inline void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
+{
+}
+#endif
+
 #endif /* LOONGARCH_CPU_H */
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 27df02fa3a..2d2fb1e261 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1016,6 +1016,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return ret;
 }
 
+void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
+{
+}
+
 int kvm_arch_destroy_vcpu(CPUState *cs)
 {
     return 0;
-- 
2.43.5


