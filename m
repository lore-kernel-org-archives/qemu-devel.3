Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73BFCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHm1-00033z-Ry; Wed, 27 Aug 2025 11:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHim-0005v4-UT; Wed, 27 Aug 2025 11:05:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHij-0005Jw-65; Wed, 27 Aug 2025 11:05:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 670AC14C546;
 Wed, 27 Aug 2025 18:02:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 55F5826984E;
 Wed, 27 Aug 2025 18:03:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alex Richardson <alexrichardson@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 30/59] target/arm: add support for 64-bit PMCCNTR in
 AArch32 mode
Date: Wed, 27 Aug 2025 18:02:35 +0300
Message-ID: <20250827150323.2694101-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alex Richardson <alexrichardson@google.com>

In the PMUv3, a new AArch32 64-bit (MCRR/MRRC) accessor for the
PMCCNTR was added. In QEMU we forgot to implement this, so only
provide the 32-bit accessor. Since we have a 64-bit PMCCNTR
sysreg for AArch64, adding the 64-bit AArch32 version is easy.

We add the PMCCNTR to the v8_cp_reginfo because PMUv3 was added
in the ARMv8 architecture. This is consistent with how we
handle the existing PMCCNTR support, where we always implement
it for all v7 CPUs. This is arguably something we should
clean up so it is gated on ARM_FEATURE_PMU and/or an ID
register check for the relevant PMU version, but we should
do that as its own tidyup rather than being inconsistent between
this PMCCNTR accessor and the others.

Since the register name is the same as the 32-bit PMCCNTR, we set
ARM_CP_NO_GDB on the 32-bit one to avoid generating an invalid GDB XML.

See https://developer.arm.com/documentation/ddi0601/2024-06/AArch32-Registers/PMCCNTR--Performance-Monitors-Cycle-Count-Register?lang=en

Note for potential backporting:
 * this code in cpregs-pmu.c will be in helper.c on stable
   branches that don't have commit ae2086426d37

Cc: qemu-stable@nongnu.org
Signed-off-by: Alex Richardson <alexrichardson@google.com>
Message-id: 20250725170136.145116-1-alexrichardson@google.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit cd9f752fee75238f842a91be1146c988bd16a010)
(Mjt: moved code to target/arm/helper.c and modified it for 10.0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index bb445e30cd..4f89eaa2c2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1946,11 +1946,6 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fgt = FGT_PMSELR_EL0,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmselr),
       .writefn = pmselr_write, .raw_writefn = raw_write, },
-    { .name = "PMCCNTR", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 0,
-      .access = PL0_RW, .resetvalue = 0, .type = ARM_CP_ALIAS | ARM_CP_IO,
-      .fgt = FGT_PMCCNTR_EL0,
-      .readfn = pmccntr_read, .writefn = pmccntr_write32,
-      .accessfn = pmreg_access_ccntr },
     { .name = "PMCCNTR_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 13, .opc2 = 0,
       .access = PL0_RW, .accessfn = pmreg_access_ccntr,
@@ -6849,9 +6844,26 @@ static void define_pmu_regs(ARMCPU *cpu)
         .readfn = pmcr_read, .raw_readfn = raw_read,
         .writefn = pmcr_write, .raw_writefn = raw_write,
     };
+    /*
+     * 32-bit AArch32 PMCCNTR. We don't expose this to GDB if the
+     * new-in-v8 PMUv3 64-bit AArch32 PMCCNTR register is implemented
+     * (as that will provide the GDB user's view of "PMCCNTR").
+     */
+    ARMCPRegInfo pmccntr = {
+        .name = "PMCCNTR",
+        .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 0,
+        .access = PL0_RW, .accessfn = pmreg_access_ccntr,
+        .resetvalue = 0, .type = ARM_CP_ALIAS | ARM_CP_IO,
+        .fgt = FGT_PMCCNTR_EL0,
+        .readfn = pmccntr_read, .writefn = pmccntr_write32,
+    };
+    if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+        pmccntr.type |= ARM_CP_NO_GDB;
+    }
 
     define_one_arm_cp_reg(cpu, &pmcr);
     define_one_arm_cp_reg(cpu, &pmcr64);
+    define_one_arm_cp_reg(cpu, &pmccntr);
     for (i = 0; i < pmcrn; i++) {
         char *pmevcntr_name = g_strdup_printf("PMEVCNTR%d", i);
         char *pmevcntr_el0_name = g_strdup_printf("PMEVCNTR%d_EL0", i);
@@ -8162,6 +8174,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
               .fgt = FGT_PMCEIDN_EL0,
               .resetvalue = cpu->pmceid1 },
+            /* AArch32 64-bit PMCCNTR view: added in PMUv3 with Armv8 */
+            { .name = "PMCCNTR", .state = ARM_CP_STATE_AA32,
+              .cp = 15, .crm = 9, .opc1 = 0,
+              .access = PL0_RW, .accessfn = pmreg_access_ccntr, .resetvalue = 0,
+              .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_64BIT,
+              .fgt = FGT_PMCCNTR_EL0, .readfn = pmccntr_read,
+              .writefn = pmccntr_write,  },
         };
 #ifdef CONFIG_USER_ONLY
         static const ARMCPRegUserSpaceInfo v8_user_idregs[] = {
-- 
2.47.2


