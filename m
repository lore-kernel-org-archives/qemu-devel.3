Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A044DC48285
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUnj-0002y1-0F; Mon, 29 Jan 2024 11:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUmU-0007WT-Io
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:46:48 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUmP-00040P-PH
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:46:46 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33ae6f4fd78so1226342f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546799; x=1707151599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgRQukTglCKRn9R4pg+Z4Q5fPFCih1Qi18kzfRXi8wM=;
 b=tpQu8Z81kPKT7YxFbNm1jwgnQ+nbc471/mHlK1lJB/S2uwF4CBvrAppnD84SV/3xev
 lPlUHS3krySbp9PfE8o5o8h7cVAjtGqlpqDx/abByDhxTZPVcpZezokWRY3WNtNlmuec
 QCkmWp2aG6eNRhPJm+SwhCUTL4KHaU+3f8GsKMBceXId+oD/dMlHu42/HWTPKwx8HL3Y
 EDdDw5nMw0F+mfaVAEWRnBoMKNKNmU73tVz7tzNzaYQelWJ1Yl+IRff62GyDAW8bGN3b
 cLWr4Sc4urBtWn7WvUMDjedVzFpSIczSJtLP330YIZ4a3DUnYA8cqRsvWxzcyjKue71m
 3NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546799; x=1707151599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgRQukTglCKRn9R4pg+Z4Q5fPFCih1Qi18kzfRXi8wM=;
 b=mdnKMcji5zC1N/XGPFKKy8SeMslThI+Q/0y8lJUiP+q2LWvYK3h4zDTFIRGuhwuBkd
 WQJyO68fBZ2wQ5ePe/TTNlBHoMnNonWn3zQVOIzujFbCU/keVgi5JUJMZBnMemC2bA3b
 y1XB512dVE5qLLbpB8J90od8APT4RNAedsTiFXvZtH5dl7H+HBgh0hRUHi6njl4FQ6wE
 NoAif4c5ulb4EFXvPoFgioDYNUAuo1lcVuP5TedzSWDhIB6djEWP+vxPL/LjjDdSSH6J
 EcG6ToDoXseS4vpfbdrQmwCeV2L7gbl3chw5YDmaL3cFiGBJaPGMlhQ63PL6jfgD8tTe
 VlSg==
X-Gm-Message-State: AOJu0YxRLHIFBkGowZmbLjkrP8wCyjjBM3bUgHmkzRi6mpSksfV+IiSc
 e78juhCz8X8wcSuhw98HKR/sRZIEE5qnPccuASSvDNK/51lmzUsP4tYAYjqgkW+sf9QJ8XpxiVS
 B
X-Google-Smtp-Source: AGHT+IEXTtrczMFNyn45KIgONf2aMQI+ma8RE/aMVM4QCmov/Z7glj7xGwykdFZTGExZ/63tVScDDQ==
X-Received: by 2002:a5d:4248:0:b0:337:c3ed:bd1e with SMTP id
 s8-20020a5d4248000000b00337c3edbd1emr4746982wrr.25.1706546799608; 
 Mon, 29 Jan 2024 08:46:39 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a5d4a47000000b0033aef37ec94sm2525026wrs.113.2024.01.29.08.46.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:46:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v3 13/29] target/i386/hvf: Use CPUState typedef
Date: Mon, 29 Jan 2024 17:44:55 +0100
Message-ID: <20240129164514.73104-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

