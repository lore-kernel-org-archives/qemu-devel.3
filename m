Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AAFC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWG4b-0000ev-CX; Tue, 23 Jul 2024 10:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG4W-0000PX-UV
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWG4V-0003gq-92
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721743254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPXZn5CcFMTSuQfROt1NiJlZ/fM6jguHxXahwT9zliI=;
 b=PcUUdK4BmfFfV8XiOmyZ32H3qMk59pUs7NMpa/vQNYv7bVgE3ykDE+4qUcBTM1JF+f5cIO
 4EwWDSnIGwMer3qVOK/33B1QYL26FUZelJPcbUDjguZAKl/FhSxOeUWoTuGHCXrs59Ctl8
 RKK+izIgM8A17u1bkCiDNpFo3bKTQQI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-1XcSyJRQMveUHTBdgV5AcQ-1; Tue,
 23 Jul 2024 10:00:52 -0400
X-MC-Unique: 1XcSyJRQMveUHTBdgV5AcQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 600B8195608A; Tue, 23 Jul 2024 14:00:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.91])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59652195605A; Tue, 23 Jul 2024 14:00:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 09/16] vfio/{iommufd,container}: Remove caps::aw_bits
Date: Tue, 23 Jul 2024 16:00:12 +0200
Message-ID: <20240723140019.387786-10-clg@redhat.com>
In-Reply-To: <20240723140019.387786-1-clg@redhat.com>
References: <20240723140019.387786-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Joao Martins <joao.m.martins@oracle.com>

Remove caps::aw_bits which requires the bcontainer::iova_ranges being
initialized after device is actually attached. Instead defer that to
.get_cap() and call vfio_device_get_aw_bits() directly.

This is in preparation for HostIOMMUDevice::realize() being called early
during attach_device().

Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 include/sysemu/host_iommu_device.h | 3 ---
 backends/iommufd.c                 | 3 ++-
 hw/vfio/container.c                | 5 +----
 hw/vfio/iommufd.c                  | 1 -
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index c1bf74ae2c7a729b22d6512f3ca37ce65fa6bcec..d1c10ff7c239d9a0ae31894abe929e1e96b63ef2 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -19,12 +19,9 @@
  * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
  *
  * @type: host platform IOMMU type.
- *
- * @aw_bits: host IOMMU address width. 0xff if no limitation.
  */
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
-    uint8_t aw_bits;
 } HostIOMMUDeviceCaps;
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 60a3d14bfab4b96186509886d3e8665b249b3415..06b135111f303ca95d55dc0f71ad3bbb76211337 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -18,6 +18,7 @@
 #include "qemu/error-report.h"
 #include "monitor/monitor.h"
 #include "trace.h"
+#include "hw/vfio/vfio-common.h"
 #include <sys/ioctl.h>
 #include <linux/iommufd.h>
 
@@ -269,7 +270,7 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
     case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
         return caps->type;
     case HOST_IOMMU_DEVICE_CAP_AW_BITS:
-        return caps->aw_bits;
+        return vfio_device_get_aw_bits(hiod->agent);
     default:
         error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
         return -EINVAL;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index ce9a858e56218a9e9c803b4f5cf4c9f7cfc4edda..10cb4b4320ac3d6b3a1da3625e964af5f2f2f9a7 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1141,7 +1141,6 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     VFIODevice *vdev = opaque;
 
     hiod->name = g_strdup(vdev->name);
-    hiod->caps.aw_bits = vfio_device_get_aw_bits(vdev);
     hiod->agent = opaque;
 
     return true;
@@ -1150,11 +1149,9 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
 static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
                                     Error **errp)
 {
-    HostIOMMUDeviceCaps *caps = &hiod->caps;
-
     switch (cap) {
     case HOST_IOMMU_DEVICE_CAP_AW_BITS:
-        return caps->aw_bits;
+        return vfio_device_get_aw_bits(hiod->agent);
     default:
         error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
         return -EINVAL;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 58c11c93086e0c2aba20a80b147f3b980015c7bb..f1e7cf3e9cafde08a0353876da973f3713006df3 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -725,7 +725,6 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
 
     hiod->name = g_strdup(vdev->name);
     caps->type = type;
-    caps->aw_bits = vfio_device_get_aw_bits(vdev);
 
     return true;
 }
-- 
2.45.2


