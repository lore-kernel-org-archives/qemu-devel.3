Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEEBE8305A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnAS5-000279-KX; Tue, 03 Feb 2026 02:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARw-00020e-I6; Tue, 03 Feb 2026 02:03:49 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vnARu-0003Dx-0h; Tue, 03 Feb 2026 02:03:48 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2DA7A444C7;
 Tue,  3 Feb 2026 07:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1138C2BC86;
 Tue,  3 Feb 2026 07:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770102217;
 bh=Nkr5nf9b7Y4A9IBCYQHm95/Po/azKwjoY+f4gLgHvqk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Mm/hMfPJLfZVNBLSnNrD2YZr4EPrVCKv2Oa1w1RYa4eR/F9c+i6Dv1vdiUVk0XmQy
 Ykymu20za64Iygmrq11g5F1P0y6TkcDQz9o9oQpT29DM7ASDC9VRf6JG0alhRWf0HJ
 wD0pUv3YFC+x/BAGjJlVMWHh6MDNnGqgrSrbibkOcHktFoE8gpXeEhUsH/QecGgO3O
 nGwHtGc4JLz90aavL7n/G/1KiAJ2AruVnAeQE9WFwrkTCabntvibUjRNQNDdfKyADp
 D3slJnnTJa122Sqps2JPdnmz9eE+eH5FCGBHDWTlPSO9awqGIKdYZ2Dcpsv5b/vQN7
 GNVFxFzPP7FVA==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 02 Feb 2026 23:01:19 -0800
Subject: [PATCH RFC 3/7] hw/riscv: virt-acpi-build: Generate PPTT table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-riscv-rqsc-v1-3-dcf448a3ed73@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3575; i=fustini@kernel.org;
 h=from:subject:message-id; bh=f01KlbLacT8ikueuCj8ojGDFWa6aTj7XhptcDLqYro0=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQ2zj12Y3/j532z1onsyTvaKljStOuEpcvcf2tWp9+fW
 7vN669dekcpC4MYF4OsmCLLpg95F5Z4hX5dMP/FNpg5rEwgQxi4OAVgIm9YGBmePDsg0/s+2aiV
 M8x5G4NfzM3Z1dYcijOCruU8cS/fdn46I8PxXQ11it5JGrNY/oj7bbLQLfg0NfOC9MqGFmnhXZX
 7V/AAAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Received-SPF: pass client-ip=172.234.252.31; envelope-from=fustini@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Sia Jee Heng <jeeheng.sia@starfivetech.com>

Generate the Processor Properties Topology Table (PPTT) with a
cache type 1 structure for RISC-V virtual machine. A 3-layer
cache topology is used.

Link: https://lore.kernel.org/all/20240129104039.117671-1-jeeheng.sia@starfivetech.com/
Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 hw/riscv/virt-acpi-build.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c            |  1 +
 2 files changed, 48 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 210b3f5fff98..5703b0827682 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -40,6 +40,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "system/reset.h"
+#include "qemu/units.h"
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
 #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
@@ -973,6 +974,48 @@ build_srat(GArray *table_data, BIOSLinker *linker, RISCVVirtState *vms)
     acpi_table_end(linker, &table);
 }
 
+static void pptt_setup(GArray *table_data, BIOSLinker *linker, MachineState *ms,
+                       const char *oem_id, const char *oem_table_id)
+{
+    CPUCaches default_cache_info = {
+        .l1d_cache = &(CPUCacheInfo) {
+            .type = DATA_CACHE,
+            .size = 64 * KiB,
+            .line_size = 64,
+            .associativity = 4,
+            .sets = 256,
+            .attributes = 0x02,
+        },
+        .l1i_cache = &(CPUCacheInfo) {
+            .type = INSTRUCTION_CACHE,
+            .size = 64 * KiB,
+            .line_size = 64,
+            .associativity = 4,
+            .sets = 256,
+            .attributes = 0x04,
+        },
+        .l2_cache = &(CPUCacheInfo) {
+            .type = UNIFIED_CACHE,
+            .size = 2048 * KiB,
+            .line_size = 64,
+            .associativity = 8,
+            .sets = 4096,
+            .attributes = 0x0a,
+        },
+        .l3_cache = &(CPUCacheInfo) {
+            .type = UNIFIED_CACHE,
+            .size = 4096 * KiB,
+            .line_size = 64,
+            .associativity = 8,
+            .sets = 8192,
+            .attributes = 0x0a,
+        },
+    };
+
+    build_pptt(table_data, linker, ms, oem_id, oem_table_id,
+               &default_cache_info);
+}
+
 static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
 {
     GArray *table_offsets;
@@ -1015,6 +1058,10 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_rqsc(tables_blob, tables->linker, s);
 
+    acpi_add_table(table_offsets, tables_blob);
+    pptt_setup(tables_blob, tables->linker, ms,
+               s->oem_id, s->oem_table_id);
+
     acpi_add_table(table_offsets, tables_blob);
     {
         AcpiMcfgInfo mcfg = {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 99871119be44..491328f7e192 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1929,6 +1929,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
     mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
     mc->numa_mem_supported = true;
+    mc->smp_props.clusters_supported = true;
     /* platform instead of architectural choice */
     mc->cpu_cluster_has_numa_boundary = true;
     mc->default_ram_id = "riscv_virt_board.ram";

-- 
2.43.0


