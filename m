Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05EF606A881
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYDiuW8A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xS0T8-0000Qe-PK; Fri, 13 Nov 2026 18:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xS0T5-0000Lq-DB; Fri, 13 Nov 2026 18:14:03 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1xS0T2-00027z-Ni; Fri, 13 Nov 2026 18:14:03 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 44E84623FC;
 Fri, 13 Nov 2026 23:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE701F000C5;
 Fri, 13 Nov 2026 23:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794611632;
 bh=taX31sIGuvqf5m/KG4d2PcGlzMGN1v3wG7kekRtE/V4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hYDiuW8AzaeF4HSsIvPxycV4QSR0K+du/CSBprLNgMcKt/9xY+L/ET1yMgt29Qnjw
 SbRYYjyj/ITavfvhCYi1OcyteCsn8aPU+ew2usMNKBa15UUI8xMgukD9qAzfYLwKww
 /tCDuy1mwo4Zx6PNLAFWBRi4E3glTrDDE6uXd3aMj3l+XpmwbqP54l8FvEXXmcrBw+
 BI4qyByazXfJOsk47I/j5hadFP8p4w3eoBkeGaIdlWKkpd4VYttsxl+9zRwJ/z+QsN
 cP+247LyF3TaA6xCb46gcdUOjfoLkKUZmlMzV32KaXlqAADv5A+c96eOQQB7CbdwO5
 BTtSOEDJmts0A==
From: Drew Fustini <fustini@kernel.org>
Date: Fri, 13 Nov 2026 15:12:40 -0800
Subject: [PATCH v2 2/2] hw/riscv: add support for ACPI RQSC table
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-riscv-rqsc-v2-2-34d47fa4141e@kernel.org>
References: <20261113-riscv-rqsc-v2-0-34d47fa4141e@kernel.org>
In-Reply-To: <20261113-riscv-rqsc-v2-0-34d47fa4141e@kernel.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Sunil V L <sunilvl@oss.qualcomm.com>, 
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Jinjie Ruan <2118537295@qq.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, 
 Drew Fustini <fustini@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=16109; i=fustini@kernel.org;
 h=from:subject:message-id; bh=fFrjZvdW3fBA21bmKhGQnQuRzi1HnGXQODhP+uwwXOM=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWR9n7kuKSph8wM9DhmxWju17Uu8Dzzd3NBwdMLL9Ze/y
 m4Ir9Ze2FHKwiDGxSArpsiy6UPehSVeoV8XzH+xDWYOKxPIEAYuTgGYyMd4RoYpvjxN0qpi7zwl
 L2T+vlaZl/As92OGjr4Oh3/ntnflVjeAKtw/fDg57dn5Y+y9XOktFSllb4tyd4bsf77b0M6O4/J
 GJgA=
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the ACPI RISC-V Quality of Service Controllers (RQSC) table for
the virt machine when CBQRI controllers are present. A capacity
controller is described by the PPTT Cache ID of the cache it backs and
a bandwidth controller by the SRAT proximity domain of its NUMA node.

Make RISCV_VIRT select RISCV_CBQRI as the table code calls into the
CBQRI devices.

Link: https://github.com/riscv-non-isa/riscv-rqsc/releases/tag/v1.0.0
Co-developed-by: Vasudevan Srinivasan <vasu@rivosinc.com>
Signed-off-by: Vasudevan Srinivasan <vasu@rivosinc.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 hw/riscv/Kconfig           |   2 +-
 hw/riscv/cbqri_bandwidth.c |  13 ++
 hw/riscv/cbqri_capacity.c  |  13 ++
 hw/riscv/virt-acpi-build.c | 298 ++++++++++++++++++++++++++++++++++++++++++++-
 include/hw/riscv/cbqri.h   |  20 +++
 5 files changed, 344 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 98bdebb4b814..47dda3e52d20 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -71,7 +71,7 @@ config RISCV_VIRT
     select PLATFORM_BUS
     select ACPI
     select ACPI_PCI
-    imply RISCV_CBQRI
+    select RISCV_CBQRI
 
 config RISCV_SERVER_PLATFORM_REF
     bool
