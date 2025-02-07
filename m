Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D30BC02192
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 04:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgGR0-0005MW-4q; Thu, 06 Feb 2025 23:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tgGQy-0005MD-4p
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 23:57:44 -0500
Received: from mail-co1nam11on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2416::62a]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tgGQw-0006z8-0c
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 23:57:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F15qAKnbFIYKPuEEi62SxlE8jIVJ++Q3zrPkxqBkiw6u2WK3KyEopkmDbZKvIZkNwxpPVZD5hUfIigp87nLi2j5No8ZHq9iLQobP2CPN5VhbxThlfHAFwa3rI9FlMgPe0OHI6J8SsVcO2/cJKONkB4q/tI1lRZpwsDaiYbBIv/FZC87VQGXI5bgtBjd4b7T8EpI5EH5X7BYpwQn+QZ+UX9h8RRH+YWmDg0HXqEEmQ4FxWSTV4pcUUGKOlvoXS5FyWPdNB/3tG1VJE1TMPIMJeM0VOsU3YCBMeG728IUbFiSMAswxMwEKntKiH6eGWwzsjJXmvh6nSIIWnrgCIB3x+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=112plWQ7Al8+BnE4lQJcxMRwQVFdeiMjOddzHNg18s4=;
 b=PQZcRv1yV9KrG6zTZe1BJQqSYhWyDf/J7RDSm9Mwi19EAdt4y7jKT0twriFYS2aZN2Eah3vh9L+xfqSOiWHIyOn0C4L9hmpb6mdzNU0aPIbSSR8tcY5RCY631eyaTL/V8jiv2yUU3zFo7c6ZvL06ILHgUs6XM3vkZ1Wlx9iAooyAmaPOGEfP+L9Doy8NF8mz8/THUDeUWBKm3Z0TLKQYj2Vpuy3GDHgfI0TSPxZSjWX0C9qxktixEjFBGKr4Ac+rnDyz3MZSiG6xzV/ZluWSN5bJZPcznsXJhmxmUx5NrZpnNm7ro2+ezPaqtZKzYHTi1k6Iu5sjfGa2YGMpMgTP4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=112plWQ7Al8+BnE4lQJcxMRwQVFdeiMjOddzHNg18s4=;
 b=KrZDcywFYHW/57Y20VeRrFidTxb7q1Ia5XCDbD3naCptKu67Jw98G9OFE7ln7zcIArNceiaGWrsYpH5S1BwTD3wGDl0mLh+4aID1iaSJTk8q2dxtVE5k8loNeAEWFZ9QgvYWeOuZgKVtbQH2eG7Ef0tymSJm+OuiFcuEKlMkN9M=
Received: from SJ0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:a03:2ef::27)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 04:57:36 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::d8) by SJ0PR03CA0202.outlook.office365.com
 (2603:10b6:a03:2ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 04:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 04:57:36 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 22:57:30 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>, 
 Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH 2/2] amd_iommu: Use correct bitmask to set capability BAR
