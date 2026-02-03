Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B2FE8305C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnASB-0002D7-32; Tue, 03 Feb 2026 02:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARv-00020a-Vd; Tue, 03 Feb 2026 02:03:47 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARu-0003Dq-07; Tue, 03 Feb 2026 02:03:47 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 77C736013C;
 Tue,  3 Feb 2026 07:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD4EC2BC86;
 Tue,  3 Feb 2026 07:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770102216;
 bh=e2KtRGoKZ47Vc8zsUbi+oBeJfeeSHXFxI38YIVjPrls=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=E8KArSHj6slGZfuj6yEjISiiVHht4bbO92EsSJNrBhA0ULUE3EI6verYKRY1Oshra
 SOoQHnNN1ghfTZQKhAY+FsbZg39kMbUA7Kb7w1Q+/nBzG0jXFS8OZhiQPcg5CSlmtI
 DYDruaNhWB9lOb+YNLh8rGvYWyfScd3zXV42qu6eP2zT6FJ8GpEizbyr4c4cTmmyG6
 0aOn8A/JIKgbAOAbS51dXIDVINWkOBRJ+c/LDinH711NPAh/v30d3u2goXBhAThbak
 cpF90VFVuHhieFL1QVQ2v5HhMEj17UAZm/66MUbmhDd2LcIHuaBvv8j1reK70kn0kV
 /X5PADs1eEsUA==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 02 Feb 2026 23:01:17 -0800
Subject: [PATCH RFC 1/7] hw/riscv: Add support for ACPI RQSC table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-riscv-rqsc-v1-1-dcf448a3ed73@kernel.org>
References: <20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org>
In-Reply-To: <20260202-riscv-rqsc-v1-0-dcf448a3ed73@kernel.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Sunil V L <sunilvl@ventanamicro.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-arm@nongnu.org, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9127; i=fustini@kernel.org;
 h=from:subject:message-id; bh=eXZEfZrgLgLSbfNI9AvAgsinKRrStsfYatyPSMNmam0=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQ2zj3GdOve2wDO/9miZW/enHyiJVXa8umE8a9rbGfdb
 /DLMxrd7ChlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMhMOT4X8655Rdj5f+nGD/
 KiTikuiziJzX5pd1l3w18A0LzJgv2yLJyPDwMMu8H37J+ayMLElGcxVLMmUW+ot03Ztjb/F2O1v
 sDGYA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vasudevan Srinivasan <vasu@rivosinc.com>

In build_rqsc(), set Res ID 1 for each cache controller in RQSC table.
The AML code that generates that PPTT table uses the cache controller
mmio_base address as the Cache ID.

TODO: Similar plumbing still needs to be done to correlate bandwitch
controllers to the Proximity Domain for Memory Affinity Structures in
the SRAT table.

Signed-off-by: Vasudevan Srinivasan <vasu@rivosinc.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 hw/core/sysbus-fdt.c       |   3 ++
 hw/riscv/cbqri_bandwidth.c |  11 +++++
 hw/riscv/cbqri_capacity.c  |  11 +++++
 hw/riscv/virt-acpi-build.c | 121 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/cbqri.h   |  12 +++++
 5 files changed, 158 insertions(+)

diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index 89d0c464454a..d7967cde51be 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -36,6 +36,7 @@
 #include "hw/display/ramfb.h"
 #include "hw/uefi/var-service-api.h"
 #include "hw/arm/fdt.h"
+#include "hw/riscv/cbqri.h"
 
 /*
  * internal struct that contains the information to create dynamic
@@ -140,6 +141,8 @@ static const BindingEntry bindings[] = {
     TYPE_BINDING(TYPE_ARM_SMMUV3, no_fdt_node),
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
     TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
+    TYPE_BINDING(TYPE_RISCV_CBQRI_BC, no_fdt_node),
+    TYPE_BINDING(TYPE_RISCV_CBQRI_CC, no_fdt_node),
     TYPE_BINDING("", NULL), /* last element */
 };
 
diff --git a/hw/riscv/cbqri_bandwidth.c b/hw/riscv/cbqri_bandwidth.c
index f86b3bf75027..01f03d790410 100644
--- a/hw/riscv/cbqri_bandwidth.c
+++ b/hw/riscv/cbqri_bandwidth.c
@@ -635,4 +635,15 @@ DeviceState *riscv_cbqri_bc_create(hwaddr addr,
     return dev;
 }
 
