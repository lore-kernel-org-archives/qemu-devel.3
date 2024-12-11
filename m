Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61118E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 17:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLQOb-0004Mo-2H; Wed, 11 Dec 2024 12:21:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tLQON-0004Kq-H7; Wed, 11 Dec 2024 12:20:55 -0500
Received: from mail-dm6nam10on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2413::61e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tLQOK-0000gv-Pt; Wed, 11 Dec 2024 12:20:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8pDjVWE9uG/tSPlcchFUKirvyk17AVchGm/mOYB2g+GXyNxLrD/4lIk6FjaZs5NMm9suigrhazv9tDOifEvr/i7WTwqHA49AQ3DZlliYsd3LQGxR+2ezgT5RQuchnTs7REZ2jpOat3lNQ82u06uIbcU/kDGaDrT1wZWyraB52ZJeJwUQNF/BptR1QWla6sJUpyLOLyuMtnL3WYVLZCAvC0//heKOtO0DHoCH24OlFWHsfCvya6beQ5smSKYUY7e23npBBr9VQ8lb9KJik83avj0tOvFlTbXEcTDpH6qK6nCBcigRIzHdfn6+r1amBxmpRtYTR/mHgFTDdKHWixdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afjQvGZZheHaxe1msmJk+Feq3i+OUgTEfDw0zRxJOWE=;
 b=dSUl1Q30A4NTTlN3emALd5xXmK9l6c9P/guHupUcyDbHwoEBOZ679Vt4jHjkNxRO/P/Cm0aVrSuWB4WNgDeo+4agWKa7DQLd4aFO6z2TJB8c30yA0SRslcBNVdIFtsPpCClDINl5Xt7PJENBweFIq2ZnFvDuTo58nFnnagtKjPHrP+8KuJpYYogfqq8NWonc/s7hCUp4USu9+BOI8BwpmWZWwL4qhafLRZug7WKdxjCfil32lUivZ/LURAhh6kGGoiELufqMJC4OIWXgTYZQgxQEuH++Ncqs72IFMI2aTx3bMEUg6rJOG5T9oa+MbY3WMyfcskKxNiaCU8yEJLLMgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afjQvGZZheHaxe1msmJk+Feq3i+OUgTEfDw0zRxJOWE=;
 b=ReuX418rIAtaxrZ3kbbKvH7CEzULPKzoOfJ8D8RoOvkPeqtM64hXQK+H64tVpn87p/mhHTXCLVefGKcvK2CdOHp8DnvjF8P5iKd44lRaBl2jia8sPs7z4QByzV2/agkjI3AEadQqT1jOLoC1wxlLv5HbPyz1hOWkhgds8GHybwqDN+/tk6vXYi+yCPVGBCELwi/cVlsAnvbjCOvBCE9t/2OCq7H71Z6W7tl+YgY54yMaTRTbCrl2q3krWMexEBoQ8fbrYBYOHbgKDmJu6mWx3WdqDpuxz8GuPgVzYq7odE22nxrpPhkJkmm/79rEwBJ2d0He/x1QjnoIGDD1ut7joA==
Received: from BYAPR07CA0004.namprd07.prod.outlook.com (2603:10b6:a02:bc::17)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 17:20:46 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a02:bc:cafe::fb) by BYAPR07CA0004.outlook.office365.com
 (2603:10b6:a02:bc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.18 via Frontend Transport; Wed,
 11 Dec 2024 17:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 17:20:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 09:20:23 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 09:20:23 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Dec 2024 09:20:22 -0800
Date: Wed, 11 Dec 2024 09:20:20 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <eric.auger@redhat.com>, <ddutile@redhat.com>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 5/5] hw/arm/virt-acpi-build: Add IORT RMR regions to
 handle MSI nested binding
