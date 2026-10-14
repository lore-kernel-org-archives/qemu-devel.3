Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852BECC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpbF-0001Xh-IX; Tue, 13 Oct 2026 23:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xGpb7-0001UE-A4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:24:09 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xGpb5-0000C6-Ia
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:24:09 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cd1006978ecso203124a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1791948246; x=1792553046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K01QCnnb27X3LHcQOnx4YnlR9MTY0rWVtmtVD4RUyZM=;
 b=GL5z2Bv3KPTnbTsfWGPN4VnWm8MWZm9wqjEN5ah5OWJfc3Qx+knsL9ThyioWhoB4Yg
 LJ0DoIaNk1Chz6tmXSfuM2ZDYtsTrrvQ2jwBHnKa5FTQx0QPid9cmJdXv8rIW/ZjAgWd
 H/1PaU7REZ1a2V2z9kYhHv3Y7VUf71l8Zo1DACFvupnWa+ExsyviDbPckyqRc115hXK3
 VDY1XUbilGDVAK2aZ79A87pIfoxr13PSBOnl5be9t5R4Jo3b/ZIHt/1c2loHHCHMrTUV
 46FfaCCJE/5WXOjKXf5XNfAJUFinMra1RbxIvy8/ZQ3M58pBJiwMMz1mTc+atyQZmqZj
 1wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791948246; x=1792553046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K01QCnnb27X3LHcQOnx4YnlR9MTY0rWVtmtVD4RUyZM=;
 b=ARfV2VQATt4sTsd29pg7VayryGZd2TVZ1sVZupKOkeHpOofWChlLj5hRqyzZSoNrQq
 cW05/eUiSwY1xxkuzyR8WXZSLREDMid9t0Fbq70aqZiNODGK3i8vvZHxFCIeSEdQZx7R
 jWmwSdz+f0b6t55Vueym2cSnXcuC0DTUPhon9tFFlU5UF69pmTTD9aHL22peWRkPijGN
 71/+m7lvfvMVM/Q/0bu0Wh5LW7NSporEU3z0WhcL0lbeO6IzJshocjtX7as77/goImRF
 aNdXsVSHTcBWLHdoUhE+0bAgCgtttPMigvP6ib3pVLp7to42Plg+QPhtk0USTD5MuW5u
 xMvg==
X-Gm-Message-State: AFq9FYI/+uI2wAI/oThT46w0/URgXUxR9F8j6myrucpeK8pYPP3YWiYi
 FzAb34/aHKpjUaPCoX0rtJ7c17DsmRgRxS9pvzfeKPCoKWrrNKY6yrpYoSjIWFPjdZ2eNjiHFJ5
 DSuf3
X-Gm-Gg: AYBFou3lGH8Iu/AJCI65cq68j6LBzktQwa5bI/QnTcHTTkMzOgHfoN1RpgARel1x7Oj
 Mldz+vNRCzazA/OM8uy+bLbiVVZ1amiaxWA04ScFyZGs1jl6wUYZe6sAvwsY4icUxh++kyUEhDv
 CzwYJrsbEnhNB+D7P4jvgpZXDyA7Uu38xYoaR4slv3dVED9WWJFkKnEJME5OMWssm571si50AOy
 9VUTYuoclm06MtE7bv/mLRkQ6Br7CN8ez9VE09QjdKpbdhbgBKoSUm3MCqE0kFXRUiM5MWeZJXP
 pMFqt+LX81NCbXV4VY0jKEbK3asz/i6VxITiIK6YKrF64KUDSxWU1yiPKN+NOxozuidjDA/2pB1
 xOgbGvF42sxw5JxLHX/oiVihrbqY6OxZq+WZ+ZgMpmDYZYCPbRaSeTPugvdI3iJrXc2WWZvsmTI
 3MUuIB6PRcISwLFezacw0schzLqlVMw3Gxzm0FNvt7llQQuWm4WOJtiBxqmPkwnqAt9SPDrcm0Z
 bqX7OTuBmU6x5xUL56AIde7LIbM5LHcPlbArYLDMQe9b44=
X-Received: by 2002:a17:90b:224c:b0:3a6:f1d2:57fa with SMTP id
 98e67ed59e1d1-3ab3a9d3e21mr23214663a91.4.1791948246050; 
 Tue, 13 Oct 2026 20:24:06 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac6069ca15sm2211261a91.11.2026.10.13.20.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:24:05 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Michael Ellerman <mpe@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 2/3] hw/riscv/atlantis: Add all UARTs for Atlantis SoC
Date: Wed, 14 Oct 2026 13:23:45 +1000
Message-ID: <20261014032346.732257-3-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014032346.732257-1-portias@oss.tenstorrent.com>
References: <20261014032346.732257-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=portias@tenstorrent.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Previously only the Ascalon console UART was enabled, this enables all 5
UARTs on the SoC. Only UART1 is added to the serial interface for now.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/tt_atlantis.c         | 54 +++++++++++++++++++++++++---------
 include/hw/riscv/tt_atlantis.h | 11 ++++++-
 2 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 70815e12ef..2342edce93 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -62,7 +62,11 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_I2C2] =             { 0xd4060000,       0x10000 },
     [TT_ATL_I2C3] =             { 0xd4070000,       0x10000 },
     [TT_ATL_I2C4] =             { 0xd4080000,       0x10000 },
+    [TT_ATL_UART0] =            { 0xd4100000,       0x10000 },
     [TT_ATL_UART1] =            { 0xd4110000,       0x10000 },
