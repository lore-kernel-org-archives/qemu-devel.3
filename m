Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED42CC27C44
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdmR-00063g-02; Thu, 30 May 2024 07:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmO-00061G-6u
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:08 -0400
Received: from mail-bn8nam11on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2414::604]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmL-0001TL-FD
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ikt3GdTpKCAHiLx8ozTxSpnzsMz9XNQbQ+4HK2d/j3k/9w1g9hF3RK9KtTL5wXC9TabHNSmm46avRbaISWq1qNTqaXdvrXQtkB8JMWgUtg15f//aIo0wP3AlW/JOl3oeQrn1V8dzOE2CDKe1VgbnYdiVXin4VZsDCPuFkvztP15hIbygYU1NZsMIQgAEH9nTsUzbVij30Ir9ogTuVsgMgUppio1MDWLJ6yhmWIk/XgWpvL8z+1iz2PQHayW6v6HtG2cBFonM48gA6NH5SBcJ5dWd8msuyz+icG/vVD5HpqW+/NVpkL3511g5rYSRIQwuBOtI73gEhAfpm0G5fwJHCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6lss2Hg9OxWRNKdJdzyXq7LJ3ceSxLzrC+ts+YdeIg=;
 b=h6e1dYB9yJ26hSZV0KdYD3YKfJ0sTlFYKv4rRqKRRUytmYqk+grtUsN9sHv3ARaugnv0nVA2PVEqxjm7sbHE1YvgTItPpeFGzLMDSIgYZeIEkZwP3xvyLqxHmbTWED+VUfp5x1ygkKDn1CCbZUV/+KeNxtd8cZVTtdCEFg5RoBk30cXfEsbPOriBxT5c/6q7xV+L1FwCg1TNMgQRiAby4GiXEAkynE1mNpvQq9Ura1U0kTl5cU2jGpQrsWzmux+sClVjl7eJmS6741lglr5Ap1eP6ccQx2q3/lKnmneXbStntvvTxsUMw5JObg5M1350ir5la34PFRW47p7GB9wcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6lss2Hg9OxWRNKdJdzyXq7LJ3ceSxLzrC+ts+YdeIg=;
 b=BmpF6A2WbnA1Chavg1NueMcHYoYAeJ6CMxnMXlgExfuRvBH7Gp1uWBO+PiKJlmOb7cfNV4VF1JYH0iWLsklAhtQbMjheyfUuYi5Hz6ve+i8Zb/0KJyYzVZSHPvN7iMKU+GluXKaFcuS5dHqqgo33h7I0Iquiur3hBlnvcNguLlg=
