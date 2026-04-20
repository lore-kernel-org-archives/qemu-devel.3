Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4783EF55810
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm6d-0007LR-B7; Mon, 20 Apr 2026 06:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6b-0007Ki-IV
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:53 -0400
Received: from p-west3-cluster6-host11-snip4-10.eps.apple.com ([57.103.75.33]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6a-0000gC-0M
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:53 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 C36E51800EC2; Mon, 20 Apr 2026 10:43:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681831; x=1779273831;
 bh=35AwHuK3FNutlfTTq4p+Vg27ixeNuT9FvPY378EVDsQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=g9dcsIzNLY+BJW6ySRkk7+o5tgxBqmVyDVPwi+qJaipyJZvst/WVPmngY1NI7elYXTYxGjayco4peUbdNExH23Kgxw8hN6E+6neNpFGm6ZG8IYNtwyQMtRAYIyQRsM8fWk5KJaRNvvSqOmjidJvhVR2lzBRa7F4zk5rdde7eUBwR/K26+W3oIQKMwh88DMkq4Mlestn20YuKwSpXqSeLNvuQqB7kTs3Rav4KajDhUb0TOfpCJLaIetSttyJ8KWKjGfyW9JZuiGgPxZqG2W8wViqKSTTIaONy8C5f0WGpRvxioPUIs+GsSgLb8QTc8+S2ixghzdoGwYq3gZmDTvSn7A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 3860218000A8; Mon, 20 Apr 2026 10:43:46 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 22/38] whpx: i386: add HV_X64_MSR_GUEST_IDLE when
 !kernel-irqchip
Date: Mon, 20 Apr 2026 12:42:32 +0200
Message-ID: <20260420104248.86702-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dE6Sy28pQ6v8HPLMu6rOC2g_RSQ33-4c
X-Authority-Info-Out: v=2.4 cv=DOGCIiNb c=1 sm=1 tr=0 ts=69e60365
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=mSEN7FZ2dYRJNo9PPvgA:9
X-Proofpoint-ORIG-GUID: dE6Sy28pQ6v8HPLMu6rOC2g_RSQ33-4c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfX/7s1U1iEpY8u
 ZJ2HMCKQaIoxG9HSWTjkfi5jX7O3mzViV6jBElXOxoBTyurbtq+LN/WgjirDgGQxJkIzTSB1U2J
 Rb6XaLeljwlP5V8WSRjrGAwBa25rbFzhBAksOW7VOAJITE5H9ZFHWYTDZeylu05nsV+nIGrqKMQ
 xIOqI6mTbBzxTWejXf+cIZnoZfxQEodb4HJXWu+KG1ktiD7Xk7BpyN3p7Cci8fKv0cdtr1/U/rF
 NJrRChgr61UTrYYIZLYaKxrIFs/oYmSLlnOL/nCTE06LAzVRVhr5KI7dHkdTY8dEv9Xn9DYk8xh
 xe4PHvaTz6HNxO/IyYImGhROQotso7+Brh2uHL69Fze17sQxglxo7IIlJibkkY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.75.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add support for an oddball HV_X64_MSR_GUEST_IDLE not-quite-an-HLT
that wakes the vCPU even if EFLAGS.IF is set.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 46 ++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 3af5f936d4..4dc4030d87 100644
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


