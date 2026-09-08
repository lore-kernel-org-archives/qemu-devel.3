Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D99C79FAD
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42sw-0005wV-IQ; Tue, 08 Sep 2026 16:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42su-0005sP-TY
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:57:40 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42ss-0007hc-L9
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:57:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVdKvEF5DsSVkQVLmObEDwN+Oh+91U357IpGmiAa7xlLdZmlhr2wqWVXR91db6ErGj6lHGGfiknK3RrwEhoiKdZCUe0sHA1Eq2k6jRSfhsmFwMOQ2HRT2Q+TJZ/AG2e/OwHrcGoYT5qNdDnxHefyiA4nAJD9N12RR5bFpwrbm8QsEvDncFi/pzzlljI0hdJwd4J64tKawbqcRFEaZPch+LztiozByXtQCrN/TMO3xhSno5gAvUzYzn+kiFJ5N42ysar7tJtqjdrfaqWMNRxkMMfQIHxA55Z9sljqfbWLtKLVtoMtYvnr7hsCia0857/L5yEwChqKcVsRh6SlI8aLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ji2H5V2zti+96WZhQz3TUW7oH/0McDvlc1Nv9Ac2KSw=;
 b=MQbePdSvtoYYAgIgJGCccFVYbVM2uiQ82OC5KGF722arWY650NwicjAr8aZ1CsYmYHbxdxzg1JyhICE4fPLIHZIzUpJjrA9l0SxeJ3f/IiFcHWSeKDrY0B5lky+TzzaRg58OT+kPyQxnnfDoZoSEWwXZ4TiHYbV8eX65ICt017DmrZsBQB9DL9ihVCqMQpYUZ5UatMezmyir9ZrDOOge2xBu4BYUSkzyZ8gw6ZSUdZGVButlFJrDCnkzDeMCSGFguwyXn4R3KPRuisApU1HECPTQTzAnUFc+RAFzmkdOhRk3BI9u0i/5PicdbxkTyNxxGgwF/F5VavN6846JjInNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji2H5V2zti+96WZhQz3TUW7oH/0McDvlc1Nv9Ac2KSw=;
 b=p9BI48q15zGL91OaDjhb/KFAGoCGNwK+gZDgyJjIT0wuSp2CTHnXqGZJE/NdT/9RWW5wcI3HxillPjhfY58X2Rqf98ydC9ra5/PMzT9iHYjv9JTBPGLBpj5Xle/RLX6VU8JwvvWXT1GXHVtLZwaVDo+tQjJ4kyyRtQfRARFWZPs=
Received: from DS1P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::15) by
 MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Tue, 8 Sep 2026 20:57:30 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:8:451:cafe::20) by DS1P221CA0014.outlook.office365.com
 (2603:10b6:8:451::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 20:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:57:29 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:57:28 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 01/19] accel/kvm: Add helper for handling conversions of
 MMIO holes
Date: Tue, 8 Sep 2026 15:48:21 -0500
Message-ID: <20260908205236.838281-2-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908205236.838281-1-michael.roth@amd.com>
References: <20260908205236.838281-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d45122-dd1a-4fe4-31a4-08df0debcbe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|7416014|1800799024|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kA5RXllXhq9ECFzeO7RzU1NT7+WXVjaCgyjiQ/xOWUkO7oNZe2eD4//WSH5vRdUNCMpo1J+07TaynIKpRy56j+aR6uRL8jUn+JFfqRD8R6tAL90gl4B7BwYmpgoVbKdzrI1GYweD2mTW+n9GjmsgccMqXrnm2+CG8S3Gn86ypaZIrwVAgCe0GzgMwGE3h5bWmS+APWdDHzUGxbIKhZ+eMHnHaOpOim1Srkk5a4UmDH3qaXBsPTl+skzfOgHgw8IYAa1xtBI/X43yo+pk32qhbkJCs/35atroyFms93V3YIqLuPrEghfRoZt9K6gLDjYBENGor+fskoLIvdE2ijrhsseCJdOToQlV97NVs3PcRtQPve3loYQY51IJCWlrv80cpGIIhI/rVN71m/Qu+D2rEI8teT6ftT5zEP8+2GpgD6RaOaJmTmrdlWlJhWJyX2Hg1lOQDq1Fd/jR42aVkw810OBeWvuw1VznpppD+sLK5BcfiH5EhWdk2gGcqQMVlcGf8jwJ5eia2UPUc35Cxu0s3wVsr97KZzCOzdtzsQfwVW+Q3X5TbsSOhwCd1oPe+OsEa83PWWwx51qICjW3zGfdQX/TN/8uwMIaOkR0IAO/nTIQwjEuSpChU2uMk1GH40D+B1dbhPaksnDuloa1Ip+/W9az4q04WW47ryY1dqQcdXogEo6/qXCnEmmh/iTFGnNuZpQ34MEQ0lgmh74kMowQcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(7416014)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dveeyS3VfcNlteIsGpx+GV8BzLA0UR0CVfu3NJtTpyAJR09KJV7ojugcpaVPbL8oAXIZNRex59VupmMaXcVhBvBSVS0MzU90I1WQIZ2yhkLfvIMGhRtzwbp7afeGoETbj4k+oQ4zXDiJ93Qd/H97s/9fHzyzgcQ2tEszImltKwdlAe10eqvSvW0rdqHtCeYDPZPzVXG8fp/kr0lArnmTx0fkb5oYIQ2rBqOpmrOB1NinlH8QLs5xiz97hkZvpl4tlUI4eG9KubClkeh73HJkR/8K7PRooXA2pHaNTFurhX93jdfUNUmkkHYElZGIcY/5/ik3vl7CNn8uojoEPM74HRTKzaoeeMRM5HqLZerwiRmZDO+B+qx0pwxQeVMAnEnJ6ncNXa8zWF1zdDHP7aaUUV4XTSlVGA7apHdhi1IofDt7QrHh7fHptWFvkub5NjvB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:57:29.8111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d45122-dd1a-4fe4-31a4-08df0debcbe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Michael.Roth@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index 70605a8d10..0b59ba0d3c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3334,6 +3334,67 @@ static void kvm_eat_signals(CPUState *cpu)
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
+    if (!memory_region_has_guest_memfd_private(mr)) {
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
@@ -3341,6 +3402,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
     MemoryRegion *mr;
     RAMBlock *rb;
     void *addr;
+    bool skip;
     int ret = -EINVAL;
 
     trace_kvm_convert_memory(start, size, to_private ? "shared_to_private" : "private_to_shared");
@@ -3356,39 +3418,9 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
 
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
 
-    if (!memory_region_has_guest_memfd_private(mr)) {
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


