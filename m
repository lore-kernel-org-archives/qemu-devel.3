Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614DECAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lfi-0004fC-9E; Mon, 22 Sep 2025 14:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfQ-0003t7-8D
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:43 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lf6-0004wl-56
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:39 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b5229007f31so3489383a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567197; x=1759171997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6UhbL1wlL/mcB0x0GrzT1zamkcYww0puSFWXXUpmdY=;
 b=Q371F4DCtvP1LoKW0X69Wzf3ecok3xeIshTjrt+G3u0+HT+988j8RHKcGEo4uCIsrK
 wR48vni68s5Zyvvc8SmzAPBF4x7taP6MiSv/SuodQS7vgnjFEaMufnuSybkhlttY7kXv
 D1EYctHUEvStDb4i/1BZbND0hQm2mbAi18MlikXbiwZ9L8WTiCc5RC028kid8CTOl4Hl
 fjeaSN7Ct6qpIXQ1VLhPaw1NS+d0OOt3r4EP/vVlS5vgGlxNM4/A7ib59RK+NssX+qBG
 zo+bFSgsfH1dY0V3elBNzq/2NTEFagqqU+6AJZ/jq9H03/JPVlFJPqk7STS3bM5hGwbT
 HJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567197; x=1759171997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6UhbL1wlL/mcB0x0GrzT1zamkcYww0puSFWXXUpmdY=;
 b=WfJdGR/bZewO0vKdMl5ISIPQG/afVz4tHpf+MW1PfBr5LMLSa5In/YKPQzlygokwCu
 A+zkqSXJ4I3d7JLBUp1+NcIKdyxqA301YaW7a+P+eV7w542oLzw+Y0QSis51Vgij9r9h
 Jfg5ZhVx7p5mksGAHDAL4XTSq0MLD7S9kDKONntex3zu4P5t5mjiYmFvEYH9MBwARrQY
 erTRhLO1bDtRQSwBTxyKpeTkupeCWQMdvx1HTLeXirjB9CzY6vbcX6gNe/NlUVWH9GIf
 XCWQhB3ij8Z/7a8e92yhQ52Rq5NJeh6asN3aDs7QhN0n/0D5XyTkK+oHG3qNtNJL1txW
 95yQ==
X-Gm-Message-State: AOJu0YylkBMUc8qnAbzeRY4fmrZmcoZnWqG+z1Osa7YsmCjIbWJqIlcT
 IVD097lxG1f9aUuQdBRxoUsbypZFH4DKT+VWyP3Xfcr/4HeFVbLKsOPEo9fEs97pY4XTKwAmL4u
 MX8Ok
X-Gm-Gg: ASbGnctN5ep0tcrXhYmSPw843RMTLVKVcUsrAe+AMA06LqAUrk0dV92bGNqsFzTaysP
 Pr8LhYKue5F8j/g686nclg0aIRCrsgEFFpiaIs0zZl95TV4oxErsRO+2n2Datx1F2WbC9y7tlpP
 xJ8VvHDcNHTIxBfeFWo+WaQGVvVWcVSkntLy4ZmcWB/TS6o3xmIlyURekQT8n/sTNDwbPFWVRa6
 q+llf1Pm3NEVOdVcDRoBWQKknbTU46djvCoqF3s2ZCxGyoLb4GfEcu3dQOvr7r/JIAFabQfBGwM
 URvnAkL+oxGMD97zjMDtHcospnBWdbdRCiDvQ+1OIH62T3Y4iuuaUvG7u3vvHU3FhQ37+Da3VKc
 R4aa+p5JbWEck1VaZCavyUbXrGYbig9qIOKvEqQs=
X-Google-Smtp-Source: AGHT+IGkwd2kVoy9NlQG7nUZU589wUz+kJm1XWypVwk4RoTTsYvVdnc3Ewl2ClScgqsIRFj7u7YsFg==
X-Received: by 2002:a17:902:e549:b0:26e:62c9:1cc4 with SMTP id
 d9443c01a7336-26e62c92042mr124693015ad.4.1758567196716; 
 Mon, 22 Sep 2025 11:53:16 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 44/76] target/arm: Implement EXLOCKException for ELR_ELx
 and SPSR_ELx
