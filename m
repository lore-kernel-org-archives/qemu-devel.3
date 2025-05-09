Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FC7C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNXz-0001k5-3R; Fri, 09 May 2025 09:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXq-0001i0-1i
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNXo-0006xS-0E
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzGye/MLmPKxKAPIljfhMJ7poocLepPP6GDibNB0t5A=;
 b=fo+Thg74r3LFWjdEI3B6z54rjjEvCYMirIbDBs1VNT5opzql174eNQWbc/2P89GjITo/2x
 yDBEA+rmGroRPkFxlPhlNHMtOytF9Aot4CmUe1Kv3Rc41ropsBH32qum9bm+k0/GqvQ74r
 +zmzDwSufvE/N64D6xvw4yC0yuVeZu4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-xDPyiTDQNb2T5_QPr34FxQ-1; Fri,
 09 May 2025 09:13:36 -0400
X-MC-Unique: xDPyiTDQNb2T5_QPr34FxQ-1
X-Mimecast-MFC-AGG-ID: xDPyiTDQNb2T5_QPr34FxQ_1746796415
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7A881956053; Fri,  9 May 2025 13:13:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C45818003FD; Fri,  9 May 2025 13:13:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/28] vfio/igd: Restrict legacy mode to Gen6-9 devices
Date: Fri,  9 May 2025 15:12:53 +0200
Message-ID: <20250509131317.164235-5-clg@redhat.com>
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

Intel only provides legacy VBIOS for IGD up to Gen9, and there is no
CSM support on later devices. Additionally, Seabios can only handle
32-bit BDSM register used until Gen9. Since legacy mode requires VGA
capability, restrict it to Gen6 through Gen9 devices.

Link: https://lore.kernel.org/qemu-devel/20250325172239.27926-1-tomitamoeko@gmail.com/T/
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250505170305.23622-2-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/igd-assign.txt | 1 +
 hw/vfio/igd.c       | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
index 3aed7956d5d4fbc763d52c0f6ae0288c9a423679..95beb7681279ca97fc2b4b390045847dcd59eabd 100644
--- a/docs/igd-assign.txt
+++ b/docs/igd-assign.txt
@@ -47,6 +47,7 @@ Intel document [1] shows how to dump VBIOS to file. For UEFI Option ROM, see
 
 QEMU also provides a "Legacy" mode that implicitly enables full functionality
 on IGD, it is automatically enabled when
+* IGD generation is 6 to 9 (Sandy Bridge to Comet Lake)
 * Machine type is i440fx
 * IGD is assigned to guest BDF 00:02.0
 * ROM BAR or romfile is present
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index d7e4728fdc84a0d91086f224c889f24120e1ce14..e06484c9112f104b87c18bb7b2d0a2cd2de1992e 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -517,11 +517,13 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
     /*
      * For backward compatibility, enable legacy mode when
+     * - Device geneation is 6 to 9 (including both)
      * - Machine type is i440fx (pc_piix)
      * - IGD device is at guest BDF 00:02.0
      * - Not manually disabled by x-igd-legacy-mode=off
      */
     if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
+        (gen >= 6 && gen <= 9) &&
         !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
         (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
         0, PCI_DEVFN(0x2, 0)))) {
@@ -566,7 +568,9 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         vdev->features |= VFIO_FEATURE_ENABLE_IGD_LPC;
     } else if (vdev->igd_legacy_mode == ON_OFF_AUTO_ON) {
         error_setg(&err,
-                   "Machine is not i440fx or assigned BDF is not 00:02.0");
+                   "Machine is not i440fx, assigned BDF is not 00:02.0, "
+                   "or device %04x (gen %d) doesn't support legacy mode",
+                   vdev->device_id, gen);
         goto error;
     }
 
-- 
2.49.0


