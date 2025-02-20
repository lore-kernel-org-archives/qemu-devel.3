Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAE6C021B4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 22:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlFMn-0000YF-Or; Thu, 20 Feb 2025 17:50:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tlFMl-0000XS-7L
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 17:50:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tlFMf-0007hx-ES
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 17:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740091791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/K4a9lJqOcl/+KANDHuSpFRF/H3zOSrUvDABEJptC0=;
 b=Qzf7eDh7RS1Ye0m0bwAuCKd0PFR4xadyzMNPqx7sqZ5sFWd72VNXe4CexyoHDmm/SRjL83
 IafTuy8d4Hxo7Ut/Ruf7f4+2iheTnR1uJG2yhCW08f7LUIAb/1J2/NSA7MQH23AURx6pIS
 ia0mCoB2Npgap1W3M4fDLxHsQlpg+M8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-bcr4XA_xMnSe7nnUQge1IA-1; Thu,
 20 Feb 2025 17:49:50 -0500
X-MC-Unique: bcr4XA_xMnSe7nnUQge1IA-1
X-Mimecast-MFC-AGG-ID: bcr4XA_xMnSe7nnUQge1IA_1740091789
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBE9A1800871; Thu, 20 Feb 2025 22:49:48 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.88.77])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 497071955BCB; Thu, 20 Feb 2025 22:49:47 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, clg@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Subject: [PATCH 5/5] hw/vfio/pci: Re-order pre-reset
Date: Thu, 20 Feb 2025 15:48:58 -0700
Message-ID: <20250220224918.2520417-6-alex.williamson@redhat.com>
In-Reply-To: <20250220224918.2520417-1-alex.williamson@redhat.com>
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
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

We want the device in the D0 power state going into reset, but the
config write can enable the BARs in the address space, which are
then removed from the address space once we clear the memory enable
bit in the command register.  Re-order to clear the command bit
first, so the power state change doesn't enable the BARs.

Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ba4ef65b16fa..fcc5f118bf90 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2405,6 +2405,15 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
 
     vfio_disable_interrupts(vdev);
 
+    /*
+     * Stop any ongoing DMA by disconnecting I/O, MMIO, and bus master.
+     * Also put INTx Disable in known state.
+     */
+    cmd = vfio_pci_read_config(pdev, PCI_COMMAND, 2);
+    cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
+             PCI_COMMAND_INTX_DISABLE);
+    vfio_pci_write_config(pdev, PCI_COMMAND, cmd, 2);
+
     /* Make sure the device is in D0 */
     if (pdev->pm_cap) {
         uint16_t pmcsr;
@@ -2424,15 +2433,6 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
             }
         }
     }
-
-    /*
-     * Stop any ongoing DMA by disconnecting I/O, MMIO, and bus master.
-     * Also put INTx Disable in known state.
-     */
-    cmd = vfio_pci_read_config(pdev, PCI_COMMAND, 2);
-    cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
-             PCI_COMMAND_INTX_DISABLE);
-    vfio_pci_write_config(pdev, PCI_COMMAND, cmd, 2);
 }
 
 void vfio_pci_post_reset(VFIOPCIDevice *vdev)
-- 
2.48.1


