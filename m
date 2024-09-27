Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DBFCDD1CD
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 17:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suEnH-0007Jg-9X; Fri, 27 Sep 2024 13:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1suEnD-00073S-5s
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 13:30:11 -0400
Received: from mail-bn8nam11on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2414::609]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1suEn8-0002qv-R9
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 13:30:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMFdpn1KSrpIW98bjqiKlRcLqxuFQm6JhNijaX0jbgB/DKkZ3Syd65aSnHyGG74MaxpSKABJWk5rEoIzo2yQZCL4YFhYjJqpyt+Q+/WwhcqQnIDYzSIEhXrGT7Z2W11ocJ3X7VVjdx1BiVvD2dM2WQHQz1HypfL8wQ8TcsOBPVKHsaK2zmv9+f+xhs69n7pVPN13XNJHM8ioCBFtrLkv0gSa0lCnEG8iTFDURL3K/SXnO3nchqQXM4TDd7t8dRVShjl6yU0cbJLYeFJ0DYw2NDcaEaU1ao+f9ok2D1VrK7IXVCpqw4I4cMaPzDNQKEHzmh74ZrDI2QICo5jkOajFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaTEiFHA7ihOwUMOM6FQMFuNJn3la7pQKoPMESzJ5N0=;
 b=ZYk3fPlzmBndWgnXKwTcCzAuPEJ55XoAltSZteyia1xF5UrtnMoxtceYfx8rgV7gjALvloeBGM7oIE1zRiZg38v7UfH+wVU2AbtsRn839fGk1QT1Qfyo1z/MDFwkrgLkn78UEN612cSQy8e5TouJiYI8qGvcEhL+F9HpKgfZLcAH5wdLLXsV4SutBbmf5aiHnudr0AjA8DzSJVOYF4wf0tsAi1A/ptf5moimT115psquIfSIdPKVKLNkJnSowH6xQz5buxe3Fs/8d6hQjXn3e5BSBrmu/CQSZRQ75c3yLwcxIgA9rfKqEIOh3OlXhZBF3QB9grVQm9jrIlWynob0tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaTEiFHA7ihOwUMOM6FQMFuNJn3la7pQKoPMESzJ5N0=;
 b=hs3K2N/aDux2ltaoO0/TDVqFoFlM7icCMjjwj80bkHyXUCcsYAHHWA61OM0Pe5wGMGvNFu5uDRvuKEGuMesDXBKO9kbl7/DsTjJJD8tdbBY/oI5dm6KDz96XccnPkk4YFQx6GXrS3bXUxtIMN1Ty1MKaqINqStk2UzwJGA/Qk64=
