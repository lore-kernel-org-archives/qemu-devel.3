Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CA0C5DF66
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8cn-00044H-Lf; Wed, 12 Aug 2026 09:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8cI-0003au-1K; Wed, 12 Aug 2026 09:03:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8cE-0004JK-Ap; Wed, 12 Aug 2026 09:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=xAMkvJ8dMwZof2gX7G75ehsagxNMkELJziH0ejV84Rk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KdwtWL8qms1S31c9b6071b/xVsXQdquYvb7glYEL8MxuhM9Afs3wptGkJ/KbA/VeM
 Nvlo5c3WUW+ctD8NrbBcJFnYlWRogVDj4YLeuvgmzPaWMIGTBJJ6S1YvxhUunq63xd
 2Ivofga/uLYIUJZL0waLiB32QjX/jFfTMyEMu3fARzochPVnqLRSMYAG/mcog35O/d
 aqrLXEKeFTz1bfzdPpTUzLoS2+qwKFGtBqRKIMKipQpy/zRbbFxhopqkCIeAfupuIm
 HG2eLe6nqWA/OjkTfj04Wx7atxJ5RiPmiLzFiO8yBTFXQNs8MAoHXcaQHFo9lMOUo6
 DUTeAFuM5YtxA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 267A71CA487;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5C07C409B6A;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D4E402F8A4; Wed, 12 Aug 2026 16:02:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tomita Moeko <tomitamoeko@gmail.com>,
 K S Maan <kirandeepmaan45@gmail.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 008/102] vfio/igd: Clear saved BDSM in legacy VBIOS
 ROM at load time
Date: Wed, 12 Aug 2026 16:00:43 +0300
Message-ID: <20260812130233.621965-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
(cherry picked from commit 256229e8f9b950a41b01ecee30524e7bd3235ef7)
(Mjt: back-port across v11.0.0-3-g55e25958aa1a
 "hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 265fffc2aa5..83a95db0d0f 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -680,3 +680,118 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
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
index 3f002252acf..6675d880d5e 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1594,3 +1594,10 @@ bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
 
     return true;
 }
+
+void vfio_rom_quirk_setup(VFIOPCIDevice *vdev)
+{
+#ifdef CONFIG_VFIO_IGD
+    vfio_igd_legacy_rom_quirk(vdev);
+#endif
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b8f16d9c463..f1c8da3a81a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -956,6 +956,8 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
         }
     }
 
+    vfio_rom_quirk_setup(vdev);
+
     return true;
 }
 
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index d94ecaba689..917aca4f0de 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -217,10 +217,13 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr);
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
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 9347e3a5f66..2928b5c1d73 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -88,6 +88,7 @@ vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data, uint32_
 vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
 vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
 vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
+vfio_pci_igd_vbios_patched(const char *name) "%s"
 
 # common.c
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
-- 
2.47.3


