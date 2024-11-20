Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20D2D743D2
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 20:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDrZX-000467-65; Wed, 20 Nov 2024 15:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tDrZV-00045L-D7; Wed, 20 Nov 2024 15:45:09 -0500
Received: from mail-dm6nam10on2061d.outbound.protection.outlook.com
 ([2a01:111:f403:2413::61d]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tDrZT-0005VZ-4e; Wed, 20 Nov 2024 15:45:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGwEhjGgdAxOEdptV0HrIBxjy4Fg5fSnC4v2LTMpksuS45vc/XyTNEUET03YIP1cB3hveudj+DFWcUM6OcIVKkhKmNMbDnlgXVNm78ydxQ6WHmW/C2+3Da5Puazq4n38spszXUjYQb8sdPo+KLSNQ1wi3whpfinO2zNVTLgdhSwip1xfQarnpJ3SKIS7qy7QYICpJmjlZO1PUO2vXw8QXjSKIeeTWR/m/eM4dkzk9hUouELV6e1csXJDlY4jr2pvJEj0cetQpRlR5BvV062cnLkhxbqWMVUhT2eg2L4OEpnEXRKLE5+vKfDIOrqOikks1Re2NHxZwGxJZn8RYYcLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+bEe2WXzRh6rlF2wEsb8S+5FYiehqijvzBSZ3uVc7c=;
 b=xj/nLjnvTAm8AHgc9OIT3xwyLuF0uirBWE/OeWZYlMuaR/9SiYadEm9hPKT0CNpKfABsTWULosD9zEvNDs9lVmtpjsPYJZ1wA8vhh0Q+4S56+aN5fQ9xL7u1TLm7bBA0qTjMafTsq3QK6aZi//ujeAznm1XnBPzJTjpCrnRYuYF0m0rbX2+cZdT8/p5VmuiZVQjy7N2IyKiGZ18iRltkTE1ZAvsnVHourcE7bEoi0ooKkwZOOdEhZQ2Zd69/nbKNeu7xyvGco5ZYB9Dhc93S5JA2u5Oaoj8FweXixN4BPx0C3Af8KjrtOUpNWVlLlGheJfKzChyhVZf6/9aQtCmE5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+bEe2WXzRh6rlF2wEsb8S+5FYiehqijvzBSZ3uVc7c=;
 b=VjySbxErs8z5YJvNzCEPNm1BCefAOTo2IgRsArzRB3K3e4rBUcOUpM6OhPLbeCLjYaqcQHkfs80XVvPeRltnAtbRpi+xXM++mOE8W2RZz4Mw76LoJPpw0gR0TRF1i5rD6Cz5G7TtjHudd8AhZx0oRFRXiJp3pkFAYlY8zgsmJ4ajHDxRkJ13DmtRkT17WFJO38y8I6G1JbnWISXhUartx4XNyWbx3ASLsayMgv4ZkVKegJwCm3+U1amcIvEd8Apm2kwsVxsROnaebGUHNf2m8cuH3iHx8YUmN39kYE8VxjAbZbEVYXnH5+oTgAOX81X8Cdul/QgO84PZci+KdX2psg==
Received: from MW4P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::31)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 20:44:59 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::e6) by MW4P223CA0026.outlook.office365.com
 (2603:10b6:303:80::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend Transport; Wed,
 20 Nov 2024 20:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.0 via Frontend Transport; Wed, 20 Nov 2024 20:44:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 20 Nov
 2024 12:44:46 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 20 Nov 2024 12:44:45 -0800
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 20 Nov 2024 12:44:42 -0800
Date: Wed, 20 Nov 2024 12:44:47 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Mostafa
 Saleh" <smostafa@google.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>,
 "Michael Shavit" <mshavit@google.com>, Andrea Bolognani
 <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu
 <peterx@redhat.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 <nathanc@nvidia.com>, <arighi@nvidia.com>, <ianm@nvidia.com>,
 <jan@nvidia.com>, <mochs@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: Re: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Message-ID: <Zz5KP0wpGxDNgOTM@nvidia.com>
References: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
 <1845a6b8-5214-4379-85f4-3d36b61059dd@redhat.com>
 <Zy0jiPItu8A3wNTL@Asurada-Nvidia>
 <e36a1c1c-c880-4c64-82f9-34d55a04bd00@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e36a1c1c-c880-4c64-82f9-34d55a04bd00@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a50da1-d5f1-4e28-c1af-08dd09a432b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|30052699003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jdx/1g94nppHLqEgzw/ccyVQTOmIQCt42ASlLLDyrOvtOvIX7QN3f42uner3?=
 =?us-ascii?Q?3q46sZijFEERC54TLl0YmFAL2pujnngcTdIweVSAj2IggweChxQTuSpGhsxY?=
 =?us-ascii?Q?x7QtP5OD8R07fwyU4qbBYG6Hf/V2pJZgRPyDdqFaS20UNs+DXfVlx3DVOz7W?=
 =?us-ascii?Q?8gQWuEMUJ5ZPa9JGR+E5yvX+I11zEsRhtR5FrS6kktcJ+gmyrRe9t9s4nYvY?=
 =?us-ascii?Q?WMDONJsO4vgSWfJYeblbiASHyU4muUx0aKbibUCtbcuXD+53ZeYTpWayVrRy?=
 =?us-ascii?Q?PDAyhzCJc5WZSpz6FhxnCmz2nNONEy9eArW7qMNBLxpPP8XpyXSSjios87ly?=
 =?us-ascii?Q?/2LKOQHdfyuwtcdr+B75EzMyFuuR3yY44GllIM4wbsDzeG1BHqFI93nBQTF0?=
 =?us-ascii?Q?nZg0N6Bc8Bnj5y9ypDmv3ptKrSK0zQWRLW8dq7N6Fnyus4NZkJrXefH1d73d?=
 =?us-ascii?Q?8NvIBzFZmdjDhhk8QxoaTre3VARLnOOs0Q1HQvHCb0/8HOu8bbCjPji4qVGN?=
 =?us-ascii?Q?XHWeRcznnELvy7MK5Y+iNoZ1JREKOVizX+MezX66ikK/6x5cuk8FEO8r+Zn/?=
 =?us-ascii?Q?ddb11QaAVLGZBR2jJRnL6pytH10Czt0YW7lHxGx3j6Prf1TsgEGaUIy9aVo9?=
 =?us-ascii?Q?tCs1ktneg0cclqyy60euNdGqvN19EgBkT5x+iYDBSH/1mNWlokJfcMFkUrZH?=
 =?us-ascii?Q?3xRD4XG4HJVAqZ2ksvthn8s5WuulGrmpCuowwfXxcOozn7ZyfhwBs+lYMJK+?=
 =?us-ascii?Q?iy+afjt+7H/YG6Cm0T6+dF6sHOS87D57OJLtE2p9bJqfvRsQKgLB2SuJxk+x?=
 =?us-ascii?Q?D3PJsSObjGm1sjCUmYiZr/qEG0Js6O7VZcZtyt/jY7OoCrvFF8P87zzO7cx8?=
 =?us-ascii?Q?FGVTbllY9uQ9wgw7hk0UXAiUzN10DXGcChgXCl235/3N3bsgQ5Wp4XBEpJkA?=
 =?us-ascii?Q?y/XidOS9awZmZKV9f/l2To+VmmhU3C/C0ebGHjLPebmTaP+TnnWtpKg9e40P?=
 =?us-ascii?Q?9neI+8uhB7P5aN5KDs/xrP08Du0YqU/iaHlDjt/AY29mL5at6oypMcCBpMK9?=
 =?us-ascii?Q?gpLqCsblRtCSb02kN9hgHhmLjmA+bngUcexmHIPSjHz0p3BZsxew/z+OWP/f?=
 =?us-ascii?Q?ipqSIt56Ci+exZMUWNY+dpmFDEadS9UZhYE/jU+DKSlK9o1JEr6Qr9rl+4kZ?=
 =?us-ascii?Q?ME6b+4fsEuq3je+IPdONMSiMG1X9CAF168ll2a8UJL7aEF+dL/DIrAvsPqH/?=
 =?us-ascii?Q?LBCserebtpDvg0LAb3QNIzaLz2KUgR+QHbIzthqxT3bqffv0SL69aQWWDLxp?=
 =?us-ascii?Q?rQY+jAL1EiE2RA7fG89fa3jyiTceP7aFx/f3pOOl9aBCND+tsV2CGWtvXPBq?=
 =?us-ascii?Q?LVGC+rnrYhU5utxtx3U1+UAeOVF7R18jbHL9lQghDodxi3cLcg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(30052699003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 20:44:58.5756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a50da1-d5f1-4e28-c1af-08dd09a432b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
Received-SPF: softfail client-ip=2a01:111:f403:2413::61d;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Mon, Nov 18, 2024 at 06:59:53PM +0100, Eric Auger wrote:
> Looking at your branch I see the following series (marked with cover-letter)
..
>     cover-letter: Add RMR WAR for MSI mappings (based on former RMR flat
>     mapping and not related to *[PATCH RFCv1 0/7] vfio: Allow userspace
>     to specify the address for each MSI vector
>     <https://lore.kernel.org/kvm/cover.1731130093.git.nicolinc@nvidia.com/#r>
>     I guess)*

Yes, I think we would postpone this series, by simply putting it
on top of our future shared branches while waiting for the kernel
solution gets finalized to a certain degree, to make sure an MSI
2-stage mapping could still work.

>     cover-letter: hw/arm/virt: Add multiple nested SMMUs (Nicolin ->
>     Shameer)

Yes

>     cover-letter: Add HW accelerated nesting support for arm SMMUv3
>     (Nicolin)

I think this will be moved to Don (or Don/Nic)?

>     cover-letter: Add VIOMMU infrastructure support (Nicolin)

Yes.


>     cover-letter: intel_iommu: Enable stage-1 translation for
>     passthrough device (Zhenzhong)
..
>     cover-letter: intel_iommu: Enable stage-1 translation for emulated
>     device (Zhenzhong)

Yes. We'll need the HWPT infrastructure patches in Intel's series
and I think Intel's progress is faster so Zhenzhong should be the
submitter.

> *Are there any posts upstream for the rest, besides Shameer's respin?

Not yet. I think the dependency should be
(1) HWPT infrastructure (Zhenzhong's Intel series)
(2) VIOMMU infrastructure
(3) smmuv3-acc series (2-stage translation)
(4) Multi vSMMU instance support (VIRT and IORT)
(5) RMR

> *
> >
> > I expect the IOMMU_HWPT_ALLOC (backend APIs) will go with Intel's
> > series once their current "emulated devices" one gets merged. And
> > I think I can prepare IOMMU_VIOMMU_ALLOC patches for backend APIs
> > aligning with HWPT's.
> Can you point us to the actual series including this IOMMU_HWPT_ALLOC
> support? This would clarify which part you are going to work on next.

https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_nesting_rfcv2/
Though not planning to do so since it's unlikely the case, yet HWPT
changes could go with the vSMMU series if we're running faster than
Zhenzhong :)

> >
> > That being said, one thing I am not sure is how we should bridge
> > between these backend APIs and a virtual IOMMUs (vSMMU/intel). I
> > think it'd be better for you and Red Hat to provide some insight,
> > if calling the backend APIs directly from a viommu module isn't a
> > preferable way.
> can you clarify what you call backend API in that context?
> >
> > We also need your comments on vSMMU module patches that are still
> > roughly a draft requiring a rework at some small details I think.
> > So, if your (and Don's) bandwidth allows, perhaps you could take
> > over the vSMMU patches? Otherwise, we can also share the task for
> > reworking.
> So we have started the multi smmu instantiation review and provided
> feedbacks.
> Which part can we work on then?

This one:
     cover-letter: Add HW accelerated nesting support for arm SMMUv3
i.e. (3) that I put the list above.

Thanks
Nicolin

