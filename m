Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239EBC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgCN-0005B6-2n; Wed, 19 Aug 2026 09:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wwgCL-0005Aj-Ce
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:19:17 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wwgCI-0004qs-RO
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:19:17 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so901344a91.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787145553; x=1787750353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DAZhmr7lFpnfTihWTbQ+euv+X6D6ZMXRKGB9vPdGUwk=;
 b=DpOixrubEQ3Gcywibjr2Px5mrATi4IvtAExRoFCjeUGV62CAC273QbrH3aM5SfGL6K
 NdzoXvIngNqS+Ux5Ddc3I6iSNVN+kI8DBiGWmaQIeoSVzA5+zYSnNlrpJ6f8qfLLOVmt
 D+/CtUvxP1MClYtWwTaXL8tNlehv3eNu9JdhwbxUD6ZouIyepmfRxeSQZiyect1y//rK
 V4G1hfjgoov5XAQIsMy88THMeX6nTwtSYN9SYQZn1KA8cLfo2JNw+E1Q/FPnYNDkMlzk
 jW4vXzqdQB7oO5LsXlssla9ObMYjDUy892WQX8/zdIdSy+CSwve4codaGK272LtEK1g7
 9kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787145553; x=1787750353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DAZhmr7lFpnfTihWTbQ+euv+X6D6ZMXRKGB9vPdGUwk=;
 b=S5epc4fEwXnIr8XMO99CU4CfHNvBNE17qVfk+pY4O8+aeu6LAc8W6cETAVM5YKYgGG
 YV6P8GyhfJhL+JRM2ArJubMNCOrAdIxU7UCTsN/bQ77NVKZh5syaJL/gQ0sJcIcUt+eU
 EoRa6a7gt7xOgZDTVDflVJ/Bd2VZ5rDOmB0VEcD0r4O5boJMcHHDr6mC7AmRQ6MixLLf
 AZ84GJpi4Wnryt0zTZIRtrbg9zJQJ3815tubEtzgsCWs4qA6HlwgBLsM8U5zF2vQtrOY
 vib+/OWthQwMeX+SlBeopI7sC86GY1qhgf0ZPTkelMwWGCgjz1XWWl5fmeW4prHiYeyc
 5jdw==
X-Gm-Message-State: AFuF++mZC0fH8wfDO23aIc9zdeAjA/eJtpPJXWmCRPmf8/2WIQkJohZN
 R9d1W+g4KyZ6i4iRTcTR/j//noN1fzXOHVJKAsENLnbP9AFMVkErQLvkVsfoHA==
X-Gm-Gg: AR+sD12Eghe65NWHxAsz6Cvgg63/3UH6BHU53U10itjwF9EEhhFqwNnEW2q7PoXvVcH
 lw4VVeeMl5r8gBkVE1AeY75FNv6sCu42IslfF4Rpeg4l6EpiUKEdZ6D3ODmadunMwehQWPLImQR
 udxjZ4e803UcNDW309lvumVLDaGl2Fd4ZKvmhZgC96Dk19PVTkwPFt64YZrSXcO0v5wtUdZo70/
 /PZeTj3DdyRbgdnmKDCVLx9zzd6aihktyx2qRHvEZ1SR+CHhF/wGNyLsoEX78eh5wcFCBcQwvT5
 msxsoVhzhrXZJe90IHNEWLpEhhY9Hxdo4n9kQUN5i/4Mnsu2rc3CrpVr9sQSjhXtlumjdeCjv+W
 JEa7FygI1yHi9bIvOEtLDZ1mO9yHlM+GHl62w1j3JNp/MFNY7wiV1MnAQ/yVpLhV072J8PBSiAE
 SSj/gJlFXnuWV9gtPC/qltXJTpG71gC7dPvzIZE0zYM8PIICoaAzIXhlb+BlGG/PqtjsZo2g==
X-Received: by 2002:a17:90b:5102:b0:392:b509:b1a5 with SMTP id
 98e67ed59e1d1-395810caaf3mr9152360a91.14.1787145553017; 
 Wed, 19 Aug 2026 06:19:13 -0700 (PDT)
Received: from DESKTOP-DFGP8OG.lan ([156.226.169.41])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb12145sm2734387a91.4.2026.08.19.06.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:19:12 -0700 (PDT)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 caojunze424 <caojunze424@gmail.com>,
 Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 raoyi <rao232328@gmail.com>
