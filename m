Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D53ECAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mvv-0001IZ-Ty; Thu, 02 Oct 2025 13:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvP-0000yr-Pp
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvD-0005r5-5B
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F7AoqxUKObbMsXJjOBehknEDHvdGEyjdVUlJubkLvsI=;
 b=H68qGHW1dVe+ddvw7FgQItegLL98K9vTLMHg8sqibW9EsR5aw7T+x0RHA+Z1xmZVrMxIli
 OXIG04k21TiTWxIstL6mESw5+r7xRQh/m8D7kcBXvXJn62EOJKUT/TSJ4V9PQsrvpgy84Y
 Z2hSNBabkgBqL3qaph7lOcLVsY9xAxE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-v_hdPJiHNk-mjFtsyp_-eQ-1; Thu, 02 Oct 2025 13:16:41 -0400
X-MC-Unique: v_hdPJiHNk-mjFtsyp_-eQ-1
X-Mimecast-MFC-AGG-ID: v_hdPJiHNk-mjFtsyp_-eQ_1759425400
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b48635cf06fso143296666b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425399; x=1760030199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7AoqxUKObbMsXJjOBehknEDHvdGEyjdVUlJubkLvsI=;
 b=NBucnTpyFHUYXfeZQ4R5cG/lQUNDEfN//5uaJi8SD2lfVvXV2VdiA/2Ht8vFpN3s4z
 MgVTlfX/qvdZ1jNvCdsbYEiK63GsY3Or9v1AsZq5iPA2kf8RAPI+pLMdwV9jJ+hCdWOW
 rw1E5bXRAw3liuOcKEuvAOSgTMJuWyMm+wNcDLOXlPDESwEsWirN8nIGxQA5ElbttYEx
 t/GVAXAljF8MMIFBy/0NFAroNDi16UA1keyhg2IXpEGDOl5eWCEo4NHwAoRBBRey8IHm
 dhQEk/5IZoKriGf0yCy299tiybKN9pSWTT7dYXbapOZZawFz4dy3PPlOiO3oSkAF1VjK
 HiYw==
X-Gm-Message-State: AOJu0YxD0Y+tTtVoyQU+u+QcQAogxYsMH5upJRusMqpqo5JEe0icgEgS
 FRr3rCqMFzolJ3Yv8D4OqmEiaX5Qyp16VAr2bYJTH8rnkcy7VP26DSrUHoqWbIpWo3NmBELiuYJ
 V6wmygV6SckofooV82zfGZgHjw1+JIuDQM1PmXK3T3MliMhsDnCylC33Fny3cNuOBXVAc5mWfBM
 ohTjgIfqST7EuqOaDxgCofmoj3oXnV63FwUz8geiqA
X-Gm-Gg: ASbGncsrbq967g4Vb+j2kGkrXxrQc1FNM+Neip2HukBl3dL50aQkcy1YU5q6TJVN4E4
 Z7vyR3bL/Wr0wnSA7IZSPVMKtnL4WtkU/+VPq5FuurDWdtD8K/8m4bSQpbXsE/F5oG6bvPTqrvD
 iyipsc9WgXSbL1p4zZ/55QbtwUCuBBn5M434SZ3FXjIz8vzqVr9GmQGyyLbOFKLp0RWQRFhQYei
 K3KFztK9uUcU0GVdkjfZo7gs+Mzcp5xp64wiWhd9v/WDup0+8yyVbqQNvlhU7YvynxaPYxBTlxl
 TKhEqen6K+g5HhHk6dBq2XNcJWNywWaBKaEDQCVCpVZ8xaBu1tBdXFSyVz3vY4y8deWWHP7CV8Y
 qWnti9TnLAGZ70Q5U2YjXBQeJXakF0KYO3b81H4sYRdWq4jiC
X-Received: by 2002:a17:906:730a:b0:aeb:3df1:2e75 with SMTP id
 a640c23a62f3a-b49c3e6e27bmr22652566b.46.1759425398822; 
 Thu, 02 Oct 2025 10:16:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzwJolNeNK2MpD0GkqSWK3KwSGOK6DUKJtLZX4QjRuIM1Sy/LydbMZVi8uWwDAmHqHejrm6A==
