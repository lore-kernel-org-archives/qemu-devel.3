Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2744CC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZA-0000ZN-8W; Thu, 23 May 2024 19:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYe-0008LV-Eu; Thu, 23 May 2024 19:09:14 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYc-0005lq-6k; Thu, 23 May 2024 19:09:12 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7e1d924b0b0so365770839f.1; 
 Thu, 23 May 2024 16:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505748; x=1717110548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQBOJmwAafvlKzztCpEU/6DVh7h2qJ0yINxobE56wQw=;
 b=JvgdvK3Cs1IlAInNXlxWGrmDoxDogCJfOBAG3Xw+5seIvE4HNJUMZeNNJ913tXO9Yx
 pquN6WOQ1eW67oz4+5/Kui1IRclFQnKcNI5Ceag9xA532neKbEM9rxBmsb80tXi2Fbzt
 eQ3BCQrN6/GNStOBDlmtQOPUHe0SYfR6KsNfxabvQByyUWi410S9h4HgH+K05LTdWtDv
 Wisl304KSTvm3ntjBj2fz08bZj0C8kKQC6Pa8vM8+M0pH0IVzUtjlhg5+XR+bL4OEUHO
 YNtYTxhAotRX5bc9Lj3g/KswMRE5+2XILdNvDh0guFJWUZvTMXMtp0yIBvsIQaJga1kt
 1szQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505748; x=1717110548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQBOJmwAafvlKzztCpEU/6DVh7h2qJ0yINxobE56wQw=;
 b=u2is3dLybjLizuOnOOc0q1ECGaCO1iGgAB2g0SFp26t8hS1TaaA1o3G2zFY1OCjymc
 Cu7cfJbHuHCEgAbA53bYxsoPk7E1+cPOW1Tps6kI7xjxWYiAXlPFBBaW4NpeJGJfxaPv
 I7951EMR+S992L57nbgHTGFsTewCmeDvfQwrCoq71EqsdkiPEyymaY12Z7qSX1SrjZCW
 cKC4yeBk+icWPH0FmnwNR5VOLxbxAd/KQqckw9rpO8rdaYSLh6iBHwmRgZYKho+JItFK
 MSBys0OvJhEo7rTf7xTw9hXNj9JmNZZnR5WcCNzGDQP80xCkgETW0g31LxeMHwqRcoZv
 v8nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT76Q6j2B7UdUsJMqNXVNWUuZ8Gj+W3uwG//NpXKAl3yxxb2GYmZBdALTcTm9+U5YBFfb3w7FZxp6sw2JwN3tRxHru
X-Gm-Message-State: AOJu0Yx6YUIZqvI/8D3w2CXnkon+BOfuEYdPOhyIRKmBRT41Us0XdjpW
 bLgSCYUr36xrCED2Od1b2rGc+ouk7kRFTmoRIP2bN3p4+pLABjSCP5liyg==
X-Google-Smtp-Source: AGHT+IGIof6dwznpG943dnQlaz7Y2dyV41/la02WB7MBxD3yutISig4u9HeMDQSbNNs4pWSz/Ue5Rg==
X-Received: by 2002:a6b:f108:0:b0:7de:9c28:3119 with SMTP id
 ca18e2360f4ac-7e8c54c2329mr100083439f.12.1716505748068; 
 Thu, 23 May 2024 16:09:08 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 22/72] This commit is preparatory to the addition of Branch
 History Rolling Buffer (BHRB) functionality,
 which is being provided today starting with the P8 processor.
Date: Fri, 24 May 2024 09:06:55 +1000
Message-ID: <20240523230747.45703-23-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=npiggin@gmail.com; helo=mail-io1-xd30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

BHRB uses several SPR register fields to control whether or not
a branch instruction's address (and sometimes target address)
should be recorded.  Checking each of these fields with each
branch instruction using jitted code would lead to a significant
decrease in performance.

Therefore, it was decided that BHRB configuration bits that are
not expected to change frequently should have their state summarized
in an hflag so that the amount of checking done by jitted code can
be reduced.

