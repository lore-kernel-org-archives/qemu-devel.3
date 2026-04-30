Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C44CD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7g-00073R-RO; Thu, 30 Apr 2026 13:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7R-0005qF-0q
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7P-0004nN-4b
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UtYPUP+zX5XFauzLUam2kOgdCIkSyTwZpZcAHKldk2A=;
 b=REt/EHqGLAiFyyfhd8RBduZTeGU0+4MZDQtIs4o2kq5csmvSJEemQxLFM8IfjWVput5hV+
 9Bg5/bWqDaNMCOjQ/3K/ZaDrslkWRFfvtGX1RGI5Lu2ibcrT8TjjeQCLWcUBFczOzgRWuE
 6/v+YvcGoT5LWt9aIweIl52+0QPsnDQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-9I07aE_SM_-_SKCMAYLP-A-1; Thu, 30 Apr 2026 13:24:05 -0400
X-MC-Unique: 9I07aE_SM_-_SKCMAYLP-A-1
X-Mimecast-MFC-AGG-ID: 9I07aE_SM_-_SKCMAYLP-A_1777569845
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50e575a50bcso14866391cf.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569844; x=1778174644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UtYPUP+zX5XFauzLUam2kOgdCIkSyTwZpZcAHKldk2A=;
 b=DqQTGeNE2+1Sm9Kfs8v/zT9ugGXzpoTQDE0eE4ANEtUshIVR2bV3Vr/PWT/UoSlU0U
 RfCSX9cx3vNuzoW9zj4EvmQTlfV9d5zmTFHkUIQxC5RHUr28p1MtV8hF9AgY+7aKe77l
 +VaACi0cLxU74SEH6pbes9KzPV3zAxuqerZNSf+KCkfdwOk83Iu++lA15NKh9C9sxTX4
 J/qu4TQ0de1Os2GpJqoxP8+At+t7LisQbgm3Q/Jvkg343zvo/oStuPVe/0Th8tlTJI6G
 irbUrrOGq+/7/s3jN97X5Mh7J08pFol182DGZtWe+ihSIwOsKsess4fl/wr48fxayIoW
 8BQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569844; x=1778174644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UtYPUP+zX5XFauzLUam2kOgdCIkSyTwZpZcAHKldk2A=;
 b=mOwTLBNvNKNZr49XAvANQbxz+r/9Q5w6UJVjwf5Mm46wZQmanG2YObi/z/LiozEzES
 Z1JN4EzV75PrOwGnIItcc3xXeFQxHrvITti3r4Wna6ZHVl+1X1GWqEzfgK1hDkKSfgvc
 rV+NoRoDjdrllF4fVYddZo+NwKY4dYvg3aqJh7oKsOloaqQ/jrn94TRhTKM29z7RIXmp
 W/WX+w+zdwu7bHrhZZ8mY+fbUFSyHSM7w++xuVpSyt4FmyCPnPjRmD8sOJAasK3lOyT5
 2yfwv+2mv+wHJJhyn+QYWCFSmQ6RNPlYJ8bzlyPHdk8K80tEaG6kjAk4kJZjjt9HDfnO
 yqcQ==
X-Gm-Message-State: AOJu0Yz27JwAjirVbvzt9LQTUfKENnPJMozwIS6lm43MhfQVo+5LXv8K
 CozZp+Qtfdcsha+RSYk4dZ5OfXgON4jpB8O93PCGwwRpNsVCvbGYDjfohaEu+iFzn8GcfQHkw0l
 8HCM2Ummg/u5mx6sgVowXpqRgMFulXWi8i/CKO5KsbT0RhN6eIeolxgKgVSiSKbPXk7Nrjl81jX
 PFHqwQHg1eNXvBssw0J8RmmJ/smlIFgYZVUVM7HTGk
X-Gm-Gg: AeBDievMKlEpxrSCb59AbpK7cMO8kV2DRwQAxwy5MUszCsRPcPdkGU6nA8VdSwetbm9
 XluP0ZNxxQMCci+3WLP3GUX6OMR/3suBl1ciMuS+YH29j7BiczKresAwWzfmmDOUSaYulsck6LJ
 UMsfRre7FWeEP4KMzCZok8RXyZkG3GTteLA0u54YvNNJGuHSxaQ0nh2rCpxinLbAEiY0tuWiqZt
 mC503BCNzptqHHJ8814i3sn/CKcJS6Yj1lnvlU/FhMS2/5I5RGvMw4vronhCVDS6jDfe3DN/Ddk
 T3IQp98+Z3q24gcG+TpL02DLl1jnUgCQJR+1L5AYcnuKs84pEZ0KX6KLSNLPDGF5k/I3Ma4EARb
 j/Wn26fpTZUsf6ZAsrL62EQ3IA/PlUT0pXdO6D33s9PEYFqmi3vJa31NfvT2M29rpeEJnSHWevz
 TnS0NrrJb3KH3+SPZPHpNPbjfXwjDtAqKvTzg=
