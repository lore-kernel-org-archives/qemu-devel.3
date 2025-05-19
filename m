Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484B9C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs4c-0002uc-DB; Mon, 19 May 2025 00:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrox-0008S2-VC
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:50 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrow-0004OC-2t
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:47 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-afc857702d1so3573090a12.3
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627784; x=1748232584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B300N4tFGzpqfBm+PQfnLU/hq0whY6Gs5bO28y2J7A4=;
 b=neL+TV46MuHtRU5srcIMQEMjgv/w0iweBOPpoKdaPcNJvGzQo6fwVhBzt6wmnIEQu1
 +UT83cZ4E5clm7vJWVhPMNZEflVSeuR08F/gp9oXB9OH/J1WH9NFNJQYdM8gqoSEuB1T
 Eh65Cgl+rWUw6V51jSh3M2RLBl1zHgLoZrK51Ms87nPVsH7jgctw5VVhiqeXhr7Gt2OE
 QM/t1kFl26r8eiae7o4UJif4bdFcuGSUtCLnv+6yzsymxzGgn2Lhpjnoi5ziZOXymXWr
 coo6bes1Q7jK/gBSbeePa5v7Iarxg38DMlRzmWOjFNKLLmqc/WfpsN0ytt9FLA9idV16
 84eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627784; x=1748232584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B300N4tFGzpqfBm+PQfnLU/hq0whY6Gs5bO28y2J7A4=;
 b=doKPMXhLJkuoacVV3TgHXnf111txh8MQTTP0zCSyBrmNMlJHmmLf1M7nWQqZsLREj9
 5wIFc4nGq0g5DlzonTUkHofz5bLyCxZvF9oP+OxUoTRSL7YLMrVG5s0vbFrdNdkmduWR
 5ncdJqj41UzsxkEhAQ2x0FF/khaHahSiJETUV/EMAqp6imsVuWZ+hxNeeQt3bKI022ay
 ufomISvOpvtLIskPK3JJB+lWkwoE4rthNDmaptzGkH5l92OzoOUk7NmF7eVzEC3Z7NJ5
 zzeK5zWO7YZ4c/ED07czxDqEatFlygth+1JwdPTxef211izTmWjaiVRbG6BsbucbwKmn
 jIiQ==
X-Gm-Message-State: AOJu0Yw0r8VRKKC4tQK0VjvgcniDaDqjVL97Z9AVVS/u4gTe3+c5wxit
 vcT2wrhWm3GJXgcXby4+ZetUgLwWEaBNH0Voj3GoY0wdwAxFobVyBVOrVNmpVQ==
X-Gm-Gg: ASbGncu/C+aVpJhGEIdNdexwG3YIsu0oJ8gWVX2n8lOnwoQOO9+HyxZJMaizDwHSFJD
 T9BWQHRHlFw+1w2SIWYAnaeB4QaO/Ch8jBt6v6YVFXekX9s4qiGJmAHwgd+zj00JaUPjaGgbUoy
 g5qn6UwiFlmmvqaUhGkLEbB6BDLcs9aingmeOi7oeYEy76BGiUvBPo8hKHYYlFH+LQSSeRJxMLx
 cMh6R50TZQv210qWAvDjPgPxDHGVpKwT1k0+PSrPQe1jF9gnA0NvH8275Vgbun94Hz3Kz/nAkOF
 biKtTPPt+9GcSP058cTyNgFsAnHsTA526pzwWup4NYlOzM9Gy3PDk1saDRcnh7UHOcSeWlR1OKm
 m1zgHx2nux7lgniabjJ1YSg7ij/H3sXucZr11ML95/e81NwjPglpF6IQJ
X-Google-Smtp-Source: AGHT+IGkd576SG3pbyCDzfw/V2/d31Bp1L1f/9OLaS8f/aprVg2gprPUvMl2TY7PPNa8CUtVQkhz7A==
X-Received: by 2002:a17:903:230b:b0:22f:b6cc:421e with SMTP id
 d9443c01a7336-231d452683fmr162141075ad.26.1747627784344; 
 Sun, 18 May 2025 21:09:44 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 49/56] hw/riscv/virt.c: remove trivial virt_memmap references