X-Received: by 2002:a17:906:730a:b0:aeb:3df1:2e75 with SMTP id
 a640c23a62f3a-b49c3e6e27bmr22649466b.46.1759425398291; 
 Thu, 02 Oct 2025 10:16:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b486a26e66csm234186266b.100.2025.10.02.10.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 20/27] target/i386/mshv: Integrate x86 instruction
 decoder/emulator
Date: Thu,  2 Oct 2025 19:15:29 +0200
Message-ID: <20251002171536.1460049-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Connect the x86 instruction decoder and emulator to the MSHV backend
to handle intercepted instructions. This enables software emulation
of MMIO operations in MSHV guests. MSHV has a translate_gva hypercall
that is used to accessing the physical guest memory.

A guest might read from unmapped memory regions (e.g. OVMF will probe
0xfed40000 for a vTPM). In those cases 0xFF bytes is returned instead of
aborting the execution.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-21-magnuskulke@linux.microsoft.com
[mshv.h/mshv_int.h split. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |   4 ++
 accel/mshv/mem.c            |  65 +++++++++++++++++
 target/i386/mshv/mshv-cpu.c | 135 ++++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 66494383134..b29d39911db 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -101,6 +101,10 @@ typedef struct MshvMemoryRegion {
     bool readonly;
 } MshvMemoryRegion;
 
+int mshv_guest_mem_read(uint64_t gpa, uint8_t *data, uintptr_t size,
+                        bool is_secure_mode, bool instruction_fetch);
+int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
+                         bool is_secure_mode);
 void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
                        bool add);
 
diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
index a0a40eb3333..e55c38d4db9 100644
--- a/accel/mshv/mem.c
+++ b/accel/mshv/mem.c
@@ -59,6 +59,71 @@ static int map_or_unmap(int vm_fd, const MshvMemoryRegion *mr, bool map)
     return set_guest_memory(vm_fd, &region);
 }
 
+static int handle_unmapped_mmio_region_read(uint64_t gpa, uint64_t size,
+                                            uint8_t *data)
+{
+    warn_report("read from unmapped mmio region gpa=0x%lx size=%lu", gpa, size);
+
+    if (size == 0 || size > 8) {
+        error_report("invalid size %lu for reading from unmapped mmio region",
+                     size);
+        return -1;
+    }
+
+    memset(data, 0xFF, size);
+
+    return 0;
+}
+
+int mshv_guest_mem_read(uint64_t gpa, uint8_t *data, uintptr_t size,
+                        bool is_secure_mode, bool instruction_fetch)
+{
+    int ret;
+    MemTxAttrs memattr = { .secure = is_secure_mode };
+
+    if (instruction_fetch) {
+        trace_mshv_insn_fetch(gpa, size);
+    } else {
+        trace_mshv_mem_read(gpa, size);
+    }
+
+    ret = address_space_rw(&address_space_memory, gpa, memattr, (void *)data,
+                           size, false);
+    if (ret == MEMTX_OK) {
+        return 0;
+    }
+
+    if (ret == MEMTX_DECODE_ERROR) {
+        return handle_unmapped_mmio_region_read(gpa, size, data);
+    }
+
+    error_report("failed to read guest memory at 0x%lx", gpa);
+    return -1;
+}
+
+int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
+                         bool is_secure_mode)
+{
+    int ret;
+    MemTxAttrs memattr = { .secure = is_secure_mode };
+
+    trace_mshv_mem_write(gpa, size);
+    ret = address_space_rw(&address_space_memory, gpa, memattr, (void *)data,
+                           size, true);
+    if (ret == MEMTX_OK) {
+        return 0;
+    }
+
+    if (ret == MEMTX_DECODE_ERROR) {
+        warn_report("write to unmapped mmio region gpa=0x%lx size=%lu", gpa,
+                    size);
+        return 0;
+    }
+
+    error_report("Failed to write guest memory");
+    return -1;
+}
+
 static int set_memory(const MshvMemoryRegion *mshv_mr, bool add)
 {
     int ret = 0;
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 1f43dfc58ac..424ebdb1228 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -104,6 +104,47 @@ static enum hv_register_name FPU_REGISTER_NAMES[26] = {
     HV_X64_REGISTER_XMM_CONTROL_STATUS,
 };
 
+static int translate_gva(const CPUState *cpu, uint64_t gva, uint64_t *gpa,
+                         uint64_t flags)
+{
+    int ret;
+    int cpu_fd = mshv_vcpufd(cpu);
+    int vp_index = cpu->cpu_index;
+
+    hv_input_translate_virtual_address in = { 0 };
+    hv_output_translate_virtual_address out = { 0 };
+    struct mshv_root_hvcall args = {0};
+    uint64_t gva_page = gva >> HV_HYP_PAGE_SHIFT;
+
+    in.vp_index = vp_index;
+    in.control_flags = flags;
+    in.gva_page = gva_page;
+
+    /* create the hvcall envelope */
+    args.code = HVCALL_TRANSLATE_VIRTUAL_ADDRESS;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t) &in;
+    args.out_sz = sizeof(out);
+    args.out_ptr = (uint64_t) &out;
+
+    /* perform the call */
+    ret = mshv_hvcall(cpu_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to invoke gva->gpa translation");
+        return -errno;
+    }
+
+    if (out.translation_result.result_code != HV_TRANSLATE_GVA_SUCCESS) {
+        error_report("Failed to translate gva (" TARGET_FMT_lx ") to gpa", gva);
+        return -1;
+    }
+
+    *gpa = ((out.gpa_page << HV_HYP_PAGE_SHIFT)
+         | (gva & ~(uint64_t)HV_HYP_PAGE_MASK));
+
+    return 0;
+}
+
 int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs)
 {
@@ -1006,8 +1047,102 @@ int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
     return 0;
 }
 
