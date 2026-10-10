Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AF5CA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 06:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFQD6-0002mM-QX; Sat, 10 Oct 2026 02:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCn-0002eq-HD; Sat, 10 Oct 2026 02:05:14 -0400
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCf-00040m-Pk; Sat, 10 Oct 2026 02:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1791612287; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=PQhOE2rRkPJKMZMCH/k5wGwvruQFkyejU0x/M6UAIbQ=;
 b=F34idbCMCCAPWabkZXSBPamSOUVmDgTanDhYTRtv2K78YFfVkFXQF7JmIB6KUVkOngyDdvqCGRCVFCfHagROdbKR0VrgDtk6BvLf20TV0CekzIvmHqnMSc/EJX+C4wKQOfg+ILgmSY0/hdulPcLbkLwXA8uURUfcyObr2GvhHik=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R901e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XCVKGtS_1791612285; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XCVKGtS_1791612285 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 10 Oct 2026 14:04:46 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Sat, 10 Oct 2026 14:04:31 +0800
Subject: [PATCH v3 07/14] target/riscv: Preserve fixed counters across PMU
 state changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-riscv-pmu-correctness-v3-7-712bf814a7be@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791612280; l=44004;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=94t+Gp5nJJfvmDlzdUkHQ3ui0cRqYZxEZn8wopfxhcI=;
 b=HbmzwuLL9jcBoTNnc/runkX1CsKn+3ApCI85hKKanz+8UGB3V8LRUFHOorckY5cTgfdhDOBNz
 UII80KQkNrJAsOv8SCQHwLw7WbDfcp05DiiV5g3//pViKJye2q/HeCU
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
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

mcycle/minstret and HPM cycle/instruction counters use a stored value plus
the increment since a source baseline. Changing selectors, filters or
inhibit bits before accounting for the old settings can lose counts or
add inhibited time.

Take one snapshot, add the increments allowed by the old settings, apply
the write and establish the new baseline from that snapshot. Share this
sequence between direct and indirect CSR accesses.

Merge selector bits after accounting so low-half writes preserve OF set
by a pending wrap; explicit high-half or RV64 writes can still clear it.
Preserve full-width arithmetic for RV32 accesses and keep source baselines
independent of written counter bits. Delegated writes must preserve
machine MINH.

Test filter changes, RV32 counter halves and OF across partial selector
writes.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/cpu.h                      |   8 +-
 target/riscv/tcg/csr.c                  | 243 +++++--------------------
 target/riscv/tcg/pmu.c                  | 309 +++++++++++++++++++++++++++-----
 target/riscv/tcg/pmu.h                  |  18 +-
 tests/tcg/riscv32/pmu-fixed-rv32.S      |  90 ++++++++++
 tests/tcg/riscv32/sscofpmf-event-rv32.S |  99 ++++++++++
 tests/tcg/riscv32/system/meson.build    |  14 ++
 tests/tcg/riscv64/pmu-cycle-controls.S  |  80 +++++++++
 tests/tcg/riscv64/system/meson.build    |   7 +
 9 files changed, 622 insertions(+), 246 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8c8ffe94cd89a0f5fad806ce16ff539eb4110764..a660e16cf6e38bd5c287ed2013539d51efc2848f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -240,6 +240,12 @@ typedef struct PMUCTRState {
     uint64_t irq_overflow_left;
 } PMUCTRState;
 
+typedef enum {
+    RISCV_PMU_FIXED_DOMAIN_CYCLE,
+    RISCV_PMU_FIXED_DOMAIN_INSTRET,
+    RISCV_PMU_FIXED_DOMAIN_COUNT,
+} RISCVPMUFixedDomain;
+
 typedef struct PMUFixedCtrState {
     /* Track cycle and icount for each privilege mode */
     uint64_t counter[4];
@@ -468,7 +474,7 @@ struct CPUArchState {
      */
     uint64_t mhpmevent_val[RV_MAX_MHPMEVENTS];
 
-    PMUFixedCtrState pmu_fixed_ctrs[2];
+    PMUFixedCtrState pmu_fixed_ctrs[RISCV_PMU_FIXED_DOMAIN_COUNT];
 
     uint64_t sscratch;
     uint64_t mscratch;
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index e563a77a567fa3bbca0bc79375099cfab0e43ac7..d6ac49e25984e784b807c70321e1b89cc29e148d 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1113,9 +1113,10 @@ static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
                                       target_ulong val, uintptr_t ra)
 {
     uint64_t inh_avail_mask;
+    uint64_t value;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        env->mcyclecfg = deposit64(env->mcyclecfg, 0, 32, val);
+        value = deposit64(env->mcyclecfg, 0, 32, val);
     } else {
         /* Set xINH fields if priv mode supported */
         inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MCYCLECFG_BIT_MINH;
@@ -1125,8 +1126,9 @@ static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
                            riscv_has_ext(env, RVU)) ? MCYCLECFG_BIT_VUINH : 0;
         inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                            riscv_has_ext(env, RVS)) ? MCYCLECFG_BIT_VSINH : 0;
-        env->mcyclecfg = val & inh_avail_mask;
+        value = val & inh_avail_mask;
     }
+    riscv_pmu_write_ctr_cfg(env, 0, value);
 
     return RISCV_EXCP_NONE;
 }
@@ -1152,7 +1154,9 @@ static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                        riscv_has_ext(env, RVS)) ? MCYCLECFGH_BIT_VSINH : 0;
 
-    env->mcyclecfg = deposit64(env->mcyclecfg, 32, 32, val & inh_avail_mask);
+    riscv_pmu_write_ctr_cfg(env, 0,
+                            deposit64(env->mcyclecfg, 32, 32,
+                                      val & inh_avail_mask));
     return RISCV_EXCP_NONE;
 }
 
