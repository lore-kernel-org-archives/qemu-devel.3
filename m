Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA63C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 09:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSXhw-0000wv-Bt; Fri, 20 Jun 2025 05:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSXhu-0000w1-BL
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:06:46 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSXhs-0004zi-DU
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750410405; x=1781946405;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=65qXWX5jHQ5ZGTW9Q8QusnykV+YUDGSqPzotpWRYlLo=;
 b=JEz8S1+TKB7AsTg7OHqA494cfZN3ESnJ8q7Jz7HrWC6n9qum0/+vCgdU
 tZArSTmkL4ZrbAqdbq7Okwh8gcPaCaJI0J6RU2stEy+rlAYGDYFDoueuW
 wP6SXaYYASLJqk/wSOsh21etIOZIQyb3gYcSM+k+ESMIGDawV2QbNjbRc
 LQujD84LJGoYJhpafyoI5fvvNtzWpxPEeHSuRbYta4WsNAdxVbrPrXYE7
 6k6VGfnk9101cCTWkARQaGycmOSFpYQOwaH7Lghb6HJu/5DNa8Z9SbYjb
 onGJ0uNOSU3ANuPMQiFDUykIPadES5BAP8nbJ9mtMDnBmTE9fnmW+o/et A==;
X-CSE-ConnectionGUID: po/1I9QhR0KWwETB5lKNSQ==
X-CSE-MsgGUID: MgpI8uDtT+Kzn1DNK83Ggg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="56466617"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="56466617"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:06:44 -0700
X-CSE-ConnectionGUID: VYLEjsR1SOGnzxmIf8l0CA==
X-CSE-MsgGUID: N3+QkdSwTW2eRz8dwn0pIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="156669950"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 02:06:40 -0700
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
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 05/16] i386/cpu: Consolidate CPUID 0x4 leaf
Date: Fri, 20 Jun 2025 17:27:23 +0800
Message-Id: <20250620092734.1576677-6-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620092734.1576677-1-zhao1.liu@intel.com>
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 48 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2f895bf13523..a06aa1d629dc 100644
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
 
+/* Encode cache info for CPUID[4] */
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
@@ -7451,16 +7486,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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


