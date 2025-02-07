Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A2FC02192
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 04:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgGSt-0006Dz-9u; Thu, 06 Feb 2025 23:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tgGSm-0006Ca-NT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 23:59:38 -0500
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com
 ([40.107.243.62] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tgGSk-0007HI-P8
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 23:59:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXl7g0vgGZD6rCP0EYlxmWdKnLguQBsQsL/18ZPNcW8dUbT1HqB2YLzLekXfRPpH2qJ7IwyQmxurhuRsHO14wPx4RV/XwNuiRGwmeeMrYVg9pAc5fd215HQtkssfgBcdT6UNIR5IkMxYonejF/N9tub+jJsgZQfxuhBNXEtHni+EKvkEFAYEmQiqm0sbdTd7o9/GxCT1SS1/Fuuy05Kboy6AcmUduc7s2amPko0UHBmu6vnmTsudQbT8oUAgLUZB7jw01+tizGuLwV/Egf4fBksIldYZN9NIjia8J9S+qqGf4BUWsCDBwyCg/qWfMZCGT29NwQDbZDQYGI+Jmi4MIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vcmw8yxyI5Ml5bmxW96vVbVkNptJ+OxFKkQ1LX1lTc=;
 b=f5GdxOYPES7w1lCPPYsxItvuV8MuspVEcsVjLUxVc4mGHXV8dl73snMuA/uNrnwMRSSZdLAvC1cq/G7R60Vgp/lzGbPIYutXHapmyRlTXFSL4g/wTFMLXqnUQ4+p8fD5+SS7vZHgQwS/D9R2mAhLtPsSKR8KvhXvmtirJgdCk4ru9cdSgzoZ8wPeH84evJ1Y1zI/gIgvmg1NMfRmzZM9JjIjibXH5QMDoibc9Vn/8y/cVE8CSVsj5EpRyRZzrwByiiZrEOx63WLuNfCA45ocYPbqR7bYByeez+wqdgFvE5jT7nI3OH4OuAz5Rb338I5gnzi/tGgPiM3lWW/cY41iXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vcmw8yxyI5Ml5bmxW96vVbVkNptJ+OxFKkQ1LX1lTc=;
 b=VEXo+NrGG9I/W+BluNzbdAgIIAiZrwV4N3nM/9mO6Vw5XpEAehrteynZUuG7Gg9tWshrcPo0Kx7fbkaEAkFj3JCZ9DCqg49Syn7dt1VxNCQM8I48jtc8oK4J2dUPIIZDPmYG+WchLtZ3TcbtYAXDjsX1hGmDFLKJ5OSSkQ99ySI=
Received: from BYAPR02CA0033.namprd02.prod.outlook.com (2603:10b6:a02:ee::46)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 04:54:23 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::43) by BYAPR02CA0033.outlook.office365.com
 (2603:10b6:a02:ee::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Fri,
 7 Feb 2025 04:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 04:54:23 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 22:54:20 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>, 
 Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v2 0/2] Emulated AMD IOMMU cleanup and fixes
