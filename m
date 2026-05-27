Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2738ECD6E44
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMpI-0007Xf-TS; Wed, 27 May 2026 18:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSMpH-0007XU-Ei
 for qemu-devel@nongnu.org; Wed, 27 May 2026 18:34:11 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSMpF-0000Gk-ET
 for qemu-devel@nongnu.org; Wed, 27 May 2026 18:34:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUZy9pEhf84gYNbcV1CPi/V7QyFF6GWfbqBcfBP+ToegD4J+evkw8b46s3vhCA0wAjTmYs5P/U6+Nesz6OGrn882zwsB4adGncRzuDUFmirZPPyC/GVztAGXmdCev7PiBXhUHC1s/VozNAWSKbOm0FkuzUj7mPz/hDkJXT6SZBza0BHB99JynHRjG8bqSjk64Ijpp0cLrwSyAW/e7cvNlyZ6nWdGXHGqHrd2YEoJdRH+1mcPtqqjP9gOcMexyCd91+CTDxUGd9v/FIe9UEfYVESnSXkY49rKavNDe0FJK7Z1CIOtNVLRRgowo1icQnDFLEc7Pge6ifFxY9enM1pExw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5Pj4K1CTPVwSoBdlQ1uR/NenHacWMMO2apNTiaUVu4=;
 b=XML1MA4m+02YLr9jJJENtdrbEs5ju2SQN/xdy+R9AkoB8q0PZQFChemADZoSrzWvd8sMh2GPo4QyMkaSjdQ6dp6dXRFWXzMDlUvU/OR1AKo9wfkccJxHQI4OfOoyNhjlxZcXraYJFZBinDdpqrwTy/gWaLE1nsWUXBgDrO/fckVO8r225BFpJ6JqfLMbIKZggxpesCro7hn0O2uyHvqRWsiZrAtxnvmwxwRdW1osR/Xt7YrF6gKDRQnQgRqCi1wudJYflipdNbZaOGuq5nQiz24AcqkJwM2CdXuEzYWzWlb0iNGyijHGp3Sgg4SdmhM/6ju/VF+Ot9C4NW2CjBb9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5Pj4K1CTPVwSoBdlQ1uR/NenHacWMMO2apNTiaUVu4=;
 b=A8RdAZONqhK6d+aB1H+VIMlYUeP4vTHtlFGwyxNWy+1kpdVSJzdz3dCEWAi3Sbbl/jV2O8+2Z0+lP/8QPGVOSyWJCsHcrJegdgXa5dUx86pL6IFwUp0frOCJMcp6emtezt2NFIzId4EhBRTIBGddBiLYqQHHV2tv3n7+dyLv1gY=
