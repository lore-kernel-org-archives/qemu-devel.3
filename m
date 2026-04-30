Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AFDCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV8Y-0002a4-NN; Thu, 30 Apr 2026 13:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV8H-0001vv-MU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV8D-00050R-LC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23mc5aBTTO2rCi1UiT36jDv8Lv14DhuBboQ/8mkVWUY=;
 b=NJuhZ7NJfScYtFyz9IdHPRkQyetzWV4i8U2Whtwq9qC4LFERUBp9Z6/RbXwQe8JoWsuN65
 Yn/vs5fN5pY+pjWdz1XRhU2xhVCFso/t3Tplks25FjRccuSuPbSPq5RyxHA03slSIjRuMb
 SPKUcwIk561emg7CGNWcW94oYMPqpRM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-gF99JjVrNZWFtwtNGW5yxw-1; Thu, 30 Apr 2026 13:24:52 -0400
X-MC-Unique: gF99JjVrNZWFtwtNGW5yxw-1
X-Mimecast-MFC-AGG-ID: gF99JjVrNZWFtwtNGW5yxw_1777569892
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8a16036c90eso33257766d6.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569891; x=1778174691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23mc5aBTTO2rCi1UiT36jDv8Lv14DhuBboQ/8mkVWUY=;
 b=PKBK2C0coXz2CqYHmdEQ0yuPzHr1x37TEl1UGi75XpnbvlUHMcTOZinYWqkxxzTCTw
 OlRkbb5VBz3i+bkQuvFw0HjpZKYQCKjJxw7CR2lTUMrY75NcSbRd9i06Z5pngDRoPU/B
 ZDJSv8dAkNPltfWmgdXN+igWcSCDEEMNMzvt29UXAzR+OfeyFeOUBzZav230zqEGLW/F
 XBNzOvt4QF4HDFB9Jp69KjwV1+DlNPdROfK/1oJPfKr8kJSsH8R9ygk1tYefvpnHlcuj
 xlkyPYVsPS4EJzVZ4ronS6IhqnJJ34MSHR3RUZPCv3NOdPPiVLoBwKha5pZEOjmTilWv
 VkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569892; x=1778174692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=23mc5aBTTO2rCi1UiT36jDv8Lv14DhuBboQ/8mkVWUY=;
 b=a98j5RfJLKliSQ/bsMJgcUD9QsYViYdnpIs+St0n6W+f2LUVAEd1YMSfGLM+lyyeei
 EKUdO6/9urquTZzEFwFY47t5tIFwenFFIuLBJ+QaO4a4OReAupGOWLI4U/I+g+BqYYXH
 olwlnMkyPrXm7H+Mfgu2Fb392cBpRz0JvxZCHYVoyVVWPaiPgtTQVkW23muA9JHMPQbH
 dHYjivPLMIQlYfQNphGEXEIYdX583KRsJnc+cMMUGb04ozPBQAK2/jUGZPyh9sG+Ht9o
 MbnZWcC/LKRiQ5ZHpTQ8wb7SZsYxmJzBrwk2ZrBSR6uSSLiN0row5NdkcBjuamjr2/8S
 R/Ig==
X-Gm-Message-State: AOJu0Yw+QeH/YWXamqR1aP+2hK3M9H6JOD2Q+2b35c7VneNWBE6+tDWN
 L1btJchWaP20DtTrbmSQyF1YX2uY9XFcdJpaiF1M+lEOLyVAZK1FDwW2wIt7h5ynLbW5+H9kVY+
 BMvb0/gPExNH5fj9nNC/Sf0FG8UHaFTf0gm2P3h+SeiD0ihLKgqLc1uIKRszknVa0lOB4BQtl5O
 /7LDNGRGHZvAmQQgpdbAfl5+9srkTSGsgY91OraOHR
X-Gm-Gg: AeBDieuEqa1CSNhthv6W4GLzq+xRYJpx1sPUpfgrcl7BMm4zUoBSaoWY74nkj5j9xQc
 JR7MqAq7UKOTnoYZxfRsC8FMC8eelNnzR6KDqdLYdEC+4uUygG/jGnsFiQ1LpyilFJGBbKVsq5P
 sKhTAZNCtM75SyerXiQhOUKF7KEBsICt+8GxffG4Tvgq7i/s8LvwYhQ7XmmEmS/uZbE0ZHIuGLY
 XMpjPov8AX0yyqAFt1LG6ohCayy1lEfYiJxBnrY5LM4AEIxCqa0wYiuRVFLc1lwUev4l5oIkNLD
 lf4S1Pi71ADL0LQeq0GrqOiI7paEvr8T3kOhOV3DOReuWjrDqqr5bOPQcaftqDXR4b8qFxvC0/d
 G1BJLUFXSobRFu668HnEOcqNLQeRO44qNNHzZu/5PjqqXYXJ9vxMF7GQ8HbdJupKgQyY2Dm3KdB
 SXvdYnjwVr7JnfL3R4RngszUmmun7z3XKKRdY=
