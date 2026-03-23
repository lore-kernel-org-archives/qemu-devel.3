Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEDFF46122
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fsJ-0004Ef-MZ; Mon, 23 Mar 2026 10:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4fpP-0000vR-4W
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:00:27 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4fpK-0007IE-8R
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:00:20 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 7EACB20B6F20;
 Mon, 23 Mar 2026 07:00:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7EACB20B6F20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774274406;
 bh=WL7aGhrD9h47rdLHpTc412OkLiLisXW3EZzyJTLGXtA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GBWvBSQvLoC3WBwWC0h45O+c/bU66/wvFs3nCeH9dOBaDh3MrqJbaMB0d/3twYolp
 qvvOrQRf4mxkubIxtdNXWQ89nWGQeQiEHfiBjm2tSgorfRLojL4M5nu+I0Yb4MmhCA
 QpG9cl4yELEpjCTar2KL9Xfg8mHIvHV2pMlhckrQ=
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
Subject: [RFC 29/32] target/i386/mshv: migrate XSAVE state
Date: Mon, 23 Mar 2026 14:58:09 +0100
Message-Id: <20260323135812.383509-30-magnuskulke@linux.microsoft.com>
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

We implement fn's that roundtrip XSAVE state in migration. We are using
the xsave_helper routines to move individual components from CPUX86State
to an xsave_buf and then we have to compact the buffer to XSAVEC format,
which is what the hypervisor expects.

And the same applies in the other direction for restoring state from the
hypervisor.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/cpu.h           |   2 +-
 target/i386/mshv/mshv-cpu.c | 100 +++++++++++++++++++++++++++++++++++-
 2 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cd5d5a5369..0f30f0dd5b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2272,7 +2272,7 @@ typedef struct CPUArchState {
     int64_t user_tsc_khz; /* for sanity check only */
     uint64_t apic_bus_freq;
     uint64_t tsc;
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
+#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_MSHV)
     void *xsave_buf;
     uint32_t xsave_buf_len;
 #endif
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 746987d62b..dacc33674c 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -109,6 +109,78 @@ static enum hv_register_name FPU_REGISTER_NAMES[26] = {
 
 static int set_special_regs(const CPUState *cpu);
 
+static int get_xsave_state(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
+    void *xsavec_buf;
+    const size_t page = HV_HYP_PAGE_SIZE;
+    size_t xsavec_buf_len = page;
+
+    /* TODO: should properly determine xsavec size based on CPUID */
+    xsavec_buf = qemu_memalign(page, xsavec_buf_len);
+    memset(xsavec_buf, 0, xsavec_buf_len);
+
+    struct mshv_get_set_vp_state args = {
+        .type = MSHV_VP_STATE_XSAVE,
+        .buf_sz = xsavec_buf_len,
+        .buf_ptr = (uintptr_t)xsavec_buf,
+    };
+
+    ret = ioctl(cpu_fd, MSHV_GET_VP_STATE, &args);
+    if (ret < 0) {
+        error_report("failed to get xsave state: %s", strerror(errno));
+        return -errno;
+    }
+
+    ret = decompact_xsave_area(xsavec_buf, xsavec_buf_len, env);
+    g_free(xsavec_buf);
+    if (ret < 0) {
+        error_report("failed to decompact xsave area");
+        return ret;
+    }
+    x86_cpu_xrstor_all_areas(x86cpu, env->xsave_buf, env->xsave_buf_len);
+
+    return 0;
+}
+
+static int set_xsave_state(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    int cpu_fd = mshv_vcpufd(cpu);
+    int ret;
+    void *xsavec_buf;
+    size_t page = HV_HYP_PAGE_SIZE, xsavec_buf_len;
+
+    /* allocate and populate compacted buffer */
+    xsavec_buf = qemu_memalign(page, page);
+    xsavec_buf_len = page;
+
+    /* save registers to standard format buffer */
+    x86_cpu_xsave_all_areas(x86cpu, env->xsave_buf, env->xsave_buf_len);
+
+    /* store compacted version of xsave area in xsavec_buf */
+    compact_xsave_area(env, xsavec_buf, xsavec_buf_len);
+
+    struct mshv_get_set_vp_state args = {
+        .type = MSHV_VP_STATE_XSAVE,
+        .buf_sz = xsavec_buf_len,
+        .buf_ptr = (uintptr_t)xsavec_buf,
+    };
+
+    ret = ioctl(cpu_fd, MSHV_SET_VP_STATE, &args);
+    g_free(xsavec_buf);
+    if (ret < 0) {
+        error_report("failed to set xsave state: %s", strerror(errno));
+        return -errno;
+    }
+
+    return 0;
+}
+
 static int get_lapic(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
@@ -766,6 +838,11 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    ret = get_xsave_state(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     ret = get_lapic(cpu);
     if (ret < 0) {
         return ret;
@@ -1284,6 +1361,11 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
+    ret = set_xsave_state(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     /* INVARIANT: special regs (APIC_BASE) must be restored before LAPIC */
     ret = set_lapic(cpu);
     if (ret < 0) {
@@ -1812,9 +1894,10 @@ void mshv_arch_init_vcpu(CPUState *cpu)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
     AccelCPUState *state = cpu->accel;
-    size_t page = HV_HYP_PAGE_SIZE;
+    size_t page = HV_HYP_PAGE_SIZE, xsave_len;
     void *mem = qemu_memalign(page, 2 * page);
     int ret;
+    X86XSaveHeader *header;
 
     /* sanity check, to make sure we don't overflow the page */
     QEMU_BUILD_BUG_ON((MAX_REGISTER_COUNT
@@ -1828,6 +1911,17 @@ void mshv_arch_init_vcpu(CPUState *cpu)
 
     env->emu_mmio_buf = g_new(char, 4096);
 
+    /* Initialize XSAVE buffer page-aligned */
+    /* TODO: pick proper size based on CPUID */
+    xsave_len = page;
+    env->xsave_buf = qemu_memalign(page, xsave_len);
+    env->xsave_buf_len = xsave_len;
+    memset(env->xsave_buf, 0, env->xsave_buf_len);
+
+    /* we need to set the compacted format bit in xsave header for mshv */
+    header = (X86XSaveHeader *)(env->xsave_buf + sizeof(X86LegacyXSaveArea));
+    header->xcomp_bv = header->xstate_bv | (1ULL << 63);
+
     /*
      * TODO: populate topology info:
      * X86CPUTopoInfo *topo_info = &env->topo_info;
@@ -1852,6 +1946,10 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
     g_free(state->hvcall_args.base);
     state->hvcall_args = (MshvHvCallArgs){0};
     g_clear_pointer(&env->emu_mmio_buf, g_free);
+
+    qemu_vfree(env->xsave_buf);
+    env->xsave_buf = NULL;
+    env->xsave_buf_len = 0;
 }
 
 /*
-- 
2.34.1


