Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B175C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFrj-00034X-1m; Mon, 17 Mar 2025 15:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tuFrX-00032n-NH; Mon, 17 Mar 2025 15:10:59 -0400
Received: from mail-dm6nam10on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2413::62f]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tuFrO-00054t-24; Mon, 17 Mar 2025 15:10:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHOWiuTqlklwvrJ89TClgafA3HyEcrcY5+NnhZL1Il1AK7xUhHW5Semw/IRU4n97OITSkmgxdwpO9HGY0G7Nf2d1VyL1zT+pacSJzf6aK3hHYW5XUx5fS7JsE165fKlzwklldtXTLmGo8bcIBZ6AQogd0lzZKP9BhvfmBxfHPjzDCNfr4bJ7RqIwYWIYjWv3pnzPWSXgjk4wMlYW/P/UpuCIu0jOaYtrVDRJLol9u4q/DYFebBNitbydNgDbgdJUD1pe8uZMcQ7t/hy13EyW5bMOvfu52CnSg2vM4r05r4I4hoZOzLMRjv1nkZWj8UFWBaSpvfuScj3+qO6JYSjUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+s09oahbDFI+0W7DkCIh/WbDnrBKNl3Rb5tnY6p+Cs=;
 b=qJUzLvAvMVE9kHITPvVNhMERVZTqKBX2zueDjc30E0dBjF4X0OkaR3IGIdJuRBuqTFYl4OArMbmbh7gVFouVtnH9OQaJO6VeCeI3lkl3u8Xq28J8wE5gZvsi3e3lTSGuPOgYwrljJIiVxe+VmwQQH7ddbWuO9pVJTxwpTnv/8DOZMTfvwPT326Uy5ypufZblZUbGQJjG0edlQztYYEE9lUVdAB0oPuB6whQ39juKhzHclNsLYZILE8q7Gk19e4D61FsYPUL8LSv8Z4SnWoaUf5p4UcCpri9aRgEhcX0Ml/aMo2B4XM6W78UOoihHyLsEhPfdDhT1pXbsapjHRMln7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+s09oahbDFI+0W7DkCIh/WbDnrBKNl3Rb5tnY6p+Cs=;
 b=GJLz8ateW0W/ZQJj17wFrbR0IrMe8d1KkeCUdSvPrHH+XBsbAfzuzXSbBMMZwfVQCPY8tQ2U8uGL+tFv781xd8MbOrhcCUC19+eQVT5tYVIvu3tnxg25I3k1KH4v5DdrQbJe+i3dMjMcH0RaHc8/4HitqLfYJ0oGcOiSBoWNe1+CvIJtOAlfP9x/Q7wZZYO47FrByG6nBSZp3cDXVWk5e7/RsIGuS4ucHwGSu7lvx6w9caGuKUquIuUllCrs+nV3bS038NC0BBT34IUG0epRryYI7LsaqfG/262BY6V0CPO4C9jMNuczVzxpmHSoXVxtosL/z1Tpq8+H/SLNoQ98Wg==
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 19:10:37 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::a4) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Mon,
 17 Mar 2025 19:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 19:10:37 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Mar
 2025 12:10:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 12:10:22 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 17 Mar 2025 12:10:21 -0700
