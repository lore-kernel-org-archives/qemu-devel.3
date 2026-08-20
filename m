Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44333C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yn-0004LY-FP; Thu, 20 Aug 2026 12:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yg-0004Gb-F2
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yc-0005UL-M3
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JueMryf3s0Y3RsXpb349HwSludY1hIutej/j0MLEyJw=;
 b=KSnQb8cGZd2PD8yFX/ahxj5HgL19HO7zgkdq1EIpNDha13fY1R1fQR/13v+qDSJXTCiXOS
 6mzvJjKrprsvo+7+5tY9CsfsDGdT9I32x475Z+KJthsLIA8rE5o270sXCQm47mIOCa72kJ
 Jnq5bOxrYMqKx+iqnxnPOZgyAKYb/FM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-bCMORHg1MYi_ifqvKYiOFQ-1; Thu, 20 Aug 2026 12:50:47 -0400
X-MC-Unique: bCMORHg1MYi_ifqvKYiOFQ-1
X-Mimecast-MFC-AGG-ID: bCMORHg1MYi_ifqvKYiOFQ_1787244646
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-496b61bd846so171405e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244646; x=1787849446; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JueMryf3s0Y3RsXpb349HwSludY1hIutej/j0MLEyJw=;
 b=uDdPdiwhtWwm7pSpm+36v12s+gpJMT6PUMIKQeeI1oUEhAokElC5BCh9yK/kVMOSfW
 vDBXAFW3jYclkM7hHMcKgWoXfsWZSQHMov96F64f9MYodXZWzkZTbyADkQ4iXlBzYpEs
 YDaM53qXDFU82ZeZnLFFiSCOvlrsBBqcW9VpSaFioSRsryZ7j8lrjm7n0Hikvfj093gx
 F7NB+/NrEqwbTG6jmpCUpPZaHt+IcUwIv7uGYYLq9oqDy1irCuOoja4j+c5kopQrniVA
 hquAzpNOetCXVuEEDRM6nzmS4/vGgMYgjBSYWoW5UnhQqKyRNsPhOq45s0CI6nGB7y+r
 esOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244646; x=1787849446;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JueMryf3s0Y3RsXpb349HwSludY1hIutej/j0MLEyJw=;
 b=Q9Mr3nuwKwdJ1HfoLh4mfUPlKqZpoLvnN18eR/5fyyTHRSsaX8X4SzxZiNM+PMnYGi
 Ya8CB7G1JobEAWdq02M4aZBNJcZa27q5R2BkLCqUaZaBhJG2y6vvI5/SZeXCl9ZEQyqY
 YyzrepnvlrVRhQagudUf7bPG4IdCDxVfovSkvJ6Y9WngLF0M8+kAAryQ1agImRF5IE70
 ovkZApTuj1bAnxmOR0Ti5LTcBWkFWjwgBSVeo9OPPT28p1dgAv7rB50R/XXm9QE3FrzM
 d+nq9sDncBp2nbRH4h7BzUh0p4ucwjfp/sF4jHyZcD7xxgoSYEGt+c6CehIBo5uC88Hx
 qaBA==
X-Gm-Message-State: AOJu0Yz2vcGvaRG8X1Dr2u0HIzQWBf9ILJnwl7KqBRPt2OrD3m4/7T0Z
 h57Mdd96cJgKP5dUoBFwOvIjmbRAcTeB5Faensy7ui6KhziUcboDQinrX5VDxD1jwDT5C95OqBh
 vgCvMGTOdUF/HBUYUvDrXKDZK/kLpWbF5ai3Ko7M6OXHyhao0lLVjtT77XLNEbQIMSXK9ZySAUF
 9UyuquAvjlRPjezeB2/MilwZIExWWofkMIK67vBu48
X-Gm-Gg: AR+sD12DK1SmuYtyYaEuuF6R4kvcFNHPNqH73SYSO1FDu1pw8bgy0k7uruDZA2+LAAh
 ZGpJIhBQPCjK4ufzxcZK8ccDTW748VHm2sU7tn81nutE75DIi27uTqM9xolq2MI+GuCRF096utg
 HKwRyRTV4YUJxZOefIpM4ERSkYaFL/c3NBnRyD7abczs8udA27p0/hkW+KSo9xFmYhtAnA9cfTD
 xxMti+1VZ9BuX5V4zfL2+uPqJ5mMxE4HCtmme1qVUYTncr1+dUOxJ3a83LuA5IVSq9hNGwnw7X7
 pcQIN6RQmDVM8FucYpDpcB/q/HY61WcDKfS7lqWHPLKE7dOPeDpJPx8KOe6jxElYW+1zYEJVgBj
 NLTv7fjj8FIVc/73fNSzYts+MK4pHL+N9aMWlBVn+jS66rMHl6LgxyrnUTYg4eL2y8/n3Nnizfu
 Nas/o=