Message-ID: <Z1nJ1HYxnCdsEKng@Asurada-Nvidia>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-6-shameerali.kolothum.thodi@huawei.com>
 <Z1jIXHmFcBFIUeKn@Asurada-Nvidia>
 <20241211004821.GM2347147@nvidia.com>
 <Z1jqsVTiMwW/Zk5z@Asurada-Nvidia>
 <20241211131112.GN2347147@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241211131112.GN2347147@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: d7abd1ec-1eec-42ae-1e1e-08dd1a08263c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RnI8t12RoYSHXVx7IvCADVLUJ83XnBMNkMrO34F9gyDi91VIKURKws2zhZQA?=
 =?us-ascii?Q?athbeFgPuTG1/47NH39J4vgppJlVFEM0CpFFkqj+CU/KgZnFqOgx8lAXwN3S?=
 =?us-ascii?Q?TO0ToQyfQQVW71SaOSz/rcFdD00gEZnddmiRefYyiS/dYAXhhRwM6ME/yxgU?=
 =?us-ascii?Q?mDen781aoa/Q1Ylg4OUNk8x4tD4tNdhShV5mt7wm2KfX/UtDJ81vwYSINfI7?=
 =?us-ascii?Q?TACox4TBLdSC+DqjurGJ0+91WZnJ3lw2nvFS9x8JQF6e2RLtfzrcPXwevkUp?=
 =?us-ascii?Q?lolp1zfS8vd4CLv9lW2gxeAczNjFoejoneIUxKk4LXPATUSiybVcJmoA2poQ?=
 =?us-ascii?Q?/t3SvADC5Hixc5aNZLkfAOTwIGjZ1ywWt05KUbFpvFKL15aQ8N80Jvd15/D2?=
 =?us-ascii?Q?8srkCC5cZENEIgvlbzT8MIITl6I4wjvYgx8kyE6mbEpUnz0IJDX1Ifi0zJKZ?=
 =?us-ascii?Q?ff9Rk3bqpV4DFFvrTlVVPdvve1JqslE/nylDa4z1sDYu5SAG4cBA+mlWany/?=
 =?us-ascii?Q?aZMl1D9CInPl+PTqqPzrAL5KSDo/UaCAo6Y8zZIrTHTfqRISGC4CbtYGcTX5?=
 =?us-ascii?Q?KAobP33/7B/jc6cdYOA0LWZWW6FNHGTQbSGThbcHMIkIQe/Do6woXJFpV7pC?=
 =?us-ascii?Q?KZwRGGpB+voOqIcTzJX/2/hWcD+mzrJnngjZ7w0U8LvzpTVAIVOvkYer/vt2?=
 =?us-ascii?Q?MnNUDH6anRQ945SV1DmamXePXvop2gAVBIa0ZcPn5wCSIG6sJ4PR4eqQrC1G?=
 =?us-ascii?Q?k9k1F6YsuVkyTFVSFMXz87PPtGmzijKc9rjSOHciIOuTMIPe+AHkVezKC4W2?=
 =?us-ascii?Q?kDXoLYZDtztZxSrtrng6mjS/L72fITBAm8irG7/PSBlVFFZ7VxUYsX8iXHRy?=
 =?us-ascii?Q?VXY0pMdptpi7lkVZ3QoD9cIQmBHTlAZ4DCeK/x/Grec57MkIOqfDw6IFgi3x?=
 =?us-ascii?Q?K+QY3+ETHicaINUSyMuySPxwN82RxyHRWai50uzahIoj6ISdgKdzThGOc5A3?=
 =?us-ascii?Q?jHZhWvetaVG0qh3OH8GnV+4Dh6osWsVaqR4n4wGQeJluPDTmwTdKKtiNpJPL?=
 =?us-ascii?Q?1MuJdRHF6AXLOtGp1MPFhPOl2t9MnY4LG0Q+xsQcXSNbEolZvR3KN2Wt/GNj?=
 =?us-ascii?Q?mBO8uYhT1VNW2EtiuVCLe9wTcnjNJK+PJOAm1koB67zLp2gAjq9FCBUJRpiP?=
 =?us-ascii?Q?QtBEE0+cqofnAbzfWd5KjGYl6tfjk5/mVlx3KKZf1FAcKQYplyHD/AqpxwzO?=
 =?us-ascii?Q?0qLcbzdElOdoNdw50X/+v67xhKILPeR1u2GEqHJQ465cBSSCqOB4AbFofcGV?=
 =?us-ascii?Q?NNwmiClm/eWobLdN0dLOpTpAdg6pkBQSQ+UTHeOF9TpqGRJJxXBwqvBQC9Iv?=
 =?us-ascii?Q?5ll1mKC1Wh5BEfDxaE6nrO0uHAcFQQcm5u90qifdFH+jI88xkMYo44AJ4dDH?=
 =?us-ascii?Q?xny/K9yV+HhbmsV0/T4gWKcPjoJQkb8V?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 17:20:45.8450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7abd1ec-1eec-42ae-1e1e-08dd1a08263c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
Received-SPF: softfail client-ip=2a01:111:f403:2413::61e;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

On Wed, Dec 11, 2024 at 09:11:12AM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 10, 2024 at 05:28:17PM -0800, Nicolin Chen wrote:
> > > I would ideally turn it around and provide that range information to
> > > the kernel and totally ignore the SW_MSI reserved region once
> > > userspace provides it.
> > 
> > Hmm.. that sounds like a uAPI for vITS range..but yes..
> 
> It controls the window that the kernel uses to dynamically map the ITS
> pages.

Can we use SET_OPTION for vITS mapping (non-RMR solution) too? 

> > So, VMM can GET_OPTION(SW_MSI) for msi_base to extract the
> > info from kernel. Likely need a second call for its length?
> > Since IOMMU_OPTION only supports one val64 input or output.
> 
> No, just forget about the kernel's SW_MSI region. The VMM uses this
> API and overrides it and iommufd completely ignores SW_MSI.
> 
> There is nothing special about the range hard coded into the smmu
> driver.

OK. We will have SET_OPTION(IOMMU_OPTION_SW_MSI_START) and
SET_OPTION(IOMMU_OPTION_SW_MSI_LAST).

I think we will need some validation to the range too, although
iommufd doesn't have the information about the underlying ITS
driver: what if user space sets range to a page size, while the
ITS driver requires multiple pages?

Thanks
Nicolin

