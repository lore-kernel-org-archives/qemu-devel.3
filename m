Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0FAD5B85A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCB9-0007wL-Qc; Mon, 15 Dec 2025 12:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vVBx9-0008MU-SD
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:02:00 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vVBx5-0004fw-PJ
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:01:42 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-7aae5f2633dso3879908b3a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 09:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765818098; x=1766422898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjxxLsRNjcyKu3PcTmcgIDjCqeR8gY8riy6SUVStzi4=;
 b=PYs3FO+VsnsPFlInCccTkKPditNcsvf7bNB4Sct2N7vWJbTpzkCefEPbJOGYIsoNiG
 +Z72wkZak1BMGtxk3n2tCqIE54IWocRn+hQ1D1FqyDn+rtJ1wRUAN1Ml26XNtKPxOeCL
 0si0DTswOez9aFMZViX/OCFVJNtWr3jfzr36tkYGEpeNGG+k7DCeEXzN06zNewc7wV01
 fFH5Cv3keXpvMA9FSQ6zCEWwJhO5ZQSahalJcakbJzK2Cyu623XawnaYYOXh102uCrLS
 IcepF+Urz0p35/ANlsqtHDO+4tyFfc8KNuUw42EQmYT0P+/gotwJIGhwmjE4Ofj+0DnC
 ldPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765818098; x=1766422898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XjxxLsRNjcyKu3PcTmcgIDjCqeR8gY8riy6SUVStzi4=;
 b=oCgHQB9Iz9zZJM1eO1DdDJ/WGGrAxA9/GBqjZtmcH9eVGN/B0gUMCDigRtPrKJPecF
 8qW4Lp5Y7WG0rrGzTnThLo3/UDU3eidZgmWtTby3X+6SZcWvnEMBvqTVXOYDiCIn+IkD
 mMObolPmoErlsiy3cqHA5vBzW1qb+SGAIeOACwB9Ukinc256kE+EhZlRpBpkKDQGtvJ8
 QQbtUDyE5ie7ri2p/T5uAbuZ9DYb045RiS1X406zCwr4jLqTOKBjCghCUUveaaB9X3BL
 SC4lyq4SiYuttryERRhwW+wa3iBINTxiFDMKV91kIA8H1cpV9Meycg28IhsAdSZNo9I5
 caFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMxrTocJj+Cf9c2Ut9TrBoEBIEFmL2JS09qNqJ3wIybNb/2rTqSWVcwuYDWOyvBsww04EMHX0lkjMj@nongnu.org
X-Gm-Message-State: AOJu0YxAMgVQrp7HwX8QD0Mv0xB1cQbNtYZw+ZmNMScEfF3UwXOmYB0A
 1lPwVEsH+HocEUYcXSa59ekhiUYPs/hQfCQdj2hAYtfsJKN9UUoD+9D/
X-Gm-Gg: AY/fxX7joJIn5L+qoOwetBmgCOemMMF/u+3h/ldzjdvoR35FSKZASprySmpQcn+kFjE
 l/r2ynrUoY91VeaWo16yd6OjxpA+fBePbOo/pSJdTptwl91qqTlM7UjzF/OaTajcSFsk7DDxin5
 F1Vn88CUHLRe9B6cPnhBdNXCV331FeqRCcqy+7mUF6rFs+OqWdGSKzGsfA5L9qYxPiU6Gx1Pi0d
 NDIqr54yAq0wWBuYBp5RKK8HNb2a3gqmEkbbvGPb6gph4qUV8oy0QLcO6W0wMF3HvakmNNDrkYS
 /2DmuAE+thjOr1w2VtAc5i8Enb4GSbkTgkYCi81jgw4NxWLTu8eF58R0RB2urt9rGOOgGq5AgzA
 0gJy3ErdYqQDKIUn4TdYcMr78OpBcXf1Xgb6h2Re7q2qcEyZOZybuy/syZGlU8a8utQXzm17bT2
 iX7/3kIrRnOO/O+62qASRngj8mhbPQSQ==
X-Google-Smtp-Source: AGHT+IGuMAVJxRt5SMHAH7l2GHTmR4X0Cbc+Hrd0TWq9PlUeMlJgpqT2a1EFcrkE09Si7ctHlItJTg==
X-Received: by 2002:a05:6a20:7290:b0:366:14ac:e207 with SMTP id
 adf61e73a8af0-369b748dfd1mr12696238637.69.1765818097663; 
 Mon, 15 Dec 2025 09:01:37 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c2589d4f7sm13132788a12.3.2025.12.15.09.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 09:01:37 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: pbonzini@redhat.com, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, 1440332527@qq.com,
 3160104094@zju.edu.cn, temashking@foxmail.com, me@ziyao.cc,
 Chao Liu <chao.liu@zevorn.cn>, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RESEND PATCH v3 3/5] hw/watchdog: add k230 watchdog initial support
