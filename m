Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B305C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 18:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdGq-0001Pg-2h; Mon, 24 Feb 2025 13:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdDF-0005gA-Tn
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:29:55 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tmdD7-0003JM-9d
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 13:29:52 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-220c8cf98bbso13344025ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 10:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740421781; x=1741026581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPwdQyAYH1XWglrDs3yxsMrLIl2j/SlpqBC7lDIhGyg=;
 b=dAkccxEtyaI0P/JROy0UzVuBth76nQGX6N+hrrMsD2WEyC+Pn9IJHWd16HGJglxdFp
 k6wg92GT68Gx3XA1T0Iyo6/XwhN4lkJkvAFGD+WIZNPEjPZozA74t1bsYAikXcc71RqZ
 cXIqoM6ssFs/oi2tNZCE54RZWGVMG9muzIf7LmbpmhddgBoxKEZf8GesxdbVX993TN47
 qSkETBmtyOdeUCe3HrylxAcQ8JzSRDUYJD39gfoJs0pk/cC5Y/8tqgClslMIqvw8Ar3T
 qfWOSu1RRhy+YE3IK0HG9A0sFGTAh9TZ5O+Pl7MLmCEIr07W+0ELBv8l1zSQumga2SRW
 njVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740421781; x=1741026581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPwdQyAYH1XWglrDs3yxsMrLIl2j/SlpqBC7lDIhGyg=;
 b=H0bAPvsotGNK4HOEdh5JiOALlK/SZanunOOcu92Sbk1LkMTABN9z/2WIEJMkPNDSke
 wF4mv37oba0sCXn+NrzCcFLg/kDDxZfA6qsJfgECZnLmsXAadklvQJJuQcKQ59lVof0i
 UHCH2IhbUJ9lq/7wzWzFVxMdUnv3tH2TLI3CJEKBX5wrL/JrvcUKgBxFXkjgHuijlR/b
 3HbXEtMvH/Hh7sB7LsLIkkIWhkNOqMzIiAAV19hMuwNaFz7fcR7qDoOYvCHq/n+NuX2T
 Lrep6pjRAX9l+G6WDw61VAvQFWQhYntn/9D3CYNHmd1eHZ5gokKVeJJlxQJuXimoh/Zo
 TlvQ==
X-Gm-Message-State: AOJu0YyfQvFnIbDacQhvNJP0nMuGzm32r38siafgyToL017rHYo2fLVS
 QOtcnXxZDAiZotldIacwmsL3TeJhlWD5Ix7BtcZ/4rKG/tTy1Zzzk/fRv4X7vg==
X-Gm-Gg: ASbGncuSXZKJu9UN71E8j7ojJm6HbKOng4fLK+h1baiGrHi9qDSy9Jctp8676K1BxWA
 pUrXxw63dJa7UNvkTwHkigxxUG8exPu+AKnw4YMsQUAmEC3hhMLT697YFARYx6CC1cuqqbMfy0f
 s8WX+zcDbaauRxy7Y18BKR4Zb1X3obHKkRaQfVvmBE1tcIWPgL1gCZbG9kqnYJzVC5cIXt4D6jW
 Ekm2V3sHfikan5OZUw91b0ozjDBy0cxQh3P9RmB//CNIPIQNFwIc9HmG30cr6GeK4EgQuRAMTB9
 n6X15OBL2cp6wyOOMlVPK2RwTrlN4WB5rCQPkqY=
X-Google-Smtp-Source: AGHT+IFTTyAIcwmc+ghZnZ0tTw7Ml7hnOkduu6V9O7ot2F4A+nVPhazCUwc8uBHrY0hFNTEvcZJfFg==
X-Received: by 2002:a17:903:2349:b0:21f:baa:80be with SMTP id
 d9443c01a7336-221a118a866mr240107215ad.46.1740421781215; 
 Mon, 24 Feb 2025 10:29:41 -0800 (PST)
Received: from localhost.localdomain ([116.227.8.253])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545cf6bsm183662615ad.123.2025.02.24.10.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 10:29:40 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 01/10] vfio/igd: Remove GTT write quirk in IO BAR 4
Date: Tue, 25 Feb 2025 02:29:18 +0800
Message-ID: <20250224182927.31519-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224182927.31519-1-tomitamoeko@gmail.com>
References: <20250224182927.31519-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The IO BAR4 of IGD devices contains a pair of 32-bit address/data
registers, MMIO_Index (0x0) and MMIO_Data (0x4), which provide access
to the MMIO BAR0 (GTTMMADR) from IO space. These registers are probably
only used by the VBIOS, and are not documented by intel. The observed
layout of MMIO_Index register is:
 31                                                   2   1      0
+-------------------------------------------------------------------+
|                        Offset                        | Rsvd | Sel |
+-------------------------------------------------------------------+
- Offset: Byte offset in specified region, 4-byte aligned.
- Sel: Region selector
       0: MMIO register region (first half of MMIO BAR0)
       1: GTT region (second half of MMIO BAR0). Pre Gen11 only.

