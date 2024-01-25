Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7E5C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSpfN-0003UC-Eu; Wed, 24 Jan 2024 21:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSpfG-0003Te-H8
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:40:26 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSpfE-0007d2-Qh
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706150424; x=1737686424;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nblpklNzUZKD78eAt5m3cZr0n/f8GwIruXeYbHNh9Ok=;
 b=GNMj4WwjqCql2nsXhJFhjnK2sY3ph8jbPgUrD8fy8F+dHCt7yPTZUSnt
 63goLi9xTnGuM0buD2nQblt0wq+DbE4GihSqAZkyyll6Bu0N9QOtHbvmy
 2SIaWFhCjVI7bFTMI0zJYwqZBzzvqmY7/Uw0obVHUG9H7VuurIQfDEwhp
 PO/b3bdxACJgasXBtI/Pk3z/P5nxHzq6j8ssD5v8dMzCEJghrgOoI8vTI
 +kCVfAzwrUxJqT5Mf0ajxWlyr/zDi8zrn93pfWIFlr070lfXeTbbovpjs
 98G+CByrUlKDzN3oI1VgSOEpTlW9AKeYNOUy+MqLBDGXtc08RkqKy05/Q A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401687453"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="401687453"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 18:40:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2120530"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa003.jf.intel.com with ESMTP; 24 Jan 2024 18:40:21 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH v3 1/3] i386/cpuid: Decrease cpuid_i when skipping CPUID leaf
 1F
Date: Wed, 24 Jan 2024 21:40:14 -0500
Message-Id: <20240125024016.2521244-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125024016.2521244-1-xiaoyao.li@intel.com>
References: <20240125024016.2521244-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
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

Existing code misses a decrement of cpuid_i when skip leaf 0x1F.
There's a blank CPUID entry(with leaf, subleaf as 0, and all fields
stuffed 0s) left in the CPUID array.

It conflicts with correct CPUID leaf 0.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by:Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/kvm/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 76a66246eb72..dff9dedbd761 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1914,6 +1914,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
         case 0x1f:
             if (env->nr_dies < 2) {
+                cpuid_i--;
                 break;
             }
             /* fallthrough */
-- 
2.34.1


