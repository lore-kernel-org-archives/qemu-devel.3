Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651D8E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSEa-0006B4-NQ; Thu, 19 Dec 2024 20:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEY-0006AY-Gs
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:18 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEW-0004Ph-Mn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:18 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-725ed193c9eso1283409b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659715; x=1735264515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=enBDjegY8V+VdOlXQaQjxZZeMo94AMYKDHgxhL4QJc0=;
 b=CuZc3fns2zu+FzNKna9UR+sDRfP99oyeoZPbS1wnOfKE3+60bXQEnAsTIZOlc6SgKQ
 q+oiqxhA0pRfa24YkQyyR3WGf9QRsLjEg8e1jyZKxzJ+764HFidBBuIGE13IfZuKDIyD
 i/gIq3lWspCE5+cCghUoBnWAHz3yP67Qj3KU2LLf47YJKcH7wXlQ0CCpWJmUEnnBZN/x
 MzXnprSJjVgZnVpWuaQIcd5qm5o5mEtDNcIAR7qAdTBMcyccUdziXmZJQgpBikJZG0Tk
 DLMzjFAP7MJH8woNrbkCaq1lNYv9r52sFL0RwWNnLdwR8brTopX+okCd0FFE4s56WzjI
 I0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659715; x=1735264515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=enBDjegY8V+VdOlXQaQjxZZeMo94AMYKDHgxhL4QJc0=;
 b=UZObrOz0MgpyzW85UE3qcv20v/9IzdFsrEgGgYcw6ROirJECHPYe1ZzP7+0HE02CqW
 kNjBJ5kbceK8tvuP8VdIIgYkNnCe7gFMy8N7ftznUkS7l/wJjDUxt2ZYOohSaAAcRhOb
 zl74vSQTj0EoLflXqFctQwj3Qr2cU4Fa8BikSxBH4uIMzI74/CoA+yVGIHaDfCuwlbJB
 sfVy5W8h6kJUFYsbkPv1kDOmmKoLzv+JSnQKG780E1vJ8SyuDt0Dd59yDr2IlEgb0hc9
 Rll56azPv8HkTbJGjUy3ddGou3ZIef6kzBxPgq6ogIxhfbhHRfOnGfHCS1Jl2wvdXmBc
 Wd+A==
X-Gm-Message-State: AOJu0YwzcFWk709thjHTO1Ni562ErtQ6EXyyOGazK5czIsqLuQXIeGL3
 pFCruKEEPPhFj5gAlJ64RZiqI4Oz7CwqojdTDNPxYF6+O/Dtvz+8e00om/TI
X-Gm-Gg: ASbGncuYiuBu98lYNMmDCWB7b/fv9mCV7qaKCtvYhdsA3+OuIUDpCQTHdUwD24VF1ee
 Csqo8faz72Sif975u4gXojAnrBnuUUxRFdduFrQVVOBtShdCU+DwbFuqlqeOsVmIzWNetR7+JMx
 qO/7rZUsRj0cqb+wQ6WZi8QhyzSXt2ogC7csJMxuXnnIiRMeBJHGieMG7Z2pFav7ytS3KaPza9k
 JmHXpRXmEY8hO+45CkWFByJMZHLhb386UHSI3A//tj9WDRM4mUWYKojOHORqmASyiBImLIqFnuB
 tFzjAnFFbCZs8UmjKzsPkmCVp/fHJt5HOFhHeQ8CTxgJBQRaZiDlgJRsAdeDjzg=
X-Google-Smtp-Source: AGHT+IFhTYgKy+PLF6Z06wEs3/et3ZwsJVQlrx+KVvMs/yBdktRWlRkIBbar4NMGjIaTQno09HTnIA==
X-Received: by 2002:a05:6a00:35c3:b0:725:a78c:6c31 with SMTP id
 d2e1a72fcca58-72abdd3c168mr1424501b3a.3.1734659714909; 
 Thu, 19 Dec 2024 17:55:14 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:14 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 07/39] hw/riscv/virt.c, riscv-iommu-sys.c: add MSIx support
Date: Fri, 20 Dec 2024 11:54:07 +1000
Message-ID: <20241220015441.317236-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
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

MSIx support is added in the RISC-V IOMMU platform device by including
the required MSIx facilities to alow software to properly setup the MSIx
subsystem.

We took inspiration of what is being done in the riscv-iommu-pci device,
mainly msix_init() and msix_notify(), while keeping in mind that
riscv-iommu-sys isn't a true PCI device and we don't need to copy/paste
all the contents of these MSIx functions.

Two extra MSI MemoryRegions were added: 'msix-table' and 'msix-pba'.
They are used to manage r/w of the MSI table and Pending Bit Array (PBA)
respectively. Both are subregions of the main IOMMU memory region,
iommu->regs_mr, initialized during riscv_iommu_realize(), and each one
has their own handlers for MSIx reads and writes.

