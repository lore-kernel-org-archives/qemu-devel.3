Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69623CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKSY-000304-8B; Thu, 15 Oct 2026 08:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKSV-0002xP-Em
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKST-0005Ja-1b
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mv2xuRM7yQNOA3AOJqXsmilOmSaKGP93T3T04IWMT9Q=;
 b=Q+Bq9UD8I1SUZMD3qSTFX9atoglpSojz5sy47+/ZTVZHSRmcaXhiog+vucpxZq+AwDUuA7
 MjlfteAjQy0CPl7d9WOGIT/Rxbzz5P+sVvLoKgywQRGpdB3IiTzIGyUJeKcL51W3tiX3Nd
 OwdJN+P83W1Ba9UrJ1G1+jAVOUgicIo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-28l3Ss-xN-qfXpzgmkmjNA-1; Thu,
 15 Oct 2026 12:21:11 +0000
X-MC-Unique: 28l3Ss-xN-qfXpzgmkmjNA-1
X-Mimecast-MFC-AGG-ID: 28l3Ss-xN-qfXpzgmkmjNA_1792066870
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 673AF1955F70; Thu, 15 Oct 2026 12:21:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7697818004D2; Thu, 15 Oct 2026 12:21:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yuan Wang <yuan1.wang@intel.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Bosheng Xue <bosheng.xue@intel.com>, Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 6/8] vfio/igd: Make MTL/ARL guests fall back to BAR-based
 framebuffer access
Date: Thu, 15 Oct 2026 14:20:53 +0200
Message-ID: <20261015122055.888209-7-clg@redhat.com>
In-Reply-To: <20261015122055.888209-1-clg@redhat.com>
References: <20261015122055.888209-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yuan Wang <yuan1.wang@intel.com>

Meteor Lake and Arrow Lake GOP can read BAR0 MMIO offset 0x138914 to
detect whether direct framebuffer access via DSM is available.

In a VFIO passthrough VM, the guest cannot access the host DSM memory
region via such a pointer. If the guest GOP enables that path, it may
hand off a DSM-based framebuffer address that the guest cannot actually
use.

Intercept reads from the detection register and return 0 so the guest
does not enable the DSM-based path and instead keeps using the standard
BAR-based framebuffer address.

Suggested-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Bosheng Xue <bosheng.xue@intel.com>
Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
Link: https://lore.kernel.org/qemu-devel/20260923052511.2842596-1-yuan1.wang@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 5e6160763cefb9d9739dd0a6462137c49109e81a..4c7d6545924ca49cbe0285f77b422517b1c59159 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -96,6 +96,8 @@ static int igd_gen(VFIOPCIDevice *vdev)
     case 0x4C00:    /* Rocket Lake */
     case 0x4600:    /* Alder Lake */
     case 0xA700:    /* Raptor Lake */
+    case 0x7D00:    /* Meteor Lake / Arrow Lake */
+    case 0xB600:    /* Arrow Lake */
         return 12;
     }
 
@@ -452,8 +454,30 @@ static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
     return ret;
 }
 
-#define IGD_GGC_MMIO_OFFSET     0x108040
-#define IGD_BDSM_MMIO_OFFSET    0x1080C0
+#define IGD_GGC_MMIO_OFFSET         0x108040
+#define IGD_BDSM_MMIO_OFFSET        0x1080C0
+#define IGD_MTL_PCODE_STOLEN_ACCESS 0x138914
+
+#define IGD_IS_MTL_OR_ARL(vdev) \
+    ((((vdev)->device_id & 0xff00) == 0x7d00) || \
+     (((vdev)->device_id & 0xff00) == 0xb600))
+
+static uint64_t vfio_igd_pcode_stolen_access_read(void *opaque, hwaddr addr,
+                                                  unsigned size)
+{
+    return 0;
+}
+
+static void vfio_igd_pcode_stolen_access_write(void *opaque, hwaddr addr,
+                                               uint64_t data, unsigned size)
+{
+}
+
+static const MemoryRegionOps vfio_igd_pcode_stolen_access_quirk = {
+    .read = vfio_igd_pcode_stolen_access_read,
+    .write = vfio_igd_pcode_stolen_access_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
 
 /*
  * IGD BAR0 DBUF_CTL sanitize quirk.
@@ -547,7 +571,7 @@ static const MemoryRegionOps igd_dbuf_ctl_ops = {
 
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 {
-    VFIOQuirk *ggc_quirk, *bdsm_quirk;
+    VFIOQuirk *ggc_quirk, *bdsm_quirk, *pcode_stolen_access_quirk;
     VFIOConfigMirrorQuirk *ggc_mirror, *bdsm_mirror;
     int gen;
 
@@ -562,6 +586,25 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
+    /*
+     * MTL/ARL guests must keep using the BAR-based framebuffer address.
+     * Return 0 for PCODE stolen memory access detection (0x138914) so GOP
+     * stays on the standard access path in the VM.
+     */
+    if (IGD_IS_MTL_OR_ARL(vdev)) {
+        pcode_stolen_access_quirk = vfio_quirk_alloc(1);
+        memory_region_init_io(pcode_stolen_access_quirk->mem, OBJECT(vdev),
+                              &vfio_igd_pcode_stolen_access_quirk, vdev,
+                              "vfio-igd-pcode-stolen-access-quirk", 4);
+        memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
+                                            IGD_MTL_PCODE_STOLEN_ACCESS,
+                                            pcode_stolen_access_quirk->mem,
+                                            1);
+
+        QLIST_INSERT_HEAD(&vdev->bars[nr].quirks,
+                          pcode_stolen_access_quirk, next);
+    }
+
     if (vdev->igd_gms) {
         ggc_quirk = vfio_quirk_alloc(1);
         ggc_mirror = ggc_quirk->data = g_malloc0(sizeof(*ggc_mirror));
-- 
2.56.0


