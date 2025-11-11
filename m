Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3732CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImrI-0006gW-TI; Tue, 11 Nov 2025 06:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqL-0004jn-VK
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:26 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqJ-0004OZ-IL
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:25 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-29808a9a96aso23117085ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861641; x=1763466441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnNgxDvECjfofIwXpwzJzkhqPD4xUi0O1E23cP4lx4s=;
 b=hBkxuIP4H4jPIytE6XWUzUGzdRbyJNnFSAksFcAe/RNlyIU4G0e2qbfbBAcq2jHErU
 1G9iz2eyZrh0+PunzXzIiehTYSVdoKD/e7ml5RSSAzcH+wLqQZZYV/NZLRNYkMKGc3XU
 nqSczV7BT+GcYlZmOjGXtYDIByi6uab2PRYqVhL4vkJai7C0gMHNyY698WXFT10kGGIB
 EyBXUk4wvunNuQj7uRgw0PoWhdOM4hnOgyNdXLyHfVINIjIyKTNYp0bwUC0WX3J2vL2L
 pRUQczoxVCJh8wjmhzu8iOpx50JsL3uZ06r5ItwZJsEHO1Vg7MgKkIH8bAXjJV18gtU+
 mnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861641; x=1763466441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OnNgxDvECjfofIwXpwzJzkhqPD4xUi0O1E23cP4lx4s=;
 b=b0IzV8zr8XqOKdQCxOkYezvWwwQ5RWP/44BleVDe/ztnX8Y3mszozzav+QEWV0gwFi
 iNNS32dIyIEq/v1j1nNK4WSLKXoqpTcxbXTQluDPCGdeVEYghipO4eO6ZXyFiMe9s4Iz
 1uyTWkrPtkAUIgO2A3C/VJoAgLzngyZWPALXmt9JqjZ2Vl05BZ1lnyg0Btbw73EdQMn9
 Py3tsHSqr0PO0s3WxWYKXoE7ENaeGB2wdOLBORimH6VDvCwCYoPZOdJtIAw6QXeJuJ7o
 bfMEblpy6DHXuxl6kJ6ZW4WpOXPrjV/gE6IbmUHwqFu88aUvmmWP8zdXi5Kl+E+CFvTG
 8vSQ==
X-Gm-Message-State: AOJu0Yxxo9aaraAGlJY1CYZmTRotT9/yv0MrZJReP6ruCRHCCjVHmUDp
 ofVGk4SACh1arqeLbSnJ6BdfpGS8QpBda+nbMsnlUfp6zlbzgkfelhzMMC3mC7P5A21kmTIOZ7G
 ZGsqFERo=
X-Gm-Gg: ASbGncsKghfXJG/9Aq+bUhcQC1Bjoer6gj969aaIjDZvA+LyhxkkIp21JxDyh2IV5vP
 naIE/2as5h7YO4dCbrc7uByb6kgnVRi/zDl4+yYyZd/bz4G5lyVgSA5HfvaHAEEcMGyM0A7fcKr
 GLsWYwb3aplB56adXcg0dDmqnb+t57jFWtdhyNPPwHgi50pku5wuHhsM8QjFBOrUNGlkNsbpgRU
 B68r7gzHVjR60OiM4C5LevuVF2ysD7wNDFuOh11UWHECNUDYRgThoX1+Kr3gLh+WiqAHbAGhzQs
 GVo2KyeFjLFs04hJ9+DSLxrKrBslFnn92+Fbi30C3xh8dCbP6USytvF3h+qit0TzbJgHDFl2ylR
 8eVu9gLTqOhWpHnGo5mnZL1IcmDPKzeLqe0O9dGu3bCub0R8B6u3TAa9I/45HvAW7jlnV/t89BP
 0mZXB/iH6xdDpXfgvHEvwKswQ1n8w=