@@ -1168,9 +1172,10 @@ static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
                                         target_ulong val, uintptr_t ra)
 {
     uint64_t inh_avail_mask;
+    uint64_t value;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        env->minstretcfg = deposit64(env->minstretcfg, 0, 32, val);
+        value = deposit64(env->minstretcfg, 0, 32, val);
     } else {
         inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MINSTRETCFG_BIT_MINH;
         inh_avail_mask |= riscv_has_ext(env, RVU) ? MINSTRETCFG_BIT_UINH : 0;
@@ -1179,8 +1184,9 @@ static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
                            riscv_has_ext(env, RVU)) ? MINSTRETCFG_BIT_VUINH : 0;
         inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                            riscv_has_ext(env, RVS)) ? MINSTRETCFG_BIT_VSINH : 0;
-        env->minstretcfg = val & inh_avail_mask;
+        value = val & inh_avail_mask;
     }
+    riscv_pmu_write_ctr_cfg(env, 2, value);
     return RISCV_EXCP_NONE;
 }
 
@@ -1204,8 +1210,9 @@ static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                        riscv_has_ext(env, RVS)) ? MINSTRETCFGH_BIT_VSINH : 0;
 
-    env->minstretcfg = deposit64(env->minstretcfg, 32, 32,
-                                 val & inh_avail_mask);
+    riscv_pmu_write_ctr_cfg(env, 2,
+                            deposit64(env->minstretcfg, 32, 32,
+                                      val & inh_avail_mask));
     return RISCV_EXCP_NONE;
 }
 
@@ -1220,50 +1227,17 @@ static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static uint64_t riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
-                                                     int counter_idx);
-
-static void riscv_pmu_write_mhpmevent(CPURISCVState *env,
-                                      uint32_t ctr_idx, uint64_t value)
-{
-    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    bool enabled = !get_field(env->mcountinhibit, BIT(ctr_idx));
-
-    /*
-     * A programmable counter backed by a fixed source uses mhpmcounter_val
-     * as its base and mhpmcounter_prev as the source snapshot.  Preserve the
-     * visible value before changing the source or its privilege filters.
-     */
-    if (enabled &&
-        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        uint64_t source = riscv_pmu_ctr_get_fixed_counters_val(env,
-                                                               ctr_idx);
-
-        counter->mhpmcounter_val += source - counter->mhpmcounter_prev;
-    }
-
-    env->mhpmevent_val[ctr_idx] = value;
-    riscv_pmu_rebuild_event_map(env);
-
-    if (enabled &&
-        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        counter->mhpmcounter_prev =
-            riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
-        riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
-    }
-}
-
 static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
                                       target_ulong val, uintptr_t ra)
 {
     int ctr_idx = csrno - CSR_MCOUNTINHIBIT;
     uint64_t mhpmevt_val;
     uint64_t inh_avail_mask;
+    uint64_t wr_mask = UINT64_MAX;
 
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        mhpmevt_val = deposit64(env->mhpmevent_val[ctr_idx], 0, 32, val);
+        mhpmevt_val = val;
+        wr_mask = UINT32_MAX;
     } else {
         inh_avail_mask = ~MHPMEVENT_FILTER_MASK | MHPMEVENT_BIT_MINH;
         inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENT_BIT_UINH : 0;
@@ -1275,7 +1249,7 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
         mhpmevt_val = val & inh_avail_mask;
     }
 
-    riscv_pmu_write_mhpmevent(env, ctr_idx, mhpmevt_val);
+    riscv_pmu_write_event(env, ctr_idx, mhpmevt_val, wr_mask);
 
     return RISCV_EXCP_NONE;
 }
@@ -1304,9 +1278,9 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
     inh_avail_mask |= (riscv_has_ext(env, RVH) &&
                        riscv_has_ext(env, RVS)) ? MHPMEVENTH_BIT_VSINH : 0;
 
-    riscv_pmu_write_mhpmevent(env, ctr_idx,
-                              deposit64(env->mhpmevent_val[ctr_idx], 32, 32,
-                                        val & inh_avail_mask));
+    riscv_pmu_write_event(env, ctr_idx,
+                          (uint64_t)(val & inh_avail_mask) << 32,
+                          MAKE_64BIT_MASK(32, 32));
 
     return RISCV_EXCP_NONE;
 }
@@ -1314,106 +1288,10 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
 static uint64_t riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
                                                      int counter_idx)
 {
-    int inst = riscv_pmu_ctr_monitor_instructions(env, counter_idx);
-    uint64_t *counter_arr_virt = env->pmu_fixed_ctrs[inst].counter_virt;
-    uint64_t *counter_arr = env->pmu_fixed_ctrs[inst].counter;
-    uint64_t curr_val = 0;
-    uint64_t cfg_val = 0;
-
-    if (counter_idx == 0) {
-        cfg_val = env->mcyclecfg;
-    } else if (counter_idx == 2) {
-        cfg_val = env->minstretcfg;
-    } else {
-        cfg_val = env->mhpmevent_val[counter_idx];
-        cfg_val &= MHPMEVENT_FILTER_MASK;
-    }
-
-    if (!cfg_val) {
-        return riscv_pmu_read_fixed_source(env, inst);
-    }
-
-    /* Update counter before reading. */
-    riscv_pmu_update_fixed_ctrs(env, env->priv, env->virt_enabled);
-
-    if (!(cfg_val & MCYCLECFG_BIT_MINH)) {
-        curr_val += counter_arr[PRV_M];
-    }
-
-    if (!(cfg_val & MCYCLECFG_BIT_SINH)) {
-        curr_val += counter_arr[PRV_S];
-    }
+    RISCVPMUFixedSnapshot snapshot;
 
-    if (!(cfg_val & MCYCLECFG_BIT_UINH)) {
-        curr_val += counter_arr[PRV_U];
-    }
-
-    if (!(cfg_val & MCYCLECFG_BIT_VSINH)) {
-        curr_val += counter_arr_virt[PRV_S];
-    }
-
-    if (!(cfg_val & MCYCLECFG_BIT_VUINH)) {
-        curr_val += counter_arr_virt[PRV_U];
-    }
-
-    return curr_val;
-}
-
-static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
-                                          uint32_t ctr_idx, RISCVMXL xl)
-{
-    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    bool rv32 = xl == MXL_RV32;
-    int deposit_size = rv32 ? 32 : 64;
-    uint64_t ctr;
-
-    if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
-        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
-        counter->mhpmcounter_val += ctr - counter->mhpmcounter_prev;
-        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
-                                             0, deposit_size, val);
-        counter->mhpmcounter_prev = ctr;
-        if (ctr_idx > 2) {
-            riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
-        }
-     } else {
-        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
-                                             0, deposit_size, val);
-        /* Other counters can keep incrementing from the given value */
-        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
-                                              0, deposit_size, val);
-    }
-
-    return RISCV_EXCP_NONE;
-}
-
-static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
-                                          uint32_t ctr_idx)
-{
-    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    uint64_t ctr;
-
-    if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
-        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
-        counter->mhpmcounter_val += ctr - counter->mhpmcounter_prev;
-        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
-                                             32, 32, val);
-        counter->mhpmcounter_prev = ctr;
-        if (ctr_idx > 2) {
-            riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
-        }
-    } else {
-        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
-                                             32, 32, val);
-        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
-                                              32, 32, val);
-    }
-
-    return RISCV_EXCP_NONE;
+    riscv_pmu_take_fixed_snapshot(env, &snapshot);
+    return riscv_pmu_ctr_get_fixed_value(env, counter_idx, &snapshot);
 }
 
 static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
