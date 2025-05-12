Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3887DC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 04:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEKe3-0005RB-Lr; Mon, 12 May 2025 00:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEKVI-00048O-Tj
 for qemu-devel@nongnu.org; Mon, 12 May 2025 00:11:07 -0400
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com
 ([40.107.237.55] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEKVF-0004UQ-9t
 for qemu-devel@nongnu.org; Mon, 12 May 2025 00:11:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKlCJ8fYGKIA0osB9vG+DyzRUF30BFGyFdDW8eGUcbcHzJ+2UaKU6DhwcTV0dpG1xj0i0mSU5K3p3bbzV868IXDkdaBEux8uOe5jAMM3G75sLJOuyOZ6bB8aycVK61k+am9ZNHYGqfj6tW22RPHQONuceJAVwj8aj2dwmH0+EKiXtcTEUy0DIAHUAmfclKpU9JsfZh4gUWJ6iSunJ2mvZfbnrPR61sefYZr7NU4GHn7dx5mimjZC4fHZjcrLuVhGBFvt5s4wDwtY+wc8NCHOlia8+zpZOTZAiZubTu/JNl0LSDXVFobuQsx8/SdJdsbbP3fNy5ke7WCPBP74uDuzcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RrZUM8jblRswFVZN0NYpda3fW+fg6tMd9awM8EiahM=;
 b=Hx7qxo1uH2YkDkqBn16urzOC/C7DFs2BibBOHo/pTPr7/Yn38zwpO1YM3L9a/RVKbf+jGEHfR2pr3CKtSOZ9dj3O9WVFp5MK9n89g92QRHYhG8RjRTvpnaPjuHaJhDQOcPSJCzmw2QUqfQf2AsCEvtHq520Dj931jkxtC1q08DB15+OwWJQSjC4l4WWhNNIVuTvyQAwjAmnywnlp+MQwjhrdvuMPbaVmVsy1b9aOhPYvPKiSdiwNt3vm7CJ7fZXqRJuoCNtk+bnEuniBTP0F2EnNU0YZnOVFNigTGR6psf5c9DQzD//HJTIu0oC+gpMcth6kNo5s4T+O1N8yLKUC/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RrZUM8jblRswFVZN0NYpda3fW+fg6tMd9awM8EiahM=;
 b=grnVCcB5EXiThorxwPPC7hN6X5Gwnan4iz7cWSWEohoY/4R0oeAzxc7N3ujYEZndnAVerx2fsr1uNMwojMo7HcayYBGA9NC+dX/Ngq9UqrAKoiKzTotxyfUPWKqsiWHivrXWIvpzpBLBfpKbEDXXkpBECullhQ75EIV61P5hHZc=
Received: from BN9PR03CA0190.namprd03.prod.outlook.com (2603:10b6:408:f9::15)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 04:05:52 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::55) by BN9PR03CA0190.outlook.office365.com
 (2603:10b6:408:f9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.29 via Frontend Transport; Mon,
 12 May 2025 04:05:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 04:05:51 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 May
 2025 23:05:48 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <suravee.suthikulpanit@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <joao.m.martins@oracle.com>, <sarunkod@amd.com>
Subject: [PATCH v2 1/2] hw/i386/amd_iommu: Fix device setup failure when PT is
 on.
Date: Mon, 12 May 2025 09:35:37 +0530
Message-ID: <20250512040537.15557-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509064526.15500-1-sarunkod@amd.com>
References: <20250509064526.15500-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c10b91e-5829-48a1-8fd6-08dd910a4925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OktpWFvA1/qJYNJVfjyNvUzgE7q+8d70Pm1lR8k7AdJNfvCXPZsHLNUYZIUq?=
 =?us-ascii?Q?jUSNBqxwLkIuxrLPBBYERjszNIASB/clhVquDRzl7/1XTMnsubuEk7faL9jM?=
 =?us-ascii?Q?sXu9YXyY7HXK7bKpv48quKWL/w2vIhdDULNM1t+89qs5rWR/L8D1CfI219gP?=
 =?us-ascii?Q?iValB9GS+P7UeccUeVRiUfC9WTOB/vEhO+QQb28T8Mmw7n+xvV8Jxbwns4HC?=
 =?us-ascii?Q?pFfXh/l2wRQo/+rj1A0PwyZA3WmNZtPJnH/wjDeR0vJEuI/KYs0SxRwnftYZ?=
 =?us-ascii?Q?ys5Qvyn5YY2j8wKDdWzQGHFxc/5ZVsq4KRD8UhMh5gBv5Z9dgDI82U01NrZz?=
 =?us-ascii?Q?U4bj4NXdMFvRgPI/Ho75KtgsNwlUQls0hMarqfMm5ayMP8oTjAd4bhbl5y26?=
 =?us-ascii?Q?vBqbDazGzXfGyY2igaMDw0EAQJ/myXDIRxT5P7jg6drk5WGvgdIQbtoC40RD?=
 =?us-ascii?Q?YSxRKCAEIur8QLRfmN1bdvhaYhCsgYEKbDjlpuLw3e15c1g1+/nsSqhylUpj?=
 =?us-ascii?Q?SWOUS1S/PZVVpB/m40fNFdG58c3LJRgoP74hdT3Oo3lU2DO/Rl3S56tuURqz?=
 =?us-ascii?Q?SXtMdcjtJ36Xt0hD1vnbt4S3GTMF+9zOS+NH8PYNW+36gVKVwTaflFzIuKf/?=
 =?us-ascii?Q?j2oitMRz3nPjU419KGIFjgdB6+YcavwBtj7gpR87MMjKYlrbgK/B8O0l0wxY?=
 =?us-ascii?Q?Y5EsPmcNx8U1/wko1TFjSqoq2Dj8n6QpuTEKw6dhJZU0u7eFUmYIxjktXCsI?=
 =?us-ascii?Q?5AtzFs2HfF3rXamS4iqP0JnSONMmizYHKGunmWWyxcrVM2koDgTkLJXrdNIu?=
 =?us-ascii?Q?rfxjfP2W5vKH+O69f+CwsMUYsBqS2UVhLsvikZWyJwSR+ZpivrhS85YUQdRu?=
 =?us-ascii?Q?WEKqt0Go6hCGTSiv3km0sPhXp4Rl0XDrFJNpR73m3vap3y1bWi4zTvNBRaL+?=
 =?us-ascii?Q?GBnLEpsnvQiZL9Zk9P8GYSO6hDunrGKjGT05XB9PgeZlLxQ3CJRyM5kA2cJC?=
 =?us-ascii?Q?PWw7lTxfKuCFADygCYJGoMZQg4uxdTAEaWXiiSIH2t1GZ3qVXB8DRpdQhGpy?=
 =?us-ascii?Q?svuTdKZg2VfasOHhHrtJMDhxFWcddVG5gzn4UgG/H0KKBuNUTQQDBvpSdrZD?=
 =?us-ascii?Q?deRfA5xBOzUyWHgIfRr/BrPyTj7NAHe8kb6m7Iymb8XDDkxBZeyfWnUuzk7n?=
 =?us-ascii?Q?ORydyuMxdEV5CuWjie5IacQ6vXCGZeGtQBACDy4I5Q9fa9/uI4L/7h7Z5bkd?=
 =?us-ascii?Q?dj5W3GuUfS2HZL5+IwYF9ao5TPgaErEbKNowtsuTh5hakF9GDcIzSEkArZb+?=
 =?us-ascii?Q?tH4x619hREIROuQXHq+BGPDJsPQEZ+JkxU7IL6zBrCaSyzti+4KesLhFVyD3?=
 =?us-ascii?Q?r6RbfN5yUkn6fUGnEGoVwIHyCZtHdV5ZamMqLNyuijfsWGNsMmz0UZm/Ox1g?=
 =?us-ascii?Q?lvSf9qjqnKMEJB1zI//gB+aWzGMKhv3iZbtunFVV1JSUPMt6hHfmJ2XijzBU?=
 =?us-ascii?Q?/rhXpThbra6cMQRx6pXgFq8MZ7YieFWdY29+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 04:05:51.8923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c10b91e-5829-48a1-8fd6-08dd910a4925
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
Received-SPF: permerror client-ip=40.107.237.55;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Current amd_iommu enables the iommu_nodma address space when pt_supported
flag is on. This causes device to bypass the IOMMU and use untranslated
address to perform DMA when guest kernel uses DMA mode, resulting in
failure to setup the devices in the guest.

Fix the issue by always enabling amdvi_dev_as->iommu, which is explicitly
created as an IOMMU memory region (i.e. a memory region with mr->is_iommu
== true), and it is meant to support DMA remapping. It is relying on the
"side effect" that VFIO will try to register notifiers for memory regions
that are an "IOMMU" (i.e. pass the check in memory_region_is_iommu()),
and later fail when trying to register the notifier.

Fixes: c1f46999ef506 ("amd_iommu: Add support for pass though mode")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5f9b95279997..df8ba5d39ada 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1426,7 +1426,6 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     AMDVIState *s = opaque;
     AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
     int bus_num = pci_bus_num(bus);
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     iommu_as = s->address_spaces[bus_num];
 
@@ -1486,15 +1485,8 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
                                             AMDVI_INT_ADDR_FIRST,
                                             &amdvi_dev_as->iommu_ir, 1);
 
-        if (!x86_iommu->pt_supported) {
-            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
-            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
-                                      true);
-        } else {
-            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
-                                      false);
-            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
-        }
+        memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
+        memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu), true);
     }
     return &iommu_as[devfn]->as;
 }
-- 
2.34.1


