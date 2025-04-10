Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75789C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 07:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2mRu-0006ue-Cj; Thu, 10 Apr 2025 03:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2mRp-0006tj-Qc
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 03:35:41 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2mRm-0003wK-Uu
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 03:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744270539; x=1775806539;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GW8I9IwZKiH7d39LBHZIwP0evJpIuEmUi4Sf9x3winU=;
 b=DmD1bqDu6/T17q/hccIQ04flAPPNxIFPB29LEqY4aKVBJF8BHtWl+Rg/
 fW/unlJ2QmlUvJcdb2Ku6xNjLU2z6Zs1zDoohAA0U29BeOoxnXjl6eiDY
 HrkJadgrOx4zTb017160FYRnHi1QG3UqI6smU5rrYbcz8krvx6vLDljjT
 CXwYCsY60JJOlYCKhLiNd1ncETprgwIGHIMHfZMPy4QigD5u+ZQsjj13y
 pBwdsggQIpEBMCarbt28SQ2UISwT63J7/7eBR1oePXMBTi67o5yqIIzCf
 RTwq9OilZ8kINjn99ZVtRuuON+7MDsN7mfBmK6xDGQP666qJ+Dzzel7+l A==;
X-CSE-ConnectionGUID: pybBx94vQnuP3ei1u+5axw==
X-CSE-MsgGUID: x9fCvtAqRrWiEB8UiO1hfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="33381968"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="33381968"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2025 00:35:34 -0700
X-CSE-ConnectionGUID: 6Kzd+w8AQRyuK+2qq5CsiA==
X-CSE-MsgGUID: W5IpU9nmSKeOx1aeWrvLIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="134012104"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 10 Apr 2025 00:35:33 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] i386/cpu: Consolidate the helper to get Host's vendor
Date: Thu, 10 Apr 2025 15:56:19 +0800
Message-Id: <20250410075619.145792-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
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

Extend host_cpu_vendor_fms() to help more cases to get Host's vendor
information.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/host-cpu.c        | 10 ++++++----
 target/i386/kvm/vmsr_energy.c |  3 +--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 3e4e85e729c8..072731a4dd25 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -109,9 +109,13 @@ void host_cpu_vendor_fms(char *vendor, int *family, int *model, int *stepping)
 {
     uint32_t eax, ebx, ecx, edx;
 
-    host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
+    host_cpuid(0x0, 0, NULL, &ebx, &ecx, &edx);
     x86_cpu_vendor_words2str(vendor, ebx, edx, ecx);
 
+    if (!family && !model && !stepping) {
+        return;
+    }
+
     host_cpuid(0x1, 0, &eax, &ebx, &ecx, &edx);
     if (family) {
         *family = ((eax >> 8) & 0x0F) + ((eax >> 20) & 0xFF);
@@ -129,11 +133,9 @@ void host_cpu_instance_init(X86CPU *cpu)
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
     if (xcc->model) {
-        uint32_t ebx = 0, ecx = 0, edx = 0;
         char vendor[CPUID_VENDOR_SZ + 1];
 
-        host_cpuid(0, 0, NULL, &ebx, &ecx, &edx);
-        x86_cpu_vendor_words2str(vendor, ebx, edx, ecx);
+        host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
         object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
     }
 }
diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index 31508d4e77a2..f499ec6e8b05 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -29,10 +29,9 @@ char *vmsr_compute_default_paths(void)
 
 bool is_host_cpu_intel(void)
 {
-    int family, model, stepping;
     char vendor[CPUID_VENDOR_SZ + 1];
 
-    host_cpu_vendor_fms(vendor, &family, &model, &stepping);
+    host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
 
     return g_str_equal(vendor, CPUID_VENDOR_INTEL);
 }
-- 
2.34.1


