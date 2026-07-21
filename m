Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611B3C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDuO-0004lb-Iz; Tue, 21 Jul 2026 13:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDuM-0004kr-C3
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmDuK-00072O-3l
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784653527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ls3p/bTX4nCuNnshAFjSlUyfFX7ZZPLPVZ6OwzJD8zM=;
 b=LTGp+mRormv9UHOH+2wlANxbMAhyvxTF3W4xg6T2Aag6rm/cEGRdUKuvN6YGFgNebY53jM
 JXa/4JWs6AY0O4iYW+JlGdcW/XfpSnpTk5RSwk9CcCoYPBqVKANXDyklorlou6hyeywmT6
 gHS4QFcOUK4ie+AVRAy/HLt993sPKHY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-yOEL44fAOQWHfbn0CFVr1A-1; Tue,
 21 Jul 2026 13:05:25 -0400
X-MC-Unique: yOEL44fAOQWHfbn0CFVr1A-1
X-Mimecast-MFC-AGG-ID: yOEL44fAOQWHfbn0CFVr1A_1784653524
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9078D19774FC; Tue, 21 Jul 2026 17:05:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 454F61598; Tue, 21 Jul 2026 17:05:22 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>,
 qemu-stable@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/13] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load
 time
Date: Tue, 21 Jul 2026 19:05:06 +0200
Message-ID: <20260721170518.4160785-2-clg@redhat.com>
In-Reply-To: <20260721170518.4160785-1-clg@redhat.com>
References: <20260721170518.4160785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

From: Tomita Moeko <tomitamoeko@gmail.com>

IGD does not come with a ROM BAR [1], the ROM BAR read by default from
kernel is actually the host VBIOS shadow RAM region that contains host
modifications on boot. With AI-assisted reverse engineering on VBIOS
binaries, it is observed that VBIOS saves BDSM register value on first
access and uses saved value if present.

When the image is executed in guest, since there is already a saved HPA
in VBIOS, it keeps using that value instead of the GPA programmed by
SeaBIOS in BDSM register in PCI config space, causing VBIOS to program
GTT entries with wrong address, resulting in garbled output in BIOS
POST and the error below detected by i915 driver.

i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using invalid range, dma_addr=0x00000000db200000 ((null) [0x00000000baf00000-0x00000000beefffff])

The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
values in MMIO BAR0 and IO BAR4.

Since it was a value latched into the VBIOS that breaks virtualization
(QEMU does not map the GTT at the same address in the VM), a ROM quirk
clearing the saved value in VBIOS image is introduced. It searches the
BDSM accessor routine by matching a 19-byte signature anchored on the
unique `mov $0x105e,%ax` instruction, then locates the offset of saved
BDSM and clears it. This makes the routine fall through to the PCI
config read on the first call inside the guest.

[1] 3.5.15, 4th Generation Intel Core Processor Family Datasheet Vol. 2
    https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf

Fixes: 5aed8b0f0be2 ("vfio/igd: Remove GTT write quirk in IO BAR 4")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Reviewed-by: Alex Williamson <alex@shazbot.org>
Link: https://lore.kernel.org/qemu-devel/20260708103100.23127-1-tomitamoeko@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h        |   3 ++
 hw/vfio/igd-stubs.c  |   5 ++
 hw/vfio/igd.c        | 115 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c |   5 ++
 hw/vfio/pci.c        |   2 +
 hw/vfio/trace-events |   1 +
 6 files changed, 131 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index fe52e9df6e67707c9899d418b0261afeedf4aab2..c9ab9498708ec0343e206c7f343085b0be8a7a1e 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -252,10 +252,13 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr);
 void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
 void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
 bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
+void vfio_rom_quirk_setup(VFIOPCIDevice *vdev);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
 VFIOQuirk *vfio_quirk_alloc(int nr_mem);
+
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
 bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
+void vfio_igd_legacy_rom_quirk(VFIOPCIDevice *vdev);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
index f7687d909125c2233e76f7e6d03aa90f38c3b89f..5f60b24c8b46d94f0de2573aeb6b6c80690476cb 100644
--- a/hw/vfio/igd-stubs.c
+++ b/hw/vfio/igd-stubs.c
@@ -18,3 +18,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     return true;
 }
+
+void vfio_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
+{
+    return;
+}
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e091f21b6a3aea0013e0b3094d2ca13588200c98..413a49aae9163c6500bc50f29e5454f698addaa4 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -724,3 +724,118 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
     return vfio_pci_igd_config_quirk(vdev, errp);
 }
