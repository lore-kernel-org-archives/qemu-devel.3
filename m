Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38937C83F10
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 00:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZeor-0002rY-K9; Wed, 09 Jul 2025 20:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZeog-0002pX-Jy; Wed, 09 Jul 2025 20:07:12 -0400
Received: from mail-dm6nam10on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2413::611]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZeoc-00086U-64; Wed, 09 Jul 2025 20:07:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2fznlJQH6kUzx6MVbHcQvrfwnz+33ZSnGEoHXe2xqGOaTjITIVAGwmY37aKqKdouCfsEF4zNC8IAE1//xtfjiZ3esx+Gh9xR8eZuJ6RcCU3jn2UX03GPaFupneD19wrY9qv5PlQDObehTm7D5KKJfp0+bPgkwhojQswX4rZo8fHVW+jBeC5bPPxX8+XihCbUobv5IS5zSxjAWiIxEagAZnWCJyhUTHVTYIm1k030s/7Ng98B5GdKzzkVs35vjuIDjuftR/22jrJFRK/K+IHR+3pNJLs9AgK9oR7fRyEVYoEpJSGncpgDqgPnNoUr/sFZFn+nD3HYkfNbI5wTnr5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71MUrkRa1+PjOBQboKLr6WMidIya6KcPHnJPigof4AE=;
 b=NcuFSoGNMOhWja/wh3r3W+5XF1F1JQlOdcdQ1vWFyyw/NS+6Ep+Lf+ROw3+CTuCriBqe+zJB8WCx4Tf2kXytFmz2/uOgACnqcCaaaOCxY9e5iQH3FLeeg7HwXRhuZoePgYEHqSzNFNjZfMdWDXMWnfbR0C+6jQKkE0RiCchzVTECEdusOkNIq5QnPAwkyJuoE8NMZ9ezvcLPsMX78/npMG16PxznU6W9lNRr2tgCHQ4u3ZXKDEbP15kWxyet41zTiKGlOBHdFFwmuer5Z151OJHMXdSWUPMkEEYB/OQ2rqaEiTzaAg1i0zWM8G1/xtdg3Hc5I2JfNf35sKWjKU9Byg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71MUrkRa1+PjOBQboKLr6WMidIya6KcPHnJPigof4AE=;
 b=DGarIvmHM/1wRCoHTGqXLtfjiapw1qCglFAG05to4AIcK4JFjN4hbWkRFNpeKf9l5taCZpqVKPLXSwErM6+n/Bgu6vF8qOvFlEScmC5vmzXbgbfftqn05iykzHrLGz7Hhjpb8I6U093IE6JQ6ZLhfai1eVsByJOZYO9lrwnoPmdAKYE8ImYDtj+aQWeHdF1N2QuxFMa0pnhWQUWT9Y7Vs7GfL4z4oc2S6xQ+XyvFbTQtkGEltensuZSrUMeYSM0gp89en++kJO1wl3deB3dsmEILMEUbAje0vpvt7hMmEWfFqQLW18owASPAdIznbvKfTXqRnTaBmIky1/DkZsmwmA==
Received: from BN7PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:20::45)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 00:06:58 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:20:cafe::66) by BN7PR02CA0032.outlook.office365.com
 (2603:10b6:408:20::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 00:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.1 via Frontend Transport; Thu, 10 Jul 2025 00:06:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 17:06:37 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 17:06:36 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 17:06:35 -0700
Date: Wed, 9 Jul 2025 17:06:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v7 07/12] hw/pci: Introduce pci_setup_iommu_per_bus() for
 per-bus IOMMU ops retrieval
