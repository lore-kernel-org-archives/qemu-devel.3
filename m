Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ADAC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 06:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugdnx-00080I-5L; Tue, 29 Jul 2025 02:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugdne-0007gS-Un
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugdnc-0007Rz-2V
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753770415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4glDHNCgMVTJXjLWuuYQ37MfDHpaGRYZ9//wvL9EKI=;
 b=J33JA/wy9hCb3VSgKQIhM9Z+Ai5FncJJE5ViayA8jGTmkNPiZPIrcJGdKijb3tkbfAcL+Z
 YCuxY+wD7ZSevGgexoFuDfOTRhPIZm+WhIa0qBX95lDqbK3okX0eMNTa0uLxSkotNdQHNc
 TSD6DZ3mZImZ42rKsZ9GWBkdSGzPAEU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-vFyUNemxMYChm3-dHF5TfQ-1; Tue,
 29 Jul 2025 02:26:52 -0400
X-MC-Unique: vFyUNemxMYChm3-dHF5TfQ-1
X-Mimecast-MFC-AGG-ID: vFyUNemxMYChm3-dHF5TfQ_1753770411
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66C20180045B; Tue, 29 Jul 2025 06:26:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.29])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A6E91955F16; Tue, 29 Jul 2025 06:26:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 4/5] vfio/igd: Require host VGA decode for legacy mode
Date: Tue, 29 Jul 2025 08:26:32 +0200
Message-ID: <20250729062633.452522-5-clg@redhat.com>
In-Reply-To: <20250729062633.452522-1-clg@redhat.com>
References: <20250729062633.452522-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

Commit a59d06305fff ("vfio/pci: Introduce x-pci-class-code option")
allows user to expose non-VGA IGD device as VGA controller to the
guest. However, legacy mode requires host VGA range access. Check
that GGC.IVD == 0 before enabling legacy mode to ensure IGD is a real
VGA device claiming host VGA ranges.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250723160906.44941-2-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/igd-assign.txt |  1 +
 hw/vfio/igd.c       | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
index af4e8391fc25898906b0b8bf123e1ec44e45efc0..e54040335ba72dc971babb4d776e46d94f342f70 100644
--- a/docs/igd-assign.txt
+++ b/docs/igd-assign.txt
@@ -48,6 +48,7 @@ Intel document [1] shows how to dump VBIOS to file. For UEFI Option ROM, see
 QEMU also provides a "Legacy" mode that implicitly enables full functionality
 on IGD, it is automatically enabled when
 * IGD generation is 6 to 9 (Sandy Bridge to Comet Lake)
+* IGD claims VGA cycles on host (IGD is VGA controller on host)
 * Machine type is i440fx
 * IGD is assigned to guest BDF 00:02.0
 * ROM BAR or romfile is present
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e7a9d1ffc13044dd01ba83b88b2b3a1c24cfbf98..5b1ad1a8048b8753f524059810b1b17015704ac9 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -113,6 +113,7 @@ static int igd_gen(VFIOPCIDevice *vdev)
 #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
 #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
 
+#define IGD_GMCH_VGA_DISABLE        BIT(1)
 #define IGD_GMCH_GEN6_GMS_SHIFT     3       /* SNB_GMCH in i915 */
 #define IGD_GMCH_GEN6_GMS_MASK      0x1f
 #define IGD_GMCH_GEN8_GMS_SHIFT     8       /* BDW_GMCH in i915 */
@@ -533,12 +534,14 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     /*
      * For backward compatibility, enable legacy mode when
      * - Device geneation is 6 to 9 (including both)
+     * - IGD claims VGA cycles on host
      * - Machine type is i440fx (pc_piix)
      * - IGD device is at guest BDF 00:02.0
      * - Not manually disabled by x-igd-legacy-mode=off
      */
     if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
         (gen >= 6 && gen <= 9) &&
+        !(gmch & IGD_GMCH_VGA_DISABLE) &&
         !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
         (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
         0, PCI_DEVFN(0x2, 0)))) {
@@ -568,12 +571,10 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         }
 
         /*
-         * If IGD VGA Disable is clear (expected) and VGA is not already
-         * enabled, try to enable it. Probably shouldn't be using legacy mode
-         * without VGA, but also no point in us enabling VGA if disabled in
-         * hardware.
+         * If VGA is not already enabled, try to enable it. We shouldn't be
+         * using legacy mode without VGA.
          */
-        if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
+        if (!vdev->vga && !vfio_populate_vga(vdev, &err)) {
             error_setg(&err, "Unable to enable VGA access");
             goto error;
         }
-- 
2.50.1


