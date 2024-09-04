Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C534CD4847
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slmrj-0000Lb-U4; Wed, 04 Sep 2024 06:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1slmri-0000K3-Fr
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:03:54 -0400
Received: from mail-co1nam11on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2416::624]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1slmrf-0005zz-P4
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:03:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmfp14lzYm9mMdno2y2iV6ARlhH3i4I9rG6eRekEiNB+mndPMqm1f8b1t0Atl8CSWh3OVdPN1GNf7aZUhD3I4YDnbXax06+jn8ftH5UOADZXEG/Jr0jZAzLwOua1+/9LnK8cyBpdRemTMPAQdwjFrcZtGA06ntcqLZmJoROpG0J5mAjVvyLgTev167EiC+7zh7uEg7DuxQrx/hqmaQ+odi+xRXd/m5bKYNIaVJMyC4jozfDKYO0+xrfHIUB36jDo7UouxqX3hWuYKG5uYeKuEYty1G/MrT8wRnnz2v4y0kmghv7yOxQg6PeClU3n/G58Z1aQldvlks6eLjgLf3uS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEkPYhh9Ha0mFPI7Ylba9YXaKH/58LyVQUwhqZ6/xYw=;
 b=PgAl3ys9Rtcy+dxfLvQjHMUnMopExTNUJB3HwsySHTX+qZ+OR23TOoZR1vmOSdJe7RQzcGWza5lqTHVrmLm0fWR6kMNXTM/ioHUDukKkCjHb20Vincfev4dkJt2FlOJi4UE3Utaj1oaQd+StejpXgalqBrJLMKrLMDC6PlMeeKV9uUBGRSSJsDqJwr5VTSKVGdenWuBP7hZ/WwhH73HE8//7S59ma3Z7Pllo3iCUB8+8cYmQJr+ZuxECp8LRKLUmyMS3IQXVIyOjS6yZT+/+uOI+l15QzPwfFcQrkOdNdryZ0jMSN6MAF6ZoEjy2mZbTaW0dikXBWSiqo1A3tAYV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEkPYhh9Ha0mFPI7Ylba9YXaKH/58LyVQUwhqZ6/xYw=;
 b=tLBxU4SYKAEMtfFUQ8BiHbf6Sr0cIwEazDmRvz0DsZ5gzFmnTC1/rGNPKw5M8EFxEZJRuXOssSN3miq0RU/wohEtJKQ2GewIlRVWMyuUclZEG+yoUvt6JwV7PXdF9MW6c33eTv7+UO1bo4rS6YMtKMGDe+2udAbtL4iLkSGep18=
