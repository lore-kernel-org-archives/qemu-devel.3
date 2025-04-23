Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AC9C369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YG2-0004Qv-57; Wed, 23 Apr 2025 07:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YFf-000438-U5
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:53 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YFd-0002wd-TY
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745407610; x=1776943610;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dpAgjvFZpHGJGhZZSq1pgwGCVmFSsMCmYasOajOmwzE=;
 b=l1AhIlYutXweH1Aqw2eI7iOyvkz8bjZEzukqLSI03y/zRxgtzc/inD4f
 7HFYmJI8tWkAs53lfv5TmdWxL6HcaYvXNI4JqQ/h1RpPTMeMGZ5o3mqZu
 AEGTX1pb56UnJJnBWZ8kEOhhCXH3MCz+ZtiVWC/FhlwIfTPTsQfebHwno
 DVELj5mVHMacgJxIbec3ezwaI2SiqW/894cTr4aVk0ldOoKfYFc+3Q55k
 xrvr5XTxyIGCwMqPBdZ/d5Canrsl6FE5Vt3qCypOtrOu9Z7KI/Rx6xUCU
 a2WH5eLlvH4Tir7xGqSB8DHXT+FfxUtj48px91kiAMSPQCvt95FJU2dsJ A==;
X-CSE-ConnectionGUID: E/J/rI/4T5SpfKU/wCfQ+w==
X-CSE-MsgGUID: 4NcVgJ1oQ2eNs8jwI7Ao+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50825334"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="50825334"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 04:26:49 -0700
X-CSE-ConnectionGUID: ja6nxVJHQhOL5H5ugAyeqw==
X-CSE-MsgGUID: +liuPxK7SUe9OSjxja4HXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137150833"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 23 Apr 2025 04:26:45 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tejus GK <tejus.gk@nutanix.com>,
 Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>, Tao Su <tao1.su@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 10/10] i386/cpu: Enable 0x1f leaf for SapphireRapids by default
Date: Wed, 23 Apr 2025 19:47:02 +0800
Message-Id: <20250423114702.1529340-11-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423114702.1529340-1-zhao1.liu@intel.com>
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

Host SapphireRapids CPU has 0x1f leaf by default, so that enable it for
Guest CPU by default as well.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 38b330aaed4f..5573a9fd6c61 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4548,8 +4548,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 4,
-                .note = "with spr-sp cache model",
+                .note = "with spr-sp cache model and 0x1f leaf",
                 .cache_info = &xeon_spr_cache_info,
+                .props = (PropValue[]) {
+                    { "cpuid-0x1f", "on" },
+                }
             },
             { /* end of list */ }
         }
-- 
2.34.1


