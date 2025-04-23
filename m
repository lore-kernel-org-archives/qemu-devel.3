Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224B9C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YFR-0003xY-Ny; Wed, 23 Apr 2025 07:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YF9-0003uh-Fg
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:22 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YF7-0002vw-47
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745407577; x=1776943577;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hFmCDh1g6jFUGO8m7NQhmZ+M7gV0kLnTguTu4AQJhYA=;
 b=ILm2u1j2aUjNZkAGGbAGYxnkVZuTrF2q8+d/8BzGLSNdp0DblD59N/m8
 rI0RWsNCuda8YNYH8QyrrXk0Q9QcTgiPItaY0HToPFjW6qqitTAjZ8cuF
 b5AEG32qWcRswWwPmid2yI9lvhxYQBdRB5LJK5umM1z5Xc9N02qvX26tL
 UBphuCfbQaywn0ES3kuZUGKaLTmCh4V1dcCmvJZVw5w6Ux0lSCfhJUnw4
 85k1BL2CulrN6omdJAVRViJUnAfG2oN1sDnEfzZ+kjTSD/KSEgx9nbx2c
 fLzVPE3htJQGusLs/HErcH4ybTpkjhmeZ6wjzz8E7gQYpiU8rJ53YeGCF g==;
X-CSE-ConnectionGUID: 0tqkhLdeR6WSPtR5xXim4Q==
X-CSE-MsgGUID: lIcY+OS6TmGZQLTEoie26w==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50825254"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="50825254"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 04:26:14 -0700
X-CSE-ConnectionGUID: tsvDa8cqR0qLIgIGbl3vlA==
X-CSE-MsgGUID: FVISKOKWSki5mLfx20fGug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137150725"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 23 Apr 2025 04:26:11 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tejus GK <tejus.gk@nutanix.com>,
 Jason Zeng <jason.zeng@intel.com>,
 Manish Mishra <manish.mishra@nutanix.com>, Tao Su <tao1.su@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 01/10] i386/cpu: Mark CPUID[0x80000005] as reserved for Intel
Date: Wed, 23 Apr 2025 19:46:53 +0800
Message-Id: <20250423114702.1529340-2-zhao1.liu@intel.com>
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

Per SDM, 0x80000005 leaf is reserved for Intel CPU, and its current
"assert" check blocks adding new cache model for non-AMD CPUs.

Therefore, check the vendor and encode this leaf as all-0 for Intel
CPU. And since Zhaoxin mostly follows Intel behavior, apply the vendor
check for Zhaoxin as well.

Note, for !vendor_cpuid_only case, non-AMD CPU would get the wrong
information, i.e., get AMD's cache model for Intel or Zhaoxin CPUs.
For this case, there is no need to tweak for non-AMD CPUs, because
vendor_cpuid_only has been turned on by default since PC machine v6.1.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b64ceaaba46..8fdafa8aedaf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7248,11 +7248,23 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = env->cpuid_model[(index - 0x80000002) * 4 + 3];
         break;
     case 0x80000005:
-        /* cache info (L1 cache) */
-        if (cpu->cache_info_passthrough) {
+        /*
+         * cache info (L1 cache)
+         *
+         * For !vendor_cpuid_only case, non-AMD CPU would get the wrong
+         * information, i.e., get AMD's cache model. It doesn't matter,
+         * vendor_cpuid_only has been turned on by default since
+         * PC machine v6.1.
+         */
+        if (cpu->vendor_cpuid_only &&
+            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+            *eax = *ebx = *ecx = *edx = 0;
+            break;
+        } else if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         }
+
         *eax = (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
                (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
         *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
-- 
2.34.1


