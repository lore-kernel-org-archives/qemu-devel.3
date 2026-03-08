Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6539F55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8Qo-0000iD-SO; Sun, 08 Mar 2026 03:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Ql-0000VD-PY
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:03 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Qh-000286-TG
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:03 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so12815827eec.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954398; x=1773559198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhC8VZyeuJcb+P+nRDt5ADfRP2/AkWKt1VLXaWj5i1I=;
 b=G2LTtPMbu8QH0ncqICUTgyiMDQ1Erb/bMQVx4JCUiaFp1mH9WUjDleOaau7L6CIxDw
 ogurBTZpoIBIztMi4jKMZ5UqzVNkflEwm909cStS5t8SWGTK1/S0JUzLftgevZ6zfD0s
 Ipsc/PCAfZQcJCHnNeaq1u7OYpzKP7T5nob1N7pNdui1LeWg9tAt27Wk1ImW7GrSe23+
 MMsqd1yTGy7bJlnQzUM9LlbhasRigD96Gw8Gi9GjIck4hzA0xGpBqoEDp7q7bGaoDMZG
 3ffZJVH3kbNISlA0UTJfnlQ90s0ftZcIc6x+zbBJaNUDMrBOWqh6CI/YXCVR4bDkDkGl
 P6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954398; x=1773559198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bhC8VZyeuJcb+P+nRDt5ADfRP2/AkWKt1VLXaWj5i1I=;
 b=TKDAMy8uSU5Xnrq7YQM73To7SQHMSKjfGAC6Fd0fxhSJt+cj9NWSH099WZmC6GYITh
 BzlUzMdhhlGZEGLsvTUInAnKbnTUVglyYYhFqT7rq9boRCIv8BvltNXUtS7i3bNktmje
 m/+06fwcT40NTQ98xVTc4oFOq32G/HETCNXqN8A494LhIXEwn26SeUIeDzEVBR2XhoK6
 Z3+GIzL2EMRqRYPXn2znPb4HRpzGnxUuJzD7G1YxSx/6C+q1HfUnjggWPH1F3qjeqJqI
 1TstVZU6OYwJXLOWwcb9rTugTdRfGpRyRfdQ0GoXgQJHNxhsdpXkCX89XF3WE8BmkRMO
 6sqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0fr6Xw3JuKve6tjJwQtwrvxURJMYvWEJsjG8uLNj+xlmPCGJTkPrbVtuddVsXYhzXLvNPWKfS+bo6@nongnu.org
X-Gm-Message-State: AOJu0YzaX3YcVz/mXEqQGD1lUPUBxGlFqqbeZ7Z4vc+Jhfo8FGAjiqt5
 hAL1cgWa5gqypF2P5BO5z6UaoQXScGkzQs1dTuvMu8YE2BjTjlxNH7Pc+nUaUMpJ
X-Gm-Gg: ATEYQzzUDMekJuJsbmHg6//69sbW8H9KWg6q6DO6bSiUsEqroUHA1Q/vnRRrc0KPlqi
 OST7G/UDVM4edkLDBOnGRkDjf6gHvzgaRbnLnqHe3HWu5yjPruZpjr9G3ysbMLIoAWPbcBqTFF/
 ROESNLSiaWBripmkzHAcmfoVjpEGx7jaKhmu06Zwboadx/YQCQ7Y+TshsAkAB7yJgbW3+leCdYI
 bDknuRPczuAbpNzJkv9Jf1plLyzFDbl1o+F3CdXfHMD4lpPnHXgHgWO1F3xniLdRfj+ZEfMmdUK
 GYAgpRBehu8CpToolztPcET9aMmcE9+cmhDtsLqVD1atFp2Hck8vs09oiAa1q7WDMKgTAfE8nhp
 mLogLEB2t8lU9kHmLHDoiFv+itclwz8BI34qQ3gMTrpfiIlecYF/V1ed5EJSAmp6HqK1H8ZH53n
 C1U3WLSjfjYH4Fx8SodznHi6BhN43lGB6za1vmuXkGdB1dU+o9btr+4+ICFe50lQ5VGFCfDYt8r
 fVLEEFUJCeWgzgapEM2aac1Coe0trx4iVJIGg==
