Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138E9CCD1AB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 02:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBlMg-0007ki-86; Wed, 22 Oct 2025 22:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vBlMc-0007kM-S6
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:47:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vBlMV-0006XY-4Q
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:47:42 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bxnr8_l_loTJcZAA--.53653S3;
 Thu, 23 Oct 2025 10:47:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxmcA+l_lo4ysCAQ--.19467S3;
 Thu, 23 Oct 2025 10:47:27 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/loongarch: Add PMU migration support in KVM mode
Date: Thu, 23 Oct 2025 10:47:24 +0800
Message-Id: <20251023024726.2995960-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251023024726.2995960-1-maobibo@loongson.cn>
References: <20251023024726.2995960-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxmcA+l_lo4ysCAQ--.19467S3
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

PMU is supported in KVM mode. When VM is migrated, PMU register should
be migrated also, otherwise PMU will be disabled after migration.

Here add PMU register save and restore interface and PMU register
state migration is added also.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-csr.h | 10 ++++++
 target/loongarch/cpu.h     |  8 +++++
 target/loongarch/kvm/kvm.c | 64 ++++++++++++++++++++++++++++++++++++++
 target/loongarch/machine.c | 26 ++++++++++++++++
 4 files changed, 108 insertions(+)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 9097fddee1..91c01c5ccc 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -203,6 +203,16 @@ FIELD(CSR_DMW_32, PSEG, 25, 3)
 FIELD(CSR_DMW_32, VSEG, 29, 3)
 FIELD(CSR_DMW_64, VSEG, 60, 4)
 
+/* Performance Counter registers */
+#define LOONGARCH_CSR_PERFCTRL0      0x200
+#define LOONGARCH_CSR_PERFCNTR0      0x201
+#define LOONGARCH_CSR_PERFCTRL1      0x202
+#define LOONGARCH_CSR_PERFCNTR1      0x203
+#define LOONGARCH_CSR_PERFCTRL2      0x204
+#define LOONGARCH_CSR_PERFCNTR2      0x205
+#define LOONGARCH_CSR_PERFCTRL3      0x206
+#define LOONGARCH_CSR_PERFCNTR3      0x207
+
 /* Debug CSRs */
 #define LOONGARCH_CSR_DBG            0x500 /* debug config */
 FIELD(CSR_DBG, DST, 0, 1)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index b8e3b46c3a..264297df3e 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -355,6 +355,14 @@ typedef struct CPUArchState {
     uint64_t CSR_MERRSAVE;
     uint64_t CSR_CTAG;
     uint64_t CSR_DMW[4];
+    uint64_t CSR_PERFCTRL0;
+    uint64_t CSR_PERFCNTR0;
+    uint64_t CSR_PERFCTRL1;
+    uint64_t CSR_PERFCNTR1;
+    uint64_t CSR_PERFCTRL2;
+    uint64_t CSR_PERFCNTR2;
+    uint64_t CSR_PERFCTRL3;
+    uint64_t CSR_PERFCNTR3;
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 4e4f4e79f6..53b2103502 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -155,6 +155,64 @@ static int kvm_loongarch_put_regs_core(CPUState *cs)
     return ret;
 }
 
+static int kvm_loongarch_put_pmu(CPUState *cs)
+{
+    int ret;
+    CPULoongArchState *env = cpu_env(cs);
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+
+    if (cpu->pmu != ON_OFF_AUTO_ON) {
+        return 0;
+    }
+
+    ret  = kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCTRL0),
+                           &env->CSR_PERFCTRL0);
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCNTR0),
+                           &env->CSR_PERFCNTR0);
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCTRL1),
+                           &env->CSR_PERFCTRL1);
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCNTR1),
+                           &env->CSR_PERFCNTR1);
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCTRL2),
+                           &env->CSR_PERFCTRL2);
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCNTR2),
+                           &env->CSR_PERFCNTR2);
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCTRL3),
+                           &env->CSR_PERFCTRL3);
+    ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCNTR3),
+                           &env->CSR_PERFCNTR3);
+    return ret;
+}
+
+static int kvm_loongarch_get_pmu(CPUState *cs)
+{
+    int ret;
+    CPULoongArchState *env = cpu_env(cs);
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+
+    if (cpu->pmu != ON_OFF_AUTO_ON) {
+        return 0;
+    }
+
+    ret  = kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCTRL0),
+                           &env->CSR_PERFCTRL0);
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCNTR0),
+                           &env->CSR_PERFCNTR0);
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCTRL1),
+                           &env->CSR_PERFCTRL1);
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCNTR1),
+                           &env->CSR_PERFCNTR1);
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCTRL2),
+                           &env->CSR_PERFCTRL2);
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCNTR2),
+                           &env->CSR_PERFCNTR2);
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCTRL3),
+                           &env->CSR_PERFCTRL3);
+    ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCNTR3),
+                           &env->CSR_PERFCNTR3);
+    return ret;
+}
+
 static int kvm_loongarch_get_csr(CPUState *cs)
 {
     int ret = 0;
@@ -316,6 +374,8 @@ static int kvm_loongarch_get_csr(CPUState *cs)
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(3)),
                            &env->CSR_DMW[3]);
 
+    ret |= kvm_loongarch_get_pmu(cs);
+
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TVAL),
                            &env->CSR_TVAL);
 
@@ -488,6 +548,9 @@ static int kvm_loongarch_put_csr(CPUState *cs, KvmPutState level)
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(3)),
                            &env->CSR_DMW[3]);
+
+    ret |= kvm_loongarch_put_pmu(cs);
+
     /*
      * timer cfg must be put at last since it is used to enable
      * guest timer
@@ -1021,6 +1084,7 @@ static int kvm_cpu_check_pmu(CPUState *cs, Error **errp)
     }
 
     if (kvm_supported) {
+        cpu->pmu = ON_OFF_AUTO_ON;
         env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMP, 1);
         env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMNUM, 3);
         env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMBITS, 63);
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 0366a50763..0a3febf36d 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -153,6 +153,31 @@ static const VMStateDescription vmstate_lbt = {
     },
 };
 
+static bool pmu_needed(void *opaque)
+{
+    LoongArchCPU *cpu = opaque;
+
+    return cpu->pmu == ON_OFF_AUTO_ON;
+}
+
+static const VMStateDescription vmstate_pmu = {
+    .name = "cpu/pmu",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = pmu_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(env.CSR_PERFCTRL0,   LoongArchCPU),
+        VMSTATE_UINT64(env.CSR_PERFCNTR0,   LoongArchCPU),
+        VMSTATE_UINT64(env.CSR_PERFCTRL1,   LoongArchCPU),
+        VMSTATE_UINT64(env.CSR_PERFCNTR1,   LoongArchCPU),
+        VMSTATE_UINT64(env.CSR_PERFCTRL2,   LoongArchCPU),
+        VMSTATE_UINT64(env.CSR_PERFCNTR2,   LoongArchCPU),
+        VMSTATE_UINT64(env.CSR_PERFCTRL3,   LoongArchCPU),
+        VMSTATE_UINT64(env.CSR_PERFCNTR3,   LoongArchCPU),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
 static bool tlb_needed(void *opaque)
 {
@@ -266,6 +291,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
 #endif
         &vmstate_lbt,
         &vmstate_msgint,
+        &vmstate_pmu,
         NULL
     }
 };
-- 
2.39.3


