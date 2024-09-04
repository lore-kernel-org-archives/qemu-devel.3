Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821BDCD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slmrS-0008WU-6g; Wed, 04 Sep 2024 06:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1slmrQ-0008Vx-J4
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:03:36 -0400
Received: from mail-dm6nam04on20618.outbound.protection.outlook.com
 ([2a01:111:f403:2409::618]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1slmrO-0005vQ-4E
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:03:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ypp2bnUSeYScZT0rmVczMdnBIAIhA1o+HiIpnKBHTKV7DVpJqcw5nN0xIlPf85Hc6RfC/xddfYcVrsOGs7nI6MiSpqHT+u4xiYi0guhwLbCwOqVnct1GPW/091BEkpGNWgMHjkdAgqXS98pGtGwoUB0gjZ9KL5VLLovvdPfZ/vGhuC+Rs+QGwUu5/5sKi/iXLnO7vIzzH9Sanj5KMe5MRyiKo3QKEQmSQvnYoYcBQOIZy2A1aHQW76CmaciLfzw3dUeSNNOdCA3g5lf41yKTbEACRvU/PptQEKam46N6GtmXYMX9zsnM3+RSiE4bFWl6bZTT+GOu1Ht8sdqk1iNytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zWKDIse7CvL4yG6ZFopdMjmqXqgkuvCwLUX+oR0vfA=;
 b=LoKmaPa0fGOewQ03B5tMWlC9CoosShey84MRFuKAZg2HLUAD87f85ycOpIChRQWa4L671UVOitm1L+T6vVn2D6U0B/sf3LFxw9Wghwzpp+gxGv/VASz554V8Xp2gn1q6eBC1eYN6rPJ9b5MQsKcvfjU6U9cDJOq6bdXBEsOjPU2zDJxtfYlBCYm9VCfz1ULJw1MJc/6aIPYo0Gd9Abg8dUpXxwv8PRJU5trCr9aHii9bC6C54cxqj8UypDtg8b2zt2R7zTRGvdLqn7T7hpytNmbAYs1ceXEFr3inTkPqoC9to3Culj9drMPwK5/VQmtxeXUpiPWmvrJzJMzwNVaBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zWKDIse7CvL4yG6ZFopdMjmqXqgkuvCwLUX+oR0vfA=;
 b=2geDHgMHAlqr/R8+1mQqL/LGBDxx1JstdK/ysuIR0akRIAhRW/04RZNGnO0AkGC/HJc6ttqbbMHhQLhB1aYKEVNUrQA8PoI1G2wvG8vR3dYqLlInEWtjBZJamWTpdreF1qibAsCmaZeqpW1mUOms4pWIv968F8BRC7aXhodVxzM=
Received: from BY3PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:39a::30)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Wed, 4 Sep
 2024 10:03:28 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::25) by BY3PR03CA0025.outlook.office365.com
 (2603:10b6:a03:39a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 10:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 10:03:27 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 05:03:25 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
Subject: [PATCH 1/5] amd_iommu: Rename variable mmio to mr_mmio
Date: Wed, 4 Sep 2024 05:02:53 -0500
Message-ID: <20240904100257.184851-2-santosh.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: 75994ff1-cd88-4e98-3a35-08dcccc8d268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j7k9A8W2UcgCT/p+dSwvXOTGUYX/MQqmynqID22aM0ZXoFYfUFRwJix7niLH?=
 =?us-ascii?Q?waBheOgO8b5+Ta9Z88NkG3a4icS5eNt31KGHWg58sY0MCs4un4TASHURsgmK?=
 =?us-ascii?Q?9fobL3h+NRXzUtf6WQ5tlJRpI0FRTuAAG2gNyv32MfGWh9YWMlyesz7cCcLl?=
 =?us-ascii?Q?Fw0touBPwny8DqqvkncwguSDdxui3nipXOlcLga8ceIdnNGaMviVq+knaMN2?=
 =?us-ascii?Q?/enbqZQVO5Ijjh299BogiyfLvHcKD7k/8zDdj9Fv65ESJqL95SElPbL/xN4F?=
 =?us-ascii?Q?IfjS5vGGIi0r/CtwSjpBMsLSXn7wQ494HGx+EVlq2KuaThfP+/uoEQVULjZt?=
 =?us-ascii?Q?nJovCA47Ngw012F7bq3mYde04sBP+2Lahyc2HZyuubFjcNc+ZJ2lGHVfWmIK?=
 =?us-ascii?Q?/93yp6WQDNgdZTrKwAzlYoFiZdeiofLfO9qE15p6OXN7g6kJya4D3F4+KpqE?=
 =?us-ascii?Q?+jmmBnNAw12RiwTwl8AAb4VMQTDjg6AeAV70curYJZK+pUrhGxmu4soO4wY/?=
 =?us-ascii?Q?cKND8QnRf7VvQkpiwKVtSRX9bTzzzRP6ghFzXU6EM9NDWM+J+CW6JGWT2lII?=
 =?us-ascii?Q?Zy3XQ3OpX9kmRI+IIzRK4ZR6qa8IFZtSptloFJDmjRg6pIT26WHKbYAjv4Yj?=
 =?us-ascii?Q?YiNjFj99J2zGiFP1DPzdGFHf6q4xO0isFMxneH3smuUP+Xdb0sFJ1a0XGEtg?=
 =?us-ascii?Q?SMRe78vrXVVKc1A57Eu1mAQH27+qjKacI359LXbm3fsbAR4z+gheoJUqFkIt?=
 =?us-ascii?Q?GxQdEY2JcG2TJQguGcp8b8ZlKLPodAzs7jpztBxFI/XoESspSOuRBjtM6AO7?=
 =?us-ascii?Q?uDiA8ShP/DsjqUapecCtrSJyDM4Oice2amzFKMa8daydtWrNDkn4Xbc0xDG/?=
 =?us-ascii?Q?6rQtAk8/NxXrPd+AITpNn2ILA2Y1wgwUDsZ6MwZgnH1RJ+Y1ygcgIPH3bcSP?=
 =?us-ascii?Q?8fUz/BVcpoL4w1h53ZYRmv7izKxRkHHfpLH8yd1P/pK+8KERFE4c3fo5aJEK?=
 =?us-ascii?Q?PLJo2nb92GVqvHeyBf71awMqV48twRdPVG8l1tDGjtGEzH49T8MxKtp+Az0Q?=
 =?us-ascii?Q?Uu7jNCI3DX58Y07rv4FT9lNH0UJSKnTMKuMYhJMNM2HemNWwJEuj+AC+qu60?=
 =?us-ascii?Q?QVHfl9Ut/OT5HaZdT6qIf+S87DSnS3jQTWtuUU1jUGMWK1BTbzxAN4AD3I38?=
 =?us-ascii?Q?xmCRBm8ul5JVPEkF7zusOZaVSM1aM87V86YqtmIBAY7an5SoCJElT58jdi/F?=
 =?us-ascii?Q?cBdQoP+OJP+VuKSBVNb8sCkI4D/u8EW6pFNZ4OiTUUvY9ZWVKtkNXP9mGaW3?=
 =?us-ascii?Q?usk0N+XJexu5jCvXAygYiUT33DlvAeL4EqoYj4VbFpKlL5lFv891bHqJviAU?=
 =?us-ascii?Q?pxG0qewJhcJAZ6FpJ4SEE/UqfJpfsJLsojbNQY9aC7T7N+PGSpKFlbWaDGrx?=
 =?us-ascii?Q?+RSEcrIrK3yEqgBRMPbKu9cVNQOSdZY2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 10:03:27.3308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75994ff1-cd88-4e98-3a35-08dcccc8d268
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
Received-SPF: permerror client-ip=2a01:111:f403:2409::618;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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

Rename the MMIO memory region variable 'mmio' to 'mr_mmio'
so to correctly name align with struct AMDVIState::variable type.

No functional change intended.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
---
 hw/i386/acpi-build.c | 4 ++--
 hw/i386/amd_iommu.c  | 6 +++---
 hw/i386/amd_iommu.h  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 5d4bd2b7106f..032fb1f904f7 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2397,7 +2397,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     /* Capability offset */
     build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
     /* IOMMU base address */
-    build_append_int_noprefix(table_data, s->mmio.addr, 8);
+    build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
     /* PCI Segment Group */
     build_append_int_noprefix(table_data, 0, 2);
     /* IOMMU info */
@@ -2432,7 +2432,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     /* Capability offset */
     build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
     /* IOMMU base address */
-    build_append_int_noprefix(table_data, s->mmio.addr, 8);
+    build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
     /* PCI Segment Group */
     build_append_int_noprefix(table_data, 0, 2);
     /* IOMMU info */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 87643d28917d..148b5ee51dba 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1598,10 +1598,10 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
 
     /* set up MMIO */
-    memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdvi-mmio",
-                          AMDVI_MMIO_SIZE);
+    memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
+                          "amdvi-mmio", AMDVI_MMIO_SIZE);
     memory_region_add_subregion(get_system_memory(), AMDVI_BASE_ADDR,
-                                &s->mmio);
+                                &s->mr_mmio);
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 73619fe9eaa7..e5c2ae94f243 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -353,7 +353,7 @@ struct AMDVIState {
     uint32_t pprlog_head;        /* ppr log head */
     uint32_t pprlog_tail;        /* ppr log tail */
 
-    MemoryRegion mmio;                 /* MMIO region                  */
+    MemoryRegion mr_mmio;              /* MMIO region                  */
     uint8_t mmior[AMDVI_MMIO_SIZE];    /* read/write MMIO              */
     uint8_t w1cmask[AMDVI_MMIO_SIZE];  /* read/write 1 clear mask      */
     uint8_t romask[AMDVI_MMIO_SIZE];   /* MMIO read/only mask          */
-- 
2.43.5


