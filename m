Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444FEFC9EDF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 09:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyncW-0006xJ-7i; Sat, 07 Mar 2026 04:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyncP-0006oN-Oo
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:41 -0500
Received: from qs-2001k-snip4-6.eps.apple.com ([57.103.87.109]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyncM-00017k-S0
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:41 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id
 D8CA1180010B; Sat,  7 Mar 2026 09:06:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772874395; x=1775466395;
 bh=hle0o+U/f2vujv/4zDDblnnwIkB2kG2UZAlEYajCDCM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VuTb0qKXPWc5yeF6Y8q6gWJ1myorLin0J5cl9MRkzn5grmUezb4gyUCl10rXxkfhpmA5SgLDZIE4YdWWfMCqZg1IfT/gd3+fCG82j+RNB7BSMp/ObFT4sE11ebp3J3QyogrnRoW5TNo/YNtfAAzakfzzapSHHeLIatXRsmjJ9ZRGHdyi94zwrhfjLjUyAzEiKpqwME5UfTq1SgJnwv6UCXoqW65bQkxzYbzyspkArrS9efQ/CJSiLM28u0fRuNS2+EtYMomJ0GqTClIRzc4WYfQOk5S31qAoWEDk2KMpADtGVSwTKRpcR048EpfZ+fCL6AcGSe2B8jA8WhL6qHflbg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id
 D88A21800128; Sat,  7 Mar 2026 09:06:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v17 14/14] hvf: arm: move SME2 registers to common hvf_sreg
 structure
Date: Sat,  7 Mar 2026 10:06:06 +0100
Message-ID: <20260307090606.95300-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307090606.95300-1-mohamed@unpredictable.fr>
References: <20260307090606.95300-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=KJ5XzVFo c=1 sm=1 tr=0 ts=69abea99
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FlfE2Sm0emw1bnAL0rsA:9
X-Proofpoint-GUID: CcphG2fXQYfWYs0CYQRWozs6OY-Nbxnc
X-Proofpoint-ORIG-GUID: CcphG2fXQYfWYs0CYQRWozs6OY-Nbxnc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA4MyBTYWx0ZWRfX88R+kRNsX497
 c8XKNbYPcgZj+xACVSJm/LK5T+fkTzQJCWY4FId9k7FmqcDywEQOephxW9TpnHXeQi5xkN0gKul
 suejvncneWe2CgIwpW4izQuWpRsGX8rtRrcxAYfosDSiBw1ay0Kj32NEkSexlycSyG0mw7rjRVu
 v8UPY9s1HOo/2LxuYi4xjbFUnGzcCnT85Q99tjmZms+ZxE1tCa7CZdNxg/E3co2gkaLUMH5xBD7
 Rjh/TcDHax2JvQDFKw9s/ZU4OdH2Ga3rKqNIzFx0aqkpBwIsrZ/OQGV4rqRNfUr/byUDso7IsMz
 Iwc2+y1Y2ZpqO5KIzLEnF6TlQ6X37fAkbDyDx4oeeBShfYEX0W3SCKTttPip2Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070083
