Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A324CA5FC4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 03:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC7Il-0005lX-K8; Wed, 30 Sep 2026 23:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xC7Ik-0005l7-Rw
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 23:17:42 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xC7Ij-00077w-2M
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 23:17:42 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39666e7c9efso639520a91.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 20:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790824660; x=1791429460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MOliXFqEn7cqFnNRuJ0mKXRkMHRaxcJcSb/LTuddodA=;
 b=gV3JFiusK2wkjE8+T3jvO9oDtPgdMtcsXpB14UNe9rwKCHSXL0sFRh14difM14Cjli
 vJYEH8EYjQWQ9NctEmRVvN8dZol56XAWIiZ8ptFSBAcdcQgqITPb48+Ji8Pivpk9Q+OF
 B5Xm8wOGNDtIEM8p/A5Vmuxyz2h/vP4BuU8amLV9orfDKvRPZKuSfV/4yix6gGyM7iqf
 y/WsrKHptKdacxgcjt30U7//HTpQzUEDLlYejD6Wz2MEcwV62okXgj/Y4KRfdYeVajXt
 HHbUgbaVWZZXugWpDGqOmOXhgXf+tK9vnAQvSsVqGf9GDvyXpCA0DMkJ8fsYMuZIZ1QZ
 PbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790824660; x=1791429460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MOliXFqEn7cqFnNRuJ0mKXRkMHRaxcJcSb/LTuddodA=;
 b=kg3o5p+/taXs+DfjU33ZPB1TgYbIPyFsLm9gAybaYGxMFbss2QXMZtyVVF3Qnc0UQx
 u0A8JiqIIVG4sHl5D2VH9ji5Jau6ziAk5mwsF9VVodtvDFWy9P7zDj+Syct4kWxO6NKE
 o4kxuORCFjqV7RWLLdlu3Xjvk2gAeTRFjwJeonrXD1WwkfkkRWW/fVX0+0SfzeLPylRg
 3UtbKxqnAdIPgbJxg50FumeC+3D1V+l+0xW8ub5t38PaNxSXwr3gD4gUgbMpTKtIEi7x
 DfMqywQLimbrzaoGNoCoLBLV5Dy41eRcJLA7QNvJO5BwydFInvjwS65XSSgxDo4RaR4w
 lNWg==
X-Gm-Message-State: AFq9FYKcvhOffw/ZsOPVIn619jxPZW+wxyZ8L49FAizHoJzNRhdbV/PI
 Xp/IBWrCk3KIBFjl3dxdalY3fOw34xWCURnhP60D1fiCk6qILcKoIP+8KQw0VQb3IQm8w7ylggC
 WO2W0
X-Gm-Gg: AYBFou2OLr5vIENhyEOoG1OoOEMetznAe/fVf6eFIJroKi8wlrseRKz5PQeUyoA/T6B
 ImriPvbdhnkjnzStutwPpqa/YR+qLO2eniyHkTfEoOKWJdKoAFcfNsDNIMlIQOhchkAariFL1VR
 3x55rvV2pNLCUa1fVReFWMea1/sKTCCu+L60CZU1Ef7dB7OkNw3sGJE2tTrwHDwh3czDXSDP6DI
 ce7PRwr1NmCKgnu2UXpfBMSNGPdh2hZ7eeouRK81wpD+CibuKjjXTzRdlnrakp6yVrd971ewp98
 gjUZLJOcpMuLOSQ0O0QfYPIBXe7B4bRN8g1SOUkOJWti3IQc6nKCvG7zpH3XC3isu7aCLjP1QBC
 AJIBeNm7YvaArnx4aSWw6LreXy0eUDAd2ZbYNOOGO1u562IY8qzePdZMlqm/xmSrmiUadXvYjOs
 YAlO3/SgEqOuCWjhwvN5L0m4GX/IuM5h9q2KeklnKodpvTBmYHeRu/wDF/wejJ9pWMTzWD7NMKB
 Rt7x1CKL/9oAyubBRVJbPRGkSfDdQHnyE5drk0utW61ZK4=
X-Received: by 2002:a17:90b:5283:b0:3a0:8001:7d11 with SMTP id
 98e67ed59e1d1-3a4d1b046bdmr4300068a91.6.1790824659642; 
 Wed, 30 Sep 2026 20:17:39 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f43f833asm2255552a91.6.2026.09.30.20.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 20:17:39 -0700 (PDT)
From: 'Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Chao Liu <chao.liu@processmission.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>
Subject: [PATCH v2 2/4] hw/riscv/atlantis: Add all UARTs for Atlantis SoC
Date: Thu,  1 Oct 2026 13:17:18 +1000
Message-ID: <20261001031720.2334056-3-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001031720.2334056-1-portias@oss.tenstorrent.com>
References: <20261001031720.2334056-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=portias@tenstorrent.com; helo=mail-pj2-x11.google.com
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

From: Portia Stephens <portias@oss.tenstorrent.com>

Previously only the Ascalon console UART was enabled, this enables all 5
UARTs on the SoC. Only UART1 is added to the serial interface for now.
The next change will handle adding the rest of the UARTs.

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


