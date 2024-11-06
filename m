Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E78D3E787
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 02:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8W7i-00079i-CF; Tue, 05 Nov 2024 21:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8W7g-00078Q-B0
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:50:20 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8W7e-0003cN-Kd
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 21:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730861419; x=1762397419;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W73DxTAKGKDwOxIP+UEa3mm04Ri1kkHN13Gfy8Im22A=;
 b=EKm3CdB6YGkg/3fIyvwg9wDE7j8ZUj5vqTzA/z9SA8y3/t2hsniixpRf
 pVE9ejeXngKQQzSOstkblvW5eXE20vLeZgKU9wNjCaJ1apHe6Zb5h0DoT
 t2Lp8ZO1dqFWHA3Y2l0HHfIdsDSbK9V1Cpibz0LL7p3fdeUkyTfzBep98
 uYFrYVxgeapFNEePGWZSOtm8MpeLz+96OQ9fvqv7E17DVS3JGRfrRJijm
 +IQndhNNgYTaZ572zAm14uIg2/Z51AOKBCOqApyT6rCvFGFMjuIpd8P9e
 nKp/NWmghk76MAMi2VJUBDitcRoP/2ZRgYrAggoV0Uoc3Wkz14s0HKKpV w==;
X-CSE-ConnectionGUID: Yr4Qp6ctTfCzL9AirMb+vg==
X-CSE-MsgGUID: 0yhaZxALQ5aoJxzCkBO/2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30492312"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30492312"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 18:50:17 -0800
X-CSE-ConnectionGUID: u6UjNTUoTaahh0D0ORPZLQ==
X-CSE-MsgGUID: u1ZDVdxyTCW2KTSVmr2mUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="115078027"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 05 Nov 2024 18:50:14 -0800
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
Subject: [PATCH v5 09/11] target/i386/kvm: Return -1 when
 kvm_msr_energy_thread_init() fails
Date: Wed,  6 Nov 2024 11:07:26 +0800
Message-Id: <20241106030728.553238-10-zhao1.liu@intel.com>
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

It is common practice to return a negative value (like -1) to indicate
an error, and other functions in kvm_arch_init() follow this style.

To avoid confusion (sometimes returned -1 indicates failure, and
sometimes -1, in a same function), return -1 when
kvm_msr_energy_thread_init() fails.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
v5: new commit.
---
 target/i386/kvm/kvm.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9993382fb40e..69825b53b6da 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2921,7 +2921,6 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     struct KVMMsrEnergy *r = &s->msr_energy;
-    int ret = 0;
 
     /*
      * Sanity check
@@ -2931,13 +2930,11 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
     if (!is_host_cpu_intel()) {
         error_report("The RAPL feature can only be enabled on hosts "
                      "with Intel CPU models");
-        ret = 1;
-        goto out;
+        return -1;
     }
 
     if (!is_rapl_enabled()) {
-        ret = 1;
-        goto out;
+        return -1;
     }
 
     /* Retrieve the virtual topology */
@@ -2959,16 +2956,14 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
     r->host_topo.maxcpus = vmsr_get_maxcpus();
     if (r->host_topo.maxcpus == 0) {
         error_report("host max cpus = 0");
-        ret = 1;
-        goto out;
+        return -1;
     }
 
     /* Max number of packages on the host */
     r->host_topo.maxpkgs = vmsr_get_max_physical_package(r->host_topo.maxcpus);
     if (r->host_topo.maxpkgs == 0) {
         error_report("host max pkgs = 0");
-        ret = 1;
-        goto out;
+        return -1;
     }
 
     /* Allocate memory for each package on the host */
@@ -2980,8 +2975,7 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
     for (int i = 0; i < r->host_topo.maxpkgs; i++) {
         if (r->host_topo.pkg_cpu_count[i] == 0) {
             error_report("cpu per packages = 0 on package_%d", i);
-            ret = 1;
-            goto out;
+            return -1;
         }
     }
 
@@ -2998,8 +2992,7 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
 
     if (s->msr_energy.sioc == NULL) {
         error_report("vmsr socket opening failed");
-        ret = 1;
-        goto out;
+        return -1;
     }
 
     /* Those MSR values should not change */
@@ -3011,15 +3004,13 @@ static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
                                     s->msr_energy.sioc);
     if (r->msr_unit == 0 || r->msr_limit == 0 || r->msr_info == 0) {
         error_report("can't read any virtual msr");
-        ret = 1;
-        goto out;
+        return -1;
     }
 
     qemu_thread_create(&r->msr_thr, "kvm-msr",
                        kvm_msr_energy_thread,
                        s, QEMU_THREAD_JOINABLE);
-out:
-    return ret;
+    return 0;
 }
 
 int kvm_arch_get_default_type(MachineState *ms)
@@ -3327,7 +3318,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
         if (s->msr_energy.enable == true) {
             kvm_vm_enable_energy_msrs(s);
-            if (kvm_msr_energy_thread_init(s, ms)) {
+
+            ret = kvm_msr_energy_thread_init(s, ms);
+            if (ret < 0) {
                 error_report("kvm : error RAPL feature requirement not met");
                 exit(1);
             }
-- 
2.34.1


