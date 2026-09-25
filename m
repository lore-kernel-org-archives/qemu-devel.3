Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC58C9832A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xADod-0007zg-Qn; Fri, 25 Sep 2026 17:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADo8-0007lH-It
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:22 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADo2-0007kz-JC
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:12 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 d2e1a72fcca58-8804b59404aso532754b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790373009; x=1790977809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tMmCze3sPkjcYyDerNEGCIJ6B0dT/d1kXK1wyuv2STI=;
 b=UBaEPMcR6brwWeQ72IchlW1/NeZeEHX9x9X5lB+fSCYFK2poxXC3TuESTTFZh5p4Ti
 GPtfv/5PbQ4pnCOMzBxJxfbvLO9wlbLhfTn2bFxIjbOjnXhFsIDFLIQQGMvP88Vb/DJd
 qX3DVz3sdw8KxnWE4ELOY01QI944ilLkESakXdX0SL6LfGwa8yOXXbHfbKPU3sHlbgKZ
 DAw8dhckubq9AKcl0xOjTGBrk2TrLlhbU6zCOXt+JOBov3NLB8W9NyWmfQt1/zV7OjXz
 X80UEosLAQg+p9kERFo9V9QplVX2CMd1bgAUVxemd4d2h2gAJe01EE8USh8UU7EkfmAC
 NQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790373009; x=1790977809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tMmCze3sPkjcYyDerNEGCIJ6B0dT/d1kXK1wyuv2STI=;
 b=x7TyA6Yiyz5Su8/qg72OhGJsHTqE3M0c0MH510k9gcAFetMYnKJzLeo5To8rzVO2z6
 l8L15I9FlYyVr2v7+FTZrL3EZK76mJ7qZ+/KWFxjKposz8Sl1BOz5nqcVMcct4pEy08U
 r/CesKMS34LyDVKnHRk5rfdvRhtOaUxechg7sM+NKxQ+0j6G9VkVRLnTW/9TN8p0Wod5
 gbF5OWqYMtgHcBlT66mMzzBorSrFM3pDb6uLhdcVx9s68lLIsvzKneB4Ld9k2LvdxmG/
 u2OSgb+MVjLCY0DbhF7UwUHgrYzyTJhnptuNrKhMPcPNoJa3IMnBLZLLlnkBNwLFcNsZ
 Afjw==
X-Gm-Message-State: AFuF++nRz58wIHEQoVI47ZrNh3HTe03NWCQhveYCwLRL6xP7bZkrTu0e
 tBl9JnQ/fYlTvRtWp13NZy4rQyxv2TkG48eyMaLv1WawFufwoeWIL5T7lWWSB1sX6Sb70Z/in71
 Tij7C
X-Gm-Gg: AYBFou258FJ2jU8ysrDjd8EuHARB7BxRx3bGvAPODND0ka81dDFQJ0FNY50M30Wobg6
 0kO01OZiec9gnvG+pebUr80Q5KfjtqcylLA8PQjS8Dos5ChD77mHNCBk2hwM3l58Tu7TYYTnTzQ
 vfqePvTTWIdHrBPywnpgBc44Ldg6+MCAqvsljr8d7XbQPsLPcQYP+MqbQdYVtLonCaU+dBZTAEa
 Uj7ZKGTxWBapNsoSmuyi1Cfjw+WPPen5BkuaAW4ZtTziisGct0UCIMt60tppEyMpUdcJHMIv4BZ
 TuXvKFWhkDLeyARgz9pPVxumhL6jwWe5u43A0eF5VmU/hcoGGAPPTvFXl2y55eqlPKYHB0pXPIC
 ++jnc4Qk8AuE0eNmEkv6SJkT7osun+v+Arg5OJR5UOZ2bG0KiLRmoHxAkvl07TfvSwS6p+PGuvi
 OlNErdLJMrH36vUfOsGiISj4xd6vhXN1W5bFlVgY2Op1uWAtoUVlSMNioVMwdHVt6TQ2INL3EDe
 fLJ5mctGuKV5undxymu/VlPA+32pro=
X-Received: by 2002:aa7:88ce:0:b0:874:32d1:d3d8 with SMTP id
 d2e1a72fcca58-87e99568188mr5692465b3a.21.1790373009056; 
 Fri, 25 Sep 2026 14:50:09 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea1940ecsm1725256b3a.13.2026.09.25.14.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 14:50:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 03/14] target/arm: Split out rebuild_hflags_common_aprofile
Date: Fri, 25 Sep 2026 14:49:53 -0700
Message-ID: <20260925215004.456336-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925215004.456336-1-richard.henderson@linaro.org>
References: <20260925215004.456336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Alignment, FGT, and IL are common to a32 and a64, though the
latter comes from different places.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/hflags.c | 65 +++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index eb1aff91d5f..8da02ae1ecf 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -114,6 +114,24 @@ static void rebuild_hflags_common_32(CPUARMTBFlags *flags, CPUARMState *env)
     DP_TBFLAG_A32(*flags, NS, !access_secure_reg(env));
 }
 
