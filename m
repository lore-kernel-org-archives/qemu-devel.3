Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53794C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihC-0003d6-1N; Wed, 22 May 2024 05:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih2-0003Z0-JQ
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih0-0001jM-K7
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vw2zTHzLsIJf+NLe+QWmmQ2AB9G2JtY38zOEeTbtoxo=;
 b=SLt61pwnsPD+446DSmkxoGq35WSYHBrgborbKleqFvl/2XA8FxVCdRNfJLcfYMXahxHlDs
 i4HIrIX7iqOcejc3JGX9o2MMGZOvNfvcNbUws1NQbQ3ykHWqPM7O/a0ySUebMgDFWMS/s8
 g3NdYvYb0jhyqk/yZg6aLgd1qBLkQuY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-GnqohcBzNDuxLVkhRGEqog-1; Wed,
 22 May 2024 05:55:25 -0400
X-MC-Unique: GnqohcBzNDuxLVkhRGEqog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB5F8380008D;
 Wed, 22 May 2024 09:55:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B07E28E5;
 Wed, 22 May 2024 09:55:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 25/47] vfio/container: Make vfio_set_iommu() return bool
Date: Wed, 22 May 2024 11:54:20 +0200
Message-ID: <20240522095442.195243-26-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

This is to follow the coding standand to return bool if 'Error **'
is used to pass error.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 802828ddff061fef25b8e4c997a68348d4be9892..e330b2897423b97fee467884f4237669ceff4756 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -393,21 +393,20 @@ static const VFIOIOMMUClass *vfio_get_iommu_class(int iommu_type, Error **errp)
     return VFIO_IOMMU_CLASS(klass);
 }
 
-static int vfio_set_iommu(VFIOContainer *container, int group_fd,
-                          VFIOAddressSpace *space, Error **errp)
+static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
+                           VFIOAddressSpace *space, Error **errp)
 {
-    int iommu_type, ret;
+    int iommu_type;
     const VFIOIOMMUClass *vioc;
 
     iommu_type = vfio_get_iommu_type(container, errp);
     if (iommu_type < 0) {
-        return iommu_type;
+        return false;
     }
 
-    ret = ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd);
-    if (ret) {
+    if (ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
         error_setg_errno(errp, errno, "Failed to set group container");
-        return -errno;
+        return false;
     }
 
     while (ioctl(container->fd, VFIO_SET_IOMMU, iommu_type)) {
@@ -422,7 +421,7 @@ static int vfio_set_iommu(VFIOContainer *container, int group_fd,
             continue;
         }
         error_setg_errno(errp, errno, "Failed to set iommu for container");
-        return -errno;
+        return false;
     }
 
     container->iommu_type = iommu_type;
@@ -430,11 +429,11 @@ static int vfio_set_iommu(VFIOContainer *container, int group_fd,
     vioc = vfio_get_iommu_class(iommu_type, errp);
     if (!vioc) {
         error_setg(errp, "No available IOMMU models");
-        return -EINVAL;
+        return false;
     }
 
     vfio_container_init(&container->bcontainer, space, vioc);
-    return 0;
+    return true;
 }
 
 static int vfio_get_iommu_info(VFIOContainer *container,
@@ -615,8 +614,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->fd = fd;
     bcontainer = &container->bcontainer;
 
-    ret = vfio_set_iommu(container, group->fd, space, errp);
-    if (ret) {
+    if (!vfio_set_iommu(container, group->fd, space, errp)) {
         goto free_container_exit;
     }
 
-- 
2.45.1