X-Received: by 2002:a05:622a:199d:b0:50f:ae60:25ab with SMTP id
 d75a77b69052e-5102ab1c0abmr56558881cf.12.1777569843696; 
 Thu, 30 Apr 2026 10:24:03 -0700 (PDT)
X-Received: by 2002:a05:622a:199d:b0:50f:ae60:25ab with SMTP id
 d75a77b69052e-5102ab1c0abmr56558101cf.12.1777569843084; 
 Thu, 30 Apr 2026 10:24:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d31247asm254421cf.21.2026.04.30.10.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 37/58] whpx: i386: fix CPUID[1:EDX].APIC reporting
Date: Thu, 30 Apr 2026 19:21:43 +0200
Message-ID: <20260430172204.1006673-38-pbonzini@redhat.com>
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

Hyper-V always has CPUID[1:EDX].APIC set, even when the APIC isn't enabled yet.

Work around this by also using the APICBASE trap for kernel-irqchip=on.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-16-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/whpx-common.h |  1 -
 target/i386/whpx/whpx-all.c  | 34 ++++++++---------
 target/i386/whpx/whpx-apic.c | 71 ++++++++++++++++++++++++++++++++++--
 3 files changed, 84 insertions(+), 22 deletions(-)

diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 3406c20fec0..79710e2fb3c 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -8,7 +8,6 @@ struct AccelCPUState {
     bool interruptable;
     bool ready_for_pic_interrupt;
     uint64_t tpr;
-    uint64_t apic_base;
     bool interruption_pending;
     /* Must be the last field as it may have a tail */
     WHV_RUN_VP_EXIT_CONTEXT exit_ctx;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 012fa6d0216..b0556445801 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -139,7 +139,6 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
 #ifdef TARGET_X86_64
     WHvX64RegisterKernelGsBase,
 #endif
-    WHvX64RegisterApicBase,
     /* WHvX64RegisterPat, */
     WHvX64RegisterSysenterCs,
     WHvX64RegisterSysenterEip,
@@ -420,7 +419,6 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
     r86 = !(env->cr[0] & CR0_PE_MASK);
 
     vcpu->tpr = cpu_get_apic_tpr(x86_cpu->apic_state);
-    vcpu->apic_base = cpu_get_apic_base(x86_cpu->apic_state);
 
     idx = 0;
 
@@ -538,9 +536,6 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
         vcxt.values[idx++].Reg64 = env->kernelgsbase;
 #endif
 
-        assert(whpx_register_names[idx] == WHvX64RegisterApicBase);
-        vcxt.values[idx++].Reg64 = vcpu->apic_base;
-
         /* WHvX64RegisterPat - Skipped */
 
         assert(whpx_register_names[idx] == WHvX64RegisterSysenterCs);
@@ -575,6 +570,12 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
         error_report("WHPX: Failed to set virtual processor context, hr=%08lx",
                      hr);
     }
+
+    if (level >= WHPX_LEVEL_FULL_STATE) {
+        WHV_REGISTER_VALUE apic_base = {};
+        apic_base.Reg64 = cpu_get_apic_base(X86_CPU(cpu)->apic_state);
+        whpx_set_reg(cpu, WHvX64RegisterApicBase, apic_base);
+    }
 }
 
 static int whpx_get_tsc(CPUState *cpu)
@@ -666,7 +667,7 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
     struct whpx_register_set vcxt;
-    uint64_t tpr, apic_base;
+    uint64_t tpr;
     HRESULT hr;
     int idx;
     int idx_next;
@@ -798,13 +799,6 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     env->kernelgsbase = vcxt.values[idx++].Reg64;
 #endif
 
-    assert(whpx_register_names[idx] == WHvX64RegisterApicBase);
-    apic_base = vcxt.values[idx++].Reg64;
-    if (apic_base != vcpu->apic_base) {
-        vcpu->apic_base = apic_base;
-        cpu_set_apic_base(x86_cpu->apic_state, vcpu->apic_base);
-    }
-
     /* WHvX64RegisterPat - Skipped */
 
     assert(whpx_register_names[idx] == WHvX64RegisterSysenterCs);
@@ -2082,8 +2076,7 @@ int whpx_vcpu_run(CPUState *cpu)
                 val = X86_CPU(cpu)->env.apic_bus_freq;
             }
 
