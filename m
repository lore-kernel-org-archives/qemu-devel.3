Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAF3D3E793
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 05:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTZSz-0000dc-DN; Thu, 11 Dec 2025 00:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTZSs-0000cP-SW
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 00:43:47 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTZSr-0001OC-6f
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 00:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765431825; x=1796967825;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6oiSLxx2zin740/NCyRplOfAx3FyLNTrt2eo2NqNpGA=;
 b=GtbMjO2BzX3GvcqW+KxcykqZ8tmub/7rOla8axSe1NYhYnRIbdf6vzjR
 sWE/SijdRScw/U/l2URMaDjODLivnH/HyeHQjGJAoGJTKgFuDrw+g0elK
 9qes9GBMy3tnuoxJ78EgFNQCHHXhjQpjnvaWhNjw8qaxqlhMvvu1obE0C
 adsWCbVqMgBv8iHmU3XHwWeNOWs7ZT7IhADOXh2r/i2MWqQ7HQ8rGOQq6
 ll9vG0fKQKkcwLcAKJgDe2hGPkeMnRcBZjXkJl0/iNxY5ePceeIDOFU/p
 v576XLFxnSA3/gx2UTlWJNglNKhwdgO8Suf0mASlsyq5Uf0kN6NCVrkPx g==;
X-CSE-ConnectionGUID: x3DmeCPuRGmu6nPjoyYPnA==
X-CSE-MsgGUID: kdylc6qUS+qNsH6saEixKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="66409861"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="66409861"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 21:43:44 -0800
X-CSE-ConnectionGUID: QhiEBwHTRwuV3cmxtIgpeA==
X-CSE-MsgGUID: M4jIW4ehTxqoyGKyrI4PYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="227366043"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 10 Dec 2025 21:43:41 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 Xin Li <xin@zytor.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 06/22] i386/cpu: Use x86_ext_save_areas[] for CPUID.0XD
 subleaves
Date: Thu, 11 Dec 2025 14:07:45 +0800
Message-Id: <20251211060801.3600039-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211060801.3600039-1-zhao1.liu@intel.com>
References: <20251211060801.3600039-1-zhao1.liu@intel.com>
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

The x86_ext_save_areas[] is expected to be well initialized by
accelerators and its xstate detail information cannot be changed by
user. So use x86_ext_save_areas[] to encode CPUID.0XD subleaves directly
without other hardcoding & masking.

And for arch LBR, KVM fills its xstate in x86_ext_save_areas[] via
host_cpuid(). The info obtained this way matches what would be retrieved
from x86_cpu_get_supported_cpuid() (since KVM just fills CPUID with the
host xstate info directly anyway). So just use the initialized
x86_ext_save_areas[] instead of calling x86_cpu_get_supported_cpuid().

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v4:
 - Update commit meesage to explain x86_cpu_get_supported_cpuid() is not
   necessary.

Changes Since v3:
 - New commit.
---
 target/i386/cpu.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 70a282668f72..f3bf7f892214 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8188,20 +8188,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             }
         } else if (count == 0xf && cpu->enable_pmu
                    && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
-            x86_cpu_get_supported_cpuid(0xD, count, eax, ebx, ecx, edx);
+            const ExtSaveArea *esa = &x86_ext_save_areas[count];
+
+            *eax = esa->size;
+            *ebx = esa->offset;
+            *ecx = esa->ecx;
         } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
             const ExtSaveArea *esa = &x86_ext_save_areas[count];
 
-            if (x86_cpu_xsave_xcr0_components(cpu) & (1ULL << count)) {
-                *eax = esa->size;
-                *ebx = esa->offset;
-                *ecx = esa->ecx &
-                       (ESA_FEATURE_ALIGN64_MASK | ESA_FEATURE_XFD_MASK);
-            } else if (x86_cpu_xsave_xss_components(cpu) & (1ULL << count)) {
-                *eax = esa->size;
-                *ebx = 0;
-                *ecx = 1;
-            }
+            *eax = esa->size;
+            *ebx = esa->offset;
+            *ecx = esa->ecx;
         }
         break;
     }
-- 
2.34.1


