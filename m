Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26D9C52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se8xx-0002Jo-Ji; Wed, 14 Aug 2024 04:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8xu-0002Gu-Ge
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:02:42 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1se8xp-0007sc-EF
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723622558; x=1755158558;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=95lVEX5CsBG7kTAIi2nQlw8g78ZvNp99dsAYOY0HpDo=;
 b=VIxXEF2dmN65l3Ift9jCWBlURN0XOtLWCb1bH0So7P9WxPoCdBWr7KvK
 rwgHNtvAiTWg7IeAYslnCRZHFVI3DJG9leIleQ3IoNsuvkYjZLAavMncV
 Z+otNFiu5zYonqyYZSiuBtfczO056hj/ZIGQ3r/KDXUKrpMilnyauXD6j
 MZwdfeNbkkHBPjtuVe+UfhSd03C6t+JX3TKXyT1E3fi3dMRk7JLssOwzu
 tBUJoOtKtV/WXKcGQHj55xDsGpAtjNIwKfPDRPmSM6tt+gwbZvVZ+ab9r
 Rijly0BVEGDSUs4/RRT7xYWivfIXd0azzXsAmta2HRV9F95AYbDGIxlBt Q==;
X-CSE-ConnectionGUID: Ef9vSaLZTWKQc4921Oav3Q==
X-CSE-MsgGUID: 95A1uGMvSz6TvzmPqpskag==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25584456"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="25584456"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 01:02:35 -0700
X-CSE-ConnectionGUID: 8wOW06pLTcCnYg13vPkjNw==
X-CSE-MsgGUID: NbBLo//tQNKuSM0CFGdwiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; d="scan'208";a="59048943"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 01:02:32 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 1/9] i386/cpu: Don't construct a all-zero entry for CPUID[0xD
 0x3f]
Date: Wed, 14 Aug 2024 03:54:23 -0400
Message-Id: <20240814075431.339209-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814075431.339209-1-xiaoyao.li@intel.com>
References: <20240814075431.339209-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently, QEMU always constructs a all-zero CPUID entry for
CPUID[0xD 0x3f].

It's meaningless to construct such a leaf as the end of leaf 0xD. Rework
the logic of how subleaves of 0xD are constructed to get rid of such
all-zero value of subleaf 0x3f.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 31f149c9902c..c168ff5691df 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1844,10 +1844,6 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
         case 0xb:
         case 0xd:
             for (j = 0; ; j++) {
-                if (i == 0xd && j == 64) {
-                    break;
-                }
-
                 c->function = i;
                 c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
                 c->index = j;
@@ -1863,7 +1859,12 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
                     break;
                 }
                 if (i == 0xd && c->eax == 0) {
-                    continue;
+                    if (j < 63) {
+                        continue;
+                    } else {
+                        cpuid_i--;
+                        break;
+                    }
                 }
                 if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
                     goto full;
-- 
2.34.1