Message-ID: <aG8ECVeOYXPzBEVB@Asurada-Nvidia>
References: <20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com>
 <20250708154055.101012-8-shameerali.kolothum.thodi@huawei.com>
 <aG2M/BI3UAYxKCD3@Asurada-Nvidia>
 <741503f8f96148b389b875e6b6812c1a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <741503f8f96148b389b875e6b6812c1a@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 300ea904-8564-4a57-8ac2-08ddbf45af91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yke/QoYDfY/QQ+lF0BIFcINXhQzwB8Tt5cEF+6Y9l/6si+dG0wIDY9MxhGQn?=
 =?us-ascii?Q?rZkGHsFAbW+bYrJyN5d0Ny1wzTgDrj+bO6t/TbzB8I1AlNaARMzzjms70PDM?=
 =?us-ascii?Q?NRsOJDxgMZrffZvMKFHDiyt9pLbmQXVJBpiF5bjsSpvdBUvBoGhlzsdOZ3L5?=
 =?us-ascii?Q?15p2pdZg9EshXTw94RY1WKwkgaACCnURHtRKdW2MemQXKoOCOBzdbD9bRlKa?=
 =?us-ascii?Q?8QKdGU1J3BVxij5wL1l4sKfk5xuXqzIgYyzra5IYhbNxlyaCBs1hMItKfPI5?=
 =?us-ascii?Q?wfL7Q83z5dphbDtbkRi5LS+s0w6/gvRkj7lX0q/bnZdi2Fp8bAaRWMH1tlqF?=
 =?us-ascii?Q?8MhLjUHzodRg5z5t4V1bgSHJ+ecAXI0yaAWZyqJ9ZOvPJAjp32aSUXZDyRHk?=
 =?us-ascii?Q?MDE7GuZuczbLt2FKynapC/j4iRxPUbHkaKms0jTkmhraT7rRBzpep48Hjt6o?=
 =?us-ascii?Q?7BJ800sNIjyn8FOfKcjC2GIumUZa3LbVnF2AZoVbJuO+Ty2gIDJb4mdzuYqq?=
 =?us-ascii?Q?3oV5gOjzDCXbY9aRy6xRKGu6L2ys5Adb43nzSW0hZ+d1tGUVs0/7nC6YrHaP?=
 =?us-ascii?Q?8FM2KkMuBKGZbTzIaP09vhJ+CJwKL1306DBBBnxGfpoi4vcGB4zmom+s/F+M?=
 =?us-ascii?Q?haeWAVom2dbvT6EWiYLXOuHIWYzVISdIMtv7DucMOszQqIgOUX8l6kx3ciXX?=
 =?us-ascii?Q?EJTnVE/06jKKmfgSvVFX3T+f92UN3Vc+B/UBhsnI6FdLY9olzbtYPngEMWkJ?=
 =?us-ascii?Q?g7uNzPFWuQJ70WtzvmKUxXS79H+J0UZL2afLHzG9oOZ3SLmGuUvoEcz9abS3?=
 =?us-ascii?Q?N2KMEyGIk9AcbXPEHX6zqb6AucBA/YK4FCFcfb50rg+fFGANJCkTwwNup27i?=
 =?us-ascii?Q?GAPlpGpxXOIS6RYQcPyyMA/LwS0WWBSEtNdVDiS6AX5U/8I9WanA2DMHC1Aa?=
 =?us-ascii?Q?AvjxVjDf+AiMWe0kosL1s9O466SaKa35k711DuVnWKxMPTGFTmmIuGn2DkR9?=
 =?us-ascii?Q?+V4SwBxOeFDdkCMAlJSzvUdBjUTm0juJewRVUR8Q34/Tw4pRhCGuRDcrbvwo?=
 =?us-ascii?Q?3byfE2C9j/yI4an9jwGYTs/gVYiV7oxj7qEIoUJYL4iJRCgaHHFQpFbb6goK?=
 =?us-ascii?Q?WuqPQZ3A8Id8TwgmUVMBjPsVZKq26rviXInAwrMrH47/VLjN1Cf6lFSUMl5L?=
 =?us-ascii?Q?8NnOO0MsG2KfJ4jDgkGBszqFZOvVbNDWSNsVxrlylk9mGmEQOfS6MpPKjFKv?=
 =?us-ascii?Q?fjgsWAxSYXDYxwatcQ9Gv7x4XPa6ZpmoNP8CJWdopSTxpegrF/a9XxzIYeCJ?=
 =?us-ascii?Q?2a4f68fpOfFtebtih4iQk4chyvKuLqBaK2tYr7vxej+tpmBWdGNXBClez9Mg?=
 =?us-ascii?Q?zTgxxfclcd58MKKcqTyevqvMBODXIo3GWl8vivhXv561dNdUP8PS5wFapkjR?=
 =?us-ascii?Q?UzOXS6nwiIYl5YuP+UqkFGSyNBMzy4KNIvXa8m7cnJ2DO9C85N61SFA2EYKQ?=
 =?us-ascii?Q?y2liv6+/z3iUDWRUJybXs1CSDk/Co/hss3c8AzYLkBzuSdHn1JS/cBnWTA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
