Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B05D31A02
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsbX-0006AJ-Qk; Tue, 13 Jan 2026 23:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfsbR-00068R-7K
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:35:29 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfsbP-0008Jk-Iu
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:35:28 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c2af7d09533so5312082a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768365325; x=1768970125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIkoYjt0o7Lp4Hxob2wzHwzR6Bskpm4c9VC5zDlLM88=;
 b=ArnTPNT4UdvviZtvsEdhYlItbQ/PcLTlPR3lWG0wFGuJnG79CagQSlYwXV16H/xxSA
 6Bdnv4rynQnB0m8FB4xnKoGhVf1sxfBpQTGnojQTog2nJAWTwAjH/408mH4Y34s4LDUD
 Ev1M7ueYl7xBn3mx4A1PugQsAHhbJZx6VjCBO95NbeLLkjk7L9c6qzKLI+wTIyydKi2/
 xYbKwZe0/9f10PQip23j0jX1cEV2LFgwRXNUkl3IYhzGA1wv4VDXFByKZV1dR9OdY4oT
 Mqx8tnJIcHRw6seDClOTNwmXP1hXy2Rw42HBpVgFEqC5O2Ogm4btT15lNgvaWSg2aiHK
 VJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768365325; x=1768970125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fIkoYjt0o7Lp4Hxob2wzHwzR6Bskpm4c9VC5zDlLM88=;
 b=PYPzi/jHALokGZpyfJTL4v62/ch6H7aS9M7u/puEL4VzZXK8m92NZk4HLDxhgPWNg2
 wE42n6NgG1f9i6rpdHm5gSimzzcSVS8Lr9bFv0+Wj+1NFnSQRxOV7SihRaJ7n8vNPS7H
 OWcfeM38RsveHH5DzH/3q56uRcYgQdI2v67g4HGrmvYiDkUByw/p/T9Iqb0y9GC4s4YA
 rjrMb46fzj8gI6SIzi2AgALdXqfA0LaZLLHeitkiwjfWQsLpyJvlwngRmmcfZb4tWn2l
 NpeV1VpKrGLln8Lah4a0dFmnxo3F6196MDhfQ8EzrFTSECPgbyx+BEBWWQ+QlQZUZq9v
 FW5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsalyuniIeY+fI1xg/GyND1/BN3A+IMcRYJwUqRonjYBkea4i7bFHG7pdAuMmkf8KZPEMLpweCfOoK@nongnu.org
X-Gm-Message-State: AOJu0YyjceHcGiKXVOEUjNkqnGOf+fwu/gNG5ry/sJNjXAa9juIlN8DZ
 2uamcOJCmINsaYRyMCURDc7NnHC/H9u68zCZQFExW4RGBF9RQJ4P4xgK
X-Gm-Gg: AY/fxX5D/6He/Tkn+7i3Fgca4Qv6m96nRKuCCn1/fBDlj6xLMOuclzcZEHCYAZe0qqh
 qjEWCjudf8bbpuK7dCyVtCeE7sQVlY1VkUrqeNz3x4liUxeOlaCXConNyFGcgfoSFITkKvcCusU
 XtJqWHI7AYI4WI3UA5oLnPczOxsllGQqbtuMAMWpUNQpsSo9ga7rhXVkTIikgNmD48WjmyMF6AG
 mrOoLgEX/fa8eesHB3HFwp888wXZRhwbs/jCGw9AYwVSDlQaiB/PENSfGRPDJzVHqTFMZXqrO2r
 3PkvPFDPYYYasp8DvPkJEO/M1jl0FL1L6qjcNQ1mzjWGnN72UAP0sI/5kHqDRytDSNAbNpaaM6I
 +z5MTfBYyqTzi8jqttoqPSTSN/Jz1PYXSTInEA/oxE1RZ++Jx4ob3tOQkpNphZWpuvovLFODWdT
 4GvSpIaK3hO18OFJq4RiGr8YWFWQz0rc0=
X-Received: by 2002:a05:6a20:914e:b0:366:14ac:e1ef with SMTP id
 adf61e73a8af0-38befc04248mr875905637.65.1768365325170; 
 Tue, 13 Jan 2026 20:35:25 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cb5352268sm20702659a12.0.2026.01.13.20.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:35:24 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 4/6] hw/riscv/atlantis: Integrate i2c buses
Date: Wed, 14 Jan 2026 15:04:26 +1030
Message-ID: <20260114043433.1056021-5-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114043433.1056021-1-joel@jms.id.au>
References: <20260114043433.1056021-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
v2:
 - Correct count from 4 to 5
 - Fix headers location
---
 include/hw/riscv/tt_atlantis.h | 13 ++++++++++++
 hw/riscv/tt_atlantis.c         | 39 ++++++++++++++++++++++++++++++++++
 hw/riscv/Kconfig               |  1 +
 3 files changed, 53 insertions(+)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 10b06894aeca..1b4f61c95184 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -11,12 +11,15 @@
 
 #include "hw/core/boards.h"
 #include "hw/core/sysbus.h"
+#include "hw/i2c/designware_i2c.h"
 #include "hw/intc/riscv_imsic.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
 OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
 
+#define TT_ATL_NUM_I2C 5
+
 struct TTAtlantisState {
     /*< private >*/
     MachineState parent;
@@ -30,6 +33,7 @@ struct TTAtlantisState {
     RISCVHartArrayState soc;
     DeviceState *irqchip;
     GPEXHost gpex_host;
+    DesignWareI2CState i2c[TT_ATL_NUM_I2C];
 
     int fdt_size;
     int aia_guests; /* TODO: This should be hard coded once known */
@@ -37,6 +41,11 @@ struct TTAtlantisState {
 
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
@@ -52,6 +61,10 @@ enum {
     TT_ATL_DDR_HI,
     TT_ATL_FW_CFG,
     TT_ATL_I2C0,
+    TT_ATL_I2C1,
+    TT_ATL_I2C2,
+    TT_ATL_I2C3,
+    TT_ATL_I2C4,
     TT_ATL_MAPLIC,
     TT_ATL_MIMSIC,
     TT_ATL_PCIE_ECAM0,
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index fa6e4f42a12d..2d0add278c20 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -67,6 +67,11 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_TIMER] =            { 0xa8020000,       0x10000 },
     [TT_ATL_WDT0] =             { 0xa8030000,       0x10000 },
     [TT_ATL_UART0] =            { 0xb0100000,       0x10000 },
+    [TT_ATL_I2C0] =             { 0xb0400000,       0x10000 },
+    [TT_ATL_I2C1] =             { 0xb0500000,       0x10000 },
+    [TT_ATL_I2C2] =             { 0xb0600000,       0x10000 },
+    [TT_ATL_I2C3] =             { 0xb0700000,       0x10000 },
+    [TT_ATL_I2C4] =             { 0xb0800000,       0x10000 },
     [TT_ATL_MAPLIC] =           { 0xcc000000,     0x4000000 },
     [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
@@ -478,6 +483,20 @@ static void create_fdt_fw_cfg(void *fdt, const MemMapEntry *mem)
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
@@ -505,6 +524,13 @@ static void finalize_fdt(TTAtlantisState *s)
 
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
@@ -813,6 +839,19 @@ static void tt_atlantis_machine_init(MachineState *machine)
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
index 5317eccd06e7..ee876557ef15 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -137,6 +137,7 @@ config TENSTORRENT
     select RISCV_IMSIC
     select FW_CFG_DMA
     select PLATFORM_BUS
+    select DESIGNWARE_I2C
 
 config XIANGSHAN_KUNMINGHU
     bool
-- 
2.47.3


