Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB28D35E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 02:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8W7l-0007B7-TP; Tue, 05 Nov 2024 21:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8W7k-0007Ap-RQ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:50:24 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8W7i-0003cN-BN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730861422; x=1762397422;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cDyoHsWzKph1fodDMEJqXgXb9rXZ334jDEhsYTPjqKQ=;
 b=AE9fowAwJ7HZZLLPR0T/w4DMePJzsvHIP9A0M0pk27UX95jvmSJ/xKxt
 BFn+ZcfoH0b7AwbkGEJ7YB9BcC0Mf2jtD5cSKSgPn4zfLfQEPlrImgZQJ
 xQJSXTwqRcKpsKW41XvzItCnY+gixb63jA93SZPiltWuhbv7RyU6wz4+T
 VG8c/T5oh1oJWIqrLjYHpHeYjzmuIWXe2rrWXyhHalI3iObWwBGwOyhxc
 Sn0LFVg/S5jjZSxCM3z0wCzTvvRXiYm/wQKvavcN9WbNvqiqPivCpg2ig
 oS+eSQ5CnJbycMAwHKxeC8HyCDpXJJTS7rFclc3dXPdyOEyo1xbs64RBq w==;
X-CSE-ConnectionGUID: JA/98ZacSPKlO7RvjIIW+A==
X-CSE-MsgGUID: lmAPGaOKSr2SlFCF0FEwuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30492322"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30492322"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 18:50:21 -0800
X-CSE-ConnectionGUID: BgQ7aLUUSJ+cgTv2Y4xQFA==
X-CSE-MsgGUID: OQfoaMsiS52eotCldTU9ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="115078033"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 05 Nov 2024 18:50:17 -0800
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
Subject: [PATCH v5 10/11] target/i386/kvm: Clean up error handling in
 kvm_arch_init()
Date: Wed,  6 Nov 2024 11:07:27 +0800
Message-Id: <20241106030728.553238-11-zhao1.liu@intel.com>
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

Currently, there're following incorrect error handling cases in
kvm_arch_init():
* Missed to handle failure of kvm_get_supported_feature_msrs().
* Missed to return when kvm_vm_enable_disable_exits() fails.
* MSR filter related cases called exit() directly instead of returning
  to kvm_init(). (The caller of kvm_arch_init() - kvm_init() - needs to
  know if kvm_arch_init() fails in order to perform cleanup).

Fix the above cases.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
---
v5: cleaned up kvm_vm_enable_energy_msrs().
v3: new commit.
---
 target/i386/kvm/kvm.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 69825b53b6da..013c0359acbe 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3147,7 +3147,7 @@ static int kvm_vm_enable_userspace_msr(KVMState *s)
     return 0;
 }
 
-static void kvm_vm_enable_energy_msrs(KVMState *s)
+static int kvm_vm_enable_energy_msrs(KVMState *s)
 {
     int ret;
 
@@ -3157,7 +3157,7 @@ static void kvm_vm_enable_energy_msrs(KVMState *s)
         if (ret < 0) {
             error_report("Could not install MSR_RAPL_POWER_UNIT handler: %s",
                          strerror(-ret));
-            exit(1);
+            return ret;
         }
 
         ret = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
@@ -3165,7 +3165,7 @@ static void kvm_vm_enable_energy_msrs(KVMState *s)
         if (ret < 0) {
             error_report("Could not install MSR_PKG_POWER_LIMIT handler: %s",
                          strerror(-ret));
-            exit(1);
+            return ret;
         }
 
         ret = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
@@ -3173,17 +3173,17 @@ static void kvm_vm_enable_energy_msrs(KVMState *s)
         if (ret < 0) {
             error_report("Could not install MSR_PKG_POWER_INFO handler: %s",
                          strerror(-ret));
-            exit(1);
+            return ret;
         }
         ret = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
                              kvm_rdmsr_pkg_energy_status, NULL);
         if (ret < 0) {
             error_report("Could not install MSR_PKG_ENERGY_STATUS handler: %s",
                          strerror(-ret));
-            exit(1);
+            return ret;
         }
     }
-    return;
+    return 0;
 }
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
@@ -3250,7 +3250,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
-    kvm_get_supported_feature_msrs(s);
+    ret = kvm_get_supported_feature_msrs(s);
+    if (ret < 0) {
+        return ret;
+    }
 
     uname(&utsname);
     lm_capable_kernel = strcmp(utsname.machine, "x86_64") == 0;
@@ -3286,6 +3289,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         if (ret < 0) {
             error_report("kvm: guest stopping CPU not supported: %s",
                          strerror(-ret));
+            return ret;
         }
     }
 
@@ -3317,12 +3321,15 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
 
         if (s->msr_energy.enable == true) {
-            kvm_vm_enable_energy_msrs(s);
+            ret = kvm_vm_enable_energy_msrs(s);
+            if (ret < 0) {
+                return ret;
+            }
 
             ret = kvm_msr_energy_thread_init(s, ms);
             if (ret < 0) {
                 error_report("kvm : error RAPL feature requirement not met");
-                exit(1);
+                return ret;
             }
         }
     }
-- 
2.34.1


