Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0764FC47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 18:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSLLj-00078c-2p; Tue, 23 Jan 2024 13:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rSLLa-0006y3-Dt
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:18:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rSLLX-00063I-GZ
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706033882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nUqVILcn7AB2FN5KpSvA8iJREURVQcQkUzfoeXjf0Bo=;
 b=iRVu2eF7qRFwsuVOLwIr1MWqshZa4C3GO4xlbiZP/2JwyqR8Mcg9xQV8cOkVZuxB/ZydnO
 3xmNOUuDPI23hldHXYxemvy6u5HRC+sEgtYHXqWQJfn3/5pS36+2bZZ5jSmVtQp4KxuTgi
 0XY7uMwBh0HYymPtIn7wqyaQOmUu+OQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-cpCXdbAaNZulB51rsLWajA-1; Tue, 23 Jan 2024 13:17:59 -0500
X-MC-Unique: cpCXdbAaNZulB51rsLWajA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB95E85A589;
 Tue, 23 Jan 2024 18:17:58 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 369EA2166B32;
 Tue, 23 Jan 2024 18:17:56 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, alex.williamson@redhat.com,
 peter.maydell@linaro.org, zhenzhong.duan@intel.com, peterx@redhat.com,
 yanghliu@redhat.com
Cc: mst@redhat.com,
	clg@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 0/3] VIRTIO-IOMMU: Introduce an aw-bits option
Date: Tue, 23 Jan 2024 19:15:54 +0100
Message-ID: <20240123181753.413961-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In [1] and [2] we attempted to fix a case where a VFIO-PCI device
protected with a virtio-iommu is assigned to an x86 guest. On x86
the physical IOMMU may have an address width (gaw) of 39 or 48 bits
whereas the virtio-iommu exposes a 64b input address space by default.
Hence the guest may try to use the full 64b space and DMA MAP
failures may be encountered. To work around this issue we endeavoured
to pass usable host IOVA regions (excluding the out of range space) from
VFIO to the virtio-iommu device so that the virtio-iommu driver can
query those latter during the probe request and let the guest iommu
kernel subsystem carve them out.

However if there are several devices in the same iommu group,
only the reserved regions of the first one are taken into
account by the iommu subsystem of the guest. This generally
works on baremetal because devices are not going to
expose different reserved regions. However in our case, this
may prevent from taking into account the host iommu geometry.

So the simplest solution to this problem looks to introduce an
input address width option, aw-bits, which matches what is
done on the intel-iommu. By default, from now on it is set
to 39 bits with pc_q35 and 64b with arm virt. This replaces the
previous default value of 64b. So we need to introduce a compat
for pc_q35 machines older than 9.0 to behave similarly.

Outstanding series [2] remains useful to let resv regions beeing
communicated on time before the probe request.

[1] [PATCH v4 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
    https://lore.kernel.org/all/20231019134651.842175-1-eric.auger@redhat.com/
    - This is merged -

[2] [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for hotplugged devices
    https://lore.kernel.org/all/20240117080414.316890-1-eric.auger@redhat.com/
    - This is pending for review on the ML -

This series can be found at:
https://github.com/eauger/qemu/tree/virtio-iommu-aw-bits-v1

Applied on top of [3]
[PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default page_size_mask
https://lore.kernel.org/all/20240117132039.332273-1-eric.auger@redhat.com/

Eric Auger (3):
  virtio-iommu: Add an option to define the input range width
  virtio-iommu: Trace domain range limits as unsigned int
  hw/pc: Set the default virtio-iommu aw-bits to 39 on pc_q35_9.0
    onwards

 include/hw/virtio/virtio-iommu.h |  1 +
 hw/arm/virt.c                    |  6 ++++++
 hw/i386/pc.c                     | 10 +++++++++-
 hw/virtio/virtio-iommu.c         |  4 +++-
 hw/virtio/trace-events           |  2 +-
 5 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.41.0


