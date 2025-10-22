Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A2BCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXoO-00014W-8t; Wed, 22 Oct 2025 08:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXoM-00013y-AQ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXoK-00073w-80
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761135563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drGGtVaxobxu4HvmHz2FmYJQ+I8x7J88yoMWzXLYGJM=;
 b=WutfQYTZUujep1uGtUgUorZqYyQ/Hdi9enF4TV0QL65j34bKYfXnASa1R/W6LtbX9jh/cQ
 SEWslO+X2yJB9W+Vd5o/YxnVz/to/H/BmABdXq2iJJleEj8bvRqd0WtwPz8y2veySsg6Rg
 Z5kSIpobXuX1h++rv8fEaPcqH6vA8QQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-YL8Z_JnWM6eFT6gwywx-oA-1; Wed,
 22 Oct 2025 08:19:20 -0400
X-MC-Unique: YL8Z_JnWM6eFT6gwywx-oA-1
X-Mimecast-MFC-AGG-ID: YL8Z_JnWM6eFT6gwywx-oA_1761135559
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 303C31956070; Wed, 22 Oct 2025 12:19:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 041511800452; Wed, 22 Oct 2025 12:19:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: [PULL 11/12] vfio: rename field to "num_initial_regions"
Date: Wed, 22 Oct 2025 14:18:45 +0200
Message-ID: <20251022121846.874152-12-clg@redhat.com>
In-Reply-To: <20251022121846.874152-1-clg@redhat.com>
References: <20251022121846.874152-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Levon <john.levon@nutanix.com>

We set VFIODevice::num_regions at initialization time, and do not
otherwise refresh it. As it is valid in theory for a VFIO device to
later increase the number of supported regions, rename the field to
"num_initial_regions" to better reflect its semantics.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Alex Williamson <alex@shazbot.org>
Link: https://lore.kernel.org/qemu-devel/20251014151227.2298892-2-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h |  2 +-
 hw/vfio-user/device.c         |  2 +-
 hw/vfio/ccw.c                 |  4 ++--
 hw/vfio/device.c              | 12 ++++++------
 hw/vfio/iommufd.c             |  3 ++-
 hw/vfio/pci.c                 |  4 ++--
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 7e9aed6d3cd424d718919a0b236d8acf1bc0deaf..0fe6c60ba2d65b0ef5de5ef0c75c43cfa8e89352 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -74,7 +74,7 @@ typedef struct VFIODevice {
     VFIODeviceOps *ops;
     VFIODeviceIOOps *io_ops;
     unsigned int num_irqs;
-    unsigned int num_regions;
+    unsigned int num_initial_regions;
     unsigned int flags;
     VFIOMigration *migration;
     Error *migration_blocker;
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 0609a7dc25428c1e7efed1e7a4e85de91aace2d4..64ef35b3209429f7158d4ea79f095a5f16950d77 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -134,7 +134,7 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
     VFIOUserFDs fds = { 0, 1, fd};
     int ret;
 
-    if (info->index > vbasedev->num_regions) {
+    if (info->index > vbasedev->num_initial_regions) {
         return -EINVAL;
     }
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 9560b8d851b6b25e647476c51efe845ebff10410..4d9588e7aa1c0868fc2530d7e297676834d85259 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -484,9 +484,9 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
      * We always expect at least the I/O region to be present. We also
      * may have a variable number of regions governed by capabilities.
      */
-    if (vdev->num_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
+    if (vdev->num_initial_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
         error_setg(errp, "vfio: too few regions (%u), expected at least %u",
-                   vdev->num_regions, VFIO_CCW_CONFIG_REGION_INDEX + 1);
+                   vdev->num_initial_regions, VFIO_CCW_CONFIG_REGION_INDEX + 1);
         return false;
     }
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 64f87503894791850b059b225762fd45d85ee16c..52079f4cf5bda7c1d9e6e3791a6c340a0e3f57ba 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -257,7 +257,7 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
 {
     int i;
 
-    for (i = 0; i < vbasedev->num_regions; i++) {
+    for (i = 0; i < vbasedev->num_initial_regions; i++) {
         struct vfio_info_cap_header *hdr;
         struct vfio_region_info_cap_type *cap_type;
 
@@ -466,7 +466,7 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
     int i;
 
     vbasedev->num_irqs = info->num_irqs;
-    vbasedev->num_regions = info->num_regions;
+    vbasedev->num_initial_regions = info->num_regions;
     vbasedev->flags = info->flags;
     vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
 
@@ -476,10 +476,10 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 
     vbasedev->reginfo = g_new0(struct vfio_region_info *,
-                               vbasedev->num_regions);
+                               vbasedev->num_initial_regions);
     if (vbasedev->use_region_fds) {
-        vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
-        for (i = 0; i < vbasedev->num_regions; i++) {
+        vbasedev->region_fds = g_new0(int, vbasedev->num_initial_regions);
+        for (i = 0; i < vbasedev->num_initial_regions; i++) {
             vbasedev->region_fds[i] = -1;
         }
     }
@@ -489,7 +489,7 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
 {
     int i;
 
-    for (i = 0; i < vbasedev->num_regions; i++) {
+    for (i = 0; i < vbasedev->num_initial_regions; i++) {
         g_free(vbasedev->reginfo[i]);
         if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
             close(vbasedev->region_fds[i]);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index fc9cd9d22ff2d6f126d3c0964d7033eee33ed9f2..bb5775aa711a668b7927865d19c3a27499ef49c8 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -650,7 +650,8 @@ found_container:
     vfio_iommufd_cpr_register_device(vbasedev);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
-                                   vbasedev->num_regions, vbasedev->flags);
+                                   vbasedev->num_initial_regions,
+                                   vbasedev->flags);
     return true;
 
 err_listener_register:
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 06b06afc2b43d34d3a78ab874e3735eef91f529f..8b8bc5a42186d617ccfcc2307f62e19b53f46d50 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2975,9 +2975,9 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    if (vbasedev->num_regions < VFIO_PCI_CONFIG_REGION_INDEX + 1) {
+    if (vbasedev->num_initial_regions < VFIO_PCI_CONFIG_REGION_INDEX + 1) {
         error_setg(errp, "unexpected number of io regions %u",
-                   vbasedev->num_regions);
+                   vbasedev->num_initial_regions);
         return false;
     }
 
-- 
2.51.0