Currently, QEMU implements a quirk that adjusts the guest Data Stolen
Memory (DSM) region address to be (addr - host BDSM + guest BDSM) when
programming GTT entries via IO BAR4, assuming guest still programs GTT
with host DSM address, which is not the case. Guest's BDSM register is
emulated and initialized to 0 at startup by QEMU, then SeaBIOS programs
its value[1]. As result, the address programmed to GTT entries by VBIOS
running in guest are valid GPA, and this unnecessary adjustment brings
inconsistency.

[1] https://gitlab.com/qemu-project/seabios/-/blob/1.12-stable/src/fw/pciinit.c#L319-332

Link: https://lore.kernel.org/all/20250124191245.12464-1-tomitamoeko@gmail.com/
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 191 +-------------------------------------------------
 1 file changed, 1 insertion(+), 190 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index b1a237edd6..ca3a32f4f2 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -106,12 +106,6 @@ static int igd_gen(VFIOPCIDevice *vdev)
     return -1;
 }
 
-typedef struct VFIOIGDQuirk {
-    struct VFIOPCIDevice *vdev;
-    uint32_t index;
-    uint64_t bdsm;
-} VFIOIGDQuirk;
-
 #define IGD_GMCH 0x50 /* Graphics Control Register */
 #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
 #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
@@ -300,129 +294,6 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
     return ret;
 }
 
