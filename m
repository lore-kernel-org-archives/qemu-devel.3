Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4C6FA1FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfMM-0000OL-Ts; Wed, 22 Apr 2026 17:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfMG-0000BU-89
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:45 -0400
Received: from p-east2-cluster5-host9-snip4-1.eps.apple.com ([57.103.79.104]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfMD-0007mF-Lx
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:43 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 055FA18006F2; Wed, 22 Apr 2026 21:43:31 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlgGXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894218; x=1779486218;
 bh=Kn5qWVg//2Ad45UT8zwcr0uimx3B8gbWXGnh6Te9WXU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=GD/yfRt3ppu8b66v+LaQn+A6ewhNfvN0979/BygHWp2SBWF6AaMZOr3foqwuNGAKOJV/3vYbnVnOPGm5z4prgee0GsKIu7qTVzB40US40jTqsebOHjvXnqGx0S3oA+HUVTOWiJrTKbZIS81WHENUAVwZwr4fjgLdRApTAV3HqPvNvHO3d3i10RCh5NT/cdKthlGLgOczGCI1Us7Jql9XXJ3ySckcOfpKF/GtZxnf51IgAp8j82n4A5VZClBqXhMdSDxZ/+SgHUoVhbfVwyGaO56CVOs4ZzvwA3f9uk827y2e26w2ipuYQK7oZ0qCpWBav6o8D5OkxfWq3dbu+9tS3A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 8A3F01800230; Wed, 22 Apr 2026 21:43:29 +0000 (UTC)
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
Subject: [PATCH v3 33/37] target/i386: emulate, hvf: rdmsr/wrmsr GPF handling
Date: Wed, 22 Apr 2026 23:42:21 +0200
Message-ID: <20260422214225.2242-34-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMiBTYWx0ZWRfX/sjTyrXqbONY
 cXYQ+RVVvF5X4c8ppWRwXjW0xBF5Xi3G5GXU8gDy++Y6vhE5S5SBEd6gVFwFaT0SsjGAsWFWBvN
 lp8hroKT4kdo5Pjp/HCYv/lHdchud/SEcsjNtK/v1S7hqreEtS4dIdBwGd4/0M1QPdAxIjaBAh4
 EL97Uji7yu/Tww5wC7FCrOWQ/ojlrLbOle5lZMHm2goeJ0FeN0P9+KHLuP/FdfXVd/W922ksbO5
 S4iA2akdO4yvvlQ7rIftfCMfk/hH4TvFLxU2lIXi2TYrBEBCJsu7hmq/5zU+uq3lxBuT0IWmZj0
 4vcLm3jXQUvqvbYDtmeNHl+9eZeHC9TKJe+V4NGzVVb3SG6qSAJxYYAnTdRLfU=
X-Proofpoint-ORIG-GUID: sev8Q10vcorok3vUVoER2ip5t-DRIOfk
X-Authority-Info-Out: v=2.4 cv=Vrkuwu2n c=1 sm=1 tr=0 ts=69e94108
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=D0rFuASKtNlKNcT_3-8A:9
X-Proofpoint-GUID: sev8Q10vcorok3vUVoER2ip5t-DRIOfk
Received-SPF: pass client-ip=57.103.79.104;
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

In that case, the instruction pointer mustn't be incremented.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.c | 10 ++++++----
 target/i386/emulate/x86_emu.h |  4 ++--
 target/i386/hvf/hvf-i386.h    |  4 ++--
 target/i386/hvf/hvf.c         |  9 +++++++--
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index c2da1a133f..c6ea854290 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -792,15 +792,17 @@ void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_c
 
 static bool exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    emul_ops->simulate_rdmsr(env_cpu(env));
-    env->eip += decode->len;
+    if (!emul_ops->simulate_rdmsr(env_cpu(env))) {
+        env->eip += decode->len;
+    }
     return 0;
 }
 
 static bool exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    emul_ops->simulate_wrmsr(env_cpu(env));
-    env->eip += decode->len;
+    if (!emul_ops->simulate_wrmsr(env_cpu(env))) {
+        env->eip += decode->len;
+    }
     return 0;
 }
 
diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index a8d4c93098..b985240b90 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -31,8 +31,8 @@ struct x86_emul_ops {
     target_ulong (*read_cr) (CPUState *cpu, int cr);
     void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int direction,
                       int size, int count);
-    void (*simulate_rdmsr)(CPUState *cs);
-    void (*simulate_wrmsr)(CPUState *cs);
+    bool (*simulate_rdmsr)(CPUState *cs);
+    bool (*simulate_wrmsr)(CPUState *cs);
     bool (*is_protected_mode)(CPUState *cpu);
     bool (*is_long_mode)(CPUState *cpu);
     bool (*is_user_mode)(CPUState *cpu);
diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 8c42ae6b01..b91c17e2fc 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -19,8 +19,8 @@
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
 
 void hvf_handle_io(CPUState *, uint16_t, void *, int, int, int);
-void hvf_simulate_rdmsr(CPUState *cpu);
-void hvf_simulate_wrmsr(CPUState *cpu);
+bool hvf_simulate_rdmsr(CPUState *cpu);
+bool hvf_simulate_wrmsr(CPUState *cpu);
 
 /* Host specific functions */
 int hvf_inject_interrupt(CPUArchState *env, int vector);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index c0d028b147..dfe7500010 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -536,7 +536,7 @@ void hvf_store_regs(CPUState *cs)
     macvm_set_rip(cs, env->eip);
 }
 
-void hvf_simulate_rdmsr(CPUState *cs)
+bool hvf_simulate_rdmsr(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -557,6 +557,7 @@ void hvf_simulate_rdmsr(CPUState *cs)
         ret = apic_msr_read(cpu->apic_state, index, &val);
         if (ret < 0) {
             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
+            return 1;
         }
 
         break;
@@ -639,9 +640,10 @@ void hvf_simulate_rdmsr(CPUState *cs)
 
     RAX(env) = (uint32_t)val;
     RDX(env) = (uint32_t)(val >> 32);
+    return 0;
 }
 
-void hvf_simulate_wrmsr(CPUState *cs)
+bool hvf_simulate_wrmsr(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -657,6 +659,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
         r = cpu_set_apic_base(cpu->apic_state, data);
         if (r < 0) {
             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
+            return 1;
         }
 
         break;
@@ -668,6 +671,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
         ret = apic_msr_write(cpu->apic_state, index, data);
         if (ret < 0) {
             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
+            return 1;
         }
 
         break;
@@ -746,6 +750,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
          g_hypervisor_iface->wrmsr_handler(cs, msr, data);
 
     printf("write msr %llx\n", RCX(cs));*/
+    return 0;
 }
 
 static int hvf_handle_vmexit(CPUState *cpu)
-- 
2.50.1 (Apple Git-155)


