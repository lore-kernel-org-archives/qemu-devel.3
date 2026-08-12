Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDF6C5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFSO-00084X-F2; Wed, 12 Aug 2026 16:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFSA-00083y-Cn
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:21:34 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFS8-0006lI-03
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:21:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqzC7eXla2GEnOoly9cIH45SblDrf62SEsyNgO4+rD1UAx5NaZEI7lO/GcdhZ1xI53/TwxEFaKxHcUSPREbafRoxXa19joTZgSO9wnT08vNRcJQ60kEFbjdLnzBXCzsnq3kgiI2ZbNeNKtQGL92SzFh8T60ZFvYn8vb0ow0m5lmQaQTYw3xJYfapylElfYIW8Ic8BwEe5o6rMbSw25wEcay+he/U+rbdDkAIEugH7JfAF5oA1kQZQH3St3R30jMKnGTr1it0vY6vitL/8e1FpYNE0xyRx9RE4CtgKz7lszHg1QJd0zQwskUI1+tIlFFw9PgKkm46SKvE9hSj092uxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIvMKMa4mrEaXXlYNoyPHklP5x+dihqoKea3OV5BfhY=;
 b=XwPmc3wCcWt7u3OCfMLCAI0jHEjgPo9Oaqm/ANStGJGrycEiwlIMQogG5PXYSeJt0DlWQ/BPpeCaj/HyQGqsLApw5SRT4eGnu2nFOVcKRpgbGtN5v8CQc/+HVkbigjiMFpXXzlhW0LfNE0herk/6Eiivl+SP2rY9Ta70U8ERLflQaY7W4P9sTLLsJvEi65AElgEQYEfHReKg/iXt01Yje9ok9HH9+dbF0hzsNPsktL5k04l/IhVZbiei5DZEGtRzqqlkJS6WwmGW188N6l9aC4zVRHKH/20SgGN+2xTD5fg71cvnyWTT31zD4X98GanTU2kPf0IG5afdd5ycSJ2mDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIvMKMa4mrEaXXlYNoyPHklP5x+dihqoKea3OV5BfhY=;
 b=imUK9caPcd1gsgaDbJOJmH0R3yaY0fsVOuYpywl6L4XEb6eTGUgfhQZHcH18dnkcVue02qK6UqV/cxsrHUIH7Ji9slBW3qEH9nxDaTsESUZaqkXSs6M12a7GQcRQxcSkt50Lm3MKZiatCohqoPi+b6Z6RrViXjw/jQScT/fWZNY=
Received: from SJ0PR03CA0111.namprd03.prod.outlook.com (2603:10b6:a03:333::26)
 by DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 20:21:22 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::4d) by SJ0PR03CA0111.outlook.office365.com
 (2603:10b6:a03:333::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Wed,
 12 Aug 2026 20:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 20:21:21 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 15:21:20 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <jmarcin@redhat.com>, <david@kernel.org>, <pbonzini@redhat.com>,
 <chenyi.qiang@intel.com>, <peterx@redhat.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>
Subject: [PATCH v4 09/12] machine: Rename machine_require_guest_memfd() to
 *_private()
Date: Wed, 12 Aug 2026 15:16:47 -0500
Message-ID: <20260812201938.198915-10-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812201938.198915-1-michael.roth@amd.com>
References: <20260812201938.198915-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: be92de22-208f-44c2-7968-08def8af465e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: H6oI53siTRFl0Irq/8M5E/GIHLEFjlxnQkoTECaWsZ4UY42EA9m+ep4m3bewSQaAy77EjfPK+Xdep/SVIJylvyDp1Y6/2li+YWZc3Pr9408qiOlnuWVGca0rSycZ+G6TPuh2KlvH7N2V6yGk10EUOXf4LaasqBtyid7G+FmL3rgCs2QtW70LEQBji657LPnyFXQJDDjWAKzY+0/PC9a4K3zCBdqLFzYKPUoat3JC715Q8ZKGc2hWkiM1uhuIvfbQ/QrfD2ZKB0wPjNc3Nw6nY2A32/Odp/cv1L6lZlBXLNEXvOPoikFbg4MV+6MyHPDkPOIz3zzH3Ky2UtqEFuO3TzSMf8MZ6a9Xbd+vODeS1KMVaj1ZRWAxigk7KtDTM8H4XmmZ51yAJOFsCorjPZgrwa6AN8IuwmMJfW3Xjpyj1PMo4I3VD8GGRT0gGmn4i6pu9DTyYz9UPwzDZ1tdDnD7DvPje6tZtL0os62AGOrHLfs7odqCnoA25YGKkYo8CaDh5aBc4hzeQDWzhrN7eyY6n6LoX0CxgV/Ph8lR6P7uDukoopRT38nzeBodUGoHF4Qa/4DuxsrhGl/p+QSPV4mbPsZGu3lOBZmnFMQAfMNIsc48U06WHJeXMJycgkBgv0Qh/o63wFRrYR62j5mdV8lkH4qEjbenhHlFPfQWoLLz1qnZwPwsuyiOMNABWWoG5q31nNDkOGTN0oXYeIzIZTTuvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: th9dn68WiB/cLR/oHCw3yc0mSbXzbGqEuIC43+5Maz0nAYpfzDnD/yg8l3NqGts87jmRj9H9gOtYgWJyQ2Jr9lNcKQbAijL0kYbnrWz0WXZv9TKmfcPoZrMjXXOvebdU+WbTfGuf0Md6BDkNHN2lgKwMXj+7ENTAqGAqvjheCjSx5y+C8CByqmE7plXnTWpGFWwhsvgru0GZIbfVZ0ORANXownBieFH50OTEfzq7/3aGG37Z1WPMUJWkMD5n8/acngVe6jh6QoDKWxIqWLzARalgUEEPNMVcOeuWth2oRmnPV4Guo+1tFxWrYS8XHbDZyC2MMDVU7APIDRVU7P2SsAAWjc/fCJZun8VVcefYx2tPgUKBXZrxDw3gxlrxxKw472fVVjvRM3MhM8jFPT0TwtnA4SbmRIcivSDkZjMzwRaC+4LO9TKYp4V4ONDpPvjl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:21:21.5385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be92de22-208f-44c2-7968-08def8af465e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=Michael.Roth@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 73b4d82b4a..b78e9c2135 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1330,7 +1330,7 @@ bool machine_mem_merge(MachineState *machine)
     return machine->mem_merge;
 }
 
-bool machine_require_guest_memfd(MachineState *machine)
+bool machine_require_guest_memfd_private(MachineState *machine)
 {
     return machine->cgs && machine->cgs->require_guest_memfd;
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f064aa2b3e..3ca8468c0f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -870,7 +870,7 @@ void pc_memory_init(PCMachineState *pcms,
 
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
index 29c68931d8..7c46db4dd9 100644
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
index 4272b6770c..176d65d44f 100644
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


