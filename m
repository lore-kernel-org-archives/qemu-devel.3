Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870FDCD13D2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImrI-0006cN-2W; Tue, 11 Nov 2025 06:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqI-0004eK-AY
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:22 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqD-0004Nd-Uw
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:21 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2964d616df7so52845245ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861635; x=1763466435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+h/wrFXrgdh3yfXTJ2th26fdXN3XUAkCGxZ+AoI8dZY=;
 b=U3dA+B8R/3Czm1XspImNm7cjB5qbMALlBA4NbVi0WnKQ5nM+daEsbbtJ5MZ+Fo91+u
 2VOmdanD8biGk/+GP6A73hDbQZlqyLV9c1GpAYCLR7tbUnkCK/4I3L5W7txawNYxeedV
 KjNDy20ySACAXYwA3/Vr2AU92cg3cNglagnvMit1O2YH8VD9UPLj/gf3rGeqquonsil4
 HBYHz/rFilA4cNhk7R2OFmGjs9koREt19KH1Y7rum55gSHriP5JDuvcPkSdaZj9mHklI
 UQGK4RPfwd0FSeMowr2Ja1J4pyqwGaQl+xxV4zUEza1qqEE2PY0c/jTmBBT4LZy7T+Qc
 i1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861635; x=1763466435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+h/wrFXrgdh3yfXTJ2th26fdXN3XUAkCGxZ+AoI8dZY=;
 b=JHJ7D/1CdVL+ETdnNbsu4KYCXKf9LTnMdWjcxg7oaQZMGYEJWyN4Docc1rSphfzgE5
 F1d9LoeoYBcth7weqeCEkf17n20gtPsSdTCYRZfridPD9D/oerfFbg8pGoqy+WaDsink
 3GYfiGJNBC59ssnv1rLln9kaSS3RlMh6KWcoRtivdguOot90b8WD4qsXvUnpWSg2teRa
 j+zXA4S6KsoGqvDh5lyRdpbSrlK1LY4QWS6hImJf4dSsBHdSHC8Lo/Kqm8ORlIhZk2Li
 QTphQrpEgDsU/xe9UzWvE06dwN1GNKHeD4nzjUe+O/aooa9sjy0sOagcXDNUCkmkT60p
 4f7Q==
X-Gm-Message-State: AOJu0Yx58v059Crj2BmM6N95wHiE/rhAAmngoQ8E99vVASXToVQhGuYX
 HCZ96hmNmfcPL7zy7QTiOIRDjcJVk+6Lwt7SPK+OdGAS1IIYe1FyrYqMPQsiWKS9q3Bwi2f3uNB
 uFH7e9QQ=
X-Gm-Gg: ASbGncu+osi6DAp9mEo+Xi120cl6eNYXUO0rxDfPZFRKkxh0lzz4Ed/SkaMx6nrwSnU
 qHRn2iunZ/Tg4IXcBaCcCPFqvni/EALfbGgjz24Gc23ulKsIEU8ZnBhe0YmNi68vts2SSaZf7/p
 6yFj2PWT84qFxrAwuXOFcItBXJUx30oVzlReG4oAz7VxOzBz9TXiwsPoGhQO30Uf18E80lVsOLX
 bTTlbOwWFXFvCya76eGuJ1wSmaZ7bxt0R9h08N1BfTE4BUOHdpO0fJcKtVFVRm5SoBgGiG9Xv+e
 CeoZdYpKycSSAozMbjqMdqXw9XtOuba8xUl0FHxkgBibb7wH4Qfs/CLVb4IuST7saiISmSLAj2b
 fYydRH3JKfcE5E1+v5RuVBeGTN0EaQjICz8CG/zlUu/hwKMX1A+diptCxvaIRqrHKbxjpXa5gFn
 UkEwJUfpvg3kX0zyg5Y0l9FNadWuL/3MAG/HBeK3Iz5P8OGLn7
X-Google-Smtp-Source: AGHT+IF2es4gnZHnRMgmkYOgOa0e8ZikM2omPy5yzdBaUaGHP3rrc54D2ZYlbwk70RkEIwt2mbrZxQ==
X-Received: by 2002:a17:902:f791:b0:295:30d4:23c2 with SMTP id
 d9443c01a7336-297e571247cmr151032365ad.50.1762861635220; 
 Tue, 11 Nov 2025 03:47:15 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:47:14 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 01/17] hw/riscv: Trace Encoder initial impl
