Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2118E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 12:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNX5L-0000As-33; Tue, 17 Dec 2024 07:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tNX5J-0000AC-Rr
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 07:53:57 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tNX5H-0005DQ-RX
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 07:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734440036; x=1765976036;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FxrxvgyTxe7v2slGilL0hs9RicUqXHpApITr+EHT6TU=;
 b=ALXJ5zmQ4AnEDBgy+/xdfQEoI9UfcbfjLIR9Ul3+2Mg9Mk0dtzlVekVJ
 98rCOjBWVbZjirs0Y4dTeXjrE6UpOudegvDNaX9F7LrGDYxL7kPMtHxbw
 W5D6BIWjUCsOBbA0FcamWP+vAxx/GvZmqHZxeyaxzIw2mzjWjsgGMWmL3
 axHIlgn4nOtQsQYfWO/BEwmruO3AYw1y6phr2A6/mA+MjzLqBic89T0sx
 jKUDc/E6F2zxcDagFXBDvqnSk9Fri/kkjuvx5KZyqo14WXGnqkb9VRq3g
 a9uuTAh2yBVEGme3JjjpYJVXCgPPI7/bJOP3+UWAMNsBfXhTTJUSCHaw6 w==;
X-CSE-ConnectionGUID: d7WDq8bjSmWMmhbdigzwUQ==
X-CSE-MsgGUID: JTEPH3nsSI2cBIwBgqaAkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34993244"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; d="scan'208";a="34993244"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 04:53:52 -0800
X-CSE-ConnectionGUID: Xrux9+hATXWF/a9AVGVCdQ==
X-CSE-MsgGUID: rfymQn0eRoqLK8H1V60LZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; d="scan'208";a="97760211"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 17 Dec 2024 04:53:51 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/i386: Print CPUID subleaf info for unsupported
 feature
Date: Tue, 17 Dec 2024 07:39:32 -0500
Message-Id: <20241217123932.948789-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217123932.948789-1-xiaoyao.li@intel.com>
References: <20241217123932.948789-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some CPUID leaves have meaningful subleaf index. Print the subleaf info
in feature_word_description for CPUID features.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d09e2f868c35..3a697834e3ad 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5460,8 +5460,9 @@ static char *feature_word_description(FeatureWordInfo *f)
         {
             const char *reg = get_register_name_32(f->cpuid.reg);
             assert(reg);
-            return g_strdup_printf("CPUID.%02XH:%s",
-                                   f->cpuid.eax, reg);
+            return g_strdup_printf("CPUID.%02XH_%02XH:%s",
+                                   f->cpuid.eax,
+                                   f->cpuid.needs_ecx ? f->cpuid.ecx : 0, reg);
         }
     case MSR_FEATURE_WORD:
         return g_strdup_printf("MSR(%02XH)",
-- 
2.34.1


