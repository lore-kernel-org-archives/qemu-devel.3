Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969B2C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vwg-0001id-8M; Tue, 08 Sep 2026 09:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vwe-0001iF-BD
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:33:04 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vwb-0005Sy-V1
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:33:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLJC4aQrvxPgrXyhbeZaKQ0QKZbZiqPf9wgrW3M5nV+kcUqDi8X8S33wIlxikMOvjLI2tF9MoxwcUW/PQAshvMmh25RqdBq1svfb3Yb7+c0c12QRH7umdVpNwAl8UvU5KQbN8BFkCFwHJTsj6SwJTOMMN+MvcZBom5nmkF0HhW1dJVgpjmIDb7omu1Y0GZL//xIwiM+rCkcMaLdK5p9QvuAX8tu/lmr8l4zv5YcuqoWZNun39OaPOgibx5/OBBPWMTyZtxED9iyNjZR5ebPRf7+QebBeBrJ2DFW4yF/+JoKMnUOiuc1+SSNuQteaiBw7/UTHN33Hhs9buuMGFXy9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n18q9NARWvNqXHIjFtVCkB0MIbImgO9OOwnPMbRshp4=;
 b=JRQid1Q+/mBRg46sswG7AsHMFLzvvcxo/5s0ybUVZNh0/CTSj/zQi3gTqDKchVZZ0tFsXAEVavS+WuaOFaaY5n44p9Va8kgGyZHsBBgdGvF3WtSMeWZoKSSW9YgEgYWt+Rf7rya39A/Smd6gaCnsn/X7ZZ2iA7xFm4K3kLKfOprRnEbp6gdqlx0pCIoJoZhy2/IpWUogjEXNmkta8cNd7l4unDtoImtmR/iz0kVXyOlTz5oe+V9+dnWFR+Ii+eTmrC9n5PjyKXBFp07lsDRU940MoHajuhn8ekwRSI9jCcPVh6VBxRsRAeJ9q0CXBB5rQNdWPSehIaxssRNX8aXAzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n18q9NARWvNqXHIjFtVCkB0MIbImgO9OOwnPMbRshp4=;
 b=Hgd25v/rR3Fa984FgrpyuhZZYzza6Jm5+Xv1IWwjuuDPD03QEIqqFrnk5isdjCIlIt8pqezSDOrimADdM4QoH+1uW20chSFgW2yiQdgYEIVO9yT3Dbaw0a75uFet/tCPwlm5yx1Ek6Lb65dQtOCKCaEitEN7ptNGg3d7zGnfdpo=
Received: from MN0P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::7)
 by DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 13:32:49 +0000
