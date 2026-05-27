Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443C0CD6E45
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMor-0007O4-96; Wed, 27 May 2026 18:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSMon-0007Ne-9o
 for qemu-devel@nongnu.org; Wed, 27 May 2026 18:33:41 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSMoj-000063-Qd
 for qemu-devel@nongnu.org; Wed, 27 May 2026 18:33:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huJunUiyZ2SnbCXurojc0MtHp72EXAO41TvKt4HVCOITJ8JnNHDptaTVBRIG64B0GIBzDIf5OhUPG6SaxTSkIO47fylFZyh/QCdaxVRELDMX8SmHg7ekbDQ2BfnngHOi8cAbSkcEqGzO/IQUs/x8NRlt4gx0NuhBatNN0OFF1A4UW9RReRpUrb9+5xHq05nu9aklplG3vnDbInPLffowgJdIDYbIQTgZb1YdZdTRaA2rcY/o2Fp3kK4HWFzCTq71Rr4JuV5SWB3OjdTOSfWV0FHK2ImYq+gg1vmGQ0aMl48Rf01rtlK+CwX3uh+PgBzNDpnX1vzwqB1A8d4ho8JBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Sv8ro5aoDR/R26arscjZRg3DmMdkac/V5TGynVGHjI=;
 b=D/tR64b5+QpmC6oDTE1ht5BAjBw6oDMEFQEpA0tRJqJirvv3AeI0hmTjc02gkuuaK9NI7yNtlc+Bfc45m/sqYQYQ+SpFJXUyLNMeneRbvhlSAG60I/xtIDOF5CHXcMxnU+51Mmx7wSAC7cuQHmST7DTFFN2Gj9fGjdUky4TAC61v0tjuSxR7BopEeqOY0a2gEMwPXEBZDIjq+BWr89aRaxX2y+ZxPmhP21bpHyMlMJBGho/qN+5qQyQV0eGUjvwDaQhfUKe6Nu/y2c8/xMmudg9wUYUB7AoGQT9ouoT+Byh++pPDrYCjujDsN518gIEAuMXcFSpBNbCFyJLVVsfiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Sv8ro5aoDR/R26arscjZRg3DmMdkac/V5TGynVGHjI=;
 b=UC+M6L6/qedTXnDmMDSXlKu0DoCRstWHVm8rd4/prUMgbpi17TFAg+8yFi5p3MxjHq/7+3SVuAq53mKgtj+UhNWbzPh8/nnQxd5+jDU23Q2Tis2VEJhRkgwSEWZ0LLnCtGaAxi8YmjtduLudEls9LVhGZiaUNp3Kozl1V4loKh0=
Received: from BYAPR21CA0009.namprd21.prod.outlook.com (2603:10b6:a03:114::19)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 22:33:21 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::7c) by BYAPR21CA0009.outlook.office365.com
 (2603:10b6:a03:114::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Wed, 27
 May 2026 22:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 22:33:20 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 17:33:20 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>
Subject: [PATCH v1 1/4] accel/kvm: Add helper for handling conversions of MMIO
 holes
Date: Wed, 27 May 2026 17:28:24 -0500
Message-ID: <20260527223036.4614-2-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527223036.4614-1-michael.roth@amd.com>
References: <20260527223036.4614-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: a43d4964-19a7-464d-1aac-08debc3ff4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: eWds9xAueLas9CjGAX3jH9HAPhBK4TZOko9UdBcynshevL2wY1iarbPKIMWMTE4W41Kq4wIulgLerQUUIED+EZiKOt6tvjFlelGtta3ubfm53BJDzsinpHJgBi39Sx02yQ1N08hM7sxOg5Dt0Je/13rqDh7mx7Uj//JGJ7MgvoruepOTAf4lj4eKOC1oVniYMTSNCwWpSc4JX1LWzfILBlEtQLLEp1NL3vppZHJQsZX46P0VhGl0F3jk3IhGIWkSp5xYY5h5iFYip6mv9qCCXqWP8hC4jZyzOnowIhFuWI09Dn145GN0AgVf4WtT4yrC1lTnxXgaORFvLjmO0iMarDftI6FauSnL8I2ZRtUTZEWS4QkebVH34GMx2lkxoE//fHDP5Ck2nQ4oyiaac7g6t+Acepk97VDvngoMOMwNYVH9IEk4taAC8tLpb9MFsN1dkM5cpRUylLsEuLDH5bKIvVn1BWUzNZGfcB9t78AEue2+GSGAZpXMoT0gVLF1Z6nTXYFY2sLPGV3a8G/IUK7U+nT+MC79+8FNBZMrvALTk0xkn6cSWrL11UxIJwIqzslTc6cjWUtfR8/6a8/oddMxzsKgL5eita/BmnnzRQvlP0zUQ2UJSnR+CmC5l316vm5JknC/a+vmW2KiNHv/b5Mi4q1lkHGYcvO2vM5ZiqX5gsG5Msq+dy4hKUambnEnMb2tEncSvT2bh4wlm+3+86rSuKmExzKQwuaIzPKS2czjw+g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cYPbsgV83Uqf65zMDA40piEqEKOjSs+vw46D03MTgwa9il8KnwpWHWbqThrfX1WaJ7A6koIQbrntf4dk17Pe5WHi6yCqf9irR0BKS+fSj8JVzrynotvWB/RDB4JlG71yk+3x1eVfMSZiVFz1XVx+y3twTzmBefpTxP/sUK1hKOvfHmZE4NO91tEeKo7U6Ck+VmucG4QEM4VrLSl678/PcK9Y53sZmFtdP36xuPJT4TTwhJENlZuWw5vJ38JGd9KeDEECoFvITTwtVeG0NL+sCy9qKCwne2Qk64kt8GUCCxiiX9xOZFDARP1AuLFmTDwmoegXKIEvrsaHhXJ+zwCzczQF0AvZ7wP1K7yFvU0/+SAJonUffmqzEOf00PLT1citNBBWRc56Xw7RwF37FLMpTBAZO6citUjy7Irk2+hXE5ia4Zmqa1QeALmA8QnyUoXK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:33:20.7683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43d4964-19a7-464d-1aac-08debc3ff4c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Michael.Roth@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

When converting GPA ranges containing MMIO holes, the general intended
logic is to skip MMIO ranges as long as it is a private->shared
conversion, and to fail otherwise.

To better enable some future refactorings to address bugs in the current
code, go ahead and consolidate all of the MMIO handling to a
self-contained helper.

The only intended functional change is that the error message for
shared->private conversion of MMIO ranges corresponding to a
non-RAM/non-ROM region now report the range of the region that
specifically caused the failure, as opposed to reporting the entire
conversion range.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 96 ++++++++++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 32 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 96f90ebb24..24117b4634 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3339,6 +3339,67 @@ static void kvm_eat_signals(CPUState *cpu)
     } while (sigismember(&chkset, SIG_IPI));
 }
 