X-Received: by 2002:a05:6214:411a:b0:89a:666:ad2b with SMTP id
 6a1803df08f44-8b3fe809fbemr55197546d6.27.1777569891259; 
 Thu, 30 Apr 2026 10:24:51 -0700 (PDT)
X-Received: by 2002:a05:6214:411a:b0:89a:666:ad2b with SMTP id
 6a1803df08f44-8b3fe809fbemr55196676d6.27.1777569890342; 
 Thu, 30 Apr 2026 10:24:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff328884sm22944026d6.14.2026.04.30.10.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 53/58] whpx: xsave support
Date: Thu, 30 Apr 2026 19:21:59 +0200
Message-ID: <20260430172204.1006673-54-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-30-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/whpx-internal.h |  16 ++
 target/i386/whpx/whpx-all.c    | 379 ++++++++++++++++++++++++---------
 target/i386/meson.build        |   2 +-
 3 files changed, 293 insertions(+), 104 deletions(-)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 86639627b36..0aae83bd7c8 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -99,6 +99,22 @@ void whpx_apic_get(APICCommonState *s);
          UINT32 StateSize)) \
   X(HRESULT, WHvResetPartition, \
         (WHV_PARTITION_HANDLE Partition)) \
+  X(HRESULT, WHvGetVirtualProcessorXsaveState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        PVOID Buffer, \
+        UINT32 BufferSizeInBytes, UINT32 *BytesWritten)) \
+  X(HRESULT, WHvSetVirtualProcessorXsaveState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        PVOID Buffer, \
+        UINT32 BufferSizeInBytes)) \
+  X(HRESULT, WHvGetVirtualProcessorState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
+        UINT32 BufferSizeInBytes, UINT32 *BytesWritten)) \
+  X(HRESULT, WHvSetVirtualProcessorState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
+        UINT32 BufferSizeInBytes)) \
   LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL_ARCH(X)
 
 #define WHP_DEFINE_TYPE(return_type, function_name, signature) \
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8d8aabf4db7..717d47f9cce 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "qemu/typedefs.h"
 #include "system/address-spaces.h"
 #include "system/ioport.h"
 #include "gdbstub/helpers.h"
@@ -20,6 +21,7 @@
 #include "system/cpus.h"
 #include "system/runstate.h"
 #include "qemu/main-loop.h"
+#include "qemu/memalign.h"
 #include "hw/core/boards.h"
 #include "hw/intc/ioapic.h"
 #include "hw/intc/i8259.h"
@@ -108,34 +110,6 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
      * WHvX64RegisterDr7,
      */
 
-    /* X64 Floating Point and Vector Registers */
-    WHvX64RegisterXmm0,
-    WHvX64RegisterXmm1,
-    WHvX64RegisterXmm2,
-    WHvX64RegisterXmm3,
-    WHvX64RegisterXmm4,
-    WHvX64RegisterXmm5,
-    WHvX64RegisterXmm6,
-    WHvX64RegisterXmm7,
-    WHvX64RegisterXmm8,
-    WHvX64RegisterXmm9,
-    WHvX64RegisterXmm10,
-    WHvX64RegisterXmm11,
-    WHvX64RegisterXmm12,
-    WHvX64RegisterXmm13,
-    WHvX64RegisterXmm14,
-    WHvX64RegisterXmm15,
-    WHvX64RegisterFpMmx0,
-    WHvX64RegisterFpMmx1,
-    WHvX64RegisterFpMmx2,
-    WHvX64RegisterFpMmx3,
-    WHvX64RegisterFpMmx4,
-    WHvX64RegisterFpMmx5,
-    WHvX64RegisterFpMmx6,
-    WHvX64RegisterFpMmx7,
-    WHvX64RegisterFpControlStatus,
-    WHvX64RegisterXmmControlStatus,
-
     /* X64 MSRs */
     WHvX64RegisterEfer,
 #ifdef TARGET_X86_64
