Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1040ACD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnB4-0003zH-A1; Wed, 17 Jun 2026 06:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnB2-0003yJ-Ql
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:20 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnAz-0008Rn-KN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:19 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-30759632453so8865716eec.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 03:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781690836; x=1782295636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eR29j5eSW3jHnfyZlO9CmHsOeUjUcFAsBjZkoSBziy4=;
 b=ccElQpHUncg9PvCPw1y2KeH++e6L3MTqbGi19KJjUpV4RXAPlSJfc5CRV4xucuITpj
 h/Kd+jQb4O/iOul4F9SvtAD5i1sWMLT6dKu+Qrq6aus8TkpRoSjhdp6bOjsWdmSXO6Gv
 YugMwh/qZNiYrrr4fiCEizVLs/2FtWAoJe1pkLKFeyJFI5lQ3bJ8ecg0Xmm0SrWDg3yO
 6tOTPboMIJrzroOdrjIJ035ZxN+/UzbTQuUt5n5JpGaZUCJR0i8teWwGvTi0nEnZ8/N6
 GIhWOsZnMdj6YpMwi6dTH/d4+kjxwmaCtpap93mkB6nL6gwLWdUn9bV21fgp2T+0Ik0O
 V7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781690836; x=1782295636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eR29j5eSW3jHnfyZlO9CmHsOeUjUcFAsBjZkoSBziy4=;
 b=ri9BP5rfnoDpNHWhiSVDgOuj/Limy6ARgJdco4/OYzIL+2Z42ew7QOZsIzxqMY1iLT
 TJG87gk1/nvUyWHZBzsc86UYFAhx3kn7Vdi0gQv+qRN+0hO2UynkbeHWpo1H8o7viE/a
 j+vkkq+vh/+P3vq8b2joQqLyNLGbwcNay/7U60AznOCHMt18TqUzBosnTTtN3kPR2faC
 dHutcWMwsFh+VG9JvrutAvajKcNPhf6N2L0Av9yp0YDIVkTy5dG6BNgjfy+uPv9m2D66
 gPcEuWxZSpGEPtVwUrvtThTqE/vklAvpifMeMrEfNFLDnVeqzQrH2eX2+KAWX4BtUxCj
 Ggkw==
X-Gm-Message-State: AOJu0Ywd2IPUHJglAFCO3n+G4lkZnSWL6X9mmLDVB+OcMdim2QEPj1Bi
 UlVmQsSS+2cZUrGPsl2DUuE7UKQEnF4zzM2Tc3TFBS6Jhd664fXSk96gru9JfLlyzQ==
X-Gm-Gg: AfdE7cl2wAnvft7CG+edd/U8xV/bADgnbILbjrBf7QgWY5Jgc1Otp6I43XHfFeJURf1
 oK1v7nJn0LuxCGtlX6m2sG/RWhjOxLMeHCFLuNQz4LtbLJW1IyDfaVowMKD22a7sCi7WD7noCd5
 78k9f8smVR8HDLZJY/dRdoLK5Z+cF5oy/MGAMldHvbMXMXm7+FVBknSZbyT0J5F1JUnrhG/tsXM
 mh3PpPm7JVGPzsOBiMAAmoakFzlOkdaez6qSiV/EXQXWZm8AUNU/SUog2AQlvpScE9sY/j1X03J
 k7ekHRqZ03H4j6lGBcLkDZBbOlneHn1AN3AmPWGLG7F0fwRTYuHAJKpTEXP12u6rV6UFMYgzVfE
 HfFuEWu29nOSeZDpfN0j8exTJSJ2AadPJojAzpef2mBY8OmTFK/7calsRY5UWWl7IqV52pM9k1X
 M2JDMHBJwD4fOkDkvukQ57E2Ygh+ZNutQ=
