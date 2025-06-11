Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A1BC678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN3F-0006Tm-Eh; Wed, 11 Jun 2025 11:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN3C-00067h-DQ
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN3A-0007DZ-Ch
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BsxD0QoGu2gGa5vU6B8722YrthlSDcy7GlRoSTzSQ8=;
 b=OdHbjHQtuoUOUwc1vQND4aBtF207ISsG8m0CBi325huBBDP5GDWOaAGf8Ibt070WROKLGq
 du9RzfT1BiFqUH5EJXowlLQZzGY8ApS7kUKqWm1nnWhwNcI8cbj+oOwDPoLrbV5BxNOGBx
 Y4bDWBcGP8CCoT3eAVbHddcgfS/hHN4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-4vN196XcPsydvL1BwnItZA-1; Wed,
 11 Jun 2025 11:07:29 -0400
X-MC-Unique: 4vN196XcPsydvL1BwnItZA-1
X-Mimecast-MFC-AGG-ID: 4vN196XcPsydvL1BwnItZA_1749654447
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66F43180028E; Wed, 11 Jun 2025 15:07:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C651818002B6; Wed, 11 Jun 2025 15:07:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/27] vfio/pci: export MSI functions
Date: Wed, 11 Jun 2025 17:06:18 +0200
Message-ID: <20250611150620.701903-27-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
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

From: Steve Sistare <steven.sistare@oracle.com>

Export various MSI functions, renamed with a vfio_pci prefix, for use by
CPR in subsequent patches.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1749569991-25171-18-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h |  8 ++++++++
 hw/vfio/pci.c | 29 +++++++++++++++++------------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index d4c6b2e7b77f26e44f902e6b840d7e39d39de3e9..d3dc2274a97bc591b02df117f4488d24cd39fe7a 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -210,6 +210,14 @@ static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
     return class == PCI_CLASS_DISPLAY_VGA;
 }
 
+/* MSI/MSI-X/INTx */
+void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr);
+void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
+                               int vector_n, bool msix);
+void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
+void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
+bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);
+
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 06a7a63cf501deafe26b1a9172eb56fecf4deaf3..fa25bded25c51f8efb6c5ad31bd90506cd69745c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -351,6 +351,11 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
     trace_vfio_intx_disable(vdev->vbasedev.name);
 }
 
+bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp)
+{
+    return vfio_intx_enable(vdev, errp);
+}
+
 /*
  * MSI/X
  */
@@ -475,8 +480,8 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
     return ret;
 }
 
-static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
-                                  int vector_n, bool msix)
+void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
+                               int vector_n, bool msix)
 {
     if ((msix && vdev->no_kvm_msix) || (!msix && vdev->no_kvm_msi)) {
         return;
@@ -549,7 +554,7 @@ static void set_irq_signalling(VFIODevice *vbasedev, VFIOMSIVector *vector,
     }
 }
 
-static void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
+void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
 {
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
     PCIDevice *pdev = &vdev->pdev;
@@ -599,10 +604,10 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     } else {
         if (msg) {
             if (vdev->defer_kvm_irq_routing) {
-                vfio_add_kvm_msi_virq(vdev, vector, nr, true);
+                vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
             } else {
                 vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
-                vfio_add_kvm_msi_virq(vdev, vector, nr, true);
+                vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
                 kvm_irqchip_commit_route_changes(&vfio_route_change);
                 vfio_connect_kvm_msi_virq(vector, nr);
             }
@@ -681,14 +686,14 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
     }
 }
 
-static void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
+void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 {
     assert(!vdev->defer_kvm_irq_routing);
     vdev->defer_kvm_irq_routing = true;
     vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
 }
 
-static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
+void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 {
     int i;
 
@@ -718,14 +723,14 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
      * routes once rather than per vector provides a substantial
      * performance improvement.
      */
-    vfio_prepare_kvm_msi_virq_batch(vdev);
+    vfio_pci_prepare_kvm_msi_virq_batch(vdev);
 
     if (msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
                                   vfio_msix_vector_release, NULL)) {
         error_report("vfio: msix_set_vector_notifiers failed");
     }
 
-    vfio_commit_kvm_msi_virq_batch(vdev);
+    vfio_pci_commit_kvm_msi_virq_batch(vdev);
 
     if (vdev->nr_vectors) {
         ret = vfio_enable_vectors(vdev, true);
@@ -769,7 +774,7 @@ retry:
      * Deferring to commit the KVM routes once rather than per vector
      * provides a substantial performance improvement.
      */
-    vfio_prepare_kvm_msi_virq_batch(vdev);
+    vfio_pci_prepare_kvm_msi_virq_batch(vdev);
 
     vdev->msi_vectors = g_new0(VFIOMSIVector, vdev->nr_vectors);
 
@@ -793,10 +798,10 @@ retry:
          * Attempt to enable route through KVM irqchip,
          * default to userspace handling if unavailable.
          */
-        vfio_add_kvm_msi_virq(vdev, vector, i, false);
+        vfio_pci_add_kvm_msi_virq(vdev, vector, i, false);
     }
 
-    vfio_commit_kvm_msi_virq_batch(vdev);
+    vfio_pci_commit_kvm_msi_virq_batch(vdev);
 
     /* Set interrupt type prior to possible interrupts */
     vdev->interrupt = VFIO_INT_MSI;
-- 
2.49.0


