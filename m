Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A3FFD0046
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 22:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwSUh-0002ZB-R0; Sat, 28 Feb 2026 17:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUg-0002YV-HJ
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:09:02 -0500
Received: from qs-2004l-snip4-8.eps.apple.com ([57.103.84.121]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwSUd-0005pI-Q5
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:09:02 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 95C7B180038B; Sat, 28 Feb 2026 22:08:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772316539; x=1774908539;
 bh=pEB1q+UBDvl45MTUrB6NLPUSLe0c6C6gSYXpXiwgtxo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=YZi6azaQVTta9i+X5ZyVMj/seXYXY/hv6n2N9m7tjBa9DRILkSpk5V+C4aeTFmZ7YKNYTlKNGCpsuGdEz/Ou2PNxBe3xi3/6GChgsWQTkx5mN6FnBu4TgihlgiHxhQmiCOMZrTCLGqBrzXayIimXVf7ubGLUykqAXVpwR7/IlNxpvz7tWubuMVrVvXh4Epd4tHmvp8jNwR2VPH+aBaUvyYo91APEMQKrSzGm73YDacNGm378iI/tvYQmpoXIsOt2pyIKHBUw0SL8m0asTUvp8wjBw/+8knBiEqJrKPZLCTtchTN89kNoqeoLrKdOJsYNSgm3/oztITpgxhaK9C3m9w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 B25E118003A6; Sat, 28 Feb 2026 22:08:54 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v11 10/12] hvf: sync registers used at EL2
Date: Sat, 28 Feb 2026 23:08:35 +0100
Message-ID: <20260228220837.35275-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228220837.35275-1-mohamed@unpredictable.fr>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Oa2VzxTY c=1 sm=1 tr=0 ts=69a36779
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=rrAUKWPZoPk1NO14nDIA:9
X-Proofpoint-ORIG-GUID: wV82LRq8nvHQ-qaUbjfT9Hqw_6bq1fMl
X-Proofpoint-GUID: wV82LRq8nvHQ-qaUbjfT9Hqw_6bq1fMl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwNyBTYWx0ZWRfX7X3ztpNbjm0L
 LRATxgUkdhIeCHTci+zGk7dsGnfeA6/sz/Aweep9jzIaH6ba/LSPRTn7gOPv+PdcEXiEiVCNEAh
 RWWkSGgyuEXF5JKYrocDb5EHXqcKHnq23X6DVTJ6d4C3ztGB56Aq2ZZrmlEXYLWpoKCyGFYN9ce
 Qf0CiWiO1E1j/pa/YGk6AIBmUSeY2Uyc2JtVGbQxp65gYVlw+VapogYwXrt8kn7SaBu31gb7fHI
 nxt5+/dQ8yYxd2a2WBNVQTUhz1+zhN0E9m9fNI4czGe03Y+e7eJAKzXB4ZM3yYjxU2Ljq24eOcx
 s4RQVU5jKAVrZ4kO2GkhHewqZzuIb7RhRVLWhsTEDEDqDxhwkjaqhl0meKK2f8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1030
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280207
X-JNJ: AAAAAAAB1MEuHofmJxH3oo+QArSdrL68NhWGQHjeu2DdlurHV17/0E9D7vYgZ+BjKmAHLPUh9MLpN9X9wotoi54ebB1xZXc0Y7nxYPHa0VJPn69wOOuOOXNVG65Wvv3tkwC10k+fj+1s3OYhXhs+0Nz3Rof784W2KfDiep1ax/qaCytTSpNraXgOXWjodtZ9OUBhTP1QF8Tzk1d0wqabyRMYVcRqmGkk94EHVHamZpJr+HJdcg9pLRhTa1oy6XI9H1r6WK05Wp2JAOKnvGxzCuff46+jOZJlNO1GT7Ef+AKbJe7/UNcz+gHw5MfWu8bB+Y/fZv7M0E+qzugB4kIDCQy1afpvYb4EFwll2BPIYPsXplzPH0mRap7IExtkVewKgyjhexqKQWbVlotw5uEhHNKJWQ3iZie3xvFlTZXrfy1RWG7f2ZVfsZnZBG5ISCb6GE/5Zf74ywQdWyI6Y9WQGiPVi+s1vV2E+En+OJTtfM+J1sOgAw7AjIUlsSizK0c1t/ltComlN5j6PZ+5cBOHPADPw9L/vMh9ckp2azIv+c4OE3K4ioIZH1+awrV411rE1O49Z3NqNwu2/DUPqKeLYN7SS1GAQc83UMx3STiTfSnSgun2JbfKmcvtTtwQ1WeU6eSoT/q9dreQqgNXwzXrx96qr10A21xj52I0e7G389KHb71TDfftEVl1Eu7JsH2DjavcIMQwrg==
Received-SPF: pass client-ip=57.103.84.121;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
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
 target/arm/hvf/hvf.c        | 37 ++++++++++++++++++++++++++----
 target/arm/hvf/sysreg.c.inc | 45 +++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0aae421ba6..f286e6a014 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -412,13 +412,34 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
 #define DEF_SYSREG(HVF_ID, ...) \
   QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
 
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
+#undef DEF_SYSREG_EL2
+#undef DEF_SYSREG_VGIC
+#undef DEF_SYSREG_VGIC_EL2
+
+#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID},
+#define DEF_SYSREG_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .el2 = true},
+#define DEF_SYSREG_VGIC(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .vgic = true},
+#define DEF_SYSREG_VGIC_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, true, true},
+
+struct hvf_sreg {
+    hv_sys_reg_t sreg;
+    bool vgic;
+    bool el2;
+};
 
-#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  HVF_ID,
-
-static const hv_sys_reg_t hvf_sreg_list[] = {
+static struct hvf_sreg hvf_sreg_list[] = {
 #include "sysreg.c.inc"
 };
 
@@ -1052,11 +1073,19 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
     /* Populate cp list for all known sysregs */
     for (i = 0; i < sregs_match_len; i++) {
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
diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
index 067a8603fa..bda35afbd0 100644
--- a/target/arm/hvf/sysreg.c.inc
+++ b/target/arm/hvf/sysreg.c.inc
@@ -145,3 +145,48 @@ DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 3, 3, 13, 0, 3)
 DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 3, 3, 14, 3, 1)
 DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 3, 3, 14, 3, 2)
 DEF_SYSREG(HV_SYS_REG_SP_EL1, 3, 4, 4, 1, 0)
+
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
+DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHCTL_EL2, 3, 4, 14, 1, 0);
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


