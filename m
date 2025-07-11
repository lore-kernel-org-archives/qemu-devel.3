Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208A1C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAa0-0004K5-Hy; Fri, 11 Jul 2025 06:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAZ7-0002im-Bg
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:01:13 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAZ5-0005KY-8M
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752228071; x=1783764071;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OWvNFKsV7hzM+qTU1YrQuD91g8tHqECnL/vc/zNLCno=;
 b=a27ORQnYHLL/KAcSjHt66pZcxrzrtHYy0S+E5DJuPojj2iPoq3zw5wNL
 cYBZ8cg0O/YoEWA4AhxqxpAyLGMq0KoKBkg18i0kccCxD8p/h62Q/vg16
 XcK9SLKKRZxVWuBd145YebrITpOWTDn+9CRw6wTsbIX5zZUo6qungTDin
 HAbIuU6RwTJln4f6xblJOqqE5j2RaTXAvtoneoLiexV/BtJhnYNtnOyEV
 eMh7L5dOXa+n2QuHKvz+jPnAYoQObWv4bLjIUyr5gvwUfVbHYU23VzzO7
 /BVCuBxLD6kVU1089+oTY5AwdOlb9KSCTAH3R+ApEmdAyW+LkqwqHDU0q A==;
X-CSE-ConnectionGUID: WPKQmhRnT6m61F7PQjUUmw==
X-CSE-MsgGUID: aweWttU0QRyS2o1lBMaOxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54496345"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="54496345"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:01:10 -0700
X-CSE-ConnectionGUID: uXa0yX4nQbq6F4DewAEYdQ==
X-CSE-MsgGUID: 2anHszCTTw20zsbfqlyKJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="160662076"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 11 Jul 2025 03:01:05 -0700
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
Subject: [PATCH v2 10/18] i386/cpu: Fix CPUID[0x80000006] for Intel CPU
Date: Fri, 11 Jul 2025 18:21:35 +0800
Message-Id: <20250711102143.1622339-11-zhao1.liu@intel.com>
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

Per SDM, Intel supports CPUID[0x80000006]. But only L2 information is
encoded in ECX (note that L2 associativity field encodings rules
consistent with AMD are used), all other fields are reserved.

Therefore, make the following changes to CPUID[0x80000006]:
 * Check the vendor in CPUID[0x80000006] and just encode L2 to ECX for
   Intel.
 * Drop the lines_per_tag assertion, since AMD supports this field but
   Intel doesn't. And this field can be easily checked via cpuid tool
   in Guest.
 * Apply the encoding change of Intel for Zhaoxin as well [1].

This fix also resolves the FIXME of legacy_l2_cache_amd:

/*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */

In addition, per AMD's APM, update the comment of CPUID[0x80000006].

[1]: https://lore.kernel.org/qemu-devel/c522ebb5-04d5-49c6-9ad8-d755b8998988@zhaoxin.com/

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v1:
 * Drop the lines_per_tag assertion in encode_cache_cpuid80000006(),
   since it breaks the case running Intel CPUs (with cache model) on
   PC/Q35 machine v10.0.

Changes Since RFC:
 * Check vendor_cpuid_only_v2 instead of vendor_cpuid_only.
 * Move lines_per_tag assert check into encode_cache_cpuid80000006().
---
 target/i386/cpu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e0d5a39e477c..609efb10ddb5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -529,16 +529,15 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
 {
     assert(l2->size % 1024 == 0);
     assert(l2->associativity > 0);
-    assert(l2->lines_per_tag > 0);
     assert(l2->line_size > 0);
     *ecx = ((l2->size / 1024) << 16) |
            (X86_ENC_ASSOC(l2->associativity) << 12) |
            (l2->lines_per_tag << 8) | (l2->line_size);
 
+    /* For Intel, EDX is reserved. */
     if (l3) {
         assert(l3->size % (512 * 1024) == 0);
         assert(l3->associativity > 0);
-        assert(l3->lines_per_tag > 0);
         assert(l3->line_size > 0);
         *edx = ((l3->size / (512 * 1024)) << 18) |
                (X86_ENC_ASSOC(l3->associativity) << 12) |
@@ -710,7 +709,6 @@ static CPUCacheInfo legacy_l2_cache = {
     .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
-/*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */
 static CPUCacheInfo legacy_l2_cache_amd = {
     .type = UNIFIED_CACHE,
     .level = 2,
@@ -7902,11 +7900,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
         break;
     case 0x80000006:
-        /* cache info (L2 cache) */
+        /* cache info (L2 cache/TLB/L3 cache) */
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         }
+
+        if (cpu->vendor_cpuid_only_v2 &&
+            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+            *eax = *ebx = 0;
+            encode_cache_cpuid80000006(env->cache_info_cpuid4.l2_cache,
+                                       NULL, ecx, edx);
+            break;
+        }
+
         *eax = (X86_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) |
                (L2_DTLB_2M_ENTRIES << 16) |
                (X86_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) |
@@ -7915,6 +7922,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (L2_DTLB_4K_ENTRIES << 16) |
                (X86_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
                (L2_ITLB_4K_ENTRIES);
+
         encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
                                    cpu->enable_l3_cache ?
                                    env->cache_info_amd.l3_cache : NULL,
-- 
2.34.1


