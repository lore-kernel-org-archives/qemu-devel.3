Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9B3C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 14:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueE9q-00023I-6x; Tue, 22 Jul 2025 10:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smail.aider@huawei.com>)
 id 1ueD9U-0002sg-AJ; Tue, 22 Jul 2025 09:35:29 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smail.aider@huawei.com>)
 id 1ueD9O-0005Yl-IP; Tue, 22 Jul 2025 09:35:27 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bmd745WGVz6L4t1;
 Tue, 22 Jul 2025 21:15:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 0295914038F;
 Tue, 22 Jul 2025 21:19:35 +0800 (CST)
Received: from china (7.182.10.167) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Jul
 2025 15:19:30 +0200
To: <qemu-devel@nongnu.org>
CC: <alexander.spyridakis@huawei.com>, <zhangyue165@huawei.com>,
 <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>,
 <liuyutao2@huawei.com>, <qemu-stable@nongnu.org>
Subject: [PATCH] target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
Date: Tue, 22 Jul 2025 21:19:25 +0800
Message-ID: <20250722131925.2119169-1-smail.aider@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [7.182.10.167]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
X-Mailman-Approved-At: Tue, 22 Jul 2025 10:39:45 -0400
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

Trap PMCR_EL0 or PMCR accesses to EL2 when MDCR_EL2.TPMCR is set.
Similar to MDCR_EL2.TPM, MDCR_EL2.TPMCR allows trapping EL0 and EL1
accesses to the PMCR register to EL2.

Signed-off-by: Smail AIDER <smail.aider@huawei.com>
---
 target/arm/cpregs-pmu.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpregs-pmu.c b/target/arm/cpregs-pmu.c
index 0f295b1376..3aacd4f652 100644
--- a/target/arm/cpregs-pmu.c
+++ b/target/arm/cpregs-pmu.c
@@ -252,6 +252,26 @@ static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+/*
+ * Check for traps to PMCR register, which are controlled by PMUSERENR.EN
+ * for EL1, MDCR_EL2.TPM/TPMCR for EL2 and MDCR_EL3.TPM for EL3.
+ */
+static CPAccessResult pmreg_access_pmcr(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
+{
+    int el = arm_current_el(env);
+    uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);
+
+    CPAccessResult ret = pmreg_access(env, ri, isread);
+
+    /* Check MDCR_TPMCR if not already trapped to EL1 */
+    if (ret != CP_ACCESS_TRAP_EL1 && el < 2 && (mdcr_el2 & MDCR_TPMCR)) {
+        ret = CP_ACCESS_TRAP_EL2;
+    }
+
+    return ret;
+}
+
 static CPAccessResult pmreg_access_xevcntr(CPUARMState *env,
                                            const ARMCPRegInfo *ri,
                                            bool isread)
@@ -1192,14 +1212,14 @@ void define_pm_cpregs(ARMCPU *cpu)
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


