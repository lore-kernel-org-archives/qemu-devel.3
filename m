Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65244CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usODc-0003w5-Hk; Sat, 30 Aug 2025 12:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQf-0007GC-2K
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:09 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQb-0004ri-Mg
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:08 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-248ff5cabe0so12032105ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532824; x=1757137624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8B7sIbsSJ/cOWPqqEvvb1o4vwQPENNhK2iKckGHu1kw=;
 b=ukyjja0etJPzF2sge61036Hpym2dA7p9z0C9QLS1p1IdgCat/LRhj39ujp6sW26CK5
 Lcg65aUUhbh1R2KgURDj0w3A5Kt4vgvpX5NJ3ISc2Jf1ohSHBEO4U5wEfjwTiZi33nur
 pMchigqJMSpuiJNyWE2mJEEwD3TEUidHk3BRSVLeB190VGsVxOCsazb67f4PGqu1lMYQ
 5BlnM3T3VSInQvN1DmWiFmsHtEdBVE7JnfYin48QVDgCh+faQaOqwFXUcu1cWpVXr1KQ
 Y3cJfmhA4f2Uw9R/fDK+spKDo+LpfNqe1KNE4n0I1cei3BBzcmS1zWUt2/NQ8zNGogFv
 eDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532824; x=1757137624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8B7sIbsSJ/cOWPqqEvvb1o4vwQPENNhK2iKckGHu1kw=;
 b=ZWQLoVtjd3Pg5FIvwhoYzMsa9tuCIecI3u5VbS9wxCtGd8Ot6SO7ZkpEHFNxOGyF2P
 hr+uNoxiNHY0wriRoeJtARji6LxdJmehdrXbQ7MZLY5KyWUSaDEHZA6ImBKiZuvZ3n+4
 /REQUk/weoe+9U/OiZqb0qRhpX+q746Q+Q8lOhr0sVvFVVYQu8enp/DQw4TlRx7hTeVU
 uT71Jm4fJD3y1D6nRngv8M9JJZSoSP9KouvZp99sc0pB2iaox6lHabSgjpOTRzgwZGPL
 qfzE5WlIoCV+p4xhKKBrIEVzAsqKJ+5o/Av8oO+UsC5PNzje9fN1quzAjX7c/pY96ito
 ReeQ==
X-Gm-Message-State: AOJu0YzOK+4YdC1prIdNJhSQlitLEHriSabXWFZpj6QDWkMPK2LVDtIJ
 dF6JAYb6xLMf/FX9pUxYh+/QLxs71iKOM8As0kGBlrRLX8NJD8LDGju31mCSocWdnXJhIXv8kgO
 C6fG6GkU=
X-Gm-Gg: ASbGncshSpBs/g2dbxWR8m2xHO+dMr+bVt0gMOMiO/W86+owxgzWp6ly30yklVIfwSq
 gLaIc32cqeRP5d2cHUoxzgnwhBzDLJZlIh2I/DBom4JX1VquSNQegRgJrHx++ofoePVeMx2rRBS
 C+QSk/eV2PrI+mIdoFcM4wVda1hgiLLq1Dfob2a8B1j/nBlSjpsCa7H9N2WabpU+NhJWukECur/
 fFTgGxSc1247UdQ8qDToeEdc6V12r1P6AgCxtNvfrjAfQGJ8TLM9zyCl5lsNkBaUS9ydgCM8H+d
 7i09VdnCl/AumgUEsC8MZIRNbVnhBFuyrWeucZRxUP4T/BRqnP00XeSdsYiAKFoF1W8IRjs7AUw
 GcHWTQ/Nv37NQkYuLueNFgxetgweAuw0XKVAkFYbqw2+vHxyrHmMkpbo4XtY5wRNKZdZjDhOkcg
 ==
X-Google-Smtp-Source: AGHT+IF4jSutS5ul/aEuCvRgPJiuCGXz5G0mpCqAizeb9k2KQQlI9oSYZHPqrQ0qPzlkXYluqNV1+Q==
X-Received: by 2002:a17:902:ebc5:b0:246:a93c:5850 with SMTP id
 d9443c01a7336-24944ad3977mr10464805ad.42.1756532823704; 
 Fri, 29 Aug 2025 22:47:03 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 52/84] target/arm: Implement EXLOCKException for ELR_ELx
 and SPSR_ELx
Date: Sat, 30 Aug 2025 15:40:56 +1000
Message-ID: <20250830054128.448363-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

If PSTATE.EXLOCK is set, and the GCS EXLOCK enable bit is set,
and nested virt is in the appropriate state, then we need to
raise an EXLOCK exception.

Since PSTATE.EXLOCK cannot be set without GCS being present
and enabled, no explicit check for GCS is required.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h        |  3 ++
 target/arm/cpu.h           |  1 +
 target/arm/helper.c        | 83 +++++++++++++++++++++++++++++++++++---
 target/arm/tcg/op_helper.c |  4 ++
 4 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index bc6adf5956..15894332b2 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -346,6 +346,9 @@ typedef enum CPAccessResult {
      * specified target EL.
      */
     CP_ACCESS_UNDEFINED = (2 << 2),
+
+    /* Access fails with EXLOCK, a GCS exception syndrome. */
+    CP_ACCESS_EXLOCK = (3 << 2),
 } CPAccessResult;
 
 /* Indexes into fgt_read[] */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d5a5152a9c..17902eb40d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1511,6 +1511,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_C (1U << 29)
 #define PSTATE_Z (1U << 30)
 #define PSTATE_N (1U << 31)
