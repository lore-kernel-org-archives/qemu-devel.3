Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD28CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eM-0007up-AU; Fri, 26 Jun 2026 06:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dn-0007JR-Nu
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dl-0005B1-B1
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XHg+sFyNMes+caI8HycqYBS24olay+Ktvlo3gmk/XWo=;
 b=U+JTxbpnALvaW4JrdvMoKCj3HeiFTiMhPO27rMnbiUANfy98LBvMSlT3zeyvOjVCyZcsat
 ouY+evG5e7ofzVDtEHT6ASV80n5/NC8s2G6i+jB8a8og3WgnxifYhAS/lfDk8ahobXg1Qo
 JWUGTt07dz713K+neGKg+ETjyDdTpHY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-8XfL0QFzPpOEcluXIhpBkw-1; Fri, 26 Jun 2026 06:18:21 -0400
X-MC-Unique: 8XfL0QFzPpOEcluXIhpBkw-1
X-Mimecast-MFC-AGG-ID: 8XfL0QFzPpOEcluXIhpBkw_1782469100
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46315372c3eso584273f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469100; x=1783073900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHg+sFyNMes+caI8HycqYBS24olay+Ktvlo3gmk/XWo=;
 b=o99og3bgJPuTPeRJe/MY6TLN1PuCXZqMO80KJobUB86e7JL7FNwVRJzxCh1TBtsoD3
 oQgdYrocyChfein+6ycClyC/Fpznt4HrNDWZaTkL9ObUMJbh7c0IzvLz3tzkhBAUmvzv
 7mzrWGIdJNcw0ZcAV3kdiRC1phc5E2ync5UMXXjquzAguJXXAYKHj221I5S4V3P6TSZ6
 g3QkRhyAhcieAahw3Tm//7K0Q36GztX91V/RGaz6uOyUwOCyxME+7NLlTdjBSCqBhmGb
 3yIBJOL2kC+EGV825IsjyLUAA9bgwJZRXkudb+LdpwF3z25keEvTPpsLjJAK+aliVvMD
 RmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469100; x=1783073900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XHg+sFyNMes+caI8HycqYBS24olay+Ktvlo3gmk/XWo=;
 b=QAgan0I3M/JG1yfwD77Bahc6ggCOBi538MZYjf5jNpoeUjdRVwDaTemKd9de7zN74N
 TEmxftxtzkrIL+F6blReoJgUF4dnw+YYXgTdZhwY2F4S/MTpdj1R08BnN2Wrg2bA8wZL
 UOeDGEjf327h0EMzHeNUp54AXaYi58Cia2gOaXa6BCoJVAzNcmXKyaioE3uvMG49ObA+
 wtHExQaCHzUH3ss3SVT5Vd4z0DRSLjGviN50+0Bjelk6thVBbdRM8Yj37J1kYDvxUlwM
 CusFIMtc4xJx3jhWcIiNzBV6D9SIzjN9tD2y4szk8M8KSDP8ReYzuukf8DXmqPiHFgC7
 aqHQ==
X-Gm-Message-State: AOJu0Yya62hYNd3nm90Pl+vIkY5PS5hEy5vfj0BQjuDFNSachEs6BVLy
 Fsfxrp9uJYSBzR1xPx9rR9id6Un/4/YrDsGpmRWkm4gaJMAtR2lpTq18PFDxmdo/zMFY0Tp+wIJ
 hdGQp+Hx48Qkvj95OAU1qaDjl0anAGt6J4lzYzHbBVEbgphJfPso0HbPsHqsCGVmgC3qFVTqyy4
 w2K6pVXsBDoCG35DFrtaUshvRTRV3OdpWeAuK43gsT
X-Gm-Gg: AfdE7clyhIY6gK8nldrGDS6CwnuqqknVeaTgzcjkaoI6ZOgRk37F5RCdwVXXcRf2jTr
 G4hHhC2+yAXpS+LNII8i5Q52MrpF2dU9ze3ai3Nx81bYVMiZmHlM75mT8uRwhvyruqZvv+xm8fn
 Zc+ctUKy+TucbpRDfSwVS19WI4HbJ/E3kt51tB4Z9dpCnl2WeqiGTDvEMeJZtLBoUHkUUZcZUiA
 1Wfz13d1Qiru9BJThUVJ1I8Fe0dpsm3eAuytNFOHtx1wCMnQoJ4x6831/1CUnlfrLWWvmMcxxea
 6xl1AnPSpTdi2hWl2DiqQYuKHn/tLOznCCMtCOhHIcgO2XyXhlJjpebeH8WSi0XSRZX+wDd392q
 JtH0gzyjB4Q/jrWFMONmRmvGk7MGNbHwNRX9/G5aWrSIdErJ6A8xVPloiQdsvYtPve52lA34X38
 XFFZ+PDPSaB5OIlH58
