Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01FBC5DF8A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2CM-0004xV-H3; Thu, 20 Aug 2026 08:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CJ-0004ux-Fe
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:43 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CF-0001ZU-Vs
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:43 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a082b3671fso3355852a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787230118; x=1787834918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MqaVcqtkE7t2SvbA8+a94FGHj/ejmg1puu7JuAxVL1I=;
 b=ADhONDo+d76ajcbnz5ev4L0L0FwfPCQKK1Ypp3Ggiy8avNsn8KNejbM7OlopTtvSqT
 E+iAhZW5iix+CR4B2rmjuaw11szzU90l04OeN8MwJWMFsml/wb+9u5lqEO2FXpeW/bns
 EHCnizrxVX023+hg8/7IqZ++lLCLD6oNReltR3+FPfVe7CCn96NvkamMI1lZn46qYWSc
 VbLvHg2bTJqUlb8kGVLJMSxiQGBdGN9XJherVB9LgyvIpD+qCFkPheKsi3sjKEYMB9Sz
 Y378IcNhmlU2f1/xbAuZ73khPh8fHT2vxbgoMvCTQvoGuRTBxi9DmD2J4DPaee3xehm/
 eWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787230118; x=1787834918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MqaVcqtkE7t2SvbA8+a94FGHj/ejmg1puu7JuAxVL1I=;
 b=YDhgl1KgBciuyj327REfihiuVksF+7xgdDlmikq6fxCW4gtRUaLR4TeBrbR6Il2jdD
 lbBWtqTatu0Vyv0n3Q/aySfCbN6ocEhmShO9Gvo9Suin+0eyugQBCv9ZYD89lYPOc3jP
 DDrmNLIbtx5sVM2ecxDrXkvIaUkmnPsG1XKrtU4PFfv3pcrnkhIxI5bTj2NXQQfBjAdE
 X8MH3RcsR6pTwJIkX8qe7DRlGyJ+RKKkWrAPK+GccKTpwxqmXw1LSRjbtfgsFMDr4PvJ
 VKJ8+DpfL44CyHW7gJ8jJ2OQWUVeYD7iyODVfRqSXU0GibB2yFnoKCF12fyyzukRTuoU
 t7DQ==
X-Gm-Message-State: AFuF++kQzmjxfDNPO3sLIMj4m8EKh0PbxYOFNJwe7PkDAy92+MLaBYaG
 yZg1wDlbkk/ltW7v1iXj+KYLl2U7tX4/yfQRSy21FOw49l0FK7w3qwdJRcMFu5H5
X-Gm-Gg: AR+sD13DrP522nRRmeJP8fGNhAoVGtMKmYBwo90/KNPmtuBBC59T/MXlu/xvifp2Zj+
 jsDIta8jvOH2P3LDJTNuGWgFQxKKpnSVs8xcmyhA6niCWyAg5I0TYiGSuAUU577LjZlkobsP1It
 5Lgye5TeLDwrDZfTh3Ps1gJ82cSUEkGjAp3T6admi6b0absha82H5xFeb4vvemvSPvRCQysmwLQ
 LIIzaoQPBXEsLFLWT4+poggXcO6N69J7yrpfS6lYv9LrV5nrZg71c1H3dl25vtoLvMSfRedrJvC
 99CoHMJmTPujEM4X8fdMDzC7LBsNAaHA+WjW8MYJXtoZpe+mIvcbuR492lYk9zIM1SzneWUhPIo
 jBPAxTayByrJU9Aplv5cxB+zEMTNagx+4ZqjhTg2vtPPee/4YSKQU3zngp+2npkWHEIrTNRSFzy
 dVAC/UpRsUg8bZcAcnpOZZXhs3z7h6KQVosVGGIsy5+0EC147yuwW5ofjuYIF/wdq9c93rZs6bw
 0oYEXLaZic=
X-Received: by 2002:a05:6402:4555:b0:698:af31:5a9b with SMTP id
 4fb4d7f45d1cf-6a4032f9d1bmr7904220a12.9.1787230118217; 
 Thu, 20 Aug 2026 05:48:38 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1563c5sm2270449a12.14.2026.08.20.05.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:48:37 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Wadim Mueller <wafgo01@gmail.com>
Subject: [RFC PATCH v2 07/14] hw/misc: add TI RAT (region address translation)
 model
Date: Thu, 20 Aug 2026 14:48:07 +0200
Message-ID: <20260820124824.618671-8-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820124824.618671-1-wafgo01@gmail.com>
References: <20260820124824.618671-1-wafgo01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=wafgo01@gmail.com; helo=mail-ed1-x534.google.com
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

