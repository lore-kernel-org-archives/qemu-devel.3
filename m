Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7F9CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhcC-0004ac-1g; Tue, 29 Sep 2026 19:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhc9-0004aK-Ed
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:52:01 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhc7-0007bv-1Q
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:52:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fS3+LI71B0s0uaekGDjbnItoo7WOSu3cGENifWJI6Nno6CxhkheF7ONnNQs6Ryv709d9xNqgekbFgjqE1A2Kt6/c8R0TanmuJCYDYUzA74FXnw2G0D2kMeGFNVCct6UlNojjPDKu72IoWdFxv0OayNSWmUGTEyGpX1HnqXpAGRWmJ5dxxLjVO2UViAsGmchDzqTxDtTzMCNfq6L1t/nI3lHT35Q+yEi7xnxej4Est0WsgktCsSVL1wzg8gPagJMybWb5mOBmDQVdbp9hTHfpnSYb98N3tVLye/2Qw0G1RoO5hH1WIXO2O2ubGdd8ajT2xqw3A7QNokM2fHbJTq7QNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMK0sSQeYcJ2SpZUHsUEOIHNVrbe+TOzK1ACkBFcx98=;
 b=fXHolTqqrHUL5PRfE6CBOQXpq+g0Qyrlk6HPzJbm1JkpZoaumDGKVLrbrX1g4xVjs8wvxWxNdlzzSnAY5EnzI8V2Y5LkQU6e6a3FzInQ88gByfTpjB4ZpzNC9Tbk1tvrCMMxpxgQaHnEv6H8mm/WkKm/B2NHqprvdxrbHQFNEiq4avXkLSEmUUcdG96+ekiM8Y56N0/5kevqzLYw5orQj1zuXrljtpNvtSLYqBnQQFPxy5nVV4k0nIerx3qzC13C7tadit3sBMrFDQFKvS2WcOQ1JK+pbT3My34ju/+jIsZP4Igm1WNU5aSRfP5LmTY1y1bWEvLjFcD6lqv5CNGsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMK0sSQeYcJ2SpZUHsUEOIHNVrbe+TOzK1ACkBFcx98=;
 b=XmGQfux3m8Lr9bJW7J2ubxBiPmYDaUWGD7SsRkeFNWVo1ZATZjSSL1E834hZcNMnKK3S7j8+iUL7TFJa3ZIc8CWJN3LMRUK/X/ro5JLbDG4gmG0vI1DVm+QOCATkMPz8NFi2LaltuDdx5uOgdqW+1D2TODLgC980irjM1r77C9o=
Received: from SJ0PR13CA0212.namprd13.prod.outlook.com (2603:10b6:a03:2c1::7)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 23:51:52 +0000
Received: from SJ1PEPF000037A2.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::35) by SJ0PR13CA0212.outlook.office365.com
 (2603:10b6:a03:2c1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 23:51:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A2.mail.protection.outlook.com (10.167.244.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 23:51:52 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 18:51:51 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <armbru@redhat.com>, <pankaj.gupta@amd.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v7 08/12] machine: Rename machine_require_guest_memfd() to
 *_private()
Date: Tue, 29 Sep 2026 18:50:14 -0500
Message-ID: <20260929235109.1398509-9-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929235109.1398509-1-michael.roth@amd.com>
References: <20260929235109.1398509-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A2:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 990ae0c0-54d5-4bbb-8097-08df1e84a293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 74JaJ7BYsj9gc/TWS0w3/JDdsjkI7VGBQGerO+mvRrzsQSXgP4sD54wHYE58Y8YpD67XN6XBMusjJMsgSdKxtKQG9IaIyIqtkMA5yOmkznXLiaVO7RNyvT87Kh4o9u5RNVzvyOMSU5iXW69WKY92dOX6Q1uSgsmGclqW8f0SDhixrl92/j1uXJ6zfW33IbVU6193L5kkwDI70MopzBfErtEXgKLVO65GhYlJ7dmfpM0zI/pq75EnyYjr7NtAr+MKNxwb/cRbZenhPIBU8snHBOW9R+mvH8TpDcdzrUAMR7gOZuaV9K7kerOSpRaAMJfQUCdidEiJh3vYBb4wl3gqxFU2YhUmyLF8r7jZ0f2LiauqtCIbdbwa74p97LXxGGLaHfIfR+KS+GcyXMeH1egDFA0XYp+G4V9v2BdX5G9GQwXrVBwDNj7tGRCibxCH7j+rJx3rcZo1iS3LmuH2mY/o7l3KmC1hK/IhNPD8u2v2+uUbt5OX1PR9IV3idGvsQ7h+s8AcNUmwPxyfAL8K4dQ9yoH4EC2Jq6s4C9v8i/73Y6eOPS2KGrLRhdKICgnZ2CkjcM1VO6llZbHhWt/nFp9YjVnGGmz0C7AjrAFlxdOFhM9BHZGn75LVJLBWkn0gK/lsAFX4BgLTyAgLJah10GiDRGBegDjDLiNgRVTOjQMnK9qVo8lounccTuVLUnVwKhN9+s40yQ2+ZpszcrXcwQ/eYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9n9YqmvUe7inbGitUbDuYWzfYtm69TZ4swiuwczPQqrs+5dd47yOGQbgFluapyPVNKrzNyC3Mwuz/O6CDorB8M4CYx9gjKMTcv3mrn73QILj4XTa7MxC57AXnlIR64b5GrdOvcC+3CRFdA5l1fts8Li6OioNicQgot23QaIiXeqR+O0ikYgvN7RB22hlylMUNiQbi6aD0IYLkFExBixBgT1NjAH2z+vw3jSviAg22t+a4JiCfdJVtr/ByxmsVTiIXmCDhiuEAw7wSdVTG0lE6O3BEZ+hlYs2QKRrnD3dG+cE9KdC+VloNn6vVCqEHnRZzQld7LvjYrtD/KPWoFGMfgEnDb4Zq155JGaRHUPszVt+p+LM0Arobe6utY0mJRmcSBdRv7o5EOti0ly8kgXo/d5bRkcAi51958kCjZlHuYW5ehef2mlecpWVcDCltRK6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:51:52.0715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 990ae0c0-54d5-4bbb-8097-08df1e84a293
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Michael.Roth@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Peter Xu <peterx@redhat.com>

Differentiate it from fully shared guest-memfd use cases.

When at it, add proper brackets in kvm_handle_hc_map_gpa_range()
otherwise checkpatch may complain.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 backends/hostmem.c       | 2 +-
 hw/core/machine.c        | 2 +-
 hw/i386/pc.c             | 2 +-
 hw/i386/pc_sysfw.c       | 4 ++--
 hw/i386/x86-common.c     | 4 ++--
 include/hw/core/boards.h | 2 +-
 target/i386/kvm/kvm.c    | 3 ++-
 7 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index a41540d50d..8782c8b1ea 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -290,7 +290,7 @@ static void host_memory_backend_init(Object *obj)
     /* TODO: convert access to globals to compat properties */
     backend->merge = machine_mem_merge(machine);
     backend->dump = machine_dump_guest_core(machine);
-    backend->guest_memfd_private = machine_require_guest_memfd(machine);
+    backend->guest_memfd_private = machine_require_guest_memfd_private(machine);
     backend->reserve = true;
     backend->prealloc_threads = machine->smp.cpus;
 }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 92f7be52a1..438624ece3 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1337,7 +1337,7 @@ bool machine_mem_merge(MachineState *machine)
     return machine->mem_merge;
 }
 
