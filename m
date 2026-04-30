Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6681BCD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV9D-000321-Th; Thu, 30 Apr 2026 13:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV8N-0001zC-HX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV8L-0005Ao-Bb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rI6XQ1wKDimuJdX07FWspRnBdPlM+lQZmlUv3zi1ts4=;
 b=D4LA49DH3dja3B74YmPgWW4Z3Z0dIO08FPMvJAMkSm6JDPM1qkrMu7farWhg0g0Tiqk4o9
 f+H7k+Ak0R4XiuklKoKPidRPmbDAHEu+TwoOSamVOQxbBcwCTPnKteBNxWHhu700PI5e+x
 Sw20c31PkZPtx0TN1rs+en4PAFFB6oQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-qHu0IhrHPrCWn2zayKRo2w-1; Thu, 30 Apr 2026 13:25:01 -0400
X-MC-Unique: qHu0IhrHPrCWn2zayKRo2w-1
X-Mimecast-MFC-AGG-ID: qHu0IhrHPrCWn2zayKRo2w_1777569901
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8acaea1ffe7so30383416d6.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569900; x=1778174700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rI6XQ1wKDimuJdX07FWspRnBdPlM+lQZmlUv3zi1ts4=;
 b=gD7I4gdukaK0TF62Y6nxSEPBYHsTgZf20YoxFMyP+yFPupMaqrEyKjbkVbio2lSaKF
 bjAs5N1jx7gaIxoIXqiQlmSn0I8PuYedxhyb1wgBEXPnX3raI4lI0R6oFBUw+S7udrGd
 UppVLPewpbV+fbDfRdYbzKqtHZwx2dxbPDvbc5YxrN2eF5Xk/J2AtTQlgmgZ54d9Lmi4
 Z1KwZ2vtQ/c8lsRKdNbjNV5rl4J1wqrnM9cNXyDyVdWOkQFLv0VuMGDlZ0E317v4HU/b
 i3IVXQQJo44vMAuvqKS2oT6Hx09sVVCQ60dGFvnnisxM6eKnz5QsYv3Jdqbhe2iUJluy
 XYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569900; x=1778174700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rI6XQ1wKDimuJdX07FWspRnBdPlM+lQZmlUv3zi1ts4=;
 b=pNwAf6tzM/hSK0DigfPS7R99dbe2YpnETUne+zTH7K9lfdnXmUvjbtalKjq51Yl+Ao
 Aws84Bh3hi1AEBV5q+I59Atq8xgGU84mNufmTU3oJaXntqMPsQLdf5Rt+jCjHvJQkK2b
 sywhurRva5AogICvaAYC86MIBscKpxXYtivMPSVcr6p8NNpd7g+jyAex5EY0bVTMV85w
 xp3n+2pZf6FhIAjrgoauz958Khtfo/rDgAAgWP+KFFU2uNR6bvLm0ff6/V6uh/3k6s30
 sifj5yp3ubqCw+sfkvuHhA4Sp7/m/7lHxj2OsxCh/4zymsis5xLWTeAwtTEgGlxC6ZOP
 uGWA==
X-Gm-Message-State: AOJu0Yzytt/hnpmnxNxaDHSU6OttXfRbrYqXks+8jE9nX85/reiswPud
 mC62UJJdWDBeJYjwcQD9Y40x8njIQcORz4Pa0aY6k11YKSwBhffqwoxPjGTEphGbWdWsfFyjHHO
 HpzDb4Y5FYvQcRkFDu/Mky8b5SHkMblBV5fIPc9O8QmwQkmm1nadJSLAykhBp482ms5mvIBdrjr
 +aOelRiyY7WnDEEFWivw/cuQ6zYZOFmJkahL8bqzpv