X-Google-Smtp-Source: AGHT+IHVuK/yIbMSqMmgxWCK07cYDcrrA7apki/JNfMucSN5RSsb6RoYrXE4uwvfJiblkhmsa+g/kA==
X-Received: by 2002:a17:903:244a:b0:295:59ef:809e with SMTP id
 d9443c01a7336-297e564e380mr154915745ad.24.1762861641429; 
 Tue, 11 Nov 2025 03:47:21 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:47:21 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 02/17] hw/riscv: Trace RAM Sink initial impl
Date: Tue, 11 Nov 2025 08:46:41 -0300
Message-ID: <20251111114656.2285048-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Following the effort to implement the basic support for Efficient Trace
(e-trace) in QEMU we'll add a Trace RAM Sink implementation.

Similar to the Trace Encoder, this is inspired in both the Efficient
Trace for RISC-V [1] and  RISC-V Trace Control Interface Specification
[2] specs. It implements a minimal set of features to get started - only
SMEM will be supported for now.

We'll implement the RAM sink logic in the next patches, although most of
the work will be done by the trace encoder.

[1] https://github.com/riscv-non-isa/riscv-trace-spec/releases/download/v2.0-20250616/riscv-trace-spec-asciidoc.pdf
[2] https://github.com/riscv-non-isa/tg-nexus-trace/releases/download/1.0_Ratified/RISC-V-Trace-Control-Interface.pdf

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/meson.build      |   2 +-
 hw/riscv/trace-events     |   4 +
 hw/riscv/trace-ram-sink.c | 263 ++++++++++++++++++++++++++++++++++++++
 hw/riscv/trace-ram-sink.h |  83 ++++++++++++
 4 files changed, 351 insertions(+), 1 deletion(-)
 create mode 100644 hw/riscv/trace-ram-sink.c
 create mode 100644 hw/riscv/trace-ram-sink.h

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index b4a9988a62..2aadbe1e50 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -14,6 +14,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c', 'trace-ram-sink.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 0cbf6ffcb6..14e333fd9e 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -28,3 +28,7 @@ riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx
 # trace-encoder.c
 trencoder_read_error(uint64_t addr) "addr 0x%" PRIx64
 trencoder_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