Date: Mon, 22 Sep 2025 11:48:52 -0700
Message-ID: <20250922184924.2754205-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/cpregs.h        |  8 +++++
 target/arm/cpu.h           |  1 +
 target/arm/helper.c        | 67 ++++++++++++++++++++++++++++++++++----
 target/arm/tcg/op_helper.c |  7 ++++
 4 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index bd2121a336..a79f00351c 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -351,6 +351,14 @@ typedef enum CPAccessResult {
      * specified target EL.
      */
     CP_ACCESS_UNDEFINED = (2 << 2),
+
+    /*
+     * Access fails with EXLOCK, a GCS exception syndrome.
+     * These traps are always to the current execution EL,
+     * which is the same as the usual target EL because
+     * they cannot occur from EL0.
+     */
+    CP_ACCESS_EXLOCK = (3 << 2),
 } CPAccessResult;
 
 /* Indexes into fgt_read[] */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b36436ee2b..97cdcd8cdc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1502,6 +1502,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_C (1U << 29)
 #define PSTATE_Z (1U << 30)
 #define PSTATE_N (1U << 31)
+#define PSTATE_EXLOCK (1ULL << 34)
 #define PSTATE_NZCV (PSTATE_N | PSTATE_Z | PSTATE_C | PSTATE_V)
 #define PSTATE_DAIF (PSTATE_D | PSTATE_A | PSTATE_I | PSTATE_F)
 #define CACHED_PSTATE_BITS (PSTATE_NZCV | PSTATE_DAIF | PSTATE_BTYPE)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5519484186..e90398acc9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3433,6 +3433,61 @@ static CPAccessResult access_nv1(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_nv1_or_exlock_el1(CPUARMState *env,
+                                               const ARMCPRegInfo *ri,
+                                               bool isread)
+{
+    if (arm_current_el(env) == 1) {
+        uint64_t nvx = arm_hcr_el2_nvx_eff(env);
+
+        if (!isread &&
+            (env->pstate & PSTATE_EXLOCK) &&
+            (env->cp15.gcscr_el[1] & GCSCR_EXLOCKEN) &&
+            !(nvx & HCR_NV1)) {
+            return CP_ACCESS_EXLOCK;
+        }
+        return access_nv1_with_nvx(nvx);
+    }
+
+    /*
+     * At EL2, since VHE redirection is done at translation time,
+     * el_is_in_host is always false here, so EXLOCK does not apply.
+     */
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
+
+    /*
+     * Access to the EL2 register from EL1 means NV is set, and
+     * EXLOCK has priority over an NV1 trap to EL2.
+     */
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
@@ -3604,7 +3659,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "ELR_EL1", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 1,
-      .access = PL1_RW, .accessfn = access_nv1,
+      .access = PL1_RW, .accessfn = access_nv1_or_exlock_el1,
       .nv2_redirect_offset = 0x230 | NV2_REDIR_NV1,
       .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 4, 0, 1),
       .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 4, 0, 1),
@@ -3612,7 +3667,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "SPSR_EL1", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 0,
-      .access = PL1_RW, .accessfn = access_nv1,
+      .access = PL1_RW, .accessfn = access_nv1_or_exlock_el1,
       .nv2_redirect_offset = 0x160 | NV2_REDIR_NV1,
       .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 4, 0, 0),
       .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 4, 0, 0),
@@ -4095,7 +4150,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "ELR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS | ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 1,
-      .access = PL2_RW,
+      .access = PL2_RW, .accessfn = access_exlock_el2,
       .fieldoffset = offsetof(CPUARMState, elr_el[2]) },
     { .name = "ESR_EL2", .state = ARM_CP_STATE_BOTH,
       .type = ARM_CP_NV2_REDIRECT,
@@ -4113,7 +4168,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "SPSR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS | ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 0,
-      .access = PL2_RW,
+      .access = PL2_RW, .accessfn = access_exlock_el2,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_HYP]) },
     { .name = "VBAR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 0, .opc2 = 0,
@@ -4395,7 +4450,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
     { .name = "ELR_EL3", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 6, .crn = 4, .crm = 0, .opc2 = 1,
-      .access = PL3_RW,
+      .access = PL3_RW, .accessfn = access_exlock_el3,
       .fieldoffset = offsetof(CPUARMState, elr_el[3]) },
     { .name = "ESR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 5, .crm = 2, .opc2 = 0,
@@ -4406,7 +4461,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
     { .name = "SPSR_EL3", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 6, .crn = 4, .crm = 0, .opc2 = 0,
-      .access = PL3_RW,
+      .access = PL3_RW, .accessfn = access_exlock_el3,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_MON]) },
     { .name = "VBAR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 12, .crm = 0, .opc2 = 0,
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index dd3700dc6f..4fbd219555 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -881,6 +881,13 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
         }
         syndrome = syn_uncategorized();
         break;
+    case CP_ACCESS_EXLOCK:
+        /*
+         * CP_ACCESS_EXLOCK is always directed to the current EL,
+         * which is going to be the same as the usual target EL.
+         */
+        syndrome = syn_gcs_exlock();
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


