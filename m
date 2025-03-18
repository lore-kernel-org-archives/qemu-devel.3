Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0003C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTg3-00053H-26; Tue, 18 Mar 2025 05:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfg-0004c6-Ii
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfe-0002LU-T3
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNZN8C122wIEfAzNtP0aJoVNmEdlEmIVuOIcOTjHdwQ=;
 b=KKjqC/heK6oBA1ninW5bi3YY2yWu0/K8NGqqt/K0cXmqLS40j27jMwQOeXguSdVVnFhb25
 urEv30L3AB3VqK7GstJxbY4DBmBlOmXymboHrC5j0EwGIqkr5O9/l2Cm/ZsK+gNdffAN8X
 mFDPPNSCOs/Omv4zl1tTb+vWB+SpH44=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-pvasKJNnPhuOFn2cf6CMUw-1; Tue,
 18 Mar 2025 05:55:33 -0400
X-MC-Unique: pvasKJNnPhuOFn2cf6CMUw-1
X-Mimecast-MFC-AGG-ID: pvasKJNnPhuOFn2cf6CMUw_1742291732
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3688818007E1; Tue, 18 Mar 2025 09:55:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A39B1828A80; Tue, 18 Mar 2025 09:55:29 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 15/32] vfio: Introduce a new header file for helper
 services
Date: Tue, 18 Mar 2025 10:53:58 +0100
Message-ID: <20250318095415.670319-16-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Gather all helper routine declarations into "helpers.h" to reduce
exposure of VFIO internals in "hw/vfio/vfio-common.h".

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/helpers.h             | 26 ++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  7 -------
 hw/s390x/s390-pci-vfio.c      |  1 +
 hw/vfio/common.c              |  1 +
 hw/vfio/container.c           |  1 +
 hw/vfio/helpers.c             |  1 +
 hw/vfio/pci.c                 |  1 +
 hw/vfio/region.c              |  1 +
 8 files changed, 32 insertions(+), 7 deletions(-)
 create mode 100644 hw/vfio/helpers.h

diff --git a/hw/vfio/helpers.h b/hw/vfio/helpers.h
new file mode 100644
index 0000000000000000000000000000000000000000..b70f7082562dedff9d97db80d2eecc7ddf71e2af
--- /dev/null
+++ b/hw/vfio/helpers.h
@@ -0,0 +1,26 @@
+/*
+ * VFIO helpers
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_HELPERS_H
+#define HW_VFIO_HELPERS_H
+
+#ifdef CONFIG_LINUX
+#include <linux/vfio.h>
+
+struct vfio_info_cap_header *
+vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
+struct vfio_info_cap_header *
+vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
+struct vfio_info_cap_header *
+vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id);
+
+#endif
+
+int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
+
+#endif /* HW_VFIO_HELPERS_H */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c45a18ab3af7d0b55a41d607a17d93079ae445d7..0fe424633c9cb94195c08d0b62ca4fb8ffccd79c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -146,17 +146,10 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
 int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
                              uint32_t subtype, struct vfio_region_info **info);
 bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
-struct vfio_info_cap_header *
-vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id);
 bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
                              unsigned int *avail);
-struct vfio_info_cap_header *
-vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
-struct vfio_info_cap_header *
-vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
 #endif
 
-int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
 bool vfio_devices_all_dirty_tracking_started(
     const VFIOContainerBase *bcontainer);
 bool
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 88d4c5b3ecc617c5b93ca53cba0850666db3a67b..83c8e84919aecf2a8581205f3de5061aceb20ea8 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -21,6 +21,7 @@
 #include "hw/s390x/s390-pci-vfio.h"
 #include "hw/vfio/pci.h"
 #include "hw/vfio/vfio-container.h"
+#include "hw/vfio/helpers.h"
 
 /*
  * Get the current DMA available count from vfio.  Returns true if vfio is
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 08e2494d7c4a9858657724730b2829290fb3f197..3a20b121fcaf361596bc975437f9a358effc7f88 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -44,6 +44,7 @@
 #include "system/tcg.h"
 #include "system/tpm.h"
 #include "migration.h"
+#include "helpers.h"
 
 VFIODeviceList vfio_device_list =
     QLIST_HEAD_INITIALIZER(vfio_device_list);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9aa9f6931f591211e46f57029df2ca194f9c3eaf..a6f7359faefc02b01ca05f76b4c1f8a9934a9091 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -33,6 +33,7 @@
 #include "qapi/error.h"
 #include "pci.h"
 #include "hw/vfio/vfio-container.h"
+#include "helpers.h"
 
 #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
 
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 89403943a7a219e491b6812d50b27b7f1fd7b4a4..9d635c18156d3271bad824b74fbc5b6f1f810a95 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -30,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "monitor/monitor.h"
+#include "helpers.h"
 
 /*
  * Common VFIO interrupt disable
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6bf5a4dc720f717b2593b1b272927a13f2932d27..c0d314265836759beaf65afd85153b465179ecce 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -46,6 +46,7 @@
 #include "system/iommufd.h"
 #include "migration.h"
 #include "hw/vfio/vfio-region.h"
+#include "helpers.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 3e174c3dcb0b699fd0cee00d104250d8ae97f698..87bf5e046a432dfedf3be3c1c7e8f33e006da004 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -30,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "monitor/monitor.h"
+#include "helpers.h"
 
 /*
  * IO Port/MMIO - Beware of the endians, VFIO is always little endian
-- 
2.48.1


