Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58935CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 05:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Agr-0003tz-LZ; Mon, 13 Oct 2025 01:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8Agp-0003tc-9t
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:01:43 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v8Agm-0006rs-UL
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 01:01:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DK8C//IWw7jIKIURY1bT+9fhbde0ZAPZAUFT9EfPsjK6QHF1d+rBgO4VcEWebNFfBPc5Lhr15IydZ1oJJuC1MWmYlKNmHk20xGMJNp8Q2lsoAd34/rm9O4IGSfCJ9gFJgZeu4RwVJo6uM+nfhfqylcFP5B5RhWs2/FnuiuWANPiLRTqkptYI/A23sYeSU5nEdfa7Wvi2HYkYtfMtCPaVDb1ludp6eCrzREaPWsyeeiJvziY2DTOSvAbddBKab7Psn77As/8NbzGPK32frs4Bdqvjfii/1uG/3TiNXBgIpJzqsBQrSuqmXy1PzzHk5s49jfH3pMuVmcprdkkRhYRQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTjVWHHNGISgvzSCDi78s6eA51c63N4M7DgGbIM/6Lo=;
 b=xO4AMQsQ++i70eK1mzCun/pG0+2QtLZSkhLRHNz/AvjpYvtmfv5I74vz/mykDS+7jvOZ5JsDEiTsa5LF3qGAtMiQPQyy7LcoalMde5AQwoCGq2MXNLTWf6uhPcMmI/zFBX24+DEbUgf06qlvfPBLXyWre78l6WGx6mzXVz/x+JyU+E0QBJGYkhXXRq2lQsde3ED89fHNW8i57FuyiAKSq3UVbkwLA5kP6doaDXnD/flKlCFGoLuvid63/OuC/OwG/cm0zHemBWfOF8rGSQYQI1tjqvPFAsgYixLy1K6i1JfoK7Elapvk4VBoZOdI/5Nthw7dai7h90WCJJJ/Up5T4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTjVWHHNGISgvzSCDi78s6eA51c63N4M7DgGbIM/6Lo=;
 b=C2WPwzubQkpnp8kqnObKCC/nvdWltfwC8guH3oCTI2avYeCYgEGfo4liYj35xW01T5B77d4minpGwFclEHC27R5RGsfYJaYTK4wfoqmGGlha9dftETUi/Y4jtv3KdUQZQQPtRg1X1IjRT70rg8dhj+FIx63cNufauDZujOatxkk=
