Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EA0CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Muz-0000pe-Vl; Thu, 02 Oct 2025 13:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Mue-0000b2-Un
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MuL-0005ca-8j
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8mgIyUucNwmMx4EjvXo3O9E8ww8tXMy2EwnkJclxwU=;
 b=B8LFM/VF8bvO+3dOKy2519M+mbdQvZJk3B+H0E/nHadrGiK7/I88Dm3pXUpe4XyylShwuw
 QU3V1H/b10BTJrQMOX4gUim+L9cZ1Nkzf9thixr6JU4QfOyjdM2ZaN+KKvzjq0lhH4KL0R
 Lyp82WQQOVfSBshCZZQav0Ria21r+v4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608--cTr-pXSPkqsvYfUT3bLGg-1; Thu, 02 Oct 2025 13:15:48 -0400
X-MC-Unique: -cTr-pXSPkqsvYfUT3bLGg-1
X-Mimecast-MFC-AGG-ID: -cTr-pXSPkqsvYfUT3bLGg_1759425347
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-634cdb5d528so2559242a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425346; x=1760030146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8mgIyUucNwmMx4EjvXo3O9E8ww8tXMy2EwnkJclxwU=;
 b=wmxkiLLOVT+kQYUk5fyd5fVXAA0RJ5EWRxEBH+GfBI/EAPthFfQ8aWzT7mHKVWxucI
 LEc7knUqfuBm3CV1sZGU6+HnNXkW9uHlbsPcyde0fVUJpRhFLGDj79qO+M6PdPCvVcMn
 Xbm3pIoQ3FcobtZFHHW20XTl4ElHggI6w7IenEALYF2ZiVhjXy34CixGwhzFJBPTDf7G
 xB8P3d5iul9ANOtDgsAKD3lMi3872Jl9MIjyEl9cCmz+TJPmIXSzmzgXAz8GwVZr5Tbb
 jx7+nLUCYyZQ8Jsl5m/WGTCD0GD4KQ0aJBHRRjRbYBZWeMhIdjQXv/yOrsNTPLV4oxF0
 R4SA==
X-Gm-Message-State: AOJu0YzG9QrKD0qbM2mXqLZyelfggoQchSKZ1e1A17yHmzqNdP1scnKu
 /AT2jEsbkzP73MYsRj0idVRd5yF68vgKBWBKWdhcajDPtKjF3/j80MPqtFlfitcKXmrX4XhPCfS
 DBTnZ9GJXgAw0+9IdPOTG75lAQy/t9L7jeANDUjMzIIjWs/gJwkAgtg4XVhIU00m0AX2MmcHxat
 I7LA/oXPOYcU7C/U88f2cwjw+dCu8aYsGxjUJthm71
X-Gm-Gg: ASbGncuCyuNQCMVvV3oaXepivFsTE64G0sfJDl6H1hD3q0minVLy5Rkq1HsZoe3Vfai
 OL4HSLeXNoZobbqySWhMvD8iGKyvfC+9NSS6JCmpsk3dVBwsW3p9039D11G/R+MFnOJMoCFMqjP
 fRlNnlg5YCXuaJQVUO37dbfeQ6SgPtWDnh4G7kcIURbKSePMN/f8dJnu++XyLRFlyREOEyvpYLA
 1RC7XmbL2x38n22JsJ31226MOQcg3QxoOl+KnMMV8Z90PniSSiCDmpxUzZulbld6tVmHfsKS3f9
 zCMfWqTEdrwooA5uv4bHGndm+eLhJ+tVUyWeh6Ls3B5R9M/hknrqnJPERUM3nPzr84xyvXcHhce
 Ai+Mqsb+R2/VGEEzTl/lpe0QAWDpkJBEdyD/JIWmRB2tabCr/
X-Received: by 2002:a05:6402:28a8:b0:61c:b23f:417e with SMTP id
 4fb4d7f45d1cf-6376a8cbb40mr3252415a12.2.1759425346099; 
 Thu, 02 Oct 2025 10:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGytOM5VjsUFLy82AEoPjbJr5WZdcqzGyIe/V/hwiMXxxLDEbgPi/tKihDyHQ4bi5dk/5ANRA==
