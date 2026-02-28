Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBF9FD0046
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 22:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwSUe-0002X7-Fi; Sat, 28 Feb 2026 17:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUb-0002VA-Cz
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:08:57 -0500
Received: from qs-2004g-snip4-1.eps.apple.com ([57.103.84.64]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUZ-0005o2-Hp
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:08:57 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 424CA1800394; Sat, 28 Feb 2026 22:08:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772316534; x=1774908534;
 bh=ZobmyIudfu7P7uUuPB0BU6gBIwq7faUFJCiyh8v9O8Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=DEEuF50qZr7o72gSyai+vXWWxOKL8xNg5wkWqvV6LWVo7tR7Gyt6z3hU68p4nwrLWJLfQuN5eIX4jAMe/7eYfwwtNeBd+P3v3lcpps6Pzdk3IYGr1VzVdtLNRMPwsu0+Q1IJ732UsKABywkXp03BTBXXpvIqPyNfmXOEBZIf/D4qznzO4RkyhUcoRYH7h6eGv0OxeKARJU9zAFyZEAtLV0SquWe+Dot+ALA9H+R/HBWrolI2U0J9BcdZ8Ideb6D+4SzJp8RznLcgI9qjk2f8Ij6jFsnT9y9AxIzPsv514+jVsjLmQID5lHHz0SuwUH23zF2ChfG/ZmmrpeHt4MzHGg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 4AB6818000A4; Sat, 28 Feb 2026 22:08:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 07/12] hvf: gate ARM_FEATURE_PMU register emulation behind
 not being at EL2
Date: Sat, 28 Feb 2026 23:08:32 +0100
Message-ID: <20260228220837.35275-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228220837.35275-1-mohamed@unpredictable.fr>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=b6K/I9Gx c=1 sm=1 tr=0 ts=69a36775
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=lOv7bB1OiAV5i3s2B4UA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwNyBTYWx0ZWRfXx4tl1eVnxX43
 BfJaXYGKuGO5qoDIye1m6dmN2QuFXi4TFqDkDf5kscOxgljdmofyO8ndQ6gcBtColQD545v7T1h
 H9OPq1WAGKJNLpEMOqueUY7BKZod/SLsDBIdQYmAH30nu8jwloWcRdqGW79aapX0hUYNUM/G/uK
 vKiHl+Yj1ub8OUeNdOKwFZa3gkXcQzYQhq/wNPOnoXprP/jJ3jyedrtlNjaQ6rWyDRR23wvNTT4
 VYoz9k1UZ1oFRS3JP2EvZ050d7O1rngT60Z2KEvW7idLMuE3eY8DxNGWVK438ZstnqJY2rFxB/g
 r/nlPq/t8iWsgcb6BGndcVwO3fcnF/5mV+VKGauIuHAE4niOAfqp/dZ8b3wJU0=
X-Proofpoint-GUID: iGuvJBzpgvc235Rl_V9qHp_N8_2RV3-a
X-Proofpoint-ORIG-GUID: iGuvJBzpgvc235Rl_V9qHp_N8_2RV3-a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1030
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=786 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280207
X-JNJ: AAAAAAABYxFkrOGdY18Y8CMDfVKWgJr9GLT7fBpuzIVPWChzAu+Hf03M1iYGSOBAa3PLaVOY4cddzR5EsaqOBDlRjkKgcQoZhfJ5GbwSlyqphK0/J1fHqsvZjrW41FI5GXxuTpTcl9uskBONy++2CVezhSVZ326So76mmgmNNbCJo3xOLWmECnFI44I13Kw79ObN54CwIZbVIeFYWcP+ORlg+gU5W8xar/RxxUCrdtanZwOnLVqgkTiUuwHkLMWSaa56F3HlH0u0C63QAvQeYEin5Nf6dwbAiPSz0dfp9vS3BUmsy51+KKW/ccp2kubB0cdsjTorqMe58Fz7qdWDb+0QI+eZVuum2Mdy9zdWMtcI2/vDONxOqDkSn6t0zYJNG4HdyBPgDTFXOB/UR2/4wjf7FA6wmoAciOD1w2vPuF4xD9AuPpTSEvQPx7mxMKTg58gNdpuURkQTAODp0NgJ2632omCg9EOnxTiYSMTMISv/EttpS2jOhkU4UkWQojzD+pRatELg+NIFxKy/APHUCvDgU/imTBYY9ybeLlUFqvHkp3pQNBCsVV6ig7wDTs8l+x5s7Oe2By5Qz05sWBwiXcQ+gwPFUPVYfmyx30g6oGvfKnE5uFu5M0vouCho/38a0vfjMVx+0jYDRPYM/3hom9BVwL7HWV3h45JNrY+B/Mt9NXEiRk6EvQSaqe3sAgRdb2+sWCeOILRj01lXN+HdYcULpHAcsnPeWV0VM98=
Received-SPF: pass client-ip=57.103.84.64;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
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
index e0a51faf28..be1ff93e0e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1285,7 +1285,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCR_EL0:
             *val = env->cp15.c9_pmcr;
@@ -1546,7 +1546,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                            SYSREG_OP2(reg),
                            val);
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCCNTR_EL0:
             pmu_op_start(env);
-- 
2.50.1 (Apple Git-155)


