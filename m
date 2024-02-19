Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D514C48BC4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 01:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbsJb-0005ag-3X; Sun, 18 Feb 2024 20:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIO-0003MX-3b; Sun, 18 Feb 2024 20:18:12 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIK-0004HJ-2f; Sun, 18 Feb 2024 20:18:11 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-607eefeea90so24780457b3.1; 
 Sun, 18 Feb 2024 17:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708305486; x=1708910286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kC4YL2o/n6VsyfdQYEYsB2wxqqdsHaAEsApKGT1G+BE=;
 b=fv6SM6v1EsjpZjS8B+i9WufUYIDeaqSSNsw+huYnCaxIHagz5SzFqtDS87XbZK8dsq
 7ADYs7wHFiT9CWYNfPHgiOprVMU4z1sBCpqtccHLtTzNZH8huozuKHnVcyBMtmhuvitH
 WR1Wj/n1G1Z2dWhfSWmFVS02qaukuDPPfihRLhhVB8nQsQTnrrsJDEVsCU0M9SMz8Fpk
 IK65nCw6+QflhUpJNuIUYKG8HoAEtQG2IuTUQ2igzE8BB26puH3yGEdmhyCdNK+yyFSg
 TjbtlKBU2901Rb2kwON74pE/Slc0S7NpvGV+XJQ8AJ3bp48bFAMyBtZiAIIAcE2QowSY
 6KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708305486; x=1708910286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kC4YL2o/n6VsyfdQYEYsB2wxqqdsHaAEsApKGT1G+BE=;
 b=JqyFiNjCfZM28S9gqjQtHY4TwlhJ2EyLlSiYToj0tUgSYu8c7uHxtbm5GEmjUgUEjm
 /z9/bpnqennYLS95Hga4MWQWEzkZd/ge1jWqqbOfJ7tu16c97idAwTo66eBOD0SaWNGL
 LMdjB8isJYrYqUTZiy0AJRnJ2sYDYV5N0vfFp+EBAMbX4lneHoRaSCgTFAkO2qtuehaT
 4S6aGB/TzfYi44V5gkh2LETbuU96e4tJKV+fIuHklpdlArIu6NNIihgj3TF5zgpgkQ7h
 z4EsI9O8iCTJ3B+Rib9nU6QLUH0s5Csa9Ou+c5W+a3B4zqqHJba8BP8fpMB1hybE2lvb
 Fu9g==
X-Gm-Message-State: AOJu0Yx1LJKVSrTXHbXunIoY31jAfKCj9c6gxFfnQXhKK7iZlbeVbyHF
 OCHWoA53jJQKXiarNmPTjWFyW9sQ6gJlfoiBAYkIvd1No+KlMzrXTtO6Zt4uKwA=
X-Google-Smtp-Source: AGHT+IEVO3cao/g6iD1ljp4y+F32SdPvBkVHC/4ma9XHwNrO4hM5AGMYuh824RMHq+JmdsNs5DdUUA==
X-Received: by 2002:a81:b717:0:b0:607:c65a:ba02 with SMTP id
 v23-20020a81b717000000b00607c65aba02mr7357232ywh.17.1708305486141; 
 Sun, 18 Feb 2024 17:18:06 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a819e0c000000b00607ff905ed3sm1204704ywj.58.2024.02.18.17.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 17:18:05 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v5 16/41] Add RPi4 RNG200
Date: Sun, 18 Feb 2024 19:17:14 -0600
Message-Id: <20240219011739.2316619-17-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838.c                     |   4 +
 hw/arm/bcm2838_peripherals.c         |  14 +
 hw/arm/raspi4b.c                     |   1 -
 hw/misc/bcm2838_rng200.c             | 405 +++++++++++++++++++++++++++
 hw/misc/meson.build                  |   1 +
 hw/misc/trace-events                 |   9 +
 include/hw/arm/bcm2838_peripherals.h |   2 +
 include/hw/misc/bcm2838_rng200.h     |  43 +++
 8 files changed, 478 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/bcm2838_rng200.c
 create mode 100644 include/hw/misc/bcm2838_rng200.h

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 481b262b02..c330322bd5 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -205,6 +205,10 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dwc2), 0,
                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DWC2));
 
