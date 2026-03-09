Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7217CEFCD99
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 11:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzZ51-00043l-KI; Mon, 09 Mar 2026 07:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzZ4j-000428-QC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 07:47:07 -0400
Received: from p-east2-cluster5-host1-snip4-2.eps.apple.com ([57.103.79.5]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzZ4e-0001yQ-2q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 07:47:03 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPS id
 11A601800183; Mon,  9 Mar 2026 11:46:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773056817; x=1775648817;
 bh=M4X7F7sVtSxrSdswU0mmNoP5PsUwxm7FymuQOBZVwe8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=StFNPSJCQMJCF4bCx1nY1Wd4cmdorH0m/P2hGNaVyF2XrI8nrGnEnptabIjLlprOPzJFu4acT1x/FtOKmKDTV65BgSZxWVBv1pnzgV+GSmbe/vn0v+KEISA86FM6vAxhLPqHPuRTf2BDLOyb6GaybpNY9B4LUuosQM22SjQT9TsRHRoANFvlEpJut0/JyermAz1y5N6tBN7q8JsneAu5pTTe0Nj42+MP21ujfoZekQiIVT6zTfe3RpMh71RV9sr6l3eWzSyXoD+fYNu5u372KZpZIU5eQoxUcW084f03unO87tZFldZ1IuEUm70CgtEBHverzUqxv8qfq/Fc5WNuWw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPSA id
 874BB180023F; Mon,  9 Mar 2026 11:46:54 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2] hvf: arm: fix Windows boot with kernel-irqchip=on
Date: Mon,  9 Mar 2026 12:46:51 +0100
Message-ID: <20260309114651.18825-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=F+Fat6hN c=1 sm=1 tr=0 ts=69aeb330
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JzR25OtQh3In-oAEvrgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEwOCBTYWx0ZWRfX80igAhqfA5wx
 k3Z0sof6xJYVGMcT9BUzIAI+r5LK60SffBJz90YzqT4e7xlfUPlVdgoP+/Zd/xOT0RSX/f/RVfF
 tZzjKoSJKaIxb7Xln7waWaTvpyIX03uzwUG+tYYHg5ZvoHNJqvd2Y/BbHdl+vvrrRwHXh4/IZBY
 AB0HhCjx2DYY9RQkqrhoPkCKCGYTn5+6w6IYe6TpOJPfwcFJqm1mmtdn3w4RHcS1NGSsPZ3rtcs
 7UK1g3vEeVsgP15qdx34wWt34GSWraMkY5F/XMOPdQBUIeb29R7F/uNarh+LGaofOsUqn7WUTE+
 WhlLvrJRPrUHQwOdTmMK8+xAraOnRAGCoj8AQcKVHw+q+IyCh3qjZDkYk0yt5k=
X-Proofpoint-GUID: QZU2tkLk-45yrQTjnBJD050XckdMbfOP
X-Proofpoint-ORIG-GUID: QZU2tkLk-45yrQTjnBJD050XckdMbfOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxscore=0 clxscore=1030 spamscore=0 adultscore=0
 mlxlogscore=870 bulkscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603090108
X-JNJ: AAAAAAABMoDJjOlVmJHigbOEm1sqtD4HyC3J0vuyd4Ug1P/o2WCJ84ygL/69MsuVpoW3LFwVXlHW4NJ7m4Es/Y8DkLuyHwaY84NfaXvp1x7BEJDq0Y9dvhnwSHXowSc+ZffWiX/0fUrxAGm/+D6ggpPbeGH4TBAJoBGvE1ixwutq6EFoQSGyTm08mPiST4DgHf10JvfpUXsK69VDw3TuDafYXUPAmt7WIQ+deTBQMbT0OGQotBxLMz7qfFrTC0Hw/0qLGC/VM9a5gMvLXxlBggMPpzv20gfiy2gOnRhxcNg0gu8c9jSsdEz8LA6Cpv81gVAcXP9+OE7FU0M5ZRPlhMVL6K3trIWvanQ3dE8J1WiuJBPm2T8P/317h/DI1Ah03XYIVPa4VzhjCVQwSrjowyrb/KRAcTt24PAZgp634g/nTh+LVIGcsNVNALgOOMiYWesCltfOD2eqUbBg9uUGWef72fqh3CMqgS+UBCBRzWhAnkq6Ty8hdbecCq4k6vyDxjKhijejCbIixS8Mfl/126HHtPWE9uM3lWsXtnVi3AqNI/s0th+bctFguCIkUW9LAq51V47yPcAKY8qv8pj3xrJoUrN10ewauzqdj8q/xgQyC0hhE6xrObTZsEppakKe3Q+QKh9PuX+0J/4k0TzNx94FRjLVEd2EDxJLihA4DTc=
Received-SPF: pass client-ip=57.103.79.5;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Apple headers say:

> When EL2 is disabled, PMU register accesses trigger "Trapped MSR, MRS, or
> System Instruction" exceptions. When this happens, hv_vcpu_run() returns, and the
>  hv_vcpu_exit_t object contains the information about this exception.

> When EL2 is enabled, the handling of PMU register accesses is determined by the PMUVer
> field of ID_AA64DFR0_EL1 register.
> If the PMUVer field value is zero or is invalid, PMU register accesses generate "Undefined"
> exceptions, which are sent to the guest.
> If the PMUVer field value is non-zero and valid, PMU register accesses are emulated by the framework.
> The ID_AA64DFR0_EL1 register can be modified via hv_vcpu_set_sys_reg API.

That documentation turns out to not be so accurate, with the determining factor being whether the vGIC
is enabled instead of nested virtualisation. If ID_AA64DFR0_EL1.PMUVer = 0, Hypervisor.framework doesn't
give us the luxury of having PMU sysreg accesses trapped to the VMM when the vGIC is enabled.

As Windows really wants at least a single counter PMU, give it even when
using the kernel-irqchip with nested virt off.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8aa59a1f77..136761b429 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1187,8 +1187,12 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
-    if (hvf_nested_virt_enabled()) {
+    /* Windows really wants at least a single counter PMU... */
+    if (hvf_irqchip_in_kernel()) {
         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+    }
+
+    if (hvf_nested_virt_enabled()) {
         /* SME is not implemented with nested virt on the Apple side */
         FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
     }
@@ -1660,7 +1664,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
-    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_irqchip_in_kernel() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCR_EL0:
             *val = env->cp15.c9_pmcr;
@@ -1930,7 +1934,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                            SYSREG_OP2(reg),
                            val);
 
-    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_irqchip_in_kernel() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCCNTR_EL0:
             pmu_op_start(env);
-- 
2.50.1 (Apple Git-155)


