Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF54EC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAYz-00028l-PR; Fri, 11 Jul 2025 06:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAYW-0001mK-WD
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:00:39 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAYR-0005FJ-O7
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752228032; x=1783764032;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ROoVRKY7dce0T2TAcHTZK8KJkdKbNMAzZALpbA8p8yk=;
 b=WcaDsf1ZupC8g10+QzQhtiqa+2PmrcTaYz3cUQfj7wEah5xQiyPEEDf6
 AnumZtWgQbLEmkYr7DaFhk/xShQadgQ2ayokNPwxqS+tMNCKSHtmeDdX2
 cLpN9/TpsTdbdZrQJGSfN8HCSw6qWWrJ4a692AbHLtc2NtdAISneRlaTu
 bhZP0Mt37tml3gWYfAFT9IlJRlylbXCLgSbRiHI6YtqPpFpVBX5mslAd8
 tsHgUG0sX9Le7PUqBvQMi2WrhShm28qwqO8nHdh7/QpHO5gXix/Zi/9xl
 tdBFPz8znyAI1+oEoHmUV8wCpZYUMLOizVNIdQwsjvAQikF7yxA2Ujc2A g==;
X-CSE-ConnectionGUID: vVcQQSMoSRSpC1HqLnULSg==
X-CSE-MsgGUID: iFzQxaf2QmiA5Wmu7Bp6Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54496216"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="54496216"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:00:31 -0700
X-CSE-ConnectionGUID: kEwFLIVOTGajOgISGLQ+zg==
X-CSE-MsgGUID: I/V0E3r4RNuATUyrQCZTfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="160662034"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 11 Jul 2025 03:00:26 -0700
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
Subject: [PATCH v2 02/18] i386/cpu: Add descriptor 0x49 for CPUID 0x2 encoding
Date: Fri, 11 Jul 2025 18:21:27 +0800
Message-Id: <20250711102143.1622339-3-zhao1.liu@intel.com>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The legacy_l2_cache (2nd-level cache: 4 MByte, 16-way set associative,
64 byte line size) corresponds to descriptor 0x49, but at present
cpuid2_cache_descriptors doesn't support descriptor 0x49 because it has
multiple meanings.

The 0x49 is necessary when CPUID 0x2 and 0x4 leaves have the consistent
cache model, and use legacy_l2_cache as the default L2 cache.

Therefore, add descriptor 0x49 to represent general L2 cache.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v2:
 * Fix the typo in comment. (Dapeng)
---
 target/i386/cpu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6983b5f70457..75932579542a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -127,7 +127,18 @@ struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
                .associativity = 8,  .line_size = 64, },
     [0x48] = { .level = 2, .type = UNIFIED_CACHE,     .size =   3 * MiB,
                .associativity = 12, .line_size = 64, },
-    /* Descriptor 0x49 depends on CPU family/model, so it is not included */
+    /*
+     * Descriptor 0x49 has 2 cases:
+     *  - 2nd-level cache: 4 MByte, 16-way set associative, 64 byte line size.
+     *  - 3rd-level cache: 4MB, 16-way set associative, 64-byte line size
+     *    (Intel Xeon processor MP, Family 0FH, Model 06H).
+     *
+     * When it represents L3, then it depends on CPU family/model. Fortunately,
+     * the legacy cache/CPU models don't have such special L3. So, just add it
+     * to represent the general L2 case.
+     */
+    [0x49] = { .level = 2, .type = UNIFIED_CACHE,     .size =   4 * MiB,
+               .associativity = 16, .line_size = 64, },
     [0x4A] = { .level = 3, .type = UNIFIED_CACHE,     .size =   6 * MiB,
                .associativity = 12, .line_size = 64, },
     [0x4B] = { .level = 3, .type = UNIFIED_CACHE,     .size =   8 * MiB,
-- 
2.34.1


