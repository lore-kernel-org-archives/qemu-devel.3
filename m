Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A447C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3dX-00067s-Sk; Fri, 14 Jun 2024 05:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI3dW-00066q-9y
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:54:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI3dU-0003Rw-5x
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718358859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xSMsGWiIDaWBh/1sOWutFdLDNKll+hfjQCTOA1Gx6t4=;
 b=IY6WmjNehM+SxSjsVUe/ZgvtOcsP1qiG4B7I5LD7a8RfVbyPTY7L48UCbcAh1tKmmAz5xF
 +Ye1T2VD0kh0tGv5QxlsB1KUFB3cpLG86buPuGVLWYEXNtMm0HIJS+LG0nylP7mYnzlwa/
 qz1S4gFc5CA2d5YiqHvqnev8YtM1A4U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-daRnIyRIP6WC9EAvuZ0VOA-1; Fri,
 14 Jun 2024 05:54:15 -0400
X-MC-Unique: daRnIyRIP6WC9EAvuZ0VOA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B308819560B2; Fri, 14 Jun 2024 09:54:13 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36C593000219; Fri, 14 Jun 2024 09:54:07 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [PATCH v4 0/8] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling
 for hotplugged devices
Date: Fri, 14 Jun 2024 11:52:50 +0200
Message-ID: <20240614095402.904691-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This series is based on Zhenzhong HostIOMMUDevice: 

[PATCH v7 00/17] Add a host IOMMU device abstraction to check with vIOMMU
https://lore.kernel.org/all/20240605083043.317831-1-zhenzhong.duan@intel.com/

It allows to convey host IOVA reserved regions to the virtio-iommu and
uses the HostIOMMUDevice infrastructure. This replaces the usage of
IOMMU MR ops which fail to satisfy this need for hotplugged devices.

See below for additional background.

In [1] we attempted to fix a case where a VFIO-PCI device protected
with a virtio-iommu was assigned to an x86 guest. On x86 the physical
IOMMU may have an address width (gaw) of 39 or 48 bits whereas the
virtio-iommu used to expose a 64b address space by default.
Hence the guest was trying to use the full 64b space and we hit
DMA MAP failures. To work around this issue we managed to pass
usable IOVA regions (excluding the out of range space) from VFIO
to the virtio-iommu device. This was made feasible by introducing
a new IOMMU Memory Region callback dubbed iommu_set_iova_regions().
This latter gets called when the IOMMU MR is enabled which
causes the vfio_listener_region_add() to be called.

For coldplugged devices the technique works because we make sure all
the IOMMU MR are enabled once on the machine init done: 94df5b2180
("virtio-iommu: Fix 64kB host page size VFIO device assignment")
for granule freeze. But I would be keen to get rid of this trick.

However with VFIO-PCI hotplug, this technique fails due to the
race between the call to the callback in the add memory listener
and the virtio-iommu probe request. Indeed the probe request gets
called before the attach to the domain. So in that case the usable
regions are communicated after the probe request and fail to be
conveyed to the guest.

Using an IOMMU MR Ops is unpractical because this relies on the IOMMU
MR to have been enabled and the corresponding vfio_listener_region_add()
to be executed. Instead this series proposes to replace the usage of this
API by the recently introduced PCIIOMMUOps: ba7d12eb8c  ("hw/pci: modify
pci_setup_iommu() to set PCIIOMMUOps"). That way, the callback can be
called earlier, once the usable IOVA regions have been collected by
VFIO, without the need for the IOMMU MR to be enabled.

This series also removes the spurious message:
qemu-system-aarch64: warning: virtio-iommu-memory-region-7-0: Notified about new host reserved regions after probe

In the short term this may also be used for passing the page size
mask, which would allow to get rid of the hacky transient IOMMU
MR enablement mentionned above.

[1] [PATCH v4 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
    https://lore.kernel.org/all/20231019134651.842175-1-eric.auger@redhat.com/

Extra Notes:
With that series, the reserved memory regions are communicated on time
so that the virtio-iommu probe request grabs them. However this is not
sufficient. In some cases (my case), I still see some DMA MAP failures
and the guest keeps on using IOVA ranges outside the geometry of the
physical IOMMU. This is due to the fact the VFIO-PCI device is in the
same iommu group as the pcie root port. Normally the kernel
iova_reserve_iommu_regions (dma-iommu.c) is supposed to call reserve_iova()
for each reserved IOVA, which carves them out of the allocator. When
iommu_dma_init_domain() gets called for the hotplugged vfio-pci device
the iova domain is already allocated and set and we don't call
iova_reserve_iommu_regions() again for the vfio-pci device. So its
corresponding reserved regions are not properly taken into account.

This is not trivial to fix because theoretically the 1st attached
devices could already have allocated IOVAs within the reserved regions
of the second device. Also we are somehow hijacking the reserved
memory regions to model the geometry of the physical IOMMU so not sure
any attempt to fix that upstream will be accepted. At the moment one
solution is to make sure assigned devices end up in singleton group.
Another solution is to work on a different approach where the gaw
can be passed as an option to the virtio-iommu device, similarly at
what is done with intel iommu.

This series can be found at:
https://github.com/eauger/qemu/tree/iommufd_nesting_preq_v7_resv_regions_v4

History:
v3 -> v4:
- add one patch to add aliased pci bus and devfn in the HostIOMMUDevice
- Use those for resv regions computation
- Remove VirtioHostIOMMUDevice and simply use the base object

v2 -> v3:
- moved the series from RFC to patch
- collected Zhenzhong's R-bs and took into account most of his comments
  (see replies on v2)


Eric Auger (8):
  HostIOMMUDevice: Store the VFIO/VDPA agent
  virtio-iommu: Implement set|unset]_iommu_device() callbacks
  HostIOMMUDevice: Introduce get_iova_ranges callback
  HostIOMMUDevice: Store the aliased bus and devfn
  virtio-iommu: Compute host reserved regions
  virtio-iommu: Remove the implementation of iommu_set_iova_range
  hw/vfio: Remove memory_region_iommu_set_iova_ranges() call
  memory: Remove IOMMU MR iommu_set_iova_range API

 include/exec/memory.h              |  32 ----
 include/hw/virtio/virtio-iommu.h   |   2 +
 include/sysemu/host_iommu_device.h |  11 ++
 hw/pci/pci.c                       |   8 +-
 hw/vfio/common.c                   |  10 -
 hw/vfio/container.c                |  17 ++
 hw/vfio/iommufd.c                  |  18 ++
 hw/virtio/virtio-iommu.c           | 296 +++++++++++++++++++----------
 system/memory.c                    |  13 --
 9 files changed, 249 insertions(+), 158 deletions(-)

-- 
2.41.0


