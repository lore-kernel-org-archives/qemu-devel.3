Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F40C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 14:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqClq-0002u5-3X; Mon, 16 Sep 2024 10:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sqClj-0002qc-UM
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:31:59 -0400
Received: from mail-dm6nam10on20607.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::607]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sqClh-0008Qy-1S
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:31:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hv8vVSIhSL09Po1MiXNv0nOqKuXxeUcdNqJpU+JpC64iXvdAMgvBZ8PSdaHjuzn/sBprSbObJTwpW9e7VOg8czD9ZjuZ8dkSXpV/gwWiZmQfhum2SrFMIDCAuLbN9/UIvApzxCd0VhnIqwZI1v+zhdqh6KuhJm4zLD/MYfKHW0AVxvGrm9/h+CoHgvY8xvfySqnqfjERiqlLVv4Rp5uNu23VPcsJRLzldFjcH5FRefdUYpcDMbapTZ+OdJVU31nXSPo10OgRCzuG9TvEVMT5p6JQEVWmJTiyXOsWTeKlmU3gdOvP5qQgxZIAXJcUJdiOP+Qa+wboU5Rmpo18hBmFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5ubfCtBc+j644eI27xuiuImRuefsEjP+rSV1R2oN/M=;
 b=PVrV2ZU0lnN9zveARyksMXZc8eZaapzcBKUWMRj2JPYwjU5xy4YoTRWhOB3hSR/X2PFe655EE5F8scx7H++ATir6whlANBsG1MiWg3MLVntrVpeuB9clq9vl5kU5qDG1931kB8P+7IvqAeQbW3/+d0yojYpv4O6rhtEr3M34BAnrCnAcF7acpHlwC5h/2HTZN2q8hb/fWhrJuMBhCE1NkLC0sjyQZT27IX4OaGZxJ8ERqvmslv87anS1cXTWACmZrOJuFVHKBY86DeVEPSPULgvGbweYhnz2HWvvoVk3BdV4fHPjkvPwoAp182qFARw+JAo++coW+1O7MV/5yBf5QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5ubfCtBc+j644eI27xuiuImRuefsEjP+rSV1R2oN/M=;
 b=MhSyIC9ylG1fu5Lwsm2migPotOVSRIh5g+OpcWxCymq+ZnLTqM9R3QmqgoksqXgO7LinGPyxhTAswYNeg82FRpz4VLUZfQPX/j8bldeC9cZrae4+DG16zNjfuRb3eNzWzwZeq9W+ap59F/DDf9cXHC77ptMWlDy12apgXJXafSY=
Received: from MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 14:31:51 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::9f) by MW4PR04CA0215.outlook.office365.com
 (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 16 Sep 2024 14:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 14:31:51 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 09:31:50 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 2/5] amd_iommu: Add support for pass though mode