@@ -182,6 +156,36 @@ static const WHV_REGISTER_NAME whpx_register_names_for_vmexit[] = {
     WHvX64RegisterR15,
 };
 
+static const WHV_REGISTER_NAME whpx_register_names_legacy_fp[] = {
+    /* X64 Floating Point and Vector Registers (non-xsave) */
+    WHvX64RegisterXmm0,
+    WHvX64RegisterXmm1,
+    WHvX64RegisterXmm2,
+    WHvX64RegisterXmm3,
+    WHvX64RegisterXmm4,
+    WHvX64RegisterXmm5,
+    WHvX64RegisterXmm6,
+    WHvX64RegisterXmm7,
+    WHvX64RegisterXmm8,
+    WHvX64RegisterXmm9,
+    WHvX64RegisterXmm10,
+    WHvX64RegisterXmm11,
+    WHvX64RegisterXmm12,
+    WHvX64RegisterXmm13,
+    WHvX64RegisterXmm14,
+    WHvX64RegisterXmm15,
+    WHvX64RegisterFpMmx0,
+    WHvX64RegisterFpMmx1,
+    WHvX64RegisterFpMmx2,
+    WHvX64RegisterFpMmx3,
+    WHvX64RegisterFpMmx4,
+    WHvX64RegisterFpMmx5,
+    WHvX64RegisterFpMmx6,
+    WHvX64RegisterFpMmx7,
+    WHvX64RegisterFpControlStatus,
+    WHvX64RegisterXmmControlStatus,
+};
+
 struct whpx_register_set {
     WHV_REGISTER_VALUE values[RTL_NUMBER_OF(whpx_register_names)];
 };
@@ -392,6 +396,123 @@ static int whpx_set_tsc(CPUState *cpu)
     return 0;
 }
 