Date: Tue, 11 Nov 2025 08:46:40 -0300
Message-ID: <20251111114656.2285048-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Trace Encoder is a hardware module that interacts with a CPU,
gathering execution information (a.k.a instruction delta trace), and
send it downstream to other storage components such as a RAM Sink (a RAM
storage). This trace info can then be read via software (e.g. perf) to
reproduce the behavior of a given binary that ran in the CPU.

This implementation is based on the Efficient Trace for RISC-V [1] and
RISC-V Trace Control Interface Specification [2]. It's not intended to
implement all spec features: the idea is to provide a base where we can
add extra features on demand.

We'll get back to the instruction delta trace and how we'll instrument
TCG to produce it later. For now we'll set the minimal components to get
the basic framework running.

This Trace Encoder impl has just the minimal bits specified in [2],
section "Minimal Implementation". RO and RSVP bits are taken verbatim
from [2] without considering what we're actually going to support. The
base impl is heavily inspired by the XLNZ-ZDMA device w.r.t the usage of
the RegisterInfo and register.h framework.

Discovery of the Trace Encoder will be made via fdt, a single entry per
CPU. We'll connect each Trace Encoder to its CPU in the 'virt' board
later.

[1] https://github.com/riscv-non-isa/riscv-trace-spec/releases/download/v2.0-20250616/riscv-trace-spec-asciidoc.pdf
[2] https://github.com/riscv-non-isa/tg-nexus-trace/releases/download/1.0_Ratified/RISC-V-Trace-Control-Interface.pdf

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/Kconfig         |   5 +
 hw/riscv/meson.build     |   1 +
 hw/riscv/trace-encoder.c | 216 +++++++++++++++++++++++++++++++++++++++
 hw/riscv/trace-encoder.h |  42 ++++++++
 hw/riscv/trace-events    |   4 +
 5 files changed, 268 insertions(+)
 create mode 100644 hw/riscv/trace-encoder.c
 create mode 100644 hw/riscv/trace-encoder.h

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fc9c35bd98..2de0892496 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -7,6 +7,10 @@ config RISCV_NUMA
 config IBEX
     bool
 
+config RISCV_TRACE
+    bool
+    select REGISTER
+
 # RISC-V machines in alphabetical order
 
 config MICROCHIP_PFSOC
@@ -68,6 +72,7 @@ config RISCV_VIRT
     select PLATFORM_BUS
     select ACPI
     select ACPI_PCI