Date: Mon, 16 Sep 2024 09:31:13 -0500
Message-ID: <20240916143116.169693-3-santosh.shukla@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240916143116.169693-1-santosh.shukla@amd.com>
References: <20240916143116.169693-1-santosh.shukla@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: d79eee10-8ca6-47bd-3cc1-08dcd65c4e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yp6+7n1pPD8hsmrrr6mlUVJ/vCgVwBmcTPsuAx5SEU4UMcWVIGYYM9ADGtNx?=
 =?us-ascii?Q?u6QQyWmq6VQT0SxRb6OeT3WbVf5zh91qEjyQgthXjypiiac9j7wVOhMjLRBw?=
 =?us-ascii?Q?e/Pay0hbxjo8tro2umGwYQMup9S6eziXvKQKsQxk7paCaQz0Xp5u6t2iYwem?=
 =?us-ascii?Q?mvXzjsYIIk2S/SKuUUdqbR7HI75xRPOiwt88+60MxhZ68vFpERrruWGz/PAi?=
 =?us-ascii?Q?LAtZ3DG4lUSdcCjlH+/69zkRI3mA71tebbHjX/PQPKuSFCmI21EiM82rQxNr?=
 =?us-ascii?Q?pbu3ceHId08vr1L9l5wsjmXmHrWDaDTt+vNa8QqoiwgYje+DbJ7gSw1xuxkB?=
 =?us-ascii?Q?y/tMCbHY7r4o8AICUmpaqwGg6aNo/gGkeV0HxbRLq3Urc5HowiIi/K5TCPND?=
 =?us-ascii?Q?1huHclH18fdB5nReYfe9i2fXgED4oo0XJbAzazrWVcSZ6S8sPHqCVF4ipSBP?=
 =?us-ascii?Q?HBY60LNA3XscaLoTFgzfLsE/zXBFzv+ViQl6cUH9YFa2jx68SywBheJrDva/?=
 =?us-ascii?Q?QAtRxek2KjPoxYBoqVkl/0Ago+0g0QofVHEbgTdfndNL/quG+NJdzGx8KYRY?=
 =?us-ascii?Q?31duEq8eLWrSCep2vrJisYZt9CrNOYf+QqrR8oqHWIGPOVx/RwPSiJMkp+3b?=
 =?us-ascii?Q?5gGAg4s8KD0ZwikQcQgcuiHWo+QqIEbHBxN8CZQlwurZ4eVvVItDyxakCkFh?=
 =?us-ascii?Q?9Q3nGON2zfiqA3VnNSJ8nMTkErFbNpZxrrNimALspOJIcjJ3HOsMGjZVlwwL?=
 =?us-ascii?Q?jbYGMHISl4MwKbN6Xyb36hZhCQ97bycR/BV7FJyJCVk/jsMF0aHZFtk8Jns3?=
 =?us-ascii?Q?ROn90b87Ho8P6ktnjlPms4avC2PFVzL6WSQN8lm0uFACN5KhGgjK1Troa0Z0?=
 =?us-ascii?Q?5OvmIxwesqa5xFNgBBYiIvjQ5+/B1V0xQERWcqyWCXV1zyIHz4oadM45Kv1J?=
 =?us-ascii?Q?ubgSJwc1O6NCzl7HCpTyBjsrhRSvU6T50zneCQnkKdirbGPzAdWyfeMXgIGr?=
 =?us-ascii?Q?lEWlHTuJcreRbs1aG8oRu0VsgbwUiacyUCNrvMfZfz0Fud1CHBBowUoSDZ44?=
 =?us-ascii?Q?2Jn6Cv7XW1FeMvjsMjKwpUwO2XSqs7vvq+eBNCrBM9W+HR5U9fCsnMmazB9f?=
 =?us-ascii?Q?9eEk2V8jD4HL1TnZZtDAu4iab+LSjd2dmMh2pstrHDKmyG344pbvTgR2APpE?=
 =?us-ascii?Q?CEMS8SJ/Lr6f6C2BYWcKVJ0k87FevfB9w3Bgp2NKPyUy+rVZ6KEvO/RvRpXD?=
 =?us-ascii?Q?oo/PCW4S8dLMTi/snl04URP7JmUlMxPWk3XoLJe/HJU+SGmgO1DG1cHFvH4B?=
 =?us-ascii?Q?Qdu8BywZdj/DFJAqOsxkWLC1pHngPGtDHxTSFbNIxLx9BeITh2fBMekgXCiH?=
 =?us-ascii?Q?JLexdRHh2XZ9qE6WauwZdzqCbe2Vm5r/jZg2vylGNALYoWm7wRvk642ucap8?=
 =?us-ascii?Q?fRNMx5JbvHCv3wROlg7Z+Zrgdij5Q4NF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 14:31:51.2990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d79eee10-8ca6-47bd-3cc1-08dcd65c4e0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
Received-SPF: permerror client-ip=2a01:111:f400:7e88::607;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Introduce 'nodma' shared memory region to support PT mode
so that for each device, we only create an alias to shared memory
region when DMA-remapping is disabled.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
---
 hw/i386/amd_iommu.c | 49 ++++++++++++++++++++++++++++++++++++---------
 hw/i386/amd_iommu.h |  2 ++
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index abb64ea507be..c5f5103f4911 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -60,8 +60,9 @@ struct AMDVIAddressSpace {
     uint8_t bus_num;            /* bus number                           */
     uint8_t devfn;              /* device function                      */
     AMDVIState *iommu_state;    /* AMDVI - one per machine              */
-    MemoryRegion root;          /* AMDVI Root memory map region */
+    MemoryRegion root;          /* AMDVI Root memory map region         */
     IOMMUMemoryRegion iommu;    /* Device's address translation region  */
+    MemoryRegion iommu_nodma;   /* Alias of shared nodma memory region  */
     MemoryRegion iommu_ir;      /* Device's interrupt remapping region  */
     AddressSpace as;            /* device's corresponding address space */
 };
