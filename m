Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6308C36009
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVWp-0006yX-7K; Tue, 17 Sep 2024 06:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqVVp-00069F-IB
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqVVn-0006lc-Ol
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726569167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h1I319d7l3peW813h/MQKdOblm5RNBXb6q0NhABxO9g=;
 b=ZN0gy4Hjc303TQ0JL8c1nmzyaskKtDtWocJIs5nobPmcIS14GC5YXSOQZPfyMRntKt8rCF
 0nim6dE3N48TW5K9Al17Owo4K1SHjWsOSCpdVidBML5J53FaeBxlPNRQgvaGOliXIl/57V
 9LTdqzfmzvJ9oc5WxfpjBIXM9IykhBQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-QXtJmuonNFWRewJ6ikWFXg-1; Tue,
 17 Sep 2024 06:32:43 -0400
X-MC-Unique: QXtJmuonNFWRewJ6ikWFXg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5ABD1955D4A; Tue, 17 Sep 2024 10:32:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.154])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D76D19560AA; Tue, 17 Sep 2024 10:32:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PULL 4/8] vfio/igd: use new BDSM register location and size for gen
 11 and later
Date: Tue, 17 Sep 2024 12:32:25 +0200
Message-ID: <20240917103229.876515-5-clg@redhat.com>
In-Reply-To: <20240917103229.876515-1-clg@redhat.com>
References: <20240917103229.876515-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Corvin Köhne <corvin.koehne@gmail.com>

Intel changed the location and size of the BDSM register for gen 11
devices and later. We have to adjust our emulation for these devices to
properly support them.

Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/igd.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index d5e57656a8b7bb207b421977f9a2c76943d4a899..0b6533bbf7cc37c570f332636a292c26326cd870 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -100,11 +100,12 @@ static int igd_gen(VFIOPCIDevice *vdev)
 typedef struct VFIOIGDQuirk {
     struct VFIOPCIDevice *vdev;
     uint32_t index;
-    uint32_t bdsm;
+    uint64_t bdsm;
 } VFIOIGDQuirk;
 
 #define IGD_GMCH 0x50 /* Graphics Control Register */
 #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
+#define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
 
 
 /*
@@ -313,9 +314,13 @@ static void vfio_igd_quirk_data_write(void *opaque, hwaddr addr,
      */
     if ((igd->index % 4 == 1) && igd->index < vfio_igd_gtt_max(vdev)) {
         if (gen < 8 || (igd->index % 8 == 1)) {
-            uint32_t base;
+            uint64_t base;
 
-            base = pci_get_long(vdev->pdev.config + IGD_BDSM);
+            if (gen < 11) {
+                base = pci_get_long(vdev->pdev.config + IGD_BDSM);
+            } else {
+                base = pci_get_quad(vdev->pdev.config + IGD_BDSM_GEN11);
+            }
             if (!base) {
                 hw_error("vfio-igd: Guest attempted to program IGD GTT before "
                          "BIOS reserved stolen memory.  Unsupported BIOS?");
@@ -519,7 +524,13 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     igd = quirk->data = g_malloc0(sizeof(*igd));
     igd->vdev = vdev;
     igd->index = ~0;
-    igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM, 4);
+    if (gen < 11) {
+        igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM, 4);
+    } else {
+        igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM_GEN11, 4);
+        igd->bdsm |=
+            (uint64_t)vfio_pci_read_config(&vdev->pdev, IGD_BDSM_GEN11 + 4, 4) << 32;
+    }
     igd->bdsm &= ~((1 * MiB) - 1); /* 1MB aligned */
 
     memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_index_quirk,
@@ -577,9 +588,15 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
 
     /* BDSM is read-write, emulated.  The BIOS needs to be able to write it */
-    pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
-    pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
-    pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
+    if (gen < 11) {
+        pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
+        pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
+        pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
+    } else {
+        pci_set_quad(vdev->pdev.config + IGD_BDSM_GEN11, 0);
+        pci_set_quad(vdev->pdev.wmask + IGD_BDSM_GEN11, ~0);
+        pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
+    }
 
     /*
      * This IOBAR gives us access to GTTADR, which allows us to write to
-- 
2.46.0