Subject: [PATCH v5 1/3] hw/timer: add DesignWare APB timer model
Date: Wed, 19 Aug 2026 21:18:57 +0800
Message-ID: <20260819131859.9583-2-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819131859.9583-1-rao232328@gmail.com>
References: <20260819131859.9583-1-rao232328@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=rao232328@gmail.com; helo=mail-pj1-x102e.google.com
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

Add generic DesignWare APB timer device model. The number
of timer channels is configurable via the num-timers property.

Add timer files to MAINTAINERS.

Signed-off-by: raoyi <rao232328@gmail.com>
---
 MAINTAINERS                     |   2 +
 hw/timer/Kconfig                |   4 +
 hw/timer/dw-apb-timer.c         | 376 ++++++++++++++++++++++++++++++++
 hw/timer/meson.build            |   1 +
 hw/timer/trace-events           |   8 +
 include/hw/timer/dw-apb-timer.h |  40 ++++
 6 files changed, 431 insertions(+)
 create mode 100644 hw/timer/dw-apb-timer.c
 create mode 100644 include/hw/timer/dw-apb-timer.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6171cc7494..cf689433ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1826,8 +1826,10 @@ S: Maintained
 F: docs/system/riscv/k230.rst
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
+F: hw/timer/dw-apb-timer.c
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
+F: include/hw/timer/dw-apb-timer.h
 F: tests/qtest/k230-wdt-test.c
 
 RX Machines
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index b3d823ce2c..b533cf1ba9 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -65,3 +65,7 @@ config STELLARIS_GPTM
 
 config AVR_TIMER16
     bool
