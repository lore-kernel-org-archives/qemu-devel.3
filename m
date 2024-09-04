Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE755CD484B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slmsG-0001Ai-Cx; Wed, 04 Sep 2024 06:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1slmsD-00011S-HO
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:04:26 -0400
Received: from mail-dm6nam12on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:2417::60b]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1slmsA-0006AR-Ec
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:04:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PK/bdRNt0VffytBQtINObCPQIA6FgS8TzNfAp3sxLrKOq6js+qUZUG1LAhvIt5k0l2yX7SR8lAm/EKR800Zh3eo1H3yKWGlFNggnXzp973y7baPz4Pe4agENN2tcO/tZUzvQ9JJ5OGpTwxvTiLFfVhc8Smf3Ja5/ylskrK+5dioPg2ItU7GXtg6kIUlempcf+7gfo52pYMG1B8+JR/Sf17nEyvBdzyHNEwbvGoNx0GaYID9rKwWs8HIrBr1sYpIBzDxHiT5HyBNNz1ehG2DoZNZprsgQOJvE3wZAM8Hl8ym/5CkNmWhizNIDU82sP2+CSM6micwERG9MrEVOIkPGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKpo5reCdMBQyVpNACQ5+3WJ3vz0OxoBeCAfX166Ppg=;
 b=VVrKaEDxP12R/Y7kAVp+ZOd4KNBO4+9VCFxQwpCluG3v/OtsfaIMiH9cF7m12BtwgCNUCu80WEuz1vzaiqDqlQzRrXwcAKsGjT9bs3WQqoqWz6PtCACHDNyfPVvwVwx+dXMpp2qBbMwiSJYeYmxPrci5t0TMJXt6qXEa6Mm7AQ2zAJtg63cnfsRgbFP1FkbVWPoMKtXxEIliBt14rKwzwvCKlW1KYZrDTOey/JMLkKaEgUUhYTSaZkpvIpe0cfOjsbHRF2RJtWXVNxHXFHz4OLFpcDWiVuNdnAOZokREO5W8Qn8ZAyItOz/TqN9wrzO+ZYylQ6Q6qS7ChzIfNGPDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKpo5reCdMBQyVpNACQ5+3WJ3vz0OxoBeCAfX166Ppg=;
 b=rMUkjCSrViYatJ5AcEoMp4AUinbTK1KDK3UJfmttP3m7uzzfxzZVSlkgDH7i57L6Xyt7lcjRizH/WHNZzrdOlzR/RnYlM4p2kojzxo6LLIIANASCMamSe0TZJB2EbHn99UYHRoSD05oJpK2ROrBlR3w8UsLLn153XmgeV7pxzyk=
