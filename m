Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236B9C53200
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 12:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnxzi-0002rJ-5X; Sun, 26 Jul 2026 08:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxzQ-0002Hm-Hv
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:29:57 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wnxzM-0003MC-SI
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 08:29:56 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-84a2c90e383so1858407b3a.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 05:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785068992; x=1785673792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o25qBdrbB0cCxrdOmXBhSEsyH8Q+W880TO/mlWSZJuU=;
 b=ZM+YHXYD+X0Z+A5MFlV7heJjb+G4CUR4eeQOvazH7UdUnbEp4b3WfvoejhDE4qe30t
 swNZEddxsaHLpXWqa1izQkPKe4bHFqnJ7YfiY8Dwz0fMWzBApCVdZrGst34YT2xJMH79
 ckPQUUuPQez1AQuuY/xpm1cki/r8lfgONpyuC5R3aa2l6ocNQGv6V+adWG4RlV6AVe/e
 zN64PHMAN4nGnbUyNaI0eR5Ilhll/iTNvq5pKesScPxLwWQhPxDrzuaOwC5ZeJv9bHwy
 qqFtLY2rnBV4pg08dpuMwLKn/wk04DuGxJWs1AB/xnl7M2lEpfE4IiQZh29igMk/o5CP
 nEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785068992; x=1785673792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o25qBdrbB0cCxrdOmXBhSEsyH8Q+W880TO/mlWSZJuU=;
 b=QzF5cQQ/ywMhxPrfdfVSFJeXbl6qCq9Yai/dOsdSPT7VXfhQYtIDIgQEXtjXoC+3vh
 tbodSeKmyvp2vqbvXWAgWD1FRMqvdmsPZ9yQ3JMo1k5IrfZt0jG4iTPoX2Va12CADMbl
 jYzuVhtHIcGe9rYa03FCq7UZZag9QKk8My2cAeh6q4tcylOejNkAFyOrFOcHrZcZLC6h
 k4ecve1lDSQsiME71gIxgZnBV6yxsxEgBmef0PPcIxK436lp6CQqbjTDRQx47EwIx21a
 dsmhoIWVQ18G8+gn3hk5ao7FHJ98d26lnmpUDbq6HihZYvv/fArQJGtcnJnWCtuWYThZ
 1kKQ==
X-Gm-Message-State: AOJu0YyRWsLDSObfdZ7IJrjUHtZ52A3mMyVsRdFHkC8eB4JtynsJOTmk
 jjqmi/BeGS7wJ4D8qesdCLQXnhkA0U5/g7GlNlS72VkZi/9r47dUtuHU8hll6vBMko0=
X-Gm-Gg: AR+sD11O7iLzTs5uvYv4hp5Uolu3RCDD5zpgWxwQuH1f6VfhHgaeY1wldJg25qqynuP
 6CvBCdyGVY1+b1r5vmWjzz7Aj3niXZObbAlsmIswy8Ng+8iryd0TiBy8WQd2+m81BX9tmNRFzwk
 J1K+GkIT29UEVqXoGyd4S4yqdU0wuc4wI+ihMNU/t9QvuvLWRchOTz0d4cbekMRrE3Wc2/sBIFu
 MEVn7ARokmErDWznBxIoxbA7PTBFp33IXOl/yzVH0iupr1j68sONQ83xpHy7gvh/Jv22mnFT3Pz
 oAgQKLD9GbbeoYOHkoPI+LgwQVm7CUtC8FaRWirj9kGZcA4OVBgLSLNa0A+Yir4KfrTEMrHrkkJ
 yO1ND2Gp9qyXCg8vLsCLb0hBhImyLGHIKoReE+ZDVxTbrtNuBIXTi0b5kO7czLwY6g0bFzDXBw6
 UTlKCgG8wH0/D7pRtiotR+
X-Received: by 2002:a05:6a00:414b:b0:848:7bcf:9a9a with SMTP id
 d2e1a72fcca58-84e5941163fmr3874859b3a.1.1785068991391; 
 Sun, 26 Jul 2026 05:29:51 -0700 (PDT)
