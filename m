Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4F6CD0437
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 05:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd05Y-0005XT-Uf; Tue, 06 Jan 2026 00:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd05M-0004zc-U5
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:31 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd05K-00029h-Iw
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:58:28 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-34f0bc64a27so551290a91.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767679105; x=1768283905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqRmUkHjK4JIa3H46oNnrD3f8z1CVK/k08LxTrnytSE=;
 b=ZI8WHJialyaDfb6qYdbVLE0jw5puXenNJDQxEPb2Aw6FQPHq3DUbMvTUbwJGt8/N+2
 MRDHiaZjqv6wNCNaabdsyAD9syzuWLD8y4js+Li37D3mvJQpjwaiCPn7VY8aRZ1djmps
 WPWLRyd7UXs7X8/fxEyJTvMnhFu6tuBPuvcoV936oB4cabg4GvnSurlAVQ7JIQiNV7cw
 DRQxLuFi0duIBX0C7+2q5pf7sZR/2BruV8ciHxXHsQwOOCefGNF76dIr8KPHlnl1fSJs
 4v5X5TYSFCwR3P117dY5aontN/Sy7fc5AIk5RtySyLOcFK9D9K66gBEzwUQH6uzTsx1J
 2gEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767679105; x=1768283905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lqRmUkHjK4JIa3H46oNnrD3f8z1CVK/k08LxTrnytSE=;
 b=cag5MKatwlX9np2GJdXiZinadHGrPSQ3kbjGzDgG0DUcBMFLftE+W6ZeZsq51jJJxR
 MX1EEVzrdLQmX8LIzi0+DWdwzV2k92yDdnq4w/gWQMAK6zzjbsy1En/qWQQNiLp0BNSO
 jKwMopO3ECnnSx0hlMKjjeOiv5Rtu5VKxraRzpLNdlh5Ou66qYm6UeuU7QEx4Wcgcvbw
 EThfWIr04xPgNclj7G4aU5N/Z44hLbrU++J0oDhxAperud9JD8JkxpNugK9qvbtJ9sIN
 y39LoQUg1pDBwHxMqyXpnUhBiw9RI1cm/dMc0gmn3/osaoECgaoJPFOJZUkdZCzSJFq9
 rDLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9Ljfs4tD6Tk2Hngj5ivmiEbzLazw4SdtWiwCJPU4jL6eSMmghpI+nCmwQwWTgGcndiufm9+xLG32P@nongnu.org
X-Gm-Message-State: AOJu0Yy2Y1nnCcsqRi/fz3SbX2G4GrWnP8zm6ersDX3kUHJPSXJ7zxMf
 4VhX96i1cmF8t3jCb4txO8Mnzinxx9CGY+3KN//3Ov+pitAOXFaQODxP
X-Gm-Gg: AY/fxX5P7lpvkEs4zdQT8GitglCCN2eglixGwLrNTxhSmVbkAFi//pSI/sH1PstCwUf
 0WhEEa2Mt5r0aXA7IP2MYRjXmeSfxKwawRIjGcSivY97+le7eiGIMEA7fzpT/X2b3V20xx+Xxz4
 8QLABo6Ixk5cadzj00/TpSi47lK3hNCAghRXhcUaF8S5+rP+rDy6Vf5y5hgDW4gAYlOZzxw8HIP
 ML3c/Af3mUOLdzf39UAim7FB61CxwE3uT2pbh83gpdNChz39dlFVzdmKk6vn3Ac+lxgevDXHTmi
 WOWi5alyOuCAFDzuSpW1Kzbcm2IbdhmFCQ8fpIt5p/++kYde6gDkgUiIFzN1xgaF6HF93XMEufS
 mKOnU5Rs8fv4qK0DZV+7XcMAVn39lpFKJHvj2qV5A00EEMzeuyNFi2zZd3vxByoU4jfTJW+q4E/
 r9fYKyAjKNfvlofYEZ4L4m
X-Google-Smtp-Source: AGHT+IG4BW89bcoS6orjC30/CVvmKSDFDcMutMf/YTruOcYvnAEfaYDj1TbarhNrvfdedl+VA46aVQ==
X-Received: by 2002:a17:90b:2e8f:b0:33f:eca0:47c6 with SMTP id
 98e67ed59e1d1-34f5f352ab1mr1535354a91.30.1767679105153; 
 Mon, 05 Jan 2026 21:58:25 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f60178af5sm460222a91.3.2026.01.05.21.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 21:58:24 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chris Rauer <crauer@google.com>,
 Vijai Kumar K <vijai@behindbytes.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 12/16] hw/riscv/atlantis: Integrate i2c buses
