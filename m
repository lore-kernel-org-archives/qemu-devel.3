Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D66C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 06:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnX1r-000387-Q2; Thu, 27 Feb 2025 01:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tnX1q-00036W-9o
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:05:50 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tnX1n-0001rg-QT
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740636348; x=1772172348;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qiT+QrYO3wwFWmjRfccfmoms2UuARhbBEpByws33hpk=;
 b=Yu1LfftYbAPzHesdCLfn3aBl9p0BB3v3JwsipBv0jhiSzwETXTW6uQpt
 FD68oPNEXNCV0xNQhPhm5o9T7UmSKJ7zawKKADqsX8sF+JsJzNvNSY9J+
 S4jJGztov0SBDDIk4daWxFV1QbYJNC+u8kDrjJCuVRrHApl1uhleaGRvd
 OudI//eAUd4IOjdwrl9ORzQljHhlvKUUKMj/6wEmlRByb6NkTFBqLYb6P
 Ls7Fp4OtuX2ZfOe67f6kIlOURyC/QL54fT8NsoLr+OkZqrfBXrUzyJ+WR
 Ieyfh2xqfStxLeMc0P8ev5KeZ/GYjHES9dnl9idAaOMADCF1sFPppf8V5 w==;
X-CSE-ConnectionGUID: Qbcb0QQ5QMuLczJ00fO9YQ==
X-CSE-MsgGUID: knpNynyLTPyHmNQzQVIZPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52148197"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="52148197"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 22:05:47 -0800
X-CSE-ConnectionGUID: XXADOOOaRJeC3CINS2+gTw==
X-CSE-MsgGUID: cgPca28VTTGR4xRTkLqNkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="121938313"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 26 Feb 2025 22:05:44 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chuang Xu <xuchuangxclwt@bytedance.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Babu Moger <babu.moger@amd.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 4/4] i386/cpu: Honor maximum value for
 CPUID.8000001DH.EAX[25:14]
Date: Thu, 27 Feb 2025 14:25:23 +0800
Message-Id: <20250227062523.124601-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227062523.124601-1-zhao1.liu@intel.com>
References: <20250227062523.124601-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

CPUID.8000001DH:EAX[25:14] is "NumSharingCache", and the number of
logical processors sharing this cache is the value of this field
incremented by 1. Because of its width limitation, the maximum value
currently supported is 4095.

Though at present Q35 supports up to 4096 CPUs, to prevent potential
overflow issues from further increasing the number of CPUs in the
future, check and honor the maximum value as CPUID.04H did.

Cc: Babu Moger <babu.moger@amd.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
RFC:
 * Although there are currently no overflow cases, to avoid any
   potential issue, add the overflow check, just as I did for Intel.
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d75175b0850a..7ca9740e8c97 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -493,7 +493,8 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
 
     *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
                (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
-    *eax |= max_thread_ids_for_cache(topo_info, cache->share_level) << 14;
+    /* Bits 25:14 - NumSharingCache: maximum 4095. */
+    *eax |= MIN(max_thread_ids_for_cache(topo_info, cache->share_level), 4095) << 14;
 
     assert(cache->line_size > 0);
     assert(cache->partitions > 0);
-- 
2.34.1


