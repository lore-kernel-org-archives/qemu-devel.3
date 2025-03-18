Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A21C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTgH-0005dj-AP; Tue, 18 Mar 2025 05:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfy-00050r-9O
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfu-0002NV-91
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrck+yT5eKamMeSTUHuEXchTCKwAoiWjB7vpcxAw1a8=;
 b=JPXYLtA4d8yowdKKsp4d/bxg3hXfa+wgw7QKdo3KSj/LLtD+0+GXZLKT2Kk1cLsQW2a+hS
 acFyKdhRk9Donx0POzxPzSHXEKznF1j1efDOEPUieOsFf9pPBqINsGwEPA8kwlsSjO567/
 c73G8PL1mStt8FV0lZ9lZrNOZe3BJ50=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-EsDrimtyM-O27QMjCkU2LQ-1; Tue,
 18 Mar 2025 05:55:49 -0400
X-MC-Unique: EsDrimtyM-O27QMjCkU2LQ-1
X-Mimecast-MFC-AGG-ID: EsDrimtyM-O27QMjCkU2LQ_1742291748
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A11719560AE; Tue, 18 Mar 2025 09:55:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A0DA18001EF; Tue, 18 Mar 2025 09:55:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 21/32] vfio: Move vfio_kvm_device_fd() into helpers.c
Date: Tue, 18 Mar 2025 10:54:04 +0100
Message-ID: <20250318095415.670319-22-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The vfio_kvm_device_add/del_fd() routines opening the VFIO pseudo
device are defined in "helpers.c". Move 'vfio_kvm_device_fd'
definition there and its declaration into "helpers.h" to reduce
exposure of VFIO internals in "hw/vfio/vfio-common.h".

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/helpers.h             |  2 ++
 include/hw/vfio/vfio-common.h |  1 -
 hw/vfio/common.c              | 11 -----------
 hw/vfio/helpers.c             | 11 +++++++++++
 hw/vfio/spapr.c               |  2 +-
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/helpers.h b/hw/vfio/helpers.h
index 8ac1f13c6e2a51983f69f81072cb134ff8969c70..416b045c6aacd4b6186fc86c4e38be80cad81bbe 100644
--- a/hw/vfio/helpers.h
+++ b/hw/vfio/helpers.h
@@ -12,6 +12,8 @@
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 
+extern int vfio_kvm_device_fd;
+
 struct vfio_info_cap_header *
 vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
 struct vfio_info_cap_header *
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 7f1df4fc0c545ceb117ad6c090bd3f701456a70c..184a422916f62259158e8759efc473a5efb2b2f7 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -131,7 +131,6 @@ VFIODevice *vfio_get_vfio_device(Object *obj);
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
-extern int vfio_kvm_device_fd;
 
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e70e4c077ca27ce0d2f990d684196f2f74f6f07a..52f440c0d05fa9f781221032442b6118ef898a10 100644
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
index ffc40ff43c8b614f044d6131562e5837cd932aa5..e99d312a9f5c7462644ea3d0de2e9de38979f851 100644
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
index 4adfd50967313d1a5c3c4033a57c37eeb3a779a7..e9c954352857ab4a437b84eeda6b5a95ce285472 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -15,13 +15,13 @@
 #include "system/hostmem.h"
 #include "exec/address-spaces.h"
 
-#include "hw/vfio/vfio-common.h"
 #include "hw/vfio/vfio-container.h"
 #include "hw/hw.h"
 #include "exec/ram_addr.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "trace.h"
+#include "helpers.h"
 
 typedef struct VFIOHostDMAWindow {
     hwaddr min_iova;
-- 
2.48.1


