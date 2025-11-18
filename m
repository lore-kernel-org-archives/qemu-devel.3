Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14F0CED26B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 10:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLIlZ-0007Jf-Su; Tue, 18 Nov 2025 05:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vLIlP-0007Cq-9F
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:16:43 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vLIlN-0007x5-20
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:16:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gy3kizyaIbEVdlZ1ei3l6YezbgQt5B9ons5XkQP477BMuZmZdRPlRHSTh8T3r8LRiKhppj3FMDPTc/DRuya4Opw+r/DTxQYaeUdFSkCqVdJjQBgERnjeKZnl3LLCC9RXm83CceSK8EGKaEOL7LZ59ogQCy0BgokACCPfheSGPM7aIX0ua9bwrbv8rTZV/MIWI90VmBfejArNnX1jCt/f4vEKdIUZ3WhpLgnv3K+F2lB05Hh2ynrET3iLohtyVig1yCfeTNqAg+oPlb47fgdcLZfXsJQ6r0aBTkSXiAaiWsg5Sh5XdFYtPuXIrNKedeqwAwHQQc+TlO1KcHfa21j+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daNL5hgxamLuGLTlEXEONUIm6GASpOYvVR48Zji7D8Q=;
 b=Ma70UX9ZsKVh9YaTjo0GDVD2loYnnW26YBUvaV5H1+kaASD/yqbp7Lx1D1tdh3752JXf7Hxdt8+5gwGkFWV6Ve4hrbX6Zr3wVwAZJm/33IUmLOwFC8wPesDOpSN7i3xSclzoNTmPJ95ygYm8bJv8MY5J1bo/LdSv6teTZMTZrE7ZvhFupiMua1UBXkU4vFaccDaJ8uStBUCo5GTF6pjxQawxTdFqbuBjy154QvsvKb/3a75rYALjbsyPkNmIMfi4kQIEw921OJH74p0f2B+HhiTnaGgpwSAUijzviJubimC1wW5wsK3zODi4jWGm0eNQZ1GR13Chz+LYrJuK+qq1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daNL5hgxamLuGLTlEXEONUIm6GASpOYvVR48Zji7D8Q=;
 b=b3P/e5dQyaPZUd3wHX4Efdyg9eOF2ccrlkUgg2NetiC28tGBuUa0rKYTdAE4CIJz8LlXBxU60y5tufFrUyrjkpb8WNrOBbB4h6b8lx01bqOQ7nJzunWVH7f5nHBIf2m0ifPTbcnLNRcbvkJUdwplG0DRFeIxEMvtuoiHa2GkFY4=
