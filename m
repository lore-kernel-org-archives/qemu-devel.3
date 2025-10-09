Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15ACCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lQw-0008U9-3E; Thu, 09 Oct 2025 03:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQt-0008TH-8F
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQp-0004R3-6x
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIPVW/vreV6f3fNXGaXrbRU4fqOOeANYsAJB3x/TZdo=;
 b=OTPWbFrLZ9zfZtpEX2PHIaKHb7MEf5sNLBZXbMpM3wwf7zrw4CEzSnuo8ueR2ZFvR2wLtk
 uRMQx9BLZRLI/Zn0DEe/aXhhc0XWca1WKgLbyGiu2Y1dPmHURT9wtJmLjqrp4d/pHv0Y3L
 EXRMZpTVGWdmF8BrMGMJD2SBwo0JLjU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-bT0ikaWIPiKMvh-WO7KYtg-1; Thu, 09 Oct 2025 03:51:19 -0400
X-MC-Unique: bT0ikaWIPiKMvh-WO7KYtg-1
X-Mimecast-MFC-AGG-ID: bT0ikaWIPiKMvh-WO7KYtg_1759996278
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46fa88b5760so2038875e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996277; x=1760601077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uIPVW/vreV6f3fNXGaXrbRU4fqOOeANYsAJB3x/TZdo=;
 b=DT6IoH6VKtwIsIb6IlY1eEyK0MOUwKIURsV2bSUhSVOG0Wys+KK17moEz0IzHpR+dM
 07H77qAZKHM4MlyOYKwn6bzJeVOghp76By97sspBi1aLoh7oTbjIPNuUT2tDUijH4LsK
 cnvOotyrhDZJmg4mhGQwAOu5Y3qo+8X8JNy2dOuvLmvmiag8XP/3lKISYZ6k+0gbbJJN
 ChBTIQAByHiHP0XOaSTYRdEU9lX7LXCVOAVXGKLiW5bEhANBwWMqsq+6qS+LMH+iBE/A
 RHU6XazulBAw508/y0crdlr4Nq7haRJeYw4jEjnzUhOT/2+fNn6oTO/BbPhILGpQrW7s
 AfEA==
X-Gm-Message-State: AOJu0YyB+tpvYOkCuwdTeE4F9bHx58CuGgBdUW8/1u+nHJnEga1DAlcJ
 kXN6fEShcVDNsiOEP+jd4gWk4iEyOlZmqFN7frd3yGPviHzX1IdWyB7f9pmS/3J7KpgMaxdhZ0b
 AUii92DSM16R7jlkH1B/DHInPaTz+HOcOW5J1gVQbAWCb2hCi9IfbUhW/smuJFgN+zQYOzeGvg6
 pJyOQn5z1XdxQsmDPfCkOBXCjzyazQJx5NuOfu11e+N7Y=
X-Gm-Gg: ASbGncs4g7RDO16CvRXOBqg6wrAMaELbBSmVPitDCZT14lDcREhTQPm8ka/ZZfkSKdH
 giCFheZ3gyVub2MTfv5snjckWxaQUqCNPfrQnEhCbaeVqUTtVGmgX0ewRWJJ7kcbshE/39690P7
 dAP7sQZJMxMro+gdavEXU8wPkyxG9Ner3YuKQUB1zE5zm3a2TSV964r0eqjN07w6z32r8256SeG
 zA1jOxokr9ZyMaT99WcmD1Bz201b0AzNa5STUHefimZlwc5okRxkHwMR0KdA8ZXM2Z7z8T/TAA0
 MfN9Cd3mRd9ZDBYQhfs/5eF9Ja7kTZqxjysA52mzknFsKKes3yiV9aRblUtsGfzT2THOJ6D/I4M
 x4E9LDkCzJtk0pQgQ0IbBkwuBMG3LJF30Lj2DJaS2GQAkiXUI
