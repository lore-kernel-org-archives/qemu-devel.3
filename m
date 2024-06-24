Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2322FC30653
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 20:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLq9b-0004CN-TC; Mon, 24 Jun 2024 16:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sLq9a-0004Bv-Dt
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:19:06 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sLq9Y-0003es-DK
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:19:06 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70679845d69so1256861b3a.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719260343; x=1719865143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2T8IEiuSBYa9AMo9fm6dIa4irZ9moI/CdLoLt8G4WnI=;
 b=Juiy/2GKlg3TR3WC4YQohA5Qp3MpljYCjJ8UyYkOvU09+TXNDmKMqs48sljdTPjt3f
 4D9+Cat+Ny1K7XfvpKtHsFFsLxsg+83oZsXpF9sU0Utc2WsP3Kp5W2WIaduzDpQJdWF8
 xwtDaNaWxXjAwlQSpy/uE4JDjSLktQWesk5OLaMbrE70GC1BRap/cIJ4mt484sKjEY13
 kv/Ze3BJH1pAJzkw2tnfX5eBj60gc/o1A78rbgeUbE/MYCuxIyx0CHDQnQ2C10br0gD5
 YhRrkahPhJN9SjkGGsd1gtezryzGGy1REeMZLrLm6nK98LgigPzf2BPifGdUhQLO5NmX
 tU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719260343; x=1719865143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2T8IEiuSBYa9AMo9fm6dIa4irZ9moI/CdLoLt8G4WnI=;
 b=BJPeg1UpQha2QbbR8QHFczVvGAwlu9Tao4qBGNomuURkLhQhgTh+YauRiwQZOHY97k
 TIUVUb6EVxwe0yAM4Vn4jiZDnaE17wdIPesa7TLKT523reNsHuFPnm6jviRvWl6sUwEn
 cm0ikgYu3hIgXHNCr8q7LJKCYRRA9gCmIlSXGpVVOOcbU3wELpjqm8TsFB7yEjDa4Pej
 XPlu/vgc3f6XwojDA5+wDLBDQeXndptSSxWu1aUiQRxHVQKIA1jmF1SLtVBf9wx43tzY
 +HyE77oyCVmMXYEU2UDG5PkhnRU4LBNZ/pMQJtif1YY9AikGCupm1ogyDjK3TXSsu1c/
 jiwg==
X-Gm-Message-State: AOJu0Yx+gCu6/8YpNjZApjIVdR16RtpcRl99EE6Ar0QuR1wdBgqlpU21
 0AcezVB54fMm7NOZnTSKq3y/GvFpyhTdoqhyryHWwA1cYkOldZ59wRjrtA6T3mCT+iMVl2hutu8
 1
X-Google-Smtp-Source: AGHT+IEPiMfoVz75IzQoStMyqYrx+oXgfaeiZ+0F+6F+264ufLjeXo93LGnvXBoztT10IB9VAcsiuQ==
X-Received: by 2002:a05:6a20:96d5:b0:1b6:98ba:8df5 with SMTP id
 adf61e73a8af0-1bcf7eadf83mr4490483637.21.1719260342745; 
 Mon, 24 Jun 2024 13:19:02 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70688f2d76bsm1927091b3a.41.2024.06.24.13.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 13:19:02 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com, frank.chang@sifive.com,
 jason.chien@sifive.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 05/14] hw/riscv: add riscv-iommu-pci reference device
Date: Mon, 24 Jun 2024 17:18:15 -0300
Message-ID: <20240624201825.1054980-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
References: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

The RISC-V IOMMU can be modelled as a PCIe device following the
guidelines of the RISC-V IOMMU spec, chapter 7.1, "Integrating an IOMMU
as a PCIe device".

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/riscv/meson.build       |   2 +-
 hw/riscv/riscv-iommu-pci.c | 178 +++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 hw/riscv/riscv-iommu-pci.c

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index cbc99c6e8e..adbef8a9b2 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -10,6 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
 riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
 riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c', 'riscv-iommu-pci.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
