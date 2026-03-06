Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C106BFCB61D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXpq-00044f-8Y; Fri, 06 Mar 2026 11:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXpm-00042b-8g
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:26 -0500
Received: from p-west3-cluster1-host1-snip4-5.eps.apple.com ([57.103.73.136]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXpi-000744-9L
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:24 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 E317918007AA; Fri,  6 Mar 2026 16:15:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772813720; x=1775405720;
 bh=8cYPzfT79hzawhax/U0Dq4YWRUe35ck31xEEzB7qIbI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LC/7LAydiWLq1d/v9RBzpYXZly846TQaD88WSnaeoRmbhwZ0aplSe34SmCNcUEfO/Z9bKvX6dCemGqSgmDs9TjZUDWtg9gKYkh6p9ifpj5Sc4ZkOQHDCbDiK8ubEE95oCa1e48JyXguDqR2IezcNcv/ThAjpSDurQYOnwQiiD8t2RPF6eNyS3rZwyB5PPtYmm3WWrtcVyIvoCAqoDyhGH9Ahbm8D/PFrAy945wVgKbmvaQeSaRKFndr5EocuZBSW4LReSRNAqn+phPU+yeoE26HSirci7gqmD3Hcba5AJ54RXGaZqkbooJhTd3/12AxLEtUtXerFQ0uw+fqhkCvoYg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 20CA818007A1; Fri,  6 Mar 2026 16:15:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v16 01/17] hvf/arm: handle FEAT_SME2 migration
Date: Fri,  6 Mar 2026 17:14:53 +0100
Message-ID: <20260306161509.79712-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306161509.79712-1-mohamed@unpredictable.fr>
References: <20260306161509.79712-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fABST7ofA2SqHggr-w214vnQE84mJyC-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NCBTYWx0ZWRfX4SSEaUK6D73U
 Usu2Cn+/Ka3EF4HlnxOMiOhvQgsQ62avlOyIlX7JU6AlfOLaou/wmvVUSYjiGA37lhxQpvCbbnn
 R1doUEJShBztiRKO+HFqFWo+u1Afm5GoXRMrTGTYWB3ZM/JUnl7ybuZa+73NQgxFp7g8LgyJwnK
 zS01nnHCrIvzZL/d8DmsFb+fyyZfd6X6ck1k4koKh6Nv0vQ115A2OYTFuJkN/rTcKLaVvHlssBf
 SNMOEz0/NORHocQeLntB0lY5XOfEG0Z9DdBhV3Kt2IG4XDVurZJ4v621Ct3dONWLxUvVaUYNkC5
 ns1+vFyDzLQD2zLgId/fVZUNOzykn9ldYtQ7HE+A0BLGWX+SGwqSx4OLcZahBU=
X-Authority-Info-Out: v=2.4 cv=DrpbOW/+ c=1 sm=1 tr=0 ts=69aafd96
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=FwCt1zJGaJMg4q4ZpKQA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: fABST7ofA2SqHggr-w214vnQE84mJyC-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1030
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060154
X-JNJ: AAAAAAABfDPucK8Bw+TDfDg2ztKb/KSypq2pmZoPhh+Zr/34Ln29r9cWFXa9n2EZPitSn3aqQAly/HHoXHvqUqG8cXqV1QzUuQ1bq0fMqyh9vrIS0mSbvq2DRGLJhi5mZ5lxp/gsLXm0Qx9r/aYzAXtG995J3wrk53Yh0ufn228PK0S0BhiU7m2R2kZ97WgiMpRgvnASzwy+XXg+OHu6vethUxgnT99vo6kpFmzttMIkOVBJoihzCldF4QUsrmE3E9Yl3f1cWmpjvRNyYhvQIUzF6IH/aa8sKMIkaDJJ+IHxtJPDH9m4kE/vKnxhRJbCYncQrUr//+oFjTntAsNoYupF8dlZhpBMAeJCCoTqNRH1jeviTdbM42kDLgJajJngUdO/DMYtRnbnZ3YIkwdNJeZDGAAdKrHX9f2/5UYs2WRTIuvVq5BiCDrSYhVKI1QPr4B2dzImw1XNY1Ge8e78xNdk9NSOxW9LQnMxBpzmeDDMDUgevy5euN14vidX57Px7RpY3RQlUfmceKjjEiQT7VKESyBLzmBNT60GxcdpHqMkVMSui5GaZ+BUNlYjUUTq0RoBvu4ewC1zbcWyh3bkevHzeCvxwC/HsE5NjU6XqaNM0J45Txa4wJ5aiiXCRwWUpXsBdlrFUB5ezT21XL5i5bHSt1lnHyNfbC5/KzzUGadsTU1kdbPH4fIZdIja0bZ7Y0t8bHsLm+10yW/JRVs8aRdVHzBmXv3s5l73/luwdtD0LmC+oO6L/h9ajzHQ4sbaXQ==
Received-SPF: pass client-ip=57.103.73.136;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

