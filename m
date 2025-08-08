Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF35C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukH7M-0006BR-Oq; Fri, 08 Aug 2025 03:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH77-000689-3Y
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:02:05 -0400
Received: from p-east3-cluster5-host4-snip4-10.eps.apple.com ([57.103.86.171]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH75-0005G1-AE
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:02:04 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPS id
 0090C180012E; Fri,  8 Aug 2025 07:01:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=Y1BLofzvzOyvUyrQGqExglby6i74ucZ7Huh1krTE/9k=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=FUMeiQjKTE/uB59nIBm/SYmovKV9MfMId8gxKsN1rt9XZ/YDAEO0nf8JX4RTJZ/1HhHpKD94vF9+ULNugrZH4/tkr5roq3wz1MPLpIiO6kzbO6NW3U45/o1To0lQKwEoRgVOARGPbWwwuTAJbFUNf7vP+f0iHMO+GYQcLWfw3BXeUGXNL9pl43/tUPBgiem8E8QuEQSuVCpj5yo/3mWj3ruPBYZS0z1+4hx4o2RpTxIYmqzwVEmPZE2ujp9/ozVGUc+Qxqmn4xspC4KdWdhZiVUeBT8U0jnE6fmQHGoMaCGqwKKQFmHixzqyoa3wPcisvWOtF9yIoLPYC72DM0PVLg==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPSA id
 CEDEF18000AC; Fri,  8 Aug 2025 07:01:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 10/13] hvf: sync registers used at EL2
Date: Fri,  8 Aug 2025 09:01:34 +0200
Message-Id: <20250808070137.48716-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250808070137.48716-1-mohamed@unpredictable.fr>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA1NyBTYWx0ZWRfXzjWw+Evw2XDI
 RA7MaKk9nBcHkGkL1/2kPmKeOWluxVyH5zT7+Fw8hzBBhL0i2HBBIzfh6ZAGOmiDxD7qwwjz8+9
 qerpdG9rsJ5Qlsq0kSi0nQmQxPM98alkAruHlmwR9s8eB1Ol11kZZTW3eg6zKVlUUWkE0UWrXcP
 BcP1sIJvLvBH8CiBGLb5YSr7bI34dL6LMhDutJhtFJlN7vl1BZiRpnO95dV+pl+rw5GWWJyy07t
 OmpoIgWU3pFsiGMh9n5U9NzG5kstBjwT/tYeGuRW2uhrngiR0IFXojEK89PBJF26c8Ijf7peQ=
X-Proofpoint-ORIG-GUID: BZ1UfJon9s26B2ofFzJYRy4xDa1qT78i
X-Proofpoint-GUID: BZ1UfJon9s26B2ofFzJYRy4xDa1qT78i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxlogscore=875 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 clxscore=1030 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508080057
Received-SPF: pass client-ip=57.103.86.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When starting up the VM at EL2, more sysregs are available. Sync the state of those.

In addition, sync the state of the EL1 physical timer when the vGIC is used, even
if running at EL1. However, no OS running at EL1 is expected to use those registers.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d8741f942d..41b4321b0b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -406,6 +406,8 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
 struct hvf_sreg_match {
     int reg;
     uint32_t key;
+    bool vgic;
+    bool el2;
     uint32_t cp_idx;
 };
 
