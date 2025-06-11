Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94F4C678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN3C-00065P-7J; Wed, 11 Jun 2025 11:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN31-0005cP-5r
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2y-0007Bl-Tt
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gOQzLLiN8iauOujs8Nfw0zuPWkL6ghzAGZLmzgYRxsA=;
 b=DlSpxnczfir1Sl+PMDUOJOno3BStgN5ufWoqqpitCDHcIJsRjoVruqrHAkoRHBGxF27+eb
 3L5ZD8ejKqvknImePBuDywhxjrAuLlIWFlktIwI/oFUQsHeK+xStrQEz3hMIfFJgIcEpL7
 8r/XnvBT5HHRG22gnfRFjvtl/DbNnuM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-h_JtNDq_PxaZAZX1-jREKg-1; Wed,
 11 Jun 2025 11:07:21 -0400
X-MC-Unique: h_JtNDq_PxaZAZX1-jREKg-1
X-Mimecast-MFC-AGG-ID: h_JtNDq_PxaZAZX1-jREKg_1749654441
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BED819560B4; Wed, 11 Jun 2025 15:07:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 678EA180045B; Wed, 11 Jun 2025 15:07:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/27] vfio/pci: pass vector to virq functions
Date: Wed, 11 Jun 2025 17:06:15 +0200
Message-ID: <20250611150620.701903-24-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

Pass the vector number to vfio_connect_kvm_msi_virq and
vfio_remove_kvm_msi_virq, so it can be passed to their subroutines in
a subsequent patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1749569991-25171-15-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index dc0d9a7fbb939cdcae58c40e7bd33b0a2c1bd3ec..1d22c41efb6c6150ca1dff6ace752faad4a0fcfd 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -478,7 +478,7 @@ static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
                                              vector_n, &vdev->pdev);
 }
 
-static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector)
+static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
 {
     const char *name = "kvm_interrupt";
 
@@ -504,7 +504,8 @@ fail_notifier:
     vector->virq = -1;
 }
 
-static void vfio_remove_kvm_msi_virq(VFIOMSIVector *vector)
+static void vfio_remove_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
+                                     int nr)
 {
     kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vector->kvm_interrupt,
                                           vector->virq);
@@ -581,7 +582,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
      */
     if (vector->virq >= 0) {
         if (!msg) {
-            vfio_remove_kvm_msi_virq(vector);
+            vfio_remove_kvm_msi_virq(vdev, vector, nr);
         } else {
             vfio_update_kvm_msi_virq(vector, *msg, pdev);
         }
@@ -593,7 +594,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                 vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
                 vfio_add_kvm_msi_virq(vdev, vector, nr, true);
                 kvm_irqchip_commit_route_changes(&vfio_route_change);
-                vfio_connect_kvm_msi_virq(vector);
+                vfio_connect_kvm_msi_virq(vector, nr);
             }
         }
     }
@@ -687,7 +688,7 @@ static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
     kvm_irqchip_commit_route_changes(&vfio_route_change);
 
     for (i = 0; i < vdev->nr_vectors; i++) {
-        vfio_connect_kvm_msi_virq(&vdev->msi_vectors[i]);
+        vfio_connect_kvm_msi_virq(&vdev->msi_vectors[i], i);
     }
 }
 
@@ -827,7 +828,7 @@ static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
         VFIOMSIVector *vector = &vdev->msi_vectors[i];
         if (vdev->msi_vectors[i].use) {
             if (vector->virq >= 0) {
-                vfio_remove_kvm_msi_virq(vector);
+                vfio_remove_kvm_msi_virq(vdev, vector, i);
             }
             qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
                                 NULL, NULL, NULL);
-- 
2.49.0


