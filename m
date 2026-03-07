Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D58F5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytdW-0001Bw-Cv; Sat, 07 Mar 2026 10:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdS-00019Q-1U
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:10 -0500
Received: from p-west2-cluster5-host7-snip4-10.eps.apple.com ([57.103.71.73]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytdQ-0000Oz-G9
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:32:09 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 82FC01800168; Sat,  7 Mar 2026 15:32:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772897526; x=1775489526;
 bh=E/LouNoMQ4W/aKzwh/YIr4xZ/85njeY6sAjm9F1tdWU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=e3wRwCztfIimOEyU/6jNuMxrtvcz5+EKjSe61MhxQ7OzAty6W0tkmpAX6fuHl1lQRc1Q+NlTPA4sBLXgOVM46frIMBZCbdHsD+ECwFt3HSawueLZS2+7cE3Se/6NOuKTzlvWg+NhKXoy1xmqtkiS9X3bOc8nr06hpBOjJC1mMx8wnSCousohFrRN+RpkTi0PC2SALmJhaH5xIEAXDEKk+OUIwWE80WAQw5RbjVdzu+PThU7Ke7lkHIXxfiIj7v5yoQM9/YRP8cd+Os1hhapEc9xFAmkMYRViXL8vwTLGGGI71Q6gGUcYw7eZuz0u7dN9CTsJ69S9UHg9vP4wp+eMMg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 0F1C61800869; Sat,  7 Mar 2026 15:32:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v18 07/13] hvf: gate ARM_FEATURE_PMU register emulation behind
 not being at EL2
Date: Sat,  7 Mar 2026 16:31:37 +0100
Message-ID: <20260307153143.76893-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307153143.76893-1-mohamed@unpredictable.fr>
References: <20260307153143.76893-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o605RbihFRAFabpCLfoQRDY8clryCpIf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0NyBTYWx0ZWRfX0JJTAfyX6lJW
 57ZNVJozyrmOvzbx3EDTLxzUxcg8JOgdrtSrMSk7t8KAruB3A/UAd+yqkxwkwr/w5LZzb6ITsAO
 o6YXrqWndjVXI4GYEPFNhwANRk+QFNk/ibNPma+A8b5FHb55DkriUfkEGc6WiLh+oECERPiol+K
 pB0UmKqIKl9F/1rIGp/Zi4PXrta/8vpvnfzR+xRNvZQxLKFVOX2Amsr1LPQubooNYcaUFtfq3lg
 XhyMRPJqsNXfEPRxGUq6iP3rew+YdU2fufdME5++2+7rTJPCfaw6f7K5ode7qRWAw3cQkLmgvF7
 p/AoaEhTW+y9vBGBXjhrXTcE+rqu5t8vu/X6RniTYC0r5tnUFlc5MPK0J+hgB4=
X-Authority-Info-Out: v=2.4 cv=RKC+3oi+ c=1 sm=1 tr=0 ts=69ac44f6
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=lOv7bB1OiAV5i3s2B4UA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: o605RbihFRAFabpCLfoQRDY8clryCpIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0
 mlxlogscore=683 bulkscore=0 adultscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070147
X-JNJ: AAAAAAABlnILBYlXhJw6ayq2b2CufoOrh+kdUHyoAHrRB4kmCuLRH6XAl1/A7BYHCP+bkKCtWFxogCWcclA43V1qfsYNo8Pw4x4HMpkoSY77L4LqxhQqQnZq00dNMaY15ebrB/vaWjs3lL1Lt5dEBH2BUQMt9NADZWD2jYfxmZftyNeARs/nwABIqfw1k0Kdzm6rEeykalcyHuPy1c3KAwOq8xqeJvqXNDiAmHyPh7JGmlosmtcA+am22GsMQ2vXgPH4A+AtYUGWciqwgaZdtSom0FmABNX7J46QfW091p+10FE5VGOWVXrY8usBPOcQbk/ao5ITNdKs0Z7Q0s1mYlujII1ITsSstnfnvMdBuNhXP0kUJcN2y2f+e9ctYUbxFcMb8dlY2Ve533yR4KxR5diZg2D5dndSrIexcROAnfs3iJlx/yq0/kxe2V0VN9gNWiGUNVLNyt7sKSVBlabTd9BC3qRIVWT0MnSV/S84M2WEds7femHXOJKV1AaGY2yI/DNwBZMhlnZ34MbwbfN2aIA1OhQm3Qs1LezMjEANg9E7lH3+byllALDa4T49vXds9OyqMJK80MkoGVNwjQV+UIo2uBS5jctY0MQgViRVi+Gw+C1xIfJn0OBp3QEuSVAG+SQA48nEz1uEWYK/JSFSKoJ6gqBb65Eb8OIzgQs2GFTsBOpF7WHlYMVHFHPwzswazq8RdocDjKlEC8oesrZm2thYonokANN4kzdICLtgexun8AnxPWesOi+/hys=
Received-SPF: pass client-ip=57.103.71.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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


