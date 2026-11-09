Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5BC606D806
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JH4FEXB7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLKz-0002gJ-P3; Mon, 09 Nov 2026 04:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLKo-0002Z2-Rc
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:06:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLKn-0002s1-5g
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794215195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bYvpjXcyCKC5HUpeJIqqRue2GcFzskb/n75G54uXyLo=;
 b=JH4FEXB7uuzl74IKM5RqeygbDtvF3nr62myhWUide+WaMcWEFBRutTAx0rYL3ep2bXh/L1
 CWNlm5fLp5vpcDANaT4nxt9I63v+Kttg4nUUWAWjehc8bHHtXCLkmeVSGnLpA9uOU86meN
 UmwZ6FLiqVSBh8/ZX477+m0AXYNuA4w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-_FZelS5yM9q2PMB1WceGtw-1; Mon,
 09 Nov 2026 04:06:34 -0500
X-MC-Unique: _FZelS5yM9q2PMB1WceGtw-1
X-Mimecast-MFC-AGG-ID: _FZelS5yM9q2PMB1WceGtw_1794215193
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79B6A180029F; Mon,  9 Nov 2026 09:06:33 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 20B8330000E5; Mon,  9 Nov 2026 09:06:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-12.0 2/9] vfio/pci: Move vfio_mmap_set_enabled() to
 region.c
Date: Mon,  9 Nov 2026 10:06:18 +0100
Message-ID: <20261109090625.908592-3-clg@redhat.com>
In-Reply-To: <20261109090625.908592-1-clg@redhat.com>
References: <20261109090625.908592-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vfio_mmap_set_enabled() iterates over BAR regions calling
vfio_region_mmaps_set_enabled(). Move it from pci-irq.c to region.c
and rename it to vfio_region_set_enabled().

No functional change.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h         |  1 -
 hw/vfio/vfio-region.h |  4 +++-
 hw/vfio/pci-irq.c     | 15 +++------------
 hw/vfio/region.c      | 12 +++++++++++-
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 2e6c90cbf8ff..3315fb4fbceb 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -232,7 +232,6 @@ void vfio_update_msi(VFIOPCIDevice *vdev);
 bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp);
 bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp);
 bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp);
-void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);
 void vfio_pci_intx_eoi(VFIODevice *vbasedev);
 void vfio_pci_teardown_msi(VFIOPCIDevice *vdev);
diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index abcfbacfff1b..51d4caf5dcd3 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -42,7 +42,6 @@ uint64_t vfio_region_read(void *opaque,
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name, Error **errp);
 int vfio_region_mmap(VFIORegion *region);
-void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 
@@ -51,4 +50,7 @@ int vfio_region_setup_sparse_mmaps(VFIORegion *region,
                                     struct vfio_region_info *info,
                                     Error **errp);
 
+struct VFIOPCIDevice;
+void vfio_region_set_enabled(struct VFIOPCIDevice *vdev, bool enabled);
+
 #endif /* HW_VFIO_REGION_H */
diff --git a/hw/vfio/pci-irq.c b/hw/vfio/pci-irq.c
index c68be22f8723..2b2a118b130a 100644
--- a/hw/vfio/pci-irq.c
+++ b/hw/vfio/pci-irq.c
@@ -93,7 +93,7 @@ static void vfio_intx_mmap_enable(void *opaque)
         return;
     }
 
-    vfio_mmap_set_enabled(vdev, true);
+    vfio_region_set_enabled(vdev, true);
 }
 
 static void vfio_intx_interrupt(void *opaque)
@@ -109,7 +109,7 @@ static void vfio_intx_interrupt(void *opaque)
 
     vdev->intx.pending = true;
     pci_irq_assert(pdev);
-    vfio_mmap_set_enabled(vdev, false);
+    vfio_region_set_enabled(vdev, false);
     if (vdev->intx.mmap_timeout) {
         timer_mod(vdev->intx.mmap_timer,
                        qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + vdev->intx.mmap_timeout);
@@ -389,7 +389,7 @@ void vfio_intx_disable(VFIOPCIDevice *vdev)
     vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
     pci_irq_deassert(pdev);
-    vfio_mmap_set_enabled(vdev, true);
+    vfio_region_set_enabled(vdev, true);
 
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
     qemu_set_fd_handler(fd, NULL, NULL, vdev);
@@ -1439,15 +1439,6 @@ void vfio_pci_teardown_msi(VFIOPCIDevice *vdev)
     }
 }
 
-void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled)
-{
-    int i;
-
-    for (i = 0; i < PCI_ROM_SLOT; i++) {
-        vfio_region_mmaps_set_enabled(&vdev->bars[i].region, enabled);
-    }
-}
-
 /*
  * Err/Req notifiers
  */
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 30bc5079f1a7..d54d5e34cef5 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -30,6 +30,7 @@
 #include "qemu/units.h"
 #include "monitor/monitor.h"
 #include "system/ramblock.h"
+#include "pci.h"
 #include "vfio-helpers.h"
 
 /*
@@ -539,7 +540,7 @@ void vfio_region_finalize(VFIORegion *region)
     region->nr = 0;
 }
 
-void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
+static void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
 {
     int i;
 
@@ -556,3 +557,12 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
     trace_vfio_region_mmaps_set_enabled(memory_region_name(region->mem),
                                         enabled);
 }
+
+void vfio_region_set_enabled(VFIOPCIDevice *vdev, bool enabled)
+{
+    int i;
+
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        vfio_region_mmaps_set_enabled(&vdev->bars[i].region, enabled);
+    }
+}
-- 
2.56.0