+void get_bc_details(DeviceState *ds, const char *type, RQSC *rqsc)
+{
+    if (strcmp(type, TYPE_RISCV_CBQRI_BC) == 0) {
+        RiscvCbqriBandwidthState *bcs = RISCV_CBQRI_BC(ds);
+        (rqsc)->controllerType = 1;
+        (rqsc)->mmio_base = bcs->mmio_base;
+        (rqsc)->rcidCount = bcs->nb_rcids;
+        (rqsc)->mcidCount = bcs->nb_mcids;
+    }
+}
+
 type_init(riscv_cbqri_bc_register_types)
diff --git a/hw/riscv/cbqri_capacity.c b/hw/riscv/cbqri_capacity.c
index 1c3570262a36..8d830c278e00 100644
--- a/hw/riscv/cbqri_capacity.c
+++ b/hw/riscv/cbqri_capacity.c
@@ -730,4 +730,15 @@ DeviceState *riscv_cbqri_cc_create(hwaddr addr,
     return dev;
 }
 
+void get_cc_details(DeviceState *ds, const char *type, RQSC *rqsc)
+{
+    if (strcmp(type, TYPE_RISCV_CBQRI_CC) == 0) {
+        RiscvCbqriCapacityState *ccs = RISCV_CBQRI_CC(ds);
+        rqsc->controllerType = 0;
+        rqsc->mmio_base = ccs->mmio_base;
+        rqsc->rcidCount = ccs->nb_rcids;
+        rqsc->mcidCount = ccs->nb_mcids;
+    }
+}
+
 type_init(riscv_cbqri_cc_register_types)
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index f1406cb68339..210b3f5fff98 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -34,6 +34,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/numa.h"
+#include "hw/riscv/cbqri.h"
 #include "hw/virtio/virtio-acpi.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
@@ -269,6 +270,123 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
 /* RHCT Node[N] starts at offset 56 */
 #define RHCT_NODE_ARRAY_OFFSET 56
 