X-Gm-Gg: AeBDiesAUiATND0CWizhPOnM1Sb+8oKT+hFyk1x1lkqQyCAjUBLeBUA151vSFQnxn49
 xb4fKcWWrd/0CZFWIEd1Uik+OTsiviitRmPv6WaED7bWcfuUK+AV5VvlG/BdnKgbT2obd9ThcXW
 GFkTdtJdM1hciXt09FNA9aJdNPRuLiyK8KV0PJw4FR37LVGScPFQUJUuPH5/1ydqLihz6oPaS4L
 gL3fR1aLRzw4bhq9bpA7/5AucV3uKJmnA9S+6Fy7h7msEPDohpy4zxenYuSZlqluw37Eu/BdtrL
 IWw8GZ/qRxshqF5pi4qaFC0gTsH9VndNcDDNvPjjfnV1UZpT1LZ1ZK2aXunhhJvTlemWm3Ys9Gf
 g0beDFU6EBbpK2s/mcRwf7ZezvmSZsmWcsLcmLBfAUK8Z/ZvpEesXIhtSKJkmFW1lz4POJcE+6w
 Er7U7sbTCyUgs8mUAYAmwDzukiCAn9y0WnLT8=
X-Received: by 2002:ad4:5ae2:0:b0:8ac:a6c5:c7d1 with SMTP id
 6a1803df08f44-8b3fe70f50emr59167976d6.8.1777569900136; 
 Thu, 30 Apr 2026 10:25:00 -0700 (PDT)
X-Received: by 2002:ad4:5ae2:0:b0:8ac:a6c5:c7d1 with SMTP id
 6a1803df08f44-8b3fe70f50emr59167296d6.8.1777569899548; 
 Thu, 30 Apr 2026 10:24:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff328884sm22947666d6.14.2026.04.30.10.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 56/58] whpx: i386: add feature to intercept #GP MSR accesses
Date: Thu, 30 Apr 2026 19:22:02 +0200
Message-ID: <20260430172204.1006673-57-pbonzini@redhat.com>
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

It turns out they're not that uncommon, so have
a feature around to log those.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-35-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/whpx-internal.h |   1 +
 accel/whpx/whpx-common.c       |   1 +
 target/i386/whpx/whpx-all.c    | 183 +++++++++++++++++++++++++++++----
 3 files changed, 166 insertions(+), 19 deletions(-)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 0aae83bd7c8..15027a7d524 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -48,6 +48,7 @@ struct whpx_state {
     bool hyperv_enlightenments_enabled;
 
     bool ignore_unknown_msr;
+    bool intercept_msr_gp;
 };
 
 extern struct whpx_state whpx_global;
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 497c03138ec..d846e08714b 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -555,6 +555,7 @@ static void whpx_accel_instance_init(Object *obj)
     /* Value determined at whpx_accel_init */
     whpx->hyperv_enlightenments_enabled = false;
     whpx->ignore_unknown_msr = true;
+    whpx->intercept_msr_gp = false;
 }
 
 static const TypeInfo whpx_accel_type = {
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 5750539ee49..d6bc36686c2 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1008,6 +1008,27 @@ static int emulate_instruction(CPUState *cpu, const uint8_t *insn_bytes, size_t
     return 0;
 }
 
+static int emulate_msr_instruction(CPUState *cpu,
+            const uint8_t *insn_bytes, size_t insn_len)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    struct x86_decode decode = { 0 };
+    x86_insn_stream stream = { .bytes = insn_bytes, .len = insn_len };
+
+    whpx_get_registers(cpu, WHPX_LEVEL_FAST_RUNTIME_STATE);
+    decode_instruction_stream(env, &decode, &stream);
+
+    if (decode.cmd != X86_DECODE_CMD_RDMSR
+        && decode.cmd != X86_DECODE_CMD_WRMSR) {
+        return 1;
+    }
+
+    exec_instruction(env, &decode);
+    whpx_set_registers(cpu, WHPX_LEVEL_FAST_RUNTIME_STATE);
+    return 0;
+}
+
 static int whpx_handle_mmio(CPUState *cpu, WHV_RUN_VP_EXIT_CONTEXT *exit_ctx)
 {
     WHV_MEMORY_ACCESS_CONTEXT *ctx = &exit_ctx->MemoryAccess;
@@ -1022,6 +1043,45 @@ static int whpx_handle_mmio(CPUState *cpu, WHV_RUN_VP_EXIT_CONTEXT *exit_ctx)
     return 0;
 }
 
