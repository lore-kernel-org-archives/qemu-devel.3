Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C21CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf8l-0006mc-47; Mon, 08 Sep 2025 12:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8I-0006V1-Py
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8D-0001ZK-8A
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMWQE+lVSW0xd2rlDdzp5kGDyFgdfJPePxcUB3qr7U0=;
 b=OWDt7cx0CLUclcd10F9lqK+d/QqaXA0n3Lzrxj52dnz5sjskdoAC4eSobE2Aq3t0wNzFF3
 YH+z4cERnTOCM7o0XNdBqQ2DUY7eklrItjx73ZX5neraeAOh26OhoAqMY1hZ6R3EqVs00G
 oYR0BdsPFw9yy92aDTOoQ2//iGduZ3Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-qP9et2AmOKCB9pes12hjxw-1; Mon,
 08 Sep 2025 12:54:07 -0400
X-MC-Unique: qP9et2AmOKCB9pes12hjxw-1
X-Mimecast-MFC-AGG-ID: qP9et2AmOKCB9pes12hjxw_1757350446
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D262195419F; Mon,  8 Sep 2025 16:54:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDC77300018D; Mon,  8 Sep 2025 16:54:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/31] vfio/igd: Enable quirks when IGD is not the primary
 display
Date: Mon,  8 Sep 2025 18:53:25 +0200
Message-ID: <20250908165354.1731444-3-clg@redhat.com>
In-Reply-To: <20250908165354.1731444-1-clg@redhat.com>
References: <20250908165354.1731444-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Since linux 6.15, commit 41112160ca87 ("vfio/pci: match IGD devices in
display controller class"), IGD related regions are also exposed when
IGD is not primary display (device class is Display controller).

Allow IGD quirks to be enabled in this configuration so that guests can
have display output on IGD when it is not the primary display.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250813160510.23553-1-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h | 5 +++++
 hw/vfio/igd.c | 7 ++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 810a842f4a153d4bcc924a6984c6dae58e1e69dd..923cf9c2f79d078546239bf67195d6ba8157265a 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -203,6 +203,11 @@ static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
     return (vdev->class_code >> 8) == PCI_CLASS_DISPLAY_VGA;
 }
 
+static inline bool vfio_is_base_display(VFIOPCIDevice *vdev)
+{
+    return (vdev->class_code >> 16) == PCI_BASE_CLASS_DISPLAY;
+}
+
 /* MSI/MSI-X/INTx */
 void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr);
 void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index ee0767b0b89c085a5147369dd6fcbd3ff21f8927..f116c40ccd933c8e6e7fd99d599c6372c26973e1 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -460,7 +460,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     int gen;
 
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev) || nr != 0) {
+        !vfio_is_base_display(vdev) || nr != 0) {
         return;
     }
 
@@ -518,7 +518,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     Error *err = NULL;
 
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev)) {
+        !vfio_is_base_display(vdev)) {
         return true;
     }
 
@@ -534,12 +534,13 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     /*
      * For backward compatibility, enable legacy mode when
      * - Device geneation is 6 to 9 (including both)
-     * - IGD claims VGA cycles on host
+     * - IGD exposes itself as VGA controller and claims VGA cycles on host
      * - Machine type is i440fx (pc_piix)
      * - IGD device is at guest BDF 00:02.0
      * - Not manually disabled by x-igd-legacy-mode=off
      */
     if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
+        vfio_is_vga(vdev) &&
         (gen >= 6 && gen <= 9) &&
         !(gmch & IGD_GMCH_VGA_DISABLE) &&
         !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
-- 
2.51.0