Received: from BL0PR02CA0093.namprd02.prod.outlook.com (2603:10b6:208:51::34)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 05:01:37 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:51:cafe::b2) by BL0PR02CA0093.outlook.office365.com
 (2603:10b6:208:51::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 05:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 05:01:36 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 12 Oct
 2025 22:01:32 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, 
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>, <aik@amd.com>, "Sairaj
 Kodilkar" <sarunkod@amd.com>
Subject: [PATCH v2 2/2] amd_iommu: Support 64 bit address for IOTLB lookup
Date: Mon, 13 Oct 2025 10:30:46 +0530
Message-ID: <20251013050046.393-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013050046.393-1-sarunkod@amd.com>
References: <20251013050046.393-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: da16f0be-2d89-41b3-e1dc-08de0a159641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ytEQ2k2glQmG7qarMe/IPhqvdw1S4tVth1Bs8sTMMJ6VUEXyXSyOC3X03+Px?=
 =?us-ascii?Q?6Rd6oq1oQOHj/4UgFtCCBHN+epNwuj4/rxKsBDripm4ms8oKluY/5aiQ5dhi?=
 =?us-ascii?Q?j1+N3P/Ynwp7AFJRgEojmQU31ddIJ3b/AopWOCpm+cY/pCq8Oa9UdUk9q9se?=
 =?us-ascii?Q?LYMQuYnUdOmsnVLPtccq6GVcq+dDqCppS29dx1BCBhyyoIFQSPEIFsE64Xy3?=
 =?us-ascii?Q?aCUB00XETqI32th3uQsBMWE8WOM8zCQlV+dbvTZG8JhIwjgLmMTtiLXBFIqx?=
 =?us-ascii?Q?aGw11oTRSqP7SdQhwHONZldKs7kR4wRIvtsiNjMCSgRYN2XRx0ZsaO4YJP5H?=
 =?us-ascii?Q?04NAyJjS8bLdvBAvEbLaYaKO1hayle7dGfwjObUg4bAS5B7MdHxPVqPoS0cb?=
 =?us-ascii?Q?BMOFWoN/SaTYK8PxbMXH7/kkKTyrYngMqq/WeuEwlvmIDQxxN2aMkiR9/yZR?=
 =?us-ascii?Q?Jot2ZmfWk6Sz/t8S1IjfHfrrbIPZE6+ONBZbuC70cqksXRqsYJoduArSbK5H?=
 =?us-ascii?Q?3qLnbeeLXQSTqDBj5RglDkcg1MZmu4fhV1+ixX9VfxiHdb6EM6LQOeePf5U9?=
 =?us-ascii?Q?gMdF1C1Uk8FIjXX6PbhTOTIJ2chjRuLJVI2VR66mvV5zv+2/j0Ilxo4V8Dy7?=
 =?us-ascii?Q?m5785VdhPj0n427tKsIQReeTkeOLzapIu0CQfiveDTl/JrGq87nl7CsQe+eN?=
 =?us-ascii?Q?glH+qcBY1c3nBrkddOI1H6E7NCMPbipb1OunKg3OLD1M2E9VEMgz0P3asSrI?=
 =?us-ascii?Q?rblqspzu6uL3MfOIfm/tyGU0Pk484M44tbdkFSWGYdrsYfKjnSUuZcJ34Qhe?=
 =?us-ascii?Q?1T3maGOjxKvDgz5kSjx73OThqz6c8iELYsUfqM08ANlSYimhYFqVcHcPEm7L?=
 =?us-ascii?Q?5GTifF0UjLHiVdq83jLUF2Ww69AjwkPSA8KsAQ7OJiewSrkDmxwNGLcFQ8P/?=
 =?us-ascii?Q?N1CEs+Dc3lE++V0EtBky5ITfsy86ZPq4bMHN+dR98iKic0w7fJqCiArinSXD?=
 =?us-ascii?Q?ScKZSHKMkksnHULyHwCdcb8xAjW3rvF30gDpM3y5nT2IWwm565Pl2GpRK8lz?=
 =?us-ascii?Q?LuXe7sLj5hRNBvtCqD3l2AHJ3eQPB/NUcFOpRSqgz7lcohFwmCZDCeWvV4yj?=
 =?us-ascii?Q?ApmulnRpV+ZsxTq0Q+tCYSGQeDJC92x3nvmKDAdXNyklrCvja3r4PX1sllEA?=
 =?us-ascii?Q?kNAdvweFyrIGhx7EiSYkiS8rCoEjt4SVLsjXdM00W71wyg+g5+6bYXuOV0mj?=
 =?us-ascii?Q?s3KdBCZ4p+mcsTR7fr42MDNVTLwK48K2nuUyJeX6MgMP8eY62rKjx1iowLHj?=
 =?us-ascii?Q?IEaJ9rLy/ZKeutLiY0uZiFzl28Mo+OPOZES+jwbbK6B0eB/0RTWTQO5QkauQ?=
 =?us-ascii?Q?mVI6yUoAgaid6txsc0NPKSOHprmgliuoBJAT/XRKctVP4GV6B6PBz+hfwyga?=
 =?us-ascii?Q?Hcuk5UyRAK/7oY3vjG5j4V9k5eu7RSK32eV6ikh9Te/QEC++4SIq3FTaYAJY?=
 =?us-ascii?Q?GWqLureVZi2pcxonReoEnbv47iunO5+BMPhdQsHjdZoY2ddh9OISYQ+7J/Pj?=
 =?us-ascii?Q?lr1Z0XmEelSvPq7KDMU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 05:01:36.4260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da16f0be-2d89-41b3-e1dc-08de0a159641
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
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

Physical AMD IOMMU supports up to 64 bits of DMA address. When device tries
to read or write from a given DMA address, IOMMU translates the address
using page table assigned to that device. Since IOMMU uses per device page
tables, the emulated IOMMU should use the cache tag of 68 bits
(64 bit address - 12 bit page alignment + 16 bit device ID).

Current emulated AMD IOMMU uses GLib hash table to create software iotlb
and uses 64 bit key to store the IOVA and deviceID, which limits the IOVA
to 60 bits. This causes failure while setting up the device when guest is
booted with "iommu.forcedac=1".

To solve this problem, Use 64 bit IOVA and 16 bit devid as key to store
entries in IOTLB; Use upper 52 bits of IOVA (GFN) and lower 12 bits of
the device ID to construct the 64 bit hash key in order avoid the
truncation as much as possible (reducing hash collisions).

Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 57 ++++++++++++++++++++++++++++++---------------
 hw/i386/amd_iommu.h |  4 ++--
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index b194e3294dd7..a218d147e53d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -106,6 +106,11 @@ typedef struct amdvi_as_key {
     uint8_t devfn;
 } amdvi_as_key;
 
+typedef struct amdvi_iotlb_key {
+    uint64_t gfn;
+    uint16_t devid;
+} amdvi_iotlb_key;
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -377,16 +382,6 @@ static void amdvi_log_pagetab_error(AMDVIState *s, uint16_t devid,
              PCI_STATUS_SIG_TARGET_ABORT);
 }
 
