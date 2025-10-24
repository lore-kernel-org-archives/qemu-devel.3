Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4245ECCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDPx-00046W-4Y; Fri, 24 Oct 2025 04:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDPv-00043X-Bs
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:44:59 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDPt-0006I7-OH
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761295498; x=1792831498;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qHLED1XIY6Q5SS9koomJEvK4/Adx3nXbXGD/y+pGbBI=;
 b=dxS1borUo76Ht3w7MDB7h7fjvZ1WlAQsiYQa1zfLUyIPUC7XgKEG19ie
 tSxys2fBORAXTK9fg+HvX5VWGq+OO3abA/a4NL9U5ehpseSRVZwCtU7tp
 jzjRjRH/U7eDlB1bbiIeOW2VUY9Mu5bye1mGt6nkl4QKeE1As5mRFyEuj
 QMUfAZXD9jL8K+cdxo5L7FFX7R2sCO84qvHWUntvdqAu0exN/7f7S7jYU
 B3wMTmZw7bqnVgJCD1Cvk1d/rhjJSya54r/+tQra6oBRvMf1WyhYP5XMc
 rivP2WmE38z6ZdupZ/BZE4Mmwg9EtruhwErUVFcqKLXYfFzfTY1asycWd Q==;
X-CSE-ConnectionGUID: 7iwNxma7SmO9Onjg7+R12A==
X-CSE-MsgGUID: bQqK7t3cSvG9mTXFAdAkag==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62504837"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="62504837"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:44:57 -0700
X-CSE-ConnectionGUID: Hcl9TUaRRAWcgAdIXNuoHA==
X-CSE-MsgGUID: vGy0RVF4RUGy8T00EFus+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="183985839"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:44:53 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 06/23] intel_iommu: Implement get_viommu_flags() callback
Date: Fri, 24 Oct 2025 04:43:30 -0400
Message-ID: <20251024084349.102322-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024084349.102322-1-zhenzhong.duan@intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
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

Implement get_viommu_flags() callback and expose a request for nesting
parent HWPT for now.

VFIO uses it to create nesting parent HWPT which is further used to create
nested HWPT in vIOMMU. All these will be implemented in following patches.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d6a4e21972..db5be065bf 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -24,6 +24,7 @@
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
+#include "hw/iommu.h"
 #include "intel_iommu_internal.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
@@ -4704,6 +4705,16 @@ static void vtd_address_space_unmap_in_migration(VTDAddressSpace *as,
     }
 }
 
+static uint64_t vtd_get_viommu_flags(void *opaque)
+{
+    IntelIOMMUState *s = opaque;
+    uint64_t flags;
+
+    flags = s->fsts ? VIOMMU_FLAG_WANT_NESTING_PARENT : 0;
+
+    return flags;
+}
+
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
@@ -5362,6 +5373,7 @@ static PCIIOMMUOps vtd_iommu_ops = {
     .pri_register_notifier = vtd_pri_register_notifier,
     .pri_unregister_notifier = vtd_pri_unregister_notifier,
     .pri_request_page = vtd_pri_request_page,
+    .get_viommu_flags = vtd_get_viommu_flags,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
-- 
2.47.1


