Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881F5CD98F0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 06:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbuRG-00036w-Jc; Tue, 23 Jun 2026 02:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wbuRE-000364-7w
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 02:16:48 -0400
Received: from [2400:e920:0:e::2c] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wbuRB-0002Qo-G2
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 02:16:47 -0400
Received: from yuno-loong (unknown [IPv6:2400:e920:0:e::2c])
 by krgm.moe (Postfix) with ESMTPSA id 64695240AE90;
 Tue, 23 Jun 2026 14:16:30 +0800 (CST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 SignKirigami <prcups@krgm.moe>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v2 1/4] target/loongarch: Add LVZ feature definitions and CPU
 structures
Date: Tue, 23 Jun 2026 14:16:12 +0800
Message-ID: <665fac3d20d71421b7318731b05c62c7d6d2cda9.1782194683.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1782194683.git.prcups@krgm.moe>
References: <cover.1782194683.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2400:e920:0:e::2c (failed)
Received-SPF: pass client-ip=2400:e920:0:e::2c; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_SBL_CSS=3.335,
 RDNS_NONE=0.793, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add LVZ (LoongArch Virtualization) CSR definitions to cpu-csr.h
including guest status/configuration/interrupt/timer/TLB CSRs.
Add VM level constants, guest MMU indices, guest exception codes
(GSPR, HVC, GCSC, GCHC), guest interrupt type, and utility
functions for VM-level switching. Extend CPUSysState with LVZ
control registers and add lvz/guest_timer fields to ArchCPU.
Define HW_FLAGS_GUEST_MODE for translation block guest flag and
add avail_LVZ/guest_mode to translation context.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu-csr.h   | 42 ++++++++++++++++++++++++
 target/loongarch/cpu.h       | 62 +++++++++++++++++++++++++++++++++++-
 target/loongarch/translate.h |  2 ++
 3 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index d860417af2..4b0bb4d2e5 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -180,11 +180,13 @@ FIELD(CSR_TLBREHI_64, VPPN, 13, 35)
 #define LOONGARCH_CSR_TLBRPRMD       0x8f /* TLB refill mode info */
 FIELD(CSR_TLBRPRMD, PPLV, 0, 2)
 FIELD(CSR_TLBRPRMD, PIE, 2, 1)
+FIELD(CSR_TLBRPRMD, PGM, 3, 1)
 FIELD(CSR_TLBRPRMD, PWE, 4, 1)
 
 /* Machine Error CSRs */
 #define LOONGARCH_CSR_MERRCTL        0x90 /* ERRCTL */
 FIELD(CSR_MERRCTL, ISMERR, 0, 1)
+FIELD(CSR_MERRCTL, PGM, 5, 1)
 #define LOONGARCH_CSR_MERRINFO1      0x91
 #define LOONGARCH_CSR_MERRINFO2      0x92
 #define LOONGARCH_CSR_MERRENTRY      0x93 /* MError exception base */
@@ -224,4 +226,44 @@ FIELD(CSR_DBG, ECODE, 16, 6)
 #define LOONGARCH_CSR_DERA           0x501 /* Debug era */
 #define LOONGARCH_CSR_DSAVE          0x502 /* Debug save */
 
