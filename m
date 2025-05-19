Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A2CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs4h-0003Lc-0K; Mon, 19 May 2025 00:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrpH-0000K6-2v
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:10:08 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrpE-0004Qy-My
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:10:06 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-af548cb1f83so3628827a12.3
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627801; x=1748232601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PyLdyYCHN0qVxiYhTJKCmDnIpQOjoM3r03Xr3doFWjY=;
 b=IHe2+w9lk6eKOT9kk7mkrlX/bpgHfqIqiI17PB+50RO29SJC6RB6nHe3i361FN5Yct
 UXPRLXD6htd1uw3J/6NMXVaqUxZ8tN13gFND2kdad2pAarW0iofEca6tdv5voLSjqiW+
 pZVGQVgewirkT3YCWyVwSnUpg+31S02vaUfHfBzmYHMssbKm0DYyCbAJWNltvFNn2w0J
 QLh1j0UMHGFi9BemWGntzpk5nJbz2IxckTBoaU2j10LlK7keVCovhkX+51PR9PtJBn47
 7uTqu2JzOstx/lpaAPfkYL8uDB32QrHMyXLYw7lnC9903xQ7jUV/8i9yboKhObBVXj46
 8Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627801; x=1748232601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PyLdyYCHN0qVxiYhTJKCmDnIpQOjoM3r03Xr3doFWjY=;
 b=Qa17dTaDnqRdkILV+XWTlnt/s33DMOl5dei+MpREoZSLcnC9GcTPejeFZL82fmiTCG
 9DckJhKYn/DySpaLf1Pa/Df8qkE0Lb+Pm7u1958sIMinYmdka+vhJVzRfIfWl/Qg719f
 GVLFSYwg63GOtVThOQo+PfRaEYQlMYDXUIBzcSlPeCe31ffrgfCSCZtE30NCQ9w4s3ec
 vd54dFlB5c9wUY6WpZzXcx//SRvEVITcTjMfRA8y5flMqtvpOxPdID6tXPeZs6K3RlUL
 2PE5qaSdaaC3DORHpdNTbCP8vLsPi5OQJmqw7l6SjTk3dBNitTg4M9Sc8oN0y3bZdzND
 Cybw==
X-Gm-Message-State: AOJu0YwQyMAwmevNnc7xI9Jel4FeSn0EwKgajtUSV4t8j/3CDUHADcM0
 7VxlcAulH3lhX7gUC93stXQTNbJln2TRCUvWHhpWGVdBX/fglJYXHcUl8zjXVg==
X-Gm-Gg: ASbGnctqHipcr/wTwzbxI1KXj6Pnz2C2zl8wI/lGajnjbNlmcATAsO5z0Jr5ODy1X3w
 3ZvT/VAgCOoCalLXlCjab9oAy/gVVPvjovYKleI49aIHo52VWDxqGXk9SYq0LGcj9Byf+UBIsSM
 IqCgo5jusWN6oogNSFdU1DXSqCelipgOxNir+1/g6xKVkPelzgAVHa6V4ZBC+4Gaz26ih4PwVQL
 VT8KW/bIT6JI1AlkPfEeIRl13cRxlhkzidiEtpivPdIThHaR4Y85cJSgcmJv+Xpqn1dLHIvApju
 tV2WKicOS/bTPzakWMC5nDtGRFtJ8dkH2O/deTdqK1F9kDrLF8+5f/lNTogu0JCZ8qJDv6NUE8m
 nPjagnB4E86CWReCbtP7Dwx9b4upp9oGIFQ4AzxGdY57fayuZnXzz2U2f6gukndTYmso=
X-Google-Smtp-Source: AGHT+IFWcWO3eLqf9814E9bYuVkcvKRxop+3cuSPpH39ttcBjNNY5SaNbyRE9rymtQXr30iNJHFugg==
X-Received: by 2002:a17:902:db07:b0:223:f9a4:3fb6 with SMTP id
 d9443c01a7336-231de3515c1mr156101895ad.11.1747627801232; 
 Sun, 18 May 2025 21:10:01 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:10:00 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 55/56] hw/riscv/virt.c: use s->memmap in finalize_fdt()
 functions
Date: Mon, 19 May 2025 14:05:52 +1000
Message-ID: <20250519040555.3797167-56-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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

Change create_fdt_pcie(), create_fdt_reset(), create_fdt_uart() and
create_fdt_rtc() to use s->memmap in their logic.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429125811.224803-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 37bd720068..edb6973100 100644
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


