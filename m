Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F7AC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW54-0004Zd-QS; Fri, 20 Jun 2025 03:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW4x-0004Z4-4i
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:27 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW4u-0008Ff-Rp
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404145; x=1781940145;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NrYvyfTwhT5be/BBp7vf0xEivOZkRqhnMvUCZbKJOC0=;
 b=KjTbOKGJipa95Fm4rXj619kEXVv6bzF1b7a8Hk5aHfj3aSwmWoM98u6p
 8jv03V9tAWSgHqBf3ABO4W1J1DESw1qg4yInESoqVQiDkFejQv90rUYLP
 bbdJmeU3zI512gzwPqcCs1JavCQS1PMHhit7a1PvAeXTTZxv6LvcOO9KU
 95vRqR42tN+gHleAQF8shGVw1HOg6JsvpBJJP4BPnq74AKHbCCQeBe8wa
 FCXR+VxX2dXU8AeDG7SIR5wPTYFUEFpRsrcFE/HFlNDHBAh55CCCCzEFA
 o4CNHqUWFfvHF+r61iZWLfwCNUGhpO3yZbAjQg4jKDTWjVD2rc0hPBooD Q==;
X-CSE-ConnectionGUID: jkAdCPFsRFuNJc94ZmJttQ==
X-CSE-MsgGUID: Ap4JXicDTuKn3/v9GT4FKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532287"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532287"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:24 -0700
X-CSE-ConnectionGUID: Dlwfz0DhT0uw3B9oyA0X1w==
X-CSE-MsgGUID: wpdrxUYwTOe3/0hFsgBH3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863067"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 03/19] intel_iommu: Implement get_viommu_cap() callback
Date: Fri, 20 Jun 2025 15:17:57 +0800
Message-Id: <20250620071813.55571-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620071813.55571-1-zhenzhong.duan@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

Implement get_viommu_cap() callback and expose stage-1 capability for now.

VFIO uses it to create nested parent domain which is further used to create
nested domain in vIOMMU. All these will be implemented in following patches.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 MAINTAINERS           |  1 +
 include/hw/iommu.h    | 14 ++++++++++++++
 hw/i386/intel_iommu.c | 12 ++++++++++++
 3 files changed, 27 insertions(+)
 create mode 100644 include/hw/iommu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 94c4076127..27817974a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2277,6 +2277,7 @@ F: include/system/iommufd.h
 F: backends/host_iommu_device.c
 F: include/system/host_iommu_device.h
 F: include/qemu/chardev_open.h
+F: include/hw/iommu.h
 F: util/chardev_open.c
 F: docs/devel/vfio-iommufd.rst
 
diff --git a/include/hw/iommu.h b/include/hw/iommu.h
new file mode 100644
index 0000000000..3c1c08f05d
--- /dev/null
+++ b/include/hw/iommu.h
@@ -0,0 +1,14 @@
+/*
+ * General vIOMMU capabilities, flags, etc
+ *
+ * Copyright (C) 2025 Intel Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_IOMMU_H
+#define HW_IOMMU_H
+
+#define VIOMMU_CAP_STAGE1    BIT_ULL(0)
+
+#endif /* HW_IOMMU_H */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f0b1f90eff..702973da5c 100644
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
 
+static uint64_t vtd_get_viommu_cap(void *opaque)
+{
+    IntelIOMMUState *s = opaque;
+    uint64_t caps;
+
+    caps = s->flts ? VIOMMU_CAP_STAGE1 : 0;
+
+    return caps;
+}
+
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
@@ -4734,6 +4745,7 @@ static PCIIOMMUOps vtd_iommu_ops = {
     .get_address_space = vtd_host_dma_iommu,
     .set_iommu_device = vtd_dev_set_iommu_device,
     .unset_iommu_device = vtd_dev_unset_iommu_device,
+    .get_viommu_cap = vtd_get_viommu_cap,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
-- 
2.34.1


