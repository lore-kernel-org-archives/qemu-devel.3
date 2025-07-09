Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23057C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 00:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZIrc-0001wj-TJ; Tue, 08 Jul 2025 20:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZIrT-0001vg-7A
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 20:40:35 -0400
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZIrQ-0003zJ-8Q
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 20:40:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuRf8zMWz2JbTCAY9TWz47kpoxmMc7XWQJDPPo2xFGltKJyVppPCexqKe0DeQxvaLqjsreT7mI7MQFz3YUL+7oD8B3cHjnK0efk6HYkS01EwgrgpZaI0ptRPwcbOJqS63e6PjgHHKuRsjagDtgIVPQj+cDtL3sjm8xru9hoZMuOn8i/L6mPYOCWmjpTApxigLSxIVrJhnoEdxoRiPhS+xLtvCWofN7aUOuIP38stOkxuyO6RXROqv8YGSoyJ60CxkSXoAdUCyefAC2nEXhaN/q5y71xi2e44B6EqBuDY0pusKnbELRKr2UYrd/7sJ7GHEwK8Z6bkpE/COsyISwKj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XYVJKWXawt+ktqM09NV31i6azefyLYp5rmptfPpQmM=;
 b=EszdzouqWj6H7+0nGP9MEqzn0yPfdqJh4J+KefeubfHRcqmwdpv5eYpfML/BHai1jiXev9HPI0Wtan627YJ30415eigW6Ue/UtnGjy/OfROIAkafer0cuO76RlZKgxgag0KsffIV61rlL0bAN/at7vcVt+omMsS0WtlEvkl6Nyfbt8IiBhK2YanvLs4dOkFu8j5JTP8abweOCYJ8W+BJLjHEBshPv94IEaM7EVQaQm/SGhu9YAy1ymUwdPEpxWcDSh/sZUVnc3kGNPV7vqWPk4KTNt4Rhjwn9FsHX7gzi159RFExmthI/knq4wJX9HYbyzRzDjKr7bbVKxlmKM7JLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XYVJKWXawt+ktqM09NV31i6azefyLYp5rmptfPpQmM=;
 b=e0plX9n/L3IyUgsMtn5u+g+GcrrcC23fFSzxIz/LVHro1k9HomdWamZ7HMBuLjZf9ef1ddXboyJGfA8udlG3iSHxPuQjeqik6l4ZvoJoXCzbuRLJW2i/d8BAD5ts+QOCDubzRhun7VP1ISQWONSNgLtV499l5+UH4OPXkB2sfURAH3BBTurPL3RF5h1w+llC9H/G5qKBgN8mUm7dgKoaIM4FGtldAVh6fH3XqfjxJ0g03hMZtx1Ys7jKjXM/3/M39AydvyZr54Jgd9y1TVaqrOmQ2q6wXmfjBr8EjPPUIjh+9vY7PZDYp80FrxQa4Ko41TE3StjJU31KFR/WzsQl9A==
