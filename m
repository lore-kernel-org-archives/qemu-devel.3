Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8A6C021A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 14:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrKv-0006UI-H8; Tue, 11 Feb 2025 09:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrKs-0006TY-H6
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:34:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrKq-0001tJ-G0
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739284439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lo7r4SYY6eTQaIELD3Ok5zA0WWqcDmUhUeH6haaBJ+U=;
 b=LsDq3sHyh9Rdsv93aJp2iXhyeyqAKfdRHkScTjtVpcZ7k1OUT/YUdmEraBLv2vqthEMZcz
 aIPwdi+1I9JGqSIzQumNmZjkat+6sSZ67PIUiPbxZl+sct6phnWzd2T2obX3l5/DkVjIH3
 GbyZuoV/4ekv4VbU6VvtrrOqopcDYtI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-_q6YYjfONwKvkFjzYA-07g-1; Tue,
 11 Feb 2025 09:33:55 -0500
X-MC-Unique: _q6YYjfONwKvkFjzYA-07g-1
X-Mimecast-MFC-AGG-ID: _q6YYjfONwKvkFjzYA-07g
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9013919560AA; Tue, 11 Feb 2025 14:33:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E61701800873; Tue, 11 Feb 2025 14:33:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/12] vfio/pci: introduce config_offset field in
 VFIOConfigMirrorQuirk
Date: Tue, 11 Feb 2025 15:33:31 +0100
Message-ID: <20250211143340.787996-4-clg@redhat.com>
In-Reply-To: <20250211143340.787996-1-clg@redhat.com>
References: <20250211143340.787996-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

From: Tomita Moeko <tomitamoeko@gmail.com>

Device may only expose a specific portion of PCI config space through a
region in a BAR, such behavior is seen in igd GGC and BDSM mirrors in
BAR0. To handle these, config_offset is introduced to allow mirroring
arbitrary region in PCI config space.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/r/20250104154219.7209-3-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci-quirks.h | 3 ++-
 hw/vfio/pci-quirks.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci-quirks.h b/hw/vfio/pci-quirks.h
index c0e96a01cc64bd82013d6bd87adb7ce3d31bf060..d1532e379b14c56950c562b84af7edb2b4748321 100644
--- a/hw/vfio/pci-quirks.h
+++ b/hw/vfio/pci-quirks.h
@@ -60,7 +60,8 @@ extern const MemoryRegionOps vfio_generic_window_data_quirk;
  */
 typedef struct VFIOConfigMirrorQuirk {
     struct VFIOPCIDevice *vdev;
-    uint32_t offset;
+    uint32_t offset; /* Offset in BAR */
+    uint32_t config_offset; /* Offset in PCI config space */
     uint8_t bar;
     MemoryRegion *mem;
     uint8_t data[];
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 2258fdda5f1fd4ae4f57fd163beb24bfe2116717..fbe43b0a7903ecc75de54f575076d6ddb24fd6ed 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -162,6 +162,7 @@ static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
     (void)vfio_region_read(&vdev->bars[mirror->bar].region,
                            addr + mirror->offset, size);
 
+    addr += mirror->config_offset;
     data = vfio_pci_read_config(&vdev->pdev, addr, size);
     trace_vfio_quirk_generic_mirror_read(vdev->vbasedev.name,
                                          memory_region_name(mirror->mem),
@@ -175,6 +176,7 @@ static void vfio_generic_quirk_mirror_write(void *opaque, hwaddr addr,
     VFIOConfigMirrorQuirk *mirror = opaque;
     VFIOPCIDevice *vdev = mirror->vdev;
 
+    addr += mirror->config_offset;
     vfio_pci_write_config(&vdev->pdev, addr, data, size);
     trace_vfio_quirk_generic_mirror_write(vdev->vbasedev.name,
                                           memory_region_name(mirror->mem),
-- 
2.48.1