The R5F and M4F subsystems of the K3 devices reach the 64-bit SoC address
space through a RAT, which maps windows of the core's 32-bit view onto
system addresses. Model it as a set of translation regions layered as
memory region aliases into the core's address space.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 hw/misc/Kconfig          |   3 +
 hw/misc/meson.build      |   1 +
 hw/misc/ti-rat.c         | 290 +++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events     |   5 +
 include/hw/misc/ti-rat.h |  51 +++++++
 5 files changed, 350 insertions(+)
 create mode 100644 hw/misc/ti-rat.c
 create mode 100644 include/hw/misc/ti-rat.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 3e499a902d..c176d6d6c7 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -143,6 +143,9 @@ config MPS2_SCC
     bool
     select LED
 
+config TI_RAT
+    bool
+
 config TI_K3_CTRLMMR
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e973d7e8a4..952b7b7c2f 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -123,6 +123,7 @@ system_ss.add(when: 'CONFIG_STM32L4X5_RCC', if_true: files('stm32l4x5_rcc.c'))
 system_ss.add(when: 'CONFIG_MPS2_FPGAIO', if_true: files('mps2-fpgaio.c'))
 system_ss.add(when: 'CONFIG_MPS2_SCC', if_true: files('mps2-scc.c'))
 
+system_ss.add(when: 'CONFIG_TI_RAT', if_true: files('ti-rat.c'))
 system_ss.add(when: 'CONFIG_TI_K3_CTRLMMR', if_true: files('ti-k3-ctrlmmr.c'))
 system_ss.add(when: 'CONFIG_TI_K3_GTC', if_true: files('ti-k3-gtc.c'))
 system_ss.add(when: 'CONFIG_TI_K3_DDRSS', if_true: files('ti-k3-ddrss.c'))
