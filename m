Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07025CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slmrt-0000ZI-Vj; Wed, 04 Sep 2024 06:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1slmrr-0000WY-JH
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:04:03 -0400
Received: from mail-mw2nam04on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:240a::60d]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1slmro-000639-VD
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:04:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jY/jgfkvoPTiz4DGGda32uVRE/WlmD03U1M3b90Rh3WJ+dFtZ+MNVibV3KJOmls5pcucczXCgzlhQXc7BIixyY9UmNnBpFmF3p+nSO+WDQmzyfGIZzYYv9rk9x3pZ2MRhXrKJAaguta43djhHvR6A+z7rkEynaQ53ckiki/xNkZLMxQWn2pZ2p5crI6jBBvt0CLLgmh8bmnTvaZUDGuYtUXFpkYXsoPuCG7+pPwYZMHQnydJ1/sOx0QlYrZNkKkuJOPJ0YF2iIm5En47+IiKOvvYOgeZY5vDLn78l1JyCRXGOuYksfUxj6vGlrNqVWwkgkoxnu9xEHdjx5aNoa/9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYd8tgMbNKETmbVXBwS9GrO/IQQ5w4s2aX4AonadlR0=;
 b=GHLLGEPcDxA0OylmKyI4zixed+LVUUzBpkcj3ZkLB1YW/26Sl/8CrfZXgH3smANgVBO7QNs2kQBqEabj/hg7OQc+4Ui4KlS+0l7tAveMZLXPtvxRz7OKoq1kXXOSVFnMZXGkeJoCKz+p11geu/imz4dMtUOrr+6mbvtmDtdSZq96Gv9MZ+ugSzP6VSirzWprHBetz4zQjzLFp9bFwdnjqLRt3Q1Wf4z6udD/26e/85zSx3FDTIXZ12aNxMX5Jr0C5seZO4dOF90XfC8BrejSgjt7lx8ljudkeWM7FfCNHABi3XGSeIFVNknJGPL/2yWAAPnnIsnj/EpG/jYvRDUMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYd8tgMbNKETmbVXBwS9GrO/IQQ5w4s2aX4AonadlR0=;
 b=4pNLvJfYdL1kux6Tl1fIljmbvSAU7ejv0qKWpKzerxFjaM+ZUCt6Zw7HqMZSYpdLIkBOVYe/LZJhqTDN4FblKLnEdiiSi+9h557QDFPe0eIl+52N5vmUWqtG/KsLVrCxZMZVfBKaSzsm0JFx2qMeRRxgJ6C+9QEJdDNNNplOMO4=
