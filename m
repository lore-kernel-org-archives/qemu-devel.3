Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C343C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC0B-0006tZ-3v; Thu, 06 Mar 2025 09:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC08-0006qw-Tn
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC07-0001aZ-4q
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sOP2UCzhPbCeiRkfJuaSQp64INrHzLLVntxr+JH2q3k=;
 b=WqdBvjNv1GyEnN8LXffLBCGTXqa9jvicCaYpjroA5V/0+qO8kav7cGSbkPsf31+zUr6PlB
 dUBpGEpvqLr+tALYyMDw1K4aTd0/Ha1QvBdxTHWyhUsqS3qiZoNo6XRcy3FWyU2CEIP03x
 kZjhiQ13l39DWrRXd5DbbEBt18cgTGU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-farwqlZaPzGiEPI_mBFUkg-1; Thu,
 06 Mar 2025 09:14:54 -0500
X-MC-Unique: farwqlZaPzGiEPI_mBFUkg-1
X-Mimecast-MFC-AGG-ID: farwqlZaPzGiEPI_mBFUkg_1741270493
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EA831828A9B; Thu,  6 Mar 2025 14:14:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD32718001D3; Thu,  6 Mar 2025 14:14:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 07/42] hw/vfio/pci: Re-order pre-reset
Date: Thu,  6 Mar 2025 15:13:43 +0100
Message-ID: <20250306141419.2015340-8-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Alex Williamson <alex.williamson@redhat.com>

We want the device in the D0 power state going into reset, but the
config write can enable the BARs in the address space, which are
then removed from the address space once we clear the memory enable
bit in the command register.  Re-order to clear the command bit
first, so the power state change doesn't enable the BARs.

Cc: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250225215237.3314011-6-alex.williamson@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a8db19d8d2f9707693500493eb237c7362d35c06..c1cee280ae4bbfc5a479aa5d1f2290065667a677 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2410,6 +2410,15 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
 
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
@@ -2429,15 +2438,6 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
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


