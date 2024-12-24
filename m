Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715B6E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6dw-00078x-An; Tue, 24 Dec 2024 10:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dq-00075z-Lx
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dp-00044T-4G
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8TbpuTXj3ymVz1dIlCfBgLXx/Ehp/E/rCS9FSGIZm7M=;
 b=ThvYnpvDYS+YQpOakFx0u28INliOcg992Jugi+1eV553zRNa6RoKL036yCApLM8OVL7c0B
 Y66eFELqgBiGnaivVd7PXEhLY09U4XupjwMCDxPu6lKIpxkDUoeg09mPh9VTPmck+hbKQP
 2HT9sXLr8crHddIg5kFz/fweO5MAK4I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-XpFnzunmMcOJpT6Tf1N8Cg-1; Tue,
 24 Dec 2024 10:16:09 -0500
X-MC-Unique: XpFnzunmMcOJpT6Tf1N8Cg-1
X-Mimecast-MFC-AGG-ID: XpFnzunmMcOJpT6Tf1N8Cg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 006EA1956096; Tue, 24 Dec 2024 15:16:09 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 683FD3000197; Tue, 24 Dec 2024 15:16:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/17] vfio/igd: emulate GGC register in mmio bar0
Date: Tue, 24 Dec 2024 16:15:38 +0100
Message-ID: <20241224151547.386529-9-clg@redhat.com>
In-Reply-To: <20241224151547.386529-1-clg@redhat.com>
References: <20241224151547.386529-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Tomita Moeko <tomitamoeko@gmail.com>

The GGC register at 0x50 of pci config space is a mirror of the same
register at 0x108040 of mmio bar0 [1]. i915 driver also reads that
register from mmio bar0 instead of config space. As GGC is programmed
and emulated by qemu, the mmio address should also be emulated, in the
same way of BDSM register.

[1] 4.1.28, 12th Generation Intel Core Processors Datasheet Volume 2
    https://www.intel.com/content/www/us/en/content-details/655259

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/r/20241206122749.9893-9-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 18d159aa8ecde3bb384dd6d3bd90e2110434335b..12e0553e830aab31980586ebf572070186ac38ad 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -488,8 +488,10 @@ static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
     .endianness = DEVICE_LITTLE_ENDIAN,                                 \
 };
 
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_GMCH, ggc)
 VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
 
+#define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
 
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
@@ -518,14 +520,21 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    quirk = vfio_quirk_alloc(1);
+    quirk = vfio_quirk_alloc(2);
     quirk->data = vdev;
 
     memory_region_init_io(&quirk->mem[0], OBJECT(vdev),
+                          &vfio_igd_quirk_mirror_ggc, vdev,
+                          "vfio-igd-ggc-quirk", 2);
+    memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
+                                        IGD_GGC_MMIO_OFFSET, &quirk->mem[0],
+                                        1);
+
+    memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
                           &vfio_igd_quirk_mirror_bdsm, vdev,
                           "vfio-igd-bdsm-quirk", 8);
     memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
-                                        IGD_BDSM_MMIO_OFFSET, &quirk->mem[0],
+                                        IGD_BDSM_MMIO_OFFSET, &quirk->mem[1],
                                         1);
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
-- 
2.47.1


