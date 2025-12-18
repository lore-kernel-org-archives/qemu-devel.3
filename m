Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582ECD6E2D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIo7-0003x7-Qy; Thu, 18 Dec 2025 13:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vWIn1-0003nS-68
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:31:51 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vWImy-0007Le-EF
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:31:50 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-59a10df8027so1218191e87.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766082706; x=1766687506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fz6/yRoKmyA4y96hfLNLzvlBPFCau47uJa3XYkJmMi8=;
 b=VtPvLXMJY3wGmCX2eateJS+ZyIhmPgNVCPe/uwhSXBFMruMNPSxw94dli+GUKVsHYp
 xh4YfRah8t4vYwLZUd8fgFSi151jE8n/bUKoW9FWfg4ceGz3E2FgzQriH/w9hQaQL4bN
 VoBg8jAkSDAgHL/k8cLfprtkYTF2eDKta5rHaWqaXBsEEnlLXRps1l3DWIu42smUazuh
 qOGKPqsEjdbCD0R0j+KpHdBt6vqS9Hpm3s3/jBgEl0W5hJ79wctimKI6hX4bmXwsVhn3
 ovNLtDhYKYPI/4Wd/6DCvuYWT88iqvV2mp5xXVO2wcWtG2i3NUeYao0NNvfujUspgxWK
 c9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766082706; x=1766687506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fz6/yRoKmyA4y96hfLNLzvlBPFCau47uJa3XYkJmMi8=;
 b=royWarVpyrn0KAzGpnyfYQeypjIeJoewRSKcFqpckMLaMoQkv9IxUiyTJUvp7Qeo3U
 7WoyaIxu+t2OIZRdvtEUJfFF6NEDO75N/UCCEFX3tPe6/yCc15Wq+/T1Oh+iGZ4a5J3K
 TDI4gfHNVSWUTD6rPOJcvkC3DfIu+KPpRCn7f/MGunMzti990dBKYYZ9WfH5fGV2WtSl
 QGQJiIkac6wpuRRJ9ml8Fapm4Vn29Vmf8z1992ohfB24CBb2uoDVGrVSVQsWyxkaqeSI
 NNAiuHRsyWDnKIcmkOza9hbsPAhUM7EA5o5z44+atQZ0j/tRZCmE0haI4bIwctYbkqZ1
 MiYA==
X-Gm-Message-State: AOJu0YzwFjk2Yhw1le52WmCDIBcG8x0HYNMfTCS2fy0gOE6K69kiMpry
 9n2A9FX4NeYvb4wRJ2iLXmpEtvSEXeXafDT2FvrafyVMB4QTfDoHwSLjsb02AFPb
X-Gm-Gg: AY/fxX5QU28zf8S9MocugyZSCAC1nEFOLohJHVbpY2LKbvUUislHsK+YmowKMdpddrU
 NRWnLRaNS8JlOoeki86TwLdXgGOx2TzusAD0PcZtx6/3F6iODsXRdsMVcWNWCHp5VcODzjzDB7D
 +XZRj6Mwjm4sdBMcMNJLvnTBfMDE0Her7VhIcpYh7qPOixTrquF5dmda+df2yhILBol3qVU2HkA
 aibO5+fk8iybSswFpDJVKTMGKPtNngMeoX2tE5yKpjG4n/ahbsmkwQCTsBLZFUvhslrXe0sOjA8
 o8RtQr/+x24lxhLrjPsNfL99oZ+7MGgESJ/32VAG0XUxTOR9vcu8UmkTcMeqflpsQM1/5kGzfJr
 rBYlE3we8n0ZfFNrBY4d+XnepMeiQJy35e6BQSj1Qh4ee/C+CLaZxxHaIOwFOi1R7G+ef1AZywR
 pL5qKURnNGtHLS
X-Google-Smtp-Source: AGHT+IHEqFEpp06qf9xlk6BJPLvkyTjKlUCY7QBfpUnETc8xFLLng4gDGoFLnkq/9zM2q94dEmw11Q==
X-Received: by 2002:a05:6512:3d1f:b0:594:3340:1b63 with SMTP id
 2adb3069b0e04-59a17d76d7bmr197909e87.49.1766082706092; 
 Thu, 18 Dec 2025 10:31:46 -0800 (PST)
