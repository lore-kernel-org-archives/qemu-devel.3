Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F810C88E7F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkInz-0001xC-2P; Mon, 26 Jan 2026 04:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vkIno-0001sE-3S
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:22:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vkInm-0005z8-G3
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769419349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3hEabu/Tq4sGkr6Y5w9RAh2UfpWvIsQdYKgROmkilT0=;
 b=cl0dHFyIbZfQcA/QcZaHKVErSHqRZ7DQNVChTPbVnPuUWh12G6eqo9KMGWa5FssAKXEh4l
 hQu58W2l8EleT1ISBRVSiKPrAVeXL602BTNY67k2O6bjEozfbjzb3bUThkC2O0X3U6yfL/
 TInMxkAioOj2TwLYI3Eq4MlAcj+cI14=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-0aTBk0HpOP-_EuyI1Sxt0g-1; Mon,
 26 Jan 2026 04:22:28 -0500
X-MC-Unique: 0aTBk0HpOP-_EuyI1Sxt0g-1
X-Mimecast-MFC-AGG-ID: 0aTBk0HpOP-_EuyI1Sxt0g_1769419347
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1FC51800473; Mon, 26 Jan 2026 09:22:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0A5E1956095; Mon, 26 Jan 2026 09:22:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 4/7] hw/vfio: Add helper to retrieve device feature
Date: Mon, 26 Jan 2026 10:22:09 +0100
Message-ID: <20260126092212.503162-5-clg@redhat.com>
In-Reply-To: <20260126092212.503162-1-clg@redhat.com>
References: <20260126092212.503162-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Add vfio_device_get_feature() as a common helper to retrieve
VFIO device features.

No functional change intended.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260121114111.34045-3-skolothumtho@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h | 3 +++
 hw/vfio/container.c           | 2 +-
 hw/vfio/device.c              | 9 +++++++++
 hw/vfio/listener.c            | 4 ++--
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index f6f3d0e3786cf85553d75674828391e16f9fa250..35a5ec6d9224df515c354fe50fcf7c80c1241c8c 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -272,6 +272,9 @@ bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
                                                 uint32_t type, void *caps,
                                                 uint32_t size);
 
+int vfio_device_get_feature(VFIODevice *vbasedev,
+                            struct vfio_device_feature *feature);
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index af16cd14db069882cc5fcf6349b433af3867f40c..4c2816b5741fa5232f104fb16fe919f7642f2a36 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -205,7 +205,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     feature->flags = VFIO_DEVICE_FEATURE_GET |
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
 
-    return vbasedev->io_ops->device_feature(vbasedev, feature);
+    return vfio_device_get_feature(vbasedev, feature);
 }
 
 static int vfio_container_iommu_query_dirty_bitmap(
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 086f20f6762a3a86f52bbab840ef67f603850a01..973fc35b59d4bdaa34c0f2773ec78df0f151dfa2 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -547,6 +547,15 @@ bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
     return false;
 }
 
+int vfio_device_get_feature(VFIODevice *vbasedev,
+                            struct vfio_device_feature *feature)
+{
+    if (!vbasedev->io_ops || !vbasedev->io_ops->device_feature) {
+        return -EINVAL;
+    }
+    return vbasedev->io_ops->device_feature(vbasedev, feature);
+}
+
 /*
  * Traditional ioctl() based io
  */
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 8ba1cd255d146ab8055ab73c71eac640eafa1bdd..1087fdc142e05ecd7890b68a08bb562e161c501b 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -909,7 +909,7 @@ static void vfio_devices_dma_logging_stop(VFIOContainer *bcontainer)
             continue;
         }
 
-        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
+        ret = vfio_device_get_feature(vbasedev, feature);
 
         if (ret != 0) {
             warn_report("%s: Failed to stop DMA logging, err %d (%s)",
@@ -1014,7 +1014,7 @@ static bool vfio_devices_dma_logging_start(VFIOContainer *bcontainer,
             continue;
         }
 
-        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
+        ret = vfio_device_get_feature(vbasedev, feature);
         if (ret) {
             error_setg_errno(errp, -ret, "%s: Failed to start DMA logging",
                              vbasedev->name);
-- 
2.52.0


