Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B10E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 15:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVXYj-0001KF-UG; Wed, 08 Jan 2025 10:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVXYh-0001Je-Bf
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:01:23 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVXYe-0005Ma-GM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 10:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736348481; x=1767884481;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tMIGREXOYzwCwmhYCovbFSTzpG/ESCAbGuGEI0gzqOI=;
 b=IhQ4ZP7Vce6TO102x2jjF2cJbyGhejAb2RsdXy42TKXpegM0TVtqcnAt
 TqSx23P57HvOes1BtnKEcdPmB9EuFqv8CICJZSqSsciUv0YZSURtwhDNB
 bi0wy+S7JtQCH3bVDGfXKg1FKTLJR/JBZnZnfbATi+K4q/duQ1ykRwt3i
 vxDR9o4rqvGjl2K4U9gRF1iV5C1olz9jh8dYINVPoeE268XgE9evJFqoK
 uYcx0wWf3tYNrUEyOOpAnJ1Ckqb2JSSUrQmaQI4EMeapjAkqN3ntbCzR4
 o4KJaxGoi7nBmmkS9H/K5jR3ybi/+1nOtLpOA3fvQjicKsSzusi/VCGNS A==;
X-CSE-ConnectionGUID: 0lt+IREYTIKMJ/insbZ6Tw==
X-CSE-MsgGUID: lXUhYKHxR2S54sNV390wZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="53992536"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; d="scan'208";a="53992536"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2025 07:01:09 -0800
X-CSE-ConnectionGUID: mc90ZV2YTB6xaITJKL26Rg==
X-CSE-MsgGUID: /Vh06HKBR6GMy8torOHoZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; d="scan'208";a="102921009"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 08 Jan 2025 07:01:07 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Zide Chen <zide.chen@intel.com>
Subject: [PATCH] target/i386/kvm: Replace KVM_MSR_FILTER_MAX_RANGES with
 ARRAY_SIZE(msr_handlers)
Date: Wed,  8 Jan 2025 23:19:46 +0800
Message-Id: <20250108151946.1379591-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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

kvm_install_msr_filters() uses KVM_MSR_FILTER_MAX_RANGES as the bound
when traversing msr_handlers[], while other places compute the size by
ARRAY_SIZE(msr_handlers).

In fact, msr_handlers[] is an array with the fixed size
KVM_MSR_FILTER_MAX_RANGES, so there is no difference between the two
ways.

For the code consistency, use ARRAY_SIZE(msr_handlers) uniformly instead
of KVM_MSR_FILTER_MAX_RANGES.

Suggested-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changelog:
 * Addressed Paolo's comment [1] to choose ARRAY_SIZE(msr_handlers).

 [1]: https://lore.kernel.org/qemu-devel/5463356b-827f-4c9f-a76e-02cd580fe885@redhat.com/
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2f66e63b880a..7424a3f5cf48 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5851,7 +5851,7 @@ static bool kvm_install_msr_filters(KVMState *s)
     };
     int r, i, j = 0;
 
-    for (i = 0; i < KVM_MSR_FILTER_MAX_RANGES; i++) {
+    for (i = 0; i < ARRAY_SIZE(msr_handlers); i++) {
         KVMMSRHandlers *handler = &msr_handlers[i];
         if (handler->msr) {
             struct kvm_msr_filter_range *range = &filter.ranges[j++];
-- 
2.34.1


