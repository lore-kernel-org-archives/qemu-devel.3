Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD4CC3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 17:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQsHE-0006IU-8U; Mon, 08 Jul 2024 13:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sQsH2-0005t3-MR
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 13:35:41 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sQsGy-00083q-B1
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 13:35:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f70c457823so17039705ad.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 10:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720460130; x=1721064930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bSV5rwJs1l/4AVT07lE41oPs9+do5UeVJi0VZ15LYnU=;
 b=ccQpdZjzk3nIFNtUi+amEGIASasBHzLZILKI7dWFbMctJHIGOPK8+PUJz1oFUHBJSO
 PiR9IbeXGhq8mQLpXXrYq3mUnfs2tksV1D0Au0v+yOVAKHjhG0KvyWkjFpCvM5ghX7db
 Xss2pB98+RJUNIIff8kdz/TRBJ5D168L20HXgO1ldAU73FCZ1d2XNkga9zr0XCzfdfn8
 vRsTdfjxpnDgQ+5j4qtU3V0QgAE/jI+wv9mwxVn9wjcmshyiRd6OOm6sGQGyIQABKQ09
 cjj5nOH2szh550NQR9Nx354Wo45pmX80+u3g9IIyBmq7fhqiUq36jcREqNA7Wc6jDd8A
 PR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720460130; x=1721064930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bSV5rwJs1l/4AVT07lE41oPs9+do5UeVJi0VZ15LYnU=;
 b=wyY8vdNwH+S5cG6shlNObESMAoYo7/X+xfFsKS3g5OcpOr1nr42+mDVLPw3ncfkxoi
 vKkZL9jS1UuVGOrFZUdJPcYUEKBgeuDH0DQREWC70B+Di3SauEBQRewL7yM9zivQnsdQ
 UwHeladKvkS54Rb2qXvzm2AE42vagQq3Hd5MYt7Z65PjzsLpQwVLqw0MTGZEopHRAnS2
 DGazTfn32envDY96Ft3szzX2gNPman1TkUBpE25/AlwqOfpXRHtQEq+c7SQczDgCLsNw
 +RxHYmM5Uk9pS0weL7u/xa4w/fnOE6+F5J11Swk1dDp5/AhdSgLEEt/pj40tiibNOdNB
 YNwg==
X-Gm-Message-State: AOJu0Yxt4o4aFNbd2oEwwwloG35T++zsvpwaXGWgf9e5ktKzlMiSEwub
 H/uHPFMyL3lPDyEzNOmZzsoCCvo64KGtw6lSCYKM1vlUegPr27erIM1ujHZ6V/wVSYNZuYXaxO6
 y
X-Google-Smtp-Source: AGHT+IFt8DUMlq0xIKksdvztxxnc6TxhAvPq7zjCwadjVGGB9lC7KpUTwFglYkBggMKbOqRL4/3F9g==
X-Received: by 2002:a17:902:ec8a:b0:1f9:c3e4:4c0f with SMTP id
 d9443c01a7336-1fbb6d2a53cmr2141845ad.34.1720460130126; 
 Mon, 08 Jul 2024 10:35:30 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ad3829sm1153765ad.299.2024.07.08.10.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 10:35:29 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 frank.chang@sifive.com, tjeznach@rivosinc.com, jason.chien@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 06/13] hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice
 hotplug
Date: Mon,  8 Jul 2024 14:34:53 -0300
Message-ID: <20240708173501.426225-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708173501.426225-1-dbarboza@ventanamicro.com>
References: <20240708173501.426225-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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
index bc0893e087..8da1f1c9e9 100644
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
@@ -1024,6 +1025,30 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
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
@@ -1730,9 +1755,11 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
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
 
@@ -1753,6 +1780,10 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
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