+
+/*
+ * IGD ROM BAR read from kernel is actually the host VBIOS shadow RAM region,
+ * which contains host modifications. In Gen 6-9 VBIOS, the routine below is
+ * used to get BDSM value when programming the initial GTT.
+ *   xx xx xx xx           v: .long ?                  # saved value
+ *   66 53                    push  %ebx
+ *   66 2e 83 3e xx xx 00     cmpl  $0x0,%cs:v         # is saved value empty?
+ *   74 07                    je    1f                 # if zero, go compute
+ *   66 2e a1 xx xx           mov   %cs:v,%eax         # else return saved value
+ *   eb 0f                    jmp   2f
+ *   b8 5e 10              1: mov   $0x105e,%ax        # dev 00:02.0, offset 5E
+ *   e8 xx xx                 call  pci_read_cfg_word
+ *   66 c1 e0 10              shl   $0x10,%eax         # left shift 16 bits
+ *   66 2e a3 xx xx           mov   %eax,%cs:v         # save the result
+ *   66 5b                 2: pop   %ebx
+ *   c3                       ret
+ * When running the VBIOS in guest, saved value still reflects the host stolen
+ * memory base address, which is not correct in guest. So we need to patch the
+ * VBIOS to clear the saved value.
+ *
+ * The unique 19-byte starts at `cmpl $0,%cs:v` and ends at `mov $0x105e,%ax`
+ * anchors the match to the routine. Both `cs:` displacements must reference
+ * the same offset.
+ */
+static int igd_vbios_find_saved_bdsm(const uint8_t *rom, size_t rom_size,
+                                     uint16_t *bdsm_offset)
+{
+    static const uint8_t start[] = { 0x66, 0x2e, 0x83, 0x3e };
+    static const uint8_t middle[] = { 0x00, 0x74, 0x07, 0x66, 0x2e, 0xa1 };
+    static const uint8_t end[] = { 0xeb, 0x0f, 0xb8, 0x5e, 0x10 };
+    uint16_t val;
+    size_t i;
+    bool found = false;
+
+    if (rom_size < 19) {
+        return -ENOENT;
+    }
+
+    for (i = 0; i + 19 <= rom_size; i++) {
+        if (memcmp(rom + i, start, sizeof(start)) != 0 ||
+            memcmp(rom + i + 6, middle, sizeof(middle)) != 0 ||
+            memcmp(rom + i + 14, end, sizeof(end)) != 0) {
+            continue;
+        }
+
+        /* same saved value address? */
+        if (rom[i + 4] != rom[i + 12] || rom[i + 5] != rom[i + 13]) {
+            continue;
+        }
+
+        if (found) {
+            return -EEXIST;
+        }
+
+        val = rom[i + 4] | ((uint16_t)rom[i + 5] << 8);
+        if (val + sizeof(uint32_t) <= rom_size) {
+            *bdsm_offset = val;
+            found = true;
+        }
+    }
+
+    if (!found) {
+        return -ENOENT;
+    }
+
+    return 0;
+}
+
+void vfio_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
+{
+    uint8_t *rom = vdev->rom;
+    int gen;
+    uint16_t pcir_offset;
+    uint16_t bdsm_offset = 0;
+    uint8_t checksum = 0;
+    uint32_t i;
+
+    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
+        !vfio_is_vga(vdev) || !vdev->vga) {
+        return;
+    }
+
+    /* Only Gen 6~9 devices have legacy VBIOS as Option ROM */
+    gen = igd_gen(vdev);
+    if (gen < 6 || gen > 9) {
+        return;
+    }
+
+    if (pci_get_word(rom) != 0xaa55) {
+        return;
+    }
+
+    /* Must be a legacy ROM */
+    pcir_offset = pci_get_word(rom + 0x18);
+    if (pcir_offset + 0x14 >= vdev->rom_size ||
+        memcmp(rom + pcir_offset, "PCIR", 4) ||
+        pci_get_byte(rom + pcir_offset + 0x14) != 0x00) {
+        return;
+    }
+
+    /* Search and clear the saved BDSM value */
+    if (igd_vbios_find_saved_bdsm(rom, vdev->rom_size, &bdsm_offset)) {
+        return;
+    }
+    memset(rom + bdsm_offset, 0, sizeof(uint32_t));
+
+    /* Recalculate checksum and patch it. */
+    for (i = 0; i < vdev->rom_size; i++) {
+        checksum += rom[i];
+    }
+    rom[6] -= checksum;
+
+    trace_vfio_pci_igd_vbios_patched(vdev->vbasedev.name);
+}
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index bccf31751fd47387fd89110e27b695e5c822d5c4..c5b4f9091d498d49eb3371c0502e7ab6b7b76b30 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1592,3 +1592,8 @@ bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
 
     return true;
 }
+
+void vfio_rom_quirk_setup(VFIOPCIDevice *vdev)
+{
+    vfio_igd_legacy_rom_quirk(vdev);
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c204706e63045c930bda7977adc8034f907b6890..dcfc92aae1c78d3a803665bcaea1e83f66a6d030 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1119,6 +1119,8 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev, Error **errp)
         }
     }
 
+    vfio_rom_quirk_setup(vdev);
+
     return true;
 }
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index f71d0bbc0a5440e4ccd374fac4733af08438e7be..bfdaf229e42b0d9d40e38c828c97cf47eb831a87 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -90,6 +90,7 @@ vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data, uint32_
 vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
 vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
 vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
+vfio_pci_igd_vbios_patched(const char *name) "%s"
 
 # listener.c
 vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64
-- 
2.55.0


