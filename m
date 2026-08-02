Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F7EC55162
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 13:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqWiS-0003fM-3x; Sun, 02 Aug 2026 09:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wqWiP-0003el-NZ
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 09:58:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wqWiO-0002wO-3a
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 09:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785679135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oe30+pZLs7ebCtt568b7pWAkTjVmXsh5LCbTA0CdRNI=;
 b=FztpZSXOtR97HJrIIYEmeGvkaStpYSK71Ehwtx0WjxOsLtbjZ0ZIjuQr1UbzwZuG6cJmiz
 7REl1X0aremipDuINWtHYug2nZ3DUZOlE6MIo8Vk7rP56DjGeBb6hrcSU/TllvjVlVlx0P
 vFY3gyNKq8CpjEa87MAJ1NZEb3aXdCA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-a5_nIiiOOGKVvJnWbEgjCA-1; Sun,
 02 Aug 2026 09:58:53 -0400
X-MC-Unique: a5_nIiiOOGKVvJnWbEgjCA-1
X-Mimecast-MFC-AGG-ID: a5_nIiiOOGKVvJnWbEgjCA_1785679133
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01A061956089; Sun,  2 Aug 2026 13:58:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.25])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD65130002E9; Sun,  2 Aug 2026 13:58:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 2/2] vfio/pci: Guard accel_irqchip_begin_route_changes() calls
Date: Sun,  2 Aug 2026 15:58:46 +0200
Message-ID: <20260802135846.328866-3-clg@redhat.com>
In-Reply-To: <20260802135846.328866-1-clg@redhat.com>
References: <20260802135846.328866-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since commit 49b2dcbd2422 ("accel/accel-irq: add generic
begin_route_changes"), accel_irqchip_begin_route_changes() aborts when
no accelerator irqchip is available. This causes a fatal error when
running VFIO passthrough devices under TCG emulation:

  qemu-system-aarch64: can't initiate route change, no accel irqchip available

The previous kvm_irqchip_begin_route_changes() was a simple inline
that did not have a fatal path. The VFIO code already handles the
absence of KVM MSI routing gracefully by falling back to userspace
handling, but the new generic function aborts before that fallback
can take effect.

Guard the call sites in hw/vfio/pci.c with
accel_msi_via_irqfd_enabled() so that route changes are only
initiated when an accelerator irqchip is actually present.

Fixes: 49b2dcbd2422 ("accel/accel-irq: add generic begin_route_changes")
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/qemu-devel/20260721105026.3932297-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b5280c3d2a366cd7cff4069936858ac651afeb6d..428ab2f06983ba9ecb306975a4aca7f6efe1b855 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -699,7 +699,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
         if (msg) {
             if (vdev->defer_kvm_irq_routing) {
                 vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
-            } else {
+            } else if (accel_msi_via_irqfd_enabled()) {
                 vfio_route_change = accel_irqchip_begin_route_changes();
                 vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
                 accel_irqchip_commit_route_changes(&vfio_route_change);
@@ -801,7 +801,9 @@ void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 {
     assert(!vdev->defer_kvm_irq_routing);
     vdev->defer_kvm_irq_routing = true;
-    vfio_route_change = accel_irqchip_begin_route_changes();
+    if (accel_msi_via_irqfd_enabled()) {
+        vfio_route_change = accel_irqchip_begin_route_changes();
+    }
 }
 
 void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
-- 
2.55.0


