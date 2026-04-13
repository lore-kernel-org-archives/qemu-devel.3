Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62983F34C62
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCJ90-00062h-83; Mon, 13 Apr 2026 11:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCJ8d-0005X3-Cv
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:23:49 -0400
Received: from qs-2005a-snip4-11.eps.apple.com ([57.103.86.141]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCJ8b-0000U6-6q
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:23:46 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id
 887EE1800190; Mon, 13 Apr 2026 15:23:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776093824; x=1778685824;
 bh=9UzhbHGn3KNjJvwbSrpYXcynAdkRNKmx/7n4duVcxcA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=H/EImIWWofNJ/oQKbexwojsmYODehcKiWx1+D1YO4/da+BGoqMY0AP137XniU3q9kjlcark1tCWc8PSDL/7p5TXi5L6NoRq/HOW6/3eb+CgAsVh/JVyVuOqGoIfqcbXbDvFKnqrkLfG9jN+wr29t+yVLSqNhl5qey8DzXKMj0dY60sQal75VcS8wpwwySDhIYQ8IZGwNREyzivfUpunbF5OwLc0plutHzLO0+fF8cGSrt5T3MN4HI+3UpZ+W2IFLuXAYQrKjqwDS+xup+YY1j+4NgDCikVeFYniepGOsEYJlZjunTdlto4Vn5XkEzg7nvN9Xz46/pFwxrkoqfldUig==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id
 55B831800108; Mon, 13 Apr 2026 15:23:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v10 08/14] whpx: i386: use WHvX64RegisterCr8 only when
 kernel-irqchip=off
Date: Mon, 13 Apr 2026 17:23:20 +0200
Message-ID: <20260413152326.63738-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413152326.63738-1-mohamed@unpredictable.fr>
References: <20260413152326.63738-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QFq6oXE-GucBxWpoaDEOgcIgS6MFCzpb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE1MSBTYWx0ZWRfX2ir0rUN0/guR
 p5lD/3cNAteQRsmvdQ+M2PVJ80laWdmQAJtKNQvQsTvHJeDHpsoiAEAz4oq+/Zj06cwTPoAHBuH
 tkdzdbmqaP5ntWsNTOX3eoGqckLm2ImqB930dgKxQg2aXejKjR+PfS/PE9AnJc3OwR9998WdCua
 VeLyg9ufSHGllfkSZbYt9ReQ+gv8XCRvHfEbAnXvThb/hDArTa8tVlhl0DHWUwUDroMJuBDgl77
 pbWW/V1IhJz/RvEAL77Sxl1P0VQyc/Vqmwcj/gCHEPDWn9d0q/IJdlW4+Y05rA4Lwd7nTd9luYP
 EIIptWsLYnYpAe6VFY5O+Pyi4M9NhXYYmYEgG234ctTnJocQFy4jlDi8nmsy3Q=
X-Authority-Info-Out: v=2.4 cv=Xqr3+FF9 c=1 sm=1 tr=0 ts=69dd0a7f
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=4IdwVP5-j8YZXVcKM5MA:9
X-Proofpoint-ORIG-GUID: QFq6oXE-GucBxWpoaDEOgcIgS6MFCzpb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxlogscore=867 bulkscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130151
Received-SPF: pass client-ip=57.103.86.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When kernel-irqchip=on, manage TPR as part of the APIC state instead entirely.

This fixes some failure to set state errors.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 62542922a4..74b94b799e 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -95,7 +95,6 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
     WHvX64RegisterCr2,
     WHvX64RegisterCr3,
     WHvX64RegisterCr4,
-    WHvX64RegisterCr8,
 
     /* X64 Debug Registers */
     /*
@@ -459,8 +458,11 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
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
 
@@ -716,11 +718,14 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
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
@@ -1660,7 +1665,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
     /* Sync the TPR to the CR8 if was modified during the intercept */
     tpr = cpu_get_apic_tpr(x86_cpu->apic_state);
-    if (tpr != vcpu->tpr) {
+    if (!whpx_irqchip_in_kernel() && tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
         reg_values[reg_count].Reg64 = tpr;
         qatomic_set(&cpu->exit_request, true);
@@ -1702,12 +1707,14 @@ static void whpx_vcpu_post_run(CPUState *cpu)
 
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


