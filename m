Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F27D3CCB1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 04:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgFKK-0004nD-UX; Wed, 14 Jan 2026 23:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFKH-0004lx-To
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:51:17 -0500
Received: from p-west3-cluster2-host10-snip4-4.eps.apple.com ([57.103.74.17]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFKG-00066y-6p
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:51:17 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPS id
 6BC091800126; Thu, 15 Jan 2026 04:51:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=sQ4Ek+qCxf73Mm1+7CUPLvriVbB9zK8bC6CHZbAqExw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=X8KIPoIrLiJXVsVo/oamy8nBByaPE6fWxOiHWl/oNtxZ3cu1oS2CczqUmqdBR0QTO9HNv9Xhf4mqcDLmMznihZwTxYgol8XyUxRsZS1ZTDe4/OlSnng5Q8a6WGvAQxW/SNXZsNgDvWBdM22RfCypNXVxYyNXwuhdx4dOkZej1azWClQo/FdydpSmvdK79bevgIm2Fj2ZddrhGWf5Xqan+UO2NoDUqVnTNbuF6wP0yVi2bbdV6VyXcJNkiefBX07omh28VhX31WoaY2EGbVP6XGl505v+t3c3q6Vdma4sutGim/ed9fiUWbPzjS1fdfEHAt/vwNHKb+wjdB9T9yXXTA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPSA id
 1D1FB18007C3; Thu, 15 Jan 2026 04:51:11 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v7 10/10] hvf: sync registers used at EL2
Date: Thu, 15 Jan 2026 05:50:42 +0100
Message-ID: <20260115045042.70086-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115045042.70086-1-mohamed@unpredictable.fr>
References: <20260115045042.70086-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oXL2-H_-3LRog5quyDE47tc1L9Sh-21b
X-Authority-Info: v=2.4 cv=GdIaXAXL c=1 sm=1 tr=0 ts=69687242
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7gx8ALrZTGDtSAp3wEYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAyOSBTYWx0ZWRfX2dLIx7xwXIQ4
 idVvm51FOy2SkGag2Muv8gvVMvM5343m27X3N8P8qLBmk1/l+Z2DdhxGNzZhLATmkZjtxfvpPRD
 9hMhx2I42qodiI7NWw2BTlLDmKFlWuVf8u5YQseK1d362wCWH0JBr3ZfK5P5iZI2ljBbSplocZt
 RqazPM37sshbXX/iFupp+iiXmCTSqOGKc3vxdCWLMxhK4G6Ps0WbDo/2DgUzd7etmpKrtid5qlM
 qyA9kdBs7f3/6474th+wFDSy97LQ9nrKg7egEaQqoWKuQHE69RQrkaE9M9ank0Bxm+V1X0937yr
 4vfM9isTrn8aADCXKnN
X-Proofpoint-ORIG-GUID: oXL2-H_-3LRog5quyDE47tc1L9Sh-21b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_01,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 clxscore=1030 mlxlogscore=854 bulkscore=0 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150029
X-JNJ: AAAAAAABNd71uqer21B3K76TuVornhxsWf1stsPy7Djp7bOmD1zJ+hxwOo9zzXY9p0NOrrWEGfALGuBuoaCkvCXABeQbEJogGIYCpUfHalMotqGCPO2r8r1iEEeX1nscHuIC/ZQ/TbNjy5srT9PrjUzoZuFxdbD3syolxZkuFw0qsP/talGosTtY1LcAITDVsn3QFBbQLTzS3Au/FhOPuK/RuaAQ5T23AZN28bxmIaWBnQSs2D9W9fIMRQryUwxwpauCZ9tLkoNeq0OsTFhcYOj75p4onZT/U3iUWk0lT55Ojs2By+mrRDUs58xfcgmZxEP1uSYgTuTVC8CmvZKtTPMJbt1mYQPNCZ4cb14YNzEzuOOKpHavW/V8MguMNLQwfPEruoDgGATmqC3J+FRVvSF6A/AqR9i1u4vzutOr85pqvkHuwAuqtNfY02v0yCOEfBZdZkUR03J06aBMDrthtsO4zG+JGZooCwOkD4d4l5P7Wf4oRn1+2Wla0HQabuQy1ckkmlfMq+cv1lzbxEI0REmN3i5ZJEwa9FdhyoXD5XT3GnmLTEJDvSlzwAoE3WouSlRcP7LRQfP64bL6XMDmSaO8vt9oEbW3PbupuLwGucq51+LyhXxbV3Bzpl7hZFsA+8xhwe8zTsAlLvmHpO8ipy1SlWOTjDvYQ+MDfEsE6UJmzVqU5C+XAK9odg==
Received-SPF: pass client-ip=57.103.74.17;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/arm/hvf/hvf.c        | 37 +++++++++++++++++++++++++++++++++----
 target/arm/hvf/sysreg.c.inc | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 9a70cbed28..40467929e8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -417,13 +417,34 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
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
 
@@ -982,11 +1003,19 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
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
index 067a8603fa..ce4a4fdc68 100644
--- a/target/arm/hvf/sysreg.c.inc
+++ b/target/arm/hvf/sysreg.c.inc
@@ -145,3 +145,38 @@ DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 3, 3, 13, 0, 3)
 DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 3, 3, 14, 3, 1)
 DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 3, 3, 14, 3, 2)
 DEF_SYSREG(HV_SYS_REG_SP_EL1, 3, 4, 4, 1, 0)
+
+DEF_SYSREG_VGIC(HV_SYS_REG_CNTP_CTL_EL0, 3, 3, 14, 2, 1)
+DEF_SYSREG_VGIC(HV_SYS_REG_CNTP_CVAL_EL0, 3, 3, 14, 2, 2)
+#ifdef SYNC_NO_RAW_REGS
+DEF_SYSREG_VGIC(HV_SYS_REG_CNTP_TVAL_EL0, 3, 3, 14, 2, 0)
+#endif
+
+DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHCTL_EL2, 3, 4, 14, 1, 0)
+DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHP_CVAL_EL2, 3, 4, 14, 2, 2)
+DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHP_CTL_EL2, 3, 4, 14, 2, 1)
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


