Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A76CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBOL6-0004h1-D8; Mon, 28 Sep 2026 23:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xBOL4-0004gU-Fh
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 23:17:06 -0400
Received: from mail-pj2-x2b.google.com ([2607:f8b0:4864:39::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xBOL2-0006vi-As
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 23:17:05 -0400
Received: by mail-pj2-x2b.google.com with SMTP id
 98e67ed59e1d1-3a4a33ed59fso27032a91.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 20:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790651821; x=1791256621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BCC9M5RTcfHqMUR/mLr4D6h55OxLm/exnu4LPYDyyW0=;
 b=YgWLqX/6HmhjhTKrFw2hoyrrjJr108jDG0ceNpRXXb05wLUlXugvu+1ZtmbwesIqu7
 sXtZkEDzGmml5EhlFb21Km82oBqCCC+qNITzSKxBG+R4GqS/A0zETqdylry4iJ+FVl5b
 mIGstdKz6Nv6+9rvA3gEmISG8MVS9+LN8Jho/xdHpMywIki3g0X6YPKcdtC+ZDUjs+xY
 LnWJy/R+Az9eEs/yQQEoNXhSnrqYl89xS5Rb7YtrXmYlyN4ZxiqWesrNVVwW5b2svcYr
 Xg/90DdCM1zVreDelwpJA4suVA43MRUL8nVyr09zkmQ8Dqt8R3+nQIbG3f2SDfPfg3wt
 VT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790651821; x=1791256621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BCC9M5RTcfHqMUR/mLr4D6h55OxLm/exnu4LPYDyyW0=;
 b=1IF+bSkHCeiLv7bWxxB0LFcmfg2dA1MJzA0JK/GcAkG1xKDvnDHTi5C31dzO1xSTVQ
 H0ozldlT6qAWZ+szCkhtgVGz9IQu1igjc08WzkfCv/dFZOfxhHQ6oq7lCZ5Tx3YV36CW
 0/n2CVtUp83NNdmU8wFyqZaAINABCpwwGz9FE/ZHDhn/r1kYJOM51pSbt6h8dTeqDHyG
 ULV2XMCC7p1F/BZsLET2IPxcwqKlrfN2gTAyXRBLbRo9j/jRNCZyWCw6wUeiXHv3sSLI
 lUpdkx5QbqtrT0mPAGIsmEp4pBz8IxPBU2QULW8x0ceBpMDiGUx0ZgVK6N5cQPWg5Jqw
 PTSg==
X-Gm-Message-State: AFq9FYIG3st3Kfb/c129UQe8W0Xz3ReEZu3cw15kTHSuf/chZ6SvEjYo
 P/0xPjjwojXBsGjiY73mtZW3vP48a7mQ1YeXBZ3/QnPp57v+GbW3VY8rZCuoCc1EkAZqcL3d4cH
 NhCWoZNI=
X-Gm-Gg: AYBFou22ID1aoXQMX8pgG01zaVxjlkMoAhj1KS0nVv4Cm36VVsunT6Nvr7E3SGgXZcr
 hClsZ5Vwei0FDqF2JcmwN3NeSnyU4qGe7C4CtjuSs/dW6RKtHZq6IMFRMTpv9VxGiZnxxJ5MKxi
 pwoHSPPQD+XmKdbjN3+YymBgl6zr0FjCfyjPsEb+J9q6C6N6I7nLHCHw/ZwBKy+0u5yf6o5wIxI
 1LXye5szYgSR4PxppWGNkIuz5S6qPUk+mIppHrd3Y1LALJ2XZ/jmGqsMn5Bmj+JyDd2DVvf+P+L
 tmK3+JzIRZJP+Q0XQEUUn+5grNmoHZZzmZ7JRKGtcwh8c8hQQAaiRqyRfOXi7gDoao1hnmwB4Iz
 hfNO67G2bUvoOe6JQ0u3yZw6mlLXfSx1DT6AqoELs2vEhpfhiOAz1iKhh60weVj27PSrwu3aNbn
 5V3OkU06aYN/urovdjuZLWKWjdBoFpOpe0Hh51IRsokdC34elAgl0gshWOdMtsvDWi/rhsFr4/y
 HpfbujY3ITTBNx5TOI5tUMAl8eBr1uvd5khfU4CifW18O0=
X-Received: by 2002:a17:90b:254e:b0:3a0:238b:db4d with SMTP id
 98e67ed59e1d1-3a098dc0266mr20932867a91.5.1790651821282; 
 Mon, 28 Sep 2026 20:17:01 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a492dfc5absm1563641a91.3.2026.09.28.20.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 20:17:00 -0700 (PDT)
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
Subject: [PATCH 2/5] hw/riscv/atlantis: Use dw8250 UART model
Date: Tue, 29 Sep 2026 13:16:41 +1000
Message-ID: <20260929031644.1016354-3-portias@oss.tenstorrent.com>
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

Replace the ns16550 UART with a Designware UART now that a model is
available. The hack which sets the rest of the UART register space as
unimplemented can be removed.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 hw/riscv/Kconfig               |  2 +-
 hw/riscv/tt_atlantis.c         | 41 +++++++++-------------------------
 include/hw/riscv/tt_atlantis.h |  4 ++--
 3 files changed, 14 insertions(+), 33 deletions(-)

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
index 8a219afef7..e889951677 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -24,7 +24,7 @@
 #include "hw/riscv/fdt-common.h"
 #include "hw/riscv/riscv_hart.h"
 
-#include "hw/char/serial-mm.h"
+#include "hw/char/dw8250.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/misc/unimp.h"
 
@@ -262,11 +262,12 @@ static void create_fdt_cpu(void *fdt, TTAtlantisSoCState *s,
 static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
                             int irqchip_phandle)
 {
+    static const char compat[] = "snps,dw-apb-uart\0ns16550a";
     g_autofree char *name = g_strdup_printf("/soc/serial@%"HWADDR_PRIX,
                                             mem->base);
 
     qemu_fdt_add_subnode(fdt, name);
-    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
+    qemu_fdt_setprop(fdt, name, "compatible", compat, sizeof(compat));
     qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
     qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
     qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
@@ -409,17 +410,6 @@ static void load_fdt(TTAtlantisState *ams)
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
@@ -488,8 +478,7 @@ static void tt_atlantis_soc_init(Object *obj)
 
     object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
 
-    object_initialize_child(obj, "uart1", &s->uart1,
-                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "uart1", &s->uart1, TYPE_DW8250);
 
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
         object_initialize_child(obj, "i2c[*]", &s->i2c[i],
@@ -584,21 +573,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
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


