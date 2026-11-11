Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604DA606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=PXRl/O9n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRF9Q-0001bg-S8; Wed, 11 Nov 2026 15:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xRF9O-0001bJ-SG
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 15:42:35 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xRF9M-0005ww-VY
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 15:42:34 -0500
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id A350720B7169;
 Wed, 11 Nov 2026 12:42:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A350720B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794429748;
 bh=b30rocUZA9hdcsXaaoAC/EZ/DXZST4Kxh/zPSdwuBjQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PXRl/O9nQQuYd79x/bbsjgb/eE5Yeb3Nyhv+LWDGo0kcuMpYwX7qSnb7IPRMoirfs
 yYgSWDCKX69Q30ZwPMzHlGmhg44ui4ne3yVsuGmYqMvVvDLdpXGaEWKHOHgjkHmWLk
 UgOyDxdTvADcxbZG3+8B0yvWIN6/t+/wN7/bG+dI=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 Doru Blanzeanu <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 4/4] target/i386/mshv: add MshvPutState for vcpu writes
Date: Wed, 11 Nov 2026 21:41:55 +0100
Message-Id: <20261111204155.36683-5-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111204155.36683-1-magnuskulke@linux.microsoft.com>
References: <20261111204155.36683-1-magnuskulke@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently QEMU marks a vcpu state as dirty also on merely inspectional
reads, e.g. via "info registers", which triggers a writeback to the
hypervisor. For MSRs that cause a side-effect when written to this is
undesired.

We introduce an MshvPutState flag into the writeback logic to differentiate
"runtime" from "full" and "reset" writebacks that should occur e.g. after
a migration or startup.

Discrete side-effectful MSRs are excluded in runtime writebacks. So far
we only mark one MSR as not runtime-safe, but probably more will be
added eventually.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/mshv/mshv-all.c       | 10 +++++-----
 include/system/mshv_int.h   | 13 +++++++++++--
 target/i386/mshv/mshv-cpu.c | 10 ++++++++--
 target/i386/mshv/msr.c      | 21 ++++++++++++++++++++-
 4 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 5519768cc2..cd5b5d1863 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -764,10 +764,10 @@ static int mshv_cpu_exec(CPUState *cpu)
 
     do {
         if (cpu->vcpu_dirty) {
-            ret = mshv_arch_store_vcpu_state(cpu);
+            ret = mshv_arch_store_vcpu_state(cpu, MSHV_PUT_RUNTIME_STATE);
             if (ret) {
-                error_report("Failed to put registers after init: %s",
-                              strerror(-ret));
+                error_report("Failed to put registers at runtime: %s",
+                             strerror(-ret));
                 ret = -1;
                 break;
             }
@@ -895,7 +895,7 @@ static void mshv_start_vcpu_thread(CPUState *cpu)
 static void do_mshv_cpu_synchronize_post_init(CPUState *cpu,
                                               run_on_cpu_data arg)
 {
-    int ret = mshv_arch_store_vcpu_state(cpu);
+    int ret = mshv_arch_store_vcpu_state(cpu, MSHV_PUT_FULL_STATE);
     if (ret < 0) {
         error_report("Failed to put registers after init: %s", strerror(-ret));
         abort();
@@ -911,7 +911,7 @@ static void mshv_cpu_synchronize_post_init(CPUState *cpu)
 
 static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
 {
-    int ret = mshv_arch_store_vcpu_state(cpu);
+    int ret = mshv_arch_store_vcpu_state(cpu, MSHV_PUT_RESET_STATE);
     if (ret) {
         error_report("Failed to put registers after reset: %s",
                      strerror(-ret));
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 89b44f387a..01da21affe 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -99,6 +99,15 @@ typedef enum MshvVmExit {
     MshvVmExitDebug    = 3,
 } MshvVmExit;
 
+typedef enum MshvPutState {
+    /* state subset only touched by the VCPU itself during runtime */
+    MSHV_PUT_RUNTIME_STATE = 1,
+    /* state subset modified during VCPU reset */
+    MSHV_PUT_RESET_STATE = 2,
+    /* full state set, modified during initialization or on vmload */
+    MSHV_PUT_FULL_STATE = 3,
+} MshvPutState;
+
 void mshv_init_mmio_emu(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
@@ -108,7 +117,7 @@ int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
                           size_t n_regs);
 int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
                           size_t n_regs);
-int mshv_arch_store_vcpu_state(const CPUState *cpu);
+int mshv_arch_store_vcpu_state(const CPUState *cpu, MshvPutState state);
 int mshv_arch_load_vcpu_state(CPUState *cpu);
 int mshv_arch_set_partition_msrs(const CPUState *cpu);
 int mshv_arch_set_mp_state(const CPUState *cpu);
@@ -153,7 +162,7 @@ void mshv_log_global_stop(MemoryListener *listener);
 /* msr */
 int mshv_init_msrs(const CPUState *cpu);
 int mshv_get_msrs(CPUState *cpu);
-int mshv_set_msrs(const CPUState *cpu);
+int mshv_set_msrs(const CPUState *cpu, MshvPutState put_state);
 
 /* synic */
 int mshv_get_simp(int cpu_fd, uint8_t *page);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index e3c155da2e..c145bbc447 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1511,7 +1511,13 @@ static int set_synic_state(const CPUState *cpu)
     return 0;
 }
 
-int mshv_arch_store_vcpu_state(const CPUState *cpu)
+/*
+ * The put_state param is passed to decide whether we need a full restoration
+ * of all registers (e.g. after a migration ) or just a subset during runtime
+ * (e.g after "info registers"). The latter should avoid writing registers that
+ * cause a side-effect.
+ */
+int mshv_arch_store_vcpu_state(const CPUState *cpu, MshvPutState put_state)
 {
     int ret;
 
@@ -1541,7 +1547,7 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
         return ret;
     }
 
-    ret = mshv_set_msrs(cpu);
+    ret = mshv_set_msrs(cpu, put_state);
     if (ret < 0) {
         return ret;
     }
diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index 96bd552916..a06844cc99 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -324,6 +324,20 @@ static bool msr_supported(uint32_t name)
     return true;
 }
 
+static bool msr_is_runtime_safe(uint32_t name)
+{
+    switch (name) {
+    /*
+     * HV_X64_REGISTER_TSC will invalidate the guest's tsc_page if written to
+     * while the guest's timer is not frozen.
+     */
+    case HV_X64_REGISTER_TSC:
+        return false;
+    default:
+        return true;
+    }
+}
+
 int mshv_get_msrs(CPUState *cpu)
 {
     int ret = 0;
@@ -406,13 +420,14 @@ static void load_from_env(const CPUState *cpu, struct hv_register_assoc *assocs,
     load_from_env_mtrr_phys(cpu, &assocs[mtrr_offset], MSHV_MTRR_MSR_COUNT);
 }
 
-int mshv_set_msrs(const CPUState *cpu)
+int mshv_set_msrs(const CPUState *cpu, MshvPutState put_state)
 {
     size_t n_assocs = MSHV_MSR_TOTAL_COUNT;
     struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT] = { 0 };
     int ret;
     size_t i, j;
     X86CPU *x86cpu = X86_CPU(cpu);
+    bool runtime = (put_state <= MSHV_PUT_RUNTIME_STATE);
 
     load_from_env(cpu, assocs, n_assocs);
 
@@ -432,6 +447,10 @@ int mshv_set_msrs(const CPUState *cpu)
             continue;
         }
 
+        if (runtime && !msr_is_runtime_safe(name)) {
+            continue;
+        }
+
         if (j != i) {
             assocs[j] = assocs[i];
         }
-- 
2.34.1


