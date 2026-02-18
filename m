Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4A9E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 14:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsi7V-0004GK-6k; Wed, 18 Feb 2026 09:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsi6T-00040A-7E
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 09:00:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsi6Q-0007Bj-OT
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 09:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771423229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGFAO1IXnM0+bjnrxUtaJJdGMMhAn4QNXCcXW9XUah0=;
 b=Bknc9X8f9GDLrIqQwm4NSZiUtuT+IhKbBNnl8dDpYiMjD+AelmlNCvWRy1eypvSXLyj16f
 qD+AercUXhijva5/c7iyFxw7ZAMdHbtfAobDvmPsvTCYNIPGsV5CFwb0UNUXfhMIpVkC4q
 zE2hJ2m823hUYAa9R7lCuQ5MzsPH36Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-xcdRyIQRPIiyTBMQLwze3A-1; Wed,
 18 Feb 2026 09:00:15 -0500
X-MC-Unique: xcdRyIQRPIiyTBMQLwze3A-1
X-Mimecast-MFC-AGG-ID: xcdRyIQRPIiyTBMQLwze3A_1771423215
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C926919344F9; Wed, 18 Feb 2026 14:00:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.251])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 314931956095; Wed, 18 Feb 2026 14:00:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
 Cedric Le Goater <clg@redhat.com>
Subject: [PULL 3/5] vfio: Add Error ** parameter to vfio_region_setup()
Date: Wed, 18 Feb 2026 15:00:01 +0100
Message-ID: <20260218140003.1554502-4-clg@redhat.com>
In-Reply-To: <20260218140003.1554502-1-clg@redhat.com>
References: <20260218140003.1554502-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ankit Agrawal <ankita@nvidia.com>

Add an Error **errp parameter to vfio_region_setup() and
vfio_setup_region_sparse_mmaps to allow proper error handling
instead of just returning error codes.

The function sets errors via error_setg() when failure occur.

Suggested-by: Cedric Le Goater <clg@redhat.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260217153010.408739-3-ankita@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-region.h |  2 +-
 hw/vfio/display.c     |  6 +++---
 hw/vfio/pci.c         |  3 +--
 hw/vfio/region.c      | 20 +++++++++++---------
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index ede6e0c8f992caa3292d280474c90ddef27eb3dd..9b21d4ee5ba16f8c05be83c75d1c7a6ad4cf8370 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -38,7 +38,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
 uint64_t vfio_region_read(void *opaque,
                           hwaddr addr, unsigned size);
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
-                      int index, const char *name);
+                      int index, const char *name, Error **errp);
 int vfio_region_mmap(VFIORegion *region);
 void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_unmap(VFIORegion *region);
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index faacd9019a558ea35a8730696472e967d4196919..5a42a6f7a29e77ec2489f942457221aed8118d0b 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -446,13 +446,13 @@ static void vfio_display_region_update(void *opaque)
 
     if (!dpy->region.buffer.size) {
         /* mmap region */
+        Error *error = NULL;
         ret = vfio_region_setup(OBJECT(vdev), &vdev->vbasedev,
                                 &dpy->region.buffer,
                                 plane.region_index,
-                                "display");
+                                "display", &error);
         if (ret != 0) {
-            error_report("%s: vfio_region_setup(%d): %s",
-                         __func__, plane.region_index, strerror(-ret));
+            error_report_err(error);
             goto err;
         }
         ret = vfio_region_mmap(&dpy->region.buffer);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 36d8fbe872eb9c0e2493b9710fc29e326dc1ec52..c89f3fbea348e780b7662c7d6893d9d778aae678 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3056,11 +3056,10 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
         char *name = g_strdup_printf("%s BAR %d", vbasedev->name, i);
 
         ret = vfio_region_setup(OBJECT(vdev), vbasedev,
-                                &vdev->bars[i].region, i, name);
+                                &vdev->bars[i].region, i, name, errp);
         g_free(name);
 
         if (ret) {
-            error_setg_errno(errp, -ret, "failed to get region %d info", i);
             return false;
         }
 
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 8fbc98918f5f7c76c5e2f99956b54b96d0908fd6..d464eadf9c048e29981da8af48f8f86933a98ad5 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -163,7 +163,8 @@ static int vfio_mmap_compare_offset(const void *a, const void *b)
 }
 
 static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
-                                          struct vfio_region_info *info)
+                                          struct vfio_region_info *info,
+                                          Error **errp)
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_region_info_cap_sparse_mmap *sparse;
@@ -210,12 +211,12 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
             off_t prev_end = region->mmaps[i - 1].offset +
                              region->mmaps[i - 1].size;
             if (prev_end > region->mmaps[i].offset) {
-                error_report("%s: overlapping sparse mmap regions detected "
-                             "in region %d: [0x%"PRIx64"-0x%"PRIx64"] overlaps "
-                             "with [0x%"PRIx64"-0x%"PRIx64"]",
-                             __func__, region->nr, region->mmaps[i - 1].offset,
-                             prev_end - 1, region->mmaps[i].offset,
-                             region->mmaps[i].offset + region->mmaps[i].size - 1);
+                error_setg(errp, "%s: overlapping sparse mmap regions detected "
+                           "in region %d: [0x%"PRIx64"-0x%"PRIx64"] overlaps "
+                           "with [0x%"PRIx64"-0x%"PRIx64"]",
+                           __func__, region->nr, region->mmaps[i - 1].offset,
+                           prev_end - 1, region->mmaps[i].offset,
+                           region->mmaps[i].offset + region->mmaps[i].size - 1);
                 g_free(region->mmaps);
                 region->mmaps = NULL;
                 region->nr_mmaps = 0;
@@ -228,13 +229,14 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 }
 
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
-                      int index, const char *name)
+                      int index, const char *name, Error **errp)
 {
     struct vfio_region_info *info = NULL;
     int ret;
 
     ret = vfio_device_get_region_info(vbasedev, index, &info);
     if (ret) {
+        error_setg_errno(errp, -ret, "failed to get region %d info", index);
         return ret;
     }
 
@@ -253,7 +255,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
         if (!vbasedev->no_mmap &&
             region->flags & VFIO_REGION_INFO_FLAG_MMAP) {
 
-            ret = vfio_setup_region_sparse_mmaps(region, info);
+            ret = vfio_setup_region_sparse_mmaps(region, info, errp);
 
             if (ret == -ENODEV) {
                 region->nr_mmaps = 1;
-- 
2.53.0