X-Received: by 2002:a05:600c:c172:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-499b8464e46mr3571765e9.12.1787244646290; 
 Thu, 20 Aug 2026 09:50:46 -0700 (PDT)
X-Received: by 2002:a05:600c:c172:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-499b8464e46mr3570475e9.12.1787244645846; 
 Thu, 20 Aug 2026 09:50:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0e473dsm146006515e9.15.2026.08.20.09.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 15/53] target/i386/mshv: migrate SIMP and SIEFP state
Date: Thu, 20 Aug 2026 18:49:18 +0200
Message-ID: <20260820164957.1895963-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This part SynIC state is retrieved from the hypervisor via aligned state
pages:

- Add new synic source file
- Centralize the synic_enabled() check
- r/w pages from the hyper via aligned pages
- only handle pages when synic is enabled
- add buffers for migration to VM state

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260710101534.664604-8-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h    |   7 ++
 target/i386/cpu.h            |   5 ++
 target/i386/machine.c        |  26 ++++++
 target/i386/mshv/mshv-cpu.c  |  64 +++++++++++++++
 target/i386/mshv/msr.c       |   7 +-
 target/i386/mshv/synic.c     | 155 +++++++++++++++++++++++++++++++++++
 target/i386/mshv/meson.build |   1 +
 7 files changed, 260 insertions(+), 5 deletions(-)
 create mode 100644 target/i386/mshv/synic.c

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index c2f13c01947..bc023d35355 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -138,4 +138,11 @@ int mshv_init_msrs(const CPUState *cpu);
 int mshv_get_msrs(CPUState *cpu);
 int mshv_set_msrs(const CPUState *cpu);
 
+/* synic */
+int mshv_get_simp(int cpu_fd, uint8_t *page);
+int mshv_set_simp(int cpu_fd, const uint8_t *page);
+int mshv_get_siefp(int cpu_fd, uint8_t *page);
+int mshv_set_siefp(int cpu_fd, const uint8_t *page);
+bool mshv_synic_enabled(const CPUState *cpu);
+
 #endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fff701c6c42..fcde8956008 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -33,6 +33,7 @@
 #include "qemu/cpu-float.h"
 #include "qemu/timer.h"
 #include "standard-headers/asm-x86/kvm_para.h"
+#include "hw/hyperv/hvgdk_mini.h"
 
 #define XEN_NR_VIRQS 24
 
@@ -2301,6 +2302,10 @@ typedef struct CPUArchState {
 #if defined(CONFIG_HVF) || defined(CONFIG_MSHV) || defined(CONFIG_WHPX)
     void *emu_mmio_buf;
 #endif
+#if defined(CONFIG_MSHV)
+    uint8_t hv_simp_page[HV_HYP_PAGE_SIZE];
+    uint8_t hv_siefp_page[HV_HYP_PAGE_SIZE];
+#endif
 
     uint64_t mcg_cap;
     uint64_t mcg_ctl;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index df0e0c178e4..023a397ab89 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -951,6 +951,29 @@ static const VMStateDescription vmstate_msr_hyperv_reenlightenment = {
     }
 };
 
