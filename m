Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F68BC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrkN-0006qD-Lt; Wed, 20 Mar 2024 04:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrkB-0006ip-E0
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:56:21 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2414::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrk7-0002RU-U5
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:56:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeBlpNlXQxuvWvoIP0Lezk8qMm07hVp9Xomsrz22eHkeI+Jw/ncn46iPF8Z69L7uaK6vmQJs9X9hHO2o8Z9cku58s9GCCH/mFWzbV8Y4UfvBdKM8NOYvzb2D354nY+CRHQEclX9IWbnF2z2hA1mn9lmakCctCY8VOhH+rfn66a1ustPu0UvuDbbMVuo5zp0DT8/9Kw3x8xvKaeYZCLAyQgISuX7hg4Wwu5J4IOg9DeejBkfmxXNmrBhISDziaIPr/1lfV71MV6Ege8HD8sy5YlH1j16eHCJoh1C5G4O8Sp22zRPijrm6ADob9fRLjy6xobY/2Erkpco3RKPTT/alKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E/Kfm7FjVTHJdrRiizkTs8U/YQj6h39yD41y1O7YEY=;
 b=MonyoSvxha17UvF9fZoijSG9k9Hqsgd3sFj+8FaCmFxZ1qbNCHVxaO8bG/PnuIncfuySSIEWugr3WpehMa3LtX/0eDKqmfc6TFKu4dY1xsdfsYSub/Q8JaZKlsfRoW54JMr+/RtXy+GlYQ1vzA5CD76YFe0EuW3067p1sm3nNDnE44Q1VLDeemnZ+QUJzJILGlvnzDaPV1e/uMO5DKTgNUvRzlDQYf1hs2VlyRv/eLpPpFfxBYu+IwxSSfbBaEdYXiEMbFo96h4078ZiOAsJlLm+WDpBbXel6WR5xMrDOrgn6Q5bYpxPBPhfneKj+lO7zY8ueS0N2SZd2eCQ70YgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E/Kfm7FjVTHJdrRiizkTs8U/YQj6h39yD41y1O7YEY=;
 b=ALp8rBgC4zxEExXM2cKfpIJj1CX9AMpZkUw5hN3BYedy7uPRWkKM5fT/s+43wQdfKBvNSS+lya+RTy/nYTfgrjWb+jEIaYw6/pWHbVnvGtd3r9Cl+NUnQ0zWGP284rrQyvMI5gfhscf4ChoPTl/8UQ4fuNlDiqr0RZtX+ZuJGlc=
Received: from BYAPR07CA0032.namprd07.prod.outlook.com (2603:10b6:a02:bc::45)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 08:56:12 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::47) by BYAPR07CA0032.outlook.office365.com
 (2603:10b6:a02:bc::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 08:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:56:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:56:09 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 48/49] hw/i386/sev: Use guest_memfd for legacy ROMs
Date: Wed, 20 Mar 2024 03:39:44 -0500
Message-ID: <20240320083945.991426-49-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320083945.991426-1-michael.roth@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: a6bbff3f-3dc2-47bf-2ea7-08dc48bb97a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oP1IYz3RRSF70OF0Wt1opqwX+IbO53yRvmllQP8V6FOufCgL07I3iwo6iB+IPzw2/Q5gpIlpf2hNkAeLz8fJtzBUD7q2DRbvl47VUFzYDUODT7AGEiv+h+NcYI2RiJ9pz4KAAyke77QsYqpll8ISFBv8mM95um/S01gI+CTUTrsFSdfXiDI0h9QwLSPogwXeg1Gv4aXFP9wRCEov42oo/13i+3sXK8yZ9klHitUOBGnb1kuZ7RUbMLo7SfZLLRMkbpyneV+WBa5OqDoRDQuZMeQ8S+/LAwpsSyrq0Oxj04wY4eYb2H8lS8OfP5EMitlHqWEoqXdk2dOFPeWkv2BFbhvuzUD41dqh787CNDYu24ZlABqypyudNyD6JizAXX83rpx4cFoZGDWkzUDDRgYBIKFvB3qwBaAzelBlMq3EAKQmwO30CdxZAilXJr9VcG83axsTdlXBOmjdVLNvtvywFFA8sqaJi6yTQ6mP5sGrUN4/bEwbMCykwr34Aooa9z5rNrFLMBnetAAAQt7XASkf6MCrjoTx8AOjlzd+3pzkWDPGOYUg/zWRaYtmYOPSXHpR384wGzCPjuduQrZBit+bFQGLOafg39AaDg2rOi4Nc5SdFm/X+p5Uh03dlvLhApgyjTCmQTeBK79D96O5YPQtmKnj1rO25/C4mL6MpiupTtmHHzJzxmlFGfxsV24zJbHDmCzaQGKQbH5eqxZ5tia/66CClmE0R9sFuWyWCyee4LOILrHNjubjI1/NcXGk+wRc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:56:11.7274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bbff3f-3dc2-47bf-2ea7-08dc48bb97a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085
Received-SPF: permerror client-ip=2a01:111:f403:2414::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

TODO: make this SNP-specific if TDX disables legacy ROMs in general

Current SNP guest kernels will attempt to access these regions with
with C-bit set, so guest_memfd is needed to handle that. Otherwise,
kvm_convert_memory() will fail when the guest kernel tries to access it
and QEMU attempts to call KVM_SET_MEMORY_ATTRIBUTES to set these ranges
to private.

Whether guests should actually try to access ROM regions in this way (or
need to deal with legacy ROM regions at all), is a separate issue to be
addressed on kernel side, but current SNP guest kernels will exhibit
this behavior and so this handling is needed to allow QEMU to continue
running existing SNP guest kernels.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 hw/i386/pc.c       | 13 +++++++++----
 hw/i386/pc_sysfw.c | 13 ++++++++++---
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index feb7a93083..5feaeb43ee 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1011,10 +1011,15 @@ void pc_memory_init(PCMachineState *pcms,
     pc_system_firmware_init(pcms, rom_memory);
 
     option_rom_mr = g_malloc(sizeof(*option_rom_mr));
-    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
-                           &error_fatal);
-    if (pcmc->pci_enabled) {
-        memory_region_set_readonly(option_rom_mr, true);
+    if (machine_require_guest_memfd(machine)) {
+        memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
+                                           PC_ROM_SIZE, &error_fatal);
+    } else {
+        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
+                               &error_fatal);
+        if (pcmc->pci_enabled) {
+            memory_region_set_readonly(option_rom_mr, true);
+        }
     }
     memory_region_add_subregion_overlap(rom_memory,
                                         PC_ROM_MIN_VGA,
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 9dbb3f7337..850f86edd4 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -54,8 +54,13 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * KiB);
     isa_bios = g_malloc(sizeof(*isa_bios));
-    memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
-                           &error_fatal);
+    if (machine_require_guest_memfd(current_machine)) {
+        memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
+                                           isa_bios_size, &error_fatal);
+    } else {
+        memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
+                               &error_fatal);
+    }
     memory_region_add_subregion_overlap(rom_memory,
                                         0x100000 - isa_bios_size,
                                         isa_bios,
@@ -68,7 +73,9 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
            ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
            isa_bios_size);
 
-    memory_region_set_readonly(isa_bios, true);
+    if (!machine_require_guest_memfd(current_machine)) {
+        memory_region_set_readonly(isa_bios, true);
+    }
 }
 
 static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
-- 
2.25.1