SME2 support adds the following state for HVF guests:

- Vector registers Z0, ... , Z31 (introduced by FEAT_SVE but HVF does
  not support it)
- Predicate registers P0, .., P15 (also FEAT_SVE)
- ZA register
- ZT0 register
- PSTATE.{SM,ZA} bits (SVCR pseudo-register)
- SMPRI_EL1 which handles the PE's priority in the SMCU
- TPIDR2_EL0 the thread local ID register for SME

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20260306-sme2-hvf-v7-1-e72eeda41ed3@linaro.org>

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c           | 298 ++++++++++++++++++++++++++++++++-
 target/arm/hvf/hvf_sme_stubs.h | 172 +++++++++++++++++++
 target/arm/hvf/sysreg.c.inc    |   8 +
 target/arm/hvf_arm.h           |  41 +++++
 target/arm/machine.c           |   2 +-
 5 files changed, 518 insertions(+), 3 deletions(-)
 create mode 100644 target/arm/hvf/hvf_sme_stubs.h

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d79469ca27..21b16dfe42 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -395,6 +395,60 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
     { HV_SIMD_FP_REG_Q31, offsetof(CPUARMState, vfp.zregs[31]) },
 };
 
+static const struct hvf_reg_match hvf_sme2_zreg_match[] = {
+    { HV_SME_Z_REG_0, offsetof(CPUARMState, vfp.zregs[0]) },
+    { HV_SME_Z_REG_1, offsetof(CPUARMState, vfp.zregs[1]) },
+    { HV_SME_Z_REG_2, offsetof(CPUARMState, vfp.zregs[2]) },
+    { HV_SME_Z_REG_3, offsetof(CPUARMState, vfp.zregs[3]) },
+    { HV_SME_Z_REG_4, offsetof(CPUARMState, vfp.zregs[4]) },
+    { HV_SME_Z_REG_5, offsetof(CPUARMState, vfp.zregs[5]) },
+    { HV_SME_Z_REG_6, offsetof(CPUARMState, vfp.zregs[6]) },
+    { HV_SME_Z_REG_7, offsetof(CPUARMState, vfp.zregs[7]) },
+    { HV_SME_Z_REG_8, offsetof(CPUARMState, vfp.zregs[8]) },
+    { HV_SME_Z_REG_9, offsetof(CPUARMState, vfp.zregs[9]) },
+    { HV_SME_Z_REG_10, offsetof(CPUARMState, vfp.zregs[10]) },
+    { HV_SME_Z_REG_11, offsetof(CPUARMState, vfp.zregs[11]) },
+    { HV_SME_Z_REG_12, offsetof(CPUARMState, vfp.zregs[12]) },
+    { HV_SME_Z_REG_13, offsetof(CPUARMState, vfp.zregs[13]) },
+    { HV_SME_Z_REG_14, offsetof(CPUARMState, vfp.zregs[14]) },
+    { HV_SME_Z_REG_15, offsetof(CPUARMState, vfp.zregs[15]) },
+    { HV_SME_Z_REG_16, offsetof(CPUARMState, vfp.zregs[16]) },
+    { HV_SME_Z_REG_17, offsetof(CPUARMState, vfp.zregs[17]) },
+    { HV_SME_Z_REG_18, offsetof(CPUARMState, vfp.zregs[18]) },
+    { HV_SME_Z_REG_19, offsetof(CPUARMState, vfp.zregs[19]) },
+    { HV_SME_Z_REG_20, offsetof(CPUARMState, vfp.zregs[20]) },
+    { HV_SME_Z_REG_21, offsetof(CPUARMState, vfp.zregs[21]) },
+    { HV_SME_Z_REG_22, offsetof(CPUARMState, vfp.zregs[22]) },
+    { HV_SME_Z_REG_23, offsetof(CPUARMState, vfp.zregs[23]) },
+    { HV_SME_Z_REG_24, offsetof(CPUARMState, vfp.zregs[24]) },
+    { HV_SME_Z_REG_25, offsetof(CPUARMState, vfp.zregs[25]) },
+    { HV_SME_Z_REG_26, offsetof(CPUARMState, vfp.zregs[26]) },
+    { HV_SME_Z_REG_27, offsetof(CPUARMState, vfp.zregs[27]) },
+    { HV_SME_Z_REG_28, offsetof(CPUARMState, vfp.zregs[28]) },
+    { HV_SME_Z_REG_29, offsetof(CPUARMState, vfp.zregs[29]) },
+    { HV_SME_Z_REG_30, offsetof(CPUARMState, vfp.zregs[30]) },
+    { HV_SME_Z_REG_31, offsetof(CPUARMState, vfp.zregs[31]) },
+};
+
+static const struct hvf_reg_match hvf_sme2_preg_match[] = {
+    { HV_SME_P_REG_0, offsetof(CPUARMState, vfp.pregs[0]) },
+    { HV_SME_P_REG_1, offsetof(CPUARMState, vfp.pregs[1]) },
+    { HV_SME_P_REG_2, offsetof(CPUARMState, vfp.pregs[2]) },
+    { HV_SME_P_REG_3, offsetof(CPUARMState, vfp.pregs[3]) },
+    { HV_SME_P_REG_4, offsetof(CPUARMState, vfp.pregs[4]) },
+    { HV_SME_P_REG_5, offsetof(CPUARMState, vfp.pregs[5]) },
+    { HV_SME_P_REG_6, offsetof(CPUARMState, vfp.pregs[6]) },
+    { HV_SME_P_REG_7, offsetof(CPUARMState, vfp.pregs[7]) },
+    { HV_SME_P_REG_8, offsetof(CPUARMState, vfp.pregs[8]) },
+    { HV_SME_P_REG_9, offsetof(CPUARMState, vfp.pregs[9]) },
+    { HV_SME_P_REG_10, offsetof(CPUARMState, vfp.pregs[10]) },
+    { HV_SME_P_REG_11, offsetof(CPUARMState, vfp.pregs[11]) },
+    { HV_SME_P_REG_12, offsetof(CPUARMState, vfp.pregs[12]) },
+    { HV_SME_P_REG_13, offsetof(CPUARMState, vfp.pregs[13]) },
+    { HV_SME_P_REG_14, offsetof(CPUARMState, vfp.pregs[14]) },
+    { HV_SME_P_REG_15, offsetof(CPUARMState, vfp.pregs[15]) },
+};
+
 /*
  * QEMU uses KVM system register ids in the migration format.
  * Conveniently, HVF uses the same encoding of the op* and cr* parameters
@@ -406,22 +460,201 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
 #define HVF_TO_KVMID(HVF)  \
     (CP_REG_ARM64 | CP_REG_SIZE_U64 | CP_REG_ARM64_SYSREG | (HVF))
 
-/* Verify this at compile-time. */
+/*
+ * Verify this at compile-time.
+ *
+ * SME2 registers are guarded by a runtime availability attribute instead of a
+ * compile-time def, so verify those at runtime in hvf_arch_init_vcpu() below.
+ */
 
 #define DEF_SYSREG(HVF_ID, ...) \
   QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
