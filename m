Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59A5CA6004
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 06:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFQDW-0002y7-1c; Sat, 10 Oct 2026 02:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCs-0002h8-LJ; Sat, 10 Oct 2026 02:05:18 -0400
Received: from [115.124.30.132] (helo=out30-132.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCk-00040t-Fe; Sat, 10 Oct 2026 02:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1791612290; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=XlCcFWDFxh4DeZ29TuIlIgR7QBjpZf7ZenU0xDL0T58=;
 b=ZP1A6RB2FTFMs55laSWrM35QQaLuj6DwOh69xGNtfoKNjEwKmrbzoAjzbKe2mGTfVxixjc/baLBE3uNP+4rt8unBEcQh7JopOtBHRcC3vxauit/PLes70bofbfZzrgHaZi5SpRPbjbTSjk9KHyZkyiddXoPMAguy+1QShrN7joI=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XCVKGuh_1791612289; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XCVKGuh_1791612289 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 10 Oct 2026 14:04:49 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Sat, 10 Oct 2026 14:04:36 +0800
Subject: [PATCH v3 12/14] target/riscv: Migrate fixed PMU counter state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-riscv-pmu-correctness-v3-12-712bf814a7be@linux.alibaba.com>
References: <20261010-riscv-pmu-correctness-v3-0-712bf814a7be@linux.alibaba.com>
In-Reply-To: <20261010-riscv-pmu-correctness-v3-0-712bf814a7be@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791612281; l=10545;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=WOCzC28RVadrpLRGLED0Hj169fa2ssnLSyLLGVsJvfg=;
 b=zVV6CenSNOAyTzuAO+ogU4WaqNhru/S4IoV9F9Kxu1+BvCZEm0V9gu5HBpPR7cUALoNbbKjiV
 8PljvOElSUSC/ENa3tXTHmtIyxsJhMSLHRJLRqsuWfRp6Izeb16L5pj
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.132 (deferred)
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Migration saves fixed-source baselines but not the per-mode totals they
refer to, nor mcyclecfg/minstretcfg. TCG can therefore subtract an
unrelated baseline or apply the wrong privilege filter after loading.

Before saving, add pending increments allowed by the current filters to
each enabled fixed-source counter, including HPM cycle/instruction
counters. The per-mode totals then need not migrate.

On load, clear those totals and establish destination-local baselines.
Inhibited counters get a new baseline when enabled; other event counters
get one when switched to a fixed source. This excludes migration downtime
and avoids using the source QEMU's saved baselines.

Rebuild the event map and overflow timer. Recompute interrupt requests
because pre-save can set LCOFIP after cpu_common saved CPU_INTERRUPT_HARD.

Keep the existing main-section fields and add cpu/pmu-fixed to carry
mcyclecfg/minstretcfg and identify values that include pending increments.
All TCG CPUs send and require it because mcycle/minstret exist even
without Zicntr, Zihpm or HPM counters. Reject older TCG streams, whose
counter values cannot be reconstructed reliably. KVM PMU migration is
unchanged.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4422
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4425
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/cpu.h     |  1 +
 target/riscv/machine.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++----
 target/riscv/tcg/pmu.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
 target/riscv/tcg/pmu.h |  2 ++
 4 files changed, 163 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index abc9180e35dae9f713652038f3e677d520e2ef50..67ecdc51d32b0cea7808a13c0f138a9deac31f38 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -587,6 +587,7 @@ struct ArchCPU {
     uint64_t pmu_timer_instret_snapshot;
     bool pmu_timer_stalled;
     bool pmu_timer_work_pending;
+    bool pmu_fixed_subsection_present;
     /* A bitmask of Available programmable counters */
     uint32_t pmu_avail_ctrs;
     /* Mapping of events to counters */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index b0ff2fc7f2ac10fab1f2ff845a953649091e1f43..7aa38b739cfd4d9274fe249eb914411e8a65b91f 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -267,6 +267,30 @@ static const VMStateDescription vmstate_kvm_mp_state = {
 };
 #endif
 
+static int riscv_cpu_pre_load(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    cpu->pmu_fixed_subsection_present = false;
+#ifdef CONFIG_KVM
+    return riscv_cpu_kvm_pre_load(opaque);
+#else
+    return 0;
+#endif
+}
+
+static int riscv_cpu_pre_save(void *opaque)
+{
+#ifdef CONFIG_TCG
+    RISCVCPU *cpu = opaque;
+
+    if (tcg_enabled()) {
+        riscv_pmu_prepare_save(&cpu->env);
+    }
+#endif
+    return 0;
+}
+
 static bool debug_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
@@ -308,16 +332,25 @@ static const VMStateDescription vmstate_debug = {
     }
 };
 
-static int riscv_cpu_post_load(void *opaque, int version_id)
+static bool riscv_cpu_post_load(void *opaque, int version_id, Error **errp)
 {
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
 
     env->xl = cpu_recompute_xl(env);
 #ifdef CONFIG_TCG
-    riscv_pmu_rebuild_event_map(env);
+    if (tcg_enabled()) {
+        if (!cpu->pmu_fixed_subsection_present) {
+            error_setg(errp,
+                       "missing RISC-V fixed-counter PMU migration state");
+            return false;
+        }
+        riscv_pmu_complete_load(env);
+        /* PMU pre-save can raise an interrupt after cpu_common was saved. */
+        riscv_cpu_interrupt(env);
+    }
 #endif
-    return 0;
+    return true;
 }
 
 static bool smstateen_needed(void *opaque)
@@ -404,6 +437,42 @@ static const VMStateDescription vmstate_pmu_ctr_state = {
     }
 };
 
