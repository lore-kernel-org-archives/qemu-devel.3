Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AE9D39406
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Eiy-00079b-6o; Thu, 02 Apr 2026 05:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8Eiu-00078v-QK
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8Eis-0008TM-SP
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775123540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1gBbz0lXmLXZQfWTPJ1x/oz786AusvxHAXLc6WW8Klk=;
 b=cU+j3yFzsVA5KzeyJqg7qlV/Rb9wd8AD6OWhfOd4ZBa4JSQ75sGjCS1+o7gZ8NgltvcA+q
 1hz7lukx1lXXk343cDPe2+03IU+kBYBZSF1WB5M6xuaBLosPx/Eoi8knwwarafQI/yN5FF
 TABXk1IXX2yBFIUnGtDhRJZa+2nn7sk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-4uqSidACPHiJXw1hTNwhTg-1; Thu,
 02 Apr 2026 05:52:17 -0400
X-MC-Unique: 4uqSidACPHiJXw1hTNwhTg-1
X-Mimecast-MFC-AGG-ID: 4uqSidACPHiJXw1hTNwhTg_1775123536
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00733180047F; Thu,  2 Apr 2026 09:52:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66333196B088; Thu,  2 Apr 2026 09:52:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 09/10] target/i386: Support migrating from i386 to x86_64
 target
Date: Thu,  2 Apr 2026 11:51:31 +0200
Message-ID: <20260402095132.29245-10-thuth@redhat.com>
In-Reply-To: <20260402095132.29245-1-thuth@redhat.com>
References: <20260402095132.29245-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

For migrating from qemu-system-i386 to qemu-system-x86_64, we have
to support the CPU vmstate of the 32-bit target.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/i386/cpu.h     |  47 +++++++--
 target/i386/cpu.c     |   8 +-
 target/i386/machine.c | 222 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 270 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 78f2dadc2e3..88fcf44fdc0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1632,6 +1632,13 @@ typedef struct SegmentCache {
     uint32_t flags;
 } SegmentCache;
 