X-JNJ: AAAAAAABOFDvImjSZZ9xxlXTqQRyLdOuuAbKWhkFzJk8qS5DKBmAXV1o9s2hpg04ihO5/sQDIV5iEAiyU1LzfdhaxLC7Ha5qAwB9MhCeXNk5YS03EQDy3L62d6PFu4N/To29ovaQRiLbDEFoFOWqEhL0HSkZIijggrexVjv1zet0UFpwMBf+cmEpShA0klnyoENeQOzL3zxlt/JlU8rszWrmqfAnac1t1rEcfcPOES1XFFiHR/NEfmmonv7dY9JlY7giIIFOvWWq5pgh6QfkJroCr0NEPq01IyfwbwYAIZzV8TuBtG4VPVdXpSa4Q2glK8ZtUMYNnG3+iE+UxlhyZ+f5zNs4cTJPqK/9EIcDAOTwCR4ZTtFU2zq4S0q/zdviF1vVgFbrHVV+/4lS2Geq2yPvHvgfJRHMgozkKMavImhHREHG6HpUHIWdTOsku0k5CICM68awXJOIGDpHx5VIj9uAMs8pBcnDs8EqR52RFNpfFIhB/sMpms4+aG6phGa1lE734jvVR+wqaF2LOU42qqKye0DYhU91RZEpJmGtOp25Tcy2XMthKitoRA40J2KZxAMERv0e7I4hxeHuYVgtF/hugyaCrXgB6FJ5RXSnTgQLW4bcA59LoMQ1t14tBmK7CtK78lHA86LtrnXQRutIHBRt108JFnUINP7d7XXl13vqEAckBjAXVyEd9gAcTs6S51dx4XJJSiXRzxE0J2adyHN+lztAXJDIqx0DrQBtWSlVl6fzNNuVL/mURpHM49bkDQ==
Received-SPF: pass client-ip=57.103.87.109;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c        | 77 +++++++++++--------------------------
 target/arm/hvf/sysreg.c.inc | 14 +++----
 2 files changed, 29 insertions(+), 62 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 2cb4c4aa4e..4630d76930 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -481,7 +481,9 @@ static const struct hvf_reg_match hvf_sme2_preg_match[] = {
 
 #define DEF_SYSREG(HVF_ID, ...) \
   QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
-#define DEF_SYSREG_15_02(...)
+
+#define DEF_SYSREG_SME2(HVF_ID, ...) \
+  QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
 
 #define DEF_SYSREG_EL2(HVF_ID, ...) \
   QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
@@ -495,13 +497,13 @@ static const struct hvf_reg_match hvf_sme2_preg_match[] = {
 #include "sysreg.c.inc"
 
 #undef DEF_SYSREG
-#undef DEF_SYSREG_15_02
+#undef DEF_SYSREG_SME2
 #undef DEF_SYSREG_EL2
 #undef DEF_SYSREG_VGIC
 #undef DEF_SYSREG_VGIC_EL2
 
 #define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID},
-#define DEF_SYSREG_15_02(...)
+#define DEF_SYSREG_SME2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .sme2 = true},
 #define DEF_SYSREG_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .el2 = true},
 #define DEF_SYSREG_VGIC(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .vgic = true},
 #define DEF_SYSREG_VGIC_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, true, true},
@@ -510,6 +512,7 @@ struct hvf_sreg {
     hv_sys_reg_t sreg;
     bool vgic;
     bool el2;
+    bool sme2;
 };
 
 static struct hvf_sreg hvf_sreg_list[] = {
@@ -517,30 +520,13 @@ static struct hvf_sreg hvf_sreg_list[] = {
 };
 
 #undef DEF_SYSREG
-#undef DEF_SYSREG_15_02
+#undef DEF_SYSREG_SME2
 #undef DEF_SYSREG_EL2
 #undef DEF_SYSREG_VGIC
 #undef DEF_SYSREG_VGIC_EL2
 
 #pragma clang diagnostic pop
 
-#define DEF_SYSREG(...)
-#define DEF_SYSREG_15_02(HVF_ID, op0, op1, crn, crm, op2) {HVF_ID},
-#define DEF_SYSREG_EL2(...)
-#define DEF_SYSREG_VGIC(...)
-#define DEF_SYSREG_VGIC_EL2(...)
-
-API_AVAILABLE(macos(15.2))
-static struct hvf_sreg hvf_sreg_list_sme2[] = {
-#include "sysreg.c.inc"
-};
-
-#undef DEF_SYSREG
-#undef DEF_SYSREG_15_02
-#undef DEF_SYSREG_EL2
-#undef DEF_SYSREG_VGIC
-#undef DEF_SYSREG_VGIC_EL2
-
 /*
  * For FEAT_SME2 migration, we need to store PSTATE.{SM,ZA} bits which are
  * accessible with the SVCR pseudo-register. However, in the HVF API this is
@@ -1357,23 +1343,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     hv_return_t ret;
     int i;
 
-    if (__builtin_available(macOS 15.2, *)) {
-        if (hvf_arm_sme2_supported()) {
-            sregs_match_len += ARRAY_SIZE(hvf_sreg_list_sme2) + 1;
-        }
-
-#define DEF_SYSREG_15_02(HVF_ID, ...) \
-        g_assert(HVF_ID == KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
-#define DEF_SYSREG(...)
-#define DEF_SYSREG_EL2(...)
-#define DEF_SYSREG_VGIC(...)
-#define DEF_SYSREG_VGIC_EL2(...)
-
-#include "sysreg.c.inc"
-
-#undef DEF_SYSREG
-#undef DEF_SYSREG_15_02
+    if (hvf_arm_sme2_supported()) {
+        /* SVCR will be added at the end. */
+        sregs_match_len += 1;
     }
+
     env->aarch64 = true;
 
     /* system count frequency sanity check */
@@ -1408,31 +1382,24 @@ int hvf_arch_init_vcpu(CPUState *cpu)
             continue;
         }
 
+        if (hvf_sreg_list[i].sme2 && !hvf_arm_sme2_supported()) {
+            continue;
+        }
+
         if (ri) {
             assert(!(ri->type & ARM_CP_NO_RAW));
             arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
         }
     }
