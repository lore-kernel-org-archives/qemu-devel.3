Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523EED59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2lk-0003As-Hx; Mon, 15 Dec 2025 02:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2lg-00038H-FH
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:17 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2le-0008DF-LR
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765782795; x=1797318795;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EzPVzaUr3I3OOvLOdifr5YptjvugY0i5WiQfN8ijd28=;
 b=dbm2FPU64e1xUCpTZmnrX44RtEyBpvXidooxVNdfatPB7kTKJqKw2paN
 FQ20Z2e5RoxjQ1ZPXO1vlQ0pKhEKGQOQEFezGqz2nLz8FxLBN+36p/bCE
 RoQb2wEmYDur9eVojIk/Y6SBHCCY/QJaxFzTMVc2tFtRpbVi1IwchVYm3
 mpCQmdwV/Jj2oYX/oWkdH1s6DzL/AsDHho0ILSA26EmDgObk5OPq/UGJq
 XZSZXb7h596T+g1za/q1B4DIDJD5cBOPvciCidro0D/d6ZF4UHhkJYgTj
 av0WLm+akPPt14/UvE9dSPdZlwpK/cVa1B7ugcaCBpBMJ3J4LwjiuasB0 A==;
X-CSE-ConnectionGUID: T0fyzjupT7yH8wzUwTG86g==
X-CSE-MsgGUID: MpwIVsHHRLSNmMa7c1A/aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="90332256"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="90332256"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 23:13:14 -0800
X-CSE-ConnectionGUID: 7KQqUEnTSESt3Q9ULSvq/w==
X-CSE-MsgGUID: rVdwKmeHSqqlz09nSNJcrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197265959"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 14 Dec 2025 23:13:12 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 07/11] i386/cpu: Allow cache to be shared at thread level
Date: Mon, 15 Dec 2025 15:37:39 +0800
Message-Id: <20251215073743.4055227-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215073743.4055227-1-zhao1.liu@intel.com>
References: <20251215073743.4055227-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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
index 41ff4058871a..1deed542561c 100644
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