diff --git a/hw/riscv/cbqri_bandwidth.c b/hw/riscv/cbqri_bandwidth.c
index 6c33d1738d27..c55709d662f2 100644
--- a/hw/riscv/cbqri_bandwidth.c
+++ b/hw/riscv/cbqri_bandwidth.c
@@ -760,4 +760,17 @@ DeviceState *riscv_cbqri_bc_create(hwaddr addr,
     return dev;
 }
 
+void riscv_cbqri_bc_get_details(DeviceState *ds, const char *type,
+                                RqscController *rqsc)
+{
+    if (strcmp(type, TYPE_RISCV_CBQRI_BC) == 0) {
+        RiscvCbqriBandwidthState *bcs = RISCV_CBQRI_BC(ds);
+        rqsc->type = RQSC_CONTROLLER_TYPE_BANDWIDTH;
+        rqsc->mmio_base = bcs->mmio_base;
+        rqsc->rcid_count = bcs->nb_rcids;
+        rqsc->mcid_count = bcs->nb_mcids;
+        rqsc->node = bcs->node;
+    }
+}
+
 type_init(riscv_cbqri_bc_register_types)
diff --git a/hw/riscv/cbqri_capacity.c b/hw/riscv/cbqri_capacity.c
index 1585cad1d073..3ebc8a1cc26d 100644
--- a/hw/riscv/cbqri_capacity.c
+++ b/hw/riscv/cbqri_capacity.c
@@ -776,4 +776,17 @@ DeviceState *riscv_cbqri_cc_create(hwaddr addr,
     return dev;
 }
 
+void riscv_cbqri_cc_get_details(DeviceState *ds, const char *type,
+                                RqscController *rqsc)
+{
+    if (strcmp(type, TYPE_RISCV_CBQRI_CC) == 0) {
+        RiscvCbqriCapacityState *ccs = RISCV_CBQRI_CC(ds);
+        rqsc->type = RQSC_CONTROLLER_TYPE_CAPACITY;
+        rqsc->mmio_base = ccs->mmio_base;
+        rqsc->rcid_count = ccs->nb_rcids;
+        rqsc->mcid_count = ccs->nb_mcids;
+        rqsc->cache_level = ccs->cache_level;
+    }
+}
+
 type_init(riscv_cbqri_cc_register_types)
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 8254f1294a72..c8a720eb568c 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -34,6 +34,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/numa.h"
+#include "hw/riscv/cbqri.h"
 #include "hw/virtio/virtio-acpi.h"
 #include "kvm/kvm_riscv.h"
 #include "migration/vmstate.h"
@@ -279,6 +280,295 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
 /* RHCT Node[N] starts at offset 56 */
 #define RHCT_NODE_ARRAY_OFFSET 56
 
