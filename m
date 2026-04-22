Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C150F94CC1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLs-0008Pp-Sp; Wed, 22 Apr 2026 17:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLp-0008Fu-6g
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:17 -0400
Received: from p-east2-cluster1-host10-snip4-1.eps.apple.com ([57.103.76.114]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLn-0007PE-Fx
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:16 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 481531800951; Wed, 22 Apr 2026 21:43:11 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlkBXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894194; x=1779486194;
 bh=YHkuVnpzX5n//Dg7yBbo00rWen0/V/dFS7/fQ041cHE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=dKcY0fb3KVSd0W5I0YxVNQXJI/bxpuVyi3/imm26XaPn98a81iRRw0dOUE4aBnMkIubANS28PSMqNyZrCBA0pM/JFpE4QXcpRIHAPLImx45Md8wjZzkjnoHGfBRQxPwX3qqdlnJD+TDhoVZ/2pEOYy9iC4JQw2uQM4ecXiIKZO9HB5DObg1gCKE2DQC6ARxv0Pr5toKU4Cwc9EKxWcA7NQ9n9Y42pOAAvEJn7OXevq93e4gL8NwAHSV/f8eiqP8ExRHAFnkfsvQAwKWl6hMJ49HJnucpsqpigUnRMXpVTF77Q/di0FYQ7VZSgPLOFpPgKkemLSSst95b5MdgmICWdg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 1F07C180021C; Wed, 22 Apr 2026 21:43:09 +0000 (UTC)
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
Subject: [PATCH v3 22/37] whpx: i386: add HV_X64_MSR_GUEST_IDLE when
 !kernel-irqchip
Date: Wed, 22 Apr 2026 23:42:10 +0200
Message-ID: <20260422214225.2242-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: m9g-lEtEjFVIUQr6zWpTvE6K5sgoJH9B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMiBTYWx0ZWRfX3M+Y4peERC38
 7TSnI8/XOW1AbsHICKYBKhc4uwQx/QURAOJWV1F2QoDjkKPgG0eitBMp9a1zhTavTEgSF47YcG2
 gbwue877SPgBfmfT3sE15jWi7Ru25yn29lD2J4YH+0x83tl1BNZfv72pBzPS3DMNgs3e9iXG8mV
 SZHfLkvdKlPSl91bp3OXvUjerc0qwbNr//Obp5fOdDeGjbibN4Fd5vm/BZOnlu0Rul0eshjq24F
 F6XSVbKC1m52KyLKyNgeHwlo6RUeIgRCWU7/2giN5qZp/PikdxTqdzcwQzUU+LVZOI/cvxNKelM
 zs3g5B9UF+iN4HphZ38RbxMbqwBEEJ/T/oIduYSVzqUlXAogMYJeOA+6tXrRUk=
X-Proofpoint-ORIG-GUID: m9g-lEtEjFVIUQr6zWpTvE6K5sgoJH9B
X-Authority-Info-Out: v=2.4 cv=VZL6/Vp9 c=1 sm=1 tr=0 ts=69e940f0
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mSEN7FZ2dYRJNo9PPvgA:9
Received-SPF: pass client-ip=57.103.76.114;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
index cafcbf8bbb..f03f5a5115 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -52,6 +52,7 @@
 /* for kernel-irqchip=off */
 #define HV_X64_MSR_APIC_FREQUENCY       0x40000023
 #define HV_X64_MSR_VP_ASSIST_PAGE       0x40000073
+#define HV_X64_MSR_GUEST_IDLE           0x400000f0
 
 static bool is_modern_os = true;
 
@@ -1628,13 +1629,16 @@ static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
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
@@ -1645,6 +1649,27 @@ static int whpx_handle_halt(CPUState *cpu)
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
@@ -1848,9 +1873,10 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 
     if ((cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
-         (env->eflags & IF_MASK)) ||
+         ((env->eflags & IF_MASK) || env->hflags2 & HF2_HYPERV_HLT_MASK)) ||
         cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         cpu->halted = false;
+        env->hflags2 &= ~HF2_HYPERV_HLT_MASK;
     }
 
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SIPI)) {
@@ -2120,6 +2146,20 @@ int whpx_vcpu_run(CPUState *cpu)
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