@@ -1421,7 +1299,8 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
 {
     int ctr_idx = csrno - CSR_MCYCLE;
 
-    return riscv_pmu_write_ctr(env, val, ctr_idx, riscv_cpu_mxl(env));
+    riscv_pmu_write_counter(env, ctr_idx, val, false, riscv_cpu_mxl(env));
+    return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
@@ -1429,7 +1308,8 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
 {
     int ctr_idx = csrno - CSR_MCYCLEH;
 
-    return riscv_pmu_write_ctrh(env, val, ctr_idx);
+    riscv_pmu_write_counter(env, ctr_idx, val, true, riscv_cpu_mxl(env));
+    return RISCV_EXCP_NONE;
 }
 
 RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
@@ -1518,7 +1398,7 @@ static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
     if (!wr_mask && val) {
         riscv_pmu_read_ctr(env, val, false, ctr_idx, env->xl);
     } else if (wr_mask) {
-        riscv_pmu_write_ctr(env, new_val, ctr_idx, env->xl);
+        riscv_pmu_write_counter(env, ctr_idx, new_val, false, env->xl);
     } else {
         return -EINVAL;
     }
@@ -1537,7 +1417,7 @@ static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
     if (!wr_mask && val) {
         riscv_pmu_read_ctr(env, val, true, ctr_idx, env->xl);
     } else if (wr_mask) {
-        riscv_pmu_write_ctrh(env, new_val, ctr_idx);
+        riscv_pmu_write_counter(env, ctr_idx, new_val, true, env->xl);
     } else {
         return -EINVAL;
     }
@@ -1563,9 +1443,7 @@ static int rmw_cd_mhpmevent(CPURISCVState *env, int ctr_idx,
         }
     } else if (wr_mask) {
         wr_mask &= ~MHPMEVENT_BIT_MINH;
-        /* wr_mask is 64-bit so upper 32 bits of mhpmevt_val are retained */
-        mhpmevt_val = (new_val & wr_mask) | (mhpmevt_val & ~wr_mask);
-        riscv_pmu_write_mhpmevent(env, ctr_idx, mhpmevt_val);
+        riscv_pmu_write_event(env, ctr_idx, new_val, wr_mask);
     } else {
         return -EINVAL;
     }
@@ -1591,9 +1469,8 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int ctr_idx,
         }
     } else if (wr_mask) {
         wr_mask &= ~MHPMEVENTH_BIT_MINH;
-        mhpmevth_val = (new_val & wr_mask) | (mhpmevth_val & ~wr_mask);
-        mhpmevt_val = deposit64(mhpmevt_val, 32, 32, mhpmevth_val);
-        riscv_pmu_write_mhpmevent(env, ctr_idx, mhpmevt_val);
+        riscv_pmu_write_event(env, ctr_idx, (uint64_t)new_val << 32,
+                              (uint64_t)wr_mask << 32);
     } else {
         return -EINVAL;
     }
@@ -1612,7 +1489,9 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
     case 0:             /* CYCLECFG */
         if (wr_mask) {
             wr_mask &= ~MCYCLECFG_BIT_MINH;
-            env->mcyclecfg = (new_val & wr_mask) | (env->mcyclecfg & ~wr_mask);
+            riscv_pmu_write_ctr_cfg(env, 0,
+                                    (new_val & wr_mask) |
+                                    (env->mcyclecfg & ~wr_mask));
         } else {
             *val = env->mcyclecfg & ~MCYCLECFG_BIT_MINH;
         }
@@ -1620,8 +1499,9 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
     case 2:             /* INSTRETCFG */
         if (wr_mask) {
             wr_mask &= ~MINSTRETCFG_BIT_MINH;
-            env->minstretcfg = (new_val & wr_mask) |
-                               (env->minstretcfg & ~wr_mask);
+            riscv_pmu_write_ctr_cfg(env, 2,
+                                    (new_val & wr_mask) |
+                                    (env->minstretcfg & ~wr_mask));
         } else {
             *val = env->minstretcfg & ~MINSTRETCFG_BIT_MINH;
         }
@@ -1643,7 +1523,8 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
         if (wr_mask) {
             wr_mask &= ~MCYCLECFGH_BIT_MINH;
             cfgh = (new_val & wr_mask) | (cfgh & ~wr_mask);
-            env->mcyclecfg = deposit64(env->mcyclecfg, 32, 32, cfgh);
+            riscv_pmu_write_ctr_cfg(env, 0,
+                                    deposit64(env->mcyclecfg, 32, 32, cfgh));
         } else {
             *val = cfgh & ~MCYCLECFGH_BIT_MINH;
         }
