Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0730CC25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 17:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sACRb-00018e-6H; Thu, 23 May 2024 13:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sACQk-0000f0-Gq
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:40:49 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sACQe-0001Y6-6r
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:40:39 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1edc696df2bso23511755ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 10:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716486031; x=1717090831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGPfl8RQwJB4ac+Jn3/uPBXou7Ar56dUVK2HpypxcRk=;
 b=WPHpe2x7ha1BTVF3QdymH6LbKopmJsxpx1fm2WN2I8uxy6Or8ZqIGspnaw8aPt1kj8
 +VHUa/By4WUPBh9HrUEIDJaiIB3wQr8J1Taq6zZSAoe902JmK3wDf6EkajpsWCoZyzxf
 KdL6qMDdii4qoKEfoP8HPdFt2NxZxqxdNZ0AxSw6jHMRacFh4BajbNj6rVeMFC4qsISl
 BsV7j0hjj0IhWwYWh5qaIlkNOgGcn2zeoTehV+uJFsF3BM1+QjHlfDJHaJsCoAw//w4H
 11d/0weCz5mQNIomavKIKKLXC9BwvS4TbxTIADpxXu9bGV8muoLP9EGsTxK7qgcZmx0E
 LsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716486031; x=1717090831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aGPfl8RQwJB4ac+Jn3/uPBXou7Ar56dUVK2HpypxcRk=;
 b=XhtGutA+l+wtVqbKm9n4PKOoai2SLm9Kxtq4kKvmqueK2tEPSJps4KZ/pirEbYRP5M
 F/w++9shLzYCFM3CftkylymMBov9/l842Fqi5RG1xoX/20eG6yiA1SjX5PN2xW2s+KRo
 VSzC7tTL+S6sYCnut2iwdHSiFQG7UGmQ/lJczXSKqS6Fd6/q0XYDjyEiun3zRCwPfdMS
 TcWH8OgzRNWCibDhX/2Ct5iFqvctqY2U3GyENj1QKVgLnEmXhQdIOarGrMUdsPjA6O1h
 aSAolsrF2ccr7YLnIA1ZOmPZCQmoYHHYk5tLylIZSe1C6BneBX8HXz6jShWb1DNWqYzc
 u/BQ==
X-Gm-Message-State: AOJu0YzOeowdA5o4wp4WKVQVaC5ufX+k9dipSPSbwAlJM3Sq1gfHC2Ke
 u2StJTsr610KscGMDe8hwinCIxb1092Gg7Yl4Btf9Kh+gzf8/q2h0d6XCDqFxbo+mXn8O5IZFFa
 7
X-Google-Smtp-Source: AGHT+IGwv7KuW///6l26wWQT54po8ULYGfD4stQ/tM9YVFaT7sq9Q6N7UdxA2rYGku4pUlcX5exPAg==
X-Received: by 2002:a17:902:6546:b0:1f3:240:2553 with SMTP id
 d9443c01a7336-1f4486b5e75mr166025ad.4.1716486031166; 
 Thu, 23 May 2024 10:40:31 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2fb4ca0ebsm81246535ad.119.2024.05.23.10.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:40:30 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 tjeznach@rivosinc.com, ajones@ventanamicro.com, frank.chang@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 06/13] hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice
 hotplug
Date: Thu, 23 May 2024 14:39:47 -0300
Message-ID: <20240523173955.1940072-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
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
---
 hw/riscv/virt.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4fdb660525..b6ebbb3baf 100644
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
@@ -1006,6 +1007,30 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
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
@@ -1712,9 +1737,11 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
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
 
@@ -1735,6 +1762,10 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
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
2.44.0


