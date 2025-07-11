Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3479C83F1D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAZF-0003GF-QU; Fri, 11 Jul 2025 06:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAYo-0001wQ-GX
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:00:58 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAYm-0005H0-BA
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752228052; x=1783764052;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NAdqAYTXJZb5DjKif7WlBLOUKuZAQoUj2XZSaZ6yx2o=;
 b=M+gVXMA7vmN+9doMeVXD3HURG8s13xJ6Btr835h9/dIzOQC9RD92icQn
 TaNSc2CRfdo43sijgsh3bxgvjB8qEFg9T6BDQyCjQ0sP34dy2BQSnzNCn
 FKQE1dMMZC+kDsv5F8hAoeCfF6NzJodob6JAShGYYc2KgPdI4JSNKgmY4
 s9TjsehSzU1XG7ExBlRxnoZfy+ibN94Iz11Dollyhmqd8XvPQW9xtNr2a
 QEDLM3M8JPxtjzIwWjWMofD2Pma6j4AXQVW9XtHUv1DHsh6TGzBnDX2P3
 ed9tpESexQX5hx+9kOkGld7ZzIVSsEJt47zBWp0IQrJPt2fd7qrRLO243 w==;
X-CSE-ConnectionGUID: U01vystwQL68AC0gt3GryA==
X-CSE-MsgGUID: eKL86v6SSwWzPWRnO3N4PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54496265"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="54496265"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:00:49 -0700
X-CSE-ConnectionGUID: TL4xReLGT6GyGPh2jf5l2w==
X-CSE-MsgGUID: e8KFagqBT5yjLtE1jLAYew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="160662047"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 11 Jul 2025 03:00:40 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v2 05/18] i386/cpu: Consolidate CPUID 0x4 leaf
Date: Fri, 11 Jul 2025 18:21:30 +0800
Message-Id: <20250711102143.1622339-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711102143.1622339-1-zhao1.liu@intel.com>
References: <20250711102143.1622339-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

Modern Intel CPUs use CPUID 0x4 leaf to describe cache information
and leave space in 0x2 for prefetch and TLBs (even TLB has its own leaf
CPUID 0x18).

And 0x2 leaf provides a descriptor 0xFF to instruct software to check
cache information in 0x4 leaf instead.

Therefore, follow this behavior to encode 0xFF when Intel CPU has 0x4
leaf with "x-consistent-cache=true" for compatibility.

In addition, for older CPUs without 0x4 leaf, still enumerate the cache
descriptor in 0x2 leaf, except the case that there's no descriptor
matching the cache model, then directly encode 0xFF in 0x2 leaf. This
makes sense, as in the 0x2 leaf era, all supported caches should have
the corresponding descriptor.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v1:
 * Fix the typo in comment. (Ewan)
---
 target/i386/cpu.c | 48 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 70ac969a9cdc..37cf591bea8d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -223,7 +223,7 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
  * Return a CPUID 2 cache descriptor for a given cache.
  * If no known descriptor is found, return CACHE_DESCRIPTOR_UNAVAILABLE
  */
-static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
+static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache, bool *unmacthed)
 {
     int i;
 
@@ -240,9 +240,44 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
             }
     }
 
+    *unmacthed |= true;
     return CACHE_DESCRIPTOR_UNAVAILABLE;
 }
 
+/* Encode cache info for CPUID[2] */
+static void encode_cache_cpuid2(X86CPU *cpu,
+                                uint32_t *eax, uint32_t *ebx,
+                                uint32_t *ecx, uint32_t *edx)
+{
+    CPUX86State *env = &cpu->env;
+    CPUCaches *caches = &env->cache_info_cpuid2;
+    int l1d, l1i, l2, l3;
+    bool unmatched = false;
+
+    *eax = 1; /* Number of CPUID[EAX=2] calls required */
+    *ebx = *ecx = *edx = 0;
+
+    l1d = cpuid2_cache_descriptor(caches->l1d_cache, &unmatched);
+    l1i = cpuid2_cache_descriptor(caches->l1i_cache, &unmatched);
+    l2 = cpuid2_cache_descriptor(caches->l2_cache, &unmatched);
+    l3 = cpuid2_cache_descriptor(caches->l3_cache, &unmatched);
+
+    if (!cpu->consistent_cache ||
+        (env->cpuid_min_level < 0x4 && !unmatched)) {
+        /*
+         * Though SDM defines code 0x40 for cases with no L2 or L3. It's
+         * also valid to just ignore l3's code if there's no l2.
+         */
+        if (cpu->enable_l3_cache) {
+            *ecx = l3;
+        }
+        *edx = (l1d << 16) | (l1i <<  8) | l2;
+    } else {
+        *ecx = 0;
+        *edx = CACHE_DESCRIPTOR_UNAVAILABLE;
+    }
+}
+
 /* CPUID Leaf 4 constants: */
 
 /* EAX: */
@@ -7448,16 +7483,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
-        *eax = 1; /* Number of CPUID[EAX=2] calls required */
-        *ebx = 0;
-        if (!cpu->enable_l3_cache) {
-            *ecx = 0;
-        } else {
-            *ecx = cpuid2_cache_descriptor(env->cache_info_cpuid2.l3_cache);
-        }
-        *edx = (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1d_cache) << 16) |
-               (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1i_cache) <<  8) |
-               (cpuid2_cache_descriptor(env->cache_info_cpuid2.l2_cache));
+        encode_cache_cpuid2(cpu, eax, ebx, ecx, edx);
         break;
     case 4:
         /* cache info: needed for Core compatibility */
-- 
2.34.1


