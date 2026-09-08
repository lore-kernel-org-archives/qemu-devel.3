Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C6FC79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3w1Y-0008Uv-25; Tue, 08 Sep 2026 09:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3w1W-0008Uj-Hg
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:38:06 -0400
Received: from mail-southcentralusazon11011063.outbound.protection.outlook.com
 ([40.93.194.63] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3w11-0007aL-RP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:38:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSa0dWOmD2MBwuo1uyAPgnzMIoQCY89DqwOz60NkVg+y0QPOgqKsDCzUEnPJXC6T33WEXRPBW1XwbDvVSqFFVVdQZ6R0NoUernm/mf0isqT+W5XP47cMEqvL7shA85DW5XE6juBLEcoYrerTEoJLtaJd2RYj8hTMrFyI6V2UjwNulbPo/PAxt1S6KOjtLNFgw95kJAdTfEp2YcJgCgVjHaxJbR4B7ikMJA/bl2aXp38ltki5z0Yo0hBD2u3YpQPVqQLumLm0eXZt2q3veTPfs5v7D0L9Lufs0p1On3sEvwr594CEZmViergdELhCF2fUS+ht1DcS1jT51M25zl1pOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNFIR1j7CWAvkxWBZt0h8hV2ibRbAQ9Ag0GZySiziN4=;
 b=TpWGiAVzp9G0cCdlLZdyYAJomHS0PGP88MTokZ97qNIGLLFu4v9fvGfRKlOpSvabm26E6eJoAKlZz7zLp9SBJAHfFOCfVEfi5sxDHuIaNPts82Gv53hBuyi8gLrUWI9RhPLREPwJLdSO9XZ1AMlwQ2y7T/uuLCL3TRO3tX2sMphJAcxyQjXYmnMu1ZklMNU044pJLL4HdDKsUWEn/PmKmdPa/aL67Ujuc9U0IGEFoI/RUmoKhPcstkOCcMo5s2WzsArDfR/lHkr07mEyppOskRquhs4B2uyKLuYwKIn3UlBnPFzoSQq4NwBToEGPmUmdUVbQO2CTor4366C6xYrDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNFIR1j7CWAvkxWBZt0h8hV2ibRbAQ9Ag0GZySiziN4=;
 b=iLlgdHfv2PAwnXNUuVlljqgM+qu4YFkPTfp1xgJs31vOxNpvDS4U+z95HtFP+//km8cJK8V3jlIAOmOhAhFLHftOofL9bgedAwbduMh9m3TtLpGbqDkdhlfZ1SgoQbbPtyhceTNe2cPkkCvC+PRbDD1glPTMdrSM12diuW1vvTo=
Received: from BN0PR04CA0078.namprd04.prod.outlook.com (2603:10b6:408:ea::23)
 by CY3PR12MB9702.namprd12.prod.outlook.com (2603:10b6:930:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:32:28 +0000
Received: from BN3PEPF00022BC2.namprd05.prod.outlook.com
 (2603:10b6:408:ea:cafe::44) by BN0PR04CA0078.outlook.office365.com
 (2603:10b6:408:ea::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 13:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC2.mail.protection.outlook.com (10.167.248.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:32:27 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 08:32:27 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, Peter Xu
 <peterx@redhat.com>
Subject: [PATCH v5 09/12] machine: Rename machine_require_guest_memfd() to
 *_private()
Date: Tue, 8 Sep 2026 08:30:59 -0500
Message-ID: <20260908133151.836685-10-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908133151.836685-1-michael.roth@amd.com>
References: <20260908133151.836685-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC2:EE_|CY3PR12MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: 691e1e09-4981-4dcd-66ed-08df0dada036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SZdV4hMA+Mrs9plyELOe68PPGlAbcWWGl/wXjU91RbAGp3muXxB4nbAR4cjgykxYwea0TujF75mSHXMON2bV3qzJ9AyrCYPXI+fB+vX006n89z1APVhEaQbVv3WoYCu3zhLIzluD00l9jVNoYpIUTnNt+5DHeVe+4F8eKelTZzWDV6HtS+bE4OCj6d+ByKParefS8z0gZeru4lRFoIZfK+lZlGukT9GfjWyKKqkwGydnOHoKHaVootPyNeVOME0mnKkBKbQgSrCdHBVYbih0DDLOA67Nivx1i11zaOfMkpDOO6XL8NL5LOajvEfUSXq4LmjmbkZv4CARMzyqSVRuAp2IA7KlkVnYy99Uusx+uE3hJ60pndbIv6GcEQn6wLS5SZynMSXTYyemx6k4g72raBuGsOchynliRl89tsWEDWP4K8WqssoxEiPRj9hoye/Ot1TzP6gYXTTsGDrdA+tVQ4PccdbkIYSDPVF+0xPIa17FTkryAuW81jPf+Z8jMA5BBAbLZ3KVDrgPq40tJMV9pBw++IKiuZvVRtRzwcxtyOEXRw6VsMpKaPd7QCIcUKo0Ruc8PeJaeYynkK74RNcwpKFSMxXr0BXRhC209ohCGTugZ8fvBrjGIQIbapswebRiWQi8ucG2v1zsJFg57PHIlPzUMZ88T7xi4gPMO6TDNbM6r0YQKd+oDQH2Xy+6QCMw86Hag6E3cl687ZsBbYzZXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A5DOXP0D0YH8MjBRr6JGHCUpWr7cVfteMBEdbzUNM+1a+u03gVYTVpRAsqmdm4jGOSV+wLzE6nz/E97N0SseEe2tDBBPMONOCCdFP7VYLVJjgDUdY0UYiZy+eJxoB5P3BzpFJHMZvPs9dA6jVMGu+/HGRkGWXwxyc+aYgBoBDdgfJqoPxUeFMny7zNoL/QlibPn6C4qrX0f82pnYTKjfKe9MPj75D2/6HUDtPb0X7S4+G3Fo2un4eKvk4GOeFXWaPbwU4Bcbxw2qH+BaF1T7N5Su/LIcUfcVLi2pv1RXi6GRlKgn7chQ02ps3ff+USnUY938GM2ZYMYBFYdS4B2+Zehsn5zT9ImvlxNEGraUpzmiIYl/UjtiMxT+IvdVPZiZpNU9idSEZX/x89T+vefa1HVQYzq80Kw79ZZ9tv9UVgKz/WX5pmagh9M76zjK6bqB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:32:27.7889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 691e1e09-4981-4dcd-66ed-08df0dada036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9702
Received-SPF: permerror client-ip=40.93.194.63;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Differenciate it from fully shared guest-memfd use cases.

When at it, add proper brackets in kvm_handle_hc_map_gpa_range() otherwise
checkpatch may complain.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
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
index d54d9091c3..0cc5adcd38 100644
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
index 8939ae1666..469033d6b3 100644
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
index e9e4fc262b..9c2d77e494 100644
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
index 1a41a5972b..4a7694c131 100644
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
index 8f9419e7d3..dd526c561c 100644
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
index a436d48c8e..7925f0451a 100644
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