+
+config DW_APB_TIMER
+    bool
+    select PTIMER
diff --git a/hw/timer/dw-apb-timer.c b/hw/timer/dw-apb-timer.c
new file mode 100644
index 0000000000..86e1fac43f
--- /dev/null
+++ b/hw/timer/dw-apb-timer.c
@@ -0,0 +1,376 @@
+/*
+ * Synopsys DesignWare APB timer
+ *
+ * Copyright (c) 2026 raoyi <rao232328@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "hw/core/ptimer.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/timer/dw-apb-timer.h"
+#include "trace.h"
+
+#define DW_APB_TIMER_STRIDE       0x14
+#define DW_APB_TIMER_MMIO_SIZE    0x100
+
+/* Per-timer register offsets */
+#define DW_APB_TIMER_N_LOAD_COUNT    0x00
+#define DW_APB_TIMER_N_CURRENT_VALUE 0x04
+#define DW_APB_TIMER_N_CONTROL       0x08
+#define DW_APB_TIMER_N_EOI           0x0c
+#define DW_APB_TIMER_N_INT_STATUS    0x10
+/* Global register offsets */
+#define DW_APB_TIMER_INT_STATUS        0xa0
+#define DW_APB_TIMER_EOI               0xa4
+#define DW_APB_TIMER_RAW_INT_STATUS    0xa8
+#define DW_APB_TIMER_COMP_VERSION      0xac
+
+/* Control register bits */
+#define DW_APB_TIMER_CONTROL_ENABLE        BIT(0)
+/* 1: periodic, 0: free running. */
+#define DW_APB_TIMER_CONTROL_MODE_PERIODIC BIT(1)
+#define DW_APB_TIMER_CONTROL_INT_MASK      BIT(2)
+#define DW_APB_TIMER_CONTROL_RW_MASK       0x7
+
+/*
+ * Component version of the DW_apb_timers IP, fixed in silicon.
+ * Decodes as the ASCII string "211*" (2.11a series); the model reports
+ * the version integrated in K230. Linux does not read this register.
+ */
+#define DW_APB_TIMER_COMP_VERSION_VAL 0x3231312A
+
+static void dw_apb_timer_update_irq(DWAPBTimerChannel *t)
+{
+    qemu_set_irq(t->irq, t->int_status &&
+                 !(t->control & DW_APB_TIMER_CONTROL_INT_MASK));
+}
+
+static void dw_apb_timer_clk_update(void *opaque, ClockEvent event)
+{
+    DWAPBTimerChannel *t = opaque;
+
+    if (!t->ptimer) {
+        return;
+    }
+    ptimer_transaction_begin(t->ptimer);
+    ptimer_set_period_from_clock(t->ptimer, t->clk, 1);
+    ptimer_transaction_commit(t->ptimer);
+}
+
+static void dw_apb_timer_enable(DWAPBTimerChannel *t)
+{
+    trace_dw_apb_timer_enable(t->id, t->load);
+
+    ptimer_transaction_begin(t->ptimer);
+    ptimer_set_limit(t->ptimer, t->load ? t->load : 1, 1);
+    ptimer_run(t->ptimer, 1);
+    ptimer_transaction_commit(t->ptimer);
+}
+
+static void dw_apb_timer_disable(DWAPBTimerChannel *t)
+{
+    trace_dw_apb_timer_disable(t->id);
+
+    ptimer_transaction_begin(t->ptimer);
+    ptimer_stop(t->ptimer);
+    ptimer_transaction_commit(t->ptimer);
+
+    t->int_status = 0;
+    dw_apb_timer_update_irq(t);
+}
+
+static void dw_apb_timer_tick(void *opaque)
+{
+    DWAPBTimerChannel *t = opaque;
+    uint32_t reload;
+
+    trace_dw_apb_timer_tick(t->id);
+
+    t->int_status = 1;
+    dw_apb_timer_update_irq(t);
+
+    if (t->control & DW_APB_TIMER_CONTROL_MODE_PERIODIC) {
+        reload = t->load ? t->load : 1;
+    } else {
+        reload = UINT32_MAX;
+    }
+
+    ptimer_set_limit(t->ptimer, reload, 1);
+    ptimer_run(t->ptimer, 1);
+}
+
+static uint64_t dw_apb_timer_read(void *opaque, hwaddr addr,
+                                  unsigned int size)
+{
+    DWAPBTimerState *s = DW_APB_TIMER(opaque);
+    uint32_t value = 0;
+
+    if (addr < DW_APB_TIMER_INT_STATUS) {
+        unsigned int idx = addr / DW_APB_TIMER_STRIDE;
+        hwaddr reg = addr % DW_APB_TIMER_STRIDE;
+
+        if (idx < s->num_timers) {
+            DWAPBTimerChannel *t = &s->timers[idx];
+
+            switch (reg) {
+            case DW_APB_TIMER_N_LOAD_COUNT:
+                value = t->load;
+                break;
+            case DW_APB_TIMER_N_CURRENT_VALUE:
+                if (t->control & DW_APB_TIMER_CONTROL_ENABLE) {
+                    value = ptimer_get_count(t->ptimer);
+                }
+                break;
+            case DW_APB_TIMER_N_CONTROL:
+                value = t->control;
+                break;
+            case DW_APB_TIMER_N_EOI:
+                t->int_status = 0;
+                dw_apb_timer_update_irq(t);
+                trace_dw_apb_timer_irq_clear(t->id);
+                break;
+            case DW_APB_TIMER_N_INT_STATUS:
+                value = t->int_status &&
+                        !(t->control & DW_APB_TIMER_CONTROL_INT_MASK);
+                break;
+            default:
+                break;
+            }
+        }
+    } else {
+        switch (addr) {
+        case DW_APB_TIMER_INT_STATUS:
+            for (int i = 0; i < s->num_timers; i++) {
+                DWAPBTimerChannel *t = &s->timers[i];
+
+                value |= (t->int_status &&
+                          !(t->control & DW_APB_TIMER_CONTROL_INT_MASK)) << i;
+            }
+            break;
+        case DW_APB_TIMER_EOI:
+            for (int i = 0; i < s->num_timers; i++) {
+                DWAPBTimerChannel *t = &s->timers[i];
+
+                t->int_status = 0;
+                dw_apb_timer_update_irq(t);
+            }
+            break;
+        case DW_APB_TIMER_RAW_INT_STATUS:
+            for (int i = 0; i < s->num_timers; i++) {
+                value |= s->timers[i].int_status << i;
+            }
+            break;
+        case DW_APB_TIMER_COMP_VERSION:
+            value = DW_APB_TIMER_COMP_VERSION_VAL;
+            break;
+        default:
+            break;
+        }
+    }
+
+    trace_dw_apb_timer_read(addr, value);
+    return value;
+}
+
+static void dw_apb_timer_write(void *opaque, hwaddr addr,
+                               uint64_t value, unsigned int size)
+{
+    DWAPBTimerState *s = DW_APB_TIMER(opaque);
+
+    if (addr < DW_APB_TIMER_INT_STATUS) {
+        unsigned int idx = addr / DW_APB_TIMER_STRIDE;
+        hwaddr reg = addr % DW_APB_TIMER_STRIDE;
+
+        if (idx < s->num_timers) {
+            DWAPBTimerChannel *t = &s->timers[idx];
+
+            switch (reg) {
+            case DW_APB_TIMER_N_LOAD_COUNT:
+                t->load = value;
+                break;
+            case DW_APB_TIMER_N_CONTROL: {
+                uint32_t old_control = t->control;
+                uint32_t new_control = value & DW_APB_TIMER_CONTROL_RW_MASK;
+
+                t->control = new_control;
+                if ((new_control ^ old_control) &
+                    DW_APB_TIMER_CONTROL_ENABLE) {
+                    if (new_control & DW_APB_TIMER_CONTROL_ENABLE) {
+                        dw_apb_timer_enable(t);
+                    } else {
+                        dw_apb_timer_disable(t);
+                    }
+                }
+                if ((new_control ^ old_control) &
+                    DW_APB_TIMER_CONTROL_INT_MASK) {
+                    dw_apb_timer_update_irq(t);
+                }
+                break;
+            }
+            default:
+                break;
+            }
+        }
+    }
+
+    trace_dw_apb_timer_write(addr, value);
+}
+
+static const MemoryRegionOps dw_apb_timer_ops = {
+    .read = dw_apb_timer_read,
+    .write = dw_apb_timer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void dw_apb_timer_reset_hold(Object *obj, ResetType type)
+{
+    DWAPBTimerState *s = DW_APB_TIMER(obj);
+
+    for (int i = 0; i < s->num_timers; i++) {
+        DWAPBTimerChannel *t = &s->timers[i];
+
+        ptimer_transaction_begin(t->ptimer);
+        ptimer_stop(t->ptimer);
+        ptimer_transaction_commit(t->ptimer);
+
+        t->load = 0;
+        t->control = 0;
+        t->int_status = 0;
+        dw_apb_timer_update_irq(t);
+    }
+}
+
+static const VMStateDescription vmstate_dw_apb_timer_channel = {
+    .name = "dw-apb-timer-channel",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PTIMER(ptimer, DWAPBTimerChannel),
+        VMSTATE_CLOCK(clk, DWAPBTimerChannel),
+        VMSTATE_UINT32(load, DWAPBTimerChannel),
+        VMSTATE_UINT32(control, DWAPBTimerChannel),
+        VMSTATE_UINT32(int_status, DWAPBTimerChannel),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_dw_apb_timer = {
+    .name = "dw-apb-timer",
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_UINT32(timers, DWAPBTimerState,
+                                     num_timers, 0,
+                                     vmstate_dw_apb_timer_channel,
+                                     DWAPBTimerChannel),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property dw_apb_timer_properties[] = {
+    DEFINE_PROP_UINT32("num-timers", DWAPBTimerState, num_timers, 1),
+};
+
+static void dw_apb_timer_init(Object *obj)
+{
+    DWAPBTimerState *s = DW_APB_TIMER(obj);
+
+    for (int i = 0; i < DW_APB_TIMER_MAX_TIMERS; i++) {
+        DWAPBTimerChannel *t = &s->timers[i];
+        g_autofree char *name = g_strdup_printf("timer[%d]", i);
+
+        t->id = i;
+        t->clk = qdev_init_clock_in(DEVICE(obj), name,
+                                    dw_apb_timer_clk_update, t,
+                                    ClockUpdate);
+    }
+}
+
+static void dw_apb_timer_realize(DeviceState *dev, Error **errp)
+{
+    DWAPBTimerState *s = DW_APB_TIMER(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    if (s->num_timers == 0 || s->num_timers > DW_APB_TIMER_MAX_TIMERS) {
+        error_setg(errp, "dw-apb-timer: num-timers must be between 1 and %u",
+                   DW_APB_TIMER_MAX_TIMERS);
+        return;
+    }
+
+    for (int i = 0; i < s->num_timers; i++) {
+        DWAPBTimerChannel *t = &s->timers[i];
+
+        if (!clock_has_source(t->clk)) {
+            error_setg(errp, "dw-apb-timer: timer[%u] clock must be connected",
+                       i);
+            return;
+        }
+    }
+
+    for (int i = 0; i < s->num_timers; i++) {
+        DWAPBTimerChannel *t = &s->timers[i];
+
+        t->ptimer = ptimer_init(dw_apb_timer_tick, t,
+            PTIMER_POLICY_NO_IMMEDIATE_TRIGGER |
+            PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+            PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+        ptimer_transaction_begin(t->ptimer);
+        ptimer_set_limit(t->ptimer, UINT32_MAX, 1);
+        ptimer_transaction_commit(t->ptimer);
+        sysbus_init_irq(sbd, &t->irq);
+
+        /* The source may have been connected before the ptimer existed. */
+        dw_apb_timer_clk_update(t, ClockUpdate);
+    }
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &dw_apb_timer_ops,
+                          s, TYPE_DW_APB_TIMER, DW_APB_TIMER_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->mmio);
+}
+
+static void dw_apb_timer_unrealize(DeviceState *dev)
+{
+    DWAPBTimerState *s = DW_APB_TIMER(dev);
+
+    for (int i = 0; i < s->num_timers; i++) {
+        ptimer_free(s->timers[i].ptimer);
+    }
+}
+
+static void dw_apb_timer_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = dw_apb_timer_realize;
+    dc->unrealize = dw_apb_timer_unrealize;
+    dc->vmsd = &vmstate_dw_apb_timer;
+    dc->desc = "Synopsys DesignWare APB timer";
+    rc->phases.hold = dw_apb_timer_reset_hold;
+    device_class_set_props(dc, dw_apb_timer_properties);
+}
+
+static const TypeInfo dw_apb_timer_info = {
+    .name          = TYPE_DW_APB_TIMER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(DWAPBTimerState),
+    .instance_init = dw_apb_timer_init,
+    .class_init    = dw_apb_timer_class_init,
+};
+
+static void dw_apb_timer_register_type(void)
+{
+    type_register_static(&dw_apb_timer_info);
+}
+
+type_init(dw_apb_timer_register_type)
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 201b5d8316..fccc36540c 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -34,3 +34,4 @@ specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_timer.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
 
 system_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
+system_ss.add(when: 'CONFIG_DW_APB_TIMER', if_true: files('dw-apb-timer.c'))
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 634ba1da27..7f592a96c8 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -1,5 +1,13 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# dw-apb-timer.c
+dw_apb_timer_read(uint64_t addr, uint32_t val) "DW APB timer read: [0x%" PRIx64 "] -> 0x%" PRIx32
+dw_apb_timer_write(uint64_t addr, uint64_t val) "DW APB timer write: [0x%" PRIx64 "] <- 0x%" PRIx64
+dw_apb_timer_tick(int idx) "DW APB timer %d tick"
+dw_apb_timer_irq_clear(int idx) "DW APB timer %d IRQ cleared"
+dw_apb_timer_enable(int idx, uint32_t load) "DW APB timer %d enabled load=0x%" PRIx32
+dw_apb_timer_disable(int idx) "DW APB timer %d disabled"
+
 # slavio_timer.c
 slavio_timer_get_out(uint64_t limit, uint32_t counthigh, uint32_t count) "limit 0x%"PRIx64" count 0x%x0x%08x"
 slavio_timer_irq(uint32_t counthigh, uint32_t count) "callback: count 0x%x0x%08x"
diff --git a/include/hw/timer/dw-apb-timer.h b/include/hw/timer/dw-apb-timer.h
new file mode 100644
index 0000000000..f6b83ae5ca
--- /dev/null
+++ b/include/hw/timer/dw-apb-timer.h
@@ -0,0 +1,40 @@
+/*
+ * Synopsys DesignWare APB timer
+ *
+ * Copyright (c) 2026 raoyi <rao232328@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef DW_APB_TIMER_H
+#define DW_APB_TIMER_H
+
+#include "hw/core/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/core/clock.h"
+#include "qom/object.h"
+
+#define TYPE_DW_APB_TIMER "dw-apb-timer"
+OBJECT_DECLARE_SIMPLE_TYPE(DWAPBTimerState, DW_APB_TIMER)
+
+#define DW_APB_TIMER_MAX_TIMERS   8
+
+typedef struct DWAPBTimerChannel {
+    struct ptimer_state *ptimer;
+    Clock *clk;
+    qemu_irq irq;
+    unsigned int id;
+    uint32_t load;
+    uint32_t control;
+    uint32_t int_status;
+} DWAPBTimerChannel;
+
+struct DWAPBTimerState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t num_timers;
+    DWAPBTimerChannel timers[DW_APB_TIMER_MAX_TIMERS];
+};
+
+#endif
-- 
2.53.0