@@ -1653,7 +1534,8 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
         if (wr_mask) {
             wr_mask &= ~MINSTRETCFGH_BIT_MINH;
             cfgh = (new_val & wr_mask) | (cfgh & ~wr_mask);
-            env->minstretcfg = deposit64(env->minstretcfg, 32, 32, cfgh);
+            riscv_pmu_write_ctr_cfg(env, 2,
+                                    deposit64(env->minstretcfg, 32, 32, cfgh));
         } else {
             *val = cfgh & ~MINSTRETCFGH_BIT_MINH;
         }
@@ -3092,44 +2974,7 @@ static RISCVException read_mcountinhibit(CPURISCVState *env, int csrno,
 static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
                                           target_ulong val, uintptr_t ra)
 {
-    int cidx;
-    PMUCTRState *counter;
-    RISCVCPU *cpu = env_archcpu(env);
-    uint32_t present_ctrs = cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR;
-    target_ulong updated_ctrs = (env->mcountinhibit ^ val) & present_ctrs;
-    uint64_t mhpmctr_val, prev_count, curr_count;
-
-    /* WARL register - disable unavailable counters; TM bit is always 0 */
-    env->mcountinhibit = val & present_ctrs;
-
-    /* Check if any other counter is also monitoring cycles/instructions */
-    for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
-        if (!(updated_ctrs & BIT(cidx)) ||
-            (!riscv_pmu_ctr_monitor_cycles(env, cidx) &&
-            !riscv_pmu_ctr_monitor_instructions(env, cidx))) {
-            continue;
-        }
-
-        counter = &env->pmu_ctrs[cidx];
-
-        if (!get_field(env->mcountinhibit, BIT(cidx))) {
-            counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env, cidx);
-
-            if (cidx > 2) {
-                riscv_pmu_setup_timer(env, counter->mhpmcounter_val, cidx);
-            }
-        } else {
-            curr_count = riscv_pmu_ctr_get_fixed_counters_val(env, cidx);
-
-            mhpmctr_val = counter->mhpmcounter_val;
-            prev_count = counter->mhpmcounter_prev;
-
-            /* Adjust the counter for later reads. */
-            mhpmctr_val = curr_count - prev_count + mhpmctr_val;
-            counter->mhpmcounter_val = mhpmctr_val;
-        }
-    }
-
+    riscv_pmu_write_inhibit(env, val);
     return RISCV_EXCP_NONE;
 }
 
diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index 54fff2ba49c1034d5fa6db1c7b19ff59003cd1e1..16942e53489cd5a2d2dd055fdffef07d04d59465 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -85,15 +85,27 @@ static bool riscv_pmu_counter_filtered(CPURISCVState *env, uint64_t cfg)
  * VM-elapsed ticks stop advancing while VM ticks are disabled.  Under
  * icount, instruction events retain raw instruction-count units.
  */