This commit contains the changes for summarizing the state of the
following register fields in the HFLAGS_BHRB_ENABLE hflag:

	MMCR0[FCP] - Determines if BHRB recording is frozen in the
                     problem state

	MMCR0[FCPC] - A modifier for MMCR0[FCP]

	MMCRA[BHRBRD] - Disables all BHRB recording for a thread

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h                 |  5 +++++
 target/ppc/cpu_init.c            |  4 ++--
 target/ppc/helper.h              |  1 +
 target/ppc/helper_regs.c         | 37 ++++++++++++++++++++++++++++++++
 target/ppc/machine.c             |  2 +-
 target/ppc/power8-pmu-regs.c.inc |  5 +++++
 target/ppc/power8-pmu.c          | 15 +++++++++----
 target/ppc/power8-pmu.h          |  4 ++--
 target/ppc/spr_common.h          |  1 +
 target/ppc/translate.c           |  2 ++
 10 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a5f46d0b10..195d4be2b7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -533,6 +533,8 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define MMCR0_FC56   PPC_BIT(59)         /* PMC Freeze Counters 5-6 bit */
 #define MMCR0_PMC1CE PPC_BIT(48)         /* MMCR0 PMC1 Condition Enabled */
 #define MMCR0_PMCjCE PPC_BIT(49)         /* MMCR0 PMCj Condition Enabled */
+#define MMCR0_FCP    PPC_BIT(34)         /* Freeze Counters/BHRB if PR=1 */
+#define MMCR0_FCPC   PPC_BIT(51)         /* Condition for FCP bit */
 /* MMCR0 userspace r/w mask */
 #define MMCR0_UREG_MASK (MMCR0_FC | MMCR0_PMAO | MMCR0_PMAE)
 /* MMCR2 userspace r/w mask */
@@ -545,6 +547,8 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define MMCR2_UREG_MASK (MMCR2_FC1P0 | MMCR2_FC2P0 | MMCR2_FC3P0 | \
                          MMCR2_FC4P0 | MMCR2_FC5P0 | MMCR2_FC6P0)
 
+#define MMCRA_BHRBRD    PPC_BIT(26)         /* BHRB Recording Disable */
+
 #define MMCR1_EVT_SIZE 8
 /* extract64() does a right shift before extracting */
 #define MMCR1_PMC1SEL_START 32
@@ -797,6 +801,7 @@ enum {
     HFLAGS_PMCJCE = 17, /* MMCR0 PMCjCE bit */
     HFLAGS_PMC_OTHER = 18, /* PMC other than PMC5-6 is enabled */
     HFLAGS_INSN_CNT = 19, /* PMU instruction count enabled */
+    HFLAGS_BHRB_ENABLE = 20, /* Summary flag for enabling BHRB */
     HFLAGS_VSX = 23, /* MSR_VSX if cpu has VSX */
     HFLAGS_VR = 25,  /* MSR_VR if cpu has VRE */
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 914c6e0f18..366ea8568b 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5152,7 +5152,7 @@ static void register_book3s_pmu_sup_sprs(CPUPPCState *env)
                      KVM_REG_PPC_MMCR1, 0x00000000);
     spr_register_kvm(env, SPR_POWER_MMCRA, "MMCRA",
                      SPR_NOACCESS, SPR_NOACCESS,
-                     &spr_read_generic, &spr_write_generic,
+                     &spr_read_generic, &spr_write_MMCRA,
                      KVM_REG_PPC_MMCRA, 0x00000000);
     spr_register_kvm(env, SPR_POWER_PMC1, "PMC1",
                      SPR_NOACCESS, SPR_NOACCESS,
@@ -7196,7 +7196,7 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
         if (env->mmu_model != POWERPC_MMU_REAL) {
             ppc_tlb_invalidate_all(env);
         }
-        pmu_mmcr01_updated(env);
+        pmu_mmcr01a_updated(env);
     }
 
     /* clean any pending stop state */
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 6d6f31366c..7b07cd1a49 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -30,6 +30,7 @@ DEF_HELPER_2(store_dawr0, void, env, tl)
 DEF_HELPER_2(store_dawrx0, void, env, tl)
 DEF_HELPER_2(store_mmcr0, void, env, tl)
 DEF_HELPER_2(store_mmcr1, void, env, tl)
