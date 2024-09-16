Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3063C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 14:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqCli-0002jn-15; Mon, 16 Sep 2024 10:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sqClf-0002hS-AW
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:31:55 -0400
Received: from mail-dm6nam11on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2415::62a]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1sqClY-0008OY-BX
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 10:31:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAapSEsnn22Tj1q1E9PpNDYxJQJ1cQO4Ht4EKUBoLjmKFVlSQXZ5wc/Rcsy3Ihgjvp4lMQmXwZYAjBckLYAX4hLXYiH4dRiyLW4KLtKBFKgJFNKYI/Cy9bq4qDH8VYdwozTAvTHzTj3bl9Gz4L5bXuFUV2ZRRZP+SjAHMAnp3rccM0/XOSc9zQ1ULdEtH3rjZlAZoM4VZ6VNC5pUPYb2CxMmKXtiOSPYS+MeD/udYHfljCjAiMNX4PxNnQ7ruIvk66upVaMo+mcONaZFMUvnWoZRCaa/aIk8vuRAnT94Z78+pNAu2rrNDOgDstQYvTMS2Wj1ZasPSz50F411E0qemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDn6O8TRmR2aviZQj/8nPRMzuOOx7oOVsG0u/qDyRnw=;
 b=LC7QrNnEGHH19MNNTQgbFFURN67hr4n8XWVrzPja8fP8nfE6qEaD0AMDsrXym/pPYHrCSV2EmXaZdOUa4G7Y+GhNISqb6PxdNpx0aMkE2PQFi8TzGvRaAqxKwJ03Y+kKXZmdGL6FYfhIS8SRIqwuua2R7YvNgyqDqVQ4rw6/h/5+UYjAAdGIaTzxZTbjXGXqnNhJHY2dHCC5bYI0AGP6rdjuS5dBpN1/78mB8PU5ub6vWdd/PoSVabPj88W6hZvd83Q3GUmP7OJFPBxJ5MH3adTly5/pFXMIwdJ44Vy9cQMBkAb9opbSg2j5/2Ip32JFA4QMcUDubJ5XG8BhjjLZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDn6O8TRmR2aviZQj/8nPRMzuOOx7oOVsG0u/qDyRnw=;
 b=qpwrVazyC+GYoTPXx8KOervszsIy5cBDRdnHfUqJhcfn6krN2C86Xq+jUW/Y19oGyB0AUkn6avEY0AgkY3DQag+jKqSk8CDWJHuQUZLqSSzde/O/ymC9kJy40Z0EX++QAwr96/a7oQrrfW5cfbidL+wQ9JG6b8E34Dn/i3QDLMY=
Received: from MW4PR04CA0219.namprd04.prod.outlook.com (2603:10b6:303:87::14)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 14:31:41 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::af) by MW4PR04CA0219.outlook.office365.com
 (2603:10b6:303:87::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 14:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 14:31:40 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 09:31:39 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 1/5] amd_iommu: Rename variable mmio to mr_mmio
