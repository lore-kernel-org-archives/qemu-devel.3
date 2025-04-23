Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4FCC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YFo-00046E-FZ; Wed, 23 Apr 2025 07:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YFc-00042i-Pw
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:51 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YFa-0002wd-No
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745407607; x=1776943607;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ru8y57hh6APWX2y18YyGmRmqQ+sT6KAsNwnfHzd4IY4=;
 b=i5/HkXz1ebqTrnqg2CUdqvjVgV9F/wX3wQCeZfmUTwuKCNfuBJEtsya1
 4OoQNQO/4hURGIHYXe8Ddc2zSrMHlIkrJycmJYNL7FUD6Z1BMfEg5dM9k
 BPWWNn7Q8j2MAHF2EFz8f13FZs3SjAYBEMxaO0ZUDxNMwzXcPdYxx6WDa
 u0I69JL6zX2qGlVrDAOIVdi/+LYbTGMoAMBC49np3sGUqVqKWRfwZNz5b
 yfZu3B3Xi6rG2+FHD6sGXPsLZL2bx1OM4K38gsPzu6vpcuD44N88/sueq
 l4Jmq+McqvTp4q3Tgyd10eNSnFt3BmX1eYi0gQj/aNzKM49pPC5EA2RUj g==;
X-CSE-ConnectionGUID: plag3YijQmOZDKrMpKJ9nw==
X-CSE-MsgGUID: KqPWrMKiStKFTIVSC5nWtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50825326"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="50825326"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 04:26:45 -0700
X-CSE-ConnectionGUID: W9p10uIKSGGYNjTOX4fqYQ==
X-CSE-MsgGUID: b72GhZUaTw6dE7wyqdtjbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137150820"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 23 Apr 2025 04:26:42 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tejus GK <tejus.gk@nutanix.com>,
 Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>, Tao Su <tao1.su@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 09/10] i386/cpu: Enable 0x1f leaf for GraniteRapids by default
Date: Wed, 23 Apr 2025 19:47:01 +0800
Message-Id: <20250423114702.1529340-10-zhao1.liu@intel.com>
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

Host GraniteRapids CPU has 0x1f leaf by default, so that enable it for
Guest CPU by default as well.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2a518b68e67a..38b330aaed4f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4706,8 +4706,11 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 3,
-                .note = "with gnr-sp cache model",
+                .note = "with gnr-sp cache model and 0x1f leaf",
                 .cache_info = &xeon_gnr_cache_info,
+                .props = (PropValue[]) {
+                    { "cpuid-0x1f", "on" },
+                }
             },
             { /* end of list */ },
         },
-- 
2.34.1