-/*
- * IGD Gen8 and newer support up to 8MB for the GTT and use a 64bit PTE
- * entry, older IGDs use 2MB and 32bit.  Each PTE maps a 4k page.  Therefore
- * we either have 2M/4k * 4 = 2k or 8M/4k * 8 = 16k as the maximum iobar index
- * for programming the GTT.
- *
- * See linux:include/drm/i915_drm.h for shift and mask values.
- */
-static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
-{
-    uint32_t gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
-    int gen = igd_gen(vdev);
-    uint64_t ggms_size = igd_gtt_memory_size(gen, gmch);
-
-    return (ggms_size / (4 * KiB)) * (gen < 8 ? 4 : 8);
-}
-
-/*
- * The IGD ROM will make use of stolen memory (GGMS) for support of VESA modes.
- * Somehow the host stolen memory range is used for this, but how the ROM gets
- * it is a mystery, perhaps it's hardcoded into the ROM.  Thankfully though, it
- * reprograms the GTT through the IOBAR where we can trap it and transpose the
- * programming to the VM allocated buffer.  That buffer gets reserved by the VM
- * firmware via the fw_cfg entry added below.  Here we're just monitoring the
- * IOBAR address and data registers to detect a write sequence targeting the
- * GTTADR.  This code is developed by observed behavior and doesn't have a
- * direct spec reference, unfortunately.
- */
-static uint64_t vfio_igd_quirk_data_read(void *opaque,
-                                         hwaddr addr, unsigned size)
-{
-    VFIOIGDQuirk *igd = opaque;
-    VFIOPCIDevice *vdev = igd->vdev;
-
-    igd->index = ~0;
-
-    return vfio_region_read(&vdev->bars[4].region, addr + 4, size);
-}
-
-static void vfio_igd_quirk_data_write(void *opaque, hwaddr addr,
-                                      uint64_t data, unsigned size)
-{
-    VFIOIGDQuirk *igd = opaque;
-    VFIOPCIDevice *vdev = igd->vdev;
-    uint64_t val = data;
-    int gen = igd_gen(vdev);
-
-    /*
-     * Programming the GGMS starts at index 0x1 and uses every 4th index (ie.
-     * 0x1, 0x5, 0x9, 0xd,...).  For pre-Gen8 each 4-byte write is a whole PTE
-     * entry, with 0th bit enable set.  For Gen8 and up, PTEs are 64bit, so
-     * entries 0x5 & 0xd are the high dword, in our case zero.  Each PTE points
-     * to a 4k page, which we translate to a page from the VM allocated region,
-     * pointed to by the BDSM register.  If this is not set, we fail.
-     *
-     * We trap writes to the full configured GTT size, but we typically only
-     * see the vBIOS writing up to (nearly) the 1MB barrier.  In fact it often
-     * seems to miss the last entry for an even 1MB GTT.  Doing a gratuitous
-     * write of that last entry does work, but is hopefully unnecessary since
-     * we clear the previous GTT on initialization.
-     */
-    if ((igd->index % 4 == 1) && igd->index < vfio_igd_gtt_max(vdev)) {
-        if (gen < 8 || (igd->index % 8 == 1)) {
-            uint64_t base;
-
-            if (gen < 11) {
-                base = pci_get_long(vdev->pdev.config + IGD_BDSM);
-            } else {
-                base = pci_get_quad(vdev->pdev.config + IGD_BDSM_GEN11);
-            }
-            if (!base) {
-                hw_error("vfio-igd: Guest attempted to program IGD GTT before "
-                         "BIOS reserved stolen memory.  Unsupported BIOS?");
-            }
-
-            val = data - igd->bdsm + base;
-        } else {
-            val = 0; /* upper 32bits of pte, we only enable below 4G PTEs */
-        }
-
-        trace_vfio_pci_igd_bar4_write(vdev->vbasedev.name,
-                                      igd->index, data, val);
-    }
-
-    vfio_region_write(&vdev->bars[4].region, addr + 4, val, size);
-
-    igd->index = ~0;
-}
-
-static const MemoryRegionOps vfio_igd_data_quirk = {
-    .read = vfio_igd_quirk_data_read,
-    .write = vfio_igd_quirk_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static uint64_t vfio_igd_quirk_index_read(void *opaque,
-                                          hwaddr addr, unsigned size)
-{
-    VFIOIGDQuirk *igd = opaque;
-    VFIOPCIDevice *vdev = igd->vdev;
-
-    igd->index = ~0;
-
-    return vfio_region_read(&vdev->bars[4].region, addr, size);
-}
-
-static void vfio_igd_quirk_index_write(void *opaque, hwaddr addr,
-                                       uint64_t data, unsigned size)
-{
-    VFIOIGDQuirk *igd = opaque;
-    VFIOPCIDevice *vdev = igd->vdev;
-
-    igd->index = data;
-
-    vfio_region_write(&vdev->bars[4].region, addr, data, size);
-}
-
-static const MemoryRegionOps vfio_igd_index_quirk = {
-    .read = vfio_igd_quirk_index_read,
-    .write = vfio_igd_quirk_index_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
 #define IGD_GGC_MMIO_OFFSET     0x108040
 #define IGD_BDSM_MMIO_OFFSET    0x1080C0
 
@@ -494,14 +365,11 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     g_autofree struct vfio_region_info *opregion = NULL;
     g_autofree struct vfio_region_info *host = NULL;
     g_autofree struct vfio_region_info *lpc = NULL;
-    VFIOQuirk *quirk;
-    VFIOIGDQuirk *igd;
     PCIDevice *lpc_bridge;
-    int i, ret, gen;
+    int ret, gen;
     uint64_t ggms_size, gms_size;
     uint64_t *bdsm_size;
     uint32_t gmch;
-    uint16_t cmd_orig, cmd;
     Error *err = NULL;
 
     /*
@@ -634,32 +502,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    /* Setup our quirk to munge GTT addresses to the VM allocated buffer */
-    quirk = vfio_quirk_alloc(2);
-    igd = quirk->data = g_malloc0(sizeof(*igd));
-    igd->vdev = vdev;
-    igd->index = ~0;
-    if (gen < 11) {
-        igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM, 4);
-    } else {
-        igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM_GEN11, 4);
-        igd->bdsm |=
-            (uint64_t)vfio_pci_read_config(&vdev->pdev, IGD_BDSM_GEN11 + 4, 4) << 32;
-    }
-    igd->bdsm &= ~((1 * MiB) - 1); /* 1MB aligned */
-
-    memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_index_quirk,
-                          igd, "vfio-igd-index-quirk", 4);
-    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
-                                        0, &quirk->mem[0], 1);
-
-    memory_region_init_io(&quirk->mem[1], OBJECT(vdev), &vfio_igd_data_quirk,
-                          igd, "vfio-igd-data-quirk", 4);
-    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
-                                        4, &quirk->mem[1], 1);
-
-    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
-
     /*
      * Allow user to override dsm size using x-igd-gms option, in multiples of
      * 32MiB. This option should only be used when the desired size cannot be
@@ -717,37 +559,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         pci_set_quad(vdev->emulated_config_bits + IGD_BDSM_GEN11, ~0);
     }
 
-    /*
-     * This IOBAR gives us access to GTTADR, which allows us to write to
-     * the GTT itself.  So let's go ahead and write zero to all the GTT
-     * entries to avoid spurious DMA faults.  Be sure I/O access is enabled
-     * before talking to the device.
-     */
-    if (pread(vdev->vbasedev.fd, &cmd_orig, sizeof(cmd_orig),
-              vdev->config_offset + PCI_COMMAND) != sizeof(cmd_orig)) {
-        error_report("IGD device %s - failed to read PCI command register",
-                     vdev->vbasedev.name);
-    }
-
-    cmd = cmd_orig | PCI_COMMAND_IO;
-
-    if (pwrite(vdev->vbasedev.fd, &cmd, sizeof(cmd),
-               vdev->config_offset + PCI_COMMAND) != sizeof(cmd)) {
-        error_report("IGD device %s - failed to write PCI command register",
-                     vdev->vbasedev.name);
-    }
-
-    for (i = 1; i < vfio_igd_gtt_max(vdev); i += 4) {
-        vfio_region_write(&vdev->bars[4].region, 0, i, 4);
-        vfio_region_write(&vdev->bars[4].region, 4, 0, 4);
-    }
-
-    if (pwrite(vdev->vbasedev.fd, &cmd_orig, sizeof(cmd_orig),
-               vdev->config_offset + PCI_COMMAND) != sizeof(cmd_orig)) {
-        error_report("IGD device %s - failed to restore PCI command register",
-                     vdev->vbasedev.name);
-    }
-
     trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name,
                                     (ggms_size + gms_size) / MiB);
 }
-- 
2.47.2


