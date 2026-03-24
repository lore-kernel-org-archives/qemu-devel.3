Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BD7F54ACF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53U7-0007It-8Z; Tue, 24 Mar 2026 11:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53T1-0005vS-0B
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:57 -0400
Received: from p-east2-cluster2-host9-snip4-3.eps.apple.com ([57.103.78.66]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Su-0005ug-Ol
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:50 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id
 5BE121816450; Tue, 24 Mar 2026 15:14:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774365283; x=1776957283;
 bh=zQcPeomdXccfH+MbZAPd430h2qraXqNbsqETIXZDarE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=dnuuG0YoKT07W9X6t0y9Uq9f2JjW7+OHA6N2p9QcfNxzBUCBE7SkOIzNoKQQpe5EF9lUuEiwAwfB9RuM+CziZm9nmHTiCcAgoSiTE8TSUYP8xDhC8NkcTLy9jHAvyjWxVDiK1T3/o8n1DBj5idQa60C9kmjiaTcW/MfPSGxlPFhEbjYc3LYA3G6PPx/FIA3PjOXV2kCuCQCG1BX5slr4P9UCi8NbqJ846s3HOR5B3bAXUCX6VlhgVLCFLTs9hfrqo/Ngw8Wx4o1JYhNsDft4u9ld+z6umbUo9s6eaFrXvU1Z5E3BMZ+4VEqZuZHYywlCXPZJ8C8imewq9Uxe6UE7IQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id
 0F36C1814D00; Tue, 24 Mar 2026 15:13:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v3 12/12] whpx: i386: fast runtime state reads
Date: Tue, 24 Mar 2026 16:13:23 +0100
Message-ID: <20260324151323.74473-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324151323.74473-1-mohamed@unpredictable.fr>
References: <20260324151323.74473-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69c2aa61
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=WK8LibQvd4XDxIxmQ_8A:9
X-Proofpoint-GUID: Oejcy40_NUbP154VkmSDFSXO-xZFPkw4
X-Proofpoint-ORIG-GUID: Oejcy40_NUbP154VkmSDFSXO-xZFPkw4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX0Mt18A5WgCh/
 a88coKuXK4Wpb2/XyZRbCR9rHkw3fl4g7Sfn5h2gWvJDgvvCTM0/BrdNNXigtGm5tGMaP5TQN4h
 iV1nmSV4rsefAy4ohYzC8seUyDkQwqDhXCMRYRLyLrKwgSLB4lkBcD+256BfLD02h4u2HBtQO4B
 M/rYace51fXvNHS1ZDqtgZDhbGYdURL+y7HkSbCsQpki1XitZPGVmrb2VtELZvCxUL6ZANNr3HG
 8o3O9RG+lU84Meb+OZWicp+OE8w89izP8abiIGdQouacbhWLuemqODGWMQqXNjczWjtV0no0fKj
 WMC7JxGbTLLagbR+Em1DpeQVLYhGpm17U85AXXAvsf47M64PE3eX8OOG/FFJQQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=790 malwarescore=0 suspectscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240119
Received-SPF: pass client-ip=57.103.78.66;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that there's an on-demand interface for fetching CRs
and segments, only query GPRs and query everything else
on-demand for vmexits.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 77 +++++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 7 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 6f23278642..acae61e089 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -156,6 +156,26 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
      */
 };
 
+static const WHV_REGISTER_NAME whpx_register_names_for_vmexit[] = {
+    /* X64 General purpose registers */
+    WHvX64RegisterRax,
+    WHvX64RegisterRcx,
+    WHvX64RegisterRdx,
+    WHvX64RegisterRbx,
+    WHvX64RegisterRsp,
+    WHvX64RegisterRbp,
+    WHvX64RegisterRsi,
+    WHvX64RegisterRdi,
+    WHvX64RegisterR8,
+    WHvX64RegisterR9,
+    WHvX64RegisterR10,
+    WHvX64RegisterR11,
+    WHvX64RegisterR12,
+    WHvX64RegisterR13,
+    WHvX64RegisterR14,
+    WHvX64RegisterR15,
+};
+
 struct whpx_register_set {
     WHV_REGISTER_VALUE values[RTL_NUMBER_OF(whpx_register_names)];
 };
@@ -593,6 +613,47 @@ static void whpx_get_xcrs(CPUState *cpu)
     cpu_env(cpu)->xcr0 = xcr0.Reg64;
 }
 
+static void whpx_get_registers_for_vmexit(CPUState *cpu, WHPXStateLevel level)
+{
+    struct whpx_state *whpx = &whpx_global;
+    AccelCPUState *vcpu = cpu->accel;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    struct whpx_register_set vcxt;
+    HRESULT hr;
+    int idx;
+    int idx_next;
+
+    assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
+
+    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index,
+        whpx_register_names_for_vmexit,
+        RTL_NUMBER_OF(whpx_register_names_for_vmexit),
+        &vcxt.values[0]);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get virtual processor context, hr=%08lx",
+                     hr);
+    }
+
+    idx = 0;
+
+    /* Indexes for first 16 registers match between HV and QEMU definitions */
+    idx_next = 16;
+    for (idx = 0; idx < CPU_NB_REGS; idx += 1) {
+        env->regs[idx] = vcxt.values[idx].Reg64;
+    }
+    idx = idx_next;
+
+    env->eip = vcpu->exit_ctx.VpContext.Rip;
+    env->eflags = vcpu->exit_ctx.VpContext.Rflags;
+    rflags_to_lflags(env);
+
+    assert(idx == RTL_NUMBER_OF(whpx_register_names_for_vmexit));
+
+    x86_update_hflags(env);
+}
+
 void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 {
     struct whpx_state *whpx = &whpx_global;
@@ -608,7 +669,11 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
-    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && !env->tsc_valid) {
+    if (level == WHPX_LEVEL_FAST_RUNTIME_STATE) {
+        return whpx_get_registers_for_vmexit(cpu, level);
+    }
+
+    if (!env->tsc_valid) {
         whpx_get_tsc(cpu);
         env->tsc_valid = !runstate_is_running();
     }
@@ -623,7 +688,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
                      hr);
     }
 
-    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && whpx_irqchip_in_kernel()) {
+    if (whpx_irqchip_in_kernel()) {
         /*
          * Fetch the TPR value from the emulated APIC. It may get overwritten
          * below with the value from CR8 returned by
@@ -680,7 +745,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     env->cr[4] = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterCr8);
     tpr = vcxt.values[idx++].Reg64;
-    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && tpr != vcpu->tpr) {
+    if (tpr != vcpu->tpr) {
         vcpu->tpr = tpr;
         cpu_set_apic_tpr(x86_cpu->apic_state, whpx_cr8_to_apic_tpr(tpr));
     }
@@ -691,9 +756,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
      * Extended control registers needs to be handled separately depending
      * on whether xsave is supported/enabled or not.
      */
-    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE) {
-        whpx_get_xcrs(cpu);
-    }
+    whpx_get_xcrs(cpu);
 
     /* 16 XMM registers */
     assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
@@ -768,7 +831,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names));
 
-    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && whpx_irqchip_in_kernel()) {
+    if (whpx_irqchip_in_kernel()) {
         whpx_apic_get(x86_cpu->apic_state);
     }
 
-- 
2.50.1 (Apple Git-155)