@@ -551,6 +553,41 @@ static struct hvf_sreg_match hvf_sreg_match[] = {
     { HV_SYS_REG_CNTV_CTL_EL0, HVF_SYSREG(14, 3, 3, 3, 1) },
     { HV_SYS_REG_CNTV_CVAL_EL0, HVF_SYSREG(14, 3, 3, 3, 2) },
     { HV_SYS_REG_SP_EL1, HVF_SYSREG(4, 1, 3, 4, 0) },
+    /* vGIC */
+    { HV_SYS_REG_CNTP_CTL_EL0, HVF_SYSREG(14, 2, 3, 3, 1), true },
+    { HV_SYS_REG_CNTP_CVAL_EL0, HVF_SYSREG(14, 2, 3, 3, 2), true },
+#ifdef SYNC_NO_RAW_REGS
+    { HV_SYS_REG_CNTP_TVAL_EL0, HVF_SYSREG(14, 2, 3, 3, 0), true},
+#endif
+    /* vGIC + EL2 */
+    { HV_SYS_REG_CNTHCTL_EL2, HVF_SYSREG(14, 1, 3, 4, 0), true, true },
+    { HV_SYS_REG_CNTHP_CVAL_EL2, HVF_SYSREG(14, 2, 3, 4, 2), true, true },
+    { HV_SYS_REG_CNTHP_CTL_EL2, HVF_SYSREG(14, 2, 3, 4, 1), true, true },
+#ifdef SYNC_NO_RAW_REGS
+    { HV_SYS_REG_CNTHP_TVAL_EL2, HVF_SYSREG(14, 2, 3, 4, 0), true, true },
+#endif
+    { HV_SYS_REG_CNTVOFF_EL2, HVF_SYSREG(14, 0, 3, 4, 3), true, true },
+    /* EL2 */
+    { HV_SYS_REG_CPTR_EL2, HVF_SYSREG(1, 1, 3, 4, 2), .el2 = true },
+    { HV_SYS_REG_ELR_EL2, HVF_SYSREG(4, 0, 3, 4, 1), .el2 = true },
+    { HV_SYS_REG_ESR_EL2, HVF_SYSREG(5, 2, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_FAR_EL2, HVF_SYSREG(6, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_HCR_EL2, HVF_SYSREG(1, 1, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_HPFAR_EL2, HVF_SYSREG(6, 0, 3, 4, 4), .el2 = true },
+    { HV_SYS_REG_MAIR_EL2, HVF_SYSREG(10, 2, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_MDCR_EL2, HVF_SYSREG(1, 1, 3, 4, 1), .el2 = true },
+    { HV_SYS_REG_SCTLR_EL2, HVF_SYSREG(1, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_SPSR_EL2, HVF_SYSREG(4, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_SP_EL2, HVF_SYSREG(4, 1, 3, 6, 0), .el2 = true},
+    { HV_SYS_REG_TCR_EL2, HVF_SYSREG(2, 0, 3, 4, 2), .el2 = true },
+    { HV_SYS_REG_TPIDR_EL2, HVF_SYSREG(13, 0, 3, 4, 2), .el2 = true },
+    { HV_SYS_REG_TTBR0_EL2, HVF_SYSREG(2, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_TTBR1_EL2, HVF_SYSREG(2, 0, 3, 4, 1), .el2 = true },
+    { HV_SYS_REG_VBAR_EL2, HVF_SYSREG(12, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_VMPIDR_EL2, HVF_SYSREG(0, 0, 3, 4, 5), .el2 = true },
+    { HV_SYS_REG_VPIDR_EL2, HVF_SYSREG(0, 0, 3, 4, 0), .el2 = true },
+    { HV_SYS_REG_VTCR_EL2, HVF_SYSREG(2, 1, 3, 4, 2), .el2 = true },
+    { HV_SYS_REG_VTTBR_EL2, HVF_SYSREG(2, 1, 3, 4, 0), .el2 = true },
 };
 
 int hvf_get_registers(CPUState *cpu)
@@ -594,6 +631,14 @@ int hvf_get_registers(CPUState *cpu)
             continue;
         }
 
+        if (hvf_sreg_match[i].vgic && !hvf_irqchip_in_kernel()) {
+            continue;
+        }
+
+        if (hvf_sreg_match[i].el2 && !hvf_arm_el2_enabled()) {
+            continue;
+        }
+
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
             switch (hvf_sreg_match[i].reg) {
@@ -731,6 +776,14 @@ int hvf_put_registers(CPUState *cpu)
             continue;
         }
 
+        if (hvf_sreg_match[i].vgic && !hvf_irqchip_in_kernel()) {
+            continue;
+        }
+
+        if (hvf_sreg_match[i].el2 && !hvf_arm_el2_enabled()) {
+            continue;
+        }
+
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
             switch (hvf_sreg_match[i].reg) {
-- 
2.39.5 (Apple Git-154)


