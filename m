Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B21CA5FE1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCQHX-0003RW-F4; Thu, 01 Oct 2026 19:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xCQHV-0003R3-SO
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 19:33:41 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xCQHU-0002Br-1L
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 19:33:41 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 d9443c01a7336-2df8a4eac2aso3917365ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790897619; x=1791502419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Usb3J/CszNW/AvO0rKKglFAwXucL/cNKskKSFigipT4=;
 b=Z7pEwQEazHCZt731UdF5UUYNVqUIqsO7mZn/o21BXoeqflngdEyK98FKb+WCtC4+iL
 LtR89gC/57rKIV2NO15RJx7w0FHBpw4IsvVxfmifaKcuQqBpDj4RzQ8M+5ttefJovWjf
 seWgGXJHox6e4VR5lIyWG6Yn/ptQMgzK1pwG25SszUQT7STWt3kF+v3YJly/U/Utselt
 FAOMYnvSv2oaVTNbNzfxdx82CqteCCFs9wrifwpMmRIRHSLTF589rj1spJt2lZ5rDNF1
 ivy3e4+0XvDZkqvZBIBZUUISlTPPNYcY1BtDvWgjoVOAZEyBBHMUY0SCN1YPZ1U8C1q9
 4ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790897619; x=1791502419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Usb3J/CszNW/AvO0rKKglFAwXucL/cNKskKSFigipT4=;
 b=vup9zhPxx9O2pAJUnV5jUx5iOCQA9hpA15g7zHZRldvL/0SruomcMZ4gnIxI8PgOAg
 cIszSat3uDV+58/VzUkUzppz+XbzoGHnocH3iKA74iyHdIVi6L9+DoZeUGsF1T4Enyl5
 fo1KOtKcFw3FSy6UbEkd/q1FU0y8BcAZaAkmQz9T+9iO+GlpZ6OumzVoC8tgtCHBxY0u
 aGhtzb2OcjFszqItoDT5VDtMKz4LCxaBsBoXxdC4unGtrXShY9y29A5f85yfT6YKPIiT
 BgfK8in+fJ4NRE/jOir0QEAT3jkqi3fxrP80l/sk7c/J/sB0vPQ0ox7cCfH6mrOMkhtz
 U6sQ==
X-Gm-Message-State: AFq9FYKS7a8O7PCyeqZsrHUmUnbSzdtKZwvLJvW1uxZ5pRaBqgQ8l+sm
 v9nil5AdF3QFCWTB0kgBtA0lJHLKhUTPU4tZjgONvkwwIVrp0sRVSXHz0sT+FemVA00SuRyF4m4
 BF+UJm7Y=
X-Gm-Gg: AYBFou0+zz43frT8GhZEdMAvFipH9vDhegoJAIdkIG+EzFSz3DBqRRvGpXF4mLhezGo
 Ki3ReyKMxvGhhecM7vruU53w9IM4o/qrFtmBpNn4PxOfOq7xysJWa9Yf79kg9dwPaBsRiCC7BB3
 BlCYuZC/B1+YWBGUoJ2nMKwJORzw7mwzFDdVenzZJ5pqwDplL14vAC4KzZmKNxrKg2IbewTTz2p
 qy6EsLBv/NPI+RXA1tG5BOnrN4fYdjA+hoHjEPIBykmu9bZd4DhBzGcykmeUEEHjEZlpoE4tnQe
 aclZeYaHAn8IHC+i0vz0wBZrZIJ7Hp2IuEhjHPEc8V4mN9ekHGyGtugpznmInLwVLiHyXxPdML+
 Xd7ldCAuXVrJczSQfykIHb31R+Y1rolIB6Z3HyxE2MLizR801nM/A11F5ZgtjAUWXyuG4TQLsXc
 E7saiyU9+S7dml2j430lYqt9YkfXGqWr1TKwtVgPDp89WD1ZrzMQIXIC6cFYszUr65oTiYn4mDB
 gQdc1kc+Xs/LTqt+RgUbhELIc78vQglNwQSgSnGNT8dkNXU
X-Received: by 2002:a17:902:f709:b0:2dd:b95a:e1db with SMTP id
 d9443c01a7336-2e49b61ecddmr13008465ad.3.1790897618529; 
 Thu, 01 Oct 2026 16:33:38 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6aea97sm1851855ad.45.2026.10.01.16.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 16:33:38 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v3 1/4] hw/riscv/atlantis: Use dw8250 UART model
Date: Fri,  2 Oct 2026 09:33:21 +1000
Message-ID: <20261001233324.2636629-2-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001233324.2636629-1-portias@oss.tenstorrent.com>
References: <20261001233324.2636629-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=portias@tenstorrent.com; helo=mail-pj2-x0e.google.com
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
---
 hw/riscv/Kconfig               |  2 +-
 hw/riscv/tt_atlantis.c         | 45 +++++++++++-----------------------
 include/hw/riscv/tt_atlantis.h |  4 +--
 3 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index d06ac26648..5d2abdbb67 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -127,7 +127,7 @@ config TENSTORRENT
     select RISCV_ACLINT
     select RISCV_APLIC
     select RISCV_IMSIC
-    select SERIAL_MM
+    select DW8250
     select DEVICE_TREE
     select DESIGNWARE_I2C
     select DS1338
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 8a219afef7..70815e12ef 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -24,9 +24,8 @@
 #include "hw/riscv/fdt-common.h"
 #include "hw/riscv/riscv_hart.h"
 
-#include "hw/char/serial-mm.h"
+#include "hw/char/dw8250.h"
 #include "hw/intc/riscv_aclint.h"
-#include "hw/misc/unimp.h"
 
 #include "system/system.h"
 #include "system/device_tree.h"
@@ -262,11 +261,15 @@ static void create_fdt_cpu(void *fdt, TTAtlantisSoCState *s,
 static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
                             int irqchip_phandle)
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
@@ -409,17 +412,6 @@ static void load_fdt(TTAtlantisState *ams)
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
@@ -488,8 +480,7 @@ static void tt_atlantis_soc_init(Object *obj)
 
     object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
 
-    object_initialize_child(obj, "uart1", &s->uart1,
-                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "uart1", &s->uart1, TYPE_DW8250);
 
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
         object_initialize_child(obj, "i2c[*]", &s->i2c[i],
@@ -584,21 +575,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
                                 &s->bootrom);
 
     /* UART1, the soc console (UART0 is for the boot microcontroller) */
-    serial_mm_init(s->memory, s->memmap[TT_ATL_UART1].base, 2,
-                   qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
-                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
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
index 3923308b7c..000988c037 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -13,7 +13,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/i2c/designware_i2c.h"
 #include "hw/intc/riscv_imsic.h"
-#include "hw/misc/unimp.h"
+#include "hw/char/dw8250.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
@@ -39,7 +39,7 @@ struct TTAtlantisSoCState {
     RISCVHartArrayState cpus;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
-    UnimplementedDeviceState uart1;
+    DW8250State uart1;
     MemoryRegion bootrom;
 
     uint32_t num_harts;
-- 
2.43.0