+/*
+ * RISC-V Quality of Service Controllers (RQSC) table, v1.0
+ * https://github.com/riscv-non-isa/riscv-rqsc/releases/tag/v1.0.0
+ */
+
+/* RQSC Resource Type and Resource ID Type */
+#define RQSC_RESOURCE_TYPE_CACHE                0
+#define RQSC_RESOURCE_TYPE_MEMORY               1
+#define RQSC_RESOURCE_ID_TYPE_PROCESSOR_CACHE   0
+#define RQSC_RESOURCE_ID_TYPE_MEMORY_RANGE      1
+
+#define RQSC_MAX_CONTROLLERS                    10
+
+/* PPTT nodes start after the 36-byte table header */
+#define PPTT_NODE_ARRAY_OFFSET                  36
+/* PPTT revision 3 Cache Type Structure */
+#define PPTT_NODE_TYPE_CACHE                    1
+#define PPTT_CACHE_NODE_LEN                     28
+#define PPTT_CACHE_ID_OFFSET                    24
+
+static bool virt_has_cbqri(RISCVVirtState *vs)
+{
+    BusChild *kid;
+
+    if (!vs->platform_bus_dev) {
+        return false;
+    }
+
+    QTAILQ_FOREACH(kid, &vs->platform_bus_dev->parent_bus->children, sibling) {
+        const char *type = object_get_typename(OBJECT(kid->child));
+
+        if (!strcmp(type, TYPE_RISCV_CBQRI_BC) ||
+            !strcmp(type, TYPE_RISCV_CBQRI_CC)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static int rqsc_cmp_mmio_base(const void *a, const void *b)
+{
+    const RqscController *x = a, *y = b;
+
+    return x->mmio_base < y->mmio_base ? -1 : x->mmio_base > y->mmio_base;
+}
+
+static unsigned int gather_cbqri_details(RISCVVirtState *vs,
+                                         RqscController rqsc[])
+{
+    BusChild *kid;
+    unsigned int count = 0;
+
+    if (!vs->platform_bus_dev) {
+        return 0;
+    }
+
+    QTAILQ_FOREACH(kid, &vs->platform_bus_dev->parent_bus->children, sibling) {
+        const char *type = object_get_typename(OBJECT(kid->child));
+        bool is_bc = !strcmp(type, TYPE_RISCV_CBQRI_BC);
+        bool is_cc = !strcmp(type, TYPE_RISCV_CBQRI_CC);
+
+        if (!is_bc && !is_cc) {
+            continue;
+        }
+
+        if (count == RQSC_MAX_CONTROLLERS) {
+            error_setg(&error_fatal, "RQSC: more than %d CBQRI controllers",
+                       RQSC_MAX_CONTROLLERS);
+        }
+
+        if (is_bc) {
+            riscv_cbqri_bc_get_details(kid->child, type, &rqsc[count]);
+        } else {
+            riscv_cbqri_cc_get_details(kid->child, type, &rqsc[count]);
+        }
+        count++;
+    }
+
+    /*
+     * The bus lists its children newest first. Order the controllers by
+     * address so that the n-th capacity controller of a cache level is
+     * the one backing the n-th cache of that level.
+     */
+    qsort(rqsc, count, sizeof(*rqsc), rqsc_cmp_mmio_base);
+
+    return count;
+}
+
+/*
+ * Return the PPTT Cache ID of one unified cache of the given level. The
+ * topology containers that hold a cache of that level are counted from 0
+ * in possible_cpus order, and idx selects the container. build_pptt()
+ * derives the ID with PPTT_CACHE_ID() from the cache type and level plus
+ * the first CPU of the container, so walk possible_cpus the way it does.
+ * Return -1 when there is no such cache and store in num_caches how many
+ * caches of that level the topology has, 0 when no smp-cache option places
+ * that level.
+ */
+static int64_t rqsc_pptt_cache_id(MachineState *ms, unsigned int level,
+                                  unsigned int idx, unsigned int *num_caches)
+{
+    const CPUArchIdList *cpus = ms->possible_cpus;
+    int64_t socket_id = -1, cluster_id = -1, core_id = -1;
+    unsigned int n, found = 0;
+    CpuTopologyLevel topo;
+
+    *num_caches = 0;
+
+    switch (level) {
+    case 2:
+        topo = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2);
+        break;
+    case 3:
+        topo = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3);
+        break;
+    default:
+        return -1;
+    }
+
+    for (n = 0; n < cpus->len; n++) {
+        const CpuInstanceProperties *p = &cpus->cpus[n].props;
+        bool first;
+
+        switch (topo) {
+        case CPU_TOPOLOGY_LEVEL_SOCKET:
+            first = p->socket_id != socket_id;
+            break;
+        case CPU_TOPOLOGY_LEVEL_CLUSTER:
+            first = p->socket_id != socket_id || p->cluster_id != cluster_id;
+            break;
+        case CPU_TOPOLOGY_LEVEL_CORE:
+            first = p->socket_id != socket_id ||
+                    p->cluster_id != cluster_id || p->core_id != core_id;
+            break;
+        default:
+            return -1;
+        }
+
+        if (!first) {
+            continue;
+        }
+
+        socket_id = p->socket_id;
+        cluster_id = p->cluster_id;
+        core_id = p->core_id;
+
+        if (found++ == idx) {
+            return PPTT_CACHE_ID(UNIFIED_CACHE, level, n);
+        }
+    }
+
+    *num_caches = found;
+    return -1;
+}
+
+/*
+ * Whether the PPTT at pptt_start holds a Cache Type Structure with the
+ * given Cache ID. build_pptt() does not emit every cache level for every
+ * smp-cache layout, for example an L3 cache placed at core level.
+ */
+static bool rqsc_pptt_has_cache_id(GArray *table_data, unsigned int pptt_start,
+                                   uint32_t id)
+{
+    const uint8_t *pptt = (const uint8_t *)table_data->data + pptt_start;
+    uint32_t len = ldl_le_p(pptt + 4);
+    uint32_t off = PPTT_NODE_ARRAY_OFFSET;
+
+    while (off + PPTT_CACHE_NODE_LEN <= len) {
+        uint8_t node_len = pptt[off + 1];
+
+        if (pptt[off] == PPTT_NODE_TYPE_CACHE &&
+            node_len >= PPTT_CACHE_NODE_LEN &&
+            ldl_le_p(pptt + off + PPTT_CACHE_ID_OFFSET) == id) {
+            return true;
+        }
+        if (!node_len) {
+            break;
+        }
+        off += node_len;
+    }
+
+    return false;
+}
+
+static void build_rqsc(GArray *table_data, BIOSLinker *linker,
+                       RISCVVirtState *s, unsigned int pptt_start)
+{
+    MachineState *ms = MACHINE(s);
+    RqscController rqsc[RQSC_MAX_CONTROLLERS];
+    unsigned int num, i, nr_cc[4] = {};
+    AcpiTable table = { .sig = "RQSC", .rev = 1, .oem_id = s->oem_id,
+                        .oem_table_id = s->oem_table_id };
+
+    acpi_table_begin(&table, table_data);
+
+    num = gather_cbqri_details(s, rqsc);
+
+    /* Number of QoS Controllers */
+    build_append_int_noprefix(table_data, num, 4);
+
+    for (i = 0; i < num; i++) {
+        bool is_cc = rqsc[i].type == RQSC_CONTROLLER_TYPE_CAPACITY;
+        /* A Memory resource carries 8 bytes of Bandwidth per Block */
+        unsigned int res_len = is_cc ? 20 : 28;
+        uint8_t res_type, id_type;
+        int64_t id;
+
+        if (is_cc) {
+            unsigned int level = rqsc[i].cache_level;
+            unsigned int num_caches;
+
+            res_type = RQSC_RESOURCE_TYPE_CACHE;
+            id_type = RQSC_RESOURCE_ID_TYPE_PROCESSOR_CACHE;
+            id = rqsc_pptt_cache_id(ms, level, nr_cc[level]++, &num_caches);
+            if (id < 0 && !num_caches) {
+                error_setg(&error_fatal,
+                           "CBQRI capacity controller at 0x%" PRIx64
+                           " backs an L%u cache, but no smp-cache option"
+                           " places the L%u cache",
+                           rqsc[i].mmio_base, level, level);
+            } else if (id < 0) {
+                error_setg(&error_fatal,
+                           "CBQRI capacity controller at 0x%" PRIx64
+                           " is L%u controller %u, but the smp-cache"
+                           " topology has only %u L%u cache%s",
+                           rqsc[i].mmio_base, level, nr_cc[level] - 1,
+                           num_caches, level, num_caches == 1 ? "" : "s");
+            } else if (!rqsc_pptt_has_cache_id(table_data, pptt_start, id)) {
+                error_setg(&error_fatal,
+                           "CBQRI capacity controller at 0x%" PRIx64
+                           " backs an L%u cache, but the PPTT has no L%u"
+                           " cache with ID 0x%" PRIx64,
+                           rqsc[i].mmio_base, level, level, (uint64_t)id);
+            }
+        } else {
+            res_type = RQSC_RESOURCE_TYPE_MEMORY;
+            id_type = RQSC_RESOURCE_ID_TYPE_MEMORY_RANGE;
+            id = rqsc[i].node;
+        }
+
+        /* Controller Type */
+        build_append_int_noprefix(table_data, rqsc[i].type, 1);
+        /* Reserved */
+        build_append_int_noprefix(table_data, 0, 1);
+        /* Length */
+        build_append_int_noprefix(table_data, 24 + res_len, 2);
+        /* Register Interface Address */
+        build_append_gas(table_data,
+                AML_AS_SYSTEM_MEMORY,
+                0,
+                0,
+                4,
+                rqsc[i].mmio_base);
+        /* RCID Count */
+        build_append_int_noprefix(table_data, rqsc[i].rcid_count, 2);
+        /* MCID Count */
+        build_append_int_noprefix(table_data, rqsc[i].mcid_count, 2);
+        /* Controller Flags */
+        build_append_int_noprefix(table_data, 0, 2);
+        /* Number of Resources, one per controller */
+        build_append_int_noprefix(table_data, 1, 2);
+
+        /* Resource Structure */
+        /* Resource Type */
+        build_append_int_noprefix(table_data, res_type, 1);
+        /* Reserved */
+        build_append_int_noprefix(table_data, 0, 1);
+        /* Length of Resource Structure */
+        build_append_int_noprefix(table_data, res_len, 2);
+        /* Resource Flags */
+        build_append_int_noprefix(table_data, 0, 2);
+        /* Reserved */
+        build_append_int_noprefix(table_data, 0, 1);
+        /* Resource ID Type */
+        build_append_int_noprefix(table_data, id_type, 1);
+        /* Resource ID 1: PPTT Cache ID or SRAT Proximity Domain */
+        build_append_int_noprefix(table_data, id, 8);
+        /* Resource ID 2 */
+        build_append_int_noprefix(table_data, 0, 4);
+        if (!is_cc) {
+            /* Bandwidth per Block, 0 means not provided */
+            build_append_int_noprefix(table_data, 0, 8);
+        }
+    }
+
+    acpi_table_end(linker, &table);
+}
+
 /*
  * ACPI spec, Revision 6.6
  * 5.2.37 RISC-V Hart Capabilities Table (RHCT)
@@ -879,7 +1169,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, RISCVVirtState *vms)
 static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
 {
     GArray *table_offsets;
-    unsigned dsdt, xsdt;
+    unsigned dsdt, xsdt, pptt_start;
     GArray *tables_blob = tables->table_data;
     MachineState *ms = MACHINE(s);
     CPUCoreCaches caches[CPU_MAX_CACHES];
@@ -913,9 +1203,15 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
     }
 
     acpi_add_table(table_offsets, tables_blob);
+    pptt_start = tables_blob->len;
     build_pptt(tables_blob, tables->linker, ms, s->oem_id,
                s->oem_table_id, num_caches, caches);
 
+    if (virt_has_cbqri(s)) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_rqsc(tables_blob, tables->linker, s, pptt_start);
+    }
+
     acpi_add_table(table_offsets, tables_blob);
 
     if (ms->acpi_spcr_enabled) {
diff --git a/include/hw/riscv/cbqri.h b/include/hw/riscv/cbqri.h
index 10b64613599f..bb0b961b3a43 100644
--- a/include/hw/riscv/cbqri.h
+++ b/include/hw/riscv/cbqri.h
@@ -78,4 +78,24 @@ DeviceState *riscv_cbqri_cc_create(hwaddr addr,
                                    const RiscvCbqriCapacityCaps *caps);
 DeviceState *riscv_cbqri_bc_create(hwaddr addr,
                                    const RiscvCbqriBandwidthCaps *caps);
+
+/* RQSC QoS Controller Type */
+#define RQSC_CONTROLLER_TYPE_CAPACITY   0
+#define RQSC_CONTROLLER_TYPE_BANDWIDTH  1
+
+/* What the ACPI RQSC table reports about one CBQRI controller */
+typedef struct RqscController {
+    uint8_t type;           /* RQSC_CONTROLLER_TYPE_* */
+    uint64_t mmio_base;
+    uint16_t rcid_count;
+    uint16_t mcid_count;
+    uint8_t cache_level;    /* capacity controllers */
+    uint32_t node;          /* bandwidth controllers */
+} RqscController;
+
+void riscv_cbqri_bc_get_details(DeviceState *ds, const char *type,
+                                RqscController *rqsc);
+void riscv_cbqri_cc_get_details(DeviceState *ds, const char *type,
+                                RqscController *rqsc);
+
 #endif

-- 
2.43.0


