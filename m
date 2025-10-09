Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A2ACCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQy-0008Ur-1p; Thu, 09 Oct 2025 03:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQw-0008UI-78
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQt-0004Rg-II
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DIImP9rsbENMbkYn9y/syNVGQpkLhbp28x1tK4d0VmY=;
 b=P0Q9Dnmm77KqoDjPaldpiEarrTTMsUCjp2OZzW1i4NzBsx2A8t/Nr/xM6TTRBmeq8Qrl3P
 caXCjtWDriDa+b73KY0/qcu0L4ekD4tgElzD+dfuZsHr0FhzKP3OU44C4S1Eh9h6p8b+uO
 yRjXrwQYpyWoeWGelLUmM9NEKV859NI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-vK8Yy5FYPTazp-xo0hJbkA-1; Thu, 09 Oct 2025 03:51:23 -0400
X-MC-Unique: vK8Yy5FYPTazp-xo0hJbkA-1
X-Mimecast-MFC-AGG-ID: vK8Yy5FYPTazp-xo0hJbkA_1759996283
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ecdd80ea44so541454f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996282; x=1760601082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIImP9rsbENMbkYn9y/syNVGQpkLhbp28x1tK4d0VmY=;
 b=m/qqMmIEyDWM1smrzOi/rDNE0mHzFQj1NjSPCI//qICgv7AKJeoA4QE8c6XVqNnEsi
 7ezP8ic+X0sTHTeI/6p4U7IRiY0cw+/7Q3wZtLu+tS/o3nXiQwhAFpEEb+NA+D+kJF6T
 DLt2947trCyvQvydWzjCOyp2Kn8OVTk+A+necKn2uwfCmE+8wwWOVJhY+LybDaBDhOk/
 MDXEdJuBBKnvN78ilA3WJS24/CG4F2K8CWXGTlkut2bJIGdxm1ZDhh68oY1Zqqr3gnRI
 SIeimWQGDUYqww58v9aONnqSXmoXSyn8s4jygpYzSPhsYDovUFHVpz1LzmXjjHxvFtvQ
 GzGQ==
X-Gm-Message-State: AOJu0YyA8LVaK7Ec+aQOxvH+k7fjpibonaTchdAVUKa6+8pUUzLH/Nc1
 faS2MNbL5iByzYNu/q5Oa1r2431UfsCP3bLRB6pNYOuk+wBrNHZeeTZdiCx11LmgW7PigLwQzIN
 o2D/M+yfly4BhulQHHDzY40Sl8OzqVdTKAGZipXWeSxEsMubqGuMfaj8tI2N3/LoT5YxaLSUBbc
 NyQn1Xy3C/r0m8zryXD2AoVTFw2CKK5ubLCoIh8YP8teQ=
X-Gm-Gg: ASbGnctvKhM9MzYKrUNAyhY1t1PqMXolE+Ge3877k2rK5lCC7tzncZMgLcfhB1nDNNY
 427fm8ea63ojgssRL3iz6RC9XmkEBic04ekqawF1OldX2B09k8vjfDQglYVeSunp3wl1tahTAKR
 s+A57GyBzWyrj4RMGQPpDi0OSqRiZpKB6VG2H6S4PiFeRqH0bf6Ty84MDeFX9IBJtommsQxHTwa
 R9ety0GOqaURP1aODubVNMl9eBy9PR0g+vwCCUHXu099qtya9ZkK8inP0/eNO0DLgyTC6nsqDbe
 6xKurLbyjmok3eAOwmAxBuLHgNs3BYZb2TkOI15krnS0muHWNpl4hxlJtdCukIxypbZ6nEhnr7c
 A+J9lpq3C9lkBJe+CTbfMu0jXcFjrgA2zI48V6DWeQSUM0UmV
X-Received: by 2002:a05:6000:2c02:b0:401:ae97:a1ab with SMTP id
 ffacd0b85a97d-42666aa67f9mr4850193f8f.10.1759996281608; 
 Thu, 09 Oct 2025 00:51:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfaByyQlmT9MlDK+1uimYC2uGepwrZY9j/pASb17HgNVNKv8iEdASvF82gsUC3f/BUcoNO7A==
