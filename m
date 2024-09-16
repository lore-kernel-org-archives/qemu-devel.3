Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC562C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 14:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqClz-0003AM-Co; Mon, 16 Sep 2024 10:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sqClx-00039A-Nu
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:32:14 -0400
Received: from mail-mw2nam12on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:200a::61b]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sqClv-0008SP-Or
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:32:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vi3IMVr4HPa8WmnXGHSJ88zuCkEJmlCglOXcbVFAkRBE9R/0ncxFttDCMsXAv85FFcd1gM8Ghcjum5PXfeI063m39m6tOBNn9f069ml5DRJ25/6UZLXVGcRvf6yKv2npySVdOaJfcY/Y6Eem7m9x7QhHnls5lk4Z05roUTSN0BVr4nHlDRflKJbU/hSskUTby1wV28FSkQaWSM/NGoA6vE6C5l1P2cfv7QnoeeVOLbvutGALkXIzi5rWyvyym+Cpzcm6lclVTU4+ZDX23153RQ8Wc6F4LdJUjb0TGjfYB7c4AypkpNRCB+2wATzpbBnKFK2PxWDQY5Lx4E+gBcELIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVZp8W/mrH7cMm9l7mu2ltWFQ0fVkgp5gJs11YYxcIE=;
 b=etkblZ5uDkJUudeajfu6gPMxXsPszcezVNCEGCAH3/A2L+vn9g6zjeEcd3YRBM7rrwGvCTZJqBNaPshbLWKWKkenyx1bOJgCF8kJwRiXRdy8ikiehzm85cpbcQXtcFLtgiyc38e7TuZR3xbtk83tzEM8KljUw835oFKrSBqpEZK27efC/TrrX0hinBph+UVHiO3UWzHW5hhMZkyvOEs0BViqSHOazUAgQiXpr+W7bDwf6ydFsb1J0tF+1RzcRtm5+kNWP/r2OeJdzGv0LnBrl2c9HiFjTdKCThlxlUi/zmonl8TMyYveQAmA/BHYjWNDXMfnsKpMvQvNgAfhQtqUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVZp8W/mrH7cMm9l7mu2ltWFQ0fVkgp5gJs11YYxcIE=;
 b=b+3uxurw6DiOsaGEVEIg8vvyiDIarFVJvrW/39/yxeCycLxtJcq/0SsfRQ5vD/JLAExXGkkH3TAds1FtJswEzuNwNAOc9TIgcEUfaZDhlygIrALeNvPhqQojuE8aFW36J6H38pD8UI1P1//urj/32t55KkNW/ucG3fULnuTqLLg=
Received: from MW4PR04CA0220.namprd04.prod.outlook.com (2603:10b6:303:87::15)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.23; Mon, 16 Sep 2024 14:32:03 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::81) by MW4PR04CA0220.outlook.office365.com
 (2603:10b6:303:87::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 16 Sep 2024 14:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 14:32:02 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 09:32:01 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 3/5] amd_iommu: Use shared memory region for Interrupt
 Remapping
Date: Mon, 16 Sep 2024 09:31:14 -0500
Message-ID: <20240916143116.169693-4-santosh.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0a5bff-0461-410b-2b8a-08dcd65c54e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?saqN4pTtxV3Cp6d1TDZPMhm7AWpNxUVRI/qdgF2qnKBxqcHSTylmizW8AjRq?=
 =?us-ascii?Q?uVVFc5SM+Av4jKjOm0Ssu6jNNjpdxwr+UT+1819y/wununYK8T6aeYOcv/wW?=
 =?us-ascii?Q?n5sxBRWNsFv+6TqU2q6LbxCdb4wcuGuVWGRqPreK/KOkX923BGlNF8bW8enH?=
 =?us-ascii?Q?n/ygbp6UNotnOcwEi+/ZlPnAPUVh0IMHSprtfmcGb5xjryCONFka89kf38yj?=
 =?us-ascii?Q?Cj+FJZmdL7YTPSCz2/QrWvSPrm7nG3G5UbCM0p/lvhYRSaLnr0w/ghKKKT6e?=
 =?us-ascii?Q?KsOLZRrEK3CGJHVML1l/n0gDHrkH2dpjv+gUsMvDsRTZfyxxpATMobS4oOV6?=
 =?us-ascii?Q?zfRoj9gXTwQ/o+YbU51dO6f1kSCB1QpSy1Btgf8dJ/61o/9qw44pUZer7+VA?=
 =?us-ascii?Q?oL06Y/AT51ggPv1uZp/I2OkCCLwzMtZwp0wSpc6G3XI8bEX4xyvpKQKurp5J?=
 =?us-ascii?Q?YvHL7Iglc35/7a6HT6E/Gzqz2Ug+vF1zFY254bGeCSE92QwNkDvBfEHtnAc0?=
 =?us-ascii?Q?RbOuqp50mjUMgRTErzvAMZCa7IhxeNC8srP6J+Vvg8Um3OGdCGZgX6qnIR2f?=
 =?us-ascii?Q?+j56XI968NTEKfNw17qx7IInc/MCvqEc6QLnM7cC7CMYLZq3lxw3d0SfuqjA?=
 =?us-ascii?Q?UNZyHiIKGzfDKFonaXzBlCv5Y91Sm+CQoAl5EmkIJnfd0BVicYIRhIaBTwll?=
 =?us-ascii?Q?QS/fv7EQicJ/61f0I8nXd1w5q4n3QuNolzY3Ysr0pYUr+AfAerxrSDzglVIN?=
 =?us-ascii?Q?6MipHc9+F0rdl1iN9x1Pu4RxK8EJfiFWjSjZwGCBGYszR62TIje0CeSZ6k7t?=
 =?us-ascii?Q?tpuL+z3wIAwvqfJflDdpqfVGK/iQsVe0WYIQOMDHRUOXZ+buR6v5AfsFgyXz?=
 =?us-ascii?Q?L6NiDSgAaveaYUXpRPAJy5KPDdHQbxqwZX/kCIRB9c/yefyzv9tm+e5ZV8ef?=
 =?us-ascii?Q?Zt2xYZ8Ixq2wnndRVUvG4nzm2n8pD8wl/nQRejVmYQsfkcMg7Bzg5SNTYsQZ?=
 =?us-ascii?Q?T6Yshdv1cRG7mYPRUfdjaBfvFPDG08xvRjrtD8zgNC+spCgOPdYLAfyJ0Etj?=
 =?us-ascii?Q?AJRkoaS1zjTT3InRd9im1modl5+Jt4ZzphxI20+LopxxgpHWk7mjxg/NOPWo?=
 =?us-ascii?Q?3l6P6i6uEnqNR6iL4fP/JmvOw0LlAQAmIL540vGHtEYsjDNqHkzazmq94FuR?=
 =?us-ascii?Q?XNX0YD2dGDlnkxH02h4o5v81SfsPvQ7wT0GRcD/vv9B2pJwvJRKKiewNSSXa?=
 =?us-ascii?Q?e8KWbZcygW2Ba8uRS0u5a8hf1YJUpHFD69KdVj8E70ec+LMY0UV4pMFK+J7Q?=
 =?us-ascii?Q?8hA5Cqqq10GA2MkK82wPgcZXq45rKwgJ8wlXk2/QLgDXDppJ2HvKtpvLqvcQ?=
 =?us-ascii?Q?u8ezyLfTqZ1n48io95weSWPdqvmIH/wD5LWuea7Yuzdt6mE5q0QDHo7sRNF9?=
 =?us-ascii?Q?U3ANU2efYBHvbskZw6jfKhAtFKfX3PgA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 14:32:02.7976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0a5bff-0461-410b-2b8a-08dcd65c54e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012
