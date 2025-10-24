Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6454BCCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBOO-0003Uj-7G; Fri, 24 Oct 2025 02:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBOL-0003UP-7j
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:35:13 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCBOI-0003kG-Hf
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761287711; x=1792823711;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hgZVF5yOjTiT/cqOb4vICgZJdehG/NoYvKjkMr72MLQ=;
 b=jsUUyBHirlmdg3nDAoh0gxnHEN8/Ovv1369plhXApV4ArfSFGWH9zYSu
 oxip7a9YdA/LEoxQtxlmJUpHKZVJjMxCM5m5h8OCMG06MTSP3AZkjrVlH
 BWmK4P3tqbdGqCySiiH0GnTaPxzI88sHa48xZTROYyh32obLlbXPk5obZ
 VP/UbUF53MTcR43S2QHyP7YCAFH9X+f30y8elAZzd8hlLB0TzqAMoePT5
 UUnPQFcX56vXQMYj6PzV8egfEPK+RvQ+MeyfBtGUbG19bOJP24MQdte5h
 7CpyqolU+8cutvhL33LWgs2qdpgjZIzQFrKzemTcGI1TYJ8SV8h6tHoDB w==;
X-CSE-ConnectionGUID: moztmNvrRhCJDXz+4M2gIw==
X-CSE-MsgGUID: kFiUGrFDTz6UXg717BknHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74137883"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="74137883"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 23:35:10 -0700
X-CSE-ConnectionGUID: k+loaOomT4esGWD24LR1Hg==
X-CSE-MsgGUID: JXZ5mRxMRDa0NViqr9Tl8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="184276030"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2025 23:35:06 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 08/20] i386/cpu: Drop pmu check in CPUID 0x1C encoding
Date: Fri, 24 Oct 2025 14:56:20 +0800
Message-Id: <20251024065632.1448606-9-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024065632.1448606-1-zhao1.liu@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

Since CPUID_7_0_EDX_ARCH_LBR will be masked off if pmu is disabled,
there's no need to check CPUID_7_0_EDX_ARCH_LBR feature with pmu.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5b7a81fcdb1b..5cd335bb5574 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8275,11 +8275,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     }
-    case 0x1C:
-        if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
-            x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
-            *edx = 0;
+    case 0x1C: /* Last Branch Records Information Leaf */
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        if (!(env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
+            break;
         }
+        x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
+        *edx = 0; /* EDX is reserved. */
         break;
     case 0x1D: {
         /* AMX TILE, for now hardcoded for Sapphire Rapids*/
-- 
2.34.1