+    /* Connect RNG200 to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->rng200), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_RNG200));
+
     /* Connect DMA 0-6 to the interrupt controller */
     for (int n = GIC_SPI_INTERRUPT_DMA_0; n <= GIC_SPI_INTERRUPT_DMA_6; n++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dma),
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 7e86ebb555..6b4c840c5b 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -34,6 +34,9 @@ static void bcm2838_peripherals_init(Object *obj)
                        bc->peri_low_size);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_low_mr);
 
+    /* Random Number Generator */
+    object_initialize_child(obj, "rng200", &s->rng200, TYPE_BCM2838_RNG200);
+
     /* PCIe Host Bridge */
     object_initialize_child(obj, "pcie-host", &s->pcie_host,
                             TYPE_BCM2838_PCIE_HOST);
@@ -88,6 +91,17 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
                                         BCM2838_VC_PERI_LOW_BASE,
                                         &s->peri_low_mr_alias, 1);
 
+    /* Random Number Generator */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng200), errp)) {
+        return;
+    }
+    memory_region_add_subregion(
+        &s_base->peri_mr, RNG_OFFSET,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng200), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng200), 0,
+        qdev_get_gpio_in_named(DEVICE(&s_base->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_RNG));
+
     /* Extended Mass Media Controller 2 */
     object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
                              &error_abort);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 2431b0b8c3..3c71fa9a9a 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -67,7 +67,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     /* Temporarily disable following devices until they are implemented */
     const char *nodes_to_remove[] = {
-        "brcm,bcm2711-rng200",
         "brcm,bcm2711-thermal",
         "brcm,bcm2711-genet-v5",
     };