+    [TT_ATL_UART2] =            { 0xd4120000,       0x10000 },
+    [TT_ATL_UART3] =            { 0xd4130000,       0x10000 },
+    [TT_ATL_UART4] =            { 0xd4140000,       0x10000 },
     [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
 };
@@ -259,13 +263,14 @@ static void create_fdt_cpu(void *fdt, TTAtlantisSoCState *s,
 }
 
 static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
-                            int irqchip_phandle)
+                            int irqchip_phandle, int index)
 {
     static const char * const compat[2] = {
         "snps,dw-apb-uart", "ns16550a"
     };
     g_autofree char *name = g_strdup_printf("/soc/serial@%"HWADDR_PRIX,
                                             mem->base);
+    g_autofree char *alias = g_strdup_printf("serial%d", index);
 
     qemu_fdt_add_subnode(fdt, name);
     qemu_fdt_setprop_string_array(fdt, name, "compatible",
@@ -277,8 +282,10 @@ static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
     qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle);
     qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
 
-    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", name);
-    qemu_fdt_setprop_string(fdt, "/aliases", "serial0", name);
+    if (index == 0) {
+        qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", name);
+    }
+    qemu_fdt_setprop_string(fdt, "/aliases", alias, name);
 }
 
 static void create_fdt_rng(void *fdt)
@@ -347,8 +354,11 @@ static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
      *                       aplic_s_phandle);
      */
 
-    create_fdt_uart(fdt, &s->memmap[TT_ATL_UART1], TT_ATL_UART1_IRQ,
-                    aplic_s_phandle);
+    /* Skip UART0 since it is the RCPU console, UART1 is the Ascalon console */
+    for (int i = 0; i < TT_ATL_NUM_UARTS - 1; i++) {
+        create_fdt_uart(fdt, &s->memmap[TT_ATL_UART1 + i], TT_ATL_UART1_IRQ + i,
+                        aplic_s_phandle, i);
+    }
 
     create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
 
@@ -474,13 +484,21 @@ static void tt_atlantis_machine_done(Notifier *n, void *data)
                               fdt_load_addr);
 }
 
+static inline int tt_atlantis_uart_index(int uart_dev)
+{
+    return uart_dev - TT_ATL_UART0;
+}
+
 static void tt_atlantis_soc_init(Object *obj)
 {
     TTAtlantisSoCState *s = TT_ATLANTIS_SOC(obj);
 
     object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
 
-    object_initialize_child(obj, "uart1", &s->uart1, TYPE_DW8250);
+    for (int i = 0; i < TT_ATL_NUM_UARTS; i++) {
+        object_initialize_child(obj, "uart[*]", &s->uart[i],
+                                TYPE_DW8250);
+    }
 
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
         object_initialize_child(obj, "i2c[*]", &s->i2c[i],
@@ -574,14 +592,22 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
                                 &s->bootrom);
 
-    /* UART1, the soc console (UART0 is for the boot microcontroller) */
-    qdev_prop_set_chr(DEVICE(&s->uart1), "chardev", serial_hd(0));
-    sysbus_realize(SYS_BUS_DEVICE(&s->uart1), &error_fatal);
-    memory_region_add_subregion(s->memory,
-                                s->memmap[TT_ATL_UART1].base,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart1), 0));
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart1), 0,
-                       qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ));
+    /* UART1, the soc console (UART0 is for the boot microcontroller */
+    qdev_prop_set_chr(DEVICE(&s->uart[tt_atlantis_uart_index(TT_ATL_UART1)]),
+                      "chardev", serial_hd(0));
+
+    for (int i = 0; i < TT_ATL_NUM_UARTS; i++) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->uart[i]);
+        if (!sysbus_realize(sbd, errp)) {
+            return;
+        }
+
+        memory_region_add_subregion(s->memory,
+                                    s->memmap[TT_ATL_UART0 + i].base,
+                                    sysbus_mmio_get_region(sbd, 0));
+        sysbus_connect_irq(sbd, 0,
+                           qdev_get_gpio_in(s->irqchip, TT_ATL_UART0_IRQ + i));
+    }
 
     /* I2C */
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 000988c037..b81b7c8abd 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -23,6 +23,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
 OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisSoCState, TT_ATLANTIS_SOC)
 
 #define TT_ATL_NUM_I2C 5
+#define TT_ATL_NUM_UARTS 5
 
 struct TTAtlantisSoCState {
     /*< private >*/
@@ -39,7 +40,7 @@ struct TTAtlantisSoCState {
     RISCVHartArrayState cpus;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
-    DW8250State uart1;
+    DW8250State uart[TT_ATL_NUM_UARTS];
     MemoryRegion bootrom;
 
     uint32_t num_harts;
@@ -63,7 +64,11 @@ enum {
     TT_ATL_I2C2_IRQ = 35,
     TT_ATL_I2C3_IRQ = 36,
     TT_ATL_I2C4_IRQ = 37,
+    TT_ATL_UART0_IRQ = 38,
     TT_ATL_UART1_IRQ = 39,
+    TT_ATL_UART2_IRQ = 40,
+    TT_ATL_UART3_IRQ = 41,
+    TT_ATL_UART4_IRQ = 42,
 };
 
 enum {
@@ -80,7 +85,11 @@ enum {
     TT_ATL_MIMSIC,
     TT_ATL_SAPLIC,
     TT_ATL_SIMSIC,
+    TT_ATL_UART0,
     TT_ATL_UART1,
+    TT_ATL_UART2,
+    TT_ATL_UART3,
+    TT_ATL_UART4,
 };
 
 #endif
-- 
2.43.0