Received: from NB-8855.Dlink ([81.201.19.27]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59a185dd229sm46777e87.22.2025.12.18.10.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 10:31:45 -0800 (PST)
From: Aleksandr Sergeev <sergeev0xef@gmail.com>
To: qemu-devel@nongnu.org
Cc: halip0503@gmail.com,
	Aleksandr Sergeev <sergeev0xef@gmail.com>
Subject: [RFC PATCH 3/6] target/riscv: Get rid of hardcoded SBI events.
Date: Thu, 18 Dec 2025 21:31:18 +0300
Message-ID: <20251218183122.408690-4-sergeev0xef@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218183122.408690-1-sergeev0xef@gmail.com>
References: <20251218183122.408690-1-sergeev0xef@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=sergeev0xef@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:32:44 -0500
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

SBI events are not a part of RISC-V specification
and should not be hardcoded right in QEMU.
It's up to vendor to implement them.

Also, we can get rid of event->ctr mapping,
as it is used only for SBI event handling.

Signed-off-by: Aleksandr Sergeev <sergeev0xef@gmail.com>
Reviewed-by: Alexei Filippov <halip0503@gmail.com>
---
 target/riscv/cpu.h        |  15 ---
 target/riscv/cpu_helper.c |  23 ----
 target/riscv/csr.c        |  18 +--
 target/riscv/pmu.c        | 240 ++------------------------------------
 target/riscv/pmu.h        |   7 --
 5 files changed, 16 insertions(+), 287 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 36e7f10037..8ab5fa0afb 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -550,8 +550,6 @@ struct ArchCPU {
     QEMUTimer *pmu_timer;
     /* A bitmask of Available programmable counters */
     uint32_t pmu_avail_ctrs;
-    /* Mapping of events to counters */
-    GHashTable *pmu_event_ctr_map;
     const GPtrArray *decoders;
 };
 
@@ -925,19 +923,6 @@ enum {
     CSR_TABLE_SIZE = 0x1000
 };
 
-/*
- * The event id are encoded based on the encoding specified in the
- * SBI specification v0.3
- */
-
-enum riscv_pmu_event_idx {
-    RISCV_PMU_EVENT_HW_CPU_CYCLES = 0x01,
-    RISCV_PMU_EVENT_HW_INSTRUCTIONS = 0x02,
-    RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS = 0x10019,
-    RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS = 0x1001B,
-    RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS = 0x10021,
-};
-
 /* used by tcg/tcg-cpu.c*/
 void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en);
 bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c4fb68b5de..b3780cf8a8 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1736,28 +1736,6 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-
-static void pmu_tlb_fill_incr_ctr(RISCVCPU *cpu, MMUAccessType access_type)
-{
-    enum riscv_pmu_event_idx pmu_event_type;
-
-    switch (access_type) {
-    case MMU_INST_FETCH:
-        pmu_event_type = RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS;
-        break;
-    case MMU_DATA_LOAD:
-        pmu_event_type = RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS;
-        break;
-    case MMU_DATA_STORE:
-        pmu_event_type = RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS;
-        break;
-    default:
-        return;
-    }
-
-    riscv_pmu_incr_ctr(cpu, pmu_event_type);
-}
-
 bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr)
@@ -1781,7 +1759,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
-    pmu_tlb_fill_incr_ctr(cpu, access_type);
     if (two_stage_lookup) {
         /* Two stage lookup */
         ret = get_physical_address(env, &pa, &prot, address,
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 81475ec9a3..fb052725fe 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1188,8 +1188,6 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
         env->mhpmevent_val[ctr_idx] = mhpmevt_val;
     }
 
-    riscv_pmu_update_event_map(env, mhpmevt_val, ctr_idx);
-
     return RISCV_EXCP_NONE;
 }
 
@@ -1223,8 +1221,6 @@ static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
     mhpmevt_val = mhpmevt_val | (mhpmevth_val << 32);
     env->mhpmeventh_val[ctr_idx] = mhpmevth_val;
 
-    riscv_pmu_update_event_map(env, mhpmevt_val, ctr_idx);
-
     return RISCV_EXCP_NONE;
 }
 