+#define DEF_SYSREG_15_02(...)
 
 #include "sysreg.c.inc"
 
 #undef DEF_SYSREG
+#undef DEF_SYSREG_15_02
 
 #define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  HVF_ID,
+#define DEF_SYSREG_15_02(...)
 
 static const hv_sys_reg_t hvf_sreg_list[] = {
 #include "sysreg.c.inc"
 };
 
 #undef DEF_SYSREG
+#undef DEF_SYSREG_15_02
+
+#define DEF_SYSREG(...)
+#define DEF_SYSREG_15_02(HVF_ID, op0, op1, crn, crm, op2) HVF_ID,
+
+API_AVAILABLE(macos(15.2))
+static const hv_sys_reg_t hvf_sreg_list_sme2[] = {
+#include "sysreg.c.inc"
+};
+
+#undef DEF_SYSREG
+#undef DEF_SYSREG_15_02
+
+/*
+ * For FEAT_SME2 migration, we need to store PSTATE.{SM,ZA} bits which are
+ * accessible with the SVCR pseudo-register. However, in the HVF API this is
+ * not exposed as a system-register (i.e. HVF_SYS_REG_SVCR) but a custom
+ * struct, hv_vcpu_sme_state_t. So we need to define our own KVMID in order to
+ * store it in cpreg_values and make it migrateable.
+ */
+#define SVCR KVMID_AA64_SYS_REG64(3, 3, 4, 2, 2)
+
+API_AVAILABLE(macos(15.2))
+static void hvf_arch_put_sme(CPUState *cpu)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    const size_t svl_bytes = hvf_arm_sme2_get_svl();
+    const size_t z_size = svl_bytes;
+    const size_t preg_size = DIV_ROUND_UP(z_size, 8);
+    const size_t za_size = svl_bytes * svl_bytes;
+    hv_vcpu_sme_state_t sme_state = { 0 };
+    hv_return_t ret;
+    uint64_t svcr;
+    int n;
+
+    /*
+     * Set PSTATE.{SM,ZA} bits
+     */
+    svcr = arm_cpu->cpreg_values[arm_cpu->cpreg_array_len - 1];
+    env->svcr = svcr;
+
+    /*
+     * Construct SVCR (PSTATE.{SM,ZA}) state to pass to HVF:
+     */
+    sme_state.streaming_sve_mode_enabled = FIELD_EX64(env->svcr, SVCR, SM) > 0;
+    sme_state.za_storage_enabled = FIELD_EX64(env->svcr, SVCR, ZA) > 0;
+    ret = hv_vcpu_set_sme_state(cpu->accel->fd, &sme_state);
+    assert_hvf_ok(ret);
+
+    /*
+     * We only care about Z/P registers if we're in streaming SVE mode, i.e.
+     * PSTATE.SM is set, because only then can instructions that access them be
+     * used. We don't care about the register values otherwise. This is because
+     * when the processing unit exits/enters this mode, it zeroes out those
+     * registers.
+     */
+    if (sme_state.streaming_sve_mode_enabled) {
+        for (n = 0; n < ARRAY_SIZE(hvf_sme2_zreg_match); ++n) {
+            ret = hv_vcpu_set_sme_z_reg(cpu->accel->fd,
+                                        hvf_sme2_zreg_match[n].reg,
+                                        (uint8_t *)&env->vfp.zregs[n].d[0],
+                                        z_size);
+            assert_hvf_ok(ret);
+        }
+
+        for (n = 0; n < ARRAY_SIZE(hvf_sme2_preg_match); ++n) {
+            ret = hv_vcpu_set_sme_p_reg(cpu->accel->fd,
+                                        hvf_sme2_preg_match[n].reg,
+                                        (uint8_t *)&env->vfp.pregs[n].p[0],
+                                        preg_size);
+            assert_hvf_ok(ret);
+        }
+    }
+
+    /*
+     * If PSTATE.ZA bit is set then ZA and ZT0 are valid, otherwise they are
+     * zeroed out.
+     */
+    if (sme_state.za_storage_enabled) {
+        hv_sme_zt0_uchar64_t tmp = { 0 };
+
+        memcpy(&tmp, &env->za_state.zt0, 64);
+        ret = hv_vcpu_set_sme_zt0_reg(cpu->accel->fd, &tmp);
+        assert_hvf_ok(ret);
+
+        ret = hv_vcpu_set_sme_za_reg(cpu->accel->fd,
+                                     (uint8_t *)&env->za_state.za,
+                                     za_size);
+        assert_hvf_ok(ret);
+    }
+
+    return;
+}
+
+API_AVAILABLE(macos(15.2))
+static void hvf_arch_get_sme(CPUState *cpu)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    const size_t svl_bytes = hvf_arm_sme2_get_svl();
+    const size_t z_size = svl_bytes;
+    const size_t preg_size = DIV_ROUND_UP(z_size, 8);
+    const size_t za_size = svl_bytes * svl_bytes;
+    hv_vcpu_sme_state_t sme_state = { 0 };
+    hv_return_t ret;
+    uint64_t svcr;
+    int n;
+
+    /*
+     * Get SVCR (PSTATE.{SM,ZA}) state from HVF:
+     */
+    ret = hv_vcpu_get_sme_state(cpu->accel->fd, &sme_state);
+    assert_hvf_ok(ret);
+
+    /*
+     * Set SVCR first because changing it will zero out Z/P regs
+     */
+    svcr =
+        (sme_state.za_storage_enabled ? R_SVCR_ZA_MASK : 0)
+        | (sme_state.streaming_sve_mode_enabled ? R_SVCR_SM_MASK : 0);
+
+    aarch64_set_svcr(env, svcr, R_SVCR_ZA_MASK | R_SVCR_SM_MASK);
+    arm_cpu->cpreg_values[arm_cpu->cpreg_array_len - 1] = svcr;
+
+    /*
+     * We only care about Z/P registers if we're in streaming SVE mode, i.e.
+     * PSTATE.SM is set, because only then can instructions that access them be
+     * used. We don't care about the register values otherwise. This is because
+     * when the processing unit exits/enters this mode, it zeroes out those
+     * registers.
+     */
+    if (sme_state.streaming_sve_mode_enabled) {
+        for (n = 0; n < ARRAY_SIZE(hvf_sme2_zreg_match); ++n) {
+            ret = hv_vcpu_get_sme_z_reg(cpu->accel->fd,
+                                        hvf_sme2_zreg_match[n].reg,
+                                        (uint8_t *)&env->vfp.zregs[n].d[0],
+                                        z_size);
+            assert_hvf_ok(ret);
+        }
+
+        for (n = 0; n < ARRAY_SIZE(hvf_sme2_preg_match); ++n) {
+            ret = hv_vcpu_get_sme_p_reg(cpu->accel->fd,
+                                        hvf_sme2_preg_match[n].reg,
+                                        (uint8_t *)&env->vfp.pregs[n].p[0],
+                                        preg_size);
+            assert_hvf_ok(ret);
+        }
+    }
+
+    /*
+     * If PSTATE.ZA bit is set then ZA and ZT0 are valid, otherwise they are
+     * zeroed out.
+     */
+    if (sme_state.za_storage_enabled) {
+        hv_sme_zt0_uchar64_t tmp = { 0 };
+
+        /* Get ZT0 in a tmp vector, and then copy it to env.za_state.zt0 */
+        ret = hv_vcpu_get_sme_zt0_reg(cpu->accel->fd, &tmp);
+        assert_hvf_ok(ret);
+
+        memcpy(&env->za_state.zt0, &tmp, 64);
+        ret = hv_vcpu_get_sme_za_reg(cpu->accel->fd,
+                                     (uint8_t *)&env->za_state.za,
+                                     za_size);
+        assert_hvf_ok(ret);
+
+    }
+
+    return;
+}
 
 static uint32_t hvf_reg2cp_reg(uint32_t reg)
 {
@@ -534,6 +767,10 @@ int hvf_arch_get_registers(CPUState *cpu)
         uint64_t kvm_id = arm_cpu->cpreg_indexes[i];
         int hvf_id = KVMID_TO_HVF(kvm_id);
 
+        if (kvm_id == HVF_TO_KVMID(SVCR)) {
+            continue;
+        }
+
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
             switch (hvf_id) {
@@ -627,6 +864,13 @@ int hvf_arch_get_registers(CPUState *cpu)
 
         arm_cpu->cpreg_values[i] = val;
     }
+    if (cpu_isar_feature(aa64_sme, arm_cpu)) {
+        if (__builtin_available(macOS 15.2, *)) {
+            hvf_arch_get_sme(cpu);
+        } else {
+            g_assert_not_reached();
+        }
+    }
     assert(write_list_to_cpustate(arm_cpu));
 
     aarch64_restore_sp(env, arm_current_el(env));
@@ -643,6 +887,18 @@ int hvf_arch_put_registers(CPUState *cpu)
     hv_simd_fp_uchar16_t fpval;
     int i, n;
 
+    /*
+     * Set SVCR first because changing it will zero out Z/P (including NEON)
+     * regs
+     */
+    if (cpu_isar_feature(aa64_sme, arm_cpu)) {
+        if (__builtin_available(macOS 15.2, *)) {
+            hvf_arch_put_sme(cpu);
+        } else {
+            g_assert_not_reached();
+        }
+    }
+
     for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
         val = *(uint64_t *)((void *)env + hvf_reg_match[i].offset);
         ret = hv_vcpu_set_reg(cpu->accel->fd, hvf_reg_match[i].reg, val);
@@ -672,6 +928,10 @@ int hvf_arch_put_registers(CPUState *cpu)
         uint64_t kvm_id = arm_cpu->cpreg_indexes[i];
         int hvf_id = KVMID_TO_HVF(kvm_id);
 
+        if (kvm_id == HVF_TO_KVMID(SVCR)) {
+            continue;
+        }
+
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
             switch (hvf_id) {
@@ -985,6 +1245,20 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     hv_return_t ret;
     int i;
 
+    if (__builtin_available(macOS 15.2, *)) {
+        if (hvf_arm_sme2_supported()) {
+            sregs_match_len += ARRAY_SIZE(hvf_sreg_list_sme2) + 1;
+        }
+
+#define DEF_SYSREG_15_02(HVF_ID, ...) \
+        g_assert(HVF_ID == KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
+#define DEF_SYSREG(...)
+
+#include "sysreg.c.inc"
+
+#undef DEF_SYSREG
+#undef DEF_SYSREG_15_02
+    }
     env->aarch64 = true;
 
     /* system count frequency sanity check */
@@ -1005,7 +1279,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t));
 
     /* Populate cp list for all known sysregs */
-    for (i = 0; i < sregs_match_len; i++) {
+    for (i = 0; i < ARRAY_SIZE(hvf_sreg_list); i++) {
         hv_sys_reg_t hvf_id = hvf_sreg_list[i];
         uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
         uint32_t key = kvm_to_cpreg_id(kvm_id);
@@ -1016,6 +1290,26 @@ int hvf_arch_init_vcpu(CPUState *cpu)
             arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
         }
     }
+    if (__builtin_available(macOS 15.2, *)) {
+        if (hvf_arm_sme2_supported()) {
+            for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
+                hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i];
+                uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
+                uint32_t key = kvm_to_cpreg_id(kvm_id);
+                const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
+
+                if (ri) {
+                    assert(!(ri->type & ARM_CP_NO_RAW));
+                    arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
+                }
+            }
+            /*
+             * Add SVCR last. It is elsewhere assumed its index is after
+             * hvf_sreg_list and hvf_sreg_list_sme2.
+             */
+            arm_cpu->cpreg_indexes[sregs_cnt++] = HVF_TO_KVMID(SVCR);
+        }
+    }
     arm_cpu->cpreg_array_len = sregs_cnt;
     arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
 
