Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEB6FC9EC6
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 09:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyncR-0006og-Gt; Sat, 07 Mar 2026 04:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyncN-0006nD-9V
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:39 -0500
Received: from qs-2007a-snip4-8.eps.apple.com ([57.103.84.139]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyncE-000148-AU
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:06:32 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id
 9E9FB180013E; Sat,  7 Mar 2026 09:06:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772874389; x=1775466389;
 bh=7K7Ydla37vwloPdHUz7tPsEx0hHirAQLjDnCNzmv+/s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=aDYjz4i9h+yDk+4HT9uuPBICpgT4x/bajEPRMw4RNaUpHI9telSA3PeOOS5jwdOfvXjRv/ZJb+riLYAUVCBoKCsB/JGni5DD4TVNHD26AJ3pLag0c8psjHJVs/AkN3Llklw6aVKyBpK8jZLkgH0fps2uq63DWidgRTZkAMat7HMuKm+Sl7IxMn3VrIXsu3GY8DJ1mb/BVu9MidxnvKo+EH8CKHPR+owPGQCeYUZ15EComDUplsSZE7AY9HXTsP7iSDhHrdb5fqx2KaHfspktF9wLmPIzsEk2Ia9dRRdyncr1EQ77kwyldHVnjuZLTisVPjeUlKgLHDetJp1aoAi/ig==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id
 A893F1800402; Sat,  7 Mar 2026 09:06:24 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v17 10/14] hvf: sync registers used at EL2
Date: Sat,  7 Mar 2026 10:06:02 +0100
Message-ID: <20260307090606.95300-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307090606.95300-1-mohamed@unpredictable.fr>
References: <20260307090606.95300-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WKwzne07u485ea-dcBO74Dpqibh007CE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA4MyBTYWx0ZWRfX0mWx8qkYonl+
 WzYNW+UmqAG48f6rRS0EEf9evW2MRvCZ8Rc9+3ip6T+cGVOQpD4NXdowErgRm/h9YWzA5orhVCY
 essAoc5Uo8fH8Y0H33vfO/MjX7MvgeGz3AvpZLNf7wHgJ8vM5Ubu0erKfjnqFCyv/mRUHFi7pau
 gFxu8woYYLyzmuWTHFhAULv/ZS39kyJ63cJ9AN4OVM+nPeh7yA/YCbqb0SFWsBRR648utFzch8o
 UhoYgWzJDQ3taWCXRCaZ1eY/4/fMgMOCxWnaAU/4GowwyV5b3MVVr25iY8hsVrdxSIIHemgpy/v
 VjPddXxWgg8s+a9MNyVsx90iO2TD94Gkfgkj5iSSCXB89QW/nRHcvzEkdiP3h8=
X-Authority-Info-Out: v=2.4 cv=HPPO14tv c=1 sm=1 tr=0 ts=69abea93
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ml6fgdKjPmdD6r9HfocA:9
X-Proofpoint-GUID: WKwzne07u485ea-dcBO74Dpqibh007CE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 clxscore=1030 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070083
X-JNJ: AAAAAAABjW6jfZMSYdnr3wp96JG9xFNjYDB8bMvvwvutWijHpdHMJUeIkKxBHCD834Yb+E4DUmWHChBIkYoMB/BDKIImAxWnknz5dAOfllSpa3IWwfXQ3ypiO25JEgxUFmlkNqD+2cBJs0LCe7XpTjb+fS5CBIccr1dRTk+R9dn8uEg4MNGC9CzbZhOxAtXlLJDw0tvESfr8G4HIJwkvihFA6BxH9vkiMD+Dlc7vJS19bxPSrTQvZi3ad5yWDaBGPeDK88fzNBjRT3Do7tjMuOXrEC0tSSt82uxJ9iV3jmCn852Y4l1f4CZROwOomju/kOfc+CH1yKPWJP1KDvNF/ImR3iitn7Hs+5m8s0PvHzVm7MuqgDNJOEuk/m9PYZAjXTXqv4tZWazcn2UxG9vwzWgEIWQusAIpqORK7XQkPjqlQEhw2Cbo6d8LxR2Tx9lMxPEjuR7KtXMsXPmNr3gWb4AQBEYKpwLjoSVe9Zg67t4TfgAWIjUTSWhiLkYuLHbSqRM5ieKjiiG4epkpNkrc3E51D+ONWgRUAarYVvnfHc6XevTDTN0hs5VCIIynzI2jdR2rj58ZJsIMMyowNWgikvQGMj+2VfoRZ2i6dic5IEW31VkYIOKkKCaHOeF/wZ5lW7+GjUgIcmL3H5sAa3GvKVWhMGa4nSE4+bkU2AKguCGKdLXpCprTbhCEu7a4NByX8Ceu2RxSuv9COJF6o+wlu7TKKsv4sdrI/sXa/2qSYsnUoEU=
Received-SPF: pass client-ip=57.103.84.139;
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