+DEF_HELPER_2(store_mmcrA, void, env, tl)
 DEF_HELPER_3(store_pmc, void, env, i32, i64)
 DEF_HELPER_2(read_pmc, tl, env, i32)
 DEF_HELPER_2(insns_inc, void, env, i32)
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 9094ae5004..16b43702d5 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -47,6 +47,39 @@ void hreg_swap_gpr_tgpr(CPUPPCState *env)
     env->tgpr[3] = tmp;
 }
 
+#if defined(TARGET_PPC64)
+static bool hreg_check_bhrb_enable(CPUPPCState *env)
+{
+    bool pr = !!(env->msr & (1 << MSR_PR));
+    target_long mmcr0;
+    bool fcp;
+    bool hv;
+
+    /* ISA 3.1 adds the PMCRA[BRHBRD] and problem state checks */
+    if ((env->insns_flags2 & PPC2_ISA310) &&
+        ((env->spr[SPR_POWER_MMCRA] & MMCRA_BHRBRD) || !pr)) {
+        return false;
+    }
+
+    /* Check for BHRB "frozen" conditions */
+    mmcr0 = env->spr[SPR_POWER_MMCR0];
+    fcp = !!(mmcr0 & MMCR0_FCP);
+    if (mmcr0 & MMCR0_FCPC) {
+        hv = !!(env->msr & (1ull << MSR_HV));
+        if (fcp) {
+            if (hv && pr) {
+                return false;
+            }
+        } else if (!hv && pr) {
+            return false;
+        }
+    } else if (fcp && pr) {
+        return false;
+    }
+    return true;
+}
+#endif
+
 static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
 {
     uint32_t hflags = 0;
@@ -61,6 +94,9 @@ static uint32_t hreg_compute_pmu_hflags_value(CPUPPCState *env)
     if (env->spr[SPR_POWER_MMCR0] & MMCR0_PMCjCE) {
         hflags |= 1 << HFLAGS_PMCJCE;
     }
+    if (hreg_check_bhrb_enable(env)) {
+        hflags |= 1 << HFLAGS_BHRB_ENABLE;
+    }
 
 #ifndef CONFIG_USER_ONLY
     if (env->pmc_ins_cnt) {
@@ -85,6 +121,7 @@ static uint32_t hreg_compute_pmu_hflags_mask(CPUPPCState *env)
     hflags_mask |= 1 << HFLAGS_PMCJCE;
     hflags_mask |= 1 << HFLAGS_INSN_CNT;
     hflags_mask |= 1 << HFLAGS_PMC_OTHER;
+    hflags_mask |= 1 << HFLAGS_BHRB_ENABLE;
 #endif
     return hflags_mask;
 }
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 203fe28e01..6b6c31d903 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -333,7 +333,7 @@ static int cpu_post_load(void *opaque, int version_id)
          * triggered types (including HDEC) would need to carry more state.
          */
         cpu_ppc_store_decr(env, env->spr[SPR_DECR]);
-        pmu_mmcr01_updated(env);
+        pmu_mmcr01a_updated(env);
     }
 
     return 0;
diff --git a/target/ppc/power8-pmu-regs.c.inc b/target/ppc/power8-pmu-regs.c.inc
index 4956a8b350..652cf20704 100644
--- a/target/ppc/power8-pmu-regs.c.inc
+++ b/target/ppc/power8-pmu-regs.c.inc
@@ -175,6 +175,11 @@ void spr_write_MMCR2_ureg(DisasContext *ctx, int sprn, int gprn)
     gen_store_spr(SPR_POWER_MMCR2, masked_gprn);
 }
 
+void spr_write_MMCRA(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_mmcrA(tcg_env, cpu_gpr[gprn]);
+}
+
 void spr_read_PMC(DisasContext *ctx, int gprn, int sprn)
 {
     TCGv_i32 t_sprn = tcg_constant_i32(sprn);
diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index cbc5889d91..6f5d4e1256 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -82,7 +82,7 @@ static void pmu_update_summaries(CPUPPCState *env)
     env->pmc_cyc_cnt = cyc_cnt;
 }
 