This is the expected memory map when using this device in the 'virt'
machine:

    0000000003010000-0000000003010fff (prio 0, i/o): riscv-iommu-regs
      0000000003010300-000000000301034f (prio 0, i/o): msix-table
      0000000003010400-0000000003010407 (prio 0, i/o): msix-pba

We're now able to set IGS to RISCV_IOMMU_CAP_IGS_BOTH, and userspace is
free to decide which interrupt model to use.

Enabling MSIx support for this device in the 'virt' machine requires
adding 'msi-parent' in the iommu-sys DT.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241106133407.604587-6-dbarboza@ventanamicro.com>
[ Changes by AF:
 - Used PRIx64 in trace
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-sys.c | 116 +++++++++++++++++++++++++++++++++++--
 hw/riscv/virt.c            |   6 +-
 hw/riscv/trace-events      |   2 +
 3 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index 4b82046ce9..a0ef67a20b 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -26,11 +26,15 @@
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "qom/object.h"
+#include "exec/exec-all.h"
+#include "trace.h"
 
 #include "riscv-iommu.h"
 
 #define RISCV_IOMMU_SYSDEV_ICVEC_VECTORS 0x3333
 
+#define RISCV_IOMMU_PCI_MSIX_VECTORS 5
+
 /* RISC-V IOMMU System Platform Device Emulation */
 
 struct RISCVIOMMUStateSys {
@@ -39,21 +43,123 @@ struct RISCVIOMMUStateSys {
     uint32_t         base_irq;
     DeviceState      *irqchip;
     RISCVIOMMUState  iommu;
+
+    /* Wired int support */
     qemu_irq         irqs[RISCV_IOMMU_INTR_COUNT];
+
+    /* Memory Regions for MSIX table and pending bit entries. */
+    MemoryRegion msix_table_mmio;
+    MemoryRegion msix_pba_mmio;
+    uint8_t *msix_table;
+    uint8_t *msix_pba;
+};
+
+static uint64_t msix_table_mmio_read(void *opaque, hwaddr addr,
+                                     unsigned size)
+{
+    RISCVIOMMUStateSys *s = opaque;
+
+    g_assert(addr + size <= RISCV_IOMMU_PCI_MSIX_VECTORS * PCI_MSIX_ENTRY_SIZE);
+    return pci_get_long(s->msix_table + addr);
+}
+
+static void msix_table_mmio_write(void *opaque, hwaddr addr,
+                                  uint64_t val, unsigned size)
+{
+    RISCVIOMMUStateSys *s = opaque;
+
+    g_assert(addr + size <= RISCV_IOMMU_PCI_MSIX_VECTORS * PCI_MSIX_ENTRY_SIZE);
+    pci_set_long(s->msix_table + addr, val);
+}
+
+static const MemoryRegionOps msix_table_mmio_ops = {
+    .read = msix_table_mmio_read,
+    .write = msix_table_mmio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .max_access_size = 4,
+    },
+};
+
+static uint64_t msix_pba_mmio_read(void *opaque, hwaddr addr,
+                                   unsigned size)
+{
+    RISCVIOMMUStateSys *s = opaque;
+
+    return pci_get_long(s->msix_pba + addr);
+}
+
+static void msix_pba_mmio_write(void *opaque, hwaddr addr,
+                                uint64_t val, unsigned size)
+{
+}
+
+static const MemoryRegionOps msix_pba_mmio_ops = {
+    .read = msix_pba_mmio_read,
+    .write = msix_pba_mmio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .max_access_size = 4,
+    },
 };
 