X-Received: by 2002:a05:7300:3b24:b0:2be:fe8:8b0c with SMTP id
 5a478bee46e88-2be4e03eda7mr2717925eec.25.1772954397842; 
 Sat, 07 Mar 2026 23:19:57 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:19:56 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 15/28] hw/riscv: add an initial Debug Module device model
Date: Sun,  8 Mar 2026 15:17:18 +0800
Message-ID: <f18c91f226c78c1f866c83d5f167460a529c246a.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
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

Add the initial QOM model for the RISC-V Debug Module and wire it
into Kconfig and Meson.

This introduces the public DM header, the riscv-dm SysBus device
type, the basic dmcontrol, dmstatus, hartinfo, and abstractcs
register state, and the backing storage for the ROM work area.
It also creates separate MMIO regions for the DMI window and the
ROM entry alias used by later patches.

At this stage the device provides reset values, simple ROM
storage, the create helper, and stub CPU callbacks. Follow-on
patches will add hart state tracking, run-control, abstract
commands, and system bus access.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 hw/riscv/Kconfig      |   5 +
 hw/riscv/dm.c         | 252 ++++++++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build  |   2 +
 include/hw/riscv/dm.h | 139 +++++++++++++++++++++++
 4 files changed, 398 insertions(+)
 create mode 100644 hw/riscv/dm.c
 create mode 100644 include/hw/riscv/dm.h

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 0222c93f87..72bcaa0028 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -1,3 +1,7 @@
+config RISCV_DM
+    bool
+    select REGISTER
+
 config RISCV_IOMMU
     bool
 
@@ -68,6 +72,7 @@ config RISCV_VIRT
     select PLATFORM_BUS
     select ACPI
     select ACPI_PCI
+    select RISCV_DM
 
 config SHAKTI_C
     bool