+#ifdef CONFIG_MSHV
+static bool mshv_synic_vp_state_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    /* Only migrate SIMP/SIEFP if SynIC is enabled */
+    return env->msr_hv_synic_control & 1;
+}
+
+static const VMStateDescription vmstate_mshv_synic_vp_state = {
+    .name = "cpu/mshv_synic_vp_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mshv_synic_vp_state_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BUFFER(env.hv_simp_page, X86CPU),
+        VMSTATE_BUFFER(env.hv_siefp_page, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+#endif
+
 static bool avx512_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -1915,6 +1938,9 @@ const VMStateDescription vmstate_x86_cpu = {
         &vmstate_cet,
 #ifdef TARGET_X86_64
         &vmstate_apx,
+#endif
+#ifdef CONFIG_MSHV
+        &vmstate_mshv_synic_vp_state,
 #endif
         NULL
     }
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 00e948903d9..ea6a660d054 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -111,6 +111,33 @@ static enum hv_register_name FPU_REGISTER_NAMES[26] = {
 
 static int set_special_regs(const CPUState *cpu);
 
+static int get_synic_state(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
+
+    /* SIMP/SIEFP can only be read when SynIC is enabled */
+    if (!mshv_synic_enabled(cpu)) {
+        return 0;
+    }
+
+    ret = mshv_get_simp(cpu_fd, env->hv_simp_page);
+    if (ret < 0) {
+        error_report("failed to get simp state");
+        return -1;
+    }
+
+    ret = mshv_get_siefp(cpu_fd, env->hv_siefp_page);
+    if (ret < 0) {
+        error_report("failed to get siefp state");
+        return -1;
+    }
+
+    return 0;
+}
+
 static int get_xsave_state(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
@@ -969,6 +996,11 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    ret = get_synic_state(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     ret = get_vcpu_events(cpu);
     if (ret < 0) {
         return ret;
@@ -1381,6 +1413,33 @@ static int set_xc_reg(const CPUState *cpu)
     return 0;
 }
 
+static int set_synic_state(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
+
+    /* SIMP/SIEFP can only be written when SynIC is enabled */
+    if (!mshv_synic_enabled(cpu)) {
+        return 0;
+    }
+
+    ret = mshv_set_simp(cpu_fd, env->hv_simp_page);
+    if (ret < 0) {
+        error_report("failed to set simp state");
+        return -1;
+    }
+
+    ret = mshv_set_siefp(cpu_fd, env->hv_siefp_page);
+    if (ret < 0) {
+        error_report("failed to set siefp state");
+        return -1;
+    }
+
+    return 0;
+}
+
 int mshv_arch_store_vcpu_state(const CPUState *cpu)
 {
     int ret;
@@ -1422,6 +1481,11 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
+    ret = set_synic_state(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     ret = set_vcpu_events(cpu);
     if (ret < 0) {
         return ret;
diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index 5288e32b6da..d3788d7715d 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -332,7 +332,6 @@ int mshv_get_msrs(CPUState *cpu)
     size_t i, j;
     uint32_t name;
     X86CPU *x86cpu = X86_CPU(cpu);
-    bool synic_enabled;
 
     set_hv_name_in_assocs(assocs, n_assocs);
 
@@ -360,8 +359,7 @@ int mshv_get_msrs(CPUState *cpu)
     store_in_env(cpu, assocs, n_assocs);
 
     /* Read SINT MSRs only if SynIC is enabled */
-    synic_enabled = x86cpu->env.msr_hv_synic_control & 1;
-    if (synic_enabled) {
+    if (mshv_synic_enabled(cpu)) {
         QEMU_BUILD_BUG_ON(MSHV_MSR_TOTAL_COUNT < HV_SINT_COUNT);
 
         for (i = 0; i < HV_SINT_COUNT; i++) {
@@ -415,7 +413,6 @@ int mshv_set_msrs(const CPUState *cpu)
     int ret;
     size_t i, j;
     X86CPU *x86cpu = X86_CPU(cpu);
-    bool synic_enabled = x86cpu->env.msr_hv_synic_control & 1;
 
     load_from_env(cpu, assocs, n_assocs);
 
@@ -449,7 +446,7 @@ int mshv_set_msrs(const CPUState *cpu)
     }
 
     /* SINT MSRs can only be written if SCONTROL has been set, so we split */
-    if (synic_enabled) {
+    if (mshv_synic_enabled(cpu)) {
         QEMU_BUILD_BUG_ON(MSHV_MSR_TOTAL_COUNT < HV_SINT_COUNT);
 
         for (i = 0; i < HV_SINT_COUNT; i++) {
diff --git a/target/i386/mshv/synic.c b/target/i386/mshv/synic.c
new file mode 100644
index 00000000000..8f9fee6ed7e
--- /dev/null
+++ b/target/i386/mshv/synic.c
@@ -0,0 +1,155 @@
+/*
+ * QEMU MSHV SynIC support
+ *
+ * Copyright Microsoft, Corp. 2026
+ *
+ * Authors: Magnus Kulke  <magnuskulke@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/memalign.h"
+#include "qemu/error-report.h"
+
+#include "system/mshv.h"
+#include "system/mshv_int.h"
+
+#include "linux/mshv.h"
+#include "hw/hyperv/hvgdk_mini.h"
+#include "cpu.h"
+
+#include <sys/ioctl.h>
+
+bool mshv_synic_enabled(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+
+    return x86cpu->env.msr_hv_synic_control & 1;
+}
+
+static int get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
+{
+    int ret;
+
+    ret = ioctl(cpu_fd, MSHV_GET_VP_STATE, state);
+    if (ret < 0) {
+        error_report("failed to get vp state: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state)
+{
+    int ret;
+
+    ret = ioctl(cpu_fd, MSHV_SET_VP_STATE, state);
+    if (ret < 0) {
+        error_report("failed to set vp state: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+int mshv_get_simp(int cpu_fd, uint8_t *page)
+{
+    int ret;
+    void *buffer;
+    struct mshv_get_set_vp_state args = {0};
+
+    buffer = qemu_memalign(HV_HYP_PAGE_SIZE, HV_HYP_PAGE_SIZE);
+    args.buf_ptr = (uint64_t)buffer;
+    args.buf_sz = HV_HYP_PAGE_SIZE;
+    args.type = MSHV_VP_STATE_SIMP;
+
+    ret = get_vp_state(cpu_fd, &args);
+
+    if (ret < 0) {
+        qemu_vfree(buffer);
+        error_report("failed to get simp");
+        return -1;
+    }
+
+    memcpy(page, buffer, HV_HYP_PAGE_SIZE);
+    qemu_vfree(buffer);
+
+    return 0;
+}
+
+int mshv_set_simp(int cpu_fd, const uint8_t *page)
+{
+    int ret;
+    void *buffer;
+    struct mshv_get_set_vp_state args = {0};
+
+    buffer = qemu_memalign(HV_HYP_PAGE_SIZE, HV_HYP_PAGE_SIZE);
+    args.buf_ptr = (uint64_t)buffer;
+    args.buf_sz = HV_HYP_PAGE_SIZE;
+    args.type = MSHV_VP_STATE_SIMP;
+
+    assert(page);
+    memcpy(buffer, page, HV_HYP_PAGE_SIZE);
+
+    ret = set_vp_state(cpu_fd, &args);
+    qemu_vfree(buffer);
+
+    if (ret < 0) {
+        error_report("failed to set simp");
+        return -1;
+    }
+
+    return 0;
+}
+
+int mshv_get_siefp(int cpu_fd, uint8_t *page)
+{
+    int ret;
+    void *buffer;
+    struct mshv_get_set_vp_state args = {0};
+
+    buffer = qemu_memalign(HV_HYP_PAGE_SIZE, HV_HYP_PAGE_SIZE);
+    args.buf_ptr = (uint64_t)buffer;
+    args.buf_sz = HV_HYP_PAGE_SIZE;
+    args.type = MSHV_VP_STATE_SIEFP,
+
+    ret = get_vp_state(cpu_fd, &args);
+
+    if (ret < 0) {
+        qemu_vfree(buffer);
+        error_report("failed to get siefp");
+        return -1;
+    }
+
+    memcpy(page, buffer, HV_HYP_PAGE_SIZE);
+    qemu_vfree(buffer);
+
+    return 0;
+}
+
+int mshv_set_siefp(int cpu_fd, const uint8_t *page)
+{
+    int ret;
+    void *buffer;
+    struct mshv_get_set_vp_state args = {0};
+
+    buffer = qemu_memalign(HV_HYP_PAGE_SIZE, HV_HYP_PAGE_SIZE);
+    args.buf_ptr = (uint64_t)buffer;
+    args.buf_sz = HV_HYP_PAGE_SIZE;
+    args.type = MSHV_VP_STATE_SIEFP,
+
+    assert(page);
+    memcpy(buffer, page, HV_HYP_PAGE_SIZE);
+
+    ret = set_vp_state(cpu_fd, &args);
+    qemu_vfree(buffer);
+
+    if (ret < 0) {
+        error_report("failed to set simp");
+        return -1;
+    }
+
+    return 0;
+}
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
index 6091c218874..31ff4cc9950 100644
--- a/target/i386/mshv/meson.build
+++ b/target/i386/mshv/meson.build
@@ -3,6 +3,7 @@ i386_mshv_ss = ss.source_set()
 i386_mshv_ss.add(files(
   'mshv-cpu.c',
   'msr.c',
+  'synic.c',
 ))
 
 i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
-- 
2.55.0


