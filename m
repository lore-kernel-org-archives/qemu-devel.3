Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37416C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YFp-00046r-5A; Wed, 23 Apr 2025 07:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YFB-0003v0-Ms
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:26 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YF9-0002vs-CV
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745407579; x=1776943579;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1ySg7f0MXv81a/sh1bBBvbxV263DWqo05jeGhcaGOgU=;
 b=hOGRjMEBAlVMpTSxyF4H0h6Enjk1PXpnAkyF450dORVBbyqYKzvo3VBV
 88xEeemw+Kpu0PRBISEhbWi+oszxH4hwWD6IxYe2RbroKxBmyxWH5ooyR
 tXIiRqfKJrA9DsYsmvXfdamZ1lzF/3M20kFgXRjfdNdSVpqYuJ5QFw1e2
 VdGHPBaF7zkgIvFKNqB2KBve9m5EJAPhq91dPwSwd4ma79i7Uzdf5PHCD
 1Tvdt0lsMmV+jw0SsIvEavPGPh0j4pe+zpCDwSkkXu7rwiKr37pfAK3vZ
 cUJB6KA5TaHptTRfEUloqV1HGURbNgKOo/D5MlDVQpQbHOWlcmu9uVaU5 A==;
X-CSE-ConnectionGUID: WFbaVZoPQzOixBMEDilUKg==
X-CSE-MsgGUID: Kx6n0vXDRKONpr+BIEeSFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50825262"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="50825262"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 04:26:18 -0700
X-CSE-ConnectionGUID: J/zQ7+W7SpG7028dkKk6iw==
X-CSE-MsgGUID: 0bwUUFdxSS+gDtdPahEu6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137150732"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 23 Apr 2025 04:26:15 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tejus GK <tejus.gk@nutanix.com>,
 Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>, Tao Su <tao1.su@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 02/10] i386/cpu: Fix CPUID[0x80000006] for Intel CPU
Date: Wed, 23 Apr 2025 19:46:54 +0800
Message-Id: <20250423114702.1529340-3-zhao1.liu@intel.com>
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

Per SDM, Intel supports CPUID[0x80000006]. But only L2 information is
encoded in ECX (note that L2 associativity field encodings rules
consistent with AMD are used), all other fields are reserved.

Therefore, make the following changes to CPUID[0x80000006]:
 * Rename AMD_ENC_ASSOC to X86_ENC_ASSOC since Intel also uses the same
   rules. (While there are some slight differences between the rules in
   AMD APM v4.07 no.40332 and those in the current QEMU, generally they
   are consistent.)
 * Check the vendor in CPUID[0x80000006] and just encode L2 to ECX for
   Intel.
 * Assert L2's lines_per_tag is not 0 for AMD, and assert it is 0 for
   Intel.
 * Apply the encoding change of Intel for Zhaoxin as well.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8fdafa8aedaf..5119d7aa4150 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -436,8 +436,8 @@ static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
 
 #define ASSOC_FULL 0xFF
 
-/* AMD associativity encoding used on CPUID Leaf 0x80000006: */
-#define AMD_ENC_ASSOC(a) (a <=   1 ? a   : \
+/* x86 associativity encoding used on CPUID Leaf 0x80000006: */
+#define X86_ENC_ASSOC(a) (a <=   1 ? a   : \
                           a ==   2 ? 0x2 : \
                           a ==   4 ? 0x4 : \
                           a ==   8 ? 0x6 : \
@@ -460,19 +460,19 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
 {
     assert(l2->size % 1024 == 0);
     assert(l2->associativity > 0);
-    assert(l2->lines_per_tag > 0);
     assert(l2->line_size > 0);
     *ecx = ((l2->size / 1024) << 16) |
-           (AMD_ENC_ASSOC(l2->associativity) << 12) |
+           (X86_ENC_ASSOC(l2->associativity) << 12) |
            (l2->lines_per_tag << 8) | (l2->line_size);
 
+    /* For Intel, EDX is reserved. */
     if (l3) {
         assert(l3->size % (512 * 1024) == 0);
         assert(l3->associativity > 0);
         assert(l3->lines_per_tag > 0);
         assert(l3->line_size > 0);
         *edx = ((l3->size / (512 * 1024)) << 18) |
-               (AMD_ENC_ASSOC(l3->associativity) << 12) |
+               (X86_ENC_ASSOC(l3->associativity) << 12) |
                (l3->lines_per_tag << 8) | (l3->line_size);
     } else {
         *edx = 0;
@@ -7277,15 +7277,25 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
+        } else if (cpu->vendor_cpuid_only &&
+            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+            *eax = *ebx = 0;
+            assert(env->cache_info_cpuid4.l2_cache->lines_per_tag == 0);
+            encode_cache_cpuid80000006(env->cache_info_cpuid4.l2_cache,
+                                       NULL, ecx, edx);
+            break;
         }
-        *eax = (AMD_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) |
+
+        *eax = (X86_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) |
                (L2_DTLB_2M_ENTRIES << 16) |
-               (AMD_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) |
+               (X86_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) |
                (L2_ITLB_2M_ENTRIES);
-        *ebx = (AMD_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) |
+        *ebx = (X86_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) |
                (L2_DTLB_4K_ENTRIES << 16) |
-               (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
+               (X86_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
                (L2_ITLB_4K_ENTRIES);
+
+        assert(env->cache_info_amd.l2_cache->lines_per_tag > 0);
         encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
                                    cpu->enable_l3_cache ?
                                    env->cache_info_amd.l3_cache : NULL,
-- 
2.34.1


