Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D09BC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ejy-0005lm-0i; Fri, 25 Apr 2025 04:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ejo-00059t-EJ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ejm-0003Jk-HK
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BeEHvgTujRyP2uqhL8UIZGBsnNlIiYNTWTNvyxVvK90=;
 b=TYLukyJ3o+DEqYS8KMlvI24fWHaMeaKd/mKdclDOboArDc3aM1IZV8MM19NHeQwdEEP349
 5PJF0VTW0bu0VrZnA14tbBjxI1P64v8x+iJeohnZW0Pqofmw503JC2LIzNtn5ykGGcNBwI
 I6hiPPGNx78ov4UC16FiOw9WdMGFRS0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-qQYZm39iNPmxT23JwRPCaA-1; Fri,
 25 Apr 2025 04:48:43 -0400
X-MC-Unique: qQYZm39iNPmxT23JwRPCaA-1
X-Mimecast-MFC-AGG-ID: qQYZm39iNPmxT23JwRPCaA_1745570922
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42D8B1956089; Fri, 25 Apr 2025 08:48:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E302230002C7; Fri, 25 Apr 2025 08:48:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 34/50] vfio: Rename vfio_devices_all_device_dirty_tracking()
Date: Fri, 25 Apr 2025 10:46:27 +0200
Message-ID: <20250425084644.102196-35-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

Use the prefix 'vfio_container_devices_' to reflect the routine simply
loops over the container's device list.

Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-31-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 3 ++-
 hw/vfio/common.c                      | 4 ++--
 hw/vfio/container-base.c              | 5 +++--
 hw/vfio/container.c                   | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 9b33e71f59bba1f3cbe10c307172422ca4e4c2ce..395ace02e488519aba77ca401737f0b319d9a512 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -91,7 +91,8 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start, Error **errp);
 bool vfio_container_dirty_tracking_is_started(
     const VFIOContainerBase *bcontainer);
-bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
+bool vfio_container_devices_dirty_tracking_is_supported(
+    const VFIOContainerBase *bcontainer);
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 89b7a71385abfff888c5208a6b4c588b4217716a..5a7327979d2cc83221384577398aa1276578ac26 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -935,7 +935,7 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
                                                  listener);
     bool ret;
 
-    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
+    if (vfio_container_devices_dirty_tracking_is_supported(bcontainer)) {
         ret = vfio_devices_dma_logging_start(bcontainer, errp);
     } else {
         ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp) == 0;
@@ -954,7 +954,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
     Error *local_err = NULL;
     int ret = 0;
 
-    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
+    if (vfio_container_devices_dirty_tracking_is_supported(bcontainer)) {
         vfio_devices_dma_logging_stop(bcontainer);
     } else {
         ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 1beba37a7739d76630c3e7db16a8d04926cb1aee..2627908e3fdbf1a43b86293a3f379baf88cef5ef 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -162,7 +162,8 @@ bool vfio_container_dirty_tracking_is_started(
            bcontainer->dirty_pages_started;
 }
 
-bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
+bool vfio_container_devices_dirty_tracking_is_supported(
+    const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -240,7 +241,7 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp)
 {
     bool all_device_dirty_tracking =
-        vfio_devices_all_device_dirty_tracking(bcontainer);
+        vfio_container_devices_dirty_tracking_is_supported(bcontainer);
     uint64_t dirty_pages;
     VFIOBitmap vbmap;
     int ret;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index e8cd9271365e4b2f55fac9ec402c292607f7fc1d..8e4a2cae037edd6d454582c8ebeb14b210463fc2 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -138,7 +138,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     Error *local_err = NULL;
 
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
-        if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
+        if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
             return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
         }
-- 
2.49.0