X-Received: by 2002:a05:7300:7b8a:b0:304:ba84:a0cc with SMTP id
 5a478bee46e88-30bca0faccamr1696169eec.33.1781690835993; 
 Wed, 17 Jun 2026 03:07:15 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d3f20sm21858490eec.9.2026.06.17.03.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:07:15 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v3 7/7] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load
 time
Date: Wed, 17 Jun 2026 18:06:44 +0800
Message-ID: <20260617100646.28326-8-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617100646.28326-1-tomitamoeko@gmail.com>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Considering it's unsafe to expose HPA to guest, a ROM quirk clearing
the saved value in VBIOS image is introduced. It searches the BDSM
accessor routine by matching a 19-byte signature anchored on the unique
`mov $0x105e,%ax` instruction, then locate the offset of saved BDSM and
clears it. This makes the routine fall through to the PCI config read
on the first call inside the guest.

The quirk is invoked in vfio_pci_load_rom(), and is gated on Gen 6-9
IGD devices with VGA access enabled and legacy (non-UEFI) PCIR code
type in the ROM header. A new trace event vfio_pci_igd_vbios_patched
is also introduced.

[1] 3.5.15, 4th Generation Intel Core Processor Family Datasheet Vol. 2
    https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd-stubs.c  |   5 ++
 hw/vfio/igd.c        | 110 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c |   5 ++
 hw/vfio/pci.c        |   2 +
 hw/vfio/pci.h        |   3 ++
 hw/vfio/trace-events |   1 +
 6 files changed, 126 insertions(+)

diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
index f7687d9091..879a8aff56 100644
--- a/hw/vfio/igd-stubs.c
+++ b/hw/vfio/igd-stubs.c
@@ -18,3 +18,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     return true;
 }
+
+void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
+{
+    return;
+}
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 834539affb..9e2d7a9648 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -734,3 +734,113 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
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
+ *   66 5b                 2：pop   %ebx
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
+void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
+{
+    int ret, gen;
+    uint16_t pcir_offset, bdsm_offset = 0;
+    uint8_t checksum;
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
+    if (pci_get_word(vdev->rom) != 0xaa55) {
+        return;
+    }
+
+    /* Must be a legacy ROM */
+    pcir_offset = pci_get_word(vdev->rom + 0x18);
+    if (pcir_offset + 0x14 >= vdev->rom_size ||
+        memcmp(vdev->rom + pcir_offset, "PCIR", 4) ||
+        pci_get_byte(vdev->rom + pcir_offset + 0x14) != 0x00) {
+        return;
+    }
+
+    ret = igd_vbios_find_saved_bdsm(vdev->rom, vdev->rom_size, &bdsm_offset);
+    if (ret < 0) {
+        return;
+    }
+
+    memset(vdev->rom + bdsm_offset, 0, sizeof(uint32_t));
+
+    checksum = pci_rom_calculate_checksum(vdev->rom, vdev->rom_size);
+    ((uint8_t *)vdev->rom)[6] -= checksum;
+
+    trace_vfio_pci_igd_vbios_patched(vdev->vbasedev.name);
+}
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index bccf31751f..45db968681 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1592,3 +1592,8 @@ bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
 
     return true;
 }
+
+void vfio_rom_quirk_setup(VFIOPCIDevice *vdev)
+{
+    vfio_probe_igd_legacy_rom_quirk(vdev);
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6cbd65126e..66d6315e6f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1088,6 +1088,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     if (pdev->rom_need_patch_id) {
         pci_rom_patch_ids(pdev, vdev->rom, vdev->rom_size);
     }
+
+    vfio_rom_quirk_setup(vdev);
 }
 
 /* "Raw" read of underlying config space. */
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c3a1f53d35..d8d6c09632 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -251,10 +251,13 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr);
 void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
 void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
 bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
+void vfio_rom_quirk_setup(VFIOPCIDevice *vdev);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
 VFIOQuirk *vfio_quirk_alloc(int nr_mem);
+
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
 bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
+void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 8dbb477298..8ff8af7302 100644
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
2.53.0


