Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101A1CAC5A9
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzATx-0000uh-8t; Thu, 18 Sep 2025 04:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzATj-0000oN-TK
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:00 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzATh-0004jY-K4
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758185937; x=1789721937;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xVsvA3MC3rq5sMUut+s4X/8edtKB0p4xkhedzqHM/Dc=;
 b=DqHTGgwQyjeAMuNxK/4axJF9KNXUsaOyn6Sgx3o4H4SdYUEtNdT2TdZl
 dHA2TPTklCtfarK4vYrM4PUIgyjVoEUMyYXY6ig+HMpVxHQ3roKK1fOs/
 6yXTT+XZ0OCJBteaPgBxDHV04F9WIiJ8Dr5xU/cOHRmovngKsdGHiVkM3
 HSHbCZcyQBN5HT668U6jPm7DMSFybTgssXwnel4fza4Oaao3HO2fCipKt
 16783Op487jZHZPy992y3pnhQSS+xhBkwfrlvoy48roU6BUGHpV583ef5
 B/mFWzpxRtsEGY4vVKTD+nTglNWIohc/2VbfFDl/TUEJ+qSkXellT5NCn w==;
X-CSE-ConnectionGUID: NrjPa+3DQcGRjfUu5j85uQ==
X-CSE-MsgGUID: XzxF7X4HT5Cw1JbqU11E4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="78109442"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="78109442"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:58:56 -0700
X-CSE-ConnectionGUID: MSIbWrv1SdO0Po2syZVcqw==
X-CSE-MsgGUID: iyoYgUN/Sm6onr/lZYDczw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175930339"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:58:53 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 06/22] intel_iommu: Implement get_viommu_flags() callback
Date: Thu, 18 Sep 2025 04:57:45 -0400
Message-ID: <20250918085803.796942-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250918085803.796942-1-zhenzhong.duan@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Implement get_viommu_flags() callback and expose a request for nesting
parent HWPT for now.

VFIO uses it to create nesting parent HWPT which is further used to create
nested HWPT in vIOMMU. All these will be implemented in following patches.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
---
 hw/i386/intel_iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a47482ba9d..83c40975cc 100644
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
@@ -4412,6 +4413,16 @@ static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
     vtd_iommu_unlock(s);
 }
 
+static uint64_t vtd_get_viommu_flags(void *opaque)
+{
+    IntelIOMMUState *s = opaque;
+    uint64_t caps;
+
+    caps = s->fsts ? VIOMMU_FLAG_WANT_NESTING_PARENT : 0;
+
+    return caps;
+}
+
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
@@ -4842,6 +4853,7 @@ static PCIIOMMUOps vtd_iommu_ops = {
     .register_iotlb_notifier = vtd_register_iotlb_notifier,
     .unregister_iotlb_notifier = vtd_unregister_iotlb_notifier,
     .ats_request_translation = vtd_ats_request_translation,
+    .get_viommu_flags = vtd_get_viommu_flags,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
-- 
2.47.1


