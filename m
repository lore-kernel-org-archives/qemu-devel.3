Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2522C46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSpfi-0003bu-Gy; Wed, 24 Jan 2024 21:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSpfJ-0003UH-80
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:40:31 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSpfG-0007ct-PS
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706150426; x=1737686426;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zCSUWz6x4CYmJnL/NhcGx17babqI2D0aVpH7noNHZvM=;
 b=jUXv4DvwtJeKz5hRdSEPGWNSm/RszoAnEj8U/ulSCWfgqgZWPwriwziY
 oKJFMheyKzXGh1dl6MAvgzshj4YWSblN3zgM6iiI3m0fBuy0IqZll7HDJ
 1AdpOgHbyDa0SinW9jrsN0MGY7pd0rbGpslk885JU5j7TPwhexz1RtduY
 MPHDoJ/Z1QJdfyIqYd/3eY2z6Z2GkCaBR7HnrJn+1XqeXLaLgXCskryuL
 0XLOKXYbbunA8+XEiIfvIjPlhsDZumHrNNFyIslhKZB0s9F7L9zBavaQq
 QHpstOMmKk0w/Ts/hLqEppR0c1xCQSs/5ImXQZI1ZZ+wpMpcU0e4y2cqy w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401687461"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="401687461"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 18:40:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2120537"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa003.jf.intel.com with ESMTP; 24 Jan 2024 18:40:24 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH v3 3/3] i386/cpuid: Move leaf 7 to correct group
Date: Wed, 24 Jan 2024 21:40:16 -0500
Message-Id: <20240125024016.2521244-4-xiaoyao.li@intel.com>
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

CPUID leaf 7 was grouped together with SGX leaf 0x12 by commit
b9edbadefb9e ("i386: Propagate SGX CPUID sub-leafs to KVM") by mistake.

SGX leaf 0x12 has its specific logic to check if subleaf (starting from 2)
is valid or not by checking the bit 0:3 of corresponding EAX is 1 or
not.

Leaf 7 follows the logic that EAX of subleaf 0 enumerates the maximum
valid subleaf.

Fixes: b9edbadefb9e ("i386: Propagate SGX CPUID sub-leafs to KVM")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9758c83693ec..42970ab046fa 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1951,7 +1951,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
                 c = &cpuid_data.entries[cpuid_i++];
             }
             break;
-        case 0x7:
         case 0x12:
             for (j = 0; ; j++) {
                 c->function = i;
@@ -1971,6 +1970,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
                 c = &cpuid_data.entries[cpuid_i++];
             }
             break;
+        case 0x7:
         case 0x14:
         case 0x1d:
         case 0x1e: {
-- 
2.34.1


