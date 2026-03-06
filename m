Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82011F513F9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 04:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyMe1-00062Q-49; Thu, 05 Mar 2026 23:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdz-00060r-Ii
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:31 -0500
Received: from p-west2-cluster5-host2-snip4-6.eps.apple.com ([57.103.71.119]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyMdw-0002WE-5x
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 23:18:31 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 F04671800123; Fri,  6 Mar 2026 04:18:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772770702; x=1775362702;
 bh=ItmA7iXTDqqGZHO0naG8y+91jnHyKvFRYWfwX5RGdgY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VkhL3F2sIxQ83BgngPBkkJ8BC718aw1bDV6wWyuSM5kZWswP5OzFIukykAZQ8wZ1/WRL+TkoUO63aObQUvbcPkFOyBxwK2a5/wyznEdTJT6iegNiuR2ARBxZHijohs1ZefVLMlNpkbr5JFQV/VQyNroIlep9lC9uMiihAlkZ3ssOu8yEDYK8eHSf5ADb0ISRymR7Wev8Jh2YAI5zruWL1JhwWRSN+yJovrvuhe4v/kqRGda52og/cvHBFfOXQRFFi9Vr9EqzJGeXZ4qWVUMFgfktIlLh7R2UTPyOIGvtZjlkAOqZNA+LWd9JZDWGjUO9JyJaGMSVZdebae9CWLFtFA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 C255D180011A; Fri,  6 Mar 2026 04:18:19 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v12 12/15] hvf: sync registers used at EL2
Date: Fri,  6 Mar 2026 05:17:43 +0100
Message-ID: <20260306041747.54554-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306041747.54554-1-mohamed@unpredictable.fr>
References: <20260306041747.54554-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MyJv00QMYNomvg35EKQBBPGFuDxmndoy
X-Proofpoint-ORIG-GUID: MyJv00QMYNomvg35EKQBBPGFuDxmndoy
X-Authority-Info-Out: v=2.4 cv=d5f4CBjE c=1 sm=1 tr=0 ts=69aa558e
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iuyuHyZKG8LmWTHPEAYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDAzOCBTYWx0ZWRfX3ezc6CXo1jVP
 fQxa+KdEE+/o1X2MM0KkuG1ohsE1LGYMj7wKZ/d0NcRuhPmltPCp2Xcp5MITk+Abl+IyRQyKGMv
 RksoPiIF2H5IP7qTmFEbAbDrupZGVTKe8eMCNr48V0xFRRQkQd6IyWHSyZJVwOedVTP8Dl+Tw2H
 1tvDJvqWixzgHiFH7THxfbvo8W0Zy1IwaYs/0B/cITu0HnbDucCkDsW76VCCoZRJ58gzag16Xv5
 s+8Z4brmP1RJ84pgsrQenmpTpTPr8k1GFXoTB8qWe+VAmMGNlCyOGpPVgqceoX+kq9C/pvgRLQC
 krmkWEfYLHOSOc+DkU7swvZiAR/ZKGuNAvKVBrRKA2LOmNMNEZwXrs1NIDo+pA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1030
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060038
X-JNJ: AAAAAAAByeXop70iBQLzkeCKMVdS24RcKJbKFDn5szcb7AmLz1ts8L1+hLt1M3dGcfYJtsTam6+PMANJ2EBA9PpAcJaRjDF8clYNiYzh1rr7fINk9sTtwgykA1caV/vHwyargakXAW+f21T/V39T2SRW+IHbRfq42g1OstXT8LA0EijjXXXbhtnmw4rQynRaUMtU/uW7KLNXOQh5/jR4VbhQfNEeDEjGJla73V+uEWCfhcbX+XQMzc3DrnhxF5XN3XFS7hYvbTVqd5Z15rmSjpd6NH6T+1ZnVG+OE5+v+WM0qm9cAA3+iglqJTs0Nyef00LOF0im0iaq+Efx8h5U5VIen9w0VxUB16ZG5xJ6CudHGZaba49XMVAxJSerOJ3HGoNo0C7NPq4U/gBIHDNXFmpLo+IhqmVvhkl46y0KpYBmLPcowI5Si/7tdjDc9Ar0yR9am/DMICaKDB3puSGzfkIbJEra48MPrSgF76JOmcxswSHG6j/2ej/u78wBPkM1TJMDsbxitDpMuYvvmiv/j2zhMgCR98x97/3S9CA7ziVK1XHAaNuOvpyBagiSgLEbYxhF8+V3dTfVgqnOHtWbXHH+hr3SH01Kl4flKDu8dYycyIb4N78tIkhlIo4wm/wg+640TQwio+6Q1mBZIK2k6cYwweOLY8LXWASgOm2F8nSdPJLqK+yZFPUgP4tJ3rKBv0Q/8XtcU+ianKfF8RbwIVHK3rTE1ARFdiLbGi4/qxRF/VJmhg==
Received-SPF: pass client-ip=57.103.71.119;
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

When starting up the VM at EL2, more sysregs are available. Sync the state of those.

In addition, sync the state of the EL1 physical timer when the vGIC is used, even
if running at EL1. However, no OS running at EL1 is expected to use those registers.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c        | 55 ++++++++++++++++++++++++++++++++-----
 target/arm/hvf/sysreg.c.inc | 44 +++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0c96119ab9..a07702047e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -473,31 +473,61 @@ static const struct hvf_reg_match hvf_sme2_preg_match[] = {
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
@@ -1288,6 +1318,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 #define DEF_SYSREG_15_02(HVF_ID, ...) \
         g_assert(HVF_ID == KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
 #define DEF_SYSREG(...)
+#define DEF_SYSREG_EL2(...)
+#define DEF_SYSREG_VGIC(...)
+#define DEF_SYSREG_VGIC_EL2(...)
 
 #include "sysreg.c.inc"
 
@@ -1314,12 +1347,20 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t));
 
     /* Populate cp list for all known sysregs */
-    for (i = 0; i < ARRAY_SIZE(hvf_sreg_list); i++) {
-        hv_sys_reg_t hvf_id = hvf_sreg_list[i];
+    for (i = 0; i < sregs_match_len; i++) {
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
@@ -1327,7 +1368,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     }
     if (__builtin_available(macOS 15.2, *)) {
         for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
-            hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i];
+            hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i].sreg;
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


