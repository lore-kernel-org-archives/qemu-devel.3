Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A927E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBfq-00055L-Fj; Thu, 19 Dec 2024 03:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tOBfp-00054r-CI
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:14:21 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tOBfn-0000IM-RF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734596060; x=1766132060;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V6ehyfXRT03O4FtDAD3WitXv+2QkhSbJcwip23ZQEPY=;
 b=VKqYxBc3oQJlKUhjS6FeBMNbytHj6xGjEpixfJYl2grjGEJq5Nl6jtnu
 WvZhx0yhLnv3fWd2Y7cnfsov2auGYr7ZGudDYJdsS2wo9DNu3ydI5hYLj
 ApE/eEXaqN9SfjEhTeRovBB1jRIQTOmkcZP/qJbXVyYhJboH+Q0lyOoxv
 hgQTowkB4MAXbLftORRoY4kyluNB+YhUia0P4Ok+5COsSG2pbdim7vQ5t
 Q2hfaIta2NwJlOmBmABfY4miW2xz/XofObfVuSWek0BASZZ0AAfC3PYKs
 UFqlYL+V/PScNPVuSv3RDgTHZ3LLbNaw7fHp+Tzu+KjMVjDv6r2swdA+M g==;
X-CSE-ConnectionGUID: mjZIrjhXQy+dmMX8rQvG3w==
X-CSE-MsgGUID: F6PSy2S5SM2Mc1W2qT2BVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34378619"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="34378619"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 00:14:18 -0800
X-CSE-ConnectionGUID: UdqI/7S7RU+8fDk7cvji/Q==
X-CSE-MsgGUID: UGRcWDG8RRON72z74aDHVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="129097518"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 19 Dec 2024 00:14:15 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: [PATCH v6 1/4] i386/cpu: Support thread and module level cache
 topology
Date: Thu, 19 Dec 2024 16:32:34 +0800
Message-Id: <20241219083237.265419-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219083237.265419-1-zhao1.liu@intel.com>
References: <20241219083237.265419-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

Allow cache to be defined at the thread and module level. This
increases flexibility for x86 users to customize their cache topology.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 target/i386/cpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 525339945920..87ffb9840cc1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -243,9 +243,15 @@ static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
     uint32_t num_ids = 0;
 
     switch (share_level) {
+    case CPU_TOPOLOGY_LEVEL_THREAD:
+        num_ids = 1;
+        break;
     case CPU_TOPOLOGY_LEVEL_CORE:
         num_ids = 1 << apicid_core_offset(topo_info);
         break;
+    case CPU_TOPOLOGY_LEVEL_MODULE:
+        num_ids = 1 << apicid_module_offset(topo_info);
+        break;
     case CPU_TOPOLOGY_LEVEL_DIE:
         num_ids = 1 << apicid_die_offset(topo_info);
         break;
@@ -253,10 +259,6 @@ static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
         num_ids = 1 << apicid_pkg_offset(topo_info);
         break;
     default:
-        /*
-         * Currently there is no use case for THREAD and MODULE, so use
-         * assert directly to facilitate debugging.
-         */
         g_assert_not_reached();
     }
 
-- 
2.34.1