+static bool whpx_is_xsave_enabled(CPUState *cpu)
+{
+    CPUX86State *env = &X86_CPU(cpu)->env;
+    return env->cr[4] & CR4_OSXSAVE_MASK;
+}
+
+static size_t whpx_get_xsave_max_len(void)
+{
+    return whpx_get_supported_cpuid(0xd, 0, R_ECX);
+}
+
+static int whpx_set_xsave_state(const CPUState *cpu)
+{
+    struct whpx_state *whpx = &whpx_global;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    HRESULT hr;
+    void *xsavec_buf;
+    size_t page = qemu_real_host_page_size();
+    size_t xsavec_buf_len;
+
+    /* allocate and populate compacted buffer */
+    xsavec_buf_len = whpx_get_xsave_max_len();
+    xsavec_buf = qemu_memalign(page, xsavec_buf_len);
+
+    /* save registers to standard format buffer */
+    x86_cpu_xsave_all_areas(x86cpu, env->xsave_buf, env->xsave_buf_len);
+
+    /* store compacted version of xsave area in xsavec_buf */
+    compact_xsave_area(env, xsavec_buf, xsavec_buf_len);
+
+    if (!whpx_is_legacy_os()) {
+        hr = whp_dispatch.WHvSetVirtualProcessorState(
+            whpx->partition, cpu->cpu_index,
+            WHvVirtualProcessorStateTypeXsaveState,
+            xsavec_buf,
+            xsavec_buf_len);
+    } else {
+        hr = whp_dispatch.WHvSetVirtualProcessorXsaveState(
+            whpx->partition, cpu->cpu_index,
+            xsavec_buf,
+            xsavec_buf_len);
+    }
+
+    qemu_vfree(xsavec_buf);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get virtual processor context, hr=%08lx",
+                     hr);
+    }
+
+    return 0;
+}
+
+static void whpx_set_legacy_fp_registers(CPUState *cpu, WHPXStateLevel level)
+{
+    struct whpx_state *whpx = &whpx_global;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    struct whpx_register_set vcxt;
+    HRESULT hr;
+    int idx = 0;
+    int i;
+    int idx_next;
+
+    assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
+
+    /* 16 XMM registers */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterXmm0);
+    idx_next = idx + 16;
+    for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
+        vcxt.values[idx].Reg128.Low64 = env->xmm_regs[i].ZMM_Q(0);
+        vcxt.values[idx].Reg128.High64 = env->xmm_regs[i].ZMM_Q(1);
+    }
+    idx = idx_next;
+
+    /* 8 FP registers */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterFpMmx0);
+    for (i = 0; i < 8; i += 1, idx += 1) {
+        vcxt.values[idx].Fp.AsUINT128.Low64 = env->fpregs[i].mmx.MMX_Q(0);
+        /* vcxt.values[idx].Fp.AsUINT128.High64 =
+               env->fpregs[i].mmx.MMX_Q(1);
+        */
+    }
+
+    /* FP control status register */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterFpControlStatus);
+    vcxt.values[idx].FpControlStatus.FpControl = env->fpuc;
+    vcxt.values[idx].FpControlStatus.FpStatus =
+        (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11;
+    vcxt.values[idx].FpControlStatus.FpTag = 0;
+    for (i = 0; i < 8; ++i) {
+        vcxt.values[idx].FpControlStatus.FpTag |= (!env->fptags[i]) << i;
+    }
+    vcxt.values[idx].FpControlStatus.Reserved = 0;
+    vcxt.values[idx].FpControlStatus.LastFpOp = env->fpop;
+    vcxt.values[idx].FpControlStatus.LastFpRip = env->fpip;
+    idx += 1;
+
+    /* XMM control status register */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterXmmControlStatus);
+    vcxt.values[idx].XmmControlStatus.LastFpRdp = 0;
+    vcxt.values[idx].XmmControlStatus.XmmStatusControl = env->mxcsr;
+    vcxt.values[idx].XmmControlStatus.XmmStatusControlMask = 0x0000ffff;
+    idx += 1;
+
+    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index,
+        whpx_register_names_legacy_fp,
+        idx,
+        &vcxt.values[0]);
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set virtual processor context, hr=%08lx",
+                     hr);
+    }
+}
+
 void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 {
     struct whpx_state *whpx = &whpx_global;
@@ -491,45 +612,11 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
          */
         whpx_set_xcrs(cpu);
 
-        /* 16 XMM registers */
-        assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
-        idx_next = idx + 16;
-        for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
-            vcxt.values[idx].Reg128.Low64 = env->xmm_regs[i].ZMM_Q(0);
-            vcxt.values[idx].Reg128.High64 = env->xmm_regs[i].ZMM_Q(1);
+        if (whpx_is_xsave_enabled(cpu)) {
+            whpx_set_xsave_state(cpu);
+        } else {
+            whpx_set_legacy_fp_registers(cpu, level);
         }
-        idx = idx_next;
-
-        /* 8 FP registers */
-        assert(whpx_register_names[idx] == WHvX64RegisterFpMmx0);
-        for (i = 0; i < 8; i += 1, idx += 1) {
-            vcxt.values[idx].Fp.AsUINT128.Low64 = env->fpregs[i].mmx.MMX_Q(0);
-            /* vcxt.values[idx].Fp.AsUINT128.High64 =
-                       env->fpregs[i].mmx.MMX_Q(1);
-            */
-        }
-
-        /* FP control status register */
-        assert(whpx_register_names[idx] == WHvX64RegisterFpControlStatus);
-        vcxt.values[idx].FpControlStatus.FpControl = env->fpuc;
-        vcxt.values[idx].FpControlStatus.FpStatus =
-            (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11;
-        vcxt.values[idx].FpControlStatus.FpTag = 0;
-        for (i = 0; i < 8; ++i) {
-            vcxt.values[idx].FpControlStatus.FpTag |= (!env->fptags[i]) << i;
-        }
-        vcxt.values[idx].FpControlStatus.Reserved = 0;
-        vcxt.values[idx].FpControlStatus.LastFpOp = env->fpop;
-        vcxt.values[idx].FpControlStatus.LastFpRip = env->fpip;
-        idx += 1;
-
-        /* XMM control status register */
-        assert(whpx_register_names[idx] == WHvX64RegisterXmmControlStatus);
-        vcxt.values[idx].XmmControlStatus.LastFpRdp = 0;
-        vcxt.values[idx].XmmControlStatus.XmmStatusControl = env->mxcsr;
-        vcxt.values[idx].XmmControlStatus.XmmStatusControlMask = 0x0000ffff;
-        idx += 1;
-
         /* MSRs */
         assert(whpx_register_names[idx] == WHvX64RegisterEfer);
         vcxt.values[idx++].Reg64 = env->efer;
@@ -662,6 +749,110 @@ static void whpx_get_registers_for_vmexit(CPUState *cpu, WHPXStateLevel level)
     x86_update_hflags(env);
 }
 
+static void whpx_get_legacy_fp_registers(CPUState *cpu, WHPXStateLevel level)
+{
+    struct whpx_state *whpx = &whpx_global;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    struct whpx_register_set vcxt;
+    HRESULT hr;
+    int i;
+    int idx;
+    int idx_next;
+
+    assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
+
+    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index,
+        whpx_register_names_legacy_fp,
+        RTL_NUMBER_OF(whpx_register_names_legacy_fp),
+        &vcxt.values[0]);
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get virtual processor context, hr=%08lx",
+                     hr);
+    }
+
+    idx = 0;
+    /* 16 XMM registers */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterXmm0);
+    idx_next = idx + 16;
+    for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
+        env->xmm_regs[i].ZMM_Q(0) = vcxt.values[idx].Reg128.Low64;
+        env->xmm_regs[i].ZMM_Q(1) = vcxt.values[idx].Reg128.High64;
+    }
+    idx = idx_next;
+
+    /* 8 FP registers */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterFpMmx0);
+    for (i = 0; i < 8; i += 1, idx += 1) {
+        env->fpregs[i].mmx.MMX_Q(0) = vcxt.values[idx].Fp.AsUINT128.Low64;
+        /* env->fpregs[i].mmx.MMX_Q(1) =
+               vcxt.values[idx].Fp.AsUINT128.High64;
+        */
+    }
+
+    /* FP control status register */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterFpControlStatus);
+    env->fpuc = vcxt.values[idx].FpControlStatus.FpControl;
+    env->fpstt = (vcxt.values[idx].FpControlStatus.FpStatus >> 11) & 0x7;
+    env->fpus = vcxt.values[idx].FpControlStatus.FpStatus & ~0x3800;
+    for (i = 0; i < 8; ++i) {
+        env->fptags[i] = !((vcxt.values[idx].FpControlStatus.FpTag >> i) & 1);
+    }
+    env->fpop = vcxt.values[idx].FpControlStatus.LastFpOp;
+    env->fpip = vcxt.values[idx].FpControlStatus.LastFpRip;
+    idx += 1;
+
+    /* XMM control status register */
+    assert(whpx_register_names_legacy_fp[idx] == WHvX64RegisterXmmControlStatus);
+    env->mxcsr = vcxt.values[idx].XmmControlStatus.XmmStatusControl;
+    idx += 1;
+}
+
+static int whpx_get_xsave_state(CPUState *cpu)
+{
+    struct whpx_state *whpx = &whpx_global;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    int ret;
+    HRESULT hr;
+    void *xsavec_buf;
+    const size_t page = qemu_real_host_page_size();
+    size_t xsavec_buf_len = whpx_get_xsave_max_len();
+    UINT32 bytes_written;
+
+    xsavec_buf = qemu_memalign(page, xsavec_buf_len);
+    memset(xsavec_buf, 0, xsavec_buf_len);
+
+    if (!whpx_is_legacy_os()) {
+        hr = whp_dispatch.WHvGetVirtualProcessorState(
+            whpx->partition, cpu->cpu_index,
+            WHvVirtualProcessorStateTypeXsaveState,
+            xsavec_buf,
+            xsavec_buf_len, &bytes_written);
+    } else {
+        hr = whp_dispatch.WHvGetVirtualProcessorXsaveState(
+            whpx->partition, cpu->cpu_index,
+            xsavec_buf,
+            xsavec_buf_len, &bytes_written);
+    }
+    if (FAILED(hr) || bytes_written == 0) {
+        error_report("failed to get xsave state: %s", strerror(errno));
+        return -errno;
+    }
+
+    ret = decompact_xsave_area(xsavec_buf, xsavec_buf_len, env);
+    qemu_vfree(xsavec_buf);
+    if (ret < 0) {
+        error_report("failed to decompact xsave area");
+        return ret;
+    }
+    x86_cpu_xrstor_all_areas(x86cpu, env->xsave_buf, env->xsave_buf_len);
+
+    return 0;
+}
+
 void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 {
     struct whpx_state *whpx = &whpx_global;
@@ -758,40 +949,11 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
      */
     whpx_get_xcrs(cpu);
 
-    /* 16 XMM registers */
-    assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
-    idx_next = idx + 16;
-    for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
-        env->xmm_regs[i].ZMM_Q(0) = vcxt.values[idx].Reg128.Low64;
-        env->xmm_regs[i].ZMM_Q(1) = vcxt.values[idx].Reg128.High64;
+    if (whpx_is_xsave_enabled(cpu)) {
+        whpx_get_xsave_state(cpu);
+    } else {
+        whpx_get_legacy_fp_registers(cpu, level);
     }
-    idx = idx_next;
-
-    /* 8 FP registers */
-    assert(whpx_register_names[idx] == WHvX64RegisterFpMmx0);
-    for (i = 0; i < 8; i += 1, idx += 1) {
-        env->fpregs[i].mmx.MMX_Q(0) = vcxt.values[idx].Fp.AsUINT128.Low64;
-        /* env->fpregs[i].mmx.MMX_Q(1) =
-               vcxt.values[idx].Fp.AsUINT128.High64;
-        */
-    }
-
-    /* FP control status register */
-    assert(whpx_register_names[idx] == WHvX64RegisterFpControlStatus);
-    env->fpuc = vcxt.values[idx].FpControlStatus.FpControl;
-    env->fpstt = (vcxt.values[idx].FpControlStatus.FpStatus >> 11) & 0x7;
-    env->fpus = vcxt.values[idx].FpControlStatus.FpStatus & ~0x3800;
-    for (i = 0; i < 8; ++i) {
-        env->fptags[i] = !((vcxt.values[idx].FpControlStatus.FpTag >> i) & 1);
-    }
-    env->fpop = vcxt.values[idx].FpControlStatus.LastFpOp;
-    env->fpip = vcxt.values[idx].FpControlStatus.LastFpRip;
-    idx += 1;
-
-    /* XMM control status register */
-    assert(whpx_register_names[idx] == WHvX64RegisterXmmControlStatus);
-    env->mxcsr = vcxt.values[idx].XmmControlStatus.XmmStatusControl;
-    idx += 1;
 
     /* MSRs */
     assert(whpx_register_names[idx] == WHvX64RegisterEfer);
@@ -1586,6 +1748,9 @@ void whpx_arch_destroy_vcpu(CPUState *cpu)
     X86CPU *x86cpu = X86_CPU(cpu);
     CPUX86State *env = &x86cpu->env;
     g_free(env->emu_mmio_buf);
+    qemu_vfree(env->xsave_buf);
+    env->xsave_buf = NULL;
+    env->xsave_buf_len = 0;
 }
 
 /* Returns the address of the next instruction that is about to be executed. */
