Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCDFC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2rq-0005ON-PX; Thu, 08 May 2025 11:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2rj-0004x2-D5
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:08:53 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2rd-0007RF-Fg
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716925; x=1778252925;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pOLEUR8SCOwB++SmnsFFG3cZP0bcRPjjl0chh6ZN5ns=;
 b=IiBWU6S6yqDcZZ16PxpOTUMrvEjv+EdPMFpcR7UaFgS1ESIi7hHG0gQp
 g1+aCt8APA7b+n2FoUZJZYmWgUuhRh9MX4G//Y6BU1kL8mds1UAory9QK
 TMYSlnoDrdC84FiyJKhjfwjBlh8XysD5qMxoI89IJ8yEJGmfiK1QVvm5B
 iPpZL+5YXrGenJZMD+BvfUsltLrp6Gmq0UnrUQxwlAbQH56WHZxwyD6sw
 W1udKf2Z/3SDu9+XVP9JDaZxYIjn6wXBoMcdo/MHY7baaATXOoLE3mq+c
 3fpUnUcfK31UaYNBcwCxYfrp02pdvuleQyVpaIapQAu8p//3dMvqcil4O g==;
X-CSE-ConnectionGUID: R7gRX1GtSFit92349ka6+Q==
X-CSE-MsgGUID: 7vd2C4N6R/WKfgmopyEYCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888548"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888548"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:07:26 -0700
X-CSE-ConnectionGUID: FE88bzw3RmOPJV8mvosaMA==
X-CSE-MsgGUID: JdSZ7wEtRJifZZjgNPdmvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141440530"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:07:23 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 49/55] i386/tdx: Define supported KVM features for TDX
Date: Thu,  8 May 2025 10:59:55 -0400
Message-ID: <20250508150002.689633-50-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

For TDX, only limited KVM PV features are supported.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/kvm/tdx.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 528b5cb4ae47..16d55613c683 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -32,6 +32,8 @@
 #include "kvm_i386.h"
 #include "tdx.h"
 
+#include "standard-headers/asm-x86/kvm_para.h"
+
 #define TDX_MIN_TSC_FREQUENCY_KHZ   (100 * 1000)
 #define TDX_MAX_TSC_FREQUENCY_KHZ   (10 * 1000 * 1000)
 
@@ -44,6 +46,14 @@
                                  TDX_TD_ATTRIBUTES_PKS | \
                                  TDX_TD_ATTRIBUTES_PERFMON)
 
+#define TDX_SUPPORTED_KVM_FEATURES  ((1U << KVM_FEATURE_NOP_IO_DELAY) | \
+                                     (1U << KVM_FEATURE_PV_UNHALT) | \
+                                     (1U << KVM_FEATURE_PV_TLB_FLUSH) | \
+                                     (1U << KVM_FEATURE_PV_SEND_IPI) | \
+                                     (1U << KVM_FEATURE_POLL_CONTROL) | \
+                                     (1U << KVM_FEATURE_PV_SCHED_YIELD) | \
+                                     (1U << KVM_FEATURE_MSI_EXT_DEST_ID))
+
 static TdxGuest *tdx_guest;
 
 static struct kvm_tdx_capabilities *tdx_caps;
@@ -638,6 +648,14 @@ static void tdx_add_supported_cpuid_by_xfam(void)
     e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK) >> 32;
 }
 
+static void tdx_add_supported_kvm_features(void)
+{
+    struct kvm_cpuid_entry2 *e;
+
+    e = find_in_supported_entry(0x40000001, 0);
+    e->eax = TDX_SUPPORTED_KVM_FEATURES;
+}
+
 static void tdx_setup_supported_cpuid(void)
 {
     if (tdx_supported_cpuid) {
@@ -654,6 +672,8 @@ static void tdx_setup_supported_cpuid(void)
     tdx_add_supported_cpuid_by_fixed1_bits();
     tdx_add_supported_cpuid_by_attrs();
     tdx_add_supported_cpuid_by_xfam();
+
+    tdx_add_supported_kvm_features();
 }
 
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
-- 
2.43.0


