Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE460F01811
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQc4-00088F-UA; Fri, 06 Mar 2026 03:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQbF-0007Ia-He
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:32:02 -0500
Received: from p-west2-cluster1-host6-snip4-8.eps.apple.com ([57.103.68.61]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQbA-0002V1-H1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:31:55 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 099E318003D5; Fri,  6 Mar 2026 08:31:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772785910; x=1775377910;
 bh=qAVaZtJuZJH9uX/VVXHmkmsjUQo1XpfNBC4AOqSB4uA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=djNWRKHxGpAxxOiagKi2Ki/+7HRCv2XmwoZGTolm8d3qO9smSjESO/WM76s1GieJTi7+pTsiO7MyelK+r2loqqb8jauhhQlegkXTUY4ulpncaIX5tkDzsvFI9RUr0hHPdwWH/A0kzc6AVa+n7ZaGqUl+zHLbY29xF17UYOeUIE7k360Z/I58NwwjaqYFq2DCJcHYIENpOv3fHrgkTjeIYm+K5WlOm3pQQtv9ct+ECom0jYiWpVkBXR8bgTrOzE8zhgyBjhNHj1KuQLXFS6C9abdO//o6EQZLVBChNZZZU6v29XguWjFn4QNq2mUberbHZ2/x8y7aQELd889FAF2WLA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 85EF4180017F; Fri,  6 Mar 2026 08:31:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v14 12/19] hvf: gate ARM_FEATURE_PMU register emulation behind
 not being at EL2
Date: Fri,  6 Mar 2026 09:31:06 +0100
Message-ID: <20260306083113.74177-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306083113.74177-1-mohamed@unpredictable.fr>
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: icv7C07zI6mxDn2gckBzczZB2Rb02MVF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MCBTYWx0ZWRfXyHQlkDndSvFP
 B5Nz7S3prwhhktc+iyuZGVO4pmyv+gryBf4lqx/mhrXmZyR02ePQdXUov2AZPMve+acOAr2L62V
 Utn/OPXRxSrFW6nB2ZeqyL+hlxNFtB1Mm88DWtCGYpxzPr0nxmcmciPbizX2DLSdpTiwd5zdX43
 S8rlB0hl480WQLaKiKkkdVPAOrQLlh8vi2fyhJH4gyTLU0ARJSc6BehWsnYw+WkxcO8UWn+eSTk
 pGVHQC4u5c8VstZMJ4ssF1kHNwNzpPyT5qnBM78HF6OJfSq+TE7jSXlamkXacVDU74vXutvX863
 p1Rh6znOCaewCKFCtD9x5byWoNCqC1rOpMBW1JOwh34AXTuYtC3MEGlTyda+xA=
X-Authority-Info-Out: v=2.4 cv=KqNAGGWN c=1 sm=1 tr=0 ts=69aa90f6
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=lOv7bB1OiAV5i3s2B4UA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: icv7C07zI6mxDn2gckBzczZB2Rb02MVF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxlogscore=774 clxscore=1030 mlxscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060080
X-JNJ: AAAAAAABOc6v6Oh04apLmn6SV7nGmXpJz3IdrysvjjHQrwftAZsNvMMYfzF/tqwPcNaklUfpw8Iuh/9YohanVjt9IslT0jL5yCADqo2ceWIaw5qToLcs2VFqpTdSmYscoZ3Vj4qmKvJp/kzc8nZy+zR5ps7e/l/JcMHjR1quA0g5GoQFfKpKFdb8Vbode4qKlOD67ZRs0gwX/lAtAdJ/Jv+2fqMR6ykd7Lm/BdhgQeMcMDpml37uaDsOSgEiYdLcviq68IZE+Kn0lz0t01GiX7ug53uPXUcfwH+6e2rqYkJNHFehqDo9CM1lVHF6fh7zITK30sXpQZrRlIijEVBq9/zdiOYuhcu9xv9VvOTNIoYNdhI89eIu5CIcZSNv9LQOyjgh4kOa9HjSieEGc5tGV2bNfDuV4jGjnXJtVwcKIjuDERpvB9Gj/jDlfe/i30zBqbmuRHm1tGwsrolgVsCCtc+dHpCdKM3Zwi5x4Qd+6/JUZWdwNt3rTe02Izit423oF5X1T08YwJsw6vsi7A5tm3hdnsCuUe+La5ahHNNxDaxU0/CII4DC+gZk6aYFUAnT7OXmX+vDZEwsKurksyqj3yA2SnIIQ4kTe2OO2t28Z27Ynx/pXl5oryNuTt+OqCIqrTPLEcExVULaZOMcGNWGekFE9vj3zds4mc1L+YWSWJe+JbjDLcv+Fwp7OOI5/k2KZjvb/GRGFdaTnme9G4s4yWgrEZ1pUjtA926UXFvSgNvkRYDPgxlcMwo7Ddo8Vg2rqdqKE8JDlXiv7sHEvpTaBGY=
Received-SPF: pass client-ip=57.103.68.61;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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
index 047b3601c9..da6b548880 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1567,7 +1567,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCR_EL0:
             *val = env->cp15.c9_pmcr;
@@ -1828,7 +1828,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                            SYSREG_OP2(reg),
                            val);
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_nested_virt_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCCNTR_EL0:
             pmu_op_start(env);
-- 
2.50.1 (Apple Git-155)


