Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20977D35E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 02:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8W7h-00079M-3U; Tue, 05 Nov 2024 21:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8W7c-00075s-MU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:50:16 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8W7a-0003OA-Sr
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730861415; x=1762397415;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jFWGnz+suDCZpSQMmtwVwuQ2yns3DjY1J2pGL1AK0/Y=;
 b=OVha51k+VVAIDX6ZS1nXqRo9MEi6bvtGSgSZNCbrFRb4D1Z4Stl9NN65
 jLjg6l12MvKhP2Cu8apkM+iO3mEZz40VKBtgdAifaTA3N4dHJAJVxkRsc
 UGNNtVKb2ZcnTil/0Fx3UK8jljIjz/ceyu5x2BeFNCWF8GrHhbPXP4zn8
 6PGCj7jU0Ybq5uPdgAasiEnrnH3LhJjyy0/7VXtwzNt4MZwhMNo19TSq5
 OI5VY946AQ/zWeyYw4ycR2qBisHIQ6ZP63Ee6JwAVD4w9Hurm4tMtRdgi
 8ruCTlv8Ww89tl/xZN4J144k8T8MADdSBslvmt3P289Sxrhajj7m7eqPU Q==;
X-CSE-ConnectionGUID: vf63t9kdRBC9sNDKganeBw==
X-CSE-MsgGUID: dNWXsMa+RwCibbBiwsbb3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30492302"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30492302"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 18:50:14 -0800
X-CSE-ConnectionGUID: BHcOIsNZSFyg2LleDmVUXA==
X-CSE-MsgGUID: 0Rm8CO5uTTevGQiWAwOa4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="115078022"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 05 Nov 2024 18:50:11 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Tao Su <tao1.su@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 08/11] target/i386/kvm: Clean up return values of MSR
 filter related functions
