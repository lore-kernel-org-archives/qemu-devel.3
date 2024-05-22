Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC75C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ih2-0003Yu-OD; Wed, 22 May 2024 05:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ign-0003RM-4u
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igk-0001Q3-N5
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbYDvgZ3A8fXGUyykwgKl2IroA+m5TOvdcZPY3ucw2s=;
 b=QuluR2mC4UNjv5dpiha5/bJUjaNuMiNplpNC+tt7ulVSddmsBGMFPG9bXdGAXnRGZ+1DdR
 7YsWxdOqyXYcdiWgTLG70EKv5HaaFNANfuu/UNrpily6+GTU+Chk5rRlsvuDxZFHj8QNnH
 1nV5TbHrSkUsEoFvKkLUHNtltKyJq60=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-V2N0Rg6uP-2KXOGCFsHy_w-1; Wed,
 22 May 2024 05:55:10 -0400
X-MC-Unique: V2N0Rg6uP-2KXOGCFsHy_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74087380673C;
 Wed, 22 May 2024 09:55:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A79F27414;
 Wed, 22 May 2024 09:55:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Vinayak Kale <vkale@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/47] vfio/pci: migration: Skip config space check for Vendor
 Specific Information in VSC during restore/load
Date: Wed, 22 May 2024 11:54:09 +0200
Message-ID: <20240522095442.195243-15-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

From: Vinayak Kale <vkale@nvidia.com>

In case of migration, during restore operation, qemu checks config space of the
pci device with the config space in the migration stream captured during save
operation. In case of config space data mismatch, restore operation is failed.

config space check is done in function get_pci_config_device(). By default VSC
(vendor-specific-capability) in config space is checked.

Due to qemu's config space check for VSC, live migration is broken across NVIDIA
vGPU devices in situation where source and destination host driver is different.
In this situation, Vendor Specific Information in VSC varies on the destination
to ensure vGPU feature capabilities exposed to the guest driver are compatible
with destination host.

If a vfio-pci device is migration capable and vfio-pci vendor driver is OK with
volatile Vendor Specific Info in VSC then qemu should exempt config space check
for Vendor Specific Info. It is vendor driver's responsibility to ensure that
VSC is consistent across migration. Here consistency could mean that VSC format
should be same on source and destination, however actual Vendor Specific Info
may not be byte-to-byte identical.

This patch skips the check for Vendor Specific Information in VSC for VFIO-PCI
device by clearing pdev->cmask[] offsets. Config space check is still enforced
for 3 byte VSC header. If cmask[] is not set for an offset, then qemu skips
config space check for that offset.

VSC check is skipped for machine types >= 9.1. The check would be enforced on
older machine types (<= 9.0).

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vinayak Kale <vkale@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h     |  1 +
 hw/core/machine.c |  1 +
 hw/vfio/pci.c     | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 6e64a2654e690af11b72710530a41135b726e96f..92cd62d1159dbd47d878454f201f9c18112a7692 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -177,6 +177,7 @@ struct VFIOPCIDevice {
     OnOffAuto ramfb_migrate;
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
+    bool skip_vsc_check;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
 };
diff --git a/hw/core/machine.c b/hw/core/machine.c
index c7ceb1150147eb2bdd5f7ef583d00cee88f306cd..3442f31f9458c4e1bdde366aa40bfe3ad8b321a8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -35,6 +35,7 @@
 
 GlobalProperty hw_compat_9_0[] = {
     {"arm-cpu", "backcompat-cntfrq", "true" },
+    {"vfio-pci", "skip-vsc-check", "false" },
 };
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index fc6e54e871508bb0e2a3ac9079a195c086531f21..4789d43c0f9cc7ef94b73adc815377f7222d8c57 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2134,6 +2134,28 @@ static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
     }
 }
 
+static int vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
+                                        uint8_t size, Error **errp)
+{
+    PCIDevice *pdev = &vdev->pdev;
+
+    pos = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, size, errp);
+    if (pos < 0) {
+        return pos;
+    }
+
+    /*
+     * Exempt config space check for Vendor Specific Information during
+     * restore/load.
+     * Config space check is still enforced for 3 byte VSC header.
+     */
+    if (vdev->skip_vsc_check && size > 3) {
+        memset(pdev->cmask + pos + 3, 0, size - 3);
+    }
+
+    return pos;
+}
+
 static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
 {
     ERRP_GUARD();
@@ -2202,6 +2224,9 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
         vfio_check_af_flr(vdev, pos);
         ret = pci_add_capability(pdev, cap_id, pos, size, errp);
         break;
+    case PCI_CAP_ID_VNDR:
+        ret = vfio_add_vendor_specific_cap(vdev, pos, size, errp);
+        break;
     default:
         ret = pci_add_capability(pdev, cap_id, pos, size, errp);
         break;
@@ -3391,6 +3416,7 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
+    DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.45.1


