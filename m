Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132A9CDD1CD
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 17:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suEmz-0006Oy-LH; Fri, 27 Sep 2024 13:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1suEmx-0006NS-Uz
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 13:29:55 -0400
Received: from mail-bn8nam12on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:2418::61a]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1suEmw-0002eS-2S
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 13:29:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B91jRYK5notV+HKWE6LNhuPdLCb8MKpiaBZ/rmZOOUMl2nMxNKQek/nRXvDNY2NJquIRx6aw3QvMS2QtOy+7kPr/xXft45hhW3oGjzeU++mfo2ShbDHTiV+QEhMT3jVwVE1CnAj3hM1V3BdygCBZA+L5wkTFjlHTkvVj/H6lvrgog7qF4fZGBWZLwOoxjNorkrt3gZuzx7PQpa6TaFpK7ex8betwy2xDFRFybSv4yzn36b3joc+PoBEbTbIZ+B/77447vnZe8bEnqtMTKhw3l3FIv4f3z5yOLk+yFlzkVMmauNgRjDP/gkBPsjCpGANheR4L8fD3k6nVNggEz0U1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3ErdNQw5r0Go8Ol4EVxRjdNp5E5Ifadu57g0Sh5KgU=;
 b=f4yt4TMpr+llYL0LTwzvE+oOsdhptjGrSvr2IaKxblwjH9x1TmhVqJ85CpuiPH0XeqLN7oAZ4iX4bDdVhwvAegw7wF0L7eT1oru3Ysq3aMlV6aH2yTr2T5IFwVAD3S9ZHwxouL4bzsid02swolX75XL1IbhSA2D2pPKdNFi+SlpupsHWP7dBi22adDGBmzroYIKp1X1QEyggo7RTwEShLibeMIeCbacCxHvgZLuk0ONWA+sgsDA27+xaXm5JosNYMBB/mAPb2eqRf85cAnHzFMFkaG7Mq/RIGagW1UXCrzo5RRDr2zHQNWuRI7ZKt50BbPUGko1P4wkEX3m7eE8gJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3ErdNQw5r0Go8Ol4EVxRjdNp5E5Ifadu57g0Sh5KgU=;
 b=tIbLecORhbdWpvU1E+FVrqTBif73KyqNBEZYZnE6IP8BTvUfKLVEeUMN76eTlQYwPi/fYZ2DpnPw4Xc0Pe5j3OAYUcd4P3OytvKK+W+z3IWLCzcqrI5RM3Tn8tSOp3q/+94N/iIzUQLlC3f3bh8eUAmyEAyWBjPZ0ehKSIfORws=
