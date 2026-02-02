Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF63CE7FDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn152-0007rA-Sb; Mon, 02 Feb 2026 16:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn14t-0007No-Tl; Mon, 02 Feb 2026 16:03:26 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn14q-0004ks-J8; Mon, 02 Feb 2026 16:03:23 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7B0071851BD;
 Mon, 02 Feb 2026 23:57:55 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 42DD935B334;
 Mon, 02 Feb 2026 23:58:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 49/74] target/arm: Correctly honour HCR.TID3 for v7A
 cores
Date: Mon,  2 Feb 2026 23:58:00 +0300
Message-ID: <20260202205833.941615-49-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251231170858.254594-3-peter.maydell@linaro.org
(cherry picked from commit 205ca535abaceda375c54797b1129a54a5ebbe96)
(Mjt: trivial context fix around AA64MMFR4_EL1 and AA64PFR2_EL1 definitions)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 482e7f514e..cb8baf7883 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5843,9 +5843,18 @@ static const ARMCPRegInfo ccsidr2_reginfo[] = {
       .readfn = ccsidr2_read, .type = ARM_CP_NO_RAW },
 };
 
-static CPAccessResult access_aa64_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
-                                       bool isread)
+static CPAccessResult access_v7a_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
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
@@ -5853,11 +5862,18 @@ static CPAccessResult access_aa64_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
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
+        return access_v7a_tid3(env, ri, isread);
     }
 
     return CP_ACCESS_OK;
@@ -6028,7 +6044,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_PFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_PFR0)},
             /*
              * ID_PFR1 is not a plain ARM_CP_CONST because we don't know
@@ -6042,7 +6058,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = GET_IDREG(isar, ID_PFR1),
 #else
               .type = ARM_CP_NO_RAW,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .readfn = id_pfr1_read,
               .writefn = arm_cp_write_ignore
 #endif
@@ -6050,72 +6066,72 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_DFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_DFR0)},
             { .name = "ID_AFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_AFR0)},
             { .name = "ID_MMFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR0)},
             { .name = "ID_MMFR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR1)},
             { .name = "ID_MMFR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR2)},
             { .name = "ID_MMFR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR3)},
             { .name = "ID_ISAR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR0)},
             { .name = "ID_ISAR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR1)},
             { .name = "ID_ISAR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR2)},
             { .name = "ID_ISAR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR3) },
             { .name = "ID_ISAR4", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR4) },
             { .name = "ID_ISAR5", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
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
@@ -6166,7 +6182,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = GET_IDREG(isar, ID_AA64PFR0)
 #else
               .type = ARM_CP_NO_RAW,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .readfn = id_aa64pfr0_read,
               .writefn = arm_cp_write_ignore
 #endif
@@ -6174,172 +6190,172 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64PFR1)},
             { .name = "ID_AA64PFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
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
@@ -6350,17 +6366,17 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
@@ -6371,27 +6387,27 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
@@ -6539,7 +6555,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