Date: Mon, 17 Mar 2025 12:10:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <jgg@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Message-ID: <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: ca36d80e-457c-4762-9690-08dd658766a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sYDHmLYVNoawDXUkmITqIihThui/HbadDJGZgu64TpwKMIoRQC5gGB2p0Yh4?=
 =?us-ascii?Q?/HtnzQxiFWRwC16KFzD3+1wRmyX9x81ETGjAt+Cslb0wwYy61yRQLz4qR9Ej?=
 =?us-ascii?Q?P7JtmcFcYWthIhPBO2We3OpMgGkn8ni5imKwvaZtsdWwKdZZliATrYwUxhn9?=
 =?us-ascii?Q?6TncEv03DZze+2gZT6qW0krYUyL7UexLyAVktjvqZktWET0pa+NeibJ7Ib+w?=
 =?us-ascii?Q?61Vv57jaZNRumXdkdOrOOULv/fsoex3uVSnEr3CuJPuEaS0z35WzO8sfmMwC?=
 =?us-ascii?Q?E2CxscLAKyj6b3XUzr67rEBwAZ42IBRc7RLKEn6mCtCHy8peVn/f3ulKPSNQ?=
 =?us-ascii?Q?3Jsw4p7rwVkEcwYSuxOcHP2QcG7M5J0HOZQ0UxOnzB2LvZipEb86OB9vCA/v?=
 =?us-ascii?Q?V63eLtggbX9vv/l08xH86hg+ycpR/iyDQEGD/F6mc5edunRZfgk/BFl2T+pC?=
 =?us-ascii?Q?WKFIyyqBlNYS1MJdqGcDxIdqr3hWy0scfgEbOevw+87RU6GGx/Qqk++92Hwi?=
 =?us-ascii?Q?FhMWS9bv/lwSekfiHBQ6DN0R0WX5a766E8wTjY72hPIcQHsAuF0YWedwzoRq?=
 =?us-ascii?Q?nmviA6gUbVY/sW2pHIOMGIIAPxYysF+MmQyd5IAiYI0OZhpG/bwh3nSGSd4o?=
 =?us-ascii?Q?tygPkc9F7QRB4b88x5B7ZFBQP0LtFEnALxCC+XOk8eU2nd/FGgPPUmZK2+Cb?=
 =?us-ascii?Q?xslZUwwrWoX4xulRj4u5j/opQwRiKvMPV55zPTlFu1XWDYXwk/YWez/I1F/v?=
 =?us-ascii?Q?s0VTUGf7cxgYP25TW0f8PNc0fnnIHCdWi3xrHVMLb3w/TUd5DpqdETbluyQa?=
 =?us-ascii?Q?ZOzBLMygruuo4CpkQo1lTPVAqIogKjuAFrdxI/cZCYhNeiHl++uxhLpBSoI+?=
 =?us-ascii?Q?EU9OIQRQiEraTvia06b4sab4kO443RFRfjQW23d1F+F0qCacEp5QuvJegsnl?=
 =?us-ascii?Q?HFUrsrXa1195BhRaKV8eYnDz5mVLfIvAa8bexynJpMTEBodxnaZybg4FOZW0?=
 =?us-ascii?Q?0e8vzFG1S7U0tRoRThOcS64LB/pNhx3osCUXSSKD/PHxQNK0JhyTfalOIp6U?=
 =?us-ascii?Q?ufqT12HxAhnOCRv8Y3JtJDJICSBoqC5O7WlJccRJvF6Hggen7Uq3Kcin3vod?=
 =?us-ascii?Q?L9RMl0d20l6gb2fL9Jt/WMgKxwjRxUfDKwP6V29tWXrMQ/0wLe7/Gm1P0kzk?=
 =?us-ascii?Q?9UFNXHDKgPAYhR4ghqEiXC74doqRFpP1o58dEKTL80l+9464fx4qvc2xHrj4?=
 =?us-ascii?Q?j8ZY+XqSOoIOlDlgDndDVAqjSxyeRAjnpov32juomDTHtbVZyyH7YWV48j2b?=
 =?us-ascii?Q?y1I4iVGrw89HWv+RzsB6zrr4uLSsr7qSfWF3hoiDXCgHRu+w5xvidHK9UrRe?=
 =?us-ascii?Q?NAufnYTC3TzM8nBpNZY7D3tWvxJmm2qeWHWnNVk/Sbq7KP1nvph6FRUxsQF/?=
 =?us-ascii?Q?TqMcUPieWfukNd8lIorIreIa/CtbE+qmZooKPuhSPZVWZFCPWyk/h2gn05/+?=
 =?us-ascii?Q?6UjRKJQnWrQDAC4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 19:10:37.3218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca36d80e-457c-4762-9690-08dd658766a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
Received-SPF: permerror client-ip=2a01:111:f403:2413::62f;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

On Mon, Mar 17, 2025 at 07:07:52PM +0100, Eric Auger wrote:
> On 3/17/25 6:54 PM, Nicolin Chen wrote:
> > On Wed, Mar 12, 2025 at 04:15:10PM +0100, Eric Auger wrote:
> >> On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> >>> Based on SMMUv3 as a parent device, add a user-creatable smmuv3-accel
> >>> device. In order to support vfio-pci dev assignment with a Guest
> >> guest
> >>> SMMUv3, the physical SMMUv3 has to be configured in nested(S1+s2)
> >> nested (s1+s2)
> >>> mode, with Guest owning the S1 page tables. Subsequent patches will
> >> the guest
> >>> add support for smmuv3-accel to provide this.
> >> Can't this -accel smmu also works with emulated devices? Do we want an
> >> exclusive usage?
> > Is there any benefit from emulated devices working in the HW-
> > accelerated nested translation mode?
> 
> Not really but do we have any justification for using different device
> name in accel mode? I am not even sure that accel option is really
> needed. Ideally the qemu device should be able to detect it is
> protecting a VFIO device, in which case it shall check whether nested is
> supported by host SMMU and then automatically turn accel mode?
> 
> I gave the example of the vfio device which has different class
> implementration depending on the iommufd option being set or not.

Do you mean that we should just create a regular smmuv3 device and
let a VFIO device to turn on this smmuv3's accel mode depending on
its LEGACY/IOMMUFD class?

Another question: how does an emulated device work with a vSMMUv3?
I could imagine that all the accel steps would be bypassed since
!sdev->idev. Yet, the emulated iotlb should cache its translation
so we will need to flush the iotlb, which will increase complexity
as the TLBI command dispatching function will need to be aware what
ASID is for emulated device and what is for vfio device..

Thanks
Nicolin

