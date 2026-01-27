Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C07D2FEDD
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vko50-00010g-7K; Tue, 27 Jan 2026 13:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4f-0000Tc-Cq
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:46:02 -0500
Received: from p-east2-cluster6-host11-snip4-10.eps.apple.com ([57.103.76.241]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4X-0007ck-7O
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:46:00 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 F24B01800646; Tue, 27 Jan 2026 18:45:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769539539; x=1772131539;
 bh=b7kCF0v73NAIBglHez4ObmnFhfyHMQtRmfY1TpbGWrE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=IRuG0I13SedHu40kU8+mRoxwnVtSeU+Ijfd+lcpfImohNxlGqKBTSzLV+9o0I9bZpVnr6iK/BoXCCdY+LM+pZvNWTP6pqOi3iRgb3+wJgM9P//r1dwF5HMkbdZlTymPbxsPu14QWGpE3a7rB0QnHJbjpWVWq6wLYfIyO+C7o4ebT0HUYrCux74rvbKlvNCJwPBwI4OmousV5GdrLAqQVPGH6cbiDB+vs4Jv1Jibg0Fu316zI680icI2bSW+mHp0/01mZlw+y8TVD5er7ydZVs9+cp7C/3P7x3Jja2me1Humm1X++fR1E0bNenrOGtVPgAKxVzt7/5bbdwPlJ9FdS4Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 3A8AC1800648; Tue, 27 Jan 2026 18:45:37 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v9 07/12] hvf: gate ARM_FEATURE_PMU register emulation behind
 not being at EL2
Date: Tue, 27 Jan 2026 19:45:18 +0100
Message-ID: <20260127184523.5357-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127184523.5357-1-mohamed@unpredictable.fr>
References: <20260127184523.5357-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=R+cO2NRX c=1 sm=1 tr=0 ts=697907d3
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=lOv7bB1OiAV5i3s2B4UA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: U4sAfxjMsPg4J0DxfeoxLypA4j6Ez3YJ
X-Proofpoint-GUID: U4sAfxjMsPg4J0DxfeoxLypA4j6Ez3YJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MyBTYWx0ZWRfXyuJ3t02g57RG
 /OlEr0Vv4BVAXxnWIbwT6MKLK5SXyrvmSpC0ksWHBbWBZDo8Poq6ZdnuA21dUuokIJ28RANr24p
 Z1lGW4nlZRp56kJcxf20zjS3QYw7tb/PSXrIPOC6UoyjCA73p7/rVOUnXV3ckrW03oMvMyjrYZY
 o3Q6l1Lti6xQMilcGM9CumOzZmmJbqclQwmWc2D1JpL3V9T35jEgnmuWzxAhKfWEg+5xusZxPOe
 IjalrdNz+Wr4oYXeSn9hWzvTOPGTUshKj4ffNGJVIlcbSyn5mlW3jejdTEpiUxvCrQKHcEMfcnn
 DK8P8AkA12SgkWII073VWSdiZhQuP8HoXNReqpNdF8AapR5B60L3GGuyfQoUEs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1030
 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=806 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270153
X-JNJ: AAAAAAABx0dvoA78dwsfAVnlORw0cofbsJJGDUqSIkUoZQ475y21Z3TRtJqAIYiNgwUurfQT3W/DlJl/3HV+M+bmxZT8eP/5L/7oaV0cccEyDuwmxZbTmxYwel7UN1wAicyqRaMsfAvlDAC6BrM9st7oRjBSLFR9ctUXVrc1tJpOlP4dTa8cBzLYprzSlQHCYYoyZ5qU+1J2JaFPhJAMJvytnuOkB6HPnoKDyep6I7EqfyiIFRoHGUSFmY+WWBPsLnPVuOvtyfybLpf3VjJeo5BgqSkkTTYpmYXXCq+Us+8ntJVAzd2SlVVPV2Y+M8G81D97X2x53SZMfjHM8SstgVmM9F8lhVnRxMgG3QHGOcn9ULNtAsZ4x6VKu+W1qCHPPSrGwDHS9IcPQrkTI+brUimh8OPCC3yrwjZw51VPNUm8orypWFnGvOQqQGHhwxJH42pHxa1tcrBZMOacUkw7PYQPCK542+ZvGwkO2MJECxU9D6NmCBJeJ6EQhyJTmOmoct1mE/fQ1L2CsgRWdIP3JL+VDhHa1C8Iehsl5tijyEENtzf2wKN/jVDZpY7y1rwBDQiOhYdXMuIehBG65VmxHKRvOyjnk7RHjx9ygQ/1ZB2qB27QnPHA7KsuaHeJjDo9hwLYXv4oK/RgYXri+mVSXJAHe8V4FjdA+91klo5YiIqfYAYACKlBaAvjxqlrv9GTFo6yuIwiCrLxDxKU1WHjLdvDnurqDLLYgvTok68=
Received-SPF: pass client-ip=57.103.76.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 9dcdff685b..9cf979d402 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1254,7 +1254,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
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


