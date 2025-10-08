Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED92CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cCe-0000Ac-On; Wed, 08 Oct 2025 18:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCU-0008VY-Rt
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:59:58 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCH-0007Lx-Te
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:59:57 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7810289cd4bso283446b3a.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960782; x=1760565582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRTFIGyvj7pYjT9HAUC3PYKg6JlBZDF5K/FSQ5MWHsY=;
 b=pRkGyRQjd5GwM6pFIA3knNaJ56kEGsQ0bsdAhrmYtlSXE7bp7BBbBPcunPWzIFp8ZS
 9Puzkh40TlvMR2cxOwrFLzX/rpyfF6pjVRseGNMZDOhgubmmcI/S/bVtZT/tovhFmZTT
 QCIFgxFukF0n8/UvE737JH/ASQw0C4XoCHbk+i+2tSCCQHG1I5J9OvOecVAWtq+0oYIK
 TYzuAh+QgH1Oh3VZyGkMMWI7BnagdX3IY71IadrktkJGf72W870obIeKIbwgUTNBY7yZ
 bpiPliExkEA7uMPtXUKMq8wjPe67VtNavy0N66fQfh7q1mpI/ntayCds067JVX69pSmO
 TZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960782; x=1760565582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xRTFIGyvj7pYjT9HAUC3PYKg6JlBZDF5K/FSQ5MWHsY=;
 b=YqCJJzKBUjfbb6Z5Hr1FH+966UISDAojlFgvIGlL1DduXzgFjcsvQX8Z+ey6N35TvS
 BBrFOQz2O5zVx9is9U5dcJwTF/JdICiyrodNHEafeu8N7dvdwTJFSerAY4F2OXWVXCc4
 iXKT8v1OOMWlhzvh5JpFzbJyNdou2J6ocYEnzUFMCSXT3Ja83qjK9wCu80EqLuj3Rc7a
 mCqo5i17xiqhGbMHiGpo73AmINMkKoPPpAHaecsGhepyqyPBFhxz97ks72etNDfNzdLT
 jm5ir60HjizF0Ks/jVv0kJ14w7fXrdX0KBbPkY+LMzLaNh3PPzXz4Af/wsdrRNwAnoPg
 FWXA==
X-Gm-Message-State: AOJu0YwfUrGykemwhqWIVV59tSrxoCKDNdm9H4FOWLEDldwTyYlGsu/P
 eiHmTDAkodNuqfQMqum3k628AIkEVpOOhL1D/AwOjW9bywI6vh6yf0tQe77MSRUBJPf+QKNuA4D
 OUtFaBYY=
X-Gm-Gg: ASbGncs50KGHlTZSaY9IExog2mGNn5FqLwj8P/XLOKS/Yys1wFMpx31KWyFFffKkfy7
 5144fnSIJfF9n0+UDK7Jga9yPINnBt7zaa0h6MjpjV0Qu2J56H1pMAoDDmEb50H9N495BS7u02L
 NJp6m6wnfNGpG0XBUsWpux4mYnO2GvXKIbGCG3hm5xVy0oF/sJr7BSq0R/xTO4XxZ5fBUgX+ld/
 FoH/XNnWS8I4G42tKnHej/fOIp6VJtST6tBpJimoZYXHDKmvR0HfqH03OdRdu3CbBN+OEPwKLTP
 qfxvWv+cCcvyHtGQeWRYjoKnZ3woxHYmqUaNS4NZhT3Yr0Tm/KV0C/Mr2TDfm3QnA4tpeOPGHYx
 0RMVIF6JfUmZKxEi66RnEQGS9CuhcLJtFmlzQ7v0L70UR61cbsy4911hx
X-Google-Smtp-Source: AGHT+IFYb6lf3wIJMWM+MzipxcaSKR0s0GktjmtmmkhbHZJbjX7T2ukMzv0FhgD2DRI86068ShISKQ==
X-Received: by 2002:a05:6a00:3c87:b0:792:574d:b13 with SMTP id
 d2e1a72fcca58-793858fb720mr6269545b3a.13.1759960781461; 
 Wed, 08 Oct 2025 14:59:41 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 41/73] target/arm: Implement EXLOCKException for ELR_ELx
 and SPSR_ELx
Date: Wed,  8 Oct 2025 14:55:41 -0700
Message-ID: <20251008215613.300150-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
index 54f3d7b1cc..91a851dac1 100644
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
index 5d40266d96..1aa0a157b7 100644
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


