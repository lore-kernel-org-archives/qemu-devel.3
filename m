Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44FAF01835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUok-0001P4-FN; Fri, 06 Mar 2026 08:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUob-0001Hv-Ty
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:02:02 -0500
Received: from p-west2-cluster2-host2-snip4-2.eps.apple.com ([57.103.68.195]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUoZ-00077s-Rr
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:02:01 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 222D11804C48; Fri,  6 Mar 2026 13:01:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772802118; x=1775394118;
 bh=ZzINuPCWN3dXEmNZ7pvDXhK4zFfceWgBWNxPKCnclwk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=ZzIOKpYzLZrt3nRD3Yy1m/b2lb5gw7RZMRWl5f2NQlW91erlByaDnXYTXdtr71CjWnedLF67XMhcqkuRY70PynvYZ5j0+NxpEWc89xyFXeZlYF3bfn8sNElnBnQ1/0TCIRWYalNrM1rkoj0IXlzM4pAC64Q8IVjOKAwiXairWq4M6MquVpsAqdA4Ps9paAuSi3YThYHyMjTxg82Ey/Yjs4gUPqlye+VlqZRuODxFi+wEqVIVw9+MgW+rNO2e3Zkvblz4kGE0+ANJIz9cU9QxRCsHiK+DuOe53RxPe6Aq+3S9LtWVNxwFLQjt5FsSIcpL/R9s9GIaFie1IWkFc2X0xA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 3CC3F1802E76; Fri,  6 Mar 2026 13:01:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v15 11/17] hvf: gate ARM_FEATURE_PMU register emulation behind
 not being at EL2
Date: Fri,  6 Mar 2026 14:01:01 +0100
Message-ID: <20260306130107.35359-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306130107.35359-1-mohamed@unpredictable.fr>
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=TsTrRTXh c=1 sm=1 tr=0 ts=69aad044
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=lOv7bB1OiAV5i3s2B4UA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEyNSBTYWx0ZWRfX0wy2KPTX9NCv
 N9omPc2zRYmoVXTxyJXSrq/MnWrp/uQZMGIy+Din5R3MZjF2kGRntbP5+N/eHM2i+BOHyMg0K13
 BGcx4e0xpWz6kS5SlZNn8ukKdEmEJleBGTUXJIaPnyFMFNdLUE6ubqhLMIpulvc4Di4F0aNq4G6
 pYJ3n78J7W87ukNiKsHuMeB6blXqR4G5TEbDbgY0z4TQlu9ffpRfFoOyOkaPrcNONY1esZAe8dp
 eGFlE5MaaKOUkou4B+mCLfIt+paAkbnMZUxYMo3BIOcVqhnyEaiZKYGE7S0A5arHIzJYb6EyAw9
 nfC17zlhS8ECsQkfMCZn/4leB3G/Z0+eranpnw+r8y5q2kn+bb2tqQszaZNFrk=
X-Proofpoint-GUID: 6r0l6VkESvLr-XrvW3HBEKYEfvXAECRR
X-Proofpoint-ORIG-GUID: 6r0l6VkESvLr-XrvW3HBEKYEfvXAECRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1030 adultscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=752 bulkscore=0 malwarescore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060125
X-JNJ: AAAAAAABfgeDZPP3tY4AhBQC/LefFHxLickTPiSneRwEWwShrKQzuhphhwTGcoCK7XCZbp3u3BiOSkBWpdsztdxerG+fhwJBNj0DVkf9W/FWD3A9D6C6A77HfwUbJ+gxmJTXVxcgnP/lXXdhlEjqnAewazOI5Im7fOvbZx63D4+O/CO1JkiLJqvme32Z8/nR8LGG1rAFbJW/je6//yBYwa4s1o64L8WOGr7px8fEmLZ7dD6KzlkzP91JjCzy5My/4R3dqTKX8dXASotJVWyPvsbz1jwum9bk13oCBZw/Phv4NJeFGLu9W7X/xFv6ZPEO9mpJcftvMPuf9JxyYYgHDkM4rAT+3QFMAnUxvOZe0lV6Gi8pA/haMvgtqKqE7KjbxUxqAG28VjY9mXOnz4/So0AR2T/CxLRteb+Q0xCJdkfW2jwibT35VCVcNA4J75UjkQpFehrZb1LYDJ4BRdJb8qvWwoVqNgM8hzq8th1WsNO17YL2j6C2IzjxFvR5RPmKQCJ5/XF5kpFqINTGmSNAYYN/6OFeGL8HM3vSBS1Vt4KvTRx6U/vsrAXXML+atM+z5BSvsGuVOt5FRPbpNSvWIoFbypyEVlP815E+UXeXqt+6q2ythMY26QkJeKFwFExuFReUSLPnAnujNER59v3JvSCWNmF56+6nEKU48cRWGN6wj99198UJ0Mn6SUyhIbAFEG2JQilqFHCad5AActjlpEvlteFi5gYS9plUGVHSurAYJqInQITFvsEANA0pWm+vlTAg9T6fxbYNcBPanOcPSA==
Received-SPF: pass client-ip=57.103.68.195;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

From Apple documentation:

> When EL2 is disabled, PMU register accesses trigger "Trapped MSR, MRS, or
> System Instruction" exceptions. When this happens, hv_vcpu_run() returns, and the
>  hv_vcpu_exit_t object contains the information about this exception.

> When EL2 is enabled, the handling of PMU register accesses is determined by the PMUVer
> field of ID_AA64DFR0_EL1 register.
> If the PMUVer field value is zero or is invalid, PMU register accesses generate "Undefined"
> exceptions, which are sent to the guest.
> If the PMUVer field value is non-zero and valid, PMU register accesses are emulated by the framework.
> The ID_AA64DFR0_EL1 register can be modified via hv_vcpu_set_sys_reg API.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8363e10eff..91bbb2013b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1589,7 +1589,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCR_EL0:
             *val = env->cp15.c9_pmcr;
@@ -1850,7 +1850,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                            SYSREG_OP2(reg),
                            val);
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCCNTR_EL0:
             pmu_op_start(env);
-- 
2.50.1 (Apple Git-155)


