Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62089C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 07:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRYG-0007Hc-6I; Thu, 01 Feb 2024 02:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRYC-0006ub-VC
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:31:58 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRYA-0001hD-C8
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706772714; x=1738308714;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SxIm2x19TwG5HPffy2XnHOf3K+46VOZDLtqOFlpVjxc=;
 b=Ss97+wJ3i5FPUzbgH8T9QxxGHpRu/SOxDEe4s/XBDSdjHPttAat5BH1U
 xiIkH/inH/mZlC7nM82Y+iYOY8T3M0EKzd4hHL/1H0pcl5uyzSedMjtOI
 /id1AQAFUf4JWMXau+8/1NspKZuwtMDdCm4MW7xVRIxfrB0fjifbjD3j4
 z4UJF3eGF64j9TK9vfxKLd+5BSe4Qi8BDmOAxZBby0Jp04qAE+iZU3F72
 D4Ls8FEGTh8f5pXunhFlqQaOdNcy43bSSqHiKZcUkHxtmmqI7k7zVbVfO
 U+0exeUSvVLpsqrTalPy5HgaXE94c1fSInxHN5RMrL1kp6fnsobLGv9cE A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402677024"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="402677024"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:31:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4443435"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:31:46 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv2 18/18] intel_iommu: Block migration if cap is updated
Date: Thu,  1 Feb 2024 15:28:18 +0800
Message-Id: <20240201072818.327930-19-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201072818.327930-1-zhenzhong.duan@intel.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When there is VFIO device and vIOMMU cap/ecap is updated based on host
IOMMU cap/ecap, migration should be blocked.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 72cc8b2c71..7f9ff653b2 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -39,6 +39,7 @@
 #include "hw/i386/apic_internal.h"
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
+#include "migration/blocker.h"
 #include "trace.h"
 
 #define S_AW_BITS (VTD_MGAW_FROM_CAP(s->cap) + 1)
@@ -3829,6 +3830,8 @@ static int vtd_check_legacy_hdev(IntelIOMMUState *s,
     return 0;
 }
 
+static Error *vtd_mig_blocker;
+
 static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
                                   IOMMUFDDevice *idev,
                                   Error **errp)
@@ -3860,8 +3863,17 @@ static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
         tmp_cap |= VTD_CAP_MGAW(host_mgaw + 1);
     }
 
-    s->cap = tmp_cap;
-    return 0;
+    if (s->cap != tmp_cap) {
+        if (vtd_mig_blocker == NULL) {
+            error_setg(&vtd_mig_blocker,
+                       "cap/ecap update from host IOMMU block migration");
+            ret = migrate_add_blocker(&vtd_mig_blocker, errp);
+        }
+        if (!ret) {
+            s->cap = tmp_cap;
+        }
+    }
+    return ret;
 }
 
 static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hdev,
-- 
2.34.1


