Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564D1C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 15:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkWh-0000Pk-2D; Tue, 16 Jul 2024 11:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTkWc-0000BM-BS
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:55:36 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTkWV-0007SD-G9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721145328; x=1752681328;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vTmyNpbDyAccpoxjesc1nPYTdmEkK+BCLqrSMM8iBwc=;
 b=lBzjOenqNzeGQx1pbNAklWInOr8GicgCSYkumxK/Zwphti0NsPtXbnRe
 sgpNliwQeGNlbFYDb19L0Gh1s++bakJI4ALb46Hj4vP/rmvRaNVE+XdeN
 4TAHqL97FxKTz7EuN3sxx1dSaekfqo0jvgHVnfq/hvFhC71NOj2veZywP
 4CEpj344gUZfe732IX2GggQtXckKCncaOvosPg8FACea1CvNGzB3Juwx4
 WvdaRaIafVWocukYhYiSCDH+mhcH7lhDrvftwJTwqeF+5PnBu/LehFYlh
 62NvQ4fox+s14VqPn/4RjwPLVpKo6bH7LdoLOq1twMPV0VdG+GSdYf4rv w==;
X-CSE-ConnectionGUID: hzogeEAJRMiKUvwndOWygw==
X-CSE-MsgGUID: oUCTECAPTwCk+u1yxNs/0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18743785"
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; d="scan'208";a="18743785"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 08:55:10 -0700
X-CSE-ConnectionGUID: EyfZj4RlTmiRaGugfiETwg==
X-CSE-MsgGUID: Wo36Cj7EQ5S5E4YUst8iYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; d="scan'208";a="50788450"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 16 Jul 2024 08:55:07 -0700
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
Subject: [PATCH v4 8/9] target/i386/kvm: Clean up error handling in
 kvm_arch_init()
Date: Wed, 17 Jul 2024 00:10:14 +0800
Message-Id: <20240716161015.263031-9-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716161015.263031-1-zhao1.liu@intel.com>
References: <20240716161015.263031-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
* Missed to return when KVM_CAP_X86_DISABLE_EXITS enabling fails.
* MSR filter related cases called exit() directly instead of returning
  to kvm_init().

Fix the above cases.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
v3: new commit.
---
 target/i386/kvm/kvm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index f68be68eb411..d47476e96813 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2682,7 +2682,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
-    kvm_get_supported_feature_msrs(s);
+    ret = kvm_get_supported_feature_msrs(s);
+    if (ret < 0) {
+        return ret;
+    }
 
     uname(&utsname);
     lm_capable_kernel = strcmp(utsname.machine, "x86_64") == 0;
@@ -2740,6 +2743,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         if (ret < 0) {
             error_report("kvm: guest stopping CPU not supported: %s",
                          strerror(-ret));
+            return ret;
         }
     }
 
@@ -2785,7 +2789,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         if (ret) {
             error_report("Could not enable user space MSRs: %s",
                          strerror(-ret));
-            exit(1);
+            return ret;
         }
 
         ret = kvm_filter_msr(s, MSR_CORE_THREAD_COUNT,
@@ -2793,7 +2797,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         if (ret) {
             error_report("Could not install MSR_CORE_THREAD_COUNT handler: %s",
                          strerror(-ret));
-            exit(1);
+            return ret;
         }
     }
 
-- 
2.34.1


