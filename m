Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0533C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc4Q-0000XP-Ox; Fri, 04 Jul 2025 04:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc4D-0000N5-Tj
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc47-0001DW-K7
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUJFqZnM/Trg5Kkp3SSUPNBS9XlVzOxwVnQbV3UWGwM=;
 b=RNdAhZQWefDxgtC/IqZicatRiHupcqbKECrZ385l2/cdzarfGcXDm/1cTwcbVmlFbZBnbG
 i/w2vDUY7ty4bZ5wIldL6iulVyagMLNmDd6mZ3H4OO0L2SjbrI+Y23mJAZpzB158Yw+V22
 HLqoqrmhJLSlg1Lf8aA2hwocpsZozrg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-f1WbWrDLMwymBiaLX5yS_w-1; Fri,
 04 Jul 2025 04:46:35 -0400
X-MC-Unique: f1WbWrDLMwymBiaLX5yS_w-1
X-Mimecast-MFC-AGG-ID: f1WbWrDLMwymBiaLX5yS_w_1751618794
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B9F51809C83; Fri,  4 Jul 2025 08:46:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E3C519560A7; Fri,  4 Jul 2025 08:46:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/27] vfio/iommufd: reconstruct device
Date: Fri,  4 Jul 2025 10:45:23 +0200
Message-ID: <20250704084528.1412959-23-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Reconstruct userland device state after CPR.  During vfio_realize, skip all
ioctls that configure the device, as it was already configured in old QEMU.

Skip bind, and use the devid from CPR state.

Skip allocation of, and attachment to, ioas_id.  Recover ioas_id from CPR
state, and use it to find a matching container, if any, before creating a
new one.

This reconstruction is not complete.  hwpt_id is handled in a subsequent
patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/1751493538-202042-17-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index f0d57ea65f148063ec2022e2321fd1d970494779..a650517a1d92ed5671757d425fee8709f2cd3ade 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,6 +25,7 @@
 #include "system/reset.h"
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
+#include "migration/cpr.h"
 #include "pci.h"
 #include "vfio-iommufd.h"
 #include "vfio-helpers.h"
@@ -121,6 +122,10 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
         goto err_kvm_device_add;
     }
 
+    if (cpr_is_incoming()) {
+        goto skip_bind;
+    }
+
     /* Bind device to iommufd */
     bind.iommufd = iommufd->fd;
     if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
@@ -132,6 +137,8 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
     vbasedev->devid = bind.out_devid;
     trace_iommufd_cdev_connect_and_bind(bind.iommufd, vbasedev->name,
                                         vbasedev->fd, vbasedev->devid);
+
+skip_bind:
     return true;
 err_bind:
     iommufd_cdev_kvm_device_del(vbasedev);
@@ -421,7 +428,9 @@ static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
         return iommufd_cdev_autodomains_get(vbasedev, container, errp);
     }
 
-    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
+    /* If CPR, we are already attached to ioas_id. */
+    return cpr_is_incoming() ||
+           !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
 }
 
 static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
@@ -510,6 +519,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     VFIOAddressSpace *space;
     struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
     int ret, devfd;
+    bool res;
     uint32_t ioas_id;
     Error *err = NULL;
     const VFIOIOMMUClass *iommufd_vioc =
@@ -540,7 +550,16 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
             vbasedev->iommufd != container->be) {
             continue;
         }
-        if (!iommufd_cdev_attach_container(vbasedev, container, &err)) {
+
+        if (!cpr_is_incoming()) {
+            res = iommufd_cdev_attach_container(vbasedev, container, &err);
+        } else if (vbasedev->cpr.ioas_id == container->ioas_id) {
+            res = true;
+        } else {
+            continue;
+        }
+
+        if (!res) {
             const char *msg = error_get_pretty(err);
 
             trace_iommufd_cdev_fail_attach_existing_container(msg);
@@ -557,6 +576,11 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         }
     }
 
+    if (cpr_is_incoming()) {
+        ioas_id = vbasedev->cpr.ioas_id;
+        goto skip_ioas_alloc;
+    }
+
     /* Need to allocate a new dedicated container */
     if (!iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp)) {
         goto err_alloc_ioas;
@@ -564,10 +588,12 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
 
+skip_ioas_alloc:
     container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
     container->be = vbasedev->iommufd;
     container->ioas_id = ioas_id;
     QLIST_INIT(&container->hwpt_list);
+    vbasedev->cpr.ioas_id = ioas_id;
 
     bcontainer = &container->bcontainer;
     vfio_address_space_insert(space, bcontainer);
-- 
2.50.0


