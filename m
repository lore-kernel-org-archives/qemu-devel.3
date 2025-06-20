Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC8EC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 09:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSXiI-0001PG-Da; Fri, 20 Jun 2025 05:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSXi4-0001G8-8s
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:06:57 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSXi1-0004zi-Cv
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750410414; x=1781946414;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QYpGG5KzrC6gv5uRcEil6mVgb1iSBM8LOyqu6n5cCW4=;
 b=eo88ULD73P6mU7w+r4zB4WHEeGvuQIeah/6iJ4fTQDvwinlO/erGouSO
 A4CDbmsOW37tFsM0A+EMa1jshdfolxw14qAg5PPNKnjKKEdb2QFfLfqFU
 qEXhRlRP4QySxPvJEwN0deAB5FwNq+c2COlfwyUEMFmnAQo88Rs8x91bq
 l5UxgUJ+pvm3a0Web4mg7gh4hN6i1/Wa2MVYmRHegecPWPkjkV8U+wbIj
 3Ot/o9O7cYM/z5q14/kdOGjl9qBQAydrYbdsSM/xh7YUPsU/LILjlsrDX
 jj/MEhZhksbq/CbWr5amKAnAfpoZP/4JORU4hH6k87jGCdjxVoxCp0G5E Q==;
X-CSE-ConnectionGUID: jbZWzAYcQzCscxObrOl6Zw==
X-CSE-MsgGUID: 2iFwNNXqQhm7FheT3108OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="56466694"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="56466694"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:06:53 -0700
X-CSE-ConnectionGUID: uXfGFCjTSfSYwqCumqHTDA==
X-CSE-MsgGUID: kYjhpG7GQV6+QwHSPwIbtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="156670042"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 02:06:49 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 07/16] i386/cpu: Mark CPUID[0x80000005] as reserved for Intel
Date: Fri, 20 Jun 2025 17:27:25 +0800
Message-Id: <20250620092734.1576677-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620092734.1576677-1-zhao1.liu@intel.com>
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Per SDM, 0x80000005 leaf is reserved for Intel CPU, and its current
"assert" check blocks adding new cache model for non-AMD CPUs.

And please note, although Zhaoxin mostly follows Intel behavior,
this leaf is an exception [1].

So, add a compat property "x-vendor-cpuid-only-v2" (for PC machine v10.0
and older) to keep the original behavior. For the machine since v10.1,
check the vendor and encode this leaf as all-0 only for Intel CPU.

This fix also resolves 2 FIXMEs of legacy_l1d_cache_amd and
legacy_l1i_cache_amd:

/*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */

In addition, per AMD's APM, update the comment of CPUID[0x80000005].

[1]: https://lore.kernel.org/qemu-devel/fa16f7a8-4917-4731-9d9f-7d4c10977168@zhaoxin.com/
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC:
 * Only set all-0 for Intel CPU.
 * Add x-vendor-cpuid-only-v2.
---
 hw/i386/pc.c      |  1 +
 target/i386/cpu.c | 11 ++++++++---
 target/i386/cpu.h | 11 ++++++++++-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ad2d6495ebde..9ec3f4db31f3 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -83,6 +83,7 @@
 
 GlobalProperty pc_compat_10_0[] = {
     { TYPE_X86_CPU, "x-consistent-cache", "false" },
+    { TYPE_X86_CPU, "x-vendor-cpuid-only-v2", "false" },
 };
 const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8f174fb971b6..df40d1362566 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -655,7 +655,6 @@ static CPUCacheInfo legacy_l1d_cache = {
     .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
-/*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
 static CPUCacheInfo legacy_l1d_cache_amd = {
     .type = DATA_CACHE,
     .level = 1,
@@ -684,7 +683,6 @@ static CPUCacheInfo legacy_l1i_cache = {
     .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
-/*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
 static CPUCacheInfo legacy_l1i_cache_amd = {
     .type = INSTRUCTION_CACHE,
     .level = 1,
@@ -7889,11 +7887,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = env->cpuid_model[(index - 0x80000002) * 4 + 3];
         break;
     case 0x80000005:
-        /* cache info (L1 cache) */
+        /* cache info (L1 cache/TLB Associativity Field) */
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         }
+
+        if (cpu->vendor_cpuid_only_v2 && IS_INTEL_CPU(env)) {
+            *eax = *ebx = *ecx = *edx = 0;
+            break;
+        }
+
         *eax = (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
                (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
         *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
@@ -9464,6 +9468,7 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
+    DEFINE_PROP_BOOL("x-vendor-cpuid-only-v2", X86CPU, vendor_cpuid_only_v2, true),
     DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8d3ce8a2b678..02cda176798f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2282,9 +2282,18 @@ struct ArchCPU {
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
 
-    /* Only advertise CPUID leaves defined by the vendor */
+    /*
+     * Compatibility bits for old machine types (PC machine v6.0 and older).
+     * Only advertise CPUID leaves defined by the vendor.
+     */
     bool vendor_cpuid_only;
 
+    /*
+     * Compatibility bits for old machine types (PC machine v10.0 and older).
+     * Only advertise CPUID leaves defined by the vendor.
+     */
+    bool vendor_cpuid_only_v2;
+
     /* Only advertise TOPOEXT features that AMD defines */
     bool amd_topoext_features_only;
 
-- 
2.34.1


