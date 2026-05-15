Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AFECD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 18:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNwqy-0007Yr-RJ; Fri, 15 May 2026 14:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqM-0007Kn-4r
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:01:11 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqI-0001M5-7J
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=+L3GZHBQ43j0/yGMIZuv+h9ZRswZsuCrmEDTG0wSro8=; b=KjtO6TKijFLec/e
 oF5yS5GhgH307AD3Lz0IzOy7rbam02lveQ4O3or2bxKCZbgW20gVqL5Tooww9Btz35mSPiSM5c3RB
 /8BBSbbxvPDvFxY7qF+xIq+ZjwVLsphtvFbR7WKF0m6GTUoAJI14pP/6eo3B31hJJERoFBEptRaWR
 4w=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v6 12/27] target/riscv: Fix size of priv
Date: Fri, 15 May 2026 20:04:22 +0200
Message-ID: <20260515180437.23620-13-anjo@rev.ng>
In-Reply-To: <20260515180437.23620-1-anjo@rev.ng>
References: <20260515180437.23620-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The priv field of CPUArchState only stores values in the range [0,3],
fix to 8 bits in size and update relevant function arguments.  Introduce
a new privilege_mode_t typedef for passing around the privilege mode.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 27 +++++++++++++++++----------
 target/riscv/internals.h  |  4 ++--
 target/riscv/pmu.h        |  2 +-
 target/riscv/cpu_helper.c | 37 ++++++++++++++++++++-----------------
 target/riscv/csr.c        | 10 ++++++----
 target/riscv/gdbstub.c    |  2 +-
 target/riscv/machine.c    |  2 +-
 target/riscv/op_helper.c  | 27 ++++++++++++++-------------
 target/riscv/pmu.c        |  9 ++++++---
 target/riscv/translate.c  |  2 +-
 10 files changed, 69 insertions(+), 53 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 31eda139c6..79d3e74b7a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -109,6 +109,12 @@ typedef struct riscv_cpu_profile {
 
 extern RISCVCPUProfile *riscv_profiles[];
 
+/*
+ * Type large enough to hold all PRV_* fields, update CPUArchState::priv
+ * migration field if changing this type.
+ */
+typedef uint8_t privilege_mode_t;
+
 /* Privileged specification version */
 #define PRIV_VER_1_10_0_STR "v1.10.0"
 #define PRIV_VER_1_11_0_STR "v1.11.0"
@@ -265,7 +271,7 @@ struct CPUArchState {
     uint32_t elf_flags;
 #endif
 
-    target_ulong priv;
+    privilege_mode_t priv;
     /* CSRs for execution environment configuration */
     uint64_t menvcfg;
     uint64_t senvcfg;
@@ -640,7 +646,7 @@ void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
 void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
                              void *arg);
-void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
+void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, privilege_mode_t priv,
                                    int (*rmw_fn)(void *arg,
                                                  target_ulong reg,
                                                  target_ulong *val,
@@ -651,10 +657,11 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 #endif /* !CONFIG_USER_ONLY */
 
-void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
+void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
+                        bool virt_en);
 
 void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
-    enum CTRType type, target_ulong prev_priv, bool prev_virt);
+    enum CTRType type, privilege_mode_t prev_priv, bool prev_virt);
 void riscv_ctr_clear(CPURISCVState *env);
 
 void riscv_translate_init(void);