+static int pmu_fixed_post_load(void *opaque, int version_id)
+{
+    RISCVCPU *cpu = opaque;
+
+    /* Let the outer post-load distinguish this format from a legacy stream. */
+    cpu->pmu_fixed_subsection_present = true;
+    return 0;
+}
+
+static bool pmu_fixed_needed(void *opaque)
+{
+    /*
+     * KVM keeps PMU state in the kernel, not in the TCG counter model.
+     * TCG implements mcycle/minstret even without Zicntr, Zihpm or
+     * programmable counters.
+     */
+    return tcg_enabled();
+}
+
+/*
+ * This subsection identifies TCG streams whose fixed-source counter values
+ * include pending deltas. It also carries mcyclecfg and minstretcfg.
+ */
+static const VMStateDescription vmstate_pmu_fixed = {
+    .name = "cpu/pmu-fixed",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pmu_fixed_needed,
+    .post_load = pmu_fixed_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(env.mcyclecfg, RISCVCPU),
+        VMSTATE_UINT64(env.minstretcfg, RISCVCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool jvt_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
@@ -505,10 +574,9 @@ const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .version_id = 12,
     .minimum_version_id = 12,
-#ifdef CONFIG_KVM
-    .pre_load = riscv_cpu_kvm_pre_load,
-#endif
-    .post_load = riscv_cpu_post_load,
+    .pre_load = riscv_cpu_pre_load,
+    .pre_save = riscv_cpu_pre_save,
+    .post_load_errp = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.gpr, RISCVCPU, 32),
         VMSTATE_UINT64_ARRAY(env.fpr, RISCVCPU, 32),
@@ -554,6 +622,11 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT32(env.mcounteren, RISCVCPU),
         VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
         VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
+        /*
+         * TCG includes pending fixed-source deltas in mhpmcounter_val
+         * before saving. After loading, it ignores mhpmcounter_prev and
+         * rebuilds the baseline from the destination source.
+         */
         VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
                              vmstate_pmu_ctr_state, PMUCTRState),
         VMSTATE_UINT64_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
@@ -582,6 +655,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_ctr,
         &vmstate_sstc,
         &vmstate_mseccfg,
+        &vmstate_pmu_fixed,
         NULL
     }
 };
diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index 6286552a4ebf614df0252f84ddfadbc25d8d2258..df99b572a4c16cb1ac65c2f7cde35c6f8349e681 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -663,6 +663,85 @@ void riscv_pmu_rebuild_timer(CPURISCVState *env)
     riscv_pmu_rebuild_timer_internal(env, false);
 }
 