X-Received: by 2002:a05:6402:28a8:b0:61c:b23f:417e with SMTP id
 4fb4d7f45d1cf-6376a8cbb40mr3252382a12.2.1759425345592; 
 Thu, 02 Oct 2025 10:15:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6378811f25fsm2165623a12.46.2025.10.02.10.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:15:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 03/27] target/i386/mshv: Add x86 decoder/emu implementation
Date: Thu,  2 Oct 2025 19:15:12 +0200
Message-ID: <20251002171536.1460049-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

The MSHV accelerator requires a x86 decoder/emulator in userland to
emulate MMIO instructions. This change contains the implementations for
the generalized i386 instruction decoder/emulator.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-4-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv.h           |  25 +++
 target/i386/cpu.h               |   2 +-
 target/i386/mshv/x86.c          | 297 ++++++++++++++++++++++++++++++++
 target/i386/emulate/meson.build |   7 +-
 target/i386/meson.build         |   2 +
 target/i386/mshv/meson.build    |   7 +
 6 files changed, 337 insertions(+), 3 deletions(-)
 create mode 100644 include/system/mshv.h
 create mode 100644 target/i386/mshv/x86.c
 create mode 100644 target/i386/mshv/meson.build

diff --git a/include/system/mshv.h b/include/system/mshv.h
new file mode 100644
index 00000000000..342f1ef6a98
--- /dev/null
+++ b/include/system/mshv.h
@@ -0,0 +1,25 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors: Ziqiao Zhou  <ziqiaozhou@microsoft.com>
+ *          Magnus Kulke <magnuskulke@microsoft.com>
+ *          Jinank Jain  <jinankjain@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef QEMU_MSHV_H
+#define QEMU_MSHV_H
+
+#ifdef COMPILING_PER_TARGET
+#ifdef CONFIG_MSHV
+#define CONFIG_MSHV_IS_POSSIBLE
+#endif
+#else
+#define CONFIG_MSHV_IS_POSSIBLE
+#endif
+
+#endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 42168f1d6d8..3aec8fd41c8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2126,7 +2126,7 @@ typedef struct CPUArchState {
     QEMUTimer *xen_periodic_timer;
     QemuMutex xen_timers_lock;
 #endif
-#if defined(CONFIG_HVF)
+#if defined(CONFIG_HVF) || defined(CONFIG_MSHV)
     void *emu_mmio_buf;
 #endif
 
