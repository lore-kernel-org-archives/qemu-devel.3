Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56364D232C8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RN-0006O1-6M; Fri, 09 Jan 2026 01:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6QW-0005Ly-Lj
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:56 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6QT-0002wT-6l
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:51 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-81e8a9d521dso90032b3a.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941807; x=1768546607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0Au3sw3AJ8TUnw2C42QeidnjEPUIHmOI0xqLrHkucE=;
 b=mhr7Uu7q8A0lKyqYT7uPTNpcjZmc+9WJV5Tl8k0HIMtdTuvpELXRPna0hEtReCEpPU
 DZPWToXFdCQbPQiPdUQXtLKzp2lBSauBmPCKT2SJEIXHiQZUmw/mVChrr5+8RfAhsOkl
 /0N/fSGrH+NgewJ6sDzjh7bi98K/Cb9/i/r4oJfPl41YYEeJQ7uL6nnRH8CNSjrx8OBN
 HOT81sFo6ZC2qdetTMKVSndxqxCKuAqdWdAcc5HoMKzTTbGYu6iqCbmuc5NbK4P/Wn/m
 MxlFaLJw2rILORo9RjWQ/LOKtz39ZrBzLwiA99YGY64wt18/vIS5L0jyU7H6M9ZvQzMP
 wKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941807; x=1768546607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H0Au3sw3AJ8TUnw2C42QeidnjEPUIHmOI0xqLrHkucE=;
 b=s/t8cnF3SUYHco3+1P0XBtEhCOs1GeMdLZzvYZmFZa283dgGt8Xj0/wvrMyKE8tTBK
 vYa+z3SECNecggxvticTlHD36J19NBTMyPGRvY3XRMGL8a9nK9VPH+cai6CzcYos+DwU
 zrk5lV9zLV9XhonR05rgKdYZyu2PQ/QdhBdt+MyaCW4apxmuAt4L6UI5eubFs1lUwb9H
 iuhZGZ3ax5ChW0/ogG4O1BUeOKn0+yhuhskh+Yri1qWmabxoJnLPFsgMJZO7Wqwo+r+3
 6yTzS9Ofst8EdzLSWswz+hnxZIX2ai6QnsjwT6DJLrlQ3NJFeNzbXqpI0msstMrFQzk/
 CKpQ==
X-Gm-Message-State: AOJu0YxOSsQ83XnzVILCPZBxgs54rfKBbLYLeGtlL02ToXADQTmslLnu
 GBpoSItSjHPmejxKEps4fF6O5D7etlCMJ9hooMMoHUK3zHawGddkak2YtsLwJA==
X-Gm-Gg: AY/fxX6+e2kep11NahPqTy4Uba1+LQb9SR7KLjAfkvPWHomH0vi9nAa8l7EudUqo/4I
 hYe9mxt3txuJVWnVAmEpCU7AFVSlbXcoMmeGRpCMXfXQmKv26RU6NECOBNZeVd5jmy7byvwv8r8
 FYDfCkJVPhYN+sM/i0fLTeW9qdhQ2QRkVysbaudyK5gkxkH4X5ELYXMnZamclAe48rajlYrjh/N
 0MzXCRC8GEdCdgO4ff1t1LwiNL0wKKC0RE1DqQLGk0YcikWYtIi+6BD3fykDzAUOeI0eQh9kIKJ
 A8gzrhXRjXHq2Cnn96pAKGjcOOz3SfCjKQJPHqLt3JkW5M6jiKInONXgJcVdnNgdWjeMF3VjvOd
 ygV/Y80qfZqOtGk5KqSCb0mLX9o2VtKudtvDnmWRoyXTeKgTZTUol3c9L+143hpKL+ULhgB0wn9
 RU1qWpWnvJTnmh+sRIdEvjCZExJGsipInf64kpQdMECPqKqwX1ENPcFlOTDS0/yb06fN/PfetYl
 wJg7LmN/ZzJJlJaT9I=
X-Google-Smtp-Source: AGHT+IF4R6DjiQoDK+FfMVrfOVuERpFz9PAyx2H2uKE6k6VGhAGxtpy1ZQEvzmow7m3BddQnlt0/QA==
X-Received: by 2002:a05:6a21:6d81:b0:389:8e23:f43a with SMTP id
 adf61e73a8af0-3898f9dc4d1mr8380363637.73.1767941807401; 
 Thu, 08 Jan 2026 22:56:47 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:56:46 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/34] hw/misc: Add RISC-V CMGCR device implementation
Date: Fri,  9 Jan 2026 16:54:54 +1000
Message-ID: <20260109065459.19987-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add RISC-V implementation of the Coherent Manager Global Control
Register (CMGCR) device. It is based on the existing MIPS CMGCR
implementation but adapted for RISC-V systems.

The CMGCR device provides global system control for multi-core
configurations in RISC-V systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20260108134128.2218102-8-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/misc/riscv_cmgcr.h |  48 +++++++
 hw/misc/riscv_cmgcr.c         | 243 ++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig               |   9 ++
 hw/misc/meson.build           |   2 +
 4 files changed, 302 insertions(+)
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 hw/misc/riscv_cmgcr.c