Received: from CH3P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::11)
 by PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 17:29:49 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:1e7:cafe::4d) by CH3P221CA0001.outlook.office365.com
 (2603:10b6:610:1e7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 17:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.0 via Frontend Transport; Fri, 27 Sep 2024 17:29:48 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 12:29:47 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <santosh.shukla@amd.com>, <alejandro.j.jimenez@oracle.com>
Subject: [PATCH v3 2/5] amd_iommu: Add support for pass though mode
Date: Fri, 27 Sep 2024 12:29:10 -0500
Message-ID: <20240927172913.121477-3-santosh.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8c2719-1995-4c88-c0fc-08dcdf19fcca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+v97zwDtJIoQblJak/eLq1d9hnhASxJk80oz4RhEg26oQl+XNrqd5nQl6Wo9?=
 =?us-ascii?Q?6i3F6pOBnaaV2eS/wX4+AtKcQvzc5IaHctUI5QxgAumh40jRk6XoAkNJrD8d?=
 =?us-ascii?Q?Fs+OH9aBW359xIG1yaYDFNmS/qRsbPDxKPcy18bd60XjrKMLo5gyQBeCDyrC?=
 =?us-ascii?Q?s9S2maDuYbXdH7eE9F0rIZsqq3B6undTO2JLS6bOR3l3OvHLtuEHtA1GtHgu?=
 =?us-ascii?Q?XhmkfcwFctAYmAF+RKQ8S5h+ZY5JJ4lGWOO/uENZ/V91Mf+EyGudiiKTdEuq?=
 =?us-ascii?Q?Z1mFzNcfK6NEoD8dB1EcdEklQrIZic4Stw9Y7D0GaGJSJJLbJrNrzpzNdazs?=
 =?us-ascii?Q?QuYrmA1udV+wtNe0Ev+KjkF754W8hUPKOf/d+av44eLZk5BzrKCwY6Y9xKDh?=
 =?us-ascii?Q?pJPfi5W1vMtTN2rYRwXAdZJO35mko2UdLI1FQXI/0clKjtsMjpzISwkpyxbl?=
 =?us-ascii?Q?yJ+3MQ9XKfcSYyBGpN9199zFbzUNuk/KDm8CRmok9VB/KZonhnAd5IDn1DCQ?=
 =?us-ascii?Q?3VaP0XnnbzR+6W1UYIOFju1BT0WVox4c5/R3rMrXBtFv9l6mLl4oURL4UYgO?=
 =?us-ascii?Q?p04K08NGl+ZlKB/acC7R4/S2zW5V7sa9WMoyCgZm7gzl9+d05ZtWOaVwhqp5?=
 =?us-ascii?Q?4odgCS1W7lBM9wALBtS5oVWJykvQgCRIEKAg68vw/zB1jjfak/jTUfUOlh3W?=
 =?us-ascii?Q?awCM2F8ViwTP++bMDu/Ko5EJ+xSiEwM215xNLGuf7GuDyy+rjbLCuvwXIitW?=
 =?us-ascii?Q?KO9mA2yVKTqT9soULRGzOk7vrNl7lbS6oifIuGOAdWlkQCI3cQwJM4GNwanI?=
 =?us-ascii?Q?3BM60UTnHFiHQaKmyRwLcEsi2iQnLe55XE6hJvV/WfKq9V63y8hWcbdFOmJc?=
 =?us-ascii?Q?Nsm/EP0eIiEudUZZ10AwsU1dssgW+xg6jk5YGjPgROWZPjzWi4p8iF9b+hZr?=
 =?us-ascii?Q?dhQJrZtL0PegMFfUsXhLjX6XFnbCNXlv3HxZB8Z6nRDQagiz8REVjRD/xDOn?=
 =?us-ascii?Q?Zc82+8XQw0M5ZuoOE0lpsMUo0j7eeWfvEM6SlFRxiLMDmOaszmlB04K7RCh/?=
 =?us-ascii?Q?ru7qdw/i7m+VljNr+hfJY0RTz2uhojuz1eqKr2OmH1aAnEF78NtJsFUB+8DZ?=
 =?us-ascii?Q?THkafDMDETitkBVNhSUG/5vX8TGzAPj4Ol88KhIDSQckWADp3a7d8S2L6h+Z?=
 =?us-ascii?Q?9jIPys1g4GRRx16WlFBM88PX3qSFFRgV3aGC8kv+gqsXa3WrokCORTOrTBMo?=
 =?us-ascii?Q?gJf9IZc1iXb/z6DSd1j97a7vgoGyqr7K8O+P6sgxM49qAe5YV/jNRuHxYh6t?=
 =?us-ascii?Q?XN0GxDiCQGZBzpQk0a4/ZGWgyrQjCPBQBwstVYSx/pLEQO+MeAGVbiKwYAeQ?=
 =?us-ascii?Q?R2prdt+bW9isvgSUN7yzeTgnlA3k4o3NcmVjWqGtoE5EDRYpbk1MxJwr1KHt?=
 =?us-ascii?Q?EJAltI7MvmL1FZQkWnvL0NVHC0O9Eieg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:29:48.7465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8c2719-1995-4c88-c0fc-08dcdf19fcca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395
Received-SPF: permerror client-ip=2a01:111:f403:2418::61a;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Introduce 'nodma' shared memory region to support PT mode
so that for each device, we only create an alias to shared memory
region when DMA-remapping is disabled.

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
---
v3:
- Fixed the indentation of _nodma and _ir at comment section.

 hw/i386/amd_iommu.c | 49 ++++++++++++++++++++++++++++++++++++---------
 hw/i386/amd_iommu.h |  2 ++
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index abb64ea507be..7c7760c57330 100644
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
+         * |  amdvi-iommu_nodma  | 00000000-ffffffff |       0 |
+         * |  amdvi-iommu_ir     | fee00000-feefffff |      64 |
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


