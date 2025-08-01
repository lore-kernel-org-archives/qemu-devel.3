Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC90C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 09:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhlns-0000bs-Dc; Fri, 01 Aug 2025 05:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smail.aider@huawei.com>)
 id 1uhljZ-0005Ai-Ue; Fri, 01 Aug 2025 05:07:25 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smail.aider@huawei.com>)
 id 1uhljV-00076y-Pb; Fri, 01 Aug 2025 05:07:25 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4btg5D2nCvz6K5Zc;
 Fri,  1 Aug 2025 17:05:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 063F31402EB;
 Fri,  1 Aug 2025 17:07:06 +0800 (CST)
Received: from china (7.182.10.167) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 1 Aug
 2025 11:07:01 +0200
To: <qemu-devel@nongnu.org>
CC: <alexander.spyridakis@huawei.com>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, <zhangyue165@huawei.com>,
 <richard.henderson@linaro.org>, <liuyutao2@huawei.com>,
 <smail.aider@huawei.com>
Subject: [PATCH v2 2/2] target/arm: Code refactoring of pmreg_access/pmcr
Date: Fri, 1 Aug 2025 17:06:45 +0800
Message-ID: <20250801090645.2205449-3-smail.aider@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801090645.2205449-1-smail.aider@huawei.com>
References: <20250801090645.2205449-1-smail.aider@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [7.182.10.167]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=smail.aider@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Create a common helper for pmreg_access and pmreg_access_pmcr to improve
readability.

Signed-off-by: Smail AIDER <smail.aider@huawei.com>
---
 target/arm/cpregs-pmu.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/target/arm/cpregs-pmu.c b/target/arm/cpregs-pmu.c
index 3aacd4f652..adaaaf2517 100644
--- a/target/arm/cpregs-pmu.c
+++ b/target/arm/cpregs-pmu.c
@@ -228,22 +228,28 @@ static bool event_supported(uint16_t number)
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
+    uint64_t mdcr_el2;
 
     if (el == 0 && !(env->cp15.c9_pmuserenr & 1)) {
         return CP_ACCESS_TRAP_EL1;
     }
-    if (el < 2 && (mdcr_el2 & MDCR_TPM)) {
-        return CP_ACCESS_TRAP_EL2;
+    if (el < 2) {
+        mdcr_el2 = arm_mdcr_el2_eff(env);
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
@@ -252,24 +258,16 @@ static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
-/*
- * Check for traps to PMCR register, which are controlled by PMUSERENR.EN
- * for EL1, MDCR_EL2.TPM/TPMCR for EL2 and MDCR_EL3.TPM for EL3.
- */
-static CPAccessResult pmreg_access_pmcr(CPUARMState *env, const ARMCPRegInfo *ri,
+static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
 {
-    int el = arm_current_el(env);
-    uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);
-
-    CPAccessResult ret = pmreg_access(env, ri, isread);
-
-    /* Check MDCR_TPMCR if not already trapped to EL1 */
-    if (ret != CP_ACCESS_TRAP_EL1 && el < 2 && (mdcr_el2 & MDCR_TPMCR)) {
-        ret = CP_ACCESS_TRAP_EL2;
-    }
+    return do_pmreg_access(env, false);
+}
 
-    return ret;
+static CPAccessResult pmreg_access_pmcr(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
+{
+    return do_pmreg_access(env, true);
 }
 
 static CPAccessResult pmreg_access_xevcntr(CPUARMState *env,
-- 
2.34.1