+static int whpx_handle_msr_from_gpf(CPUState *cpu)
+{
+    WHV_VP_EXCEPTION_CONTEXT *ctx = &cpu->accel->exit_ctx.VpException;
+    int ret;
+
+    ret = emulate_msr_instruction(cpu, ctx->InstructionBytes, ctx->InstructionByteCount);
+    if (ret == 1) {
+        /* Not an MSR instruction */
+        return 1;
+    }
+
+    return 0;
+}
+
+static void whpx_inject_back_gpf(CPUState *cpu)
+{
+    WHV_VP_EXCEPTION_CONTEXT *ctx = &cpu->accel->exit_ctx.VpException;
+    WHV_REGISTER_VALUE reg = {};
+
+    if (ctx->ExceptionInfo.SoftwareException) {
+        /* TODO */
+        warn_report("Was asked to inject software exception.");
+        return;
+    }
+
+    if (ctx->ExceptionType != EXCP0D_GPF) {
+        warn_report("Was asked to inject exception other than GPF.");
+        return;
+    }
+
+    reg.ExceptionEvent.EventPending = 1;
+    reg.ExceptionEvent.EventType = WHvX64PendingEventException;
+    reg.ExceptionEvent.DeliverErrorCode = ctx->ExceptionInfo.ErrorCodeValid;
+    reg.ExceptionEvent.Vector = ctx->ExceptionType;
+    reg.ExceptionEvent.ErrorCode = ctx->ErrorCode;
+    reg.ExceptionEvent.ExceptionParameter = ctx->ExceptionParameter;
+    whpx_set_reg(cpu, WHvRegisterPendingEvent, reg);
+}
+
 static void handle_io(CPUState *env, uint16_t port, void *buffer,
                   int direction, int size, int count)
 {
@@ -1210,13 +1270,54 @@ static target_ulong read_cr(CPUState *cpu, int cr)
     return val.Reg64;
 }
 
+static bool whpx_simulate_rdmsr(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    uint32_t msr = ECX(env);
+    uint64_t val = 0;
+
+    switch (msr) {
+    default:
+        error_report("WHPX: unknown msr 0x%x", msr);
+        x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+        return 1;
+        break;
+    }
+
+    RAX(env) = (uint32_t)val;
+    RDX(env) = (uint32_t)(val >> 32);
+
+    return 0;
+}
+
+static bool whpx_simulate_wrmsr(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    uint32_t msr = ECX(env);
+    uint64_t data = ((uint64_t)EDX(env) << 32) | EAX(env);
+
+    switch (msr) {
+    default:
+        error_report("WHPX: unknown msr 0x%x val %llx", msr, data);
+        x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+        return 1;
+        break;
+    }
+
+    return 0;
+}
+
 static const struct x86_emul_ops whpx_x86_emul_ops = {
     .read_segment_descriptor = read_segment_descriptor,
     .handle_io = handle_io,
     .is_protected_mode = is_protected_mode,
     .is_long_mode = is_long_mode,
     .is_user_mode = is_user_mode,
-    .read_cr = read_cr
+    .read_cr = read_cr,
+    .simulate_rdmsr = whpx_simulate_rdmsr,
+    .simulate_wrmsr = whpx_simulate_wrmsr
 };
 
 static void whpx_init_emu(void)
@@ -1356,6 +1457,18 @@ uint64_t whpx_get_supported_msr_feature(uint32_t index)
     return 0;
 }
 
