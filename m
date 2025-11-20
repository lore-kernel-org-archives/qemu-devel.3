Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958AACF64BB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 06:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLyTA-0005Cn-EU; Thu, 20 Nov 2025 01:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyT6-000579-Ab
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:36 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyT3-0005ql-Cx
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763621313; x=1795157313;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3EMUWkHSCA/tfmKappgbzqr0Ir4rokgyHvMpaedvWFs=;
 b=JrTI++X8HFePnrzUaoVk7MpwXuamt7/5fELTAe8vHLvEBwMuOzuh+J2K
 7L5LDObS7fe7JmlAhJe7gqdVh+XnA72KVSrEFOxxl9d9wmuH7frtmh5pR
 2DpdbvmbYgfBIQsZ9MM959QChwAbHKjw3kWKhTZmFnYGaiyL4oc009M8L
 xKvV48ZV8OG6LPFEiLZe1H2lnNH864vQgyJyIwBZmDY2QaaUua4utbUcB
 IapwVoBrugyXqDpnOkHQzRSEiDik0zBVg9yPwqtdf9SbbldPKX6Eoevoy
 UEtxpSnQAiBJneJHUMgLIJTN7nc12d30KGgSR7J6vQGWc95SifWXLX8KT A==;
X-CSE-ConnectionGUID: ApjU5gZ9TyG8kv+r9c3VfQ==
X-CSE-MsgGUID: 0qJsNSkzQduEcH3rwDux0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65572553"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="65572553"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 22:48:28 -0800
X-CSE-ConnectionGUID: Q59W+5vXQommWYSKxiUHnQ==
X-CSE-MsgGUID: ToipA4PaTV2jIbPGbBDDjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="191296126"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 19 Nov 2025 22:48:27 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 06/10] i386/cpu: Allow cache to be shared at thread level
Date: Thu, 20 Nov 2025 15:10:26 +0800
Message-Id: <20251120071030.961230-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120071030.961230-1-zhao1.liu@intel.com>
References: <20251120071030.961230-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

In CPUID 0x4 leaf, it's possible to make the cache privated at thread
level when there's no HT within the core. In this case, while cache per
thread and cache per core are essentially identical, their topology
information differs in CPUID 0x4.

Diamond Rapids assigns the L1 i/d cache at the thread level. To allow
accurate emulation of DMR cache topology, remove the cache-per-thread
restriction in max_thread_ids_for_cache(), which enables CPUID 0x4 to
support cache per thread topology.

Given that after adding thread-level support, the topology offset
information required by max_thread_ids_for_cache() can be sufficiently
provided by apicid_offset_by_topo_level(), so it's straightforward to
re-implement max_thread_ids_for_cache() based on
apicid_offset_by_topo_level() to reduce redundant duplicate codes.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 53 ++++++++++++++---------------------------------
 1 file changed, 15 insertions(+), 38 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 118ce43e4267..c5f1f5d18d07 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -304,33 +304,30 @@ static void encode_cache_cpuid2(X86CPU *cpu,
                        ((t) == UNIFIED_CACHE) ? CACHE_TYPE_UNIFIED : \
                        0 /* Invalid value */)
 
-static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
-                                         enum CpuTopologyLevel share_level)
+static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
+                                            enum CpuTopologyLevel topo_level)
 {
-    uint32_t num_ids = 0;
-
-    switch (share_level) {
+    switch (topo_level) {
+    case CPU_TOPOLOGY_LEVEL_THREAD:
+        return 0;
     case CPU_TOPOLOGY_LEVEL_CORE:
-        num_ids = 1 << apicid_core_offset(topo_info);
-        break;
+        return apicid_core_offset(topo_info);
     case CPU_TOPOLOGY_LEVEL_MODULE:
-        num_ids = 1 << apicid_module_offset(topo_info);
-        break;
+        return apicid_module_offset(topo_info);
     case CPU_TOPOLOGY_LEVEL_DIE:
-        num_ids = 1 << apicid_die_offset(topo_info);
-        break;
+        return apicid_die_offset(topo_info);
     case CPU_TOPOLOGY_LEVEL_SOCKET:
-        num_ids = 1 << apicid_pkg_offset(topo_info);
-        break;
+        return apicid_pkg_offset(topo_info);
     default:
-        /*
-         * Currently there is no use case for THREAD, so use
-         * assert directly to facilitate debugging.
-         */
         g_assert_not_reached();
     }
+    return 0;
+}
 
-    return num_ids - 1;
+static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
+                                         enum CpuTopologyLevel share_level)
+{
+    return (1 << apicid_offset_by_topo_level(topo_info, share_level)) - 1;
 }
 
 static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
@@ -398,26 +395,6 @@ static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
     return 0;
 }
 
-static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
-                                            enum CpuTopologyLevel topo_level)
-{
-    switch (topo_level) {
-    case CPU_TOPOLOGY_LEVEL_THREAD:
-        return 0;
-    case CPU_TOPOLOGY_LEVEL_CORE:
-        return apicid_core_offset(topo_info);
-    case CPU_TOPOLOGY_LEVEL_MODULE:
-        return apicid_module_offset(topo_info);
-    case CPU_TOPOLOGY_LEVEL_DIE:
-        return apicid_die_offset(topo_info);
-    case CPU_TOPOLOGY_LEVEL_SOCKET:
-        return apicid_pkg_offset(topo_info);
-    default:
-        g_assert_not_reached();
-    }
-    return 0;
-}
-
 static uint32_t cpuid1f_topo_type(enum CpuTopologyLevel topo_level)
 {
     switch (topo_level) {
-- 
2.34.1


