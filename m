Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0581FCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7X-0005rA-1x; Thu, 30 Apr 2026 13:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6t-0005HG-EW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6q-0004Yt-OS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eqUYS4HJpP9nWQW2L6iPK7iOhGhx+OX5L2AXqNzjMG4=;
 b=jMRGSBk8/Q5KlMnSV2yB1XjYW7SA7moxRJVipWNO5gNDSpAJErdR2KIXlhVgEiIoDnpoF0
 nL+Kx3vkLRnIjb6HbOumJuAwDQ2djqMW+eViJ5MjgZ5Vomu7amHxawEHaAQyHdOoB0UVV6
 4An3pfC3FwgccsSQ5phHd6Dz5rnK2S0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-vglct0wNP_-sDRxhwMuLvw-1; Thu, 30 Apr 2026 13:23:28 -0400
X-MC-Unique: vglct0wNP_-sDRxhwMuLvw-1
X-Mimecast-MFC-AGG-ID: vglct0wNP_-sDRxhwMuLvw_1777569808
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b02af4345fso41351776d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569807; x=1778174607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eqUYS4HJpP9nWQW2L6iPK7iOhGhx+OX5L2AXqNzjMG4=;
 b=HBqcEbhiI6peWPMIgnE8eL29KoHR4VcUP02g9CJFcO+JEbP6BluOv4+C3mY9X8EqdD
 9MmSargtabQtHZasdPSN0GC8320DTLR5h7W4Iw+fHqDuuXEFZisEtz6b5NahPMEE5Ibw
 g4HQTosYrhNmMWl3HL3z7m9c0az78UivRYZ1Q2YS++FZSmjORjQt+p36cgO101PYWoeE
 Ykuvo2lFlKGj3ozvF+FUkZZlckgIt3L2tgCi3X98ARj2GkXnLQIpCQe3bsn7ubekSVeX
 gbhglR40qv7asL2xgWEcXvXrnsXD3L83q2NlvtbOrY229a0OveZuA3n45sEMVw9JfdYz
 lD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569807; x=1778174607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eqUYS4HJpP9nWQW2L6iPK7iOhGhx+OX5L2AXqNzjMG4=;
 b=eYdQs+KFM2GWwpQEZMWoZ0v0fVd7hDzJZnZAQgr234dDHGHm6v8I0xNVxo0vKwyzj6
 0FuTvCXIEmIaiTad+tKn/122I6RV0njQDg0h3AvIVQsZuy8lM4mvS3HzbKqAPP7GDbOt
 FyaiK1/KhGDcmPOp+qS5v2y/i5Y7NdTsFrzZv0iOZSu5cxnv15zC4qlCiEOfacUZOqPI
 LEKZfjFJWQfpG63OIHRvJFA2amALF0hiE6gJeQpLGJMt15tthnttejC/QVGcKcCA29ys
 gr74TEPFsyOSWhrJSBigW/mosT7Wnc/OGUQECPKREpCXf5MpbjKd9czIka+Bm+7V5TWm
 yAKQ==
X-Gm-Message-State: AOJu0YwaEHJUjnvFOZe8plJZ0dmIfe0WAZGJrSQ0hLbEh1FOvRBHlNWW
 a3+JvNFGAL6JQAn60jCpnXcEJgY9rxtNpUJaW3LQR7NtCu2SOs/+Twm0CLRN69aB+zwFz6pUcES
 58cxjnIGf8Hfnn+FZ9sGvCgYhXBCoRUFCx25Ss6/NlDmN+fQ/TfN+vdKpcnVv9aiMp+M+j7JtFM
 aWjUfoorxb23YkcPk9wfwmdBG+WtUNyZ6PTWGDy6Y9
X-Gm-Gg: AeBDieve6OC86guAAEJaIlzaYub0KFnkQs65mYozidWy0d0URlizG+VBx+PUmDOl2EV
 pMrQiWD3Z1SglpORVV/cdTfjX6+0iVqRvFqE0bI4SCQCJfW3CMy8v2N91cadrD5kgv7LKDuiI+I
 9+LUBpNNPkdueKtORmGNs4CTS4AgEKYptsdPAubjlmPlEoXd6Tz5LBxK0RX9XpP0SwPciwvzn39
 CvN0XLujIefjVtEXy3b7i3LI8bhTVY8J9pIkis+UqxKny2Y3z/Mu1V+5r1tTIpqgNC/ipNZga0f
 6Vc8SiD3fDHB0jPAvH/2B7vA4m8IVROPPZi6wszb4JJR1hDz66lZP407ERIpbHsTxqWnoLG2coO
 USJk2Y0K6AtlUhzRbLDzJCSvssuIeKGew1NrGqlyfAyloENGwvd7jMmNAd/pYVvU7KwZN/OSbrO
 BlAYlU4z38B2cIsdTCpeVzqd3WAUpAlx3OECg=
X-Received: by 2002:a05:6214:19c3:b0:8ac:a4f9:da76 with SMTP id
 6a1803df08f44-8b3fe7969camr56187036d6.26.1777569807045; 
 Thu, 30 Apr 2026 10:23:27 -0700 (PDT)
X-Received: by 2002:a05:6214:19c3:b0:8ac:a4f9:da76 with SMTP id
 6a1803df08f44-8b3fe7969camr56185986d6.26.1777569806043; 
 Thu, 30 Apr 2026 10:23:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff474374sm23078026d6.40.2026.04.30.10.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 25/58] whpx: i386: wire up feature probing
Date: Thu, 30 Apr 2026 19:21:31 +0200
Message-ID: <20260430172204.1006673-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Windows 10 doesn't have the API for this, so using this
only for Windows 11.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-4-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/whpx-internal.h     |   9 ++
 target/i386/whpx/whpx-i386.h       |  12 ++
 target/i386/cpu.c                  |  17 +++
 target/i386/whpx/whpx-all.c        | 165 +++++++++++++++++++++++++++-
 target/i386/whpx/whpx-cpu-legacy.c | 171 +++++++++++++++++++++++++++++
 target/i386/whpx/meson.build       |   1 +
 6 files changed, 370 insertions(+), 5 deletions(-)
 create mode 100644 target/i386/whpx/whpx-i386.h
 create mode 100644 target/i386/whpx/whpx-cpu-legacy.c

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 8482901f714..5902124b637 100644
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
diff --git a/target/i386/whpx/whpx-i386.h b/target/i386/whpx/whpx-i386.h
new file mode 100644
index 00000000000..a1cf7328623
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
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f4856c61044..7ea80f07c7c 100644
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
@@ -8230,6 +8232,16 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
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
@@ -8311,6 +8323,11 @@ static void x86_cpu_get_supported_cpuid(uint32_t func, uint32_t index,
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
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4127440c0ca..d211b3f2efa 100644
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
index 00000000000..477429b460f
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
diff --git a/target/i386/whpx/meson.build b/target/i386/whpx/meson.build
index c3aaaff9fd1..1c6a4ce3773 100644
--- a/target/i386/whpx/meson.build
+++ b/target/i386/whpx/meson.build
@@ -1,4 +1,5 @@
 i386_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
   'whpx-all.c',
   'whpx-apic.c',
+  'whpx-cpu-legacy.c'
 ))
-- 
2.54.0


