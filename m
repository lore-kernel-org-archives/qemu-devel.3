Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6DFCA5FAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBOL9-0004iu-UF; Mon, 28 Sep 2026 23:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xBOL7-0004hr-R5
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 23:17:09 -0400
Received: from mail-pj2-x2b.google.com ([2607:f8b0:4864:39::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xBOL5-0006wm-RZ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 23:17:09 -0400
Received: by mail-pj2-x2b.google.com with SMTP id
 98e67ed59e1d1-3a49902b607so58764a91.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 20:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790651826; x=1791256626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kf+nIeHpt01xi7f9E3XZ4GcvS8aDvUDNshdLzQO/GwQ=;
 b=PSh7x1D7C3Nc6SoblUXADIDibeoxj1JLjewBDAF/04Y7z2nAu2XkJdWIXxirRE6DK+
 4gqZJPH3bQPlHWCcR1ZtuCwJWiwxZfVVZhJVYn/WrgKsm8CwT2RUzEMNBnO4M0HL1UuE
 Dqlr4b+k8hYktKyUsUyS+upD/kKB+UMoOYqdWuY0F9HexL7hUU1SwC9tGofJ68+IeJYe
 2/yLqFCTLsIHFdMvSx01tF116KMYa0u9xpfAyC1x4r4Gi/i1ax9Ove2k7RSYis/D0bdL
 Rt4UkaNZH+M4ccjRBRGV2e8xiwwkDkfwsvrlihCn9eImUVoSyIEVx1UuUeKYy2nWYXNy
 65Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790651826; x=1791256626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kf+nIeHpt01xi7f9E3XZ4GcvS8aDvUDNshdLzQO/GwQ=;
 b=QHScYjOH1giQQtX5xHXXBDXQu7HxsLFKqeh5j5PZUsp26MSdqKrJ0aHgq4j37rOqwZ
 EIy1KhPfM0eBXnXRV1W6ATJpZQZMZ51IKUiYqAUDcQY+oE30++wO51bF4o5hPdRgzZRU
 c6ViHwR/LSqvNBjsWqPPlLytROmzlrIfYHpSmKUpU8TXdAQ0S1Qrzd4IxVxGnhcxf2Qi
 +2XOUEHyivb0qFH1LD/PM/oUorMCGehMnp51LxcfYz4vg1MSR2rOXXMhqAj6J5DPfmTh
 OmD263cVUWZHlq8p9rpTCtQ9AsYxy44ime092pmYZ+Z6FBYu8eVAmoB7P4UlpbUJNv67
 SzaA==
X-Gm-Message-State: AFq9FYJCX3pqDeQmPxuVCclk5z311fUVJhEx+xWdGKmv7CEVPFUfiT4V
 9B78EC4nHkZE7Y5ub1mixu5fk25A0ZRkYJofZTZ8bAz3X/8rs6Q1qTCygCLu+oPMs4Siu0fIDGg
 9PRA1pAA=
X-Gm-Gg: AYBFou3eb4NRhUjNv49Z4I+e4qwUi1s5Lm/XTlcHGKJXZD8ZkpMCe12sLzo7xf095IW
 1+MoredXFEaRQ8a7xHPuvzDlQ0jNLkxy7zhNPcsc3f55xiCzsl+kJnKthoceYRW7Wzk+q9IbEcs
 TF9HYgLMIGuW7DToLzDl6RAlXVPGfVwFpqa65JZFI/c2Vpfg1TsmgAbglTbFk3baPzGA4H+ZWQf
 2TjnfC0f8FQiSuFYTLsi3YqNRu+YCW9RCxlTvBzB8R0D8oABm9LhOMZNY3GR6NrkPYbXYFMKEL7
 SP3KQDihxQ2E3UxHfHPpegnwSE5d/gXJoDkrjKrmVxXCZ1jt/jl3/csqkQ+ZOIMt4Q6ioXfmyi5
 5jTmZs4H9ncWqWZK1OKNiwM8gIHxSqiGRuUCrCccFFLOAY/s0yryYge2ZJqSGiE4SuuQls31XXP
 p4kzjlYsLO5XL8sKaQmgJGvuwR9FKCgXu1c7Qb3TS5xxXSdOTCxlNY83Q20kH44wN7nhIn2+I6B
 UhMBqgrcY0YzkjLqEDN1mGySA90iLq8jtGhwO4k2HtVTu0=
X-Received: by 2002:a17:90b:2547:b0:39d:e1f2:3400 with SMTP id
 98e67ed59e1d1-3a0b263614cmr17026598a91.5.1790651826548; 
 Mon, 28 Sep 2026 20:17:06 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a492dfc5absm1563641a91.3.2026.09.28.20.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 20:17:05 -0700 (PDT)
From: portias@oss.tenstorrent.com
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Joel Stanley <joel@jms.id.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/5] hw/riscv/atlantis: Add all UARTs for Atlantis SoC
Date: Tue, 29 Sep 2026 13:16:42 +1000
Message-ID: <20260929031644.1016354-4-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929031644.1016354-1-portias@oss.tenstorrent.com>
References: <20260929031644.1016354-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::2b;
 envelope-from=portias@tenstorrent.com; helo=mail-pj2-x2b.google.com
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

From: Portia Stephens <portias@oss.tenstorrent.com>

Previously only the Ascalon console UART was enabled, this enables all 5
UARTs on the SoC. Only UART1 is added to the serial interface for now.
The next change will handle adding the rest of the UARTs.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 hw/riscv/tt_atlantis.c         | 54 +++++++++++++++++++++++++---------
 include/hw/riscv/tt_atlantis.h | 11 ++++++-
 2 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index e889951677..d567ec1155 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -63,7 +63,11 @@ static const MemMapEntry tt_atlantis_memmap[] = {
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
@@ -260,11 +264,12 @@ static void create_fdt_cpu(void *fdt, TTAtlantisSoCState *s,
 }
 
 static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
-                            int irqchip_phandle)
+                            int irqchip_phandle, int index)
 {
     static const char compat[] = "snps,dw-apb-uart\0ns16550a";
     g_autofree char *name = g_strdup_printf("/soc/serial@%"HWADDR_PRIX,
                                             mem->base);
+    g_autofree char *alias = g_strdup_printf("serial%d", index);
 
     qemu_fdt_add_subnode(fdt, name);
     qemu_fdt_setprop(fdt, name, "compatible", compat, sizeof(compat));
@@ -275,8 +280,10 @@ static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
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
@@ -345,8 +352,11 @@ static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
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
 
@@ -472,13 +482,21 @@ static void tt_atlantis_machine_done(Notifier *n, void *data)
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
+        object_initialize_child(OBJECT(s), "uart[*]", &s->uart[i],
+                                TYPE_DW8250);
+    }
 
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
         object_initialize_child(obj, "i2c[*]", &s->i2c[i],
@@ -572,14 +590,22 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
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


