Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06B5C47DDF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7Ra-0007BC-VJ; Wed, 31 Jan 2024 05:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rV7QG-0005Xu-LG
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:02:28 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rV7QD-0008RJ-Mn
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706695341; x=1738231341;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ws6SEsvA0gV8jPYJi1lTDlMM4H0faGxYCTjuKCM2OZo=;
 b=lI0qF/8JddKtJxs27FeZAloXimpZSvyqYuNdPoBirxoe4QlfbHuir4TF
 BVat/yxQ5fw6pzJLKHWzeFL5GCaIJYwNz8ATS171OM1aYuk2ge6GpKxFH
 qyXogrpwa+EgJIIsUd1472R17REgYxnrCXPVNsT0pC3nDzlOO3yW0IZC2
 ZjRssEmDfxDe9fh7ELjLUwIYIu6O7y5UDQ1HLJMsQnqIMjmAOytRtHik3
 V04eOTRJ2RzhI8HgfB+StUlltDuiNTnWp6eT9AahB0JLZh8SgQYaqw6A5
 S8CLN0TzBWk/Q68WGOa2XGKK40l9mBcXnbB99okhjexgozWD+5/OqPqTh g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="25033102"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="25033102"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 02:02:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4036359"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 31 Jan 2024 02:02:05 -0800
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
Subject: [PATCH v8 20/21] i386/cpu: Use CPUCacheInfo.share_level to encode
 CPUID[4]
Date: Wed, 31 Jan 2024 18:13:49 +0800
Message-Id: <20240131101350.109512-21-zhao1.liu@linux.intel.com>
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

CPUID[4].EAX[bits 25:14] is used to represent the cache topology for
Intel CPUs.

After cache models have topology information, we can use
CPUCacheInfo.share_level to decide which topology level to be encoded
into CPUID[4].EAX[bits 25:14].

And since with the helper max_processor_ids_for_cache(), the filed
CPUID[4].EAX[bits 25:14] (original virable "num_apic_ids") is parsed
based on cpu topology levels, which are verified when parsing -smp, it's
no need to check this value by "assert(num_apic_ids > 0)" again, so
remove this assert().

Additionally, wrap the encoding of CPUID[4].EAX[bits 31:26] into a
helper to make the code cleaner.

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v7:
 * Renamed max_processor_ids_for_cache() to max_thread_ids_for_cache().
   (Xiaoyao)
 * Dropped Michael/Babu's ACKed/Tested tags since the code change.
 * Re-added Yongwei's Tested tag For his re-testing.

Changes since v1:
 * Used "enum CPUTopoLevel share_level" as the parameter in
   max_processor_ids_for_cache().
 * Made cache_into_passthrough case also use
   max_processor_ids_for_cache() and max_core_ids_in_package() to
   encode CPUID[4]. (Yanan)
 * Renamed the title of this patch (the original is "i386: Use
   CPUCacheInfo.share_level to encode CPUID[4].EAX[bits 25:14]").
---
 target/i386/cpu.c | 76 ++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f167df4f6df1..fbfebdc2caf3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -235,22 +235,53 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
                        ((t) == UNIFIED_CACHE) ? CACHE_TYPE_UNIFIED : \
                        0 /* Invalid value */)
 
