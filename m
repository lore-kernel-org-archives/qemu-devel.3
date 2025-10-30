Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2344CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vENqp-0000hH-19; Thu, 30 Oct 2025 04:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vENqm-0000gs-HO
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:17:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vENqf-0003Ax-3O
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:17:40 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxvdIWHwNpiogcAA--.61328S3;
 Thu, 30 Oct 2025 16:17:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxicAVHwNpKnMcAQ--.9832S3;
 Thu, 30 Oct 2025 16:17:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] target/loongarch: Add PMU migration support in KVM mode
Date: Thu, 30 Oct 2025 16:17:22 +0800
Message-Id: <20251030081724.3921563-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251030081724.3921563-1-maobibo@loongson.cn>
References: <20251030081724.3921563-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxicAVHwNpKnMcAQ--.9832S3
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
 target/loongarch/cpu-csr.h |  4 +++
 target/loongarch/cpu.h     |  4 +++
 target/loongarch/kvm/kvm.c | 54 +++++++++++++++++++++++++++++++++++++-
 target/loongarch/machine.c | 21 +++++++++++++++
 4 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 6898947498..06d60b464f 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -207,6 +207,10 @@ FIELD(CSR_DMW_32, PSEG, 25, 3)
 FIELD(CSR_DMW_32, VSEG, 29, 3)
 FIELD(CSR_DMW_64, VSEG, 60, 4)
 
+/* Performance Counter registers */
+#define LOONGARCH_CSR_PERFCTRL(N)    (0x200 + 2 * N)
+#define LOONGARCH_CSR_PERFCNTR(N)    (0x201 + 2 * N)
+
 /* Debug CSRs */
 #define LOONGARCH_CSR_DBG            0x500 /* debug config */
 FIELD(CSR_DBG, DST, 0, 1)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index b1d6799222..3e927edd6a 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -223,6 +223,7 @@ extern const char * const fregnames[32];
 #define IRQ_IPI     12
 #define INT_DMSI    14
 
+#define MAX_PERF_EVENTS        16
 #define LOONGARCH_STLB         2048 /* 2048 STLB */
 #define LOONGARCH_MTLB         64   /* 64 MTLB */
 #define LOONGARCH_TLB_MAX      (LOONGARCH_STLB + LOONGARCH_MTLB)
@@ -356,6 +357,8 @@ typedef struct CPUArchState {
     uint64_t CSR_MERRSAVE;
     uint64_t CSR_CTAG;
     uint64_t CSR_DMW[4];
+    uint64_t CSR_PERFCTRL[MAX_PERF_EVENTS];
+    uint64_t CSR_PERFCNTR[MAX_PERF_EVENTS];
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
@@ -366,6 +369,7 @@ typedef struct CPUArchState {
     struct {
         uint64_t guest_addr;
     } stealtime;
+    uint32_t perf_event_num;
 
 #ifdef CONFIG_TCG
     float_status fp_status;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 4e4f4e79f6..233a0429ed 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -155,6 +155,46 @@ static int kvm_loongarch_put_regs_core(CPUState *cs)
     return ret;
 }
 
+static int kvm_loongarch_put_pmu(CPUState *cs)
+{
+    int i, ret = 0;
+    CPULoongArchState *env = cpu_env(cs);
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+
+    if (cpu->pmu != ON_OFF_AUTO_ON) {
+        return 0;
+    }
+
+    for (i = 0; i < env->perf_event_num; i++) {
+        ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCTRL(i)),
+                               &env->CSR_PERFCTRL[i]);
+        ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCNTR(i)),
+                               &env->CSR_PERFCNTR[i]);
+    }
+
+    return ret;
+}
+
+static int kvm_loongarch_get_pmu(CPUState *cs)
+{
+    int i, ret = 0;
+    CPULoongArchState *env = cpu_env(cs);
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+
+    if (cpu->pmu != ON_OFF_AUTO_ON) {
+        return 0;
+    }
+
+    for (i = 0; i < env->perf_event_num; i++) {
+        ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCTRL(i)),
+                               &env->CSR_PERFCTRL[i]);
+        ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_PERFCNTR(i)),
+                               &env->CSR_PERFCNTR[i]);
+    }
+
+    return ret;
+}
+
 static int kvm_loongarch_get_csr(CPUState *cs)
 {
     int ret = 0;
@@ -316,6 +356,8 @@ static int kvm_loongarch_get_csr(CPUState *cs)
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(3)),
                            &env->CSR_DMW[3]);
 
+    ret |= kvm_loongarch_get_pmu(cs);
+
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_TVAL),
                            &env->CSR_TVAL);
 
@@ -488,6 +530,9 @@ static int kvm_loongarch_put_csr(CPUState *cs, KvmPutState level)
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_DMW(3)),
                            &env->CSR_DMW[3]);
+
+    ret |= kvm_loongarch_put_pmu(cs);
+
     /*
      * timer cfg must be put at last since it is used to enable
      * guest timer
@@ -1021,8 +1066,15 @@ static int kvm_cpu_check_pmu(CPUState *cs, Error **errp)
     }
 
     if (kvm_supported) {
+        /*
+         * TODO: Will add supported perf event number query interface
+         * from host, set perf event number with 4 by default
+         */
+        cpu->pmu = ON_OFF_AUTO_ON;
+        env->perf_event_num = 4;
         env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMP, 1);
-        env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMNUM, 3);
+        env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMNUM,
+                                    env->perf_event_num  - 1);
         env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMBITS, 63);
         env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, UPM, 1);
     }
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 0366a50763..28b9079d04 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -153,6 +153,26 @@ static const VMStateDescription vmstate_lbt = {
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
+        VMSTATE_UINT32(env.perf_event_num, LoongArchCPU),
+        VMSTATE_UINT64_ARRAY(env.CSR_PERFCTRL, LoongArchCPU, MAX_PERF_EVENTS),
+        VMSTATE_UINT64_ARRAY(env.CSR_PERFCNTR, LoongArchCPU, MAX_PERF_EVENTS),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
 static bool tlb_needed(void *opaque)
 {
@@ -266,6 +286,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
 #endif
         &vmstate_lbt,
         &vmstate_msgint,
+        &vmstate_pmu,
         NULL
     }
 };
-- 
2.39.3