diff --git a/hw/misc/ti-rat.c b/hw/misc/ti-rat.c
new file mode 100644
index 0000000000..719fdffa0a
--- /dev/null
+++ b/hw/misc/ti-rat.c
@@ -0,0 +1,290 @@
+/*
+ * TI RAT (Region Address Translation) SysBus device
+ *
+ * Copyright (c) 2025 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * A RAT sits in front of a processor and translates accesses, which fall
+ * into its address window, into 64-bit system addresses. Each entry maps
+ * one aligned power-of-two region of the window onto a translated base;
+ * enabled entries are modelled as MemoryRegion aliases into the target
+ * address space.
+ *
+ * Where the window lies is not fixed. The "window-base" and "window-size"
+ * properties place it, and the "window-root" resp. "target-root" links
+ * select the address space the window is seen in and the one it
+ * translates into. TI_RAT_NUM_ENTRIES gives the number of entries.
+ */
+
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
+#include "qemu/bitops.h"
+#include "hw/core/qdev.h"
+#include "hw/core/sysbus.h"
+#include "system/address-spaces.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "qemu/units.h"
+#include "hw/misc/ti-rat.h"
+#include "hw/core/qdev-properties.h"
+#include "trace.h"
+
+/* Property defaults: the AM64x MCU R5F RAT window. */
+#define TI_RAT_WINDOW_BASE 0x60000000ULL
+#define TI_RAT_WINDOW_SIZE (2ULL * GiB)
+
+#define RAT_PID 0x000
+#define RAT_CONFIG 0x004
+
+#define RAT_ENT_BASE 0x20
+#define RAT_ENT_STRIDE 0x10
+
+#define RAT_REG_CTRL 0x00
+#define RAT_REG_BASE 0x04
+#define RAT_REG_TRANS_L 0x08
+#define RAT_REG_TRANS_H 0x0C
+
+#define RAT_REGS_SIZE 0x1000
+
+static void ti_rat_apply_entry(TIRATState *s, TIRATEntry *e)
+{
+    bool en = (e->ctrl_reg & BIT(31)) != 0;
+
+    uint64_t shift = e->ctrl_reg & 0x3f;
+    uint64_t size = (shift >= 63) ? 0 : (1ULL << shift);
+
+    hwaddr source_addr = (hwaddr)e->base_reg;
+    hwaddr dest_addr = (hwaddr)e->transl_reg | ((hwaddr)e->transh_reg << 32);
+
+    /* Validate before aliases are changed. */
+    if (!en) {
+        trace_rat_disable_region(e->idx);
+        if (e->inserted) {
+            memory_region_transaction_begin();
+            memory_region_del_subregion(&s->window_container, &e->alias);
+            memory_region_set_enabled(&e->alias, false);
+            memory_region_transaction_commit();
+            e->inserted = false;
+        }
+        return;
+    }
+
+    if (size < 0x1000) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "RAT %u: size too small: 0x%" PRIx64 "\n", e->idx, size);
+        return;
+    }
+
+    if (source_addr < s->window_base ||
+        (source_addr - s->window_base) + size > s->window_size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "RAT %u: source outside window: 0x%" HWADDR_PRIx "\n",
+                      e->idx, source_addr);
+        return;
+    }
+
+    hwaddr woff = source_addr - s->window_base;
+    e->size = size;
+    trace_rat_enable_region(e->idx, e->size, source_addr, dest_addr);
+
+    memory_region_transaction_begin();
+
+    /* Create or move the alias at programmed source offset. */
+    if (!e->inserted) {
+        memory_region_add_subregion(&s->window_container, woff, &e->alias);
+        e->inserted = true;
+    } else {
+        /* Move existing alias, when the source offset changes. */
+        memory_region_del_subregion(&s->window_container, &e->alias);
+        memory_region_add_subregion(&s->window_container, woff, &e->alias);
+    }
+    /* Point the alias to the programmed translated address. */
+    memory_region_set_alias_offset(&e->alias, dest_addr);
+    memory_region_set_size(&e->alias, size);
+    memory_region_set_enabled(&e->alias, true);
+    memory_region_transaction_commit();
+}
+
+static uint64_t ti_rat_read(void *opaque, hwaddr off, unsigned size)
+{
+    TIRATState *s = opaque;
+    int entry;
+    int rel_offset;
+
+    if (off == RAT_PID) {
+        return 0x66804100;
+    }
+
+    if (off == RAT_CONFIG) {
+        return 0x00300110;
+    }
+
+    if (off <= 4 || off > 0x800) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "TI-RAT: invalid read offset 0x%" PRIx64 "\n", off);
+        return 0;
+    }
+
+    entry = (off - RAT_ENT_BASE) / RAT_ENT_STRIDE;
+    rel_offset = (off - RAT_ENT_BASE) % RAT_ENT_STRIDE;
+    assert(entry < TI_RAT_NUM_ENTRIES);
+    trace_rat_read_entry(entry, rel_offset, off);
+
+    switch (rel_offset) {
+    case RAT_REG_CTRL:
+        return s->ent[entry].ctrl_reg;
+    case RAT_REG_BASE:
+        return s->ent[entry].base_reg;
+    case RAT_REG_TRANS_L:
+        return s->ent[entry].transl_reg;
+    case RAT_REG_TRANS_H:
+        return s->ent[entry].transh_reg;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "TI-RAT: invalid entry read offset 0x%x\n", rel_offset);
+        break;
+    }
+
+    return 0;
+}
+
+static void ti_rat_write(void *opaque, hwaddr off, uint64_t val, unsigned size)
+{
+    TIRATState *s = opaque;
+    int entry;
+    int rel_offset;
+
+    if (off <= 4 || off > 0x800) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "TI-RAT: invalid write offset 0x%" PRIx64 "\n", off);
+        return;
+    }
+
+    entry = (off - RAT_ENT_BASE) / RAT_ENT_STRIDE;
+    rel_offset = (off - RAT_ENT_BASE) % RAT_ENT_STRIDE;
+
+    assert(entry < TI_RAT_NUM_ENTRIES);
+    TIRATEntry *e = &s->ent[entry];
+
+    switch (rel_offset) {
+    case RAT_REG_CTRL:
+        e->ctrl_reg = val;
+        break;
+    case RAT_REG_BASE:
+        e->base_reg = val;
+        break;
+    case RAT_REG_TRANS_L:
+        e->transl_reg = val;
+        break;
+    case RAT_REG_TRANS_H:
+        e->transh_reg = val;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "TI-RAT: invalid entry write offset 0x%x\n", rel_offset);
+        break;
+    }
+
+    ti_rat_apply_entry(s, e);
+}
+
+static const MemoryRegionOps ti_rat_ops = {
+    .read = ti_rat_read,
+    .write = ti_rat_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void ti_rat_reset(DeviceState *dev)
+{
+    TIRATState *s = TI_RAT(dev);
+
+    s->ctrl = 0;
+
+    memory_region_transaction_begin();
+    for (int i = 0; i < TI_RAT_NUM_ENTRIES; i++) {
+        TIRATEntry *e = &s->ent[i];
+        if (e->inserted) {
+            memory_region_del_subregion(&s->window_container, &e->alias);
+            e->inserted = false;
+        }
+        e->idx = i;
+        e->ctrl_reg = 0;
+        e->base_reg = 0;
+        e->trans_base = 0;
+        e->size = 0x0;
+        memory_region_set_enabled(&e->alias, false);
+    }
+    memory_region_transaction_commit();
+}
+
+static void ti_rat_realize(DeviceState *dev, Error **errp)
+{
+    TIRATState *s = TI_RAT(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    if (!s->window_root) {
+        error_setg(errp, "ti-rat: property 'window-root' must be set");
+        return;
+    }
+    if (!s->target_root) {
+        error_setg(errp, "ti-rat: property 'target-root' must be set");
+        return;
+    }
+    /* Register block is separate from the translated window. */
+    memory_region_init_io(&s->regs_mmio, OBJECT(s), &ti_rat_ops, s,
+                          "ti-rat-regs", RAT_REGS_SIZE);
+    sysbus_init_mmio(sbd, &s->regs_mmio);
+
+    memory_region_init(&s->window_container, OBJECT(s), "ti-rat-window",
+                       s->window_size);
+    memory_region_add_subregion(s->window_root, s->window_base,
+                                &s->window_container);
+
+    for (int i = 0; i < TI_RAT_NUM_ENTRIES; i++) {
+        g_autofree char *name = g_strdup_printf("ti-rat-alias[%d]", i);
+        memory_region_init_alias(&s->ent[i].alias, OBJECT(s), name,
+                                 s->target_root, 0, 0x1000);
+        memory_region_set_enabled(&s->ent[i].alias, false);
+    }
+
+    ti_rat_reset(dev);
+}
+
+static const Property ti_rat_props[] = {
+    DEFINE_PROP_UINT64("window-base", TIRATState, window_base,
+                       TI_RAT_WINDOW_BASE),
+    DEFINE_PROP_UINT64("window-size", TIRATState, window_size,
+                       TI_RAT_WINDOW_SIZE),
+    DEFINE_PROP_LINK("target-root", TIRATState, target_root, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+    DEFINE_PROP_LINK("window-root", TIRATState, window_root, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+};
+
+static void ti_rat_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = ti_rat_realize;
+    device_class_set_legacy_reset(dc, ti_rat_reset);
+    device_class_set_props(dc, ti_rat_props);
+}
+
+static const TypeInfo ti_rat_info = {
+    .name = TYPE_TI_RAT,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TIRATState),
+    .class_init = ti_rat_class_init,
+};
+
+static void ti_rat_register_types(void)
+{
+    type_register_static(&ti_rat_info);
+}
+
+type_init(ti_rat_register_types);
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index b32ce80ea9..fae1f90ee2 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -443,6 +443,11 @@ iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actu
 iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
 iommu_testdev_dma_armed(bool armed) "armed=%d"
 
+# ti-rat.c
+rat_enable_region(int idx, uint64_t size, uint64_t source, uint64_t dest) "Enabling RAT Region %u: size 0x%"PRIx64" map 0x%"PRIx64" -> 0x%"PRIx64
+rat_disable_region(int idx) "Disabling RAT Region %u"
+rat_read_entry(int entry, int rel_offset, uint64_t offset) "Reading Entry %i at offset %i: offset: 0x%"PRIx64
+
 # ti-k3-trng.c
 ti_k3_trng_read(uint64_t addr, uint32_t val) "offset 0x%" PRIx64 " -> 0x%08x"
 ti_k3_trng_write(uint64_t addr, uint64_t val) "offset 0x%" PRIx64 " <- 0x%" PRIx64
diff --git a/include/hw/misc/ti-rat.h b/include/hw/misc/ti-rat.h
new file mode 100644
index 0000000000..9f40a4a256
--- /dev/null
+++ b/include/hw/misc/ti-rat.h
@@ -0,0 +1,51 @@
+/*
+ * TI RAT (Region Address Translation)
+ *
+ * Copyright (c) 2025 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TI_RAT_H
+#define TI_RAT_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_TI_RAT "ti-rat"
+OBJECT_DECLARE_SIMPLE_TYPE(TIRATState, TI_RAT)
+
+#define TI_RAT_NUM_ENTRIES   16
+
+typedef struct TIRATEntry {
+    bool inserted;
+
+    int idx;
+    uint32_t ctrl_reg;
+    uint32_t base_reg;
+    uint32_t transl_reg;
+    uint32_t transh_reg;
+
+    uint64_t trans_base;   /* translated base */
+    uint64_t size;    /* bytes */
+
+    MemoryRegion alias;
+} TIRATEntry;
+
+typedef struct TIRATState {
+    SysBusDevice parent_obj;
+
+    uint32_t ctrl;
+    MemoryRegion *window_root;
+    MemoryRegion *target_root;
+    MemoryRegion regs_mmio;
+    MemoryRegion window_container;
+
+    uint64_t window_base;
+    uint64_t window_size;
+
+    TIRATEntry ent[TI_RAT_NUM_ENTRIES];
+} TIRATState;
+
+#endif
-- 
2.43.0


