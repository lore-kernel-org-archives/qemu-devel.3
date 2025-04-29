Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1598C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kXy-0002XB-5H; Tue, 29 Apr 2025 08:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kXw-0002Wf-Hr
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:58:48 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kXs-0000D2-GE
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:58:47 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-224341bbc1dso63237665ad.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745931522; x=1746536322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1PjrOhEVk/DiT++u/R6pUMVH4weoO5EwHzpd6Ihic0=;
 b=ZfIv8s9AAn4yi/laK3zaBkOECBcGxb/vus9U7DHFTLZLOTikSPaPz0P6iMVDnmlpJv
 nPuhgEQ9oR3hqkHK9NQNQ5Hbj+0zb1xBrvYjve6VeliGzM0LW/qFHHH0GAORPj6DpGaT
 pvnklgdoVWHaT21MWjfJ1J/9Mc/4BY1aMg1YLQ7dbet+A08Dk80U+K05LEDLdzzUFcg/
 dUrOJg9MODl1G9Dtx/O5apiUI90RbqHZxWFE1ZDbNL1/1kaitB5bJ4dI2D7SRVG0yCPs
 xlNy1ewbiOzbfs/XDJKsNdN8f2DOQvFhTUmBh+kaaLIPWL9yDt9H3ZvtQmD8id01ZBqy
 JWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745931522; x=1746536322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C1PjrOhEVk/DiT++u/R6pUMVH4weoO5EwHzpd6Ihic0=;
 b=fPQRGaIGC6sT0Do3P8cc7dJSfw2lsOslATZpuYiHMjNy34xZgjlpnNMdL/EYblU2cC
 n/qQGu28/GfolDZ2SnKNBMPHHIZ3bfnkQmQyKLy25CdsnGQ6n14OLLpK0BTzesq+63d2
 tkwVdyIUdFclcgNrJGf3MAR37PyW9YJG550xzTbTa/0Dm6bRq400s6LNPkwfC43S/IMj
 Q4ob67xA9FX7bAIiEaFOd1UCD4f1gOVDi4MWyPdpf1mao3zmhS8Q5B+U879pwsX0nMMh
 ToaEaZoVMUkIcvMh22Zfnw8yIS3REz5VxdaUAxcp6igB3hlBJDg8azDBZgaNqAQHW3Pm
 9YEQ==
X-Gm-Message-State: AOJu0YzdcDS3F/QwvKimOZ2dzJ2R2XCOY738BTIKwF+NNRfvrDkyV7an
 AWMUPrqNU8aLWL0XRoL+VVemcVfrlm3C6zQ8rkwndO8xRNXkgb+xMioCghxvSfeVCDVqc1UcM/T
 q
X-Gm-Gg: ASbGncvx2uGkBUqkdDXVrDW8XRwE4m1kYnQkLdsbQ7mf0JA6O2r546qnU3S00uHAVxw
 7RGw/tkOLei3InYX13CoVocInS/VdC04zrr6Duk008jzTQDz+D3i1odUmF8Z0a9FIWWxVxyeUe9
 39YFoA0xDZM6588IpMWQVUYkkKdMJwbqIEM0M4B3aqDv1yc1SvTa/ATlVcGIaC87IaDZoW+XZS4
 b/E/NL+gdBS0MgNkSNMMcojDPV27udZpyBWkIDFapkwjv0rSbAXLKshlMbsyPZi5nuZJRMLiu5k
 UI232KVmiUfglZ2Ix4KT5d/NlJXhnM3MWYec10aae3/b2v/0iJONxQ==
X-Google-Smtp-Source: AGHT+IFdjC4uHJFjcaxhLJd4m9VA+hfM2qCY/A1QaR+tpLN9IYVHqWVoV1W5UJy60/n4NRB5Hd5/xQ==
X-Received: by 2002:a17:903:18d:b0:216:393b:23d4 with SMTP id
 d9443c01a7336-22de7007252mr40710085ad.11.1745931521735; 
 Tue, 29 Apr 2025 05:58:41 -0700 (PDT)
Received: from grind.. ([152.234.125.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f7fb7e54sm8889440a12.30.2025.04.29.05.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:58:41 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, joel@jms.id.au,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 8/9] hw/riscv/virt.c: use s->memmap in finalize_fdt()
 functions
Date: Tue, 29 Apr 2025 09:58:10 -0300
Message-ID: <20250429125811.224803-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429125811.224803-1-dbarboza@ventanamicro.com>
References: <20250429125811.224803-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Change create_fdt_pcie(), create_fdt_reset(), create_fdt_uart() and
create_fdt_rtc() to use s->memmap in their logic.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 46ac42058e..f38b64d836 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -871,7 +871,7 @@ static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_phandle)
     }
 }
 
-static void create_fdt_pcie(RISCVVirtState *s, const MemMapEntry *memmap,
+static void create_fdt_pcie(RISCVVirtState *s,
                             uint32_t irq_pcie_phandle,
                             uint32_t msi_pcie_phandle,
                             uint32_t iommu_sys_phandle)
@@ -880,7 +880,7 @@ static void create_fdt_pcie(RISCVVirtState *s, const MemMapEntry *memmap,
     MachineState *ms = MACHINE(s);
 
     name = g_strdup_printf("/soc/pci@%lx",
-        (long) memmap[VIRT_PCIE_ECAM].base);
+        (long) s->memmap[VIRT_PCIE_ECAM].base);
     qemu_fdt_setprop_cell(ms->fdt, name, "#address-cells",
         FDT_PCI_ADDR_CELLS);
     qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells",
@@ -891,19 +891,19 @@ static void create_fdt_pcie(RISCVVirtState *s, const MemMapEntry *memmap,
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
@@ -917,8 +917,7 @@ static void create_fdt_pcie(RISCVVirtState *s, const MemMapEntry *memmap,
     create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
 }
 
-static void create_fdt_reset(RISCVVirtState *s, const MemMapEntry *memmap,
-                             uint32_t *phandle)
+static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
 {
     char *name;
     uint32_t test_phandle;
@@ -926,7 +925,7 @@ static void create_fdt_reset(RISCVVirtState *s, const MemMapEntry *memmap,
 
     test_phandle = (*phandle)++;
     name = g_strdup_printf("/soc/test@%lx",
-        (long)memmap[VIRT_TEST].base);
+        (long)s->memmap[VIRT_TEST].base);
     qemu_fdt_add_subnode(ms->fdt, name);
     {
         static const char * const compat[3] = {
@@ -936,7 +935,7 @@ static void create_fdt_reset(RISCVVirtState *s, const MemMapEntry *memmap,
                                       (char **)&compat, ARRAY_SIZE(compat));
     }
     qemu_fdt_setprop_cells(ms->fdt, name, "reg",
-        0x0, memmap[VIRT_TEST].base, 0x0, memmap[VIRT_TEST].size);
+        0x0, s->memmap[VIRT_TEST].base, 0x0, s->memmap[VIRT_TEST].size);
     qemu_fdt_setprop_cell(ms->fdt, name, "phandle", test_phandle);
     test_phandle = qemu_fdt_get_phandle(ms->fdt, name);
     g_free(name);
@@ -958,18 +957,19 @@ static void create_fdt_reset(RISCVVirtState *s, const MemMapEntry *memmap,
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
@@ -982,18 +982,18 @@ static void create_fdt_uart(RISCVVirtState *s, const MemMapEntry *memmap,
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
@@ -1143,14 +1143,14 @@ static void finalize_fdt(RISCVVirtState *s)
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


