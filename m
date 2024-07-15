Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E21C3DA45
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 04:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTDQE-0000rP-GR; Mon, 15 Jul 2024 00:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTDQ9-0000ga-TD
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 00:34:41 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTDQ8-0004GK-3t
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 00:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721018081; x=1752554081;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yLNWhHrtOyoeQooeafFrZVJbCO/Btc3+xL/n3wetEgs=;
 b=l0rcEghBeg8uU3xqnwNYd1CeZNpNWj7K/Z0dkZXdiyqQxAT8I97pXhSl
 KBMr0IMEvkCTcMYtPzBEHW1ReYpr/btTQwALuPthdqhGE2PjHe1/kulRD
 jtsNWQGA8K5tN0WqtdxFF4D0T0AuZ4PMc6sMEwrXVVDwiL7B41EHtPrxc
 P7fc3ysekshICbKgfp8LpJ5XwvAARg25IqCYN7y6df+A+Bm6zVolc/WdK
 hDGIJ07gNGjZrmiGec/vRaP95QbTIfE5mqkmKfIcrStFGICcJYcFDSltM
 De4AxZOaYEHHJM+gnTU1mBf1eGF0oWuCANDD+L9yz6jCaaIH1eWk0OXmP g==;
X-CSE-ConnectionGUID: soo1hmwQRzqQLQQrVJWwqg==
X-CSE-MsgGUID: rw+xOnigTLOjeYq8QhdqBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35809862"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="35809862"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2024 21:34:40 -0700
X-CSE-ConnectionGUID: VWjhGhwBQdCqLgABca1ilg==
X-CSE-MsgGUID: 6DEZMmFoTTOlfpcrOYp8jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="54043137"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 14 Jul 2024 21:34:36 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 7/8] target/i386/kvm: Clean up return values of MSR filter
 related functions
Date: Mon, 15 Jul 2024 12:49:54 +0800
Message-Id: <20240715044955.3954304-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715044955.3954304-1-zhao1.liu@intel.com>
References: <20240715044955.3954304-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

At present, the error code of MSR filter enablement is attempted to be
printed in error_report().

Unfortunately, this behavior doesn't work because the MSR filter-related
functions return the boolean and current error_report() use the wrong
return value.

So fix this by making MSR filter related functions return int type and
printing such returned value in error_report().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/kvm/kvm.c      | 35 +++++++++++++++++------------------
 target/i386/kvm/kvm_i386.h |  4 ++--
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4aae4ffc9ccd..0fd1d099ae4c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2780,8 +2780,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
             }
     }
     if (kvm_vm_check_extension(s, KVM_CAP_X86_USER_SPACE_MSR)) {
-        bool r;
-
         ret = kvm_vm_enable_cap(s, KVM_CAP_X86_USER_SPACE_MSR, 0,
                                 KVM_MSR_EXIT_REASON_FILTER);
         if (ret) {
@@ -2790,9 +2788,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
             exit(1);
         }
 
-        r = kvm_filter_msr(s, MSR_CORE_THREAD_COUNT,
-                           kvm_rdmsr_core_thread_count, NULL);
-        if (!r) {
+        ret = kvm_filter_msr(s, MSR_CORE_THREAD_COUNT,
+                             kvm_rdmsr_core_thread_count, NULL);
+        if (ret) {
             error_report("Could not install MSR_CORE_THREAD_COUNT handler: %s",
                          strerror(-ret));
             exit(1);
@@ -5274,13 +5272,13 @@ void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg)
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
+    int ret, i, j = 0;
 
     for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
         KVMMSRHandlers *handler = &msr_handlers[i];
@@ -5304,18 +5302,18 @@ static bool kvm_install_msr_filters(KVMState *s)
         }
     }
 
-    r = kvm_vm_ioctl(s, KVM_X86_SET_MSR_FILTER, &filter);
-    if (r) {
-        return false;
+    ret = kvm_vm_ioctl(s, KVM_X86_SET_MSR_FILTER, &filter);
+    if (ret) {
+        return ret;
     }
 
-    return true;
+    return 0;
 }
 
-bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
-                    QEMUWRMSRHandler *wrmsr)
+int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
+                   QEMUWRMSRHandler *wrmsr)
 {
-    int i;
+    int i, ret;
 
     for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
         if (!msr_handlers[i].msr) {
@@ -5325,16 +5323,17 @@ bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
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
+    return 0;
 }
 
 static int kvm_handle_rdmsr(X86CPU *cpu, struct kvm_run *run)
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 34fc60774b86..91c2d6e69163 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -74,8 +74,8 @@ typedef struct kvm_msr_handlers {
     QEMUWRMSRHandler *wrmsr;
 } KVMMSRHandlers;
 
-bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
-                    QEMUWRMSRHandler *wrmsr);
+int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
+                   QEMUWRMSRHandler *wrmsr);
 
 #endif /* CONFIG_KVM */
 
-- 
2.34.1