+/*
+ * This handles checking whether a conversion overlaps with any holes in
+ * the given section/range, and indicates whether or not the section/range
+ * can be safely skipped (which is generally allowed as long as the
+ * conversion is private->shared and not the other way around).
+ *
+ * Returns 0 if section is normal guest-memfd-backed memory, or is a hole or
+ * non-RAM/ROM region that should be skipped as MMIO. In the latter case, the
+ * 'skip' parameter will be set. Returns < 0 if the conversion request is not
+ * valid.
+ */
+static int handle_memory_hole(MemoryRegionSection *section, bool to_private,
+                              bool *skip)
+{
+    MemoryRegion *mr = section->mr;
+
+    if (!mr) {
+        /*
+         * TDX requires vMMIO region to be shared to inject #VE to guest.
+         * OVMF issues conservatively MapGPA(shared) on 32bit PCI MMIO
+         * region, and vIO-APIC 0xFEC00000 4K page.
+         * OVMF assigns 32bit PCI MMIO region to
+         * [top of low memory: typically 2GB=0xC000000,  0xFC00000)
+         *
+         * If the current lookup failed to find any regions, then skip the
+         * entire remaining range as a hole/MMIO.
+         */
+        if (!to_private) {
+            *skip = true;
+            return 0;
+        }
+        return -EINVAL;
+    }
+
+    /*
+     * Because vMMIO region must be shared, guest TD may convert vMMIO
+     * region to shared explicitly.  Don't complain such case.  See
+     * memory_region_type() for checking if the region is MMIO region.
+     */
+    if (!memory_region_has_guest_memfd(mr)) {
+        if (!to_private &&
+            !memory_region_is_ram(mr) &&
+            !memory_region_is_ram_device(mr) &&
+            !memory_region_is_rom(mr) &&
+            !memory_region_is_romd(mr)) {
+            *skip = true;
+            return 0;
+        } else {
+            error_report("Convert non guest_memfd backed memory region "
+                         "(0x%"HWADDR_PRIx" + 0x%"HWADDR_PRIx") to %s",
+                         section->offset_within_address_space,
+                         int128_get64(section->size),
+                         to_private ? "private" : "shared");
+            return -EINVAL;
+        }
+    }
+
+    *skip = false;
+    return 0;
+}
+
 int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
 {
     MemoryRegionSection section;
@@ -3346,6 +3407,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     MemoryRegion *mr;
     RAMBlock *rb;
     void *addr;
+    bool skip;
     int ret = -EINVAL;
 
     trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
@@ -3361,39 +3423,9 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
 
     section = memory_region_find(get_system_memory(), start, size);
     mr = section.mr;
-    if (!mr) {
-        /*
-         * Ignore converting non-assigned region to shared.
-         *
-         * TDX requires vMMIO region to be shared to inject #VE to guest.
-         * OVMF issues conservatively MapGPA(shared) on 32bit PCI MMIO region,
-         * and vIO-APIC 0xFEC00000 4K page.
-         * OVMF assigns 32bit PCI MMIO region to
-         * [top of low memory: typically 2GB=0xC000000,  0xFC00000)
-         */
-        if (!to_private) {
-            return 0;
-        }
-        return ret;
-    }
 
-    if (!memory_region_has_guest_memfd(mr)) {
-        /*
-         * Because vMMIO region must be shared, guest TD may convert vMMIO
-         * region to shared explicitly.  Don't complain such case.  See
-         * memory_region_type() for checking if the region is MMIO region.
-         */
-        if (!to_private &&
-            !memory_region_is_ram(mr) &&
-            !memory_region_is_ram_device(mr) &&
-            !memory_region_is_rom(mr) &&
-            !memory_region_is_romd(mr)) {
-            ret = 0;
-        } else {
-            error_report("Convert non guest_memfd backed memory region "
-                        "(0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",
-                        start, size, to_private ? "private" : "shared");
-        }
+    ret = handle_memory_hole(&section, to_private, &skip);
+    if (ret || skip) {
         goto out_unref;
     }
 
-- 
2.43.0