-    if (__builtin_available(macOS 15.2, *)) {
-        if (hvf_arm_sme2_supported()) {
-            for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
-                hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i].sreg;
-                uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
-                uint32_t key = kvm_to_cpreg_id(kvm_id);
-                const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
 
-                if (ri) {
-                    assert(!(ri->type & ARM_CP_NO_RAW));
-                    arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
-                }
-            }
-            /*
-             * Add SVCR last. It is elsewhere assumed its index is after
-             * hvf_sreg_list and hvf_sreg_list_sme2.
-             */
-            arm_cpu->cpreg_indexes[sregs_cnt++] = HVF_TO_KVMID(SVCR);
-        }
+    if (hvf_arm_sme2_supported()) {
+        /*
+         * Add SVCR last. It is elsewhere assumed its index is after
+         * hvf_sreg_list.
+         */
+        arm_cpu->cpreg_indexes[sregs_cnt++] = HVF_TO_KVMID(SVCR);
     }
+
     arm_cpu->cpreg_array_len = sregs_cnt;
     arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
 
diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
index c11dbf274e..2d29c2feec 100644
--- a/target/arm/hvf/sysreg.c.inc
+++ b/target/arm/hvf/sysreg.c.inc
@@ -146,13 +146,13 @@ DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 3, 3, 14, 3, 1)
 DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 3, 3, 14, 3, 2)
 DEF_SYSREG(HV_SYS_REG_SP_EL1, 3, 4, 4, 1, 0)
 
-DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
-DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
-DEF_SYSREG_15_02(HV_SYS_REG_TPIDR2_EL0, 3, 3, 13, 0, 5)
-DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
-DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
-DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
-DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
+DEF_SYSREG_SME2(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
+DEF_SYSREG_SME2(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
+DEF_SYSREG_SME2(HV_SYS_REG_TPIDR2_EL0, 3, 3, 13, 0, 5)
+DEF_SYSREG_SME2(HV_SYS_REG_ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
+DEF_SYSREG_SME2(HV_SYS_REG_ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
+DEF_SYSREG_SME2(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
+DEF_SYSREG_SME2(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
 /*
  * Block these because of the same issue as virtual counters in
  * that caused the revert in 28b0ed32b32c7e5094cf2f1ec9c0645c65fad2aa
-- 
2.50.1 (Apple Git-155)


