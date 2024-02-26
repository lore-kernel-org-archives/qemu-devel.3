Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA19EC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 18:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1refUk-0005FB-HQ; Mon, 26 Feb 2024 13:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1refUi-0005Ei-RM
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:14:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1refUO-00058Q-2o
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708971246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=i1dWddzH/YQyj6E4Obik038GydQPV4mPULLWQS4+yjQ=;
 b=bcCQvjSAVdxsrYj6/ezizpLir4P37Zm2WYoHmLP5cI/D4lBHNmGbCW5OWC0xy4jlAdUYaq
 REpW235xV/xBCMnb0z1e9fpqlFlrjx3ElAi7jOawJ5ei01oPqLwxm1YZeHUrgGdiDR2YHJ
 Kmyw5Dz8ZZXxPLpyq0Q7zwF2hKlWB5o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-xqYRYeOyOV-qz5T_QpNJfQ-1; Mon,
 26 Feb 2024 13:14:02 -0500
X-MC-Unique: xqYRYeOyOV-qz5T_QpNJfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F5443804502;
 Mon, 26 Feb 2024 18:14:01 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 49AEF40C1064;
 Mon, 26 Feb 2024 18:13:57 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com
Cc: alex.williamson@redhat.com, zhenzhong.duan@intel.com, jasowang@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com
Subject: [PATCH v5 0/3] VIRTIO-IOMMU: Set default granule to host page size
Date: Mon, 26 Feb 2024 19:11:09 +0100
Message-ID: <20240226181337.24148-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We used to set the default granule to 4kB but with VFIO assignment
it makes more sense to use the actual host page size.

Indeed when hotplugging a VFIO device protected by a virtio-iommu
on a 64kB/64kB host/guest config, we currently get a qemu crash:
    
"vfio: DMA mapping failed, unable to continue"

This is due to the hot-attached VFIO device calling
memory_region_iommu_set_page_size_mask() with 64kB granule
whereas the virtio-iommu granule was already frozen to 4kB on
machine init done.

Introduce a new granule property, set this latter to "host"
and introduce a new compat (that sets it to 4k for machine
types older than 9.0).

Note that the new default will prevent 4kB guest on 64kB host
because the granule will be set to 64kB which would be larger
than the guest page size. In that situation, the virtio-iommu
driver fails on viommu_domain_finalise() with
"granule 0x10000 larger than system page size 0x1000".

In that case 4K granule should be used.

To summarize, before the series, the support matrix (credit
to Jean-Philippe Brucker) was:

 Host | Guest | virtio-net | IGB passthrough
  4k  | 4k    | Y          | Y
  64k | 64k   | Y          | N
  64k | 4k    | Y          | N
  4k  | 64k   | Y          | Y

After the series:

 Host | Guest | virtio-net | IGB passthrough
  4k  | 4k    | Y          | Y
  64k | 64k   | Y          | Y
  64k | 4k    | 4K         | N
  4k  | 64k   | Y          | Y

The current limitation of global granule in the virtio-iommu
should be removed and turned into per domain granule. But
until we get this upgraded, this new default is probably
better because I don't think anyone is currently interested in
running a 4KB page size guest with virtio-iommu on a 64KB host.
However supporting 64kB guest on 64kB host with virtio-iommu and
VFIO looks a more important feature.

This series can be found at:
https://github.com/eauger/qemu/tree/granule-v3

Applied on top of
[PATCH v5 0/4] VIRTIO-IOMMU: Introduce an aw-bits option
https://lore.kernel.org/all/20240215084315.863897-1-eric.auger@redhat.com/

History:
v4 -> v5:
- use -(n * KiB) (Philippe)
- remove code that can be automatically generated
  and add the new enum in qapi/virtio.json (Philippe).
- Improve commit msg on last patch and collected Philippe's R-b

v3 -> v4:
- Add 8K granule (Richard)

v2 -> v3
- introduce a dedicated granule option to handle the compat

Eric Auger (3):
  qdev: Add a granule_mode property
  virtio-iommu: Add a granule property
  virtio-iommu: Change the default granule to the host page size

 qapi/virtio.json                    | 18 ++++++++++++++++++
 include/hw/qdev-properties-system.h |  3 +++
 include/hw/virtio/virtio-iommu.h    |  2 ++
 hw/core/machine.c                   |  1 +
 hw/core/qdev-properties-system.c    | 15 +++++++++++++++
 hw/virtio/virtio-iommu.c            | 28 +++++++++++++++++++++++++---
 qemu-options.hx                     |  3 +++
 7 files changed, 67 insertions(+), 3 deletions(-)

-- 
2.41.0


