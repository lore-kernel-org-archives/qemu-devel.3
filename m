Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300BECDE00C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eF-0007af-9V; Fri, 26 Jun 2026 06:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ds-0007O3-S5
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dp-0005Bu-F9
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pYOdt8vPElmwHVGL0UnCvccem7xXYiPrBcnKUVsbS/U=;
 b=U2xXnsdFa7Ok9P/ftCJeRHl+4ybMDdbBh/In7KItYf3Q8hn02GXmpltBI0UCtYeoye2kyx
 wu8IoOzBfY/HPcUVBd+yJf/irIWxxjbuXeZP9YhvEF9c5YVErDWqYsxGX79/jVjrE6+j9S
 5YN5X2Y5foN3YOVmo/xiBjhK8vjriBQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122--vCTcLwEMNSGG26Kvp-iIQ-1; Fri, 26 Jun 2026 06:18:29 -0400
X-MC-Unique: -vCTcLwEMNSGG26Kvp-iIQ-1
X-Mimecast-MFC-AGG-ID: -vCTcLwEMNSGG26Kvp-iIQ_1782469106
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b37e1f48so4955535e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469106; x=1783073906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYOdt8vPElmwHVGL0UnCvccem7xXYiPrBcnKUVsbS/U=;
 b=mnvKbkeqLqAkW5uHA4/BhGkezshNkrNDvvqMrHQIWC7Rbji7wUIcEk182F6FyE1B6z
 Sr6ZMlOPgrF6w06cDplxVDq7ptyb/iWuwKBQalJ0Yi9a9i2YqMw+LkFRGEXbfO2Ve3TB
 adwwwErfxyt/Dhb66WODiznqaHWCHnOi7PvK3Cx21N+CUk4onkdpjNazzsWN2S5AFOp8
 zH0LOI8n68U6AP08FJaIh6ugT0rjMHzT+6cOHmoA88tKUprPCKfiTAfGfbvrcRlAe0Af
 dAriIpjCnRlKtcn0pXPbKk5nQs0fBJLhqBPF/5Ey/cg6GtO8wp9VJKO8nMnHZIwYkSdy
 SnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469106; x=1783073906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pYOdt8vPElmwHVGL0UnCvccem7xXYiPrBcnKUVsbS/U=;
 b=OR10q80NdnpnuNYu8AYpVLx90hm3P5L/mfAyCv5xOSk4xXt4da4uVmKTP4vCuTbRe0
 XGQ5D964EVQFg5HHe3wCUkuvHot6JXGapRTrRFUkp0RjO3pKj4urU1IlqnFRA4/aAG1e
 hPAhwFrmkW2GOly2Y3A4mgKJLRixVpM96mfdXZ5Pxi3hpOCtcnGA7mrTDOkANbN+EyKi
 J5H93K863hAq2E7x83YoCVQC5EsO6/BlcDnhmvEtdR37m6n/bzh7vYBYEiE1d2xAYePW
 a3yEO6KBkkg/m52XzXreIBNyTExjfIFYcOfTJcU5/PMBYY1i+Il/101Hds/DP8sxG4Fr
 D9VQ==
X-Gm-Message-State: AOJu0YySrzd7EE+hEO8HSxwyVmMvnWzbShaVSEIzyY5rLLfseBnU8kVM
 6a0iFW6dX4z+tLaJBD3adsiE85ZVLLZInKbhg1WWqctRVVtqsG7Tltgr4BUeEiphdlu2+cCnImA
 EeNnVHJDRgqgUKmGaSHbSZwLriTuNHljF99bJfJpJ41LEPRhLXaAluU/2h323Y9Bza2MvIpPBAi
 wzV6s+bGuEewD/P3KwDRlz6dZT0XylNds+ktc1B/kk
X-Gm-Gg: AfdE7cmSAdbhdWQyiIkyi+vzBmP4QeMQ46DETkiDmTtbV4WCzIDTaYY2TZhksr3FWPq
 O3rEK/r7o89f+7JFsTiyklgoeCxQpNvy2qesxrdZT8hnYKbkUGkM6z0JAAV2267KegitfxlUCZN
 GylIL5k0y6tNecG70H9QjYi4wJG/JYc+JHKr8eqwVyqsV/VGrvT/KFh2woD5277R56OV3tW4j8w
 Z1dMxXkQZbdKakO2rQGjhWEu8ZpQ1HRnbTKyc8OoPTTjKZqn/v7nhQKkQbcb/7R6qFDtDsBGlq0
 Zqed9p2gkRAoatzjkPDbjqzM9fnnUo+hX9EvfylpHe0dizTpD+0i+M8KKaY0DRL0rIOqwnHWubN
 XYWpxYCUU9+PHD+4aCN+ZhFzuCjxLzxAOGcVgX1nFovDLdcD3scSSiTQLBfSgevVDrYhTZliqyY
 seMJgTDH3TZ/CXeqxs
