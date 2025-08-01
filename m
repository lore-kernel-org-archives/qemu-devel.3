Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ACFC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 06:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhiv4-0003Ul-5d; Fri, 01 Aug 2025 02:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uhiuK-00032k-3O
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:06:20 -0400
Received: from mail-sn1nam02on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2406::609]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uhiuH-00050s-H8
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:06:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzr4YBvH/TNxo9AHzAYb766/2Uy7atbm6uPdq6gDiW/9dbaKf5pmekWSIBXdf6uB8xoPoavRCJS+m8uzurCFzct1B/+KY2B7/zyTwbgphQm1Q/VQBgcUygT1ypHJLoYFQ3foJZp1q7u4AvYqlqmTSp8eBB/jWgtkJhpmrcY1Zb7ggY5Hb4Kum4PNH0WleyzEt7AvcyUCTWOl83SMiQckfqG5940iGiljf7FHlNoLQYwQkgyOLYBas1wip8dMcmfP6VcOSPXZImhzoDtjeYwrBvClfzNPbpjVxlyZy0g5VyUty8yXuNVXtVvAeXRVSURfdcMX+S49wxeCXZh6UKS+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uQnYz8UQAxrlybbrrUDW4AnA+0RSG/ldYIXG2fKuWM=;
 b=OGWkTA7CPn0loT1XBpe6XgoIdh+jRFXBev1ogp4dgTuZqsv6zoY56rMKIArIdV/ohi50Wuv5RmBckyOsu4a5OS9iwrdYUusiQ2v5dVvUaLswTWA7+zCNgyanyWHFxApByASKe+pkTswMPBbEk6av+37x3xbBGjlK4yLCAtnRe2oFzvSMPMvdQXY2gGseaDaYkayUG/9gjw8U1L7gYh6bPG97Th9fsHmZ+qQ3c3of53k2IhztApX04Oz8Nyt9lHqimPsoPfheTs6oS55x9WIwbJ9cIqKTqG6Hl0uW3qEVIg52qs2Q0v9B5q5LrVZWabulkxhzt0mZrB3Mx4BRzC5r3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uQnYz8UQAxrlybbrrUDW4AnA+0RSG/ldYIXG2fKuWM=;
 b=yakcNsLqncvu4jxMZXNZNxkl7+/SSY8xS44sKSSPiv7ZV3i+8RuAbG25VCGtCqg8ze3gX+2DJCwHC+IlTlIPofY24zSsoA/3icO8pRAaFkOe/hPxTBejV2h2vT2M+zFGvLur2EhGihUppZWDwVaCzSS6ZmLFMnRo8GFFsKr/yHQ=