QEMU coding style recommend using structure typedefs:
https://www.qemu.org/docs/master/devel/style.html#typedefs

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/hvf/x86.h       | 26 +++++++++++++-------------
 target/i386/hvf/x86_descr.h | 14 +++++++-------
 target/i386/hvf/x86_emu.h   |  4 ++--
 target/i386/hvf/x86_mmu.h   |  6 +++---
 target/i386/hvf/x86.c       | 26 +++++++++++++-------------
 target/i386/hvf/x86_descr.c |  8 ++++----
 target/i386/hvf/x86_mmu.c   | 14 +++++++-------
 7 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index 947b98da41..3570f29aa9 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -248,30 +248,30 @@ typedef struct x68_segment_selector {
 #define BH(cpu)        RH(cpu, R_EBX)
 
 /* deal with GDT/LDT descriptors in memory */
-bool x86_read_segment_descriptor(struct CPUState *cpu,
+bool x86_read_segment_descriptor(CPUState *cpu,
                                  struct x86_segment_descriptor *desc,
                                  x68_segment_selector sel);
-bool x86_write_segment_descriptor(struct CPUState *cpu,
+bool x86_write_segment_descriptor(CPUState *cpu,
                                   struct x86_segment_descriptor *desc,
                                   x68_segment_selector sel);
 
-bool x86_read_call_gate(struct CPUState *cpu, struct x86_call_gate *idt_desc,
+bool x86_read_call_gate(CPUState *cpu, struct x86_call_gate *idt_desc,
                         int gate);
 
 /* helpers */
-bool x86_is_protected(struct CPUState *cpu);
-bool x86_is_real(struct CPUState *cpu);
-bool x86_is_v8086(struct CPUState *cpu);
-bool x86_is_long_mode(struct CPUState *cpu);
-bool x86_is_long64_mode(struct CPUState *cpu);
-bool x86_is_paging_mode(struct CPUState *cpu);
-bool x86_is_pae_enabled(struct CPUState *cpu);
+bool x86_is_protected(CPUState *cpu);
+bool x86_is_real(CPUState *cpu);
+bool x86_is_v8086(CPUState *cpu);
+bool x86_is_long_mode(CPUState *cpu);
+bool x86_is_long64_mode(CPUState *cpu);
+bool x86_is_paging_mode(CPUState *cpu);
+bool x86_is_pae_enabled(CPUState *cpu);
 
 enum X86Seg;
-target_ulong linear_addr(struct CPUState *cpu, target_ulong addr, enum X86Seg seg);
-target_ulong linear_addr_size(struct CPUState *cpu, target_ulong addr, int size,
+target_ulong linear_addr(CPUState *cpu, target_ulong addr, enum X86Seg seg);
+target_ulong linear_addr_size(CPUState *cpu, target_ulong addr, int size,
                               enum X86Seg seg);
-target_ulong linear_rip(struct CPUState *cpu, target_ulong rip);
+target_ulong linear_rip(CPUState *cpu, target_ulong rip);
 
 static inline uint64_t rdtscp(void)
 {
diff --git a/target/i386/hvf/x86_descr.h b/target/i386/hvf/x86_descr.h
index c356932fa4..9f06014b56 100644
--- a/target/i386/hvf/x86_descr.h
+++ b/target/i386/hvf/x86_descr.h
@@ -29,29 +29,29 @@ typedef struct vmx_segment {
 } vmx_segment;
 
 /* deal with vmstate descriptors */
-void vmx_read_segment_descriptor(struct CPUState *cpu,
+void vmx_read_segment_descriptor(CPUState *cpu,
                                  struct vmx_segment *desc, enum X86Seg seg);
 void vmx_write_segment_descriptor(CPUState *cpu, struct vmx_segment *desc,
                                   enum X86Seg seg);
 
-x68_segment_selector vmx_read_segment_selector(struct CPUState *cpu,
+x68_segment_selector vmx_read_segment_selector(CPUState *cpu,
                                                enum X86Seg seg);
-void vmx_write_segment_selector(struct CPUState *cpu,
+void vmx_write_segment_selector(CPUState *cpu,
                                 x68_segment_selector selector,
                                 enum X86Seg seg);
 
-uint64_t vmx_read_segment_base(struct CPUState *cpu, enum X86Seg seg);
-void vmx_write_segment_base(struct CPUState *cpu, enum X86Seg seg,
+uint64_t vmx_read_segment_base(CPUState *cpu, enum X86Seg seg);
+void vmx_write_segment_base(CPUState *cpu, enum X86Seg seg,
                             uint64_t base);
 
-void x86_segment_descriptor_to_vmx(struct CPUState *cpu,
+void x86_segment_descriptor_to_vmx(CPUState *cpu,
                                    x68_segment_selector selector,
                                    struct x86_segment_descriptor *desc,
                                    struct vmx_segment *vmx_desc);
 
 uint32_t vmx_read_segment_limit(CPUState *cpu, enum X86Seg seg);
 uint32_t vmx_read_segment_ar(CPUState *cpu, enum X86Seg seg);
-void vmx_segment_to_x86_descriptor(struct CPUState *cpu,
+void vmx_segment_to_x86_descriptor(CPUState *cpu,
                                    struct vmx_segment *vmx_desc,
                                    struct x86_segment_descriptor *desc);
 
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index 4b846ba80e..8bd97608c4 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -26,8 +26,8 @@
 void init_emu(void);
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins);
 
-void load_regs(struct CPUState *cpu);
-void store_regs(struct CPUState *cpu);
+void load_regs(CPUState *cpu);
+void store_regs(CPUState *cpu);
 
 void simulate_rdmsr(CPUX86State *env);
 void simulate_wrmsr(CPUX86State *env);
diff --git a/target/i386/hvf/x86_mmu.h b/target/i386/hvf/x86_mmu.h
index 9ae8a548de..9447ae072c 100644
--- a/target/i386/hvf/x86_mmu.h
+++ b/target/i386/hvf/x86_mmu.h
@@ -36,9 +36,9 @@
 #define MMU_PAGE_US             (1 << 2)
 #define MMU_PAGE_NX             (1 << 3)
 
-bool mmu_gva_to_gpa(struct CPUState *cpu, target_ulong gva, uint64_t *gpa);
+bool mmu_gva_to_gpa(CPUState *cpu, target_ulong gva, uint64_t *gpa);
 
-void vmx_write_mem(struct CPUState *cpu, target_ulong gva, void *data, int bytes);
-void vmx_read_mem(struct CPUState *cpu, void *data, target_ulong gva, int bytes);
+void vmx_write_mem(CPUState *cpu, target_ulong gva, void *data, int bytes);
+void vmx_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes);
 
 #endif /* X86_MMU_H */
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index 8ceea6398e..80e36136d0 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -46,7 +46,7 @@
    return ar;
 }*/
 
-bool x86_read_segment_descriptor(struct CPUState *cpu,
+bool x86_read_segment_descriptor(CPUState *cpu,
                                  struct x86_segment_descriptor *desc,
                                  x68_segment_selector sel)
 {
@@ -76,7 +76,7 @@ bool x86_read_segment_descriptor(struct CPUState *cpu,
     return true;
 }
 
-bool x86_write_segment_descriptor(struct CPUState *cpu,
+bool x86_write_segment_descriptor(CPUState *cpu,
                                   struct x86_segment_descriptor *desc,
                                   x68_segment_selector sel)
 {
@@ -99,7 +99,7 @@ bool x86_write_segment_descriptor(struct CPUState *cpu,
     return true;
 }
 
-bool x86_read_call_gate(struct CPUState *cpu, struct x86_call_gate *idt_desc,
+bool x86_read_call_gate(CPUState *cpu, struct x86_call_gate *idt_desc,
                         int gate)
 {
     target_ulong base  = rvmcs(cpu->accel->fd, VMCS_GUEST_IDTR_BASE);
@@ -115,30 +115,30 @@ bool x86_read_call_gate(struct CPUState *cpu, struct x86_call_gate *idt_desc,
     return true;
 }
 
-bool x86_is_protected(struct CPUState *cpu)
+bool x86_is_protected(CPUState *cpu)
 {
     uint64_t cr0 = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
     return cr0 & CR0_PE_MASK;
 }
 
-bool x86_is_real(struct CPUState *cpu)
+bool x86_is_real(CPUState *cpu)
 {
     return !x86_is_protected(cpu);
 }
 
-bool x86_is_v8086(struct CPUState *cpu)
+bool x86_is_v8086(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
     return x86_is_protected(cpu) && (env->eflags & VM_MASK);
 }
 
-bool x86_is_long_mode(struct CPUState *cpu)
+bool x86_is_long_mode(CPUState *cpu)
 {
     return rvmcs(cpu->accel->fd, VMCS_GUEST_IA32_EFER) & MSR_EFER_LMA;
 }
 
-bool x86_is_long64_mode(struct CPUState *cpu)
+bool x86_is_long64_mode(CPUState *cpu)
 {
     struct vmx_segment desc;
     vmx_read_segment_descriptor(cpu, &desc, R_CS);
@@ -146,24 +146,24 @@ bool x86_is_long64_mode(struct CPUState *cpu)
     return x86_is_long_mode(cpu) && ((desc.ar >> 13) & 1);
 }
 
-bool x86_is_paging_mode(struct CPUState *cpu)
+bool x86_is_paging_mode(CPUState *cpu)
 {
     uint64_t cr0 = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
     return cr0 & CR0_PG_MASK;
 }
 
-bool x86_is_pae_enabled(struct CPUState *cpu)
+bool x86_is_pae_enabled(CPUState *cpu)
 {
     uint64_t cr4 = rvmcs(cpu->accel->fd, VMCS_GUEST_CR4);
     return cr4 & CR4_PAE_MASK;
 }
 
-target_ulong linear_addr(struct CPUState *cpu, target_ulong addr, X86Seg seg)
+target_ulong linear_addr(CPUState *cpu, target_ulong addr, X86Seg seg)
 {
     return vmx_read_segment_base(cpu, seg) + addr;
 }
 
-target_ulong linear_addr_size(struct CPUState *cpu, target_ulong addr, int size,
+target_ulong linear_addr_size(CPUState *cpu, target_ulong addr, int size,
                               X86Seg seg)
 {
     switch (size) {
@@ -179,7 +179,7 @@ target_ulong linear_addr_size(struct CPUState *cpu, target_ulong addr, int size,
     return linear_addr(cpu, addr, seg);
 }
 
-target_ulong linear_rip(struct CPUState *cpu, target_ulong rip)
+target_ulong linear_rip(CPUState *cpu, target_ulong rip)
 {
     return linear_addr(cpu, rip, R_CS);
 }
diff --git a/target/i386/hvf/x86_descr.c b/target/i386/hvf/x86_descr.c
index c2d2e9ee84..5a9e8d307c 100644
--- a/target/i386/hvf/x86_descr.c
+++ b/target/i386/hvf/x86_descr.c
@@ -67,12 +67,12 @@ x68_segment_selector vmx_read_segment_selector(CPUState *cpu, X86Seg seg)
     return sel;
 }
 
-void vmx_write_segment_selector(struct CPUState *cpu, x68_segment_selector selector, X86Seg seg)
+void vmx_write_segment_selector(CPUState *cpu, x68_segment_selector selector, X86Seg seg)
 {
     wvmcs(cpu->accel->fd, vmx_segment_fields[seg].selector, selector.sel);
 }
 
-void vmx_read_segment_descriptor(struct CPUState *cpu, struct vmx_segment *desc, X86Seg seg)
+void vmx_read_segment_descriptor(CPUState *cpu, struct vmx_segment *desc, X86Seg seg)
 {
     desc->sel = rvmcs(cpu->accel->fd, vmx_segment_fields[seg].selector);
     desc->base = rvmcs(cpu->accel->fd, vmx_segment_fields[seg].base);
@@ -90,7 +90,7 @@ void vmx_write_segment_descriptor(CPUState *cpu, struct vmx_segment *desc, X86Se
     wvmcs(cpu->accel->fd, sf->ar_bytes, desc->ar);
 }
 
-void x86_segment_descriptor_to_vmx(struct CPUState *cpu, x68_segment_selector selector, struct x86_segment_descriptor *desc, struct vmx_segment *vmx_desc)
+void x86_segment_descriptor_to_vmx(CPUState *cpu, x68_segment_selector selector, struct x86_segment_descriptor *desc, struct vmx_segment *vmx_desc)
 {
     vmx_desc->sel = selector.sel;
     vmx_desc->base = x86_segment_base(desc);
@@ -107,7 +107,7 @@ void x86_segment_descriptor_to_vmx(struct CPUState *cpu, x68_segment_selector se
                     desc->type;
 }
 
-void vmx_segment_to_x86_descriptor(struct CPUState *cpu, struct vmx_segment *vmx_desc, struct x86_segment_descriptor *desc)
+void vmx_segment_to_x86_descriptor(CPUState *cpu, struct vmx_segment *vmx_desc, struct x86_segment_descriptor *desc)
 {
     x86_set_segment_limit(desc, vmx_desc->limit);
     x86_set_segment_base(desc, vmx_desc->base);
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 8cd08622a1..649074a7d2 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -49,7 +49,7 @@ struct gpt_translation {
     bool exec_access;
 };
 
-static int gpt_top_level(struct CPUState *cpu, bool pae)
+static int gpt_top_level(CPUState *cpu, bool pae)
 {
     if (!pae) {
         return 2;
@@ -73,7 +73,7 @@ static inline int pte_size(bool pae)
 }
 
 
-static bool get_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
+static bool get_pt_entry(CPUState *cpu, struct gpt_translation *pt,
                          int level, bool pae)
 {
     int index;
@@ -95,7 +95,7 @@ static bool get_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
 }
 
 /* test page table entry */
-static bool test_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
+static bool test_pt_entry(CPUState *cpu, struct gpt_translation *pt,
                           int level, bool *is_large, bool pae)
 {
     uint64_t pte = pt->pte[level];
@@ -166,7 +166,7 @@ static inline uint64_t large_page_gpa(struct gpt_translation *pt, bool pae)
 
 
 
-static bool walk_gpt(struct CPUState *cpu, target_ulong addr, int err_code,
+static bool walk_gpt(CPUState *cpu, target_ulong addr, int err_code,
                      struct gpt_translation *pt, bool pae)
 {
     int top_level, level;
@@ -205,7 +205,7 @@ static bool walk_gpt(struct CPUState *cpu, target_ulong addr, int err_code,
 }
 
 
-bool mmu_gva_to_gpa(struct CPUState *cpu, target_ulong gva, uint64_t *gpa)
+bool mmu_gva_to_gpa(CPUState *cpu, target_ulong gva, uint64_t *gpa)
 {
     bool res;
     struct gpt_translation pt;
@@ -225,7 +225,7 @@ bool mmu_gva_to_gpa(struct CPUState *cpu, target_ulong gva, uint64_t *gpa)
     return false;
 }
 
-void vmx_write_mem(struct CPUState *cpu, target_ulong gva, void *data, int bytes)
+void vmx_write_mem(CPUState *cpu, target_ulong gva, void *data, int bytes)
 {
     uint64_t gpa;
 
@@ -246,7 +246,7 @@ void vmx_write_mem(struct CPUState *cpu, target_ulong gva, void *data, int bytes
     }
 }
 
-void vmx_read_mem(struct CPUState *cpu, void *data, target_ulong gva, int bytes)
+void vmx_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
 {
     uint64_t gpa;
 
-- 
2.41.0


