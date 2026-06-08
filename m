Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A203BCD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWaJP-00027a-AH; Mon, 08 Jun 2026 09:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaJN-00025v-5r
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:41 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaJK-0001qj-P5
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:40 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-307263ad0cbso5519912eec.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780926397; x=1781531197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmVUDnOf12D/8Gz/HBWKseB4q9uhka05+EsRNjPTTjQ=;
 b=fEJu6qi/MXVi0feK3NIZksjsF+KnbclSSvL4zfHA/KATUQL/UaniNZxlVu1ejlLYaQ
 TL+Zbu9RWQVBShA0bv/Fv0P0sYesGjepTWc0KFEfaHMf+1Qd6oLd/uZfIsNs93CQ7EdT
 Gh6j+P3a8XE/cLxFxWbN3Zyrg8FXbfUW9qALLKG0zkkxcjvxuH1HmELCjT13W4jFeODb
 +HMY1tzRbEK9RIOLdHhfTKWmFD1REQ0rbaTIsyamo8q4QUnOoa05yj20AsLyDr320k4W
 ybaLgizfzSNnY9WqBPsKn1mTnZS+P+nO6FaA2AP3tFAclO0oGBY1HIl8m3hFwnMRNX2z
 bSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780926397; x=1781531197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pmVUDnOf12D/8Gz/HBWKseB4q9uhka05+EsRNjPTTjQ=;
 b=Iszfzg2/hTPEnx/DzlAUuCYFccagSzSq+ObOQOptilAnByI0NGGR6JepnT1phUBvXy
 u1tkG+1FdFGAy+Nh00iruJQ8h2xaoxaOYpfQe83rYfn1dDk2L0oBJ+zDqhVnk7XS0qu6
 tRH1cxZhBP/SCfYMVxWbEcaiW/Lb2fAsNHy9S4VT7mJNMnFRkv+jfnPiUQp5bRRzws/9
 SNYhsmZdWZj5ohjtSP44msJK1koD7ZibeAysiVziOW51YfVYMVYMaIluiSgIGWdQfOEv
 AGRZaH1x2OWmOCOQqUjh7DbywlBZviCpaO1vX2X1mv5ql+lUqpTjQ95Phy1DsqGitakp
 vaiQ==
X-Gm-Message-State: AOJu0YxeGHbzLBtSLaqpLleJc/QqD7CCApLpulZIsRvDkkgUKMJp1Mt2
 n+FbYASng/ffYrMSKmWTf9dhYANxD1yooyzA7LAEjdP3Ad/90LDMHl+QelovIaD3/g==
X-Gm-Gg: Acq92OFlwjaR84bE7bZJJsMRh+A7pnekNWOzn79ASeRs3VPp+psyy0Hl4YHGKnKhSLd
 gov4a79pUwbMIQp7fvjcAAM5eHC+uLrZT2ZfwUycj5e1getJslz0StoB8mB8J8DzElIHlkB+5Wm
 ysja+n3OgW990tTfwDfjtx1yScSJUnadZkIXNQmq+SDV+w1OC+ZSOa78zRi2oZ3J3fkHAOuwq2M
 o8u+HWhSiATWRmFGgDGXxYgKXxmmOFqClOou+mwUB7sCNTF8v+Lv/jYL+8f8lusJgZNs/1pMTxH
 aKXRKuUXSTIQES7Wc24fSP1ajuSF+1hcvMRRTPW2pRXIt/VcKSoJnhIGBk7Yl7Sk5r1nbVc82na
 1RKoIM6aBg07C8/9PjnwtasZ4mao8eb2nXriLf1ACebVJ6pTOpErWc3bzXlk73+SXszrmZ7M7Ch
 oP3KeKZeyRQJai+jARB5z16X6jNx1eCK/IRA7OuxivQg==
X-Received: by 2002:a05:693c:2d85:b0:304:dc05:607e with SMTP id
 5a478bee46e88-3077af08540mr9121368eec.14.1780926396855; 
 Mon, 08 Jun 2026 06:46:36 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f54c9c12sm12335970c88.6.2026.06.08.06.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 06:46:36 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v2 7/7] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load
 time
Date: Mon,  8 Jun 2026 21:45:58 +0800
Message-ID: <20260608134559.23971-8-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608134559.23971-1-tomitamoeko@gmail.com>
References: <20260608134559.23971-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dy1-x1342.google.com
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
index 834539affb..4b49038753 100644
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
+        if (val < rom_size) {
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
+    ((uint8_t *)vdev->rom)[6] = (uint8_t)-checksum;
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
index 2049159015..7dc334ccb3 100644
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