X-Received: by 2002:a5d:5d81:0:b0:461:cd9e:2368 with SMTP id
 ffacd0b85a97d-46dc0e050f2mr10233773f8f.27.1782469100333; 
 Fri, 26 Jun 2026 03:18:20 -0700 (PDT)
X-Received: by 2002:a5d:5d81:0:b0:461:cd9e:2368 with SMTP id
 ffacd0b85a97d-46dc0e050f2mr10233717f8f.27.1782469099844; 
 Fri, 26 Jun 2026 03:18:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46d3ba68d8dsm17696085f8f.27.2026.06.26.03.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 11/45] target/i386/mshv: use generic FPU/xcr0 state
Date: Fri, 26 Jun 2026 12:17:14 +0200
Message-ID: <20260626101748.1728079-12-pbonzini@redhat.com>
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

Instead of using an mshv-specific FPU state representation we switch to
the generic i386 representation of the registers.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-3-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   | 15 +-------
 target/i386/mshv/mshv-cpu.c | 76 ++++++++++++++++++++++---------------
 2 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index bf0fe571f01..bb7f6740bba 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -58,19 +58,6 @@ typedef struct MshvMsiControl {
 #define mshv_vcpufd(cpu) (cpu->accel->cpufd)
 
 /* cpu */
-typedef struct MshvFPU {
-    uint8_t fpr[8][16];
-    uint16_t fcw;
-    uint16_t fsw;
-    uint8_t ftwx;
-    uint8_t pad1;
-    uint16_t last_opcode;
-    uint64_t last_ip;
-    uint64_t last_dp;
-    uint8_t xmm[16][16];
-    uint32_t mxcsr;
-    uint32_t pad2;
-} MshvFPU;
 
 typedef enum MshvVmExit {
     MshvVmExitIgnore   = 0,
@@ -81,7 +68,7 @@ typedef enum MshvVmExit {
 void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
-int mshv_configure_vcpu(const CPUState *cpu, const MshvFPU *fpu, uint64_t xcr0);
+int mshv_configure_vcpu(const CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_arch_load_regs(CPUState *cpu);
 int mshv_arch_store_regs(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index fba95392b9d..b5c0c504cb1 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -111,6 +111,9 @@ static enum hv_register_name FPU_REGISTER_NAMES[26] = {
 };
 
 static int set_special_regs(const CPUState *cpu);
+static int get_generic_regs(CPUState *cpu,
+                            struct hv_register_assoc *assocs,
+                            size_t n_regs);
 
 static int translate_gva(const CPUState *cpu, uint64_t gva, uint64_t *gpa,
                          uint64_t flags)
@@ -767,48 +770,65 @@ static int set_special_regs(const CPUState *cpu)
     return 0;
 }
 
-static int set_fpu(const CPUState *cpu, const struct MshvFPU *regs)
+static int set_fpu(const CPUState *cpu)
 {
     struct hv_register_assoc assocs[ARRAY_SIZE(FPU_REGISTER_NAMES)];
     union hv_register_value *value;
-    size_t fp_i;
     union hv_x64_fp_control_status_register *ctrl_status;
     union hv_x64_xmm_control_status_register *xmm_ctrl_status;
     int ret;
     size_t n_regs = ARRAY_SIZE(FPU_REGISTER_NAMES);
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    size_t i, fp_i;
+    bool valid;
 
     /* first 16 registers are xmm0-xmm15 */
-    for (size_t i = 0; i < 16; i++) {
+    for (i = 0; i < 16; i++) {
         assocs[i].name = FPU_REGISTER_NAMES[i];
         value = &assocs[i].value;
-        memcpy(&value->reg128, &regs->xmm[i], 16);
+        value->reg128.low_part  = env->xmm_regs[i].ZMM_Q(0);
+        value->reg128.high_part = env->xmm_regs[i].ZMM_Q(1);
     }
 
     /* next 8 registers are fp_mmx0-fp_mmx7 */
-    for (size_t i = 16; i < 24; i++) {
-        assocs[i].name = FPU_REGISTER_NAMES[i];
+    for (i = 16; i < 24; i++) {
         fp_i = (i - 16);
+        assocs[i].name = FPU_REGISTER_NAMES[i];
         value = &assocs[i].value;
-        memcpy(&value->reg128, &regs->fpr[fp_i], 16);
+        value->fp.mantissa        = env->fpregs[fp_i].d.low;
+        value->fp.biased_exponent = env->fpregs[fp_i].d.high & 0x7FFF;
+        value->fp.sign            = (env->fpregs[fp_i].d.high >> 15) & 0x1;
+        value->fp.reserved        = 0;
     }
 
     /* last two registers are fp_control_status and xmm_control_status */
     assocs[24].name = FPU_REGISTER_NAMES[24];
     value = &assocs[24].value;
     ctrl_status = &value->fp_control_status;
-    ctrl_status->fp_control = regs->fcw;
-    ctrl_status->fp_status = regs->fsw;
-    ctrl_status->fp_tag = regs->ftwx;
+
+    ctrl_status->fp_control = env->fpuc;
+    /* bits 11,12,13 are the top of stack pointer */
+    ctrl_status->fp_status = (env->fpus & ~0x3800) | ((env->fpstt & 0x7) << 11);
+
+    ctrl_status->fp_tag = 0;
+    for (i = 0; i < 8; i++) {
+        valid = (env->fptags[i] == 0);
+        if (valid) {
+            ctrl_status->fp_tag |= (1u << i);
+        }
+    }
+
     ctrl_status->reserved = 0;
-    ctrl_status->last_fp_op = regs->last_opcode;
-    ctrl_status->last_fp_rip = regs->last_ip;
+    ctrl_status->last_fp_op = env->fpop;
+    ctrl_status->last_fp_rip = env->fpip;
 
     assocs[25].name = FPU_REGISTER_NAMES[25];
     value = &assocs[25].value;
     xmm_ctrl_status = &value->xmm_control_status;
-    xmm_ctrl_status->xmm_status_control = regs->mxcsr;
-    xmm_ctrl_status->xmm_status_control_mask = 0;
-    xmm_ctrl_status->last_fp_rdp = regs->last_dp;
+    xmm_ctrl_status->xmm_status_control = env->mxcsr;
+    xmm_ctrl_status->xmm_status_control_mask = 0x0000ffff;
+    xmm_ctrl_status->last_fp_rdp = env->fpdp;
 
     ret = mshv_set_generic_regs(cpu, assocs, n_regs);
     if (ret < 0) {
@@ -819,12 +839,15 @@ static int set_fpu(const CPUState *cpu, const struct MshvFPU *regs)
     return 0;
 }
 
-static int set_xc_reg(const CPUState *cpu, uint64_t xcr0)
+static int set_xc_reg(const CPUState *cpu)
 {
     int ret;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+
     struct hv_register_assoc assoc = {
         .name = HV_X64_REGISTER_XFEM,
-        .value.reg64 = xcr0,
+        .value.reg64 = env->xcr0,
     };
 
     ret = mshv_set_generic_regs(cpu, &assoc, 1);
@@ -835,8 +858,7 @@ static int set_xc_reg(const CPUState *cpu, uint64_t xcr0)
     return 0;
 }
 
-static int set_cpu_state(const CPUState *cpu, const MshvFPU *fpu_regs,
-                         uint64_t xcr0)
+static int set_cpu_state(const CPUState *cpu)
 {
     int ret;
 
@@ -848,11 +870,11 @@ static int set_cpu_state(const CPUState *cpu, const MshvFPU *fpu_regs,
     if (ret < 0) {
         return ret;
     }
-    ret = set_fpu(cpu, fpu_regs);
+    ret = set_fpu(cpu);
     if (ret < 0) {
         return ret;
     }
-    ret = set_xc_reg(cpu, xcr0);
+    ret = set_xc_reg(cpu);
     if (ret < 0) {
         return ret;
     }
@@ -1001,8 +1023,7 @@ static int setup_msrs(const CPUState *cpu)
  * CPUX86State *env = &x86cpu->env;
  * X86CPUTopoInfo *topo_info = &env->topo_info;
  */
-int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
-                        uint64_t xcr0)
+int mshv_configure_vcpu(const CPUState *cpu)
 {
     int ret;
     int cpu_fd = mshv_vcpufd(cpu);
@@ -1019,7 +1040,7 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
         return -1;
     }
 
-    ret = set_cpu_state(cpu, fpu, xcr0);
+    ret = set_cpu_state(cpu);
     if (ret < 0) {
         error_report("failed to set cpu state");
         return -1;
@@ -1036,14 +1057,9 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
 
 static int put_regs(const CPUState *cpu)
 {
-    X86CPU *x86cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86cpu->env;
-    MshvFPU fpu = {0};
     int ret;
 
-    memset(&fpu, 0, sizeof(fpu));
-
-    ret = mshv_configure_vcpu(cpu, &fpu, env->xcr0);
+    ret = mshv_configure_vcpu(cpu);
     if (ret < 0) {
         error_report("failed to configure vcpu");
         return ret;
-- 
2.54.0


