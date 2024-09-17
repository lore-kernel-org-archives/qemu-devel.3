Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33972C36009
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVWo-0006u3-RN; Tue, 17 Sep 2024 06:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqVVp-00069E-9v
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqVVn-0006lZ-Gj
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726569166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cr/KNX13Ma/cPvi3HN0YGKqnJcU5fnq6s329bntpUAs=;
 b=gUUm7H9hivYUuMNgtmLzp5AvgQr9VqFW+JkLIF1D2JyIQvd9X3PXp3SKrold8DjhGPspIq
 aE8vkpbi+CoqiXzO9/p0cf0GYWy+vOjX+OQGYqGuaZrFZORLwk97E8d2EzL3w486CvAXZ6
 WbSWMbgDQUqHbJfEJhgZLxJxyitESwE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-14_JnZ7HOUmu9ol1eOcG_Q-1; Tue,
 17 Sep 2024 06:32:45 -0400
X-MC-Unique: 14_JnZ7HOUmu9ol1eOcG_Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D7351955D4A; Tue, 17 Sep 2024 10:32:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.154])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00F9B19560AA; Tue, 17 Sep 2024 10:32:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PULL 5/8] vfio/igd: add new bar0 quirk to emulate BDSM mirror
Date: Tue, 17 Sep 2024 12:32:26 +0200
Message-ID: <20240917103229.876515-6-clg@redhat.com>
In-Reply-To: <20240917103229.876515-1-clg@redhat.com>
References: <20240917103229.876515-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

The BDSM register is mirrored into MMIO space at least for gen 11 and
later devices. Unfortunately, the Windows driver reads the register
value from MMIO space instead of PCI config space for those devices [1].
Therefore, we either have to keep a 1:1 mapping for the host and guest
address or we have to emulate the MMIO register too. Using the igd in
legacy mode is already hard due to it's many constraints. Keeping a 1:1
mapping may not work in all cases and makes it even harder to use. An
MMIO emulation has to trap the whole MMIO page. This makes accesses to
this page slower compared to using second level address translation.
Nevertheless, it doesn't have any constraints and I haven't noticed any
performance degradation yet making it a better solution.

[1] https://github.com/projectacrn/acrn-hypervisor/blob/5c351bee0f6ae46250eefc07f44b4a31e770f3cf/devicemodel/hw/pci/passthrough.c#L650-L653

Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.h        |  1 +
 hw/vfio/igd.c        | 98 ++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c |  1 +
 3 files changed, 100 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index bf67df2fbc09b3d0fd97d25dfaa5290ab33b03ea..5ad090a22976e9493c726cbb2b1b9911abfbd8c4 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -215,6 +215,7 @@ void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
 bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
 VFIOQuirk *vfio_quirk_alloc(int nr_mem);
+void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 0b6533bbf7cc37c570f332636a292c26326cd870..0d68c6a45169238b274706d29d9be11455c37f76 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -374,6 +374,104 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+#define IGD_BDSM_MMIO_OFFSET 0x1080C0
+
+static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
+                                          hwaddr addr, unsigned size)
+{
+    VFIOPCIDevice *vdev = opaque;
+    uint64_t offset;
+
+    offset = IGD_BDSM_GEN11 + addr;
+
+    switch (size) {
+    case 1:
+        return pci_get_byte(vdev->pdev.config + offset);
+    case 2:
+        return pci_get_word(vdev->pdev.config + offset);
+    case 4:
+        return pci_get_long(vdev->pdev.config + offset);
+    case 8:
+        return pci_get_quad(vdev->pdev.config + offset);
+    default:
+        hw_error("igd: unsupported read size, %u bytes", size);
+        break;
+    }
+
+    return 0;
+}
+
+static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
+                                       uint64_t data, unsigned size)
+{
+    VFIOPCIDevice *vdev = opaque;
+    uint64_t offset;
+
+    offset = IGD_BDSM_GEN11 + addr;
+
+    switch (size) {
+    case 1:
+        pci_set_byte(vdev->pdev.config + offset, data);
+        break;
+    case 2:
+        pci_set_word(vdev->pdev.config + offset, data);
+        break;
+    case 4:
+        pci_set_long(vdev->pdev.config + offset, data);
+        break;
+    case 8:
+        pci_set_quad(vdev->pdev.config + offset, data);
+        break;
+    default:
+        hw_error("igd: unsupported read size, %u bytes", size);
+        break;
+    }
+}
+
+static const MemoryRegionOps vfio_igd_bdsm_quirk = {
+    .read = vfio_igd_quirk_bdsm_read,
+    .write = vfio_igd_quirk_bdsm_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
+{
+    VFIOQuirk *quirk;
+    int gen;
+
+    /*
+     * This must be an Intel VGA device at address 00:02.0 for us to even
+     * consider enabling legacy mode. Some driver have dependencies on the PCI
+     * bus address.
+     */
+    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
+        !vfio_is_vga(vdev) || nr != 0 ||
+        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
+                                       0, PCI_DEVFN(0x2, 0))) {
+        return;
+    }
+
+    /*
+     * Only on IGD devices of gen 11 and above, the BDSM register is mirrored
+     * into MMIO space and read from MMIO space by the Windows driver.
+     */
+    gen = igd_gen(vdev);
+    if (gen < 11) {
+        return;
+    }
+
+    quirk = vfio_quirk_alloc(1);
+    quirk->data = vdev;
+
+    memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_bdsm_quirk,
+                          vdev, "vfio-igd-bdsm-quirk", 8);
+    memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
+                                        IGD_BDSM_MMIO_OFFSET, &quirk->mem[0],
+                                        1);
+
+    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
+}
+
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
     g_autofree struct vfio_region_info *rom = NULL;
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 39dae72497e0315eeb580dbcd5255c58bc38c8ed..d37f722cce0975631dd691b92a1f36568718b454 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1259,6 +1259,7 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr)
     vfio_probe_nvidia_bar0_quirk(vdev, nr);
     vfio_probe_rtl8168_bar2_quirk(vdev, nr);
 #ifdef CONFIG_VFIO_IGD
+    vfio_probe_igd_bar0_quirk(vdev, nr);
     vfio_probe_igd_bar4_quirk(vdev, nr);
 #endif
 }
-- 
2.46.0


