Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A939CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZ3R-0001LX-KN; Tue, 16 Jun 2026 15:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wZZ39-0001Hq-DJ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:02:16 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wZZ36-0007US-Cw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:02:14 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8423b08b293so2461804b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781636531; x=1782241331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTCwpCF51RY4lRUcaJPa9zU/4fcfYbZj1EPKJSo44zo=;
 b=l4Q3ZnDxm8bMUGEUgs2CW1MxfI/0xFbwhs73c+TiD6sWAOStFyKuZku1Oy8dfzlT+t
 04h8jNgFtnvdD75ucXkcydV/MDm/l3LK5NP900YXoxTj1ksKFXQzwxWH6OwTME5WLZCf
 4T7yYN7CXj6EUzIgU/6c9ErBvNdTSuTFQuKsYKc/dYFNL55D9Lg+2PbTLBcGgDwee3m9
 fKaLB7hLwAF6uNS7qJig45sNjkqZYNnjv8mnJoeMCcn0V7qErAffijBSD5xyNQDiTD9/
 QCYcbEw5w2vZi8Agp5+Hk7dNl17Cu80wn9zoTbWI5I5nR9zkeaydkceCK75Iu+rIWlNC
 Rhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636531; x=1782241331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JTCwpCF51RY4lRUcaJPa9zU/4fcfYbZj1EPKJSo44zo=;
 b=pDzaq9b50UcjBJiDtyjMmshaheF9KyyFoBgwslYO5FYa6NA22fVn+YMAngc06DzNyV
 PlN8/qxeDvl4/Jv63p8kx2meOYgMvvDSLjLNEunZKA2VgVeU9odNP5jsjtOXENSqnGNx
 Bgb/sR/jmmAeZjB+t60KjKbM9MM+8S5djODkIFlqO22Af5K1HDq2COHkGE5mhWRCkWGq
 KHVfte+/ggng6FwFs8ZCAJSpXJPE231VXtFRgPA1qM0AD+DkNiR5EaepP3XZnzAEKqrs
 P2k9z+XSHzE5jizerPMMp7JL16D+KqDiei++F+5SIBqYa0D8Lxcu4SieK9Of+BN9P+wW
 MTLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ81VBfQPLCcROGHbkCTzBdc/1aCstkd+ltpVrZWmW/8O48Umx8ha46WZN8NXmqG0aAIJz2JKIU3tXKm@nongnu.org
X-Gm-Message-State: AOJu0Yz8K/03wMKWZXIkoa65WFdeEtyQN58P5ziTiUtujWRZjK8NQfV0
 Khfr8swEqwWeo8N+OyRZaTtmXxYQoKT/AzK2U5TA1GJJB2P8ak6tgdtd
X-Gm-Gg: Acq92OEeQxcHxI+SujQVf5XbIIgoJR0gGSXnNRdRix0RETRG5nJE/mcPgWVnk7qrAzb
 Nsc6m8dn6ccmtBMQFDwG3e5Zk/48Kx0yU0dJXrhXehKUuY32/KhA9E9GXeVH7YXAEZjceA2iPaJ
 fp218YIO+SIO+fimHIapR0+JLVbd2CZZmee4VGnAv0hIen/SCl6ZUo58U7usIzyaCwoIez0crAj
 BPKIGCsilvjUqtXbNYwsYk+wAR00Vg7/eG6UxNdxdn17OzEwCvjtdnTspUNz8FzXLzJrGNKVjdT
 mTvdJ0KRoD6dZoLyy5/KXHUI9zEYLx6ytBl93dCDdb5N73ZeGfQjtAItIhYg489LY3/60Qd4fe+
 EQ0wk0MT7Sep3bWXZw9+OmO2uipGUvf9fMgUVneIs/1r9XyWrzKTOJbdqH703DtJ5bBIo9biMNa
 GmhU0wvVgMb0AIHJvn45bhLRt+v1az4kyIlSD3Kv5cmyJMFjq6/J+yB9NuSoo9IAE97BBMN8zuH
 +Ru+12PZ6gJnc43uwYdCar1vnJfGnBe1w==
X-Received: by 2002:a05:6a00:a20b:b0:842:4982:82a with SMTP id
 d2e1a72fcca58-845247b90a2mr327776b3a.45.1781636530669; 
 Tue, 16 Jun 2026 12:02:10 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c474sm12671540b3a.2.2026.06.16.12.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:02:10 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair.francis@wdc.com,
 farosas@suse.de, lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 1/5] hw/char: Add dw8250 UART
Date: Tue, 16 Jun 2026 19:01:43 +0000
Message-ID: <20260616190147.1286316-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616190147.1286316-1-visitorckw@gmail.com>
References: <20260616190147.1286316-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=visitorckw@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add the dw8250 uart support. This hardware is a widely used 16550A
derivative that includes additional registers.

