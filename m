Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADABCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 18:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSfKa-0005ai-4j; Thu, 28 May 2026 14:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>)
 id 1wSfKV-0005ZT-Ut; Thu, 28 May 2026 14:19:40 -0400
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>)
 id 1wSfKT-0001p1-1k; Thu, 28 May 2026 14:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779992362; x=1780251562;
 bh=Td9xsfGCqhKByDSU7leOfQTVEDOrhO0PxfiC6/Nm/I8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=RF45/A503e2VSpdH7D9iec+M4g7rBzCQCF+AZFQXRxBzSqgm8gusezJVn0U0crNXY
 j1QgW+jZeid5ClUIOifRuSC3qE1yfhh2VlVpEfoyw16NyBQ0xz+7rI2sBhB37QULae
 6bSnSL96oCrwpZ8btK2KvPpwxevBWZyNZZ3+fmGWjnxep4TDppX3IpDTGI/ze0LQz9
 9nWc7EPQFR0R40cT6+V3agmnepEmcwwqTVLovaEUJ6olZTyJIogxrDNPsU1EsxlQUS
 GBo7eSHhrZVh4i4JCdsFq4icNkMsD6ltTCczptxwL+PoJO/LAl/oJu4jyJFz8rv9Zv
 2sR2SDYiXxTWg==
Date: Thu, 28 May 2026 18:19:19 +0000
To: peter.maydell@linaro.org
From: Jason Wright <wrigjl@proton.me>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org
Subject: [PATCH v3 1/2] target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS
Message-ID: <20260528181857.92087-2-wrigjl@proton.me>
In-Reply-To: <20260528181857.92087-1-wrigjl@proton.me>
References: <20260519153249.31100-1-wrigjl@proton.me>
 <20260524002617.69593-1-wrigjl@proton.me>
 <20260528181857.92087-1-wrigjl@proton.me>
Feedback-ID: 198029889:user:proton
X-Pm-Message-ID: 2a12207c7e23bc28fcc280478beb51e5267e1694
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.206.169; envelope-from=wrigjl@proton.me;
 helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Add an .accessfn to the RNDR and RNDRRS system registers that traps
reads to EL3 when SCR_EL3.TRNDR is set, as required by FEAT_RNG_TRAP.
Mark SCR_EL3.TRNDR (bit 40) as a writable field in scr_write() when
the CPU advertises the feature. The pseudocode in DDI0487 revision M.b
shows the trap firing from EL0, EL1, EL2, and EL3, so there is no
check of arm_current_el().

When FEAT_RNG_TRAP is implemented without FEAT_RNG, an RNDR/RNDRRS read
with SCR_EL3.TRNDR=3D0 should UNDEF rather than succeed; handle that case
in access_rndr(). Register the rndr_reginfo CP reg entries whenever either
FEAT_RNG or FEAT_RNG_TRAP is implemented, so the accessfn fires even on a
FEAT_RNG_TRAP-only CPU.

When SCR_EL3.TRNDR is set, ID_AA64ISAR0_EL1.RNDR reads as 1 regardless
of whether FEAT_RNG is implemented; give ID_AA64ISAR0_EL1 a readfn so it
reports this at runtime, as we already do for ID_AA64PFR0_EL1.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wright <wrigjl@proton.me>
---
 target/arm/cpu-features.h |  5 ++++
 target/arm/helper.c       | 58 +++++++++++++++++++++++++++++++++++----
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index f9c979d20b..1279343540 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -908,6 +908,11 @@ static inline bool isar_feature_aa64_rndr(const ARMISA=
Registers *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR0, RNDR) !=3D 0;
 }
=20
+static inline bool isar_feature_aa64_rng_trap(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR1, RNDR_TRAP) !=3D 0;
+}
+
 static inline bool isar_feature_aa64_tlbirange(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ISAR0, TLB) =3D=3D 2;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 34487eeaa3..9dd8fdfa41 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -790,6 +790,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegI=
nfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_fpmr, cpu)) {
             valid_mask |=3D SCR_ENFPM;
         }
+        if (cpu_isar_feature(aa64_rng_trap, cpu)) {
+            valid_mask |=3D SCR_TRNDR;
+        }
     } else {
         valid_mask &=3D ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -5170,6 +5173,21 @@ static uint64_t id_aa64pfr0_read(CPUARMState *env, c=
onst ARMCPRegInfo *ri)
     }
     return pfr0;
 }
