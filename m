Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCEAE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWG4O-0002Cy-SM; Fri, 10 Jan 2025 09:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tWG4N-0002CD-EH
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:33:03 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tWG4K-0006eF-5D
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736519580; x=1768055580;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=shkMAuvJ+JiK4YmkroyLIrAGyT0tA05DVR9Yl2i03nc=;
 b=WUCRW47cB0WOzroZrFDyaeXXy9u7BNUFK4Ka3wXZem73tQF96J4ixY+w
 q27BVY24PvjW5ulQGzc9DifoTLvkwZEUcQlZC4mqub9UJbKv/qqX0HZXf
 Z/n+F6o4QsJj02LrzQ+vQwiQrMaO/Ho2hIpNhwxG323DyQhlrnI7u7GXZ
 shz5c7CQbN7sOptvZ9xUwXaVis/5MIAZGRpRggnssAJrIJSLk2ZRD45MN
 1Z8x6YlbWMtqFsPx+1YZxGcmzwZGNjunlsLLTSEy8QWvWKuB2GN/p2yzs
 mIFJCs8w93nh4CMwa8Njr9+wFaAGaOYtJDfmtcOUCTAgvIuodeS34qVx3 A==;
X-CSE-ConnectionGUID: f1VMCgMiSTSDAL33aEz7tQ==
X-CSE-MsgGUID: uxDXRBGQRDqIJM5dzae9/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="62185511"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; d="scan'208";a="62185511"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2025 06:32:58 -0800
X-CSE-ConnectionGUID: 2NcUn1NuQvmTeIli9EwbPg==
X-CSE-MsgGUID: 9odVbZt2TUO8rdPBwBuRkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="108790834"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 10 Jan 2025 06:32:54 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: [PATCH v7 RESEND 2/5] i386/cpu: Support module level cache topology
Date: Fri, 10 Jan 2025 22:51:12 +0800
Message-Id: <20250110145115.1574345-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110145115.1574345-1-zhao1.liu@intel.com>
References: <20250110145115.1574345-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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

Allow cache to be defined at the module level. This increases
flexibility for x86 users to customize their cache topology.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes since Patch v6:
 * Dropped "thread" level cache topology support.
---
 target/i386/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 660ddafc28b5..4728373fdf03 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -247,6 +247,9 @@ static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
     case CPU_TOPOLOGY_LEVEL_CORE:
         num_ids = 1 << apicid_core_offset(topo_info);
         break;
+    case CPU_TOPOLOGY_LEVEL_MODULE:
+        num_ids = 1 << apicid_module_offset(topo_info);
+        break;
     case CPU_TOPOLOGY_LEVEL_DIE:
         num_ids = 1 << apicid_die_offset(topo_info);
         break;
@@ -255,7 +258,7 @@ static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
         break;
     default:
         /*
-         * Currently there is no use case for THREAD and MODULE, so use
+         * Currently there is no use case for THREAD, so use
          * assert directly to facilitate debugging.
          */
         g_assert_not_reached();
-- 
2.34.1


