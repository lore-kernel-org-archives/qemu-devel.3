Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4715FC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6Bz-0006b6-Mw; Thu, 05 Jun 2025 04:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6Bx-0006ah-6t
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6Bv-0008Fj-Ed
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749112993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2r6adC1Lp2M/gRq60WMv2a7w6Oa+asflY1raUlrchvg=;
 b=a7bOHp3EBqM5zYVZgrn71IVORF5Xhqp8RHjdjwOruXbBdg2jDyoqparTahNcDwqEair7EY
 4wB4mLFsMw7V/QkmVMC2XrAwV8bc3uSe+dIp3FjZD47nFxNKz1keTaANpn87ygSK7gPYUl
 oFOj37lDa2HV5Ry9hUtEZyPKYxtl594=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-FxpQE1TQMrmoAYxnF440JA-1; Thu,
 05 Jun 2025 04:43:09 -0400
X-MC-Unique: FxpQE1TQMrmoAYxnF440JA-1
X-Mimecast-MFC-AGG-ID: FxpQE1TQMrmoAYxnF440JA_1749112988
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D1ED1801BC7; Thu,  5 Jun 2025 08:43:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B17B01954B33; Thu,  5 Jun 2025 08:43:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Edmund Raile <edmund.raile@protonmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/16] vfio/igd: Fix incorrect error propagation in
 vfio_pci_igd_opregion_detect()
Date: Thu,  5 Jun 2025 10:42:36 +0200
Message-ID: <20250605084245.1520562-8-clg@redhat.com>
In-Reply-To: <20250605084245.1520562-1-clg@redhat.com>
References: <20250605084245.1520562-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

From: Tomita Moeko <tomitamoeko@gmail.com>

In vfio_pci_igd_opregion_detect(), errp will be set when the device does
not have OpRegion or is hotplugged. This errp will be propagated to
pci_qdev_realize(), which interprets it as failure, causing unexpected
termination on devices without OpRegion like SR-IOV VFs or discrete
GPUs. Fix it by not setting errp in vfio_pci_igd_opregion_detect().

This patch also checks if the device has OpRegion before hotplug status
to prevent unwanted warning messages on non-IGD devices.

Fixes: c0273e77f2d7 ("vfio/igd: Detect IGD device by OpRegion")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2968
Reported-by: Edmund Raile <edmund.raile@protonmail.com>
Link: https://lore.kernel.org/qemu-devel/30044d14-17ec-46e3-b9c3-63d27a5bde27@gmail.com
Tested-by: Edmund Raile <edmund.raile@protonmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Link: https://lore.kernel.org/qemu-devel/20250522151636.20001-1-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 5b6341c5bfeda5c3f5210ea080aba144d9edc90b..e7a9d1ffc13044dd01ba83b88b2b3a1c24cfbf98 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -187,23 +187,21 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
 }
 
 static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
-                                         struct vfio_region_info **opregion,
-                                         Error **errp)
+                                         struct vfio_region_info **opregion)
 {
     int ret;
 
-    /* Hotplugging is not supported for opregion access */
-    if (vdev->pdev.qdev.hotplugged) {
-        error_setg(errp, "IGD OpRegion is not supported on hotplugged device");
-        return false;
-    }
-
     ret = vfio_device_get_region_info_type(&vdev->vbasedev,
                     VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
                     VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, opregion);
     if (ret) {
-        error_setg_errno(errp, -ret,
-                         "Device does not support IGD OpRegion feature");
+        return false;
+    }
+
+    /* Hotplugging is not supported for opregion access */
+    if (vdev->pdev.qdev.hotplugged) {
+        warn_report("IGD device detected, but OpRegion is not supported "
+                    "on hotplugged device.");
         return false;
     }
 
@@ -524,7 +522,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     }
 
     /* IGD device always comes with OpRegion */
-    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
+    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
         return true;
     }
     info_report("OpRegion detected on Intel display %x.", vdev->device_id);
@@ -695,7 +693,7 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         return true;
     }
 
-    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
+    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
         /* Should never reach here, KVMGT always emulates OpRegion */
         return false;
     }
-- 
2.49.0


