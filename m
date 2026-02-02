Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9B3E7FDE0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn28l-0005ZC-Qu; Mon, 02 Feb 2026 17:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn28U-0005K9-P4; Mon, 02 Feb 2026 17:11:13 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn28S-0003D4-Sa; Mon, 02 Feb 2026 17:11:10 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5DA071852CE;
 Tue, 03 Feb 2026 01:07:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3B1CE35B3E1;
 Tue, 03 Feb 2026 01:08:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.1 33/56] target/arm: Correctly trap HCR.TID1 registers
 in v7A
Date: Tue,  3 Feb 2026 01:07:38 +0300
Message-ID: <20260202220805.945271-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
References: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
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

In v7A HCR.TID1 is defined to trap for TCMTR, TLBTR, REVIDR and AIDR.
We incorrectly use an accessfn for REVIDR and AIDR that only traps on
v8A cores.  Fix this by collapsing access_aa64_tid1() and
access_aa32_tid1() together and never doing a check for v8 vs v7.

The accessfn is also used for SMIDR_EL1, which is fine as this
register is AArch64 only.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251231170858.254594-4-peter.maydell@linaro.org
(cherry picked from commit b67a35622f9a816544ec094132d8af0debfac7f2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 51d192f0ba..633d314edf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -924,8 +924,8 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return ret;
 }
 
-static CPAccessResult access_aa64_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
-                                       bool isread)
+static CPAccessResult access_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
 {
     if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TID1)) {
         return CP_ACCESS_TRAP_EL2;
@@ -934,16 +934,6 @@ static CPAccessResult access_aa64_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
-static CPAccessResult access_aa32_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
-                                       bool isread)
-{
-    if (arm_feature(env, ARM_FEATURE_V8)) {
-        return access_aa64_tid1(env, ri, isread);
-    }
-
-    return CP_ACCESS_OK;
-}
-
 static const ARMCPRegInfo v7_cp_reginfo[] = {
     /* the old v6 WFI, UNPREDICTABLE in v7 but we choose to NOP */
     { .name = "NOP", .cp = 15, .crn = 7, .crm = 0, .opc1 = 0, .opc2 = 4,
@@ -969,7 +959,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
     { .name = "AIDR", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 7,
       .access = PL1_R, .type = ARM_CP_CONST,
-      .accessfn = access_aa64_tid1,
+      .accessfn = access_tid1,
       .fgt = FGT_AIDR_EL1,
       .resetvalue = 0 },
     /*
@@ -4997,7 +4987,7 @@ static const ARMCPRegInfo sme_reginfo[] = {
       .writefn = smcr_write, .raw_writefn = raw_write },
     { .name = "SMIDR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 6,
-      .access = PL1_R, .accessfn = access_aa64_tid1,
+      .access = PL1_R, .accessfn = access_tid1,
       /*
        * IMPLEMENTOR = 0 (software)
        * REVISION    = 0 (implementation defined)
@@ -7094,7 +7084,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "REVIDR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 0, .opc2 = 6,
               .access = PL1_R,
-              .accessfn = access_aa64_tid1,
+              .accessfn = access_tid1,
               .fgt = FGT_REVIDR_EL1,
               .type = ARM_CP_CONST, .resetvalue = cpu->revidr },
         };
@@ -7118,7 +7108,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "TCMTR",
               .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 2,
               .access = PL1_R,
-              .accessfn = access_aa32_tid1,
+              .accessfn = access_tid1,
               .type = ARM_CP_CONST, .resetvalue = 0 },
         };
         /* TLBTR is specific to VMSA */
@@ -7126,7 +7116,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .name = "TLBTR",
               .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 3,
               .access = PL1_R,
-              .accessfn = access_aa32_tid1,
+              .accessfn = access_tid1,
               .type = ARM_CP_CONST, .resetvalue = 0,
         };
         /* MPUIR is specific to PMSA V6+ */
-- 
2.47.3