+static uint32_t riscv_pmu_fixed_source_counter_mask(CPURISCVState *env)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    uint32_t mask = COUNTEREN_CY | COUNTEREN_IR;
+
+    mask |= riscv_pmu_event_counter_mask(
+        cpu, RISCV_PMU_EVENT_HW_CPU_CYCLES);
+    mask |= riscv_pmu_event_counter_mask(
+        cpu, RISCV_PMU_EVENT_HW_INSTRUCTIONS);
+    return mask;
+}
+
+static void riscv_pmu_accumulate_fixed_source_counters(
+    CPURISCVState *env, const RISCVPMUFixedSnapshot *snapshot)
+{
+    uint32_t mask = riscv_pmu_fixed_source_counter_mask(env);
+
+    while (mask) {
+        uint32_t ctr_idx = ctz32(mask);
+
+        mask &= ~BIT(ctr_idx);
+        if (riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
+            riscv_pmu_accumulate_fixed_delta(env, ctr_idx, snapshot);
+        }
+    }
+}
+
+void riscv_pmu_prepare_save(CPURISCVState *env)
+{
+    RISCVPMUFixedSnapshot snapshot;
+
+    riscv_pmu_take_fixed_snapshot(env, &snapshot);
+    riscv_pmu_accumulate_fixed_source_counters(env, &snapshot);
+}
+
+static void riscv_pmu_rebase_fixed_source_counters(
+    CPURISCVState *env, const RISCVPMUFixedSnapshot *snapshot)
+{
+    uint32_t mask;
+
+    memset(env->pmu_fixed_ctrs, 0, sizeof(env->pmu_fixed_ctrs));
+    if (env->virt_enabled) {
+        env->pmu_fixed_ctrs[RISCV_PMU_FIXED_DOMAIN_CYCLE]
+            .counter_virt_prev[env->priv] = snapshot->cycle;
+        env->pmu_fixed_ctrs[RISCV_PMU_FIXED_DOMAIN_INSTRET]
+            .counter_virt_prev[env->priv] = snapshot->instret;
+    } else {
+        env->pmu_fixed_ctrs[RISCV_PMU_FIXED_DOMAIN_CYCLE]
+            .counter_prev[env->priv] = snapshot->cycle;
+        env->pmu_fixed_ctrs[RISCV_PMU_FIXED_DOMAIN_INSTRET]
+            .counter_prev[env->priv] = snapshot->instret;
+    }
+
+    mask = riscv_pmu_fixed_source_counter_mask(env);
+    while (mask) {
+        uint32_t ctr_idx = ctz32(mask);
+
+        mask &= ~BIT(ctr_idx);
+        if (riscv_pmu_fixed_ctr_enabled(env, ctr_idx)) {
+            riscv_pmu_set_fixed_baseline(env, ctr_idx, snapshot);
+        }
+    }
+}
+
+void riscv_pmu_complete_load(CPURISCVState *env)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    RISCVPMUFixedSnapshot snapshot;
+
+    riscv_pmu_rebuild_event_map(env);
+    riscv_pmu_take_fixed_snapshot(env, &snapshot);
+    riscv_pmu_rebase_fixed_source_counters(env, &snapshot);
+
+    qatomic_set(&cpu->pmu_timer_work_pending, false);
+    cpu->pmu_timer_stalled = false;
+    cpu->pmu_timer_instret_snapshot = snapshot.instret;
+    riscv_pmu_rebuild_timer(env);
+}
+
 static void riscv_pmu_timer_work(CPUState *cs, run_on_cpu_data data)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
index d9238ae680f5e67031511db4f9afc2884212c5c2..1cfe6acf55b5468f5c00c4a136ece88981384341 100644
--- a/target/riscv/tcg/pmu.h
+++ b/target/riscv/tcg/pmu.h
@@ -45,6 +45,8 @@ void riscv_pmu_write_counter(CPURISCVState *env, uint32_t ctr_idx,
 void riscv_pmu_write_inhibit(CPURISCVState *env, uint32_t value);
 void riscv_pmu_timer_cb(void *priv);
 void riscv_pmu_rebuild_timer(CPURISCVState *env);
+void riscv_pmu_prepare_save(CPURISCVState *env);
+void riscv_pmu_complete_load(CPURISCVState *env);
 void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
 void riscv_pmu_rebuild_event_map(CPURISCVState *env);
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);

-- 
2.43.0