new file mode 100644
index 0000000000..7b82ce0645
--- /dev/null
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -0,0 +1,178 @@
+/*
+ * QEMU emulation of an RISC-V IOMMU
+ *
+ * Copyright (C) 2022-2023 Rivos Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/qdev-properties.h"
+#include "hw/riscv/riscv_hart.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/host-utils.h"
+#include "qom/object.h"
+
+#include "cpu_bits.h"
+#include "riscv-iommu.h"
+#include "riscv-iommu-bits.h"
+
+/* RISC-V IOMMU PCI Device Emulation */
+#define RISCV_PCI_CLASS_SYSTEM_IOMMU     0x0806
+
+typedef struct RISCVIOMMUStatePci {
+    PCIDevice        pci;     /* Parent PCIe device state */
+    uint16_t         vendor_id;
+    uint16_t         device_id;
+    uint8_t          revision;
+    MemoryRegion     bar0;    /* PCI BAR (including MSI-x config) */
+    RISCVIOMMUState  iommu;   /* common IOMMU state */
+} RISCVIOMMUStatePci;
+
+/* interrupt delivery callback */
+static void riscv_iommu_pci_notify(RISCVIOMMUState *iommu, unsigned vector)
+{
+    RISCVIOMMUStatePci *s = container_of(iommu, RISCVIOMMUStatePci, iommu);
+
+    if (msix_enabled(&(s->pci))) {
+        msix_notify(&(s->pci), vector);
+    }
+}
+
+static void riscv_iommu_pci_realize(PCIDevice *dev, Error **errp)
+{
+    RISCVIOMMUStatePci *s = DO_UPCAST(RISCVIOMMUStatePci, pci, dev);
+    RISCVIOMMUState *iommu = &s->iommu;
+    uint8_t *pci_conf = dev->config;
+    Error *err = NULL;
+
+    pci_set_word(pci_conf + PCI_VENDOR_ID, s->vendor_id);
+    pci_set_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID, s->vendor_id);
+    pci_set_word(pci_conf + PCI_DEVICE_ID, s->device_id);
+    pci_set_word(pci_conf + PCI_SUBSYSTEM_ID, s->device_id);
+    pci_set_byte(pci_conf + PCI_REVISION_ID, s->revision);
+
+    /* Set device id for trace / debug */
+    DEVICE(iommu)->id = g_strdup_printf("%02x:%02x.%01x",
+        pci_dev_bus_num(dev), PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+    qdev_realize(DEVICE(iommu), NULL, errp);
+
+    memory_region_init(&s->bar0, OBJECT(s), "riscv-iommu-bar0",
+        QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr), TARGET_PAGE_SIZE));
+    memory_region_add_subregion(&s->bar0, 0, &iommu->regs_mr);
+
+    pcie_endpoint_cap_init(dev, 0);
+
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64, &s->bar0);
+
+    int ret = msix_init(dev, RISCV_IOMMU_INTR_COUNT,
+                        &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG,
+                        &s->bar0, 0, RISCV_IOMMU_REG_MSI_CONFIG + 256, 0, &err);
+
+    if (ret == -ENOTSUP) {
+        /*
+         * MSI-x is not supported by the platform.
+         * Driver should use timer/polling based notification handlers.
+         */
+        warn_report_err(err);
+    } else if (ret < 0) {
+        error_propagate(errp, err);
+        return;
+    } else {
+        /* mark all allocated MSIx vectors as used. */
+        msix_vector_use(dev, RISCV_IOMMU_INTR_CQ);
+        msix_vector_use(dev, RISCV_IOMMU_INTR_FQ);
+        msix_vector_use(dev, RISCV_IOMMU_INTR_PM);
+        msix_vector_use(dev, RISCV_IOMMU_INTR_PQ);
+        iommu->notify = riscv_iommu_pci_notify;
+    }
+
+    PCIBus *bus = pci_device_root_bus(dev);
+    if (!bus) {
+        error_setg(errp, "can't find PCIe root port for %02x:%02x.%x",
+            pci_bus_num(pci_get_bus(dev)), PCI_SLOT(dev->devfn),
+            PCI_FUNC(dev->devfn));
+        return;
+    }
+
+    riscv_iommu_pci_setup_iommu(iommu, bus, errp);
+}
+
+static void riscv_iommu_pci_exit(PCIDevice *pci_dev)
+{
+    pci_setup_iommu(pci_device_root_bus(pci_dev), NULL, NULL);
+}
+
+static const VMStateDescription riscv_iommu_vmstate = {
+    .name = "riscv-iommu",
+    .unmigratable = 1
+};
+
+static void riscv_iommu_pci_init(Object *obj)
+{
+    RISCVIOMMUStatePci *s = RISCV_IOMMU_PCI(obj);
+    RISCVIOMMUState *iommu = &s->iommu;
+
+    object_initialize_child(obj, "iommu", iommu, TYPE_RISCV_IOMMU);
+    qdev_alias_all_properties(DEVICE(iommu), obj);
+}
+
+static Property riscv_iommu_pci_properties[] = {
+    DEFINE_PROP_UINT16("vendor-id", RISCVIOMMUStatePci, vendor_id,
+                       PCI_VENDOR_ID_REDHAT),
+    DEFINE_PROP_UINT16("device-id", RISCVIOMMUStatePci, device_id,
+                       PCI_DEVICE_ID_REDHAT_RISCV_IOMMU),
+    DEFINE_PROP_UINT8("revision", RISCVIOMMUStatePci, revision, 0x01),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void riscv_iommu_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = riscv_iommu_pci_realize;
+    k->exit = riscv_iommu_pci_exit;
+    k->class_id = RISCV_PCI_CLASS_SYSTEM_IOMMU;
+    dc->desc = "RISCV-IOMMU DMA Remapping device";
+    dc->vmsd = &riscv_iommu_vmstate;
+    dc->hotpluggable = false;
+    dc->user_creatable = true;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, riscv_iommu_pci_properties);
+}
+
+static const TypeInfo riscv_iommu_pci = {
+    .name = TYPE_RISCV_IOMMU_PCI,
+    .parent = TYPE_PCI_DEVICE,
+    .class_init = riscv_iommu_pci_class_init,
+    .instance_init = riscv_iommu_pci_init,
+    .instance_size = sizeof(RISCVIOMMUStatePci),
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { },
+    },
+};
+
+static void riscv_iommu_register_pci_types(void)
+{
+    type_register_static(&riscv_iommu_pci);
+}
+
+type_init(riscv_iommu_register_pci_types);
-- 
2.45.2


