Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43829C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6Bu-0006Ze-Sc; Thu, 05 Jun 2025 04:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6Bq-0006YJ-Pt
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uN6Bl-0008EC-UL
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749112982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tzKZT2zvE8ZgC/AwLSaejjjum29Bw9aQXpkQXCatp1M=;
 b=OnxSfnfBFH1ixYGuS5ewXuHcPPXpPFVDX2d0OlsYAa8wmIFk1EeqmTRdzLfRZXH8xqxcbJ
 1w9m/GCGtBq2R+WTZkV55GQuaB/kNF4Me2zCYt2daNToMAhjkydIdeXDomI+vuzHWzQaXY
 5ZzEZQf8QNAg/UXKaT3p/kjb4TgrfWc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-kj2ADxcJMNWnW8ESChkGHg-1; Thu,
 05 Jun 2025 04:43:01 -0400
X-MC-Unique: kj2ADxcJMNWnW8ESChkGHg-1
X-Mimecast-MFC-AGG-ID: kj2ADxcJMNWnW8ESChkGHg_1749112980
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A29B180045B; Thu,  5 Jun 2025 08:43:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74C421954B33; Thu,  5 Jun 2025 08:42:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/16] vfio: move config space read into vfio_pci_config_setup()
Date: Thu,  5 Jun 2025 10:42:33 +0200
Message-ID: <20250605084245.1520562-5-clg@redhat.com>
In-Reply-To: <20250605084245.1520562-1-clg@redhat.com>
References: <20250605084245.1520562-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

Small cleanup that reduces duplicate code for vfio-user and reduces the
size of vfio_realize(); while we're here, correct that name to
vfio_pci_realize().

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250520150419.2172078-4-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d96b55f80c0aa315d46aaa417c54569d71cbed1f..a873f82aeb355cfef68033e43b4829f64145d606 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3017,6 +3017,19 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
     VFIODevice *vbasedev = &vdev->vbasedev;
+    uint32_t config_space_size;
+    int ret;
+
+    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
+
+    /* Get a copy of config space */
+    ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
+                                     vdev->pdev.config);
+    if (ret < (int)config_space_size) {
+        ret = ret < 0 ? -ret : EFAULT;
+        error_setg_errno(errp, ret, "failed to read device config space");
+        return false;
+    }
 
     /* vfio emulates a lot for us, but some bits need extra love */
     vdev->emulated_config_bits = g_malloc0(vdev->config_size);
@@ -3138,15 +3151,14 @@ static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static void vfio_realize(PCIDevice *pdev, Error **errp)
+static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
-    int i, ret;
+    int i;
     char uuid[UUID_STR_LEN];
     g_autofree char *name = NULL;
-    uint32_t config_space_size;
 
     if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -3201,17 +3213,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
-
-    /* Get a copy of config space */
-    ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
-                                     vdev->pdev.config);
-    if (ret < (int)config_space_size) {
-        ret = ret < 0 ? -ret : EFAULT;
-        error_setg_errno(errp, ret, "failed to read device config space");
-        goto error;
-    }
-
     if (!vfio_pci_config_setup(vdev, errp)) {
         goto error;
     }
@@ -3515,7 +3516,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
 #endif
     dc->desc = "VFIO-based PCI device assignment";
-    pdc->realize = vfio_realize;
+    pdc->realize = vfio_pci_realize;
 
     object_class_property_set_description(klass, /* 1.3 */
                                           "host",
-- 
2.49.0


