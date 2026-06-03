Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE90CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfaR-0004yp-Np; Wed, 03 Jun 2026 03:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUfaL-0004mf-5V
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:00:20 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUfaJ-0006dx-76
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:00:16 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c85a2ca7bf7so1409548a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 00:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780470014; x=1781074814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KET5U/K+NNsKfxB2MaQGs5abLHYbTDB804zLrrpBzhQ=;
 b=MepktE7O0sAGwasEQyCwT7yzYpNSQKqGF8qecysAcb0KFmp/pnQFX8pyT9OG/5yrpQ
 kxNh6s3TxwjkkAsRYVFsqd0pRZLXnk6c4x61pG1ThYrWszGUPfPQc+AMMuHYK7YGCzSu
 rRCgSmGNO66fWAkMPHNArIJsrOiJpCmKnOho7/4MfXg1akp63FDKywB3FqD2+yfrbbxp
 ZTnEz6R3CdnIE34lBeQF2itWBxql6pUJYqVEyZvjPOnhELGPO3qQODmBMDs48To+kzYF
 Gw2iQHePyI2a4oSH+D4H6Sn3e8+/JCYxKENE/7rFNJvzrXXm6002MJDrDVeXprpPAsoN
 Gcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780470014; x=1781074814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KET5U/K+NNsKfxB2MaQGs5abLHYbTDB804zLrrpBzhQ=;
 b=mPaah63iRwNCKz6tLDMe07liV12Wy10gaJ8PJL0Rr7UpefapxP+tfouIxMhJ9AQWUK
 oNObXOPrm92xdtSdFDVfEZNOYq6W+/R0Vb+KNHiR2QtvvMVW2tcisbkD8PfHUWLXC+jJ
 SIBcPGINYECiXyrPKg+8xSF46FI/UsoWtcdnR7rLHawX6jTd57qxC6hMNs9Sk7RCpriN
 zGtWETMh8Xt0qRPFwvN0vNe5wWLicYVGJoMlHw9TNXT86Dw49/XK9FpZQzHCoYG1YzMA
 6TjsdKV300mjWVYvVdmjrW1whcbUra2q4hnhUfsZp24oedpEaqvvsfBQ+KmMU1yAA1lf
 zkpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5BQ9MQJLctTjiIRf6Rt7kyKMXAeCsg/yaHfKR+GHFagzZ9PlCu2+Kov10xdSFVrcJkxyx9LTzMPca@nongnu.org
X-Gm-Message-State: AOJu0YwRHuGbesR6kbHHx4lmumVBjbNwvZABEtA+kz2zV+Gzam8VPtcL
 eZEcwmDwCShipNVBW462v1MqGyxlXnKouD7NMpli/7y33kGQ0FpdwtWX
X-Gm-Gg: Acq92OEhFs1fPySJD17h3VtDlym1pVt4Zani+QnKEzeFC++Iv5k9hsEiOeW4I3KYMM0
 IbbY3i/Nx9SvuFQRIBn9xaprGl3gmoLXLuAUnAqOxm33uEyVQzW1UUxpF9kI7WA6e9LB7eYbJa9
 FQBydqhyidhVQlBQPHczuybJWk3Ze73sBqkWmjheJu34Y3kCypH7jZ4++RnVFYB6HtteJ0hVxmS
 b/Xv9ZiHZMuaLwOnFhi9EX2P/xjX0HDNUpRrE7Zj//zwrxokXjSVqNto6/E+5pFwiQ2YOI9a/iD
 q/EhIjTzUTzxhyujKmFh835x9pX/mYD5hhVOu1bhAN4sV2o/05kSdq0NZGrHzVtJ2J6xjTOWAVk
 u4wHVMebRj65aiucsmkW3nE8RjZfO7oWTfRKw7ZHackmpiQahYn2A/b8B/wEyD4r9Xj4lrojIUQ
 mUZ6V6knfM2oPO7cXlRZOx8q+p50iJDF7jyhz0D1ebDcCsu4YjkJVD1JW8sdlV7ktPRs0+P1jp3
 Xq1qDmCCyksVtLd8JI0vWcBt1Vtoee9NheEWQEi5TT+phglnl2VKxp7KRJ+6P90
X-Received: by 2002:a05:6a20:c5aa:b0:3b4:6f7e:d107 with SMTP id
 adf61e73a8af0-3b49739bbbfmr2582226637.14.1780470013607; 
 Wed, 03 Jun 2026 00:00:13 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df033887sm1283261a12.2.2026.06.03.00.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 00:00:13 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 11/12] hw/riscv/atlantis: Integrate i2c controllers
Date: Wed,  3 Jun 2026 16:28:55 +0930
Message-ID: <20260603065859.592063-12-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603065859.592063-1-joel@jms.id.au>
References: <20260603065859.592063-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add DesignWare I2C controllers to the tt-atlantis machine.

