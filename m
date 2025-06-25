Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA5EC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 04:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUHN4-0005nX-4V; Wed, 25 Jun 2025 00:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uUHN1-0005nD-3P
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 00:04:23 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uUHMz-0003V8-Fp
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 00:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750824261; x=1782360261;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rbCZBZdQq2plak4InFDhfQuWEzP0uj6JlMmSwsNFzOM=;
 b=cXUxmp8tDwIzBiZVfTCzYc06ofO48JvLDehdvjFL6/463oYVvOeY6Y9c
 Tl6J9+5StwRDRqHY6NpDGZVW20YOD8PG5MigkUiK2kJDmxYW+Qvn2rU9B
 UJFtVsUjpMYpD76QtGlIg+hWLPVaGdWJRIw0sdmARvtnVRjKafnsBlvX6
 eBRXMrXBgzJEvgSJ4usOyO/AgKaur0+ZvuJHHQygn7CITazpx1k0f6SBj
 Jzam1JZU06CG8MxbnGusUM5I5lDwrlBb3S4gmKMw9MjTlzbcX0/Qxfpja
 BAn804ekAqp/MRlGmfi8eEZQBW/GjofBE3diXQH2Tdctop1uuGxMLhtvv A==;
X-CSE-ConnectionGUID: PWPUJNcKTc2Sdg8Wt3gPzA==
X-CSE-MsgGUID: ODysGu3hTympBR0XU5xWlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52946973"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; d="scan'208";a="52946973"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 21:04:19 -0700
X-CSE-ConnectionGUID: b9MPWsIFQ3qagovt/dKegw==
X-CSE-MsgGUID: 6KAOorOrQbGEzlQtL/nzzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; d="scan'208";a="157859765"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 24 Jun 2025 21:04:19 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: xiaoyao.li@intel.com,
	qemu-devel@nongnu.org
Subject: [PATCH] i386/tdx: Don't mask off CPUID_EXT_PDCM
Date: Wed, 25 Jun 2025 11:57:10 +0800
Message-ID: <20250625035710.2770679-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

It gets below warning when booting TDX VMs:

  warning: TDX forcibly sets the feature: CPUID[eax=01h].ECX.pdcm [bit 15]

Because CPUID_EXT_PDCM is fixed1 for TDX, and MSR_IA32_PERF_CAPABILITIES is
supported for TDX guest unconditioanlly.

Don't mask off CPUID_EXT_PDCM for TDX.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d35e95430fe..b4cdebf85aac 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -28,6 +28,7 @@
 #include "system/hvf.h"
 #include "hvf/hvf-i386.h"
 #include "kvm/kvm_i386.h"
+#include "kvm/tdx.h"
 #include "sev.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -8338,7 +8339,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
-    if (!cpu->enable_pmu) {
+    /* PDCM is fixed1 bit for TDX */
+    if (!cpu->enable_pmu && !is_tdx_vm()) {
         mark_unavailable_features(cpu, FEAT_1_ECX,
                                   env->user_features[FEAT_1_ECX] & CPUID_EXT_PDCM,
                                   "This feature is not available due to PMU being disabled");
-- 
2.43.0