Received: from BN3PEPF00022BC7.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::6b) by MN0P220CA0008.outlook.office365.com
 (2603:10b6:208:52e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 13:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC7.mail.protection.outlook.com (10.167.248.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:32:48 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 08:32:48 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, Peter Xu
 <peterx@redhat.com>
Subject: [PATCH v5 10/12] memory: Rename memory_region_init_ram_guest_memfd()
 to *_private()
Date: Tue, 8 Sep 2026 08:31:00 -0500
Message-ID: <20260908133151.836685-11-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC7:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: b5290e3e-493e-44c5-f30f-08df0dadac80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0w7plO82MfR1Pvquzt93P5b1G117/tdI9lLhISdVtKHOTm3NBcwyykrkUmc+eu56NRXavuX1i+WNObTlT+EjKIJP6fVfawxodEFQwTjrIhSaKDu101RJ52z8Ik+NmJKfWcpz2NrueDpE7/vcmMkB0PLERMu7HP0yBmj41MEJXvmgeRFLJDTzaQsbhdBIaQvUmY/n2nt5TbSSPRxKyQa/NufjNm3a1u5vJbWT6PuXUypLmbkf8ey3gl+n3KC5O6XPH4BN3/m+L/ut7/6J2xjnfkfsdEozzGgkaFNbOU8+3XC/1iu9Y6+Wcq3YsW/8SVdS1acO4Pcdg8LFrV79NxgcB34krlMBF4NL0TgWOF+NRN4twNTj5ZMvhTwzL/zJNQdfgB5Z41AvOJu7HY1etdUWDmbK1nX9315ViAXMJxjQw/apzyTMp9OB4bfP/TwgivIu7k/aRtjzlNXX9zJLU8j72G9Fe4AFVRb5LqKDqyOU5QFuy+FshhFQSMqZ3GbhRd4aDRtl4D7UBJHMqiwFeUJvyxfISIi049bgZDT2dW3RRiR4paUrwMjXro6CjUHx9SkS9esgt/pob0KBiUGhUAaQpPPR+epJacEvPH8SAgAYI5Z7fBHuM5f4lot+wfWD3nTBWfM6WUZKCjndyCPveWQ1pSlUlVi3VdsWyXQqS7M+/BNuhs8Fx+LewWqI7NWCrTGYH7XwrR+3PeeRehTstsJPgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cf1UOBTS85Ou7wFCLIFAtwPGVvYy3FNbTgJqvVbr2marA4mj/EieY+VMstIYO5Pk8ekSjKuJ0IsSOHHOwWi7zTl4k20PKGrtcBkg8NABwB5qwZfzgK9mEQZ/GCszStyLuW59/lYqU+BPWP0bviiaYY1AaZtLQC8xbhRAtggLvFJ9mGyefd5poo2iAUEusBtC7JBuhOZG0bKD8Y9JC5IHyDeWW6DqbVVWqcWzkdnimUYef0qKO87FUBkwo7+2KcTR5UfLd98NzI5b3OmrvTLD2cgLPWDV78ssFnxLWt4K6gppeZJBM2dx4Wic9dClQ8vth3Tqkqx5/GV8vomBxwjKwOyxeyM8gPUroJeIfjIT6TAdE8e/ircIWU3r/FMrtYKb4K2AF/36LbA8juYPv85WF2LitbciHJjZp3rqjzukcbHvzvne7GcqbO7IJvygWDmP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:32:48.4109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5290e3e-493e-44c5-f30f-08df0dadac80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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

From: Peter Xu <peterx@redhat.com>

Differenciate it from fully shared guest-memfd use cases.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 backends/igvm.c         |  4 ++--
 hw/i386/pc.c            |  4 ++--
 hw/i386/pc_sysfw.c      |  4 ++--
 hw/i386/x86-common.c    |  4 ++--
 include/system/memory.h | 10 +++++-----
 system/memory.c         |  8 +++++---
 6 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 7b7bdc72b7..228d332f42 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -259,8 +259,8 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
         imr->mr = g_new0(MemoryRegion, 1);
         if (ctx->machine_state->cgs &&
             ctx->machine_state->cgs->require_guest_memfd) {
-            if (!memory_region_init_ram_guest_memfd(imr->mr, NULL,
-                                                    region_name, size, errp)) {
+            if (!memory_region_init_ram_guest_memfd_private(
+                    imr->mr, NULL, region_name, size, errp)) {
                 g_free(imr->mr);
                 g_free(imr);
                 return NULL;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9c2d77e494..1e5b23d7aa 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -874,8 +874,8 @@ void pc_memory_init(PCMachineState *pcms,
     if (!is_tdx_vm()) {
         option_rom_mr = g_malloc(sizeof(*option_rom_mr));
         if (machine_require_guest_memfd_private(machine)) {
-            memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
-                                            PC_ROM_SIZE, &error_fatal);
+            memory_region_init_ram_guest_memfd_private(
+                option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE, &error_fatal);
         } else {
             memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
                                 &error_fatal);
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 4a7694c131..3e0b9e1d28 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -52,8 +52,8 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * KiB);
     if (machine_require_guest_memfd_private(MACHINE(pcms))) {
-        memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
-                                           isa_bios_size, &error_fatal);
+        memory_region_init_ram_guest_memfd_private(
+            isa_bios, NULL, "isa-bios", isa_bios_size, &error_fatal);
     } else {
         memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
                                &error_fatal);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index dd526c561c..ffe9cc90b6 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -1037,8 +1037,8 @@ static void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
 
     /* BIOS load */
     if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
-        memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
-                                           bios_size, &error_fatal);
+        memory_region_init_ram_guest_memfd_private(
+            &x86ms->bios, NULL, "pc.bios", bios_size, &error_fatal);
         if (is_tdx_vm()) {
             tdx_set_tdvf_region(&x86ms->bios);
         }
diff --git a/include/system/memory.h b/include/system/memory.h
index 96ab920e7d..027ca81bd2 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1358,11 +1358,11 @@ bool memory_region_init_ram(MemoryRegion *mr,
                             uint64_t size,
                             Error **errp);
 
-bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
-                                        Object *owner,
-                                        const char *name,
-                                        uint64_t size,
-                                        Error **errp);
+bool memory_region_init_ram_guest_memfd_private(MemoryRegion *mr,
+                                                Object *owner,
+                                                const char *name,
+                                                uint64_t size,
+                                                Error **errp);
 
 /**
  * memory_region_init_rom: Initialize a ROM memory region.
diff --git a/system/memory.c b/system/memory.c
index b520cca1a0..b3b678617b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3617,9 +3617,11 @@ bool memory_region_init_ram(MemoryRegion *mr, Object *owner,
     return true;
 }
 
-bool memory_region_init_ram_guest_memfd(MemoryRegion *mr, Object *owner,
-                                        const char *name, uint64_t size,
-                                        Error **errp)
+bool memory_region_init_ram_guest_memfd_private(MemoryRegion *mr,
+                                                Object *owner,
+                                                const char *name,
+                                                uint64_t size,
+                                                Error **errp)
 {
     if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
                                                 RAM_GUEST_MEMFD_PRIVATE, errp)) {
-- 
2.43.0


