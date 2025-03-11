Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4B2C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts483-0007Ym-SE; Tue, 11 Mar 2025 14:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47J-00073t-G0
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts471-0006gH-L8
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741716832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qw01lD0TOMxZ0qEHz7JgAc75+3w3OU8expR1YUx0mY4=;
 b=DZgWdVj09cOKF1uHLqqvpsut6MUTYkShob5JHHmDIIsihnhltjnOzLDBA7W7DyAm2zaTqm
 0FAaitNehX1xGnb4lXRaBnZwho+BXMF7ProMsars9OaKU6VI9zNkcu36wJ7iDTfsRCaWGO
 MxlmbzonAzExsmuip8f+lObIUmRFGyA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-qgqEzkfFMHKFeuEqvwuahg-1; Tue,
 11 Mar 2025 14:13:50 -0400
X-MC-Unique: qgqEzkfFMHKFeuEqvwuahg-1
X-Mimecast-MFC-AGG-ID: qgqEzkfFMHKFeuEqvwuahg_1741716829
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36004180034D; Tue, 11 Mar 2025 18:13:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38BEA1828A96; Tue, 11 Mar 2025 18:13:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/21] vfio/igd: Refactor vfio_probe_igd_bar4_quirk into pci
 config quirk
Date: Tue, 11 Mar 2025 19:13:13 +0100
Message-ID: <20250311181328.1200431-7-clg@redhat.com>
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

The actual IO BAR4 write quirk in vfio_probe_igd_bar4_quirk was removed
in previous change, leaving the function not matching its name, so move
it into the newly introduced vfio_config_quirk_setup. There is no
functional change in this commit.

For now, to align with current legacy mode behavior, it returns and
proceeds on error. Later it will fail on error after decoupling the
quirks from legacy mode.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Link: https://lore.kernel.org/qemu-devel/20250306180131.32970-7-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h        |  2 +-
 hw/vfio/igd.c        | 21 ++++++++++++---------
 hw/vfio/pci-quirks.c |  6 +++++-
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index d125e738655a43ec01348b784af90f7e121bd695..fc7ead7727b37ed57f159416bb73698a44a38348 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -216,7 +216,7 @@ bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
 VFIOQuirk *vfio_quirk_alloc(int nr_mem);
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
-void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
+bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 7feed7dfa920725d1d550b9225c7075453bf7b88..65a3dbb5afd073404a960d3eed309368e1448950 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -482,7 +482,8 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
 }
 
-void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
+bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
+                                 Error **errp G_GNUC_UNUSED)
 {
     g_autofree struct vfio_region_info *rom = NULL;
     int ret, gen;
@@ -497,10 +498,10 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * PCI bus address.
      */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev) || nr != 4 ||
+        !vfio_is_vga(vdev) ||
         &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
                                        0, PCI_DEVFN(0x2, 0))) {
-        return;
+        return true;
     }
 
     /*
@@ -512,7 +513,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (gen == -1) {
         error_report("IGD device %s is unsupported in legacy mode, "
                      "try SandyBridge or newer", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /*
@@ -525,7 +526,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if ((ret || !rom->size) && !vdev->pdev.romfile) {
         error_report("IGD device %s has no ROM, legacy mode disabled",
                      vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /*
@@ -536,7 +537,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         error_report("IGD device %s hotplugged, ROM disabled, "
                      "legacy mode disabled", vdev->vbasedev.name);
         vdev->rom_read_failed = true;
-        return;
+        return true;
     }
 
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
@@ -550,21 +551,21 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         error_report("IGD device %s failed to enable VGA access, "
                      "legacy mode disabled", vdev->vbasedev.name);
-        return;
+        return true;
     }
 
     /* Setup OpRegion access */
     if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
         error_append_hint(&err, "IGD legacy mode disabled\n");
         error_report_err(err);
-        return;
+        return true;
     }
 
     /* Setup LPC bridge / Host bridge PCI IDs */
     if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
         error_append_hint(&err, "IGD legacy mode disabled\n");
         error_report_err(err);
-        return;
+        return true;
     }
 
     /*
@@ -624,4 +625,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     }
 
     trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, (gms_size / MiB));
+
+    return true;
 }
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 78aef7d60eff7f8e776c030942439523b2197ded..f998761abca2d1c4c366a876838f1bc05b877574 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1119,6 +1119,11 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
  */
 bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
 {
+#ifdef CONFIG_VFIO_IGD
+    if (!vfio_probe_igd_config_quirk(vdev, errp)) {
+        return false;
+    }
+#endif
     return true;
 }
 
@@ -1170,7 +1175,6 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr)
     vfio_probe_rtl8168_bar2_quirk(vdev, nr);
 #ifdef CONFIG_VFIO_IGD
     vfio_probe_igd_bar0_quirk(vdev, nr);
-    vfio_probe_igd_bar4_quirk(vdev, nr);
 #endif
 }
 
-- 
2.48.1


