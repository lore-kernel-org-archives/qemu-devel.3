Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4A3C10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 15:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzeh1-0008Cf-Li; Wed, 24 Apr 2024 11:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzegz-00089z-Hv
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:37:53 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzegx-0005j1-R6
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713973072; x=1745509072;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OlYKuDPPHSu3h5BsrEeYzI1MeMMYvSAts1dW6DU/vTY=;
 b=B9aSFJqjWMq3WGxNu+0+CE9T06qDGtjoqqTGo/gx9uARo6JQ8+y6QiBs
 QzHz4p2SlDZWo95rD1r7aEie/i9ClSSx6fkPC58cgWpsxr507ydSd2CyZ
 BhXi0yZFLfJjGYbYpLC2SGWWSVkRaWFc0m5r/opqPYymrlzNp9bg/C9tu
 L8CeAn1+rXxqKIw+ZCLk9/VtyFtlWLLqoJaeywm0Qu5MzU57j8xF1RRxC
 3U8+lBo6ihvCM7UsoeUxlV77uRtZbiGWMrOBr/34ifXqPWC/1UNXJQNG4
 5r1dr6AISw6u2CqDwS1IU/yVa6WrebncLmHQg5eJHHI+KVIiKpPPjJaOZ w==;
X-CSE-ConnectionGUID: WY+9eBVYTK+uuhUfAeNRRQ==
X-CSE-MsgGUID: jwxRCQPER5KosoMhLuucAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="12545864"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; d="scan'208";a="12545864"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 08:37:39 -0700
X-CSE-ConnectionGUID: XXNVp/cPSSarPdr4uQB0CA==
X-CSE-MsgGUID: UveUyuf9THWITkMsV4ys6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; d="scan'208";a="25363356"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 24 Apr 2024 08:37:35 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v11 21/21] i386/cpu: Use CPUCacheInfo.share_level to encode
 CPUID[0x8000001D].EAX[bits 25:14]
Date: Wed, 24 Apr 2024 23:49:29 +0800
Message-Id: <20240424154929.1487382-22-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424154929.1487382-1-zhao1.liu@intel.com>
References: <20240424154929.1487382-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

CPUID[0x8000001D].EAX[bits 25:14] NumSharingCache: number of logical
processors sharing cache.

The number of logical processors sharing this cache is
NumSharingCache + 1.

After cache models have topology information, we can use
CPUCacheInfo.share_level to decide which topology level to be encoded
into CPUID[0x8000001D].EAX[bits 25:14].

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
Changes since v7:
 * Renamed max_processor_ids_for_cache() to max_thread_ids_for_cache().
 * Dropped Michael/Babu's ACKed/Tested tags since the code change.
 * Re-added Yongwei's Tested tag For his re-testing.

Changes since v3:
 * Explained what "CPUID[0x8000001D].EAX[bits 25:14]" means in the
   commit message. (Babu)

Changes since v1:
 * Used cache->share_level as the parameter in
   max_processor_ids_for_cache().
---
 target/i386/cpu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6ab517a59aee..369c5ee54fa6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -478,20 +478,12 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
                                        uint32_t *eax, uint32_t *ebx,
                                        uint32_t *ecx, uint32_t *edx)
 {
-    uint32_t num_sharing_cache;
     assert(cache->size == cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
 
     *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
                (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
-
-    /* L3 is shared among multiple cores */
-    if (cache->level == 3) {
-        num_sharing_cache = 1 << apicid_die_offset(topo_info);
-    } else {
-        num_sharing_cache = 1 << apicid_core_offset(topo_info);
-    }
-    *eax |= (num_sharing_cache - 1) << 14;
+    *eax |= max_thread_ids_for_cache(topo_info, cache->share_level) << 14;
 
     assert(cache->line_size > 0);
     assert(cache->partitions > 0);
-- 
2.34.1


