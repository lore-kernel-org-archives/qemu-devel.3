Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA18C54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 09:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfGX1-0006FK-RP; Wed, 28 Feb 2024 04:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfGWz-0006Bb-FE
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:47:17 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfGWx-0002AQ-Vm
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709113636; x=1740649636;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=klAYBbP2OdBAI+vH8MMNk4trXTEnoMk+ZzXZROcs7UA=;
 b=bO+BNLg42d2OH60aUhRpPBhsySLitqKoJrTQnlcFLtf2mSD/UDuZr1BU
 ni7lZAR9fvcT7bHBkqYITfgJwcQMWCTQi/3ElzfVO94mJBhmdVwfN8V91
 C8L1Gua84f5XpCNKXTWiYncSmFtr0eW9n6CJL6xemlf4vWOHXKr9YWYUR
 YjFzB/5cl9S9H40HRcMtZFvyfAmt2PjaNRSXvwdWP7GGNrGw+QL1PGFoH
 jndvCSVMBl/OE4eadDR0iputaXtQjGrJfEWV/aEP9Exfu7ZUay/xFiDOq
 //5f8Jj5YGVsys3gqsj+YMZ4c8sL3ebNVeWKMfELDQoV3OPdK2P8ggw2f w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25970028"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="25970028"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 01:47:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7810109"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 01:47:11 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v1 6/6] intel_iommu: Block migration if cap is updated
Date: Wed, 28 Feb 2024 17:44:32 +0800
Message-Id: <20240228094432.1092748-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When there is VFIO device and vIOMMU cap/ecap is updated based on host
IOMMU cap/ecap, migration should be blocked.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e474284e43..9ca47dbf9a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -40,6 +40,7 @@
 #include "hw/i386/apic_internal.h"
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
+#include "migration/blocker.h"
 #include "trace.h"
 
 #define S_AW_BITS (VTD_MGAW_FROM_CAP(s->cap) + 1)
@@ -3830,6 +3831,8 @@ static int vtd_check_legacy_hdev(IntelIOMMUState *s,
     return 0;
 }
 
+static Error *vtd_mig_blocker;
+
 static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
                                   IOMMUFDDevice *idev,
                                   Error **errp)
@@ -3861,8 +3864,17 @@ static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
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


