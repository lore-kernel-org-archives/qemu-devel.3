Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBEAE7718E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6e6-0007cA-De; Tue, 24 Dec 2024 10:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6dv-0007CV-Au
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6ds-00044v-CI
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bk4u7HAtBWIrwwdMO6YCY2RA9uiddWkPGXGAxXMR4WI=;
 b=QO/N77hUK3uzF/86bNjqcKZqAVKXFzRxr221RuWrS1oIOe7K7oC+KSUW3PWVS+UoNeufvZ
 6yq0M8FbMqrX2Lpbn0yCBvxXa8KwyJzls3m6VJvnrgiGTqiiu8+Jjz9tHi/MRHTjFfHoXR
 yLTETGJDef38aqbsysRGtphxHfTxdnc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-wkuIVRxSNCOlkTelF6wRig-1; Tue,
 24 Dec 2024 10:16:12 -0500
X-MC-Unique: wkuIVRxSNCOlkTelF6wRig-1
X-Mimecast-MFC-AGG-ID: wkuIVRxSNCOlkTelF6wRig
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ACCE1956058; Tue, 24 Dec 2024 15:16:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 841483000197; Tue, 24 Dec 2024 15:16:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/17] vfio/igd: emulate BDSM in mmio bar0 for gen 6-10 devices
Date: Tue, 24 Dec 2024 16:15:39 +0100
Message-ID: <20241224151547.386529-10-clg@redhat.com>
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

A recent commit in i915 driver [1] claims the BDSM register at 0x1080c0
of mmio bar0 has been there since gen 6. Mirror this register to the 32
bit BDSM register at 0x5c in pci config space for gen6-10 devices.

[1] https://patchwork.freedesktop.org/patch/msgid/20240202224340.30647-7-ville.syrjala@linux.intel.com

Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/r/20241206122749.9893-10-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 12e0553e830aab31980586ebf572070186ac38ad..73c06bbf64d85b8dbf1575dac34ef8b7e64a3490 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -489,7 +489,8 @@ static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
 };
 
 VFIO_IGD_QUIRK_MIRROR_REG(IGD_GMCH, ggc)
-VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM, bdsm)
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm64)
 
 #define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
@@ -516,7 +517,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
      * into MMIO space and read from MMIO space by the Windows driver.
      */
     gen = igd_gen(vdev);
-    if (gen < 11) {
+    if (gen < 6) {
         return;
     }
 
@@ -530,12 +531,21 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
                                         IGD_GGC_MMIO_OFFSET, &quirk->mem[0],
                                         1);
 
-    memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
-                          &vfio_igd_quirk_mirror_bdsm, vdev,
-                          "vfio-igd-bdsm-quirk", 8);
-    memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
-                                        IGD_BDSM_MMIO_OFFSET, &quirk->mem[1],
-                                        1);
+    if (gen < 11) {
+        memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
+                              &vfio_igd_quirk_mirror_bdsm, vdev,
+                              "vfio-igd-bdsm-quirk", 4);
+        memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
+                                            IGD_BDSM_MMIO_OFFSET,
+                                            &quirk->mem[1], 1);
+    } else {
+        memory_region_init_io(&quirk->mem[1], OBJECT(vdev),
+                              &vfio_igd_quirk_mirror_bdsm64, vdev,
+                              "vfio-igd-bdsm-quirk", 8);
+        memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
+                                            IGD_BDSM_MMIO_OFFSET,
+                                            &quirk->mem[1], 1);
+    }
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 }
-- 
2.47.1


