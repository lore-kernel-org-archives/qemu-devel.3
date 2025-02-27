Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7D5C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 06:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnX1p-00036b-IR; Thu, 27 Feb 2025 01:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tnX1n-00036G-Ek
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:05:47 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tnX1l-0001rg-Da
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740636345; x=1772172345;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EVIsxSSZriTw2kvygEI0oP9xW0eaFvK4V4qMxUUiO5I=;
 b=a9bsiASfqdMg8mLfsadDrOLDBDraXdyFse9ZNTNmXr3Q/bqsstepnQW0
 kIC5DNHSkLWumpSlkfh0xzpI6+4ogzqWVFaUIDG2P5SqNZFYefJTr51yD
 KOc7ha4u/FW6J94ZXFcL5dUZdX39RnIgWK+DZhLwWm2LwZf/df3I5pLxd
 HrYC/9pios7hWXkqfVqPtGb7sKQLlwhbaIIgtAexvWJPGBIwMByGL/i1j
 IIYVYJccMZKxUq/VtJ3povs3XZnIU0vPMIlheFz+7lbJyO1tf3lVL0bF8
 mdQDCRhMrME+bzmhEY+d3I0xgUVy33dVJw8dh2mc6eKxIV7zJulg9DDJL g==;
X-CSE-ConnectionGUID: wNexKweqRxWDgbAwOafuNg==
X-CSE-MsgGUID: tlgRV1byTy2ixqI3VjgzDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52148188"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="52148188"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 22:05:44 -0800
X-CSE-ConnectionGUID: YsGzfQyyQY+8+GxibU1LLg==
X-CSE-MsgGUID: S/1P4d4oQ26HXDRZsN+3cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="121938294"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 26 Feb 2025 22:05:41 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chuang Xu <xuchuangxclwt@bytedance.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Babu Moger <babu.moger@amd.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Qian Wen <qian.wen@intel.com>
Subject: [PATCH 3/4] i386/cpu: Fix overflow of cache topology fields in
 CPUID.04H
Date: Thu, 27 Feb 2025 14:25:22 +0800
Message-Id: <20250227062523.124601-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227062523.124601-1-zhao1.liu@intel.com>
References: <20250227062523.124601-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

From: Qian Wen <qian.wen@intel.com>

According to SDM, CPUID.0x4:EAX[31:26] indicates the Maximum number of
addressable IDs for processor cores in the physical package. If we
launch over 64 cores VM, the 6-bit field will overflow, and the wrong
core_id number will be reported.

Since the HW reports 0x3f when the intel processor has over 64 cores,
limit the max value written to EAX[31:26] to 63, so max num_cores should
be 64.

For EAX[14:25], though at present Q35 supports up to 4096 CPUs, to
prevent potential overflow issues from further increasing the number of
CPUs in the future, check and honor the maximum value for EAX[14:25] as
well.

In addition, for host-cache-info case, also apply the same checks and
fixes.

Signed-off-by: Qian Wen <qian.wen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since original v4 [*]:
 * Rebase on addressable ID fixup.
 * Drop R/b tags since the code base changes.
 * Teak bits 25-14 as well and add the comment.
 * Fix overflow for host-cache-info case.

[*]: original v4: https://lore.kernel.org/qemu-devel/20230829042405.932523-3-qian.wen@intel.com/
---
 target/i386/cpu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ae6c8bfd8b5e..d75175b0850a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -280,11 +280,17 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
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
@@ -6743,13 +6749,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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


