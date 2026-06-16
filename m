Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2E5CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQhB-0007el-In; Tue, 16 Jun 2026 06:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQh9-0007cA-PU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:59 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQh7-0003Fz-1s
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:59 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36baeec21dcso2753219a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604415; x=1782209215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNDXHrJk6AV7e/wZGV5NxYwCzNb8bGdciGkd1gVO8Zg=;
 b=ZT+m0n1/wRFmnA05/H4l1UDz06Aa8WPl0AD1CnT5aAQlaqH/eMKYnMKrFckMeF+3o1
 mNAbt64U3MU9vPzyIgf0pU/52w+Brb+T7lkKKj3mqhqAUqFj+V2vKCr2FqOnijr/71JS
 SgK950AnIT44gIglfOeiFz7UqDaqznxvQGMuZQulqoNTQctvKxQxEwxi6eo2/oTc+qxD
 hZa0CbEuSDdXb2ZHfN9dPlLmSD2zwP7RdcwMkwutnaH+B6ojp/UVnK61XoF3757hb0WE
 1Wa7dwApAdrDkthf/vMpFESKuN5qQ0JPXu6hSYXvXCPfG4o8vY00YroSl1JOqeskhgiC
 BrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604415; x=1782209215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mNDXHrJk6AV7e/wZGV5NxYwCzNb8bGdciGkd1gVO8Zg=;
 b=P/hAr9ATjNjSbokq/OqTPTXzhXClTxYNT7uAxqF3Q8UGjZ3qVHHopUPCA9iaDhFmI/
 eQuRBNQC6ra1/RhFSpsUVw/WRIsbcpyEMg44ji3xvrWAQpVsEzYiN4aY7pruG1QB0Wrh
 H9KX3x3LkbU/zhicYMn8pdN6h1aX1E6abEierAaqO6hfsk7vzTPkBGVRASap3DLnvx5q
 clS29TmYybnpBiZwalg7icPE+6DeYkCBdAtk/JlFE3pVJvt0HAI8K7s3eySmi+8bMhDZ
 VNAp9RhZVmtsmyZTSrxNoFK79Zu1Tb9iSw5ybanfHHeQ5T6/Sv/kF/z9++5CjfBGbmL9
 W2Nw==
X-Gm-Message-State: AOJu0YztmkRnqXLjgaHvjb9Y/nd759fXlXaFRUtGY3leII8xs76YnFQ1
 AumDDgRaChCP++aRP5d5QZHH4lnbgRaF7PaYgSirPdLnssoXfoSnyy7wzGz4FURA
X-Gm-Gg: Acq92OF/ysCMX+GpAHfDP8uACsQK/1sIaBuqXZTknOWImUteDGRdSt8JRe4ug/tO4io
 Gz5rWiYnfPlPZgiPaX1ZesJQiifJJHlEykF/FKKnqTjK8GR3fEo1GEGGLaNsUjYnCAIzcuH6VVq
 XWJ33QxjWdzbwjM7ik720ilyJ/s4NfIqcciI6k13LQ+GKM9QFCzItciHWEdmde8RL1f1r5ayBqE
 NUieuDNz9DUiDRU4YG+ENB3ZA9eJw/JaiNZC3tFQymJVpGqMYXiOaxeMdB/FwwzqDwj1SuH9wOJ
 8y68ZB4upXukejGZS4QR7nWgALADPEo9soSYa907hRJNsC+JXJJJEWwaywpv5uPymErw1fIaDIk
 R4UJZzedvWT9YX1zVJn3FOep1Pz+a7esRlGQ9RjDk/XqMPm9Qi3cG5R88vn5W+cs3/EqbAvdVXy
 cbZRFfJt1xjYPPN6ZKSyEgjhjTI2oDGKEUwKrlrWBoUOFsQwGRaqA=
X-Received: by 2002:a17:90b:4c87:b0:36d:9e0b:3801 with SMTP id
 98e67ed59e1d1-37a024176e6mr18768451a91.8.1781604415245; 
 Tue, 16 Jun 2026 03:06:55 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:54 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/83] target/riscv: Fix size of priv
Date: Tue, 16 Jun 2026 20:04:26 +1000
Message-ID: <20260616100527.1939565-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Anton Johansson <anjo@rev.ng>