Provide a fixed clock in the device tree so that the Linux driver probes
without WARNing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h | 14 ++++++++
 hw/riscv/tt_atlantis.c         | 59 ++++++++++++++++++++++++++++++++++
 hw/riscv/Kconfig               |  1 +
 3 files changed, 74 insertions(+)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index a17732ce8114..7f7d4a5a5905 100644
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
@@ -27,11 +30,17 @@ struct TTAtlantisState {
 
     RISCVHartArrayState soc;
     DeviceState *irqchip;
+    DesignWareI2CState i2c[TT_ATL_NUM_I2C];
 
     int fdt_size;
 };
 
 enum {
+    TT_ATL_I2C0_IRQ = 33,
+    TT_ATL_I2C1_IRQ = 34,
+    TT_ATL_I2C2_IRQ = 35,
+    TT_ATL_I2C3_IRQ = 36,
+    TT_ATL_I2C4_IRQ = 37,
     TT_ATL_UART1_IRQ = 39,
 };
 
@@ -40,6 +49,11 @@ enum {
     TT_ATL_BOOTROM,
     TT_ATL_DDR_LO,
     TT_ATL_DDR_HI,
+    TT_ATL_I2C0,
+    TT_ATL_I2C1,
+    TT_ATL_I2C2,
+    TT_ATL_I2C3,
+    TT_ATL_I2C4,
     TT_ATL_MAPLIC,
     TT_ATL_MIMSIC,
     TT_ATL_SAPLIC,
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 5de138578b48..b1ff0cbe2f61 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -53,6 +53,11 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_ACLINT] =           { 0xa2180000,       0x10000 },
     [TT_ATL_SIMSIC] =           { 0xa4000000,      0x200000 },
     [TT_ATL_MAPLIC] =           { 0xcc000000,     0x4000000 },
+    [TT_ATL_I2C0] =             { 0xd4040000,       0x10000 },
+    [TT_ATL_I2C1] =             { 0xd4050000,       0x10000 },
+    [TT_ATL_I2C2] =             { 0xd4060000,       0x10000 },
+    [TT_ATL_I2C3] =             { 0xd4070000,       0x10000 },
+    [TT_ATL_I2C4] =             { 0xd4080000,       0x10000 },
     [TT_ATL_UART1] =            { 0xd4110000,       0x10000 },
     [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
@@ -333,10 +338,40 @@ static void create_fdt_rng(void *fdt)
     qemu_fdt_setprop(fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_seed));
 }
 
+static void create_fdt_clk(void *fdt, const char *clock_name,
+                           uint32_t freq, uint32_t phandle)
+{
+    g_autofree char *name = g_strdup_printf("/clocks/%s", clock_name);
+
+    qemu_fdt_add_path(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "fixed-clock");
+    qemu_fdt_setprop_string(fdt, name, "clock-output-names", clock_name);
+    qemu_fdt_setprop_cell(fdt, name, "#clock-cells", 0);
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", freq);
+    qemu_fdt_setprop_cell(fdt, name, "phandle", phandle);
+}
+
+static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
+                           uint32_t irqchip_phandle, uint32_t clk_phandle)
+{
+    g_autofree char *name = g_strdup_printf("/soc/i2c@%"HWADDR_PRIX, mem->base);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "snps,designware-i2c");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle);
+    qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
+    qemu_fdt_setprop_cell(fdt, name, "clocks", clk_phandle);
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 100000);
+    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
+    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
+}
+
 static void finalize_fdt(TTAtlantisState *s)
 {
     uint32_t aplic_s_phandle = next_phandle();
     uint32_t imsic_s_phandle = next_phandle();
+    uint32_t periph_clk_phandle = next_phandle();
     void *fdt = MACHINE(s)->fdt;
 
     create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
@@ -350,6 +385,15 @@ static void finalize_fdt(TTAtlantisState *s)
 
     create_fdt_uart(fdt, &s->memmap[TT_ATL_UART1], TT_ATL_UART1_IRQ,
                     aplic_s_phandle);
+
+    create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
+
+    for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
+        create_fdt_i2c(fdt,
+                       &s->memmap[TT_ATL_I2C0 + i],
+                       TT_ATL_I2C0_IRQ + i,
+                       aplic_s_phandle, periph_clk_phandle);
+    }
 }
 
 static void create_fdt(TTAtlantisState *s)
@@ -581,6 +625,21 @@ static void tt_atlantis_machine_init(MachineState *machine)
                                 s->memmap[TT_ATL_UART1].base,
                                 s->memmap[TT_ATL_UART1].size);
 
+    /* I2C */
+    for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
+        SysBusDevice *sbd;
+
+        object_initialize_child(OBJECT(s), "i2c[*]", &s->i2c[i],
+                                TYPE_DESIGNWARE_I2C);
+        sbd = SYS_BUS_DEVICE(&s->i2c[i]);
+        sysbus_realize(sbd, &error_fatal);
+        memory_region_add_subregion(system_memory,
+                                    s->memmap[TT_ATL_I2C0 + i].base,
+                                    sysbus_mmio_get_region(sbd, 0));
+        sysbus_connect_irq(sbd, 0,
+                           qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ + i));
+    }
+
     /* Load or create device tree */
     if (machine->dtb) {
         load_fdt(s);
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index aaf029c9ed5e..38180a903fbf 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -129,6 +129,7 @@ config TENSTORRENT
     select RISCV_IMSIC
     select SERIAL_MM
     select DEVICE_TREE
+    select DESIGNWARE_I2C
 
 config XIANGSHAN_KUNMINGHU
     bool
-- 
2.47.3


