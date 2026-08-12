Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D89C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFSh-00087W-AV; Wed, 12 Aug 2026 16:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFSX-00086R-E3
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:21:59 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFSU-0006t7-TR
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:21:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJScoabUh0avuHqjtKObV4uS9N/ulnXQKvn1HFfx+4OMs2wiAKMsqnY0RsIqa2LeyfZ8sgBbhqlrO2sBvRUQzu2ndiKtTg2kdD7+JSJxqUNYF0K6k/TACAIuMBf2JWqmcSG1ym/q4URU48H85vZFm0HX/xNNVYAX9CuoPZgkMyAFiiyOj/ctgOQhZO7PP5BSTZHhaZzfNtIA3QAxH6wllGW1Dlo8a2Q7q6PjqKDEnl5Op9D4360VD/m9QGB4t/kqpZZaETqTQ+CgltJ+Yxjsrbsf/e4Rdq7FgKAPSCRYGBjLrsMXfDxAd0UWpYRrYSnMDRS5uqA6AodzxrTQ+I04bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alhX1xbsgSVHjgCQb6mHL8pw5rjWabpiNDVDQ6LGoHk=;
 b=Nqw1CdvjgfUGyz+9Hy+cHphc4o1vE82U1oWpyb4yjsJpv5xg7mwCZC+aQw7FXgQea89rtPgZbvtWCHUK/+sM3tXHFUH/8/2REqRDyB2JGxgo91bTaPe5dYruRhcOkUFbN/NMR5sELnWfNC1cUq9b62vSbFbA8KiMIsAdQ12on08d4MTG+6LcvYeaAQTF4eSVh0CdkL38aRlTqP7JGwoJSLIH7faGYOc8JPLddlWPKa6ddq0MQdp2AVveTYC6jni0F6pDTskCcUgW5pS3kMuD0UlYG74jGL4wBubTGiL5UgME1BNZ/u2FakX8zuzHlVnEohSSeZY8phqII4soZeP6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alhX1xbsgSVHjgCQb6mHL8pw5rjWabpiNDVDQ6LGoHk=;
 b=QUaQlZt1VOI9b4tleOB5cLO9VkgBB06Q+89sKb77nXytM7Ri2Ft9zSLwgHINI3EFGKOvP7dfDw7whPq7WjsK7kSjehFoD36v2f0qU9vZtAbAsg28iI1leLSD/ILBDpXyiGcwXIFVHN+lRoDdIYLlFWRpyDMx9B9bOASQ59TaZFA=
Received: from SJ0PR03CA0211.namprd03.prod.outlook.com (2603:10b6:a03:39f::6)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 20:21:42 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::86) by SJ0PR03CA0211.outlook.office365.com
 (2603:10b6:a03:39f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Wed,
 12 Aug 2026 20:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 20:21:42 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 15:21:41 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <jmarcin@redhat.com>, <david@kernel.org>, <pbonzini@redhat.com>,
 <chenyi.qiang@intel.com>, <peterx@redhat.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>
Subject: [PATCH v4 10/12] memory: Rename memory_region_init_ram_guest_memfd()
 to *_private()
Date: Wed, 12 Aug 2026 15:16:48 -0500
Message-ID: <20260812201938.198915-11-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f31b7bf-80e5-4fd0-eeb3-08def8af52b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: +cpJA2fDteGaSgWtG2PkDwyC5qBW93jhyoaesJnsydan5TC510qXgXsREW/gtbCwFDQOTQ8KDBrTalAXb1wjx9nPgw7n8BhQU4P8z2IIii7zNd1gfCgeudi0LdLe/nrWvaWPS/SzZEJ45eq6rrQCMCTj6Vwm+UAkl9qonV94u02E74BGAKelIc/tLwIoFOLAF1OO/ij2PnvqflQ5cTenzq9PjIsjf82gk/hyC0BC6Uw+BQg8+/Albx0oNgSFBQlo83jq1+kzjbkiqsHJBhLiiiOP7WV0Aj/qH/Uh+fVcbR8mhweMdLYbyrepzTZw+1DHqr0OZii79aFh99SPs1y0UcLFdApjTtgBzePldz2DOCzfo4MRUZeuHK5V8JZvovZ1JYcHdK1ne2Sr6PUcTn4e3YIULQgbHywuRaB5yg1o8BLNTiZjGnulxiOguR1At2yuTDhDm6dA/UbAFn7X4yFOZJHvEySVjGSiuz6YBXM+h+TO33C3OS6mZK82Zp6J5eR0bqJ/PENCLSVzt+1qxHkX3uLHMaGgdeHe9qz8RzqNeEGPVUrgWk8pQU6OdpZBJGfAB++q2Xflwvy6PwVNRhUD/8EzFEPUqW737yNCiBKv5LxSo0uiuMxAHtjq6kxN+e7TvV+4t/aERjsdRMB7LZ2yAhggGX2hyd6vxShPYtcOxwfZOqOVHEA5uC0x+bhjrYqSd1fOJ+5JKaNPrZSNfeLmUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gSzRD5+GXY+80SmhbGYfCPExdXI2mpqwU74Rmj0q9im3a0N/vLj7TJad9YJskgtvDebQXAw1fBj/1z94255fG1uIpnPClG5ovZeagblrQXk9ZqIqwhXSdNzLlfS23c7nQ6t0+NNLleTFYE/tjYAv6nxlVdsVmQ/nrhY0P14dI8jZoxsF87GIOOcrcw2Xb8S2oCjIzdRTHwM7DfocWZWBEWVNvETkH2Hidqn6GLQ5h/W37ILl2aF1cVcci77Qv1vZ5DktwdPd3WZSoYO2e9nsRhlrPKyF24FoyEE2uWoZ43i1ua2JfY4vbNXk/HvBM9CCXasbMTBsgt+LrTjNfly8paKpjt361qmrDvdHpI3145TZmEG0kuKWJlwQxyMZNsNEu2f8kaRKO6OUdjR18X5J2DjB70MGxXP9V8p6fpFcLm8tVF2U3FTrFloMVH+12/QR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:21:42.2527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f31b7bf-80e5-4fd0-eeb3-08def8af52b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Michael.Roth@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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
index 80e87fe602..87e6290f46 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -256,8 +256,8 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
         igvm_pages = g_new0(MemoryRegion, 1);
         if (ctx->machine_state->cgs &&
             ctx->machine_state->cgs->require_guest_memfd) {
-            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
-                                                    region_name, size, errp)) {
+            if (!memory_region_init_ram_guest_memfd_private(
+                    igvm_pages, NULL, region_name, size, errp)) {
                 g_free(igvm_pages);
                 return NULL;
             }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3ca8468c0f..b9537edb82 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -871,8 +871,8 @@ void pc_memory_init(PCMachineState *pcms,
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
index e3096699ba..d9ccb0142b 100644
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
index db52cfe90e..05b2943bcd 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3655,9 +3655,11 @@ bool memory_region_init_ram(MemoryRegion *mr, Object *owner,
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