Date: Wed,  6 Nov 2024 11:07:25 +0800
Message-Id: <20241106030728.553238-9-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106030728.553238-1-zhao1.liu@intel.com>
References: <20241106030728.553238-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Before commit 0cc42e63bb54 ("kvm/i386: refactor kvm_arch_init and split
it into smaller functions"), error_report() attempts to print the error
code from kvm_filter_msr(). However, printing error code does not work
due to kvm_filter_msr() returns bool instead int.

0cc42e63bb54 fixed the error by removing error code printing, but this
lost useful error messages. Bring it back by making kvm_filter_msr()
return int.

This also makes the function call chain processing clearer, allowing for
better handling of error result propagation from kvm_filter_msr() to
kvm_arch_init(), preparing for the subsequent cleanup work of error
handling in kvm_arch_init().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
---
v5: Rebased and cleaned up kvm_vm_enable_energy_msrs() as well.
v4: Returned kvm_vm_ioctl() directly. (Zide)
v3: new commit.
---
 target/i386/kvm/kvm.c | 87 ++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 1fb4bd19fcf7..9993382fb40e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -108,8 +108,8 @@ typedef struct {
 } KVMMSRHandlers;
 
 static void kvm_init_msrs(X86CPU *cpu);
-static bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
-                           QEMUWRMSRHandler *wrmsr);
+static int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
+                          QEMUWRMSRHandler *wrmsr);
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
@@ -3135,17 +3135,21 @@ static int kvm_vm_enable_notify_vmexit(KVMState *s)
 
 static int kvm_vm_enable_userspace_msr(KVMState *s)
 {
-    int ret = kvm_vm_enable_cap(s, KVM_CAP_X86_USER_SPACE_MSR, 0,
-                                KVM_MSR_EXIT_REASON_FILTER);
+    int ret;
+
+    ret = kvm_vm_enable_cap(s, KVM_CAP_X86_USER_SPACE_MSR, 0,
+                            KVM_MSR_EXIT_REASON_FILTER);
     if (ret < 0) {
         error_report("Could not enable user space MSRs: %s",
                      strerror(-ret));
         exit(1);
     }
 
-    if (!kvm_filter_msr(s, MSR_CORE_THREAD_COUNT,
-                        kvm_rdmsr_core_thread_count, NULL)) {
-        error_report("Could not install MSR_CORE_THREAD_COUNT handler!");
+    ret = kvm_filter_msr(s, MSR_CORE_THREAD_COUNT,
+                         kvm_rdmsr_core_thread_count, NULL);
+    if (ret < 0) {
+        error_report("Could not install MSR_CORE_THREAD_COUNT handler: %s",
+                     strerror(-ret));
         exit(1);
     }
 
@@ -3154,36 +3158,37 @@ static int kvm_vm_enable_userspace_msr(KVMState *s)
 
 static void kvm_vm_enable_energy_msrs(KVMState *s)
 {
-    bool r;
+    int ret;
+
     if (s->msr_energy.enable == true) {
-        r = kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
-                           kvm_rdmsr_rapl_power_unit, NULL);
-        if (!r) {
-            error_report("Could not install MSR_RAPL_POWER_UNIT \
-                                handler");
+        ret = kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
+                             kvm_rdmsr_rapl_power_unit, NULL);
+        if (ret < 0) {
+            error_report("Could not install MSR_RAPL_POWER_UNIT handler: %s",
+                         strerror(-ret));
             exit(1);
         }
 
-        r = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
-                           kvm_rdmsr_pkg_power_limit, NULL);
-        if (!r) {
-            error_report("Could not install MSR_PKG_POWER_LIMIT \
-                                handler");
+        ret = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
+                             kvm_rdmsr_pkg_power_limit, NULL);
+        if (ret < 0) {
+            error_report("Could not install MSR_PKG_POWER_LIMIT handler: %s",
+                         strerror(-ret));
             exit(1);
         }
 
-        r = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
-                           kvm_rdmsr_pkg_power_info, NULL);
-        if (!r) {
-            error_report("Could not install MSR_PKG_POWER_INFO \
-                                handler");
+        ret = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
+                             kvm_rdmsr_pkg_power_info, NULL);
+        if (ret < 0) {
+            error_report("Could not install MSR_PKG_POWER_INFO handler: %s",
+                         strerror(-ret));
             exit(1);
         }
-        r = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
-                           kvm_rdmsr_pkg_energy_status, NULL);
-        if (!r) {
-            error_report("Could not install MSR_PKG_ENERGY_STATUS \
-                                handler");
+        ret = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
+                             kvm_rdmsr_pkg_energy_status, NULL);
+        if (ret < 0) {
+            error_report("Could not install MSR_PKG_ENERGY_STATUS handler: %s",
+                         strerror(-ret));
             exit(1);
         }
     }
@@ -5842,13 +5847,13 @@ void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg)
     }
 }
 
-static bool kvm_install_msr_filters(KVMState *s)
+static int kvm_install_msr_filters(KVMState *s)
 {
     uint64_t zero = 0;
     struct kvm_msr_filter filter = {
         .flags = KVM_MSR_FILTER_DEFAULT_ALLOW,
     };
-    int r, i, j = 0;
+    int i, j = 0;
 
     for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
         KVMMSRHandlers *handler = &msr_handlers[i];
@@ -5872,18 +5877,13 @@ static bool kvm_install_msr_filters(KVMState *s)
         }
     }
 
-    r = kvm_vm_ioctl(s, KVM_X86_SET_MSR_FILTER, &filter);
-    if (r) {
-        return false;
-    }
-
-    return true;
+    return kvm_vm_ioctl(s, KVM_X86_SET_MSR_FILTER, &filter);
 }
 
-static bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
-                    QEMUWRMSRHandler *wrmsr)
+static int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
+                          QEMUWRMSRHandler *wrmsr)
 {
-    int i;
+    int i, ret;
 
     for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
         if (!msr_handlers[i].msr) {
@@ -5893,16 +5893,17 @@ static bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                 .wrmsr = wrmsr,
             };
 
-            if (!kvm_install_msr_filters(s)) {
+            ret = kvm_install_msr_filters(s);
+            if (ret) {
                 msr_handlers[i] = (KVMMSRHandlers) { };
-                return false;
+                return ret;
             }
 
-            return true;
+            return 0;
         }
     }
 
-    return false;
+    return -EINVAL;
 }
 
 static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
-- 
2.34.1


