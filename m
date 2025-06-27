Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C58C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 03:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUznB-0002gl-EY; Thu, 26 Jun 2025 23:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUzn8-0002g3-Pv
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:30:18 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUzn6-0007SZ-OU
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750995017; x=1782531017;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aVTkAGWI/2ZaKLWpgm+xpYMqxlxfusnFITw89gyWokU=;
 b=RR1tVGNvklHe4lZRwtXMeAkdNeROlIdehCJmIyBqrSdJ4Pw9mlahN9sQ
 chi5mxEbc9DlCsiyS4ZHEbv2vpYfYrxbA7hgFuJ/yMDbzFEHdgG0Z2+N1
 THbpo5ZJ6IYRKhIB1ntXSvt1cfuK+ddF/fwR5WNmwSDH6XpRxdZ2kOC1N
 /C5kXlbWlalNin2iUxsraEzHCyRn6OGugWHlBSO0S9U39Ms36OmtTXMp0
 CBS9jTDyW+r2p/lVbcSqglH4jH9yHiUnZrVUwU9C6cFCAB8KLFEhGQwUo
 ZsX1oOn9X2ApCLQ1sChkUFPkeAjoDEBouV+ZO5OB5FkbvWK/dpXnd+c1S w==;
X-CSE-ConnectionGUID: 6HbzFv/oQd6lAIRWzhq8fw==
X-CSE-MsgGUID: 7ZJ/u1uuR8+zJCDuvXLpiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53247135"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="53247135"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 20:30:15 -0700
X-CSE-ConnectionGUID: tmkYkKvMSgSoCJlVrioU+w==
X-CSE-MsgGUID: WFO+GGajRPGIvOEnNJPuiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="157084629"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 26 Jun 2025 20:30:13 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/4] i386/cpu: Mark EBX/ECX/EDX in CPUID 0x80000000 leaf as
 reserved for Intel
Date: Fri, 27 Jun 2025 11:51:26 +0800
Message-Id: <20250627035129.2755537-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627035129.2755537-1-zhao1.liu@intel.com>
References: <20250627035129.2755537-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

Per SDM,

80000000H EAX Maximum Input Value for Extended Function CPUID Information.
          EBX Reserved.
          ECX Reserved.
          EDX Reserved.

EBX/ECX/EDX in CPUID 0x80000000 leaf are reserved. Intel is using 0x0
leaf to encode vendor.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c7f157a0f71c..867e08236540 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8280,9 +8280,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x80000000:
         *eax = env->cpuid_xlevel;
-        *ebx = env->cpuid_vendor1;
-        *edx = env->cpuid_vendor2;
-        *ecx = env->cpuid_vendor3;
+
+        if (cpu->vendor_cpuid_only_v2 && IS_INTEL_CPU(env)) {
+            *ebx = *ecx = *edx = 0;
+        } else {
+            *ebx = env->cpuid_vendor1;
+            *edx = env->cpuid_vendor2;
+            *ecx = env->cpuid_vendor3;
+        }
         break;
     case 0x80000001:
         *eax = env->cpuid_version;
-- 
2.34.1