Received: from MW4PR04CA0356.namprd04.prod.outlook.com (2603:10b6:303:8a::31)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 10:16:28 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::58) by MW4PR04CA0356.outlook.office365.com
 (2603:10b6:303:8a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 10:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 10:16:28 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 02:16:22 -0800
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>
CC: <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <yi.l.liu@intel.com>,
 <eric.auger@redhat.com>, <zhenzhong.duan@intel.com>, <cohuck@redhat.com>,
 <seanjc@google.com>, <iommu@lists.linux.dev>, <kevin.tian@intel.com>,
 <joro@8bytes.org>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [RFC PATCH RESEND 2/5] vfio/iommufd: Add amd specific hardware info
 struct to vendor capability
Date: Tue, 18 Nov 2025 15:45:29 +0530
Message-ID: <20251118101532.4315-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118101532.4315-1-sarunkod@amd.com>
References: <20251118101532.4315-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: e436cf3c-8e5b-4eec-fe12-08de268b897f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mZNSxAECLm9HiRD1T+ZSkdI5nyvWLyPR6g2oepCXBehjC4splEnTn5EHu5mi?=
 =?us-ascii?Q?CiP/y6OZ1b8lJ+1ez8GJTsrHbbCLQq9zRpz0AYyD5Gb7g8JEG7OgTGnBFB5H?=
 =?us-ascii?Q?bo7MbwLSLJKceeo+lPTXX3VWv2isb0OCCCNkids78rEfvv5jw++B+O70FYAh?=
 =?us-ascii?Q?rN/lHAtQmLKaZY59o9vryhpgdZCqeh02D8w30g37ncthH+kgIoP8OubVZGba?=
 =?us-ascii?Q?BmWrAkSyRJl5Rco1Y73BwpCaK2fQY5lmJTfL1zikwd59KjgFs5//9HnOTafU?=
 =?us-ascii?Q?GnjXM32NUO/LE6DkGi6hplS/MOCxxa3by5OCW3AIvWGJmiyz6pvh36CVKur6?=
 =?us-ascii?Q?9NTOi2QLUtSeNLWuaKA1C9Cd9vLKHjNaOdI82g4UAuG0a9PxViD5a3+Y8wTN?=
 =?us-ascii?Q?hjnZbmkWiZIUOSr+uRz6pkpoFoM7FZ5qvMibRJOk/cLEIh0CJpDACFQYZSOv?=
 =?us-ascii?Q?RcLxtMG4YRsqIF46Yeq7jUNRbzNKRGyxirU3eNpDSICEY5j/Bu+InWDDMAMs?=
 =?us-ascii?Q?sN0W+ResPjpW9+haZ/MAzvhFPcqjcnGqwQyfT8LJY+7g0gBquOkaANJ8YGFg?=
 =?us-ascii?Q?HI/nyeRsPWZkjTyY7HW4ZB+a2KOVww4W5EBCkFYv/UaM5ZrYxdZtAZZMxZGJ?=
 =?us-ascii?Q?YQzZNBCMMdSZbs3nHaXdeFlvRACoGOlym+Khjq/KTOtR1L79uBN/kxxjoAl7?=
 =?us-ascii?Q?HFZIKvkeVzRlY4f/Ss7b/+AWB7QUoJPXuJT2xcV0iw9ePjlhFusI0L9Rqtuk?=
 =?us-ascii?Q?pPCYRtmVsx2ds6RfZzys17JIx4VEmJqRTTxQRguXOny8H9P51gY1jxHhI5be?=
 =?us-ascii?Q?iTjlP/1P3sOk7bEcxfeAo7c8wwjY4ftjxsz+mGXswLCNog2eAi+gDuK+6FFx?=
 =?us-ascii?Q?b2zRFtJ4XXD+ISSaHQn9Haw8uWH/EgJeH69VarrWWN2bIocXpQ0PvZzsXqq0?=
 =?us-ascii?Q?Y5aIXXvZo1oZELbQKiot9mDtznG24sYdGYWlr2aQMRHvUju3z9DCNYJnopsQ?=
 =?us-ascii?Q?1mOWsT9ly59ow5RGH8pGLX9S5U94QuL7lIIrR83/NwVdPJqtY/w2cGcHrqvm?=
 =?us-ascii?Q?Aj7BA6OOlJX22aB6k9Eq9DOEF8snvFUAr77h3uXn63BhNKaI3Z8++u93CCE7?=
 =?us-ascii?Q?kztRBzp0V2Uh1skw3Z53ckIRRQ++GPFdIscUeLSCjNvJUI5vHhIFlxyvj+sM?=
 =?us-ascii?Q?cBEleATlUnCmOdWryjcfpBPP6Buu326WwJKiV8v8qmyzkL14WcVZh6icls3E?=
 =?us-ascii?Q?dp2VzRv7M/IlwOEdiePUVPq8MWk4ApED8+MHILXqJ5ArxN8JFQCfXAypAfUG?=
 =?us-ascii?Q?bNvtYy9q0G0/V+yvUS1w3hh6DiI+eSEfdWpFaWpq64Zz5tkpoqh0Ih3scHw2?=
 =?us-ascii?Q?dswrDDs3Y1XQDYPNe/IdZu3dwONWULFNNBxvP9g344e8/otgdHQ5ZNjLSKc/?=
 =?us-ascii?Q?q134goi5CpWIxNJ0fPbpTU4hhvOKpdZRzpFzhm10PPt3X4wxvnyOkrG+KR7w?=
 =?us-ascii?Q?UpU2jx+hAJVQWO4BR4S9nv9WkDlgfqtZmniWSHPWOGhjxsj9BuHmtCaYOQP9?=
 =?us-ascii?Q?xlwTi1Zwg3hYeiWZT0Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:16:28.1496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e436cf3c-8e5b-4eec-fe12-08de268b897f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Update the vendor capability structure to have `struct iommu_hw_info_amd`.
AMD vIOMMU can use this to determine hardware features supported by the
host IOMMU.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 include/system/host_iommu_device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index ab849a4a82d5..cb1745b97a09 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -20,6 +20,7 @@
 typedef union VendorCaps {
     struct iommu_hw_info_vtd vtd;
     struct iommu_hw_info_arm_smmuv3 smmuv3;
+    struct iommu_hw_info_amd amd;
 } VendorCaps;
 
 /**
-- 
2.34.1


