Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5737C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 17:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRy2q-0000vl-PA; Thu, 11 Jul 2024 13:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1sRy2n-0000sE-MA; Thu, 11 Jul 2024 13:57:25 -0400
Received: from mail-bn8nam11on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2414::628]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1sRy2l-0007sz-0u; Thu, 11 Jul 2024 13:57:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iyc+k1hO4dN3T2kdIX2A/KzJHjWLzoj9LzFl0lSpzaBpGQmCvMX4qgyy2EaxzlN852u5ssxHz3t9gblHu4e4xiHILOGwvLbd9YvXBENxw12hJwHuYTqnZiiNft4XKTxaIPV3bv6WPCUjL7aDHJTOoXbsT2yo7dJNGvlSb929vbQ14xzGVSZtQgaRD7MtRqkUmWMcIEt7xNBwpNl8GlSjVMK9tC8O/Q049/cMhDD9zWYzBdS4u7kgEAARChvtuGuMn9PzDEuEm6ynofKAjcXTNmbPqW1XVuNOvO/1GVKRLvqi1agC+IIQUQdFmcPfZATCtNaZRD4I7HmJcMhl3SzSpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7rXgmFAMzMsbyrtOo42/AbsqPFQt+U9XRWxXLTEOOo=;
 b=rbojAS72QjMJB+JvWkqfGyfEtXkN/fkXv/1Ayt+Pb+SiXe6+TM33zV8v7Auf71mV/i6lVBkZQVsYlLjM3UayXa6vhGSqQqvLbukjRd+xPbtiZBJM9Pyp+7zFaJqoEOY1zQIHYVBZL3HQFUvbfUrjCD206IgIbQMoLb4VrvQi8pGmef03Q1nAmeGFkgtXmt+YE0eCosrIARBHd6/s4BhxYhraInPtjYiK4Ug9PcGZWNtWS5rg+OvL/BZx42uh28i4juGqhKSiKhX7bhdJoYGI622/6X2MM6wYdY2maw1JvV35D8RyuHI/83uxz4FRK+cQbWWYPx8/rIA7bN2ESz0hLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7rXgmFAMzMsbyrtOo42/AbsqPFQt+U9XRWxXLTEOOo=;
 b=dtQ/aRIUlhqe61+LHE1dZqiSraiOvOQFPbfXzp4fW73ZUKYzGjNJN0ezeD2rlxpJ3nBocuqInCtlGGUosQzEMd52ob1DyTebArEBrIn4Cuyb1IHlQRp6ZRjBZwwAqTZJt5IahDTyYDYEG7uGiFqlwow3dd4m7o4HYCh+3SS5PKfnzP5NZE3hAe3gELGDPfKJqOFBfJti52umy4VxtXnpCxV1gxuu5YsqqyNaWK5sgFye4rLXAQGK0q6567ZYer06O14k3CW2XAccakqs6TGDAinPlR4avxTyskiWqeU5c6eBj/k/98sW6ocO7PsuTEfqsFsSSru5VUp57faMg5Lhsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 17:57:12 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 17:57:06 +0000
