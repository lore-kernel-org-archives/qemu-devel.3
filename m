Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A3F606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=He5jvA2m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3XZ-0000IQ-JK; Thu, 19 Nov 2026 09:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xU3Ui-0007PD-4I; Thu, 19 Nov 2026 09:52:15 -0500
Received: from [115.124.30.130] (helo=out30-130.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xU3Ud-0007xR-Hx; Thu, 19 Nov 2026 09:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1795099911; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=x5YthDFSK/Z1M2hunxdLcOeA8iLwjA/YYCOxApl5oTI=;
 b=He5jvA2mevwRi9ypJ2w2mmjI4ssjrlMDwuGrbJlB1PzDmu04LI8zQO1M+/uQi0s6C61SaWN4o0aHHZxVav1p7ipsWO4+sMIxYqwx3iTtNEnFjXRJyQx5Xt/2fxg07pPcknidiyUEU5Cvdm/LcQSuK7fc/2jTcWRJvU1S4ICJfcA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XF3s1bk_1795099910; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XF3s1bk_1795099910 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 19 Nov 2026 22:51:50 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Thu, 19 Nov 2026 22:50:45 +0800
Subject: [PATCH v5 12/14] target/riscv: Migrate fixed PMU counter state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-riscv-pmu-correctness-v5-12-ae9bdc2d2f86@linux.alibaba.com>
References: <20261119-riscv-pmu-correctness-v5-0-ae9bdc2d2f86@linux.alibaba.com>
In-Reply-To: <20261119-riscv-pmu-correctness-v5-0-ae9bdc2d2f86@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795099903; l=10810;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=2++aES9fYou0sSpZ/kLKQvDJenzc5YDaopMTwd4Bm4U=;
 b=4LVfP3jul48yp3tNTr7QC28XdjrYJyITUpujt13dcqaNFSGT7EuDoHpkMhYNP3bD3YWIqCHN4
 NqXYRc2ScEwDVaalfJfEfzu8+fN7qzJl5+DO2OyQZx0oAL81FkLNyCy
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.130 (deferred)
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-31.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Fixes: 3780e33732f8 ("target/riscv: Support mcycle/minstret write operation")
Fixes: b54a84c15e38 ("target/riscv: Add cycle & instret privilege mode filtering support")
Fixes: b2d7a7c7e4e3 ("target/riscv: Implement privilege mode filtering for cycle/instret")
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
index 360d08b9d4448023ce96211b8bc9cafa77366c40..e3822a4a4dd74dbb11d2ab5692a33fe12327ab25 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -592,6 +592,7 @@ struct ArchCPU {
     uint64_t pmu_timer_instret_snapshot;
     bool pmu_timer_stalled;
     bool pmu_timer_work_pending;
+    bool pmu_fixed_subsection_present;
     /* A bitmask of Available programmable counters */
     uint32_t pmu_avail_ctrs;
     /* Mapping of events to counters */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index c7b1da9278c6993199a94ab81bb3c7d6f3e9828c..83eb66d3214acca470c55ed61e0abc3d7c95cfa6 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -323,6 +323,30 @@ static const VMStateDescription vmstate_kvm_mp_state = {
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
@@ -385,16 +409,25 @@ static const VMStateDescription vmstate_sdext = {
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
@@ -481,6 +514,42 @@ static const VMStateDescription vmstate_pmu_ctr_state = {
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
@@ -582,10 +651,9 @@ const VMStateDescription vmstate_riscv_cpu = {
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
@@ -631,6 +699,11 @@ const VMStateDescription vmstate_riscv_cpu = {
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
@@ -662,6 +735,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_sstc,
         &vmstate_mseccfg,
         &vmstate_sdext,
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


