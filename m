Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0F5C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Xwi-0004Xm-HX; Wed, 23 Apr 2025 07:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7XwZ-0004TP-OS
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:07:07 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u7XwX-0000O8-Bb
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:07:07 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-225df540edcso8929285ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745406423; x=1746011223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OdcOyewnTvJazzD+Fddzlx2JrIw4waD2caMO8u8vjDY=;
 b=QGeMq5mbY+RaBXrD3sMHWirA8ORe/8zV+HbyCSwBPJsK4KI63uUl21FW/5qAU9KrQB
 R+zXpgS0COG2zO431KpfJPb4077gVwO0aEcj+mjvUceqgqSaCKpBpmiPBq6i12XulGqP
 YcLD0NdXVkQDkaihL4Cnf69IGwvkePpjnlkswQLMry5DWQOfGrmVsveE7EMUazAn0MbL
 Me0RIzdd8PoZfekEjni1PrW9hxRoLttN/QRLCKqMymdRohUR+bv2rur1xYLEsdmQk5vR
 cCEY/UqBYer9wBpS7kcnr7zotqfRlVsX0hq1oOGEM4yoLB8/HrmzQCx9PbG2XyKySSA7
 so2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745406423; x=1746011223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OdcOyewnTvJazzD+Fddzlx2JrIw4waD2caMO8u8vjDY=;
 b=nvPwTf9o344JuQO5CUISSY2sDtHPQJCFbXebY9cT0zS2P29uRBHa4bQbKqqLmqPJeD
 81iFSDNFt65d8girG0nVSh6DuKh/KNT8zGMzl7hvgaITLLc75/qkVw0cAUBfEnnKCnzq
 4650IH0lM4qbaGUOUjGdD6BwM3wn11XofDbDaAw+ppysgpI+w2fwS8VZefryx85ndvJ4
 76hfzhPS86rqI+0VqbGYXopBI0x4DM5teJVFz4CNlC9VP9ZTpb2IAfjcFPyjPRle/Qoy
 Cdhx+T3BZhyoTxVIji5kQD6nKAHYYXA/g/kC6uco6YHwoiB4BokTs64JznPxz+d2XSMR
 R1dQ==
X-Gm-Message-State: AOJu0YzVGxl6y+aNHM6dvdI5aK3F1gHxytWUkD0hbPG6gsglARCpu5Kz
 hEIX8ip/Jah/9FzzLLYe4d9kwZ6Z59Nx+KbZOjnnBsX9gq4xeqS0BpdRMCZp30jh9gm+AvClquC
 p
X-Gm-Gg: ASbGnctSbShmwpIi3zv1XnSr6lPOKUoBiUQ0gyAgk8M6+WqQ9PKSfPQ+kNEXT14t9gK
 lKkjAvdfxhH0BJ0oNvNjkEpyeYdPV/fBkCBrcLqzpM0OhHXGDXlOKPuxDrm7UgWpfDEcbL7Gjy8
 LlCTqxogR0l+8KPxxzLGWJsXbArf3HeyhgWJbEoxuCI5EE+R6i9vNDBMTaqk1df770CYP7cjvXp
 Jo1NCApZwE8rii4TKuAYuI+iClFkPvK8vEe8s2nkrLS9jLBuzK4WI/bBC31zcz/nAn8Va6A41IB
 Ie1VrJBcubTjlosH9Ew5Oq3QNq48KA20CGukl3nRDxBPAhl9U/T3VZ+vXc9/Jw0=
X-Google-Smtp-Source: AGHT+IG6d6AZdrHlc/b587VHfbByT8/6ZAAM+B+qFaLNq7JW8WdHmqXE5Br4VX0x9mcEAbKmWTP0WQ==
X-Received: by 2002:a17:903:1aa8:b0:223:607c:1d99 with SMTP id
 d9443c01a7336-22da304bff3mr41374475ad.0.1745406422874; 
 Wed, 23 Apr 2025 04:07:02 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:bcc0:89f4:3b90:a265:963d:8357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf3b1sm101509895ad.248.2025.04.23.04.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 04:07:02 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 8/9] hw/riscv/virt.c: use s->memmap in finalize_fdt() functions
Date: Wed, 23 Apr 2025 08:06:29 -0300
Message-ID: <20250423110630.2249904-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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

Change create_fdt_pcie(), create_fdt_reset(), create_fdt_uart() and
create_fdt_rtc() to use s->memmap in their logic.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 07ee8e144f..036a0a9bfb 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -872,7 +872,7 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
     }
 }
 
-static void create_fdt_pcie(RISCVVirtState *s, const MemMapEntry *memmap,
+static void create_fdt_pcie(RISCVVirtState *s,
                             uint32_t irq_pcie_phandle,
                             uint32_t msi_pcie_phandle,
                             uint32_t iommu_sys_phandle)
@@ -881,7 +881,7 @@ static void create_fdt_pcie(RISCVVirtState *s, const MemMapEntry *memmap,
     MachineState *ms = MACHINE(s);
 
     name = g_strdup_printf("/soc/pci@%lx",
-        (long) memmap[VIRT_PCIE_ECAM].base);
+        (long) s->memmap[VIRT_PCIE_ECAM].base);
     qemu_fdt_setprop_cell(ms->fdt, name, "#address-cells",
         FDT_PCI_ADDR_CELLS);
     qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells",
@@ -892,19 +892,19 @@ static void create_fdt_pcie(RISCVVirtState *s, const MemMapEntry *memmap,
     qemu_fdt_setprop_string(ms->fdt, name, "device_type", "pci");
     qemu_fdt_setprop_cell(ms->fdt, name, "linux,pci-domain", 0);
     qemu_fdt_setprop_cells(ms->fdt, name, "bus-range", 0,
-        memmap[VIRT_PCIE_ECAM].size / PCIE_MMCFG_SIZE_MIN - 1);
+        s->memmap[VIRT_PCIE_ECAM].size / PCIE_MMCFG_SIZE_MIN - 1);
     qemu_fdt_setprop(ms->fdt, name, "dma-coherent", NULL, 0);
     if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
         qemu_fdt_setprop_cell(ms->fdt, name, "msi-parent", msi_pcie_phandle);
     }
     qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0,