X-Received: by 2002:a05:6000:2c02:b0:401:ae97:a1ab with SMTP id
 ffacd0b85a97d-42666aa67f9mr4850166f8f.10.1759996281129; 
 Thu, 09 Oct 2025 00:51:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97f0sm33092084f8f.27.2025.10.09.00.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 24/35] target/i386/mshv: Register CPUID entries with MSHV
Date: Thu,  9 Oct 2025 09:50:14 +0200
Message-ID: <20251009075026.505715-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Convert the guest CPU's CPUID model into MSHV's format and register it
with the hypervisor. This ensures that the guest observes the correct
CPU feature set during CPUID instructions.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-19-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 206 ++++++++++++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 0fe3cbb48d8..2b7a81274b3 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -403,6 +403,206 @@ int mshv_load_regs(CPUState *cpu)
     return 0;
 }
 
+static void add_cpuid_entry(GList *cpuid_entries,
+                            uint32_t function, uint32_t index,
+                            uint32_t eax, uint32_t ebx,
+                            uint32_t ecx, uint32_t edx)
+{
+    struct hv_cpuid_entry *entry;
+
+    entry = g_malloc0(sizeof(struct hv_cpuid_entry));
+    entry->function = function;
+    entry->index = index;
+    entry->eax = eax;
+    entry->ebx = ebx;
+    entry->ecx = ecx;
+    entry->edx = edx;
+
+    cpuid_entries = g_list_append(cpuid_entries, entry);
+}
+
+static void collect_cpuid_entries(const CPUState *cpu, GList *cpuid_entries)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint32_t eax, ebx, ecx, edx;
+    uint32_t leaf, subleaf;
+    size_t max_leaf = 0x1F;
+    size_t max_subleaf = 0x20;
+
+    uint32_t leaves_with_subleaves[] = {0x4, 0x7, 0xD, 0xF, 0x10};
+    int n_subleaf_leaves = ARRAY_SIZE(leaves_with_subleaves);
+
+    /* Regular leaves without subleaves */
+    for (leaf = 0; leaf <= max_leaf; leaf++) {
+        bool has_subleaves = false;
+        for (int i = 0; i < n_subleaf_leaves; i++) {
+            if (leaf == leaves_with_subleaves[i]) {
+                has_subleaves = true;
+                break;
+            }
+        }
+
+        if (!has_subleaves) {
+            cpu_x86_cpuid(env, leaf, 0, &eax, &ebx, &ecx, &edx);
+            if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0) {
+                /* all zeroes indicates no more leaves */
+                continue;
+            }
+
+            add_cpuid_entry(cpuid_entries, leaf, 0, eax, ebx, ecx, edx);
+            continue;
+        }
+
+        subleaf = 0;
+        while (subleaf < max_subleaf) {
+            cpu_x86_cpuid(env, leaf, subleaf, &eax, &ebx, &ecx, &edx);
+
+            if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0) {
+                /* all zeroes indicates no more leaves */
+                break;
+            }
+            add_cpuid_entry(cpuid_entries, leaf, 0, eax, ebx, ecx, edx);
+            subleaf++;
+        }
+    }
+}
+
+static int register_intercept_result_cpuid_entry(const CPUState *cpu,
+                                                 uint8_t subleaf_specific,
+                                                 uint8_t always_override,
+                                                 struct hv_cpuid_entry *entry)
+{
+    int ret;
+    int vp_index = cpu->cpu_index;
+    int cpu_fd = mshv_vcpufd(cpu);
+
+    struct hv_register_x64_cpuid_result_parameters cpuid_params = {
+        .input.eax = entry->function,
+        .input.ecx = entry->index,
+        .input.subleaf_specific = subleaf_specific,
+        .input.always_override = always_override,
+        .input.padding = 0,
+        /*
+         * With regard to masks - these are to specify bits to be overwritten
+         * The current CpuidEntry structure wouldn't allow to carry the masks
+         * in addition to the actual register values. For this reason, the
+         * masks are set to the exact values of the corresponding register bits
+         * to be registered for an overwrite. To view resulting values the
+         * hypervisor would return, HvCallGetVpCpuidValues hypercall can be
+         * used.
+         */
+        .result.eax = entry->eax,
+        .result.eax_mask = entry->eax,
+        .result.ebx = entry->ebx,
+        .result.ebx_mask = entry->ebx,
+        .result.ecx = entry->ecx,
+        .result.ecx_mask = entry->ecx,
+        .result.edx = entry->edx,
+        .result.edx_mask = entry->edx,
+    };
+    union hv_register_intercept_result_parameters parameters = {
+        .cpuid = cpuid_params,
+    };
+
+    hv_input_register_intercept_result in = {0};
+    in.vp_index = vp_index;
+    in.intercept_type = HV_INTERCEPT_TYPE_X64_CPUID;
+    in.parameters = parameters;
+
+    struct mshv_root_hvcall args = {0};
+    args.code   = HVCALL_REGISTER_INTERCEPT_RESULT;
+    args.in_sz  = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    ret = mshv_hvcall(cpu_fd, &args);
+    if (ret < 0) {
+        error_report("failed to register intercept result for cpuid");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int register_intercept_result_cpuid(const CPUState *cpu,
+                                           struct hv_cpuid *cpuid)
+{
+    int ret = 0, entry_ret;
+    struct hv_cpuid_entry *entry;
+    uint8_t subleaf_specific, always_override;
+
+    for (size_t i = 0; i < cpuid->nent; i++) {
+        entry = &cpuid->entries[i];
+
+        /* set defaults */
+        subleaf_specific = 0;
+        always_override = 1;
+
+        /* Intel */
+        /* 0xb - Extended Topology Enumeration Leaf */
+        /* 0x1f - V2 Extended Topology Enumeration Leaf */
+        /* AMD */
+        /* 0x8000_001e - Processor Topology Information */
+        /* 0x8000_0026 - Extended CPU Topology */
+        if (entry->function == 0xb
+            || entry->function == 0x1f
+            || entry->function == 0x8000001e
+            || entry->function == 0x80000026) {
+            subleaf_specific = 1;
+            always_override = 1;
+        } else if (entry->function == 0x00000001
+            || entry->function == 0x80000000
+            || entry->function == 0x80000001
+            || entry->function == 0x80000008) {
+            subleaf_specific = 0;
+            always_override = 1;
+        }
+
+        entry_ret = register_intercept_result_cpuid_entry(cpu, subleaf_specific,
+                                                          always_override,
+                                                          entry);
+        if ((entry_ret < 0) && (ret == 0)) {
+            ret = entry_ret;
+        }
+    }
+
+    return ret;
+}
+
+static int set_cpuid2(const CPUState *cpu)
+{
+    int ret;
+    size_t n_entries, cpuid_size;
+    struct hv_cpuid *cpuid;
+    struct hv_cpuid_entry *entry;
+    GList *entries = NULL;
+
+    collect_cpuid_entries(cpu, entries);
+    n_entries = g_list_length(entries);
+
+    cpuid_size = sizeof(struct hv_cpuid)
+        + n_entries * sizeof(struct hv_cpuid_entry);
+
+    cpuid = g_malloc0(cpuid_size);
+    cpuid->nent = n_entries;
+    cpuid->padding = 0;
+
+    for (size_t i = 0; i < n_entries; i++) {
+        entry = g_list_nth_data(entries, i);
+        cpuid->entries[i] = *entry;
+        g_free(entry);
+    }
+    g_list_free(entries);
+
+    ret = register_intercept_result_cpuid(cpu, cpuid);
+    g_free(cpuid);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
 static inline void populate_hv_segment_reg(SegmentCache *seg,
                                            hv_x64_segment_register *hv_reg)
 {
@@ -685,6 +885,12 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
     int ret;
     int cpu_fd = mshv_vcpufd(cpu);
 
+    ret = set_cpuid2(cpu);
+    if (ret < 0) {
+        error_report("failed to set cpuid");
+        return -1;
+    }
+
     ret = set_cpu_state(cpu, fpu, xcr0);
     if (ret < 0) {
         error_report("failed to set cpu state");
-- 
2.51.0


