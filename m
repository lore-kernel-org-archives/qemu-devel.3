Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEECCA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhd2-0004uk-Si; Tue, 29 Sep 2026 19:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhd0-0004uY-KL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:52:54 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhcy-0007dL-Ih
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:52:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajdjAxxCCLYiiUVfFQjiF65ntoZLJ0DjdeEnE4qekuWrQjvmDpK3Q69QqeQ3jfPha6I0tDBeFA9WpVk7AbidIDYVQyt8fQPWmSeQKSrJ/CPJ6nciJqQ52d7cthNC+CWFJS2F+GexrTLK7spuAZWE7e7DHnTq4l/zZgxT3orKlKkIxGMa6KJeFjbuLFcNcXFMe58Vm4uiMfRNQ0demem+Dpyg6FHOrj8+pxWTjG0EDQqKKaPMiwtJzQq0LKppFQCDKitK9Be7To3q/CTY6rkX+hKo4e3Jibr/wnZdQip33EZsZOwaVY/B6IIa1AB4uNqFJ/7TcLYSNq4g8pEpGNU23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BECacQwit5Mgcm4ZB2gEjUe7RJhqbuPwWcOYNchuMdQ=;
 b=hWXBvzYTzcb9sisR414gDCdF53qK1eix3l2OBQfuApu6ad1A8RY/Sp0JMz3rR2A59vViK0fGaQKU9H1QVl1bE/JvDciLa5xfpeTjo47emw6trS//r+d9x3b+J0QrTGuPO+16sk0n/mN5XPeTVlW/ul2n3GmKeHoZu/528Wod1rfQ39VZt0W1pqf5gpVQfuq9z+SHgvhhpeOmBbVil8VQtojwmofHSEZy2Hjf826tHfML74BP3//wMFMCuuFcVgo192ul2qoOGszNp8IKUPneB2wUOtq1UR41sngeiVxxzgxg9lGUPkGJR9F/Brix7SvUYynEgvgZc8cDm5JhHWXK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BECacQwit5Mgcm4ZB2gEjUe7RJhqbuPwWcOYNchuMdQ=;
 b=uQ2WvJf0Pj+kTh7jiXyPsly1b+s2LDx2wrd8Xf3L08SQL8s11u9JgN4Qa+daj+6JKNFbJD9Ax+tp/gLR5Nbo/e1fwWyf/kZEvnvXug7GrrbtZaIw1RIr2JkPYmVt3tELYdRvRDY28y3wM0U7i8fuWl4ssUK8p6J9LqEB+1wfPYw=
Received: from SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::11)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 29 Sep
 2026 23:52:44 +0000
Received: from SJ1PEPF000037A7.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::59) by SJ0P220CA0028.outlook.office365.com
 (2603:10b6:a03:41b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Tue,
 29 Sep 2026 23:52:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A7.mail.protection.outlook.com (10.167.244.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 23:52:43 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 18:52:42 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <armbru@redhat.com>, <pankaj.gupta@amd.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v7 09/12] memory: Rename memory_region_init_ram_guest_memfd()
 to *_private()
Date: Tue, 29 Sep 2026 18:50:15 -0500
Message-ID: <20260929235109.1398509-10-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A7:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: e85c209e-f644-481f-3d04-08df1e84c139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: LfzMgt8LkdHw/f/PTOyrg+eUNob76Y+Le/QX5Px2O/zpSeGY2yl27StjwfakcsrQbVZNRZ3xszv2LXg3cXVszx/HFHZ3G3d7xLfvlgEqnmNZTORBPw6z0YUkAo78G2YA6Ffzf1CAMvQ/S9xDUD+B5j/li5Yr4/nwY4baHe0TnQ9k0BgyL8ZW++J2Roj9k7PEpwGDJGeKgxapZlNAIXIri2brJARy8wQLI4vh0BjayTE9MmsjBYdsz/hDpHctyAFnATelVIEQMbQjOFzdOD90hh6MuqgtZh6DI7F+5xPgYaStmHLrL2Pbnp835vzHJ8V3bdgPyp98FfOp9uoLKRoQSrLojkBoExwk3oCAefEg1xL4rbqK4JZ/262fHiwU9l18yUyXrGN1Ap099Qzlhs2bPFuxde0VFuA5AQ7x0HJZeSvLlbVoNRsgr2uoCiI5kTr/r5Oi8f4slZEV0RnsQY1WToxSHTdamE1/3cki9+snfFaeJ43aMBeJYuaQopISHr2vk8m8vsY6xlLf+JCedqrD9DGzzGrZLU8Eyzo3vmaXn8Qg+/oQRuYPPRWSBAmCSp2hxhofu7W/t+T1dhKDxYEkWUBD7K9IHpIw04PX51oOr+30Myml2zzqkvWHcLijlEy3hfE37pDiSu6XOUE7jnhlN7Rl5Rw5ifIxKW738/aMLYN4d2cULPT+B0hTg8CxIilQ2bp8IFOdmqZfSaSZUaGjBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TEGf1tfDTx5EuSUOG0S4PZ8Cx7TWkFc5VU84ROeLGlZSvrL0/jyNjrZ6E9ptDh9uhzo5ltNURRIcFNA/VbMxBEtR3VYdm0CHWLAlfV6cSVeJ390NMwdmdp4F5onxmD1/HADLozahY/zznthZgs8OGw3wnNxBTL7ET03WDnClOyt7mceSGVYuf9RbK5kLUcGkaixQ/GcV0ba86++OkSHod/FJfrOaud+/NqNdn9HFw5NrWhNwIL2ZCAqroSjAF7croJeNxQBri4qsJb3RryeF+gwrYEizmIFFllLuFGD9BSmNqwmeCV/KL+8QnGMO4RoSPz1VtUtXIX4bDYW2s9UOkVPsJNItrnX9m1sYRUnttESLKgxW+LMYLjudiN/eGcGGA0/c89FQ5mqkoafGivQ7BMWCZA0W1F9W31PCFTYHNQovmTgul9XqVjyXxegrJyGo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:52:43.4903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e85c209e-f644-481f-3d04-08df1e84c139
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=Michael.Roth@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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


