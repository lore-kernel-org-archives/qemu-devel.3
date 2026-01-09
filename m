Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16428D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RS-0006el-AP; Fri, 09 Jan 2026 01:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Qc-0005P5-Q6
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:57:02 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Qa-0002x6-PQ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:58 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c47ee987401so1202343a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941815; x=1768546615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gC8RXWPuJRgQiFyxukmRk2Y5PkJpf+bc3fUwtdkfyUY=;
 b=RbXNAq8X9utHEo+Jdpxdz555k/bTu7cpZ/bH6dVPiZWbHrRyjVcKnj2euK9GHImgPX
 nH9Wb0yqKSyX6lVlXr0IlkSRw8vN0LsK7xKpEcQa94p07WkJAqhdkkphi224IFvpzFHo
 UxA8F0HJkEKoSPUdVE2WEbHTgi6iwG1ZntvvRLPcHHKdw3F9q7J6bi9nKUBpgH74FkU+
 YOy3+Lyfe/xW6hwxnChsYB4LMppBLe5ff4e227SsN8JGv767VPNFD8unr6UqJYqSMS4L
 3uWFJERuxyX+ecChJLVJqXscjOJX6fpT71X6fpvbRKwLjxbGej5o3HG8gV+1eULsWWZ8
 jF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941815; x=1768546615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gC8RXWPuJRgQiFyxukmRk2Y5PkJpf+bc3fUwtdkfyUY=;
 b=t2TA7WXnE2YfQswXwl4N/OT0QzhUNo3iJNmGq0gdCK1DOIaM1q9kBBzxsDix7wr8R+
 gzhKB5InE2HeykkWoJeyjW4fdtukyFe6r0xzfnhpRat1R3IDRV167XKfxMQ4ZS2YI0Nq
 A5LX5L1vmc53N8NPeu8UJ9Wj8JITDBueVjsXO2fBolHsQHeSr78eb3jjZ0ExZ0OMI5Qv
 3/3jCiODa/w7L/dxYe/og0ITG+NCamRJBCVS4veSqqLHUd49rjYlK0H+tu7kqYYQKUaz
 oTVi+qAJC8c4otwZ/IXcZQvoZXmZGj/sNt09lUf5TsIKRTlBW+9YzT759phzNgD1YUTu
 adKg==
X-Gm-Message-State: AOJu0YwiIhQ72atbabyfVeVxWVOcZ7WmGDp5eelHXzlV/LIvNo2/WOzM
 yNp52Sv/ADzyCvOk5+gCsngIGBgYXFTpUv8wYtTeToj6+YR4xsDXHeQZz9zPOg==
X-Gm-Gg: AY/fxX4vCf7uQcPlUtHzO9hSZTsjhqr6HiiRk6k65iHfGGbSAXNVUsGyaSLdAv2dZ6U
 MulgtUm/ndULZrbvVMQs6cAdHMghBlDCSJn9x74AqoEI6HDx8ZRsT1ZqPz3bXxhsvMj53Y3KjlK
 7/ctoN6OQ2LgEZSq5yNuQdLu7YJCtw/hwnT+Iq8s+fDYat2nx6Lx68fP3p0BvczOSITCiSGQIJE
 YQrFIAw4JPWbomt4/qxb1osHLNi7xhNcKJCfkQf/pB8Zh3FaAp25/EAs2pzO00bcYJ+4+Y5sZM8
 maEUZYHhmOLgbaF1GtRWump8QHRoRndiR+RvWEcih0HUe/QgwN6gwEUMRsECHP+jjMXF2BQVAvp
 aq2XIHSf28C55DTY39wedxlSD4Ko6og+mP7xe3puEtqXkoCKqLS+13uxkpHXKcLRixNDGI7v6GQ
 U4q5w43ZtCZ96z3Z56bFIV9t8YuZxz6W1LMYe8KmcwZTTpnScOmdUeXSneASkWbLfg76P8YWOn0
 lywebQkftAqM0jORnQ=
X-Google-Smtp-Source: AGHT+IEHsvSVZXi9HkDn8WzMfGokbamVOr6bi2li/zddExDbsO3fVnQBzD3XkL754SN1pHPjZ8ba/A==
X-Received: by 2002:a05:6a21:e0a7:b0:389:5a49:1f85 with SMTP id
 adf61e73a8af0-38982a41e6fmr12841866637.7.1767941815006; 
 Thu, 08 Jan 2026 22:56:55 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:56:54 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/34] hw/riscv: Add support for RISCV CPS
Date: Fri,  9 Jan 2026 16:54:56 +1000
Message-ID: <20260109065459.19987-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
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

