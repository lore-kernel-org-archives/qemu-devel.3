Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C24C79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3aGU-0004Wj-Bd; Mon, 07 Sep 2026 10:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1x3aGT-0004WW-A9
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:24:05 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1x3aGR-0006Ye-EN
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:24:05 -0400
Received: from laptop.localdomain (unknown [81.196.141.93])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6F58520B712B;
 Mon,  7 Sep 2026 07:23:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F58520B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1788791003;
 bh=J1brsl71IEXD02jTIvt6amMa7SMls9Qs5ZHUMqIyFqM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pvJX2ZR1Np77wT+geR7t5dQDL+qN++dcT94Zfec8yzWS3aPB96GP12mCYxj5R2F1C
 Cny9/BzKPhCsYiiraKl2e5IQzfoUdyySsNEnbOYuK4Z9pN70Qw1Q3zi1peEUDrwt7L
 hSDCblPnrx/YdcICX1N8oTMO7zBdNqH6lHFCALd4=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PATCH 1/2] accel/mshv: size XSAVE buffers from the hypervisor
Date: Mon,  7 Sep 2026 17:23:54 +0300
Message-ID: <20260907142355.141033-2-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907142355.141033-1-dblanzeanu@linux.microsoft.com>
References: <20260907142355.141033-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Query MAX_XSAVE_DATA_SIZE at vcpu creation and cache it in MshvState.
Introduce a new trace event for the xsave area size reported by the
hypervisor.

Also fixes a leak of xsavec_buf on the get error path and switches
qemu_memalign() buffers to qemu_vfree().
No functional change on hosts reporting under 4 KiB.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 accel/mshv/mshv-all.c       | 21 +++++++++++++++++++++
 accel/mshv/trace-events     |  2 ++
 include/system/mshv_int.h   |  3 +++
 target/i386/mshv/mshv-cpu.c | 34 +++++++++++++++++++++++++---------
 4 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 5921ce693e..725ccd0511 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -162,6 +162,27 @@ static int get_proc_features(int vm_fd,
     return 0;
 }
 
