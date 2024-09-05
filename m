Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F26ECD4F59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 08:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm7pL-00070e-GE; Thu, 05 Sep 2024 04:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sm7pJ-0006xl-C5; Thu, 05 Sep 2024 04:26:49 -0400
Received: from mail-dm6nam12on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2417::628]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sm7pH-0003Xm-Bd; Thu, 05 Sep 2024 04:26:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYGQ6ReJPZsi6eyWordK8Bu9zOKt1Ijx+sx1Da2/450KxnmOsJPlXHERRY4lcdQHjXZVad9mueajoz+soYWXOY2NQl9xDwVa4tsQvb7xs8w6PTSElaua1Dr0KOi8kUnrXxbqn+w6OBt+S9Ye8kdw5/FPk0kFUpE6UARXO1QL7bSIbxXA6tbvo+RB9pr2I5Ckd590/RJwA5txk/EZxhLHpgzIT8mnfedyinjOAzIfafgZudk8szlE107bX62ARpEVu0A5VyNQ5cInFRDyPJYGgjTf6hGX8WaPxA8tdoAqTFjPCB1iSwrvRVs0um43y4eWlbHvot8cWby7n0RXvwl5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ino4c6XilnX2r5FZscsc9yDkaCdph6P7VwgpopXA+dM=;
 b=mIZy9W/SOoaSTz78o0VrzvjZLrXw+3tK29XzxhuZvnQQMeAD6Uac3+qoL1NU/mbHmIYY+pMz/ZFXqeM+p7B2h0A/XbSU8oC+Cr5ajJSMK2YEqy9Sl0jp5EkU9vuun4FldD8kRv09FwaR1B7Pmpx5BN9izQyvMPLmbE0/jel8ThQQfq7O0iwWOAC+mN7f9ZmpiH/DT1BsLmJXKPNb536dAMOrT8n8h+mLaVInwIGCtOEcw7nbjIBeicIWpBc90aIFXTEyHu4KlkMDczwOODNVs/+rtFTqC1XZZTGAaEeHsoQCsPUgKFO9WZ4+DKLxqfKxpHDp1DJuSfjrrNZWx+c4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ino4c6XilnX2r5FZscsc9yDkaCdph6P7VwgpopXA+dM=;
 b=M0kqQIBzRgm+yDMakOy4+mC1Cyiz4rWDPZZyU6pBBekAXk9wEwC5iYkG0wCgGSR43KyirnFqIPV44novm8Be1pLGItHz3+vQdxXYtId/s8jmKPPjKrvuRuKABwtbtSHx1JBmwKvmalGznXzQebz/rqmHI2Z0tiwUntkv6+v3jeoMkij289SB9vTW4D1VHFP+6mljBQMlkJk+1PRP7eQAwUiGNsSDDIMdSb52m4CGXhwOXlbKJvbgKAfgqhuWvJHIJatQJRhODRrzzQ8dM4OTeirywz/NT9GhrPhyvXaijnxIoplPM7qJ93OxLTJ4CFiN7BjmFiA5X9r4ye2wCRFYQw==