Received: from localhost.localdomain ([111.201.4.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53426628sm1861647b3a.49.2026.07.26.05.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 05:29:49 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kangjie Huang <flamboyant.h.01@gmail.com>, qemu-riscv@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 09/11] hw/misc: Add K230 HI_SYS SSI control
Date: Sun, 26 Jul 2026 20:28:27 +0800
Message-ID: <4b46245962029fc7e4585aa225c28053929e8a88.1785064313.git.flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785064312.git.flamboyant.h.01@gmail.com>
References: <cover.1785064312.git.flamboyant.h.01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Model the HI_SYS SSI_CTRL wrapper register, including its reset value,
write mask, and dynamic mode and sleep status for the three logical SSI
controllers.

K230 software uses this register to control XIP enable and observe the
mode and sleep state of the SSI instances, so controller-local registers
alone do not provide the complete guest-visible interface.

Reuse the machine SSI routing table to associate logical controller
numbers with physical instances. Keep the sleep indication synchronized
when IDMA disables SSI after completion or an AXI error.

Map the wrapper over the previously unimplemented HI_SYS region and
migrate its writable state and the controller sleep state. Cover the
register reset value, write mask, and read-back behaviour, three-instance
mode routing, and sleep transitions in qtest.

Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
---
 hw/misc/k230_hi_sys.c          | 164 +++++++++++++++++++++++++++++++++
 hw/misc/meson.build            |   1 +
 hw/riscv/k230.c                |  19 +++-
 hw/ssi/k230_dw_ssi.c           |  15 +++
 include/hw/misc/k230_hi_sys.h  |  54 +++++++++++
 include/hw/riscv/k230.h        |   2 +
 include/hw/ssi/k230_dw_ssi.h   |   4 +
 tests/qtest/k230-dw-ssi-test.c |  60 ++++++++++++
 8 files changed, 316 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/k230_hi_sys.c
 create mode 100644 include/hw/misc/k230_hi_sys.h

diff --git a/hw/misc/k230_hi_sys.c b/hw/misc/k230_hi_sys.c
new file mode 100644
index 0000000000..44f5ac61de
--- /dev/null
+++ b/hw/misc/k230_hi_sys.c
@@ -0,0 +1,164 @@
+/*
+ * Kendryte K230 HI_SYS
+ *
+ * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Models the HI_SYS system control block, including the SSI_CTRL wrapper
+ * register that K230 firmware uses for XIP enable and SSI mode/sleep
+ * status.
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/misc/k230_hi_sys.h"
+#include "migration/vmstate.h"
+
+/*
+ * The TRM places SSI_CTRL at HI_SYS_CONFIG + 0x068, while the DWC SSI
+ * register table uses controller offset 0x068 for DR2. These are separate
+ * address spaces, so model SSI_CTRL in HI_SYS rather than as an SSI DR alias.
+ */
+static uint32_t k230_hi_sys_ssi_status(const K230HiSysState *s)
+{
+    static const unsigned int sleep_bits[] = {
+        K230_SSI_CTRL_SPI0_SLEEP,
+        K230_SSI_CTRL_SPI1_SLEEP,
+        K230_SSI_CTRL_SPI2_SLEEP,
+    };
+    static const unsigned int mode_shifts[] = {
+        K230_SSI_CTRL_SPI0_MODE_SHIFT,
+        K230_SSI_CTRL_SPI1_MODE_SHIFT,
+        K230_SSI_CTRL_SPI2_MODE_SHIFT,
+    };
+    uint32_t value = s->ssi_ctrl;
+
+    for (unsigned int i = 0; i < ARRAY_SIZE(s->ssi); i++) {
+        if (!s->ssi[i]) {
+            continue;
+        }
+
+        value |= k230_dw_ssi_get_spi_mode(s->ssi[i]) << mode_shifts[i];
+        if (k230_dw_ssi_is_sleeping(s->ssi[i])) {
+            value |= sleep_bits[i];
+        }
+    }
+
+    return value;
+}
+
+static uint64_t k230_hi_sys_read(void *opaque, hwaddr addr, unsigned size)
+{
+    K230HiSysState *s = opaque;
+
+    if (addr == K230_HI_SYS_SSI_CTRL_OFFSET) {
+        return k230_hi_sys_ssi_status(s);
+    }
+
+    if (addr < K230_HI_SYS_MMIO_SIZE) {
+        return 0;
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: read from invalid offset 0x%" HWADDR_PRIx "\n",
+                  TYPE_K230_HI_SYS, addr);
+    return 0;
+}
+
+static void k230_hi_sys_write(void *opaque, hwaddr addr, uint64_t value,
+                              unsigned size)
+{
+    K230HiSysState *s = opaque;
+
+    if (addr == K230_HI_SYS_SSI_CTRL_OFFSET) {
+        s->ssi_ctrl = (s->ssi_ctrl & ~K230_SSI_CTRL_WRITABLE_MASK) |
+                      ((uint32_t)value & K230_SSI_CTRL_WRITABLE_MASK);
+        s->ssi_ctrl &= K230_SSI_CTRL_IMPLEMENTED_MASK;
+        return;
+    }
+
+    if (addr < K230_HI_SYS_MMIO_SIZE) {
+        return;
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: write to invalid offset 0x%" HWADDR_PRIx "\n",
+                  TYPE_K230_HI_SYS, addr);
+}
+
+static const MemoryRegionOps k230_hi_sys_ops = {
+    .read = k230_hi_sys_read,
+    .write = k230_hi_sys_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+void k230_hi_sys_set_ssi(K230HiSysState *s, unsigned int index,
+                         K230DwSsiState *ssi)
+{
+    g_assert(index < ARRAY_SIZE(s->ssi));
+    s->ssi[index] = ssi;
+}
+
+static void k230_hi_sys_reset(Object *obj, ResetType type)
+{
+    K230HiSysState *s = K230_HI_SYS(obj);
+
+    s->ssi_ctrl = K230_SSI_CTRL_RESET;
+}
+
+static void k230_hi_sys_init(Object *obj)
+{
+    K230HiSysState *s = K230_HI_SYS(obj);
+
+    memory_region_init_io(&s->mmio, obj, &k230_hi_sys_ops, s,
+                          TYPE_K230_HI_SYS, K230_HI_SYS_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static const VMStateDescription vmstate_k230_hi_sys = {
+    .name = TYPE_K230_HI_SYS,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(ssi_ctrl, K230HiSysState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void k230_hi_sys_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_k230_hi_sys;
+    rc->phases.enter = k230_hi_sys_reset;
+}
+
+static const TypeInfo k230_hi_sys_type_info = {
+    .name = TYPE_K230_HI_SYS,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230HiSysState),
+    .instance_init = k230_hi_sys_init,
+    .class_init = k230_hi_sys_class_init,
+};
+
+static void k230_hi_sys_register_types(void)
+{
+    type_register_static(&k230_hi_sys_type_info);
+}
+
+type_init(k230_hi_sys_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 23265f6035..aaae64b33c 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -28,6 +28,7 @@ system_ss.add(when: 'CONFIG_IOSB', if_true: files('iosb.c'))
 system_ss.add(when: 'CONFIG_VIRT_CTRL', if_true: files('virt_ctrl.c'))
 
 # RISC-V devices
+system_ss.add(when: 'CONFIG_K230', if_true: files('k230_hi_sys.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true: files('mchp_pfsoc_ioscb.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_SYSREG', if_true: files('mchp_pfsoc_sysreg.c'))
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 36fd1eda22..a666a41c59 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -134,6 +134,8 @@ static void k230_soc_init(Object *obj)
                             TYPE_K230_DW_SSI);
     object_initialize_child(obj, "k230-spi-opi", &s->dw_ssi[2],
                             TYPE_K230_DW_SSI);
+    object_initialize_child(obj, "k230-hi-sys", &s->hi_sys,
+                            TYPE_K230_HI_SYS);
 
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
@@ -254,6 +256,18 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    for (size_t logical_index = 0;
+         logical_index < ARRAY_SIZE(k230_ssi_routes); logical_index++) {
+        const K230SsiRoute *route = &k230_ssi_routes[logical_index];
+
+        k230_hi_sys_set_ssi(&s->hi_sys, logical_index,
+                            &s->dw_ssi[route->ssi_index]);
+    }
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->hi_sys), errp)) {
+        return;
+    }
+
     k230_connect_ssi_irqs(s);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[0]), 0, memmap[K230_DEV_WDT0].base);
@@ -270,6 +284,8 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
                     memmap[K230_DEV_QSPI1].base);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dw_ssi[2]), 0,
                     memmap[K230_DEV_SPI].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->hi_sys), 0,
