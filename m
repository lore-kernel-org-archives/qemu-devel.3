Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2DEC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi76U-000617-SU; Fri, 10 Jul 2026 05:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wi76I-0005wY-Ot
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:00:51 -0400
Received: from [2400:e920:0:e::2c] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wi76C-000489-Ra
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:00:47 -0400
Received: from yuno-loong (unknown [IPv6:2400:e920:0:e::2c])
 by krgm.moe (Postfix) with ESMTPSA id 07FE3241FC91;
 Fri, 10 Jul 2026 17:00:35 +0800 (CST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>,
 SignKirigami <prcups@krgm.moe>, Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v3 2/8] target/loongarch: Add LVZ CPU state definitions
Date: Fri, 10 Jul 2026 17:00:11 +0800
Message-ID: <cb400ce1bfa09c8da3c7aa2a3673a61eb13aa7f5.1783673526.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1783673526.git.prcups@krgm.moe>
References: <cover.1783673526.git.prcups@krgm.moe>
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

Add VM level constants, guest MMU indices, guest exception and
interrupt identifiers, GID storage in TLB entries, LVZ CPU property
state, guest timer fields and helper declarations used by later
runtime, memory translation and instruction translation patches.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.h | 62 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

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
 
-- 
2.52.0


