Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAC6C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 14:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT0wD-0001cH-NC; Thu, 25 Jan 2024 09:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=OPgD=JD=redhat.com=clg@ozlabs.org>)
 id 1rT0wA-0001c6-J3; Thu, 25 Jan 2024 09:42:38 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=OPgD=JD=redhat.com=clg@ozlabs.org>)
 id 1rT0w7-0008Qz-VC; Thu, 25 Jan 2024 09:42:37 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLNpB6LQjz4wdB;
 Fri, 26 Jan 2024 01:42:26 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLNp86RmFz4wc6;
 Fri, 26 Jan 2024 01:42:24 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jing Liu <jing2.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH] vfio/pci: Clear MSI-X IRQ index always
Date: Thu, 25 Jan 2024 15:42:20 +0100
Message-ID: <20240125144220.770725-1-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=OPgD=JD=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When doing device assignment of a physical device, MSI-X can be
enabled with no vectors enabled and this sets the IRQ index to
VFIO_PCI_MSIX_IRQ_INDEX. However, when MSI-X is disabled, the IRQ
index is left untouched if no vectors are in use. Then, when INTx
is enabled, the IRQ index value is considered incompatible (set to
MSI-X) and VFIO_DEVICE_SET_IRQS fails. QEMU complains with :

qemu-system-x86_64: vfio 0000:08:00.0: Failed to set up TRIGGER eventfd signaling for interrupt INTX-0: VFIO_DEVICE_SET_IRQS failure: Invalid argument

To avoid that, unconditionaly clear the IRQ index when MSI-X is
disabled.

Buglink: https://issues.redhat.com/browse/RHEL-21293
Fixes: 5ebffa4e87e7 ("vfio/pci: use an invalid fd to enable MSI-X")
Cc: Jing Liu <jing2.liu@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d7fe06715c4b9cde66a68c31aaf405315921b0d6..4fa387f0430d62ca2ba1b5ae5b7037f8f06b33f9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -826,9 +826,11 @@ static void vfio_msix_disable(VFIOPCIDevice *vdev)
         }
     }
 
-    if (vdev->nr_vectors) {
-        vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
-    }
+    /*
+     * Always clear MSI-X IRQ index. A PF device could have enabled
+     * MSI-X with no vectors. See vfio_msix_enable().
+     */
+    vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
 
     vfio_msi_disable_common(vdev);
     vfio_intx_enable(vdev, &err);
-- 
2.43.0