X-Received: by 2002:a05:600c:4689:b0:492:6f9b:572e with SMTP id
 5b1f17b1804b1-4926f9b5780mr3603365e9.37.1782469105881; 
 Fri, 26 Jun 2026 03:18:25 -0700 (PDT)
X-Received: by 2002:a05:600c:4689:b0:492:6f9b:572e with SMTP id
 5b1f17b1804b1-4926f9b5780mr3602025e9.37.1782469104455; 
 Fri, 26 Jun 2026 03:18:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49269002511sm66840155e9.8.2026.06.26.03.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 12/45] target/i386/mshv: impl init/load/store_vcpu_state
Date: Fri, 26 Jun 2026 12:17:15 +0200
Message-ID: <20260626101748.1728079-13-pbonzini@redhat.com>
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

In migration we will handle more than registers, so we rework the
routines that were used to load & store CPU registers from/to the
hypervisor into more explicit init/load/store_vcpu_state() functions
that can be called from the appropriate hooks.

load/store_regs() still exists for the purpose of MMIO emulation, but it
will only address standard and special x86 registers.

Functions to retrieve FPU and XCR0 state from the hypervsisor have been
introduced.

MSR and APIC state covered are covered only as part of init_vcpu(). They
are not yet part of the load/store routines.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-4-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |   5 +-
 accel/mshv/mshv-all.c       |  10 +-
 target/i386/mshv/mshv-cpu.c | 360 ++++++++++++++++++------------------
 3 files changed, 188 insertions(+), 187 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index bb7f6740bba..1d9902c9bbe 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -70,11 +70,10 @@ int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
 int mshv_configure_vcpu(const CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
-int mshv_arch_load_regs(CPUState *cpu);
-int mshv_arch_store_regs(CPUState *cpu);
 int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs);
-int mshv_arch_put_registers(const CPUState *cpu);
+int mshv_arch_store_vcpu_state(const CPUState *cpu);
+int mshv_arch_load_vcpu_state(CPUState *cpu);
 void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index ec9c90cddda..a6263effa41 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -479,13 +479,13 @@ static int mshv_init_vcpu(CPUState *cpu)
     int ret;
 
     cpu->accel = g_new0(AccelCPUState, 1);
-    mshv_arch_init_vcpu(cpu);
 
     ret = mshv_create_vcpu(vm_fd, vp_index, &cpu->accel->cpufd);
     if (ret < 0) {
         return -1;
     }
 
+    mshv_arch_init_vcpu(cpu);
     cpu->accel->dirty = true;
 
     return 0;