-bool machine_require_guest_memfd(MachineState *machine)
+bool machine_require_guest_memfd_private(MachineState *machine)
 {
     return machine->cgs && machine->cgs->require_guest_memfd;
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b649f184de..2fd90fa739 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -873,7 +873,7 @@ void pc_memory_init(PCMachineState *pcms,
 
     if (!is_tdx_vm()) {
         option_rom_mr = g_malloc(sizeof(*option_rom_mr));
-        if (machine_require_guest_memfd(machine)) {
+        if (machine_require_guest_memfd_private(machine)) {
             memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
                                             PC_ROM_SIZE, &error_fatal);
         } else {
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 441e777191..b6a56ef1fd 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -51,7 +51,7 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * KiB);
-    if (machine_require_guest_memfd(MACHINE(pcms))) {
+    if (machine_require_guest_memfd_private(MACHINE(pcms))) {
         memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
                                            isa_bios_size, &error_fatal);
     } else {
@@ -70,7 +70,7 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
            ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
            isa_bios_size);
 
-    if (!machine_require_guest_memfd(current_machine)) {
+    if (!machine_require_guest_memfd_private(current_machine)) {
         memory_region_set_readonly(isa_bios, true);
     }
 }
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index ae58352760..59e92b1a1b 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1036,7 +1036,7 @@ static void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
     ssize_t ret;
 
     /* BIOS load */
-    if (machine_require_guest_memfd(MACHINE(x86ms))) {
+    if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
         memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
                                            bios_size, &error_fatal);
         if (is_tdx_vm()) {
@@ -1106,7 +1106,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
     bios_size = get_bios_size(x86ms, bios_name, filename);
     load_bios_from_file(x86ms, bios_name, filename, bios_size, isapc_ram_fw);
 
-    if (!machine_require_guest_memfd(MACHINE(x86ms))) {
+    if (!machine_require_guest_memfd_private(MACHINE(x86ms))) {
         /* map the last 128KB of the BIOS in ISA space */
         x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
                           !isapc_ram_fw);
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 3b86724cf0..d0e4ad9820 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -43,7 +43,7 @@ bool machine_usb(MachineState *machine);
 int machine_phandle_start(MachineState *machine);
 bool machine_dump_guest_core(MachineState *machine);
 bool machine_mem_merge(MachineState *machine);
-bool machine_require_guest_memfd(MachineState *machine);
+bool machine_require_guest_memfd_private(MachineState *machine);
 HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
 void machine_set_cpu_numa_node(MachineState *machine,
                                const CpuInstanceProperties *props,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 1eeadb99ad..a72b6e6b74 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6488,8 +6488,9 @@ static int kvm_handle_hc_map_gpa_range(X86CPU *cpu, struct kvm_run *run)
     uint64_t gpa, size, attributes;
     int ret;
 
-    if (!machine_require_guest_memfd(current_machine))
+    if (!machine_require_guest_memfd_private(current_machine)) {
         return -EINVAL;
+    }
 
     gpa = run->hypercall.args[0];
     size = run->hypercall.args[1] * TARGET_PAGE_SIZE;
-- 
2.43.0