-uint64_t riscv_pmu_read_fixed_source(CPURISCVState *env, bool instret)
+static uint64_t riscv_pmu_read_fixed_source(CPURISCVState *env,
+                                            RISCVPMUFixedDomain domain)
 {
-    if (instret && icount_enabled()) {
+    if (domain == RISCV_PMU_FIXED_DOMAIN_INSTRET && icount_enabled()) {
         return icount_get_raw();
     }
 
+    g_assert(domain == RISCV_PMU_FIXED_DOMAIN_CYCLE ||
+             domain == RISCV_PMU_FIXED_DOMAIN_INSTRET);
     return cpus_get_elapsed_ticks();
 }
 
+void riscv_pmu_take_fixed_snapshot(CPURISCVState *env,
+                                   RISCVPMUFixedSnapshot *snapshot)
+{
+    snapshot->cycle =
+        riscv_pmu_read_fixed_source(env, RISCV_PMU_FIXED_DOMAIN_CYCLE);
+    snapshot->instret =
+        riscv_pmu_read_fixed_source(env, RISCV_PMU_FIXED_DOMAIN_INSTRET);
+}
+
 /*
  * Information needed to update counters:
  *  new_priv, new_virt: To correctly save starting snapshot for the newly
@@ -106,82 +118,289 @@ uint64_t riscv_pmu_read_fixed_source(CPURISCVState *env, bool instret)
  *  env->priv and env->virt_enabled contain old priv and old virt and
  *  new priv and new virt values are passed in as arguments.
  */
-static void riscv_pmu_icount_update_priv(CPURISCVState *env,
-                                         privilege_mode_t newpriv,
-                                         bool new_virt)
+static void riscv_pmu_fixed_update_priv(CPURISCVState *env,
+                                        privilege_mode_t newpriv,
+                                        bool new_virt,
+                                        RISCVPMUFixedDomain domain,
+                                        uint64_t source)
 {
+    PMUFixedCtrState *fixed = &env->pmu_fixed_ctrs[domain];
     uint64_t *snapshot_prev, *snapshot_new;
-    uint64_t current_icount;
     uint64_t *counter_arr;
     uint64_t delta;
 
-    current_icount = riscv_pmu_read_fixed_source(env, true);
-
     if (env->virt_enabled) {
         g_assert(env->priv <= PRV_S);
-        counter_arr = env->pmu_fixed_ctrs[1].counter_virt;
-        snapshot_prev = env->pmu_fixed_ctrs[1].counter_virt_prev;
+        counter_arr = fixed->counter_virt;
+        snapshot_prev = fixed->counter_virt_prev;
     } else {
-        counter_arr = env->pmu_fixed_ctrs[1].counter;
-        snapshot_prev = env->pmu_fixed_ctrs[1].counter_prev;
+        counter_arr = fixed->counter;
+        snapshot_prev = fixed->counter_prev;
     }
 
     if (new_virt) {
         g_assert(newpriv <= PRV_S);
-        snapshot_new = env->pmu_fixed_ctrs[1].counter_virt_prev;
+        snapshot_new = fixed->counter_virt_prev;
     } else {
-        snapshot_new = env->pmu_fixed_ctrs[1].counter_prev;
+        snapshot_new = fixed->counter_prev;
     }
 
-     /*
-      * new_priv can be same as env->priv. So we need to calculate
-      * delta first before updating snapshot_new[new_priv].
-      */
-    delta = current_icount - snapshot_prev[env->priv];
-    snapshot_new[newpriv] = current_icount;
+    /*
+     * new_priv can be same as env->priv. So we need to calculate
+     * delta first before updating snapshot_new[new_priv].
+     */
+    delta = source - snapshot_prev[env->priv];
+    snapshot_new[newpriv] = source;
 
     counter_arr[env->priv] += delta;
 }
 
-static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
-                                        privilege_mode_t newpriv,
-                                        bool new_virt)
+static void
+riscv_pmu_update_fixed_ctrs_snapshot(CPURISCVState *env,
+                                     privilege_mode_t newpriv, bool new_virt,
+                                     const RISCVPMUFixedSnapshot *snapshot)
 {
-    uint64_t *snapshot_prev, *snapshot_new;
-    uint64_t current_ticks;
+    riscv_pmu_fixed_update_priv(env, newpriv, new_virt,
+                                RISCV_PMU_FIXED_DOMAIN_CYCLE,
+                                snapshot->cycle);
+    riscv_pmu_fixed_update_priv(env, newpriv, new_virt,
+                                RISCV_PMU_FIXED_DOMAIN_INSTRET,
+                                snapshot->instret);
+}
+
+void riscv_pmu_update_fixed_ctrs(CPURISCVState *env,
+                                 privilege_mode_t newpriv,
+                                 bool new_virt)
+{
+    RISCVPMUFixedSnapshot snapshot;
+
+    riscv_pmu_take_fixed_snapshot(env, &snapshot);
+    riscv_pmu_update_fixed_ctrs_snapshot(env, newpriv, new_virt, &snapshot);
+}
+
+uint64_t
+riscv_pmu_ctr_get_fixed_value(CPURISCVState *env, uint32_t ctr_idx,
+                              const RISCVPMUFixedSnapshot *snapshot)
+{
+    RISCVPMUFixedDomain domain;
+    PMUFixedCtrState *fixed;
+    uint64_t *counter_arr_virt;
     uint64_t *counter_arr;
-    uint64_t delta;
+    uint64_t cfg;
+    uint64_t value = 0;
 
-    current_ticks = riscv_pmu_read_fixed_source(env, false);
+    if (riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
+        domain = RISCV_PMU_FIXED_DOMAIN_INSTRET;
+    } else {
+        domain = RISCV_PMU_FIXED_DOMAIN_CYCLE;
+    }
 
-    if (env->virt_enabled) {
-        g_assert(env->priv <= PRV_S);
-        counter_arr = env->pmu_fixed_ctrs[0].counter_virt;
-        snapshot_prev = env->pmu_fixed_ctrs[0].counter_virt_prev;
+    fixed = &env->pmu_fixed_ctrs[domain];
+    counter_arr_virt = fixed->counter_virt;
+    counter_arr = fixed->counter;
+
+    if (ctr_idx == 0) {
+        cfg = env->mcyclecfg;
+    } else if (ctr_idx == 2) {
+        cfg = env->minstretcfg;
     } else {
-        counter_arr = env->pmu_fixed_ctrs[0].counter;
-        snapshot_prev = env->pmu_fixed_ctrs[0].counter_prev;
+        cfg = env->mhpmevent_val[ctr_idx] & MHPMEVENT_FILTER_MASK;
     }
 
-    if (new_virt) {
-        g_assert(newpriv <= PRV_S);
-        snapshot_new = env->pmu_fixed_ctrs[0].counter_virt_prev;
+    if (!cfg) {
+        return domain == RISCV_PMU_FIXED_DOMAIN_INSTRET ?
+               snapshot->instret : snapshot->cycle;
+    }
+
+    riscv_pmu_update_fixed_ctrs_snapshot(env, env->priv, env->virt_enabled,
+                                         snapshot);
+
+    if (!(cfg & MCYCLECFG_BIT_MINH)) {
+        value += counter_arr[PRV_M];
+    }
+    if (!(cfg & MCYCLECFG_BIT_SINH)) {
+        value += counter_arr[PRV_S];
+    }
+    if (!(cfg & MCYCLECFG_BIT_UINH)) {
+        value += counter_arr[PRV_U];
+    }
+    if (!(cfg & MCYCLECFG_BIT_VSINH)) {
+        value += counter_arr_virt[PRV_S];
+    }
+    if (!(cfg & MCYCLECFG_BIT_VUINH)) {
+        value += counter_arr_virt[PRV_U];
+    }
+
+    return value;
+}
+
+static bool riscv_pmu_fixed_ctr_selected(CPURISCVState *env,
+                                         uint32_t ctr_idx)
+{
+    return riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
+           riscv_pmu_ctr_monitor_instructions(env, ctr_idx);
+}
+
+static bool riscv_pmu_fixed_ctr_enabled(CPURISCVState *env,
+                                        uint32_t ctr_idx)
+{
+    return !(env->mcountinhibit & BIT(ctr_idx)) &&
+           riscv_pmu_fixed_ctr_selected(env, ctr_idx);
+}
+
+static bool riscv_pmu_fixed_ctr_running(CPURISCVState *env,
+                                        uint32_t ctr_idx)
+{
+    return riscv_pmu_fixed_ctr_enabled(env, ctr_idx);
+}
+
+static void riscv_pmu_set_overflow(CPURISCVState *env, uint32_t ctr_idx)
+{
+    if (ctr_idx < 3 || !riscv_cpu_cfg(env)->ext_sscofpmf ||
+        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
+        return;
+    }
+
+    env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
+    riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
+}
+
+/*
+ * Accumulate the delta from mhpmcounter_prev to the fixed source snapshot,
+ * then align mhpmcounter_prev with that snapshot.
+ */
+static void
+riscv_pmu_accumulate_fixed_delta(CPURISCVState *env, uint32_t ctr_idx,
+                                 const RISCVPMUFixedSnapshot *snapshot)
+{
+    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
+    uint64_t source, delta, value;
+
+    g_assert(riscv_pmu_fixed_ctr_selected(env, ctr_idx));
+
+    source = riscv_pmu_ctr_get_fixed_value(env, ctr_idx, snapshot);
+    delta = source - counter->mhpmcounter_prev;
+    value = counter->mhpmcounter_val;
+
+    if (delta > UINT64_MAX - value) {
+        riscv_pmu_set_overflow(env, ctr_idx);
+    }
+
+    counter->mhpmcounter_val = value + delta;
+    counter->mhpmcounter_prev = source;
+}
+
+static void
+riscv_pmu_set_fixed_baseline(CPURISCVState *env, uint32_t ctr_idx,
+                             const RISCVPMUFixedSnapshot *snapshot)
+{
+    g_assert(riscv_pmu_fixed_ctr_selected(env, ctr_idx));
+    env->pmu_ctrs[ctr_idx].mhpmcounter_prev =
+        riscv_pmu_ctr_get_fixed_value(env, ctr_idx, snapshot);
+}
+
+void riscv_pmu_write_ctr_cfg(CPURISCVState *env, uint32_t ctr_idx,
+                             uint64_t value)
+{
+    RISCVPMUFixedSnapshot snapshot;
+
+    g_assert(ctr_idx == 0 || ctr_idx == 2);
+
+    riscv_pmu_take_fixed_snapshot(env, &snapshot);
+    if (riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
+        riscv_pmu_accumulate_fixed_delta(env, ctr_idx, &snapshot);
+    }
+    if (ctr_idx == 0) {
+        env->mcyclecfg = value;
     } else {
-        snapshot_new = env->pmu_fixed_ctrs[0].counter_prev;
+        env->minstretcfg = value;
+    }
+    if (riscv_pmu_fixed_ctr_enabled(env, ctr_idx)) {
+        riscv_pmu_set_fixed_baseline(env, ctr_idx, &snapshot);
     }
+}
 
-    delta = current_ticks - snapshot_prev[env->priv];
-    snapshot_new[newpriv] = current_ticks;
+void riscv_pmu_write_event(CPURISCVState *env, uint32_t ctr_idx,
+                           uint64_t value, uint64_t wr_mask)
+{
+    RISCVPMUFixedSnapshot snapshot;
+    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
 
-    counter_arr[env->priv] += delta;
+    riscv_pmu_take_fixed_snapshot(env, &snapshot);
+    if (riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
+        riscv_pmu_accumulate_fixed_delta(env, ctr_idx, &snapshot);
+    }
+    /* Accumulating the old source can set OF outside the written bits. */
+    env->mhpmevent_val[ctr_idx] = (value & wr_mask) |
+                                (env->mhpmevent_val[ctr_idx] & ~wr_mask);
+    riscv_pmu_rebuild_event_map(env);
+    if (riscv_pmu_fixed_ctr_enabled(env, ctr_idx)) {
+        riscv_pmu_set_fixed_baseline(env, ctr_idx, &snapshot);
+    }
+
+    if (riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
+        riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
+    }
 }
 
-void riscv_pmu_update_fixed_ctrs(CPURISCVState *env,
-                                 privilege_mode_t newpriv,
-                                 bool new_virt)
+void riscv_pmu_write_counter(CPURISCVState *env, uint32_t ctr_idx,
+                             target_ulong value, bool upper_half, RISCVMXL xl)
+{
+    RISCVPMUFixedSnapshot snapshot;
+    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
+    bool rv32 = xl == MXL_RV32;
+    bool running;
+    int start = upper_half ? 32 : 0;
+    int length = rv32 ? 32 : 64;
+
+    g_assert(rv32 || !upper_half);
+
+    riscv_pmu_take_fixed_snapshot(env, &snapshot);
+    running = riscv_pmu_fixed_ctr_running(env, ctr_idx);
+    if (running) {
+        riscv_pmu_accumulate_fixed_delta(env, ctr_idx, &snapshot);
+    }
+    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                         start, length, value);
+    /* mhpmcounter_prev tracks the source, not the written counter value. */
+    if (running && ctr_idx > 2) {
+        riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
+    }
+}
+
+void riscv_pmu_write_inhibit(CPURISCVState *env, uint32_t value)
 {
-    riscv_pmu_cycle_update_priv(env, newpriv, new_virt);
-    riscv_pmu_icount_update_priv(env, newpriv, new_virt);
+    RISCVCPU *cpu = env_archcpu(env);
+    RISCVPMUFixedSnapshot snapshot;
+    uint32_t present = cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR;
+    uint32_t old = env->mcountinhibit;
+    uint32_t changed = (old ^ value) & present;
+    uint32_t ctr_idx;
+
+    riscv_pmu_take_fixed_snapshot(env, &snapshot);
+    for (ctr_idx = 0; ctr_idx < RV_MAX_MHPMCOUNTERS; ctr_idx++) {
+        if ((changed & BIT(ctr_idx)) && !(old & BIT(ctr_idx)) &&
+            riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
+            riscv_pmu_accumulate_fixed_delta(env, ctr_idx, &snapshot);
+        }
+    }
+
+    env->mcountinhibit = value & present;
+
+    for (ctr_idx = 0; ctr_idx < RV_MAX_MHPMCOUNTERS; ctr_idx++) {
+        if (!(changed & BIT(ctr_idx)) ||
+            (env->mcountinhibit & BIT(ctr_idx))) {
+            continue;
+        }
+
+        if (riscv_pmu_fixed_ctr_enabled(env, ctr_idx)) {
+            riscv_pmu_set_fixed_baseline(env, ctr_idx, &snapshot);
+        }
+        if (ctr_idx > 2 && riscv_pmu_fixed_ctr_running(env, ctr_idx)) {
+            riscv_pmu_setup_timer(env, env->pmu_ctrs[ctr_idx].mhpmcounter_val,
+                                  ctr_idx);
+        }
+    }
 }
 
 void riscv_pmu_decr_instret(CPURISCVState *env)
diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
index bf2e8373474d471d914f8801c55d2f6ffbb5cdd3..1494fbc21f53137a90c1338f6ca8e3c3e750276a 100644
--- a/target/riscv/tcg/pmu.h
+++ b/target/riscv/tcg/pmu.h
@@ -22,11 +22,27 @@
 #include "cpu.h"
 #include "qapi/error.h"
 
+typedef struct RISCVPMUFixedSnapshot {
+    uint64_t cycle;
+    uint64_t instret;
+} RISCVPMUFixedSnapshot;
+
 bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
                                         uint32_t target_ctr);
 bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env,
                                   uint32_t target_ctr);