Date: Thu, 11 Jul 2024 14:57:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peterx@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 shameerali.kolothum.thodi@huawei.com, jasowang@redhat.com
Subject: Re: [PATCH RFCv1 05/10] hw/arm/virt: Add VIRT_NESTED_SMMU
Message-ID: <20240711175704.GI1482543@nvidia.com>
References: <cover.1719361174.git.nicolinc@nvidia.com>
 <bc7a57311ac4976699789ceca329edfdfe823c2d.1719361174.git.nicolinc@nvidia.com>
 <9c3e95c2-1035-4a55-89a3-97165ef32f18@redhat.com>
 <Zo16gnKKxXFg4LLE@Asurada-Nvidia>
 <CABJz62PVt9h9776DjXkPYq_Mf+AUJ-0YhnDi-OsaqCqrsrGSQQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABJz62PVt9h9776DjXkPYq_Mf+AUJ-0YhnDi-OsaqCqrsrGSQQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR01CA0048.prod.exchangelabs.com (2603:10b6:208:23f::17)
 To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 85bca739-5895-465b-e8ee-08dca1d2e059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1to+jUmPSnD22yg25tmd9PqePFBzCVobTAsbXuYNopXCykv7Ka1dvrJOuBUh?=
 =?us-ascii?Q?pfMKnS1GbalqL85cOEsm8vV4vcDfPNUm9oyxo5jOOklgoHGZ1UcP6kOUeFMp?=
 =?us-ascii?Q?eZZ+sfZhbOyjV9C8uAWWcC8UdUSDI3Wn4WlW6VLYBXKdBQSefls141wmLa8Q?=
 =?us-ascii?Q?bPIIfUS3br6cx/zthzKX7XIzb5xUARV4NOxnio8wOPCG+zaq/+L0TNz4xqOb?=
 =?us-ascii?Q?eJn4tbVXJyevHQdmXICDMQ3u0F0VHhiRSfS0NglCS1S0PsLFJ/Tb6qjihCUb?=
 =?us-ascii?Q?WjdU8HJ+ZjebpNILY/kk2L+G9IFzFQNEp6QmPm8Q2CdLnkLzbkhs4arsF2MM?=
 =?us-ascii?Q?A+O61f4YQjZQKlYY9QBolDn0SF5QlaepJeu4l91JQw9ojQlgsZau26FP7Acv?=
 =?us-ascii?Q?km0yGg/XRV2MurgVuyUn07iSvPBFmH/J8cC8zNK6bKgDZNscjH+GYuVJZiws?=
 =?us-ascii?Q?bFg1WUrkwd+XzNiWsSt6fj514lPY0kWDDjQVAXY4XPEM10rg2DkNs+AHhaf3?=
 =?us-ascii?Q?pQvdS5WJAWAZD2z1PE3ZcDVcZA4ajM6FayanWk5eBHUVWClxrxH4N4uiUpv5?=
 =?us-ascii?Q?rY4g+ZP3BdHzHvDxAgvV3xlbVsR1OYUU+JGiYq6DmaxN6tEq+aQ34OHh8TnU?=
 =?us-ascii?Q?CMPmOONet4vjPIFLh4O9vU5R49IZrcPYV8OEzLpsHgw7767yZCSTE/QsD4nu?=
 =?us-ascii?Q?OJF8pW8Ikse61UBn70kR4K4dRvnW33I+fy5lK7SLRTp1PKm8SqC9MqYiIELM?=
 =?us-ascii?Q?jRKqL0Onj259OvWUwEUF1IiFRlhBA77fdgonvNbS8NFTK4vdsW836XbVHYaz?=
 =?us-ascii?Q?EihHdHMrZVJH9W9/FiYYYavhO3uL0iI1AvcNi7Z0ld7wEANME+IdjR7U4HQx?=
 =?us-ascii?Q?p8q3TtmIgzixSPESGXmF7hTlrBncRlc6i2JA6TsMAwZmtkxyXUsAy2NlrpD9?=
 =?us-ascii?Q?3ZMaX1mT/AmOCFKRiBVFZaAaTNxfEIb7x8YcY4yMZOPlvhCeig0lCmDfM9RX?=
 =?us-ascii?Q?MYmbaTQShZEOEqfqUzVYmDpxCL+DpLJMCmtuIyPFzRQA2OuJ89AcJIIyIKnL?=
 =?us-ascii?Q?JzJQN1gsZ9FfRzIc3wTOKXaSndu9ElbaIH4t6XUZwYWVkrFDr/s7h/aPV+J6?=
 =?us-ascii?Q?SXcR5LdE7HqlM16+Vko/WIRgcklM5w0gaFfeoBQes/+HvHpQZqcj9qNEXlO/?=
 =?us-ascii?Q?D2Fc5ZbRWNvWcWLr6rXQPPCSxPAcCQoIJEOXpyp80MMUgi4Pi87d4SciEV5K?=
 =?us-ascii?Q?NC7HVBHxYAU0rWp7/lcxiC9h1TA8Gf9BFF0UWDGIP4ie5KqFLcJSwA8JfDvL?=
 =?us-ascii?Q?rIzXyKiKvoDy7wYFzQO/mkXg6yYLGBTWefZVIhU3Q3MZfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vlTZgkPCFoiort2I/AWHy/JooIiXScLoy7xLPBLCO7Z3p8RdW3Zf3RMfHLrQ?=
 =?us-ascii?Q?tBkAOeoUc9+Yzqw3fCA1pw5j/7DCkOk763NbsPv3KdZoiPhxLq4CAOzGnkVd?=
 =?us-ascii?Q?VIf7eQluCQALR5DSAdQjSkkB+8KxIftvLXIpfsTlf683NUFqF89j+dmUMJJ8?=
 =?us-ascii?Q?kG8dD3SZCc4iMcHmKi95tJA6GDVIhWNNjAxZLWr6tCWdLclX3R0muxh0YyrA?=
 =?us-ascii?Q?wNnoTRliovvAULGTIsphk3UIcBsPDGCGj6AndexkdQdW9Ef1gUCVUt+tmfcu?=
 =?us-ascii?Q?H4z+rkfr6FDKOn/z3DM9uQxGmjB1DsbLwZHpxV53y73khhwglfwwmJVTv7/8?=
 =?us-ascii?Q?ElnoN8Q0Dc7UOeZFHpO8Qo48zZXFedMJ5VuQgFotDikqnMfsLenHZn02lQLZ?=
 =?us-ascii?Q?vkZuOQZW64YKpFDTS2VIoVSgldGMNVO5BSVRpxCQvhtgjhQwFrlcttoUg8UW?=
 =?us-ascii?Q?b1KLcA7izW7DedwXuRifY7vv5hQgG2kiR7v186ya5xBYv0/sKLi3Fddrj+jd?=
 =?us-ascii?Q?PCIT5gDx04OJObZIFEM2W/p6G6ULdrQS67LOe1aJBhquUo+kUxWZkFFbixoB?=
 =?us-ascii?Q?kfXSgTy9W0ewzGZ1HwRqHHfdfxCLVLUIrPJX3ZXmLAzcbggy18Qdf0viEtVZ?=
 =?us-ascii?Q?ad6LnbfgH9O6SDlVH5O3eM6zZRQjlSjIiN3y1J0HrtS8uCRLhpB6xZT1MS1v?=
 =?us-ascii?Q?7jlTdZF4KdkMlnMv212kP22e2DTNb4zwx5VNuDV31jfINVvZhjwYaxJpFJBB?=
 =?us-ascii?Q?kY1GS3TAzg03vsbeivhDW4LmmO4D5laSHLoIl7sbizB5VXPjWnft06GrpIPF?=
 =?us-ascii?Q?aX5JzVKbsZBhKqxfUBL09Y0JSmDRGZ7zGss76TxKxcm8zrhZR9h3udsdQNfB?=
 =?us-ascii?Q?zmosPtMxNwxEl31TEF4PoTpFbHKGUw2p30oI0m/uLJpIFgJkoOh7e8TcODsC?=
 =?us-ascii?Q?JmktS72kA0g6UC2saZou+Z5352gRmSnKwfFdlDg2DdL+G6fWobA5wF4l6VnS?=
 =?us-ascii?Q?pXQn5q1we064pTedOYqACjkAogkuDPTP0rpIzM4hHQrH9Nca7rAQHukp33wC?=
 =?us-ascii?Q?Y8LI/5Rhtjt/W87Q1plddGyU+qqpOFWGK38SDldjvz38nL/IxMrpkttWBYk3?=
 =?us-ascii?Q?QJnR9nXnOILArmL/FHtZcN2rKyW2kF4KQEJQ1Ke0tmaz3SDk4GExgUlsJvG0?=
 =?us-ascii?Q?+wbhDF8Jqd+246O/cgEM5lkJ5zVIWAdLics5X4tdbU5VwBqsS/YUgDGE03K7?=
 =?us-ascii?Q?2i+ygW4ZdBaHy1d6k49gI6Q8zfD2rNInRGZQJO9JKFScaSkz935fP+9F6Z7d?=
 =?us-ascii?Q?lbb6/eR/2DMDIs5RN/WENsbS0IfaUBUCGmnk2j0/jXEohh3xcTpcBArhn6jY?=
 =?us-ascii?Q?XgETqFpyjQasLONE5RSEdUfPJzyX03SLQpPL7woZ7qgfWiOzSUMsGF5zbZPq?=
 =?us-ascii?Q?b2qYkoRNta1MaHuojTM4jLbyHYNSWO4Bfg1jOJk2A72q1yUfl+iakfuzIuiA?=
 =?us-ascii?Q?vQJ5Sm17UqoPX8kmsWCUbcgzpGW7QPywmewiGz8ATVwfC+Hgd0HNbTUnmWjB?=
 =?us-ascii?Q?MM2l+urWZsGYi7PZWkx8EQyh4zURt2Xv5m0ciajf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bca739-5895-465b-e8ee-08dca1d2e059
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 17:57:06.0015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhwi8gfTQikf3F7T7F5FIBwforx/BDm4YbJJoJgz45WkFJd2aekCoqFOvIlWClbO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
Received-SPF: softfail client-ip=2a01:111:f403:2414::628;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Thu, Jul 11, 2024 at 08:48:10AM -0700, Andrea Bolognani wrote:

