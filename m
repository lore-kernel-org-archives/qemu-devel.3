Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6415EEB569
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 17:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vazhH-0002bJ-Cr; Wed, 31 Dec 2025 12:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vazhB-0002Xa-A8
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 12:09:14 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vazh5-0000ZA-Av
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 12:09:11 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so84253585e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Dec 2025 09:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767200942; x=1767805742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AiTH0WXDhB71cHRZd1RTUOWk3bvV4V7fuZHHwsuReiA=;
 b=K/bNqU7FizYv6HZer8plFuJo2LqjutumIaAeMJTTafwugZFa8CKaZZfs1zgafe7IHM
 h/4d9knpaGY3XymmdqFVnfdT/8Yd6LHGamHcoeAPYa50uSzL6HJ04ko/yLnCeIP5bW9r
 Nb1B1y+MdM/cB+c16n3qag9a8GXqnzOpfBIZEyvpLlcYAtzQC7hB6zyKl9skcrvHGlmG
 LgPQVAHW24vXEkeol/iyX5TMI11fvXLB068WKF6JFJayt4qQFnL4NAcYwiKEn1yXUQ6+
 pcwLOk6KVxJyLAPZJxXA3KmQN/uTlvk8Tbo2/s6q0O1yGtjtliYOpppnFf/EILOZd9zH
 pLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767200942; x=1767805742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AiTH0WXDhB71cHRZd1RTUOWk3bvV4V7fuZHHwsuReiA=;
 b=wifdPR25D6n02z0q6DnTVdCDx57onZJFRS6Ec6oX/FdN2dZEhB8SNYnSrc23rXj1BC
 +kuULaZn0mgvNgaKwxpQXyn/6uVHLx+n8886Bxb4fdP5AOQ/RnrvsnIldshnMIWKmj8Y
 /sUgNmphahUzGech2nhg6knvnmkaU2Mvetnly4RQu5RV7GzAPoxNFtWzttnUgv/2gpEg
 s/DLS1EWOUvtAHIwwER/rl99AV/+on3tKDbnOEuGOL1bTal4Al2Q4y4Dz/VWUZFtJmrC
 /EdtKnaJ9dBGZrT6j96GjRYFGI99Ozb/wcG/dEo23tPqck523QpyKGWPDa8bqNa6/sO5
 Qdjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5mwnuKmQBCeAnYtbIiK/u8zFZHMEaq34gTdCf+hZdvstzuw+jKsAgKmLrZ+l1dc6bvt9uvJNES5KJ@nongnu.org
X-Gm-Message-State: AOJu0YzBh6cAJoEnwLd/sBv0pvnznL5gGraybigjSx4NonCOjtC8EZcu
 EZE9a6KuNGhOMwUMw+KU8/RyNdu+nfs4pEc8NB7t1op8CF6s9XV8+Zd2RFCrltdMgx548lbWetp
 HBM00
X-Gm-Gg: AY/fxX7VDcmeLGVWaxf6TDeF8xvi5M5EnpR+VjWHXQweofxNOI4CWpI0BnInd0X57+O
 DCBh2ugNsU8MqUXuSHvqVwj7DcZWYyFjrk3Z+sfMWzCwpmUuQ2HNp6rQPMfn7oKchMaGdGw59KP
 fSy+oEjZh/C/7JyRhBrr7Dvixl6L29RlsEiE/2TKaICdrxBqX6EUUGEXWYIFklKmVrEhh4XPiOA
 t47l5CRY+EYt9LxjyesDvpsezuvICSWGl8OTi9TZLjj3wfi3zGvbEFjrKcfu8X8Yw9MrRLsbiuB
 nhJDs9BCjqU23ekWfijDKyAn58gZnxDOA4GnwOdyXbDO98g0AAN1ZJ5Eet3kQSS3bzgE/RNAEMR
 yRWsB3TtdTf37rQKs1rNiZJ0S8lMHWHSBOCMfqd3HOGJfWeSKwOlfmVwf3N/+zcr20GLXML+qeu
 H7Ds7+uu1gEZn/me+Fmjez8p5vEwOT/U+u3AnLcaLZs2y5+cTbO2cdPvOmLSbbKFHqszNohJNFQ
 Gjzv/KniAdWGsYHwAKwtJMVatOUAMb/rje8Jsx7bfzOq6itWdOo75tJ