diff --git a/target/i386/mshv/x86.c b/target/i386/mshv/x86.c
new file mode 100644
index 00000000000..d574b3bc52f
--- /dev/null
+++ b/target/i386/mshv/x86.c
@@ -0,0 +1,297 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors: Magnus Kulke <magnuskulke@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "cpu.h"
+#include "emulate/x86_decode.h"
+#include "emulate/x86_emu.h"
+#include "qemu/typedefs.h"
+#include "qemu/error-report.h"
+#include "system/mshv.h"
+
+/* RW or Exec segment */
+static const uint8_t RWRX_SEGMENT_TYPE        = 0x2;
+static const uint8_t CODE_SEGMENT_TYPE        = 0x8;
+static const uint8_t EXPAND_DOWN_SEGMENT_TYPE = 0x4;
+
+typedef enum CpuMode {
+    REAL_MODE,
+    PROTECTED_MODE,
+    LONG_MODE,
+} CpuMode;
+
+static CpuMode cpu_mode(CPUState *cpu)
+{
+    enum CpuMode m = REAL_MODE;
+
+    if (x86_is_protected(cpu)) {
+        m = PROTECTED_MODE;
+
+        if (x86_is_long_mode(cpu)) {
+            m = LONG_MODE;
+        }
+    }
+
+    return m;
+}
+
+static bool segment_type_ro(const SegmentCache *seg)
+{
+    uint32_t type_ = (seg->flags >> DESC_TYPE_SHIFT) & 15;
+    return (type_ & (~RWRX_SEGMENT_TYPE)) == 0;
+}
+
+static bool segment_type_code(const SegmentCache *seg)
+{
+    uint32_t type_ = (seg->flags >> DESC_TYPE_SHIFT) & 15;
+    return (type_ & CODE_SEGMENT_TYPE) != 0;
+}
+
+static bool segment_expands_down(const SegmentCache *seg)
+{
+    uint32_t type_ = (seg->flags >> DESC_TYPE_SHIFT) & 15;
+
+    if (segment_type_code(seg)) {
+        return false;
+    }
+
+    return (type_ & EXPAND_DOWN_SEGMENT_TYPE) != 0;
+}
+
+static uint32_t segment_limit(const SegmentCache *seg)
+{
+    uint32_t limit = seg->limit;
+    uint32_t granularity = (seg->flags & DESC_G_MASK) != 0;
+
+    if (granularity != 0) {
+        limit = (limit << 12) | 0xFFF;
+    }
+
+    return limit;
+}
+
+static uint8_t segment_db(const SegmentCache *seg)
+{
+    return (seg->flags >> DESC_B_SHIFT) & 1;
+}
+
+static uint32_t segment_max_limit(const SegmentCache *seg)
+{
+    if (segment_db(seg) != 0) {
+        return 0xFFFFFFFF;
+    }
+    return 0xFFFF;
+}
+
+static int linearize(CPUState *cpu,
+                     target_ulong logical_addr, target_ulong *linear_addr,
+                     X86Seg seg_idx)
+{
+    enum CpuMode mode;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    SegmentCache *seg = &env->segs[seg_idx];
+    target_ulong base = seg->base;
+    target_ulong logical_addr_32b;
+    uint32_t limit;
+    /* TODO: the emulator will not pass us "write" indicator yet */
+    bool write = false;
+
+    mode = cpu_mode(cpu);
+
+    switch (mode) {
+    case LONG_MODE:
+        if (__builtin_add_overflow(logical_addr, base, linear_addr)) {
+            error_report("Address overflow");
+            return -1;
+        }
+        break;
+    case PROTECTED_MODE:
+    case REAL_MODE:
+        if (segment_type_ro(seg) && write) {
+            error_report("Cannot write to read-only segment");
+            return -1;
+        }
+
+        logical_addr_32b = logical_addr & 0xFFFFFFFF;
+        limit = segment_limit(seg);
+
+        if (segment_expands_down(seg)) {
+            if (logical_addr_32b >= limit) {
+                error_report("Address exceeds limit (expands down)");
+                return -1;
+            }
+
+            limit = segment_max_limit(seg);
+        }
+
+        if (logical_addr_32b > limit) {
+            error_report("Address exceeds limit %u", limit);
+            return -1;
+        }
+        *linear_addr = logical_addr_32b + base;
+        break;
+    default:
+        error_report("Unknown cpu mode: %d", mode);
+        return -1;
+    }
+
+    return 0;
+}
+
+bool x86_read_segment_descriptor(CPUState *cpu,
+                                 struct x86_segment_descriptor *desc,
+                                 x86_segment_selector sel)
+{
+    target_ulong base;
+    uint32_t limit;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    target_ulong gva;
+
+    memset(desc, 0, sizeof(*desc));
+
+    /* valid gdt descriptors start from index 1 */
+    if (!sel.index && GDT_SEL == sel.ti) {
+        return false;
+    }
+
+    if (GDT_SEL == sel.ti) {
+        base = env->gdt.base;
+        limit = env->gdt.limit;
+    } else {
+        base = env->ldt.base;
+        limit = env->ldt.limit;
+    }
+
+    if (sel.index * 8 >= limit) {
+        return false;
+    }
+
+    gva = base + sel.index * 8;
+    emul_ops->read_mem(cpu, desc, gva, sizeof(*desc));
+
+    return true;
+}
+
+bool x86_read_call_gate(CPUState *cpu, struct x86_call_gate *idt_desc,
+                        int gate)
+{
+    target_ulong base;
+    uint32_t limit;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    target_ulong gva;
+
+    base = env->idt.base;
+    limit = env->idt.limit;
+
+    memset(idt_desc, 0, sizeof(*idt_desc));
+    if (gate * 8 >= limit) {
+        perror("call gate exceeds idt limit");
+        return false;
+    }
+
+    gva = base + gate * 8;
+    emul_ops->read_mem(cpu, idt_desc, gva, sizeof(*idt_desc));
+
+    return true;
+}
+
+bool x86_is_protected(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint64_t cr0 = env->cr[0];
+
+    return cr0 & CR0_PE_MASK;
+}
+
+bool x86_is_real(CPUState *cpu)
+{
+    return !x86_is_protected(cpu);
+}
+
+bool x86_is_v8086(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    return x86_is_protected(cpu) && (env->eflags & VM_MASK);
+}
+
+bool x86_is_long_mode(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint64_t efer = env->efer;
+    uint64_t lme_lma = (MSR_EFER_LME | MSR_EFER_LMA);
+
+    return ((efer & lme_lma) == lme_lma);
+}
+
+bool x86_is_long64_mode(CPUState *cpu)
+{
+    error_report("unimplemented: is_long64_mode()");
+    abort();
+}
+
+bool x86_is_paging_mode(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint64_t cr0 = env->cr[0];
+
+    return cr0 & CR0_PG_MASK;
+}
+
+bool x86_is_pae_enabled(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint64_t cr4 = env->cr[4];
+
+    return cr4 & CR4_PAE_MASK;
+}
+
+target_ulong linear_addr(CPUState *cpu, target_ulong addr, X86Seg seg)
+{
+    int ret;
+    target_ulong linear_addr;
+
+    ret = linearize(cpu, addr, &linear_addr, seg);
+    if (ret < 0) {
+        error_report("failed to linearize address");
+        abort();
+    }
+
+    return linear_addr;
+}
+
+target_ulong linear_addr_size(CPUState *cpu, target_ulong addr, int size,
+                              X86Seg seg)
+{
+    switch (size) {
+    case 2:
+        addr = (uint16_t)addr;
+        break;
+    case 4:
+        addr = (uint32_t)addr;
+        break;
+    default:
+        break;
+    }
+    return linear_addr(cpu, addr, seg);
+}
+
+target_ulong linear_rip(CPUState *cpu, target_ulong rip)
+{
+    return linear_addr(cpu, rip, R_CS);
+}
diff --git a/target/i386/emulate/meson.build b/target/i386/emulate/meson.build
index 4edd4f462fc..b6dafb6a5be 100644
--- a/target/i386/emulate/meson.build
+++ b/target/i386/emulate/meson.build
@@ -1,5 +1,8 @@
-i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
+emulator_files = files(
   'x86_decode.c',
   'x86_emu.c',
   'x86_flags.c',
-))
+)
+
+i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: emulator_files)
+i386_system_ss.add(when: 'CONFIG_MSHV', if_true: emulator_files)
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 092af34e2d8..89ba4912aae 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -13,6 +13,7 @@ i386_ss.add(when: 'CONFIG_KVM', if_true: files('host-cpu.c'))
 i386_ss.add(when: 'CONFIG_HVF', if_true: files('host-cpu.c'))
 i386_ss.add(when: 'CONFIG_WHPX', if_true: files('host-cpu.c'))
 i386_ss.add(when: 'CONFIG_NVMM', if_true: files('host-cpu.c'))
+i386_ss.add(when: 'CONFIG_MSHV', if_true: files('host-cpu.c'))
 
 i386_system_ss = ss.source_set()
 i386_system_ss.add(files(
@@ -34,6 +35,7 @@ subdir('nvmm')
 subdir('hvf')
 subdir('tcg')
 subdir('emulate')
+subdir('mshv')
 
 target_arch += {'i386': i386_ss}
 target_system_arch += {'i386': i386_system_ss}
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
new file mode 100644
index 00000000000..8ddaa7c11dc
--- /dev/null
+++ b/target/i386/mshv/meson.build
@@ -0,0 +1,7 @@
+i386_mshv_ss = ss.source_set()
+
+i386_mshv_ss.add(files(
+  'x86.c',
+))
+
+i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
-- 
2.51.0