Without this specific device support, the Linux 8250_dw driver fails to
probe the extended registers (UCV, CPR, etc.), which are essential for
correct feature detection:

[    0.293566] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.306929] Oops - store (or AMO) access fault [#1]
[    0.307020] Modules linked in:
[    0.307192] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0 #1 PREEMPTLAZY
[    0.307250] Hardware name: Milk-V Duo (DT)
[    0.307294] epc : dw8250_setup_port+0x22/0x520
[    0.307504]  ra : dw8250_probe+0x57e/0x5b8
[    0.307518] epc : ffffffff80708dd6 ra : ffffffff8070a49e sp : ffffffc60000b820
[    0.307525]  gp : ffffffff81a32ba8 tp : ffffffd602180cc0 t0 : 0000000000000073
[    0.307533]  t1 : 000000000000006c t2 : 0000000000000000 s0 : ffffffc60000b830
[    0.307539]  s1 : ffffffd6028c8640 a0 : ffffffc60000b848 a1 : ffffffff813162c1
[    0.307546]  a2 : ffffffff813162c0 a3 : ffffffd6028c8640 a4 : ffffffc60002d0b4
[    0.307552]  a5 : 0000000000000001 a6 : 0000000000000094 a7 : 0000000000000060
[    0.307558]  s2 : ffffffd60225d410 s3 : ffffffd60225d400 s4 : 0000000000000000
[    0.307573]  s5 : ffffffff80e31a48 s6 : 0000000000000008 s7 : 0000000000000000
[    0.307584]  s8 : 0000000000000149 s9 : 0000000000000000 s10: 0000000000000000
[    0.307590]  s11: 0000000000000000 t3 : ffffffd602007c00 t4 : ffffffff81601540
[    0.307604]  t5 : 0000000000000003 t6 : ffffffd602a42f82 ssp : 0000000000000000
[    0.307611] status: 0000000200000120 badaddr: ffffffc60002d0b4 cause: 0000000000000007
[    0.307652] [<ffffffff80708dd6>] dw8250_setup_port+0x22/0x520
[    0.307695] [<ffffffff8070a49e>] dw8250_probe+0x57e/0x5b8
[    0.307702] [<ffffffff80731f0e>] platform_probe+0x46/0x80
[    0.307708] [<ffffffff8072f67c>] really_probe+0x84/0x22c
[    0.307715] [<ffffffff8072f880>] __driver_probe_device+0x5c/0xd4
[    0.307721] [<ffffffff8072f9be>] driver_probe_device+0x2e/0xf4
[    0.307727] [<ffffffff8072fbe6>] __driver_attach+0x6e/0x14c
[    0.307734] [<ffffffff8072d5f0>] bus_for_each_dev+0x60/0xb0
[    0.307740] [<ffffffff8072f1b2>] driver_attach+0x1a/0x24
[    0.307746] [<ffffffff8072e8da>] bus_add_driver+0xca/0x1d8
[    0.307752] [<ffffffff80730aaa>] driver_register+0x3e/0xdc
[    0.307757] [<ffffffff80731c54>] __platform_driver_register+0x1c/0x24
[    0.307779] [<ffffffff80c334f6>] dw8250_platform_driver_init+0x1a/0x24
[    0.307793] [<ffffffff80011992>] do_one_initcall+0x4e/0x2a4
[    0.307800] [<ffffffff80c01362>] kernel_init_freeable+0x226/0x2b0
[    0.307807] [<ffffffff80bc3798>] kernel_init+0x1c/0x144
[    0.307813] [<ffffffff8001361c>] ret_from_fork_kernel+0x18/0x164
[    0.307820] [<ffffffff80bcefb6>] ret_from_fork_kernel_asm+0x16/0x18
[    0.307914] Code: 3683 2085 0b63 32f7 000f 0140 6918 4785 0713 0b47 (c31c) 2583
[    0.308041] ---[ end trace 0000000000000000 ]---
[    0.308180] Kernel panic - not syncing: Fatal exception in interrupt
[    0.315760] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 hw/char/Kconfig          |   4 ++
 hw/char/dw8250.c         | 118 +++++++++++++++++++++++++++++++++++++++
 hw/char/meson.build      |   1 +
 include/hw/char/dw8250.h |  27 +++++++++
 4 files changed, 150 insertions(+)
 create mode 100644 hw/char/dw8250.c
 create mode 100644 include/hw/char/dw8250.h

diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 020c0a84bb..418d99b757 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -95,3 +95,7 @@ config IP_OCTAL_232
     bool
     default y
     depends on IPACK
+
+config DW8250
+    bool
+    select SERIAL
diff --git a/hw/char/dw8250.c b/hw/char/dw8250.c
new file mode 100644
index 0000000000..4ec829ceaf
--- /dev/null
+++ b/hw/char/dw8250.c
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Synopsys DesignWare APB UART (DW 8250)
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/char/dw8250.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+
+#define DW_UART_REGION_SIZE 0x100
+
+#define DW_UART_RE_EN 0xB4 /* Receiver Output Enable Register */
+#define DW_UART_DLF   0xC0 /* Divisor Latch Fraction Register */
+#define DW_UART_CPR   0xF4 /* Component Parameter Register */
+#define DW_UART_UCV   0xF8 /* UART Component Version */
+#define DW_UART_CTR   0xFC /* Component Type Register */
+
+#define DW_UART_UCV_VALUE 0x3332332A /* "323*" -> v3.23a */
+#define DW_UART_CTR_VALUE 0x44570110 /* "DW" */
+
+static uint64_t dw8250_ext_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    switch (addr) {
+    case DW_UART_UCV:
+        return DW_UART_UCV_VALUE;
+    case DW_UART_CPR:
+        return 0x00000000; /* No advanced features (DMA, extra FIFOs) */
+    case DW_UART_CTR:
+        return DW_UART_CTR_VALUE;
+
+    case DW_UART_RE_EN:
+    case DW_UART_DLF:
+        /*
+         * Return 0 to indicate these optional features
+         * (RS485 and Fractional Divisor) are not implemented.
+         */
+        return 0x00000000;
+
+    default:
+        return 0;
+    }
+}
+
+static void dw8250_ext_write(void *opaque, hwaddr addr, uint64_t val, unsigned int size)
+{
+}
+
+static const MemoryRegionOps dw8250_ext_ops = {
+    .read = dw8250_ext_read,
+    .write = dw8250_ext_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void dw8250_instance_init(Object *obj)
+{
+    DW8250State *s = DW8250(obj);
+
+    s->serial_mm = qdev_new("serial-mm");
+    object_property_add_child(obj, "serial-mm", OBJECT(s->serial_mm));
+    object_property_add_alias(obj, "chardev", OBJECT(s->serial_mm), "chardev");
+}
+
+static void dw8250_realize(DeviceState *dev, Error **errp)
+{
+    DW8250State *s = DW8250(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    SysBusDevice *serial_sbd = SYS_BUS_DEVICE(s->serial_mm);
+
+    memory_region_init(&s->container, OBJECT(dev), "dw8250-container",
+                       DW_UART_REGION_SIZE);
+    sysbus_init_mmio(sbd, &s->container);
+
+    qdev_prop_set_uint8(s->serial_mm, "regshift", s->regshift);
+    qdev_prop_set_uint8(s->serial_mm, "endianness", DEVICE_LITTLE_ENDIAN);
+    sysbus_realize(serial_sbd, errp);
+
+    memory_region_init_io(&s->ext_iomem, OBJECT(dev), &dw8250_ext_ops, s,
+                          "dw8250-ext", DW_UART_REGION_SIZE);
+    memory_region_add_subregion(&s->container, 0, &s->ext_iomem);
+
+    memory_region_add_subregion_overlap(&s->container, 0,
+                                        sysbus_mmio_get_region(serial_sbd, 0), 1);
+
+    sysbus_pass_irq(sbd, serial_sbd);
+}
+
+static const Property dw8250_properties[] = {
+    DEFINE_PROP_UINT8("regshift", DW8250State, regshift, 2),
+};
+
+static void dw8250_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = dw8250_realize;
+    device_class_set_props(dc, dw8250_properties);
+}
+
+static const TypeInfo dw8250_info = {
+    .name          = TYPE_DW8250,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(DW8250State),
+    .instance_init = dw8250_instance_init,
+    .class_init    = dw8250_class_init,
+};
+
+static void dw8250_register_types(void)
+{
+    type_register_static(&dw8250_info);
+}
+
+type_init(dw8250_register_types)
diff --git a/hw/char/meson.build b/hw/char/meson.build
index fc3d7ee506..b2250ee6ae 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -38,6 +38,7 @@ system_ss.add(when: 'CONFIG_STM32L4X5_USART', if_true: files('stm32l4x5_usart.c'
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfsoc_mmuart.c'))
 system_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
 system_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.c'))
+system_ss.add(when: 'CONFIG_DW8250', if_true: files('dw8250.c'))
 
 specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
diff --git a/include/hw/char/dw8250.h b/include/hw/char/dw8250.h
new file mode 100644
index 0000000000..59396ad202
--- /dev/null
+++ b/include/hw/char/dw8250.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Synopsys DesignWare APB UART (DW 8250)
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#ifndef HW_CHAR_DW8250_H
+#define HW_CHAR_DW8250_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_DW8250 "dw8250"
+OBJECT_DECLARE_SIMPLE_TYPE(DW8250State, DW8250)
+
+struct DW8250State {
+    SysBusDevice parent_obj;
+
+    MemoryRegion container;
+    MemoryRegion ext_iomem;
+    DeviceState *serial_mm;
+
+    uint8_t regshift;
+};
+
+#endif
-- 
2.54.0.1136.gdb2ca164c4-goog


