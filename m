Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F655C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEF7-0007zR-0g; Mon, 14 Jul 2025 04:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDum-0004hS-1U
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:47:57 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDuj-0007Nf-9t
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752479273; x=1784015273;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UbCihhGNTf3oDGMfXmVjGFL0hmBQppSwgqh5BrCmBO4=;
 b=MaOsJKtJ3h7KMJjluIa7yDUHTIY7ieiz+UIlyL2KSCknFUkNWdQ3fOUj
 0upk8KgFGoACo+5/YU6JWZcOAA2h2WlIMJfB4VqfRE9jvhn7UaSu3dDNY
 P8AOgJPWJmViknOdEMMV7c1i2Ib1QAuiJfC3c4GeuRsgGPpLFTWJW9w4t
 Dx1mCaBPyXS36y/IPkzVSAIERTq0SLIy3dnG8RQETzz72qqP96Hq+vuN5
 do2XdGY1KSPOfOfvXUoRZceTO8YzYkA2wKTLszpRMxGq11Vu5WjTg0yu/
 UxPETh6+08ok+7ZAnIH8ns260rg4I1OgokGNAXaiAngKaDC/wwm4GTkpx Q==;
X-CSE-ConnectionGUID: HfHqeAq5RKijs7IpMqGNHQ==
X-CSE-MsgGUID: 6qfClBuLRTalEN2ABCQLmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58324682"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="58324682"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 00:47:52 -0700
X-CSE-ConnectionGUID: KK0kA3mBTRmvxSXc9gwxSw==
X-CSE-MsgGUID: OM6wARDFQTi/hWtqCiNzpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="156952225"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 14 Jul 2025 00:47:49 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Qian Wen <qian.wen@intel.com>
Subject: [PATCH v2 6/7] i386/cpu: Fix overflow of cache topology fields in
 CPUID.04H
Date: Mon, 14 Jul 2025 16:08:58 +0800
Message-Id: <20250714080859.1960104-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714080859.1960104-1-zhao1.liu@intel.com>
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Qian Wen <qian.wen@intel.com>

According to SDM, CPUID.0x4:EAX[31:26] indicates the Maximum number of
addressable IDs for processor cores in the physical package. If we
launch over 64 cores VM, the 6-bit field will overflow, and the wrong
core_id number will be reported.

Since the HW reports 0x3f when the intel processor has over 64 cores,
limit the max value written to EAX[31:26] to 63, so max num_cores should
be 64.

For EAX[14:25], though at present Q35 supports up to 4096 CPUs, by
constructing a specific topology, the width of the APIC ID can be
extended beyond 12 bits. For example, using `-smp threads=33,cores=9,
modules=9` results in a die level offset of 6 + 4 + 4 = 14 bits, which
can also cause overflow.  check and honor the maximum value for
EAX[14:25] as well.

In addition, for host-cache-info case, also apply the same checks and
fixes.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Qian Wen <qian.wen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since New v1 [**]:
 * Provide an overflow example of EAX[14:25].

Changes Since Original v4 [*]:
 * Rebase on addressable ID fixup.
 * Drop R/b tags since the code base changes.
 * Teak bits 25-14 as well and add the comment.
 * Fix overflow for host-cache-info case.

[*]: original v4: https://lore.kernel.org/qemu-devel/20230829042405.932523-3-qian.wen@intel.com/
[**]: new v1: https://lore.kernel.org/qemu-devel/20250227062523.124601-4-zhao1.liu@intel.com/
---
 target/i386/cpu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 67a371e23b22..fedeeea151ee 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -347,11 +347,17 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
     assert(cache->size == cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
 
+    /*
+     * The following fields have bit-width limitations, so consider the
+     * maximum values to avoid overflow:
+     * Bits 25-14: maximum 4095.
+     * Bits 31-26: maximum 63.
+     */
     *eax = CACHE_TYPE(cache->type) |
            CACHE_LEVEL(cache->level) |
            (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
-           (max_core_ids_in_package(topo_info) << 26) |
-           (max_thread_ids_for_cache(topo_info, cache->share_level) << 14);
+           (MIN(max_core_ids_in_package(topo_info), 63) << 26) |
+           (MIN(max_thread_ids_for_cache(topo_info, cache->share_level), 4095) << 14);
 
     assert(cache->line_size > 0);
     assert(cache->partitions > 0);
@@ -7928,13 +7934,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
 
                 *eax &= ~0xFC000000;
-                *eax |= max_core_ids_in_package(topo_info) << 26;
+                *eax |= MIN(max_core_ids_in_package(topo_info), 63) << 26;
                 if (host_vcpus_per_cache > threads_per_pkg) {
                     *eax &= ~0x3FFC000;
 
                     /* Share the cache at package level. */
-                    *eax |= max_thread_ids_for_cache(topo_info,
-                                CPU_TOPOLOGY_LEVEL_SOCKET) << 14;
+                    *eax |= MIN(max_thread_ids_for_cache(topo_info,
+                                CPU_TOPOLOGY_LEVEL_SOCKET), 4095) << 14;
                 }
             }
         } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
-- 
2.34.1


