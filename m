Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652CCD3CCAF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 04:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgFKF-0004k6-Hl; Wed, 14 Jan 2026 23:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFKA-0004f3-W5
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:51:11 -0500
Received: from p-west3-cluster2-host3-snip4-10.eps.apple.com ([57.103.74.73]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFK9-00065B-Fi
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:51:10 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPS id
 9A61B1800138; Thu, 15 Jan 2026 04:51:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=f7JtO9MEmCTAmLhBjznnRgGZ/zww0xrzSkcQXdzny5o=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=QMOzbdj8hxbZhzDAee98SevUHm7iX5cWE1Wq3ZlSFK7njjXQEq5LtM65YizqERh3TeiC77wvEUzFaU1o2SJrzboYYFyByUNAs+tr+9v1DCLKiAfRLO6/Y6bfahhWNZUQmDK6Ul+/GmB/uagEkvJIS6E0vfmAxP2WXQl1zlaHY55HT8wPRSfbWt7Y5yFufJjP8s6zToGDuXBnHJQErfGftepoWpohbrkIIEnC8wW+nhaFeI+OYfW7mIInkNqunKHEXNEzgIyGL7Guw3KNptvcG/cTkchQSCpLrpKWCZAg6gpn/jJpRl5ZWRBlRHTZJEl6sVu8HvpqaVxaqnGlW1KC6A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPSA id
 DBB93180012E; Thu, 15 Jan 2026 04:51:03 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 07/10] hvf: gate ARM_FEATURE_PMU register emulation behind
 not being at EL2
Date: Thu, 15 Jan 2026 05:50:39 +0100
Message-ID: <20260115045042.70086-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115045042.70086-1-mohamed@unpredictable.fr>
References: <20260115045042.70086-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: D7p-i1kCWrfFZJvoV1_GGpvfYNncTbv7
X-Authority-Info: v=2.4 cv=L+QQguT8 c=1 sm=1 tr=0 ts=6968723b
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=lOv7bB1OiAV5i3s2B4UA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: D7p-i1kCWrfFZJvoV1_GGpvfYNncTbv7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAyOSBTYWx0ZWRfXzXYJHaMNa+Y9
 FjiGOYEsXRXhEFITyqq+pjj/DrWEhAVZlvaVPSWbbauwULidpYGrkVMAwHyqxJW/fM09ddEtjIx
 FOVhtgSZXsFBX2cZzmNpw8sSQtlZq5/ixK5ohsWn5tVVUbap8QaZFz9Cn+P77E+NdOI3Jh1bqKE
 9Xne9xFqKOkp9IbrHmpgL3bLT0OzD8EmhbKa/2wDGpG0C8/16W8qjTK5f17bQWVShTdU70xSsGD
 s29X5WBicJM+zEvYtNNNAx2BKlU6yD5RCo5kM4l6Vel9dVoozMerDj44n41pb8xDHFdAWJTjo8e
 x6/vn7Vm6kzSdAkzzpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_01,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1030 mlxlogscore=769
 spamscore=0 bulkscore=0 adultscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150029
X-JNJ: AAAAAAABaiOOKGrreDzkv0i6VFybPUE47odTym+XXj4cI/M4i2qJfhJOsSA2hmYGB5Mwl62qrrQsisDF8BjoAsJcvyPcfWjUFlD1JVY+Wqwrs5aO8pDuaKHDsVBaBz6PJ6QxBe/56oPPGevcJm4o1aN6SXL2F6M8jcZkOEwJSaC4vK2hydmmlhJnqKipuQjhzp2WEDN0iJ4WFqCykG1o5lV+EyjGEG5QMYwoBhkxVyxceW5mmGMHO/sncDh5xCYwYoqCSyShdDb+o73w5wIp5bCeNnx2gD/sHWteIZR+NT8R0rVBuwk5C8vCSneo/e3GuYKmrg2eiLcFBo4/5ik8xMamBtdtk7/CeTGqCMAy5L3QefVtwOEYNMURCsga89MFo/c0ktF6l9WoXExmdFzxCrBqxP3E3U534eIPOscf2188q2o4vGkdLwTqMnx+TKfaqYJZOBdZbMHpdBcS9sxPCO+Km7ZpDRpFUQiGNI+Nh26SGsMFslp7RZVaw7BbFphwNA9I1JRXzhZzfJJStLOg9eLdSVL+Cs9dXm5C4OMA1ZJaWz1zai049cMD8+UTHHP6OkTBLqrC9PUnicqNJgm4B0MOQ4ag5/qiYbwuKplEGLZfbn+2dsC7irWJ8gip5emQy0qw+g3PY/KgapP2gzB5NAENMB8rRNy7At5O0EjYPkpH5XMJOfZJgZ3z8qBTDVEGPZRKdszzdkbiGfc1dPeAID0UqOY=
Received-SPF: pass client-ip=57.103.74.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 2c22025d88..de40a866e0 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1243,7 +1243,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCR_EL0:
             *val = env->cp15.c9_pmcr;
@@ -1541,7 +1541,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                            SYSREG_OP2(reg),
                            val);
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCCNTR_EL0:
             pmu_op_start(env);
-- 
2.50.1 (Apple Git-155)


