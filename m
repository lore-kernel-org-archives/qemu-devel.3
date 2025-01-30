Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C8CC02190
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUPy-00006O-A0; Thu, 30 Jan 2025 08:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUP0-0007RB-Du
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOw-00008M-MF
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738242969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOg0khL/nFR+01yux0bKcXoZ2hGXnkX9GGBxE3V2ChU=;
 b=fDxMTZ4L0o3h5xyJmgqP643tdYQZZBRZuVbU7WhZEQe2rEvZvTa6zgylnL991ONyjqSf2w
 Q5953UBu93eiEJhsz57B7Bep/iuW03sLeyNJqRXLspT+IXVvmDQ9I7tcHnNakQogeBMKZT
 w+ok3q8//fT0EKiTOFP+hkx92zmbVFw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-owMZhpVeNYOuLepDUj2qjw-1; Thu,
 30 Jan 2025 08:16:07 -0500
X-MC-Unique: owMZhpVeNYOuLepDUj2qjw-1
X-Mimecast-MFC-AGG-ID: owMZhpVeNYOuLepDUj2qjw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A655F1956050; Thu, 30 Jan 2025 13:16:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE84E30001BE; Thu, 30 Jan 2025 13:16:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Reza Arbab <arbab@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 11/20] virtio-balloon-pci: Allow setting nvectors,
 so we can use MSI-X
Date: Thu, 30 Jan 2025 14:15:25 +0100
Message-ID: <20250130131535.91297-12-thuth@redhat.com>
In-Reply-To: <20250130131535.91297-1-thuth@redhat.com>
References: <20250130131535.91297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Reza Arbab <arbab@linux.ibm.com>

Most virtio-pci devices allow MSI-X. Add it to virtio-balloon-pci, but
only enable it in new machine types, so we don't break migration of
existing machine types between different qemu versions.

This copies what was done for virtio-rng-pci in:
9ea02e8f1306 ("virtio-rng-pci: Allow setting nvectors, so we can use MSI-X")
bad9c5a5166f ("virtio-rng-pci: fix migration compat for vectors")
62bdb8871512 ("virtio-rng-pci: fix transitional migration compat for vectors")

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Message-ID: <20250115161425.246348-1-arbab@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/core/machine.c              |  3 +++
 hw/virtio/virtio-balloon-pci.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c23b399496..8f396ef803 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,9 @@
 
 GlobalProperty hw_compat_9_2[] = {
     {"arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
+    { "virtio-balloon-pci", "vectors", "0" },
+    { "virtio-balloon-pci-transitional", "vectors", "0" },
+    { "virtio-balloon-pci-non-transitional", "vectors", "0" },
 };
 const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
 
diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.c
index ce2645ba71..db7e1cb475 100644
--- a/hw/virtio/virtio-balloon-pci.c
+++ b/hw/virtio/virtio-balloon-pci.c
@@ -35,11 +35,22 @@ struct VirtIOBalloonPCI {
     VirtIOBalloon vdev;
 };
 
+static const Property virtio_balloon_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+};
+
 static void virtio_balloon_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VirtIOBalloonPCI *dev = VIRTIO_BALLOON_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
 
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = 2;
+    }
+
     vpci_dev->class_code = PCI_CLASS_OTHERS;
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
@@ -55,6 +66,7 @@ static void virtio_balloon_pci_class_init(ObjectClass *klass, void *data)
     pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BALLOON;
     pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
     pcidev_k->class_id = PCI_CLASS_OTHERS;
+    device_class_set_props(dc, virtio_balloon_properties);
 }
 
 static void virtio_balloon_pci_instance_init(Object *obj)
-- 
2.48.1