-        memmap[VIRT_PCIE_ECAM].base, 0, memmap[VIRT_PCIE_ECAM].size);
+        s->memmap[VIRT_PCIE_ECAM].base, 0, s->memmap[VIRT_PCIE_ECAM].size);
     qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
         1, FDT_PCI_RANGE_IOPORT, 2, 0,
-        2, memmap[VIRT_PCIE_PIO].base, 2, memmap[VIRT_PCIE_PIO].size,
+        2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO].size,
         1, FDT_PCI_RANGE_MMIO,
-        2, memmap[VIRT_PCIE_MMIO].base,
-        2, memmap[VIRT_PCIE_MMIO].base, 2, memmap[VIRT_PCIE_MMIO].size,
+        2, s->memmap[VIRT_PCIE_MMIO].base,
+        2, s->memmap[VIRT_PCIE_MMIO].base, 2, s->memmap[VIRT_PCIE_MMIO].size,
         1, FDT_PCI_RANGE_MMIO_64BIT,
         2, virt_high_pcie_memmap.base,
         2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size);
@@ -918,8 +918,7 @@ static void create_fdt_pcie(RISCVVirtState *s, const MemMapEntry *memmap,
     create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
 }
 
-static void create_fdt_reset(RISCVVirtState *s, const MemMapEntry *memmap,
-                             uint32_t *phandle)
+static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
 {
     char *name;
     uint32_t test_phandle;
@@ -927,7 +926,7 @@ static void create_fdt_reset(RISCVVirtState *s, const MemMapEntry *memmap,
 
     test_phandle = (*phandle)++;
     name = g_strdup_printf("/soc/test@%lx",
-        (long)memmap[VIRT_TEST].base);
+        (long)s->memmap[VIRT_TEST].base);
     qemu_fdt_add_subnode(ms->fdt, name);
     {
         static const char * const compat[3] = {
@@ -937,7 +936,7 @@ static void create_fdt_reset(RISCVVirtState *s, const MemMapEntry *memmap,
                                       (char **)&compat, ARRAY_SIZE(compat));
     }
     qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-        0x0, memmap[VIRT_TEST].base, 0x0, memmap[VIRT_TEST].size);
+        0x0, s->memmap[VIRT_TEST].base, 0x0, s->memmap[VIRT_TEST].size);
     qemu_fdt_setprop_cell(ms->fdt, name, "phandle", test_phandle);
     test_phandle = qemu_fdt_get_phandle(ms->fdt, name);
     g_free(name);
@@ -959,18 +958,19 @@ static void create_fdt_reset(RISCVVirtState *s, const MemMapEntry *memmap,
     g_free(name);
 }
 
-static void create_fdt_uart(RISCVVirtState *s, const MemMapEntry *memmap,
+static void create_fdt_uart(RISCVVirtState *s,
                             uint32_t irq_mmio_phandle)
 {
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
 
-    name = g_strdup_printf("/soc/serial@%lx", (long)memmap[VIRT_UART0].base);
+    name = g_strdup_printf("/soc/serial@%lx",
+                           (long)s->memmap[VIRT_UART0].base);
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
     qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-        0x0, memmap[VIRT_UART0].base,
-        0x0, memmap[VIRT_UART0].size);
+        0x0, s->memmap[VIRT_UART0].base,
+        0x0, s->memmap[VIRT_UART0].size);
     qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
     qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent", irq_mmio_phandle);
     if (s->aia_type == VIRT_AIA_TYPE_NONE) {
@@ -983,18 +983,18 @@ static void create_fdt_uart(RISCVVirtState *s, const MemMapEntry *memmap,
     qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
 }
 
-static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
+static void create_fdt_rtc(RISCVVirtState *s,
                            uint32_t irq_mmio_phandle)
 {
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
 
-    name = g_strdup_printf("/soc/rtc@%lx", (long)memmap[VIRT_RTC].base);
+    name = g_strdup_printf("/soc/rtc@%lx", (long)s->memmap[VIRT_RTC].base);
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible",
         "google,goldfish-rtc");
     qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-        0x0, memmap[VIRT_RTC].base, 0x0, memmap[VIRT_RTC].size);
+        0x0, s->memmap[VIRT_RTC].base, 0x0, s->memmap[VIRT_RTC].size);
     qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
         irq_mmio_phandle);
     if (s->aia_type == VIRT_AIA_TYPE_NONE) {
@@ -1144,14 +1144,14 @@ static void finalize_fdt(RISCVVirtState *s)
         create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
                              &iommu_sys_phandle);
     }
-    create_fdt_pcie(s, s->memmap, irq_pcie_phandle, msi_pcie_phandle,
+    create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
 
-    create_fdt_reset(s, s->memmap, &phandle);
+    create_fdt_reset(s, &phandle);
 
-    create_fdt_uart(s, s->memmap, irq_mmio_phandle);
+    create_fdt_uart(s, irq_mmio_phandle);
 
-    create_fdt_rtc(s, s->memmap, irq_mmio_phandle);
+    create_fdt_rtc(s, irq_mmio_phandle);
 }
 
 static void create_fdt(RISCVVirtState *s)
-- 
2.49.0