+static UINT64 whpx_get_default_exceptions(void)
+{
+    struct whpx_state *whpx = &whpx_global;
+    UINT64 intercepts = 0;
+
+    if (whpx->intercept_msr_gp) {
+        intercepts |= 1UL << WHvX64ExceptionTypeGeneralProtectionFault;
+    }
+
+    return intercepts;
+}
+
 /*
  * Controls whether we should intercept various exceptions on the guest,
  * namely breakpoint/single-step events.
@@ -1378,7 +1491,7 @@ HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
     prop.ExtendedVmExits.X64MsrExit = 1;
     prop.ExtendedVmExits.X64CpuidExit = 1;
 
-    if (exceptions != 0) {
+    if (exceptions != 0 || whpx_get_default_exceptions() != 0) {
         prop.ExtendedVmExits.ExceptionExit = 1;
     }
 
@@ -1393,7 +1506,7 @@ HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
     }
 
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
-    prop.ExceptionExitBitmap = exceptions;
+    prop.ExceptionExitBitmap = exceptions | whpx_get_default_exceptions();
 
     hr = whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
@@ -1403,6 +1516,8 @@ HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
 
     if (SUCCEEDED(hr)) {
         whpx->exception_exit_bitmap = exceptions;
+    } else {
+        error_report("WHPX: Failed to set exception exit bitmap, hr=%08lx", hr);
     }
 
     return hr;
@@ -2518,6 +2633,15 @@ int whpx_vcpu_run(CPUState *cpu)
             break;
         }
         case WHvRunVpExitReasonException:
+            if (vcpu->exit_ctx.VpException.ExceptionType ==
+                WHvX64ExceptionTypeGeneralProtectionFault) {
+                if (whpx_handle_msr_from_gpf(cpu)) {
+                    whpx_inject_back_gpf(cpu);
+                }
+                ret = 0;
+                break;
+            }
+
             whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
 
             if ((vcpu->exit_ctx.VpException.ExceptionType ==
@@ -2806,6 +2930,38 @@ static void whpx_set_unknown_msr(Object *obj, Visitor *v,
     }
 }
 
+static void whpx_set_intercept_msr_gp(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    struct whpx_state *whpx = &whpx_global;
+    OnOffAuto mode;
+
+    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
+        return;
+    }
+
+    switch (mode) {
+    case ON_OFF_AUTO_ON:
+        whpx->intercept_msr_gp = true;
+        break;
+
+    case ON_OFF_AUTO_OFF:
+        whpx->intercept_msr_gp = false;
+        break;
+
+    case ON_OFF_AUTO_AUTO:
+        whpx->intercept_msr_gp = false;
+        break;
+    default:
+        /*
+         * The value was checked in visit_type_OnOffAuto() above. If
+         * we get here, then something is wrong in QEMU.
+         */
+        abort();
+    }
+}
+
 void whpx_arch_accel_class_init(ObjectClass *oc)
 {
     object_class_property_add(oc, "ignore-unknown-msr", "OnOffAuto",
@@ -2813,6 +2969,11 @@ void whpx_arch_accel_class_init(ObjectClass *oc)
         NULL, NULL);
     object_class_property_set_description(oc, "ignore-unknown-msr",
         "Configure unknown MSR behavior");
+    object_class_property_add(oc, "intercept-msr-gp", "OnOffAuto",
+        NULL, whpx_set_intercept_msr_gp,
+        NULL, NULL);
+    object_class_property_set_description(oc, "intercept-msr-gp",
+        "Intercept #GP to log erroring MSR accesses.");
 }
 
 int whpx_accel_init(AccelState *as, MachineState *ms)
@@ -3067,22 +3228,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    /* Register for MSR and CPUID exits */
-    memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
-    prop.ExtendedVmExits.X64MsrExit = 1;
-    prop.ExtendedVmExits.X64CpuidExit = 1;
-
-    hr = whp_dispatch.WHvSetPartitionProperty(
-            whpx->partition,
-            WHvPartitionPropertyCodeExtendedVmExits,
-            &prop,
-            sizeof(WHV_PARTITION_PROPERTY));
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to enable extended VM exits, hr=%08lx", hr);
-        ret = -EINVAL;
-        goto error;
-    }
-
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.X64MsrExitBitmap.UnhandledMsrs = 1;
     prop.X64MsrExitBitmap.ApicBaseMsrWrite = 1;
-- 
2.54.0


