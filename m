Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4930EC30653
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCM-0003gF-G2; Mon, 24 Jun 2024 17:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCL-0003fi-Al
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCJ-0006h1-4L
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/kEeWueMYaOD7ss4z/eRg9sCl9TdZcGWF/dsPXKsyU=;
 b=LeAXHmBRP5gbYCTFRsEDManTMhXvm3O4zs7KBidcJW2YJlMB16rnEgurYPnCN8GShlUQvr
 O3qICunYYMm2PRmkBIeYq1tyRvV8GP8YG+xFqH3+ix9aNWUXnc4hCzcYbE9OfTnm1S0Rn/
 mSdgXJdQ+uMDmbrjCNias4Tcs0gOjR0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-vGxR2wGUMPm1-ontR-49zQ-1; Mon,
 24 Jun 2024 17:25:57 -0400
X-MC-Unique: vGxR2wGUMPm1-ontR-49zQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1129019560A3; Mon, 24 Jun 2024 21:25:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 607C71956051; Mon, 24 Jun 2024 21:25:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 21/42] HostIOMMUDevice: Store the aliased bus and devfn
Date: Mon, 24 Jun 2024 23:24:35 +0200
Message-ID: <20240624212456.350919-22-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

Store the aliased bus and devfn in the HostIOMMUDevice.
This will be useful to handle info that are iommu group
specific and not device specific (such as reserved
iova ranges).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/sysemu/host_iommu_device.h | 2 ++
 hw/pci/pci.c                       | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index 40e0fa13efb5c023bc9b46fc99bf553cb93adf24..ee6c813c8b2299ed1d1d3b34d143c20a8ec27400 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -35,6 +35,8 @@ struct HostIOMMUDevice {
 
     char *name;
     void *agent; /* pointer to agent device, ie. VFIO or VDPA device */
+    PCIBus *aliased_bus;
+    int aliased_devfn;
     HostIOMMUDeviceCaps caps;
 };
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c8a8aab30646c5e37816f49f6ef9d1bdf8be241f..50b86d57907411ee7646b436dda53503eca33c13 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2745,11 +2745,15 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp)
 {
-    PCIBus *iommu_bus;
+    PCIBus *iommu_bus, *aliased_bus;
+    int aliased_devfn;
 
     /* set_iommu_device requires device's direct BDF instead of aliased BDF */
-    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus,
+                                   &aliased_bus, &aliased_devfn);
     if (iommu_bus && iommu_bus->iommu_ops->set_iommu_device) {
+        hiod->aliased_bus = aliased_bus;
+        hiod->aliased_devfn = aliased_devfn;
         return iommu_bus->iommu_ops->set_iommu_device(pci_get_bus(dev),
                                                       iommu_bus->iommu_opaque,
                                                       dev->devfn, hiod, errp);
-- 
2.45.2


