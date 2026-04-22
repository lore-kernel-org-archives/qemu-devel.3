Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1BAFA1FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLK-0007tM-9a; Wed, 22 Apr 2026 17:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLI-0007sn-8p
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:44 -0400
Received: from p-east2-cluster1-host2-snip4-4.eps.apple.com ([57.103.76.37]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLF-0006wp-7q
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:42:43 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 7E86E1800951; Wed, 22 Apr 2026 21:42:36 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGl8fHVYQUgBSD3IFVwhBCFMCUQRYGl8IGQ1AThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894160; x=1779486160;
 bh=IeLwDiWpTVXNjCjqgANs/S5+IQILH2QyjipMpqv8C+Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cYT/Cn2aYPmMCxi2xzJj+7HDU+h1h5mjj2u4I+Pmv80cGHYghEhRRtNdzrZu1kAN9ZoXnE2yIrUqFcsHWm4FAcxlVuj7HraDiHicpOigeXtgB2kR8qGiRzHoN3b5hl1VMR3GF1NCiNThYmKcbkADAVkrByqvrGfkg9TvJnC24NIJ9H6UAvKws8vaHMhjuJLgNxP0s5HslhmUDd0WDzi6t5csRCrXMr4uI7jd/5KfC+n7S9KrU3Kci9Dh3tQYRijlKCF6qX+uTPXWS63TBH4xWNZu1Ri1Gndb5W0JdeQc2Kniyrk2/HODZP/7WjaObRpm96S0jQsF6txIpC2UGEv1rQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 D074418006EB; Wed, 22 Apr 2026 21:42:33 +0000 (UTC)
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
Subject: [PATCH v3 03/37] whpx: i386: wire up feature probing
Date: Wed, 22 Apr 2026 23:41:51 +0200
Message-ID: <20260422214225.2242-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bGkY5p5kwID_cDFf8wnwCNpgda7jZX8w
X-Proofpoint-ORIG-GUID: bGkY5p5kwID_cDFf8wnwCNpgda7jZX8w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMSBTYWx0ZWRfX2G1pS9R0xnua
 dJ1Iq8BlHu25mfbpVpoaXdkoEIDKOdiX+Fq/RlrW9fm1ZkM6L+UH4N6tt+XrTBTYMwSCqeVpJQR
 mbhRFS78Y3dgX8P+lrhxCDuZmBWsSUwR5SQB+MYUfRH71wvG/NcU0PDpCbOJs03yYbNwcLLHOxQ
 L8AhSe1NghE6NF65+GdArppZO6DGJoKeasdEBfLlBoLI+cyZD28547k/hpTDFKeR8PPUYqnkUTR
 HTIAOmtpif3hoG/juihay5w2K76IvXGd4BqNwK8zMvM2rge16WoWo0g6eVynot+jpoO6zsViAr9
 6NS/W6w41/hSJFcHUEI8SWZLb6EIOQvZIeVjH8jsPmchezSG5joh94ygEt7lFM=
X-Authority-Info-Out: v=2.4 cv=b7e/I9Gx c=1 sm=1 tr=0 ts=69e940ce
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mDV3o1hIAAAA:8 a=E2jrspqCZx2CoTvb7ogA:9
Received-SPF: pass client-ip=57.103.76.37;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

Windows 10 doesn't have the API for this, so using this
only for Windows 11.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 include/system/whpx-internal.h     |   9 ++
 target/i386/cpu.c                  |  17 +++
 target/i386/whpx/meson.build       |   1 +
 target/i386/whpx/whpx-all.c        | 165 +++++++++++++++++++++++++++-
 target/i386/whpx/whpx-cpu-legacy.c | 171 +++++++++++++++++++++++++++++
 target/i386/whpx/whpx-i386.h       |  12 ++
 6 files changed, 370 insertions(+), 5 deletions(-)
 create mode 100644 target/i386/whpx/whpx-cpu-legacy.c
 create mode 100644 target/i386/whpx/whpx-i386.h

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 8482901f71..5902124b63 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -73,6 +73,14 @@ void whpx_apic_get(APICCommonState *s);
   X(HRESULT, WHvGetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, WHV_REGISTER_VALUE* RegisterValues)) \
   X(HRESULT, WHvSetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, const WHV_REGISTER_VALUE* RegisterValues)) \
 