Add support for the Coherent Processing System for RISC-V.
This enables SMP support for RISC-V boards that require
cache-coherent multiprocessor systems.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20260108134128.2218102-10-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/cps.h |  66 ++++++++++++++
 hw/riscv/cps.c         | 196 +++++++++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig        |   4 +
 hw/riscv/meson.build   |   2 +
 4 files changed, 268 insertions(+)
 create mode 100644 include/hw/riscv/cps.h
 create mode 100644 hw/riscv/cps.c

diff --git a/include/hw/riscv/cps.h b/include/hw/riscv/cps.h
new file mode 100644
index 0000000000..f33fd7ac86
--- /dev/null
+++ b/include/hw/riscv/cps.h
@@ -0,0 +1,66 @@
+/*
+ * Coherent Processing System emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CPS_H
+#define RISCV_CPS_H
+
+#include "hw/core/sysbus.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/misc/riscv_cpc.h"
+#include "target/riscv/cpu.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_CPS "riscv-cps"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPSState, RISCV_CPS)
+
+/* The model supports up to 64 harts. */
+#define MAX_HARTS 64
+
+/* The global CM base for the boston-aia model. */
+#define GLOBAL_CM_BASE 0x16100000
+/* The CM block is 512 KiB. */
+#define CM_SIZE (1 << 19)
+
+/*
+ * The mhartid bits has cluster at bit 16, core at bit 4, and hart at
+ * bit 0.
+ */
+
+#define MHARTID_CLUSTER_SHIFT 16
+#define MHARTID_CORE_SHIFT 4
+#define MHARTID_HART_SHIFT 0
+
+#define APLIC_NUM_SOURCES 0x35 /* Arbitray maximum number of interrupts. */
+#define APLIC_NUM_PRIO_BITS 3
+#define AIA_PLIC_M_OFFSET 0x40000
+#define AIA_PLIC_M_SIZE 0x8000
+#define AIA_PLIC_S_OFFSET 0x60000
+#define AIA_PLIC_S_SIZE 0x8000
+#define AIA_CLINT_OFFSET 0x50000
+
+typedef struct RISCVCPSState {
+    SysBusDevice parent_obj;
+
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    uint64_t gcr_base;
+    char *cpu_type;
+
+    MemoryRegion container;
+    RISCVGCRState gcr;
+    RISCVCPCState cpc;
+
+    DeviceState *aplic;
+    CPUState **cpus;
+} RISCVCPSState;
+
+#endif
diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
new file mode 100644
index 0000000000..86172be5b3
--- /dev/null
+++ b/hw/riscv/cps.c
@@ -0,0 +1,196 @@
+/*
+ * Coherent Processing System emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/riscv/cps.h"
+#include "hw/core/qdev-properties.h"
+#include "system/reset.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/intc/riscv_aplic.h"
+#include "hw/intc/riscv_imsic.h"
+#include "hw/pci/msi.h"
+
+static void riscv_cps_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RISCVCPSState *s = RISCV_CPS(obj);
+
+    /*
+     * Cover entire address space as there do not seem to be any
+     * constraints for the base address of CPC .
+     */
+    memory_region_init(&s->container, obj, "mips-cps-container", UINT64_MAX);
+    sysbus_init_mmio(sbd, &s->container);
+}
+
+static void main_cpu_reset(void *opaque)
+{
+    CPUState *cs = opaque;
+
+    cpu_reset(cs);
+}
+
+static void riscv_cps_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPSState *s = RISCV_CPS(dev);
+    RISCVCPU *cpu;
+    int i;
+
+    /* Validate num_vp */
+    if (s->num_vp == 0) {
+        error_setg(errp, "num-vp must be at least 1");
+        return;
+    }
+    if (s->num_vp > MAX_HARTS) {
+        error_setg(errp, "num-vp cannot exceed %d", MAX_HARTS);
+        return;
+    }
+
+    /* Allocate CPU array */
+    s->cpus = g_new0(CPUState *, s->num_vp);
+
+    /* Set up cpu_index and mhartid for avaiable CPUs. */
+    int harts_in_cluster = s->num_hart * s->num_core;
+    int num_of_clusters = s->num_vp / harts_in_cluster;
+    for (i = 0; i < s->num_vp; i++) {
+        cpu = RISCV_CPU(object_new(s->cpu_type));
+
+        /* All VPs are halted on reset. Leave powering up to CPC. */
+        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
+                                 &error_abort);
+
+        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
+            return;
+        }
+
+        /* Store CPU in array */
+        s->cpus[i] = CPU(cpu);
+
+        /* Set up mhartid */
+        int cluster_id = i / harts_in_cluster;
+        int hart_id = (i % harts_in_cluster) % s->num_hart;
+        int core_id = (i % harts_in_cluster) / s->num_hart;
+        int mhartid = (cluster_id << MHARTID_CLUSTER_SHIFT) +
+                      (core_id << MHARTID_CORE_SHIFT) +
+                      (hart_id << MHARTID_HART_SHIFT);
+        cpu->env.mhartid = mhartid;
+        qemu_register_reset(main_cpu_reset, s->cpus[i]);
+    }
+
+    /* Cluster Power Controller */
+    object_initialize_child(OBJECT(dev), "cpc", &s->cpc, TYPE_RISCV_CPC);
+    object_property_set_uint(OBJECT(&s->cpc), "cluster-id", 0,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-vp", s->num_vp,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-hart", s->num_hart,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-core", s->num_core,
+                            &error_abort);
+
+    /* Pass CPUs to CPC using link properties */
+    for (i = 0; i < s->num_vp; i++) {
+        char *propname = g_strdup_printf("cpu[%d]", i);
+        object_property_set_link(OBJECT(&s->cpc), propname,
+                                OBJECT(s->cpus[i]), &error_abort);
+        g_free(propname);
+    }
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpc), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->container, 0,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cpc), 0));
+
+    /* Global Configuration Registers */
+    object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_RISCV_GCR);
+    object_property_set_uint(OBJECT(&s->gcr), "cluster-id", 0,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->gcr), "num-vp", s->num_vp,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), "gcr-rev", 0xa00,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), "gcr-base", s->gcr_base,
+                            &error_abort);
+    object_property_set_link(OBJECT(&s->gcr), "cpc", OBJECT(&s->cpc.mr),
+                             &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->container, s->gcr_base,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gcr), 0));
+
+    for (i = 0; i < num_of_clusters; i++) {
+        uint64_t cm_base = GLOBAL_CM_BASE + (CM_SIZE * i);
+        uint32_t hartid_base = i << MHARTID_CLUSTER_SHIFT;
+        s->aplic = riscv_aplic_create(cm_base + AIA_PLIC_M_OFFSET,
+                                      AIA_PLIC_M_SIZE,
+                                      hartid_base, /* hartid_base */
+                                      MAX_HARTS, /* num_harts */
+                                      APLIC_NUM_SOURCES,
+                                      APLIC_NUM_PRIO_BITS,
+                                      false, true, NULL);
+        riscv_aplic_create(cm_base + AIA_PLIC_S_OFFSET,
+                           AIA_PLIC_S_SIZE,
+                           hartid_base, /* hartid_base */
+                           MAX_HARTS, /* num_harts */
+                           APLIC_NUM_SOURCES,
+                           APLIC_NUM_PRIO_BITS,
+                           false, false, s->aplic);
+        /* PLIC changes msi_nonbroken to ture. We revert the change. */
+        msi_nonbroken = false;
+        riscv_aclint_swi_create(cm_base + AIA_CLINT_OFFSET,
+                                hartid_base, MAX_HARTS, false);
+        riscv_aclint_mtimer_create(cm_base + AIA_CLINT_OFFSET +
+                                   RISCV_ACLINT_SWI_SIZE,
+                                   RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
+                                   hartid_base,
+                                   MAX_HARTS,
+                                   RISCV_ACLINT_DEFAULT_MTIMECMP,
+                                   RISCV_ACLINT_DEFAULT_MTIME,
+                                   RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, false);
+    }
+}
+
+static const Property riscv_cps_properties[] = {
+    DEFINE_PROP_UINT32("num-vp", RISCVCPSState, num_vp, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPSState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPSState, num_core, 1),
+    DEFINE_PROP_UINT64("gcr-base", RISCVCPSState, gcr_base, GCR_BASE_ADDR),
+    DEFINE_PROP_STRING("cpu-type", RISCVCPSState, cpu_type),
+};
+
+static void riscv_cps_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = riscv_cps_realize;
+    device_class_set_props(dc, riscv_cps_properties);
+}
+
+static const TypeInfo riscv_cps_info = {
+    .name = TYPE_RISCV_CPS,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RISCVCPSState),
+    .instance_init = riscv_cps_init,
+    .class_init = riscv_cps_class_init,
+};
+
+static void riscv_cps_register_types(void)
+{
+    type_register_static(&riscv_cps_info);
+}
+
+type_init(riscv_cps_register_types)
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 38be72b141..4a22d68233 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -127,12 +127,16 @@ config RISCV_MIPS_CMGCR
 config RISCV_MIPS_CPC
     bool
 
+config RISCV_MIPS_CPS
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_MIPS_CMGCR
     select RISCV_MIPS_CPC
+    select RISCV_MIPS_CPS
 
 config MPS2_FPGAIO
     bool
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2a8d5b136c..9023b80087 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -15,4 +15,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
 
+riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
+
 hw_arch += {'riscv': riscv_ss}
-- 
2.52.0


