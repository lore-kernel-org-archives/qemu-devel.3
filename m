Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A23AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 11:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh5v4-00083f-Qb; Thu, 22 Aug 2024 07:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sh5v2-00081N-Fk
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:23:56 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1sh5v0-00035l-Dt
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 07:23:56 -0400
Received: from 172.17.5.170 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Thu, 22 Aug 2024 11:18:48 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1724325528; bh=51g5v0YASy9hVByXKdNTFlH8GhBPc80zGQ+RejMqEuw=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 CuceMlyIjYx0zPQVCeHdeftVUpQOBQRgciV1ZO9PHRP0WG6WbJkkOhpXYfwZKdeZ/tvJn6oO+YiDSa3hhMa8Dw==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1724325528; bh=51g5v0YASy9hVByXKdNTFlH8GhBPc80zGQ+RejMqEuw=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 F1Zs27GyFHZwvmD0vTgKtIS0O0mw2deg8VviA59jHLKG+MwF8KwhsqgoLnCbU7WKmaOc8EbOddg4knK7+26P4ib38Fn7CnRnk2SaIJOV1r90f5sUax52wGcWhfxf6m1MuEf7Ov5ZC30XUuU6xw/Sv++jUCCNUPRHEUEogdcGmtOZkY3msmK4UUVcALWFIFGUSC+jA4Wt6dasT79TuYzVM+fOSTsc3PYVuRXllYcUCH+ToUcMvSj/2s7+iDKIsiVQpFlvFPcjgptNb6XTXSGMEd8CR+EDbjePS/ti9aIQtEgKOApdb9ovzC9IKhWjuSLRVQnPbNm+TVTvOaRcRfcaPA==
Received: from corvink-nb.c.koehne.headscale.beckhoff.dev (172.17.61.20) by
 ex04.beckhoff.com (172.17.5.170) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 Aug
 2024 13:18:45 +0200
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
To: <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 4/7] vfio/igd: add new bar0 quirk to emulate BDSM mirror
Date: Thu, 22 Aug 2024 13:08:29 +0200
Message-ID: <20240822111819.34306-5-c.koehne@beckhoff.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822111819.34306-1-c.koehne@beckhoff.com>
References: <20240822111819.34306-1-c.koehne@beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.17.61.20]
X-ClientProxiedBy: ex01.beckhoff.com (172.17.2.168) To ex04.beckhoff.com
 (172.17.5.170)
X-OLX-Disclaimer: EX04.BECKHOFF.COM
Received-SPF: pass client-ip=62.159.14.10; envelope-from=C.Koehne@beckhoff.com;
 helo=netsrv01.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

=EF=BB=BFThe BDSM register is mirrored into MMIO space at least for gen 11 =
and
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

[1] https://github.com/projectacrn/acrn-hypervisor/blob/5c351bee0f6ae46250e=
efc07f44b4a31e770f3cf/devicemodel/hw/pci/passthrough.c#L650-L653

Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c        | 97 ++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c |  1 +
 hw/vfio/pci.h        |  1 +
 3 files changed, 99 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 0b6533bbf7..863b58565e 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -374,6 +374,103 @@ static const MemoryRegionOps vfio_igd_index_quirk =3D=
 {
     .endianness =3D DEVICE_LITTLE_ENDIAN,
 };
=20
+#define IGD_BDSM_MMIO_OFFSET 0x1080C0
+
+static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
+                                          hwaddr addr, unsigned size)
+{
+    VFIOPCIDevice *vdev =3D opaque;
+    uint64_t offset;
+
+    offset =3D IGD_BDSM_GEN11 + addr;
+
+    switch (size) {
+    case 1:
+        return pci_get_byte(vdev->pdev.config + offset);
+    case 2:
+        return le16_to_cpu(pci_get_word(vdev->pdev.config + offset));
+    case 4:
+        return le32_to_cpu(pci_get_long(vdev->pdev.config + offset));
+    case 8:
+        return le64_to_cpu(pci_get_quad(vdev->pdev.config + offset));
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
+    VFIOPCIDevice *vdev =3D opaque;
+    uint64_t offset;
+
+    offset =3D IGD_BDSM_GEN11 + addr;
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
+static const MemoryRegionOps vfio_igd_bdsm_quirk =3D {
+    .read =3D vfio_igd_quirk_bdsm_read,
+    .write =3D vfio_igd_quirk_bdsm_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+};
+
+void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
+{
+    VFIOQuirk *quirk;
+    int gen;
+
+    /*
+     * This must be an Intel VGA device at address 00:02.0 for us to even
+     * consider enabling legacy mode. Some driver have dependencies on the=
 PCI
+     * bus address.
+     */
+    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
+        !vfio_is_vga(vdev) || nr !=3D 0 ||
+        &vdev->pdev !=3D pci_find_device(pci_device_root_bus(&vdev->pdev),
+                                       0, PCI_DEVFN(0x2, 0))) {
+        return;
+    }
+
+    /*
+     * Only on IGD devices of gen 11 and above, the BDSM register is mirro=
red
+     * into MMIO space and read from MMIO space by the Windows driver.
+     */
+    gen =3D igd_gen(vdev);
+    if (gen < 11) {
+        return;
+    }
+
+    quirk =3D vfio_quirk_alloc(1);
+    quirk->data =3D vdev;
+
+    memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_bdsm_qui=
rk,
+                          vdev, "vfio-igd-bdsm-quirk", 8);
+    memory_region_add_subregion_overlap(vdev->bars[0].region.mem, 0x1080C0=
,
+                                        &quirk->mem[0], 1);
+
+    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
+}
+
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
     g_autofree struct vfio_region_info *rom =3D NULL;
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 39dae72497..d37f722cce 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1259,6 +1259,7 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr=
)
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
=20
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
--=20
2.46.0

This email contains confidential information. If you have received it in er=
ror, you must not read, use, copy or pass on this e-mail or its attachments=
. If you have received the e-mail in error, please inform me immediately by=
 reply e-mail and then delete this e-mail from your system. Thank you
=20
Diese E-Mail enth=C3=A4lt vertrauliche Informationen. Sollten Sie sie irrt=
=C3=BCmlich erhalten haben, d=C3=BCrfen Sie diese E-Mail oder ihre Anh=C3=
=A4nge nicht lesen, verwenden, kopieren oder weitergeben. Sollten Sie die M=
ail versehentlich erhalten haben, teilen Sie mir dies bitte umgehend per An=
twort-E-Mail mit und l=C3=B6schen Sie diese E-Mail dann aus Ihrem System. V=
ielen Dank

Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Bec=
khoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075