@@ -1232,7 +1228,7 @@ static target_ulong riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
                                                          int counter_idx,
                                                          bool upper_half)
 {
-    int inst = riscv_pmu_ctr_monitor_instructions(env, counter_idx);
+    int inst = (counter_idx == HPM_MINSTRET_IDX);
     uint64_t *counter_arr_virt = env->pmu_fixed_ctrs[inst].counter_virt;
     uint64_t *counter_arr = env->pmu_fixed_ctrs[inst].counter;
     target_ulong result = 0;
@@ -1303,8 +1299,7 @@ static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
 
     counter->mhpmcounter_val = val;
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
-        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
+        (ctr_idx == HPM_MCYCLE_IDX || ctr_idx == HPM_MINSTRET_IDX)) {
         counter->mhpmcounter_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
                                                                 ctr_idx, false);
         if (ctr_idx > 2) {
@@ -1332,8 +1327,7 @@ static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
     counter->mhpmcounterh_val = val;
     mhpmctr_val = mhpmctr_val | (mhpmctrh_val << 32);
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
-        (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-         riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
+        (ctr_idx == HPM_MCYCLE_IDX || ctr_idx == HPM_MINSTRET_IDX)) {
         counter->mhpmcounterh_prev = riscv_pmu_ctr_get_fixed_counters_val(env,
                                                                  ctr_idx, true);
         if (ctr_idx > 2) {
@@ -1384,8 +1378,7 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
      * The kernel computes the perf delta by subtracting the current value from
      * the value it initialized previously (ctr_val).
      */
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
+    if (ctr_idx == HPM_MCYCLE_IDX || ctr_idx == HPM_MINSTRET_IDX) {
         *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx, upper_half) -
                                                     ctr_prev + ctr_val;
     } else {
@@ -2955,8 +2948,7 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
     /* Check if any other counter is also monitoring cycles/instructions */
     for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
         if (!(updated_ctrs & BIT(cidx)) ||
-            (!riscv_pmu_ctr_monitor_cycles(env, cidx) &&
-            !riscv_pmu_ctr_monitor_instructions(env, cidx))) {
+            (cidx != HPM_MCYCLE_IDX && cidx != HPM_MINSTRET_IDX)) {
             continue;
         }
 
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index b983eadd83..c503fffde1 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -101,82 +101,6 @@ static bool riscv_pmu_counter_enabled(RISCVCPU *cpu, uint32_t ctr_idx)
     }
 }
 
-static int riscv_pmu_incr_ctr_rv32(RISCVCPU *cpu, uint32_t ctr_idx)
-{
-    CPURISCVState *env = &cpu->env;
-    target_ulong max_val = UINT32_MAX;
-    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    bool virt_on = env->virt_enabled;
-
-    /* Privilege mode filtering */
-    if ((env->priv == PRV_M &&
-        (env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_MINH)) ||
-        (env->priv == PRV_S && virt_on &&
-        (env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_VSINH)) ||
-        (env->priv == PRV_U && virt_on &&
-        (env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_VUINH)) ||
-        (env->priv == PRV_S && !virt_on &&
-        (env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_SINH)) ||
-        (env->priv == PRV_U && !virt_on &&
-        (env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_UINH))) {
-        return 0;
-    }
-
-    /* Handle the overflow scenario */
-    if (counter->mhpmcounter_val == max_val) {
-        if (counter->mhpmcounterh_val == max_val) {
-            counter->mhpmcounter_val = 0;
-            counter->mhpmcounterh_val = 0;
-            /* Generate interrupt only if OF bit is clear */
-            if (!(env->mhpmeventh_val[ctr_idx] & MHPMEVENTH_BIT_OF)) {
-                env->mhpmeventh_val[ctr_idx] |= MHPMEVENTH_BIT_OF;
-                riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
-            }
-        } else {
-            counter->mhpmcounterh_val++;
-        }
-    } else {
-        counter->mhpmcounter_val++;
-    }
-
-    return 0;
-}
-
-static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu, uint32_t ctr_idx)
-{
-    CPURISCVState *env = &cpu->env;
-    PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    uint64_t max_val = UINT64_MAX;
-    bool virt_on = env->virt_enabled;
-
-    /* Privilege mode filtering */
-    if ((env->priv == PRV_M &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_MINH)) ||
-        (env->priv == PRV_S && virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VSINH)) ||
-        (env->priv == PRV_U && virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_VUINH)) ||
-        (env->priv == PRV_S && !virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_SINH)) ||
-        (env->priv == PRV_U && !virt_on &&
-        (env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_UINH))) {
-        return 0;
-    }
-
-    /* Handle the overflow scenario */
-    if (counter->mhpmcounter_val == max_val) {
-        counter->mhpmcounter_val = 0;
-        /* Generate interrupt only if OF bit is clear */
-        if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
-            env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
-            riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
-        }
-    } else {
-        counter->mhpmcounter_val++;
-    }
-    return 0;
-}
-
 /*
  * Information needed to update counters:
  *  new_priv, new_virt: To correctly save starting snapshot for the newly
@@ -272,97 +196,6 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
     riscv_pmu_icount_update_priv(env, newpriv, new_virt);
 }
 
-int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
-{
-    uint32_t ctr_idx;
-    int ret;
-    CPURISCVState *env = &cpu->env;
-    gpointer value;
-
-    if (!cpu->cfg.pmu_mask) {
-        return 0;
-    }
-    value = g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                                GUINT_TO_POINTER(event_idx));
-    if (!value) {
-        return -1;
-    }
-
-    ctr_idx = GPOINTER_TO_UINT(value);
-    if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
-        return -1;
-    }
-
-    if (riscv_cpu_mxl(env) == MXL_RV32) {
-        ret = riscv_pmu_incr_ctr_rv32(cpu, ctr_idx);
-    } else {
-        ret = riscv_pmu_incr_ctr_rv64(cpu, ctr_idx);
-    }
-
-    return ret;
-}
-
-bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
-                                        uint32_t target_ctr)
-{
-    RISCVCPU *cpu;
-    uint32_t event_idx;
-    uint32_t ctr_idx;
-
-    /* Fixed instret counter */
-    if (target_ctr == 2) {
-        return true;
-    }
-
-    cpu = env_archcpu(env);
-    if (!cpu->pmu_event_ctr_map) {
-        return false;
-    }
-
-    event_idx = RISCV_PMU_EVENT_HW_INSTRUCTIONS;
-    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                               GUINT_TO_POINTER(event_idx)));
-    if (!ctr_idx) {
-        return false;
-    }
-
-    return target_ctr == ctr_idx ? true : false;
-}
-
-bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
-{
-    RISCVCPU *cpu;
-    uint32_t event_idx;
-    uint32_t ctr_idx;
-
-    /* Fixed mcycle counter */
-    if (target_ctr == 0) {
-        return true;
-    }
-
-    cpu = env_archcpu(env);
-    if (!cpu->pmu_event_ctr_map) {
-        return false;
-    }
-
-    event_idx = RISCV_PMU_EVENT_HW_CPU_CYCLES;
-    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                               GUINT_TO_POINTER(event_idx)));
-
-    /* Counter zero is not used for event_ctr_map */
-    if (!ctr_idx) {
-        return false;
-    }
-
-    return (target_ctr == ctr_idx) ? true : false;
-}
-
-static gboolean pmu_remove_event_map(gpointer key, gpointer value,
-                                     gpointer udata)
-{
-    return (GPOINTER_TO_UINT(value) == GPOINTER_TO_UINT(udata)) ? true : false;
-}
-
 static int64_t pmu_icount_ticks_to_ns(int64_t value)
 {
     int64_t ret = 0;
@@ -376,50 +209,6 @@ static int64_t pmu_icount_ticks_to_ns(int64_t value)
     return ret;
 }
 
