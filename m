Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D58FA1FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLQ-0007yH-3t; Wed, 22 Apr 2026 17:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLO-0007x9-O1
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:50 -0400
Received: from p-east2-cluster1-host9-snip4-7.eps.apple.com ([57.103.76.110]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLM-00071f-QA
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:50 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 013DA18000A2; Wed, 22 Apr 2026 21:42:43 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlMfHVYQUgBSD3IFVwhBCFMCUQRYGl8IGQ1AThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894167; x=1779486167;
 bh=LbkTYL/emjmTtubWjDApjBeMnmXQk5lJhboi+ilmPdI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OcDqLMVLbKrAX4gUijebvDmSSvaJKZB2PFrIR4tgp2VD5rIpeZuF/tP8EegcxuWcsOlLgZvow+6Q5yc6EpW4Pf5li3Y/nny7Hejaur7OyCBo1R6272LJHD0ATp1o1y92FqbPskvxr5onBx67Q1HoJWE9tXDuZbtXfP4EO4RgmP5QxRShAhap3tXezlfCIihRiZ8cleL5UnWC5Yzw4FUtKHSp6ocYdQ9TA0BbZvRSDpuNu+wriCy/wskyPJZX9tYWxTKqH2ag/TZSqR0/Snp1ivBDlH19oBtqB5iq5rEHbUN6+MUEAP9v+QTOpBUzR1+evOjpkHstKqMKsF83B6PdLw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 512E918000CB; Wed, 22 Apr 2026 21:42:41 +0000 (UTC)
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
Subject: [PATCH v3 07/37] whpx: i386: introduce proper cpuid support
Date: Wed, 22 Apr 2026 23:41:55 +0200
Message-ID: <20260422214225.2242-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9LtywL4pZIm3GB1pDvAZno_gE8i2zlGW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfX1KI+PadiQ2JO
 dR5C7bw8IJLpHo+M3NmdX4G2sIcpzVP6UKlZ6F8A+6UsJeaBcmP9AG92h0GprUYBGTBq5zjddX8
 N2TJj1L0pIaLr9q9ClInSFLR10hKfe8BhL6MazpdNvP5Ahor9hj8zB/p+XKKIWQg6XqCCAdrpNk
 bquORuOP4ZL02iYoNcKrQQjC5nBLU6XugTX4BAgn1phadjK3JzhBbbrNC/Ytu0UxYkbzdeUGq5f
 qOOAjzQ1dGyq1AUHOgybzz9BGXPCIkduLIA/ESo1URcFfTB17rQ9plThCM9MBKG/iMJiONvBHuE
 nSP8cwtwtD8rt/83D3mmxdZYXMF/eZtjn0T46IgZzdVFRFMHNdKhv3tYgnRFYM=
X-Authority-Info-Out: v=2.4 cv=XaGEDY55 c=1 sm=1 tr=0 ts=69e940d5
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mDV3o1hIAAAA:8 a=raKznI45vfUyTbRhOY0A:9
X-Proofpoint-ORIG-GUID: 9LtywL4pZIm3GB1pDvAZno_gE8i2zlGW
Received-SPF: pass client-ip=57.103.76.110;
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

Unlike the implementation in QEMU 10.2, this one works.

It's not optimal though as it doesn't use the Hyper-V support for this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c        | 136 +++++++++++++++++++++++++----
 target/i386/whpx/whpx-cpu-legacy.c |  15 +---
 2 files changed, 122 insertions(+), 29 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index f9f330c038..73e351d895 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2168,18 +2168,11 @@ int whpx_vcpu_run(CPUState *cpu)
                 vcpu->exit_ctx.VpContext.Rip +
                 vcpu->exit_ctx.VpContext.InstructionLength;
 
-            if (whpx_is_legacy_os()) {
-                reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
-                reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
-                reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
-                reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
-            } else {
-                cpu_x86_cpuid(env, vcpu->exit_ctx.CpuidAccess.Rax,
-                    vcpu->exit_ctx.CpuidAccess.Rcx,
-                    (UINT32 *)&reg_values[1].Reg32,
-                    (UINT32 *)&reg_values[4].Reg32, (UINT32 *)&reg_values[2].Reg32,
-                    (UINT32 *)&reg_values[3].Reg32);
-            }
+             cpu_x86_cpuid(env, vcpu->exit_ctx.CpuidAccess.Rax,
+                vcpu->exit_ctx.CpuidAccess.Rcx,
+                (UINT32 *)&reg_values[1].Reg32,
+                (UINT32 *)&reg_values[4].Reg32, (UINT32 *)&reg_values[2].Reg32,
+                (UINT32 *)&reg_values[3].Reg32);
 
             if (!whpx->hyperv_enlightenments_enabled) {
                 switch (vcpu->exit_ctx.CpuidAccess.Rax) {
@@ -2220,6 +2213,68 @@ int whpx_vcpu_run(CPUState *cpu)
                     }
                     break;
                 }
+            } else {
+                switch (vcpu->exit_ctx.CpuidAccess.Rax) {
+                case 0x40000000:
+                case 0x40000001:
+                case 0x40000010:
+                    reg_values[1].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
+                    reg_values[2].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
+                    reg_values[3].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
+                    reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+                    break;
+                }
+            }
+
+            if (vcpu->exit_ctx.CpuidAccess.Rax == 0x1) {
+                if (cpu_has_x2apic_feature(env)) {
+                    reg_values[2].Reg64 |= CPUID_EXT_X2APIC;
+                } else {
+                    reg_values[2].Reg32 &= ~CPUID_EXT_X2APIC;
+                }
+            }
+
+            /* Dynamic depending on XCR0 and XSS, so query DefaultResult */
+            if (vcpu->exit_ctx.CpuidAccess.Rax == 0x07
+                && vcpu->exit_ctx.CpuidAccess.Rcx == 0) {
+                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRdx
+                    & CPUID_7_0_EDX_CET_IBT) {
+                    reg_values[3].Reg32 |= CPUID_7_0_EDX_CET_IBT;
+                } else {
+                    reg_values[3].Reg32 &= ~CPUID_7_0_EDX_CET_IBT;
+                }
+
+                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRcx
+                    & CPUID_7_0_ECX_CET_SHSTK) {
+                    reg_values[2].Reg32 |= CPUID_7_0_ECX_CET_SHSTK;
+                } else {
+                    reg_values[2].Reg32 &= ~CPUID_7_0_ECX_CET_SHSTK;
+                }
+
+                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRcx
+                    & CPUID_7_0_ECX_OSPKE) {
+                    reg_values[2].Reg32 |= CPUID_7_0_ECX_OSPKE;
+                } else {
+                    reg_values[2].Reg32 &= ~CPUID_7_0_ECX_OSPKE;
+                }
+            }
+
+            /* CPUID[0xD,{1,2}].EBX are dynamic depending on guest features. */
+            if (vcpu->exit_ctx.CpuidAccess.Rax == 0xd) {
+                if (vcpu->exit_ctx.CpuidAccess.Rcx == 1
+                    || vcpu->exit_ctx.CpuidAccess.Rcx == 2) {
+                    reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
+                }
+            }
+
+            /* OSXSAVE is dynamic. Do this instead of syncing CR4 */
+            if (vcpu->exit_ctx.CpuidAccess.Rax == 1) {
+                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRcx
+                    & CPUID_EXT_OSXSAVE) {
+                    reg_values[2].Reg32 |= CPUID_EXT_OSXSAVE;
+                } else {
+                    reg_values[2].Reg32 &= ~CPUID_EXT_OSXSAVE;
+                }
             }
 
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
@@ -2409,6 +2464,45 @@ error:
     return ret;
 }
 