Received: from SJ0PR13CA0006.namprd13.prod.outlook.com (2603:10b6:a03:2c0::11)
 by CY8PR12MB8314.namprd12.prod.outlook.com (2603:10b6:930:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 10:03:54 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::ed) by SJ0PR13CA0006.outlook.office365.com
 (2603:10b6:a03:2c0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Wed, 4 Sep 2024 10:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 10:03:53 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 05:03:52 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
Subject: [PATCH 3/5] amd_iommu: Use shared memory region for Interrupt
 Remapping
Date: Wed, 4 Sep 2024 05:02:55 -0500
Message-ID: <20240904100257.184851-4-santosh.shukla@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904100257.184851-1-santosh.shukla@amd.com>
References: <20240904100257.184851-1-santosh.shukla@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CY8PR12MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f4bbd3-ca62-4f01-84af-08dcccc8e222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mBrETiISo6pLOLBXqhc4Bo0CnkpjagU3opKeiI1T8eSbg6KxjvYhcKADt4vH?=
 =?us-ascii?Q?46HTKFqBgF5ckxyio0m9HErLHrZvZqxN01/jOVOijCsZhrQ7xn5q3WDH26UX?=
 =?us-ascii?Q?cesvLh0xiPzeyp4pWGAb336pfGjRscm5uukQQEOoVxsHuiF+33tq7P3GMQQj?=
 =?us-ascii?Q?4P4DRI6fRNnO0jGKhdjMHPb16iXnGm3SCbLtW4g4aQ0lakXtyS19TC5m4L86?=
 =?us-ascii?Q?KqeEjCTw3Fm497aFOuZCnGf3CCIHWgpdfqj8v4ikcwDSYDdv2Qb1Ikfo30y1?=
 =?us-ascii?Q?SzWKUWNJww/GJr4gX+E3i9XEvq2Gsf1+gdtRJf2JFpP/MhUAe3B1I/XmWYAT?=
 =?us-ascii?Q?2XaUH9VhsDyPr2I15xWOAMkAkqmlwFT14dWl1my9VPMcI8P0TOoHhLL3ZB2n?=
 =?us-ascii?Q?/Pzmp3YKe16vxpV7sS1/SA8YoGb+yrT6mjGPGvSGPyCmOv+c31JD6P+V5BHj?=
 =?us-ascii?Q?B1mGCJuQIq5FLaQAx1Gbw2JfWC9a5djo6fqTpR9MxRLogmOWqT9Suxk5eiZH?=
 =?us-ascii?Q?410f16QlhYRDYMmbkToROKS1/GEaaBgJlbAjoBaw/u2PR4zuxnfVdNaj6olQ?=
 =?us-ascii?Q?lpHSXemju/hinwaxxTygERpSw8+SuqFphAttOzhgTB6CBY/b8Tbi4GtaLA4b?=
 =?us-ascii?Q?MTVYvVBz+vkxXg2PONQZ6p0J05Oqzxi2iYOwUcEhLczrPpAOo2mBsAZ7jxmv?=
 =?us-ascii?Q?2GjZJiVBkQ/mYnduHcgP0+vQvSmf6NN3qIM3Uo7Q5NEsjiYFP7DWFO4yJWdi?=
 =?us-ascii?Q?5QzdWxanS5ZRdYzTgpUc/liKrPiuuloD/jzm2xOOUOI8eG1BzhvTYotmijWs?=
 =?us-ascii?Q?z8sWVTH6hB1NKWvQq0AiFsuE5ujdKCFJd03UX5Q8alcbTmrfi09AjS7J0Fp/?=
 =?us-ascii?Q?sVD34O8TEBwgtfgWHU3pVlnTKEiSLJZEeO9a+Xqljky+eI6pvXFz2PPauLgP?=
 =?us-ascii?Q?DQY13J0JHsHZws5QNFgr6JzpzHJUlKLFPrULmXz79JnrNgXgbeWYG0P4IPun?=
 =?us-ascii?Q?n9wsZYCtfeiLyXZbqcJj2WxuRaf2ORJQmrKdDR0nmPbMHfG6B9N0pShQ15EU?=
 =?us-ascii?Q?IvPOAhRZ6GP0PMOwRyoOCukHrBkuPhCqx5U1ZUpzRjBnVHw9c37zN7jE1noG?=
 =?us-ascii?Q?fRKTK8xV9i6/lyIgQzwHwjwJVGDwAQDRzBa9k5zUL8IqhpV/nVaDpJECqoVU?=
 =?us-ascii?Q?LRpMM5tXReOT8ugh4vxkX9RDpIs+qKzHG6fG0DxIR46KhUtn/2HJQVAqzkmQ?=
 =?us-ascii?Q?3zJbHGl1cyHXNmJ5NY+/TeK7DCCwmn5Oe3PUrLYzEWO29siL6L9K0/CNG0u9?=
 =?us-ascii?Q?p/p0QhkMuXT4h1HoR/oIP6mGFpeTQmhTsEt0HFzxLdP+nyT++Sg8QeP5xEBX?=
 =?us-ascii?Q?scNIXpwl3ZahbTUhqAxb8x30lQ5ObzzF0U4wedF9MdldqrP3LiraQyqwicKR?=
 =?us-ascii?Q?h4yy2u9Fv4Mo96bR+zi6GzyVPeq2kjMA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 10:03:53.7175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f4bbd3-ca62-4f01-84af-08dcccc8e222
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8314
Received-SPF: permerror client-ip=2a01:111:f403:240a::60d;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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
index 8f7ebee16ac3..ffe91dff3986 100644
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


