Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E9BE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6e2-0007Hf-OF; Tue, 24 Dec 2024 10:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dr-00076P-6E
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dp-00044c-Hg
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zqvdmj3PI63lrEa3bXwmqwjRLdujGQtTCqkk1uDJPR8=;
 b=QFwEYi/FKNVC8jcar+FzEPkH8BNbR4UQ+R/4fdevze7ozvR6iiz3ikHdlHtUhOA+YlYO2v
 FpCwwe+kf8rtposY8QIMXhcOAHCZJFF+VmYlrRPNwE2bvK+Lf0kgw+F8DsYVhaYukm/Lzs
 EnA/moLqJFY9TfL3kF+InnX6j1QuydQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-4GCbb9R7NVOW8COu9e7D8w-1; Tue,
 24 Dec 2024 10:16:08 -0500
X-MC-Unique: 4GCbb9R7NVOW8COu9e7D8w-1
X-Mimecast-MFC-AGG-ID: 4GCbb9R7NVOW8COu9e7D8w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55739195609F; Tue, 24 Dec 2024 15:16:07 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B51F3000197; Tue, 24 Dec 2024 15:16:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/17] vfio/igd: add macro for declaring mirrored registers
Date: Tue, 24 Dec 2024 16:15:37 +0100
Message-ID: <20241224151547.386529-8-clg@redhat.com>
In-Reply-To: <20241224151547.386529-1-clg@redhat.com>
References: <20241224151547.386529-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

igd devices have multipe registers mirroring mmio address and pci
config space, more than a single BDSM register. To support this,
the read/write functions are made common and a macro is defined to
simplify the declaration of MemoryRegionOps.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/r/20241206122749.9893-8-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 60 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 49b65477767308cab3ce1f4e5b3bd77b90f42831..18d159aa8ecde3bb384dd6d3bd90e2110434335b 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -421,16 +421,9 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-#define IGD_BDSM_MMIO_OFFSET 0x1080C0
-
-static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
-                                          hwaddr addr, unsigned size)
+static uint64_t vfio_igd_pci_config_read(VFIOPCIDevice *vdev, uint64_t offset,
+                                         unsigned size)
 {
-    VFIOPCIDevice *vdev = opaque;
-    uint64_t offset;
-
-    offset = IGD_BDSM_GEN11 + addr;
-
     switch (size) {
     case 1:
         return pci_get_byte(vdev->pdev.config + offset);
@@ -441,21 +434,17 @@ static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
     case 8:
         return pci_get_quad(vdev->pdev.config + offset);
     default:
-        hw_error("igd: unsupported read size, %u bytes", size);
+        hw_error("igd: unsupported pci config read at %lx, size %u",
+                 offset, size);
         break;
     }
 
     return 0;
 }
 
-static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
-                                       uint64_t data, unsigned size)
+static void vfio_igd_pci_config_write(VFIOPCIDevice *vdev, uint64_t offset,
+                                      uint64_t data, unsigned size)
 {
-    VFIOPCIDevice *vdev = opaque;
-    uint64_t offset;
-
-    offset = IGD_BDSM_GEN11 + addr;
-
     switch (size) {
     case 1:
         pci_set_byte(vdev->pdev.config + offset, data);
@@ -470,17 +459,39 @@ static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
         pci_set_quad(vdev->pdev.config + offset, data);
         break;
     default:
-        hw_error("igd: unsupported read size, %u bytes", size);
+        hw_error("igd: unsupported pci config write at %lx, size %u",
+                 offset, size);
         break;
     }
 }
 
-static const MemoryRegionOps vfio_igd_bdsm_quirk = {
-    .read = vfio_igd_quirk_bdsm_read,
-    .write = vfio_igd_quirk_bdsm_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+#define VFIO_IGD_QUIRK_MIRROR_REG(reg, name)                            \
+static uint64_t vfio_igd_quirk_read_##name(void *opaque,                \
+                                           hwaddr addr, unsigned size)  \
+{                                                                       \
+    VFIOPCIDevice *vdev = opaque;                                       \
+                                                                        \
+    return vfio_igd_pci_config_read(vdev, reg + addr, size);            \
+}                                                                       \
+                                                                        \
+static void vfio_igd_quirk_write_##name(void *opaque, hwaddr addr,      \
+                                        uint64_t data, unsigned size)   \
+{                                                                       \
+    VFIOPCIDevice *vdev = opaque;                                       \
+                                                                        \
+    vfio_igd_pci_config_write(vdev, reg + addr, data, size);            \
+}                                                                       \
+                                                                        \
+static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
+    .read = vfio_igd_quirk_read_##name,                                 \
+    .write = vfio_igd_quirk_write_##name,                               \
+    .endianness = DEVICE_LITTLE_ENDIAN,                                 \
 };
 
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
+
+#define IGD_BDSM_MMIO_OFFSET    0x1080C0
+
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 {
     VFIOQuirk *quirk;
@@ -510,8 +521,9 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     quirk = vfio_quirk_alloc(1);
     quirk->data = vdev;
 
-    memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_bdsm_quirk,
-                          vdev, "vfio-igd-bdsm-quirk", 8);
+    memory_region_init_io(&quirk->mem[0], OBJECT(vdev),
+                          &vfio_igd_quirk_mirror_bdsm, vdev,
+                          "vfio-igd-bdsm-quirk", 8);
     memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
                                         IGD_BDSM_MMIO_OFFSET, &quirk->mem[0],
                                         1);
-- 
2.47.1