diff --git a/hw/riscv/dm.c b/hw/riscv/dm.c
new file mode 100644
index 0000000000..9ac5f2cfac
--- /dev/null
+++ b/hw/riscv/dm.c
@@ -0,0 +1,252 @@
+/*
+ * RISC-V Debug Module v1.0
+ *
+ * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
+ *
+ * Based on the RISC-V Debug Specification v1.0 (ratified 2025-02-21)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/riscv/dm.h"
+#include "migration/vmstate.h"
+
+REG32(DMCONTROL, 0x40)
+    FIELD(DMCONTROL, DMACTIVE, 0, 1)
+
+REG32(DMSTATUS, 0x44)
+    FIELD(DMSTATUS, VERSION, 0, 4)
+    FIELD(DMSTATUS, AUTHENTICATED, 7, 1)
+
+REG32(HARTINFO, 0x48)
+
+REG32(ABSTRACTCS, 0x58)
+    FIELD(ABSTRACTCS, DATACOUNT, 0, 4)
+    FIELD(ABSTRACTCS, PROGBUFSIZE, 24, 5)
+
+static RegisterAccessInfo riscv_dm_regs_info[] = {
+    { .name = "DMCONTROL", .addr = A_DMCONTROL, },
+    { .name = "DMSTATUS", .addr = A_DMSTATUS, .ro = 0xffffffff, },
+    { .name = "HARTINFO", .addr = A_HARTINFO, .ro = 0xffffffff, },
+    { .name = "ABSTRACTCS", .addr = A_ABSTRACTCS, .ro = 0xffffffff, },
+};
+
+static uint64_t riscv_dm_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return register_read_memory(opaque, addr, size);
+}
+
+static void riscv_dm_write(void *opaque, hwaddr addr,
+                           uint64_t value, unsigned size)
+{
+    register_write_memory(opaque, addr, value, size);
+}
+
+static const MemoryRegionOps riscv_dm_ops = {
+    .read = riscv_dm_read,
+    .write = riscv_dm_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+/*
+ * ROM device read callback.
+ *
+ * In ROMD mode (the default) reads go directly to the RAM backing store and
+ * this callback is never invoked.  It is kept as a fallback for correctness
+ * should ROMD mode ever be disabled at runtime.
+ */
+static uint64_t dm_rom_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RISCVDMState *s = opaque;
+
+    return ldn_le_p(s->rom_ptr + offset, size);
+}
+
+static void dm_rom_write(void *opaque, hwaddr offset,
+                         uint64_t value, unsigned size)
+{
+    RISCVDMState *s = opaque;
+
+    stn_le_p(s->rom_ptr + offset, size, value);
+}
+
+static const MemoryRegionOps dm_rom_ops = {
+    .read = dm_rom_read,
+    .write = dm_rom_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static bool dm_rom_realize(RISCVDMState *s, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(s);
+
+    if (!memory_region_init_rom_device(&s->rom_mr, OBJECT(s), &dm_rom_ops, s,
+                                       "riscv-dm.rom", RISCV_DM_SIZE,
+                                       errp)) {
+        return false;
+    }
+
+    s->rom_ptr = memory_region_get_ram_ptr(&s->rom_mr);
+
+    memory_region_init_alias(&s->rom_work_alias_mr, OBJECT(s),
+                             "riscv-dm.rom-work", &s->rom_mr,
+                             RISCV_DM_ROM_WORK_BASE, RISCV_DM_ROM_WORK_SIZE);
+    memory_region_init_alias(&s->rom_entry_alias_mr, OBJECT(s),
+                             "riscv-dm.rom-entry", &s->rom_mr,
+                             RISCV_DM_ROM_ENTRY, RISCV_DM_ROM_ENTRY_SIZE);
+
+    sysbus_init_mmio(sbd, &s->rom_work_alias_mr);
+    sysbus_init_mmio(sbd, &s->rom_entry_alias_mr);
+    return true;
+}
+
+void riscv_dm_hart_halted(RISCVDMState *s, uint32_t hartsel)
+{
+    (void)s;
+    (void)hartsel;
+}
+
+void riscv_dm_hart_resumed(RISCVDMState *s, uint32_t hartsel)
+{
+    (void)s;
+    (void)hartsel;
+}
+
+void riscv_dm_abstracts_done(RISCVDMState *s, uint32_t hartsel)
+{
+    (void)s;
+    (void)hartsel;
+}
+
+void riscv_dm_abstracts_exception(RISCVDMState *s, uint32_t hartsel)
+{
+    (void)s;
+    (void)hartsel;
+}
+
+static void dm_debug_reset(RISCVDMState *s)
+{
+    memset(s->regs, 0, sizeof(s->regs));
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, VERSION, 3);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, AUTHENTICATED, 1);
+    ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, DATACOUNT, s->num_abstract_data);
+    ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, PROGBUFSIZE, s->progbuf_size);
+
+    if (s->rom_ptr) {
+        memset(s->rom_ptr, 0, RISCV_DM_SIZE);
+    }
+}
+
+static void riscv_dm_init(Object *obj)
+{
+    RISCVDMState *s = RISCV_DM(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    s->reg_array = register_init_block32(DEVICE(obj), riscv_dm_regs_info,
+                                         ARRAY_SIZE(riscv_dm_regs_info),
+                                         s->regs_info, s->regs, &riscv_dm_ops,
+                                         false, RISCV_DM_REG_SIZE);
+
+    sysbus_init_mmio(sbd, &s->reg_array->mem);
+}
+
+static void riscv_dm_realize(DeviceState *dev, Error **errp)
+{
+    RISCVDMState *s = RISCV_DM(dev);
+
+    if (s->num_harts > RISCV_DM_MAX_HARTS) {
+        error_setg(errp, "riscv-dm: num-harts %u exceeds maximum %d",
+                   s->num_harts, RISCV_DM_MAX_HARTS);
+        return;
+    }
+
+    if (!dm_rom_realize(s, errp)) {
+        return;
+    }
+
+    dm_debug_reset(s);
+}
+
+static void riscv_dm_reset_hold(Object *obj, ResetType type)
+{
+    (void)type;
+    dm_debug_reset(RISCV_DM(obj));
+}
+
+static const Property riscv_dm_props[] = {
+    DEFINE_PROP_UINT32("num-harts", RISCVDMState, num_harts, 1),
+    DEFINE_PROP_UINT32("datacount", RISCVDMState, num_abstract_data, 2),
+    DEFINE_PROP_UINT32("progbufsize", RISCVDMState, progbuf_size, 8),
+    DEFINE_PROP_BOOL("impebreak", RISCVDMState, impebreak, true),
+    DEFINE_PROP_UINT32("nscratch", RISCVDMState, nscratch, 1),
+    DEFINE_PROP_UINT32("sba-addr-width", RISCVDMState, sba_addr_width, 0),
+};
+
+static const VMStateDescription vmstate_riscv_dm = {
+    .name = TYPE_RISCV_DM,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, RISCVDMState, RISCV_DM_R_MAX),
+        VMSTATE_BOOL(dm_active, RISCVDMState),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static void riscv_dm_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = riscv_dm_realize;
+    dc->vmsd = &vmstate_riscv_dm;
+    device_class_set_props(dc, riscv_dm_props);
+    rc->phases.hold = riscv_dm_reset_hold;
+}
+
+static const TypeInfo riscv_dm_info = {
+    .name          = TYPE_RISCV_DM,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RISCVDMState),
+    .instance_init = riscv_dm_init,
+    .class_init    = riscv_dm_class_init,
+};
+
+static void riscv_dm_register_types(void)
+{
+    type_register_static(&riscv_dm_info);
+}
+
+type_init(riscv_dm_register_types)
+
+DeviceState *riscv_dm_create(MemoryRegion *sys_mem, hwaddr base,
+                             uint32_t num_harts)
+{
+    DeviceState *dev = qdev_new(TYPE_RISCV_DM);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    qdev_prop_set_uint32(dev, "num-harts", num_harts);
+    sysbus_realize_and_unref(sbd, &error_fatal);
+
+    /* MMIO region 0: DMI register file */
+    memory_region_add_subregion(sys_mem, base,
+                                sysbus_mmio_get_region(sbd, 0));
+    /* MMIO region 1: low debug work area (mailbox, cmd, data, flags) */
+    memory_region_add_subregion(sys_mem, base + RISCV_DM_ROM_WORK_BASE,
+                                sysbus_mmio_get_region(sbd, 1));
+    /* MMIO region 2: debug ROM entry vector */
+    memory_region_add_subregion(sys_mem, base + RISCV_DM_ROM_ENTRY,
+                                sysbus_mmio_get_region(sbd, 2));
+    return dev;
+}
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 533472e22a..2e98bfbe9a 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -18,4 +18,6 @@ riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c
 riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
 riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
 