-static gboolean amdvi_uint64_equal(gconstpointer v1, gconstpointer v2)
-{
-    return *((const uint64_t *)v1) == *((const uint64_t *)v2);
-}
-
-static guint amdvi_uint64_hash(gconstpointer v)
-{
-    return (guint)*(const uint64_t *)v;
-}
-
 static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
 {
     const struct amdvi_as_key *key1 = v1;
@@ -425,11 +420,30 @@ static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
                              amdvi_find_as_by_devid, &devid);
 }
 
+static gboolean amdvi_iotlb_equal(gconstpointer v1, gconstpointer v2)
+{
+    const amdvi_iotlb_key *key1 = v1;
+    const amdvi_iotlb_key *key2 = v2;
+
+    return key1->devid == key2->devid && key1->gfn == key2->gfn;
+}
+
+static guint amdvi_iotlb_hash(gconstpointer v)
+{
+    const amdvi_iotlb_key *key = v;
+    /* Use GPA and DEVID to find the bucket */
+    return (guint)(key->gfn << AMDVI_PAGE_SHIFT_4K |
+                   (key->devid & ~AMDVI_PAGE_MASK_4K));
+}
+
+
 static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
                                            uint64_t devid)
 {
-    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
-                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+    amdvi_iotlb_key key = {
+        .gfn = AMDVI_GET_IOTLB_GFN(addr)
+        .devid = devid,
+    };
     return g_hash_table_lookup(s->iotlb, &key);
 }
 
@@ -451,8 +465,10 @@ static gboolean amdvi_iotlb_remove_by_devid(gpointer key, gpointer value,
 static void amdvi_iotlb_remove_page(AMDVIState *s, hwaddr addr,
                                     uint64_t devid)
 {
-    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
-                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+    amdvi_iotlb_key key = {
+        .gfn = AMDVI_GET_IOTLB_GFN(addr)
+        .devid = devid,
+    };
     g_hash_table_remove(s->iotlb, &key);
 }
 
@@ -463,8 +479,10 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
     /* don't cache erroneous translations */
     if (to_cache.perm != IOMMU_NONE) {
         AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
-        uint64_t *key = g_new(uint64_t, 1);
-        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
+        amdvi_iotlb_key *key = g_new(amdvi_iotlb_key, 1);
+
+        key->gfn = AMDVI_GET_IOTLB_GFN(gpa);
+        key->devid = devid;
 
         trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), PCI_SLOT(devid),
                 PCI_FUNC(devid), gpa, to_cache.translated_addr);
@@ -477,7 +495,8 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
         entry->perms = to_cache.perm;
         entry->translated_addr = to_cache.translated_addr;
         entry->page_mask = to_cache.addr_mask;
-        *key = gfn | ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+        entry->devid = devid;
+
         g_hash_table_replace(s->iotlb, key, entry);
     }
 }
@@ -2526,8 +2545,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
-                                     amdvi_uint64_equal, g_free, g_free);
+    s->iotlb = g_hash_table_new_full(amdvi_iotlb_hash,
+                                     amdvi_iotlb_equal, g_free, g_free);
 
     s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
                                      amdvi_as_equal, g_free, g_free);
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 38471b95d153..302ccca5121f 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -220,8 +220,8 @@
 #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
 
 /* IOTLB */
-#define AMDVI_IOTLB_MAX_SIZE 1024
-#define AMDVI_DEVID_SHIFT    36
+#define AMDVI_IOTLB_MAX_SIZE        1024
+#define AMDVI_GET_IOTLB_GFN(addr)   (addr >> AMDVI_PAGE_SHIFT_4K)
 
 /* default extended feature */
 #define AMDVI_DEFAULT_EXT_FEATURES \
-- 
2.34.1


