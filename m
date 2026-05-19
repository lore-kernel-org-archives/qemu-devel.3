Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05E3CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMRq-0008TS-P0; Tue, 19 May 2026 11:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1wPMRc-0008O9-Gs
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:33:25 -0400
Received: from mail-06.mail-europe.com ([85.9.210.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrigjl@proton.me>) id 1wPMRY-0002eg-B7
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1779204788; x=1779463988;
 bh=pYmKjFuS4S1UdxusOVX29Ta5fki6ZMd1A5v9kjl/tsM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Kxn25ESnH4/B+F2PwoK4I/w/C+NPIUnaRZzgqyBfpUcx5wE4p2Y+sPLAXLHovZW8L
 1GzdFZLFFDNO2L5OYDfPx1naULxivxj9Ie6K58YTLgpaxxtt4QFclZL/1xh8Ckw5QU
 wcsi+5Ui+fVJBWmS9a2/mOwdNr5Z5snSFyw+x6tcxbpHiPlFKIUcDV/RK0NyNtw/OI
 2xjz6cErbnzvfzzkzZ2ne8j7OfwnJgfIc80SL0q+0Q3CnVaJfXnLrceURcxoyL2GeD
 wYaNp/7ByQXy373vHN9LL5U4Hgr+fYHFVu/L9GUjT1HOu7xep7MvdNH13K0pM9Fqh1
 Wyn1h+RGDE9gA==
Date: Tue, 19 May 2026 15:33:03 +0000
To: Peter Maydell <peter.maydell@linaro.org>
From: Jason Wright <wrigjl@proton.me>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS
Message-ID: <20260519153249.31100-2-wrigjl@proton.me>
In-Reply-To: <20260519153249.31100-1-wrigjl@proton.me>
References: <20260519153249.31100-1-wrigjl@proton.me>
Feedback-ID: 198029889:user:proton
X-Pm-Message-ID: 9667e4f3dd1008b647acc16e6aa19be4b6ca9db2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.210.45; envelope-from=wrigjl@proton.me;
 helo=mail-06.mail-europe.com
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

Add an .accessfn to the RNDR and RNDRRS system registers that traps
reads to EL3 when SCR_EL3.TRNDR is set, as required by FEAT_RNG_TRAP.
Mark SCR_EL3.TRNDR (bit 40) as a writable field in scr_write() when
the CPU advertises the feature. The pseudocode in DDI04387 revision M.b
shows the trap firing from El0, EL1, EL2, and EL3, so there is no
check of arm_current_el().

Signed-off-by: Jason Wright <wrigjl@proton.me>
---
 target/arm/cpu-features.h |  5 +++++
 target/arm/helper.c       | 16 ++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

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
index 8240f1b384..e293cc3836 100644
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
@@ -5294,6 +5297,15 @@ static const ARMCPRegInfo pauth_reginfo[] =3D {
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
+    return CP_ACCESS_OK;
+}
+
 static uint64_t rndr_readfn(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     Error *err =3D NULL;
@@ -5325,11 +5337,11 @@ static const ARMCPRegInfo rndr_reginfo[] =3D {
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
--=20
2.50.1 (Apple Git-155)