X-Google-Smtp-Source: AGHT+IG4SU+YSHcopM+q2gV5rm9MFoLy8bRfRgW5o3cXKFufVh6XRhiCw4Ou1PbbHVmmSQ/ul0S/lA==
X-Received: by 2002:a05:6000:2285:b0:430:f494:6abb with SMTP id
 ffacd0b85a97d-4324e4c63f9mr39180811f8f.8.1767200942032; 
 Wed, 31 Dec 2025 09:09:02 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa64cesm75208990f8f.35.2025.12.31.09.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 09:09:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 2/4] target/arm: Correctly honour HCR.TID3 for v7A cores
Date: Wed, 31 Dec 2025 17:08:56 +0000
Message-ID: <20251231170858.254594-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231170858.254594-1-peter.maydell@linaro.org>
References: <20251231170858.254594-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

The HCR.TID3 bit defines that we should trap to the hypervisor for
reads to a collection of ID registers. Different architecture versions
have defined this differently:

 * v7A has a set of ID regs that definitely must trap:
    - ID_PFR{0,1}, ID_DFR0, ID_AFR0, ID_MMFR{0,1,2,3},
      ID_ISAR{0,1,2,3,4,5}, MVFR{0,1}
   and somewhat vaguely says that "there is no requirement"
   to trap for registers that are reserved in the ID reg space
   (i.e. which RAZ and might be used for new ID regs in future)
 * v8A adds to this list:
    - ID_PFR2 and MVFR2 must trap
    - ID_MMFR4, ID_MMFR5, ID_ISAR6, ID_DFR1 and reserved registers
      in the ID reg space must trap if FEAT_FGT is implemented,
      and it is IMPDEF if they trap if FEAT_FGT is not implemented

In QEMU we seem to have attempted to implement this distinction
(taking the "we do trap" IMPDEF choice if no FEAT_FGT), with
access_aa64_tid3() always trapping on TID3 and access_aa32_tid3()
trapping only if ARM_FEATURE_V8 is set.  However, we didn't apply
these to the right set of registers: we use access_aa32_tid3() on all
the 32-bit ID registers *except* ID_PFR2, ID_DFR1, ID_MMFR5 and the
RES0 space, which means that for a v7 CPU we don't trap on a lot of
registers that we should trap on, and we do trap on various things
that the v7A Arm ARM says there is "no requirement" to trap on.

Straighten this out by naming the access functions more clearly for
their purpose, and documenting this: access_v7_tid3() is only for the
fixed set of ID registers that v7A traps on HCR.TID3, and
access_tid3() is for any others, including the reserved encoding
spaces and any new registers we add in future.

AArch32 MVFR2 access is handled differently, in check_hcr_el2_trap;
there we already do not trap on TID3 on v7A cores (where MVFR2
doesn't exist), because we in the code-generation function we UNDEF
if ARM_FEATURE_V8 is not set, without generating code to call
check_hcr_el2_trap.

This bug was causing a problem for Xen which (after a recent change
to Xen) expects to be able to trap ID_PFR0 on a Cortex-A15.

The result of these changes is that our v8A behaviour remains
the same, and on v7A we now trap the registers the Arm ARM definitely
requires us to trap, and don't trap the reserved space that "there is
no requirement" to trap.

Cc: qemu-stable@nongnu.org
Fixes: 6a4ef4e5d1084c ("target/arm: Honor HCR_EL2.TID3 trapping requirements")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 146 ++++++++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 65 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ec82ea6203..c4f73eb3f3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5835,9 +5835,18 @@ static const ARMCPRegInfo ccsidr2_reginfo[] = {
       .readfn = ccsidr2_read, .type = ARM_CP_NO_RAW },
 };
 
-static CPAccessResult access_aa64_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
-                                       bool isread)
+static CPAccessResult access_v7_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
+                                     bool isread)
 {
+    /*
+     * Trap on TID3 always. This should be used only for the fixed set of
+     * registers which are defined to trap on HCR.TID3 in v7A, which is:
+     *   ID_PFR{0,1}, ID_DFR0, ID_AFR0, ID_MMFR{0,1,2,3}, ID_ISAR{0,1,2,3,4,5}
+     * (MVFR0 and MVFR1 also trap in v7A, but this is not handled via
+     * this accessfn but in check_hcr_el2_trap.)
+     * Any other registers in the TID3 trap space should use access_tid3(),
+     * so that they trap on v8 and above, but not on v7.
+     */
     if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID3)) {
         return CP_ACCESS_TRAP_EL2;
     }
