Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9099FCF884E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swkgr-0007P3-1S; Fri, 04 Oct 2024 11:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swkgi-0007M7-Ml
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 11:57:53 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swkgh-0000qR-4S
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 11:57:52 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20b84bfbdfcso22831805ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728057469; x=1728662269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MgZWh8RRqxn5Vr0pJth1pB16p4UHTGHLVd+FFPOcE0=;
 b=Ta3ygV+QyGEpSY9rzrSOyuP7doepkBH8ryETTBW1CEnZDZvy6LNeJWig6Vw3G2/VI/
 3GH//7ciCZJA81dTOGQrhL+1bGPu+kWBULinGZQWzOIL/NzbDkSTkES+UBSBlnGYKK8A
 zJf/P5FE3H0fET1SQlmMcR2sjGDPsoMCarXZCHz7EyZbef/Co9Q57k7ZsBDsJIk6fNbJ
 Xa50H/9g4aVrZ1+Sk7u3+PAx64FZaAx62AzfXnJvPz32PJgKYtuyg5OyUG6ioyNy3ZJG
 d+JBsKSq7KwhJ5w58dzuQJdiMECtlSKiM+JPVcWjtVAc7lzuT4vFgE4hnNAtiM95NIjm
 BuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728057469; x=1728662269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9MgZWh8RRqxn5Vr0pJth1pB16p4UHTGHLVd+FFPOcE0=;
 b=bJ7XkYVt36NRENzrHYJZuerUx0GME79Ud7TzGqMJ4mSkCduNQNmC7wa59+f/Bz15dq
 DPYMZmwWpG95i9JI5MMcpZa0fLgEFLQDjzhev31EPlcO7xg+euKghuj1a2/AQ8gHV2la
 rUGEYPKzGNKOHAVt+pGTcSJGwsAAdfa9W03pg+8ocl0WhEAKfLa2wjmzKZNg6vJP5ELp
 QgTH9p8JL1//ygTY4ACZd1sLXgr3qOVHOcsolPWB1fjKXxPykdH755MSZWKaLbURKhRJ
 c8AwpYng4q5tm7CDdX6kH2rTRlUa07P8yXIKJPsjTssSVnaQCglysBmv0bp1UDsrsezj
 9yxQ==
X-Gm-Message-State: AOJu0YzpRM1EYM8ZxLo+KiHF/N/kwg6Ey+LrMDLPs72yKKYQQFrz1QDW
 XJqXlwfKVikSJu8D+XdcmmIyFndvSv/lyhT6RWEBac3Tt4Z0IQZjeX6p9FfAGdf9R/3fL1OW9GH
 f
X-Google-Smtp-Source: AGHT+IEQuB2qiWTYGTZ90y0B1AvLGUH3azJGzbhuHqSopJnlQT+eeIFEZAOnbOhuLmjStjXS70QYww==
X-Received: by 2002:a17:902:e94e:b0:20b:831f:e905 with SMTP id
 d9443c01a7336-20bff497da0mr51865095ad.12.1728057469438; 
 Fri, 04 Oct 2024 08:57:49 -0700 (PDT)
Received: from grind.. (200-206-229-93.dsl.telesp.net.br. [200.206.229.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c139306cfsm107635ad.170.2024.10.04.08.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 08:57:49 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v9 06/12] hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice
 hotplug
Date: Fri,  4 Oct 2024 12:57:13 -0300
Message-ID: <20241004155721.2154626-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004155721.2154626-1-dbarboza@ventanamicro.com>
References: <20241004155721.2154626-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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
index 3c0dca86f1..1d32b4b0f3 100644
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