-            if (!whpx_irqchip_in_kernel() &&
-                vcpu->exit_ctx.MsrAccess.MsrNumber == MSR_IA32_APICBASE) {
+            if (vcpu->exit_ctx.MsrAccess.MsrNumber == MSR_IA32_APICBASE) {
                 is_known_msr = 1;
                 if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
                     /* Read path unreachable on Hyper-V */
@@ -2233,6 +2226,13 @@ int whpx_vcpu_run(CPUState *cpu)
                 } else {
                     reg_values[2].Reg32 &= ~CPUID_EXT_X2APIC;
                 }
+
+                /* CPUID[1:EDX].APIC is dynamic */
+                if (env->features[FEAT_1_EDX] & CPUID_APIC) {
+                    reg_values[3].Reg32 |= CPUID_APIC;
+                } else {
+                    reg_values[3].Reg32 &= ~CPUID_APIC;
+                }
             }
 
             /* Dynamic depending on XCR0 and XSS, so query DefaultResult */
@@ -2804,9 +2804,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.X64MsrExitBitmap.UnhandledMsrs = 1;
-    if (!whpx_irqchip_in_kernel()) {
-        prop.X64MsrExitBitmap.ApicBaseMsrWrite = 1;
-    }
+    prop.X64MsrExitBitmap.ApicBaseMsrWrite = 1;
 
     hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index f26ecaf6e83..65629ca45f9 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -90,9 +90,70 @@ static void whpx_get_apic_state(APICCommonState *s,
     apic_next_timer(s, s->initial_count_load_time);
 }
 
-static int whpx_apic_set_base(APICCommonState *s, uint64_t val)
+static int apic_set_base_check(APICCommonState *s, uint64_t val)
 {
-    s->apicbase = val;
+    /* Enable x2apic when x2apic is not supported by CPU */
+    if (!cpu_has_x2apic_feature(&s->cpu->env) &&
+        val & MSR_IA32_APICBASE_EXTD) {
+        return -1;
+    }
+
+    /*
+     * Transition into invalid state
+     * (s->apicbase & MSR_IA32_APICBASE_ENABLE == 0) &&
+     * (s->apicbase & MSR_IA32_APICBASE_EXTD) == 1
+     */
+    if (!(val & MSR_IA32_APICBASE_ENABLE) &&
+        (val & MSR_IA32_APICBASE_EXTD)) {
+        return -1;
+    }
+
+    /* Invalid transition from disabled mode to x2APIC */
+    if (!(s->apicbase & MSR_IA32_APICBASE_ENABLE) &&
+        !(s->apicbase & MSR_IA32_APICBASE_EXTD) &&
+        (val & MSR_IA32_APICBASE_ENABLE) &&
+        (val & MSR_IA32_APICBASE_EXTD)) {
+        return -1;
+    }
+
+    /* Invalid transition from x2APIC to xAPIC */
+    if ((s->apicbase & MSR_IA32_APICBASE_ENABLE) &&
+        (s->apicbase & MSR_IA32_APICBASE_EXTD) &&
+        (val & MSR_IA32_APICBASE_ENABLE) &&
+        !(val & MSR_IA32_APICBASE_EXTD)) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static int apic_set_base(APICCommonState *s, uint64_t val)
+{
+    if (apic_set_base_check(s, val) < 0) {
+        return -1;
+    }
+
+    s->apicbase = (val & MSR_IA32_APICBASE_BASE) |
+        (s->apicbase & (MSR_IA32_APICBASE_BSP | MSR_IA32_APICBASE_ENABLE));
+    if (!(val & MSR_IA32_APICBASE_ENABLE)) {
+        s->apicbase &= ~MSR_IA32_APICBASE_ENABLE;
+        cpu_clear_apic_feature(&s->cpu->env);
+    }
+
+    /* Transition from disabled mode to xAPIC */
+    if (!(s->apicbase & MSR_IA32_APICBASE_ENABLE) &&
+        (val & MSR_IA32_APICBASE_ENABLE)) {
+        s->apicbase |= MSR_IA32_APICBASE_ENABLE;
+        cpu_set_apic_feature(&s->cpu->env);
+    }
+
+    /* Transition from xAPIC to x2APIC */
+    if (cpu_has_x2apic_feature(&s->cpu->env) &&
+        !(s->apicbase & MSR_IA32_APICBASE_EXTD) &&
+        (val & MSR_IA32_APICBASE_EXTD)) {
+        s->apicbase |= MSR_IA32_APICBASE_EXTD;
+    }
+
     return 0;
 }
 
@@ -235,6 +296,10 @@ static void whpx_apic_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps whpx_apic_io_ops = {
     .read = whpx_apic_mem_read,
     .write = whpx_apic_mem_write,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
@@ -262,7 +327,7 @@ static void whpx_apic_class_init(ObjectClass *klass, const void *data)
 
     k->realize = whpx_apic_realize;
     k->reset = whpx_apic_reset;
-    k->set_base = whpx_apic_set_base;
+    k->set_base = apic_set_base;
     k->set_tpr = whpx_apic_set_tpr;
     k->get_tpr = whpx_apic_get_tpr;
     k->post_load = whpx_apic_post_load;
-- 
2.54.0


