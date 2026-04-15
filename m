Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4A9F419A5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0JO-0007Hk-0W; Wed, 15 Apr 2026 09:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JM-0007Fz-HH
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:44 -0400
Received: from pv-2002c-snip4-11.eps.apple.com ([57.103.64.241]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JK-0004AE-Td
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:44 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id
 C41AE18000AA; Wed, 15 Apr 2026 13:29:40 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgDTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRNEwVSB11NVg1HD1geXBQXCEVDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAtIAVsHXwNFCEsBVAVdHEUBQARVGlMfHVYQUgBSD3IFVwhBCFMCUQRYGl8IGQ1AThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776259781; x=1778851781;
 bh=NdNHW+HU7nWqdCiVuwZpuQ7yi7ZDV/6IOnp123UbLOQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=byWOFmWKdpFZwrPvNbXBODDs5cBqtb1G9Hc2K9ndjzl0v/45H8eaQluoCqu+jnkfi+QodT8/ZMCY8RlucepTQaAqJ1a/ZuybjYCcA9PBGovY1StiZhFR4+26IKbdVIm2rY0cJNFYEutTbw+RVZaK8sKu9CigBrxT3Wx2WxNoXEo0tse2O6Rwym9H4m6ymK4pawjvvmMvEcICdv8dvXpxRjNVsRkXFTEiv/p6FA71vYFZonBhzjbPE6BKh2gp0YqxF0957O9caQGNKvE9ELih9WhoRqNwp9IGMJHahsEI0NtyOvWvvZ3qBzf0x62k0yVCJUzvKlJyfk/W4tp9cwmh4g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id
 721B3180034B; Wed, 15 Apr 2026 13:29:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v2 07/10] whpx: i386: add HV_X64_MSR_GUEST_IDLE when
 !kernel-irqchip
Date: Wed, 15 Apr 2026 15:29:23 +0200
Message-ID: <20260415132926.58878-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260415132926.58878-1-mohamed@unpredictable.fr>
References: <20260415132926.58878-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FbdWsunsJBF2P3nOeWjcK73nI0VSS4Rq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEyNSBTYWx0ZWRfX6CPToTixMAlv
 WNndKgmKL6BgyR40FIrwzEc7iWmmCtgourLXOLjBE/DHAX2GcMnzODwjjsb9DXOrcpV6MBI9YPC
 r1lEiemVRByGWchK00NudttFM0OF9MM/ewxriwi1ZLlC/ZRoJ3ThfrYIOdOsDaZ0m010u85enlQ
 o7N+bahrqHeMP9HOhe2T7GiuNPdZD7h77/Nd95Lb2DLvjxWmEjZCXdnghsXGf4htT6TfR/ii3Yx
 C+8UjwdAPqAQFVtGhbzSdBd1WjLrFxR5Nnmh0+EA7myNnAzQWlqZm9JTI47eFOTIQWQ7iBLyj73
 ROxw3hPB0ez29u4AKVmq/2aHKpQjf9BWQ1cADa4XeaYuqH6haHnporkyV+ELi4=
X-Authority-Info-Out: v=2.4 cv=Cu2ys34D c=1 sm=1 tr=0 ts=69df92c4
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mSEN7FZ2dYRJNo9PPvgA:9
X-Proofpoint-GUID: FbdWsunsJBF2P3nOeWjcK73nI0VSS4Rq
Received-SPF: pass client-ip=57.103.64.241;
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
 target/i386/whpx/whpx-all.c | 46 ++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2e6679f40b..0b89fe093f 100644
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
@@ -1763,9 +1788,10 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 
     if ((cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
-         (env->eflags & IF_MASK)) ||
+         ((env->eflags & IF_MASK) || env->hflags2 & HF2_HYPERV_HLT_MASK)) ||
         cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         cpu->halted = false;
+        env->hflags2 &= ~HF2_HYPERV_HLT_MASK;
     }
 
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SIPI)) {
@@ -2035,6 +2061,20 @@ int whpx_vcpu_run(CPUState *cpu)
                 }
             }
 
+            /*
+             * Windows and Linux both use this MSR.
+             * Windows 11 25H2 uses it even when not advertised.
+             */
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


