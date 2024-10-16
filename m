Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0B4D206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 20:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Apd-0004QW-K1; Wed, 16 Oct 2024 16:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t1ApX-0004Jg-2g
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 16:41:15 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t1ApR-0004en-E4
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 16:41:13 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e2e87153a3so166171a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 13:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1729111266; x=1729716066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g1YycUQAt9UKb42nF+Mgs9YCS8HN+Vx/bp8kGjNxWNk=;
 b=iUoLvTQoCQ9wevGct+RM7jhMUMXYdtTYLP/oBWSS+wkwFMaJsVB8toHSEwQNghBl1i
 XqNiJvJh6Xs7d2FWHkmIz7MIJHaoNANyEbSKXlnQ4CutYCkQ8ti7NqoNrBqhciaF+oRt
 /S3U/MUzD9djvDQo4p7eTAlYSHiKIDan7IZiUqu3WPub1/UPo1Pm1RKtk9DB9IlM7Obm
 wAHuwWC4rUjCybVwgUg171LiF/au0ZvtveuT4YaGGUzSeIczWzHHn/pGcCzIbpckDo4v
 q5nYxtyIWHbUsUisS+rQo84uxFxexx260vQ294YzqPfMHYVSyGroNz7CayXT2Q58sBM/
 74NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729111266; x=1729716066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g1YycUQAt9UKb42nF+Mgs9YCS8HN+Vx/bp8kGjNxWNk=;
 b=nYCNGS++MkOebU0BqmYX8DsJRy9XOja6YUCfXaABeaX4558uuaaT+cbitHMVnMENO+
 HPBTmfHxYVo29i1cYCAlLhDQhs8yK+Dm0aK/hlVGq0H6lS/+aFYT5jtKIWkwvsgcffHE
 2Zkkif4xk1ymsPPNKJKvpZYDHUNwQ3Hc1mvdGIkbMDXT4idKsy7xxJlzH79FfkLGwTVx
 ybmSL6Ncjph9f/wJH/lwPHKozgasEmL50AAKum3Okgka0tnbyTW17ZYYIwGw101yZlqS
 Pc5daOvXSGKkfRpdcNYAXCf9uRykjq/9yXwby2XsC0HH4PFpyIc8nUjKqZVA4/Hja277
 QbUQ==
X-Gm-Message-State: AOJu0Yzuva40/UOPjknh2bOr2Qi01j3dVO1lHs08KGscfjUH6XXq4uEd
 ujSldP0Sw6sUiL6gutxDNojKt4/wT+0ZzcOe10jXATxAw2gfQM5OmYLIbzyfxg1PxPqXysFk3MH
 t
X-Google-Smtp-Source: AGHT+IH/JsnoakR7TA77xoIO19rWwOTV2YkV994wCPnlUvBd2Q4JD3vnCi5UiizVoEwoDX6J+UFKcQ==
X-Received: by 2002:a17:90a:987:b0:2e2:b719:d581 with SMTP id
 98e67ed59e1d1-2e3152b00e9mr20245938a91.5.1729111265656; 
 Wed, 16 Oct 2024 13:41:05 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e3e09085cfsm242158a91.54.2024.10.16.13.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 13:41:05 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v10 06/12] hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice
 hotplug
Date: Wed, 16 Oct 2024 17:40:30 -0300
Message-ID: <20241016204038.649340-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016204038.649340-1-dbarboza@ventanamicro.com>
References: <20241016204038.649340-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1035.google.com
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

Generate device tree entry for riscv-iommu PCI device, along with
mapping all PCI device identifiers to the single IOMMU device instance.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ee3129f3b3..45a8c4f819 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -32,6 +32,7 @@
 #include "hw/core/sysbus-fdt.h"
 #include "target/riscv/pmu.h"
 #include "hw/riscv/riscv_hart.h"
+#include "hw/riscv/iommu.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
@@ -1032,6 +1033,30 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
                            bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
 }
 
+static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
+{
+    const char comp[] = "riscv,pci-iommu";
+    void *fdt = MACHINE(s)->fdt;
+    uint32_t iommu_phandle;
+    g_autofree char *iommu_node = NULL;
+    g_autofree char *pci_node = NULL;
+
+    pci_node = g_strdup_printf("/soc/pci@%lx",
+                               (long) virt_memmap[VIRT_PCIE_ECAM].base);
+    iommu_node = g_strdup_printf("%s/iommu@%x", pci_node, bdf);
+    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
+    qemu_fdt_add_subnode(fdt, iommu_node);
+
+    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
+    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
+    qemu_fdt_setprop_cells(fdt, iommu_node, "reg",
+                           bdf << 8, 0, 0, 0, 0);
+    qemu_fdt_setprop_cells(fdt, pci_node, "iommu-map",
+                           0, iommu_phandle, 0, bdf,
+                           bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
+}
+
 static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -1738,9 +1763,11 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     if (device_is_dynamic_sysbus(mc, dev) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_RISCV_IOMMU_PCI)) {
         return HOTPLUG_HANDLER(machine);
     }
+
     return NULL;
 }
 
@@ -1761,6 +1788,10 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         create_fdt_virtio_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
     }
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_IOMMU_PCI)) {
+        create_fdt_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
+    }
 }
 
 static void virt_machine_class_init(ObjectClass *oc, void *data)
-- 
2.45.2


