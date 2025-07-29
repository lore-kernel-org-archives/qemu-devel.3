Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B30C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 06:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugdnz-00086J-Uc; Tue, 29 Jul 2025 02:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugdng-0007h3-HA
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugdne-0007SC-Ne
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753770416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViewocIKxdPQ6hSzn6y+Sev0VKSo11zY1FkphSN2lMM=;
 b=fIDB4iLFKPEZPd11yq1gJFk6L+LgvYi+aa6VtpXMz1ROVRCAn+JZRsYvf9aqHOdCq4yu0c
 XPdOZlz9Rjhb/SucXRrwQoMRoM/LQsiBeEWRev5+T2/IoyVxfYLInI0kLverO6R6RCY/Za
 usORaXyjFJpRCnjny4bdzEocjA/+l1g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-TEv8NrSOMQye99DwxZBpbA-1; Tue,
 29 Jul 2025 02:26:54 -0400
X-MC-Unique: TEv8NrSOMQye99DwxZBpbA-1
X-Mimecast-MFC-AGG-ID: TEv8NrSOMQye99DwxZBpbA_1753770413
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D54D1800366; Tue, 29 Jul 2025 06:26:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.29])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9C841955F16; Tue, 29 Jul 2025 06:26:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 5/5] vfio/igd: Fix VGA regions are not exposed in legacy mode
Date: Tue, 29 Jul 2025 08:26:33 +0200
Message-ID: <20250729062633.452522-6-clg@redhat.com>
In-Reply-To: <20250729062633.452522-1-clg@redhat.com>
References: <20250729062633.452522-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In commit a59d06305fff ("vfio/pci: Introduce x-pci-class-code option"),
pci_register_vga() has been moved ouside of vfio_populate_vga(). As a
result, IGD VGA ranges are no longer properly exposed to guest.

To fix this, call pci_register_vga() after vfio_populate_vga() legacy
mode. A wrapper function vfio_pci_config_register_vga() is introduced
to handle it.

Fixes: a59d06305fff ("vfio/pci: Introduce x-pci-class-code option")
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250723160906.44941-3-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h |  1 +
 hw/vfio/igd.c | 10 +++++++---
 hw/vfio/pci.c | 13 ++++++++++---
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index bca289035aaebb6c4422b31e26bb1dd76ab5ae72..81465a8214a4008716806ae85c7f320f6b198bb2 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -253,6 +253,7 @@ extern const VMStateDescription vfio_display_vmstate;
 
 void vfio_pci_bars_exit(VFIOPCIDevice *vdev);
 bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_config_register_vga(VFIOPCIDevice *vdev);
 bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp);
 bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);
 void vfio_pci_intx_eoi(VFIODevice *vbasedev);
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 5b1ad1a8048b8753f524059810b1b17015704ac9..ee0767b0b89c085a5147369dd6fcbd3ff21f8927 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -574,9 +574,13 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
          * If VGA is not already enabled, try to enable it. We shouldn't be
          * using legacy mode without VGA.
          */
-        if (!vdev->vga && !vfio_populate_vga(vdev, &err)) {
-            error_setg(&err, "Unable to enable VGA access");
-            goto error;
+        if (!vdev->vga) {
+            if (vfio_populate_vga(vdev, &err)) {
+                vfio_pci_config_register_vga(vdev);
+            } else {
+                error_setg(&err, "Unable to enable VGA access");
+                goto error;
+            }
         }
 
         /* Enable OpRegion and LPC bridge quirk */
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index f5bc5359eb8bdb8ddfa5f2b50d7387f2638bbeb4..4fa692c1a32bcfa4e4939e5fcb64f2bf19905b3b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3162,6 +3162,15 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+void vfio_pci_config_register_vga(VFIOPCIDevice *vdev)
+{
+    assert(vdev->vga != NULL);
+
+    pci_register_vga(&vdev->pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
+                     &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
+                     &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
+}
+
 bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
@@ -3283,9 +3292,7 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
     vfio_bars_register(vdev);
 
     if (vdev->vga && vfio_is_vga(vdev)) {
-        pci_register_vga(&vdev->pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
-                         &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
-                         &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
+        vfio_pci_config_register_vga(vdev);
     }
 
     return true;
-- 
2.50.1


