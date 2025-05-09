Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55C7C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNY1-0001l5-P8; Fri, 09 May 2025 09:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXv-0001ic-5a
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXt-0006yx-12
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RYeG22mCeiTacQ8DiSx9KTLVQyfLuPSeREmUytrZTGI=;
 b=Faz5jzDdEZksyfqDZWYEiYIQQucdMEOiudj8atcPqw77Mm16M2vgzwFOnKg4memcThZLNI
 p82t79F5o3TzAFGE12wqDVo4WUfChenQ1jLMea6tmLudN1/DJiixmflq2n5555oNGz7Ltn
 jBU4JBRUjTEByCJuVwN4ikEcsOeEgmo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-fqk0K2CVMJ6Xnu-yrYyTMg-1; Fri,
 09 May 2025 09:13:42 -0400
X-MC-Unique: fqk0K2CVMJ6Xnu-yrYyTMg-1
X-Mimecast-MFC-AGG-ID: fqk0K2CVMJ6Xnu-yrYyTMg_1746796421
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F041180035C; Fri,  9 May 2025 13:13:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3773418003FD; Fri,  9 May 2025 13:13:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/28] vfio/igd: Detect IGD device by OpRegion
Date: Fri,  9 May 2025 15:12:55 +0200
Message-ID: <20250509131317.164235-7-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

From: Tomita Moeko <tomitamoeko@gmail.com>

There is currently no straightforward way to distinguish if a Intel
graphics device is IGD or discrete GPU. However, only IGD devices have
OpRegion. Use the presence of VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION
to identify IGD devices. Still, OpRegion on hotplugged IGD device is
not supported.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250505170305.23622-4-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index b1fce76f7250c2b2185cc259ac673d0d595832e8..347253d08ce594d46cafb674ebbd9ca8878200e0 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -185,9 +185,10 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
     return true;
 }
 
-static bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
+                                         struct vfio_region_info **opregion,
+                                         Error **errp)
 {
-    g_autofree struct vfio_region_info *opregion = NULL;
     int ret;
 
     /* Hotplugging is not supported for opregion access */
@@ -198,17 +199,13 @@ static bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
 
     ret = vfio_device_get_region_info_type(&vdev->vbasedev,
                     VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
-                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
+                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, opregion);
     if (ret) {
         error_setg_errno(errp, -ret,
                          "Device does not supports IGD OpRegion feature");
         return false;
     }
 
-    if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
-        return false;
-    }
-
     return true;
 }
 
@@ -480,6 +477,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 
 static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
+    g_autofree struct vfio_region_info *opregion = NULL;
     int ret, gen;
     uint64_t gms_size;
     uint64_t *bdsm_size;
@@ -487,16 +485,17 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     bool legacy_mode_enabled = false;
     Error *err = NULL;
 
-    /*
-     * This must be an Intel VGA device at address 00:02.0 for us to even
-     * consider enabling legacy mode.  The vBIOS has dependencies on the
-     * PCI bus address.
-     */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
         !vfio_is_vga(vdev)) {
         return true;
     }
 
+    /* IGD device always comes with OpRegion */
+    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
+        return true;
+    }
+    info_report("OpRegion detected on Intel display %x.", vdev->device_id);
+
     /*
      * IGD is not a standard, they like to change their specs often.  We
      * only attempt to support back to SandBridge and we hope that newer
@@ -572,7 +571,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
     /* Setup OpRegion access */
     if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
-        !vfio_pci_igd_setup_opregion(vdev, errp)) {
+        !vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
         goto error;
     }
 
@@ -672,8 +671,11 @@ error:
  */
 static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
+    g_autofree struct vfio_region_info *opregion = NULL;
+
     if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
-        !vfio_pci_igd_setup_opregion(vdev, errp)) {
+        (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp) ||
+         !vfio_pci_igd_opregion_init(vdev, opregion, errp))) {
         return false;
     }
 
-- 
2.49.0