Received: from SJ0PR05CA0140.namprd05.prod.outlook.com (2603:10b6:a03:33d::25)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 10:03:43 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::2e) by SJ0PR05CA0140.outlook.office365.com
 (2603:10b6:a03:33d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12 via Frontend
 Transport; Wed, 4 Sep 2024 10:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 10:03:42 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 05:03:41 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
Subject: [PATCH 2/5] amd_iommu: Add support for pass though mode
Date: Wed, 4 Sep 2024 05:02:54 -0500
Message-ID: <20240904100257.184851-3-santosh.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: f05e22f8-ae55-4e4c-7804-08dcccc8db88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nvrHYElMf9VrG7IBFpcJZbcY84M/Ha6qCKXbCnn6wE7M2gXz08c4rtFf0pD/?=
 =?us-ascii?Q?rjN+kWBgrSAxw7Ir5y6wUEPrNrHvf//90pZlL79Fcb5W2vlL65jGc1oy7STG?=
 =?us-ascii?Q?2L1vcskMr4qBVdPLfBt2g6/Y2z78IFZTQHDKW7rpNy/aYaeHaebVX00J6P/Z?=
 =?us-ascii?Q?YgDK/xEZpzEbV7gE4E2mOcfHIVzR3y+swy29JKYB0ct3Svt9blDgyjAA+OV5?=
 =?us-ascii?Q?CknOQ0x+v/xGy4fEh+THTvCGBgPlzPpSLveuwLEY6ySJlQt+1lxGyQnm701s?=
 =?us-ascii?Q?ag/0t5MUXv005n/jP7pkvNiqAxjaoMIGHx5CIIqL8fhVNjfziUX6mVZdf9So?=
 =?us-ascii?Q?t8oy4O4XK3j6gNRFfETR7TcZ/EqrKAgvPRTZi1/MD8RuVaKhr9UZIjpk7V5X?=
 =?us-ascii?Q?mvxS8RJOnTK+TUFDTbkiz8xc4yuQakndLXibAedp9/8l5ZukxKhr4gfFkAfw?=
 =?us-ascii?Q?EK0GKryF8zMDVCSSN/1Phks6pAvAEZZ4tJn6CWhQA2Fy0okk5Bns0ahFYXeA?=
 =?us-ascii?Q?y2gDMcimKtI3CEHGXnBZ9RBHwHrk9R++UeTZSgIjXaeGAalK6fWuRksQdwHd?=
 =?us-ascii?Q?f0zLnO2rsMxLQU8HdOtITEKzHUIAlfJ8YpnQa2W02PmYu1muplxjku3XFZWs?=
 =?us-ascii?Q?Sg0vgSUcYGmVIYLPepV00SOC132JYo3pE90RAEQ6X8fDYiKOUGLr14eDeInD?=
 =?us-ascii?Q?fHaQgGpsqxeJQ5bR+ISFWbAiuMIwUsLARQ65KWfK2Cyi251LGkcj0xSwbT5V?=
 =?us-ascii?Q?2GvaUSnaydv/j26BUJZfZbBhnYb0Rd1qn9K6NJP6pjV22/V0zaxccdbIyxc+?=
 =?us-ascii?Q?Rnb5pcYp+lcP63fJlWRAX43YH58z44Bi8du9P69pGwtG1p4WTJwF/a/gJ5Af?=
 =?us-ascii?Q?K6EY6GCX5iS6p0VBLp5/rsYcsRUtbXSQVTWEnuU9jOHsW0gfjfTqpSuOWuac?=
 =?us-ascii?Q?E9SraigZ+rtFq0FD9BEHaXRMuEbAfwelv7PyGoj8oHAbQEbxQpMb7IQZDOeW?=
 =?us-ascii?Q?Xpt8PSYA0aHVCS/VyRRft+dp4dDLoJeeOGKhUTkNIlve2v4wUqO87CJs0iys?=
 =?us-ascii?Q?8cqo6Opb5H5maPz8ayDtTdrVcZLP1j0Tma8ja6kNBGzs26jLXhJpdhKeVk86?=
 =?us-ascii?Q?vIrK1k+cDA7B4/z3GXWz2gugk560Vbb3e7sZCoOwFtdhn8Zgs7ipQDW9ZyZt?=
 =?us-ascii?Q?Yl8ePgKOokXktOCqscnw/YvyD5YI/izTheg0BKvdFYpCn4LNiAspmiwNJ5dh?=
 =?us-ascii?Q?Cxay4KoPM9Jfl+XrPSXoXaTwGJVRV3dpGohsAkKB9dN17PPtSs3pDc+TdH5T?=
 =?us-ascii?Q?T3wshAVAj1Zmxgt5OqrEimfT5aRmbbAO5Dhh+9mT02J0ceiUUbjGRgzeAA74?=
 =?us-ascii?Q?c0tqnIKBB7dc3sdZqKkj9zZwjY9GuEM0pYZ1yZi2cPr3LBo4lF6egKup0VAI?=
 =?us-ascii?Q?Xf7CW1eiVgg5MskNssfmsvrxl5kFC9t1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 10:03:42.6572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f05e22f8-ae55-4e4c-7804-08dcccc8db88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
Received-SPF: permerror client-ip=2a01:111:f403:2416::624;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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
index 148b5ee51dba..8f7ebee16ac3 100644
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


