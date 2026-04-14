Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622DAF9D0F0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCiPa-000690-6f; Tue, 14 Apr 2026 14:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCiPU-00068N-AV
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:22:52 -0400
Received: from pv-2005g-snip4-11.eps.apple.com ([57.103.66.241]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCiPS-0006Uw-5t
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:22:51 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPS id
 1CEC01801395; Tue, 14 Apr 2026 18:22:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776190968; x=1778782968;
 bh=6lVPI+m1fDykLwqr3FmC9utzBoApYycYAPsCsYijeBQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JzfW61ZsLVqnaVpKRLOAkzyseZhn/VCpmqqOOGxiNQ0PvcrFWdEHv9Ey3kGonokeYsdMOJgJDJNhYZTN47yfLDhP7fUWiJgzgW+EXGbodqaTz7C6+mjafxGYZsNzzQK8StEnKGwm7GJVjL/SkYlHCD0U9V4/rSRmRBJBwwR/2iqMo6/q+urxkGwByKnbn5Y67/mwJ/4V5WVqzvr5tKqGMAXTIQdm/ZV03feRWmHXcbcfqe3kwbM6Ie3NGOSA7ZMXxIesm7T6I7BEWe/mlbjyHrg02Z+cvs2+SJJ5x9fwlNk8nwym33YDj4+tXBs5jeHYFF4xE126hmIDspYldScx5A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPSA id
 66EAB18001C2; Tue, 14 Apr 2026 18:22:45 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 7/7] whpx: i386: add HV_X64_MSR_GUEST_IDLE when !kernel-irqchip
Date: Tue, 14 Apr 2026 20:22:31 +0200
Message-ID: <20260414182231.18776-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260414182231.18776-1-mohamed@unpredictable.fr>
References: <20260414182231.18776-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=fuHRpV4f c=1 sm=1 tr=0 ts=69de85f7
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mSEN7FZ2dYRJNo9PPvgA:9
X-Proofpoint-ORIG-GUID: FxBd79eiJqztALedvUoGlk5Nlu3ocs-e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE3MiBTYWx0ZWRfX6myu1tomdZox
 hTEYjNabLO/AZB6oGv2F77fR//h/dKHjywXHdbECxgqM23pSOZvjtSECRIwsHehiTaA9MMiV1GI
 po/VuD7HZrLkU+TL7cbXM8K02fSkw/kfijz0b8qv70FmCozrJ4OHEZwfEeuycsq4Sh+MbyaooY/
 kd8Gi0v04LVR0suXIuYa/EgeZLkdtFdqvgEJKzeNVdzMH46DypAyH6lxMysgYV2Om6cA6/HsmP8
 pTji8UmipfZLKnN7IRNIeyORuwMwKM3EZw1t04FC7UEOv1vx4ybpxONRRdex/bhIEtZUU71ZT2D
 PX2r8cKxlRj0SlZGdGwUU9hexc/hn6OIojgM0cV65GBQttbKhjgwEH4ILmS6wg=
X-Proofpoint-GUID: FxBd79eiJqztALedvUoGlk5Nlu3ocs-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604140172
Received-SPF: pass client-ip=57.103.66.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Add support for an oddball HV_X64_MSR_GUEST_IDLE not-quite-an-HLT
that wakes the vCPU even if EFLAGS.IF is set.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 46 +++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2e6679f40b..7a157e6dae 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -52,6 +52,7 @@
 /* for kernel-irqchip=off */
 #define HV_X64_MSR_APIC_FREQUENCY       0x40000023
 #define HV_X64_MSR_VP_ASSIST_PAGE       0x40000073
+#define HV_X64_MSR_GUEST_IDLE           0x400000f0
 
 static bool is_modern_os = true;
 
@@ -1543,13 +1544,16 @@ static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
     }
 }
 
-static int whpx_handle_halt(CPUState *cpu)
+static int whpx_handle_halt_generic(CPUState *cpu)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
     int ret = 0;
 
     bql_lock();
     if (!(cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
-          (cpu_env(cpu)->eflags & IF_MASK)) &&
+          ((cpu_env(cpu)->eflags & IF_MASK) || env->hflags2 & HF2_HYPERV_HLT_MASK)) &&
         !cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         cpu->exception_index = EXCP_HLT;
         cpu->halted = true;
@@ -1560,6 +1564,27 @@ static int whpx_handle_halt(CPUState *cpu)
     return ret;
 }
 
+static int whpx_handle_halt(CPUState *cpu)
+{
+    int ret = 0;
+
+    ret = whpx_handle_halt_generic(cpu);
+
+    return ret;
+}
+
+static int whpx_handle_hyperv_guestidle(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    int ret = 0;
+
+    env->hflags2 |= HF2_HYPERV_HLT_MASK;
+    ret = whpx_handle_halt_generic(cpu);
+
+    return ret;
+}
+
 static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu) 
 {
     WHV_REGISTER_VALUE reg;
@@ -1631,7 +1656,8 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     /* Get pending hard interruption or replay one that was overwritten */
     if (!whpx_irqchip_in_kernel()) {
         if (!vcpu->interruption_pending &&
-            vcpu->interruptable && (env->eflags & IF_MASK)
+            vcpu->interruptable &&
+            ((env->eflags & IF_MASK) || env->hflags2 & HF2_HYPERV_HLT_MASK)
             && (vcpu->tpr < irr || irr == 0)) {
             assert(!new_int.InterruptionPending);
             if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
@@ -1763,9 +1789,10 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 
     if ((cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
-         (env->eflags & IF_MASK)) ||
+         ((env->eflags & IF_MASK) || env->hflags2 & HF2_HYPERV_HLT_MASK)) ||
         cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         cpu->halted = false;
+        env->hflags2 &= ~HF2_HYPERV_HLT_MASK;
     }
 
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SIPI)) {
@@ -2035,6 +2062,17 @@ int whpx_vcpu_run(CPUState *cpu)
                 }
             }
 
+            /* Windows and Linux both use this MSR. */
+            if (vcpu->exit_ctx.MsrAccess.MsrNumber == HV_X64_MSR_GUEST_IDLE
+                && !vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite
+                && !whpx_irqchip_in_kernel()
+                && whpx->hyperv_enlightenments_enabled) {
+                is_known_msr = 1;
+                whpx_bump_rip(cpu, &vcpu->exit_ctx);
+                ret = whpx_handle_hyperv_guestidle(cpu);
+                break;
+            }
+
             /*
              * Linux tries to use it anyway even when not exposed. 
              * Ignore the write as the VP assist page is not used.
-- 
2.50.1 (Apple Git-155)


