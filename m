Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB4DC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEEn-0007O2-Ip; Mon, 14 Jul 2025 04:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDun-0004j0-Op
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:47:58 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubDul-0007P2-OS
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752479276; x=1784015276;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KWmh+nOlncMmEQC89o+Q3i7UNZgMqD2lsLZ/ETngSXM=;
 b=dEY7ZiITllXoMf2r6WPGpLRbacdAQ9asyPQh1+NOtRuszRRW8vMpO9C6
 K7cDjPNdAvkD6FlQMcdbmty9JLf505KxTkq8qfEMxS53DoKzPWcVpt2g5
 iJoP+v9sVU98dEPeCnh7fOLUgwFIs4eKjNc701ecWuC+XnGTii4SOxv/j
 7EUN6IZt22XRet0Qo8rxsU6bOGWLpsyaZ6faTsc8BzoeQWJRCL4HtHeyP
 6TOqvOCiifDeC12FEFabeyRg+AIlGk07105955TxDMU6LGhllUnGaeqFo
 v6pg6hKWdGq8fL10UrofHVoKf/lrwPOuBe/tkAj8X/tkNrfBZ3NP+XaOK Q==;
X-CSE-ConnectionGUID: /hA30Cm0Tlq+BdGRm38zRQ==
X-CSE-MsgGUID: q93AHBEnTnGvLW4BvUpFbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58324685"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="58324685"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 00:47:55 -0700
X-CSE-ConnectionGUID: eMe8W2QcS/+eKNVOV+We3g==
X-CSE-MsgGUID: sUdgvKc2S7qSd/wvbLrQjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="156952231"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 14 Jul 2025 00:47:52 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Tao Su <tao1.su@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Babu Moger <babu.moger@amd.com>
Subject: [PATCH v2 7/7] i386/cpu: Honor maximum value for
 CPUID.8000001DH.EAX[25:14]
Date: Mon, 14 Jul 2025 16:08:59 +0800
Message-Id: <20250714080859.1960104-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714080859.1960104-1-zhao1.liu@intel.com>
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

CPUID.8000001DH:EAX[25:14] is "NumSharingCache", and the number of
logical processors sharing this cache is the value of this field
incremented by 1. Because of its width limitation, the maximum value
currently supported is 4095.

Though at present Q35 supports up to 4096 CPUs, by constructing a
specific topology, the width of the APIC ID can be extended beyond 12
bits. For example, using `-smp threads=33,cores=9,modules=9` results in
a die level offset of 6 + 4 + 4 = 14 bits, which can also cause
overflow. Check and honor the maximum value as CPUID.04H did.

Cc: Babu Moger <babu.moger@amd.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since RFC v1 [*]:
 * Correct the RFC's description, now there's the overflow case. Provide
   an overflow example.

RFC:
 * Although there are currently no overflow cases, to avoid any
   potential issue, add the overflow check, just as I did for Intel.

[*]: https://lore.kernel.org/qemu-devel/20250227062523.124601-5-zhao1.liu@intel.com/
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fedeeea151ee..eceda9865b8f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -558,7 +558,8 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
 
     *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
                (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
-    *eax |= max_thread_ids_for_cache(topo_info, cache->share_level) << 14;
+    /* Bits 25:14 - NumSharingCache: maximum 4095. */
+    *eax |= MIN(max_thread_ids_for_cache(topo_info, cache->share_level), 4095) << 14;
 
     assert(cache->line_size > 0);
     assert(cache->partitions > 0);
-- 
2.34.1


