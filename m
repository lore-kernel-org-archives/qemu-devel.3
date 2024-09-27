Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A28CDD1CD
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 17:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suEmr-0006Ck-2y; Fri, 27 Sep 2024 13:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1suEmo-0006Ba-Sa
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 13:29:46 -0400
Received: from mail-bn8nam12on20612.outbound.protection.outlook.com
 ([2a01:111:f403:2418::612]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1suEmn-0002eA-44
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 13:29:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwpbdGryz9nwn4no4ORTXP/z+iE+2tiJnXUIvsgQu/zKANNSp0pl/ef71sXLaDsfXAoDQWRWKx0+2LpuKyvdpMMQoPJ+Gq68noygYk6l1rMJDeaoltxGbEghMMw7PMWl3iV/OgJUNRV0u5WPPv9H2MKdYMju/dJ7nrpTNXB/CcaY2gnCOhk20bNYXzzipYgjMQUB1CAUet5hWE5hjOMD11/bWNrzWIg6kir9dWgQBAM0c5GsWo0rI1E7b1sGOs91dMRY538ITh8RoYkp2oO2vXpAJZsFR5q0gPqtj7woQ0smnCAOcQYfvm5qXcAHFxw8mBJ8J5ON6/xyGlaluDV5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbPagA3ro7p329hS9wZ6cPPM5pH1ke2fvkL4QxUmXzg=;
 b=MSC/utmNqj6clVcn5qqP5q6bZEK2OHWZH9cUV5mGU9HxSjXtSf6ofhfbhuXrk+ZnB/+ZQy1GWKXhAbZ/Je271LPpLu/7pJpUoJGs3dK7/YDUABsnrmgW5pwX4x7aNK/+l/v3vxFvQLKfE8SzqPouS+DESEAB2TqAkFT29O+oNQrLQhj10Ok/kEsdokVhC32G8L/A2A0P/bObD69cPg9Kr0FOu/oaA7gnLMGycjHrxYGHaAf+0yLNk7wMpuJ2FD0cXJ3SHFbEWVGtZJPb3esAQcewFD//QNPGdnkGAk3kj9oQsquWeYbo1U/8AfehvJGM3C0SxKEBCQk0blB2UhBA9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbPagA3ro7p329hS9wZ6cPPM5pH1ke2fvkL4QxUmXzg=;
 b=ibHV1xfPKunR4rlW6iPvTtNzkGgcFDzhrqGJKYmejDa5/Sb9zX7Mlcj2r3EmhvlPdTYderiTU0joLLQjW+0MO0jCNZgx+g7udMbllwH1c3SOWx5MnvluAS7iUynUimCpAjKJ9BGEhOare7PanNbS2Nd8gClLwCgJYjYvE4Jq6lk=
Received: from CH2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:610:54::40)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 17:29:37 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:54:cafe::96) by CH2PR11CA0030.outlook.office365.com
 (2603:10b6:610:54::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22 via Frontend
 Transport; Fri, 27 Sep 2024 17:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.0 via Frontend Transport; Fri, 27 Sep 2024 17:29:37 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 12:29:36 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <santosh.shukla@amd.com>, <alejandro.j.jimenez@oracle.com>
Subject: [PATCH v3 1/5] amd_iommu: Rename variable mmio to mr_mmio
Date: Fri, 27 Sep 2024 12:29:09 -0500
Message-ID: <20240927172913.121477-2-santosh.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2ec6ff-4355-4bf2-41d6-08dcdf19f605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mfsC9yRZ0uoV4du6zmMsVhZVqofQyyM0/729+QKgl2BqcD4RlX46Juqau8Fn?=
 =?us-ascii?Q?UhCH0YaTAUP+8ABgUf7e9elG5CyrBLnngxKXkEZW889Ksq0bFgsM8nVZbKAM?=
 =?us-ascii?Q?FYByxAo0UP4RUkYI6W+WKnq72jIel1U3MT5te8Rc3FSsiThEkcPdWCO+n/s+?=
 =?us-ascii?Q?bzpsDtpU4b8IVy3gunUoYc0NjSFoU5Nj2hQCUOAD8N9H5M4fulE7Kso3u8Xf?=
 =?us-ascii?Q?PR58k0NrKdYcgHCRQrMKMoDJfNubUDCKCw6qrzbObCcXBKVWS1L9QvwiP0lE?=
 =?us-ascii?Q?bFRwDjgF4apwWJx+P7K70mZ3Nuqs8Ogz1MmSXOLeFQmKbILvTZN9vdwSYrmU?=
 =?us-ascii?Q?npyon6JGRIf2IknPlsScNyIF3RKAZIt8tn+Fi01USCQNypo+atJphT6LCPlp?=
 =?us-ascii?Q?LnGudnuH9F8XCLCdbsTejM0b9PxUXUWopMVK+X+TaNwLMDc4t81D6roeNfMa?=
 =?us-ascii?Q?HTqDFBiA8a9n9rxFNI1UtmG30B6jwRsNWBsFC7o0fJe+MjCVOI3fWGbrNPd/?=
 =?us-ascii?Q?r7EsOMmTpAjZZvu6nZUo8r/4oMsfxaTyCnhm6tcdUkU4Dp5GSupre8olVZ1H?=
 =?us-ascii?Q?OWzmRbWXf9/yjEnGCiYTWYPIcVDiDVcTZ7pFrugSHEFmhsErN6qe4JAb7Xxx?=
 =?us-ascii?Q?zlkBu+NKRebudTaJB9KGQIX8leM/D6fVGtztJGSrZYW7kL4Yvg9uziYtJGfg?=
 =?us-ascii?Q?uzcvchoN9pxCjWNLyBeeLgDRIKmCOLn6ykIobZlvhq6nVtvZCd98Da9lWeka?=
 =?us-ascii?Q?AJHcpqtkzqG2PxEd3H/tkjjeZU/Zgr4CImSegqPFm5ubomqQtB4wI8fckmF4?=
 =?us-ascii?Q?Fq0/gJOooxOD5YA7a3UnHzORgNP3AjPPSh1wxUXVQNsWeS56tlK6xckfIqH1?=
 =?us-ascii?Q?SzSr2gCLjhRyweizBchePehz+dsxktWY1LUs59NOAA+3xRaPhd9uLzzozpAk?=
 =?us-ascii?Q?fi20nqoMfUES9YF8+3JHL+E1Bxa6NPTi3zSqUvEpmtTV0jFzwRGTXxTIt8Ai?=
 =?us-ascii?Q?qXKVH5aAeACLlCrhDMvU8ndbji0yRauacWb7HdOIoN8f5w52QPlXj7lRghlx?=
 =?us-ascii?Q?EZvG8PG4pukAUQEPXPsqGp2tiK4uduHFMMbBukIkKGkuD5kjBE3UEO2596Wx?=
 =?us-ascii?Q?32LEaoUjfM/xkL3Drc4QJArdVQlAWmijBJN3pM8zSIN7IrdrC5vYTyLcCMRr?=
 =?us-ascii?Q?IbOwg41pOO+tD9QFi3yrot9QM5+JWSvbOSC9Q6+2tns1hhFXfuC0UOnKhvI1?=
 =?us-ascii?Q?D9ZWWLwdNi+9QV4pL0Gd+xYFzRGw52M9yN6e/hswBcRuJ8JE0BW8WERF3fwh?=
 =?us-ascii?Q?9JpCsWADNp7FUAvCHNEbhYYpcvYOhhA5LBm864Or75KTpmHC6Pdx5Sm97dGa?=
 =?us-ascii?Q?jWGFtMMeyQGwAdUkFEabVB5bUwX4oxY8DAMUowZHhoQZADNMEI92MLu8NfrM?=
 =?us-ascii?Q?t7M6CtkB30VUMyq+9895UPmaNIHGWQHw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:29:37.3702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2ec6ff-4355-4bf2-41d6-08dcdf19f605
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983
Received-SPF: permerror client-ip=2a01:111:f403:2418::612;
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

Rename the MMIO memory region variable 'mmio' to 'mr_mmio'
so to correctly name align with struct AMDVIState::variable type.

No functional change intended.

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
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