X-Received: by 2002:a05:600d:8110:b0:45f:2922:2aef with SMTP id
 5b1f17b1804b1-46fa9b09233mr34363775e9.28.1759996276913; 
 Thu, 09 Oct 2025 00:51:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh5BzeOpzk9YPY5rNBi9iy/9ASzYHyFCbO4IG9chXAV+bzn0eFFWirCrk2ibM+n0Uczpk3uA==
X-Received: by 2002:a05:600d:8110:b0:45f:2922:2aef with SMTP id
 5b1f17b1804b1-46fa9b09233mr34363585e9.28.1759996276453; 
 Thu, 09 Oct 2025 00:51:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9b622cdsm71342885e9.0.2025.10.09.00.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 22/35] target/i386/mshv: Implement mshv_arch_put_registers()
Date: Thu,  9 Oct 2025 09:50:12 +0200
Message-ID: <20251009075026.505715-23-pbonzini@redhat.com>
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

Write CPU register state to MSHV vCPUs. Various mapping functions to
prepare the payload for the HV call have been implemented.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-17-magnuskulke@linux.microsoft.com
[mshv.h/mshv_int.h split. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |  15 +++
 target/i386/mshv/mshv-cpu.c | 237 ++++++++++++++++++++++++++++++++++++
 2 files changed, 252 insertions(+)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index c6e6e8af307..0ea8d504fa5 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -49,6 +49,20 @@ typedef struct MshvMsiControl {
 #define mshv_vcpufd(cpu) (cpu->accel->cpufd)
 
 /* cpu */
+typedef struct MshvFPU {
+    uint8_t fpr[8][16];
+    uint16_t fcw;
+    uint16_t fsw;
+    uint8_t ftwx;
+    uint8_t pad1;
+    uint16_t last_opcode;
+    uint64_t last_ip;
+    uint64_t last_dp;
+    uint8_t xmm[16][16];
+    uint32_t mxcsr;
+    uint32_t pad2;
+} MshvFPU;
+
 typedef enum MshvVmExit {
     MshvVmExitIgnore   = 0,
     MshvVmExitShutdown = 1,
@@ -58,6 +72,7 @@ typedef enum MshvVmExit {
 void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
+int mshv_configure_vcpu(const CPUState *cpu, const MshvFPU *fpu, uint64_t xcr0);
 int mshv_get_standard_regs(CPUState *cpu);
 int mshv_get_special_regs(CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index bc75686f828..8b10c79e547 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -73,6 +73,35 @@ static enum hv_register_name SPECIAL_REGISTER_NAMES[17] = {
     HV_X64_REGISTER_APIC_BASE,
 };
 
+static enum hv_register_name FPU_REGISTER_NAMES[26] = {
+    HV_X64_REGISTER_XMM0,
+    HV_X64_REGISTER_XMM1,
+    HV_X64_REGISTER_XMM2,
+    HV_X64_REGISTER_XMM3,
+    HV_X64_REGISTER_XMM4,
+    HV_X64_REGISTER_XMM5,
+    HV_X64_REGISTER_XMM6,
+    HV_X64_REGISTER_XMM7,
+    HV_X64_REGISTER_XMM8,
+    HV_X64_REGISTER_XMM9,
+    HV_X64_REGISTER_XMM10,
+    HV_X64_REGISTER_XMM11,
+    HV_X64_REGISTER_XMM12,
+    HV_X64_REGISTER_XMM13,
+    HV_X64_REGISTER_XMM14,
+    HV_X64_REGISTER_XMM15,
+    HV_X64_REGISTER_FP_MMX0,
+    HV_X64_REGISTER_FP_MMX1,
+    HV_X64_REGISTER_FP_MMX2,
+    HV_X64_REGISTER_FP_MMX3,
+    HV_X64_REGISTER_FP_MMX4,
+    HV_X64_REGISTER_FP_MMX5,
+    HV_X64_REGISTER_FP_MMX6,
+    HV_X64_REGISTER_FP_MMX7,
+    HV_X64_REGISTER_FP_CONTROL_STATUS,
+    HV_X64_REGISTER_XMM_CONTROL_STATUS,
+};
+
 int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs)
 {
@@ -372,8 +401,216 @@ int mshv_load_regs(CPUState *cpu)
     return 0;
 }
 
+static inline void populate_hv_segment_reg(SegmentCache *seg,
+                                           hv_x64_segment_register *hv_reg)
+{
+    uint32_t flags = seg->flags;
+
+    hv_reg->base = seg->base;
+    hv_reg->limit = seg->limit;
+    hv_reg->selector = seg->selector;
+    hv_reg->segment_type = (flags >> DESC_TYPE_SHIFT) & 0xF;
+    hv_reg->non_system_segment = (flags & DESC_S_MASK) != 0;
+    hv_reg->descriptor_privilege_level = (flags >> DESC_DPL_SHIFT) & 0x3;
+    hv_reg->present = (flags & DESC_P_MASK) != 0;
+    hv_reg->reserved = 0;
+    hv_reg->available = (flags & DESC_AVL_MASK) != 0;
+    hv_reg->_long = (flags >> DESC_L_SHIFT) & 0x1;
+    hv_reg->_default = (flags >> DESC_B_SHIFT) & 0x1;
+    hv_reg->granularity = (flags & DESC_G_MASK) != 0;
+}
+
+static inline void populate_hv_table_reg(const struct SegmentCache *seg,
+                                         hv_x64_table_register *hv_reg)
+{
+    memset(hv_reg, 0, sizeof(*hv_reg));
+
+    hv_reg->base = seg->base;
+    hv_reg->limit = seg->limit;
+}
+
+static int set_special_regs(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    struct hv_register_assoc assocs[ARRAY_SIZE(SPECIAL_REGISTER_NAMES)];
+    size_t n_regs = ARRAY_SIZE(SPECIAL_REGISTER_NAMES);
+    int ret;
+
+    /* set names */
+    for (size_t i = 0; i < n_regs; i++) {
+        assocs[i].name = SPECIAL_REGISTER_NAMES[i];
+    }
+    populate_hv_segment_reg(&env->segs[R_CS], &assocs[0].value.segment);
+    populate_hv_segment_reg(&env->segs[R_DS], &assocs[1].value.segment);
+    populate_hv_segment_reg(&env->segs[R_ES], &assocs[2].value.segment);
+    populate_hv_segment_reg(&env->segs[R_FS], &assocs[3].value.segment);
+    populate_hv_segment_reg(&env->segs[R_GS], &assocs[4].value.segment);
+    populate_hv_segment_reg(&env->segs[R_SS], &assocs[5].value.segment);
+    populate_hv_segment_reg(&env->tr, &assocs[6].value.segment);
+    populate_hv_segment_reg(&env->ldt, &assocs[7].value.segment);
+
+    populate_hv_table_reg(&env->gdt, &assocs[8].value.table);
+    populate_hv_table_reg(&env->idt, &assocs[9].value.table);
+
+    assocs[10].value.reg64 = env->cr[0];
+    assocs[11].value.reg64 = env->cr[2];
+    assocs[12].value.reg64 = env->cr[3];
+    assocs[13].value.reg64 = env->cr[4];
+    assocs[14].value.reg64 = cpu_get_apic_tpr(x86cpu->apic_state);
+    assocs[15].value.reg64 = env->efer;
+    assocs[16].value.reg64 = cpu_get_apic_base(x86cpu->apic_state);
+
+    ret = mshv_set_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to set special registers");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_fpu(const CPUState *cpu, const struct MshvFPU *regs)
+{
+    struct hv_register_assoc assocs[ARRAY_SIZE(FPU_REGISTER_NAMES)];
+    union hv_register_value *value;
+    size_t fp_i;
+    union hv_x64_fp_control_status_register *ctrl_status;
+    union hv_x64_xmm_control_status_register *xmm_ctrl_status;
+    int ret;
+    size_t n_regs = ARRAY_SIZE(FPU_REGISTER_NAMES);
+
+    /* first 16 registers are xmm0-xmm15 */
+    for (size_t i = 0; i < 16; i++) {
+        assocs[i].name = FPU_REGISTER_NAMES[i];
+        value = &assocs[i].value;
+        memcpy(&value->reg128, &regs->xmm[i], 16);
+    }
+
+    /* next 8 registers are fp_mmx0-fp_mmx7 */
+    for (size_t i = 16; i < 24; i++) {
+        assocs[i].name = FPU_REGISTER_NAMES[i];
+        fp_i = (i - 16);
+        value = &assocs[i].value;
+        memcpy(&value->reg128, &regs->fpr[fp_i], 16);
+    }
+
+    /* last two registers are fp_control_status and xmm_control_status */
+    assocs[24].name = FPU_REGISTER_NAMES[24];
+    value = &assocs[24].value;
+    ctrl_status = &value->fp_control_status;
+    ctrl_status->fp_control = regs->fcw;
+    ctrl_status->fp_status = regs->fsw;
+    ctrl_status->fp_tag = regs->ftwx;
+    ctrl_status->reserved = 0;
+    ctrl_status->last_fp_op = regs->last_opcode;
+    ctrl_status->last_fp_rip = regs->last_ip;
+
+    assocs[25].name = FPU_REGISTER_NAMES[25];
+    value = &assocs[25].value;
+    xmm_ctrl_status = &value->xmm_control_status;
+    xmm_ctrl_status->xmm_status_control = regs->mxcsr;
+    xmm_ctrl_status->xmm_status_control_mask = 0;
+    xmm_ctrl_status->last_fp_rdp = regs->last_dp;
+
+    ret = mshv_set_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to set fpu registers");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_xc_reg(const CPUState *cpu, uint64_t xcr0)
+{
+    int ret;
+    struct hv_register_assoc assoc = {
+        .name = HV_X64_REGISTER_XFEM,
+        .value.reg64 = xcr0,
+    };
+
+    ret = mshv_set_generic_regs(cpu, &assoc, 1);
+    if (ret < 0) {
+        error_report("failed to set xcr0");
+        return -errno;
+    }
+    return 0;
+}
+
+static int set_cpu_state(const CPUState *cpu, const MshvFPU *fpu_regs,
+                         uint64_t xcr0)
+{
+    int ret;
+
+    ret = set_standard_regs(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+    ret = set_special_regs(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+    ret = set_fpu(cpu, fpu_regs);
+    if (ret < 0) {
+        return ret;
+    }
+    ret = set_xc_reg(cpu, xcr0);
+    if (ret < 0) {
+        return ret;
+    }
+    return 0;
+}
+
+/*
+ * TODO: populate topology info:
+ *
+ * X86CPU *x86cpu = X86_CPU(cpu);
+ * CPUX86State *env = &x86cpu->env;
+ * X86CPUTopoInfo *topo_info = &env->topo_info;
+ */
+int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
+                        uint64_t xcr0)
+{
+    int ret;
+
+    ret = set_cpu_state(cpu, fpu, xcr0);
+    if (ret < 0) {
+        error_report("failed to set cpu state");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int put_regs(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    MshvFPU fpu = {0};
+    int ret;
+
+    memset(&fpu, 0, sizeof(fpu));
+
+    ret = mshv_configure_vcpu(cpu, &fpu, env->xcr0);
+    if (ret < 0) {
+        error_report("failed to configure vcpu");
+        return ret;
+    }
+
+    return 0;
+}
+
 int mshv_arch_put_registers(const CPUState *cpu)
 {
+    int ret;
+
+    ret = put_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to put registers");
+        return -1;
+    }
+
     error_report("unimplemented");
     abort();
 }
-- 
2.51.0