+/* LVZ (LoongArch Virtualization) CSRs */
+#define LOONGARCH_CSR_GSTAT          0x50 /* Guest status */
+FIELD(CSR_GSTAT, VM, 0, 1)
+FIELD(CSR_GSTAT, PVM, 1, 1)
+FIELD(CSR_GSTAT, GIDBIT, 4, 6)
+FIELD(CSR_GSTAT, GID, 16, 8)
+
+#define LOONGARCH_CSR_GCFG           0x51 /* Guest config */
+FIELD(CSR_GCFG, MATP, 0, 4)
+FIELD(CSR_GCFG, MATC, 4, 2)
+FIELD(CSR_GCFG, TOPIP, 6, 1)
+FIELD(CSR_GCFG, TOPI, 7, 1)
+FIELD(CSR_GCFG, TOTIP, 8, 1)
+FIELD(CSR_GCFG, TOTI, 9, 1)
+FIELD(CSR_GCFG, TOEP, 10, 1)
+FIELD(CSR_GCFG, TOE, 11, 1)
+FIELD(CSR_GCFG, TOPP, 12, 1)
+FIELD(CSR_GCFG, TOP, 13, 1)
+FIELD(CSR_GCFG, TOHUP, 14, 1)
+FIELD(CSR_GCFG, TOHU, 15, 1)
+FIELD(CSR_GCFG, TOCIP, 16, 4)
+FIELD(CSR_GCFG, TOCI, 20, 2)
+FIELD(CSR_GCFG, GPMP, 23, 1)
+FIELD(CSR_GCFG, GPMNUM, 24, 3)
+
+#define LOONGARCH_CSR_GINTC          0x52 /* Guest interrupt config */
+FIELD(CSR_GINTC, HWIS, 0, 8)
+FIELD(CSR_GINTC, HWIP, 8, 8)
+FIELD(CSR_GINTC, HWIC, 16, 8)
+
+#define LOONGARCH_CSR_GCNTC          0x53 /* Guest counter compensation */
+
+#define LOONGARCH_CSR_GTLBC          0x15 /* Guest TLB control */
+FIELD(CSR_GTLBC, GMTLBSZ, 0, 6)
+FIELD(CSR_GTLBC, USETGID, 12, 1)
+FIELD(CSR_GTLBC, TOTI, 13, 1)
+FIELD(CSR_GTLBC, TGID, 16, 8)
+
+#define LOONGARCH_CSR_TRGP           0x16 /* Trapped guest physical address */
+
 #endif /* LOONGARCH_CPU_CSR_H */
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ad30c73167..c151287469 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -20,6 +20,8 @@
 #include "cpu-csr.h"
 #include "cpu-qom.h"
 
+#define CPU_INTERRUPT_GUEST CPU_INTERRUPT_TGT_EXT_0
+
 #define FCSR0_M1    0x1f         /* FCSR1 mask, Enables */
 #define FCSR0_M2    0x1f1f0000   /* FCSR2 mask, Cause and Flags */
 #define FCSR0_M3    0x300        /* FCSR3 mask, Round Mode */
@@ -93,6 +95,10 @@ FIELD(FCSR0, CAUSE, 24, 5)
 #define  EXCCODE_WPEM                EXCODE(19, 1)
 #define  EXCCODE_BTD                 EXCODE(20, 0)
 #define  EXCCODE_BTE                 EXCODE(21, 0)
+#define  EXCCODE_GSPR                EXCODE(22, 0)
+#define  EXCCODE_HVC                 EXCODE(23, 0)
+#define  EXCCODE_GCSC                EXCODE(24, 0)
+#define  EXCCODE_GCHC                EXCODE(25, 0)
 #define  EXCCODE_DBP                 EXCODE(26, 0) /* Reserved subcode used for debug */
 
 /* cpucfg[0] bits */
@@ -255,6 +261,7 @@ FIELD(TLB_MISC, E, 0, 1)
 FIELD(TLB_MISC, ASID, 1, 10)
 FIELD(TLB_MISC, VPPN, 13, 35)
 FIELD(TLB_MISC, PS, 48, 6)
+FIELD(TLB_MISC, GID, 54, 8)
 
 /*Msg interrupt registers */
 #define N_MSGIS                4
@@ -314,6 +321,10 @@ typedef struct  LoongArchBT {
     uint32_t ftop;
 } lbt_t;
 
+#define LOONGARCH_VM_LEVEL_HOST      0
+#define LOONGARCH_VM_LEVEL_GUEST     1
+#define LOONGARCH_VM_LEVELS          2
+
 #define CPU_VENDOR_LOONGSON   "Loongson"
 #define CPU_MODEL_3A5000      "3A5000"
 #define CPU_MODEL_1C101       "1C101"
