Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BC3C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XwX-0004Ri-FF; Wed, 23 Apr 2025 07:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7XwK-0004Md-S7
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:06:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7XwI-0000Kl-CK
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:06:52 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224341bbc1dso61328005ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745406406; x=1746011206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tdC7v5uuUdSxi8wuRBQWveWEhppmpKnHFvEmwM+p9Q=;
 b=BQevlMUP+CJ2y8rChtXaKmu9aFwuxCD9tFLSq42e9xpd2rLMPasxihMuvsgqg44hah
 TwNziAfMeCxsGRMPg+iOs79dpS4OOwK9R36A7+5ftLKXRPjgB5ImwJmAWNmOYMc4lsK9
 nv20ZdRhIz26t+hOJkCL+9QqSgxoB6TyToxu0ZhEIa+nWOQvG5MeIGWpPqmfrqoBcHMS
 /9yuXyYwcfhVvhWgmBprlaO1YaAC9ka5cD/00biFOKWpIyK+EBTsqft/Qp7tJqP7+e6r
 h9cbaqd13oiUyiZ99IX/m6PAj/SNhfxXPreZnLLNhvSlu8fQvF8WMjgR3cLfHNT9DVZv
 dOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745406406; x=1746011206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8tdC7v5uuUdSxi8wuRBQWveWEhppmpKnHFvEmwM+p9Q=;
 b=aGrOw6aB+UyLvo5rVFrtUjHL5OJuBsUxxmCV7dp8cDsJ8PIccMVF9EmsEPkbKm+u7b
 kICATyp3Jzqm2u8MGkiPI3JIATUB9g2mJYSP1iGegxBwyn+ThNZxSSbIQa187HQvV92z
 YGgNq4cnMWFZHFxCqdCMcI3YB82r5ZgXDcjK2PxzIjvd6Z4kD1UpggXbDbUPH6Rq0ztW
 UeECFLeodfdbqepydWBIuNFQ8eOlbimDNWsRr99rymfEhWUy2CnFFhV4tZIQmtADK+T6
 +wKGW8ac3ts3QBVJvi36kLkVHO3JgVXyNl+gtxZhAEkBwCZhchH06JQ0LqYnx6E7WKyy
 Nhzg==
X-Gm-Message-State: AOJu0YzqlURemZSq2Gd4FtnOHYTyj91Yuzy4o0B4clVgDxmiGBvZvOQI
 KRrLFj4TPL/tIQKsc/yAVqr3cHQOUXVO37qJQTd8BR0wuUpI1kto9UqDs4va4NHM6aq3R9LZGwz
 H
X-Gm-Gg: ASbGncss4vFYn8I4Pf5v4V6NsxZeoTQ4Dfmauj6LU+vOAlWhK8bRTiBbEQTOhWK1yxh
 lPLpvzXMB5aPbvK0BpRCNNNRYmK8WjK1wsZTGhvGE5eqvM/xnXo178NzGX40j/8AtvUB7bqsi5m
 PSdcXzBncMn677BIYx/UBotRhkWFCTzfpqhYPuni5tcunz99DymJ0iIpMA2ZRLn4F6xLlzRIDhT
 4EiiwhzkDuVCDGOzQZ8bQnk2AIVE/6l6Flz7r1nbbT7DsfBHItdcLZnx4TQQZH1/8zvL93ZAjLs
 SaJu08/rstSaLT75uRGHKkMNwLy4wiF6UQjC4mW+Dc9ZC8AWxH0sSocyzxPcLKU=
X-Google-Smtp-Source: AGHT+IHXAFYkzrfCLqWZxJlawdt9U10gOCPhzO1b2zwD1TDHOQnmMoMbETdw8C/g52b9vbAj08JIIQ==
X-Received: by 2002:a17:902:d4ce:b0:220:cd9f:a180 with SMTP id
 d9443c01a7336-22c53620f5dmr275122255ad.53.1745406406104; 
 Wed, 23 Apr 2025 04:06:46 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bcc0:89f4:3b90:a265:963d:8357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf3b1sm101509895ad.248.2025.04.23.04.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 04:06:45 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/9] hw/riscv/virt.c: remove trivial virt_memmap references
Date: Wed, 23 Apr 2025 08:06:23 -0300
Message-ID: <20250423110630.2249904-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We should use s->memmap instead of virt_memmap to be able to use an
updated memmap when we start versioning the board.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 6e3e34879f..fdf0318e15 100644
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
@@ -1366,14 +1366,13 @@ static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
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
 
@@ -1384,7 +1383,7 @@ static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
     }
 
     memory_region_add_subregion(sysmem,
-                                memmap[VIRT_PLATFORM_BUS].base,
+                                s->memmap[VIRT_PLATFORM_BUS].base,
                                 sysbus_mmio_get_region(sysbus, 0));
 }
 
-- 
2.49.0


