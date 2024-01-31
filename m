Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7EAC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7Q6-0005AE-0n; Wed, 31 Jan 2024 05:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rV7Pg-0004ph-9H
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:01:49 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rV7Pd-0008RJ-RS
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706695305; x=1738231305;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CEg1EuIAzjPsONCoh7kjj0RyiPAm4Iqa1aBnTo9zcFk=;
 b=YBpuJvc10MNF/f7zAqhSune3FojVw4Dpk7tVbcs8g8QXfjGxe4K0tzcp
 jmvAsILSncGLGmi4+5fadJbHadmYk5Na2wsUCBO4C4H0ZpXQpLCD9UxBy
 DLJBUdq5xjZ2TsdnNmBzx0pJZVPagLBel9C2rU2yspXj6KdkcaDAmTtQ1
 pWETToo0lBKRit4Zzet8asOP9g6vu+iqrOlf5HWaMCR4WVFRLOKqucHYp
 ogne0ccSg4YvpHEwTbG7/J9X+QVM/mc4d3VNOmQEaeO034lomiOKBTx7c
 T4PjSV3TITHGeSsXWLfVDQwCymzHR5YsFATKJotjyMhlbp+cd5Yp4oL1O g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="25032910"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="25032910"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 02:01:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4036203"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 31 Jan 2024 02:01:39 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v8 14/21] i386: Expose module level in CPUID[0x1F]
Date: Wed, 31 Jan 2024 18:13:43 +0800
Message-Id: <20240131101350.109512-15-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
References: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Linux kernel (from v6.4, with commit edc0a2b595765 ("x86/topology: Fix
erroneous smp_num_siblings on Intel Hybrid platforms") is able to
handle platforms with Module level enumerated via CPUID.1F.

Expose the module level in CPUID[0x1F] if the machine has more than 1
modules.

(Tested CPU topology in CPUID[0x1F] leaf with various die/cluster
configurations in "-smp".)

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v7:
 * Mapped x86 module to smp module instead of cluster.
 * Dropped Michael/Babu's ACKed/Tested tags since the code change.
 * Re-added Yongwei's Tested tag For his re-testing.

Changes since v3:
 * New patch to expose module level in 0x1F.
 * Added Tested-by tag from Yongwei.
---
 hw/i386/x86.c              | 2 +-
 include/hw/i386/topology.h | 6 ++++--
 target/i386/cpu.c          | 6 ++++++
 target/i386/cpu.h          | 1 +
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 9d41bc2824e3..f0aad733747a 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -318,7 +318,7 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     if (ms->smp.modules > 1) {
         env->nr_modules = ms->smp.modules;
-        /* TODO: Expose module level in CPUID[0x1F]. */
+        set_bit(CPU_TOPO_LEVEL_MODULE, env->avail_cpu_topo);
     }
 
     if (ms->smp.dies > 1) {
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 7622d806932c..ea871045779d 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -71,6 +71,7 @@ enum CPUTopoLevel {
     CPU_TOPO_LEVEL_INVALID,
     CPU_TOPO_LEVEL_SMT,
     CPU_TOPO_LEVEL_CORE,
+    CPU_TOPO_LEVEL_MODULE,
     CPU_TOPO_LEVEL_DIE,
     CPU_TOPO_LEVEL_PACKAGE,
     CPU_TOPO_LEVEL_MAX,
@@ -198,11 +199,12 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
 }
 
 /*
- * Check whether there's extended topology level (die)?
+ * Check whether there's extended topology level (module or die)?
  */
 static inline bool x86_has_extended_topo(unsigned long *topo_bitmap)
 {
-    return test_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
+    return test_bit(CPU_TOPO_LEVEL_MODULE, topo_bitmap) ||
+           test_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
 }
 
 #endif /* HW_I386_TOPOLOGY_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a5a1411285c0..bc7b3d7c0eb0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -277,6 +277,8 @@ static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
         return 1;
     case CPU_TOPO_LEVEL_CORE:
         return topo_info->threads_per_core;
+    case CPU_TOPO_LEVEL_MODULE:
+        return topo_info->threads_per_core * topo_info->cores_per_module;
     case CPU_TOPO_LEVEL_DIE:
         return topo_info->threads_per_core * topo_info->cores_per_module *
                topo_info->modules_per_die;
@@ -297,6 +299,8 @@ static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
         return 0;
     case CPU_TOPO_LEVEL_CORE:
         return apicid_core_offset(topo_info);
+    case CPU_TOPO_LEVEL_MODULE:
+        return apicid_module_offset(topo_info);
     case CPU_TOPO_LEVEL_DIE:
         return apicid_die_offset(topo_info);
     case CPU_TOPO_LEVEL_PACKAGE:
@@ -316,6 +320,8 @@ static uint32_t cpuid1f_topo_type(enum CPUTopoLevel topo_level)
         return CPUID_1F_ECX_TOPO_LEVEL_SMT;
     case CPU_TOPO_LEVEL_CORE:
         return CPUID_1F_ECX_TOPO_LEVEL_CORE;
+    case CPU_TOPO_LEVEL_MODULE:
+        return CPUID_1F_ECX_TOPO_LEVEL_MODULE;
     case CPU_TOPO_LEVEL_DIE:
         return CPUID_1F_ECX_TOPO_LEVEL_DIE;
     default:
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d0951a0fec27..08d4414692c9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1018,6 +1018,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_1F_ECX_TOPO_LEVEL_INVALID  CPUID_B_ECX_TOPO_LEVEL_INVALID
 #define CPUID_1F_ECX_TOPO_LEVEL_SMT      CPUID_B_ECX_TOPO_LEVEL_SMT
 #define CPUID_1F_ECX_TOPO_LEVEL_CORE     CPUID_B_ECX_TOPO_LEVEL_CORE
+#define CPUID_1F_ECX_TOPO_LEVEL_MODULE   3
 #define CPUID_1F_ECX_TOPO_LEVEL_DIE      5
 
 /* MSR Feature Bits */
-- 
2.34.1