Received-SPF: permerror client-ip=2a01:111:f403:200a::61b;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

Use shared memory region for interrupt remapping which can be
aliased by all devices.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
---
 hw/i386/amd_iommu.c | 22 ++++++++++++++--------
 hw/i386/amd_iommu.h |  1 +
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index c5f5103f4911..24fcd561345c 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1443,7 +1443,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
          * |--------------------+-------------------+----------+
          * | amdvi-root         | 00000000-ffffffff |        0 |
          * | amdvi-iommu_nodma  | 00000000-ffffffff |        0 |
-         * | amdvi-iommu_ir     | fee00000-feefffff |       64 |
+         * | amdvi-iommu_ir     | fee00000-feefffff |        1 |
          * |--------------------+-------------------+----------|
          */
         memory_region_init_iommu(&amdvi_dev_as->iommu,
@@ -1454,13 +1454,6 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         memory_region_init(&amdvi_dev_as->root, OBJECT(s),
                            "amdvi_root", UINT64_MAX);
         address_space_init(&amdvi_dev_as->as, &amdvi_dev_as->root, name);
-        memory_region_init_io(&amdvi_dev_as->iommu_ir, OBJECT(s),
-                              &amdvi_ir_ops, s, "amd_iommu_ir",
-                              AMDVI_INT_ADDR_SIZE);
-        memory_region_add_subregion_overlap(&amdvi_dev_as->root,
-                                            AMDVI_INT_ADDR_FIRST,
-                                            &amdvi_dev_as->iommu_ir,
-                                            64);
         memory_region_add_subregion_overlap(&amdvi_dev_as->root, 0,
                                             MEMORY_REGION(&amdvi_dev_as->iommu),
                                             0);
@@ -1472,6 +1465,13 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         memory_region_add_subregion_overlap(&amdvi_dev_as->root, 0,
                                             &amdvi_dev_as->iommu_nodma,
                                             0);
+        /* Build the Interrupt Remapping alias to shared memory */
+        memory_region_init_alias(&amdvi_dev_as->iommu_ir, OBJECT(s),
+                                 "amdvi-ir", &s->mr_ir, 0,
+                                 memory_region_size(&s->mr_ir));
+        memory_region_add_subregion_overlap(MEMORY_REGION(&amdvi_dev_as->iommu),
+                                            AMDVI_INT_ADDR_FIRST,
+                                            &amdvi_dev_as->iommu_ir, 1);
 
         if (!x86_iommu->pt_supported) {
             memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
@@ -1633,6 +1633,12 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->mr_sys, 0,
                                         &s->mr_nodma, 0);
 
+    /* set up the Interrupt Remapping memory region */
+    memory_region_init_io(&s->mr_ir, OBJECT(s), &amdvi_ir_ops,
+                          s, "amdvi-ir", AMDVI_INT_ADDR_SIZE);
+    memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
+                                        &s->mr_ir, 1);
+
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index be417e51c4dc..e0dac4d9a96c 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -356,6 +356,7 @@ struct AMDVIState {
     MemoryRegion mr_mmio;              /* MMIO region                  */
     MemoryRegion mr_sys;
     MemoryRegion mr_nodma;
+    MemoryRegion mr_ir;
     uint8_t mmior[AMDVI_MMIO_SIZE];    /* read/write MMIO              */
     uint8_t w1cmask[AMDVI_MMIO_SIZE];  /* read/write 1 clear mask      */
     uint8_t romask[AMDVI_MMIO_SIZE];   /* MMIO read/only mask          */
-- 
2.43.5


