Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426A5C3ABCC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNZy-0003GZ-2F; Fri, 09 May 2025 09:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYq-0002Do-3v
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYn-0007D8-1o
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OStcsqLN3Qew8ZrB5Fggs4ss5DbCOLdB7ezfyhhYOok=;
 b=QRiLi7p+l3hDnYxL1oIHK5ZhcCoyBn0KBLqZX4LGaDCyt1JP3xKI9zBdWRISWJKdzPF59H
 rTA3QTyGSq+cI04aQWTTlP+lm/ZBubi92xdHeCF0hJiTBb1hKmuUmyHG1hTdXpfGfWKPQx
 3zh6hMi73KvSSAilkG41wlVptTC3ghk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-V_w2SPTeNOm_BjiVHU-oBw-1; Fri,
 09 May 2025 09:14:37 -0400
X-MC-Unique: V_w2SPTeNOm_BjiVHU-oBw-1
X-Mimecast-MFC-AGG-ID: V_w2SPTeNOm_BjiVHU-oBw_1746796476
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C34A31956046; Fri,  9 May 2025 13:14:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5F9C18003FD; Fri,  9 May 2025 13:14:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/28] vfio: implement unmap all for DMA unmap callbacks
Date: Fri,  9 May 2025 15:13:12 +0200
Message-ID: <20250509131317.164235-24-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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

From: John Levon <john.levon@nutanix.com>

Handle unmap_all in the DMA unmap handlers rather than in the caller.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250507152020.1254632-10-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 41 +++++++++++++++++++++++++++++++----------
 hw/vfio/iommufd.c   | 15 ++++++++++++++-
 hw/vfio/listener.c  | 19 ++++++-------------
 3 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index d5f4e66f1c4146c2eb6a2ce209c74c4d391c27ce..a9f0dbaec4c8d83450048d9bc53b34d859731ebb 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -119,12 +119,9 @@ unmap_exit:
     return ret;
 }
 
-/*
- * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
- */
-static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
-                                 hwaddr iova, ram_addr_t size,
-                                 IOMMUTLBEntry *iotlb, bool unmap_all)
+static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
+                                     hwaddr iova, ram_addr_t size,
+                                     IOMMUTLBEntry *iotlb)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -138,10 +135,6 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
-    if (unmap_all) {
-        return -ENOTSUP;
-    }
-
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
@@ -185,6 +178,34 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     return 0;
 }
 
+/*
+ * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
+ */
+static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
+                                 hwaddr iova, ram_addr_t size,
+                                 IOMMUTLBEntry *iotlb, bool unmap_all)
+{
+    int ret;
+
+    if (unmap_all) {
+        /* The unmap ioctl doesn't accept a full 64-bit span. */
+        Int128 llsize = int128_rshift(int128_2_64(), 1);
+
+        ret = vfio_legacy_dma_unmap_one(bcontainer, 0, int128_get64(llsize),
+                                        iotlb);
+
+        if (ret == 0) {
+            ret = vfio_legacy_dma_unmap_one(bcontainer, int128_get64(llsize),
+                                            int128_get64(llsize), iotlb);
+        }
+
+    } else {
+        ret = vfio_legacy_dma_unmap_one(bcontainer, iova, size, iotlb);
+    }
+
+    return ret;
+}
+
 static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                ram_addr_t size, void *vaddr, bool readonly)
 {
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6b2764c044135b95c199b5df2f864156817fb6fc..af1c7ab10a090a2a4a2913231fc50903be9fb0f1 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -51,8 +51,21 @@ static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
+    /* unmap in halves */
     if (unmap_all) {
-        return -ENOTSUP;
+        Int128 llsize = int128_rshift(int128_2_64(), 1);
+        int ret;
+
+        ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
+                                        0, int128_get64(llsize));
+
+        if (ret == 0) {
+            ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
+                                            int128_get64(llsize),
+                                            int128_get64(llsize));
+        }
+
+        return ret;
     }
 
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index c5183700dbd859c9a66083f2cb6f74a75a01cc66..e7ade7d62ec81c9228e096ba4818a8dd09f54bd3 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -634,21 +634,14 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 
     if (try_unmap) {
+        bool unmap_all = false;
+
         if (int128_eq(llsize, int128_2_64())) {
-            /* The unmap ioctl doesn't accept a full 64-bit span. */
-            llsize = int128_rshift(llsize, 1);
-            ret = vfio_container_dma_unmap(bcontainer, iova,
-                                           int128_get64(llsize), NULL, false);
-            if (ret) {
-                error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
-                             "0x%"HWADDR_PRIx") = %d (%s)",
-                             bcontainer, iova, int128_get64(llsize), ret,
-                             strerror(-ret));
-            }
-            iova += int128_get64(llsize);
+            unmap_all = true;
+            llsize = int128_zero();
         }
-        ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       int128_get64(llsize), NULL, false);
+        ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
+                                       NULL, unmap_all);
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
-- 
2.49.0


