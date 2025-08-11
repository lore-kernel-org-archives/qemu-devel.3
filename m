Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB6AC87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 11:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulQbh-0001wC-Hw; Mon, 11 Aug 2025 07:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smail.aider@huawei.com>)
 id 1ulQbe-0001v9-8R; Mon, 11 Aug 2025 07:22:22 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smail.aider@huawei.com>)
 id 1ulQba-0003aN-Cp; Mon, 11 Aug 2025 07:22:21 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c0scQ1XFLz6M5Cg;
 Mon, 11 Aug 2025 19:20:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id D94391402EF;
 Mon, 11 Aug 2025 19:22:00 +0800 (CST)
Received: from china (7.182.10.167) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 11 Aug
 2025 13:21:55 +0200
To: <qemu-devel@nongnu.org>
CC: <alexander.spyridakis@huawei.com>, <zhangyue165@huawei.com>,
 <liuyutao2@huawei.com>, <mjt@tls.msk.ru>, Peter Maydell
 <peter.maydell@linaro.org>, <qemu-stable@nongnu.org>, <qemu-arm@nongnu.org>,
 <richard.henderson@linaro.org>, <smail.aider@huawei.com>
Subject: [PATCH v3 1/1] target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
Date: Mon, 11 Aug 2025 19:21:43 +0800
Message-ID: <20250811112143.1577055-2-smail.aider@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811112143.1577055-1-smail.aider@huawei.com>
References: <20250811112143.1577055-1-smail.aider@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [7.182.10.167]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=smail.aider@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Smail AIDER <smail.aider@huawei.com>
From:  Smail AIDER via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Smail AIDER via <qemu-devel@nongnu.org>

Trap PMCR_EL0 or PMCR accesses to EL2 when MDCR_EL2.TPMCR is set.
Similar to MDCR_EL2.TPM, MDCR_EL2.TPMCR allows trapping EL0 and EL1
accesses to the PMCR register to EL2.

Signed-off-by: Smail AIDER <smail.aider@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250722131925.2119169-1-smail.aider@huawei.com>
---
 target/arm/cpregs-pmu.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpregs-pmu.c b/target/arm/cpregs-pmu.c
index 9c4431c18b..13392ddc4c 100644
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
@@ -252,6 +257,18 @@ static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
+{
+    return do_pmreg_access(env, false);
+}
+
+static CPAccessResult pmreg_access_pmcr(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
+{
+    return do_pmreg_access(env, true);
+}
+
 static CPAccessResult pmreg_access_xevcntr(CPUARMState *env,
                                            const ARMCPRegInfo *ri,
                                            bool isread)
@@ -1187,14 +1204,14 @@ void define_pm_cpregs(ARMCPU *cpu)
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
2.34.1


