Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F872CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf8q-00073K-AA; Mon, 08 Sep 2025 12:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8h-0006hv-Bu
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8e-0001cF-PO
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHdFZnrjCMDOGkyais0homueeFu9kysDP0ORzt9+fdw=;
 b=AssaJSO2VUAFKqibqDWOABc0Dn/grwxAoZWXDpelhUWGKtDca7/unghh4+jzEgSG5U4x5k
 0GBrS/JXE/zdSRbPo7dDILxDwd7wm7ZJQK9JRegNhrRfa/zqYzwI2VFEWMWza/bjQizErD
 PGbOpE4F/WpR5t/1oVXTzfvSa359E6s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-Q6AbwY-nOQiWogJ_EuAQhA-1; Mon,
 08 Sep 2025 12:54:38 -0400
X-MC-Unique: Q6AbwY-nOQiWogJ_EuAQhA-1
X-Mimecast-MFC-AGG-ID: Q6AbwY-nOQiWogJ_EuAQhA_1757350477
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D5C319560AD; Mon,  8 Sep 2025 16:54:37 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E6ED300018D; Mon,  8 Sep 2025 16:54:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/31] hw/vfio/container.c: use QOM casts where appropriate
Date: Mon,  8 Sep 2025 18:53:37 +0200
Message-ID: <20250908165354.1731444-15-clg@redhat.com>
In-Reply-To: <20250908165354.1731444-1-clg@redhat.com>
References: <20250908165354.1731444-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Use QOM casts to convert between VFIOContainer and VFIOContainerBase instead
of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250715093110.107317-5-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 134ddccc52449cd7d4ac90d17075e9fca5439674..030c6d3f89cf57dc06e9bb2222f02e7803482c56 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -71,7 +71,7 @@ static int vfio_dma_unmap_bitmap(const VFIOContainer *container,
                                  hwaddr iova, ram_addr_t size,
                                  IOMMUTLBEntry *iotlb)
 {
-    const VFIOContainerBase *bcontainer = &container->bcontainer;
+    const VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     struct vfio_iommu_type1_dma_unmap *unmap;
     struct vfio_bitmap *bitmap;
     VFIOBitmap vbmap;
@@ -124,8 +124,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
                                      hwaddr iova, ram_addr_t size,
                                      IOMMUTLBEntry *iotlb)
 {
-    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                                  bcontainer);
+    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
         .flags = 0,
@@ -213,8 +212,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                ram_addr_t size, void *vaddr, bool readonly,
                                MemoryRegion *mr)
 {
-    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                                  bcontainer);
+    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dma_map map = {
         .argsz = sizeof(map),
         .flags = VFIO_DMA_MAP_FLAG_READ,
@@ -246,8 +244,7 @@ static int
 vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
                                     bool start, Error **errp)
 {
-    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                                  bcontainer);
+    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     int ret;
     struct vfio_iommu_type1_dirty_bitmap dirty = {
         .argsz = sizeof(dirty),
@@ -272,8 +269,7 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
 static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                       VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
 {
-    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                                  bcontainer);
+    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dirty_bitmap *dbitmap;
     struct vfio_iommu_type1_dirty_bitmap_get *range;
     int ret;
@@ -495,7 +491,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_iommu_type1_info_cap_migration *cap_mig;
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
 
     hdr = vfio_get_iommu_info_cap(info, VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION);
     if (!hdr) {
@@ -518,8 +514,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
 
 static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
+    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     g_autofree struct vfio_iommu_type1_info *info = NULL;
     int ret;
 
@@ -634,7 +629,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
 
     if (!cpr_is_incoming()) {
         QLIST_FOREACH(bcontainer, &space->containers, next) {
-            container = container_of(bcontainer, VFIOContainer, bcontainer);
+            container = VFIO_IOMMU_LEGACY(bcontainer);
             if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
                 return vfio_container_group_add(container, group, errp);
             }
@@ -652,7 +647,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
          * create the container struct and group list.
          */
         QLIST_FOREACH(bcontainer, &space->containers, next) {
-            container = container_of(bcontainer, VFIOContainer, bcontainer);
+            container = VFIO_IOMMU_LEGACY(bcontainer);
 
             if (vfio_cpr_container_match(container, group, fd)) {
                 return vfio_container_group_add(container, group, errp);
@@ -672,7 +667,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
         goto fail;
     }
     new_container = true;
-    bcontainer = &container->bcontainer;
+    bcontainer = VFIO_IOMMU(container);
 
     if (!vfio_legacy_cpr_register_container(container, errp)) {
         goto fail;
@@ -735,7 +730,7 @@ fail:
 static void vfio_container_disconnect(VFIOGroup *group)
 {
     VFIOContainer *container = group->container;
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     QLIST_REMOVE(group, container_next);
@@ -781,7 +776,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
     QLIST_FOREACH(group, &vfio_group_list, next) {
         if (group->groupid == groupid) {
             /* Found it.  Now is it already in the right context? */
-            if (group->container->bcontainer.space->as == as) {
+            if (VFIO_IOMMU(group->container)->space->as == as) {
                 return group;
             } else {
                 error_setg(errp, "group %d used in multiple address spaces",
@@ -895,7 +890,7 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
         }
     }
 
-    vfio_device_prepare(vbasedev, &group->container->bcontainer, info);
+    vfio_device_prepare(vbasedev, VFIO_IOMMU(group->container), info);
 
     vbasedev->fd = fd;
     vbasedev->group = group;
-- 
2.51.0