@@ -5845,11 +5854,18 @@ static CPAccessResult access_aa64_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
-static CPAccessResult access_aa32_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
-                                       bool isread)
+static CPAccessResult access_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
 {
+    /*
+     * Trap on TID3, if we implement at least v8. For v8 and above
+     * the ID register space is at least IMPDEF permitted to trap,
+     * and must trap if FEAT_FGT is implemented. We choose to trap
+     * always. Use this function for any new registers that should
+     * trap on TID3.
+     */
     if (arm_feature(env, ARM_FEATURE_V8)) {
-        return access_aa64_tid3(env, ri, isread);
+        return access_v7_tid3(env, ri, isread);
     }
 
     return CP_ACCESS_OK;
@@ -6287,7 +6303,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_PFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7_tid3,
               .resetvalue = GET_IDREG(isar, ID_PFR0)},
             /*
              * ID_PFR1 is not a plain ARM_CP_CONST because we don't know
@@ -6301,7 +6317,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = GET_IDREG(isar, ID_PFR1),
 #else
               .type = ARM_CP_NO_RAW,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7_tid3,
               .readfn = id_pfr1_read,
               .writefn = arm_cp_write_ignore
 #endif
@@ -6309,72 +6325,72 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_DFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7_tid3,
               .resetvalue = GET_IDREG(isar, ID_DFR0)},
             { .name = "ID_AFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7_tid3,
               .resetvalue = GET_IDREG(isar, ID_AFR0)},
             { .name = "ID_MMFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR0)},
             { .name = "ID_MMFR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR1)},
             { .name = "ID_MMFR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR2)},
             { .name = "ID_MMFR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR3)},
             { .name = "ID_ISAR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR0)},
             { .name = "ID_ISAR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR1)},
             { .name = "ID_ISAR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR2)},
             { .name = "ID_ISAR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR3) },
             { .name = "ID_ISAR4", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR4) },
             { .name = "ID_ISAR5", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR5) },
             { .name = "ID_MMFR4", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR4)},
             { .name = "ID_ISAR6", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR6) },
         };
         define_arm_cp_regs(cpu, v6_idregs);
@@ -6425,7 +6441,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = GET_IDREG(isar, ID_AA64PFR0)
 #else
               .type = ARM_CP_NO_RAW,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .readfn = id_aa64pfr0_read,
               .writefn = arm_cp_write_ignore
 #endif
@@ -6433,172 +6449,172 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64PFR1)},
             { .name = "ID_AA64PFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64PFR2)},
             { .name = "ID_AA64PFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ZFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64ZFR0)},
             { .name = "ID_AA64SMFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64SMFR0)},
             { .name = "ID_AA64PFR6_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64PFR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64DFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64DFR0) },
             { .name = "ID_AA64DFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64DFR1) },
             { .name = "ID_AA64DFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64DFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64AFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64AFR0) },
             { .name = "ID_AA64AFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64AFR1) },
             { .name = "ID_AA64AFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64AFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64ISAR0)},
             { .name = "ID_AA64ISAR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64ISAR1)},
             { .name = "ID_AA64ISAR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64ISAR2)},
             { .name = "ID_AA64ISAR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR6_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR0)},
             { .name = "ID_AA64MMFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR1) },
             { .name = "ID_AA64MMFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR2) },
             { .name = "ID_AA64MMFR3_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR3) },
             { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR6_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "MVFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = cpu->isar.mvfr0 },
             { .name = "MVFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = cpu->isar.mvfr1 },
             { .name = "MVFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = cpu->isar.mvfr2 },
             /*
              * "0, c0, c3, {0,1,2}" are the encodings corresponding to
@@ -6609,17 +6625,17 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "RES_0_C0_C3_0", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "RES_0_C0_C3_1", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "RES_0_C0_C3_2", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             /*
              * Other encodings in "0, c0, c3, ..." are STATE_BOTH because
@@ -6630,27 +6646,27 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "RES_0_C0_C3_3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_PFR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_PFR2)},
             { .name = "ID_DFR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_DFR1)},
             { .name = "ID_MMFR5", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR5)},
             { .name = "RES_0_C0_C3_7", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
         };
 #ifdef CONFIG_USER_ONLY
@@ -6800,7 +6816,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                 .state = ARM_CP_STATE_AA32,
                 .cp = 15, .opc1 = 0, .crn = 0, .crm = i, .opc2 = CP_ANY,
                 .access = PL1_R, .type = ARM_CP_CONST,
-                .accessfn = access_aa64_tid3,
+                .accessfn = access_tid3,
                 .resetvalue = 0 };
             define_one_arm_cp_reg(cpu, &v8_aa32_raz_idregs);
         }
-- 
2.47.3