> IIUC having devices associated to the "correct" SMMU is only a
> requirement for optimal performance, not pure functionality, right?
> In other words, getting the association wrong will make things slower
> but they will keep working.

As part of declaring the iommu as a device libvirt should also specify
the iommu capabilities and features.

There are capabilities that require perfect 1:1 pIOMMU to vIOMMU
matching, or it can't work.

For instance if the pIOMMU has a direct path for invalidations then
the pIOMMU, pPCI, vIOMMU, and vPCI all must be perfectly matched
because the vIOMMU will deliver invalidations directly to a single
pIOMMU with no possibility to steer them to the correct place in
hypervisor SW.

> Is a 1:1 match between pSMMU and vSMMU mandatory? On a system with 4
> SMMUs, could I create a VMs with
> 
>   vSMMU0 <-> pSMMU0
>   vSMMU1 <-> pSMMU1
> 
> and another one with
> 
>   vSMMU0 <-> pSMMU2
>   vSMMU1 <-> pSMMU3

This is fine
 
> assuming of course that devices are assigned to the correct VM?

But devices on pSMMU0 cannot be assigned to the second VM in above
situations.

> How is the association between vSMMU and pSMMU created anyway? Is
> that something that the user can control, or is it done automatically
> somehow?

From a kernel side VIOMMU will be created in IOMMUFD and it will get
as input a reference to a VFIO device. The VIOMMU will be linked to
that VFIO device's pIOMMU.

Also creating a dummy vIOMMU without any devices and thus no way to
reach the pIOMMU is definately "tricky", I'm not sure exactly what is
possible there.

Jason

