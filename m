Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF61CC6B2D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH9LK-0001d0-3O; Wed, 14 Oct 2026 20:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xH9LH-0001cB-9Y
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:29:07 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xH9LF-0000wb-7G
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:29:07 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3deso314390a91.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792024144; x=1792628944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W6iQt/nJGJKSfexDx17afcIMBhxPEbv2eHDhVLE1BZQ=;
 b=I0aU5GSGT+YCrsGJRVyDUPmZSpde8Nq4RX6tb9iDejCYueGjZgvQaVrkD1HqRG+Re9
 Yyusxmf5ijy7nE3NR1ss3Rv0U2hJqFQWCpMY0IbNm4tCSWpm4aUfRZ8tW6XVCtEXGO51
 50J1axNbE8Az6GtM9+55+zGiJKN6/0BmMsyOHrRPFy9bINXujP/Jc1/6Wa6ne0cides+
 QqQsXZ/ylhrZZ9Ez98W2bmndzVkH3L3odgyXVmDXK4VoZ5s9HbGJGVTu4sM1nLBLc5Y7
 Umhu+yK5JMLd5r65DTevn333laDU2/+kr4Cj1qsu6ZcFohpZ7W5/leKEXC8BDpCEpr0z
 nBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792024144; x=1792628944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W6iQt/nJGJKSfexDx17afcIMBhxPEbv2eHDhVLE1BZQ=;
 b=cW6Iu8S75YZn7UsQf/+pmhUYpeipykP80HE2B1GkLh/fGdYy2B3cUMWjqXlKo9P5Yo
 Efd3H2xo8Xg/Eq40CoV9K2Gz0ViUpPpEv/FHSdgXT1k8PVmpOU6OMgxTXt1M7T+mQ0cW
 44592ztwkVb0gl8x6nvENwwf8fYCRmRpAIT5i8cAOTCEGNExOglLefyYHpoXNvMPm/vt
 EuYfjh+A+UA43KdBGrSr+LmsDi1QyVN0veRH//5XUxCyq/+l3xvri/QfOwP6SoJB9pP7
 AGg3J2310WwJ7RP+8YY9etueCoZGZwwY1tBwQ57i1bZh24irZpPNmOdrA6EelKdWW+7c
 uQug==
X-Gm-Message-State: AFq9FYIWffVHK/i8R5VCwkVDKAoOrdDY0Qhxnll6bQwtwhkwDAIEGq5v
 kcbf+HRcWgn/QmjD8DHa7IUTNHTdfddLC5lVmb5CHvlJY6K9zG9lefK6muZ1FumJNI1FkdBX3T5
 6TRu3sXQ=
X-Gm-Gg: AYBFou0uUcc2qb6iGWoL+bhXMhwMs2+I9m4h9O/6Z6ECZZiDGgUUz9im6ftNz7n+4sI
 F2TLCurUnVx1ttomnIXHeANNR01hBp3+lDploQkJlxkXkph5vLNsvF2KiRQOxJFgDJlGc2XGluE
 2E4UFSGpNP1gBGr27rz4OTOKvLsdFy8eyERXyaHK/s0HdqWj7aNKTZRQF2yLCtz2V/1SXzHxwVJ
 jy7H1YGDH7TzRsucapjQ/gMD0INMMmD+ZouI4SDXh2e0347xnXK7rCsE9e1sbs04FwNSzqlwSh7
 v3Z8MAEED4RbHSCu4Xw+iyB/i0E9LPofYs5ttDgM4tj2QT6y+x3JJaejkWEtuOpzoEfFWubx4Qg
 9ozLF4fBCww+kHO6ZqiEt1nlYSgsh0NKsXDNiW0zvajqkLXpzV0aLlGmZQcLxys9EusKU1mqk0w
 d6uAwu+9iB6HGDKA8eF3yL4YyFzW3cZszwPdZ5gMK4o2JvpjpoV0PYZic065n+NXLux0UlwbbDO
 PE/SdHAX/sRZTOlNiDH4OnXaH3gZqkEDZyGTIOyoMXlMc8=
X-Received: by 2002:a17:90b:1a90:b0:3a8:1759:2217 with SMTP id
 98e67ed59e1d1-3ab3a393867mr26528758a91.2.1792024143827; 
 Wed, 14 Oct 2026 17:29:03 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac92a49d7bsm795730a91.0.2026.10.14.17.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 17:29:03 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 Michael Ellerman <mpe@kernel.org>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v5 1/3] hw/riscv/atlantis: Use dw8250 UART model
Date: Thu, 15 Oct 2026 10:28:47 +1000
Message-ID: <20261015002849.1640109-2-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015002849.1640109-1-portias@oss.tenstorrent.com>
References: <20261015002849.1640109-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x102e.google.com
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

