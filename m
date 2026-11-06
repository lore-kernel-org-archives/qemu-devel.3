Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C29606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aKJsno1s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPLIN-0002wH-1W; Fri, 06 Nov 2026 09:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xPLIL-0002vy-9n
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:51:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xPLIJ-0002Di-Hd
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793976714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vznTLmH13jSN6b9wnsxqDutjisldxefqee0nkmHh/pg=;
 b=aKJsno1snXEEyey/ZBMKLJuB0U6CjtLMy2mXFq/oL8RetrY7YEXemiSeeUsPsui/uA4uS+
 CrWBseDd7c5rnwxaLpxXa3999TelHr7QPpkNhfz/F8oFU9LP7Wh0v2E46qN9m/cLJHP3LN
 RIFcQrOfiVGEUGO/z5lMeMUw4dAeH5A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-VscfiL02Mk6sRKqVoZywoQ-1; Fri,
 06 Nov 2026 09:51:51 -0500
X-MC-Unique: VscfiL02Mk6sRKqVoZywoQ-1
X-Mimecast-MFC-AGG-ID: VscfiL02Mk6sRKqVoZywoQ_1793976710
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86C321955F08; Fri,  6 Nov 2026 14:51:49 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.31])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3D321956087; Fri,  6 Nov 2026 14:51:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
Subject: [PATCH] vfio/region: Skip IOMMU mapping for BARs when dma-buf is
 unavailable
Date: Fri,  6 Nov 2026 15:51:44 +0100
Message-ID: <20261106145144.1352917-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the kernel does not support the VFIO_DEVICE_FEATURE_DMA_BUF
feature (e.g. old kernel or out-of-tree vGPU driver),
vfio_region_create_dma_buf() returns with a warning and no fd is
assigned to the BAR RAMBlocks. Later, when the VFIO listener tries
to DMA-map these BAR regions, the iommufd backend falls back to
IOMMU_IOAS_MAP with a vaddr pointing at device MMIO. The kernel cannot
pin device memory and fails with EFAULT on aarch64, producing these
warnings:

  qemu-kvm: warning: VFIO dma-buf not supported in kernel, using mmap fallback, P2P DMA will not work
  qemu-kvm: warning: IOMMU_IOAS_MAP failed: Bad address, PCI BAR?
  qemu-kvm: warning: vfio_container_dma_map(0xaaabb9621a90, 0x88400000000, 0x10000, 0xfffe50100000) = -14 (Bad address)
  hostdev0: PCI peer-to-peer transactions on BARs are not supported.

memory_region_set_skip_iommu_map() was recently introduced by commit
11b9798c7b52 ("memory: Allow RAM device regions to skip IOMMU
mapping") for the Tegra CMDQV case. Use it to mark BAR mmap regions
when dma-buf is unavailable so the VFIO listener skips them. This
drops the last three messages and covers both the iommufd and legacy
Type1 IOMMU backends.

Cc: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>
Fixes: 8cfaf22668c7 ("hw/vfio/region: Create dmabuf for PCI BAR per region")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/region.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 996bc523edfe10bd256f5b09dec45cb5c9f543f0..4148d0ea8e35496e4c5a2bf97d1ef6974df7ccbb 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -362,6 +362,9 @@ static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
         if (ret == -ENOTTY) {
             warn_report_once("VFIO dma-buf not supported in kernel, "
                              "using mmap fallback, P2P DMA will not work");
+            for (i = 0; i < region->nr_mmaps; i++) {
+                memory_region_set_skip_iommu_map(&region->mmaps[i].mem, true);
+            }
             return true;
         }
         error_setg_errno(errp, -ret, "%s: dma-buf unavailable, "
-- 
2.56.0