Received: from BYAPR21CA0024.namprd21.prod.outlook.com (2603:10b6:a03:114::34)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 22:34:02 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::3d) by BYAPR21CA0024.outlook.office365.com
 (2603:10b6:a03:114::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Wed, 27
 May 2026 22:34:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 22:34:01 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 17:34:01 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>
Subject: [PATCH v1 3/4] accel/kvm: Fix handling of MMIO holes at start of
 conversion ranges
Date: Wed, 27 May 2026 17:28:26 -0500
Message-ID: <20260527223036.4614-4-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d098dd-62fb-4380-51b0-08debc400d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: PmrM33son+4B4w2V0gfUmX0jWHG4v4pLi3sexFbvMIYQeK1ClpwzwpNmD1kNXFoC/P1ejL9nxLd6Hc27ifpAVpKvwMUL/aFY4hm3CzU7NOpULP/AfdnLmmpEAcpID+NXt9HyYyxO+Ymj2+vPs5uK02o3eidMHkQ3nmqBVLrOyTJHaOZKsxYec2cOOC3naQ16uKlg7fHVr5nB5mrJ+6QjRO2w/sGitqyUvCH+V3gmX03xognVdXm2ZVBgjh3xZnekpK6n4oSvEq3VC8hqmtRoUL8kwTMP7vL77FkzIWqY3LWIbY6MaX6+63RbuwPGsdXLM6J8zLdnViHpV+DyES9pL5KwTNMJAwjWrVfdoj6BPhUmV3XZDtWMnphcMHbmlT4E+FPhmnPVC/9nnygaocsYEK2bdIUG18cgH/Us1tREA9hoUQr91qSqUHTYw3uzTJU2g+w/AGlknvD0cFOOIXNsmKa8TVUqhJ54XRGxuAJPrklbGI9Cd7rjpPjT6NmhYHzVMwLMStr3guQJtnV0zQdarv5jzJNwouwKHBGoOb/yD54ZsGUA0AmSG44cVvqcyXOGgPfP14pd6znqUjl4gX+ok6cupFYOC6ussPGMdnEkZsq9U8/9LulhotX1HOqdkn8Sg+JBsFuiGRESTK94mzz2Bart6vXeBwGipenWtcQPKCNRg1g8+LJfTmshE6tCdDenyS22c0oUkq6egha+l6GNrexcffob3v0cvkW6W6eXMzI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dkhzeFi74FYGoooGUmTyFNys1rPWkqmltiTCFTwhPbOHxbc7Uh/H3TZ8ECTSyeIrzzdlgsBqaA06hFzM9Xku1t8h/1IHR5vGRmjZFlbXoWEJ56Y2CAn5x9Z219VSqP9kmrRAZCp7bSHiDBI1fWl/SUTITcdcFELJXHZNteQRYsZsgnTViyRhjY678AaQEy163ovNN++n+qidIgR8OnwqaraC7XSHUt9OgT0oyhaYtypO3P0DXfyNcI0YXyZ28V+GrESqrYpS27GUV5l1FvKsU5JIh/AOZXYMjt5v4Ck4Du3kyAPb6JgsXj27sJmcVCXpWnQUhgfTYl63KHekzQjedft5C/aTgFPSIeEjoqT2+hVuVLH2b1OCNLYPNskSDpJpMfEF3mKc5WeQyc6SdqlPC9r1M31z/a62sczyNookWbbOondrmbXF8Y4qYjDZV4B1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:34:01.9910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d098dd-62fb-4380-51b0-08debc400d57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Michael.Roth@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Currently MMIO checks are done for ranges where memory_region_find()
finds no regions within the entire range, or for cases where
non-RAM/ROM regions at the beginning of the range.

However, if the first region in the range is a normal RAM/ROM region,
then the portion of the conversion range that overlaps the region is
processed normally, but any MMIO holes that might be present at the
beginning are ignored, so the checks are bypassed for those ranges.

Plumb the 'start' GPA that was used to query memory_region_find(), and
pass that into the MMIO-processing helper so that these gaps can be
detected and MMIO checks can be applied appropriately.

Fixes: c5d9425ef4da ("kvm/tdx: Don't complain when converting vMMIO region to shared")
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 21e8404e61..609126b847 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3349,9 +3349,14 @@ static void kvm_eat_signals(CPUState *cpu)
  * non-RAM/ROM region that should be skipped as MMIO. In the latter case, the
  * 'skip' parameter will be set. Returns < 0 if the conversion request is not
  * valid.
+ *
+ * 'start' corresponds to the starting range memory_region_find() was
+ * called for, and is used to determine if there are any MMIO holes preceding
+ * the region passed in so the appropriate checks can be made on those
+ * ranges.
  */
 static int handle_memory_hole(MemoryRegionSection *section, bool to_private,
-                              bool *skip)
+                              hwaddr start, bool *skip)
 {
     MemoryRegion *mr = section->mr;
 
@@ -3396,6 +3401,15 @@ static int handle_memory_hole(MemoryRegionSection *section, bool to_private,
         }
     }
 
+    /*
+     * In this case the region should be processed as normal
+     * guest_memfd-backed RAM/ROM, but still need to check if there are
+     * preceding holes to apply the MMIO checks against.
+     */
+    if (start < section->offset_within_address_space && to_private) {
+        return -EINVAL;
+    }
+
     *skip = false;
     return 0;
 }
@@ -3480,7 +3494,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         assert(section_end > start);
         assert(section_end - start <= size);
 
-        ret = handle_memory_hole(&section, to_private, &skip);
+        ret = handle_memory_hole(&section, to_private, start, &skip);
         if (ret || skip) {
             memory_region_unref(section.mr);
             break;
-- 
2.43.0


