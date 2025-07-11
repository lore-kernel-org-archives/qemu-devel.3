Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB706C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAwy-0000wt-T7; Fri, 11 Jul 2025 06:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAwR-0008NI-8k
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:25:22 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAwH-0003Qk-9A
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752229509; x=1783765509;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=khbballI6gmKT0z4b4zjwmq+f9oB1sL9HydrYDHkPNA=;
 b=RGJZFAQ58q37N5osRBRHcda8Tmq6hteh/ydNPzwgdh3a9wWsyNGxElqo
 JjHBumjbvSwHfCQ0N6pSNKF4ftMv+EWJQUYyFGy7Za6uCiycJ1b3+hGNJ
 KUx96prSX2FyQuUaU5OVmKM8gvSOWe5TLeWh92cLbaZGrwAH/7hj+weHh
 dnGVtEZr1LljnyqSX5etDcMXGX1j8REjTBJeL92KXcO9Ed/w/cV8hEH/M
 AK0bRVJSm7hGy8p4uXMMH7xhiQGNnb4dgnOE2v+HdDFTKPio0gLQNxQhc
 CuWSMrpjGse7+pbiWCO5uDYFk/E7jmbJM0Rse6Rr3fGkHcW3/NVR6F20e Q==;
X-CSE-ConnectionGUID: ZhbngMq1QNiRo4Q9T+FCHQ==
X-CSE-MsgGUID: kSQzPNCMSma09EMtTF0tcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65875737"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="65875737"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:25:07 -0700
X-CSE-ConnectionGUID: 1uYeHUXTSxCeAwhjCzEtfg==
X-CSE-MsgGUID: N7utgOwQQ8CCcFckL6GSxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="156894422"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 11 Jul 2025 03:25:04 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Jason Zeng <jason.zeng@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Tejus GK <tejus.gk@nutanix.com>, Manish Mishra <manish.mishra@nutanix.com>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v2 8/9] i386/cpu: Enable 0x1f leaf for SapphireRapids by
 default
Date: Fri, 11 Jul 2025 18:46:02 +0800
Message-Id: <20250711104603.1634832-9-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711104603.1634832-1-zhao1.liu@intel.com>
References: <20250711104603.1634832-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

Host SapphireRapids CPU has 0x1f leaf by default, so that enable it for
Guest CPU by default as well.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC:
 * Rename the property to "x-force-cpuid-0x1f". (Igor)
---
 target/i386/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 02198872ede7..44394fa72248 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5079,8 +5079,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 4,
-                .note = "with spr-sp cache model",
+                .note = "with spr-sp cache model and 0x1f leaf",
                 .cache_info = &xeon_spr_cache_info,
+                .props = (PropValue[]) {
+                    { "x-force-cpuid-0x1f", "on" },
+                }
             },
             { /* end of list */ }
         }
-- 
2.34.1