+                    memmap[K230_DEV_HI_SYS_CFG].base);
 
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
@@ -414,9 +430,6 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("sd1", memmap[K230_DEV_SD1].base,
                                 memmap[K230_DEV_SD1].size);
 
-    create_unimplemented_device("hi_sys_cfg", memmap[K230_DEV_HI_SYS_CFG].base,
-                                memmap[K230_DEV_HI_SYS_CFG].size);
-
     create_unimplemented_device("ddrc_cfg", memmap[K230_DEV_DDRC_CFG].base,
                                 memmap[K230_DEV_DDRC_CFG].size);
 
diff --git a/hw/ssi/k230_dw_ssi.c b/hw/ssi/k230_dw_ssi.c
index 65b2a8c245..c1c4f40e07 100644
--- a/hw/ssi/k230_dw_ssi.c
+++ b/hw/ssi/k230_dw_ssi.c
@@ -337,6 +337,16 @@ static bool k230_dw_ssi_enabled(const K230DwSsiState *s)
     return FIELD_EX32(s->regs[R_SSIENR], SSIENR, SSIC_EN);
 }
 
+uint32_t k230_dw_ssi_get_spi_mode(const K230DwSsiState *s)
+{
+    return FIELD_EX32(s->regs[R_CTRLR0], CTRLR0, SPI_FRF);
+}
+
+bool k230_dw_ssi_is_sleeping(const K230DwSsiState *s)
+{
+    return s->sleep_status;
+}
+
 static void k230_dw_ssi_deselect(K230DwSsiState *s)
 {
     if (s->active_cs < 0) {
@@ -648,6 +658,7 @@ static bool k230_dw_ssi_idma_triggered(const K230DwSsiState *s)
 static void k230_dw_ssi_idma_end(K230DwSsiState *s, uint32_t cause)
 {
     s->regs[R_SSIENR] = 0;
+    s->sleep_status = true;
     s->phase = K230_DW_SSI_PHASE_IDLE;
     s->remaining_frames = 0;
     k230_dw_ssi_deselect(s);
@@ -1202,9 +1213,11 @@ static void k230_dw_ssi_write(void *opaque, hwaddr addr,
         s->regs[R_SSIENR] = FIELD_DP32(0, SSIENR, SSIC_EN, new_enabled);
         if (!new_enabled) {
             k230_dw_ssi_abort_transfer(s);
+            s->sleep_status = true;
             return;
         }
 
+        s->sleep_status = false;
         k230_dw_ssi_update_cs(s);
         if (k230_dw_ssi_idma_enabled(s)) {
             k230_dw_ssi_try_idma(s);
@@ -1371,6 +1384,7 @@ static void k230_dw_ssi_enter_reset(Object *obj, ResetType type)
     s->irq_latched = 0;
     s->idma_completed_frames = 0;
     memset(&s->enhanced, 0, sizeof(s->enhanced));
+    s->sleep_status = false;
 
     s->regs[R_CTRLR0] = K230_DW_SSI_CTRLR0_RESET;
     s->regs[R_SR] = K230_DW_SSI_SR_RESET;
@@ -1448,6 +1462,7 @@ static const VMStateDescription vmstate_k230_dw_ssi = {
         VMSTATE_UINT32(enhanced.tmod, K230DwSsiState),
         VMSTATE_BOOL(enhanced.mode_bits_enabled, K230DwSsiState),
         VMSTATE_INT32(active_cs, K230DwSsiState),
+        VMSTATE_BOOL(sleep_status, K230DwSsiState),
         VMSTATE_END_OF_LIST()
     },
 };
diff --git a/include/hw/misc/k230_hi_sys.h b/include/hw/misc/k230_hi_sys.h
new file mode 100644
index 0000000000..4c85da531e
--- /dev/null
+++ b/include/hw/misc/k230_hi_sys.h
@@ -0,0 +1,54 @@
+/*
+ * Kendryte K230 HI_SYS
+ *
+ * Copyright (c) 2026 Kangjie Huang <flamboyant.h.01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Models the HI_SYS system control block, including the SSI_CTRL wrapper
+ * register that K230 firmware uses for XIP enable and SSI mode/sleep
+ * status.
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ */
+
+#ifndef HW_MISC_K230_HI_SYS_H
+#define HW_MISC_K230_HI_SYS_H
+
+#include "hw/core/sysbus.h"
+#include "hw/ssi/k230_dw_ssi.h"
+#include "qom/object.h"
+
+#define TYPE_K230_HI_SYS "riscv.k230.hi-sys"
+OBJECT_DECLARE_SIMPLE_TYPE(K230HiSysState, K230_HI_SYS)
+
+#define K230_HI_SYS_MMIO_SIZE            0x400
+#define K230_HI_SYS_SSI_CTRL_OFFSET      0x068
+
+#define K230_SSI_CTRL_RESET              0x00004000U
+#define K230_SSI_CTRL_IMPLEMENTED_MASK   0x0003fff1U
+#define K230_SSI_CTRL_WRITABLE_MASK      0x0003e001U
+
+#define K230_SSI_CTRL_XIP_EN             (1U << 0)
+#define K230_SSI_CTRL_SPI0_SLEEP         (1U << 4)
+#define K230_SSI_CTRL_SPI0_MODE_SHIFT    5
+#define K230_SSI_CTRL_SPI1_SLEEP         (1U << 7)
+#define K230_SSI_CTRL_SPI1_MODE_SHIFT    8
+#define K230_SSI_CTRL_SPI2_SLEEP         (1U << 10)
+#define K230_SSI_CTRL_SPI2_MODE_SHIFT    11
+
+struct K230HiSysState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t ssi_ctrl;
+    K230DwSsiState *ssi[3];
+};
+
+void k230_hi_sys_set_ssi(K230HiSysState *s, unsigned int index,
+                         K230DwSsiState *ssi);
+
+#endif /* HW_MISC_K230_HI_SYS_H */
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 493d739aa4..f280c3bebe 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -16,6 +16,7 @@
 #define HW_K230_H
 
 #include "hw/core/boards.h"
+#include "hw/misc/k230_hi_sys.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/ssi/k230_dw_ssi.h"
 #include "hw/watchdog/k230_wdt.h"
@@ -35,6 +36,7 @@ typedef struct K230SoCState {
 
     K230WdtState wdt[2];
     K230DwSsiState dw_ssi[3];
+    K230HiSysState hi_sys;
     MemoryRegion sram;
     MemoryRegion bootrom;
 
diff --git a/include/hw/ssi/k230_dw_ssi.h b/include/hw/ssi/k230_dw_ssi.h
index 3a1b2c08cd..49c137d73f 100644
--- a/include/hw/ssi/k230_dw_ssi.h
+++ b/include/hw/ssi/k230_dw_ssi.h
@@ -96,6 +96,10 @@ struct K230DwSsiState {
     uint32_t num_cs;
     uint32_t max_lines;
     int active_cs;
+    bool sleep_status;
 };
 
+uint32_t k230_dw_ssi_get_spi_mode(const K230DwSsiState *s);
+bool k230_dw_ssi_is_sleeping(const K230DwSsiState *s);
+
 #endif /* HW_SSI_K230_DW_SSI_H */
diff --git a/tests/qtest/k230-dw-ssi-test.c b/tests/qtest/k230-dw-ssi-test.c
index ddf5e13145..6bae56b1a8 100644
--- a/tests/qtest/k230-dw-ssi-test.c
+++ b/tests/qtest/k230-dw-ssi-test.c
@@ -14,6 +14,8 @@
 #define K230_SPI0_BASE          0x91584000ULL
 #define K230_SPI1_BASE          0x91582000ULL
 #define K230_SPI2_BASE          0x91583000ULL
+#define K230_HI_SYS_BASE        0x91585000ULL
+#define K230_SSI_CTRL_ADDR      (K230_HI_SYS_BASE + 0x68)
 #define K230_PLIC_BASE          0xf00000000ULL
 #define K230_PLIC_PENDING_BASE  0x1000
 #define K230_SSI_CTRLR0          0x000
@@ -53,6 +55,15 @@
 #define K230_SSI_CTRLR0_WRITABLE_MASK   0x01cf7f1fU
 #define K230_SSI_BAUDR_WRITABLE_MASK    0x0000fffeU
 
+#define K230_SSI_CTRL_RESET             0x00004000U
+#define K230_SSI_CTRL_IMPLEMENTED_MASK  0x0003fff1U
+#define K230_SSI_CTRL_WRITABLE_MASK     0x0003e001U
+#define K230_SSI_CTRL_XIP_EN            BIT(0)
+#define K230_SSI_CTRL_SPI0_SLEEP        BIT(4)
+#define K230_SSI_CTRL_SPI0_MODE_SHIFT   5
+#define K230_SSI_CTRL_SPI1_MODE_SHIFT   8
+#define K230_SSI_CTRL_SPI2_MODE_SHIFT   11
+
 #define K230_SSI_CTRLR0_DFS_MASK        0x1fU
 #define K230_SSI_CTRLR0_TMOD_SHIFT      10
 #define K230_SSI_CTRLR0_SRL             BIT(13)
@@ -767,6 +778,54 @@ static void test_idma(void)
     k230_ssi_flash_image_clear(&image);
 }
 
+static void test_hi_sys(void)
+{
+    QTestState *qts = k230_ssi_start();
+    uint32_t ctrlr0;
+    uint32_t expected_modes;
+
+    g_assert_cmphex(qtest_readl(qts, K230_SSI_CTRL_ADDR),
+                    ==, K230_SSI_CTRL_RESET);
+    qtest_writel(qts, K230_SSI_CTRL_ADDR, UINT32_MAX);
+    g_assert_cmphex(qtest_readl(qts, K230_SSI_CTRL_ADDR) &
+                    K230_SSI_CTRL_IMPLEMENTED_MASK,
+                    ==, (K230_SSI_CTRL_RESET &
+                         ~K230_SSI_CTRL_WRITABLE_MASK) |
+                        K230_SSI_CTRL_WRITABLE_MASK);
+    qtest_system_reset(qts);
+
+    ctrlr0 = k230_ssi_readl(qts, K230_SPI0_BASE, K230_SSI_CTRLR0);
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_CTRLR0,
+                    ctrlr0 | (K230_SSI_FRF_QUAD <<
+                              K230_SSI_CTRLR0_SPI_FRF_SHIFT));
+    ctrlr0 = k230_ssi_readl(qts, K230_SPI1_BASE, K230_SSI_CTRLR0);
+    k230_ssi_writel(qts, K230_SPI1_BASE, K230_SSI_CTRLR0,
+                    ctrlr0 | (1U << K230_SSI_CTRLR0_SPI_FRF_SHIFT));
+    ctrlr0 = k230_ssi_readl(qts, K230_SPI2_BASE, K230_SSI_CTRLR0);
+    k230_ssi_writel(qts, K230_SPI2_BASE, K230_SSI_CTRLR0,
+                    ctrlr0 | (K230_SSI_FRF_OCTAL <<
+                              K230_SSI_CTRLR0_SPI_FRF_SHIFT));
+    expected_modes = (K230_SSI_FRF_QUAD <<
+                      K230_SSI_CTRL_SPI0_MODE_SHIFT) |
+                     (1U << K230_SSI_CTRL_SPI1_MODE_SHIFT) |
+                     (K230_SSI_FRF_OCTAL <<
+                      K230_SSI_CTRL_SPI2_MODE_SHIFT);
+    g_assert_cmphex(qtest_readl(qts, K230_SSI_CTRL_ADDR) &
+                    ((3U << K230_SSI_CTRL_SPI0_MODE_SHIFT) |
+                     (3U << K230_SSI_CTRL_SPI1_MODE_SHIFT) |
+                     (3U << K230_SSI_CTRL_SPI2_MODE_SHIFT)),
+                    ==, expected_modes);
+
+    k230_ssi_writel(qts, K230_SPI0_BASE, K230_SSI_SSIENR, 1);
+    g_assert_cmphex(qtest_readl(qts, K230_SSI_CTRL_ADDR) &
+                    K230_SSI_CTRL_SPI0_SLEEP, ==, 0);
+    k230_ssi_disable(qts, K230_SPI0_BASE);
+    g_assert_cmphex(qtest_readl(qts, K230_SSI_CTRL_ADDR) &
+                    K230_SSI_CTRL_SPI0_SLEEP,
+                    ==, K230_SSI_CTRL_SPI0_SLEEP);
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -780,5 +839,6 @@ int main(int argc, char **argv)
     qtest_add_func("/k230-dw-ssi/spi-nor", test_spi_nor);
     qtest_add_func("/k230-dw-ssi/qspi-sdr", test_qspi_sdr);
     qtest_add_func("/k230-dw-ssi/idma", test_idma);
+    qtest_add_func("/k230-dw-ssi/hi-sys", test_hi_sys);
     return g_test_run();
 }
-- 
2.43.0


