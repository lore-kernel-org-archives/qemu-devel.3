Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F233D5D688
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 20:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t99AG-00022E-PT; Thu, 07 Nov 2024 15:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1t99AC-00021p-NR; Thu, 07 Nov 2024 15:31:33 -0500
Received: from mail-dm6nam12on20608.outbound.protection.outlook.com
 ([2a01:111:f403:2417::608]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1t99A9-00080E-Tj; Thu, 07 Nov 2024 15:31:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeP97S4IRTUEGRqc6IfgBkRJ4b+Pz/zNhVJ9GOXYWByVBUjtuua5rnwvaqIGexW/S0ACcMQ4v+mF+UDorkchf4Q0g+JV4YTpDQZYRxgMeDBjaWt8hPDyv53FTMOpd8UEeuxCoSCLVVzNJEZ7viD8dWxESR1lla5EjlH2GtilzTS2OZIdkcDjR+5z3bY++vPte9Swoqk4cgo1cKEhJ5kJ8DjcRndhrpUyJtzmcqsIgMRM09QSZZhAnsGBQKkVhdRkYCgbI5e3GLePfTG7BY2qci6AMgCiwzMdIyIfqp5+zJ3hv9qObUG6h2pX8D1thM2pPU2ztXNI+9T5sfYAjuZDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOqOlXN4SWeSzW877D2Knnkl0qhGPhPFAUGvGF7bir8=;
 b=adFaZrlXaL2eKOfsGtHAMoifpT1JN+fHJiy/giAy3Ozo3JYsmP2qSgI027EJPPlmE8hfUriYbGrqQB0qcZNf9qRZ8bGZ58rpWEVh9VuE16mqzsnSskFJgs0EJU6o/ODjm6Sje5wSimgDNtyYfCo6MpFeKgy7cds4SDuh/DYN7mdMuSwPJPlp5S9hKUxwEnU8n+IMkHxD0nJutEGHVeqwm/u8Yf9wbo4e4xY7FD/cV3MS1kk7qyMqfz2LQweS65nfcHMmKYM25SEA1p61y+Lx4GgbfCdjTfcgevCBpT8cSSH40rG6iMW8sz4NVcAXMVeCLJDwZLhEF8AttTMoZD6yRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOqOlXN4SWeSzW877D2Knnkl0qhGPhPFAUGvGF7bir8=;
 b=FeBZtvHA0XVcTfdlteeNJQtNFtaf4s9aTkiOLGVayoJGGrSXre+mkKNh6Z4S9WAa8jfsVcFsqD43Va8BVcGTZCwtZdX3tFCYpYomKhMMz4kjn0oZiF6x+Nz5EVwuB8tahoTJaMfjCv6qT44qpcBjowG3yQrg33rzVnq8X2YuyAR8if67WzhiX0Oe+9OGrw3dwLnr1+oLPKxC85IjG2KHsyq5UYVVHSabQwRh0Fbj8+6Ycd0XWCrwRfZ8EhBO7zNODzkFtQpNhpCBZ3iPizHjNnDo+i9DeKJtlQpJGcoKOeZrYVykUHp5rs3Zy3kBP2v9Ib23Xa6C72pWi3B/9hH+/A==
Received: from PH7P220CA0151.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::11)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 20:31:21 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::b4) by PH7P220CA0151.outlook.office365.com
 (2603:10b6:510:33b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 20:31:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 20:31:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 12:31:07 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 12:31:06 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 12:31:05 -0800
Date: Thu, 7 Nov 2024 12:31:04 -0800
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
 <jan@nvidia.com>, <mochs@nvidia.com>, Don Dutile <ddutile@redhat.com>
Subject: Re: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Message-ID: <Zy0jiPItu8A3wNTL@Asurada-Nvidia>
References: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
 <1845a6b8-5214-4379-85f4-3d36b61059dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1845a6b8-5214-4379-85f4-3d36b61059dd@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: c5710021-0afe-41d8-7678-08dcff6b23e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J3nHVoceyRjPogE+/Bua2/pqSp0R5qtBePJRokVwWfwKMTaLTVHzp3u0Q3lm?=
 =?us-ascii?Q?sQmWn2ZNLPOHbQeph5Zh01CYq5Lkvrz2AVKfAieTlhoBqU4kvEFAWgHpeT6z?=
 =?us-ascii?Q?e7sGv0jSASE497jEJhljzYk7J0ulu1H1JP6YeDTRoSinHMvXineMLKPmRCD2?=
 =?us-ascii?Q?NiyfgKhIjVSzXnfAvJtdT8iGH6e73ue0wHebGWewIaIGw0rECsLZxiLZA8/a?=
 =?us-ascii?Q?zIVvGcp3OKkn84U151BEhLY50wpm5E49H0HIh3pJeLJ0KRM9cz8ipgR4G3YQ?=
 =?us-ascii?Q?RCgrOCOuUQr+nyXKIawX1xAHeyOCFhqXyqHP1750JovtG9rFvYhHSjRxzuaC?=
 =?us-ascii?Q?Gm6tR9/D5supaaHLmOkvEOzde48YiOsdSZJJvbduRlE6vpyGQRDGydeC8w6K?=
 =?us-ascii?Q?EERSIut6PueH2aIwtD+XszmnTPEFkXiUutlvqPzmyaPtuQvMe8GAGyIEL5AB?=
 =?us-ascii?Q?swwdtWzTTJzRIrKPBfGwxVXSddbFH9Xwl/MUUnCWRmF83NBUaLU5WhMC7HYw?=
 =?us-ascii?Q?aqinxHL7CLC1dX+fl99yQfKHGT98csRy5VlcDaF1LCw/Go9ehJNHj1P1dSp3?=
 =?us-ascii?Q?xRubCPuBIf2MkSxSHSzvu/coMWEKl32z/onGNt3bD1hz3Pmh1nCAY8tudU13?=
 =?us-ascii?Q?TVCClGJAHxNESzgVBBhI5PQ5tWLe9XdVOvJi8yT7zOUWyZV1Vb3akrdrcHt+?=
 =?us-ascii?Q?+9vNH/SIbp2+D3BqjBa44+Tf94oZjibda5c/KNvD12YG7jcZsLhLCzY1pWn/?=
 =?us-ascii?Q?QL46m9qFDCJk+KE5r1OeE3N1OLZnId/iUwA//hLPV+y31hmnGfYDLsaJieEu?=
 =?us-ascii?Q?iFBT7pXlJbvG2zLGUVXNCq23f3iUE4U7HRMlI3i0kl7K6nuzLA4PKTxpQtZE?=
 =?us-ascii?Q?1UjjWSdI/SL8oVB68vpaB+aITktoYcXaITKrc7VGeqlVMc05NYnQojIuzMVB?=
 =?us-ascii?Q?Dl2FgJHA2acR+IesF6ut67GMGaEi2oWG3vu69MN4MD8U9vvEQfAmqGu+JtqF?=
 =?us-ascii?Q?18wfp34LUwNEUF/uTKeNGT48lnps3tBWWsnLIuCBqrwQ05MwU1p6l7+urib/?=
 =?us-ascii?Q?9Tslk/C36z2eADTdEBW6+2cO6zcWKVdtsMw1HYDG34O6qoqAMxQ3+ccX3QUv?=
 =?us-ascii?Q?eh/Wq9f6ds1o5t7MzdpYDnoESyvXJYOr9uUEEONfVEP70c6iQ2Upn9EyPuWZ?=
 =?us-ascii?Q?SKYycshz3D5CwxxKR/VJQuB+BZJ3xa1NlYb6IiqVSNu1fHTSeubnExxutINK?=
 =?us-ascii?Q?vND0dSIpW42xeiqv3Y3g82wE0iFN9PlEarcYUncqLJdxC1rtbTIMNwpKqh9B?=
 =?us-ascii?Q?Tn90lXVc8zqFFX+iU9WgSPiZWRrEasIVPdH4MAgooyYzeh1ZlXyXUmeGRfng?=
 =?us-ascii?Q?ID7aQA3+cFrCJ12/q0SLQVjy9hsnNY6z8jG2FThHE3B1tSEdGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 20:31:20.7654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5710021-0afe-41d8-7678-08dcff6b23e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655
Received-SPF: softfail client-ip=2a01:111:f403:2417::608;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

Hi Eric,

On Thu, Nov 07, 2024 at 12:11:05PM +0100, Eric Auger wrote:
> On 11/1/24 05:09, Nicolin Chen wrote:
> > Hi,
> >
> > This is a continued discussion following previous month's:
> > https://lore.kernel.org/qemu-devel/Zvr%2Fbf7KgLN1cjOl@Asurada-Nvidia/
> >
> > Kernel changes are getting closer to merge, as Jason's planning to
> > take vIOMMU series and smmuv3_nesting series into the iommufd tree:
> > https://lore.kernel.org/all/cover.1730313494.git.nicolinc@nvidia.com/
> > https://lore.kernel.org/all/cover.1730313494.git.nicolinc@nvidia.com/
> > https://lore.kernel.org/all/0-v4-9e99b76f3518+3a8-smmuv3_nesting_jgg@nvidia.com/
> >
> > So, I think it's probably a good time to align with each others and
> > talk about kicking off some QEMU upstream work in the month ahead.
> >
> > @Shameer,
> > Do you have some update on the pluggable smmuv3 module?
> >
> > Updates on my side:
> > 1) I have kept uAPI updated to the latest version and verified too.
> >    There should be some polishing changes depending on how the basic
> >    nesting infrastructure would look like from Intel/Duan's work.
> > 2) I got some help from NVIDIA folks for the libvirt task. And they
> >    have done some drafting and are now verifying the PCI topology
> >    with "iommu=none".
> >
> > Once the pluggable smmuv3 module is ready to test, we will make some
> > change to libvirt for that and drop the auto-assigning patches from
> > the VIRT code, so as to converge for a libvirt+QEMU test.
> >
> > FWIW, Robin requested a different solution for MSI mapping [1], v.s.
> > the RMR one that we have been using since Eric's work. I drafted a
> > few VFIO/IOMMUFD patches for that, yet paused for getting the vIOMMU
> > series merged to this kernel cycle. I plan to continue in Nov/Dec.
> > So, for the near term we will continue with the RMR solution, until
> > we have something solid later.
> >
> > [1] https://lore.kernel.org/linux-iommu/ZrVN05VylFq8lK4q@Asurada-Nvidia/
> 
> At Red Hat we may find some cycles to resume working on the QEMU
> integration. Please can you sketch some tasks we could carry out in
> coordination with you and Shameer? Adding Don in the loop.

That is great!

So, given that Shameer is working on pluggable module part and we
have folks working on libvirt. I think the only big thing here is
the SMMUv3 series itself. Please refer to the changes in the link:
 - cover-letter: Add HW accelerated nesting support for arm SMMUv3
 - https://github.com/nicolinc/qemu/commits/wip/for_smmuv3_nesting-v4/

I expect the IOMMU_HWPT_ALLOC (backend APIs) will go with Intel's
series once their current "emulated devices" one gets merged. And
I think I can prepare IOMMU_VIOMMU_ALLOC patches for backend APIs
aligning with HWPT's.

That being said, one thing I am not sure is how we should bridge
between these backend APIs and a virtual IOMMUs (vSMMU/intel). I
think it'd be better for you and Red Hat to provide some insight,
if calling the backend APIs directly from a viommu module isn't a
preferable way.

We also need your comments on vSMMU module patches that are still
roughly a draft requiring a rework at some small details I think.
So, if your (and Don's) bandwidth allows, perhaps you could take
over the vSMMU patches? Otherwise, we can also share the task for
reworking.

Thanks!
Nicolin