Received: from BN9PR03CA0181.namprd03.prod.outlook.com (2603:10b6:408:f9::6)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 08:26:37 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::e6) by BN9PR03CA0181.outlook.office365.com
 (2603:10b6:408:f9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 08:26:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 08:26:37 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 01:26:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Sep 2024 01:26:22 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Sep 2024 01:26:21 -0700
Date: Thu, 5 Sep 2024 01:26:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Mostafa Saleh <smostafa@google.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>,
 "Michael Shavit" <mshavit@google.com>, Andrea Bolognani
 <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu
 <peterx@redhat.com>
Subject: nested-smmuv3 topic, Sep 2024
Message-ID: <ZtlrLJzZqpnUrZQf@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 93dcd5a1-917d-4a9a-003b-08dccd8475b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AlvNLplG9pJo+S/r4BWvUfX4Q3wPDptxy8WUvVOCYVx0nJ79cBNAOAtnU37A?=
 =?us-ascii?Q?tNKrWRSxnF7AGSIUjq5arNEA12bIP5o0SfIzfEIxgZaxQPt14HUEbmHW37Pz?=
 =?us-ascii?Q?oMEuY/sBbJkmyXl+i1dHG/ewdDd8yzeV1K9UoGoQdZCHWkFXoFnX6DepjNqL?=
 =?us-ascii?Q?xXYNq6ONWu21TBlsbGcnJccHJTLPMkjovwfu7CR95ir4zisYWRxWQCM9Cmx5?=
 =?us-ascii?Q?OhpO8L18tnBCc9O0UkgLmNVoCexJ3Fvv1SCrj3u79svtMt0wMcNYnvE3FgGS?=
 =?us-ascii?Q?6uUOfw+L8PyhvEhC1EMVV/4vlr2iV2ue66/EBwuR6jor9Hse8W34Jg4Cxbm0?=
 =?us-ascii?Q?Gb7R3asEL/w76oQ9FghXITa1dClP9C/XEohRTouxLga97SwCM/CcbfbLUlFD?=
 =?us-ascii?Q?Q/HvbfkD0/2E8V/Mpe151Yq5z0cIafBiWfi249sUBAnPGo0UI7X2MxJXCrC2?=
 =?us-ascii?Q?rRazMyqPhN0cW5OIcMr2Jz/cMURm1QOJAMsW8on2ha4d8tX91p3HAw7jcXQl?=
 =?us-ascii?Q?H3uHJhhfWhQFPrfRKGHUq332+LdWyUfyMXu1oDqB1c6GTUmCmaWb3R54yT1x?=
 =?us-ascii?Q?8xErVe8DORbU5iY3M/a6Q7Kg7Z6uIztlw4UQBz62ZP6BDUrtYspvZ90EJVEZ?=
 =?us-ascii?Q?FR9Hu5vBQ6We9XU0V48VMjqqGo3cyl9PdZNkrs7Bmv7vdQv3x+VgMDpoGPnR?=
 =?us-ascii?Q?MbuzYORzPrWfHTeBDCgnhT2iXHVVclzTZyqfqn6o6WbuXIyGi05H8It9+Mul?=
 =?us-ascii?Q?BDv034CDfXAtLMroWOS7Ku5qoInlZjspwXuduX2R73inAyXNG5V7u4qRsuXv?=
 =?us-ascii?Q?vDn/Fae9PlRZk4xCyL3s4mzQg6CfDq+drteGg559Cf76cvaVKz74L1HObFIk?=
 =?us-ascii?Q?/LAg9RGIHqcCbLxCN7JzgkOcHzPrQCDwvpyMtsby+aBdqeUCOwQ/hq1lEQ4e?=
 =?us-ascii?Q?sofyy9XyUFEZk8bRJuikqDAZoVZJWZfKWTbllZPR+GlRvPlBs+dOOrGIey2p?=
 =?us-ascii?Q?xsK2VV1UFiSXjjSgUd2Q5wtgLn07yEL5u9+Io/8nxbt46SjnT4m+K6M/rJfZ?=
 =?us-ascii?Q?fF9+YonpK9m5NseVNBz8efq8WBqZrYO6VW+QxlzehBR36m1Etmf6kOjt7vqt?=
 =?us-ascii?Q?kDqlVyZxMImEHgXdLieLmacBfN6pIox++C3j/yCEy961mfVKToIzbQK7XJxu?=
 =?us-ascii?Q?/AtCCTjFjeAH9D2ZSc1txvHTSbuzokoy4GNevbPVPix5gJwi8nl63phYXIW7?=
 =?us-ascii?Q?x6AuQKDncehGJ5VeIOm+d9zByzgyC9cZ1bHho1TonP9Sam1eYOLyO0B/+zK3?=
 =?us-ascii?Q?eQtYzieSvh9O1SISQCmult4M+kQB7sz1s7xoHLBlrqzvH+V2PIXxsijA06dQ?=
 =?us-ascii?Q?KdvqRAYz7bgmDBTVsBiqWmnx+qbUwl9aOG3czMl82fgkzLau1FP67gdlaIjU?=
 =?us-ascii?Q?Cd7NoUOuCSyVVPbW5Aezy9WnJItrXpjH?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 08:26:37.2066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93dcd5a1-917d-4a9a-003b-08dccd8475b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957
Received-SPF: softfail client-ip=2a01:111:f403:2417::628;
 envelope-from=nicolinc@nvidia.com;
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

Hi all,

Hope I didn't miss anybody who is related to the topic. Please,
feel free to add!

<--- Background --->
As some of you know, there is an ongoing effort for nested-smmuv3
support in QEMU on ARM, working with the kernel IOMMUFD uAPIs:
[Nesting for vSTE]
https://lore.kernel.org/linux-iommu/0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com/
[Nesting for invalidations]
https://lore.kernel.org/linux-iommu/cover.1724776335.git.nicolinc@nvidia.com/

The kernel patches are still under review. Jason and I are hoping
them to get merged at next cycle for v6.13, which means the QEMU
patches might start a review process as early as Nov/Dec?

That being said, I think we are way behind the point that patches
can get reviewed: most of the QEMU patches on my branches weren't
touched very often, but merely updated to the latest kernel uAPIs
for verification. So, I feel this might be a good point to gather
folks together to discuss about the possible timeline and ask for
help. I think this would potentially help folks who are going to
attend the KVM forum (or LPC) to carry out a discussion. (Sorry,
I won't make it due to some conflict..)

<-- Task Breakdown --->
I previously sent a RFCv1 series collecting comments/suggestions,
for multi-vSMMU instance design in ARM Virt code:
https://lore.kernel.org/qemu-devel/cover.1719361174.git.nicolinc@nvidia.com/
(And thanks again for all the inputs!)

The main takeaway from the discussion is to
1) Turn the vSMMU module into a pluggable one, like intel-iommu
2) Move the per-SMMU pxb bus and device auto-assign into libvirt

Apart from the multi-vSMMU thing, there's basic nesting series:
0) Keep updating to the latest kernel uAPIs to support nesting

I was trying to do all these three, but apparently too ambitious.
The kernel side of work is still taking a lot of my bandwidth. So
far I had almost-zero progress on task (1) and completely-zero on
task (2).

<-- Help Needed --->
So, I'm wondering if anyone(s) might have some extra bandwidth in
the following months helping these two tasks, either of which can
be a standalone project I think.

For task (0), I think I can keep updating the uAPI part, although
it'd need some help for reviews, which I was hoping to occur after
Intel sends the QEMU nesting backend patches. Once we know how big
the rework is going to be, we may need to borrow some help at that
point once again..

Thank you
Nicolin

