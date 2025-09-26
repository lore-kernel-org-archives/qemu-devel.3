Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3544ACAC5BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v216b-0008Mt-SO; Fri, 26 Sep 2025 01:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216Q-0008I3-5T
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v216G-0000np-EY
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758864867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6w3+lZTYuLZuv2+Esf51IFYRhO1FHVe3PkRojpcwlTA=;
 b=HKvzJTrmhoNMLSMdgY0naQOBwlWcaUCrzZSS2H0oNK/XNFsHpx4v7MiOiX75wbspfrc57b
 4BcGiKleht+8SBiy0CtVDOHX6g53Aw+wyowQi1XLuAmq+RUJ/SKSlvEclKMa/uMQeLJO2+
 KEi/bWfRMzW2RwtZfalQ+n/yryqRxAs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-lz8FlyJ7N-ut35YwU8RicA-1; Fri,
 26 Sep 2025 01:34:26 -0400
X-MC-Unique: lz8FlyJ7N-ut35YwU8RicA-1
X-Mimecast-MFC-AGG-ID: lz8FlyJ7N-ut35YwU8RicA_1758864865
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E8AF1956053; Fri, 26 Sep 2025 05:34:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19D4D1800452; Fri, 26 Sep 2025 05:34:22 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/29] vfio/iommufd.c: use QOM casts where appropriate
Date: Fri, 26 Sep 2025 07:33:37 +0200
Message-ID: <20250926053358.308198-9-clg@redhat.com>
In-Reply-To: <20250926053358.308198-1-clg@redhat.com>
References: <20250926053358.308198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Use QOM casts to convert between VFIOIOMMUFDContainer and VFIOContainer instead
of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250925113159.1760317-8-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 7f2243d9d197d9aced99d8d8a9065e7e9d888e97..f0ffe2359196505468dd5ed159440f4655847d42 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -38,8 +38,7 @@ static int iommufd_cdev_map(const VFIOContainer *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly,
                             MemoryRegion *mr)
 {
-    const VFIOIOMMUFDContainer *container =
-        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
 
     return iommufd_backend_map_dma(container->be,
                                    container->ioas_id,
@@ -50,8 +49,7 @@ static int iommufd_cdev_map_file(const VFIOContainer *bcontainer,
                                  hwaddr iova, ram_addr_t size,
                                  int fd, unsigned long start, bool readonly)
 {
-    const VFIOIOMMUFDContainer *container =
-        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
 
     return iommufd_backend_map_file_dma(container->be,
                                         container->ioas_id,
@@ -62,8 +60,7 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
                               hwaddr iova, ram_addr_t size,
                               IOMMUTLBEntry *iotlb, bool unmap_all)
 {
-    const VFIOIOMMUFDContainer *container =
-        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
 
     /* unmap in halves */
     if (unmap_all) {
@@ -162,8 +159,7 @@ static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
 static int iommufd_set_dirty_page_tracking(const VFIOContainer *bcontainer,
                                            bool start, Error **errp)
 {
-    const VFIOIOMMUFDContainer *container =
-        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
     VFIOIOASHwpt *hwpt;
 
     QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
@@ -194,9 +190,7 @@ static int iommufd_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                       VFIOBitmap *vbmap, hwaddr iova,
                                       hwaddr size, Error **errp)
 {
-    VFIOIOMMUFDContainer *container = container_of(bcontainer,
-                                                   VFIOIOMMUFDContainer,
-                                                   bcontainer);
+    VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
     unsigned long page_size = qemu_real_host_page_size();
     VFIOIOASHwpt *hwpt;
 
@@ -324,6 +318,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
 {
     ERRP_GUARD();
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     uint32_t type, flags = 0;
     uint64_t hw_caps;
     VFIOIOASHwpt *hwpt;
@@ -408,9 +403,9 @@ skip_alloc:
     vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
-    container->bcontainer.dirty_pages_supported |=
+    bcontainer->dirty_pages_supported |=
                                 vbasedev->iommu_dirty_tracking;
-    if (container->bcontainer.dirty_pages_supported &&
+    if (bcontainer->dirty_pages_supported &&
         !vbasedev->iommu_dirty_tracking) {
         warn_report("IOMMU instance for device %s doesn't support dirty tracking",
                     vbasedev->name);
@@ -464,7 +459,7 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
 
 static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
 {
-    VFIOContainer *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
 
     if (!QLIST_EMPTY(&bcontainer->device_list)) {
         return;
@@ -486,7 +481,7 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
 static bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
                                              uint32_t ioas_id, Error **errp)
 {
-    VFIOContainer *bcontainer = &container->bcontainer;
+    VFIOContainer *bcontainer = VFIO_IOMMU(container);
     g_autofree struct iommu_ioas_iova_ranges *info = NULL;
     struct iommu_iova_range *iova_ranges;
     int sz, fd = container->be->fd;
@@ -559,7 +554,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(bcontainer, &space->containers, next) {
-        container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+        container = VFIO_IOMMU_IOMMUFD(bcontainer);
         if (VFIO_IOMMU_GET_CLASS(bcontainer) != iommufd_vioc ||
             vbasedev->iommufd != container->be) {
             continue;
@@ -609,7 +604,7 @@ skip_ioas_alloc:
     QLIST_INIT(&container->hwpt_list);
     vbasedev->cpr.ioas_id = ioas_id;
 
-    bcontainer = &container->bcontainer;
+    bcontainer = VFIO_IOMMU(container);
     vfio_address_space_insert(space, bcontainer);
 
     if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
@@ -689,9 +684,8 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
 {
     VFIOContainer *bcontainer = vbasedev->bcontainer;
     VFIOAddressSpace *space = bcontainer->space;
-    VFIOIOMMUFDContainer *container = container_of(bcontainer,
-                                                   VFIOIOMMUFDContainer,
-                                                   bcontainer);
+    VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
+
     vfio_device_unprepare(vbasedev);
 
     if (!vbasedev->ram_block_discard_allowed) {
-- 
2.51.0