When starting up the VM at EL2, more sysregs are available. Sync the state of those.

In addition, sync the state of the EL1 physical timer when the vGIC is used, even
if running at EL1. However, no OS running at EL1 is expected to use those registers.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c        | 61 +++++++++++++++++++++++++++++++++----
 target/arm/hvf/sysreg.c.inc | 44 ++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 53ca84c35d..949c4a3431 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -467,37 +467,75 @@ static const struct hvf_reg_match hvf_sme2_preg_match[] = {
  *
  * SME2 registers are guarded by a runtime availability attribute instead of a
  * compile-time def, so verify those at runtime in hvf_arch_init_vcpu() below.
+ *
+ * Nested virt registers are handled via a runtime check, so override the guarded
+ * availability check done by Clang.
  */
 
+#pragma clang diagnostic push
+#pragma clang diagnostic ignored "-Wunguarded-availability"
+
 #define DEF_SYSREG(HVF_ID, ...) \
   QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
 #define DEF_SYSREG_15_02(...)
 
+#define DEF_SYSREG_EL2(HVF_ID, ...) \
+  QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
+
+#define DEF_SYSREG_VGIC(HVF_ID, ...) \
+  QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
+
+#define DEF_SYSREG_VGIC_EL2(HVF_ID, ...) \
+  QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
+
 #include "sysreg.c.inc"
 
 #undef DEF_SYSREG
 #undef DEF_SYSREG_15_02
+#undef DEF_SYSREG_EL2
+#undef DEF_SYSREG_VGIC
+#undef DEF_SYSREG_VGIC_EL2
 
-#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  HVF_ID,
+#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID},
 #define DEF_SYSREG_15_02(...)
+#define DEF_SYSREG_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .el2 = true},
+#define DEF_SYSREG_VGIC(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .vgic = true},
+#define DEF_SYSREG_VGIC_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, true, true},
+
+struct hvf_sreg {
+    hv_sys_reg_t sreg;
+    bool vgic;
+    bool el2;
+};
 
-static const hv_sys_reg_t hvf_sreg_list[] = {
+static struct hvf_sreg hvf_sreg_list[] = {
 #include "sysreg.c.inc"
 };
 
 #undef DEF_SYSREG
 #undef DEF_SYSREG_15_02
+#undef DEF_SYSREG_EL2
+#undef DEF_SYSREG_VGIC
+#undef DEF_SYSREG_VGIC_EL2
+
+#pragma clang diagnostic pop
 
 #define DEF_SYSREG(...)
-#define DEF_SYSREG_15_02(HVF_ID, op0, op1, crn, crm, op2) HVF_ID,
+#define DEF_SYSREG_15_02(HVF_ID, op0, op1, crn, crm, op2) {HVF_ID},
+#define DEF_SYSREG_EL2(...)
+#define DEF_SYSREG_VGIC(...)
+#define DEF_SYSREG_VGIC_EL2(...)
 
 API_AVAILABLE(macos(15.2))
-static const hv_sys_reg_t hvf_sreg_list_sme2[] = {
+static struct hvf_sreg hvf_sreg_list_sme2[] = {
 #include "sysreg.c.inc"
 };
 
 #undef DEF_SYSREG
 #undef DEF_SYSREG_15_02
+#undef DEF_SYSREG_EL2
+#undef DEF_SYSREG_VGIC
+#undef DEF_SYSREG_VGIC_EL2
 
 /*
  * For FEAT_SME2 migration, we need to store PSTATE.{SM,ZA} bits which are
@@ -1320,6 +1358,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 #define DEF_SYSREG_15_02(HVF_ID, ...) \
         g_assert(HVF_ID == KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
 #define DEF_SYSREG(...)
+#define DEF_SYSREG_EL2(...)
+#define DEF_SYSREG_VGIC(...)
+#define DEF_SYSREG_VGIC_EL2(...)
 
 #include "sysreg.c.inc"
 
@@ -1347,11 +1388,19 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
     /* Populate cp list for all known sysregs */
     for (i = 0; i < ARRAY_SIZE(hvf_sreg_list); i++) {
-        hv_sys_reg_t hvf_id = hvf_sreg_list[i];
+        hv_sys_reg_t hvf_id = hvf_sreg_list[i].sreg;
         uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
         uint32_t key = kvm_to_cpreg_id(kvm_id);
         const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
 
+        if (hvf_sreg_list[i].vgic && !hvf_irqchip_in_kernel()) {
+            continue;
+        }
+
+        if (hvf_sreg_list[i].el2 && !hvf_nested_virt_enabled()) {
+            continue;
+        }
+
         if (ri) {
             assert(!(ri->type & ARM_CP_NO_RAW));
             arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
@@ -1360,7 +1409,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     if (__builtin_available(macOS 15.2, *)) {
         if (hvf_arm_sme2_supported()) {
             for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
-                hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i];
+                hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i].sreg;
                 uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
                 uint32_t key = kvm_to_cpreg_id(kvm_id);
                 const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
index 7a2f880f78..c11dbf274e 100644
--- a/target/arm/hvf/sysreg.c.inc
+++ b/target/arm/hvf/sysreg.c.inc
@@ -153,3 +153,47 @@ DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
 DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
 DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
 DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
+/*
+ * Block these because of the same issue as virtual counters in
+ * that caused the revert in 28b0ed32b32c7e5094cf2f1ec9c0645c65fad2aa
+ *
+ * DEF_SYSREG_VGIC(HV_SYS_REG_CNTP_CTL_EL0, 3, 3, 14, 2, 1)
+ * DEF_SYSREG_VGIC(HV_SYS_REG_CNTP_CVAL_EL0, 3, 3, 14, 2, 2)
+ */
+#ifdef SYNC_NO_RAW_REGS
+DEF_SYSREG_VGIC(HV_SYS_REG_CNTP_TVAL_EL0, 3, 3, 14, 2, 0)
+#endif
+
+/*
+ * Also block these because of the same issue as virtual counters in
+ * that caused the revert in 28b0ed32b32c7e5094cf2f1ec9c0645c65fad2aa
+ *
+ * DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHP_CVAL_EL2, 3, 4, 14, 2, 2)
+ * DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHP_CTL_EL2, 3, 4, 14, 2, 1)
+ */
+DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHCTL_EL2, 3, 4, 14, 1, 0)
+#ifdef SYNC_NO_RAW_REGS
+DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHP_TVAL_EL2, 3, 4, 14, 2, 0)
+#endif
+DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTVOFF_EL2, 3, 4, 14, 0, 3)
+
+DEF_SYSREG_EL2(HV_SYS_REG_CPTR_EL2, 3, 4, 1, 1, 2)
+DEF_SYSREG_EL2(HV_SYS_REG_ELR_EL2, 3, 4, 4, 0, 1)
+DEF_SYSREG_EL2(HV_SYS_REG_ESR_EL2, 3, 4, 5, 2, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_FAR_EL2, 3, 4, 6, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_HCR_EL2, 3, 4, 1, 1, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_HPFAR_EL2, 3, 4, 6, 0, 4)
+DEF_SYSREG_EL2(HV_SYS_REG_MAIR_EL2, 3, 4, 10, 2, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_MDCR_EL2, 3, 4, 1, 1, 1)
+DEF_SYSREG_EL2(HV_SYS_REG_SCTLR_EL2, 3, 4, 1, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_SPSR_EL2, 3, 4, 4, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_SP_EL2, 3, 6, 4, 1, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_TCR_EL2, 3, 4, 2, 0, 2)
+DEF_SYSREG_EL2(HV_SYS_REG_TPIDR_EL2, 3, 4, 13, 0, 2)
+DEF_SYSREG_EL2(HV_SYS_REG_TTBR0_EL2, 3, 4, 2, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_TTBR1_EL2, 3, 4, 2, 0, 1)
+DEF_SYSREG_EL2(HV_SYS_REG_VBAR_EL2, 3, 4, 12, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_VMPIDR_EL2, 3, 4, 0, 0, 5)
+DEF_SYSREG_EL2(HV_SYS_REG_VPIDR_EL2, 3, 4, 0, 0, 0)
+DEF_SYSREG_EL2(HV_SYS_REG_VTCR_EL2, 3, 4, 2, 1, 2)
+DEF_SYSREG_EL2(HV_SYS_REG_VTTBR_EL2, 3, 4, 2, 1, 0)
-- 
2.50.1 (Apple Git-155)