+static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
+                                         enum CPUTopoLevel share_level)
+{
+    uint32_t num_ids = 0;
+
+    switch (share_level) {
+    case CPU_TOPO_LEVEL_CORE:
+        num_ids = 1 << apicid_core_offset(topo_info);
+        break;
+    case CPU_TOPO_LEVEL_DIE:
+        num_ids = 1 << apicid_die_offset(topo_info);
+        break;
+    case CPU_TOPO_LEVEL_PACKAGE:
+        num_ids = 1 << apicid_pkg_offset(topo_info);
+        break;
+    default:
+        /*
+         * Currently there is no use case for SMT and MODULE, so use
+         * assert directly to facilitate debugging.
+         */
+        g_assert_not_reached();
+    }
+
+    return num_ids - 1;
+}
+
+static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
+{
+    uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
+                               apicid_core_offset(topo_info));
+    return num_cores - 1;
+}
 
 /* Encode cache info for CPUID[4] */
 static void encode_cache_cpuid4(CPUCacheInfo *cache,
-                                int num_apic_ids, int num_cores,
+                                X86CPUTopoInfo *topo_info,
                                 uint32_t *eax, uint32_t *ebx,
                                 uint32_t *ecx, uint32_t *edx)
 {
     assert(cache->size == cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
 
-    assert(num_apic_ids > 0);
     *eax = CACHE_TYPE(cache->type) |
            CACHE_LEVEL(cache->level) |
            (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
-           ((num_cores - 1) << 26) |
-           ((num_apic_ids - 1) << 14);
+           (max_core_ids_in_package(topo_info) << 26) |
+           (max_thread_ids_for_cache(topo_info, cache->share_level) << 14);
 
     assert(cache->line_size > 0);
     assert(cache->partitions > 0);
@@ -6246,10 +6277,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1i_cache) <<  8) |
                (cpuid2_cache_descriptor(env->cache_info_cpuid2.l2_cache));
         break;
-    case 4: {
-        int addressable_cores_width;
-        int addressable_threads_width;
-
+    case 4:
         /* cache info: needed for Core compatibility */
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, count, eax, ebx, ecx, edx);
@@ -6261,55 +6289,42 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
 
                 if (cores_per_pkg > 1) {
-                    addressable_cores_width = apicid_pkg_offset(&topo_info) -
-                                              apicid_core_offset(&topo_info);
-
                     *eax &= ~0xFC000000;
-                    *eax |= ((1 << addressable_cores_width) - 1) << 26;
+                    *eax |= max_core_ids_in_package(&topo_info) << 26;
                 }
                 if (host_vcpus_per_cache > threads_per_pkg) {
-                    /* Share the cache at package level. */
-                    addressable_threads_width = apicid_pkg_offset(&topo_info);
-
                     *eax &= ~0x3FFC000;
-                    *eax |= ((1 << addressable_threads_width) - 1) << 14;
+
+                    /* Share the cache at package level. */
+                    *eax |= max_thread_ids_for_cache(&topo_info,
+                                CPU_TOPO_LEVEL_PACKAGE) << 14;
                 }
             }
         } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
             *eax = *ebx = *ecx = *edx = 0;
         } else {
             *eax = 0;
-            addressable_cores_width = apicid_pkg_offset(&topo_info) -
-                                      apicid_core_offset(&topo_info);
 
             switch (count) {
             case 0: /* L1 dcache info */
-                addressable_threads_width = apicid_core_offset(&topo_info);
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
-                                    (1 << addressable_threads_width),
-                                    (1 << addressable_cores_width),
+                                    &topo_info,
                                     eax, ebx, ecx, edx);
                 break;
             case 1: /* L1 icache info */
-                addressable_threads_width = apicid_core_offset(&topo_info);
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
-                                    (1 << addressable_threads_width),
-                                    (1 << addressable_cores_width),
+                                    &topo_info,
                                     eax, ebx, ecx, edx);
                 break;
             case 2: /* L2 cache info */
-                addressable_threads_width = apicid_core_offset(&topo_info);
                 encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
-                                    (1 << addressable_threads_width),
-                                    (1 << addressable_cores_width),
+                                    &topo_info,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
                 if (cpu->enable_l3_cache) {
-                    addressable_threads_width = apicid_die_offset(&topo_info);
                     encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
-                                        (1 << addressable_threads_width),
-                                        (1 << addressable_cores_width),
+                                        &topo_info,
                                         eax, ebx, ecx, edx);
                     break;
                 }
@@ -6320,7 +6335,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             }
         }
         break;
-    }
     case 5:
         /* MONITOR/MWAIT Leaf */
         *eax = cpu->mwait.eax; /* Smallest monitor-line size in bytes */
-- 
2.34.1


