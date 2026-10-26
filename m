Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAB5606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=ieZXiHY9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJbT-0002dP-J8; Mon, 26 Oct 2026 08:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHPM-0002nW-JI
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:54:26 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHPK-000820-CO
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1793008462; x=1824544462;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kLKxlm+BQ650xZa4ALIBpQz5RtaIkt0udZ+BW/aSd4Q=;
 b=ieZXiHY9W3Ys2WvPzahCrOgI0GJWHLr6HlMWis2fx6k7oUXLM6YjduGm
 6WiksBZJ9uVpHM83o8Z0scA3JJFub+4KFa1b43GcYzudyxBncu5wGdE7W
 WdHdhMh2+WMaVYIqMZD/rzf4xjrrv/2VRmooGF7Bx/S8YEvWccsO41uac
 k6d+WbCO2ypr92uhdhsGVC6nlXxQpsdJjS5oJ+SUKbMfIUpaN6UMcy4cQ
 aUjkXLlGK2jF4hijQ7oelJiWX5HZf+9EqC30TrjNBZ228dpp1VCs4Uf6O
 4qGGu1z5mYDKaoJfW3wACSFNGS9kCXDP5G/XtlNHv280inyzrmq5R+2zL w==;
X-CSE-ConnectionGUID: ihdYMzWRQmWamebMUIoS3Q==
X-CSE-MsgGUID: afVnxItOR32wjl1AnEGrPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="257684911"
X-IronPort-AV: E=Sophos;i="6.27,179,1786978800"; d="scan'208";a="257684911"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 18:54:20 +0900
Received: from az2nlsmgm1.o.css.fujitsu.com (unknown [10.150.26.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 3C7A442A327
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:54:20 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (unknown [10.128.233.114])
 by az2nlsmgm1.o.css.fujitsu.com (Postfix) with ESMTP id AA145C00218
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:54:19 +0000 (UTC)
Received: from tanjiro.soft.fujitsu.com (unknown [10.118.236.61])
 by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 742A3202EBDE;
 Mon, 26 Oct 2026 18:54:18 +0900 (JST)
To: qemu-devel@nongnu.org
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Wolski, Tomasz" <tomasz.wolski@fujitsu.com>, lizhijian@fujitsu.com,
 y-goto@fujitsu.com, yukiya.takaki@gmail.com
Subject: [PATCH RFC 7/7] add CXL Type 3 memory ranges to SRAT
Date: Mon, 26 Oct 2026 19:03:28 +0900
Message-ID: <fd860bd75ed2bacd39e052831baa012ba268bc57.1793003983.git.fj2110jc@fujitsu.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793003983.git.fj2110jc@fujitsu.com>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.139.130; envelope-from=fj2110jc@fujitsu.com;
 helo=esa5.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:14:57 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Yukiya Takaki <fj2110jc@fujitsu.com>
From:  Yukiya Takaki via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Linux, the kernel first checks E820_SOFT_RESERVED ranges, and when
multiple CXL Type 3 devices share a contiguous HPA range those ranges
tend to be merged into a single region. In that case, the CXL driver
cannot reliably initialize per‑device regions based on E820 alone.

To let the OS distinguish CXL Type 3 memory from normal RAM and associate
it with the “memory only” NUMA nodes created earlier, SRAT needs entries
for the host physical address ranges assigned to CXL Type 3 devices.

This patch adds a helper that walks CXL Type 3 devices, obtains their HPA
ranges via `ct3_type3_get_hpm_range()`, and emits SRAT memory affinity
entries using the NUMA node IDs stored on each device. This runs only when
CXL is enabled and `program_hdm_decoder` is set.

Signed-off-by: Yukiya Takaki <fj2110jc@fujitsu.com>
---
 hw/acpi/cxl_type3.c        | 30 ++++++++++++++++++++++++++++++
 hw/acpi/meson.build        |  1 +
 hw/i386/acpi-build.c       |  7 +++++++
 include/hw/mem/cxl_type3.h |  8 ++++++++
 4 files changed, 46 insertions(+)
 create mode 100644 hw/acpi/cxl_type3.c
 create mode 100644 include/hw/mem/cxl_type3.h

diff --git a/hw/acpi/cxl_type3.c b/hw/acpi/cxl_type3.c
new file mode 100644
index 0000000000..4cad270257
--- /dev/null
+++ b/hw/acpi/cxl_type3.c
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+
+#include "hw/acpi/aml-build.h"
+#include "hw/cxl/cxl_device.h"
+#include "hw/mem/cxl_type3.h"
+
+int cxl_type3_build_srat(Object *obj, void *opaque)
+{
+    GArray *table_data = opaque;
+    DeviceState *dev;
+    CXLType3Dev *c3d;
+    uint64_t addr, size;
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        return 0;
+    }
+    dev = DEVICE(obj);
+    c3d = CXL_TYPE3(dev);
+
+    if (!c3d->program_hdm_decoder) {
+        return 0;
+    }
+
+    ct3_type3_get_hpm_range(c3d, &addr, &size);
+
+    build_srat_memory(table_data, addr, size, c3d->node,
+                      MEM_AFFINITY_ENABLED | MEM_AFFINITY_HOTPLUGGABLE);
+    return 0;
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 09ad488a04..b1def538bd 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -13,6 +13,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_true: files('nvdimm.c'))
 stub_ss.add(files('acpi-nvdimm-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'))
+acpi_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
 stub_ss.add(files('cxl-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VMCLOCK', if_true: files('vmclock.c'))
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6d7308b4e4..2f607f3ec9 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -51,6 +51,7 @@
 #include "hw/rtc/mc146818rtc_regs.h"
 #include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
+#include "hw/mem/cxl_type3.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/mem/sp-mem.h"
 #include "system/numa.h"
@@ -1460,6 +1461,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     uint64_t mem_len, mem_base, next_base;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     X86MachineState *x86ms = X86_MACHINE(machine);
+    PCMachineState *pcms = PC_MACHINE(machine);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
     int nb_numa_nodes = machine->numa_state->num_nodes;
     NodeInfo *numa_info = machine->numa_state->nodes;
@@ -1584,6 +1586,11 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
         build_srat_device_memory(table_data, machine);
     }
 
+    if (pcms->cxl_devices_state.is_enabled) {
+        object_child_foreach_recursive(object_get_root(),
+                                       cxl_type3_build_srat, table_data);
+    }
+
     acpi_table_end(linker, &table);
 }
 
diff --git a/include/hw/mem/cxl_type3.h b/include/hw/mem/cxl_type3.h
new file mode 100644
index 0000000000..15a204d66a
--- /dev/null
+++ b/include/hw/mem/cxl_type3.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef QEMU_CXL_TYPE3_H
+#define QEMU_CXL_TYPE3_H
+
+int cxl_type3_build_srat(Object *obj, void *opaque);
+
+#endif
-- 
2.52.0