diff --git a/include/hw/misc/riscv_cmgcr.h b/include/hw/misc/riscv_cmgcr.h
new file mode 100644
index 0000000000..1878d98fc6
--- /dev/null
+++ b/include/hw/misc/riscv_cmgcr.h
@@ -0,0 +1,48 @@
+/*
+ * Coherent Manager Global Control Register
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CMGCR_H
+#define RISCV_CMGCR_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_GCR "riscv-gcr"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVGCRState, RISCV_GCR)
+
+#define GCR_BASE_ADDR           0x1fb80000ULL
+#define GCR_MAX_VPS             256
+
+typedef struct RISCVGCRVPState RISCVGCRVPState;
+struct RISCVGCRVPState {
+    uint64_t reset_base;
+};
+
+typedef struct RISCVGCRState RISCVGCRState;
+struct RISCVGCRState {
+    SysBusDevice parent_obj;
+
+    int32_t gcr_rev;
+    uint32_t cluster_id;
+    uint32_t num_vps;
+    uint32_t num_hart;
+    uint32_t num_core;
+    hwaddr gcr_base;
+    MemoryRegion iomem;
+    MemoryRegion *cpc_mr;
+
+    uint64_t cpc_base;
+
+    /* VP Local/Other Registers */
+    RISCVGCRVPState *vps;
+};
+
+#endif /* RISCV_CMGCR_H */
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
new file mode 100644
index 0000000000..b0294e7663
--- /dev/null
+++ b/hw/misc/riscv_cmgcr.c
@@ -0,0 +1,243 @@
+/*
+ * Coherent Manager Global Control Register
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 documentation
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/core/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/core/qdev-properties.h"
+
+#include "cpu.h"
+
+#define CM_RESET_VEC 0x1FC00000
+#define GCR_ADDRSPACE_SZ        0x8000
+
+/* Offsets to register blocks */
+#define RISCV_GCB_OFS        0x0000 /* Global Control Block */
+#define RISCV_CLCB_OFS       0x2000 /* Core Control Block */
+#define RISCV_CORE_REG_STRIDE 0x100 /* Stride between core-specific registers */
+
+/* Global Control Block Register Map */
+#define GCR_CONFIG_OFS      0x0000
+#define GCR_BASE_OFS        0x0008
+#define GCR_REV_OFS         0x0030
+#define GCR_CPC_STATUS_OFS  0x00F0
+#define GCR_L2_CONFIG_OFS   0x0130
+
+/* GCR_L2_CONFIG register fields */
+#define GCR_L2_CONFIG_BYPASS_SHF    20
+#define GCR_L2_CONFIG_BYPASS_MSK    ((0x1ULL) << GCR_L2_CONFIG_BYPASS_SHF)
+
+/* GCR_BASE register fields */
+#define GCR_BASE_GCRBASE_MSK     0xffffffff8000ULL
+
+/* GCR_CPC_BASE register fields */
+#define GCR_CPC_BASE_CPCEN_MSK   1
+#define GCR_CPC_BASE_CPCBASE_MSK 0xFFFFFFFF8000ULL
+#define GCR_CPC_BASE_MSK (GCR_CPC_BASE_CPCEN_MSK | GCR_CPC_BASE_CPCBASE_MSK)
+
+/* GCR_CL_RESETBASE_OFS register fields */
+#define GCR_CL_RESET_BASE_RESETBASE_MSK 0xFFFFFFFFFFFFF000U
+#define GCR_CL_RESET_BASE_MSK GCR_CL_RESET_BASE_RESETBASE_MSK
+
+static inline bool is_cpc_connected(RISCVGCRState *s)
+{
+    return s->cpc_mr != NULL;
+}
+
+static inline void update_cpc_base(RISCVGCRState *gcr, uint64_t val)
+{
+    if (is_cpc_connected(gcr)) {
+        gcr->cpc_base = val & GCR_CPC_BASE_MSK;
+        memory_region_transaction_begin();
+        memory_region_set_address(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCBASE_MSK);
+        memory_region_set_enabled(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCEN_MSK);
+        memory_region_transaction_commit();
+    }
+}
+
+static inline void update_gcr_base(RISCVGCRState *gcr, uint64_t val)
+{
+    gcr->gcr_base = val & GCR_BASE_GCRBASE_MSK;
+    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
+
+    /*
+     * For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
+     * cpc automatically.
+     */
+    update_cpc_base(gcr, val + 0x8001);
+}
+
+/* Read GCR registers */
+static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RISCVGCRState *gcr = (RISCVGCRState *) opaque;
+
+    switch (addr) {
+    /* Global Control Block Register */
+    case GCR_CONFIG_OFS:
+        /* Set PCORES to 0 */
+        return 0;
+    case GCR_BASE_OFS:
+        return gcr->gcr_base;
+    case GCR_REV_OFS:
+        return gcr->gcr_rev;
+    case GCR_CPC_STATUS_OFS:
+        return is_cpc_connected(gcr);
+    case GCR_L2_CONFIG_OFS:
+        /* L2 BYPASS */
+        return GCR_L2_CONFIG_BYPASS_MSK;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" HWADDR_PRIx
+                      "\n", size, addr);
+    }
+    return 0;
+}
+
+static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
+{
+    return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
+}
+
+/* Write GCR registers */
+static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
+{
+    RISCVGCRState *gcr = (RISCVGCRState *)opaque;
+    RISCVGCRVPState *current_vps;
+    int cpu_index, c, h;
+
+    for (c = 0; c < gcr->num_core; c++) {
+        for (h = 0; h < gcr->num_hart; h++) {
+            if (addr == RISCV_CLCB_OFS + c * RISCV_CORE_REG_STRIDE + h * 8) {
+                cpu_index = c * gcr->num_hart + h;
+                current_vps = &gcr->vps[cpu_index];
+                current_vps->reset_base = data & GCR_CL_RESET_BASE_MSK;
+                cpu_set_exception_base(cpu_index + gcr->cluster_id *
+                                       gcr->num_core * gcr->num_hart,
+                                       get_exception_base(current_vps));
+                return;
+            }
+        }
+    }
+
+    switch (addr) {
+    case GCR_BASE_OFS:
+        update_gcr_base(gcr, data);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" HWADDR_PRIx
+                      " 0x%" PRIx64 "\n", size, addr, data);
+        break;
+    }
+}
+
+static const MemoryRegionOps gcr_ops = {
+    .read = gcr_read,
+    .write = gcr_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .max_access_size = 8,
+    },
+};
+
+static void riscv_gcr_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RISCVGCRState *s = RISCV_GCR(obj);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &gcr_ops, s,
+                          "riscv-gcr", GCR_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void riscv_gcr_reset(DeviceState *dev)
+{
+    RISCVGCRState *s = RISCV_GCR(dev);
+    int i;
+
+    /* Update cpc_base to gcr_base + 0x8001 to enable cpc automatically. */
+    update_cpc_base(s, s->gcr_base + 0x8001);
+
+    for (i = 0; i < s->num_vps; i++) {
+        s->vps[i].reset_base = CM_RESET_VEC & GCR_CL_RESET_BASE_MSK;
+        cpu_set_exception_base(i, get_exception_base(&s->vps[i]));
+    }
+}
+
+static const VMStateDescription vmstate_riscv_gcr = {
+    .name = "riscv-gcr",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(cpc_base, RISCVGCRState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_gcr_properties[] = {
+    DEFINE_PROP_UINT32("cluster-id", RISCVGCRState, cluster_id, 0),
+    DEFINE_PROP_UINT32("num-vp", RISCVGCRState, num_vps, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVGCRState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVGCRState, num_core, 1),
+    DEFINE_PROP_INT32("gcr-rev", RISCVGCRState, gcr_rev, 0xa00),
+    DEFINE_PROP_UINT64("gcr-base", RISCVGCRState, gcr_base, GCR_BASE_ADDR),
+    DEFINE_PROP_LINK("cpc", RISCVGCRState, cpc_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+};
+
+static void riscv_gcr_realize(DeviceState *dev, Error **errp)
+{
+    RISCVGCRState *s = RISCV_GCR(dev);
+
+    /* Validate num_vps */
+    if (s->num_vps == 0) {
+        error_setg(errp, "num-vp must be at least 1");
+        return;
+    }
+    if (s->num_vps > GCR_MAX_VPS) {
+        error_setg(errp, "num-vp cannot exceed %d", GCR_MAX_VPS);
+        return;
+    }
+
+    /* Create local set of registers for each VP */
+    s->vps = g_new(RISCVGCRVPState, s->num_vps);
+}
+
+static void riscv_gcr_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_props(dc, riscv_gcr_properties);
+    dc->vmsd = &vmstate_riscv_gcr;
+    device_class_set_legacy_reset(dc, riscv_gcr_reset);
+    dc->realize = riscv_gcr_realize;
+}
+
+static const TypeInfo riscv_gcr_info = {
+    .name          = TYPE_RISCV_GCR,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RISCVGCRState),
+    .instance_init = riscv_gcr_init,
+    .class_init    = riscv_gcr_class_init,
+};
+
+static void riscv_gcr_register_types(void)
+{
+    type_register_static(&riscv_gcr_info);
+}
+
+type_init(riscv_gcr_register_types)
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fccd735c24..404500979c 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -121,6 +121,15 @@ config MIPS_ITU
     bool
     depends on TCG
 
+config RISCV_MIPS_CMGCR
+    bool
+
+config MIPS_BOSTON_AIA
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_MIPS_CMGCR
+
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..489f0f3319 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -157,6 +157,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
 
+specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmgcr.c'))
+
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 
 # HPPA devices
-- 
2.52.0


