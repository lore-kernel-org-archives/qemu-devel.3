Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040E7C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Eji-0004d2-Oq; Fri, 25 Apr 2025 04:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjS-0003c5-NS
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjQ-0003I2-Gb
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLZSUJBhoIXxYbxQyf5Khkubcy7Pz4EtiVYqPi92EZ0=;
 b=NMG6L7OzWUeto4D38u0PFOT6vtU0Ftht2i2T09SPSwsF+zcZj0quLrVmhWIjA5USzmCDFt
 SWUBNZmIjD3gJoq1Zb5gIeeJ5wzxex9KY2dGgUdXUO2+2on47UrWfKJpYbcFi/vHf6pE1H
 jjf7v2RPPtKpjL+nbFP1f9OI8iar8QY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-Qr8QTlLgPkSQBa4cGonTMg-1; Fri,
 25 Apr 2025 04:48:18 -0400
X-MC-Unique: Qr8QTlLgPkSQBa4cGonTMg-1
X-Mimecast-MFC-AGG-ID: Qr8QTlLgPkSQBa4cGonTMg_1745570898
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D713B1956094; Fri, 25 Apr 2025 08:48:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B68C630001A2; Fri, 25 Apr 2025 08:48:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 26/50] vfio: Move vfio_kvm_device_fd() into helpers.c
Date: Fri, 25 Apr 2025 10:46:19 +0200
Message-ID: <20250425084644.102196-27-clg@redhat.com>
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

The vfio_kvm_device_add/del_fd() routines opening the VFIO pseudo
device are defined in "helpers.c". Move 'vfio_kvm_device_fd'
definition there and its declaration into "vfio-helpers.h" to reduce
exposure of VFIO internals in "hw/vfio/vfio-common.h".

Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-22-clg@redhat.com
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-23-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-helpers.h        |  2 ++
 include/hw/vfio/vfio-common.h |  1 -
 hw/vfio/common.c              | 11 -----------
 hw/vfio/helpers.c             | 11 +++++++++++
 hw/vfio/spapr.c               |  2 +-
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/vfio-helpers.h b/hw/vfio/vfio-helpers.h
index dbcb68bbb0e12607f5ccf15f114530966c2cbcb2..54a327ffbc04a2df364fdd78bd97fe7e2065b38c 100644
--- a/hw/vfio/vfio-helpers.h
+++ b/hw/vfio/vfio-helpers.h
@@ -12,6 +12,8 @@
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 
+extern int vfio_kvm_device_fd;
+
 struct vfio_info_cap_header *
 vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
 struct vfio_info_cap_header *
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 2065c2f9e409b27a4c8f7e0d0d3340c6636c5fa2..06178cf2828bdeb5e4881b6b3e2f67708a6df218 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -132,7 +132,6 @@ VFIODevice *vfio_get_vfio_device(Object *obj);
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
-extern int vfio_kvm_device_fd;
 
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f80c0ef229c867070593f6a6f53e7ea1a701cf41..84a9a37d9d26cf24b7ea9e07ac040c0dc283a5ba 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -49,17 +49,6 @@
 VFIODeviceList vfio_device_list =
     QLIST_HEAD_INITIALIZER(vfio_device_list);
 
-#ifdef CONFIG_KVM
-/*
- * We have a single VFIO pseudo device per KVM VM.  Once created it lives
- * for the life of the VM.  Closing the file descriptor only drops our
- * reference to it and the device's reference to kvm.  Therefore once
- * initialized, this file descriptor is only released on QEMU exit and
- * we'll re-use it should another vfio device be attached before then.
- */
-int vfio_kvm_device_fd = -1;
-#endif
-
 /*
  * Device state interfaces
  */
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 7ddc9797ef7659035d927e40a3b99a8f74dca2de..48bd61d5280967dffa509dcbaeeee7a1ba01335a 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -106,6 +106,17 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
     return true;
 }
 
+#ifdef CONFIG_KVM
+/*
+ * We have a single VFIO pseudo device per KVM VM.  Once created it lives
+ * for the life of the VM.  Closing the file descriptor only drops our
+ * reference to it and the device's reference to kvm.  Therefore once
+ * initialized, this file descriptor is only released on QEMU exit and
+ * we'll re-use it should another vfio device be attached before then.
+ */
+int vfio_kvm_device_fd = -1;
+#endif
+
 int vfio_kvm_device_add_fd(int fd, Error **errp)
 {
 #ifdef CONFIG_KVM
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 31e4dddc9e2707b18ebaf3e744d85009e635f172..95ccbad4181ec826c8ff7490b6e023a78710f297 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -15,13 +15,13 @@
 #include "system/hostmem.h"
 #include "system/address-spaces.h"
 
-#include "hw/vfio/vfio-common.h"
 #include "hw/vfio/vfio-container.h"
 #include "hw/hw.h"
 #include "system/ram_addr.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "trace.h"
+#include "vfio-helpers.h"
 
 typedef struct VFIOHostDMAWindow {
     hwaddr min_iova;
-- 
2.49.0