Date: Mon, 16 Sep 2024 09:31:12 -0500
Message-ID: <20240916143116.169693-2-santosh.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: be10effc-2014-4bff-d413-08dcd65c47ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DA74l9tbU68n3g9CkTSzi9IY90NslqAuHecDi7Q7XlvDnYIZlkwG2fLsqoS6?=
 =?us-ascii?Q?pvfMdhAuax54H1wSyUoITJz9mz6jO3KTSc3A7iJKe/xdl1sQ7PoyppSMFJKH?=
 =?us-ascii?Q?44gIYQgA3Z1xLmoln0vP2OaClGSUL08/t5YYGIXeY5xeMuu5uoyggg6gGT2U?=
 =?us-ascii?Q?x5EXa4v7uYDEdlXmZoHFOaJTZ9PX1+r1UufnHjm1YafoALf9dsoFIqpkWeHl?=
 =?us-ascii?Q?U6eJohnZ87w1Yfca2/kQOSPl/EYTfFhry1tRxNHdnjYyqdLB3luFdxCAs4ZH?=
 =?us-ascii?Q?GVr+1d2qiyIK0OvA8QHVAx5aw1ZS7ExUnVOGebJ/hPnmhDmQ0pIPPcka3/eF?=
 =?us-ascii?Q?6+feDmjiLmjz9NVE/7v3cNhtYeO9Pc2lSgG2yaRu78fDsK5zkKQlNxxFkANh?=
 =?us-ascii?Q?SbL+d7UYi37nNNgJIkSUE1C0VufFZ0YyocLJmAvXN/iJMBcmlRwQdOdlvg2c?=
 =?us-ascii?Q?JkV9FPEBXlBXWjIlrr4C/EAtkh1uRcsdieABpz5BYGhmPqDr7likJuBuoi0t?=
 =?us-ascii?Q?3xdZjiFLw7MdyKbegaQBVyvCP3ZfuP8jNPgekQnOGzNrfD6kQg2TxR1w/iRa?=
 =?us-ascii?Q?ZDiAA2bUdMc+2+Mirsc5BY343fzRHI1JUtrE6jPhUzY5eg7b8Jd17bUOd5ba?=
 =?us-ascii?Q?npLp00ZGEnJieqgkD9uCJ/FQgfBgQx6UUKDr1+mulYwbFLr9bZTSfzxmk4BR?=
 =?us-ascii?Q?Hl2as80Xh3ahzbWqbxS1CfSvS2uPdxNjgtFAYXPc8XcliUKADfu2L4jA3p/T?=
 =?us-ascii?Q?WzImXmEz8sG5TnkjtHuPB/MzNN3B2ZtGAWlS7oVczr0QD3pT/6SJ7nw+c2P2?=
 =?us-ascii?Q?WsLDse87Ug4SS8EFp8FUeVseksRiSa9B4js+tNsHDRQWWXTCE+w6EKBq0rIz?=
 =?us-ascii?Q?Q0Thdl+zUzybo0VZnF+9/aQG5EhNSJistSbnYRNlnlMC0xUy7XdPjI3/SZWG?=
 =?us-ascii?Q?KQPEidNdNw556ReHcCR9mh9uQumR0/wdqLt5UcNa8GPzbNA6wfeElJu/Iv5w?=
 =?us-ascii?Q?ic5mjq10Dzn5M/OLWK3nt8JBBqLfARqL7s7cNV3VmTeZbi0M0Gc1htPKgFeZ?=
 =?us-ascii?Q?2/84G7+Ui7EuQaTXDRNU3QJbX+KMlZYsb+Tpye706ceFpDXI+x3zf0N4Pdi5?=
 =?us-ascii?Q?Blcuuc83spANofR1ySCSQO4P+Bilw7yPu0P3pmdhM4tQg4cfS1+ds9o7svat?=
 =?us-ascii?Q?nZ0LoFRuBCYfaK+V+dNEGWlOgBFdkOQ2M8yQXLtkdyD5hPN4l1sjBhrcyinP?=
 =?us-ascii?Q?PjkmEGxHerfI026r1H3TogRwQaZ1H9e97weem8msq4llkAN2AATMQXp2O9Kv?=
 =?us-ascii?Q?o3z2siRZFveMl7gJCdnxFJ0K5q4UvnIn2HmT6d3lewuJCMFpdDPKTe3QhHqX?=
 =?us-ascii?Q?+f1/Xq/TsE4fVijaf8LQk/6rKHAN+361moJwMZx6mj/Ob0B5nWIToO7B+3ps?=
 =?us-ascii?Q?n9IoT5zBl/RShjZojvT7cbYKY/1nQNw6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 14:31:40.6114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be10effc-2014-4bff-d413-08dcd65c47ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
Received-SPF: permerror client-ip=2a01:111:f403:2415::62a;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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
index 4967aa745902..5c6920f90d05 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2321,7 +2321,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     /* Capability offset */
     build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
     /* IOMMU base address */
-    build_append_int_noprefix(table_data, s->mmio.addr, 8);
+    build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
     /* PCI Segment Group */
     build_append_int_noprefix(table_data, 0, 2);
     /* IOMMU info */
@@ -2356,7 +2356,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     /* Capability offset */
     build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
     /* IOMMU base address */
-    build_append_int_noprefix(table_data, s->mmio.addr, 8);
+    build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
     /* PCI Segment Group */
     build_append_int_noprefix(table_data, 0, 2);
     /* IOMMU info */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 464f0b666e69..abb64ea507be 100644
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