+int mshv_get_max_xsave_size(int vm_fd, uint32_t *size)
+{
+    uint64_t value = 0;
+    int ret;
+
+    ret = get_partition_property(vm_fd,
+                                 HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE,
+                                 &value);
+    if (ret < 0) {
+        error_report("Failed to get partition property MAX_XSAVE_DATA_SIZE");
+        return -1;
+    }
+
+    /* round up to page size */
+    *size = ROUND_UP(value, HV_HYP_PAGE_SIZE);
+
+    trace_mshv_xsave_data_size(value, *size);
+
+    return 0;
+}
+
 static int create_partition(int mshv_fd, int *vm_fd)
 {
     int ret;
diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
index 859e8bfb0f..9473530140 100644
--- a/accel/mshv/trace-events
+++ b/accel/mshv/trace-events
@@ -12,6 +12,8 @@ mshv_mem_ioeventfd_del(uint64_t addr, uint32_t size, uint32_t data) "addr=0x%" P
 
 mshv_hvcall_args(const char* hvcall, uint16_t code, uint16_t in_sz) "built args for '%s' code: %d in_sz: %d"
 
+mshv_xsave_data_size(uint64_t required, uint32_t allocated) "required=%" PRIu64 " allocated=%u"
+
 mshv_handle_interrupt(uint32_t cpu, int mask) "cpu_index=%d mask=0x%x"
 mshv_set_msi_routing(uint32_t gsi, uint64_t addr, uint32_t data) "gsi=%d addr=0x%" PRIx64 " data=0x%x"
 mshv_remove_msi_routing(uint32_t gsi) "gsi=%d"
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 3dffe3c5fb..9d0957a65b 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -70,6 +70,8 @@ struct MshvState {
     unsigned long *used_gsi_bitmap;
     unsigned int gsi_count;
     union hv_partition_processor_features processor_features;
+    /* compacted xsave area size rounded up to the page size */
+    uint32_t xsave_data_size;
 };
 
 typedef struct MshvMsiControl {
@@ -107,6 +109,7 @@ void mshv_arch_amend_proc_features(
 void mshv_arch_disable_partition_proc_features(
      union hv_partition_processor_features *disabled_features);
 int mshv_arch_post_init_vm(int vm_fd);
+int mshv_get_max_xsave_size(int vm_fd, uint32_t *size);
 int mshv_get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state);
 int mshv_set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state);
 typedef struct mshv_root_hvcall mshv_root_hvcall;
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index f528dd2b9a..7ce05bfb17 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -157,9 +157,8 @@ static int get_xsave_state(CPUState *cpu)
     int ret;
     void *xsavec_buf;
     const size_t page = HV_HYP_PAGE_SIZE;
-    size_t xsavec_buf_len = page;
+    size_t xsavec_buf_len = mshv_state->xsave_data_size;
 
-    /* TODO: should properly determine xsavec size based on CPUID */
     xsavec_buf = qemu_memalign(page, xsavec_buf_len);
     memset(xsavec_buf, 0, xsavec_buf_len);
 
@@ -172,11 +171,12 @@ static int get_xsave_state(CPUState *cpu)
     ret = ioctl(cpu_fd, MSHV_GET_VP_STATE, &args);
     if (ret < 0) {
         error_report("failed to get xsave state: %s", strerror(errno));
+        qemu_vfree(xsavec_buf);
         return -errno;
     }
 
     ret = decompact_xsave_area(xsavec_buf, xsavec_buf_len, env);
-    g_free(xsavec_buf);
+    qemu_vfree(xsavec_buf);
     if (ret < 0) {
         error_report("failed to decompact xsave area");
         return ret;
@@ -196,8 +196,8 @@ static int set_xsave_state(const CPUState *cpu)
     size_t page = HV_HYP_PAGE_SIZE, xsavec_buf_len;
 
     /* allocate and populate compacted buffer */
-    xsavec_buf = qemu_memalign(page, page);
-    xsavec_buf_len = page;
+    xsavec_buf_len = mshv_state->xsave_data_size;
+    xsavec_buf = qemu_memalign(page, xsavec_buf_len);
 
     /* save registers to standard format buffer */
     x86_cpu_xsave_all_areas(x86cpu, env->xsave_buf, env->xsave_buf_len);
@@ -212,7 +212,7 @@ static int set_xsave_state(const CPUState *cpu)
     };
 
     ret = ioctl(cpu_fd, MSHV_SET_VP_STATE, &args);
-    g_free(xsavec_buf);
+    qemu_vfree(xsavec_buf);
     if (ret < 0) {
         error_report("failed to set xsave state: %s", strerror(errno));
         return -errno;
@@ -2125,6 +2125,24 @@ void mshv_arch_init_vcpu(CPUState *cpu)
     int ret;
     X86XSaveHeader *header;
 
+    /* get the xsave data size */
+    if (!mshv_state->xsave_data_size) {
+        ret = mshv_get_max_xsave_size(mshv_state->vm,
+                                      &mshv_state->xsave_data_size);
+        if (ret < 0) {
+            warn_report("failed to get the max xsave area size: %s",
+                        strerror(errno));
+            /*
+             * Use the maximum size for xsave because the partition is
+             * provisioned with every XSAVE component supported
+             */
+            mshv_state->xsave_data_size =
+                ROUND_UP(mshv_get_supported_cpuid(0xD, 0, R_ECX), page);
+        }
+        /* never allow a zero-sized xsave area */
+        mshv_state->xsave_data_size = MAX(mshv_state->xsave_data_size, page);
+    }
+
     /* sanity check, to make sure we don't overflow the page */
     QEMU_BUILD_BUG_ON((MAX_REGISTER_COUNT
                       * sizeof(hv_register_assoc)
@@ -2149,9 +2167,7 @@ void mshv_arch_init_vcpu(CPUState *cpu)
 
     env->emu_mmio_buf = g_new(char, 4096);
 
-    /* Initialize XSAVE buffer page-aligned */
-    /* TODO: pick proper size based on CPUID */
-    xsave_len = page;
+    xsave_len = mshv_state->xsave_data_size;
     env->xsave_buf = qemu_memalign(page, xsave_len);
     env->xsave_buf_len = xsave_len;
     memset(env->xsave_buf, 0, env->xsave_buf_len);
-- 
2.53.0


