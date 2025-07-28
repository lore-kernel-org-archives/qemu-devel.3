Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2411AC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugO7S-0000Rr-F0; Mon, 28 Jul 2025 09:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugO6r-00056I-Kf
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:41:46 -0400
Received: from p-east3-cluster6-host1-snip4-5.eps.apple.com ([57.103.85.136]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugO6o-0004Jh-T6
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:41:45 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 B4E96180023D; Mon, 28 Jul 2025 13:41:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=J1nJyl6Z22NYU2tA6mRe99LaY8X3LBgdU2vPzRuLMcE=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:x-icloud-hme;
 b=fUEqUgB0BkpEE9H+cSyDlbPD3ZKh7vKDkoCe+OviyXxoZW4X/8D+7GosoW85XMAMz/EmAj0fJvrn8Pu/XLrm/3McL/+0hfuRXJAmjA5HRhoIfvqcKdoP6d601ukoE1C/ktWutSJ6S5w8L5K8y/y9Xtbs1XbpdtPuVld/h+lI7fOg29ZsfaQkbTpNUiJTG5W1il97vpD4WTXLiQzXTv63p0opOCQRcE4QKcVNMXc2ZDbgriJHQdQXcAQ990OTMLequs0KDvDhKdLd1kqOH/gB1/yT5Jaa+BApXH/UyAlmEp41/qHnKGKERFmDS3JK3iAR6IoNNS0OksnjrmNh1Y7nog==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 7D57118000AA; Mon, 28 Jul 2025 13:41:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v5 11/13] hvf: gate ARM_FEATURE_PMU register emulation behind
 not being at EL2
Date: Mon, 28 Jul 2025 15:41:12 +0200
Message-Id: <20250728134114.77545-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250728134114.77545-1-mohamed@unpredictable.fr>
References: <20250728134114.77545-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEwMSBTYWx0ZWRfX4FpretWVjPQd
 YjgZEI8yjbJnAt6eqNpvrTy6j6P0Ob3m2rO/UFsAFoe+LTfpHmyGViNPeNSABEn1SPpjZy09Kz7
 UnYldOhZ6ZFpciOdMsSfq0SjkM+R8FvUkf5quNA3GroWjC7qJNpso95xqGEQyywSXLXQI6tclHB
 12rs+BC/L6zJg/GUkdCIqxres0D7WvsJM1yrw41gkyoWXWIG2ximuMMTnvumH7E1ip6nDq8688N
 Ty6Th8jwQR20D3hCfGXNg3bnl5JEkgVDmXTgE5i0VGusLWGTRIZ1/oncI2g0KXU9o+dj8BAOo=
X-Proofpoint-GUID: vF3sOsrB9ORjJmIqU01mq9Av2tXvxBn3
X-Proofpoint-ORIG-GUID: vF3sOsrB9ORjJmIqU01mq9Av2tXvxBn3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=766
 bulkscore=0 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507280101
Received-SPF: pass client-ip=57.103.85.136;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a1e928ddfa..f70870fb62 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1379,7 +1379,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_arm_el2_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCR_EL0:
             *val = env->cp15.c9_pmcr;
@@ -1676,7 +1676,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                            SYSREG_OP2(reg),
                            val);
 
-    if (arm_feature(env, ARM_FEATURE_PMU)) {
+    if (!hvf_arm_el2_enabled() && arm_feature(env, ARM_FEATURE_PMU)) {
         switch (reg) {
         case SYSREG_PMCCNTR_EL0:
             pmu_op_start(env);
-- 
2.39.5 (Apple Git-154)