-uint64_t riscv_pmu_read_fixed_source(CPURISCVState *env, bool instret);
+void riscv_pmu_take_fixed_snapshot(CPURISCVState *env,
+                                   RISCVPMUFixedSnapshot *snapshot);
+uint64_t riscv_pmu_ctr_get_fixed_value(CPURISCVState *env,
+                                       uint32_t ctr_idx,
+                                       const RISCVPMUFixedSnapshot *snapshot);
+void riscv_pmu_write_ctr_cfg(CPURISCVState *env, uint32_t ctr_idx,
+                             uint64_t value);
+void riscv_pmu_write_event(CPURISCVState *env, uint32_t ctr_idx,
+                           uint64_t value, uint64_t wr_mask);
+void riscv_pmu_write_counter(CPURISCVState *env, uint32_t ctr_idx,
+                             target_ulong value, bool upper_half, RISCVMXL xl);
+void riscv_pmu_write_inhibit(CPURISCVState *env, uint32_t value);
 void riscv_pmu_timer_cb(void *priv);
 void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
 void riscv_pmu_rebuild_event_map(CPURISCVState *env);
diff --git a/tests/tcg/riscv32/pmu-fixed-rv32.S b/tests/tcg/riscv32/pmu-fixed-rv32.S
new file mode 100644
index 0000000000000000000000000000000000000000..85917fe0caa40621d873be2a70426552bde975c3
--- /dev/null
+++ b/tests/tcg/riscv32/pmu-fixed-rv32.S
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+	.option	norvc
+	.option	norelax
+
+	.text
+	.global _start
+_start:
+	/*
+	 * Failure bits:
+	 * 0: selecting cycles changes the initialized high half
+	 * 1: a low-half write discards a carry into the visible high half
+	 * 2: the high-half read does not match the value just written
+	 */
+	li	t4, 0
+	csrw	mhpmevent3, zero
+	csrw	mhpmcounter3, zero
+	li	t0, 1
+	csrw	mhpmcounter3h, t0
+	li	t0, 1
+	csrw	mhpmevent3, t0		/* mhpmevent3: cycles */
+
+	/* Starting the counter must preserve its initialized high half. */
+	csrr	t0, hpmcounter3h
+	li	t1, 1
+	xor	t0, t0, t1
+	sltu	t0, zero, t0
+	or	t4, t4, t0
+
+	/*
+	 * Start 256 cycles below 2 << 32.  With -icount shift=0, the
+	 * following instructions carry into the visible high half.  A
+	 * low-half write must replace only bits 31:0 and preserve that carry.
+	 */
+	csrw	mhpmevent3, zero
+	li	t0, -256
+	csrw	mhpmcounter3, t0
+	li	t0, 1
+	csrw	mhpmcounter3h, t0
+	li	t0, 1
+	csrw	mhpmevent3, t0		/* mhpmevent3: cycles */
+	.rept	512
+	nop
+	.endr
+	li	t0, 0x1234
+	csrw	mhpmcounter3, t0
+	csrr	t0, hpmcounter3h
+	li	t1, 2
+	xor	t0, t0, t1
+	sltu	t0, zero, t0
+	slli	t0, t0, 1
+	or	t4, t4, t0
+
+	/*
+	 * Restart with a small low half so no carry can affect this check.
+	 * Writing 2 to the running counter's high half must read back as 2.
+	 */
+	csrw	mhpmevent3, zero
+	li	t0, 0x1234
+	csrw	mhpmcounter3, t0
+	li	t0, 1
+	csrw	mhpmcounter3h, t0
+	li	t0, 1
+	csrw	mhpmevent3, t0		/* mhpmevent3: cycles */
+	li	t0, 2
+	csrw	mhpmcounter3h, t0
+	csrr	t0, hpmcounter3h
+	li	t1, 2
+	xor	t0, t0, t1
+	sltu	t0, zero, t0
+	slli	t0, t0, 2
+	or	t4, t4, t0
+
+	la	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sw	t0, 0(a1)
+	sw	t4, 4(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence. */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	8
diff --git a/tests/tcg/riscv32/sscofpmf-event-rv32.S b/tests/tcg/riscv32/sscofpmf-event-rv32.S
new file mode 100644
index 0000000000000000000000000000000000000000..0c769c5f6bea4350a197dd044e6959b28fc69700
--- /dev/null
+++ b/tests/tcg/riscv32/sscofpmf-event-rv32.S
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* CSR numbers for older assemblers. */
+#define CSR_SISELECT         0x150
+#define CSR_SIREG2           0x152
+#define CSR_SIREG5           0x156
+#define CSR_MENVCFGH         0x31a
+#define CSR_MHPMEVENT3H      0x723
+
+/* Low-half selector writes preserve OF; high-half writes can clear it. */
+
+	.option	norvc
+	.option	norelax
+
+	.macro	check_selector_write low_csr, high_csr, first_failure
+	li	t4, \first_failure
+	li	t0, 8			/* mcountinhibit.HPM3 */
+	csrs	mcountinhibit, t0
+	li	t1, 1 << 29		/* SINH: still count in M-mode. */
+	csrw	CSR_MHPMEVENT3H, t1		/* mhpmevent3h: OF is clear. */
+	li	t1, 2			/* HW_INSTRUCTIONS */
+	csrw	mhpmevent3, t1
+	/* Set the counter to UINT64_MAX while inhibited. */
+	li	t2, -1
+	csrw	mhpmcounter3, t2
+	csrw	mhpmcounter3h, t2
+	li	t3, 1 << 13		/* mip.LCOFIP */
+	csrc	mip, t3
+
+	/*
+	 * With icount, this write accounts for the first increment after
+	 * enabling HPM3. The counter wraps, setting OF. Updating bits 31:0
+	 * must preserve both that OF and the existing SINH in bits 63:32.
+	 */
+	csrc	mcountinhibit, t0
+	csrw	\low_csr, t1
+	csrr	t2, CSR_MHPMEVENT3H
+	li	t1, 0xa0000000		/* OF | SINH */
+	bne	t1, t2, exit
+	csrs	mcountinhibit, t0
+
+	li	t4, \first_failure + 1
+	csrr	t2, mip
+	and	t2, t2, t3
+	beqz	t2, exit
+
+	/* Explicitly writing the high half must still be able to clear OF. */
+	li	t4, \first_failure + 2
+	li	t1, 1 << 29		/* Keep SINH, clear OF. */
+	csrw	\high_csr, t1
+	csrr	t2, CSR_MHPMEVENT3H
+	bne	t1, t2, exit
+
+	/* The high-half write must not change the selected event. */
+	li	t4, \first_failure + 3
+	csrr	t2, mhpmevent3
+	li	t1, 2
+	bne	t1, t2, exit
+	.endm
+
+	.text
+	.global _start
+_start:
+	/* Unexpected exceptions report the check in progress. */
+	li	t4, 9
+	lla	t0, exit
+	csrw	mtvec, t0
+	li	t0, 1 << 28		/* menvcfgh.CDE */
+	csrw	CSR_MENVCFGH, t0
+	li	t0, 8
+	csrw	mcounteren, t0		/* Delegate counter 3. */
+	li	t0, 0x43
+	csrw	CSR_SISELECT, t0		/* siselect: counter 3 */
+
+	/* Checks 1-4 use machine CSRs; checks 5-8 use delegated aliases. */
+	/* mhpmevent3, mhpmevent3h */
+	check_selector_write mhpmevent3, CSR_MHPMEVENT3H, 1
+	check_selector_write CSR_SIREG2, CSR_SIREG5, 5	/* sireg2, sireg5 */
+	li	t4, 0
+
+	.balign	4
+exit:
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sw	t0, 0(a1)
+	sw	t4, 4(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence. */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	8
diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
index f1506d06967d64ce3e908f35ee82c2442b2556fb..629278006c6a979682b98e06f1a9243b6dbc556b 100644
--- a/tests/tcg/riscv32/system/meson.build
+++ b/tests/tcg/riscv32/system/meson.build
@@ -22,6 +22,13 @@ tests += {
   },
 }
 
+tests += {
+  'pmu-fixed-rv32.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', '-icount', 'shift=0', qemu_args],
+  },
+}
+
 tests += {
   'smcdeleg-minh-rv32.S': {
     'cflags': cflags,
@@ -43,6 +50,13 @@ tests += {
   },
 }
 
+tests += {
+  'sscofpmf-event-rv32.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', '-icount', 'shift=0', qemu_args],
+  },
+}
+
 if 'qemu-system-riscv32' in emulators
   tcg_tests += {
     'riscv32-softmmu': {
diff --git a/tests/tcg/riscv64/pmu-cycle-controls.S b/tests/tcg/riscv64/pmu-cycle-controls.S
new file mode 100644
index 0000000000000000000000000000000000000000..fdd14755f4d196dc2a3ec6c8b8540adc40b3a253
--- /dev/null
+++ b/tests/tcg/riscv64/pmu-cycle-controls.S
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* CSR number for older assemblers. */
+#define CSR_MCYCLECFG        0x321
+
+/* Check cycle-counter behavior across filter and inhibit control writes. */
+
+	.option	norvc
+	.option	norelax
+
+	.text
+	.global _start
+_start:
+	/*
+	 * Failure bits:
+	 * 0: enabling MINH discards the previously accumulated value
+	 * 1: mcycle changes while M-mode is filtered
+	 * 2: disabling MINH adds the filtered interval
+	 * 3: mcycle does not resume after disabling MINH
+	 */
+	li	t4, 0
+	csrw	mcountinhibit, zero
+	csrw	CSR_MCYCLECFG, zero
+
+	/* Filtering M-mode must not discard the value accumulated so far. */
+	csrr	s0, mcycle
+	.rept	64
+	nop
+	.endr
+	li	t0, 1
+	slli	t0, t0, 62		/* MINH */
+	csrw	CSR_MCYCLECFG, t0
+	csrr	s1, mcycle
+	sltu	t1, s0, s1
+	xori	t1, t1, 1
+	or	t4, t4, t1
+	.rept	128
+	nop
+	.endr
+	csrr	s2, mcycle
+	xor	t1, s1, s2
+	sltu	t1, zero, t1
+	slli	t1, t1, 1
+	or	t4, t4, t1
+
+	/* Removing the filter must not add the inhibited interval. */
+	csrw	CSR_MCYCLECFG, zero
+	csrr	s3, mcycle
+	sub	t1, s3, s2
+	li	t2, 64
+	sltu	t1, t1, t2
+	xori	t1, t1, 1
+	slli	t1, t1, 2
+	or	t4, t4, t1
+	.rept	128
+	nop
+	.endr
+	csrr	t1, mcycle
+	sltu	t1, s3, t1
+	xori	t1, t1, 1
+	slli	t1, t1, 3
+	or	t4, t4, t1
+
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	t4, 8(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence. */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 679ccf414208b0c84b0de1e7beea7201cb4d6b70..6f13ee95b798250d7b4f8f82344aa550c794888f 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -113,6 +113,13 @@ tests += {
   },
 }
 
+tests += {
+  'pmu-cycle-controls.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', '-icount', 'shift=0', qemu_args],
+  },
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {

-- 
2.43.0


