Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE49C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ejg-0004Nd-87; Fri, 25 Apr 2025 04:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjG-0003RZ-Tq
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjA-0003GU-SW
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWX9TpPpPcwU2SDAsZBVZrpVJxO44kGgrgcQiQERT58=;
 b=AY4YORCjj75bxmcJVVWsxFYfiLXakVSwU40R6iiw5S9rf/8Ls8Q17aH5UBNMS8PyZHTozP
 BBYFPll2TqxOVF/h188F2p/3g4fV5Ne1nBsVZl5Ef6HRawpjFWXJhkExJ/hrOsJh4bVVW8
 LcWR9havffgzbzD1iFuXjJOchnArqg0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-3hAdNj10O_yrOW36LbmXRg-1; Fri,
 25 Apr 2025 04:48:01 -0400
X-MC-Unique: 3hAdNj10O_yrOW36LbmXRg-1
X-Mimecast-MFC-AGG-ID: 3hAdNj10O_yrOW36LbmXRg_1745570880
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73D491956086; Fri, 25 Apr 2025 08:48:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5063B30001A2; Fri, 25 Apr 2025 08:47:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 20/50] vfio: Introduce a new header file for helper services
Date: Fri, 25 Apr 2025 10:46:13 +0200
Message-ID: <20250425084644.102196-21-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Gather all helper routine declarations into "vfio-helpers.h" to reduce
exposure of VFIO internals in "hw/vfio/vfio-common.h".

Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-16-clg@redhat.com
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-17-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-helpers.h        | 26 ++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  7 -------
 hw/s390x/s390-pci-vfio.c      |  1 +
 hw/vfio/common.c              |  1 +
 hw/vfio/container.c           |  1 +
 hw/vfio/helpers.c             |  1 +
 hw/vfio/pci.c                 |  1 +
 hw/vfio/region.c              |  1 +
 8 files changed, 32 insertions(+), 7 deletions(-)
 create mode 100644 hw/vfio/vfio-helpers.h

diff --git a/hw/vfio/vfio-helpers.h b/hw/vfio/vfio-helpers.h
new file mode 100644
index 0000000000000000000000000000000000000000..d7e4dcba512a2a842c4a9d75e2d834bdf97c8f31
--- /dev/null
+++ b/hw/vfio/vfio-helpers.h
@@ -0,0 +1,26 @@
+/*
+ * VFIO helpers
+ *
+ * Copyright Red Hat, Inc. 2025
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_VFIO_HELPERS_H
+#define HW_VFIO_VFIO_HELPERS_H
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
+#endif /* HW_VFIO_VFIO_HELPERS_H */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index bb11b8215a889500bdf019166cfd2622431432a4..8e465111d26ff612148fcd1af9a39a4e4de5184e 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -147,17 +147,10 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
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
index 748a51fd8cc478604340b7c812e0da356836b807..aaf91319b4e3cfacf3ca3a91e71d9d6d2fbda13f 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -21,6 +21,7 @@
 #include "hw/s390x/s390-pci-vfio.h"
 #include "hw/vfio/pci.h"
 #include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-helpers.h"
 
 /*
  * Get the current DMA available count from vfio.  Returns true if vfio is
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index c099d4d24d044263ca3570ec9cfbd5ca4bcd1e23..18e5aacbd1b5e8033221df99999739cd58c883b0 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -44,6 +44,7 @@
 #include "system/tcg.h"
 #include "system/tpm.h"
 #include "vfio-migration-internal.h"
+#include "vfio-helpers.h"
 
 VFIODeviceList vfio_device_list =
     QLIST_HEAD_INITIALIZER(vfio_device_list);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 6ef53ee187052002be0bd20af8f05b41cc2424b3..b2d72f5036c5182e4b2d48b8cf57260d906e0bb5 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -33,6 +33,7 @@
 #include "qapi/error.h"
 #include "pci.h"
 #include "hw/vfio/vfio-container.h"
+#include "vfio-helpers.h"
 
 #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
 
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 89403943a7a219e491b6812d50b27b7f1fd7b4a4..054ee6e31ebd080cc10516b9fc5a0373725b63d8 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -30,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "monitor/monitor.h"
+#include "vfio-helpers.h"
 
 /*
  * Common VFIO interrupt disable
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b0aac2f3a0b93ad3af6d8b71c6dc0f9d390ea475..bade3b80d7d98125cf84e13f0d34009b6c46992e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -45,6 +45,7 @@
 #include "migration/qemu-file.h"
 #include "system/iommufd.h"
 #include "vfio-migration-internal.h"
+#include "vfio-helpers.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 08cd69e7047ab950151832864a14af7af774ff3b..9049143abffa28bed333d110d1e01d68ad7f83be 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "monitor/monitor.h"
+#include "vfio-helpers.h"
 
 /*
  * IO Port/MMIO - Beware of the endians, VFIO is always little endian
-- 
2.49.0