Date: Fri, 7 Feb 2025 10:23:54 +0530
Message-ID: <20250207045354.27329-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207045354.27329-1-sarunkod@amd.com>
References: <20250207045354.27329-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9a1519-da42-4eb6-b9cb-08dd4733f0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f8wOSYEZZe4I6SF276eZnKVbQuATkshMrZaxuaw2v7s0VdyE3GwTT5OL+h1+?=
 =?us-ascii?Q?7KmtoD037epOG8rAI+gzwPgK/+0GbPI6H3pVjldxnkINTlpWLDGo8oWml5ns?=
 =?us-ascii?Q?x6Brycg9SxwJkpCTSg2VCGCHWZUYnj4C8bnrN0YITSZXuI7sD4rkJOH2KLS+?=
 =?us-ascii?Q?Gz54jM6AD+R2J38s/k0iSRTDPifv4F/L1LK01DAHKRd+hq2dV03YM7ikJqR7?=
 =?us-ascii?Q?e3rdvUeYCrHbuz9AoXZ3dCu9e3evZsnB3XPY1ZnG8E/PvVonJIM6SBj3Vq2q?=
 =?us-ascii?Q?T/mL0QjR5s8yrsMOnbOIBUiWxPvcQxbWJSmyemzg4XWcPpvFxzBESWLmlYMG?=
 =?us-ascii?Q?dNMgRixK2ZXV265UFA9YmpxtUz9Axgt5Kj282Y9GfHZD38I6euHmKibwR+kD?=
 =?us-ascii?Q?62wB+mwoc2e8zle+3xcVEK2h71a1MCF18+1wN75E4WmPq9tQnCmwJPMWIAk1?=
 =?us-ascii?Q?FzuroWRcc2fVKXKmoqiZCW4mxE+1SUXCy1tHn0YBoa8VV2itrqUZj/P5yn5v?=
 =?us-ascii?Q?U2m8Kr8vmkubBY7MPEqLcUBdRjta594DJ4+uRYFKhlOaLOqGaQ+lIwJQZIoc?=
 =?us-ascii?Q?k4DkBDuMoVLeKaDptxSCIcKmI2JSboskz4Pors02Bpe1eQlWAV8YXQR2P00m?=
 =?us-ascii?Q?on2h+IG6X0eoVY2WZ5BWJ1vRlnwOCviGyQf2zzlkosEf2EGSr4G5e85WhGGp?=
 =?us-ascii?Q?bqKkR2oTj7+nGmBFs+54cV2jUrCs/TSb12CRQYJQuyhgq2EEZtonp7iRmM56?=
 =?us-ascii?Q?RF4yMtXsshz+vU3ztBbPAulNgKcv73B1Oz/WSYYnTmlkPkbp2QLhkF/DBwIe?=
 =?us-ascii?Q?9UWBtSAGJ2KHTFmzXTWmCVa2GfHiFns9yYX+Gtx9jH4/FimFf5xvxtkCvQ3t?=
 =?us-ascii?Q?scCQlz3pXjQSU/7SfzRtVo3uxLxlkm7DyCRxzKstmld3BlJLlsVdh6Oxx7Qj?=
 =?us-ascii?Q?2n2PskzkT65G44Aglx9u5knBEugdyjfQO3wwaaldQ+adPZ4bNZtcocxALzOk?=
 =?us-ascii?Q?MvCaYHu09zcRCMjdZmybiqmew8fN7c4PKAeDzY9zIW4JQAcDuXSJOKXI+dIQ?=
 =?us-ascii?Q?a1nKeHXoYM7E9Zlvc8IVarC32CoxGLPnGv2B11U9LKf75A2qa16cPtTCFsVi?=
 =?us-ascii?Q?J/3oZ88HJbLVVxPqvl6X37AXZhyc1jh7uN8fIqSU5sgiyX5wlTZ3jv+h+3ub?=
 =?us-ascii?Q?w8Ob54hbM48p9/ZjnunDSPxb5ub83Xuhinw5+RBqyD+qiWOevEOpBk3BZ4uF?=
 =?us-ascii?Q?dQ+uO2mukVlLBp+sYlsog91xg7T+V2j+EsbEPperX8GNsM1p+dQR5igQ7ofS?=
 =?us-ascii?Q?4Q/lXZU9SgR+NxL3FByEkUlwlcYED67QzYXucVPAnuHzfwK9k5AtEte7wHvn?=
 =?us-ascii?Q?tuUiqsZBhJYLlUPDBL9CpLdn5WPkgXTvOtiA/szWvqLTkvfXCswYtDXsBJ+/?=
 =?us-ascii?Q?0wk8DnPDdBOHGc/e5Dj3wnwv9Oao9yYEi8bE1yq/VPMqQfmlMfYc8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 04:57:36.1081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9a1519-da42-4eb6-b9cb-08dd4733f0a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
Received-SPF: permerror client-ip=2a01:111:f403:2416::62a;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

AMD IOMMU provides the base address of control registers through
IVRS table and PCI capability. Since this base address is of 64 bit,
use 32 bits mask (instead of 16 bits) to set BAR low and high.

Fixes: d29a09ca68 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 4 ++--
 hw/i386/amd_iommu.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 98f1209a3818..044fe432567d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1593,9 +1593,9 @@ static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
     /* reset AMDVI specific capabilities, all r/o */
     pci_set_long(pdev->config + s->capab_offset, AMDVI_CAPAB_FEATURES);
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_BAR_LOW,
-                 AMDVI_BASE_ADDR & ~(0xffff0000));
+                 AMDVI_BASE_ADDR & MAKE_64BIT_MASK(14, 18));
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_BAR_HIGH,
-                (AMDVI_BASE_ADDR & ~(0xffff)) >> 16);
+                AMDVI_BASE_ADDR >> 32);
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_RANGE,
                  0xff000000);
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_MISC, 0);
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index e0dac4d9a96c..28125130c6fc 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -187,7 +187,7 @@
         AMDVI_CAPAB_FLAG_HTTUNNEL |  AMDVI_CAPAB_EFR_SUP)
 
 /* AMDVI default address */
-#define AMDVI_BASE_ADDR 0xfed80000
+#define AMDVI_BASE_ADDR 0xfed80000ULL
 
 /* page management constants */
 #define AMDVI_PAGE_SHIFT 12
-- 
2.34.1


