Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B68C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YFs-0004BY-GW; Wed, 23 Apr 2025 07:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YFY-000423-Ko
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:48 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YFW-0002wd-AH
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745407602; x=1776943602;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4q6Or/+6p9mp+08bZ9Ij5ZWPX5A6SM+UoEM54szMPr4=;
 b=MWIMvZpHuNKGw8ax/i7jIDGyaDSdiJ8fZ6+GDo5cz2aKFw0tw2Sb56FO
 iVohAtjEh74DppFeXBnU5JtaGJhkc8asRZibP7eAXS3mL8C586QHVf86k
 Qr4kDJ1gDNAzuLaZKF55qfU5ifR7/bnsWebDUP5gu5jDs4kR9tBYnBGr+
 +A1Q8PkKHcamBs3+J2RGM6UFcXCegCSFYHL4OKbk2co5GVGlqSM4zXNdM
 Y4Sgwzie5Dc208Q8qdJ1CXgs14RkxfbkxlV7Iqgqw8KD0SDmaNSrAHFm/
 MEs2jfLpSylI/N16PrvyxIPETcT+yFm1AMf0QyhJ1EEmFedWIOYJdNDHo w==;
X-CSE-ConnectionGUID: pIepYYMMRtK2jIe/22f/jg==
X-CSE-MsgGUID: AhrETjlEQ7KDx9WLEnaJNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50825314"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="50825314"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 04:26:41 -0700
X-CSE-ConnectionGUID: LydGAKfyTp+US07j7VmH9A==
X-CSE-MsgGUID: MQJmjqnKRnGYG4bE3LBY/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137150812"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 23 Apr 2025 04:26:38 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tejus GK <tejus.gk@nutanix.com>,
 Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>, Tao Su <tao1.su@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 08/10] i386/cpu: Enable 0x1f leaf for SierraForest by default
Date: Wed, 23 Apr 2025 19:47:00 +0800
Message-Id: <20250423114702.1529340-9-zhao1.liu@intel.com>
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

Host SierraForest CPU has 0x1f leaf by default, so that enable it for
Guest CPU by default as well.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 26dc5b6a6a8c..2a518b68e67a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4856,8 +4856,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 3,
-                .note = "with srf-sp cache model",
+                .note = "with srf-sp cache model and 0x1f leaf",
                 .cache_info = &xeon_srf_cache_info,
+                .props = (PropValue[]) {
+                    { "cpuid-0x1f", "on" },
+                }
             },
             { /* end of list */ },
         },
-- 
2.34.1