+static int guest_mem_read_with_gva(const CPUState *cpu, uint64_t gva,
+                                   uint8_t *data, uintptr_t size,
+                                   bool fetch_instruction)
+{
+    int ret;
+    uint64_t gpa, flags;
+
+    flags = HV_TRANSLATE_GVA_VALIDATE_READ;
+    ret = translate_gva(cpu, gva, &gpa, flags);
+    if (ret < 0) {
+        error_report("failed to translate gva to gpa");
+        return -1;
+    }
+
+    ret = mshv_guest_mem_read(gpa, data, size, false, fetch_instruction);
+    if (ret < 0) {
+        error_report("failed to read from guest memory");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int guest_mem_write_with_gva(const CPUState *cpu, uint64_t gva,
+                                    const uint8_t *data, uintptr_t size)
+{
+    int ret;
+    uint64_t gpa, flags;
+
+    flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
+    ret = translate_gva(cpu, gva, &gpa, flags);
+    if (ret < 0) {
+        error_report("failed to translate gva to gpa");
+        return -1;
+    }
+    ret = mshv_guest_mem_write(gpa, data, size, false);
+    if (ret < 0) {
+        error_report("failed to write to guest memory");
+        return -1;
+    }
+    return 0;
+}
+
+static void write_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
+{
+    if (guest_mem_write_with_gva(cpu, addr, data, bytes) < 0) {
+        error_report("failed to write memory");
+        abort();
+    }
+}
+
+static void fetch_instruction(CPUState *cpu, void *data,
+                              target_ulong addr, int bytes)
+{
+    if (guest_mem_read_with_gva(cpu, addr, data, bytes, true) < 0) {
+        error_report("failed to fetch instruction");
+        abort();
+    }
+}
+
+static void read_mem(CPUState *cpu, void *data, target_ulong addr, int bytes)
+{
+    if (guest_mem_read_with_gva(cpu, addr, data, bytes, false) < 0) {
+        error_report("failed to read memory");
+        abort();
+    }
+}
+
+static void read_segment_descriptor(CPUState *cpu,
+                                    struct x86_segment_descriptor *desc,
+                                    enum X86Seg seg_idx)
+{
+    bool ret;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    SegmentCache *seg = &env->segs[seg_idx];
+    x86_segment_selector sel = { .sel = seg->selector & 0xFFFF };
+
+    ret = x86_read_segment_descriptor(cpu, desc, sel);
+    if (ret == false) {
+        error_report("failed to read segment descriptor");
+        abort();
+    }
+}
+
+static const struct x86_emul_ops mshv_x86_emul_ops = {
+    .fetch_instruction = fetch_instruction,
+    .read_mem = read_mem,
+    .write_mem = write_mem,
+    .read_segment_descriptor = read_segment_descriptor,
+};
+
 void mshv_init_mmio_emu(void)
 {
+    init_decoder();
+    init_emu(&mshv_x86_emul_ops);
 }
 
 void mshv_arch_init_vcpu(CPUState *cpu)
-- 
2.51.0