Received: from SJ0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:a03:39e::9)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26; Wed, 4 Sep
 2024 10:04:16 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::da) by SJ0PR03CA0274.outlook.office365.com
 (2603:10b6:a03:39e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 10:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 10:04:15 +0000
Received: from volcano-ed17host-rhel.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 05:04:14 -0500
From: Santosh Shukla <santosh.shukla@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <joao.m.martins@oracle.com>,
 <Suravee.Suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <mtosatti@redhat.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
Subject: [PATCH 5/5] amd_iommu: Check APIC ID > 255 for XTSup
Date: Wed, 4 Sep 2024 05:02:57 -0500
Message-ID: <20240904100257.184851-6-santosh.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: 982afda3-c009-4533-ae57-08dcccc8ef13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EwTiSnBb5b8+LYXuzOhXlWovcXtVItuh4OfcOQV7DGfD4yAmEIMW8VoBS5K6?=
 =?us-ascii?Q?S0n2BURJZ+8235EgLKkxuaxqyhMp4U8jiMMwryYhugs1CE5IZaYo/8XxK0YI?=
 =?us-ascii?Q?yU3NbCXSebb6k5NG8MkCwoegS+7X+nlAw+kR1WoGJqJNgltBE6Qw2WpUTWKt?=
 =?us-ascii?Q?Roqd5Kwd41MkOihrlKOOn26b/6aeeFEX51BpLI1pCXgGOHp1CFgmBbxZoE6T?=
 =?us-ascii?Q?xZZZQqt90oqJ2r9XKtFWPxgJa8BFZC3/RotZkU4ATk/D64BcqImiGnxSwFIM?=
 =?us-ascii?Q?xk/8XrfINIOo+xzsKPrCn6lBIMoRcwZ5pkW4/4TRe2ESUqhDiFdsDsH+mqVu?=
 =?us-ascii?Q?W8NC8mLCaoUBSSKT5O7k7XTBmxy4eNAaccxl5FCc4ioRDjbQ6CNjmscS6LqT?=
 =?us-ascii?Q?UV3SLgGVBP7c+zNXzMcKJ51yo/mKP9eUKc93qsn6DW7fY1UQY9yjWTbhJfPY?=
 =?us-ascii?Q?Fq8Ij44LCD9Al+2W07/yIobD+DA+7hwqLWRNnUz/ZvpVlGkv8Sdab0y6zCS/?=
 =?us-ascii?Q?Qq9e3GlUEVgyC91mIUdmMbf0Jes2ByXXf4gbIxxLDnKAntH4OgKEIbETLoG3?=
 =?us-ascii?Q?FwTEifzBXKAyCN6swGMIyOe/aTWzCmgq4sOwUGGPjifUWCmB+2WwfeZ+QeI2?=
 =?us-ascii?Q?LY1pc7MRZuhG9qXVbHGfmjrAip9+C45cwngO6kZK4YZiiiYquEqq0IEUf5x6?=
 =?us-ascii?Q?+6lKrlZ5M4LT8mFvCf8UbRKV5ZAsMFtHtLcYZN/XJi/GWo5ZqQYEQyqmkF6p?=
 =?us-ascii?Q?NwY/WE6eu4+FmRGhU3+Oy36MrkdD01IHP8hj/Ma7t2uIKsb1jYYSNoCXf84i?=
 =?us-ascii?Q?+7ZLYZ1dH9/Sx7tUMa1WUVTM3//u/gTX4A/6QMgum6/VpuOB/W3E/HjSk6k4?=
 =?us-ascii?Q?bdpP6wtFTU1Q+WjKlb3LI9B2iLT7qVG3/gsGiTs2cY36etCMXumOI22n5w13?=
 =?us-ascii?Q?ePTQzD4YCGzZHBlnAn7vllB+o/Br+U9eCXU1ElJNtwp8JlL6+XOrmHKIemcH?=
 =?us-ascii?Q?4mf1VQ3ztHWtzOFNAd7sFsboaxxp41AjMy4vLGFc4d4ReSSX9fkZz1Bd2qOO?=
 =?us-ascii?Q?pq9gL4gZyHG5NeO0kJmIz96b+6pneUQSR1MbR5k5QabxXGLUvzy+iFrro8yv?=
 =?us-ascii?Q?DWaJlikyt21mVpXpE9f6EvllLxIPH3K3rwdI0KApZ5QjSiJqGvgH6cvvT2fQ?=
 =?us-ascii?Q?gobaKUhY4TYg8k9iFtIvi9VPjFg8gZ5QxInnqdpQlAMy48OngjD1hgv+N1ZM?=
 =?us-ascii?Q?HpIVwCXTYz8rsaFRkWEStpzGUqWfcbB341/zZo0j4r+EyvZUo1nKC3ZKoBwt?=
 =?us-ascii?Q?ngUhYufwNBv8iXYAfZ/EK0qY7itAk2k5blkSsNfxS9DFUfODqtclEr5U8JuO?=
 =?us-ascii?Q?2tJG4jsrPRwpni4frd4aA7RjOorBoVACJwQJPgY5wk5r1PDvXX6SbvGaBdmj?=
 =?us-ascii?Q?GlYLzrMnexdlPKer24tY1Cbr1PdfnxZE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 10:04:15.4462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 982afda3-c009-4533-ae57-08dcccc8ef13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
Received-SPF: permerror client-ip=2a01:111:f403:2417::60b;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

The XTSup mode enables x2APIC support for AMD IOMMU, which is needed
to support vcpu w/ APIC ID > 255.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
---
 hw/i386/amd_iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5acb40fb909c..89d941fa4221 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -32,6 +32,7 @@
 #include "trace.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/qdev-properties.h"
+#include "kvm/kvm_i386.h"
 
 /* used AMD-Vi MMIO registers */
 const char *amdvi_mmio_low[] = {
@@ -1651,6 +1652,16 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
                                         &s->mr_ir, 1);
 
+    /* AMD IOMMU with x2APIC mode requires xtsup=on */
+    if (x86ms->apic_id_limit > 255 && !s->xtsup) {
+        error_report("AMD IOMMU with x2APIC confguration requires xtsup=on");
+        exit(EXIT_FAILURE);
+    }
+    if (s->xtsup && !kvm_enable_x2apic()) {
+        error_report("AMD IOMMU xt=on requires support on the KVM side");
+        exit(EXIT_FAILURE);
+    }
+
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
-- 
2.43.5