Received: from BN9PR03CA0761.namprd03.prod.outlook.com (2603:10b6:408:13a::16)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 11:17:02 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::e5) by BN9PR03CA0761.outlook.office365.com
 (2603:10b6:408:13a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Thu, 30 May 2024 11:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 11:17:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:17:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:17:01 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 30 May 2024 06:17:00 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <thomas.lendacky@amd.com>, <isaku.yamahata@intel.com>, <berrange@redhat.com>, 
 <kvm@vger.kernel.org>, <anisinha@redhat.com>, <pankaj.gupta@amd.com>
Subject: [PATCH v4 27/31] hw/i386/sev: Use guest_memfd for legacy ROMs
Date: Thu, 30 May 2024 06:16:39 -0500
Message-ID: <20240530111643.1091816-28-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530111643.1091816-1-pankaj.gupta@amd.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: pankaj.gupta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e5f545-cf03-45b9-6b2b-08dc809a0779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xMzsJqpZD+6+QHzbhcTR4Lhfd7l5Xvs2UObFprFDgpH4Pjs2qBLLOgv3m0rk?=
 =?us-ascii?Q?5bY7BKtl8+vVqBsS87oxHjw8LSjbRzFAR/1gagc5QZftN84bZeLtaN+/kpHQ?=
 =?us-ascii?Q?067C0TQ91Px5RCrDmUoi+I8migWgF33fV7IGUOpxX855c6yWKwhJI0Yrwyww?=
 =?us-ascii?Q?ctKhtyLLbMtamwU8bXtLwhsuNCbzURGyQtZOz6TpAi0zHt168CWp7hWgqTpi?=
 =?us-ascii?Q?At4tXgTaWvyA460zeInOw2unp9NbXtbCCy4KcjKzGRGkGEZXhmIm5GFDdp6U?=
 =?us-ascii?Q?BfKyidWpHBS4HnoBcRr34mqR0R3vr0EPYaVzuXRpemM/n+rZmhwvgs1yk5MJ?=
 =?us-ascii?Q?RpXble2+vfxX9luAVXpvhltWhK//86XMN0U3VL/G6TfRXBfR1y5FDnl0aMM7?=
 =?us-ascii?Q?tipMmhoKVZhdWQJndm/Mm36A0C1TZpOC0Y1StM8274EkWPyhbOggo3UKdKVP?=
 =?us-ascii?Q?sEVOPOqdRe7n94whYcBU7nrgEzGdtDOQkmOz2JBO52Rjx8D5eZCCbGgafSFV?=
 =?us-ascii?Q?6tiin/GtwygmgqaZ/SaX9cEFoLzT9DnoHQIlB/39qyEtk+A8qYgFzXRBU6v0?=
 =?us-ascii?Q?EYCUS6doVFzhgjj6nDxz/0d1kxsi/jbREoj4DOVZeObw592QlQcks+VdTvXK?=
 =?us-ascii?Q?rJUmuyhQ+hGo/f7oFz/ByU6SnbPcwGsQAgJ+K8Dm5sIwqkqpJEAhhFrkAO/8?=
 =?us-ascii?Q?LgoQxgCWdiWGT1/6yZN6hxi0LTDx0Tkn9I1O9mohqntCdxaaVvYsBYAWFCBH?=
 =?us-ascii?Q?rztYBTz24UViquOg+gFa2F+RwE46eMDO3Vy+Ut6TyFtE3/8rRwjPO+qk/TQj?=
 =?us-ascii?Q?mBxzy1RfSjOgv2p8OaIW6haXPSIrvE86JflD0WqkZ3QOfti4SE05G1kUGj13?=
 =?us-ascii?Q?pcYnFHMCYQvvt2tDT5MP7zu4tey2Ps2meSV2JwAHlwlBJMK4E+RZldYQ7TNe?=
 =?us-ascii?Q?eWeRarFoZ8A/IyOvfcV1rmv++wnOCuJLHd0a6kcfLSmNHa3M2m8RzbkxTJk3?=
 =?us-ascii?Q?St9ZQa1t+RG9+fWjTZW8o2rGw4ps5q/3b5YbJV9WMaKa6kXFRsC5BGunlkTM?=
 =?us-ascii?Q?Xs14mTIwC2IZvAmSvbFGd0W7wHbMawYd8P6WDGmBUX+FckwbkNLU6t7IC7UH?=
 =?us-ascii?Q?wpabIWqWdrH8q1cWn9PVousubikagn/3KHil13HmpDRGE9goaw7eGhJjI8eL?=
 =?us-ascii?Q?vAUv+Ih2x8pZ05fzDE28K7TD8MA3SU5BVhzMZZ6XSSELrwm/EL2XbofF1ePa?=
 =?us-ascii?Q?f8amRshFGnrcJYBYplXSXWVFn9LKBfaJ9TOJRUtqA5xcF2yx7OOoyxDFva4i?=
 =?us-ascii?Q?Orb3swIFepsd39OtEQgTY1vMfx9hdlMXhdpRtgO/m6ImFlCVxU6HUB3lb8mE?=
 =?us-ascii?Q?j/5kl1EkhJp0PcN/hFQ6+EkujIHh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 11:17:01.8015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e5f545-cf03-45b9-6b2b-08dc809a0779
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934
Received-SPF: permerror client-ip=2a01:111:f403:2414::604;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

From: Michael Roth <michael.roth@amd.com>

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
[pankaj: Added sev_snp_enabled() check]
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 hw/i386/pc.c       | 14 ++++++++++----
 hw/i386/pc_sysfw.c | 13 ++++++++++---
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7b638da7aa..62c25ea1e9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -62,6 +62,7 @@
 #include "hw/mem/memory-device.h"
 #include "e820_memory_layout.h"
 #include "trace.h"
+#include "sev.h"
 #include CONFIG_DEVICES
 
 #ifdef CONFIG_XEN_EMU
@@ -1022,10 +1023,15 @@ void pc_memory_init(PCMachineState *pcms,
     pc_system_firmware_init(pcms, rom_memory);
 
     option_rom_mr = g_malloc(sizeof(*option_rom_mr));
-    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
-                           &error_fatal);
-    if (pcmc->pci_enabled) {
-        memory_region_set_readonly(option_rom_mr, true);
+    if (sev_snp_enabled()) {
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
index 00464afcb4..def77a442d 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -51,8 +51,13 @@ static void pc_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *rom_memory,
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * KiB);
-    memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
-                           &error_fatal);
+    if (sev_snp_enabled()) {
+        memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
+                                           isa_bios_size, &error_fatal);
+    } else {
+        memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
+                               &error_fatal);
+    }
     memory_region_add_subregion_overlap(rom_memory,
                                         0x100000 - isa_bios_size,
                                         isa_bios,
@@ -65,7 +70,9 @@ static void pc_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *rom_memory,
            ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
            isa_bios_size);
 
-    memory_region_set_readonly(isa_bios, true);
+    if (!machine_require_guest_memfd(current_machine)) {
+        memory_region_set_readonly(isa_bios, true);
+    }
 }
 
 static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
-- 
2.34.1