Date: Mon, 19 May 2025 14:05:46 +1000
Message-ID: <20250519040555.3797167-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We should use s->memmap instead of virt_memmap to be able to use an
updated memmap when we start versioning the board.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429125811.224803-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0200679240..843665a5bd 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -166,8 +166,8 @@ static void virt_flash_map1(PFlashCFI01 *flash,
 static void virt_flash_map(RISCVVirtState *s,
                            MemoryRegion *sysmem)
 {
-    hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
-    hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
+    hwaddr flashsize = s->memmap[VIRT_FLASH].size / 2;
+    hwaddr flashbase = s->memmap[VIRT_FLASH].base;
 
     virt_flash_map1(s->flash[0], flashbase, flashsize,
                     sysmem);
@@ -999,8 +999,8 @@ static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
 static void create_fdt_flash(RISCVVirtState *s, const MemMapEntry *memmap)
 {
     MachineState *ms = MACHINE(s);
-    hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
-    hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
+    hwaddr flashsize = s->memmap[VIRT_FLASH].size / 2;
+    hwaddr flashbase = s->memmap[VIRT_FLASH].base;
     g_autofree char *name = g_strdup_printf("/flash@%" PRIx64, flashbase);
 
     qemu_fdt_add_subnode(ms->fdt, name);
@@ -1035,7 +1035,7 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
     g_autofree char *pci_node = NULL;
 
     pci_node = g_strdup_printf("/soc/pci@%lx",
-                               (long) virt_memmap[VIRT_PCIE_ECAM].base);
+                               (long) s->memmap[VIRT_PCIE_ECAM].base);
     iommu_node = g_strdup_printf("%s/virtio_iommu@%x,%x", pci_node,
                                  PCI_SLOT(bdf), PCI_FUNC(bdf));
     iommu_phandle = qemu_fdt_alloc_phandle(fdt);
@@ -1104,7 +1104,7 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     g_autofree char *pci_node = NULL;
 
     pci_node = g_strdup_printf("/soc/pci@%lx",
-                               (long) virt_memmap[VIRT_PCIE_ECAM].base);
+                               (long) s->memmap[VIRT_PCIE_ECAM].base);
     iommu_node = g_strdup_printf("%s/iommu@%x", pci_node, bdf);
     iommu_phandle = qemu_fdt_alloc_phandle(fdt);
     qemu_fdt_add_subnode(fdt, iommu_node);
@@ -1126,24 +1126,24 @@ static void finalize_fdt(RISCVVirtState *s)
     uint32_t irq_pcie_phandle = 1, irq_virtio_phandle = 1;
     uint32_t iommu_sys_phandle = 1;
 
-    create_fdt_sockets(s, virt_memmap, &phandle, &irq_mmio_phandle,
+    create_fdt_sockets(s, s->memmap, &phandle, &irq_mmio_phandle,
                        &irq_pcie_phandle, &irq_virtio_phandle,
                        &msi_pcie_phandle);
 
-    create_fdt_virtio(s, virt_memmap, irq_virtio_phandle);
+    create_fdt_virtio(s, s->memmap, irq_virtio_phandle);
 
     if (virt_is_iommu_sys_enabled(s)) {
         create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
                              &iommu_sys_phandle);
     }
-    create_fdt_pcie(s, virt_memmap, irq_pcie_phandle, msi_pcie_phandle,
+    create_fdt_pcie(s, s->memmap, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
 
-    create_fdt_reset(s, virt_memmap, &phandle);
+    create_fdt_reset(s, s->memmap, &phandle);
 
-    create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
+    create_fdt_uart(s, s->memmap, irq_mmio_phandle);
 
-    create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
+    create_fdt_rtc(s, s->memmap, irq_mmio_phandle);
 }
 
 static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
@@ -1361,14 +1361,13 @@ static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
 {
     DeviceState *dev;
     SysBusDevice *sysbus;
-    const MemMapEntry *memmap = virt_memmap;
     int i;
     MemoryRegion *sysmem = get_system_memory();
 
     dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
     dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
     qdev_prop_set_uint32(dev, "num_irqs", VIRT_PLATFORM_BUS_NUM_IRQS);
-    qdev_prop_set_uint32(dev, "mmio_size", memmap[VIRT_PLATFORM_BUS].size);
+    qdev_prop_set_uint32(dev, "mmio_size", s->memmap[VIRT_PLATFORM_BUS].size);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     s->platform_bus_dev = dev;
 
@@ -1379,7 +1378,7 @@ static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
     }
 
     memory_region_add_subregion(sysmem,
-                                memmap[VIRT_PLATFORM_BUS].base,
+                                s->memmap[VIRT_PLATFORM_BUS].base,
                                 sysbus_mmio_get_region(sysbus, 0));
 }
 
-- 
2.49.0


