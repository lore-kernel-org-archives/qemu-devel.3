Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EDDC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6Bx-0006ag-3V; Thu, 05 Jun 2025 04:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6Bq-0006YK-Pw
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6Bl-0008EK-Rm
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749112984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yW8jPWqLwcNUdagJccxHmCsp9Y+9UpMpdi6ELX8R7Xo=;
 b=frAnOvQkHDJtLlSAhLzM2xervet6wjFuG36mHN3XBzVLnj9mGXBJo8WknrM3H95Uc2VFLK
 qRMyoCBj8SiwcqJHM3HRHPco+5JXjXcbwCr93hZ8Lw1op9PYU10Dm/i3azkn54QSZ+/5gF
 sWJgOmgHpdW4ybjqJd5sW5HduclXHik=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-OBzxASyXPmiXWilMyFXdfw-1; Thu,
 05 Jun 2025 04:42:58 -0400
X-MC-Unique: OBzxASyXPmiXWilMyFXdfw-1
X-Mimecast-MFC-AGG-ID: OBzxASyXPmiXWilMyFXdfw_1749112977
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C412919560B4; Thu,  5 Jun 2025 08:42:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE26C1954B33; Thu,  5 Jun 2025 08:42:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/16] vfio: move more cleanup into vfio_pci_put_device()
Date: Thu,  5 Jun 2025 10:42:32 +0200
Message-ID: <20250605084245.1520562-4-clg@redhat.com>
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

From: John Levon <john.levon@nutanix.com>

All of the cleanup can be done in the same place, and vfio-user will
want to do the same.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250520150419.2172078-3-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a1bfdfe3751fdf171b0b96d78d0b51853d8e7838..d96b55f80c0aa315d46aaa417c54569d71cbed1f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2854,6 +2854,18 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 
 static void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
+    vfio_display_finalize(vdev);
+    vfio_bars_finalize(vdev);
+    g_free(vdev->emulated_config_bits);
+    g_free(vdev->rom);
+    /*
+     * XXX Leaking igd_opregion is not an oversight, we can't remove the
+     * fw_cfg entry therefore leaking this allocation seems like the safest
+     * option.
+     *
+     * g_free(vdev->igd_opregion);
+     */
+
     vfio_device_detach(&vdev->vbasedev);
 
     g_free(vdev->vbasedev.name);
@@ -3302,17 +3314,6 @@ static void vfio_instance_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
 
-    vfio_display_finalize(vdev);
-    vfio_bars_finalize(vdev);
-    g_free(vdev->emulated_config_bits);
-    g_free(vdev->rom);
-    /*
-     * XXX Leaking igd_opregion is not an oversight, we can't remove the
-     * fw_cfg entry therefore leaking this allocation seems like the safest
-     * option.
-     *
-     * g_free(vdev->igd_opregion);
-     */
     vfio_pci_put_device(vdev);
 }
 
-- 
2.49.0


