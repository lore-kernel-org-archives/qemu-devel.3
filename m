Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455A5FA1FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLU-00080z-Cq; Wed, 22 Apr 2026 17:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLP-0007xh-MM
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:51 -0400
Received: from p-east2-cluster1-host3-snip4-4.eps.apple.com ([57.103.76.7]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLN-00073Z-JK
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:51 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 3BA5018006EB; Wed, 22 Apr 2026 21:42:47 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGloCXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894168; x=1779486168;
 bh=xC+Bs3uetls1lV4cbRHxGlDX60WBtwmt4XZ2tgs35W4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=FX8zhnx9un9lq+vPVZR/6suJow+FoEhwvsex4G9QGjBpFeRiLskhaGCAUdw/ZwvXWif0AnE7u93dv/0rywtMCnLuFyC1XC/sZmPPVx3kNFpW9n35aEBY2pHXxOXiNdqmhgsnHJy19layazFBqA2f4f4cgr9bNwvktKl/tW8j8BLLaPpVSqAq+aexhR392mc+8SrevRzly5d8/+EhWzgtf9BtmAMraaJx3u8x1SbH+0E8mhBwOnJM6RICwIKm0Ffykgu9mrkhH36tOnE7NKsi/SV7YnZjWUBBiKn5yXYgf93Bd/DEakHQfBT1O0U2r0CLBmahd+zdz+ewhr3+s7uALg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 F33FD18006EF; Wed, 22 Apr 2026 21:42:44 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 09/37] whpx: i386: use WHvX64RegisterCr8 only when
 kernel-irqchip=off
Date: Wed, 22 Apr 2026 23:41:57 +0200
Message-ID: <20260422214225.2242-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Z5xbyGaJV_Pcac9j1vRLLqbhhM1-6Ptm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfX1cBEdaCOIBYI
 eFHc9mYgGClgsMvCEs8kl8TlAmJrihicnPiqjpEf82VCBYRNEqWAcmjVfFcLpStA8Udm0kF6wvW
 WeRznUely+ou/1QLaeUabqA4T9t9aGYx0eZ7b7LY27WOsip/gZSM/9+x3Zns0eDs2eWljTXvwOB
 nfKpXOyqBvQBjNntsBjt7ObET6JRi8pjjt0az3d6fuo3p11eOr/pGFJu31yjIdXFcC3P7JtfJDS
 vu/ZV+eVp+FdWmno+Y2WITWiuWUgfpehT5w16BrvE/fPUPF9nBV3BuizdPMQ7bDH6ERoC9qsq+H
 +flNOQVWZk7CRG8w6ePvq6EpJrPEn+Zp2TaLoT8t+KCShfjkeKxVYlgSoCE3z0=
X-Authority-Info-Out: v=2.4 cv=Kf/fcAYD c=1 sm=1 tr=0 ts=69e940d8
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CtoYo02lv3ougeLbNZoA:9
X-Proofpoint-GUID: Z5xbyGaJV_Pcac9j1vRLLqbhhM1-6Ptm
Received-SPF: pass client-ip=57.103.76.7;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When kernel-irqchip=on, manage TPR as part of the APIC state instead entirely.

This fixes some failure to set state errors.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index d470c5b9d3..03c146dfb8 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -95,7 +95,6 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
     WHvX64RegisterCr2,
     WHvX64RegisterCr3,
     WHvX64RegisterCr4,
-    WHvX64RegisterCr8,
 
     /* X64 Debug Registers */
     /*
@@ -478,8 +477,11 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
         vcxt.values[idx++].Reg64 = env->cr[3];
         assert(whpx_register_names[idx] == WHvX64RegisterCr4);
         vcxt.values[idx++].Reg64 = env->cr[4];
-        assert(whpx_register_names[idx] == WHvX64RegisterCr8);
-        vcxt.values[idx++].Reg64 = vcpu->tpr;
+        /* For kernel-irqchip=on, TPR is managed as part of APIC state */
+        if (!whpx_irqchip_in_kernel()) {
+            WHV_REGISTER_VALUE cr8 = {.Reg64 = vcpu->tpr};
+            whpx_set_reg(cpu, WHvX64RegisterCr8, cr8);
+        }
 
         /* 8 Debug Registers - Skipped */
 
@@ -735,11 +737,14 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     env->cr[3] = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterCr4);
     env->cr[4] = vcxt.values[idx++].Reg64;
-    assert(whpx_register_names[idx] == WHvX64RegisterCr8);
-    tpr = vcxt.values[idx++].Reg64;
-    if (tpr != vcpu->tpr) {
-        vcpu->tpr = tpr;
-        cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
+
+    /* For kernel-irqchip=on, TPR is managed as part of APIC state */
+    if (!whpx_irqchip_in_kernel()) {
+        tpr = vcpu->exit_ctx.VpContext.Cr8;
+        if (tpr != vcpu->tpr) {
+            vcpu->tpr = tpr;
+            cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
+        }
     }
 
     /* 8 Debug Registers - Skipped */
@@ -1745,7 +1750,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
     /* Sync the TPR to the CR8 if was modified during the intercept */
     tpr = cpu_get_apic_tpr(x86_cpu->apic_state);
-    if (tpr != vcpu->tpr) {
+    if (!whpx_irqchip_in_kernel() && tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
         reg_values[reg_count].Reg64 = tpr;
         qatomic_set(&cpu->exit_request, true);
@@ -1787,12 +1792,14 @@ static void whpx_vcpu_post_run(CPUState *cpu)
 
     env->eflags = vcpu->exit_ctx.VpContext.Rflags;
 
-    uint64_t tpr = vcpu->exit_ctx.VpContext.Cr8;
-    if (vcpu->tpr != tpr) {
-        vcpu->tpr = tpr;
-        bql_lock();
-        cpu_set_apic_tpr(x86_cpu->apic_state, vcpu->tpr);
-        bql_unlock();
+    if (!whpx_irqchip_in_kernel()) {
+        uint64_t tpr = vcpu->exit_ctx.VpContext.Cr8;
+        if (vcpu->tpr != tpr) {
+            vcpu->tpr = tpr;
+            bql_lock();
+            cpu_set_apic_tpr(x86_cpu->apic_state, vcpu->tpr);
+            bql_unlock();
+        }
     }
 
     vcpu->interruption_pending =
-- 
2.50.1 (Apple Git-155)