The priv field of CPUArchState only stores values in the range [0,3],
fix to 8 bits in size and update relevant function arguments.  Introduce
a new privilege_mode_t typedef for passing around the privilege mode.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-13-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
index 4794489ec3..a57e28f40e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -110,6 +110,12 @@ typedef struct riscv_cpu_profile {
 
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
@@ -266,7 +272,7 @@ struct CPUArchState {
     uint32_t elf_flags;
 #endif
 
-    target_ulong priv;
+    privilege_mode_t priv;
     /* CSRs for execution environment configuration */
     uint64_t menvcfg;
     uint64_t senvcfg;
@@ -642,7 +648,7 @@ void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
 void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
                              void *arg);
-void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
+void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, privilege_mode_t priv,
                                    int (*rmw_fn)(void *arg,
                                                  target_ulong reg,
                                                  target_ulong *val,
@@ -653,10 +659,11 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
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
@@ -724,9 +731,9 @@ static inline const RISCVCPUConfig *riscv_cpu_cfg(CPURISCVState *env)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-static inline int cpu_address_mode(CPURISCVState *env)
+static inline privilege_mode_t cpu_address_mode(CPURISCVState *env)
 {
-    int mode = env->priv;
+    privilege_mode_t mode = env->priv;
 
     if (mode == PRV_M && get_field(env->mstatus, MSTATUS_MPRV)) {
         mode = get_field(env->mstatus, MSTATUS_MPP);
@@ -734,7 +741,7 @@ static inline int cpu_address_mode(CPURISCVState *env)
     return mode;
 }
 
-static inline RISCVMXL cpu_get_xl(CPURISCVState *env, target_ulong mode)
+static inline RISCVMXL cpu_get_xl(CPURISCVState *env, privilege_mode_t mode)
 {
     RISCVMXL xl = env->misa_mxl;
     /*
@@ -780,7 +787,7 @@ static inline RISCVMXL cpu_address_xl(CPURISCVState *env)
 #ifdef CONFIG_USER_ONLY
     return env->xl;
 #else
-    int mode = cpu_address_mode(env);
+    privilege_mode_t mode = cpu_address_mode(env);
 
     return cpu_get_xl(env, mode);
 #endif
@@ -818,9 +825,9 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
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
index a25727b0da..9ffcc6fa51 100644
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
@@ -1861,7 +1864,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     bool two_stage_lookup = mmuidx_2stage(mmu_idx);
     bool two_stage_indirect_error = false;
     int ret = TRANSLATE_FAIL;
-    int mode = mmuidx_priv(mmu_idx);
+    privilege_mode_t mode = mmuidx_priv(mmu_idx);
     /* default TLB page size */
     hwaddr tlb_size = TARGET_PAGE_SIZE;
 
@@ -2250,7 +2253,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool always_storeamo = (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO);
     bool vsmode_exc;
     uint64_t s;
-    int mode;
+    privilege_mode_t mode;
 
     /*
      * cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
@@ -2266,7 +2269,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool smode_double_trap = false;
     uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
     const bool prev_virt = env->virt_enabled;
-    const target_ulong prev_priv = env->priv;
+    const privilege_mode_t prev_priv = env->priv;
     uint64_t last_pc = env->pc;
     target_ulong tval = 0;
     target_ulong tinst = 0;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 8c2dcbeca4..f885f5d4f7 100644
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
@@ -2671,7 +2671,8 @@ static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
     bool virt = false, isel_reserved = false;
     int ret = -EINVAL;
     uint8_t *iprio;
-    target_ulong priv, vgein;
+    privilege_mode_t priv;
+    uint32_t vgein;
 
     /* VS-mode CSR number passed in has already been translated */
     switch (csrno) {
@@ -2956,7 +2957,8 @@ static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
 {
     bool virt;
     int ret = -EINVAL;
-    target_ulong priv, vgein;
+    privilege_mode_t priv;
+    uint32_t vgein;
 
     /* Translate CSR number for VS-mode */
     csrno = aia_xlate_vs_csrno(env, csrno);
@@ -5647,7 +5649,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
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
index 7ab62ebc82..045e830242 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -465,7 +465,7 @@ const VMStateDescription vmstate_riscv_cpu = {
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
2.54.0