diff --git a/target/arm/hvf/hvf_sme_stubs.h b/target/arm/hvf/hvf_sme_stubs.h
new file mode 100644
index 0000000000..43686f7824
--- /dev/null
+++ b/target/arm/hvf/hvf_sme_stubs.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+typedef int32_t hv_return_t;
+typedef uint64_t hv_vcpu_t;
+
+static inline bool hvf_arm_sme2_supported(void)
+{
+    return false;
+}
+
+static inline uint32_t hvf_arm_sme2_get_svl(void)
+{
+    g_assert_not_reached();
+}
+
+typedef enum hv_sme_p_reg_t {
+    HV_SME_P_REG_0,
+    HV_SME_P_REG_1,
+    HV_SME_P_REG_2,
+    HV_SME_P_REG_3,
+    HV_SME_P_REG_4,
+    HV_SME_P_REG_5,
+    HV_SME_P_REG_6,
+    HV_SME_P_REG_7,
+    HV_SME_P_REG_8,
+    HV_SME_P_REG_9,
+    HV_SME_P_REG_10,
+    HV_SME_P_REG_11,
+    HV_SME_P_REG_12,
+    HV_SME_P_REG_13,
+    HV_SME_P_REG_14,
+    HV_SME_P_REG_15,
+} hv_sme_p_reg_t;
+
+/*
+ * The system version of this type declares it with
+ *    __attribute__((ext_vector_type(64)))
+ * However, that is clang specific and not supported by GCC.
+ * Since these headers are only here for the case where the system
+ * headers do not provide these types (including both older macos
+ * and non-macos hosts), we don't need to make the type match
+ * exactly, so we declare it as a uint8_t array.
+ */
+typedef uint8_t hv_sme_zt0_uchar64_t[64];
+
+typedef enum hv_sme_z_reg_t {
+    HV_SME_Z_REG_0,
+    HV_SME_Z_REG_1,
+    HV_SME_Z_REG_2,
+    HV_SME_Z_REG_3,
+    HV_SME_Z_REG_4,
+    HV_SME_Z_REG_5,
+    HV_SME_Z_REG_6,
+    HV_SME_Z_REG_7,
+    HV_SME_Z_REG_8,
+    HV_SME_Z_REG_9,
+    HV_SME_Z_REG_10,
+    HV_SME_Z_REG_11,
+    HV_SME_Z_REG_12,
+    HV_SME_Z_REG_13,
+    HV_SME_Z_REG_14,
+    HV_SME_Z_REG_15,
+    HV_SME_Z_REG_16,
+    HV_SME_Z_REG_17,
+    HV_SME_Z_REG_18,
+    HV_SME_Z_REG_19,
+    HV_SME_Z_REG_20,
+    HV_SME_Z_REG_21,
+    HV_SME_Z_REG_22,
+    HV_SME_Z_REG_23,
+    HV_SME_Z_REG_24,
+    HV_SME_Z_REG_25,
+    HV_SME_Z_REG_26,
+    HV_SME_Z_REG_27,
+    HV_SME_Z_REG_28,
+    HV_SME_Z_REG_29,
+    HV_SME_Z_REG_30,
+    HV_SME_Z_REG_31,
+} hv_sme_z_reg_t;
+
+enum {
+  HV_SYS_REG_SMCR_EL1,
+  HV_SYS_REG_SMPRI_EL1,
+  HV_SYS_REG_TPIDR2_EL0,
+  HV_SYS_REG_ID_AA64ZFR0_EL1,
+  HV_SYS_REG_ID_AA64SMFR0_EL1,
+};
+
+enum {
+  HV_FEATURE_REG_ID_AA64SMFR0_EL1,
+  HV_FEATURE_REG_ID_AA64ZFR0_EL1,
+};
+
+typedef struct {
+    bool streaming_sve_mode_enabled;
+    bool za_storage_enabled;
+} hv_vcpu_sme_state_t;
+
+static inline hv_return_t hv_sme_config_get_max_svl_bytes(size_t *value)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_get_sme_state(hv_vcpu_t vcpu,
+                                                hv_vcpu_sme_state_t *sme_state)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_set_sme_state(hv_vcpu_t vcpu,
+                                                const hv_vcpu_sme_state_t *sme_state)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_get_sme_z_reg(hv_vcpu_t vcpu,
+                                                hv_sme_z_reg_t reg,
+                                                uint8_t *value,
+                                                size_t length)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_set_sme_z_reg(hv_vcpu_t vcpu,
+                                                hv_sme_z_reg_t reg,
+                                                const uint8_t *value,
+                                                size_t length)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_get_sme_p_reg(hv_vcpu_t vcpu,
+                                                hv_sme_p_reg_t reg,
+                                                uint8_t *value,
+                                                size_t length)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_set_sme_p_reg(hv_vcpu_t vcpu,
+                                                hv_sme_p_reg_t reg,
+                                                const uint8_t *value,
+                                                size_t length)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_get_sme_za_reg(hv_vcpu_t vcpu,
+                                                 uint8_t *value,
+                                                 size_t length)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_set_sme_za_reg(hv_vcpu_t vcpu,
+                                                 const uint8_t *value,
+                                                 size_t length)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_get_sme_zt0_reg(hv_vcpu_t vcpu,
+                                                  hv_sme_zt0_uchar64_t *value)
+{
+    g_assert_not_reached();
+}
+
+static inline hv_return_t hv_vcpu_set_sme_zt0_reg(hv_vcpu_t vcpu,
+                                                  const hv_sme_zt0_uchar64_t *value)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
index 067a8603fa..7a2f880f78 100644
--- a/target/arm/hvf/sysreg.c.inc
+++ b/target/arm/hvf/sysreg.c.inc
@@ -145,3 +145,11 @@ DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 3, 3, 13, 0, 3)
 DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 3, 3, 14, 3, 1)
 DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 3, 3, 14, 3, 2)
 DEF_SYSREG(HV_SYS_REG_SP_EL1, 3, 4, 4, 1, 0)
