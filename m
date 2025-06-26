Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DE1C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 07:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhJl-0005Qa-T8; Thu, 26 Jun 2025 03:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJY-0004qx-1O
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJR-0001z0-IG
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750923984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMVdBE6sPxaz95ENjSAyU0hEzektczFNWQgGZnlVLh8=;
 b=JTFlgTt785jf2Z4u5iREPCmHmqlkd8tapOPmYmTMdMYXFW9Cs/PQIVavuN/imwOMt1h3hc
 jWwxUmfMRaY5+XBtA88udOk88IA+fc9nAoo4tMtNJDUvXbzyQ6hZWoOLg59DQmT2A2hsYA
 k7l7LX+nk6bvulioiAI1bHtdOG1zxL0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-lbaYQ96JOLKXjMdTzHr5cQ-1; Thu,
 26 Jun 2025 03:46:21 -0400
X-MC-Unique: lbaYQ96JOLKXjMdTzHr5cQ-1
X-Mimecast-MFC-AGG-ID: lbaYQ96JOLKXjMdTzHr5cQ_1750923980
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21511193F069; Thu, 26 Jun 2025 07:46:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AFAE6180035C; Thu, 26 Jun 2025 07:46:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/25] vfio-user: forward MSI-X PBA BAR accesses to server
Date: Thu, 26 Jun 2025 09:45:20 +0200
Message-ID: <20250626074529.1384114-17-clg@redhat.com>
In-Reply-To: <20250626074529.1384114-1-clg@redhat.com>
References: <20250626074529.1384114-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

From: John Levon <john.levon@nutanix.com>

For vfio-user, the server holds the pending IRQ state; set up an I/O
region for the MSI-X PBA so we can ask the server for this state on a
PBA read.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250625193012.2316242-11-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h      |  1 +
 hw/vfio-user/pci.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index d3dc2274a97bc591b02df117f4488d24cd39fe7a..5ba7330b27e80d1a565da2704689e48fa9bece18 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -116,6 +116,7 @@ typedef struct VFIOMSIXInfo {
     uint32_t pba_offset;
     unsigned long *pending;
     bool noresize;
+    MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
 /*
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index b49f42b980017d61a2676c5dd7e01a869a63ac50..c0f00f15b10a80820606ff4ef0383d59ecd91670 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -24,6 +24,62 @@ struct VFIOUserPCIDevice {
     bool send_queued;   /* all sends are queued */
 };
 
+/*
+ * The server maintains the device's pending interrupts,
+ * via its MSIX table and PBA, so we treat these accesses
+ * like PCI config space and forward them.
+ */
+static uint64_t vfio_user_pba_read(void *opaque, hwaddr addr,
+                                   unsigned size)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIORegion *region = &vdev->bars[vdev->msix->pba_bar].region;
+    uint64_t data;
+
+    /* server copy is what matters */
+    data = vfio_region_read(region, addr + vdev->msix->pba_offset, size);
+    return data;
+}
+
+static void vfio_user_pba_write(void *opaque, hwaddr addr,
+                                  uint64_t data, unsigned size)
+{
+    /* dropped */
+}
+
+static const MemoryRegionOps vfio_user_pba_ops = {
+    .read = vfio_user_pba_read,
+    .write = vfio_user_pba_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void vfio_user_msix_setup(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *vfio_reg, *msix_reg, *pba_reg;
+
+    pba_reg = g_new0(MemoryRegion, 1);
+    vdev->msix->pba_region = pba_reg;
+
+    vfio_reg = vdev->bars[vdev->msix->pba_bar].mr;
+    msix_reg = &vdev->pdev.msix_pba_mmio;
+    memory_region_init_io(pba_reg, OBJECT(vdev), &vfio_user_pba_ops, vdev,
+                          "VFIO MSIX PBA", int128_get64(msix_reg->size));
+    memory_region_add_subregion_overlap(vfio_reg, vdev->msix->pba_offset,
+                                        pba_reg, 1);
+}
+
+static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *mr, *sub;
+
+    mr = vdev->bars[vdev->msix->pba_bar].mr;
+    sub = vdev->msix->pba_region;
+    memory_region_del_subregion(mr, sub);
+
+    g_free(vdev->msix->pba_region);
+    vdev->msix->pba_region = NULL;
+}
+
 /*
  * Incoming request message callback.
  *
@@ -144,6 +200,10 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto out_teardown;
     }
 
+    if (vdev->msix != NULL) {
+        vfio_user_msix_setup(vdev);
+    }
+
     if (!vfio_pci_interrupt_setup(vdev, errp)) {
         goto out_teardown;
     }
@@ -192,6 +252,10 @@ static void vfio_user_instance_finalize(Object *obj)
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
+    if (vdev->msix != NULL) {
+        vfio_user_msix_teardown(vdev);
+    }
+
     vfio_pci_put_device(vdev);
 
     if (vbasedev->proxy != NULL) {
-- 
2.49.0


