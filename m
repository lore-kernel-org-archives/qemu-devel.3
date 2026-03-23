Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538DCF46122
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ft1-0005aF-5p; Mon, 23 Mar 2026 10:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4fow-0000av-9n
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:59:56 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4fou-000710-2V
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:59:54 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id A05FF20B6F0C;
 Mon, 23 Mar 2026 06:59:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A05FF20B6F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774274380;
 bh=zOiXzpk6ZsOGpRIWUT9SZ7VhQlMkNvXloKqOzNfhXPM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S4LoVi6GMIfd5aBKX4+RBdvHCOaVeQcDrmNttz1aoQUupOjidR1hg6/U7EOoJQ27h
 YpPAn+Oe0f27T0ScMVgxdD1Wn5eJVkYD7TkW4VGHJeEXqeXJ8ixyMD9GSuof/PtntZ
 Im5RqEcAWKCXw4qN0Ht4tJsKwKr8i5TwtIo9+D90=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 22/32] target/i386/mshv: migrate SIMP and SIEFP state
Date: Mon, 23 Mar 2026 14:58:02 +0100
Message-Id: <20260323135812.383509-23-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This part SynIC state is retrieved from the hypervisor via aligned state
pages:

- Add new synic source file
- Centralize the synic_enabled() check
- r/w pages from the hyper via aligned pages
- only handle pages when synic is enabled
- add buffers for migration to VM state

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/system/mshv_int.h    |   7 ++
 target/i386/cpu.h            |   5 ++
 target/i386/machine.c        |  26 ++++++
 target/i386/mshv/meson.build |   1 +
 target/i386/mshv/mshv-cpu.c  |  64 +++++++++++++++
 target/i386/mshv/msr.c       |   7 +-
 target/i386/mshv/synic.c     | 155 +++++++++++++++++++++++++++++++++++
 7 files changed, 260 insertions(+), 5 deletions(-)
 create mode 100644 target/i386/mshv/synic.c

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 29b363e73e..80df4030c5 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -119,4 +119,11 @@ int mshv_init_msrs(const CPUState *cpu);
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
index 0b539155c4..d010d26146 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -33,6 +33,7 @@
 #include "qemu/cpu-float.h"
 #include "qemu/timer.h"
 #include "standard-headers/asm-x86/kvm_para.h"
+#include "hw/hyperv/hvgdk_mini.h"
 
 #define XEN_NR_VIRQS 24
 
@@ -2291,6 +2292,10 @@ typedef struct CPUArchState {
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
index 48a2a4b319..f94cc544b3 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -952,6 +952,29 @@ static const VMStateDescription vmstate_msr_hyperv_reenlightenment = {
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
@@ -1916,6 +1939,9 @@ const VMStateDescription vmstate_x86_cpu = {
         &vmstate_cet,
 #ifdef TARGET_X86_64
         &vmstate_apx,
+#endif
+#ifdef CONFIG_MSHV
+        &vmstate_mshv_synic_vp_state,
 #endif
         NULL
     }
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
index f44e84688d..a847a6c74c 100644
--- a/target/i386/mshv/meson.build
+++ b/target/i386/mshv/meson.build
@@ -4,6 +4,7 @@ i386_mshv_ss.add(files(
   'mshv-apic.c',
   'mshv-cpu.c',
   'msr.c',
+  'synic.c',
 ))
 
 i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 0d4721582a..49f3f9c090 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -128,6 +128,33 @@ static int get_lapic(CPUState *cpu)
     return 0;
 }
 
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
 static void populate_fpu(const hv_register_assoc *assocs, X86CPU *x86cpu)
 {
     union hv_register_value value;
@@ -585,6 +612,11 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    ret = get_synic_state(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
@@ -1026,6 +1058,33 @@ static int set_lapic(const CPUState *cpu)
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
@@ -1062,6 +1121,11 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
+    ret = set_synic_state(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index d19b79d729..bfae4ed0d8 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -299,7 +299,6 @@ int mshv_get_msrs(CPUState *cpu)
     size_t i, j;
     uint32_t name;
     X86CPU *x86cpu = X86_CPU(cpu);
-    bool synic_enabled;
 
     set_hv_name_in_assocs(assocs, n_assocs);
 
@@ -327,8 +326,7 @@ int mshv_get_msrs(CPUState *cpu)
     store_in_env(cpu, assocs, n_assocs);
 
     /* Read SINT MSRs only if SynIC is enabled */
-    synic_enabled = x86cpu->env.msr_hv_synic_control & 1;
-    if (synic_enabled) {
+    if (mshv_synic_enabled(cpu)) {
         QEMU_BUILD_BUG_ON(MSHV_MSR_TOTAL_COUNT < HV_SINT_COUNT);
 
         for (i = 0; i < HV_SINT_COUNT; i++) {
@@ -382,7 +380,6 @@ int mshv_set_msrs(const CPUState *cpu)
     int ret;
     size_t i, j;
     X86CPU *x86cpu = X86_CPU(cpu);
-    bool synic_enabled = x86cpu->env.msr_hv_synic_control & 1;
 
     load_from_env(cpu, assocs, n_assocs);
 
@@ -416,7 +413,7 @@ int mshv_set_msrs(const CPUState *cpu)
     }
 
     /* SINT MSRs can only be written if SCONTROL has been set, so we split */
-    if (synic_enabled) {
+    if (mshv_synic_enabled(cpu)) {
         QEMU_BUILD_BUG_ON(MSHV_MSR_TOTAL_COUNT < HV_SINT_COUNT);
 
         for (i = 0; i < HV_SINT_COUNT; i++) {
diff --git a/target/i386/mshv/synic.c b/target/i386/mshv/synic.c
new file mode 100644
index 0000000000..8f9fee6ed7
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
-- 
2.34.1


