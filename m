Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE5FC25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihJ-00043J-GZ; Wed, 22 May 2024 05:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihG-0003qG-So
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ihE-0001lw-RS
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wmo6MS5izlXdTvxEwKEvXFrvfXH3rJrzKQLemJ1NuoU=;
 b=gtUHy2r5uyUHqD1YddyYgTh+uoIY7Sr79U8B+xk+EZWUqHG8+2P12B06sImqhWbjCR+q6i
 4CrE8KY5rRiOoBxocWvoB9ewvvk98dj9IFJSAL1GODeNtk29tzE3Y/rKr9MtNXqvGLdMPb
 AKcbRMzwrQD+GDSPqsVc2+lmfo5ESgg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-JKcF0W5BO4qku0ERx_uc-A-1; Wed, 22 May 2024 05:55:42 -0400
X-MC-Unique: JKcF0W5BO4qku0ERx_uc-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DE0F81227E;
 Wed, 22 May 2024 09:55:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CB3451BF;
 Wed, 22 May 2024 09:55:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 37/47] vfio/pci: Make vfio_intx_enable_kvm() return a bool
Date: Wed, 22 May 2024 11:54:32 +0200
Message-ID: <20240522095442.195243-38-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Since vfio_intx_enable_kvm() takes an 'Error **' argument,
best practices suggest to return a bool. See the qapi/error.h
Rules section.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index aad012c34885ff2a5a39039777dddd962236b41b..12fb534d796f52724f365746c9c8c2491265f03d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -116,7 +116,7 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
     vfio_unmask_single_irqindex(vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 }
 
-static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
 #ifdef CONFIG_KVM
     int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
@@ -124,7 +124,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
         vdev->intx.route.mode != PCI_INTX_ENABLED ||
         !kvm_resamplefds_enabled()) {
-        return;
+        return true;
     }
 
     /* Get to a known interrupt state */
@@ -161,7 +161,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 
     trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
 
-    return;
+    return true;
 
 fail_vfio:
     kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
@@ -171,6 +171,9 @@ fail_irqfd:
 fail:
     qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
     vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
+    return false;
+#else
+    return true;
 #endif
 }
 
@@ -226,8 +229,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
         return;
     }
 
-    vfio_intx_enable_kvm(vdev, &err);
-    if (err) {
+    if (!vfio_intx_enable_kvm(vdev, &err)) {
         warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
@@ -302,8 +304,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
         return -errno;
     }
 
-    vfio_intx_enable_kvm(vdev, &err);
-    if (err) {
+    if (!vfio_intx_enable_kvm(vdev, &err)) {
         warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
-- 
2.45.1


