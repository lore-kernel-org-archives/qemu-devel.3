Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BD0CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpbD-0001W1-UV; Tue, 13 Oct 2026 23:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xGpb1-0001S3-KB
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:24:03 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xGpaz-0000BV-Mt
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:24:03 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3a47d4fb7feso224078a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1791948240; x=1792553040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Usb3J/CszNW/AvO0rKKglFAwXucL/cNKskKSFigipT4=;
 b=CXPBY1AjHTS16Ue6K9KoS3mLL3TRq5QHEwW15e6wL/50kO4pMNO590o5lgAmh+cYNF
 tmdD4cUlN8GovFkmFhaCqXMU9a4b58bRcOecuvp6EatsjE1VQ40C2kqhpJ/AHpMQrdCV
 HE8p5e6lRTXyK1GNHgdCjhzoBz6UbWzsQnwgM6K4IiduUFpnh2G0JDrqdHBA0Yf+2noD
 zc8QpnjIfM1SdnKhm2j0QTr6c+rSyuB4WjMFVnTvwSfzZE3R70FixMAt6ROhyl+XH39u
 ueqQu8hLK5C/VVuY1xCNjMplt4D9gB6puc5bqQY+10ZCLX7LqH6Z7IxfmKP7xwkh4YRf
 iWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791948240; x=1792553040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Usb3J/CszNW/AvO0rKKglFAwXucL/cNKskKSFigipT4=;
 b=VVAM5Pi7rhf+EWS9ghFTjIMo/U80OYPlP6IUcN8DQ6EGigUbmkjUIJmqBbv77epIAG
 E3flf0F8mVG7OfE3b3jiql3AO/9g/G4rXqUl+7uKIYqz/Ty5haFasPqEzF+MeEdkJFKr
 cvL0vVZaJRe/X09etE/m/U4P9PZr170bIO4aG+iQ/sgRv1H/x4JgMZrTR48wr54DZ9rD
 85v0KROphvciFHYhTpe1UFYAMnftf1MwlxtBVtTZ7Lk7LVVqMhKL+8R6aaaRQbOtQjX1
 LRXznVq2lxesAfVjJTlvMPvgnJfJTcYqCAh2oPmv18a71egyrVvxtLXTVZrq8395VOmB
 jx9w==
X-Gm-Message-State: AFq9FYK0/1nDdvVWCp9iFrvXatYLOy9/VLnQebBCq7ZDhxK7ihT+1g3A
 m/IUeVz33QoucAC8p3a4d6UKvyyT1Cm9eR9hp9Yq2ZU+qf21e+14ysYaUzCbR+mLFdxo/TNQrv8
 RXnrBQFM=
X-Gm-Gg: AYBFou0ry32OgxEfluqEbclSTzCwnVzDSZWhm3lg2FfNczAFE/NOZQPF3Kr2OLqeCeL
 C4jUae3niiCWHq2WQLBtSBKP7edVTd32rIaWe49AAUupc+omnf+Cd+mUko2j3C0wrHqkHr2p2Ky
 as140NfPf7/jFuZV+1DsRQIwAJh3aHr3fYyDSB7xpCHuO4TcSeOaxE0EIb7KgrzSowdN/NVAeD8
 JWn7V7Z+CjjvOsc7lEiS6HTaay/YA3fKNPuL0WBsXskBHmqv6OOBwwxV/QHoRRRXeOx/rkpuDhx
 9y3kyJ04h9FdeujY3DTj53vPPSsn5I/uuAb+Y/S2ZGOQnN7xWH2zr31nkuaQJEqaBGhgAA1g7sU
 g52bZbq8bAfRw4uaYvrLQjf+l8IW+KcO9kH6bHeSrLTghw8pP19fP9yMGduitJYYlywBMh6w1MU
 wmHA81ZJIyulUAt1AkN8AIMk9jHgPasLf1vwvpNXShLlCeKqWMnPod1eir90NexIufeFeILq5m0
 jUoIVglYO4cZpbWPhh9e0grswRSze3cqM6j/WDes3cMFDY=
X-Received: by 2002:a17:90b:224e:b0:3a8:9db2:a59 with SMTP id
 98e67ed59e1d1-3ab3a0f0a2amr20618986a91.0.1791948240483; 
 Tue, 13 Oct 2026 20:24:00 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac6069ca15sm2211261a91.11.2026.10.13.20.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:24:00 -0700 (PDT)
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
Subject: [PATCH v4 1/3] hw/riscv/atlantis: Use dw8250 UART model
Date: Wed, 14 Oct 2026 13:23:44 +1000
Message-ID: <20261014032346.732257-2-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014032346.732257-1-portias@oss.tenstorrent.com>
References: <20261014032346.732257-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


