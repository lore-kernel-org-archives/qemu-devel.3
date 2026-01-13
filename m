Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6209ED29DF3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfapo-0006ei-Rf; Tue, 13 Jan 2026 04:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfapn-0006cK-3Y
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfapl-0003Hu-AG
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UYqenjYCfzNzCClz6T59UQB/S2AiR1c3NCrEgZD/k5U=;
 b=Z8sOB8hMrIBPfC+e+cnhnSbgOj0Fh6Skv+02XflZK03zBh7/ukBIzEBS/pxYFEl1f2JzH8
 O5m0rOXP3RqbzP7jxm4melinrXX7ItqsGY6ES9QeImMfli+BYIjgK+RUgfZ3JvhLhcHxnI
 SDPO9ai3etg2K60GpXYikg4A6g3Tz2k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-_a4rcI_LNounxYRdJdxzjQ-1; Tue,
 13 Jan 2026 04:37:03 -0500
X-MC-Unique: _a4rcI_LNounxYRdJdxzjQ-1
X-Mimecast-MFC-AGG-ID: _a4rcI_LNounxYRdJdxzjQ_1768297022
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 315A319560B1; Tue, 13 Jan 2026 09:37:02 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CF6B30001A2; Tue, 13 Jan 2026 09:36:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 07/41] hw/pci: Introduce pci_device_get_viommu_flags()
Date: Tue, 13 Jan 2026 10:36:03 +0100
Message-ID: <20260113093637.1549214-8-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Introduce a new PCIIOMMUOps optional callback, get_viommu_flags() which
allows to retrieve flags exposed by a vIOMMU. The first planned vIOMMU
device flag is VIOMMU_FLAG_WANT_NESTING_PARENT that advertises the
support of HW nested stage translation scheme and wants other sub-system
like VFIO's cooperation to create nesting parent HWPT.

pci_device_get_viommu_flags() is a wrapper that can be called on a PCI
device potentially protected by a vIOMMU.

get_viommu_flags() is designed to return 64bit bitmap of purely vIOMMU
flags which are only determined by user's configuration, no host
capabilities involved. Reasons are:

1. host may has heterogeneous IOMMUs, each with different capabilities
2. this is migration friendly, return value is consistent between source
   and target.

Note that this op will be invoked at the attach_device() stage, at which
point host IOMMU capabilities are not yet forwarded to the vIOMMU through
the set_iommu_device() callback that will be after the attach_device().

See below sequence:

  vfio_device_attach():
      iommufd_cdev_attach():
          pci_device_get_viommu_flags() for HW nesting cap
          create a nesting parent HWPT
          attach device to the HWPT
          vfio_device_hiod_create_and_realize() creating hiod
  ...
  pci_device_set_iommu_device(hiod)

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260106061304.314546-6-zhenzhong.duan@intel.com
[ clg: include/hw/core/iommu.h: Changed Copyright date 2025 -> 2026 ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS             |  1 +
 include/hw/core/iommu.h | 25 +++++++++++++++++++++++++
 include/hw/pci/pci.h    | 22 ++++++++++++++++++++++
 hw/pci/pci.c            | 11 +++++++++++
 4 files changed, 59 insertions(+)
 create mode 100644 include/hw/core/iommu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d16e620e01e49ec7a862bd43f3bdacc92b251dc3..620b184aa5f91f8f86879cf22eabe720a9fa33a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2368,6 +2368,7 @@ F: include/system/iommufd.h
 F: backends/host_iommu_device.c
 F: include/system/host_iommu_device.h
 F: include/qemu/chardev_open.h
+F: include/hw/core/iommu.h
 F: util/chardev_open.c
 F: docs/devel/vfio-iommufd.rst
 
diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
new file mode 100644
index 0000000000000000000000000000000000000000..fcbbcd10150e6e675fb68c817e786bf23b301892
--- /dev/null
+++ b/include/hw/core/iommu.h
@@ -0,0 +1,25 @@
+/*
+ * General vIOMMU flags
+ *
+ * Copyright (C) 2026 Intel Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_IOMMU_H
+#define HW_IOMMU_H
+
+#include "qemu/bitops.h"
+
+/*
+ * Theoretical vIOMMU flags. Only determined by the vIOMMU device properties and
+ * independent on the actual host IOMMU capabilities they may depend on. Each
+ * flag can be an expectation or request to other sub-system or just a pure
+ * vIOMMU capability. vIOMMU can choose which flags to expose.
+ */
+enum viommu_flags {
+    /* vIOMMU needs nesting parent HWPT to create nested HWPT */
+    VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
+};
+
+#endif /* HW_IOMMU_H */
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index b22d350ba299addb3fccf17c4042ed6e9bd53d0b..868817cc05ae26832246269eb4a1637c8e6ae64b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -462,6 +462,18 @@ typedef struct PCIIOMMUOps {
      * @devfn: device and function number of the PCI device.
      */
     void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
+    /**
+     * @get_viommu_flags: get vIOMMU flags
+     *
+     * Optional callback, if not implemented, then vIOMMU doesn't support
+     * exposing flags to other sub-system, e.g., VFIO.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * Returns: bitmap with each bit representing a vIOMMU flag defined in
+     * enum viommu_flags.
+     */
+    uint64_t (*get_viommu_flags)(void *opaque);
     /**
      * @get_iotlb_info: get properties required to initialize a device IOTLB.
      *
@@ -644,6 +656,16 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
 
+/**
+ * pci_device_get_viommu_flags: get vIOMMU flags.
+ *
+ * Returns: bitmap with each bit representing a vIOMMU flag defined in
+ * enum viommu_flags. Or 0 if vIOMMU doesn't report any.
+ *
+ * @dev: PCI device pointer.
+ */
+uint64_t pci_device_get_viommu_flags(PCIDevice *dev);
+
 /**
  * pci_iommu_get_iotlb_info: get properties required to initialize a
  * device IOTLB.
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0d4cf906f048c10ff13135a7aec509ca1baabd42..a136e772a39fd3fb1b3631351dbea710227bedfe 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -3021,6 +3021,17 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
     }
 }
 
+uint64_t pci_device_get_viommu_flags(PCIDevice *dev)
+{
+    PCIBus *iommu_bus;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
+    if (iommu_bus && iommu_bus->iommu_ops->get_viommu_flags) {
+        return iommu_bus->iommu_ops->get_viommu_flags(iommu_bus->iommu_opaque);
+    }
+    return 0;
+}
+
 int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
                          bool exec_req, hwaddr addr, bool lpig,
                          uint16_t prgi, bool is_read, bool is_write)
-- 
2.52.0