@@ -567,7 +567,7 @@ static int mshv_cpu_exec(CPUState *cpu)
 
     do {
         if (cpu->accel->dirty) {
-            ret = mshv_arch_put_registers(cpu);
+            ret = mshv_arch_store_vcpu_state(cpu);
             if (ret) {
                 error_report("Failed to put registers after init: %s",
                               strerror(-ret));
@@ -689,7 +689,7 @@ static void mshv_start_vcpu_thread(CPUState *cpu)
 static void do_mshv_cpu_synchronize_post_init(CPUState *cpu,
                                               run_on_cpu_data arg)
 {
-    int ret = mshv_arch_put_registers(cpu);
+    int ret = mshv_arch_store_vcpu_state(cpu);
     if (ret < 0) {
         error_report("Failed to put registers after init: %s", strerror(-ret));
         abort();
@@ -705,7 +705,7 @@ static void mshv_cpu_synchronize_post_init(CPUState *cpu)
 
 static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
 {
-    int ret = mshv_arch_put_registers(cpu);
+    int ret = mshv_arch_store_vcpu_state(cpu);
     if (ret) {
         error_report("Failed to put registers after reset: %s",
                      strerror(-ret));
@@ -729,7 +729,7 @@ static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
 static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->accel->dirty) {
-        int ret = mshv_arch_load_regs(cpu);
+        int ret = mshv_arch_load_vcpu_state(cpu);
         if (ret < 0) {
             error_report("Failed to load registers for vcpu %d",
                          cpu->cpu_index);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index b5c0c504cb1..e3f163ef630 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -115,6 +115,92 @@ static int get_generic_regs(CPUState *cpu,
                             struct hv_register_assoc *assocs,
                             size_t n_regs);
 
+static void populate_fpu(const hv_register_assoc *assocs, X86CPU *x86cpu)
+{
+    union hv_register_value value;
+    const union hv_x64_fp_control_status_register *ctrl_status;
+    const union hv_x64_xmm_control_status_register *xmm_ctrl;
+    CPUX86State *env = &x86cpu->env;
+    size_t i, fp_i;
+    bool valid;
+
+    /* first 16 registers are xmm0-xmm15 */
+    for (i = 0; i < 16; i++) {
+        value = assocs[i].value;
+        env->xmm_regs[i].ZMM_Q(0) = value.reg128.low_part;
+        env->xmm_regs[i].ZMM_Q(1) = value.reg128.high_part;
+    }
+
+    /* next 8 registers are fp_mmx0-fp_mmx7 */
+    for (i = 16; i < 24; i++) {
+        fp_i = i - 16;
+        value = assocs[i].value;
+        env->fpregs[fp_i].d.low = value.fp.mantissa;
+        env->fpregs[fp_i].d.high = (value.fp.sign << 15)
+                                 | (value.fp.biased_exponent & 0x7FFF);
+    }
+
+    /* last two registers are fp_control_status and xmm_control_status */
+    ctrl_status = &assocs[24].value.fp_control_status;
+    env->fpuc = ctrl_status->fp_control;
+
+    env->fpus = ctrl_status->fp_status & ~0x3800;
+    /* bits 11,12,13 are the top of stack pointer */
+    env->fpstt = (ctrl_status->fp_status >> 11) & 0x7;
+
+    for (i = 0; i < 8; i++) {
+        valid = ctrl_status->fp_tag & (1 << i);
+        env->fptags[i] = valid ? 0 : 1;
+    }
+
+    env->fpop = ctrl_status->last_fp_op;
+    env->fpip = ctrl_status->last_fp_rip;
+
+    xmm_ctrl = &assocs[25].value.xmm_control_status;
+    env->mxcsr = xmm_ctrl->xmm_status_control;
+    env->fpdp = xmm_ctrl->last_fp_rdp;
+}
+
+static int get_fpu(CPUState *cpu)
+{
+    struct hv_register_assoc assocs[ARRAY_SIZE(FPU_REGISTER_NAMES)];
+    int ret;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    size_t n_regs = ARRAY_SIZE(FPU_REGISTER_NAMES);
+
+    for (size_t i = 0; i < n_regs; i++) {
+        assocs[i].name = FPU_REGISTER_NAMES[i];
+    }
+    ret = get_generic_regs(cpu, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to get special registers");
+        return -errno;
+    }
+
+    populate_fpu(assocs, x86cpu);
+
+    return 0;
+}
+
+static int get_xc_reg(CPUState *cpu)
+{
+    int ret;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    struct hv_register_assoc assocs[1];
+
+    assocs[0].name = HV_X64_REGISTER_XFEM;
+
+    ret = get_generic_regs(cpu, assocs, 1);
+    if (ret < 0) {
+        error_report("failed to get xcr0");
+        return -1;
+    }
+    env->xcr0 = assocs[0].value.reg64;
+
+    return 0;
+}
+
 static int translate_gva(const CPUState *cpu, uint64_t gva, uint64_t *gpa,
                          uint64_t flags)
 {
@@ -293,7 +379,7 @@ static int set_standard_regs(const CPUState *cpu)
     return 0;
 }
 
-int mshv_arch_store_regs(CPUState *cpu)
+static int store_regs(CPUState *cpu)
 {
     int ret;
 
@@ -435,20 +521,45 @@ static int get_special_regs(CPUState *cpu)
     return 0;
 }
 
-int mshv_arch_load_regs(CPUState *cpu)
+static int load_regs(CPUState *cpu)
 {
     int ret;
 
     ret = get_standard_regs(cpu);
     if (ret < 0) {
-        error_report("Failed to load standard registers");
-        return -1;
+        return ret;
     }
 
     ret = get_special_regs(cpu);
     if (ret < 0) {
-        error_report("Failed to load special registers");
-        return -1;
+        return ret;
+    }
+
+    return 0;
+}
+
+int mshv_arch_load_vcpu_state(CPUState *cpu)
+{
+    int ret;
+
+    ret = get_standard_regs(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = get_special_regs(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = get_xc_reg(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = get_fpu(cpu);
+    if (ret < 0) {
+        return ret;
     }
 
     return 0;
@@ -667,7 +778,7 @@ static int register_intercept_result_cpuid(const CPUState *cpu,
     return ret;
 }
 
-static int set_cpuid2(const CPUState *cpu)
+static int init_cpuid2(const CPUState *cpu)
 {
     int ret;
     size_t n_entries, cpuid_size;
@@ -858,29 +969,6 @@ static int set_xc_reg(const CPUState *cpu)
     return 0;
 }
 
-static int set_cpu_state(const CPUState *cpu)
-{
-    int ret;
-
-    ret = set_standard_regs(cpu);
-    if (ret < 0) {
-        return ret;
-    }
-    ret = set_special_regs(cpu);
-    if (ret < 0) {
-        return ret;
-    }
-    ret = set_fpu(cpu);
-    if (ret < 0) {
-        return ret;
-    }
-    ret = set_xc_reg(cpu);
-    if (ret < 0) {
-        return ret;
-    }
-    return 0;
-}
-
 static int get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
 {
     int ret;
@@ -894,7 +982,7 @@ static int get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
     return 0;
 }
 
-static int get_lapic(int cpu_fd,
+static int get_lapic(const CPUState *cpu,
                      struct hv_local_interrupt_controller_state *state)
 {
     int ret;
@@ -902,6 +990,7 @@ static int get_lapic(int cpu_fd,
     /* buffer aligned to 4k, as *state requires that */
     void *buffer = qemu_memalign(size, size);
     struct mshv_get_set_vp_state mshv_state = { 0 };
+    int cpu_fd = mshv_vcpufd(cpu);
 
     mshv_state.buf_ptr = (uint64_t) buffer;
     mshv_state.buf_sz = size;
@@ -938,7 +1027,7 @@ static int set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state)
     return 0;
 }
 
-static int set_lapic(int cpu_fd,
+static int set_lapic(const CPUState *cpu,
                      const struct hv_local_interrupt_controller_state *state)
 {
     int ret;
@@ -946,6 +1035,7 @@ static int set_lapic(int cpu_fd,
     /* buffer aligned to 4k, as *state requires that */
     void *buffer = qemu_memalign(size, size);
     struct mshv_get_set_vp_state mshv_state = { 0 };
+    int cpu_fd = mshv_vcpufd(cpu);
 
     if (!state) {
         error_report("lapic state is NULL");
@@ -967,13 +1057,13 @@ static int set_lapic(int cpu_fd,
     return 0;
 }
 
-static int set_lint(int cpu_fd)
+static int init_lint(const CPUState *cpu)
 {
     int ret;
     uint32_t *lvt_lint0, *lvt_lint1;
 
     struct hv_local_interrupt_controller_state lapic_state = { 0 };
-    ret = get_lapic(cpu_fd, &lapic_state);
+    ret = get_lapic(cpu, &lapic_state);
     if (ret < 0) {
         return ret;
     }
@@ -986,161 +1076,31 @@ static int set_lint(int cpu_fd)
 
     /* TODO: should we skip setting lapic if the values are the same? */
 
-    return set_lapic(cpu_fd, &lapic_state);
+    return set_lapic(cpu, &lapic_state);
 }
 
-static int setup_msrs(const CPUState *cpu)
-{
-    int ret;
-    uint64_t default_type = MSR_MTRR_ENABLE | MSR_MTRR_MEM_TYPE_WB;
-
-    /* boot msr entries */
-    MshvMsrEntry msrs[9] = {
-        { .index = IA32_MSR_SYSENTER_CS, .data = 0x0, },
-        { .index = IA32_MSR_SYSENTER_ESP, .data = 0x0, },
-        { .index = IA32_MSR_SYSENTER_EIP, .data = 0x0, },
-        { .index = IA32_MSR_STAR, .data = 0x0, },
-        { .index = IA32_MSR_CSTAR, .data = 0x0, },
-        { .index = IA32_MSR_LSTAR, .data = 0x0, },
-        { .index = IA32_MSR_KERNEL_GS_BASE, .data = 0x0, },
-        { .index = IA32_MSR_SFMASK, .data = 0x0, },
-        { .index = IA32_MSR_MTRR_DEF_TYPE, .data = default_type, },
-    };
-
-    ret = mshv_configure_msr(cpu, msrs, 9);
-    if (ret < 0) {
-        error_report("failed to setup msrs");
-        return -1;
-    }
-
-    return 0;
-}
-
-/*
- * TODO: populate topology info:
- *
- * X86CPU *x86cpu = X86_CPU(cpu);
- * CPUX86State *env = &x86cpu->env;
- * X86CPUTopoInfo *topo_info = &env->topo_info;
- */
-int mshv_configure_vcpu(const CPUState *cpu)
-{
-    int ret;
-    int cpu_fd = mshv_vcpufd(cpu);
-
-    ret = set_cpuid2(cpu);
-    if (ret < 0) {
-        error_report("failed to set cpuid");
-        return -1;
-    }
-
-    ret = setup_msrs(cpu);
-    if (ret < 0) {
-        error_report("failed to setup msrs");
-        return -1;
-    }
-
-    ret = set_cpu_state(cpu);
-    if (ret < 0) {
-        error_report("failed to set cpu state");
-        return -1;
-    }
-
-    ret = set_lint(cpu_fd);
-    if (ret < 0) {
-        error_report("failed to set lpic int");
-        return -1;
-    }
-
-    return 0;
-}
-
-static int put_regs(const CPUState *cpu)
+int mshv_arch_store_vcpu_state(const CPUState *cpu)
 {
     int ret;
 
-    ret = mshv_configure_vcpu(cpu);
+    ret = set_standard_regs(cpu);
     if (ret < 0) {
-        error_report("failed to configure vcpu");
         return ret;
     }
 
-    return 0;
-}
-
-struct MsrPair {
-    uint32_t index;
-    uint64_t value;
-};
-
-static int put_msrs(const CPUState *cpu)
-{
-    int ret = 0;
-    X86CPU *x86cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86cpu->env;
-    MshvMsrEntries *msrs = g_malloc0(sizeof(MshvMsrEntries));
-
-    struct MsrPair pairs[] = {
-        { MSR_IA32_SYSENTER_CS,    env->sysenter_cs },
-        { MSR_IA32_SYSENTER_ESP,   env->sysenter_esp },
-        { MSR_IA32_SYSENTER_EIP,   env->sysenter_eip },
-        { MSR_EFER,                env->efer },
-        { MSR_PAT,                 env->pat },
-        { MSR_STAR,                env->star },
-        { MSR_CSTAR,               env->cstar },
-        { MSR_LSTAR,               env->lstar },
-        { MSR_KERNELGSBASE,        env->kernelgsbase },
-        { MSR_FMASK,               env->fmask },
-        { MSR_MTRRdefType,         env->mtrr_deftype },
-        { MSR_VM_HSAVE_PA,         env->vm_hsave },
-        { MSR_SMI_COUNT,           env->msr_smi_count },
-        { MSR_IA32_PKRS,           env->pkrs },
-        { MSR_IA32_BNDCFGS,        env->msr_bndcfgs },
-        { MSR_IA32_XSS,            env->xss },
-        { MSR_IA32_UMWAIT_CONTROL, env->umwait },
-        { MSR_IA32_TSX_CTRL,       env->tsx_ctrl },
-        { MSR_AMD64_TSC_RATIO,     env->amd_tsc_scale_msr },
-        { MSR_TSC_AUX,             env->tsc_aux },
-        { MSR_TSC_ADJUST,          env->tsc_adjust },
-        { MSR_IA32_SMBASE,         env->smbase },
-        { MSR_IA32_SPEC_CTRL,      env->spec_ctrl },
-        { MSR_VIRT_SSBD,           env->virt_ssbd },
-    };
-
-    if (ARRAY_SIZE(pairs) > MSHV_MSR_ENTRIES_COUNT) {
-        error_report("MSR entries exceed maximum size");
-        g_free(msrs);
-        return -1;
-    }
-
-    for (size_t i = 0; i < ARRAY_SIZE(pairs); i++) {
-        MshvMsrEntry *entry = &msrs->entries[i];
-        entry->index = pairs[i].index;
-        entry->reserved = 0;
-        entry->data = pairs[i].value;
-        msrs->nmsrs++;
-    }
-
-    ret = mshv_configure_msr(cpu, &msrs->entries[0], msrs->nmsrs);
-    g_free(msrs);
-    return ret;
-}
-
-
-int mshv_arch_put_registers(const CPUState *cpu)
-{
-    int ret;
-
-    ret = put_regs(cpu);
+    ret = set_special_regs(cpu);
     if (ret < 0) {
-        error_report("Failed to put registers");
-        return -1;
+        return ret;
     }
 
-    ret = put_msrs(cpu);
+    ret = set_xc_reg(cpu);
     if (ret < 0) {
-        error_report("Failed to put msrs");
-        return -1;
+        return ret;
+    }
+
+    ret = set_fpu(cpu);
+    if (ret < 0) {
+        return ret;
     }
 
     return 0;
@@ -1182,7 +1142,7 @@ static int emulate_instruction(CPUState *cpu,
     int ret;
     x86_insn_stream stream = { .bytes = insn_bytes, .len = insn_len };
 
-    ret = mshv_arch_load_regs(cpu);
+    ret = load_regs(cpu);
     if (ret < 0) {
         error_report("Failed to load registers");
         return -1;
@@ -1191,7 +1151,7 @@ static int emulate_instruction(CPUState *cpu,
     decode_instruction_stream(env, &decode, &stream);
     exec_instruction(env, &decode);
 
-    ret = mshv_arch_store_regs(cpu);
+    ret = store_regs(cpu);
     if (ret < 0) {
         error_report("failed to store registers");
         return -1;
@@ -1489,7 +1449,7 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
 
-    ret = mshv_arch_load_regs(cpu);
+    ret = load_regs(cpu);
     if (ret < 0) {
         error_report("Failed to load registers");
         return -1;
@@ -1660,6 +1620,33 @@ void mshv_init_mmio_emu(void)
     init_emu(&mshv_x86_emul_ops);
 }
 
+static int init_msrs(const CPUState *cpu)
+{
+    int ret;
+    uint64_t d_t = MSR_MTRR_ENABLE | MSR_MTRR_MEM_TYPE_WB;
+
+    const struct hv_register_assoc assocs[] = {
+        { .name = HV_X64_REGISTER_SYSENTER_CS,       .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_SYSENTER_ESP,      .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_SYSENTER_EIP,      .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_STAR,              .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_CSTAR,             .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_LSTAR,             .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_KERNEL_GS_BASE,    .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_SFMASK,            .value.reg64 = 0x0 },
+        { .name = HV_X64_REGISTER_MSR_MTRR_DEF_TYPE, .value.reg64 = d_t },
+    };
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(assocs) > MSHV_MSR_ENTRIES_COUNT);
+
+    ret = mshv_set_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
+    if (ret < 0) {
+        error_report("failed to put msrs");
+        return -1;
+    }
+
+    return 0;
+}
+
 void mshv_arch_init_vcpu(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -1667,6 +1654,7 @@ void mshv_arch_init_vcpu(CPUState *cpu)
     AccelCPUState *state = cpu->accel;
     size_t page = HV_HYP_PAGE_SIZE;
     void *mem = qemu_memalign(page, 2 * page);
+    int ret;
 
     /* sanity check, to make sure we don't overflow the page */
     QEMU_BUILD_BUG_ON((MAX_REGISTER_COUNT
@@ -1679,6 +1667,20 @@ void mshv_arch_init_vcpu(CPUState *cpu)
     state->hvcall_args.output_page = (uint8_t *)mem + page;
 
     env->emu_mmio_buf = g_new(char, 4096);
+
+    /*
+     * TODO: populate topology info:
+     * X86CPUTopoInfo *topo_info = &env->topo_info;
+     */
+
+    ret = init_cpuid2(cpu);
+    assert(ret == 0);
+
+    ret = init_msrs(cpu);
+    assert(ret == 0);
+
+    ret = init_lint(cpu);
+    assert(ret == 0);
 }
 
 void mshv_arch_destroy_vcpu(CPUState *cpu)
-- 
2.54.0