+typedef struct SegmentCache32 {
+    uint32_t selector;
+    uint32_t base;
+    uint32_t limit;
+    uint32_t flags;
+} SegmentCache32;
+
 typedef union MMXReg {
     uint8_t  _b_MMXReg[64 / 8];
     uint16_t _w_MMXReg[64 / 16];
@@ -1974,10 +1981,16 @@ typedef struct CPUCaches {
 typedef struct CPUArchState {
     /* standard registers */
     target_ulong regs[CPU_NB_EREGS];
-    target_ulong eip;
-    target_ulong eflags; /* eflags register. During CPU emulation, CC
-                        flags and DF are set to zero because they are
-                        stored elsewhere */
+    union {
+        target_ulong eip;
+        uint32_t eip32;
+    };
+    union {
+        target_ulong eflags; /* eflags register. During CPU emulation, CC
+                                flags and DF are set to zero because they are
+                                stored elsewhere */
+        uint32_t eflags32;
+    };
 
     /* emulator internal eflags handling */
     target_ulong cc_dst;
@@ -2042,8 +2055,14 @@ typedef struct CPUArchState {
 
     /* sysenter registers */
     uint32_t sysenter_cs;
-    target_ulong sysenter_esp;
-    target_ulong sysenter_eip;
+    union {
+        target_ulong sysenter_esp;
+        uint32_t sysenter_esp32;
+    };
+    union {
+        target_ulong sysenter_eip;
+        uint32_t sysenter_eip32;
+    };
     uint64_t star;
 
     uint64_t vm_hsave;
@@ -2294,6 +2313,21 @@ typedef struct CPUArchState {
     uint16_t fptag_vmstate;
     uint16_t fpregs_format_vmstate;
 
+#ifdef TARGET_X86_64
+    /*
+     * These fields are only used for migrating from qemu-system-i386
+     * to qemu-system-x86_64
+     */
+    uint32_t regs32[CPU_NB_REGS32];
+    SegmentCache32 segs32[6]; /* selector values */
+    SegmentCache32 ldt32;
+    SegmentCache32 tr32;
+    SegmentCache32 gdt32; /* only base and limit are used */
+    SegmentCache32 idt32; /* only base and limit are used */
+    uint32_t cr32[5];
+    uint32_t dr32[8];
+#endif
+
     uint64_t xss;
     uint32_t umwait;
 
@@ -2546,6 +2580,7 @@ struct X86CPUClass {
 
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_x86_cpu;
+extern const VMStateDescription vmstate_i386_cpu;
 #endif
 
 int x86_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a8ff1b29f33..a087a45dbfe 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10701,7 +10701,7 @@ static const Property x86_cpu_properties[] = {
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 
-static const struct SysemuCPUOps i386_sysemu_ops = {
+static struct SysemuCPUOps i386_sysemu_ops = {
     .has_work = x86_cpu_has_work,
     .get_memory_mapping = x86_cpu_get_memory_mapping,
     .get_paging_enabled = x86_cpu_get_paging_enabled,
@@ -10746,8 +10746,14 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
 
 #ifndef CONFIG_USER_ONLY
     cc->max_as = X86ASIdx_MAX;
+#ifdef TARGET_X86_64
+    if (target_i386()) {
+        i386_sysemu_ops.legacy_vmsd = &vmstate_i386_cpu;
+    }
+#endif
     cc->sysemu_ops = &i386_sysemu_ops;
 #endif /* !CONFIG_USER_ONLY */
+
 #ifdef CONFIG_TCG
     cc->tcg_ops = &x86_tcg_ops;
 #endif /* CONFIG_TCG */
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 48a2a4b3190..bb6019d3419 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -310,6 +310,44 @@ static int cpu_pre_save(void *opaque)
     return 0;
 }
 
+
+#ifdef TARGET_X86_64
+static void copy_segcache(SegmentCache32 *sc32, SegmentCache *sc64)
+{
+    sc64->selector = sc32->selector;
+    sc64->base = sc32->base;
+    sc64->limit = sc32->limit;
+    sc64->flags = sc32->flags;
+}
+#endif
+
+static void cpu_post_load_fixup32(CPUX86State *env)
+{
+#ifdef TARGET_X86_64
+    int i;
+
+    for (i = 0; i < CPU_NB_REGS32; i++) {
+        env->regs[i] = env->regs32[i];
+    }
+
+    for (i = 0; i < ARRAY_SIZE(env->segs); i++) {
+        copy_segcache(&env->segs32[i], &env->segs[i]);
+    }
+
+    copy_segcache(&env->ldt32, &env->ldt);
+    copy_segcache(&env->tr32, &env->tr);
+    copy_segcache(&env->gdt32, &env->gdt);
+    copy_segcache(&env->idt32, &env->idt);
+
+    for (i = 0; i < ARRAY_SIZE(env->cr); i++) {
+        env->cr[i] = env->cr32[i];
+    }
+    for (i = 0; i < ARRAY_SIZE(env->dr); i++) {
+        env->dr[i] = env->dr32[i];
+    }
+#endif
+}
+
 static int cpu_post_load(void *opaque, int version_id)
 {
     X86CPU *cpu = opaque;
@@ -317,6 +355,10 @@ static int cpu_post_load(void *opaque, int version_id)
     CPUX86State *env = &cpu->env;
     int i;
 
+    if (target_i386()) {
+        cpu_post_load_fixup32(env);
+    }
+
     if (env->tsc_khz && env->user_tsc_khz &&
         env->tsc_khz != env->user_tsc_khz) {
         error_report("Mismatch between user-specified TSC frequency and "
@@ -1920,3 +1962,183 @@ const VMStateDescription vmstate_x86_cpu = {
         NULL
     }
 };
+
+/* ***************** 32-bit target hacks below **************** */
+
+#ifdef TARGET_X86_64
+
+static const VMStateDescription vmstate_segment32 = {
+    .name = "segment",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(selector, SegmentCache32),
+        VMSTATE_UINT32(base, SegmentCache32),
+        VMSTATE_UINT32(limit, SegmentCache32),
+        VMSTATE_UINT32(flags, SegmentCache32),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+#define VMSTATE_SEGMENT32(_field, _state) {                          \
+    .name       = (stringify(_field)),                               \
+    .size       = sizeof(SegmentCache32),                            \
+    .vmsd       = &vmstate_segment32,                                \
+    .flags      = VMS_STRUCT,                                        \
+    .offset     = offsetof(_state, _field)                           \
+            + type_check(SegmentCache32, typeof_field(_state, _field)) \
+}
+
+#define VMSTATE_SEGMENT32_ARRAY(_field, _state, _n)                  \
+    VMSTATE_STRUCT_ARRAY(_field, _state, _n, 0, vmstate_segment32, SegmentCache32)
+
+#define VMSTATE_XMM32_REGS(_field, _state, _start)                       \
+    VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, CPU_NB_REGS32, 0,   \
+                             vmstate_xmm_reg, ZMMReg)
+
+#define VMSTATE_YMMH32_REGS_VARS(_field, _state, _start, _v)             \
+    VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, CPU_NB_REGS32, _v,  \
+                             vmstate_ymmh_reg, ZMMReg)
+
+const VMStateDescription vmstate_i386_cpu = {
+    .name = "cpu",
+    .version_id = 12,
+    .minimum_version_id = 11,
+    .pre_save = cpu_pre_save,
+    .post_load = cpu_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_SUB_ARRAY(env.regs32, X86CPU, 0, CPU_NB_REGS32),
+        VMSTATE_UINT32(env.eip32, X86CPU),
+        VMSTATE_UINT32(env.eflags32, X86CPU),
+        VMSTATE_UINT32(env.hflags, X86CPU),
+        /* FPU */
+        VMSTATE_UINT16(env.fpuc, X86CPU),
+        VMSTATE_UINT16(env.fpus_vmstate, X86CPU),
+        VMSTATE_UINT16(env.fptag_vmstate, X86CPU),
+        VMSTATE_UINT16(env.fpregs_format_vmstate, X86CPU),
+
+        VMSTATE_STRUCT_ARRAY(env.fpregs, X86CPU, 8, 0, vmstate_fpreg, FPReg),
+
+        VMSTATE_SEGMENT32_ARRAY(env.segs32, X86CPU, 6),
+        VMSTATE_SEGMENT32(env.ldt32, X86CPU),
+        VMSTATE_SEGMENT32(env.tr32, X86CPU),
+        VMSTATE_SEGMENT32(env.gdt32, X86CPU),
+        VMSTATE_SEGMENT32(env.idt32, X86CPU),
+
+        VMSTATE_UINT32(env.sysenter_cs, X86CPU),
+        VMSTATE_UINT32(env.sysenter_esp32, X86CPU),
+        VMSTATE_UINT32(env.sysenter_eip32, X86CPU),
+
+        VMSTATE_UINT32(env.cr32[0], X86CPU),
+        VMSTATE_UINT32(env.cr32[2], X86CPU),
+        VMSTATE_UINT32(env.cr32[3], X86CPU),
+        VMSTATE_UINT32(env.cr32[4], X86CPU),
+        VMSTATE_UINT32_ARRAY(env.dr32, X86CPU, 8),
+        /* MMU */
+        VMSTATE_INT32(env.a20_mask, X86CPU),
+        /* XMM */
+        VMSTATE_UINT32(env.mxcsr, X86CPU),
+        VMSTATE_XMM32_REGS(env.xmm_regs, X86CPU, 0),
+
+        VMSTATE_UINT32(env.smbase, X86CPU),
+
+        VMSTATE_UINT64(env.pat, X86CPU),
+        VMSTATE_UINT32(env.hflags2, X86CPU),
+
+        VMSTATE_UINT64(env.vm_hsave, X86CPU),
+        VMSTATE_UINT64(env.vm_vmcb, X86CPU),
+        VMSTATE_UINT64(env.tsc_offset, X86CPU),
+        VMSTATE_UINT64(env.intercept, X86CPU),
+        VMSTATE_UINT16(env.intercept_cr_read, X86CPU),
+        VMSTATE_UINT16(env.intercept_cr_write, X86CPU),
+        VMSTATE_UINT16(env.intercept_dr_read, X86CPU),
+        VMSTATE_UINT16(env.intercept_dr_write, X86CPU),
+        VMSTATE_UINT32(env.intercept_exceptions, X86CPU),
+        VMSTATE_UINT8(env.v_tpr, X86CPU),
+        /* MTRRs */
+        VMSTATE_UINT64_ARRAY(env.mtrr_fixed, X86CPU, 11),
+        VMSTATE_UINT64(env.mtrr_deftype, X86CPU),
+        VMSTATE_MTRR_VARS(env.mtrr_var, X86CPU, MSR_MTRRcap_VCNT, 8),
+        /* KVM-related states */
+        VMSTATE_INT32(env.interrupt_injected, X86CPU),
+        VMSTATE_UINT32(env.mp_state, X86CPU),
+        VMSTATE_UINT64(env.tsc, X86CPU),
+        VMSTATE_INT32(env.exception_nr, X86CPU),
+        VMSTATE_UINT8(env.soft_interrupt, X86CPU),
+        VMSTATE_UINT8(env.nmi_injected, X86CPU),
+        VMSTATE_UINT8(env.nmi_pending, X86CPU),
+        VMSTATE_UINT8(env.has_error_code, X86CPU),
+        VMSTATE_UINT32(env.sipi_vector, X86CPU),
+        /* MCE */
+        VMSTATE_UINT64(env.mcg_cap, X86CPU),
+        VMSTATE_UINT64(env.mcg_status, X86CPU),
+        VMSTATE_UINT64(env.mcg_ctl, X86CPU),
+        VMSTATE_UINT64_ARRAY(env.mce_banks, X86CPU, MCE_BANKS_DEF * 4),
+        /* rdtscp */
+        VMSTATE_UINT64(env.tsc_aux, X86CPU),
+        /* KVM pvclock msr */
+        VMSTATE_UINT64(env.system_time_msr, X86CPU),
+        VMSTATE_UINT64(env.wall_clock_msr, X86CPU),
+        /* XSAVE related fields */
+        VMSTATE_UINT64_V(env.xcr0, X86CPU, 12),
+        VMSTATE_UINT64_V(env.xstate_bv, X86CPU, 12),
+        VMSTATE_YMMH32_REGS_VARS(env.xmm_regs, X86CPU, 0, 12),
+        VMSTATE_END_OF_LIST()
+        /* The above list is not sorted /wrt version numbers, watch out! */
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_exception_info,
+        &vmstate_error_code,
+        &vmstate_async_pf_msr,
+        &vmstate_async_pf_int_msr,
+        &vmstate_pv_eoi_msr,
+        &vmstate_steal_time_msr,
+        &vmstate_poll_control_msr,
+        &vmstate_fpop_ip_dp,
+        &vmstate_msr_tsc_adjust,
+        &vmstate_msr_tscdeadline,
+        &vmstate_msr_ia32_misc_enable,
+        &vmstate_msr_ia32_feature_control,
+        &vmstate_msr_architectural_pmu,
+        &vmstate_mpx,
+        &vmstate_msr_hyperv_hypercall,
+        &vmstate_msr_hyperv_vapic,
+        &vmstate_msr_hyperv_time,
+        &vmstate_msr_hyperv_crash,
+        &vmstate_msr_hyperv_runtime,
+        &vmstate_msr_hyperv_synic,
+        &vmstate_msr_hyperv_stimer,
+        &vmstate_msr_hyperv_reenlightenment,
+        &vmstate_avx512,
+        &vmstate_xss,
+        &vmstate_umwait,
+        &vmstate_tsc_khz,
+        &vmstate_msr_smi_count,
+        &vmstate_pkru,
+        &vmstate_pkrs,
+        &vmstate_spec_ctrl,
+        &amd_tsc_scale_msr_ctrl,
+        &vmstate_mcg_ext_ctl,
+        &vmstate_msr_intel_pt,
+        &vmstate_msr_virt_ssbd,
+        &vmstate_svm_npt,
+        &vmstate_svm_guest,
+#ifdef CONFIG_KVM
+        &vmstate_nested_state,
+        &vmstate_xen_vcpu,
+#endif
+        &vmstate_msr_tsx_ctrl,
+        &vmstate_msr_intel_sgx,
+        &vmstate_pdptrs,
+        &vmstate_msr_xfd,
+        &vmstate_msr_hwcr,
+        &vmstate_arch_lbr,
+        &vmstate_triple_fault,
+        &vmstate_pl0_ssp,
+        &vmstate_cet,
+
+        NULL
+    }
+};
+
+#endif /* TARGET_X86_64 */
-- 
2.53.0


