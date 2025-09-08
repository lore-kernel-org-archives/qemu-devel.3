Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD83DCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 17:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf9N-0007v3-Ku; Mon, 08 Sep 2025 12:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf9L-0007pQ-6J
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf9G-0001tN-Jy
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ypOxM9dc7y4eaNDSraygXyRP+ty+I+WP3T62HkaR0aM=;
 b=dHdgycEzug2BdmKxEOBR5OFShfEK+gnfS/9miCz/nETyq95Y9bnNcKwrJlNu+u012GF1at
 U99V6XTHkaus6lSDQRe3HIHHMcFM+1R5TA2nDBPgXHCWYIkwAHFKoU+U+FXovkb+3XhYQ1
 fJTlWdEwhEoxLdYXpReTs745sJzc2wA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-MVOrqmCmPfig852YIDyiqA-1; Mon,
 08 Sep 2025 12:55:16 -0400
X-MC-Unique: MVOrqmCmPfig852YIDyiqA-1
X-Mimecast-MFC-AGG-ID: MVOrqmCmPfig852YIDyiqA_1757350515
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D144180057A; Mon,  8 Sep 2025 16:55:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D915300018D; Mon,  8 Sep 2025 16:55:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 29/31] vfio-user/pci.c: use QOM casts where appropriate
Date: Mon,  8 Sep 2025 18:53:52 +0200
Message-ID: <20250908165354.1731444-30-clg@redhat.com>
In-Reply-To: <20250908165354.1731444-1-clg@redhat.com>
References: <20250908165354.1731444-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
accessing pdev directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250715093110.107317-21-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index c3947a8f2ec9c0309b4484b95a4bd5439fa1d17f..e2c309784fec5feca635eb0f314f02eabb2dbf1f 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -65,7 +65,7 @@ static void vfio_user_msix_setup(VFIOPCIDevice *vdev)
     vdev->msix->pba_region = pba_reg;
 
     vfio_reg = vdev->bars[vdev->msix->pba_bar].mr;
-    msix_reg = &vdev->pdev.msix_pba_mmio;
+    msix_reg = &PCI_DEVICE(vdev)->msix_pba_mmio;
     memory_region_init_io(pba_reg, OBJECT(vdev), &vfio_user_pba_ops, vdev,
                           "VFIO MSIX PBA", int128_get64(msix_reg->size));
     memory_region_add_subregion_overlap(vfio_reg, vdev->msix->pba_offset,
@@ -86,7 +86,7 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
 
 static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIOUserProxy *proxy = vdev->vbasedev.proxy;
     VFIOUserDMARW *res;
     MemTxResult r;
@@ -134,7 +134,7 @@ static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
 
 static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIOUserProxy *proxy = vdev->vbasedev.proxy;
     MemTxResult r;
 
-- 
2.51.0


