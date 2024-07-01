Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4F7C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 10:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOE46-0007bb-AX; Mon, 01 Jul 2024 06:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sOE3z-0007a6-NH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 06:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sOE3t-0007d3-OQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 06:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719828901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iJpQUSK5Tl/2tmWgJcrThww2HILOhZK5yOaXKEHin4s=;
 b=WkzdtocJWogBZ/NcXhu/PBB/lnTv2lKPa0MnvKoK3KuRYd1VxChS9BmQJEyLKxXCDajym4
 3lqs3sl20l1ZfC7wunoYdwXdodyqTzr6K/s0MitwA42zc8y5AxxOtsRKPA5IMzYdGQru56
 8/8x/yhJRkOX/08zDAkD41S1+3tBTl4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-z6yj7ST7PPWhB5BcnSlH5Q-1; Mon,
 01 Jul 2024 06:15:00 -0400
X-MC-Unique: z6yj7ST7PPWhB5BcnSlH5Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4800B19560AA
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2024 10:14:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.90])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2664E19560AA; Mon,  1 Jul 2024 10:14:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] virtio-iommu: Clear IOMMUDevice when VFIO device is unplugged
Date: Mon,  1 Jul 2024 12:14:53 +0200
Message-ID: <20240701101453.203985-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

When a VFIO device is hoplugged in a VM using virtio-iommu, IOMMUPciBus
and IOMMUDevice cache entries are created in the .get_address_space()
handler of the machine IOMMU device. However, these entries are never
destroyed, not even when the VFIO device is detached from the machine.
This can lead to an assert if the device is reattached again.

When reattached, the .get_address_space() handler reuses an
IOMMUDevice entry allocated when the VFIO device was first attached.
virtio_iommu_set_host_iova_ranges() is called later on from the
.set_iommu_device() handler an fails with an assert on 'probe_done'
because the device appears to have been already probed when this is
not the case.

The IOMMUDevice entry is allocated in pci_device_iommu_address_space()
called from under vfio_realize(), the VFIO PCI realize handler. Since
pci_device_unset_iommu_device() is called from vfio_exitfn(), a sub
function of the PCIDevice unrealize() handler, it seems that the
.unset_iommu_device() handler is the best place to release resources
allocated at realize time. Clear the IOMMUDevice cache entry there to
fix hotplug.

Fixes: 817ef10da23c ("virtio-iommu: Implement set|unset]_iommu_device() callbacks")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/virtio/virtio-iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 72011d2d11ebf1da343b5924f5514ccfe6b2580d..57f53f0fa79cb34bfb75f80bcb9301b523b2a6ab 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -467,6 +467,26 @@ static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
     return &sdev->as;
 }
 
+static void virtio_iommu_device_clear(VirtIOIOMMU *s, PCIBus *bus, int devfn)
+{
+    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
+    IOMMUDevice *sdev;
+
+    if (!sbus) {
+        return;
+    }
+
+    sdev = sbus->pbdev[devfn];
+    if (!sdev) {
+        return;
+    }
+
+    g_list_free_full(sdev->resv_regions, g_free);
+    sdev->resv_regions = NULL;
+    g_free(sdev);
+    sbus->pbdev[devfn] = NULL;
+}
+
 static gboolean hiod_equal(gconstpointer v1, gconstpointer v2)
 {
     const struct hiod_key *key1 = v1;
@@ -708,6 +728,7 @@ virtio_iommu_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
     }
 
     g_hash_table_remove(viommu->host_iommu_devices, &key);
+    virtio_iommu_device_clear(viommu, bus, devfn);
 }
 
 static const PCIIOMMUOps virtio_iommu_ops = {
-- 
2.45.2