Date: Tue, 16 Dec 2025 01:01:16 +0800
Message-ID: <ee4de3669c362308f41054fb32bce7831c7ec183.1765816341.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765816341.git.chao.liu.zevorn@gmail.com>
References: <cover.1765816341.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Dec 2025 12:15:26 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Chao Liu <chao.liu@zevorn.cn>

Add programmable Watchdog Timer (WDT) peripheral for K230 machine.

Signed-off-by: Mig Yang <temashking@foxmail.com>
Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 MAINTAINERS                    |   2 +
 hw/riscv/Kconfig               |   3 +-
 hw/riscv/k230.c                |  18 ++
 hw/watchdog/Kconfig            |   4 +
 hw/watchdog/k230_wdt.c         | 307 +++++++++++++++++++++++++++++++++
 hw/watchdog/meson.build        |   1 +
 hw/watchdog/trace-events       |   9 +
 include/hw/riscv/k230.h        |   4 +
 include/hw/watchdog/k230_wdt.h | 130 ++++++++++++++
 9 files changed, 477 insertions(+), 1 deletion(-)
 create mode 100644 hw/watchdog/k230_wdt.c
 create mode 100644 include/hw/watchdog/k230_wdt.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4bc5442eff..7973785525 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1741,7 +1741,9 @@ K230 Machines
 M: Chao Liu <chao.liu.zevorn@gmail.com>
 S: Maintained
 F: hw/riscv/k230.c
+F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
+F: include/hw/watchdog/k230_wdt.h
 
 RX Machines
 -----------
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 624f166244..6faaa5cccc 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -137,4 +137,5 @@ config K230
     select RISCV_APLIC
     select RISCV_IMSIC
     select SERIAL_MM
-    select UNIMP
\ No newline at end of file
+    select UNIMP
+    select K230_WDT
\ No newline at end of file
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index e1780e4f0b..6817aa7d3e 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -112,6 +112,9 @@ static void k230_soc_init(Object *obj)
     RISCVHartArrayState *cpu0 = &s->c908_cpu;
 
     object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
+    object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
+
     qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
     qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
     qdev_prop_set_uint64(DEVICE(cpu0), "resetvec",
@@ -189,6 +192,21 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
                    qdev_get_gpio_in(DEVICE(s->c908_plic), K230_UART4_IRQ),
                    399193, serial_hd(4), DEVICE_LITTLE_ENDIAN);
 
+    /* Watchdog */
+    for (int i = 0; i < 2; i++) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
+            return;
+        }
+    }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[0]), 0, memmap[K230_DEV_WDT0].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[0]), 0,
+                       qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT0_IRQ));
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[1]), 0, memmap[K230_DEV_WDT1].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
+                       qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_IRQ));
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index 861fd00334..55f77c5c84 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -18,6 +18,10 @@ config WDT_DIAG288
 config WDT_IMX2
     bool
 
+config K230_WDT
+    bool
+    select PTIMER
+
 config WDT_SBSA
     bool
 
