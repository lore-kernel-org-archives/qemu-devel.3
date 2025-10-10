Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B460FCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cpz-0006tZ-GT; Fri, 10 Oct 2025 09:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpx-0006rx-V6
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:10 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpD-0003x4-Nd
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:09 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-421851bca51so1275173f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101576; x=1760706376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ppETInW3MEqjqW6NdufgfdsoZNQc59d69wd6I8lXxCI=;
 b=b4B/L+4PGitiwdak4iFk6r5SvjfcZrZBJGVczGQbmFY/YEU6N0Ro6wO6akZe/JK8G2
 PQmsnZmuGZJM7yf/A9UFZt9foHVGBH0UqCVubsYqYAdWRe+TW/s4pGw2Un7KBPEV9FUZ
 /jDk3i8sXlkgk8nQRVy0ahZGpEuWEcWvuSZS8F8p+hPYNTFbLSn7IVK/O+byi9bXteCi
 QJUUAq3U6ixKZyY0f/3Usxmwtw30Wig+PQ2TXWbhNrvmRBE3qLsS1drqOdxM/MCiV1Fg
 6VOTz2U57Q2lguU6ZdZY3UwQyaFKCK6iLl042FuZwUYbgCAGDeJKeIBmv3S3GwqAsP8O
 Fy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101576; x=1760706376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ppETInW3MEqjqW6NdufgfdsoZNQc59d69wd6I8lXxCI=;
 b=nQy6qbNFX2JUUbTOcJUkfeqNzfM63s21eCiQGo/K49cX1+nDlBjg76EJo0+Rz9jnyi
 usCinsUmwBoOaD+f8ZT45eqgl5Eyj7LEkKp40JvTqMBmYMPlCavUBXsb7J1kneIC0zeU
 RlTirTv2sSVsyXgE/3mbAUoUCsBsPZnhiVFkYfPVSCG+JCX9ovLn3Qx00TPq/RfYtSx6
 VsQ8iSBalLm+DGHBOrdln5pX8v+OYmQeGUvh+BrjmBswBfEx4MWY2Tq9sFf+rRb1wSW0
 CLGESZRmAPIVZKo2nwrFYEuPlaIB5hs7NK7XZkTZCeFLm2+bu7q2lXWWOO89n1d5QfKD
 5xtA==
X-Gm-Message-State: AOJu0Yxo0XoafAMwwMHOtoFqT1zkoqCH+Ucm5GCiECpzSGfyZA8T6kWz
 2UWbs2TLECAVdQchn+PqbnZk7bXq7q/xu0j4XsEM1IDkJyp58xBHQMrm9b2gMN2K4JjQa1g4gZX
 VMzdl
X-Gm-Gg: ASbGncuZfHWnKxwEZVJF5UySlZ2nEN1XDzVEx+q60QPhaZA+Qlty+ZX//1AJI9eEi0Y
 LnP5M4T09hraaAMb3gCvuhlPTmXFdXvqqQ6lc476XqPLYYcXv5gGzUzvoaZlCcoaIXoCd1NeI/2
 OVLyqem12n9p6wwHjWa9B1arXHyRSF72FLmJkuVdoGl286y+1eN+ECI8Ge6+KvlImM4uBR27xd9
 hXj0HiPephJBKMbintjo56lPJ+ZySbDj06IqOvNE7UkNSjAOjAzHQEHC2fk4s2tzBSF0SOPkIwd
 wI0GzCvpdfAgDb4y1OFGFpwK7SD2f1sKcJUIgDID0weC51Imw347WP7QLUijs655XvPcGzc/Pvk
 k/F95oOoMBSIulSqO7MA50YnVl7j2XCZYtKqZTyfD0vvlW6YY+EQ=
X-Google-Smtp-Source: AGHT+IGcGku/UhwZBBcgzOTOgb6OnJj7t2TpsTmJiaTGcJD3jl0cSdaViLeS5vnozGayJDxxdbfY4A==
X-Received: by 2002:a05:6000:2010:b0:402:4142:c7a7 with SMTP id
 ffacd0b85a97d-42666ac6f35mr8384789f8f.16.1760101576066; 
 Fri, 10 Oct 2025 06:06:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/76] target/arm: Implement EXLOCKException for ELR_ELx and
 SPSR_ELx
Date: Fri, 10 Oct 2025 14:04:52 +0100
Message-ID: <20251010130527.3921602-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

If PSTATE.EXLOCK is set, and the GCS EXLOCK enable bit is set,
and nested virt is in the appropriate state, then we need to
raise an EXLOCK exception.

Since PSTATE.EXLOCK cannot be set without GCS being present
and enabled, no explicit check for GCS is required.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-42-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h        |  8 +++++
 target/arm/cpu.h           |  1 +
 target/arm/helper.c        | 67 ++++++++++++++++++++++++++++++++++----
 target/arm/tcg/op_helper.c |  7 ++++
 4 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index bd2121a336e..a79f00351c8 100644
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
index 54f3d7b1cca..91a851dac17 100644
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
index 5d40266d96b..1aa0a157b72 100644
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
@@ -4100,7 +4155,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "ELR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS | ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 1,
-      .access = PL2_RW,
+      .access = PL2_RW, .accessfn = access_exlock_el2,
       .fieldoffset = offsetof(CPUARMState, elr_el[2]) },
     { .name = "ESR_EL2", .state = ARM_CP_STATE_BOTH,
       .type = ARM_CP_NV2_REDIRECT,
@@ -4118,7 +4173,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "SPSR_EL2", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS | ARM_CP_NV2_REDIRECT,
       .opc0 = 3, .opc1 = 4, .crn = 4, .crm = 0, .opc2 = 0,
-      .access = PL2_RW,
+      .access = PL2_RW, .accessfn = access_exlock_el2,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_HYP]) },
     { .name = "VBAR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 0, .opc2 = 0,
@@ -4400,7 +4455,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
     { .name = "ELR_EL3", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 6, .crn = 4, .crm = 0, .opc2 = 1,
-      .access = PL3_RW,
+      .access = PL3_RW, .accessfn = access_exlock_el3,
       .fieldoffset = offsetof(CPUARMState, elr_el[3]) },
     { .name = "ESR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 5, .crm = 2, .opc2 = 0,
@@ -4411,7 +4466,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
     { .name = "SPSR_EL3", .state = ARM_CP_STATE_AA64,
       .type = ARM_CP_ALIAS,
       .opc0 = 3, .opc1 = 6, .crn = 4, .crm = 0, .opc2 = 0,
-      .access = PL3_RW,
+      .access = PL3_RW, .accessfn = access_exlock_el3,
       .fieldoffset = offsetof(CPUARMState, banked_spsr[BANK_MON]) },
     { .name = "VBAR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 12, .crm = 0, .opc2 = 0,
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index dd3700dc6f2..4fbd219555d 100644
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