+riscv_ss.add(when: 'CONFIG_RISCV_DM', if_true: files('dm.c'))
+
 hw_arch += {'riscv': riscv_ss}
diff --git a/include/hw/riscv/dm.h b/include/hw/riscv/dm.h
new file mode 100644
index 0000000000..652a1f53dd
--- /dev/null
+++ b/include/hw/riscv/dm.h
@@ -0,0 +1,139 @@
+/*
+ * RISC-V Debug Module v1.0
+ *
+ * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
+ *
+ * Based on the RISC-V Debug Specification v1.0 (ratified 2025-02-21)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RISCV_DM_H
+#define HW_RISCV_DM_H
+
+#include "hw/core/sysbus.h"
+#include "hw/core/register.h"
+
+/* Debug memory layout constants (byte offsets within DM backing store) */
+#define RISCV_DM_SIZE       0x1000
+
+/*
+ * The DMI register window occupies 0x0..0x103.
+ * Place CPU<->DM mailbox words right above it.
+ */
+#define RISCV_DM_ROM_HARTID     0x104
+#define RISCV_DM_ROM_GOING      0x108
+#define RISCV_DM_ROM_RESUME     0x10C
+#define RISCV_DM_ROM_EXCP       0x110
+#define RISCV_DM_ROM_WHERETO    0x300
+#define RISCV_DM_ROM_CMD        0x338
+#define RISCV_DM_ROM_PROGBUF    0x360
+#define RISCV_DM_ROM_DATA       0x3C0
+#define RISCV_DM_ROM_FLAGS      0x400
+#define RISCV_DM_ROM_ENTRY      0x800
+#define RISCV_DM_ROM_WORK_BASE  RISCV_DM_ROM_HARTID
+#define RISCV_DM_ROM_WORK_SIZE  (RISCV_DM_ROM_ENTRY - RISCV_DM_ROM_WORK_BASE)
+#define RISCV_DM_ROM_ENTRY_SIZE (RISCV_DM_SIZE - RISCV_DM_ROM_ENTRY)
+
+/*
+ * Maximum harts addressable by the ROM entry loop.
+ * The ROM uses `lbu s0, 0x400(s0)` with a 7-bit masked mhartid,
+ * giving 128 directly-addressable harts per DM instance.
+ */
+#define RISCV_DM_MAX_HARTS      128
+#define RISCV_DM_HAWINDOW_SIZE  32
+
+/* Register space: 0x00 - 0x100, word-addressed */
+#define RISCV_DM_REG_SIZE       0x104
+#define RISCV_DM_R_MAX          (RISCV_DM_REG_SIZE / 4)
+
+/* Hart flag values written into ROM FLAGS area */
+enum RISCVDMHartFlag {
+    RISCV_DM_FLAG_CLEAR  = 0,
+    RISCV_DM_FLAG_GOING  = 1,
+    RISCV_DM_FLAG_RESUME = 2,
+};
+
+/* Abstract command error codes (CMDERR field) */
+enum RISCVDMCmdErr {
+    RISCV_DM_CMDERR_NONE       = 0,
+    RISCV_DM_CMDERR_BUSY       = 1,
+    RISCV_DM_CMDERR_NOTSUP     = 2,
+    RISCV_DM_CMDERR_EXCEPTION  = 3,
+    RISCV_DM_CMDERR_HALTRESUME = 4,
+    RISCV_DM_CMDERR_BUS        = 5,
+    RISCV_DM_CMDERR_OTHER      = 7,
+};
+
+/* Abstract command types */
+enum RISCVDMCmdType {
+    RISCV_DM_CMD_ACCESS_REG = 0,
+    RISCV_DM_CMD_QUICK_ACCESS = 1,
+    RISCV_DM_CMD_ACCESS_MEM = 2,
+};
+
+/* Abstract register number ranges */
+#define RISCV_DM_REGNO_CSR_START 0x0000
+#define RISCV_DM_REGNO_CSR_END   0x0FFF
+#define RISCV_DM_REGNO_GPR_START 0x1000
+#define RISCV_DM_REGNO_GPR_END   0x101F
+#define RISCV_DM_REGNO_FPR_START 0x1020
+#define RISCV_DM_REGNO_FPR_END   0x103F
+
+#define TYPE_RISCV_DM "riscv-dm"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVDMState, RISCV_DM)
+
+struct RISCVDMState {
+    SysBusDevice parent_obj;
+
+    /* register.h framework */
+    RegisterInfoArray *reg_array;
+    uint32_t regs[RISCV_DM_R_MAX];
+    RegisterInfo regs_info[RISCV_DM_R_MAX];
+
+    /* DM backing store (rom_device) and exported aliases */
+    MemoryRegion rom_mr;
+    MemoryRegion rom_work_alias_mr;
+    MemoryRegion rom_entry_alias_mr;
+    uint8_t *rom_ptr;
+
+    /* Per-hart state */
+    uint32_t num_harts;
+    qemu_irq *halt_irqs;
+    bool *hart_halted;
+    bool *hart_resumeack;
+    bool *hart_havereset;
+    bool *hart_resethaltreq;
+
+    /* DM active state (from DMCONTROL.dmactive) */
+    bool dm_active;
+
+    /* Hart array mask window */
+    uint32_t hawindow[RISCV_DM_MAX_HARTS / RISCV_DM_HAWINDOW_SIZE];
+
+    /* Last executed command (stored for autoexec) */
+    uint32_t last_cmd;
+
+    /* QOM properties */
+    uint32_t num_abstract_data;  /* datacount: default 2 */
+    uint32_t progbuf_size;       /* progbufsize: default 8 */
+    bool impebreak;              /* implicit ebreak */
+    uint32_t nscratch;           /* dscratch count: default 1 */
+    uint32_t sba_addr_width;     /* SBA address bits: default 0 (disabled) */
+};
+
+/*
+ * CPU-side callbacks: called from ROM write handler or CPU debug logic.
+ * These update per-hart state in the DM.
+ */
+void riscv_dm_hart_halted(RISCVDMState *s, uint32_t hartsel);
+void riscv_dm_hart_resumed(RISCVDMState *s, uint32_t hartsel);
+void riscv_dm_abstracts_done(RISCVDMState *s, uint32_t hartsel);
+void riscv_dm_abstracts_exception(RISCVDMState *s, uint32_t hartsel);
+
+/* Convenience: create, configure, realize, and map the DM device.
+ * @base is the start of the DM address space (size RISCV_DM_SIZE). */
+DeviceState *riscv_dm_create(MemoryRegion *sys_mem, hwaddr base,
+                             uint32_t num_harts);
+
+#endif /* HW_RISCV_DM_H */
-- 
2.53.0