-int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
-                               uint32_t ctr_idx)
-{
-    uint32_t event_idx;
-    RISCVCPU *cpu = env_archcpu(env);
-
-    if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->pmu_event_ctr_map) {
-        return -1;
-    }
-
-    /*
-     * Expected mhpmevent value is zero for reset case. Remove the current
-     * mapping.
-     */
-    if (!(value & MHPMEVENT_IDX_MASK)) {
-        g_hash_table_foreach_remove(cpu->pmu_event_ctr_map,
-                                    pmu_remove_event_map,
-                                    GUINT_TO_POINTER(ctr_idx));
-        return 0;
-    }
-
-    event_idx = value & MHPMEVENT_IDX_MASK;
-    if (g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                            GUINT_TO_POINTER(event_idx))) {
-        return 0;
-    }
-
-    switch (event_idx) {
-    case RISCV_PMU_EVENT_HW_CPU_CYCLES:
-    case RISCV_PMU_EVENT_HW_INSTRUCTIONS:
-    case RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS:
-    case RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS:
-    case RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS:
-        break;
-    default:
-        /* We don't support any raw events right now */
-        return -1;
-    }
-    g_hash_table_insert(cpu->pmu_event_ctr_map, GUINT_TO_POINTER(event_idx),
-                        GUINT_TO_POINTER(ctr_idx));
-
-    return 0;
-}
-
 static bool pmu_hpmevent_is_of_set(CPURISCVState *env, uint32_t ctr_idx)
 {
     target_ulong mhpmevent_val;
@@ -457,23 +246,19 @@ static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
     return false;
 }
 
