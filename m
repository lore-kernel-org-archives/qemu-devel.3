Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFD2C98318
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vGu-0004ef-TN; Thu, 24 Sep 2026 22:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vGs-0004eI-Px
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 22:02:42 -0400
Received: from mail-northcentralusazon11013013.outbound.protection.outlook.com
 ([40.107.201.13] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vGq-0006pc-Jf
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 22:02:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jr1YiR4nSYbQ+wzDLhPZIqk18Z5oBIjr5tGLcvjCYMeUNoY1ZkWgjI0zm8ncep/pFWe5Gt1PX5X3XPSwqIarcVyBcRqNRjzF7vZnWFFuLc1xOiHL9fjx1mqSTs1VhbFtkN23GOoKtlkApnS73/9XGZzTj05Evnz6K7GF/e1WU7YOKSxsrYkf5qn5DQo96OIeHG2dYacWj/RoACrYkJwUFmbV+zQ4s/FYQEK8M6zLfxY6EaG2o5bDk52JPgwWT94iPtNaMBVVnetzp5hLEoUm6Hq1Guvc9aCKbXWMQVyuC3/zeKCOe4/ix9jQqIG0Th1VLTDjjn2hFBHGzzCpoTrf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BECacQwit5Mgcm4ZB2gEjUe7RJhqbuPwWcOYNchuMdQ=;
 b=Ocdtbdm5riEvAmpiLnvc9NfU8HUZ7e2SdaP8SRjdxJCBh/d84BHAOraFVZBM0LJyZSWBqhJlSQ+2tGTH3VdbbZxBw8NkEQddUKV3FlxpAMDtQFS6u7NeLIWoKVZwycNPt++Q3fCMopmZnZeidYMY00Xbf86HpwWxju0v0xQpxsAAo2r2Qm+/jnZkyrO8hp2HW6Ft2VBNhX71NTOdx2xs3RfMBPMSOgmcIMoY+LiIaUw09Yw9Ez70WEhKFtgvhbPbQle9JnjaPwAqcYH5xNPS98d4Ex+q8gk+iQnmxknx7l6VkbBA7Y/M9A/R6pOfURGaQ3p9wNbwBPgBX+ueuliQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BECacQwit5Mgcm4ZB2gEjUe7RJhqbuPwWcOYNchuMdQ=;
 b=oCj9VBMIjr5A8Pixf+gfOWPeiWOiapv4NhmvQ/+/rOBTNPkUk7oTlsbA0b0rBEYq7UHOEVVIl489XwnjgU44wwuNm9VRXe5kRCtnrTrafIE9c9dWDjQFL/Jw2M6RGe88MbEVAl3FmpwxMptG3qZXpAiaB1Ez/SoL+3PnC3BGQtc=
Received: from MW4PR03CA0265.namprd03.prod.outlook.com (2603:10b6:303:b4::30)
 by DM4PR12MB6495.namprd12.prod.outlook.com (2603:10b6:8:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 01:57:33 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::22) by MW4PR03CA0265.outlook.office365.com
 (2603:10b6:303:b4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 25
 Sep 2026 01:57:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 01:57:32 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 20:57:31 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <david@kernel.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <xiaoyao.li@intel.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <chao.p.peng@linux.intel.com>
Subject: [PATCH v6 09/12] memory: Rename memory_region_init_ram_guest_memfd()
 to *_private()
Date: Thu, 24 Sep 2026 20:43:15 -0500
Message-ID: <20260925015700.1260501-10-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925015700.1260501-1-michael.roth@amd.com>
References: <20260925015700.1260501-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|DM4PR12MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: fe65c1e3-1173-4300-e695-08df1aa85d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VcPp59FG3GJqA+0GF5De79gGbHuGzALuI6rNsJD09c5qeWBay9xb71OQ9VbtsY+gMInSVSGchQ7FrQGhU64wctuR7D4Di5NtZhlmfvIFZ3vT5pr/vvtq+jjzOLoW2DnToEwG7E6vMwMuRbo/lnQZ7wshEUWeJDkneM1fH3B33xBtdX+yozFxIiOlw3/2170gR2a7nTM3CorazCbv7giufpcujkqbLsj5kSr2tWDyPzAfbFlANY6/U7WeS/XmM81f+QXQxhReaYFUQRz+psXiBy8aOhQd6oi4parO/mVLf4lV5I5SRoEELI5e+tsXA0AymZakLnRPBQOOZQcJcKgmw72bPTOFdA0gOcZ/ODgj8Ldigv4G7j/WVxUN6g6vTU7MtN/bK9/6KWETI8OEYAbkgkdiB+4Cl3OFHKTmanGcF63JpedIHRMwBiuI5/OOgxXO/IL19B6Is+8CuGPrlgIwgehiYPyaFnoXGMruNhDoa25BVVNOU8+24KTup/JAxSTjlEksVG34JrwjLyE6buLMFRI8An/YvOCB5w9QWRhQSSgiqRJm1bOWwumukmrXtNeW3gc4IHIKOaEXKkXI3HuOhgrhbdcRO1wg2QkUfhEEskKBQzD59S2erPwu4TzJe2Ep3roQZIZf8EnK6kAcnv2jl2oiUUBSifSSr67saQbWGIeDY/8caiPPvpX/Ljsqbu7nMfDGMJgU9tctBLanZeF6gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TwQNKRPiaK5qqO6B81YdVAjm5OjFy/taz9fx5eMKCkH5hFzFtCbC7EYRDyNdhG5Xb2hms9+8tg+pXWG2yFUVSgtTJgO37hosVLUCbQZkiA2f+dgacrJGTqR0qrGlv5dxnqNOXlM9kGb106bJPiJljXKIfxLNyF+iO5A7drwA5qwkXiac/kfxhOVFZdfErDslk+JTij/TotqaoTcUK7lISMLrrmK6mTnPHIH1aWNLDkNZiATB5vIVGbh8WXubfqj8eubq/Ye0ZMtli/JQjCmn8PFRtH042Emp+GDtHPYyR2GoqWg/euT9KFdASSikzq25SaKzcYYFBRi0mKtjPNdsOoEcNuKNzfEyLv6ZNJgQrlAI0PBxoMGyjvl3xua9yVInsi5jQnSX3VyKodFAVOgDtVOiNMs9bECLMczSIQ8tj0/R66SwYzxBgHHBwF11W9dq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 01:57:32.7407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe65c1e3-1173-4300-e695-08df1aa85d19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6495
Received-SPF: permerror client-ip=40.107.201.13;
 envelope-from=Michael.Roth@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
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
index ec7bee428b..58f3097e85 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -291,8 +291,8 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
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
index 2fd90fa739..1ae0c4f614 100644
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
index b6a56ef1fd..6ff0b9baae 100644
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
index 59e92b1a1b..fa18bf1aec 100644
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
index fa0a2cf563..f1910af8a0 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3592,9 +3592,11 @@ bool memory_region_init_ram(MemoryRegion *mr, Object *owner,
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