Received: from MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25) by
 IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.23; Wed, 9 Jul 2025 00:40:23 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::4c) by MW2PR16CA0012.outlook.office365.com
 (2603:10b6:907::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 00:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Wed, 9 Jul 2025 00:40:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 17:39:50 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Jul 2025 17:39:50 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 17:39:49 -0700
Date: Tue, 8 Jul 2025 17:39:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Message-ID: <aG26VBqzOnLAWC5z@Asurada-Nvidia>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-3-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250708110601.633308-3-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bac8a49-a55f-4885-beb8-08ddbe813018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1DbS+BzTMWKx/WYoAOn/FOvdiem4iuAa8Ac+CLrWFjAiFohKmws0PySkjsNZ?=
 =?us-ascii?Q?e45q5Jeix1qS+WR3hQVtK9tjolEoLkGaXxi3FTKSuuahdqFTuKYm0igjWcyB?=
 =?us-ascii?Q?CCrdKIj3cXH0iiPN7NwDIt1ulAEtT+uccmczDOqgI1VXRDc+slyXGRdAI3lB?=
 =?us-ascii?Q?5jTVcHT1rRGIbURwyToS8HpKikDENAWNTOtjpfIpnYvQwdFULZFnDVPB11k1?=
 =?us-ascii?Q?cTfKhWxSWAO4idyICYl2/6CKZpAnWI+jiJ2npQE8odsZucpJZEFKv284A9Im?=
 =?us-ascii?Q?n0W6uww/B0dbDOV1ErkMkBLGXJ9jFcYVH/AjJabOlo/rcxd2LnRUmHy73AYs?=
 =?us-ascii?Q?qQNCkOBzBe/ZkvA8MVaSTsIx8vqTOg7KR0l9pYXdYnLw0hVuJgi3tR+/qTBb?=
 =?us-ascii?Q?fZtEGyvHPZxZTPeEn3tJp2sQdzfFY1qXZMtRDFwc+GedJCb8vh1h3ikOrffp?=
 =?us-ascii?Q?tpJqa5tJKxJzGrYoHBJas8515i4VOJoGFaFHVjkv/6ESR3TakE6gFJ7xMJAQ?=
 =?us-ascii?Q?TqBjXNHiMz89F1N3D5SAoQPRvh9VFQOKvSFDkkbioFFfteQ8oz8L3BBrN9VY?=
 =?us-ascii?Q?J6eqYfbheuNT+gsKZKy1CGFpLi5sNGYsaU50MyDXHPukAr/y0yw23tVuFnVz?=
 =?us-ascii?Q?FOOStFBe3DxxBbnyfVebR+nPhIolIbwoukGK2nQ/Yvpkp0ooJoyJzd2szdNO?=
 =?us-ascii?Q?jowrWW/hX3+O5+U2Sk2mnKxIsCmOZsQQ+P3ppxih8fj5o2j0CttxP0BxSa5O?=
 =?us-ascii?Q?Il5KepUfhmYkgqQ+0DRnGZs87OpbvRySnRDkhH5zMPAdTsgf2h5c9+crfjzk?=
 =?us-ascii?Q?aHS8NRnXOmbwr4jhvXCLvQJLOnxrL6ZpOLvJiKRK+UVBexsLQqfwdVs/dLBW?=
 =?us-ascii?Q?PI8PdBZUfKxagUJVU2wl89rbKcHk6syKTJUZv5XR0kzwN7RcwoksQMo6/TDy?=
 =?us-ascii?Q?ez9tOD2udUaCOzt32Wrkc56niNSx5yrUqOrN8lWBSlYd3OCa+KcX7nFM65Ut?=
 =?us-ascii?Q?00fCXlFUrryMcTcc54zWg4tm3e6UqphyY0RxhfWyPkC9HegGphTizvq6r/Gp?=
 =?us-ascii?Q?60tdbAuZTxwV5Ud6FMQEoYJ5d3FKFnq2Nh508+qrEm9JXBR6JcqLCeykcNxp?=
 =?us-ascii?Q?jWGoB87tivJd5hxq+YOQVMCEw/zI65yG/29tRFBMXc6Ucbx2RjqZFk62ILtT?=
 =?us-ascii?Q?sIffZixgX0VYUhJNv6HdxftKtzDyNNl9y2vzOgxlgmQ5fy5+YKRJ3vgj5lNT?=
 =?us-ascii?Q?gqNvquxlWlAatP2MSXTv62K6fG6uvtk0N7okY8ojk1kvVyf698zbaZZH6rjr?=
 =?us-ascii?Q?vWGFCEbkCeH/y0edztA3LtLQvza4GVCTtABFg5UQGt/VroAc9D2/aburcHoc?=
 =?us-ascii?Q?AbE0J06WaaIbNRMfJGlv9d/ujvSB2bXNDlUTKcywjKuBY5Ea1UiLh0JlCtEZ?=
 =?us-ascii?Q?7QPmzba9cXv9HIN3B0ek5mQuxWlrDI9YeSe0L7vgk2TAsqmPjcGjHKgN3g2M?=
 =?us-ascii?Q?KQAy9GxmuJeDrIgD2wIGua1EFK8/mAdOFakU?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 00:40:22.2977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bac8a49-a55f-4885-beb8-08ddbe813018
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261
Received-SPF: permerror client-ip=2a01:111:f403:2412::601;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

On Tue, Jul 08, 2025 at 07:05:43AM -0400, Zhenzhong Duan wrote:
> diff --git a/include/hw/iommu.h b/include/hw/iommu.h
> new file mode 100644
> index 0000000000..e80aaf4431
> --- /dev/null
> +++ b/include/hw/iommu.h
> @@ -0,0 +1,16 @@
> +/*
> + * General vIOMMU capabilities, flags, etc
> + *
> + * Copyright (C) 2025 Intel Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_IOMMU_H
> +#define HW_IOMMU_H
> +
> +enum {
> +    VIOMMU_CAP_STAGE1 = BIT_ULL(0),  /* stage1 page table supported */
> +};

Thanks for this work. I am happy to see that we can share the
common code that allocates a NESTING_PARENT in the core using
this flag.

Yet on ARM, a STAGE1 page table isn't always a nested S1, the
hardware accelerated one. More often, it can be just a regular
1-stage translation table via emulated translation code and an
emulated iotlb.

I think this flag should indicate that the vIOMMU supports a
HW-accelerated nested S1 HWPT allocation/invalidation.

So, perhaps:
    /* hardware-accelerated nested stage-1 page table support */
    VIOMMU_CAP_NESTED_S1 = BIT_ULL(0),
?

Nicolin