Content-Transfer-Encoding: 7bit
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:06:57.3360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300ea904-8564-4a57-8ac2-08ddbf45af91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209
Received-SPF: permerror client-ip=2a01:111:f403:2413::611;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

On Wed, Jul 09, 2025 at 08:20:35AM +0000, Shameerali Kolothum Thodi wrote:
> > On Tue, Jul 08, 2025 at 04:40:50PM +0100, Shameer Kolothum wrote:
> > > @@ -2909,6 +2909,19 @@ static void
> > pci_device_get_iommu_bus_devfn(PCIDevice *dev,
> > >              }
> > >          }
> > >
> > > +        /*
> > > +         * When multiple PCI Express Root Buses are defined using pxb-
> > pcie,
> > > +         * the IOMMU configuration may be specific to each root bus.
> > However,
> > > +         * pxb-pcie acts as a special root complex whose parent is
> > effectively
> > > +         * the default root complex(pcie.0). Ensure that we retrieve the
> > > +         * correct IOMMU ops(if any) in such cases.
> > > +         */
> > > +        if (pci_bus_is_express(iommu_bus) &&
> > pci_bus_is_root(iommu_bus)) {
> > > +            if (!iommu_bus->iommu_per_bus && parent_bus-
> > >iommu_per_bus) {
> > > +                break;
> > 
> > Mind elaborating why the current bus must unset iommu_per_bus while
> > its parent sets iommu_per_bus?
> > 
> > My understanding is that for a pxb-pcie we should set iommu_per_bus
> > but for its parent (the default root complex) we should unset its
> > iommu_per_bus?
> 
> Well, for new arm-smmuv3 dev you need an associated pcie root
> complex. Either the default pcie.0 or a pxb-pcie one. And as I
> mentioned in my reply to the other thread(patch #2) and commit log here,
> the pxb-pcie is special extra root complex in Qemu which has pcie.0 has
> parent bus.
> 
> The above pci_device_get_iommu_bus_devfn() at present, iterate over the
> parent_dev if it is set and returns the parent_bus IOMMU ops even if the
> associated pxb-pcie bus doesn't have any IOMMU. This creates problem
> for a case that is described here in the cover letter here,
> https://lore.kernel.org/qemu-devel/20250708154055.101012-1-shameerali.kolothum.thodi@huawei.com/
> 
> (Please see "Major changes from v4:" section)
> 
> To address that issue, this patch introduces an new helper function to specify that
> the IOMMU ops are specific to the associated root complex(iommu_per_bus) and
> use that to return the correct IOMMU ops.
> 
> Hope with that context it is clear now.

Hmm, I was not questioning the context, I get what the patch is
supposed to do.

I was asking the logic that is unclear to me why it breaks when:
    !pxb-pcie->iommu_per_bus && pcie.0->iommu_per_bus

Or in which case pcie.0 would be set to iommu_per_bus=true?

Thanks
Nicolin

