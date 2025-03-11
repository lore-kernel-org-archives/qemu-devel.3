Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E37C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts47r-0007J6-TK; Tue, 11 Mar 2025 14:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47M-000748-4n
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts479-0006i9-1F
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741716839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tlo1m3RR+QS6t/hXoq2Tjbed6AIkTn4O/Urh32D48R0=;
 b=G6NCnIhogZdBs1sx7KJP6QnIQBMc+T56+6umnnWTEZtsJrY7iWd6G3jsrt5CYlfxoQKbdW
 XxdC5AQT1caq68VB8JDd2OLm85nzIXWwL9/jKVh+sG0m3tQLz2T+AmPmu+MyTh4bStrNNA
 GMY8ZC64NOvoRTb7Xp+EZ5qqhg0MAvw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-HlnQPTnsP6aOB_-g8Yd05g-1; Tue,
 11 Mar 2025 14:13:54 -0400
X-MC-Unique: HlnQPTnsP6aOB_-g8Yd05g-1
X-Mimecast-MFC-AGG-ID: HlnQPTnsP6aOB_-g8Yd05g_1741716834
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2A921955DCC; Tue, 11 Mar 2025 18:13:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13D17180AF7B; Tue, 11 Mar 2025 18:13:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/21] vfio/igd: Handle x-igd-opregion option in config quirk
Date: Tue, 11 Mar 2025 19:13:15 +0100
Message-ID: <20250311181328.1200431-9-clg@redhat.com>
In-Reply-To: <20250311181328.1200431-1-clg@redhat.com>
References: <20250311181328.1200431-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Both enable OpRegion option (x-igd-opregion) and legacy mode require
setting up OpRegion copy for IGD devices. As the config quirk no longer
depends on legacy mode, we can now handle x-igd-opregion option there
instead of in vfio_realize.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Link: https://lore.kernel.org/qemu-devel/20250306180131.32970-9-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h |  2 --
 hw/vfio/igd.c | 14 +++++++++-----
 hw/vfio/pci.c |  9 ---------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 3e66b19d8f24fd8c0f44ca26d63e511edbc4318a..816bdbf844dc17e7cbac9a6f42daf9a448ab9cc0 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -229,8 +229,6 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
 
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
-bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp);
-
 void vfio_display_reset(VFIOPCIDevice *vdev);
 bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
 void vfio_display_finalize(VFIOPCIDevice *vdev);
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index ee36875310b4728ac0049327a1f71021d5e6f770..12e07517b4a09ef87791acc09f6a6120abf17ae5 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -189,7 +189,7 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
     return true;
 }
 
-bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
 {
     g_autofree struct vfio_region_info *opregion = NULL;
     int ret;
@@ -560,10 +560,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
             goto error;
         }
 
-        /* Setup OpRegion access */
-        if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
-            goto error;
-        }
+        /* Enable OpRegion quirk */
+        vdev->features |= VFIO_FEATURE_ENABLE_IGD_OPREGION;
 
         /* Setup LPC bridge / Host bridge PCI IDs */
         if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
@@ -575,6 +573,12 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         goto error;
     }
 
+    /* Setup OpRegion access */
+    if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
+        !vfio_pci_igd_setup_opregion(vdev, errp)) {
+        goto error;
+    }
+
     /*
      * Allow user to override dsm size using x-igd-gms option, in multiples of
      * 32MiB. This option should only be used when the desired size cannot be
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 444a33d94b7ee56311e828f69f29c724b91812c3..e2897bdcd58d092d64689b5921a34c133139b56d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3140,15 +3140,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         vfio_bar_quirk_setup(vdev, i);
     }
 
-#ifdef CONFIG_VFIO_IGD
-    if (!vdev->igd_opregion &&
-        vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) {
-        if (!vfio_pci_igd_setup_opregion(vdev, errp)) {
-            goto out_unset_idev;
-        }
-    }
-#endif
-
     /* QEMU emulates all of MSI & MSIX */
     if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
         memset(vdev->emulated_config_bits + pdev->msix_cap, 0xff,
-- 
2.48.1