@@ -375,10 +386,19 @@ typedef struct CPUSysState {
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
+    uint64_t CSR_GSTAT;
+    uint64_t CSR_GCFG;
+    uint64_t CSR_GINTC;
+    uint64_t CSR_GCNTC;
+    uint64_t CSR_GTLBC;
+    uint64_t CSR_TRGP;
     /* Msg interrupt registers */
     uint64_t CSR_MSGIS[N_MSGIS];
     uint64_t CSR_MSGIR;
     uint64_t CSR_MSGIE;
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+    LoongArchTLB tlb[LOONGARCH_TLB_MAX];
+#endif
 } CPUSysState;
 
 typedef struct CPUArchState {
@@ -394,7 +414,7 @@ typedef struct CPUArchState {
     uint32_t pv_features;
     uint64_t vendor_id;
     uint64_t cpu_id;
-    CPUSysState sys_states[1];
+    CPUSysState sys_states[LOONGARCH_VM_LEVELS];
 
     struct {
         uint64_t guest_addr;
@@ -419,6 +439,7 @@ typedef struct CPUArchState {
     uint32_t mp_state;
 #endif
     CPUSysState *sys_state;
+    bool vm_exit;
 } CPULoongArchState;
 
 typedef struct LoongArchCPUTopo {
@@ -438,8 +459,10 @@ struct ArchCPU {
 
     CPULoongArchState env;
     QEMUTimer timer;
+    QEMUTimer guest_timer;
     uint32_t  phy_id;
     OnOffAuto lbt;
+    OnOffAuto lvz;
     OnOffAuto pmu;
     OnOffAuto ptw;
     OnOffAuto lsx;
@@ -484,6 +507,24 @@ struct LoongArchCPUClass {
 #define MMU_KERNEL_IDX   MMU_PLV_KERNEL
 #define MMU_USER_IDX     MMU_PLV_USER
 #define MMU_DA_IDX       4
+#define MMU_GUEST_IDX    5
+#define MMU_GUEST_DA_IDX 9
+
+static inline bool is_guest_mmu_idx(int mmu_idx)
+{
+    return mmu_idx >= MMU_GUEST_IDX;
+}
+
+static inline int mmu_idx_to_plv(int mmu_idx)
+{
+    if (mmu_idx == MMU_DA_IDX || mmu_idx == MMU_GUEST_DA_IDX) {
+        return 0;
+    }
+    if (is_guest_mmu_idx(mmu_idx)) {
+        return mmu_idx - MMU_GUEST_IDX;
+    }
+    return mmu_idx;
+}
 
 static inline CPUSysState *env_sys(CPULoongArchState *env)
 {
@@ -495,6 +536,18 @@ static inline void set_sys_state(CPULoongArchState *env, CPUSysState *sys)
     env->sys_state = sys;
 }
 
+static inline CPUSysState *sys_state_if(CPULoongArchState *env, bool guest)
+{
+    return &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUEST :
+                                     LOONGARCH_VM_LEVEL_HOST];
+}
+
+static inline int env_vm_level(CPULoongArchState *env)
+{
+    return env_sys(env) == &env->sys_states[LOONGARCH_VM_LEVEL_GUEST] ?
+           LOONGARCH_VM_LEVEL_GUEST : LOONGARCH_VM_LEVEL_HOST;
+}
+
 static inline bool is_la64(CPULoongArchState *env)
 {
     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
@@ -530,6 +583,13 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_CRMD_PG    R_CSR_CRMD_PG_MASK   /* 0x10 */
 #define HW_FLAGS_VA32       0x20
 #define HW_FLAGS_EUEN_ASXE  0x40
+#define HW_FLAGS_GUEST_MODE 0x80
+
+bool has_lvz_capability(CPULoongArchState *env);
+bool will_return_to_guest(CPULoongArchState *env);
+uint8_t get_gid(CPULoongArchState *env);
+uint8_t get_tgid(CPULoongArchState *env);
+void trigger_vm_exit(CPULoongArchState *env);
 
 #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
 
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 8aa8325dc6..257c3bbddd 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -24,6 +24,7 @@
 #define avail_FP(C)     (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP))
 #define avail_FP_SP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_SP))
 #define avail_FP_DP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
+#define avail_LVZ(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LVZ))
 #define avail_LSPW(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
 #define avail_LAM(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
 #define avail_LAM_BH(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM_BH))
@@ -66,6 +67,7 @@ typedef struct DisasContext {
     TCGv zero;
     bool la64; /* LoongArch64 mode */
     bool va32; /* 32-bit virtual address */
+    bool guest_mode;
     uint32_t cpucfg1;
     uint32_t cpucfg2;
     uint32_t cpucfg3;
-- 
2.52.0


