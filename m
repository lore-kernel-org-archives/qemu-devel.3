Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DDBC2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 03:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMIyn-0006XO-G8; Tue, 25 Jun 2024 23:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMIye-0006W5-7y; Tue, 25 Jun 2024 23:05:44 -0400
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2415::601]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sMIyV-0005tO-TC; Tue, 25 Jun 2024 23:05:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bb49AKlO24mv5L5u0DOyIbwFLDVOId3rrcLlpE6aQbKlCgZgrGL1jc+VXky3mChEp8MLU34e2kM65z9YMmgkjT8/GHrLPvLKhrTvyTsBHttYa/d2KsVF7X0I7MOUqOV38kxLgyyS4Wiy3WMDamLxv4ew2XmJp7M6hXzSD5ArDAFX6RKe8KSFXnSPcmtVqq6rC5kUndAvqgVYDiFv2jt1t3xhApzmMKg/TyRzNOLQK1zk/QktCqS5cCPTGQqp275TXgJZ7upQWpRYgJ3cmGhX3Kj5TO8SAYO/xDrXMe/FOoljndl0CtufY8ULipi1PRjMrYz3Ja8UNgAOj9PXTdAtjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZsvW0ATL8cXuMa4JZCuaddpeOb7hodr5FwswBZEZSY=;
 b=i/6sZFndFg1nHordd0YkERjEMoWgNuBdfGKQwCsRWHl9AJhwewv6A79p6XjzndM5fr0vncgShqJI9gmG+Eec/QSqL5LD8hKp2sc7X+/mOBNenPrUGb0t8Axy68Z+Eyx6MTJaj8ouia78iA/o8+5IE3ncnVTW2fqZ67PEPuHtwWLBntlrv3byIj53HXUVJH2lqcPbiW+FRSws9eiBdNuyc4gitxYJSxvzRAoS4gAVB9oGNiiJMtInBR5kqp3orT1qlxTi5tprsYgJ91RDNjZX6Y+jijgDF4zEdxUg06i9v+rV7a5x2Z6h2QyyBvhLihqXZmr8Os3BZx6GOzMKiEdPSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZsvW0ATL8cXuMa4JZCuaddpeOb7hodr5FwswBZEZSY=;
 b=E6qWP2lcOTSqAQxPYg3I+1YMrmYW2SR4YQCINjiSemdzxCgDqqoqWQ/f9tE2qOQCsOrnHsUjmFmL6ymDtdwibCcPAFZgKpPXToL/mrJgtXe6EcVVZWvDN15k9TZ6KENalckE2rVy3P34NwJGf8h96ZfQz8HN7QsKQb0vvIsU1hnRNk9qdvSB3p3Ng0wYuMyntyB+yZZ6nmi3PbZBKa1vz2ZbmYDu4hPQw1Nqi9rZ17ryzC3bw2pnfAz/jccL5m0MMs1dHVEjRG7tN4FVgjm3FP1om8GFGI3cFhKnojKPA0xm2U5cs1nO0VmIN2QPTzt3N0goxo+bkNgdHbN7r20ggw==
