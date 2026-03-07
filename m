Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9303F55103
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyw0O-0001nF-TH; Sat, 07 Mar 2026 13:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0L-0001mG-W1
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:03:58 -0500
Received: from p-west2-cluster4-host11-snip4-3.eps.apple.com ([57.103.69.134]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0K-0003WC-JC
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:03:57 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id
 AA1451800E3E; Sat,  7 Mar 2026 18:03:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772906635; x=1775498635;
 bh=E/LouNoMQ4W/aKzwh/YIr4xZ/85njeY6sAjm9F1tdWU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=RDbQn1fDsoJHaLu8XPoV1R3aeQmiwTDdaMGILXJC9q2NamDDHVN7mibJYpO/stqSARhF2+7XFlrClsXiIJV5pe38/YfJ3GD3seyi3BGP+Wp/nJjjpn8N/4yj19E5irfKLmXpdwdrhxZgfmawm1mAH8W9gfo0vNVAZTITYI4pI4RHzcYgSVMlvso+plmYb/HJVE7jqDzbVDLyeNActfPd2CS4c6bP0Nqff08TTaOZY0yjwNlCKH+y0fNiqApvdSWopW2tv/t2TCUcP9oVuy4TbvKUohUHEvh9GxJCbdS1Dw7HxAM4HtQniztTw+KiGzTN8L2U345UNpXtkIisctc5rA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id
 2151E1800639; Sat,  7 Mar 2026 18:03:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v19 07/13] hvf: gate ARM_FEATURE_PMU register emulation behind
 not being at EL2
Date: Sat,  7 Mar 2026 19:03:24 +0100
Message-ID: <20260307180330.75168-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307180330.75168-1-mohamed@unpredictable.fr>
References: <20260307180330.75168-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Xm0Rik_RCqAQMHwrYnGyZxarCwAj5m-V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3MSBTYWx0ZWRfXwDtZD6IDS1X1
 nJSmFkGPrRvwqkyFlJxTihBuOX+koSFaQAnk40gS8tkJqqHfYPWxr7t3R/fRiwGPma8VwSG9fXz
 nQQhDNCjHVEaZCBqGeDiyMZGwSFNDKsXvLG2GDAQ4DgPqQKY5fnq4fkXQZyMw9him6SbW9hbUxS
 sVdc2SlUOp8o0G1SXvq3CMaLEpHTgjrk3gyBkWtSOI0Xvw2vzHnZipF13xohM807elNx8nnzQb2
 LGo/vFJ374nrVXOSOid16BkmJNLrUDV4L5/jU7CBfaXcH7JEEMBKUqE4U1uYvdU7sXxh+EFHgVG
 1Ihiw/yT2CIrC3AZsOj/tRsV1Vvi3xutAtpvAH6gw8Lql4ioo9DuWgd0IIh+Po=
X-Proofpoint-GUID: Xm0Rik_RCqAQMHwrYnGyZxarCwAj5m-V
X-Authority-Info-Out: v=2.4 cv=TambdBQh c=1 sm=1 tr=0 ts=69ac6889
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=lOv7bB1OiAV5i3s2B4UA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=683
 suspectscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1030
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070171
X-JNJ: AAAAAAABMBhqfGElKlshvKNEXR31Oj5LbT08yftQpLav6awwMcZO/0h/sO0WJ6InH7Os7VAiTeMRKRZptie9I5j/j1leahbYYpGRHUKzMaDQF15iYHsvpZoDd2oS8mueAH3ud1HGnaQftMj8RzM7cgxZfzQKmoCbtWTblARtbQEkZFAJJaVfnfXSATg9AaH9tPW29EeRUXG7wBHlvckmLrI14uMlhU/c+kkdyOT2Bf8MyR8STtrev445RbOG+aUJqledrviA64CGaUq7/znPqI1VPogSvFRqHHFzxkCpaN/wGQ6qUuxmOu978zac5vLWzuDJhMdPTFm8RuyJF8SG3WGkTAqg+lFqQoODqIhqcHl41IJwf/YagIMjeO5RKzE5YBolaRyTlV2zRQFkkLDBa/GDoAuBjuZjJghFhuhxJ1HBZGff4W4RDcI/WRY38K68dRt7CR4TpQL6U9Q0A0oiCBO2RgGEhKeYK/6x4QY2nkQVxt9pyZjgwJ7Q0sLuVBd4hkVtzy4EgCgMnr+FZEKj5tca6p6n3vHLbGpvjZP8T9m9dCYVPlcemjqCs00mztDEqBE/cUUbGKGjK8W4z0U+ClyEnBa9NA0tuxDHbgcccO2BdHv4qHPb8orWF5WHM2KxozdZVWdplxeIddga+8MqaMnp8nh1YP2nqpw5UeZFQvJNpRbL5hKgfbepzdNM68pgKoHgim9FwcMJvdHVeAuSmX0CpWnDePevwpqhvQnODWAU94cfI5S0uPTMiX8=
Received-SPF: pass client-ip=57.103.69.134;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
index 04c4106a3e..14c0c7f540 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1601,7 +1601,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCR_EL0:
             *val = env->cp15.c9_pmcr;
@@ -1862,7 +1862,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                            SYSREG_OP2(reg),
                            val);
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCCNTR_EL0:
             pmu_op_start(env);
-- 
2.50.1 (Apple Git-155)


