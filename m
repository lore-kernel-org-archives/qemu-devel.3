Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37315C54FC6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIxY-0004al-F1; Wed, 28 Aug 2024 09:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxW-0004Sp-FE
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:38 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjIxU-0002L2-09
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:43:38 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7a9cf7d3f3so848061466b.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724852614; x=1725457414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S24Cu87hiavAh3YpQ1XUPV/o+dTV1fpam6g83n2N1PE=;
 b=Lcf3VtwHRgLhLAVxRrnQdMYvmXircceCembhUmcPPELUgiVZQkhzvDNj9FiYExz72/
 7I9nMbdapoVt4Go8D/2UE3PCcvtJ+/L/yzgwMn0IFJ7uaAIRx2LbtIF6lfUyU89cHjyw
 nEq5cCiMXmMpWCruqmKhtJ2n8VPqEW567Vock3KIB0NY4sH/7/Dk6y3etQ9AR25K1WBT
 hHZe1b2QvN6SSSKPeuOsr2SzHCld+vtt2X+fcrCqHeqKzbXcbukcsjOWcY9bAqr0CVg9
 12QZ5oi0B3HiJA5Wkh6LNJVPpVbH64t7uMIUApLKnsZahSzS63eCvBOQZlCyDUO1MvJw
 y2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724852614; x=1725457414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S24Cu87hiavAh3YpQ1XUPV/o+dTV1fpam6g83n2N1PE=;
 b=HV2HC9LJbvQJ/cca1TBVpnQq8UgU+D5AmehCNNq/Egfm1Iym1w6E6PlBzz4YwUFCM9
 Z++gMqDv2Bf9lRA38V7MeVVhm+D7BAkUXLAcrPyxF41u0u8eebguigLRLqBieRAFhJUB
 oihm/mDpzyvpRIJyWyOwtacQ7GB011BrU1OyTokgySJ0rhO3KQEfIoWgmhul9Rs97YQi
 ge+4rpRfvvm59HruweIo6W4wREoIyVQoGLu7fCxwM3Kw0cOPexiCVgVldTBCzmIrNBEL
 fPMSa+82e1ukKthJRoSacK0rZlg71QPj1U53KmRys6p8WzMPoQo0sweQwc2yxae+aYRk
 HW2w==
X-Gm-Message-State: AOJu0Yw0QoIIjTG5FuaZ+Oz6cmtMBxTEemR+bndiZBGDZ6ZAvPpvxx7p
 JE+6beLhow/SV3TJQdRTh2x+kABHG1/ENJgGWK2QttAgdJSoQT05IFBkfw==
X-Google-Smtp-Source: AGHT+IER2+9LL0wxMrJMVeiaYQLr2EJ0YHl47+/aSchUcxXFr/SICZewqVjIZUdbOew1jEzPGBVyWg==
X-Received: by 2002:a17:906:f5a9:b0:a86:963f:ea8d with SMTP id
 a640c23a62f3a-a86a54df8demr1308454166b.64.1724852613861; 
 Wed, 28 Aug 2024 06:43:33 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a88a48d4a39sm32606766b.12.2024.08.28.06.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:43:33 -0700 (PDT)
From: "=?UTF-8?q?Corvin=20K=C3=B6hne?=" <corvin.koehne@gmail.com>
X-Google-Original-From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: qemu-devel@nongnu.org,
	c.koehne@beckhoff.com
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 4/7] vfio/igd: add new bar0 quirk to emulate BDSM mirror
Date: Wed, 28 Aug 2024 15:43:25 +0200
Message-ID: <20240828134328.94528-5-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828134328.94528-1-c.koehne@beckhoff.com>
References: <20240828134328.94528-1-c.koehne@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
v2:
	* omit unnecessary leXX_to_cpu calls
	* make use of IGD_BDSM_MMIO_OFFSET define

 hw/vfio/igd.c        | 98 ++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c |  1 +
 hw/vfio/pci.h        |  1 +
 3 files changed, 100 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 0b6533bbf7..0d68c6a451 100644
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
index 39dae72497..d37f722cce 100644
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
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index bf67df2fbc..5ad090a229 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -215,6 +215,7 @@ void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
 bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
 VFIOQuirk *vfio_quirk_alloc(int nr_mem);
+void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
-- 
2.46.0


