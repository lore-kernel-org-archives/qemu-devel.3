Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FF3C30653
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCw-00066r-BJ; Mon, 24 Jun 2024 17:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCt-0005he-GU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCr-0006rO-HF
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBq61iAeWHT+8oXnJgWDEC4tGrxsioEtPTb5O+a6nVI=;
 b=PGubGb4gc44tguoMkmztcw+mH89XO2dlMZ6lk82p4gDBvJL24cNR7Yx3L1O4YqNUSAFXDu
 Lrb9V8+uox+7M7KbJ1VnOmTGt9P58Dqk9f4bez8RIEAP74PKIVVCEkV2Mv1Io7Y0ErmWOZ
 26hwiaO5sHxtWYC2EYzVuhkUDVRqESo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-GPd5RrMUOMW2qoOVH4BJzg-1; Mon,
 24 Jun 2024 17:26:29 -0400
X-MC-Unique: GPd5RrMUOMW2qoOVH4BJzg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69AC7195608C; Mon, 24 Jun 2024 21:26:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA03A1956053; Mon, 24 Jun 2024 21:26:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 35/42] vfio/container: Discover IOMMU type before creating the
 container
Date: Mon, 24 Jun 2024 23:24:49 +0200
Message-ID: <20240624212456.350919-36-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

Since the QEMU struct type representing the VFIO container is deduced
from the IOMMU type exposed by the host, this type should be well
defined *before* creating the container struct. This will be necessary
to instantiate a QOM object of the correct type in future changes.

Rework vfio_set_iommu() to extract the part doing the container
initialization and move it under vfio_create_container().

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 47 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index a8691942791006f44f7a3c34b32c67ca51766182..31bdc46a96d1626b237227a25007957e1d472757 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -389,54 +389,56 @@ static const char *vfio_get_iommu_class_name(int iommu_type)
     };
 }
 
-static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
-                           Error **errp)
+static bool vfio_set_iommu(int container_fd, int group_fd,
+                           int *iommu_type, Error **errp)
 {
-    int iommu_type;
-    const VFIOIOMMUClass *vioc;
-    const char *vioc_name;
-
-    iommu_type = vfio_get_iommu_type(container->fd, errp);
-    if (iommu_type < 0) {
-        return false;
-    }
-
-    if (ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
+    if (ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container_fd)) {
         error_setg_errno(errp, errno, "Failed to set group container");
         return false;
     }
 
-    while (ioctl(container->fd, VFIO_SET_IOMMU, iommu_type)) {
-        if (iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
+    while (ioctl(container_fd, VFIO_SET_IOMMU, *iommu_type)) {
+        if (*iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
             /*
              * On sPAPR, despite the IOMMU subdriver always advertises v1 and
              * v2, the running platform may not support v2 and there is no
              * way to guess it until an IOMMU group gets added to the container.
              * So in case it fails with v2, try v1 as a fallback.
              */
-            iommu_type = VFIO_SPAPR_TCE_IOMMU;
+            *iommu_type = VFIO_SPAPR_TCE_IOMMU;
             continue;
         }
         error_setg_errno(errp, errno, "Failed to set iommu for container");
         return false;
     }
 
-    container->iommu_type = iommu_type;
-
-    vioc_name = vfio_get_iommu_class_name(iommu_type);
-    vioc = VFIO_IOMMU_CLASS(object_class_by_name(vioc_name));
-
-    vfio_container_init(&container->bcontainer, vioc);
     return true;
 }
 
 static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
                                             Error **errp)
 {
+    int iommu_type;
+    const VFIOIOMMUClass *vioc;
+    const char *vioc_name;
     VFIOContainer *container;
 
+    iommu_type = vfio_get_iommu_type(fd, errp);
+    if (iommu_type < 0) {
+        return NULL;
+    }
+
+    if (!vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
+        return NULL;
+    }
+
+    vioc_name = vfio_get_iommu_class_name(iommu_type);
+    vioc = VFIO_IOMMU_CLASS(object_class_by_name(vioc_name));
+
     container = g_malloc0(sizeof(*container));
     container->fd = fd;
+    container->iommu_type = iommu_type;
+    vfio_container_init(&container->bcontainer, vioc);
     return container;
 }
 
@@ -618,9 +620,6 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     if (!container) {
         goto close_fd_exit;
     }
-    if (!vfio_set_iommu(container, group->fd, errp)) {
-        goto free_container_exit;
-    }
     bcontainer = &container->bcontainer;
 
     if (!vfio_cpr_register_container(bcontainer, errp)) {
-- 
2.45.2


