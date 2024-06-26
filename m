Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BD3C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 08:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMO0S-0006y3-TX; Wed, 26 Jun 2024 04:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sMO0Q-0006vv-Lm
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 04:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sMO0P-00078c-3K
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 04:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719390472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJ6Al0ZQnV18rO+0upSDA/VdXWm+39WAGj4ddyLFL9M=;
 b=UYLKF+5h0mqBHlY/dK0+mSVh2wLFb5ILY2+ML/bCSW03NFPnV6jAESxarL+bo/Hjbtol5S
 CPL1qNbfcL7R8fE87Fdx9rjq3V9I4E7wROxF9VhAlej8wIjRjB2Nq0Doug3qjCidaBLvoW
 nPwlTwZOVczuasehFcvCa8x9n4NeUMA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-owTbmDJ5Ob-D4nckyWdMsg-1; Wed,
 26 Jun 2024 04:27:50 -0400
X-MC-Unique: owTbmDJ5Ob-D4nckyWdMsg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93AA319560AB; Wed, 26 Jun 2024 08:27:49 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84B371956087; Wed, 26 Jun 2024 08:27:42 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com
Subject: [PATCH 2/7] vfio-container-base: Introduce
 vfio_container_get_iova_ranges() helper
Date: Wed, 26 Jun 2024 10:26:47 +0200
Message-ID: <20240626082727.1278530-3-eric.auger@redhat.com>
In-Reply-To: <20240626082727.1278530-1-eric.auger@redhat.com>
References: <20240626082727.1278530-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce vfio_container_get_iova_ranges() to retrieve the usable
IOVA regions of the base container and use it in the Host IOMMU
device implementations of get_iova_ranges() callback.

We also fix a UAF bug as the list was shallow copied while
g_list_free_full() was used both on the single call site, in
virtio_iommu_set_iommu_device() but also in
vfio_container_instance_finalize(). Instead use g_list_copy_deep.

Fixes: cf2647a76e ("virtio-iommu: Compute host reserved regions")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  2 ++
 hw/vfio/container-base.c              | 15 +++++++++++++++
 hw/vfio/container.c                   |  8 +-------
 hw/vfio/iommufd.c                     |  8 +-------
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 419e45ee7a..45d7c40fce 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -86,6 +86,8 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
 
+GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer);
+
 #define TYPE_VFIO_IOMMU "vfio-iommu"
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 50b1664f89..809b157674 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -83,6 +83,21 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                                errp);
 }
 
+static gpointer copy_iova_range(gconstpointer src, gpointer data)
+{
+     Range *source = (Range *)src;
+     Range *dest = g_new(Range, 1);
+
+     range_set_bounds(dest, range_lob(source), range_upb(source));
+     return dest;
+}
+
+GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer)
+{
+    assert(bcontainer);
+    return g_list_copy_deep(bcontainer->iova_ranges, copy_iova_range, NULL);
+}
+
 static void vfio_container_instance_finalize(Object *obj)
 {
     VFIOContainerBase *bcontainer = VFIO_IOMMU(obj);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 2e7ecdf10e..2ad57cd845 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1169,15 +1169,9 @@ static GList *
 hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
 {
     VFIODevice *vdev = hiod->agent;
-    GList *l = NULL;
 
     g_assert(vdev);
-
-    if (vdev->bcontainer) {
-        l = g_list_copy(vdev->bcontainer->iova_ranges);
-    }
-
-    return l;
+    return vfio_container_get_iova_ranges(vdev->bcontainer);
 }
 
 static void vfio_iommu_legacy_instance_init(Object *obj)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index c2f158e603..890d8d6a38 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -647,15 +647,9 @@ static GList *
 hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
 {
     VFIODevice *vdev = hiod->agent;
-    GList *l = NULL;
 
     g_assert(vdev);
-
-    if (vdev->bcontainer) {
-        l = g_list_copy(vdev->bcontainer->iova_ranges);
-    }
-
-    return l;
+    return vfio_container_get_iova_ranges(vdev->bcontainer);
 }
 
 static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
-- 
2.41.0