Date: Fri, 7 Feb 2025 10:23:52 +0530
Message-ID: <20250207045354.27329-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 01df6202-c493-4112-abd7-08dd47337dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3AsxwAdKRKsJvpTCasqAwl/ikEykEaXftsYJpfyjU0KkMWzkZT0grjP7YAZ1?=
 =?us-ascii?Q?9goEepfwr1Zvu7QN8/le5TnG/WF7iIPntgw1pE/R2hBjyytz30xQMr1QizLt?=
 =?us-ascii?Q?IEtVpv6sZA/FwH6235N8IpSWUFifmGA6JQZmIAzabzcjqVF0cOj2dftS5a5A?=
 =?us-ascii?Q?2ERvM9NnhgO/XEMl12cMyPViDaie3H9AHfqOz6yi3WEWGIv7vERaHP89UTsD?=
 =?us-ascii?Q?dAzmTiHYHP98QkuHszvJSeDeMZpiEGkURuQkLR/SWv9ptJDrDjLsbr2GT/91?=
 =?us-ascii?Q?AQMvxprWHrZcJ0x9RZcu0f3WwDlA/Ngc1m+QJ7k6u+TC9qkx8vzvocTMMMHg?=
 =?us-ascii?Q?spD2aamdd/I08bdll0d19AhuE88Xjnu4THXsBRNniaQg0/26syJndoDkogE6?=
 =?us-ascii?Q?PUBBb6brNUMG6ykfJ6emg26fz2BNJJ0BW/jOWM1CP0mRvLbkL3yI6WzE9Bdk?=
 =?us-ascii?Q?0NGFk6ohNSy7cbq9+RzL+Z9eo98OjOZERHQP2ftVV+Y76mP0YaonzzmgW5mo?=
 =?us-ascii?Q?3/fayBBPeOumqO+eoXb6ZcgJOIKwHPesn7CbhKC4jQbm8ZmaLhjo7AN2XpG6?=
 =?us-ascii?Q?no9JhaktCvw9dAiHrI9mvgbRPe7m2630dH70D8ImYV2o2+BviHqkhCHo+A1h?=
 =?us-ascii?Q?68XfRI+VFplNcUWoz+42/adEkuuD94Y5117uMeiQH2NxJC0Ogc+ZOYb/ofvK?=
 =?us-ascii?Q?4Yi0d+I92xNCeajXrGrARFZvwZ1ELyRmAsCuV8NNgMrBniuRUV0+q9zkXaYc?=
 =?us-ascii?Q?nQRFq3S3K1JfKR4zSjBxMfMC5WtbO67kAPuDSlrXTQzrqYjXwLvsIhX4SuTQ?=
 =?us-ascii?Q?rpd993lC/cMiYz0ZhtjaZPLa+i+TvwYxrXeBAy8McbU0W+EKHvnM4eyxOGdl?=
 =?us-ascii?Q?sB1ZH7PPrjYhnOcjrxN32Obnw7ZeNpI+04LjJR80M2R0y6Hy25titbejtMTw?=
 =?us-ascii?Q?7o8xn0jvQJJvVnP7GwTQ7XT/LqP1PIk5BHS8uB6TCpS3GUiaZc6YJGvju7l7?=
 =?us-ascii?Q?74g1qT5lxNPsxxT4UI/3E+9ch47DTNhXhXjpT2p1UzGWFdibmeEsvktYEpZW?=
 =?us-ascii?Q?VZUQgSmXUHT1J/htLcg088DSML3AY6puGl5piamx2+Ye+RN+7oK6aHE9K6na?=
 =?us-ascii?Q?9e5eIomJBtjThLALIMnC5YBPwf2zgprwizpgAUoT+ScJwQD8A8LdLWw8Q+Ft?=
 =?us-ascii?Q?kvOEpqcLTkbZtztjH9D7wfTIg2kPYYVKY+K0a3xGvgeE0NAE0tX3tinZ3Ymh?=
 =?us-ascii?Q?8+L1slX3tw1+RhFbfhsHsO8KiVYlYETE4jo3UIqKKZpvnZUKRbX9MNOk/BtK?=
 =?us-ascii?Q?K6XYVobYUCu//B25Dbo4+ph3WGLfRrdviPEWH7cuz+4RPHHf5XaqvXSHRQeq?=
 =?us-ascii?Q?tLstg9Gguix5k9xiVcp2n+BMrQYmvmqV0UFgvv6aBBrh7q+EdTDYn/5SOw2j?=
 =?us-ascii?Q?S0Eq4ZmwDAAqJR6Mmnx9e79HWACyqPKF8unDPVMAJuMexStMpWy2ZA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 04:54:23.2353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01df6202-c493-4112-abd7-08dd47337dad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111
Received-SPF: permerror client-ip=40.107.243.62;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series provides few bug fixes for emulated AMD IOMMU. The series is based
on top of qemu upstream master commit d922088eb4ba.

Patch 1: The code was using wrong DTE field to determine interrupt passthrough.
         Hence replaced it with correct field according to [1].

Patch 2: Current code sets the PCI capability BAR low and high to the
         lower and upper 16 bits of AMDVI_BASE_ADDR respectively, which is
         wrong. Instead use 32 bit mask to set the PCI capability BAR low and
         high.
         The guest IOMMU driver works with current qemu code because it uses
         base address from the IVRS table and not the one provided by
         PCI capability.

Sairaj Kodilkar (2):
  amd_iommu: Use correct DTE field for interrupt passthrough
  amd_iommu: Use correct bitmask to set capability BAR

 hw/i386/amd_iommu.c | 10 +++++-----
 hw/i386/amd_iommu.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1