Received: from CH2PR02CA0004.namprd02.prod.outlook.com (2603:10b6:610:4e::14)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 17:30:00 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:4e:cafe::77) by CH2PR02CA0004.outlook.office365.com
 (2603:10b6:610:4e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Fri, 27 Sep 2024 17:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.0 via Frontend Transport; Fri, 27 Sep 2024 17:30:00 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 12:29:59 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <santosh.shukla@amd.com>, <alejandro.j.jimenez@oracle.com>
Subject: [PATCH v3 3/5] amd_iommu: Use shared memory region for Interrupt
 Remapping
Date: Fri, 27 Sep 2024 12:29:11 -0500
Message-ID: <20240927172913.121477-4-santosh.shukla@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240927172913.121477-1-santosh.shukla@amd.com>
References: <20240927172913.121477-1-santosh.shukla@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 90dab867-21d2-402f-aa67-08dcdf1a0395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QODd40mBWu6waPeoqAZaWmSshG4lRyhdWsl12dTht1qA4hZx+a2FImC6mJLH?=
 =?us-ascii?Q?aCHEBvDoMBZV4S6tvcXwCKwsa6AKIVWDUJQR+P6jSmq3tekeRfXnLRTyDqx3?=
 =?us-ascii?Q?LUbvHm+M75flg5hUmBOJV4KBuMT40ipuDawS3Lo5ky7OrpZbttlwTucaVy/+?=
 =?us-ascii?Q?I9pFs+NBMDU1Hu7Lo/dg0EVrD1hAlkdVxgCm4xiI0kUtFBFqaZ1S9kbgKREL?=
 =?us-ascii?Q?iO+c045aDQRjRd0klHSGsdu8O222GdlHEqi6EiVm2uWNlFOeBDOEgdVNsdVy?=
 =?us-ascii?Q?iQBTA2/1d3vXdayvQu2h39xLbIqGIzGgyghcg38R/VNiHjoZUuyrptajrzoV?=
 =?us-ascii?Q?Dx9QwFPzluqaL5gXLUPl7ZaG+dd4RxwORk9HmBAZnmnnKHbm9DZ2jX/sqTCK?=
 =?us-ascii?Q?3q9KngjFSBnJ6YYdVs5u4phjK/4rPxsayoCl6E7GRIGXPb7kzfjOvGMu+w1v?=
 =?us-ascii?Q?hjDYQ0wNWKC/ME+z1rzfVBnLxIWvjkz6YE4ag4Buf4oPolR5ndISWkgzQeHN?=
 =?us-ascii?Q?2DigryQ/Hf5Vl1m1GMz2D18kVB5HA6RnLDjwb3EdRv66TMH5A91nDwG540Hf?=
 =?us-ascii?Q?QHiLjF2bJNNyW3jofY9C6kwUq/KK17+axtD567t7BQSRW0OkAxcrnTsJq4uK?=
 =?us-ascii?Q?aJUE2xjnupgfy8rmnfu/pCBijVLQVaLU/c/EQPI7GuZXmsL7SLXczoKB0nMY?=
 =?us-ascii?Q?Xaem7/tq+tNKddcuQ5WRJ+GyXt1UwRUTrtG4FNyyxkV5cFZ/g/V0PLQUv+lj?=
 =?us-ascii?Q?sjR8ecV3rKQbDJLeT9TNrkueS7JcmicZqm0jzpmLquYZD3uJvCsJWi+YNrr6?=
 =?us-ascii?Q?K9rZdf+skIef8Iybr7/fLl9OCAnC2OAHGMUj+at0JLjvBDYZ6dIpyVBA/j14?=
 =?us-ascii?Q?cv3LwL5ldx3DwudQCFK7mybGwMegk2C477OjU/++5Y08X+CZlGWHduxqRpnq?=
 =?us-ascii?Q?MXrZvjf+7hP9XkUcS/cCwlHUVAHSmTD9RFEObslfOBu8PDW59Ahsov5SjkhK?=
 =?us-ascii?Q?2WlWwjIBpCaRRd1A14KNdkgFLX2dBPuKTPpqLqIZs91zyYlRLnbWI7KA4H4H?=
 =?us-ascii?Q?CIq5R1G8EHsW5kUjW30K/KQWzxt11IkN7AQSoZZcqqoBRdG07iYBA1bDbeJ0?=
 =?us-ascii?Q?UcHL6UdV2PB+ctg1v5AVlPP5JlccZ0DlXsJqfN4Eona8+dbCvH5/FiDuWta4?=
 =?us-ascii?Q?2YmH4dFu+15nmg/x7kV0F6Z/xkGZ9J8sKmV7gyQIBv58ZMhqeTDAhF02nk6g?=
 =?us-ascii?Q?9h4jOn+pPNfdyumLFtzv98m98SYWpB8Fn3Wg68DVej6tksPYv2ZRr0k63aqY?=
 =?us-ascii?Q?qEGVb+qGPet5iL4Gw3hjlMNtbMGc5188x2Bg4BPUDVUvoUG+pqVPR3z8PIpP?=
 =?us-ascii?Q?3c9968qw42I+FnnOC8el9+FsKmL2Gr++yu8N5Re7Gb1v9T6K6yjxVczZYo3A?=
 =?us-ascii?Q?wAIP7cSDxfnEeFCNiIR4ifdT+3zJRv5p?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:30:00.1270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dab867-21d2-402f-aa67-08dcdf1a0395
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313
Received-SPF: permerror client-ip=2a01:111:f403:2414::609;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
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

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
---
 hw/i386/amd_iommu.c | 22 ++++++++++++++--------
 hw/i386/amd_iommu.h |  1 +
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7c7760c57330..9b923f6eb482 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1443,7 +1443,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
          * |--------------------+-------------------+----------+
          * | amdvi-root         | 00000000-ffffffff |        0 |
          * |  amdvi-iommu_nodma  | 00000000-ffffffff |       0 |
-         * |  amdvi-iommu_ir     | fee00000-feefffff |      64 |
+         * |  amdvi-iommu_ir     | fee00000-feefffff |       1 |
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


