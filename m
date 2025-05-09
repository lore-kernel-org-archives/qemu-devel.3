Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC00C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNYL-0001oH-Bs; Fri, 09 May 2025 09:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYG-0001nc-Lo
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYE-00073m-ES
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=suQwsuILrtRb07/uWbc2/shPRu3zUyBZpeF2Kznj17A=;
 b=a4LL5dnnMdidDQjLLrNNR9O1krjmM6DaQl0itD7z1/HeaR2CfHblVGpUTRC3t2DrBFlPYW
 KCcsYAa+wwpSuvBb+as2ADHx3gMakB3l6gQWo3p3WHUgNi5Dh9CPq59yEh4UjFBQYsk/Sw
 h78uZQ3x7hif2Hr1Rn2Me7/rEv+oAbU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-6YxE6aP4PD-PgwwImFFUcQ-1; Fri,
 09 May 2025 09:14:00 -0400
X-MC-Unique: 6YxE6aP4PD-PgwwImFFUcQ-1
X-Mimecast-MFC-AGG-ID: 6YxE6aP4PD-PgwwImFFUcQ_1746796439
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2078819560B0; Fri,  9 May 2025 13:13:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 372D71800EC9; Fri,  9 May 2025 13:13:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/28] vfio/igd: Only emulate GGC register when x-igd-gms is set
Date: Fri,  9 May 2025 15:13:00 +0200
Message-ID: <20250509131317.164235-12-clg@redhat.com>
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

x-igd-gms is used for overriding DSM region size in GGC register in
both config space and MMIO BAR0, by default host value is used.
There is no need to emulate it in default case.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250505170305.23622-9-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 8ad9d723e29cd4d63e12346b6e40604ac020e747..886d44f017f415d5f82c892e630ae2de1637677c 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -478,22 +478,24 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    ggc_quirk = vfio_quirk_alloc(1);
-    ggc_mirror = ggc_quirk->data = g_malloc0(sizeof(*ggc_mirror));
-    ggc_mirror->mem = ggc_quirk->mem;
-    ggc_mirror->vdev = vdev;
-    ggc_mirror->bar = nr;
-    ggc_mirror->offset = IGD_GGC_MMIO_OFFSET;
-    ggc_mirror->config_offset = IGD_GMCH;
-
-    memory_region_init_io(ggc_mirror->mem, OBJECT(vdev),
-                          &vfio_generic_mirror_quirk, ggc_mirror,
-                          "vfio-igd-ggc-quirk", 2);
-    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
-                                        ggc_mirror->offset, ggc_mirror->mem,
-                                        1);
+    if (vdev->igd_gms) {
+        ggc_quirk = vfio_quirk_alloc(1);
+        ggc_mirror = ggc_quirk->data = g_malloc0(sizeof(*ggc_mirror));
+        ggc_mirror->mem = ggc_quirk->mem;
+        ggc_mirror->vdev = vdev;
+        ggc_mirror->bar = nr;
+        ggc_mirror->offset = IGD_GGC_MMIO_OFFSET;
+        ggc_mirror->config_offset = IGD_GMCH;
 
-    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, ggc_quirk, next);
+        memory_region_init_io(ggc_mirror->mem, OBJECT(vdev),
+                              &vfio_generic_mirror_quirk, ggc_mirror,
+                              "vfio-igd-ggc-quirk", 2);
+        memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
+                                            ggc_mirror->offset, ggc_mirror->mem,
+                                            1);
+
+        QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, ggc_quirk, next);
+    }
 
     bdsm_quirk = vfio_quirk_alloc(1);
     bdsm_mirror = bdsm_quirk->data = g_malloc0(sizeof(*bdsm_mirror));
@@ -632,9 +634,15 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
      * 32MiB. This option should only be used when the desired size cannot be
      * set from DVMT Pre-Allocated option in host BIOS.
      */
-    if (vdev->igd_gms &&
-        !vfio_pci_igd_override_gms(gen, vdev->igd_gms, &gmch)) {
-        return false;
+    if (vdev->igd_gms) {
+        if (!vfio_pci_igd_override_gms(gen, vdev->igd_gms, &gmch)) {
+            return false;
+        }
+
+        /* GMCH is read-only, emulated */
+        pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
+        pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
+        pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
     }
 
     gms_size = igd_stolen_memory_size(gen, gmch);
@@ -652,11 +660,6 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
 
-    /* GMCH is read-only, emulated */
-    pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
-    pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
-    pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
-
     /* BDSM is read-write, emulated.  The BIOS needs to be able to write it */
     if (gen < 11) {
         pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
-- 
2.49.0