+
+# trace-ram-sink.c
+tr_ramsink_read_error(uint64_t addr) "addr 0x%" PRIx64
+tr_ramsink_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
diff --git a/hw/riscv/trace-ram-sink.c b/hw/riscv/trace-ram-sink.c
new file mode 100644
index 0000000000..e00de80c04
--- /dev/null
+++ b/hw/riscv/trace-ram-sink.c
@@ -0,0 +1,263 @@
+/*
+ * Emulation of a RISC-V Trace RAM Sink
+ *
+ * Copyright (C) 2025 Ventana Micro Systems Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "trace-ram-sink.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "system/device_tree.h"
+#include "hw/sysbus.h"
+#include "hw/register.h"
+
+#define R_TR_RAM_CONTROL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
+                                    R_TR_RAM_CONTROL_RSVP1_MASK | \
+                                    R_TR_RAM_CONTROL_RSVP2_MASK | \
+                                    R_TR_RAM_CONTROL_RSVP3_MASK | \
+                                    R_TR_RAM_CONTROL_RSVP4_MASK)
+
+/* trRamEmpty is the only RO field and reset value */
+#define R_TR_RAM_CONTROL_RESET R_TR_RAM_CONTROL_EMPTY_MASK
+#define R_TR_RAM_CONTROL_RO_BITS R_TR_RAM_CONTROL_EMPTY_MASK
+
+#define R_TR_RAM_IMPL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
+                                 R_TR_RAM_IMPL_RSVP1_MASK)
+
+#define R_TR_RAM_IMPL_RO_BITS (R_TR_RAM_IMPL_VER_MAJOR_MASK | \
+                               R_TR_RAM_IMPL_VER_MINOR_MASK | \
+                               R_TR_RAM_IMPL_COMP_TYPE_MASK | \
+                               R_TR_RAM_IMPL_HAS_SRAM_MASK | \
+                               R_TR_RAM_IMPL_HAS_SMEM_MASK)
+
+#define R_TR_RAM_IMPL_RESET (BIT(0) | 0x9 << 8)
+
+static RegisterAccessInfo tr_ramsink_regs_info[] = {
+    {   .name = "TR_RAM_CONTROL", .addr = A_TR_RAM_CONTROL,
+        .rsvd = R_TR_RAM_CONTROL_RSVP_BITS,
+        .reset = R_TR_RAM_CONTROL_RESET,
+        .ro = R_TR_RAM_CONTROL_RO_BITS,
+    },
+    {   .name = "TR_RAM_IMPL", .addr = A_TR_RAM_IMPL,
+        .rsvd = R_TR_RAM_IMPL_RSVP_BITS,
+        .reset = R_TR_RAM_IMPL_RESET,
+        .ro = R_TR_RAM_IMPL_RO_BITS,
+    },
+    {   .name = "TR_RAM_START_LOW", .addr = A_TR_RAM_START_LOW,
+    },
+    {   .name = "TR_RAM_START_HIGH", .addr = A_TR_RAM_START_HIGH,
+    },
+    {   .name = "TR_RAM_LIMIT_LOW", .addr = A_TR_RAM_LIMIT_LOW,
+    },
+    {   .name = "TR_RAM_LIMIT_HIGH", .addr = A_TR_RAM_LIMIT_HIGH,
+    },
+    {   .name = "TR_RAM_WP_LOW", .addr = A_TR_RAM_WP_LOW,
+    },
+    {   .name = "TR_RAM_WP_HIGH", .addr = A_TR_RAM_WP_HIGH,
+    },
+};
+
+static uint64_t tr_ramsink_regread(void *opaque, hwaddr addr, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+    RegisterInfo *r = &tram->regs_info[addr / 4];
+
+    if (!r->data) {
+        trace_tr_ramsink_read_error(addr);
+        return 0;
+    }
+
+    return register_read(r, ~0, NULL, false);
+}
+
+static void tr_ramsink_regwrite(void *opaque, hwaddr addr,
+                            uint64_t value, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+    RegisterInfo *r = &tram->regs_info[addr / 4];
+
+    if (!r->data) {
+        trace_tr_ramsink_write_error(addr, value);
+        return;
+    }
+
+    register_write(r, value, ~0, NULL, false);
+}
+
+static const MemoryRegionOps tr_ramsink_regops = {
+    .read = tr_ramsink_regread,
+    .write = tr_ramsink_regwrite,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static uint64_t tr_ramsink_msgread(void *opaque, hwaddr addr, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+
+    switch (size) {
+    case 1:
+        return tram->msgs[addr];
+    case 2:
+        return (uint16_t)tram->msgs[addr];
+    case 4:
+        return (uint32_t)tram->msgs[addr];
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tr_ramsink_msgwrite(void *opaque, hwaddr addr,
+                                uint64_t value, unsigned size)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(opaque);
+
+    switch (size) {
+    case 1:
+        tram->msgs[addr] = value;
+        break;
+    case 2:
+        tram->msgs[addr] = extract16(value, 0, 8);
+        tram->msgs[addr + 1] = extract16(value, 8, 8);
+        break;
+    case 4:
+        tram->msgs[addr] = extract32(value, 0, 8);
+        tram->msgs[addr + 1] = extract32(value, 8, 8);
+        tram->msgs[addr + 2] = extract32(value, 16, 8);
+        tram->msgs[addr + 3] = extract32(value, 24, 8);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps tr_ramsink_smemops = {
+    .read = tr_ramsink_msgread,
+    .write = tr_ramsink_msgwrite,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void tr_ramsink_setup_regs(TraceRamSink *tram)
+{
+    hwaddr ramlimit = tram->smemaddr + tram->smemsize;
+
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_START_LOW, ADDR,
+                     extract64(tram->smemaddr, 2, 30));
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_START_HIGH, ADDR,
+                     extract64(tram->smemaddr, 32, 32));
+
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_WP_LOW, ADDR,
+                     extract64(tram->smemaddr, 2, 30));
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_WP_HIGH, ADDR,
+                     extract64(tram->smemaddr, 32, 32));
+
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_LIMIT_LOW, ADDR,
+                     extract64(ramlimit, 2, 30));
+    ARRAY_FIELD_DP32(tram->regs, TR_RAM_LIMIT_HIGH, ADDR,
+                     extract64(ramlimit, 32, 32));
+}
+
+static void tr_ramsink_reset(DeviceState *dev)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(dev);
+
+    for (int i = 0; i < ARRAY_SIZE(tram->regs_info); i++) {
+        register_reset(&tram->regs_info[i]);
+    }
+
+    tr_ramsink_setup_regs(tram);
+}
+
+static void tr_ramsink_realize(DeviceState *dev, Error **errp)
+{
+    TraceRamSink *tram = TRACE_RAM_SINK(dev);
+
+    memory_region_init_io(&tram->reg_mem, OBJECT(dev),
+                          &tr_ramsink_regops, tram,
+                          "trace-ram-sink-regs",
+                          tram->reg_mem_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(tram), &tram->reg_mem);
+    sysbus_mmio_map(SYS_BUS_DEVICE(tram), 0, tram->baseaddr);
+
+    g_assert(tram->smemsize > 0);
+    tram->msgs = g_malloc0(tram->smemsize);
+
+    memory_region_init_io(&tram->smem, OBJECT(dev),
+                          &tr_ramsink_smemops, tram,
+                          "trace-ram-sink-smem",
+                          tram->smemsize);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &tram->smem);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, tram->smemaddr);
+
+    /* RegisterInfo init taken from hw/dma/xlnx-zdma.c */
+    for (int i = 0; i < ARRAY_SIZE(tr_ramsink_regs_info); i++) {
+        uint32_t reg_idx = tr_ramsink_regs_info[i].addr / 4;
+        RegisterInfo *r = &tram->regs_info[reg_idx];
+
+        *r = (RegisterInfo) {
+            .data = (uint8_t *)&tram->regs[reg_idx],
+            .data_size = sizeof(uint32_t),
+            .access = &tr_ramsink_regs_info[i],
+            .opaque = tram,
+        };
+    }
+}
+
+static const Property tr_ramsink_props[] = {
+    DEFINE_PROP_UINT64("baseaddr", TraceRamSink, baseaddr, 0),
+    DEFINE_PROP_UINT64("smemaddr", TraceRamSink, smemaddr, 0),
+    DEFINE_PROP_UINT32("smemsize", TraceRamSink, smemsize, 0),
+    DEFINE_PROP_UINT32("reg-mem-size", TraceRamSink,
+                       reg_mem_size, TR_DEV_REGMAP_SIZE),
+};
+
+static const VMStateDescription vmstate_tr_ramsink = {
+    .name = TYPE_TRACE_RAM_SINK,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, TraceRamSink, TRACE_R_MAX),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static void tr_ramsink_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, tr_ramsink_reset);
+    device_class_set_props(dc, tr_ramsink_props);
+    dc->realize = tr_ramsink_realize;
+    dc->vmsd = &vmstate_tr_ramsink;
+}
+
+static const TypeInfo tr_ramsink_info = {
+    .name          = TYPE_TRACE_RAM_SINK,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TraceRamSink),
+    .class_init    = tr_ramsink_class_init,
+};
+
+static void tr_ramsink_register_types(void)
+{
+    type_register_static(&tr_ramsink_info);
+}
+
+type_init(tr_ramsink_register_types)
diff --git a/hw/riscv/trace-ram-sink.h b/hw/riscv/trace-ram-sink.h
new file mode 100644
index 0000000000..cd55145669
--- /dev/null
+++ b/hw/riscv/trace-ram-sink.h
@@ -0,0 +1,83 @@
+/*
+ * Emulation of a RISC-V Trace RAM Sink
+ *
+ * Copyright (C) 2025 Ventana Micro Systems Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV_TRACE_RAM_SINK_H
+#define RISCV_TRACE_RAM_SINK_H
+
+#include "hw/register.h"
+#include "hw/sysbus.h"
+#include "system/dma.h"
+#include "qom/object.h"
+
+#define TRACE_R_MAX (0xFFF / 4)
+#define TR_DEV_REGMAP_SIZE 0x1000
+
+/*
+ * The Trace Encoder will read/write those regs so put their
+ * declaration in this header.
+ */
+REG32(TR_RAM_CONTROL, 0x0)
+    FIELD(TR_RAM_CONTROL, ACTIVE, 0, 1)
+    FIELD(TR_RAM_CONTROL, ENABLE, 1, 1)
+    FIELD(TR_RAM_CONTROL, EMPTY, 3, 1)
+    FIELD(TR_RAM_CONTROL, MODE, 4, 1)
+    FIELD(TR_RAM_CONTROL, STOP_ON_WRAP, 8, 1)
+    FIELD(TR_RAM_CONTROL, MEM_FORMAT, 9, 2)
+    /* reserved bits */
+    FIELD(TR_RAM_CONTROL, RSVP1, 2, 1)
+    FIELD(TR_RAM_CONTROL, RSVP2, 5, 2)
+    FIELD(TR_RAM_CONTROL, RSVP3, 11, 1)
+    FIELD(TR_RAM_CONTROL, RSVP4, 15, 16)
+
+REG32(TR_RAM_IMPL, 0x4)
+    FIELD(TR_RAM_IMPL, VER_MAJOR, 0, 4)
+    FIELD(TR_RAM_IMPL, VER_MINOR, 4, 4)
+    FIELD(TR_RAM_IMPL, COMP_TYPE, 8, 4)
+    FIELD(TR_RAM_IMPL, HAS_SRAM, 12, 1)
+    FIELD(TR_RAM_IMPL, HAS_SMEM, 13, 1)
+    /* reserved bits */
+    FIELD(TR_RAM_IMPL, RSVP1, 14, 18)
+
+REG32(TR_RAM_START_LOW, 0x010)
+    FIELD(TR_RAM_START_LOW, ADDR, 2, 30)
+REG32(TR_RAM_START_HIGH, 0x014)
+    FIELD(TR_RAM_START_HIGH, ADDR, 0, 32)
+
+REG32(TR_RAM_LIMIT_LOW, 0x018)
+    FIELD(TR_RAM_LIMIT_LOW, ADDR, 2, 30)
+REG32(TR_RAM_LIMIT_HIGH, 0x01C)
+    FIELD(TR_RAM_LIMIT_HIGH, ADDR, 0, 32)
+
+REG32(TR_RAM_WP_LOW, 0x020)
+    FIELD(TR_RAM_WP_LOW, WRAP, 0, 1)
+    FIELD(TR_RAM_WP_LOW, ADDR, 2, 30)
+REG32(TR_RAM_WP_HIGH, 0x024)
+    FIELD(TR_RAM_WP_HIGH, ADDR, 0, 32)
+
+struct TraceRamSink {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    MemoryRegion reg_mem;
+    uint32_t reg_mem_size;
+
+    hwaddr baseaddr;
+    uint32_t regs[TRACE_R_MAX];
+    RegisterInfo regs_info[TRACE_R_MAX];
+
+    hwaddr smemaddr;
+    MemoryRegion smem;
+    uint32_t smemsize;
+    uint8_t *msgs;
+};
+
+#define TYPE_TRACE_RAM_SINK "trace-ram-sink"
+
+OBJECT_DECLARE_SIMPLE_TYPE(TraceRamSink, TRACE_RAM_SINK)
+
+#endif
-- 
2.51.1