Replace the ns16550 UART with a Designware UART now that a model is
available. The hack which sets the rest of the UART register space as
unimplemented can be removed.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/Kconfig               |  2 +-
 hw/riscv/tt_atlantis.c         | 48 +++++++++++-----------------------
 include/hw/riscv/tt_atlantis.h |  4 +--
 3 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fb05031228..d89fdfcc86 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -144,7 +144,7 @@ config TENSTORRENT
     select RISCV_ACLINT
     select RISCV_APLIC
     select RISCV_IMSIC
-    select SERIAL_MM
+    select DW8250
     select DEVICE_TREE
     select DESIGNWARE_I2C
     select DS1338
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 4e6c39982c..dfd6bc6ba6 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -24,9 +24,8 @@
 #include "hw/riscv/fdt-common.h"
 #include "hw/riscv/riscv_hart.h"
 
-#include "hw/char/serial-mm.h"
+#include "hw/char/dw8250.h"
 #include "hw/intc/riscv_aclint.h"
-#include "hw/misc/unimp.h"
 #include "hw/misc/tt_atlantis_prcm.h"
 
 #include "system/system.h"
@@ -268,11 +267,15 @@ static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
                             int irqchip_phandle, uint32_t clk_parent_phandle,
                             uint32_t clk_phandle)
 {
+    static const char * const compat[2] = {
+        "snps,dw-apb-uart", "ns16550a"
+    };
     g_autofree char *name = g_strdup_printf("/soc/serial@%"HWADDR_PRIX,
                                             mem->base);
 
     qemu_fdt_add_subnode(fdt, name);
-    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
+    qemu_fdt_setprop_string_array(fdt, name, "compatible",
+                                 (char **)&compat, ARRAY_SIZE(compat));
     qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
     qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
     qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
@@ -466,17 +469,6 @@ static void load_fdt(TTAtlantisState *ams)
     create_fdt_memory(ms->fdt, &ams->soc);
 }
 
-static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
-                                   const char *name, hwaddr addr, uint64_t size)
-{
-    qdev_prop_set_string(DEVICE(dev), "name", name);
-    qdev_prop_set_uint64(DEVICE(dev), "size", size);
-    sysbus_realize(dev, &error_abort);
-
-    memory_region_add_subregion_overlap(memory, addr,
-                                        sysbus_mmio_get_region(dev, 0), -1000);
-}
-
 static void tt_atlantis_machine_done(Notifier *n, void *data)
 {
     TTAtlantisState *ams = container_of(n, TTAtlantisState, machine_done);
@@ -545,8 +537,7 @@ static void tt_atlantis_soc_init(Object *obj)
 
     object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
 
-    object_initialize_child(obj, "uart1", &s->uart1,
-                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "uart1", &s->uart1, TYPE_DW8250);
 
     object_initialize_child(obj, "prcm-rcpu",
                             &s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU],
@@ -653,11 +644,6 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
                                 &s->bootrom);
 
-    /* UART1, the soc console (UART0 is for the boot microcontroller) */
-    serial_mm_init(s->memory, s->memmap[TT_ATL_UART1].base, 2,
-                   qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
-                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
-
     /* 4 PRCM blocks */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU]),
                         errp)) {
@@ -695,18 +681,14 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_MM]), 0));
 
-    /*
-     * Atlantis contains a DesignWare uart while the QEMU machine
-     * uses the serial_mm model with the base ns16550 register set.
-     * Linux's dw driver writes outside of serial_mm's 0x20 sized
-     * mapping and faults.
-     *
-     * Create an unimplemented device region so writes don't fault
-     * and reads return zero, which keeps Linux happy.
-     */
-    mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->uart1),
-                           "tt-atlantis.uart1", s->memmap[TT_ATL_UART1].base,
-                           s->memmap[TT_ATL_UART1].size);
+    /* UART1, the soc console (UART0 is for the boot microcontroller) */
+    qdev_prop_set_chr(DEVICE(&s->uart1), "chardev", serial_hd(0));
+    sysbus_realize(SYS_BUS_DEVICE(&s->uart1), &error_fatal);
+    memory_region_add_subregion(s->memory,
+                                s->memmap[TT_ATL_UART1].base,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart1), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart1), 0,
+                       qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ));
 
     /* I2C */
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 577c867d71..fc7a4337cc 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -13,8 +13,8 @@
 #include "hw/core/sysbus.h"
 #include "hw/i2c/designware_i2c.h"
 #include "hw/intc/riscv_imsic.h"
-#include "hw/misc/unimp.h"
 #include "hw/misc/tt_atlantis_prcm.h"
+#include "hw/char/dw8250.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
@@ -41,7 +41,7 @@ struct TTAtlantisSoCState {
     RISCVHartArrayState cpus;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
-    UnimplementedDeviceState uart1;
+    DW8250State uart1;
     MemoryRegion bootrom;
     TTAtlantisPRCMState prcm[TT_ATL_NUM_PRCM];
 
-- 
2.43.0


