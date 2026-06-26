Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A04CDE00C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eZ-0000lI-2m; Fri, 26 Jun 2026 06:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eQ-0000BB-W4
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eO-0005MP-NA
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dz1pu6mWfW58JROqNGnbicb8BcOiLwuqIScXaYTXhqU=;
 b=GNSY8CVy4ATqtpO48BWuhR81V51gRW8MKCSNnmVDzXK4FnhclBkaZc17zoTG5WDusqmOPl
 ma3fHYevwvpbwxzFcfdfuvdnVcKpKSMk10f8MYGdrpdRhj/idNAG9DubEfFaeUqhj67iY0
 nQdLcJEhEZ4ijkpeGyyAtdT/5huT0y0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-MbhXTfb8NfiQANkN0o2l1w-1; Fri, 26 Jun 2026 06:19:06 -0400
X-MC-Unique: MbhXTfb8NfiQANkN0o2l1w-1
X-Mimecast-MFC-AGG-ID: MbhXTfb8NfiQANkN0o2l1w_1782469146
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46fb9079a04so901f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469145; x=1783073945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dz1pu6mWfW58JROqNGnbicb8BcOiLwuqIScXaYTXhqU=;
 b=li2eQVVd0tst6vqugC6KFnxpOTpTGdA9MKm9z6qwBI2FK3eHZqhJXaP4Ttp8IJ4KUI
 pQ2jTF80K6sKnpjbSnoAd7LtcnABdtxEQUG31KGZ19E43PpEJvN7oNKtz+wxnrcJTRLu
 4XI1jBM0/w7YXB9m60l0fbf02lxgougiKTbHsS7gQEsH79xmSczrKprCGckD1bmwWutb
 uT3fECf91d3MNKijwKcFYqurMyO+togdtpZLgdMO6tgnXSGJi2wD06HRoiTKKzhy2khH
 3QZ6wxZlmukE20vP3hfVXDUUeCAluhNMobpCPoNlWikPR18U7jS1AKapJ4ZtV/J6PLf4
 UXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469145; x=1783073945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dz1pu6mWfW58JROqNGnbicb8BcOiLwuqIScXaYTXhqU=;
 b=YpNLsDgP7M7d/5SkDwkzye2Lw/f09/iOECeM7n9CaMovHtR/J5+WJmzJaY0DC8wWF7
 +mtWalVIRlgQW8BaxpdPtfusSQ5DVXoQcVwtmjuYwB/pelk4M3t2B6rPQZMienJysFcH
 3sIQX5LNrOFZH7e8MlPX4ZsRn3xsbZGwi7SjBzJup2fyxiHGxL7iKbSOU26mdXitL5eh
 RJpF4TC+2lAb5Bvu2r3loAJHVBkGPgUHaiCCiAPo/E1NnUeSAODZwCRYdWulc4IJ525g
 kdo5Vc63pEXHKLfX324uE23Qkmiea4Lyq+X/WneFSSfCIoATENVeuYx6vx8aDE1aeKwE
 M48g==
X-Gm-Message-State: AOJu0YwRuPqNU/Oi1g8JkchTpxFMGUiPtwLZdV7/vqzarEzVYuZJ8fJh
 UflA+XeOxe7D1H7LhrJRcld+Pd+3A2PjUKygejl4ZRtKLcr2X+RRpEWkXZDjsSKFScOFck5m2cF
 l7AFmlN8B+eT5EQWpzBYWVzphH3XIfWY6WZnZpTV9eldK/nKPMAF0e031qWtuNTsyyeF5iWDbNJ
 SAlyavr459auwE2sFFYC9JsaPV2BFnHQDxKCLTz/0C
X-Gm-Gg: AfdE7clgFxwvhqijC657p0MXV73m7fOQccdtkW6Aj/wTTIh9HVJgfbOroHxaZiqzA+V
 lqBbCGRwaDb7QZBa8yls+jeLUpu7oiImHe5te5hlzPQvlvaQsq5ttLi+hGHGU5UWHcneaS9sXbK
 Jdss+HlfwiGSRh0Ju5ExV38GSJSAY70GhHTqJ4YeAENxF2xVdXYjC8WQYR797S056MfZUVNlQR3
 GlTPKdxqn+BSmomih8S9O80miYe7Xr/rESvrhDEC8PscEb8B/KR+Rm3rcgtyh1w79FOzij5n/eZ
 noIn5KqF3ED6TdJi2ACxAEJlHWGmj3QvCKE8phJe0MXL6FytxOgLWF8bo0yT4Yvc2I7BHQmZsCR
 9JDfVydydLjxY2skB1/pqDomlSPqFBxljSTgn6hBaAQmSicn4Wxf/iyu3zvxm4sOhVe1YljUkF+
 QGtqI3/CufbGq5GVK4