Received: from CH2PR15CA0019.namprd15.prod.outlook.com (2603:10b6:610:51::29)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 00:29:37 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::bd) by CH2PR15CA0019.outlook.office365.com
 (2603:10b6:610:51::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 00:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 00:29:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 17:29:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 17:29:27 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 25 Jun 2024 17:29:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>
Subject: [PATCH RFCv1 04/10] hw/arm/virt: Add an SMMU_IO_LEN macro
Date: Tue, 25 Jun 2024 17:28:31 -0700
Message-ID: <37eabf1aadd02ab0af854ff993a952af56fef6cc.1719361174.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719361174.git.nicolinc@nvidia.com>
References: <cover.1719361174.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d2f29f-fd99-464b-65f6-08dc95770f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|36860700011|376012|7416012|1800799022|82310400024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a6wHIzp9z0EvIIFnnFKENuKaKl3jHn7QezQ8mOjU5RKsBlMuT4UxUGpR1AJU?=
 =?us-ascii?Q?8FTxv3EePrgfy32uBo3j3+GEp3IgjANjXvrNzKFBhsoObcXyMHR1Li2QEinc?=
 =?us-ascii?Q?ke+g6FpfwIhiV0wGAFi+HcxiZMMLAf3e5GaykGVh5jrSP6zv04PmFvJZVvHf?=
 =?us-ascii?Q?K/rcDpRMSa7H/63zUNTR88OyJFc8JWfIZ2OHc2/swQgjCXIyCOPMsM6Bzc7l?=
 =?us-ascii?Q?265BMd9FhIiOVxZxusNi7qA+YYCdRoD9xBZRlUWbX6gh+lAQBTXaBbUplw6L?=
 =?us-ascii?Q?MgM5JZ3H5fAcE/w71Dt12jVlf0PN6Vca04wGwxOgIfRNlmPaogIAKk30kZXv?=
 =?us-ascii?Q?JGKWCl9i4Dd0J5jYEkD/pQtoU2hU39WNmJxC3tGe0DkvOEfEDfVRhYsBmqGH?=
 =?us-ascii?Q?7TjsgLD8OLLeDUE+kq16GUZKvrelvn9p3o32jE38bR4BxlOPVnH1cJQsoUpx?=
 =?us-ascii?Q?Iju6NsCKpDftruogo8SKHri9W8huej2FLWbxvQ9O4qX5+AEbPkAy1byzSxZp?=
 =?us-ascii?Q?iFtfMsFS2xYYtSIok6pytKCotuuD609ZkoXd+bmUMCu0s73APTcVBZfSjJ4G?=
 =?us-ascii?Q?z1h4/2nn+WacfpOS6U1Ina5ozEmnpJeZbeHvzRnUmzsaytr5aXxDx5gcgwGG?=
 =?us-ascii?Q?c6uEKC4xM+ppIc6Q5GyTDeYDBJ7x+aVvQ36mxZ+aufqWWdug7dKc7sl7vcLj?=
 =?us-ascii?Q?oHRhltXoS+HwQvzU8mjwmOajD2C314ByZyPko//LPMRBjYfNuwO5OWbWXGll?=
 =?us-ascii?Q?iPy7Upm+aEdvmoahDccTNp090i6K0kPX6EmwNlpvNg1DyqZaNzgttj2GU2MM?=
 =?us-ascii?Q?vXHQ9xQGADoeNSy/gsgHk2zxRSmpOSvcUuCbPPiYL5QT0Nn7lKgXDWBpXPzo?=
 =?us-ascii?Q?79DUF6+QPQJX2N6f30atSoWRnW6hvzSkkQ5Lhyp9neLnPvj5dBZGuvKAApH2?=
 =?us-ascii?Q?ckUPrwq14rCB8plBP9IP2RQIeFyO276rDt+5xQeuwGTWCNx04qaeLE6nud8M?=
 =?us-ascii?Q?fvpTv+4Jwh5E9uO77sY3E5RTLqlKMrdoGFqhWOrDVtX+S9x0/jdQ2Vm/v6dO?=
 =?us-ascii?Q?EygjP+LxlrRb8eD7DKNpsqm14W4WfqcNABt9iZekGqnnC3oqRJQ1LccgCtQB?=
 =?us-ascii?Q?TPlaonkVTlknbP09deV7PmG75M3WoEYlM88KQ4wnKhkBkEj1P+5jaLMPyDWQ?=
 =?us-ascii?Q?ioI6mzyykygVQ77qgxz+jAuXGOYl0vcbiI+rnAv+AhS1W4M+iNRl/ihlR+fp?=
 =?us-ascii?Q?OMHiUwfb0x1NdJYemhil6s53KDUDtR1HzJjGb3EJrqDo9m472iK43zWGWQ9G?=
 =?us-ascii?Q?3bkk7LTr1p1XFLTS4voTPhks/ubF4knW59CXuBiIli/gFFUZz85ZB/79NcCI?=
 =?us-ascii?Q?n1VN153CIVxqf6NujhQHbzx+HlKZv1tJzN7gVFRUQGqKW1EFmz/1i+1xEWHS?=
 =?us-ascii?Q?5Vrlph/gNrbF0HopSlTVgWZBZ6N9U7p2?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 00:29:37.0810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d2f29f-fd99-464b-65f6-08dc95770f6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
Received-SPF: softfail client-ip=2a01:111:f403:2415::601;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

A following patch will add a new MMIO region for nested SMMU instances.

This macro will be repeatedly used to set offsets and MMIO sizes in both
virt and virt-acpi-build.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 hw/arm/virt.c         | 2 +-
 include/hw/arm/virt.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index be3d8b0ce6..ef59c79ca3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -170,7 +170,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
     [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
-    [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
+    [VIRT_SMMU] =               { 0x09050000, SMMU_IO_LEN },
     [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
     [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
     [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index e0c07527c4..b35c4f62d7 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -48,6 +48,9 @@
 /* See Linux kernel arch/arm64/include/asm/pvclock-abi.h */
 #define PVTIME_SIZE_PER_CPU 64
 
+/* MMIO region size for SMMUv3 */
+#define SMMU_IO_LEN         (0x20000)
+
 enum {
     VIRT_FLASH,
     VIRT_MEM,
-- 
2.43.0


