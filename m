Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D165CD5BB8
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 00:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQwgI-0006Vp-BP; Sat, 23 May 2026 20:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1wQwg8-0006VH-6X
 for qemu-devel@nongnu.org; Sat, 23 May 2026 20:26:52 -0400
Received: from mail-4322.protonmail.ch ([185.70.43.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1wQwg6-00024c-CM
 for qemu-devel@nongnu.org; Sat, 23 May 2026 20:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779582408; x=1779841608;
 bh=PtuCJLxm9vxnyMEpraVo+tjK3AfZA56IcZCkr4fAZ1M=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=LL5xLtvsxz5zaJ51EOzds4ZUactaGoypsXXzHWLeHOLNVeus2Gu+JeKWOPc7WA0IU
 gfL9UELTEz2WedbjrDR5UmweUy7/72r29ZcKaTb1B9aQhWPhv8klNguYr7I9QuHDmJ
 vkqDK11tVZo0nFJG+mpBrczbvmt69sBoksmT4uuPlN+ZaOs3onOpg6MBHV0YhS9ONW
 r+h1DvH99hAbz2VKXIFA7y5k+nw7ObFMYu0SKPXIosX6dfA+GIDR3nTPSVlJBhmwUI
 DcakdZI8DIsfPwylwMs7Ri0VMPMdJSW2JUowiZSVX0eDLZ4BMZxAZvSEnPDo0EZuK4
 d8jiiOQgmbHqQ==
Date: Sun, 24 May 2026 00:26:44 +0000
To: peter.maydell@linaro.org
From: Jason Wright <wrigjl@proton.me>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org
Subject: [PATCH v2 1/2] target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS
Message-ID: <20260524002617.69593-2-wrigjl@proton.me>
In-Reply-To: <20260524002617.69593-1-wrigjl@proton.me>
References: <20260519153249.31100-1-wrigjl@proton.me>
 <20260524002617.69593-1-wrigjl@proton.me>
Feedback-ID: 198029889:user:proton
X-Pm-Message-ID: 0cbb8bf056e3688a1a2046f836a5e933c1872093
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.22; envelope-from=wrigjl@proton.me;
 helo=mail-4322.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jason Wright <wrigjl@proton.me>
---
 target/arm/cpu-features.h |  5 +++++
 target/arm/helper.c       | 26 +++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4e44245a8b..a3f1406f69 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -890,6 +890,11 @@ static inline bool isar_feature_aa64_rndr(const ARMISA=
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
index 8240f1b384..ee59dcaa26 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -787,6 +787,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegI=
nfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_mec, cpu)) {
             valid_mask |=3D SCR_MECEN;
         }
+        if (cpu_isar_feature(aa64_rng_trap, cpu)) {
+            valid_mask |=3D SCR_TRNDR;
+        }
     } else {
         valid_mask &=3D ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -5294,6 +5297,22 @@ static const ARMCPRegInfo pauth_reginfo[] =3D {
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
@@ -5325,11 +5344,11 @@ static const ARMCPRegInfo rndr_reginfo[] =3D {
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
@@ -7423,7 +7442,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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



