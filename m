Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A912CED240
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCGx-0001NP-Le; Mon, 17 Nov 2025 22:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGw-0001Mt-2r
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:50 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLCGu-0004Cz-HF
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763436049; x=1794972049;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fJBFcQVoKmgeoUmwsBmvZdBtcnTJvhtd89N47vMSmQc=;
 b=HUd3JsPOFNOuXqDwm3fJhSJMBJ4Zh9QaIPsbfXMjIEZO6yB7e+XCsBWE
 fVU2MNxmpkjtH0eUD/2HRhYzEsHafszX/dMhK1QIaJ8JZHDcWfl/blxOh
 cFs4LFVD5mXM1s9boPnLKKXLIv2AGA4Lly16wdkPIiLz/kurhFyfryz0d
 1S6ZmCUjWxoGP+gZpm5cBzdXL9QBY538YaJjMOo+a17/anM2GieMKyIgm
 iscA8ojv15M37BiHoGwpjzmKZ6oo2oD4/lLKuxZPhVhpFYh85C3cNlkss
 Dkc623r7iI/k9wWjdl62qOJ1n8/NWQZENHMQ1CMa/Zu5i+IPckwVquPpM A==;
X-CSE-ConnectionGUID: UfClem4FQGWxqAirqGUnYQ==
X-CSE-MsgGUID: 5OOFnSklSeaQx2L0vDxL/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68053809"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="68053809"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 19:20:48 -0800
X-CSE-ConnectionGUID: eNy4ULW9SyW1mjd4plv9QQ==
X-CSE-MsgGUID: VpWYT4o1RpyXQV4OX8Lw4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; d="scan'208";a="221537190"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2025 19:20:44 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 09/23] i386/cpu: Drop pmu check in CPUID 0x1C encoding
Date: Tue, 18 Nov 2025 11:42:17 +0800
Message-Id: <20251118034231.704240-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118034231.704240-1-zhao1.liu@intel.com>
References: <20251118034231.704240-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

Since CPUID_7_0_EDX_ARCH_LBR will be masked off if pmu is disabled,
there's no need to check CPUID_7_0_EDX_ARCH_LBR feature with pmu.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 56b4c57969c1..62769db3ebb7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8273,11 +8273,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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


