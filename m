Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CD9C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 09:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSXhl-0000pT-6k; Fri, 20 Jun 2025 05:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSXhj-0000m9-9H
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:06:35 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSXhg-0004zi-HS
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750410393; x=1781946393;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rP+3yIcVeLITlIOtxWUE53+6FM+a8wwBuKQISSU42FQ=;
 b=ahNPlHuPqEpSapTctKR17D+biHHg9iihYHXqujkwhhG22wsMDVMArSyQ
 UvxapnNP+1CD8qnk3WeS/pkK9BDkH7gmXqID954FLzUcFHWegu2TwrZEQ
 Oi2oPO4JVvU9Zv52cdJKMdbMwyC2W9jcQ+QG+FszahSRiuHGvoipRxQ/P
 z/XgF3MD/qTe9aXbU36nDto/egAwHLLMqW8ISzISp3dFe2473YGJXGMAE
 vkjuhB9FXojtwBcuzvntkPWeUkWLSPmIqC+JCbz16Fpu2I8Fx9/WgpV4K
 gooz8XyZ0gUIuRmaKXJmA/7wj8M5rGszj8Xb7c/fYPZSu4DYG59QmS35T w==;
X-CSE-ConnectionGUID: Z1eHX2jQQEecTL5FfraJSg==
X-CSE-MsgGUID: H53/NOqnQyKSS1EoisaVjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="56466542"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="56466542"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:06:30 -0700
X-CSE-ConnectionGUID: QlVPWsGrQ9KlMS6Oe37+hQ==
X-CSE-MsgGUID: dwkM4O6vRBqtU+YqP+El+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="156669847"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 02:06:26 -0700
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
Subject: [PATCH 02/16] i386/cpu: Add descriptor 0x49 for CPUID 0x2 encoding
Date: Fri, 20 Jun 2025 17:27:20 +0800
Message-Id: <20250620092734.1576677-3-zhao1.liu@intel.com>
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

The legacy_l2_cache (2nd-level cache: 4 MByte, 16-way set associative,
64 byte line size) corresponds to descriptor 0x49, but at present
cpuid2_cache_descriptors doesn't support descriptor 0x49 because it has
multiple meanings.

The 0x49 is necessary when CPUID 0x2 and 0x4 leaves have the consistent
cache model, and use legacy_l2_cache as the default l2 cache.

Therefore, add descriptor 0x49 to represent general l2 cache.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e398868a3f8d..995766c9d74c 100644
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
+     * When it represents l3, then it depends on CPU family/model. Fortunately,
+     * the legacy cache/CPU models don't have such special l3. So, just add it
+     * to represent the general l2 case.
+     */
+    [0x49] = { .level = 2, .type = UNIFIED_CACHE,     .size =   4 * MiB,
+               .associativity = 16, .line_size = 64, },
     [0x4A] = { .level = 3, .type = UNIFIED_CACHE,     .size =   6 * MiB,
                .associativity = 12, .line_size = 64, },
     [0x4B] = { .level = 3, .type = UNIFIED_CACHE,     .size =   8 * MiB,
-- 
2.34.1