+
+DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
+DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
+DEF_SYSREG_15_02(HV_SYS_REG_TPIDR2_EL0, 3, 3, 13, 0, 5)
+DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
+DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
+DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
+DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 5d19d82e5d..6b1c3b9792 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -22,4 +22,45 @@ void hvf_arm_init_debug(void);
 
 void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
+/*
+ * We need access to types from macOS SDK >=15.2, so expose stubs if the
+ * headers are not available until we raise our minimum macOS version.
+ */
+#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
+  #if (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200)
+    #include "system/hvf_int.h"
+
+    static inline bool hvf_arm_sme2_supported(void)
+    {
+        if (__builtin_available(macOS 15.2, *)) {
+            size_t svl_bytes;
+            hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
+            if (result == HV_UNSUPPORTED) {
+                return false;
+            }
+            assert_hvf_ok(result);
+            return svl_bytes > 0;
+        } else {
+            return false;
+        }
+    }
+
+    static inline uint32_t hvf_arm_sme2_get_svl(void)
+    {
+        if (__builtin_available(macOS 15.2, *)) {
+            size_t svl_bytes;
+            hv_return_t result = hv_sme_config_get_max_svl_bytes(&svl_bytes);
+            assert_hvf_ok(result);
+            return svl_bytes;
+        } else {
+            abort();
+        }
+    }
+  #else /* (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200) */
+      #include "hvf/hvf_sme_stubs.h"
+  #endif /* (__MAC_OS_X_VERSION_MAX_ALLOWED >= 150200) */
+#else /* ifdef __MAC_OS_X_VERSION_MAX_ALLOWED */
+  #include "hvf/hvf_sme_stubs.h"
+#endif /* ifdef __MAC_OS_X_VERSION_MAX_ALLOWED */
+
 #endif
diff --git a/target/arm/machine.c b/target/arm/machine.c
index bbaae34449..81a506ce4c 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -231,7 +231,7 @@ static bool sve_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
-    return cpu_isar_feature(aa64_sve, cpu);
+    return cpu_isar_feature(aa64_sve, cpu) || cpu_isar_feature(aa64_sme, cpu);
 }
 
 /* The first two words of each Zreg is stored in VFP state.  */
-- 
2.50.1 (Apple Git-155)