diff --git a/hw/misc/bcm2838_rng200.c b/hw/misc/bcm2838_rng200.c
new file mode 100644
index 0000000000..84ed723a1c
--- /dev/null
+++ b/hw/misc/bcm2838_rng200.c
@@ -0,0 +1,405 @@
+/*
+ * BCM2838 Random Number Generator emulation
+ *
+ * Copyright (C) 2022 Sergey Pushkarev <sergey.pushkarev@auriga.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qom/object_interfaces.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/bcm2838_rng200.h"
+#include "hw/registerfields.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+/* RNG200 registers */
+REG32(RNG_CTRL,               0x00)
+    FIELD(RNG_CTRL, RBG_ENABLE,   0 , 1)
+    FIELD(RNG_CTRL, RSVD,         1 , 12)
+    FIELD(RNG_CTRL, DIV,         13 , 8)
+
+REG32(RNG_SOFT_RESET,                0x04)
+REG32(RBG_SOFT_RESET,                0x08)
+REG32(RNG_TOTAL_BIT_COUNT,           0x0C)
+REG32(RNG_TOTAL_BIT_COUNT_THRESHOLD, 0x10)
+
+REG32(RNG_INT_STATUS,                               0x18)
+    FIELD(RNG_INT_STATUS, TOTAL_BITS_COUNT_IRQ,         0, 1)
+    FIELD(RNG_INT_STATUS, RSVD0,                        1, 4)
+    FIELD(RNG_INT_STATUS, NIST_FAIL_IRQ,                5, 1)
+    FIELD(RNG_INT_STATUS, RSVD1,                        6, 11)
+    FIELD(RNG_INT_STATUS, STARTUP_TRANSITIONS_MET_IRQ,  17, 1)
+    FIELD(RNG_INT_STATUS, RSVD2,                        18, 13)
+    FIELD(RNG_INT_STATUS, MASTER_FAIL_LOCKOUT_IRQ,      30, 1)
+
+REG32(RNG_INT_ENABLE,                               0x1C)
+    FIELD(RNG_INT_ENABLE, TOTAL_BITS_COUNT_IRQ,         0, 1)
+    FIELD(RNG_INT_ENABLE, RSVD0,                        1, 4)
+    FIELD(RNG_INT_ENABLE, NIST_FAIL_IRQ,                5, 1)
+    FIELD(RNG_INT_ENABLE, RSVD1,                        6, 11)
+    FIELD(RNG_INT_ENABLE, STARTUP_TRANSITIONS_MET_IRQ,  17, 1)
+    FIELD(RNG_INT_ENABLE, RSVD2,                        18, 13)
+    FIELD(RNG_INT_ENABLE, MASTER_FAIL_LOCKOUT_IRQ,      30, 1)
+
+REG32(RNG_FIFO_DATA, 0x20)
+
+REG32(RNG_FIFO_COUNT,              0x24)
+    FIELD(RNG_FIFO_COUNT, COUNT,       0, 8)
+    FIELD(RNG_FIFO_COUNT, THRESHOLD,   8, 8)
+
+
+#define RNG_WARM_UP_PERIOD_ELAPSED           17
+
+#define SOFT_RESET    1
+#define IRQ_PENDING   1
+
+#define BCM2838_RNG200_PTIMER_POLICY         (PTIMER_POLICY_CONTINUOUS_TRIGGER)
+
+static const VMStateDescription vmstate_bcm2838_rng200 = {
+    .name = "bcm2838_rng200",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(rng_fifo_cap, BCM2838Rng200State),
+        VMSTATE_ARRAY(regs, BCM2838Rng200State, N_BCM2838_RNG200_REGS, 0,
+                      vmstate_info_uint32, uint32_t),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool is_rbg_enabled(BCM2838Rng200State *s)
+{
+    return FIELD_EX32(s->regs[R_RNG_CTRL], RNG_CTRL, RBG_ENABLE);
+}
+
+static void increment_bit_counter_by(BCM2838Rng200State *s, uint32_t inc_val) {
+    s->regs[R_RNG_TOTAL_BIT_COUNT] += inc_val;
+}
+
+static void bcm2838_rng200_update_irq(BCM2838Rng200State *s)
+{ 
+    qemu_set_irq(s->irq,
+                !!(s->regs[R_RNG_INT_ENABLE] & s->regs[R_RNG_INT_STATUS]));
+}
+
+static void bcm2838_rng200_update_rbg_period(void *opaque, ClockEvent event)
+{
+    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
+
+    ptimer_transaction_begin(s->ptimer);
+    ptimer_set_period_from_clock(s->ptimer, s->clock, s->rng_fifo_cap * 8);
+    ptimer_transaction_commit(s->ptimer);
+}
+
+static void bcm2838_rng200_update_fifo(void *opaque, const void *buf,
+                                       size_t size)
+{
+    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
+    Fifo8 *fifo = &s->fifo;
+    size_t num = MIN(size, fifo8_num_free(fifo));
+    uint32_t num_bits = num * 8;
+    uint32_t bit_count = 0;
+    uint32_t bit_count_thld = 0;
+    uint32_t fifo_thld = 0;
+
+    bit_count = s->regs[R_RNG_TOTAL_BIT_COUNT];
+    bit_count_thld = s->regs[R_RNG_TOTAL_BIT_COUNT_THRESHOLD];
+
+    if (bit_count + num_bits < bit_count_thld) {
+        increment_bit_counter_by(s, num_bits);
+
+        fifo8_push_all(fifo, buf, num);
+
+        fifo_thld = FIELD_EX32(s->regs[R_RNG_FIFO_COUNT],
+                               RNG_FIFO_COUNT, THRESHOLD);
+
+        if (fifo8_num_used(fifo) > fifo_thld) {
+            s->regs[R_RNG_INT_STATUS] = FIELD_DP32(s->regs[R_RNG_INT_STATUS],
+                                                    RNG_INT_STATUS,
+                                                    TOTAL_BITS_COUNT_IRQ, 1);
+        }
+    }
+
+    s->regs[R_RNG_FIFO_COUNT] = FIELD_DP32(s->regs[R_RNG_FIFO_COUNT],
+                                           RNG_FIFO_COUNT,
+                                           COUNT,
+                                           fifo8_num_used(fifo) >> 2);
+    bcm2838_rng200_update_irq(s);
+    trace_bcm2838_rng200_update_fifo(num, fifo8_num_used(fifo));
+}
+
+static void bcm2838_rng200_fill_fifo(BCM2838Rng200State *s)
+{
+    rng_backend_request_entropy(s->rng, fifo8_num_free(&s->fifo),
+                                bcm2838_rng200_update_fifo, s);
+}
+
+static void bcm2838_rng200_disable_rbg(void)
+{
+    trace_bcm2838_rng200_disable_rbg();
+}
+
+static void bcm2838_rng200_enable_rbg(BCM2838Rng200State *s)
+{
+    s->regs[R_RNG_TOTAL_BIT_COUNT] = RNG_WARM_UP_PERIOD_ELAPSED;
+
+    bcm2838_rng200_fill_fifo(s);
+
+    trace_bcm2838_rng200_enable_rbg();
+}
+
+static void bcm2838_rng200_rng_reset(BCM2838Rng200State *s)
+{
+    memset(s->regs, 0, sizeof(s->regs));
+    s->regs[R_RNG_INT_STATUS] = FIELD_DP32(s->regs[R_RNG_INT_STATUS],
+                                           RNG_INT_STATUS,
+                                           STARTUP_TRANSITIONS_MET_IRQ,
+                                           IRQ_PENDING);
+    fifo8_reset(&s->fifo);
+
+    trace_bcm2838_rng200_rng_soft_reset();
+}
+
+static void bcm2838_rng200_rbg_reset(BCM2838Rng200State *s)
+{
+    trace_bcm2838_rng200_rbg_soft_reset();
+}
+
+static uint32_t bcm2838_rng200_read_fifo_data(BCM2838Rng200State *s)
+{
+    const uint8_t *buf;
+    Fifo8 *fifo = &s->fifo;
+    uint32_t to_read = MIN(fifo8_num_used(fifo), 4);
+    uint8_t byte_buf[4] = {};
+    uint8_t *p = byte_buf;
+    uint32_t ret = 0;
+    uint32_t num = 0;
+
+    while (to_read) {
+        buf = fifo8_pop_buf(fifo, to_read, &num);
+        memcpy(p, buf, num);
+        p += num;
+        to_read -= num;
+    }
+    ret = ldl_le_p(byte_buf);
+
+    s->regs[R_RNG_FIFO_COUNT] = FIELD_DP32(s->regs[R_RNG_FIFO_COUNT],
+                                           RNG_FIFO_COUNT,
+                                           COUNT,
+                                           fifo8_num_used(fifo) >> 2);
+
+    bcm2838_rng200_fill_fifo(s);
+
+    return ret;
+}
+
+static void bcm2838_rng200_ctrl_write(BCM2838Rng200State *s, uint32_t value)
+{
+    bool currently_enabled = is_rbg_enabled(s);
+    bool enable_requested = FIELD_EX32(value, RNG_CTRL, RBG_ENABLE);
+
+    s->regs[R_RNG_CTRL] = value;
+
+    if (!currently_enabled && enable_requested) {
+        bcm2838_rng200_enable_rbg(s);
+    } else if (currently_enabled && !enable_requested) {
+        bcm2838_rng200_disable_rbg();
+    }
+}
+
+static uint64_t bcm2838_rng200_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
+    uint32_t res = 0;
+
+    switch (offset) {
+    case A_RNG_CTRL:
+        res = s->regs[R_RNG_CTRL];
+        break;
+    case A_RNG_SOFT_RESET:
+    case A_RBG_SOFT_RESET:
+        break;
+    case A_RNG_INT_STATUS:
+        res = s->regs[R_RNG_INT_STATUS];
+        break;
+    case A_RNG_INT_ENABLE:
+        res = s->regs[R_RNG_INT_ENABLE];
+        break;
+    case A_RNG_FIFO_DATA:
+        res = bcm2838_rng200_read_fifo_data(s);
+        break;
+    case A_RNG_FIFO_COUNT:
+        res = s->regs[R_RNG_FIFO_COUNT];
+        break;
+    case A_RNG_TOTAL_BIT_COUNT:
+        res = s->regs[R_RNG_TOTAL_BIT_COUNT];
+        break;
+    case A_RNG_TOTAL_BIT_COUNT_THRESHOLD:
+        res = s->regs[R_RNG_TOTAL_BIT_COUNT_THRESHOLD];
+        break;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "bcm2838_rng200_read: Bad offset 0x%" HWADDR_PRIx "\n",
+            offset
+        );
+        res = 0;
+        break;
+    }
+
+    trace_bcm2838_rng200_read(offset, size, res);
+    return res;
+}
+
+static void bcm2838_rng200_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
+
+    trace_bcm2838_rng200_write(offset, value, size);
+
+    switch (offset) {
+    case A_RNG_CTRL:
+        bcm2838_rng200_ctrl_write(s, value);
+        break;
+    case A_RNG_SOFT_RESET:
+        if (value & SOFT_RESET) {
+            bcm2838_rng200_rng_reset(s);
+        }
+        break;
+    case A_RBG_SOFT_RESET:
+        if (value & SOFT_RESET) {
+            bcm2838_rng200_rbg_reset(s);
+        }
+        break;
+    case A_RNG_INT_STATUS:
+        s->regs[R_RNG_INT_STATUS] &= ~value;
+        bcm2838_rng200_update_irq(s);
+        break;
+    case A_RNG_INT_ENABLE:
+        s->regs[R_RNG_INT_ENABLE] = value;
+        bcm2838_rng200_update_irq(s);
+        break;
+    case A_RNG_FIFO_COUNT:
+        s->regs[R_RNG_FIFO_COUNT] = value;
+        break;
+    case A_RNG_TOTAL_BIT_COUNT_THRESHOLD:
+        s->regs[R_RNG_TOTAL_BIT_COUNT_THRESHOLD] = value;
+        s->regs[R_RNG_TOTAL_BIT_COUNT] = value + 1;
+        break;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "bcm2838_rng200_write: Bad offset 0x%" HWADDR_PRIx "\n",
+            offset
+        );
+        break;
+    }
+}
+
+static const MemoryRegionOps bcm2838_rng200_ops = {
+    .read = bcm2838_rng200_read,
+    .write = bcm2838_rng200_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .max_access_size = 4,
+        .min_access_size = 4,
+    },
+    .valid = {
+        .max_access_size = 4,
+        .min_access_size = 4
+    },
+};
+
+static void bcm2838_rng200_realize(DeviceState *dev, Error **errp)
+{
+    BCM2838Rng200State *s = BCM2838_RNG200(dev);
+
+    if (s->rng == NULL) {
+        Object *default_backend = object_new(TYPE_RNG_BUILTIN);
+
+        if (!user_creatable_complete(USER_CREATABLE(default_backend),
+                                     errp)) {
+            object_unref(default_backend);
+            error_setg(errp, "Failed to create user creatable RNG backend");
+            return;
+        }
+
+        object_property_add_child(OBJECT(dev), "default-backend",
+                                  default_backend);
+        object_unref(default_backend);
+
+        object_property_set_link(OBJECT(dev), "rng", default_backend,
+                                 errp);
+    }
+
+    fifo8_create(&s->fifo, s->rng_fifo_cap);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+}
+
+static void bcm2838_rng200_init(Object *obj)
+{
+    BCM2838Rng200State *s = BCM2838_RNG200(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    s->rng_fifo_cap = 128;
+
+    s->clock = qdev_init_clock_in(DEVICE(s), "rbg-clock",
+                                  bcm2838_rng200_update_rbg_period, s,
+                                  ClockPreUpdate);
+    if (s->clock == NULL) {
+        error_setg(&error_fatal, "Failed to init RBG clock");
+        return;
+    }
+
+    memory_region_init_io(&s->iomem, obj, &bcm2838_rng200_ops, s,
+                          TYPE_BCM2838_RNG200, 0x28);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void bcm2838_rng200_reset(DeviceState *dev)
+{
+    BCM2838Rng200State *s = BCM2838_RNG200(dev);
+
+    bcm2838_rng200_rbg_reset(s);
+    bcm2838_rng200_rng_reset(s);
+}
+
+static Property bcm2838_rng200_properties[] = {
+    DEFINE_PROP_LINK("rng", BCM2838Rng200State, rng,
+                     TYPE_RNG_BACKEND, RngBackend *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void bcm2838_rng200_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2838_rng200_realize;
+    dc->reset = bcm2838_rng200_reset;
+    dc->vmsd = &vmstate_bcm2838_rng200;
+
+    device_class_set_props(dc, bcm2838_rng200_properties);
+}
+
+static const TypeInfo bcm2838_rng200_info = {
+    .name          = TYPE_BCM2838_RNG200,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2838Rng200State),
+    .class_init    = bcm2838_rng200_class_init,
+    .instance_init = bcm2838_rng200_init,
+};
+
+static void bcm2838_rng200_register_types(void)
+{
+    type_register_static(&bcm2838_rng200_info);
+}
+
+type_init(bcm2838_rng200_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e4ef1da5a5..7c769fd2a4 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -91,6 +91,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_thermal.c',
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
+  'bcm2838_rng200.c'
 ))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 5f5bc92222..e09e399580 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -341,3 +341,12 @@ djmemc_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRI
 # iosb.c
 iosb_read(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
 iosb_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
+# bcm2838_rng200.c
+bcm2838_rng200_rng_soft_reset(void) "RNumG soft reset"
+bcm2838_rng200_rbg_soft_reset(void) "RBitG soft reset"
+bcm2838_rng200_enable_rbg(void)     "RBitG enabled"
+bcm2838_rng200_disable_rbg(void)    "RBitG disabled"
+bcm2838_rng200_update_fifo(uint32_t len, uint32_t fifo_len)    "len %u, fifo_len %u"
+bcm2838_rng200_fifo_full(void) "RNumG FIFO full"
+bcm2838_rng200_write(uint64_t addr, uint64_t value, unsigned size) "addr: 0x%"PRIx64" value: 0x%016" PRIx64 " size: %u"
+bcm2838_rng200_read(uint64_t addr, unsigned size, uint64_t value) "addr: 0x%"PRIx64" size: %u value: 0x%016" PRIx64
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index bbd8387cff..914a287af2 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -10,6 +10,7 @@
 #define BCM2838_PERIPHERALS_H
 
 #include "hw/arm/bcm2835_peripherals.h"
+#include "hw/misc/bcm2838_rng200.h"
 #include "hw/arm/bcm2838_pcie.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
@@ -64,6 +65,7 @@ struct BCM2838PeripheralState {
     MemoryRegion peri_low_mr_alias;
     MemoryRegion mphi_mr_alias;
 
+    BCM2838Rng200State rng200;
     SDHCIState emmc2;
     BCM2838PcieHostState pcie_host;
     BCM2838GpioState gpio;
diff --git a/include/hw/misc/bcm2838_rng200.h b/include/hw/misc/bcm2838_rng200.h
new file mode 100644
index 0000000000..8e084b7254
--- /dev/null
+++ b/include/hw/misc/bcm2838_rng200.h
@@ -0,0 +1,43 @@
+/*
+ * BCM2838 Random Number Generator emulation
+ *
+ * Copyright (C) 2022 Sergey Pushkarev <sergey.pushkarev@auriga.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef BCM2838_RNG200_H
+#define BCM2838_RNG200_H
+
+#include <stdbool.h>
+#include "qom/object.h"
+#include "qemu/fifo8.h"
+#include "sysemu/rng.h"
+#include "hw/sysbus.h"
+#include "hw/ptimer.h"
+#include "hw/qdev-clock.h"
+#include "hw/irq.h"
+
+#define TYPE_BCM2838_RNG200 "bcm2838-rng200"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2838Rng200State, BCM2838_RNG200)
+
+#define N_BCM2838_RNG200_REGS 9
+
+struct BCM2838Rng200State {
+    SysBusDevice busdev;
+    MemoryRegion iomem;
+
+    ptimer_state *ptimer;
+    RngBackend *rng;
+    Clock *clock;
+
+    uint32_t rng_fifo_cap;
+    Fifo8    fifo;
+
+    qemu_irq irq;
+
+    uint32_t regs[N_BCM2838_RNG200_REGS];
+};
+
+#endif /* BCM2838_RNG200_H */
-- 
2.34.1