+#define PSTATE_EXLOCK (1ULL << 34)
 #define PSTATE_NZCV (PSTATE_N | PSTATE_Z | PSTATE_C | PSTATE_V)
 #define PSTATE_DAIF (PSTATE_D | PSTATE_A | PSTATE_I | PSTATE_F)
 #define CACHED_PSTATE_BITS (PSTATE_NZCV | PSTATE_DAIF | PSTATE_BTYPE)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 83a7d6ae36..2f19695d82 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3432,6 +3432,77 @@ static CPAccessResult access_nv1(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_exlock_el1(CPUARMState *env,
+                                        const ARMCPRegInfo *ri, bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el == 1) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+
+        /*
+         * EXLOCK check is disabled for NVx in 'x11'.
+         * Since we have to diagnose that, dispatch NV1 trap too.
+         */
+        if ((hcr & HCR_NV) && (hcr & HCR_NV1)) {
+            if (hcr & HCR_NV2) {
+                return CP_ACCESS_OK;
+            }
+            return CP_ACCESS_TRAP_EL2;
+        }
+    }
+
+    if (!isread &&
+        (env->pstate & PSTATE_EXLOCK) &&
+        (el_is_in_host(env, el) ? el == 2 : el == 1) &&
+        (env->cp15.gcscr_el[el] & GCSCR_EXLOCKEN)) {
+        return CP_ACCESS_EXLOCK;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult access_exlock_el2(CPUARMState *env,
+                                        const ARMCPRegInfo *ri, bool isread)
+{
+    int el = arm_current_el(env);
+
+    if (el == 3) {
+        return CP_ACCESS_OK;
+    }
+    if (el == 1) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+
+        /*
+         * EXLOCK check is disabled for NVx in 'xx1'.
+         * Since we have to diagnose that, dispatch NV1 trap too.
+         */
+        if (hcr & HCR_NV) {
+            if (hcr & HCR_NV2) {
+                return CP_ACCESS_OK;
+            }
+            return CP_ACCESS_TRAP_EL2;
+        }
+    }
+
+    if (!isread &&
+        (env->pstate & PSTATE_EXLOCK) &&
+        (env->cp15.gcscr_el[el] & GCSCR_EXLOCKEN)) {
+        return CP_ACCESS_EXLOCK;
+    }
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult access_exlock_el3(CPUARMState *env,
+                                        const ARMCPRegInfo *ri, bool isread)
+{
+    if (!isread &&
+        (env->pstate & PSTATE_EXLOCK) &&
+        (env->cp15.gcscr_el[3] & GCSCR_EXLOCKEN)) {
+        return CP_ACCESS_EXLOCK;
+    }
+    return CP_ACCESS_OK;
+}
+
 #ifdef CONFIG_USER_ONLY
 /*
  * `IC IVAU` is handled to improve compatibility with JITs that dual-map their
@@ -3603,13 +3674,13 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "ELR_EL1", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 1,
-      .access = PL1_RW, .accessfn = access_nv1,
+      .access = PL1_RW, .accessfn = access_exlock_el1,
       .nv2_redirect_offset = 0x230 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, elr_el[1]) },
     { .name = "SPSR_EL1", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 0,
-      .access = PL1_RW, .accessfn = access_nv1,
+      .access = PL1_RW, .accessfn = access_exlock_el1,
       .nv2_redirect_offset = 0x160 | NV2_REDIR_NV1,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_SVC]) },
     /*
@@ -4080,7 +4151,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "ELR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS | ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 1,
-      .access = PL2_RW,
+      .access = PL2_RW, .accessfn = access_exlock_el2,
       .fieldoffset = offsetof(CPUARMState, elr_el[2]) },
     { .name = "ESR_EL2", .state = ARM_CP_STATE_BOTH,
       .type = ARM_CP_NV2_REDIRECT,
@@ -4098,7 +4169,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "SPSR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS | ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 0,
-      .access = PL2_RW,
+      .access = PL2_RW, .accessfn = access_exlock_el2,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_HYP]) },
     { .name = "VBAR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 0, .opc2 = 0,
@@ -4380,7 +4451,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
     { .name = "ELR_EL3", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 6, .crn = 4, .crm = 0, .opc2 = 1,
-      .access = PL3_RW,
+      .access = PL3_RW, .accessfn = access_exlock_el3,
       .fieldoffset = offsetof(CPUARMState, elr_el[3]) },
     { .name = "ESR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 5, .crm = 2, .opc2 = 0,
@@ -4391,7 +4462,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
     { .name = "SPSR_EL3", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 6, .crn = 4, .crm = 0, .opc2 = 0,
-      .access = PL3_RW,
+      .access = PL3_RW, .accessfn = access_exlock_el3,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_MON]) },
     { .name = "VBAR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 12, .crm = 0, .opc2 = 0,
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 46a3b911ec..56e117c01e 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -887,6 +887,10 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
         }
         syndrome = syn_uncategorized();
         break;
+    case CP_ACCESS_EXLOCK:
+        /* CP_ACCESS_EXLOCK is always directed to the current EL */
+        syndrome = syn_gcs_exlock();
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