-void pmu_mmcr01_updated(CPUPPCState *env)
+void pmu_mmcr01a_updated(CPUPPCState *env)
 {
     PowerPCCPU *cpu = env_archcpu(env);
 
@@ -260,7 +260,7 @@ void helper_store_mmcr0(CPUPPCState *env, target_ulong value)
 
     env->spr[SPR_POWER_MMCR0] = value;
 
-    pmu_mmcr01_updated(env);
+    pmu_mmcr01a_updated(env);
 
     /* Update cycle overflow timers with the current MMCR0 state */
     pmu_update_overflow_timers(env);
@@ -272,7 +272,14 @@ void helper_store_mmcr1(CPUPPCState *env, uint64_t value)
 
     env->spr[SPR_POWER_MMCR1] = value;
 
-    pmu_mmcr01_updated(env);
+    pmu_mmcr01a_updated(env);
+}
+
+void helper_store_mmcrA(CPUPPCState *env, uint64_t value)
+{
+    env->spr[SPR_POWER_MMCRA] = value;
+
+    pmu_mmcr01a_updated(env);
 }
 
 target_ulong helper_read_pmc(CPUPPCState *env, uint32_t sprn)
@@ -301,7 +308,7 @@ static void perfm_alert(PowerPCCPU *cpu)
         env->spr[SPR_POWER_MMCR0] |= MMCR0_FC;
 
         /* Changing MMCR0_FC requires summaries and hflags update */
-        pmu_mmcr01_updated(env);
+        pmu_mmcr01a_updated(env);
 
         /*
          * Delete all pending timers if we need to freeze
diff --git a/target/ppc/power8-pmu.h b/target/ppc/power8-pmu.h
index 775e640053..87fa8c9334 100644
--- a/target/ppc/power8-pmu.h
+++ b/target/ppc/power8-pmu.h
@@ -18,10 +18,10 @@
 #define PMC_COUNTER_NEGATIVE_VAL 0x80000000UL
 
 void cpu_ppc_pmu_init(CPUPPCState *env);
-void pmu_mmcr01_updated(CPUPPCState *env);
+void pmu_mmcr01a_updated(CPUPPCState *env);
 #else
 static inline void cpu_ppc_pmu_init(CPUPPCState *env) { }
-static inline void pmu_mmcr01_updated(CPUPPCState *env) { }
+static inline void pmu_mmcr01a_updated(CPUPPCState *env) { }
 #endif
 
 #endif
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 8a9d6cd994..eb2561f593 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -85,6 +85,7 @@ void spr_write_generic32(DisasContext *ctx, int sprn, int gprn);
 void spr_core_write_generic(DisasContext *ctx, int sprn, int gprn);
 void spr_write_MMCR0(DisasContext *ctx, int sprn, int gprn);
 void spr_write_MMCR1(DisasContext *ctx, int sprn, int gprn);
+void spr_write_MMCRA(DisasContext *ctx, int sprn, int gprn);
 void spr_write_PMC(DisasContext *ctx, int sprn, int gprn);
 void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn);
 void spr_read_xer(DisasContext *ctx, int gprn, int sprn);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 2c39605273..a85f596d65 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -193,6 +193,7 @@ struct DisasContext {
     bool mmcr0_pmcjce;
     bool pmc_other;
     bool pmu_insn_cnt;
+    bool bhrb_enable;
     ppc_spr_t *spr_cb; /* Needed to check rights for mfspr/mtspr */
     int singlestep_enabled;
     uint32_t flags;
@@ -6345,6 +6346,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mmcr0_pmcjce = (hflags >> HFLAGS_PMCJCE) & 1;
     ctx->pmc_other = (hflags >> HFLAGS_PMC_OTHER) & 1;
     ctx->pmu_insn_cnt = (hflags >> HFLAGS_INSN_CNT) & 1;
+    ctx->bhrb_enable = (hflags >> HFLAGS_BHRB_ENABLE) & 1;
 
     ctx->singlestep_enabled = 0;
     if ((hflags >> HFLAGS_SE) & 1) {
-- 
2.43.0