+
+static uint64_t id_aa64isar0_read(CPUARMState *env, const ARMCPRegInfo *ri=
)
+{
+    ARMCPU *cpu =3D env_archcpu(env);
+    uint64_t isar0 =3D GET_IDREG(&cpu->isar, ID_AA64ISAR0);
+
+    /*
+     * When FEAT_RNG_TRAP is active (SCR_EL3.TRNDR set), ID_AA64ISAR0_EL1.=
RNDR
+     * reads as 1 regardless of whether FEAT_RNG is implemented.
+     */
+    if (env->cp15.scr_el3 & SCR_TRNDR) {
+        isar0 =3D FIELD_DP64(isar0, ID_AA64ISAR0, RNDR, 1);
+    }
+    return isar0;
+}
 #endif
=20
 /*
@@ -5304,6 +5322,22 @@ static const ARMCPRegInfo pauth_reginfo[] =3D {
       .fieldoffset =3D offsetof(CPUARMState, keys.apib.hi) },
 };
=20
+static CPAccessResult access_rndr(CPUARMState *env, const ARMCPRegInfo *ri=
,
+                                  bool isread)
+{
+    if (env->cp15.scr_el3 & SCR_TRNDR) {
+        return CP_ACCESS_TRAP_EL3;
+    }
+    /*
+     * Note that FEAT_RNG_TRAP may be implemented without FEAT_RNG.
+     * In that case, if the trap is not enabled, the read undefs.
+     */
+    if (!cpu_isar_feature(aa64_rndr, env_archcpu(env))) {
+        return CP_ACCESS_UNDEFINED;
+    }
+    return CP_ACCESS_OK;
+}
+
 static uint64_t rndr_readfn(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     Error *err =3D NULL;
@@ -5335,11 +5369,11 @@ static const ARMCPRegInfo rndr_reginfo[] =3D {
     { .name =3D "RNDR", .state =3D ARM_CP_STATE_AA64,
       .type =3D ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END | ARM_CP_IO,
       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 2, .crm =3D 4, .opc2 =3D 0,
-      .access =3D PL0_R, .readfn =3D rndr_readfn },
+      .access =3D PL0_R, .accessfn =3D access_rndr, .readfn =3D rndr_readf=
n },
     { .name =3D "RNDRRS", .state =3D ARM_CP_STATE_AA64,
       .type =3D ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END | ARM_CP_IO,
       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 2, .crm =3D 4, .opc2 =3D 1,
-      .access =3D PL0_R, .readfn =3D rndr_readfn },
+      .access =3D PL0_R, .accessfn =3D access_rndr, .readfn =3D rndr_readf=
n },
 };
=20
 static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -6522,11 +6556,24 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access =3D PL1_R, .type =3D ARM_CP_CONST,
               .accessfn =3D access_tid3,
               .resetvalue =3D 0 },
+            /*
+             * ID_AA64ISAR0_EL1 is not a plain ARM_CP_CONST in system
+             * emulation because the RNDR field depends on SCR_EL3.TRNDR
+             * at read time when FEAT_RNG_TRAP is implemented.
+             */
             { .name =3D "ID_AA64ISAR0_EL1", .state =3D ARM_CP_STATE_AA64,
               .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 6, .opc2 =3D =
0,
-              .access =3D PL1_R, .type =3D ARM_CP_CONST,
+              .access =3D PL1_R,
+#ifdef CONFIG_USER_ONLY
+              .type =3D ARM_CP_CONST,
+              .resetvalue =3D GET_IDREG(isar, ID_AA64ISAR0)
+#else
+              .type =3D ARM_CP_NO_RAW,
               .accessfn =3D access_tid3,
-              .resetvalue =3D GET_IDREG(isar, ID_AA64ISAR0)},
+              .readfn =3D id_aa64isar0_read,
+              .writefn =3D arm_cp_write_ignore
+#endif
+            },
             { .name =3D "ID_AA64ISAR1_EL1", .state =3D ARM_CP_STATE_AA64,
               .opc0 =3D 3, .opc1 =3D 0, .crn =3D 0, .crm =3D 6, .opc2 =3D =
1,
               .access =3D PL1_R, .type =3D ARM_CP_CONST,
@@ -7454,7 +7501,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_pauth, cpu)) {
         define_arm_cp_regs(cpu, pauth_reginfo);
     }
-    if (cpu_isar_feature(aa64_rndr, cpu)) {
+    if (cpu_isar_feature(aa64_rndr, cpu) ||
+        cpu_isar_feature(aa64_rng_trap, cpu)) {
         define_arm_cp_regs(cpu, rndr_reginfo);
     }
     /* Data Cache clean instructions up to PoP */
--=20
2.50.1 (Apple Git-155)



