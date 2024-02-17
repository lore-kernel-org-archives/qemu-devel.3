Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2BDC48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 19:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbQKW-0001mn-Tc; Sat, 17 Feb 2024 14:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rbQKV-0001mO-Qv
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:26:31 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rbQKU-0004Qa-Ak
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:26:31 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d71cb97937so31954615ad.3
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 11:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708197988; x=1708802788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uz3CofM05BSE21m08IOk5vQLqDk13O/XdOJBk/QRHeo=;
 b=L/X4zXwTObTkcuYI9QVXWjzlW+OFiUZxC7MSPYvQPk780A042h+Csv1Lfr2u4PS+Ez
 QuVYsMUQZfF74p3cN3D33biPuB/reDQnxN2R+MftzYAO615YS5c7KYWcim8/rozXe2LN
 OVcqNTMfhoYWC0DP16PhrBfcUVitrfoUnjO/9buFPhK9tWXniHD7A/3f9ZdEn1VXVF2/
 gNVZePsgdZIRhDQNrM8WarZt4SyeIbiS1rpm0/u/nwTcmgH3dfmO/5++FqAUcMIEke/Y
 sw4J8b5FJuYqz05rpADIgPxUxZ9FSOXNMlGSshz2+2kjqfzCedzC/U94d54rLRpt28lZ
 VOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708197988; x=1708802788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uz3CofM05BSE21m08IOk5vQLqDk13O/XdOJBk/QRHeo=;
 b=iZcu72XI0O5aHyTmOlzcnd8b9gNN/szv8Hj6gWOX5l15/cBo5RdaXmtGLlbsaIwcPR
 Q8YPl6UUzedtX6toUjyN4+fCXlpfnJmtsyyvuL96hHp2dYkiJ6PU1uC2eHGFRm9fBk1h
 Q5aq8CM2CelT0r1xScdTmIsdbvBvOQxzFUmkvew+7T7ZKE6wuQaRDqglDjb7B+ReHXGq
 zQ9otrQuuuY2GJfQh5v4sO31K9S5GWyxkxGFddU6dhFgvWwHTdaYU72wbl4YMdKnG8PG
 FTpnFW67tWyekYP3XiwHz0juUYsmSthg8cY1FeI7tPME4cvBMvg6SfCWuUOIEQBr/U7s
 4MxQ==
X-Gm-Message-State: AOJu0YwB4/IXy9qCfB4QrDqFYNHX5hKFJbdK/0VGC2IImltG8IEkQvgA
 0+TgO8H8DCuHB7RALPNV1hoOs2Lt1tc+WUV/hfMkz/1PwTLUJl3JQYF7IbOXnpdwkID442ZZF/W
 D
X-Google-Smtp-Source: AGHT+IERfmhacNIJXbxXhGTimw6Ng50QduZO98lWsXsDEUw0Dt4jnF9GIjDod1rICY4bSxVA5h2TNw==
X-Received: by 2002:a17:902:b686:b0:1d9:8f6e:86e8 with SMTP id
 c6-20020a170902b68600b001d98f6e86e8mr7395064pls.69.1708197988009; 
 Sat, 17 Feb 2024 11:26:28 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 p3-20020a170902c70300b001db86c48221sm1770927plp.22.2024.02.17.11.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Feb 2024 11:26:27 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 4/6] hw/riscv/virt.c: add virtio-iommu-pci hotplug support
Date: Sat, 17 Feb 2024 16:26:05 -0300
Message-ID: <20240217192607.32565-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217192607.32565-1-dbarboza@ventanamicro.com>
References: <20240217192607.32565-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We want to add a RISC-V 'virt' libqos machine to increase our test
coverage. Some of the tests will try to plug a virtio-iommu-pci
device into the board and do some tests with it.

Enable virtio-iommu-pci in the 'virt' machine.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b540f4d3da..54ad809b44 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -53,6 +53,7 @@
 #include "hw/display/ramfb.h"
 #include "hw/acpi/aml-build.h"
 #include "qapi/qapi-visit-common.h"
+#include "hw/virtio/virtio-iommu.h"
 
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia(RISCVVirtState *s)
@@ -971,6 +972,34 @@ static void create_fdt_fw_cfg(RISCVVirtState *s, const MemMapEntry *memmap)
     qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
 }
 
+static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
+{
+    const char compat[] = "virtio,pci-iommu\0pci1af4,1057";
+    void *fdt = MACHINE(s)->fdt;
+    uint32_t iommu_phandle;
+    g_autofree char *iommu_node = NULL;
+    g_autofree char *pci_node = NULL;
+
+    pci_node = g_strdup_printf("/soc/pci@%lx",
+                               (long) virt_memmap[VIRT_PCIE_ECAM].base);
+    iommu_node = g_strdup_printf("%s/virtio_iommu@%x,%x", pci_node,
+                                 PCI_SLOT(bdf), PCI_FUNC(bdf));
+    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
+
+    qemu_fdt_add_subnode(fdt, iommu_node);
+
+    qemu_fdt_setprop(fdt, iommu_node, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg",
+                                 1, bdf << 8, 1, 0, 1, 0,
+                                 1, 0, 1, 0);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
+
+    qemu_fdt_setprop_cells(fdt, pci_node, "iommu-map",
+                           0, iommu_phandle, 0, bdf,
+                           bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
+}
+
 static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -1680,7 +1709,8 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
-    if (device_is_dynamic_sysbus(mc, dev)) {
+    if (device_is_dynamic_sysbus(mc, dev) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         return HOTPLUG_HANDLER(machine);
     }
     return NULL;
@@ -1699,6 +1729,10 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                      SYS_BUS_DEVICE(dev));
         }
     }
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
+        create_fdt_virtio_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
+    }
 }
 
 static void virt_machine_class_init(ObjectClass *oc, void *data)
-- 
2.43.2


