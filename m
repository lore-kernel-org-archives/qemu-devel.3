Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D2BC25B7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihY-0005en-AC; Wed, 22 May 2024 05:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihU-0005D3-80
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihS-0001wB-FJ
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wKSNjl0lt4yslzVe4UOEZ3ud0SqQvcTMh97IKf8SyQs=;
 b=RJw8uaxSRVJkLbVz7X9807EORKuPk9srYdOSqnywCTfSXjrmGB+iOFdZryI4xBUefs1xuP
 4TKr63PNZNK54rjqIzKzaH/E5r01rfj7w2sUMwtJm7cU4/99Ggwd+xEnd7VQP4tflnSlAd
 Ug+yJZzZAchaytl/2RmAhMuCjzLEBAI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-BdH2wSQBNoCfOxN_Yb6xDw-1; Wed,
 22 May 2024 05:55:56 -0400
X-MC-Unique: BdH2wSQBNoCfOxN_Yb6xDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB4B9380008F;
 Wed, 22 May 2024 09:55:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA8057412;
 Wed, 22 May 2024 09:55:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 47/47] vfio/igd: Use g_autofree in vfio_probe_igd_bar4_quirk()
Date: Wed, 22 May 2024 11:54:42 +0200
Message-ID: <20240522095442.195243-48-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

Pointer opregion, host and lpc are allocated and freed in
vfio_probe_igd_bar4_quirk(). Use g_autofree to automatically
free them.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 1e79202f2bd136b0bafd4f08c2f1407e467e0d65..d320d032a7f3b19df0d055178f6fefe4bdfd8668 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -368,7 +368,9 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
     g_autofree struct vfio_region_info *rom = NULL;
-    struct vfio_region_info *opregion = NULL, *host = NULL, *lpc = NULL;
+    g_autofree struct vfio_region_info *opregion = NULL;
+    g_autofree struct vfio_region_info *host = NULL;
+    g_autofree struct vfio_region_info *lpc = NULL;
     VFIOQuirk *quirk;
     VFIOIGDQuirk *igd;
     PCIDevice *lpc_bridge;
@@ -426,7 +428,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if ((ret || !rom->size) && !vdev->pdev.romfile) {
         error_report("IGD device %s has no ROM, legacy mode disabled",
                      vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     /*
@@ -437,7 +439,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         error_report("IGD device %s hotplugged, ROM disabled, "
                      "legacy mode disabled", vdev->vbasedev.name);
         vdev->rom_read_failed = true;
-        goto out;
+        return;
     }
 
     /*
@@ -450,7 +452,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s does not support OpRegion access,"
                      "legacy mode disabled", vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     ret = vfio_get_dev_region_info(&vdev->vbasedev,
@@ -459,7 +461,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s does not support host bridge access,"
                      "legacy mode disabled", vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     ret = vfio_get_dev_region_info(&vdev->vbasedev,
@@ -468,7 +470,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s does not support LPC bridge access,"
                      "legacy mode disabled", vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
@@ -482,7 +484,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         error_report("IGD device %s failed to enable VGA access, "
                      "legacy mode disabled", vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     /* Create our LPC/ISA bridge */
@@ -490,7 +492,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s failed to create LPC bridge, "
                      "legacy mode disabled", vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     /* Stuff some host values into the VM PCI host bridge */
@@ -498,14 +500,14 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s failed to modify host bridge, "
                      "legacy mode disabled", vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     /* Setup OpRegion access */
     if (!vfio_pci_igd_opregion_init(vdev, opregion, &err)) {
         error_append_hint(&err, "IGD legacy mode disabled\n");
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     /* Setup our quirk to munge GTT addresses to the VM allocated buffer */
@@ -607,9 +609,4 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     }
 
     trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, ggms_mb + gms_mb);
-
-out:
-    g_free(opregion);
-    g_free(host);
-    g_free(lpc);
 }
-- 
2.45.1