+static void rebuild_hflags_common_aprofile(CPUARMTBFlags *flags,
+                                           CPUARMState *env, int el,
+                                           uint64_t sctlr, bool il)
+{
+    if (il) {
+        DP_TBFLAG_ANY(*flags, PSTATE__IL, 1);
+    }
+    if (aprofile_require_alignment(env, el, sctlr)) {
+        DP_TBFLAG_ANY(*flags, ALIGN_MEM, 1);
+    }
+    if (arm_fgt_active(env, el)) {
+        DP_TBFLAG_ANY(*flags, FGT_ACTIVE, 1);
+        if (fgt_svc(env, el)) {
+            DP_TBFLAG_ANY(*flags, FGT_SVC, 1);
+        }
+    }
+}
+
 static CPUARMTBFlags rebuild_hflags_m32(CPUARMState *env, int fp_el,
                                         ARMMMUIdx mmu_idx)
 {
@@ -284,9 +302,8 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
 
     el = arm_current_el(env);
     sctlr = arm_sctlr(env, el);
-    if (aprofile_require_alignment(env, el, sctlr)) {
-        DP_TBFLAG_ANY(flags, ALIGN_MEM, 1);
-    }
+    rebuild_hflags_common_aprofile(&flags, env, el, sctlr,
+                                   env->uncached_cpsr & CPSR_IL);
 
     if (arm_el_is_aa64(env, 1)) {
         DP_TBFLAG_A32(flags, VFPEN, 1);
@@ -297,17 +314,6 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
         DP_TBFLAG_A32(flags, HSTR_ACTIVE, 1);
     }
 
-    if (arm_fgt_active(env, el)) {
-        DP_TBFLAG_ANY(flags, FGT_ACTIVE, 1);
-        if (fgt_svc(env, el)) {
-            DP_TBFLAG_ANY(flags, FGT_SVC, 1);
-        }
-    }
-
-    if (env->uncached_cpsr & CPSR_IL) {
-        DP_TBFLAG_ANY(flags, PSTATE__IL, 1);
-    }
-
     /*
      * The SME exception we are testing for is raised via
      * AArch64.CheckFPAdvSIMDEnabled(), as called from
@@ -397,14 +403,17 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
 {
     CPUARMTBFlags flags = rebuild_hflags_common(env, fp_el, mmu_idx);
     ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
-    uint64_t tcr = regime_tcr(env, mmu_idx);
-    uint64_t hcr = arm_hcr_el2_eff(env);
-    uint64_t sctlr;
+    uint64_t sctlr = regime_sctlr(env, stage1);
+    uint64_t tcr, hcr;
     int tbii, tbid, mtx;
 
+    rebuild_hflags_common_aprofile(&flags, env, el, sctlr,
+                                   env->pstate & PSTATE_IL);
+
     DP_TBFLAG_ANY(flags, AARCH64_STATE, 1);
 
     /* Get control bits for tagged addresses.  */
+    tcr = regime_tcr(env, mmu_idx);
     tbid = aa64_va_parameter_tbi(tcr, mmu_idx);
     tbii = tbid & ~aa64_va_parameter_tbid(tcr, mmu_idx);
     mtx = cpu_isar_feature(aa64_mte_mtx, env_archcpu(env)) ?
@@ -415,6 +424,7 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     DP_TBFLAG_A64(flags, TBID, tbid);
 
     /* E2H is used by both VHE and NV2. */
+    hcr = arm_hcr_el2_eff(env);
     if (hcr & HCR_E2H) {
         DP_TBFLAG_A64(flags, E2H, 1);
     }
@@ -465,12 +475,6 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
-    sctlr = regime_sctlr(env, stage1);
-
-    if (aprofile_require_alignment(env, el, sctlr)) {
-        DP_TBFLAG_ANY(flags, ALIGN_MEM, 1);
-    }
-
     if (arm_cpu_data_is_big_endian_a64(el, sctlr)) {
         DP_TBFLAG_ANY(flags, BE_DATA, 1);
     }
@@ -525,18 +529,9 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
-    if (env->pstate & PSTATE_IL) {
-        DP_TBFLAG_ANY(flags, PSTATE__IL, 1);
-    }
-
-    if (arm_fgt_active(env, el)) {
-        DP_TBFLAG_ANY(flags, FGT_ACTIVE, 1);
-        if (FIELD_EX64(env->cp15.fgt_exec[FGTREG_HFGITR], HFGITR_EL2, ERET)) {
-            DP_TBFLAG_A64(flags, TRAP_ERET, 1);
-        }
-        if (fgt_svc(env, el)) {
-            DP_TBFLAG_ANY(flags, FGT_SVC, 1);
-        }
+    if (EX_TBFLAG_ANY(flags, FGT_ACTIVE) &&
+        FIELD_EX64(env->cp15.fgt_exec[FGTREG_HFGITR], HFGITR_EL2, ERET)) {
+        DP_TBFLAG_A64(flags, TRAP_ERET, 1);
     }
 
     /*
-- 
2.53.0