@@ -1412,6 +1413,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     AMDVIState *s = opaque;
     AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
     int bus_num = pci_bus_num(bus);
+    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     iommu_as = s->address_spaces[bus_num];
 
@@ -1436,13 +1438,13 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
          * Memory region relationships looks like (Address range shows
          * only lower 32 bits to make it short in length...):
          *
-         * |-----------------+-------------------+----------|
-         * | Name            | Address range     | Priority |
-         * |-----------------+-------------------+----------+
-         * | amdvi_root      | 00000000-ffffffff |        0 |
-         * |  amdvi_iommu    | 00000000-ffffffff |        1 |
-         * |  amdvi_iommu_ir | fee00000-feefffff |       64 |
-         * |-----------------+-------------------+----------|
+         * |--------------------+-------------------+----------|
+         * | Name               | Address range     | Priority |
+         * |--------------------+-------------------+----------+
+         * | amdvi-root         | 00000000-ffffffff |        0 |
+         * | amdvi-iommu_nodma  | 00000000-ffffffff |        0 |
+         * | amdvi-iommu_ir     | fee00000-feefffff |       64 |
+         * |--------------------+-------------------+----------|
          */
         memory_region_init_iommu(&amdvi_dev_as->iommu,
                                  sizeof(amdvi_dev_as->iommu),
@@ -1461,7 +1463,25 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
                                             64);
         memory_region_add_subregion_overlap(&amdvi_dev_as->root, 0,
                                             MEMORY_REGION(&amdvi_dev_as->iommu),
-                                            1);
+                                            0);
+
+        /* Build the DMA Disabled alias to shared memory */
+        memory_region_init_alias(&amdvi_dev_as->iommu_nodma, OBJECT(s),
+                                 "amdvi-sys", &s->mr_sys, 0,
+                                 memory_region_size(&s->mr_sys));
+        memory_region_add_subregion_overlap(&amdvi_dev_as->root, 0,
+                                            &amdvi_dev_as->iommu_nodma,
+                                            0);
+
+        if (!x86_iommu->pt_supported) {
+            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
+            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
+                                      true);
+        } else {
+            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
+                                      false);
+            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
+        }
     }
     return &iommu_as[devfn]->as;
 }
@@ -1602,6 +1622,17 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
                           "amdvi-mmio", AMDVI_MMIO_SIZE);
     memory_region_add_subregion(get_system_memory(), AMDVI_BASE_ADDR,
                                 &s->mr_mmio);
+
+    /* Create the share memory regions by all devices */
+    memory_region_init(&s->mr_sys, OBJECT(s), "amdvi-sys", UINT64_MAX);
+
+    /* set up the DMA disabled memory region */
+    memory_region_init_alias(&s->mr_nodma, OBJECT(s),
+                             "amdvi-nodma", get_system_memory(), 0,
+                             memory_region_size(get_system_memory()));
+    memory_region_add_subregion_overlap(&s->mr_sys, 0,
+                                        &s->mr_nodma, 0);
+
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index e5c2ae94f243..be417e51c4dc 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -354,6 +354,8 @@ struct AMDVIState {
     uint32_t pprlog_tail;        /* ppr log tail */
 
     MemoryRegion mr_mmio;              /* MMIO region                  */
+    MemoryRegion mr_sys;
+    MemoryRegion mr_nodma;
     uint8_t mmior[AMDVI_MMIO_SIZE];    /* read/write MMIO              */
     uint8_t w1cmask[AMDVI_MMIO_SIZE];  /* read/write 1 clear mask      */
     uint8_t romask[AMDVI_MMIO_SIZE];   /* MMIO read/only mask          */
-- 
2.43.5