@@ -2446,6 +2611,9 @@ int whpx_init_vcpu(CPUState *cpu)
     Error *local_error = NULL;
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
+    X86XSaveHeader *header;
+    size_t page_size = qemu_real_host_page_size();
+    size_t xsave_len;
     UINT64 freq = 0;
     int ret;
 
@@ -2522,6 +2690,15 @@ int whpx_init_vcpu(CPUState *cpu)
     qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);
 
     env->emu_mmio_buf = g_new(char, 4096);
+    /* Initialize XSAVE buffer page-aligned */
+    xsave_len = whpx_get_xsave_max_len();
+    env->xsave_buf = qemu_memalign(page_size, xsave_len);
+    env->xsave_buf_len = xsave_len;
+    memset(env->xsave_buf, 0, env->xsave_buf_len);
+
+    /* we need to set the compacted format bit in xsave header for Hyper-V */
+    header = (X86XSaveHeader *)(env->xsave_buf + sizeof(X86LegacyXSaveArea));
+    header->xcomp_bv = header->xstate_bv | (1ULL << 63);
 
     return 0;
 
@@ -2722,10 +2899,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         error_report("WHPX: Failed to query XSAVE capability, hr=%08lx", hr);
     }
 
-    if (!whpx_has_xsave()) {
-        printf("WHPX: Partition is not XSAVE capable\n");
-    }
-
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ProcessorCount = ms->smp.cpus;
     hr = whp_dispatch.WHvSetPartitionProperty(
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 14b1d2977d5..80062d1d0d8 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -10,7 +10,7 @@ i386_ss.add(when: 'CONFIG_SEV', if_true: files('host-cpu.c', 'confidential-guest
 # x86 cpu type
 i386_ss.add(when: 'CONFIG_KVM', if_true: files('xsave_helper.c', 'host-cpu.c'))
 i386_ss.add(when: 'CONFIG_HVF', if_true: files('xsave_helper.c', 'host-cpu.c'))
-i386_ss.add(when: 'CONFIG_WHPX', if_true: files('host-cpu.c'))
+i386_ss.add(when: 'CONFIG_WHPX', if_true: files('xsave_helper.c', 'host-cpu.c'))
 i386_ss.add(when: 'CONFIG_NVMM', if_true: files('host-cpu.c'))
 i386_ss.add(when: 'CONFIG_MSHV', if_true: files('host-cpu.c'))
 
-- 
2.54.0


