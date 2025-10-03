Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6492CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jLT-0007MU-SR; Fri, 03 Oct 2025 13:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKC-0004xr-Nl
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:12 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jJp-0007gE-JT
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-77c1814ca1dso1859554b3a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511498; x=1760116298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ws92EEGPIgmW+WjpPuCHPFTfwKhS7o1mCwFZF+leHPk=;
 b=D5K2ZZmeAtQY0GlRLPmoN56OqVgVR/iH/tNrQFRlDfc/VGGO7NcA2JrVr9TzHguv2/
 WHTJCInZKiT8VHcGNRi/mcaxo/npbl1flpsMPlZz2jBSDdFGAc48b3kWj0r48JMRmjzi
 m1qwypb4NkhfuN3C/xhi1whEszj/0LMSCNBYSK+LPmW11AHAZtG22tjXiAIlYfl+/Dhg
 NnWggAXcftp8ocaG4RKWXjLxbZ0ycXIFQylgLbpu84BKJj6wOx7I/up3h30/1jW5OaEQ
 a529ogpgfEp8KK2I5ESjaHUXgn8vFn5jKFNJgmyS3rTVOeK1nh8XZPJd5tCEn29VOjkg
 d5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511498; x=1760116298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ws92EEGPIgmW+WjpPuCHPFTfwKhS7o1mCwFZF+leHPk=;
 b=YwHcfne5ZBqKwHhZY9kXrOELP+Pz1lUzTucrsUUUllnRDlIrvybp97I/Sd9v/YlwJE
 zmwUZv+5PkaXCMD1F1BUorJ7+0yCpP7jSf1+WMA84tVOSg7suRf3UW/kh2maisnl6E83
 BVan+/KFs1IUTECOzd+L1O9HRa9JsF2siqbu45RjlJCxqJ8bk2uUq2zaP7+gdVq4Qn7t
 3QhGUMra3Sw8pAxdDnwTReWRR61tkx8QwL7ty/tIrlF/fhnOXAx2ZJz5Kzk5HkIspJKu
 2qFZLyHAX91IG2ekWDUvszOpVXVzUyZEpnoY/CMcR2zoCMLGXtMSFZ5538ZFb4X+7f6i
 D4oA==
X-Gm-Message-State: AOJu0Yz/y2RYEFowfPtWFtRscnvFJAWpw5PLS+qpuJwKeml0LFFxhU9W
 Wesg1uIEgeVf7aF8dX++HzFzTvcls5FrYij0ApQJEJ5OHPopyMySKxsNEZv+/19sAe59pk7QeCh
 5oYZy3uo=
X-Gm-Gg: ASbGncvvyImU54fFw1GhBeoq2FQfWPqHX1krxwAmKS7tsTiucRteKPdXQiL/MtQ3K3b
 QQh8/0epF+CreXgcbtUDPlxV5MQuzdgJbSyvzEpw6JDofeDZ20mbshlzWh3dhHjIbjkyUDsRwBi
 R+pwIkePypQ7aWBgYRwKUhnkfG+p1kggDRjTkRU2ZO3jq4nKwc2cneeS9fUmFvFSyk8jo/SfQI7
 P1GPp4wwJlGdjC1EkKTNOGNdwtDDPWvotlx075Zgnco/gvx2IDqEyX3Ct01xfp2TJt3DmgnPuaT
 AyEj4pLe1J6ho/ERt2z3hj8n7PD8Z/OjmPyGv0fAn4GiJ9vWYFQ5a+wbkt68yv33I5O1UXMlQ8P
 5PL1Cvz9PRJnbklpDeCZXEmtR5SLcuC7M/sSyxKr+CrxCtfpBi0h1X+YZ
X-Google-Smtp-Source: AGHT+IGZsFpITqjnHP2rwO2XeVNT3aZoCIbNMmqRufIijmkMU6m7c8M7tnTXSF7VSvrMVslzam70tw==
X-Received: by 2002:a05:6a20:2587:b0:249:ba7b:e361 with SMTP id
 adf61e73a8af0-32b620e88dcmr5256707637.49.1759511497802; 
 Fri, 03 Oct 2025 10:11:37 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 41/73] target/arm: Implement EXLOCKException for ELR_ELx
 and SPSR_ELx
Date: Fri,  3 Oct 2025 10:07:28 -0700
Message-ID: <20251003170800.997167-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
index 5adb8bb33a..2d2a45e705 100644
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
index 8ab1b3810e..a62b7ba430 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3437,6 +3437,61 @@ static CPAccessResult access_nv1(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -3608,7 +3663,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "ELR_EL1", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 1,
-      .access = PL1_RW, .accessfn = access_nv1,
+      .access = PL1_RW, .accessfn = access_nv1_or_exlock_el1,
       .nv2_redirect_offset = 0x230 | NV2_REDIR_NV1,
       .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 4, 0, 1),
       .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 4, 0, 1),
@@ -3616,7 +3671,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "SPSR_EL1", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 0, .crn = 4, .crm = 0, .opc2 = 0,
-      .access = PL1_RW, .accessfn = access_nv1,
+      .access = PL1_RW, .accessfn = access_nv1_or_exlock_el1,
       .nv2_redirect_offset = 0x160 | NV2_REDIR_NV1,
       .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 4, 0, 0),
       .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 4, 0, 0),
@@ -4099,7 +4154,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "ELR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS | ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 1,
-      .access = PL2_RW,
+      .access = PL2_RW, .accessfn = access_exlock_el2,
       .fieldoffset = offsetof(CPUARMState, elr_el[2]) },
     { .name = "ESR_EL2", .state = ARM_CP_STATE_BOTH,
       .type = ARM_CP_NV2_REDIRECT,
@@ -4117,7 +4172,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "SPSR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS | ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 0,
-      .access = PL2_RW,
+      .access = PL2_RW, .accessfn = access_exlock_el2,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_HYP]) },
     { .name = "VBAR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 0, .opc2 = 0,
@@ -4399,7 +4454,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
     { .name = "ELR_EL3", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 6, .crn = 4, .crm = 0, .opc2 = 1,
-      .access = PL3_RW,
+      .access = PL3_RW, .accessfn = access_exlock_el3,
       .fieldoffset = offsetof(CPUARMState, elr_el[3]) },
     { .name = "ESR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 5, .crm = 2, .opc2 = 0,
@@ -4410,7 +4465,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
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


