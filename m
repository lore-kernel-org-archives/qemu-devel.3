Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A00FC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 22:33:16 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFakW-0004qr-Fx; Fri, 07 Jun 2024 10:39:24 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sFakV-0004qH-0r
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sFakT-0003Lp-4Q
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717771159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BxTfKVR6XiuvvnFaFWRHfE68N8B9f79BM09c2XvFbLo=;
 b=UW/vA9IRGCn73gfRMSGeAROEqcmz/Ydl+Hi1Kpzybabg8qhqwlVQBkR10Dawp+u45se/7i
 0JpxhBTbClSEdfbiuq6gE8KTlMoTt0pMcRN49tDiQOvokrscxizHo+ID1tiA6AwWkEYYgd
 TId8m6I9YqyoVBxqM9WmVC3ik6IAwHA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-vb_rDz9xM7SRphVBHwRJIg-1; Fri,
 07 Jun 2024 10:39:17 -0400
X-MC-Unique: vb_rDz9xM7SRphVBHwRJIg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1403F1956095; Fri,  7 Jun 2024 14:39:16 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BD9D1956051; Fri,  7 Jun 2024 14:39:09 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 imammedo@redhat.com, peter.maydell@linaro.org, clg@redhat.com,
 yanghliu@redhat.com, zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [RFC v2 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for
 hotplugged devices
Date: Fri,  7 Jun 2024 16:37:20 +0200
Message-ID: <20240607143905.765133-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

However with VFIO-PCI hotplug, this technique fails due to the
race between the call to the callback in the add memory listener
and the virtio-iommu probe request. Indeed the probe request gets
called before the attach to the domain. So in that case the usable
regions are communicated after the probe request and fail to be
conveyed to the guest. To be honest the problem was hinted by
Jean-Philippe in [1] and I should have been more careful at
listening to him and testing with hotplug :-(

Eventually in 9.0 we introduced an aw-bits option which gives
extra flexibility.

For coldplugged device the technique works because we make sure all
the IOMMU MR are enabled once on the machine init done: 94df5b2180
("virtio-iommu: Fix 64kB host page size VFIO device assignment")
for granule freeze. But I would be keen to get rid of this trick.

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

[2] https://lore.kernel.org/all/20230929161547.GB2957297@myrica/

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
https://github.com/eauger/qemu/tree/iommufd_nesting_preq_v7_resv_regions_v2


Eric Auger (7):
  HostIOMMUDevice: Store the VFIO/VDPA agent
  virtio-iommu: Implement set|unset]_iommu_device() callbacks
  HostIOMMUDevice: Introduce get_iova_ranges callback
  virtio-iommu: Compute host reserved regions
  virtio-iommu: Remove the implementation of iommu_set_iova_range
  hw/vfio: Remove memory_region_iommu_set_iova_ranges() call
  memory: Remove IOMMU MR iommu_set_iova_range API

 include/exec/memory.h              |  32 ---
 include/hw/virtio/virtio-iommu.h   |   9 +
 include/sysemu/host_iommu_device.h |   9 +
 hw/vfio/common.c                   |  10 -
 hw/vfio/container.c                |  15 ++
 hw/vfio/iommufd.c                  |  16 ++
 hw/virtio/virtio-iommu.c           | 305 +++++++++++++++++++----------
 system/memory.c                    |  13 --
 8 files changed, 253 insertions(+), 156 deletions(-)

-- 
2.41.0


