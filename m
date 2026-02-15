Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43965EF5879
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 11:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vraGa-0005M7-QC; Sun, 15 Feb 2026 06:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGR-0005G8-0G
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:11 -0500
Received: from p-west2-cluster1-host1-snip4-5.eps.apple.com ([57.103.68.8]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGP-0007zC-Ao
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:10 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 C9CED18004D5; Sun, 15 Feb 2026 11:26:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771154768; x=1773746768;
 bh=ZobmyIudfu7P7uUuPB0BU6gBIwq7faUFJCiyh8v9O8Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=In95AzLZfkxpy8Q7GY0YsPaRIqYiXs56WuPtg2BYsOX0cOXGuhGecpiLvPUFFxmuByKa1KP3HOz4HWNocwSEXqI3xaDnVcabQPNs1AIuKszTDPULfT6yyMKiymZbJT/ueLz6JGfgn5ixjFg6Gx+e32Y3vuOsGKfOe7M+002wgpMrt9vxkUk9kfb07MwxJlzEI/UZjgiQCfaBTusy9PafW2kmj/YJKQ55gmpGOJ/P5S9GSZWHkoGgNnBQYZdpH8utYsSDEbF8peP3J/QYw/CKAPw9FU0IvSp5sOpFc7UwMXTdneZLLgC0PVE8MUAfODAim14EtaFG8VKuxhTm8znLjg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 3B9A118000A9; Sun, 15 Feb 2026 11:26:04 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 08/14] hvf: gate ARM_FEATURE_PMU register emulation behind
 not being at EL2
Date: Sun, 15 Feb 2026 12:25:37 +0100
Message-ID: <20260215112543.4817-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215112543.4817-1-mohamed@unpredictable.fr>
References: <20260215112543.4817-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tklFVbP83DU9ESml1z92Sc3Pjat3wCvM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDA5MiBTYWx0ZWRfX3XsvPkcjA4Cv
 JUlxI31OketMIuwbrSKYnH7SKwznZpgRUBtsyx29lNdsFH/sn9ItTW2j2vu8qra0SvBWlrZNrcK
 jKw2Zs937/AXMRZ15NmV7BUGHcm9SesbHMqQyuggLq/oi71GdH+2UiSnEggzlIzS/+RSLVD54rj
 fdiazZNAFrgq8v49LSnz5xtibEziSOgTnaSoeM9h+66LPIV7Xho5gbl6coIjL+ZMuSnSOPxIPZf
 ifKdGXHRmMRNaytw7HRqOr/jU3oAW+gcS5DY0JVr+jBXbTWEvNga5Ig6GyHxcTnd9I9xmSLZdIG
 uwkQooSshEy3baL1rkFEg1QXuZVepHMWNrZbpjqouCGI/h/IvaRwYTDw162NPk=
X-Authority-Info-Out: v=2.4 cv=S5jUAYsP c=1 sm=1 tr=0 ts=6991ad4f
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=lOv7bB1OiAV5i3s2B4UA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tklFVbP83DU9ESml1z92Sc3Pjat3wCvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=767 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150092
X-JNJ: AAAAAAABBV4kei/EHOY4u2HTaJHSYw5i1G3kt3ADo/YWt+YVLQ/4fCxrwrHZ3Vz9FqHuA7+qHgtjztW5CsxQ9rV0rE8FDRXY2miRv1FU/51+BQMlf+SuJ9cYlnApcSvY91DnOTRkn4Us5TyTBKShL/1e0r00EV17evGt/KglPzlWgGWvzLVjXT6gGcBxD4Lx6TzGv/1w+Xe9guM8myNPt/wRCAjSEg7z+30yH+zET+TemY2juOHheq/VJzRXpf+r8QLQKfb+P4kzAO7/BCNd2+jyjha7jDVL3o4qav3cNGE4WCNlbwtCqv5xN6CbIqlB0ajGA4GB3KdJt5K/bEyHKAEyaNReqnjEvQ2c+FTOdXz6JDcKP1sCu2b+1g5BbebU7sEAC/VIY74SMIQQnvUbitpY8bD7VKT1xQvdAaDU2ikUXplBq1GOFKmfdA0TU3OYqlWgcj2XqVxzkICoEdMaIkLdSiu/WLMUjgM0uIkbJjDz09IHXnjcaYxNPD+/7AJqj8HWFhJqWEhQZOu2P+lMpzvUt8yGJk7LaM/VazFgSEnsP8BLRi2SL/WORK85VS+W4A1tbA/giIJ0At8e2Xvfq4sP5+Ckge3Bocprle0wcKsgiAYO5wzVeB+CWQSdkxrnxzuQOgV9axkq3YwekONh/WEomAGTjfioNjOGpwPi+L/UcoyqZNIsfy5J8mm40gBdZ7arHoXN4LZqT6e065YRAlwZ29t/tFEu6mA=
Received-SPF: pass client-ip=57.103.68.8;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