+static u_int8_t gatherCbqriDetails(RISCVVirtState *vs, RQSC rqsc[])
+{
+    BusChild *bc = NULL;
+    DeviceState *ds = NULL;
+    u_int8_t controllerCount = 0;
+
+    if (vs == NULL) {
+        printf("RISCVVirtState is NULL\n");
+        return 0;
+    }
+
+    QTAILQ_FOREACH(bc, &vs->platform_bus_dev->parent_bus->children, sibling) {
+        if (strcmp(object_get_typename(OBJECT(bc->child)),
+                   TYPE_RISCV_CBQRI_BC) == 0)
+        {
+            ds = bc->child;
+            get_bc_details(ds, object_get_typename(OBJECT(bc->child)),
+                           &(rqsc[controllerCount]));
+            controllerCount++;
+        }
+        if (strcmp(object_get_typename(OBJECT(bc->child)),
+                   TYPE_RISCV_CBQRI_CC) == 0)
+        {
+            ds = bc->child;
+            get_cc_details(ds, object_get_typename(OBJECT(bc->child)),
+                           &(rqsc[controllerCount]));
+            controllerCount++;
+        }
+    }
+
+    return controllerCount;
+}
+
+/*
+ *
+ * RQSC Table
+ *
+ */
+static void build_rqsc(GArray *table_data,
+                       BIOSLinker *linker,
+                       RISCVVirtState *s)
+{
+    int numCbqriControllers = 0;
+    /* Support for upto 10 CBQRI controllers */
+    RQSC rqsc[10];
+    int i = 0;
+
+    AcpiTable table = { .sig = "RQSC", .rev = 0, .oem_id = s->oem_id,
+                        .oem_table_id = s->oem_table_id };
+
+    acpi_table_begin(&table, table_data);
+
+    numCbqriControllers = gatherCbqriDetails(s, rqsc);
+
+    fprintf(stderr, "[QEMU] %s(): numCbqriControllers = %d\n",
+            __func__, numCbqriControllers);
+    /* Number of QoS Controllers */
+    build_append_int_noprefix(table_data, numCbqriControllers, 4);
+
+    for (i = 0; i < numCbqriControllers; i++) {
+        fprintf(stderr, "[QEMU] %s(): Controller %d: Controller Type = %d\n",
+                __func__, i, rqsc[i].controllerType);
+        /* Controller Type */
+        build_append_int_noprefix(table_data, rqsc[i].controllerType, 1);
+        /* Reserved */
+        build_append_int_noprefix(table_data, 0, 1);
+        /* Length */
+        build_append_int_noprefix(table_data, 32, 2);
+        /* Controller register interface address */
+        build_append_gas(table_data,
+                AML_AS_SYSTEM_MEMORY,
+                0,
+                0,
+                4,
+                rqsc[i].mmio_base);
+        /* RCID Count */
+        build_append_int_noprefix(table_data, rqsc[i].rcidCount, 4);
+        /* MCID Count */
+        build_append_int_noprefix(table_data, rqsc[i].mcidCount, 4);
+        /* Controller Flags*/
+        build_append_int_noprefix(table_data, 0, 2);
+        /* Number of Resources hard coded to 1 for QEMU */
+        build_append_int_noprefix(table_data, 1, 2);
+
+        /* Resource Structure per Controller */
+        /* Resource Type  - Setting to the same as Controller Type for now */
+        build_append_int_noprefix(table_data, rqsc[i].controllerType, 1);
+        /* Reserved */
+        build_append_int_noprefix(table_data, 0, 1);
+        /* Length of Resource Structure */
+        build_append_int_noprefix(table_data, 20, 2);
+        /* Resource Flags */
+        build_append_int_noprefix(table_data, 0, 2);
+        /* Reserved */
+        build_append_int_noprefix(table_data, 0, 1);
+        /* Resource ID Type  - Setting to the same as Controller Type for now */
+        build_append_int_noprefix(table_data, rqsc[i].controllerType, 1);
+        /*
+         * The AML code that generates that PPTT table uses the cache
+         * controller mmio_base address as the Cache ID.
+         *
+         * TODO: Similar plumbing still needs to be done to correlate
+         * the memory controller to Proximity Domain in the SRAT table
+         */
+        fprintf(stderr, "[QEMU] %s(): Controller %d: Resource ID 1 = 0x%lx\n",
+                __func__, i, rqsc[i].mmio_base);
+        /* Resource ID 1 DWORD 1 CacheID or Proximity Domain */
+        build_append_int_noprefix(table_data, rqsc[i].mmio_base, 4);
+        /* Resource ID 1 DWORD 2 Reserved */
+        build_append_int_noprefix(table_data, 0, 4);
+        /* Resrouce ID 2 */
+        build_append_int_noprefix(table_data, 0, 4);
+    }
+
+    acpi_table_end(linker, &table);
+}
+
 /*
  * ACPI spec, Revision 6.6
  * 5.2.37 RISC-V Hart Capabilities Table (RHCT)
@@ -894,6 +1012,9 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
         spcr_setup(tables_blob, tables->linker, s);
     }
 
+    acpi_add_table(table_offsets, tables_blob);
+    build_rqsc(tables_blob, tables->linker, s);
+
     acpi_add_table(table_offsets, tables_blob);
     {
         AcpiMcfgInfo mcfg = {
diff --git a/include/hw/riscv/cbqri.h b/include/hw/riscv/cbqri.h
index a07f1e3a2dde..227d4d2bd842 100644
--- a/include/hw/riscv/cbqri.h
+++ b/include/hw/riscv/cbqri.h
@@ -79,4 +79,16 @@ DeviceState *riscv_cbqri_cc_create(hwaddr addr,
 DeviceState *riscv_cbqri_bc_create(hwaddr addr,
                                    const RiscvCbqriBandwidthCaps *caps,
                                    const char *target_name);
+void example_soc_cbqri_init(void);
+
+typedef struct _RQSC {
+    u_int8_t controllerType;
+    u_int64_t mmio_base;
+    u_int16_t rcidCount;
+    u_int16_t mcidCount;
+} RQSC;
+
+void get_bc_details(DeviceState *ds, const char *type, RQSC *rqsc);
+void get_cc_details(DeviceState *ds, const char *type, RQSC *rqsc);
+
 #endif

-- 
2.43.0