Received: from MW4PR03CA0257.namprd03.prod.outlook.com (2603:10b6:303:b4::22)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Fri, 1 Aug
 2025 06:06:11 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::b4) by MW4PR03CA0257.outlook.office365.com
 (2603:10b6:303:b4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Fri,
 1 Aug 2025 06:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:06:11 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:06:08 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, <Suravee.Suthikulpanit@amd.com>, Sairaj Kodilkar
 <sarunkod@amd.com>
Subject: [PATCH v3 3/6] hw/i386/amd_iommu: Move IOAPIC memory region
 initialization to the end
Date: Fri, 1 Aug 2025 11:35:04 +0530
Message-ID: <20250801060507.3382-4-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801060507.3382-1-sarunkod@amd.com>
References: <20250801060507.3382-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8cf1f3-b6ba-40bf-a606-08ddd0c183e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9tiPvjrqIxrxtTXi+1squ5t8aTrdaP4VG8ViNsRWpr66S9NgQwyMlJYauyZl?=
 =?us-ascii?Q?ZVbKDTwLcvCWMw0D572e7nXkwY9TI9DEyl7Tz4XcsH0y/Ii5aZVxGpuLQsch?=
 =?us-ascii?Q?wY2apuIFMqPyjTDd95MkiFppiUbu5lvpu5xcfek7eleXNG5eUTL12FGjGa4Y?=
 =?us-ascii?Q?MUUTyU/jYFe11CV6g3G1qRZsGpiPXwCm4fzRLbiZ5aUN27/V0e7J5BLj3gOC?=
 =?us-ascii?Q?rT3+PIUYXlVPQWUYI08Djue09x72SS86t668EzOm22YnpUgGHO2gi6o+i1vo?=
 =?us-ascii?Q?Y3X7nbJjO7CwbPuQbsBzohP+M5HLLYXWrIqm98FoQuTSOrZDTQWCjFVlYYpa?=
 =?us-ascii?Q?GRlFdZElheiHwukFCfpdEGzGACclin0SAMwabs7izdCxi1fkPuPnPq2F4A7A?=
 =?us-ascii?Q?+QaAvFvvOhRbxBW/69JPstTKGlk0jndVU3Xwr++kScnLEEA1mY9b+cbPeDLS?=
 =?us-ascii?Q?gMVv9AhJ5AwYPRFirIRQzf/656VnM+gejWd0TiOAPnONngBY7fcFoXQu4pNb?=
 =?us-ascii?Q?Hss1C7tm44O/88PKD303XU6cL2YgKNug3zEPe1yssG7vrxaAN6gzSiScvA3n?=
 =?us-ascii?Q?xjyYayTCbMBHN31Yby0Iy7INUA/8WkwvKSE5UJBKGK6PIwAmRr9nh7ntYIO3?=
 =?us-ascii?Q?ZBZgtbrLNVvXu9dnpLTFIMgt/fn/5PAs+Z0ikTkjKZVk5zxy18nTsfE0eyCZ?=
 =?us-ascii?Q?MyK+gk+6lzqsmR4FWdvmoDNTvxs0PxF23+Y3Rk4XkkRNIm0Gi/CWGg26+7eY?=
 =?us-ascii?Q?vz708OZ34KpMwH+sGD7pgtflyP6Y/ukSJvzzsggUF0AHIv9/rkga9p0L7CLB?=
 =?us-ascii?Q?ovriVvj1EgNIK+21SAVCx3NhSon4gidPsrT38449D8idEMLHsPX/60+XBnNc?=
 =?us-ascii?Q?hkaIzPrtM7pr41zoZQoiEEiIPr8KUkSLW91qrebkJGERoMJ0j4MxsMj6c6wa?=
 =?us-ascii?Q?FcsEX/NC8E3UFYzTrmvIREb7CLvX9VQu2c49wEegEqvmcahUMdu6ROBRe8Nr?=
 =?us-ascii?Q?wf5vxtPKewhfk0vxMFxLeS5r89A4Fov+A81FKCFojsZySuGBiJ0+pgRubVs+?=
 =?us-ascii?Q?2I7c+kownQd5Un59X1/kIYWNX5ISHRJGuOO7u5ehN4Eb1idMTHoZlwUrMaTX?=
 =?us-ascii?Q?JHvq+oV5tWHVLx319eGsOVO3B7OVYtyrBw6u+VvIW/TFzk6NlC/FeRKOd3dJ?=
 =?us-ascii?Q?pChXwG6N0x9wg7RlQfKr8gPgMNRGn0IpKLgErTpCa7tbunkqEtBO7Vad7lD/?=
 =?us-ascii?Q?PXNVnbAyh45oNLgqgrrRB3fsQ6S01tvdw4zWODmx7QsITGJgch+xofdESL3S?=
 =?us-ascii?Q?LOqr3KhLVle7N/2fBcmvbTzozDQ0ZDBwKU8A0JcDyMxRNmyKzpUQQyQt4k9Y?=
 =?us-ascii?Q?GWMNKfIku+2ss0Lbj1n2ShFUm6hIv+gGIOJSpU2xRJOMxpQxHrf8Ha15ej5U?=
 =?us-ascii?Q?9GdKXiSkX5s3u0RFRjdmn2HOrAtBf+Aor8uvsCn3rduRcqrgGepYA1TTjRmW?=
 =?us-ascii?Q?dkPE9OJ+bhDsLpZOQ2V+cfkkcJfMg1ZEWEoe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:06:11.4998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8cf1f3-b6ba-40bf-a606-08ddd0c183e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781
Received-SPF: permerror client-ip=2a01:111:f403:2406::609;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

Setting up IOAPIC memory region requires mr_sys and mr_ir. Currently
these two memory regions are setup after the initializing the IOAPIC
memory region, which cause `amdvi_host_dma_iommu()` to use unitialized
mr_sys and mr_ir.

Move the IOAPIC memory region initialization to the end in order to use
the mr_sys and mr_ir regions after they are fully initialized.

Fixes: 577c470f4326 ("x86_iommu/amd: Prepare for interrupt remap support")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index d4e10d63a606..1ffd1375570c 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1698,9 +1698,6 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
                                      amdvi_uint64_equal, g_free, g_free);
 
-    /* Pseudo address space under root PCI bus. */
-    x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
-
     /* set up MMIO */
     memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
                           "amdvi-mmio", AMDVI_MMIO_SIZE);
@@ -1723,6 +1720,9 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
                                         &s->mr_ir, 1);
 
+    /* Pseudo address space under root PCI bus. */
+    x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
+
     if (kvm_enabled() && x86ms->apic_id_limit > 255 && !s->xtsup) {
         error_report("AMD IOMMU with x2APIC configuration requires xtsup=on");
         exit(EXIT_FAILURE);
-- 
2.34.1