+#ifdef __x86_64__
+#define LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL_ARCH(X) \
+    X(HRESULT, WHvGetVirtualProcessorCpuidOutput, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, UINT32 Eax, \
+         UINT32 Ecx, WHV_CPUID_OUTPUT *CpuidOutput))
+#else
+#define LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL_ARCH(X)
+#endif
 /*
  * These are supplemental functions that may not be present
  * on all versions and are not critical for basic functionality.
@@ -89,6 +97,7 @@ void whpx_apic_get(APICCommonState *s);
          UINT32 StateSize)) \
   X(HRESULT, WHvResetPartition, \
         (WHV_PARTITION_HANDLE Partition)) \
+  LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL_ARCH(X)
 
 #define WHP_DEFINE_TYPE(return_type, function_name, signature) \
     typedef return_type (WINAPI *function_name ## _t) signature;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c6fd1dc00e..a5f1a1a8fd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -26,6 +26,8 @@
 #include "tcg/helper-tcg.h"
 #include "exec/translation-block.h"
 #include "system/hvf.h"
+#include "system/whpx.h"
+#include "whpx/whpx-i386.h"
 #include "hvf/hvf-i386.h"
 #include "kvm/kvm_i386.h"
 #include "kvm/tdx.h"
@@ -8087,6 +8089,16 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
         r = hvf_get_supported_cpuid(wi->cpuid.eax,
                                     wi->cpuid.ecx,
                                     wi->cpuid.reg);
+    } else if (whpx_enabled()) {
+        switch (wi->type) {
+        case CPUID_FEATURE_WORD:
+            r = whpx_get_supported_cpuid(wi->cpuid.eax, wi->cpuid.ecx,
+                                                            wi->cpuid.reg);
+            break;
+        case MSR_FEATURE_WORD:
+            r = whpx_get_supported_msr_feature(wi->msr.index);
+            break;
+        }
     } else if (tcg_enabled() || qtest_enabled()) {
         r = wi->tcg_features;
     } else {
@@ -8168,6 +8180,11 @@ static void x86_cpu_get_supported_cpuid(uint32_t func, uint32_t index,
         *ebx = hvf_get_supported_cpuid(func, index, R_EBX);
         *ecx = hvf_get_supported_cpuid(func, index, R_ECX);
         *edx = hvf_get_supported_cpuid(func, index, R_EDX);
+    } else if (whpx_enabled()) {
+        *eax = whpx_get_supported_cpuid(func, index, R_EAX);
+        *ebx = whpx_get_supported_cpuid(func, index, R_EBX);
+        *ecx = whpx_get_supported_cpuid(func, index, R_ECX);
+        *edx = whpx_get_supported_cpuid(func, index, R_EDX);
     } else {
         *eax = 0;
         *ebx = 0;
diff --git a/target/i386/whpx/meson.build b/target/i386/whpx/meson.build
index c3aaaff9fd..1c6a4ce377 100644
--- a/target/i386/whpx/meson.build
+++ b/target/i386/whpx/meson.build
@@ -1,4 +1,5 @@
 i386_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
   'whpx-all.c',
   'whpx-apic.c',
+  'whpx-cpu-legacy.c'
 ))
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4127440c0c..d211b3f2ef 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -36,6 +36,7 @@
 #include "system/whpx-accel-ops.h"
 #include "system/whpx-all.h"
 #include "system/whpx-common.h"
+#include "whpx-i386.h"
 
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
@@ -49,6 +50,8 @@
 /* for kernel-irqchip=off */
 #define HV_X64_MSR_APIC_FREQUENCY       0x40000023
 