@@ -722,9 +729,9 @@ static inline const RISCVCPUConfig *riscv_cpu_cfg(CPURISCVState *env)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-static inline int cpu_address_mode(CPURISCVState *env)
+static inline privilege_mode_t cpu_address_mode(CPURISCVState *env)
 {
-    int mode = env->priv;
+    privilege_mode_t mode = env->priv;
 
     if (mode == PRV_M && get_field(env->mstatus, MSTATUS_MPRV)) {
         mode = get_field(env->mstatus, MSTATUS_MPP);
@@ -732,7 +739,7 @@ static inline int cpu_address_mode(CPURISCVState *env)
     return mode;
 }
 
-static inline RISCVMXL cpu_get_xl(CPURISCVState *env, target_ulong mode)
+static inline RISCVMXL cpu_get_xl(CPURISCVState *env, privilege_mode_t mode)
 {
     RISCVMXL xl = env->misa_mxl;
     /*
@@ -778,7 +785,7 @@ static inline RISCVMXL cpu_address_xl(CPURISCVState *env)
 #ifdef CONFIG_USER_ONLY
     return env->xl;
 #else
-    int mode = cpu_address_mode(env);
+    privilege_mode_t mode = cpu_address_mode(env);
 
     return cpu_get_xl(env, mode);
 #endif
@@ -816,9 +823,9 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
  * Returns true if the effective privilege mode is modified.
  */
 static inline QEMU_ALWAYS_INLINE
-bool riscv_cpu_eff_priv(CPURISCVState *env, int *priv, bool *virt)
+bool riscv_cpu_eff_priv(CPURISCVState *env, privilege_mode_t *priv, bool *virt)
 {
-    int mode = env->priv;
+    privilege_mode_t mode = env->priv;
     bool virt_enabled = false;
     bool mode_modified = false;
 
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 8c24af0d85..e143a86f97 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -43,9 +43,9 @@
 #define MMU_2STAGE_BIT      (1 << 2)
 #define MMU_IDX_SS_WRITE    (1 << 3)
 
-static inline int mmuidx_priv(int mmu_idx)
+static inline privilege_mode_t mmuidx_priv(int mmu_idx)
 {
-    int ret = mmu_idx & 3;
+    privilege_mode_t ret = mmu_idx & 3;
     if (ret == MMUIdx_S_SUM) {
         ret = PRV_S;
     }
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 3853d0e262..b4f1e469a2 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -34,7 +34,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
-void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
+void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, privilege_mode_t newpriv,
                                  bool new_virt);
 RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                   bool upper_half, uint32_t ctr_idx);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 752fb7c71d..ff4e941d94 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -44,7 +44,7 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
     return 0;
 #else
     bool virt = env->virt_enabled;
-    int mode = env->priv;
+    privilege_mode_t mode = env->priv;
     bool mode_modified = false;
 
     /* All priv -> mmu_idx mapping are here */
@@ -165,7 +165,7 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
-    int priv_mode;
+    privilege_mode_t priv_mode;
     bool virt;
 
     riscv_cpu_eff_priv(env, &priv_mode, &virt);
@@ -217,7 +217,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
-    int priv_mode;
+    privilege_mode_t priv_mode;
 
     if (!riscv_cpu_cfg(env)->ext_ssnpm ||
         get_field(env->mstatus, MSTATUS_MXR) ||
@@ -245,7 +245,7 @@ bool riscv_cpu_virt_mem_enabled(CPURISCVState *env, bool is_vm_ldst)
 #ifndef CONFIG_USER_ONLY
     int satp_mode = 0;
     uint64_t satp;
-    int priv_mode;
+    privilege_mode_t priv_mode;
     bool virt = false;
 
     if (!is_vm_ldst) {
@@ -816,7 +816,7 @@ void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
     env->rdtime_fn_arg = arg;
 }
 
-void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
+void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, privilege_mode_t priv,
                                    int (*rmw_fn)(void *arg,
                                                  target_ulong reg,
                                                  target_ulong *val,
@@ -849,7 +849,7 @@ void riscv_ctr_clear(CPURISCVState *env)
     memset(env->ctr_data, 0x0, sizeof(env->ctr_data));
 }
 
-static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
+static uint64_t riscv_ctr_priv_to_mask(privilege_mode_t priv, bool virt)
 {
     switch (priv) {
     case PRV_M:
@@ -869,7 +869,8 @@ static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
     g_assert_not_reached();
 }
 
-static uint64_t riscv_ctr_get_control(CPURISCVState *env, target_long priv,
+static uint64_t riscv_ctr_get_control(CPURISCVState *env,
+                                      privilege_mode_t priv,
                                       bool virt)
 {
     switch (priv) {
@@ -891,10 +892,11 @@ static uint64_t riscv_ctr_get_control(CPURISCVState *env, target_long priv,
  * and src privilege is less than target privilege. This includes the virtual
  * state as well.
  */
-static bool riscv_ctr_check_xte(CPURISCVState *env, target_long src_prv,
+static bool riscv_ctr_check_xte(CPURISCVState *env,
+                                privilege_mode_t src_prv,
                                 bool src_virt)
 {
-    target_long tgt_prv = env->priv;
+    privilege_mode_t tgt_prv = env->priv;
     bool res = true;
 
     /*
@@ -980,7 +982,7 @@ static bool riscv_ctr_check_xte(CPURISCVState *env, target_long src_prv,
  *    idx = (sctrstatus.WRPTR - entry - 1) & (depth - 1);
  */
 void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
-    enum CTRType type, target_ulong src_priv, bool src_virt)
+    enum CTRType type, privilege_mode_t src_priv, bool src_virt)
 {
     bool tgt_virt = env->virt_enabled;
     uint64_t src_mask = riscv_ctr_priv_to_mask(src_priv, src_virt);
@@ -1078,7 +1080,8 @@ void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
     env->sctrstatus = set_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK, head);
 }
 
-void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
+void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
+                        bool virt_en)
 {
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
 
@@ -1141,7 +1144,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
  */
 static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
                                     int size, MMUAccessType access_type,
-                                    int mode)
+                                    privilege_mode_t mode)
 {
     pmp_priv_t pmp_priv;
     bool pmp_has_privs;
@@ -1165,7 +1168,7 @@ static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
 
 /* Returns 'true' if a svukte address check is needed */
 static bool do_svukte_check(CPURISCVState *env, bool first_stage,
-                             int mode, bool virt)
+                            privilege_mode_t mode, bool virt)
 {
     /* Svukte extension depends on Sv39. */
     if (!(env_archcpu(env)->cfg.ext_svukte ||
@@ -1248,7 +1251,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
      */
     MemTxResult res;
     MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
-    int mode = mmuidx_priv(mmu_idx);
+    privilege_mode_t mode = mmuidx_priv(mmu_idx);
     bool virt = mmuidx_2stage(mmu_idx);
     bool use_background = false;
     hwaddr ppn;
@@ -1825,7 +1828,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     bool two_stage_lookup = mmuidx_2stage(mmu_idx);
     bool two_stage_indirect_error = false;
     int ret = TRANSLATE_FAIL;
-    int mode = mmuidx_priv(mmu_idx);
+    privilege_mode_t mode = mmuidx_priv(mmu_idx);
     /* default TLB page size */
     hwaddr tlb_size = TARGET_PAGE_SIZE;
 
@@ -2211,7 +2214,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool always_storeamo = (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO);
     bool vsmode_exc;
     uint64_t s;
-    int mode;
+    privilege_mode_t mode;
 
     /*
      * cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
@@ -2227,7 +2230,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool smode_double_trap = false;
     uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
     const bool prev_virt = env->virt_enabled;
-    const target_ulong prev_priv = env->priv;
+    const privilege_mode_t prev_priv = env->priv;
     uint64_t last_pc = env->pc;
     target_ulong tval = 0;
     target_ulong tinst = 0;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4f18e3ff0c..ec08fbddce 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -374,7 +374,7 @@ static RISCVException aia_smode(CPURISCVState *env, int csrno)
 static RISCVException aia_smode32(CPURISCVState *env, int csrno)
 {
     int ret;
-    int csr_priv = get_field(csrno, 0x300);
+    privilege_mode_t csr_priv = get_field(csrno, 0x300);
 
     if (csr_priv == PRV_M && !riscv_cpu_cfg(env)->ext_smaia) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -2653,7 +2653,8 @@ static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
     bool virt = false, isel_reserved = false;
     int ret = -EINVAL;
     uint8_t *iprio;
-    target_ulong priv, vgein;
+    privilege_mode_t priv;
+    uint32_t vgein;
 
     /* VS-mode CSR number passed in has already been translated */
     switch (csrno) {
@@ -2938,7 +2939,8 @@ static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
 {
     bool virt;
     int ret = -EINVAL;
-    target_ulong priv, vgein;
+    privilege_mode_t priv;
+    uint32_t vgein;
 
     /* Translate CSR number for VS-mode */
     csrno = aia_xlate_vs_csrno(env, csrno);
@@ -5612,7 +5614,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
     }
 
 #if !defined(CONFIG_USER_ONLY)
-    int csr_priv, effective_priv = env->priv;
+    privilege_mode_t csr_priv, effective_priv = env->priv;
 
     if (riscv_has_ext(env, RVH) && env->priv == PRV_S &&
         !env->virt_enabled) {
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 2c6ccd4761..7abacd0e11 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -223,7 +223,7 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
         const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
 #ifndef CONFIG_USER_ONLY
         CPURISCVState *env = &cpu->env;
-        uint64_t new_priv = ldn(env, mem_buf, regsz) & 0x3;
+        privilege_mode_t new_priv = ldn(env, mem_buf, regsz) & 0x3;
         bool new_virt = 0;
 
         if (new_priv == PRV_RESERVED) {
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index c55794c554..ce5e44325d 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -445,7 +445,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT32(env.misa_ext, RISCVCPU),
         VMSTATE_UNUSED(4),
         VMSTATE_UINT32(env.misa_ext_mask, RISCVCPU),
-        VMSTATE_UINTTL(env.priv, RISCVCPU),
+        VMSTATE_UINT8(env.priv, RISCVCPU),
         VMSTATE_BOOL(env.virt_enabled, RISCVCPU),
         VMSTATE_UINT64(env.resetvec, RISCVCPU),
         VMSTATE_UINT64(env.mhartid, RISCVCPU),
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 81873014cb..c074b24bc9 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -286,8 +286,9 @@ void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
 target_ulong helper_sret(CPURISCVState *env)
 {
     uint64_t mstatus;
-    target_ulong prev_priv, prev_virt = env->virt_enabled;
-    const target_ulong src_priv = env->priv;
+    privilege_mode_t prev_priv;
+    bool prev_virt = env->virt_enabled;
+    const privilege_mode_t src_priv = env->priv;
     const bool src_virt = env->virt_enabled;
 
     if (!(env->priv >= PRV_S)) {
@@ -339,7 +340,7 @@ target_ulong helper_sret(CPURISCVState *env)
         /* We support Hypervisor extensions and virtulisation is disabled */
         target_ulong hstatus = env->hstatus;
 
-        prev_virt = get_field(hstatus, HSTATUS_SPV);
+        prev_virt = !!(get_field(hstatus, HSTATUS_SPV));
         hstatus = set_field(hstatus, HSTATUS_SPV, 0);
 
         env->hstatus = hstatus;
@@ -369,7 +370,7 @@ target_ulong helper_sret(CPURISCVState *env)
 }
 
 static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
-                                  target_ulong prev_priv,
+                                  privilege_mode_t prev_priv,
                                   uintptr_t ra)
 {
     if (!(env->priv >= PRV_M)) {
@@ -388,8 +389,8 @@ static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
     }
 }
 static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong mstatus,
-                                   target_ulong prev_priv,
-                                   target_ulong prev_virt)
+                                   privilege_mode_t prev_priv,
+                                   bool prev_virt)
 {
     /* If returning to U, VS or VU, sstatus.sdt = 0 */
     if (prev_priv == PRV_U || (prev_virt &&
@@ -408,13 +409,13 @@ target_ulong helper_mret(CPURISCVState *env)
 {
     target_ulong retpc = env->mepc & get_xepc_mask(env);
     uint64_t mstatus = env->mstatus;
-    target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
+    privilege_mode_t prev_priv = get_field(mstatus, MSTATUS_MPP);
     uintptr_t ra = GETPC();
 
     check_ret_from_m_mode(env, retpc, prev_priv, ra);
 
-    target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV) &&
-                             (prev_priv != PRV_M);
+    bool prev_virt = !!(get_field(env->mstatus, MSTATUS_MPV) &&
+                     (prev_priv != PRV_M));
     mstatus = set_field(mstatus, MSTATUS_MIE,
                         get_field(mstatus, MSTATUS_MPIE));
     mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
@@ -457,14 +458,14 @@ target_ulong helper_mret(CPURISCVState *env)
 target_ulong helper_mnret(CPURISCVState *env)
 {
     target_ulong retpc = env->mnepc;
-    target_ulong prev_priv = get_field(env->mnstatus, MNSTATUS_MNPP);
-    target_ulong prev_virt;
+    privilege_mode_t prev_priv = get_field(env->mnstatus, MNSTATUS_MNPP);
+    bool prev_virt;
     uintptr_t ra = GETPC();
 
     check_ret_from_m_mode(env, retpc, prev_priv, ra);
 
-    prev_virt = get_field(env->mnstatus, MNSTATUS_MNPV) &&
-                (prev_priv != PRV_M);
+    prev_virt = !!(get_field(env->mnstatus, MNSTATUS_MNPV) &&
+                (prev_priv != PRV_M));
     env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, true);
 
     /*
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 708f2ec7aa..3444400bd2 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -114,7 +114,8 @@ static bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
  *  new priv and new virt values are passed in as arguments.
  */
 static void riscv_pmu_icount_update_priv(CPURISCVState *env,
-                                         target_ulong newpriv, bool new_virt)
+                                         privilege_mode_t newpriv,
+                                         bool new_virt)
 {
     uint64_t *snapshot_prev, *snapshot_new;
     uint64_t current_icount;
@@ -154,7 +155,8 @@ static void riscv_pmu_icount_update_priv(CPURISCVState *env,
 }
 
 static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
-                                        target_ulong newpriv, bool new_virt)
+                                        privilege_mode_t newpriv,
+                                        bool new_virt)
 {
     uint64_t *snapshot_prev, *snapshot_new;
     uint64_t current_ticks;
@@ -189,7 +191,8 @@ static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
     counter_arr[env->priv] += delta;
 }
 
-void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
+void riscv_pmu_update_fixed_ctrs(CPURISCVState *env,
+                                 privilege_mode_t newpriv,
                                  bool new_virt)
 {
     riscv_pmu_cycle_update_priv(env, newpriv, new_virt);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 6a1ae92e5a..3132386801 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -68,7 +68,7 @@ typedef struct DisasContext {
     RISCVExtStatus mstatus_fs;
     RISCVExtStatus mstatus_vs;
     uint32_t mem_idx;
-    uint32_t priv;
+    privilege_mode_t priv;
     /*
      * Remember the rounding mode encoded in the previous fp instruction,
      * which we have already installed into env->fp_status.  Or -1 for
-- 
2.52.0