+    select RISCV_TRACE
 
 config SHAKTI_C
     bool
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2a8d5b136c..b4a9988a62 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -14,5 +14,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
new file mode 100644
index 0000000000..21bf650a6a
--- /dev/null
+++ b/hw/riscv/trace-encoder.c
@@ -0,0 +1,216 @@
+/*
+ * Emulation of a RISC-V Trace Encoder
+ *
+ * Copyright (C) 2025 Ventana Micro Systems Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "trace-encoder.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "system/device_tree.h"
+#include "hw/register.h"
+#include "cpu.h"
+
+/*
+ * trTeControl register fields
+ */
+REG32(TR_TE_CONTROL, 0x0)
+    FIELD(TR_TE_CONTROL, ACTIVE, 0, 1)
+    FIELD(TR_TE_CONTROL, ENABLE, 1, 1)
+    FIELD(TR_TE_CONTROL, INST_TRACING, 2, 1)
+    FIELD(TR_TE_CONTROL, EMPTY, 3, 1)
+    FIELD(TR_TE_CONTROL, INST_MODE, 4, 3)
+    FIELD(TR_TE_CONTROL, INST_SYNC_MODE, 16, 2)
+    FIELD(TR_TE_CONTROL, FORMAT, 24, 3)
+    /* reserved bits */
+    FIELD(TR_TE_CONTROL, RSVP1, 7, 2)
+    FIELD(TR_TE_CONTROL, RSVP2, 10, 1)
+    FIELD(TR_TE_CONTROL, RSVP3, 14, 1)
+    FIELD(TR_TE_CONTROL, RSVP4, 18, 2)
+    FIELD(TR_TE_CONTROL, RSVP5, 27, 4)
+
+#define R_TR_TE_CONTROL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
+                                   R_TR_TE_CONTROL_RSVP1_MASK | \
+                                   R_TR_TE_CONTROL_RSVP2_MASK | \
+                                   R_TR_TE_CONTROL_RSVP3_MASK | \
+                                   R_TR_TE_CONTROL_RSVP4_MASK | \
+                                   R_TR_TE_CONTROL_RSVP5_MASK)
+
+/* trTeControlEmpty is the only RO field and reset value */
+#define R_TR_TE_CONTROL_RESET R_TR_TE_CONTROL_EMPTY_MASK
+#define R_TR_TE_CONTROL_RO_BITS R_TR_TE_CONTROL_EMPTY_MASK
+
+/*
+ * trTeImpl register fields
+ */
+REG32(TR_TE_IMPL, 0x4)
+    FIELD(TR_TE_IMPL, VER_MAJOR, 0, 4)
+    FIELD(TR_TE_IMPL, VER_MINOR, 4, 4)
+    FIELD(TR_TE_IMPL, COMP_TYPE, 8, 4)
+    FIELD(TR_TE_IMPL, PROTOCOL_MAJOR, 16, 4)
+    FIELD(TR_TE_IMPL, PROTOCOL_MINOR, 20, 4)
+    /* reserved bits */
+    FIELD(TR_TE_IMPL, RSVP1, 12, 4)
+    FIELD(TR_TE_IMPL, RSVP2, 24, 8)
+
+#define R_TR_TE_IMPL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
+                                R_TR_TE_IMPL_RSVP1_MASK | \
+                                R_TR_TE_IMPL_RSVP2_MASK)
+
+#define R_TR_TE_IMPL_RO_BITS (R_TR_TE_IMPL_VER_MAJOR_MASK | \
+                              R_TR_TE_IMPL_VER_MINOR_MASK | \
+                              R_TR_TE_IMPL_COMP_TYPE_MASK | \
+                              R_TR_TE_IMPL_PROTOCOL_MAJOR_MASK | \
+                              R_TR_TE_IMPL_PROTOCOL_MINOR_MASK)
+
+#define R_TR_TE_IMPL_RESET (BIT(0) | BIT(8))
+
+static RegisterAccessInfo trencoder_regs_info[] = {
+    {   .name = "TR_TE_CONTROL", .addr = A_TR_TE_CONTROL,
+        .rsvd = R_TR_TE_CONTROL_RSVP_BITS,
+        .reset = R_TR_TE_CONTROL_RESET,
+        .ro = R_TR_TE_CONTROL_RO_BITS,
+    },
+    {   .name = "TR_TE_IMPL", .addr = A_TR_TE_IMPL,
+        .rsvd = R_TR_TE_IMPL_RSVP_BITS,
+        .reset = R_TR_TE_IMPL_RESET,
+        .ro = R_TR_TE_IMPL_RO_BITS,
+    },
+};
+
+static uint64_t trencoder_read(void *opaque, hwaddr addr, unsigned size)
+{
+    TraceEncoder *te = TRACE_ENCODER(opaque);
+    RegisterInfo *r = &te->regs_info[addr / 4];
+
+    if (!r->data) {
+        trace_trencoder_read_error(addr);
+        return 0;
+    }
+
+    return register_read(r, ~0, NULL, false);
+}
+
+static void trencoder_write(void *opaque, hwaddr addr,
+                            uint64_t value, unsigned size)
+{
+    TraceEncoder *te = TRACE_ENCODER(opaque);
+    RegisterInfo *r = &te->regs_info[addr / 4];
+
+    if (!r->data) {
+        trace_trencoder_write_error(addr, value);
+        return;
+    }
+
+    register_write(r, value, ~0, NULL, false);
+}
+
+static const MemoryRegionOps trencoder_ops = {
+    .read = trencoder_read,
+    .write = trencoder_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void trencoder_reset(DeviceState *dev)
+{
+    TraceEncoder *te = TRACE_ENCODER(dev);
+
+    for (int i = 0; i < ARRAY_SIZE(te->regs_info); i++) {
+        register_reset(&te->regs_info[i]);
+    }
+}
+
+static void trencoder_realize(DeviceState *dev, Error **errp)
+{
+    TraceEncoder *te = TRACE_ENCODER(dev);
+
+    memory_region_init_io(&te->reg_mem, OBJECT(dev),
+                          &trencoder_ops, te,
+                          TYPE_TRACE_ENCODER,
+                          te->reg_mem_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &te->reg_mem);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, te->baseaddr);
+
+    /* RegisterInfo init taken from hw/dma/xlnx-zdma.c */
+    for (int i = 0; i < ARRAY_SIZE(trencoder_regs_info); i++) {
+        uint32_t reg_idx = trencoder_regs_info[i].addr / 4;
+        RegisterInfo *r = &te->regs_info[reg_idx];
+
+        *r = (RegisterInfo) {
+            .data = (uint8_t *)&te->regs[reg_idx],
+            .data_size = sizeof(uint32_t),
+            .access = &trencoder_regs_info[i],
+            .opaque = te,
+        };
+    }
+}
+
+static const Property trencoder_props[] = {
+    /*
+     * We need a link to the associated CPU to
+     * enable/disable tracing.
+     */
+    DEFINE_PROP_LINK("cpu", TraceEncoder, cpu, TYPE_RISCV_CPU, RISCVCPU *),
+    DEFINE_PROP_UINT64("baseaddr", TraceEncoder, baseaddr, 0),
+    DEFINE_PROP_UINT64("dest-baseaddr", TraceEncoder, dest_baseaddr, 0),
+    DEFINE_PROP_UINT64("ramsink-ramstart", TraceEncoder,
+                       ramsink_ramstart, 0),
+    DEFINE_PROP_UINT64("ramsink-ramlimit", TraceEncoder,
+                       ramsink_ramlimit, 0),
+    DEFINE_PROP_UINT32("reg-mem-size", TraceEncoder,
+                       reg_mem_size, TRACE_R_MAX * 4),
+    DEFINE_PROP_INT32("cpu-id", TraceEncoder, cpu_id, 0),
+};
+
+static const VMStateDescription vmstate_trencoder = {
+    .name = TYPE_TRACE_ENCODER,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, TraceEncoder, TRACE_R_MAX),
+        VMSTATE_UINT64(baseaddr, TraceEncoder),
+        VMSTATE_UINT64(dest_baseaddr, TraceEncoder),
+        VMSTATE_UINT64(ramsink_ramstart, TraceEncoder),
+        VMSTATE_UINT64(ramsink_ramlimit, TraceEncoder),
+        VMSTATE_INT32(cpu_id, TraceEncoder),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static void trencoder_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, trencoder_reset);
+    device_class_set_props(dc, trencoder_props);
+    dc->realize = trencoder_realize;
+    dc->vmsd = &vmstate_trencoder;
+}
+
+static const TypeInfo trencoder_info = {
+    .name          = TYPE_TRACE_ENCODER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TraceEncoder),
+    .class_init    = trencoder_class_init,
+};
+
+static void trencoder_register_types(void)
+{
+    type_register_static(&trencoder_info);
+}
+
+type_init(trencoder_register_types)
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
new file mode 100644
index 0000000000..71002f58a4
--- /dev/null
+++ b/hw/riscv/trace-encoder.h
@@ -0,0 +1,42 @@
+/*
+ * Emulation of a RISC-V Trace Encoder
+ *
+ * Copyright (C) 2025 Ventana Micro Systems Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV_TRACE_ENCODER_H
+#define RISCV_TRACE_ENCODER_H
+
+#include "hw/sysbus.h"
+#include "hw/register.h"
+#include "system/dma.h"
+#include "qom/object.h"
+#include "cpu.h"
+
+#define TRACE_R_MAX (0xFFF / 4)
+
+struct TraceEncoder {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    RISCVCPU *cpu;
+    int cpu_id;
+
+    MemoryRegion reg_mem;
+    uint32_t reg_mem_size;
+
+    hwaddr baseaddr;
+    hwaddr dest_baseaddr;
+    hwaddr ramsink_ramstart;
+    hwaddr ramsink_ramlimit;
+    uint32_t regs[TRACE_R_MAX];
+    RegisterInfo regs_info[TRACE_R_MAX];
+};
+
+#define TYPE_TRACE_ENCODER "trace-encoder"
+
+OBJECT_DECLARE_SIMPLE_TYPE(TraceEncoder, TRACE_ENCODER)
+
+#endif
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index b50b14a654..0cbf6ffcb6 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -24,3 +24,7 @@ riscv_iommu_hpm_incr_ctr(uint64_t cntr_val) "cntr_val 0x%"PRIx64
 riscv_iommu_hpm_iocntinh_cy(bool prev_cy_inh) "prev_cy_inh %d"
 riscv_iommu_hpm_cycle_write(uint32_t ovf, uint64_t val) "ovf 0x%x val 0x%"PRIx64
 riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx 0x%x ovf 0x%x val 0x%"PRIx64
+
+# trace-encoder.c
+trencoder_read_error(uint64_t addr) "addr 0x%" PRIx64
+trencoder_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
-- 
2.51.1