X-Received: by 2002:a5d:6e54:0:b0:46f:558:a43e with SMTP id
 ffacd0b85a97d-46fb6bf2e92mr50999f8f.9.1782469145434; 
 Fri, 26 Jun 2026 03:19:05 -0700 (PDT)
X-Received: by 2002:a5d:6e54:0:b0:46f:558:a43e with SMTP id
 ffacd0b85a97d-46fb6bf2e92mr50934f8f.9.1782469144793; 
 Fri, 26 Jun 2026 03:19:04 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46e3d6ba143sm10718446f8f.33.2026.06.26.03.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 27/45] target/i386/mshv: migrate pending ints/excs
Date: Fri, 26 Jun 2026 12:17:30 +0200
Message-ID: <20260626101748.1728079-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

We use PENDING_INTERRUPTION, INTERRUPT_STATE, PENDING_EVENT hv registers
to map and roundtrip from/to CPUX86State.

We ignore HV_REGISTER_PENDING_EVENT1 which represent events for nested
virt contexts, as we don't support nested virt with MSHV currently.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-30-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/hyperv/hvgdk_mini.h |   3 +
 include/system/mshv_int.h      |  14 +++
 target/i386/mshv/mshv-cpu.c    | 168 +++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index 367519143e2..81fe7f7efb0 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -12,6 +12,9 @@
 typedef enum hv_register_name {
     /* Pending Interruption Register */
     HV_REGISTER_PENDING_INTERRUPTION = 0x00010002,
+    HV_REGISTER_INTERRUPT_STATE      = 0x00010003,
+    HV_REGISTER_PENDING_EVENT0       = 0x00010004,
+    HV_REGISTER_PENDING_EVENT1       = 0x00010005,
 
     /* X64 User-Mode Registers */
     HV_X64_REGISTER_RAX     = 0x00020000,
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 3bdf16ecd35..5a30dceeea8 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -17,6 +17,20 @@
 #include "hw/hyperv/hvhdk.h"
 
 #define MSHV_MSR_ENTRIES_COUNT 64
+
+/*
+ * Interruption-type encoding, used by the hypervisor in
+ * hv_x64_pending_interruption_register.interruption_type
+ * See TLFS 6.0 section 7.9.2, p55
+ * https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs
+ */
+#define MSHV_HV_INTERRUPTION_TYPE_EXT_INT     0
+#define MSHV_HV_INTERRUPTION_TYPE_NMI         2
+#define MSHV_HV_INTERRUPTION_TYPE_HW_EXC      3
+#define MSHV_HV_INTERRUPTION_TYPE_SW_INT      4
+#define MSHV_HV_INTERRUPTION_TYPE_PRIV_SW_EXC 5
+#define MSHV_HV_INTERRUPTION_TYPE_SW_EXC      6
+
 #define MSHV_DIRTY_PAGES_BATCH_SIZE 0x10000
 
 typedef struct hyperv_message hv_message;
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index a0a25cd2c05..9f513a0e436 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -535,6 +535,164 @@ static int load_regs(CPUState *cpu)
     return 0;
 }
 