+static bool is_modern_os = true;
+
 static const WHV_REGISTER_NAME whpx_register_names[] = {
 
     /* X64 General purpose registers */
@@ -265,11 +268,30 @@ typedef enum WhpxStepMode {
 static uint32_t max_vcpu_index;
 static WHV_PROCESSOR_XSAVE_FEATURES whpx_xsave_cap;
 
-static bool whpx_has_xsave(void)
+bool whpx_has_xsave(void)
 {
     return whpx_xsave_cap.XsaveSupport;
 }
 
+bool whpx_has_xsaves(void)
+{
+    return whpx_xsave_cap.XsaveSupervisorSupport;
+}
+
+static bool whpx_rdtsc_cap;
+
+bool whpx_has_rdtscp(void)
+{
+    return whpx_rdtsc_cap;
+}
+
+static bool whpx_invpcid_cap;
+
+bool whpx_has_invpcid(void)
+{
+    return whpx_invpcid_cap;
+}
+
 static WHV_X64_SEGMENT_REGISTER whpx_seg_q2h(const SegmentCache *qs, int v86,
                                              int r86)
 {
@@ -1062,6 +1084,137 @@ static void whpx_init_emu(void)
     init_emu(&whpx_x86_emul_ops);
 }
 
+bool whpx_is_legacy_os(void)
+{
+    return !is_modern_os;
+}
+
+uint32_t whpx_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
+{
+    WHV_CPUID_OUTPUT output = {};
+    uint32_t eax, ebx, ecx, edx;
+    uint32_t cpu_index = 0;
+    bool temp_cpu = true;
+    HRESULT hr;
+
+    /* Legacy OSes don't have WHvGetVirtualProcessorCpuidOutput */
+    if (whpx_is_legacy_os()) {
+        return whpx_get_supported_cpuid_legacy(func, idx, reg);
+    }
+
+    hr = whp_dispatch.WHvCreateVirtualProcessor(
+        whpx_global.partition, cpu_index, 0);
+
+    /* This means that the CPU already exists... */
+    if (FAILED(hr)) {
+        temp_cpu = false;
+    }
+
+    hr = whp_dispatch.WHvGetVirtualProcessorCpuidOutput(whpx_global.partition,
+        cpu_index, func, idx, &output);
+
+    if (FAILED(hr)) {
+        abort();
+    }
+
+    if (temp_cpu) {
+        hr = whp_dispatch.WHvDeleteVirtualProcessor(whpx_global.partition, cpu_index);
+        if (FAILED(hr)) {
+            abort();
+        }
+    }
+
+    eax = output.Eax;
+    ebx = output.Ebx;
+    ecx = output.Ecx;
+    edx = output.Edx;
+
+    /*
+     * We can emulate X2APIC even for the kernel-irqchip=off case.
+     * CPUID_EXT_HYPERVISOR and CPUID_HT should be considered present
+     * always, so report them as unconditionally supported here.
+     */
+    if (func == 1) {
+        ecx |= CPUID_EXT_X2APIC;
+        ecx |= CPUID_EXT_HYPERVISOR;
+        edx |= CPUID_HT;
+    }
+
+    switch (reg) {
+    case R_EAX:
+        return eax;
+    case R_EBX:
+        return ebx;
+    case R_ECX:
+        return ecx;
+    case R_EDX:
+        return edx;
+    default:
+        return 0;
+    }
+}
+
+uint64_t whpx_get_supported_msr_feature(uint32_t index)
+{
+    WHV_CAPABILITY_CODE cap;
+    uint64_t val = 0;
+
+    switch (index) {
+    case MSR_IA32_VMX_BASIC:
+        cap = WHvCapabilityCodeVmxBasic;
+        break;
+    case MSR_IA32_VMX_MISC:
+        cap = WHvCapabilityCodeVmxMisc;
+        break;
+    case MSR_IA32_VMX_CR0_FIXED0:
+        cap = WHvCapabilityCodeVmxCr0Fixed0;
+        break;
+    case MSR_IA32_VMX_CR0_FIXED1:
+        cap = WHvCapabilityCodeVmxCr0Fixed1;
+        break;
+    case MSR_IA32_VMX_CR4_FIXED0:
+        cap = WHvCapabilityCodeVmxCr4Fixed0;
+        break;
+    case MSR_IA32_VMX_CR4_FIXED1:
+        cap = WHvCapabilityCodeVmxCr4Fixed1;
+        break;
+    case MSR_IA32_VMX_VMCS_ENUM:
+        cap = WHvCapabilityCodeVmxVmcsEnum;
+        break;
+    case MSR_IA32_VMX_PROCBASED_CTLS2:
+        cap = WHvCapabilityCodeVmxProcbasedCtls2;
+        break;
+    case MSR_IA32_VMX_EPT_VPID_CAP:
+        cap = WHvCapabilityCodeVmxEptVpidCap;
+        break;
+    case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
+        cap = WHvCapabilityCodeVmxPinbasedCtls;
+        break;
+    case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
+        cap = WHvCapabilityCodeVmxProcbasedCtls;
+        break;
+    case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
+        cap = WHvCapabilityCodeVmxTrueEntryCtls;
+        break;
+    case MSR_IA32_VMX_TRUE_EXIT_CTLS:
+        cap = WHvCapabilityCodeVmxTrueExitCtls;
+        break;
+    default:
+        cap = 0;
+    }
+
+    if (cap != 0) {
+        HRESULT hr = whp_dispatch.WHvGetCapability(
+            cap, &val, sizeof(val),
+                NULL);
+        if (FAILED(hr)) {
+            return 0;
+        }
+        return val;
+    }
+    return 0;
+}
+
 /*
  * Controls whether we should intercept various exceptions on the guest,
  * namely breakpoint/single-step events.
@@ -2235,7 +2388,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_CAPABILITY_FEATURES features = {0};
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
-    bool is_legacy_os = false;
     UINT32 cpuidExitList[] = {1};
 
     whpx = &whpx_global;
@@ -2355,6 +2507,9 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    whpx_rdtsc_cap = processor_features.Bank0.RdtscpSupport;
+    whpx_invpcid_cap = processor_features.Bank0.InvpcidSupport;
+
     if (whpx_irqchip_in_kernel() && processor_features.Bank1.NestedVirtSupport) {
         memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
         prop.NestedVirtualization = 1;
@@ -2395,7 +2550,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     if (FAILED(hr)) {
         warn_report("WHPX: Failed to get performance "
                     "monitoring features, hr=%08lx", hr);
-        is_legacy_os = true;
+        is_modern_os = false;
     } else {
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
@@ -2435,7 +2590,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
     }
 
-    if (!is_legacy_os && whpx->hyperv_enlightenments_allowed) {
+    if (is_modern_os && whpx->hyperv_enlightenments_allowed) {
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
                 WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
@@ -2446,7 +2601,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
             ret = -EINVAL;
             goto error;
         }
-    } else if (is_legacy_os && whpx->hyperv_enlightenments_required) {
+    } else if (!is_modern_os && whpx->hyperv_enlightenments_required) {
         error_report("Hyper-V enlightenments not available on legacy Windows");
         ret = -EINVAL;
         goto error;
diff --git a/target/i386/whpx/whpx-cpu-legacy.c b/target/i386/whpx/whpx-cpu-legacy.c
new file mode 100644
index 0000000000..477429b460
--- /dev/null
+++ b/target/i386/whpx/whpx-cpu-legacy.c
@@ -0,0 +1,171 @@
+/*
+ *  i386 CPUID helper functions
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *  Copyright (c) 2017 Google Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * cpuid
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cpuid.h"
+#include "host/cpuinfo.h"
+#include "cpu.h"
+#include "emulate/x86.h"
+#include "whpx-i386.h"
+
+static bool cached_xcr0;
+static uint64_t supported_xcr0;
+
+static void cache_host_xcr0(void)
+{
+    if (cached_xcr0) {
+        return;
+    }
+
+    if (whpx_has_xsave()) {
+        uint64_t host_xcr0 = xgetbv_low(0);
+
+        /* Only show xcr0 bits corresponding to usable features.  */
+        supported_xcr0 = host_xcr0 & (XSTATE_FP_MASK |
+                                      XSTATE_SSE_MASK | XSTATE_YMM_MASK |
+                                      XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK |
+                                      XSTATE_Hi16_ZMM_MASK);
+        if ((supported_xcr0 & (XSTATE_FP_MASK | XSTATE_SSE_MASK)) !=
+            (XSTATE_FP_MASK | XSTATE_SSE_MASK)) {
+            supported_xcr0 = 0;
+        }
+    }
+
+    cached_xcr0 = true;
+}
+
+uint32_t whpx_get_supported_cpuid_legacy(uint32_t func, uint32_t idx,
+                                 int reg)
+{
+    uint32_t eax, ebx, ecx, edx;
+
+    cache_host_xcr0();
+    host_cpuid(func, idx, &eax, &ebx, &ecx, &edx);
+
+    switch (func) {
+    case 0:
+        eax = eax < (uint32_t)0xd ? eax : (uint32_t)0xd;
+        break;
+    case 1:
+        edx &= CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
+             CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
+             CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+             CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX |
+             CPUID_FXSR | CPUID_SSE | CPUID_SSE2 | CPUID_SS | CPUID_HT;
+        ecx &= CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
+             CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID |
+             CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_MOVBE |
+             CPUID_EXT_POPCNT | CPUID_EXT_AES |
+             (supported_xcr0 ? CPUID_EXT_XSAVE : 0) |
+             CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND;
+        ecx |= CPUID_EXT_HYPERVISOR;
+        ecx |= CPUID_EXT_X2APIC;
+        edx |= CPUID_HT;
+        break;
+    case 6:
+        eax = CPUID_6_EAX_ARAT;
+        ebx = 0;
+        ecx = 0;
+        edx = 0;
+        break;
+    case 7:
+        if (idx == 0) {
+            ebx &= CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
+                    CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 |
+                    CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 |
+                    CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_RTM |
+                    CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+                    CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_AVX512IFMA |
+                    CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512PF |
+                    CPUID_7_0_EBX_AVX512ER | CPUID_7_0_EBX_AVX512CD |
+                    CPUID_7_0_EBX_CLFLUSHOPT | CPUID_7_0_EBX_CLWB |
+                    CPUID_7_0_EBX_AVX512DQ | CPUID_7_0_EBX_SHA_NI |
+                    CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512VL |
+                    CPUID_7_0_EBX_INVPCID;
+
+            if (!whpx_has_invpcid()) {
+                ebx &= ~CPUID_7_0_EBX_INVPCID;
+            }
+
+            ecx &= CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_AVX512_VPOPCNTDQ |
+                   CPUID_7_0_ECX_RDPID;
+            edx &= CPUID_7_0_EDX_AVX512_4VNNIW | CPUID_7_0_EDX_AVX512_4FMAPS;
+        } else {
+            ebx = 0;
+            ecx = 0;
+            edx = 0;
+        }
+        eax = 0;
+        break;
+    case 0xD:
+        if (!supported_xcr0 || idx >= 63 ||
+            (idx > 1 && !(supported_xcr0 & (UINT64_C(1) << idx)))) {
+            eax = ebx = ecx = edx = 0;
+            break;
+        }
+
+        if (idx == 0) {
+            eax = supported_xcr0;
+        } else if (idx == 1) {
+            eax &= CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1;
+            if (!whpx_has_xsaves()) {
+                eax &= ~CPUID_XSAVE_XSAVES;
+            }
+        }
+        break;
+    case 0x80000001:
+        /* LM only if HVF in 64-bit mode */
+        edx &= CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
+                CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
+                CPUID_EXT2_SYSCALL | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+                CPUID_PAT | CPUID_PSE36 | CPUID_EXT2_MMXEXT | CPUID_MMX |
+                CPUID_FXSR | CPUID_EXT2_FXSR | CPUID_EXT2_PDPE1GB | CPUID_EXT2_3DNOWEXT |
+                CPUID_EXT2_3DNOW | CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX;
+        if (!(whpx_has_rdtscp())) {
+            edx &= ~CPUID_EXT2_RDTSCP;
+        }
+        ecx &= CPUID_EXT3_LAHF_LM | CPUID_EXT3_CMP_LEG | CPUID_EXT3_CR8LEG |
+                CPUID_EXT3_ABM | CPUID_EXT3_SSE4A | CPUID_EXT3_MISALIGNSSE |
+                CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_OSVW | CPUID_EXT3_XOP |
+                CPUID_EXT3_FMA4 | CPUID_EXT3_TBM;
+        break;
+    case 0x80000007:
+        edx &= CPUID_APM_INVTSC;
+        eax = ebx = ecx = 0;
+        break;
+    default:
+        return 0;
+    }
+
+    switch (reg) {
+    case R_EAX:
+        return eax;
+    case R_EBX:
+        return ebx;
+    case R_ECX:
+        return ecx;
+    case R_EDX:
+        return edx;
+    default:
+        return 0;
+    }
+}
diff --git a/target/i386/whpx/whpx-i386.h b/target/i386/whpx/whpx-i386.h
new file mode 100644
index 0000000000..a1cf732862
--- /dev/null
+++ b/target/i386/whpx/whpx-i386.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+uint32_t whpx_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
+uint64_t whpx_get_supported_msr_feature(uint32_t index);
+bool whpx_is_legacy_os(void);
+
+uint32_t whpx_get_supported_cpuid_legacy(uint32_t func, uint32_t idx,
+                                 int reg);
+bool whpx_has_xsave(void);
+bool whpx_has_xsaves(void);
+bool whpx_has_rdtscp(void);
+bool whpx_has_invpcid(void);
-- 
2.50.1 (Apple Git-155)