+static void whpx_cpu_xsave_init(void)
+{
+    static bool first = true;
+    int i;
+
+    if (!first) {
+        return;
+    }
+    first = false;
+
+    /* x87 and SSE states are in the legacy region of the XSAVE area. */
+    x86_ext_save_areas[XSTATE_FP_BIT].offset = 0;
+    x86_ext_save_areas[XSTATE_SSE_BIT].offset = 0;
+
+    for (i = XSTATE_SSE_BIT + 1; i < XSAVE_STATE_AREA_COUNT; i++) {
+        ExtSaveArea *esa = &x86_ext_save_areas[i];
+
+        if (esa->size) {
+            int sz = whpx_get_supported_cpuid(0xd, i, R_EAX);
+            if (sz != 0) {
+                assert(esa->size == sz);
+                esa->offset = whpx_get_supported_cpuid(0xd, i, R_EBX);
+            }
+        }
+    }
+}
+
+static void whpx_cpu_max_instance_init(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+
+    env->cpuid_min_level =
+        whpx_get_supported_cpuid(0x0, 0, R_EAX);
+    env->cpuid_min_xlevel =
+        whpx_get_supported_cpuid(0x80000000, 0, R_EAX);
+    env->cpuid_min_xlevel2 =
+        whpx_get_supported_cpuid(0xC0000000, 0, R_EAX);
+}
+
 static PropValue whpx_default_props[] = {
     { "x2apic", "on" },
     { NULL, NULL },
@@ -2418,9 +2512,18 @@ static PropValue whpx_default_props[] = {
 void whpx_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
     host_cpu_instance_init(cpu);
     x86_cpu_apply_props(cpu, whpx_default_props);
+
+    if (xcc->max_features) {
+        whpx_cpu_max_instance_init(cpu);
+    }
+
+    if (whpx_has_xsave()) {
+        whpx_cpu_xsave_init();
+    }
 }
 
 /*
@@ -2438,8 +2541,11 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_CAPABILITY_FEATURES features = {0};
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
-    UINT32 cpuidExitList[] = {1};
-    UINT32 cpuidExitList_nohyperv[] = {1, 0x40000000, 0x40000001, 0x40000010};
+
+    UINT32 cpuidExitList[] = {0x0, 0x1, 0x6, 0x7, 0xb, 0xd, 0x14, 0x24, 0x29, 0x1E,
+        0x40000000, 0x40000001, 0x40000010, 0x80000000, 0x80000001,
+        0x80000002, 0x80000003, 0x80000004, 0x80000007, 0x80000008,
+        0x8000000A, 0x80000021, 0x80000022, 0xC0000000, 0xC0000001};
 
     whpx = &whpx_global;
 
@@ -2698,7 +2804,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     hr = whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
         WHvPartitionPropertyCodeCpuidExitList,
-        whpx->hyperv_enlightenments_enabled ? cpuidExitList : cpuidExitList_nohyperv,
+        cpuidExitList,
         RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
 
     if (FAILED(hr)) {
diff --git a/target/i386/whpx/whpx-cpu-legacy.c b/target/i386/whpx/whpx-cpu-legacy.c
index 477429b460..d341e6f4fd 100644
--- a/target/i386/whpx/whpx-cpu-legacy.c
+++ b/target/i386/whpx/whpx-cpu-legacy.c
@@ -4,20 +4,7 @@
  *  Copyright (c) 2003 Fabrice Bellard
  *  Copyright (c) 2017 Google Inc.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * cpuid
+ * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 
 #include "qemu/osdep.h"
-- 
2.50.1 (Apple Git-155)