+static int get_vcpu_events(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    struct hv_register_assoc assocs[] = {
+        { .name = HV_REGISTER_PENDING_INTERRUPTION },
+        { .name = HV_REGISTER_INTERRUPT_STATE },
+        { .name = HV_REGISTER_PENDING_EVENT0 },
+    };
+    union hv_x64_pending_interruption_register pending_int;
+    union hv_x64_interrupt_state_register int_state;
+    union hv_x64_pending_exception_event pending_exc;
+    int ret;
+
+    ret = mshv_get_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
+    if (ret < 0) {
+        error_report("failed to get vcpu event registers");
+        return -1;
+    }
+
+    pending_int.as_uint64 = assocs[0].value.reg64;
+    int_state.as_uint64 = assocs[1].value.reg64;
+    pending_exc = assocs[2].value.pending_exception_event;
+
+    /* Clear previous state. injected ints/excs are blanked w/ -1 */
+    env->interrupt_injected    = -1;
+    env->soft_interrupt        = 0;
+    env->exception_injected    = 0;
+    env->exception_pending     = 0;
+    env->exception_nr          = -1;
+    env->has_error_code        = 0;
+    env->error_code            = 0;
+    env->exception_has_payload = 0;
+    env->exception_payload     = 0;
+    env->nmi_injected          = 0;
+
+    if (pending_int.interruption_pending) {
+        switch (pending_int.interruption_type) {
+        case MSHV_HV_INTERRUPTION_TYPE_EXT_INT:
+            env->interrupt_injected = pending_int.interruption_vector;
+            break;
+        case MSHV_HV_INTERRUPTION_TYPE_NMI:
+            env->nmi_injected = 1;
+            break;
+        case MSHV_HV_INTERRUPTION_TYPE_HW_EXC:
+            env->exception_injected = 1;
+            env->exception_nr       = pending_int.interruption_vector;
+            env->has_error_code     = pending_int.deliver_error_code;
+            env->error_code         = pending_int.error_code;
+            break;
+        case MSHV_HV_INTERRUPTION_TYPE_SW_INT:
+            env->interrupt_injected = pending_int.interruption_vector;
+            env->soft_interrupt     = 1;
+            break;
+        case MSHV_HV_INTERRUPTION_TYPE_SW_EXC:
+        case MSHV_HV_INTERRUPTION_TYPE_PRIV_SW_EXC:
+            env->exception_injected = 1;
+            env->exception_nr       = pending_int.interruption_vector;
+            env->has_error_code     = pending_int.deliver_error_code;
+            env->error_code         = pending_int.error_code;
+            break;
+        default:
+            error_report("unknown interruption type %u",
+                         pending_int.interruption_type);
+            return -EINVAL;
+        }
+    }
+
+    /* disabled for one instr after STI, MOV/POP SS, see hvf_store_events() */
+    if (int_state.interrupt_shadow) {
+        env->hflags |= HF_INHIBIT_IRQ_MASK;
+    } else {
+        env->hflags &= ~HF_INHIBIT_IRQ_MASK;
+    }
+
+    /* see kvm_get_vcpu_events(), hvf_store_events() */
+    if (int_state.nmi_masked) {
+        env->hflags2 |= HF2_NMI_MASK;
+    } else {
+        env->hflags2 &= ~HF2_NMI_MASK;
+    }
+
+    /* HV_REGISTER_PENDING_EVENT0: pending exception not yet injected */
+    if (pending_exc.event_pending) {
+        env->exception_pending     = 1;
+        env->exception_nr          = pending_exc.vector;
+        env->has_error_code        = pending_exc.deliver_error_code;
+        env->error_code            = pending_exc.error_code;
+        env->exception_has_payload = (pending_exc.exception_parameter != 0);
+        env->exception_payload     = pending_exc.exception_parameter;
+    }
+
+    /*
+     * Ignoring HV_REGISTER_PENDING_EVENT1, virtualization fault events, MSHV
+     * does not support nested virtualization.
+     */
+
+    return 0;
+}
+
+static int set_vcpu_events(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    union hv_x64_pending_interruption_register pending_int = { 0 };
+    union hv_x64_interrupt_state_register int_state = { 0 };
+    union hv_x64_pending_exception_event pending_exc = { 0 };
+    struct hv_register_assoc assocs[3];
+    int ret;
+
+    /* build pending_int from CPUX86State */
+    if (env->exception_injected) {
+        pending_int.interruption_pending = 1;
+        pending_int.interruption_type    = MSHV_HV_INTERRUPTION_TYPE_HW_EXC;
+        pending_int.interruption_vector  = env->exception_nr;
+        pending_int.deliver_error_code   = env->has_error_code;
+        pending_int.error_code           = env->error_code;
+    } else if (env->nmi_injected) {
+        pending_int.interruption_pending = 1;
+        pending_int.interruption_type    = MSHV_HV_INTERRUPTION_TYPE_NMI;
+        pending_int.interruption_vector  = EXCP02_NMI;
+    } else if (env->interrupt_injected >= 0) {
+        pending_int.interruption_pending = 1;
+        pending_int.interruption_type    = env->soft_interrupt
+            ? MSHV_HV_INTERRUPTION_TYPE_SW_INT
+            : MSHV_HV_INTERRUPTION_TYPE_EXT_INT;
+        pending_int.interruption_vector  = env->interrupt_injected;
+    }
+
+    /* build int_state, normalize to bool */
+    int_state.interrupt_shadow = !!(env->hflags  & HF_INHIBIT_IRQ_MASK);
+    int_state.nmi_masked       = !!(env->hflags2 & HF2_NMI_MASK);
+
+    /* build pending_exc */
+    if (env->exception_pending) {
+        pending_exc.event_pending       = 1;
+        pending_exc.vector              = env->exception_nr;
+        pending_exc.deliver_error_code  = env->has_error_code;
+        pending_exc.error_code          = env->error_code;
+        pending_exc.exception_parameter = env->exception_payload;
+    }
+
+    assocs[0].name = HV_REGISTER_PENDING_INTERRUPTION;
+    assocs[0].value.reg64 = pending_int.as_uint64;
+    assocs[1].name = HV_REGISTER_INTERRUPT_STATE;
+    assocs[1].value.reg64 = int_state.as_uint64;
+    assocs[2].name = HV_REGISTER_PENDING_EVENT0;
+    assocs[2].value.pending_exception_event = pending_exc;
+
+    ret = mshv_set_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
+    if (ret < 0) {
+        error_report("failed to set vcpu event registers");
+        return -1;
+    }
+
+    return 0;
+}
+
 int mshv_arch_load_vcpu_state(CPUState *cpu)
 {
     int ret;
@@ -559,6 +717,11 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    ret = get_vcpu_events(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
@@ -1100,6 +1263,11 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
+    ret = set_vcpu_events(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
-- 
2.54.0