+static void riscv_iommu_sysdev_init_msi(RISCVIOMMUStateSys *s,
+                                        uint32_t n_vectors)
+{
+    RISCVIOMMUState *iommu = &s->iommu;
+    uint32_t table_size = table_size = n_vectors * PCI_MSIX_ENTRY_SIZE;
+    uint32_t table_offset = RISCV_IOMMU_REG_MSI_CONFIG;
+    uint32_t pba_size = QEMU_ALIGN_UP(n_vectors, 64) / 8;
+    uint32_t pba_offset = RISCV_IOMMU_REG_MSI_CONFIG + 256;
+
+    s->msix_table = g_malloc0(table_size);
+    s->msix_pba = g_malloc0(pba_size);
+
+    memory_region_init_io(&s->msix_table_mmio, OBJECT(s), &msix_table_mmio_ops,
+                          s, "msix-table", table_size);
+    memory_region_add_subregion(&iommu->regs_mr, table_offset,
+                                &s->msix_table_mmio);
+
+    memory_region_init_io(&s->msix_pba_mmio, OBJECT(s), &msix_pba_mmio_ops, s,
+                          "msix-pba", pba_size);
+    memory_region_add_subregion(&iommu->regs_mr, pba_offset,
+                                &s->msix_pba_mmio);
+}
+
+static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
+                                        uint32_t vector)
+{
+    uint8_t *table_entry = s->msix_table + vector * PCI_MSIX_ENTRY_SIZE;
+    uint64_t msi_addr = pci_get_quad(table_entry + PCI_MSIX_ENTRY_LOWER_ADDR);
+    uint32_t msi_data = pci_get_long(table_entry + PCI_MSIX_ENTRY_DATA);
+    MemTxResult result;
+
+    address_space_stl_le(&address_space_memory, msi_addr,
+                         msi_data, MEMTXATTRS_UNSPECIFIED, &result);
+    trace_riscv_iommu_sys_msi_sent(vector, msi_addr, msi_data, result);
+}
+
 static void riscv_iommu_sysdev_notify(RISCVIOMMUState *iommu,
                                       unsigned vector)
 {
     RISCVIOMMUStateSys *s = container_of(iommu, RISCVIOMMUStateSys, iommu);
     uint32_t fctl =  riscv_iommu_reg_get32(iommu, RISCV_IOMMU_REG_FCTL);
 
-    /* We do not support MSIs yet */
-    if (!(fctl & RISCV_IOMMU_FCTL_WSI)) {
+    if (fctl & RISCV_IOMMU_FCTL_WSI) {
+        qemu_irq_pulse(s->irqs[vector]);
+        trace_riscv_iommu_sys_irq_sent(vector);
         return;
     }
 
-    qemu_irq_pulse(s->irqs[vector]);
+    riscv_iommu_sysdev_send_MSI(s, vector);
 }
 
 static void riscv_iommu_sys_realize(DeviceState *dev, Error **errp)
@@ -82,6 +188,8 @@ static void riscv_iommu_sys_realize(DeviceState *dev, Error **errp)
         irq = qdev_get_gpio_in(s->irqchip, s->base_irq + i);
         sysbus_connect_irq(sysdev, i, irq);
     }
+
+    riscv_iommu_sysdev_init_msi(s, RISCV_IOMMU_PCI_MSIX_VECTORS);
 }
 
 static void riscv_iommu_sys_init(Object *obj)
@@ -93,7 +201,7 @@ static void riscv_iommu_sys_init(Object *obj)
     qdev_alias_all_properties(DEVICE(iommu), obj);
 
     iommu->icvec_avail_vectors = RISCV_IOMMU_SYSDEV_ICVEC_VECTORS;
-    riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_WSI);
+    riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_BOTH);
 }
 
 static Property riscv_iommu_sys_properties[] = {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c5ada635f1..5d058511be 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1043,6 +1043,7 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
 }
 
 static void create_fdt_iommu_sys(RISCVVirtState *s, uint32_t irq_chip,
+                                 uint32_t msi_phandle,
                                  uint32_t *iommu_sys_phandle)
 {
     const char comp[] = "riscv,iommu";
@@ -1077,6 +1078,8 @@ static void create_fdt_iommu_sys(RISCVVirtState *s, uint32_t irq_chip,
         iommu_irq_map[2], FDT_IRQ_TYPE_EDGE_LOW,
         iommu_irq_map[3], FDT_IRQ_TYPE_EDGE_LOW);
 
+    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
+
     *iommu_sys_phandle = iommu_phandle;
 }
 
@@ -1117,7 +1120,8 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_virtio(s, virt_memmap, irq_virtio_phandle);
 
     if (virt_is_iommu_sys_enabled(s)) {
-        create_fdt_iommu_sys(s, irq_mmio_phandle, &iommu_sys_phandle);
+        create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
+                             &iommu_sys_phandle);
     }
     create_fdt_pcie(s, virt_memmap, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 0527c56c91..525fd5b730 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -15,3 +15,5 @@ riscv_iommu_icvec_write(uint32_t orig, uint32_t actual) "ICVEC write: incoming 0
 riscv_iommu_ats(const char *id, unsigned b, unsigned d, unsigned f, uint64_t iova) "%s: translate request %04x:%02x.%u iova: 0x%"PRIx64
 riscv_iommu_ats_inval(const char *id) "%s: dev-iotlb invalidate"
 riscv_iommu_ats_prgr(const char *id) "%s: dev-iotlb page request group response"
+riscv_iommu_sys_irq_sent(uint32_t vector) "IRQ sent to vector %u"
+riscv_iommu_sys_msi_sent(uint32_t vector, uint64_t msi_addr, uint32_t msi_data, uint32_t result) "MSI sent to vector %u msi_addr 0x%"PRIx64" msi_data 0x%x result %u"
-- 
2.47.1


