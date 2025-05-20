Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611BAC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLCu-0000iJ-04; Tue, 20 May 2025 07:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uHLCr-0000dX-MB
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:32:25 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uHLCo-0001NF-He
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:32:24 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (unknown [172.201.77.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8E46F2068327;
 Tue, 20 May 2025 04:32:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E46F2068327
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747740730;
 bh=K7D24rXCK/8aJRaJM4RGExDIjlCotwx+z/V1lse7ahY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eKSgxCsw4ccjNpHQghcdZCdv6WxhEztAXsHcqsnBD61ZigMKvYErHLh65UvNQdilD
 Tgzcjd2sqJYwnu8FevIU6F/rP+YRQrIdeR0LAOvTPSFecY9SYy4VKFfOO/SvEA8J8Y
 Gezq3tMN+uKMSkvCCodynaA7IdeD4QI4bek76ypA=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: magnuskulke@microsoft.com,
	qemu-devel@nongnu.org,
	liuwe@microsoft.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 18/25] target/i386/mshv: Implement
 mshv_arch_put_registers()
Date: Tue, 20 May 2025 13:30:11 +0200
Message-Id: <20250520113018.49569-19-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Write CPU register state to MSHV vCPUs. Various mapping functions to
prepare the payload for the HV call have been implemented.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/system/mshv.h       |  41 ++++++
 target/i386/mshv/mshv-cpu.c | 249 ++++++++++++++++++++++++++++++++++++
 2 files changed, 290 insertions(+)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index 055489a6f3..76a3b0010e 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -99,6 +99,46 @@ typedef struct MshvMsiControl {
 #define EFER_LMA   ((uint64_t)0x400)
 #define EFER_LME   ((uint64_t)0x100)
 
+/* CR0 bits */
+#define CR0_PE     ((uint64_t)0x1)
+#define CR0_PG     ((uint64_t)0x80000000)
+
+/* CR4 bits */
+#define CR4_PAE    ((uint64_t)0x20)
+#define CR4_LA57   ((uint64_t)0x1000)
+
+/* rflags bits (shift values) */
+#define CF_SHIFT   0
+#define PF_SHIFT   2
+#define AF_SHIFT   4
+#define ZF_SHIFT   6
+#define SF_SHIFT   7
+#define DF_SHIFT   10
+#define OF_SHIFT   11
+
+/* rflags bits (bit masks) */
+#define CF         ((uint64_t)1 << CF_SHIFT)
+#define PF         ((uint64_t)1 << PF_SHIFT)
+#define AF         ((uint64_t)1 << AF_SHIFT)
+#define ZF         ((uint64_t)1 << ZF_SHIFT)
+#define SF         ((uint64_t)1 << SF_SHIFT)
+#define DF         ((uint64_t)1 << DF_SHIFT)
+#define OF         ((uint64_t)1 << OF_SHIFT)
+
+typedef struct MshvFPU {
+  uint8_t fpr[8][16];
+  uint16_t fcw;
+  uint16_t fsw;
+  uint8_t ftwx;
+  uint8_t pad1;
+  uint16_t last_opcode;
+  uint64_t last_ip;
+  uint64_t last_dp;
+  uint8_t xmm[16][16];
+  uint32_t mxcsr;
+  uint32_t pad2;
+} MshvFPU;
+
 typedef enum MshvVmExit {
     MshvVmExitIgnore   = 0,
     MshvVmExitShutdown = 1,
@@ -108,6 +148,7 @@ typedef enum MshvVmExit {
 void mshv_init_cpu_logic(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
+int mshv_configure_vcpu(const CPUState *cpu, const MshvFPU *fpu, uint64_t xcr0);
 int mshv_get_standard_regs(CPUState *cpu);
 int mshv_get_special_regs(CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 979ee5b8c3..ad42a09b99 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -79,6 +79,35 @@ static enum hv_register_name SPECIAL_REGISTER_NAMES[18] = {
     HV_REGISTER_PENDING_INTERRUPTION,
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
 static void add_cpu_guard(int cpu_fd)
 {
     QemuMutex *guard;
@@ -343,8 +372,228 @@ int mshv_load_regs(CPUState *cpu)
     return 0;
 }
 
+static void populate_hv_segment_reg(SegmentCache *seg,
+                                    hv_x64_segment_register *hv_reg)
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
+static void populate_hv_table_reg(const struct SegmentCache *seg,
+                                  hv_x64_table_register *hv_reg)
+{
+    hv_reg->base = seg->base;
+    hv_reg->limit = seg->limit;
+    memset(hv_reg->pad, 0, sizeof(hv_reg->pad));
+}
+
+static int set_special_regs(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    int cpu_fd = mshv_vcpufd(cpu);
+    struct hv_register_assoc *assocs;
+    size_t n_regs = sizeof(SPECIAL_REGISTER_NAMES) / sizeof(hv_register_name);
+    int ret;
+
+    assocs = g_new0(struct hv_register_assoc, n_regs);
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
+    /*
+     * TODO: support asserting an interrupt using interrup_bitmap
+     * it should be possible if we use the vm_fd
+     */
+
+    ret = mshv_set_generic_regs(cpu_fd, assocs, n_regs);
+    g_free(assocs);
+    if (ret < 0) {
+        error_report("failed to set special registers");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_fpu_regs(int cpu_fd, const struct MshvFPU *regs)
+{
+    struct hv_register_assoc *assocs;
+    union hv_register_value *value;
+    size_t n_regs = sizeof(FPU_REGISTER_NAMES) / sizeof(enum hv_register_name);
+    size_t fp_i;
+    union hv_x64_fp_control_status_register *ctrl_status;
+    union hv_x64_xmm_control_status_register *xmm_ctrl_status;
+    int ret;
+
+    assocs = g_new0(struct hv_register_assoc, n_regs);
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
+    ret = mshv_set_generic_regs(cpu_fd, assocs, n_regs);
+    g_free(assocs);
+    if (ret < 0) {
+        error_report("failed to set fpu registers");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_xc_reg(int cpu_fd, uint64_t xcr0)
+{
+    int ret;
+    struct hv_register_assoc assoc = {
+        .name = HV_X64_REGISTER_XFEM,
+        .value.reg64 = xcr0,
+    };
+
+    ret = mshv_set_generic_regs(cpu_fd, &assoc, 1);
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
+    int cpu_fd = mshv_vcpufd(cpu);
+
+    ret = set_standard_regs(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+    ret = set_special_regs(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+    ret = set_fpu_regs(cpu_fd, fpu_regs);
+    if (ret < 0) {
+        return ret;
+    }
+    ret = set_xc_reg(cpu_fd, xcr0);
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
2.34.1