Date: Tue,  6 Jan 2026 16:26:52 +1030
Message-ID: <20260106055658.209029-13-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106055658.209029-1-joel@jms.id.au>
References: <20260106055658.209029-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

Now that we have the DesignWare model we can add buses to the
tt-atlantis machine.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h |  9 ++++++++
 hw/riscv/tt_atlantis.c         | 38 ++++++++++++++++++++++++++++++++++
 hw/riscv/Kconfig               |  1 +
 3 files changed, 48 insertions(+)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index edce490453a8..bbe4cf2b4034 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -14,6 +14,7 @@
 #include "hw/sysbus.h"
 #include "hw/block/flash.h"
 #include "hw/intc/riscv_imsic.h"
+#include "hw/i2c/designware_i2c.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
 OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
@@ -41,6 +42,11 @@ struct TTAtlantisState {
 
 enum {
     TT_ATL_SYSCON_IRQ = 10,
+    TT_ATL_I2C0_IRQ = 33,
+    TT_ATL_I2C1_IRQ = 34,
+    TT_ATL_I2C2_IRQ = 35,
+    TT_ATL_I2C3_IRQ = 36,
+    TT_ATL_I2C4_IRQ = 37,
     TT_ATL_UART0_IRQ = 38,
     TT_ATL_UART1_IRQ = 39,
     TT_ATL_UART2_IRQ = 40,
@@ -56,6 +62,9 @@ enum {
     TT_ATL_DDR_HI,
     TT_ATL_FW_CFG,
     TT_ATL_I2C0,
+    TT_ATL_I2C1,
+    TT_ATL_I2C2,
+    TT_ATL_I2C3,
     TT_ATL_MAPLIC,
     TT_ATL_MIMSIC,
     TT_ATL_PCIE_ECAM0,
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 1e296e027b77..31714666b67f 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -69,6 +69,10 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_WDT0] =             { 0xa8030000,       0x10000 },
     [TT_ATL_PCI_MMU_CFG] =      { 0xaa000000,      0x100000 },
     [TT_ATL_UART0] =            { 0xb0100000,       0x10000 },
+    [TT_ATL_I2C0] =             { 0xb0400000,       0x10000 },
+    [TT_ATL_I2C1] =             { 0xb0500000,       0x10000 },
+    [TT_ATL_I2C2] =             { 0xb0600000,       0x10000 },
+    [TT_ATL_I2C3] =             { 0xb0700000,       0x10000 },
     [TT_ATL_MAPLIC] =           { 0xcc000000,     0x4000000 },
     [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
@@ -480,6 +484,20 @@ static void create_fdt_fw_cfg(void *fdt, const MemMapEntry *mem)
     qemu_fdt_setprop(fdt, name, "dma-coherent", NULL, 0);
 }
 
+static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
+                           int irqchip_phandle)
+{
+    g_autofree char *name = g_strdup_printf("/soc/i2c@%" PRIx64, mem->base);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "snps,designware-i2c");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle);
+    qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
+    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
+    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
+}
+
 static void finalize_fdt(TTAtlantisState *s)
 {
     uint32_t aplic_s_phandle = next_phandle();
@@ -507,6 +525,13 @@ static void finalize_fdt(TTAtlantisState *s)
 
     create_fdt_uart(fdt, &s->memmap[TT_ATL_UART0], TT_ATL_UART0_IRQ,
                     aplic_s_phandle);
+
+    for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
+        create_fdt_i2c(fdt,
+                       &s->memmap[TT_ATL_I2C0 + i],
+                       TT_ATL_I2C0_IRQ + i,
+                       aplic_s_phandle);
+    }
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -815,6 +840,19 @@ static void tt_atlantis_machine_init(MachineState *machine)
                    qdev_get_gpio_in(s->irqchip, TT_ATL_UART0_IRQ),
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
+    /* I2C */
+    for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
+        object_initialize_child(OBJECT(s), "i2c[*]", &s->i2c[i],
+                                TYPE_DESIGNWARE_I2C);
+        sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &error_fatal);
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->i2c[i]);
+        memory_region_add_subregion(system_memory,
+                                    s->memmap[TT_ATL_I2C0 + i].base,
+                                    sysbus_mmio_get_region(sbd, 0));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
+                           qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ + i));
+    }
+
     /* Load or create device tree */
     if (machine->dtb) {
         machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index f1525254b126..e2b6951192df 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -146,3 +146,4 @@ config TENSTORRENT
     select RISCV_IMSIC
     select FW_CFG_DMA
     select PLATFORM_BUS
+    select DESIGNWARE_I2C
-- 
2.47.3


