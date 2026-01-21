Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C71C4453B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 14:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYjn-0000Is-Km; Wed, 21 Jan 2026 08:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYjG-0008T5-R0
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:40 -0500
Received: from p-west3-cluster6-host6-snip4-1.eps.apple.com ([57.103.75.114]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYjF-0007IR-Ba
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:38 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPS id
 E5F4B18000DF; Wed, 21 Jan 2026 13:58:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769003916; x=1771595916;
 bh=JtN7MHIsgv+ceQjjKvl5vfwGY1huIPCI7oU77OcjZvE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=QJz+xihj01OGL8UV3EZu6RT2k9gqXssv0aZHBoNYx3szZwPVTVKo+EmxaQQr2c1pUREJye5RZ84DxJlb43TU/Ct9qD91Yua2LFZ0kZjG2uU0rVPvNgrx+xi4FBhVrAuvs5AgNdc4HgASFhudyQ4yDFtGVtgIhgjNwkjooOGBYG9bl5PXzXpYCzWgHC5d9xX3iwittRckFBFp4lGABpzBzaC9SXjw+2AASxd8LGQH4q60ajjEzp4gKsQfRGTKeHiB8s+IFRD5pBFyY2xD4Lnerxw+D04Bg+4NXNz8LSSaSbTxhD1LabBptQmdWtGIBCBYFH27xLa9x6Rgu6y186dnDg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPSA id
 8B7B31801066; Wed, 21 Jan 2026 13:58:32 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 06/11] hvf: gate ARM_FEATURE_PMU register emulation behind
 not being at EL2
Date: Wed, 21 Jan 2026 14:58:11 +0100
Message-ID: <20260121135816.21258-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121135816.21258-1-mohamed@unpredictable.fr>
References: <20260121135816.21258-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExOCBTYWx0ZWRfXwkUDJ05LV/3j
 ddo5sPatrxL/1HspvysKxpiYQxDQp/QhNrPI/tHxSBNqfKa4giA3oC+wceerNe3I6rMzJr1fl5o
 Hyj65btC2tm3V2VE1z8ZrR62N2HxOyV1AFvB7p/5ClhJUAKe2c9dev+/dApBQSsHnIKidg1Yrt6
 pxQqhROwgYmtcEksvxhVyGubennZq7bOuFbYIQE04Fbc9mIfwRzJi8qK5jEMkAc93xzSWFrF5t3
 tcPg4oRC5N25hd8bKNMRuuq3eUhMEWAHEUfhw7ndp1iUYUwKSxKdiUgD4/SB8yYxjZv/lDo5S9c
 kBJc9kqxVPxpdxckXpx
X-Proofpoint-ORIG-GUID: bJcoDhlMRknG-altxBlfw_jmDemKsdXb
X-Proofpoint-GUID: bJcoDhlMRknG-altxBlfw_jmDemKsdXb
X-Authority-Info-Out: v=2.4 cv=K8ov3iWI c=1 sm=1 tr=0 ts=6970db8b
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=lOv7bB1OiAV5i3s2B4UA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=768 clxscore=1030 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 adultscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210118
X-JNJ: AAAAAAABwv9/W0Ew+/1rWmzEYfyv+mBA3puUYqU6xp7DIaYL3nzdrjmSLzs9xomkax8UcM3nhJj/lX9LIOyBvjmm1+r2WuxRDO8maVTajt92U7OaT669tvXf+umjiGSgW6c/KZLxFBWJ6X41ZQqDdNkCR9foXg9TiHoKfXlOvwyVxIP8vUH/dLf4z9W/hplkNtD0OGHKRKBD5rdjX6gTgbqbUp5rhKEZgFmG2O5V/gA0jIIpOTqlPDqo8bIG6rDDQfHEGGSKSFpZJH4HDh/mHEo3tHRuptpB6pIxu4ofexN4TlE/RwmQcozmKGqg1rDh8RK++hl5WOce0NvmwnyIXdzNjCRb1ETLFGPkCjO9tOKYIp90NyYDz12AlozLCO6HU60eDjmOF2Gzg7+NlPPrnuS7+XK2pou/Vk7jjKpzUG61InlmMLSE+7beRFrRnJcVMsunCaYG51sibzZkspk6bs+8gvxw5xh2rDVktnr8PV44Mzce+XVsFlaWsdxWllxDKujAIovtNOJl02kuKctjLCO4vEGZAThkuC6vejHtRtb01FnIdJRy8U4Nt1lmOYlghoPtzsbJf0QqH1zPELmYUXVinnHwbgkOAz0a24Ag9Ab/PgRftXjzvFd4wmaUQHOIY8vPglhY4E/3rJGqMJYGhpniQBjKQtHfiOxY0WnIGnKara/fcUQYr3L6Ad8gZpNHH1vU264cI7AIe6t6CU93bPA=
Received-SPF: pass client-ip=57.103.75.114;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index f6313d9afd..13836d6510 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1239,7 +1239,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCR_EL0:
             *val = env->cp15.c9_pmcr;
@@ -1531,7 +1531,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                            SYSREG_OP2(reg),
                            val);
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCCNTR_EL0:
             pmu_op_start(env);
-- 
2.50.1 (Apple Git-155)