diff --git a/hw/watchdog/k230_wdt.c b/hw/watchdog/k230_wdt.c
new file mode 100644
index 0000000000..f385319836
--- /dev/null
+++ b/hw/watchdog/k230_wdt.c
@@ -0,0 +1,307 @@
+/*
+ *  * K230 Watchdog Compatible with kendryte K230 SDK
+ *
+ * Copyright (c) 2025 Mig Yang <temashking@foxmail.com>
+ * Copyright (c) 2025 Chao Liu <chao.liu@zevorn.cn>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Provides a board compatible with the kendryte K230 SDK
+ *
+ * Documentation: K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/module.h"
+#include "system/watchdog.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+
+#include "hw/watchdog/k230_wdt.h"
+#include "trace.h"
+
+static void k230_wdt_timeout(void *opaque)
+{
+    K230WdtState *s = K230_WDT(opaque);
+
+    trace_k230_wdt_timeout();
+
+    /* Set interrupt status if in interrupt mode */
+    if (s->cr & K230_WDT_CR_RMOD) {
+        s->stat |= K230_WDT_STAT_INT;
+        s->interrupt_pending = true;
+        qemu_set_irq(s->irq, 1);
+        trace_k230_wdt_interrupt();
+    } else {
+        /* Direct reset mode */
+        trace_k230_wdt_reset();
+        watchdog_perform_action();
+    }
+
+    /* Restart counter */
+    s->current_count = s->timeout_value;
+    ptimer_set_count(s->timer, s->current_count);
+    ptimer_run(s->timer, 1);
+}
+
+static void k230_wdt_reset(DeviceState *dev)
+{
+    K230WdtState *s = K230_WDT(dev);
+
+    trace_k230_wdt_reset_device();
+
+    ptimer_transaction_begin(s->timer);
+    ptimer_stop(s->timer);
+    ptimer_transaction_commit(s->timer);
+
+    /* Reset registers to default values */
+    s->cr = 0;
+    s->torr = 0;
+    s->ccvr = 0xFFFFFFFF;
+    s->stat = 0;
+    s->prot_level = 0x2;
+
+    s->interrupt_pending = false;
+    s->enabled = false;
+    s->timeout_value = 0;
+    s->current_count = 0xFFFFFFFF;
+}
+
+static uint64_t k230_wdt_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    K230WdtState *s = K230_WDT(opaque);
+    uint32_t value = 0;
+
+    switch (addr) {
+    case K230_WDT_CR:
+        value = s->cr;
+        break;
+    case K230_WDT_TORR:
+        value = s->torr;
+        break;
+    case K230_WDT_CCVR:
+        if (s->enabled) {
+            value = ptimer_get_count(s->timer);
+        } else {
+            value = s->current_count;
+        }
+        break;
+    case K230_WDT_STAT:
+        value = s->stat;
+        break;
+    case K230_WDT_PROT_LEVEL:
+        value = s->prot_level;
+        break;
+    case K230_WDT_COMP_PARAM_5:
+        value = 0; /* Upper limit of Timeout Period parameters */
+        break;
+    case K230_WDT_COMP_PARAM_4:
+        value = 0; /* Upper limit of Initial Timeout Period parameters */
+        break;
+    case K230_WDT_COMP_PARAM_3:
+        value = 0; /* Derived from WDT_TOP_RST parameter */
+        break;
+    case K230_WDT_COMP_PARAM_2:
+        value = 0xFFFFFFFF; /* Derived from WDT_RST_CNT parameter */
+        break;
+    case K230_WDT_COMP_PARAM_1:
+        /* Component parameters */
+        value = (32 << K230_WDT_CNT_WIDTH_SHIFT) |  /* 32-bit counter */
+                (0 << K230_WDT_DFLT_TOP_INIT_SHIFT) |
+                (0 << K230_WDT_DFLT_TOP_SHIFT) |
+                (K230_WDT_RPL_16_CYCLES << K230_WDT_DFLT_RPL_SHIFT) |
+                (2 << K230_WDT_APB_DATA_WIDTH_SHIFT) | /* 32-bit APB */
+                K230_WDT_USE_FIX_TOP; /* Use fixed timeout values */
+        break;
+    case K230_WDT_COMP_VERSION:
+        value = K230_WDT_COMP_VERSION_VAL;
+        break;
+    case K230_WDT_COMP_TYPE:
+        value = K230_WDT_COMP_TYPE_VAL;
+        break;
+    default:
+        /* Other registers return 0 */
+        break;
+    }
+
+    trace_k230_wdt_read(addr, value);
+    return value;
+}
+
+static void k230_wdt_update_timer(K230WdtState *s)
+{
+    ptimer_transaction_begin(s->timer);
+
+    if (s->enabled && s->timeout_value > 0) {
+        ptimer_set_count(s->timer, s->current_count);
+        ptimer_run(s->timer, 1);
+    } else {
+        ptimer_stop(s->timer);
+    }
+
+    ptimer_transaction_commit(s->timer);
+}
+
+static uint32_t k230_wdt_calculate_timeout(uint32_t top_value)
+{
+    /* Calculate timeout based on TOP value */
+    /* For fixed timeout mode: 2^(16 + top_value) */
+    if (top_value <= 15) {
+        return 1 << (16 + top_value);
+    }
+    return 1 << 31; /* Maximum value for 32-bit counter */
+}
+
+static void k230_wdt_write(void *opaque, hwaddr addr,
+                           uint64_t value, unsigned int size)
+{
+    K230WdtState *s = K230_WDT(opaque);
+
+    trace_k230_wdt_write(addr, value);
+
+    switch (addr) {
+    case K230_WDT_CR:
+        s->cr = value & (K230_WDT_CR_RPL_MASK << K230_WDT_CR_RPL_SHIFT |
+                         K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
+
+        /* Update enabled state */
+        s->enabled = (s->cr & K230_WDT_CR_WDT_EN) != 0;
+
+        /* Update timer */
+        k230_wdt_update_timer(s);
+        break;
+
+    case K230_WDT_TORR:
+        s->torr = value & K230_WDT_TORR_TOP_MASK;
+
+        /* Calculate new timeout value */
+        s->timeout_value = k230_wdt_calculate_timeout(s->torr);
+        s->current_count = s->timeout_value;
+
+        /* Update timer if enabled */
+        if (s->enabled) {
+            k230_wdt_update_timer(s);
+        }
+        break;
+
+    case K230_WDT_CRR:
+        /* Restart counter with magic value 0x76 */
+        if ((value & 0xFF) == K230_WDT_CRR_RESTART) {
+            trace_k230_wdt_restart();
+            s->current_count = s->timeout_value;
+
+            /* Clear interrupt if pending */
+            if (s->interrupt_pending) {
+                s->stat &= ~K230_WDT_STAT_INT;
+                s->interrupt_pending = false;
+                qemu_set_irq(s->irq, 0);
+            }
+
+            /* Update timer */
+            k230_wdt_update_timer(s);
+        }
+        break;
+
+    case K230_WDT_EOI:
+        /* Clear interrupt */
+        s->stat &= ~K230_WDT_STAT_INT;
+        s->interrupt_pending = false;
+        qemu_set_irq(s->irq, 0);
+        break;
+
+    case K230_WDT_PROT_LEVEL:
+        s->prot_level = value & 0x7;
+        break;
+
+    default:
+        /* Read-only registers, ignore writes */
+        break;
+    }
+}
+
+static const MemoryRegionOps k230_wdt_ops = {
+    .read  = k230_wdt_read,
+    .write = k230_wdt_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static const VMStateDescription vmstate_k230_wdt = {
+    .name = "k230.wdt",
+    .fields = (const VMStateField[]) {
+        VMSTATE_PTIMER(timer, K230WdtState),
+        VMSTATE_UINT32(cr, K230WdtState),
+        VMSTATE_UINT32(torr, K230WdtState),
+        VMSTATE_UINT32(ccvr, K230WdtState),
+        VMSTATE_UINT32(stat, K230WdtState),
+        VMSTATE_UINT32(prot_level, K230WdtState),
+        VMSTATE_BOOL(interrupt_pending, K230WdtState),
+        VMSTATE_BOOL(enabled, K230WdtState),
+        VMSTATE_UINT32(timeout_value, K230WdtState),
+        VMSTATE_UINT32(current_count, K230WdtState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void k230_wdt_realize(DeviceState *dev, Error **errp)
+{
+    K230WdtState *s = K230_WDT(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(dev),
+                          &k230_wdt_ops, s,
+                          TYPE_K230_WDT,
+                          K230_WDT_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+    sysbus_init_irq(sbd, &s->irq);
+
+    s->timer = ptimer_init(k230_wdt_timeout, s,
+                           PTIMER_POLICY_NO_IMMEDIATE_TRIGGER |
+                           PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+                           PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+
+    ptimer_transaction_begin(s->timer);
+    ptimer_set_freq(s->timer, K230_WDT_DEFAULT_FREQ);
+    ptimer_transaction_commit(s->timer);
+}
+
+static void k230_wdt_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = k230_wdt_realize;
+    device_class_set_legacy_reset(dc, k230_wdt_reset);
+    dc->vmsd = &vmstate_k230_wdt;
+    dc->desc = "K230 watchdog timer";
+    set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
+}
+
+static const TypeInfo k230_wdt_info = {
+    .name          = TYPE_K230_WDT,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(K230WdtState),
+    .class_init    = k230_wdt_class_init,
+};
+
+static void k230_wdt_register_type(void)
+{
+    type_register_static(&k230_wdt_info);
+}
+type_init(k230_wdt_register_type)
diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
index 15370565bd..5edae65a36 100644
--- a/hw/watchdog/meson.build
+++ b/hw/watchdog/meson.build
@@ -6,5 +6,6 @@ system_ss.add(when: 'CONFIG_WDT_IB700', if_true: files('wdt_ib700.c'))
 system_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files('wdt_diag288.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
 system_ss.add(when: 'CONFIG_WDT_IMX2', if_true: files('wdt_imx2.c'))
+system_ss.add(when: 'CONFIG_K230_WDT', if_true: files('k230_wdt.c'))
 system_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('sbsa_gwdt.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_watchdog.c'))
diff --git a/hw/watchdog/trace-events b/hw/watchdog/trace-events
index ad3be1e9bd..d85b3ca769 100644
--- a/hw/watchdog/trace-events
+++ b/hw/watchdog/trace-events
@@ -33,3 +33,12 @@ spapr_watchdog_expired(uint64_t num, unsigned action) "num=%" PRIu64 " action=%u
 # watchdog.c
 watchdog_perform_action(unsigned int action) "action=%u"
 watchdog_set_action(unsigned int action) "action=%u"
+
+# k230_wdt.c
+k230_wdt_read(uint64_t addr, uint32_t data) "K230 WDT read: [0x%" PRIx64 "] -> 0x%" PRIx32
+k230_wdt_write(uint64_t addr, uint64_t data) "K230 WDT write: [0x%" PRIx64 "] <- 0x%" PRIx64
+k230_wdt_timeout(void) "K230 WDT timeout"
+k230_wdt_interrupt(void) "K230 WDT interrupt"
+k230_wdt_reset(void) "K230 WDT system reset"
+k230_wdt_restart(void) "K230 WDT restart"
+k230_wdt_reset_device(void) "K230 WDT device reset"
diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
index 3158381e8f..f2eedd5f70 100644
--- a/include/hw/riscv/k230.h
+++ b/include/hw/riscv/k230.h
@@ -27,6 +27,7 @@
 
 #include "hw/boards.h"
 #include "hw/riscv/riscv_hart.h"
+#include "hw/watchdog/k230_wdt.h"
 
 #define C908_CPU_HARTID   (0)
 
@@ -41,6 +42,7 @@ typedef struct K230SoCState {
     /*< public >*/
     RISCVHartArrayState c908_cpu; /* Small core */
 
+    K230WdtState wdt[2];
     MemoryRegion sram;
     MemoryRegion bootrom;
 
@@ -131,6 +133,8 @@ enum {
     K230_UART2_IRQ  = 18,
     K230_UART3_IRQ  = 19,
     K230_UART4_IRQ  = 20,
+    K230_WDT0_IRQ   = 32,
+    K230_WDT1_IRQ   = 33,
 };
 
 /*
diff --git a/include/hw/watchdog/k230_wdt.h b/include/hw/watchdog/k230_wdt.h
new file mode 100644
index 0000000000..9371602387
--- /dev/null
+++ b/include/hw/watchdog/k230_wdt.h
@@ -0,0 +1,130 @@
+/*
+ * K230 Watchdog Timer
+ *
+ * Based on K230 technical documentation
+ *
+ * Copyright (c) 2025 Mig Yang <temashking@foxmail.com>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef K230_WDT_H
+#define K230_WDT_H
+
+#include "qemu/bitops.h"
+#include "hw/sysbus.h"
+#include "hw/irq.h"
+#include "hw/ptimer.h"
+#include "qom/object.h"
+
+#define TYPE_K230_WDT "riscv.k230.wdt"
+OBJECT_DECLARE_SIMPLE_TYPE(K230WdtState, K230_WDT)
+
+#define K230_WDT_DEFAULT_FREQ (32768)
+
+/* K230 Watchdog Register Map */
+enum K230WdtRegisters {
+    K230_WDT_CR      = 0x00,  /* Control Register */
+    K230_WDT_TORR    = 0x04,  /* Timeout Range Register */
+    K230_WDT_CCVR    = 0x08,  /* Current Counter Value Register */
+    K230_WDT_CRR     = 0x0c,  /* Counter Restart Register */
+    K230_WDT_STAT    = 0x10,  /* Interrupt Status Register */
+    K230_WDT_EOI     = 0x14,  /* Interrupt Clear Register */
+    K230_WDT_PROT_LEVEL = 0x1c, /* Protection Level Register */
+    K230_WDT_COMP_PARAM_5 = 0xe4, /* Component Parameters Register 5 */
+    K230_WDT_COMP_PARAM_4 = 0xe8, /* Component Parameters Register 4 */
+    K230_WDT_COMP_PARAM_3 = 0xec, /* Component Parameters Register 3 */
+    K230_WDT_COMP_PARAM_2 = 0xf0, /* Component Parameters Register 2 */
+    K230_WDT_COMP_PARAM_1 = 0xf4, /* Component Parameters Register 1 */
+    K230_WDT_COMP_VERSION = 0xf8, /* Component Version Register */
+    K230_WDT_COMP_TYPE = 0xfc, /* Component Type Register */
+};
+
+#define K230_WDT_MMIO_SIZE 0x100
+
+/* Control Register (WDT_CR) definitions */
+#define K230_WDT_CR_RPL_MASK    0x7        /* Reset Pulse Length */
+#define K230_WDT_CR_RPL_SHIFT   2
+#define K230_WDT_CR_RMOD        BIT(1)     /* Response Mode */
+#define K230_WDT_CR_WDT_EN      BIT(0)     /* Watchdog Enable */
+
+/* Reset Pulse Length values */
+#define K230_WDT_RPL_2_CYCLES   0x0
+#define K230_WDT_RPL_4_CYCLES   0x1
+#define K230_WDT_RPL_8_CYCLES   0x2
+#define K230_WDT_RPL_16_CYCLES  0x3
+#define K230_WDT_RPL_32_CYCLES  0x4
+#define K230_WDT_RPL_64_CYCLES  0x5
+#define K230_WDT_RPL_128_CYCLES 0x6
+#define K230_WDT_RPL_256_CYCLES 0x7
+
+/* Timeout Range Register (WDT_TORR) definitions */
+#define K230_WDT_TORR_TOP_MASK  0xf        /* Timeout Period */
+
+/* Interrupt Status Register (WDT_STAT) definitions */
+#define K230_WDT_STAT_INT       BIT(0)     /* Interrupt Status */
+
+/* Counter Restart Register (WDT_CRR) magic value */
+#define K230_WDT_CRR_RESTART    0x76       /* Restart command */
+
+/* Component Parameters Register 1 (WDT_COMP_PARAM_1) definitions */
+#define K230_WDT_CNT_WIDTH_MASK 0x1f000000 /* Counter Width */
+#define K230_WDT_CNT_WIDTH_SHIFT 24
+#define K230_WDT_DFLT_TOP_INIT_MASK 0xf00000 /* Default Initial Timeout */
+#define K230_WDT_DFLT_TOP_INIT_SHIFT 20
+#define K230_WDT_DFLT_TOP_MASK  0xf0000    /* Default Timeout */
+#define K230_WDT_DFLT_TOP_SHIFT 16
+#define K230_WDT_DFLT_RPL_MASK  0x7        /* Default Reset Pulse Length */
+#define K230_WDT_DFLT_RPL_SHIFT 10
+#define K230_WDT_APB_DATA_WIDTH_MASK 0x3   /* APB Data Width */
+#define K230_WDT_APB_DATA_WIDTH_SHIFT 8
+#define K230_WDT_USE_FIX_TOP    BIT(6)     /* Use Fixed Timeout Values */
+#define K230_WDT_HC_TOP         BIT(5)     /* Hard-coded Timeout */
+#define K230_WDT_HC_RPL         BIT(4)     /* Hard-coded Reset Pulse Length */
+#define K230_WDT_HC_RMOD        BIT(3)     /* Hard-coded Response Mode */
+#define K230_WDT_DUAL_TOP       BIT(2)     /* Dual Timeout Period */
+#define K230_WDT_DFLT_RMOD      BIT(1)     /* Default Response Mode */
+#define K230_WDT_ALWAYS_EN      BIT(0)     /* Always Enabled */
+
+/* Component Type Register value */
+#define K230_WDT_COMP_TYPE_VAL  0x44570120
+
+/* Component Version Register value */
+#define K230_WDT_COMP_VERSION_VAL 0x3131302a  /* "110*" */
+
+struct K230WdtState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+    qemu_irq irq;
+
+    struct ptimer_state *timer;
+
+    /* Register state */
+    uint32_t cr;           /* Control Register */
+    uint32_t torr;         /* Timeout Range Register */
+    uint32_t ccvr;         /* Current Counter Value Register */
+    uint32_t stat;         /* Interrupt Status Register */
+    uint32_t prot_level;   /* Protection Level Register */
+
+    /* Internal state */
+    bool interrupt_pending;
+    bool enabled;
+    uint32_t timeout_value;
+    uint32_t current_count;
+};
+
+#endif /* K230_WDT_H */
-- 
2.51.0


