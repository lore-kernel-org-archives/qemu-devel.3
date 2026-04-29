Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BFDCCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAEa-0001ne-5w; Wed, 29 Apr 2026 15:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEY-0001mu-Pi
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:06 -0400
Received: from p-west3-cluster3-host8-snip4-10.eps.apple.com ([57.103.72.211]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEU-0000NP-AY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:06:06 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPS id
 BBDC718000C5; Wed, 29 Apr 2026 19:05:58 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJB01fDl4fBBdGGVUERx5dVl4eGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCAEkKXQJYAF4LTgZeD0YKXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777489561; x=1780081561;
 bh=okJ5cnEaqKHvGtSWn7uQC28UhrgcqlO+u8jRZ447zdE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=VgAXrGmd1RTg8i3p3hCpPBig9F502cQ/mJZB2JYBCI+ja2OIwaOFlfF+rnJwEDgTnmYky3bIBQC4+N/kjn7XN2PZfbZ46KzvEscj+xWzvgLm2W/S7GhQq9y9BRwpI7Fo3oE4qgPz3APP2Oc2pNJl0mc97vydaqX3XZP7dWv2o5CWOFUxp4kp3S0LZf+XMxf+v4/9jUxZvrofdjyXgMmi2q8GAnfGO3ernimcxiLAZsOKdbaKSkcnnWf5uY4L/XylxB6pfoWBdDDyk+BIlzavqgqTeKOzFtluUo+wn+pFTsWgt6TAYIPZHUv02zlaW/XunrXgtYeGY2rBrjqAL1rymA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPSA id
 A0DBA18002E8; Wed, 29 Apr 2026 19:05:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v21 07/15] hvf: gate ARM_FEATURE_PMU register emulation when
 using the Apple vGIC
Date: Wed, 29 Apr 2026 21:05:24 +0200
Message-ID: <20260429190532.26538-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429190532.26538-1-mohamed@unpredictable.fr>
References: <20260429190532.26538-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=bcFmkePB c=1 sm=1 tr=0 ts=69f25698
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=TzKBU_9rahY9vEVlUJ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE5MCBTYWx0ZWRfX+BvahotabncE
 lBg+pkYd+AW5Rzfmt63auj8IxV5kcXijmSMigjf5w7ihkwSusAJGrl0yuZzQWkWfdNUgOIzI/0U
 GBvJMfUuFCaqaVqfk1aFzFIreMTnaNKQsck+OQPXGGxlbGjDxiZzFZui0qdrZcY2LJJihi3VAk+
 p18Z4k9gMCux3ym2TpcAt6odOvZDSgwcYUQP6pG95FcxilQ47mlObd9xnI4XOpBQPjQSN8aQqL2
 PurW2yL2uGZwIP+HD4HobxH7anyN6izH2YgbdKpgKckPlCH5+xdQow4pPCt3KzvP79VIi/wWEA+
 R856341yxTFhJS/YgHANn/GpxiOv3QjTrJBDRfyxYm69ZsqrVQsti8yld8f8O4=
X-Proofpoint-GUID: P_1tUE1L_zcqw_geOAwAWCtloDsnZgfZ
X-Proofpoint-ORIG-GUID: P_1tUE1L_zcqw_geOAwAWCtloDsnZgfZ
Received-SPF: pass client-ip=57.103.72.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

However, despite what that documentation says this is actually gated on using the Apple vGIC
instead of nested virtualisation per se. Apple introduced both at the same time.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index fa0a22fdc3..9d64f2e1a5 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1601,7 +1601,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_irqchip_in_kernel() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCR_EL0:
             *val = env->cp15.c9_pmcr;
@@ -1862,7 +1862,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                            SYSREG_OP2(reg),
                            val);
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_irqchip_in_kernel() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCCNTR_EL0:
             pmu_op_start(env);
-- 
2.50.1 (Apple Git-155)