-static void pmu_timer_trigger_irq(RISCVCPU *cpu,
-                                  enum riscv_pmu_event_idx evt_idx)
+static void pmu_timer_trigger_irq(RISCVCPU *cpu, uint32_t ctr_idx)
 {
-    uint32_t ctr_idx;
     CPURISCVState *env = &cpu->env;
     PMUCTRState *counter;
     int64_t irq_trigger_at;
     uint64_t curr_ctr_val, curr_ctrh_val;
     uint64_t ctr_val;
 
-    if (evt_idx != RISCV_PMU_EVENT_HW_CPU_CYCLES &&
-        evt_idx != RISCV_PMU_EVENT_HW_INSTRUCTIONS) {
+    if (ctr_idx != HPM_MINSTRET_IDX &&
+        ctr_idx != HPM_MCYCLE_IDX) {
         return;
     }
 
-    ctr_idx = GPOINTER_TO_UINT(g_hash_table_lookup(cpu->pmu_event_ctr_map,
-                               GUINT_TO_POINTER(evt_idx)));
     if (!riscv_pmu_counter_enabled(cpu, ctr_idx)) {
         return;
     }
@@ -523,10 +308,13 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
 void riscv_pmu_timer_cb(void *priv)
 {
     RISCVCPU *cpu = priv;
+    uint32_t ctr_idx;
 
-    /* Timer event was triggered only for these events */
-    pmu_timer_trigger_irq(cpu, RISCV_PMU_EVENT_HW_CPU_CYCLES);
-    pmu_timer_trigger_irq(cpu, RISCV_PMU_EVENT_HW_INSTRUCTIONS);
+    for (ctr_idx = 0; ctr_idx < RV_MAX_MHPMCOUNTERS; ctr_idx++) {
+        if (riscv_pmu_counter_valid(cpu, ctr_idx)) {
+            pmu_timer_trigger_irq(cpu, ctr_idx);
+        }
+    }
 }
 
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
@@ -557,8 +345,8 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
         overflow_left = overflow_delta - INT64_MAX;
     }
 
-    if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
-        riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
+    if (ctr_idx == HPM_MCYCLE_IDX ||
+        ctr_idx == HPM_MINSTRET_IDX) {
         overflow_ns = pmu_icount_ticks_to_ns((int64_t)overflow_delta);
         overflow_left = pmu_icount_ticks_to_ns(overflow_left) ;
     } else {
@@ -592,12 +380,6 @@ void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    cpu->pmu_event_ctr_map = g_hash_table_new(g_direct_hash, g_direct_equal);
-    if (!cpu->pmu_event_ctr_map) {
-        error_setg(errp, "Unable to allocate PMU event hash table");
-        return;
-    }
-
     cpu->pmu_avail_ctrs = cpu->cfg.pmu_mask;
 }
 
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 8f019bea9f..97b167d8f2 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -22,15 +22,8 @@
 #include "cpu.h"
 #include "qapi/error.h"
 
-bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
-                                        uint32_t target_ctr);
-bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env,
-                                  uint32_t target_ctr);
 void riscv_pmu_timer_cb(void *priv);
 void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
-int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
-                               uint32_t ctr_idx);
-int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
-- 
2.51.0


