Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C621D29DF6
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfapn-0006c7-0y; Tue, 13 Jan 2026 04:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfapm-0006Zx-6n
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfapk-0003Hn-MI
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0wa9rGJeqlryTfU8/vEgaaNivp1IdGg23E4dxsNQfe0=;
 b=OBQTF1kSJLs68oTbUoOcSYRwsO9nsD2aWjuABVHwoumFTiQdb72JrjkI9Rkdjr8ftwdPzt
 uRPytE9ktaaA4wUeElb5+dPQ/ue063aA8uClTeO3m9dBpS5NYWbs0HcbM8vptYpGpqzj0N
 z0gO8FWgWtQ6yqjWis8i6aYe2EcwwT8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-_IcZB80NP_qmwJIasC8-Nw-1; Tue,
 13 Jan 2026 04:37:00 -0500
X-MC-Unique: _IcZB80NP_qmwJIasC8-Nw-1
X-Mimecast-MFC-AGG-ID: _IcZB80NP_qmwJIasC8-Nw_1768297019
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3575F1800359; Tue, 13 Jan 2026 09:36:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69D8230001A2; Tue, 13 Jan 2026 09:36:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/41] hw/pci: Export pci_device_get_iommu_bus_devfn() and
 return bool
Date: Tue, 13 Jan 2026 10:36:02 +0100
Message-ID: <20260113093637.1549214-7-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Returns true if PCI device is aliased or false otherwise. This will be
used in following patch to determine if a PCI device is under a PCI
bridge.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260106061304.314546-5-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/pci/pci.h |  2 ++
 hw/pci/pci.c         | 12 ++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index b72e4845009f3e3af0f01a85979b2cc5a5432f56..b22d350ba299addb3fccf17c4042ed6e9bd53d0b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -637,6 +637,8 @@ typedef struct PCIIOMMUOps {
                             bool is_write);
 } PCIIOMMUOps;
 
+bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
+                                    PCIBus **aliased_bus, int *aliased_devfn);
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 5996229c813c7fcc167f29175041dfe233aaa1b4..0d4cf906f048c10ff13135a7aec509ca1baabd42 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2869,20 +2869,21 @@ static void pci_device_class_base_init(ObjectClass *klass, const void *data)
  * For call sites which don't need aliased BDF, passing NULL to
  * aliased_[bus|devfn] is allowed.
  *
+ * Returns true if PCI device RID is aliased or false otherwise.
+ *
  * @piommu_bus: return root #PCIBus backed by an IOMMU for the PCI device.
  *
  * @aliased_bus: return aliased #PCIBus of the PCI device, optional.
  *
  * @aliased_devfn: return aliased devfn of the PCI device, optional.
  */
-static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
-                                           PCIBus **piommu_bus,
-                                           PCIBus **aliased_bus,
-                                           int *aliased_devfn)
+bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
+                                    PCIBus **aliased_bus, int *aliased_devfn)
 {
     PCIBus *bus = pci_get_bus(dev);
     PCIBus *iommu_bus = bus;
     int devfn = dev->devfn;
+    bool aliased = false;
 
     while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
         PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
@@ -2919,6 +2920,7 @@ static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
                 devfn = parent->devfn;
                 bus = parent_bus;
             }
+            aliased = true;
         }
 
         /*
@@ -2953,6 +2955,8 @@ static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
     if (aliased_devfn) {
         *aliased_devfn = devfn;
     }
+
+    return aliased;
 }
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
-- 
2.52.0


