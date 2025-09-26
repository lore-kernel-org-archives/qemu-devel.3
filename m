Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E80CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23YF-0007DV-1e; Fri, 26 Sep 2025 04:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23YB-0007CM-Ih; Fri, 26 Sep 2025 04:11:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23Y2-0000Gr-J3; Fri, 26 Sep 2025 04:11:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2FA1D157D4E;
 Fri, 26 Sep 2025 11:10:31 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 40529290C32;
 Fri, 26 Sep 2025 11:10:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Smail AIDER <smail.aider@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 06/60] target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
Date: Fri, 26 Sep 2025 11:09:34 +0300
Message-ID: <20250926081031.2214971-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
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

From: Smail AIDER <smail.aider@huawei.com>

Trap PMCR_EL0 or PMCR accesses to EL2 when MDCR_EL2.TPMCR is set.
Similar to MDCR_EL2.TPM, MDCR_EL2.TPMCR allows trapping EL0 and EL1
accesses to the PMCR register to EL2.

Cc: qemu-stable@nongnu.org
Signed-off-by: Smail AIDER <smail.aider@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250811112143.1577055-2-smail.aider@huawei.com
Message-Id: <20250722131925.2119169-1-smail.aider@huawei.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 186db6a73bc5c01026bb9f4f4a59e442c0156841)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/cpregs-pmu.c b/target/arm/cpregs-pmu.c
index 9c4431c18b..31c01eddc8 100644
--- a/target/arm/cpregs-pmu.c
+++ b/target/arm/cpregs-pmu.c
@@ -228,22 +228,27 @@ static bool event_supported(uint16_t number)
     return supported_event_map[number] != UNSUPPORTED_EVENT;
 }
 
-static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
-                                   bool isread)
+static CPAccessResult do_pmreg_access(CPUARMState *env, bool is_pmcr)
 {
     /*
      * Performance monitor registers user accessibility is controlled
-     * by PMUSERENR. MDCR_EL2.TPM and MDCR_EL3.TPM allow configurable
+     * by PMUSERENR. MDCR_EL2.TPM/TPMCR and MDCR_EL3.TPM allow configurable
      * trapping to EL2 or EL3 for other accesses.
      */
     int el = arm_current_el(env);
-    uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);
 
     if (el == 0 && !(env->cp15.c9_pmuserenr & 1)) {
         return CP_ACCESS_TRAP_EL1;
     }
-    if (el < 2 && (mdcr_el2 & MDCR_TPM)) {
-        return CP_ACCESS_TRAP_EL2;
+    if (el < 2) {
+        uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);
+
+        if (mdcr_el2 & MDCR_TPM) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        if (is_pmcr && (mdcr_el2 & MDCR_TPMCR)) {
+            return CP_ACCESS_TRAP_EL2;
+        }
     }
     if (el < 3 && (env->cp15.mdcr_el3 & MDCR_TPM)) {
         return CP_ACCESS_TRAP_EL3;
@@ -252,6 +257,19 @@ static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
+{
+    return do_pmreg_access(env, false);
+}
+
+static CPAccessResult pmreg_access_pmcr(CPUARMState *env,
+                                        const ARMCPRegInfo *ri,
+                                        bool isread)
+{
+    return do_pmreg_access(env, true);
+}
+
 static CPAccessResult pmreg_access_xevcntr(CPUARMState *env,
                                            const ARMCPRegInfo *ri,
                                            bool isread)
@@ -1187,14 +1205,14 @@ void define_pm_cpregs(ARMCPU *cpu)
             .fgt = FGT_PMCR_EL0,
             .type = ARM_CP_IO | ARM_CP_ALIAS,
             .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmcr),
-            .accessfn = pmreg_access,
+            .accessfn = pmreg_access_pmcr,
             .readfn = pmcr_read, .raw_readfn = raw_read,
             .writefn = pmcr_write, .raw_writefn = raw_write,
         };
         const ARMCPRegInfo pmcr64 = {
             .name = "PMCR_EL0", .state = ARM_CP_STATE_AA64,
             .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 0,
-            .access = PL0_RW, .accessfn = pmreg_access,
+            .access = PL0_RW, .accessfn = pmreg_access_pmcr,
             .fgt = FGT_PMCR_EL0,
             .type = ARM_CP_IO,
             .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),
-- 
2.47.3


