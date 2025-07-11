Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F2EC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAZr-00043Q-UF; Fri, 11 Jul 2025 06:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAYy-0002Fz-RF
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:01:05 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAYw-0005KY-B2
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752228062; x=1783764062;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wKjEW9bps5EkjAhmB9EjInZbONVf26jZWeVxusx0w0s=;
 b=ltjUDTNyNogS8wLHTIKsRmr4QoSGOwgObWivCeURPGtosZHu6jT/EcCQ
 MGOZujeyBOFnyKgPYNz3zvA9z/0RknoAgzF43uCcFA1AyTR1ywBOkGB9j
 GzHuqY82/1Iz4eTbWQ/5BSBBhvaLkA+AlWuFXRBQUpmjJaelM3wZHCopI
 w1lTZiXa/Ycbj2KOhmkCLFUh7xiFQS0SllEKf4BCR4HXLNw1eVHeT8nRT
 2Kz0QqJHOj6pdc268z8v9wHWdOYlAjiVtRG0B2XROyCfy9wjBQaGJXjan
 ZUpRLHf+UGV+B6omZtrVkvcbK/KDBe/CQEq5XgB9IVIE5zQOqP6rnW5xt A==;
X-CSE-ConnectionGUID: a9pytUY3S0mXhM3C81Ho0Q==
X-CSE-MsgGUID: eqc1SY9FQZOAHnrz34n/yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54496301"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="54496301"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:01:01 -0700
X-CSE-ConnectionGUID: I17h21xoSkiwkPVFNCJnTg==
X-CSE-MsgGUID: Nztrt/okTAyj0GRuPPC/uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="160662064"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 11 Jul 2025 03:00:56 -0700
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
Subject: [PATCH v2 08/18] i386/cpu: Mark CPUID[0x80000005] as reserved for
 Intel
Date: Fri, 11 Jul 2025 18:21:33 +0800
Message-Id: <20250711102143.1622339-9-zhao1.liu@intel.com>
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

Per SDM, 0x80000005 leaf is reserved for Intel CPU, and its current
"assert" check blocks adding new cache model for non-AMD CPUs.

And please note, although Zhaoxin mostly follows Intel behavior,
this leaf is an exception [1].

So, with the compat property "x-vendor-cpuid-only-v2", for the machine
since v10.1, check the vendor and encode this leaf as all-0 only for
Intel CPU. In addition, drop lines_per_tag assertion in
encode_cache_cpuid80000005(), since Zhaoxin will use legacy Intel cache
model in this leaf - which doesn't have this field.

This fix also resolves 2 FIXMEs of legacy_l1d_cache_amd and
legacy_l1i_cache_amd:

/*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */

In addition, per AMD's APM, update the comment of CPUID[0x80000005].

[1]: https://lore.kernel.org/qemu-devel/fa16f7a8-4917-4731-9d9f-7d4c10977168@zhaoxin.com/

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v1:
 * Drop lines_per_tag assertion in encode_cache_cpuid80000005().

Changes Since RFC:
 * Only set all-0 for Intel CPU.
 * Add x-vendor-cpuid-only-v2.
---
 target/i386/cpu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b6d41aa110a2..6ab199c9a112 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -497,7 +497,6 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
 static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
 {
     assert(cache->size % 1024 == 0);
-    assert(cache->lines_per_tag > 0);
     assert(cache->associativity > 0);
     assert(cache->line_size > 0);
     return ((cache->size / 1024) << 24) | (cache->associativity << 16) |
@@ -655,7 +654,6 @@ static CPUCacheInfo legacy_l1d_cache = {
     .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
-/*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
 static CPUCacheInfo legacy_l1d_cache_amd = {
     .type = DATA_CACHE,
     .level = 1,
@@ -684,7 +682,6 @@ static CPUCacheInfo legacy_l1i_cache = {
     .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
-/*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
 static CPUCacheInfo legacy_l1i_cache_amd = {
     .type = INSTRUCTION_CACHE,
     .level = 1,
@@ -7886,11 +7883,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = env->cpuid_model[(index - 0x80000002) * 4 + 3];
         break;
     case 0x80000005:
-        /* cache info (L1 cache) */
+        /* cache info (L1 cache/TLB Associativity Field) */
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         }
+
+        if (cpu->vendor_cpuid_only_v2 && IS_INTEL_CPU(env)) {
+            *eax = *ebx = *ecx = *edx = 0;
+            break;
+        }
+
         *eax = (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
                (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
         *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
@@ -9478,6 +9481,7 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
+    DEFINE_PROP_BOOL("x-vendor-cpuid-only-v2", X86CPU, vendor_cpuid_only_v2, true),
     DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
-- 
2.34.1


