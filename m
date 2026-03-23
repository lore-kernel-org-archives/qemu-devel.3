Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1002EC01D4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4duk-0000PP-LK; Mon, 23 Mar 2026 07:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4duc-0000OR-H0
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:57:38 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4dua-0003hI-On
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:57:38 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 253FC20B7128;
 Mon, 23 Mar 2026 04:57:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 253FC20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774267055;
 bh=w4M3/0qg3+/gjmRlJmssrWnUuoDEuAj8A+ff+uAXc8U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VGg+5wYKmdzhfXCq5OO9bQ2Irvv37l6DjzkXf2r21abvWZFlDmsFSXPzGZAccRRVN
 sAAFsY5u0lUZvK0umJyRJmT73u0Xgooua3w+Lvz1MC6Y6Wdl0rBnPp0jSast72f397
 uTbf7NqLR+YeKgyCKGTThR4SWUUjx/V4OfGUDGH0=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 9/9] accel/mshv: disable la57 (5lvl paging)
Date: Mon, 23 Mar 2026 12:57:11 +0100
Message-Id: <20260323115711.353793-10-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323115711.353793-1-magnuskulke@linux.microsoft.com>
References: <20260323115711.353793-1-magnuskulke@linux.microsoft.com>
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

This change disable la57 paging on the mshv hypervisor on both the
mshv processor feature bitmap and mask the cpuid feature leaf to the
guest.

Since the removal of hypervisor-assisted gva=>gpa translation in
1c85a4a3d7 we have seen MMIO errors in guests on la57-enabled hw. We
will have to investigate and test this further.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c       |  7 +++++++
 include/system/mshv_int.h   |  2 ++
 target/i386/mshv/mshv-cpu.c | 12 ++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index c50641f174..a557623531 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -142,6 +142,8 @@ static int create_partition(int mshv_fd, int *vm_fd)
     int ret;
     uint64_t pt_flags, host_proc_features;
     union hv_partition_processor_xsave_features disabled_xsave_features;
+    union hv_partition_processor_features disabled_partition_features = {0};
+
     struct mshv_create_partition_v2 args = {0};
 
     QEMU_BUILD_BUG_ON(MSHV_NUM_CPU_FEATURES_BANKS != 2);
@@ -177,6 +179,11 @@ static int create_partition(int mshv_fd, int *vm_fd)
     }
     args.pt_cpu_fbanks[1] = ~host_proc_features;
 
+    /* arch-specific features we disable regardless of host support */
+    mshv_arch_disable_partition_proc_features(&disabled_partition_features);
+    args.pt_cpu_fbanks[0] |= disabled_partition_features.as_uint64[0];
+    args.pt_cpu_fbanks[1] |= disabled_partition_features.as_uint64[1];
+
     /* populate args structure */
     args.pt_flags = pt_flags;
     args.pt_isolation = MSHV_PT_ISOLATION_NONE;
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 35386c422f..ca156cdf4b 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -94,6 +94,8 @@ void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features);
+void mshv_arch_disable_partition_proc_features(
+     union hv_partition_processor_features *disabled_features);
 int mshv_arch_post_init_vm(int vm_fd);
 
 typedef struct mshv_root_hvcall mshv_root_hvcall;
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 2c66a52709..433f7a4069 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1111,6 +1111,12 @@ void mshv_arch_amend_proc_features(
     features->access_guest_idle_reg = 1;
 }
 
+void mshv_arch_disable_partition_proc_features(
+     union hv_partition_processor_features *disabled_features)
+{
+    disabled_features->la57_support = 1;
+}
+
 static int set_memory_info(const struct hyperv_message *msg,
                            struct hv_x64_memory_intercept_message *info)
 {
@@ -1677,6 +1683,12 @@ uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
      */
     if (func == 0x07 && idx == 0 && reg == R_ECX) {
         ret &= ~CPUID_7_0_ECX_CET_SHSTK;
+        /*
+         * LA57 (5-level paging) causes incorrect GVA=>GPA translations
+         * in the instruction decoder/emulator. Disable until page table
+         * walk in x86_mmu.c works w/ 5-level paging.
+         */
+        ret &= ~CPUID_7_0_ECX_LA57;
     }
     if (func == 0x07 && idx == 0 && reg == R_EDX) {
         ret &= ~CPUID_7_0_EDX_CET_IBT;
-- 
2.34.1


