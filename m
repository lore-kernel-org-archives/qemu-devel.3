Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06199F513F5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 04:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyMdZ-0005g7-RN; Thu, 05 Mar 2026 23:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdX-0005ee-Bm
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:03 -0500
Received: from p-west2-cluster1-host12-snip4-10.eps.apple.com ([57.103.68.43]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdS-0002R0-Rr
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:03 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 AFF9F1800160; Fri,  6 Mar 2026 04:17:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772770677; x=1775362677;
 bh=oermosgqoh8JEhoMeWDgwAHnYHuofVFkfxeTkLOlkJ8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=SmPugXiynJJPoUp6vnhqtSh2lYxBQAAD5T2Or8q9HmN7oz1GAZ8cqnFPPnmwOscH0jLJM6DC/IbP/QUqNMso97r++/lrKMSsoLhwSNfSqPUU+Xx4cnC5HtYvIRPRW3DURBFZbxQYNxfzkjGyf5ryScsPt3w2t8dq3w3TApr+CUAKJmYhBRPqmJ2Ja/0qe9WRxOxCxaq8mQ8FLzYiVJrsgnsEjCtJB3Kg52GtRImX+NvuDNXxQRh+X0E+HTLErUFYlFz542Su2yCM1U64WfvTRkobLYkXhCf7nqKJAWQJa9td9Mq/JjfXQGHXE8m1jAM+bzqRYoYu/vIokmcB8rlFrA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 CC8E5180011A; Fri,  6 Mar 2026 04:17:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 01/15] hvf/arm: handle FEAT_SME2 migration
Date: Fri,  6 Mar 2026 05:17:32 +0100
Message-ID: <20260306041747.54554-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306041747.54554-1-mohamed@unpredictable.fr>
References: <20260306041747.54554-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AlyZ2vYaYoac37SmfzPIrlD11jNctNWg
X-Authority-Info-Out: v=2.4 cv=G70R0tk5 c=1 sm=1 tr=0 ts=69aa5574
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=FLErkvThLWmWEKq3f44A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: AlyZ2vYaYoac37SmfzPIrlD11jNctNWg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDAzOCBTYWx0ZWRfX3wM27es9i+wN
 jxrK3FPjCRFlTkn+0cYfliUrZe4vNPHAs0gYgFOaPWcNLYu1FRGG5XvnoMThvblNcLRz6yEkYIt
 7Aql8FINjvN32SK77RmbmHFtHvM2h+ABWLQ9EPmx1UbSQEc6vBBvckIL84puF5LvkwreTLaamyD
 0U28XAOjW7XcV7ZDjww2ZtC1tjPDkQuqIOeZWkmlnF6qjuQVVcids9kyWQvznbVaiZBxdFiiSDR
 DGAoiK9EGxVgSiv3kIjqqbr64/ydQLiZ1QSx073fKhBNgcyJon5iRAWDIHXF5yVuGJiJ7YsqrnZ
 LQBNgKtX3kyG+2hl45w+sRMWmLQi3nYiO1KXJ+e8W/wkwUuKqrlroP4aT4szSc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 clxscore=1030 adultscore=0
 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060038
X-JNJ: AAAAAAABZ/v8wdHtEQ4H53tAANDBkj6GGCCLTLP9AejqZuYvLww4BUJqbTJhEHS2AthQEuNQHs7L5XO3j36+29+C7JlcVPhdjp7viXitsZ21o83oHdO19oBzZ4FXP3VawjwjlEvb2jpXXhwB6zBKY4WfnQtmfo2K5NmLDWbm1KXU7a/8z59IvFh7Al/CiqP3/a6oE2vr8/qgRSD5E+lxmqzwMYVrlbu3Obf1qzU4GNqkvux81o+fAiYdjM6iOAKwgTBTIgDOgENWsZ933oOU7Z5bfNFHkcpFw0xXtTq4vw+KyXjWygMbA7vuAfUmW72pKPMEhVrXpHsrqbV/pKKVs1HdvCnbkaoB96b35Ytx4neaOKH+iTb1OWSkyW4F7k+XH1rokXYX2gm96jl7Go+voi1gvDvRin+c2kyb09bCud4J9cgrBrfvNj2PnlQcBvj6gU6ogDKXfmlE8Q5yFfM7YTW0QT5Leuav37QKTIGvEVKV9708mz25Z8KMTB5ZPufFBsBjrVnr3Mx6WLNLLmHWKXKEFHLPiNtfnwUJjahzAxzu3IXNnIVeNqa/YT7wwcWgVkF8wlTVbJBeo+LnEIlPhBmQgFohkM7noyIQSyII7sUpMO2CfweyURxuHsCHq/6cfQ6sai9Ln3XIzVxxX/mkLBtlv0ry1IJ/vWtpqJy2hQ74OkAJcVpAS/k3o5Izz0JfgNOWNeqKpfwaKLRELdtgvnLCYHttKVRkSTF/z0J17QomNVRjzxlzaORGuRwPkSgokhKl8U8SQIO1q2Ev
Received-SPF: pass client-ip=57.103.68.43;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260303-sme2-hvf-v6-1-b473702d8287@linaro.org>
---
 target/arm/hvf/hvf.c           | 294 ++++++++++++++++++++++++++++++++-
 target/arm/hvf/hvf_sme_stubs.h | 158 ++++++++++++++++++
 target/arm/hvf/sysreg.c.inc    |   8 +
 target/arm/hvf_arm.h           |  41 +++++
 target/arm/machine.c           |   2 +-
 5 files changed, 500 insertions(+), 3 deletions(-)
 create mode 100644 target/arm/hvf/hvf_sme_stubs.h

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d79469ca27..3d194680cc 100644
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
@@ -985,6 +1245,18 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     hv_return_t ret;
     int i;
 
+    if (__builtin_available(macOS 15.2, *)) {
+        sregs_match_len += ARRAY_SIZE(hvf_sreg_list_sme2) + 1;
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
@@ -1005,7 +1277,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t));
 
     /* Populate cp list for all known sysregs */
-    for (i = 0; i < sregs_match_len; i++) {
+    for (i = 0; i < ARRAY_SIZE(hvf_sreg_list); i++) {
         hv_sys_reg_t hvf_id = hvf_sreg_list[i];
         uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
         uint32_t key = kvm_to_cpreg_id(kvm_id);
@@ -1016,6 +1288,24 @@ int hvf_arch_init_vcpu(CPUState *cpu)
             arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
         }
     }
+    if (__builtin_available(macOS 15.2, *)) {
+        for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
+            hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i];
+            uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
+            uint32_t key = kvm_to_cpreg_id(kvm_id);
+            const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
+
+            if (ri) {
+                assert(!(ri->type & ARM_CP_NO_RAW));
+                arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
+            }
+        }
+        /*
+         * Add SVCR last. It is elsewhere assumed its index is after
+         * hvf_sreg_list and hvf_sreg_list_sme2.
+         */
+        arm_cpu->cpreg_indexes[sregs_cnt++] = HVF_TO_KVMID(SVCR);
+    }
     arm_cpu->cpreg_array_len = sregs_cnt;
     arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
 
diff --git a/target/arm/hvf/hvf_sme_stubs.h b/target/arm/hvf/hvf_sme_stubs.h
new file mode 100644
index 0000000000..9c679b7110
--- /dev/null
+++ b/target/arm/hvf/hvf_sme_stubs.h
@@ -0,0 +1,158 @@
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
+typedef __attribute__((ext_vector_type(64))) uint8_t hv_sme_zt0_uchar64_t;
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


