Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45FBC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 17:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuEgW-0000Yh-Ur; Mon, 17 Mar 2025 13:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tuEgM-0000Wb-AG; Mon, 17 Mar 2025 13:55:26 -0400
Received: from mail-bn7nam10on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2009::624]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tuEgK-0007u7-1c; Mon, 17 Mar 2025 13:55:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pA7J/0Trm6bV8ZeA8Xs6TVuC8nXMitkW18TVLng6WEPykKAf6swewAmTfX8jmrpHvcel0QkSDYAczfAPW0JkJume5RYB6DpCAaZ7CC+3cDLr8fuF0Szbx7XSzQYxkoLY2p6Vpbp6+umBmK4Bq7boXfkz/0hcdyk/uTrtNTMiyPUPTyqazfFJgH5Lu7TjiXRP61hhX5KH8uO1WpMUOwAsOLtfw7W8fYL7IoTMvhFe45L2GIG0XG62mlV/M4AQeej4txf/JVK/+B2KQoAQVB5hMXdg6Ov3O8EFjTSExx5Z9EUcmE3MAsN6/BICISG1yZv9kDBx9q7fsdvKzp9d3KAWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qjJz7nIeS58hIdRg5gDqDwJX7FexKD3q9bIl5YwvLc=;
 b=y94TTKkejXhNqIFUzVhXBTlmQB+iOghhfHLhcEqbk9v08UNewcuQ8mbXkXMirTXgwXeTUIWQuqexqHce6/x9179eZHBboghuVFhS1e8kwkS+7+eBR5Vdshlr4t7oHmZh72dt1rRSHndz6/Yjmv3l+xGh7S2ACYbBL8tPbjr+Cm56+nFsBYmJLUxAHKhdIkM10Y4VvTm+3S+nDJzcmqN0aKD+dD1Sw6Y5eHqOsnbLZlD5sgtUs6weSWLb7ofdzzK0kThtA1Nx6F2B/d9HkOL4d1RhxjXmUic8/oxohatcaHVAplUNWfHK5m63MhcWdYKSCAs9KrISk2+nM0j1Ht5HYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qjJz7nIeS58hIdRg5gDqDwJX7FexKD3q9bIl5YwvLc=;
 b=ARRdAqEcCcOuR9EiKtk/NSO031TEJcGXSkif73Ae1ARSsyK7TxGHoI6G0xFevP/5RjBPKBo+Tw6Jr6LXpcq3GfIX9vGgtPcoj+JTM7QUe9G/p4O8SD4N4zuCnzJlApKdwdgiw+foGOh/swcU3+4cu2WN1DLlouire3r4dGRgam86+de1n3PcjFG1zlO8xSlyXvO2DHmRpteyd4Pwa3oqyAjsImfad0w8XSzw4LyjqMCf/hjdDTznsuh2XtM3BaRNxNofdtD+c8t6Uq4v2xhIMdLS5etF3GjuIcoEr055V7Hpublzk+dmoWVDnTKiO1GQivOL7MTimhp6KqNYLSS/ag==
Received: from SJ0PR03CA0176.namprd03.prod.outlook.com (2603:10b6:a03:338::31)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:55:14 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::37) by SJ0PR03CA0176.outlook.office365.com
 (2603:10b6:a03:338::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Mon,
 17 Mar 2025 17:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 17:55:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Mar
 2025 10:54:59 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Mar
 2025 10:54:59 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 17 Mar 2025 10:54:57 -0700
Date: Mon, 17 Mar 2025 10:54:56 -0700
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
Message-ID: <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|DM6PR12MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e12aef1-84b5-412c-145c-08dd657cdea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HkRlga6nK5E7CWR/s6RvHqsBbN7+xUoRguEJwg9I0olm4lW1HQgGQhDRUFeA?=
 =?us-ascii?Q?6qnG2xtaZnAuT7bYcT+Xoi1jvXAGFhr7OrswppTal8etkRIstVl+BPLBQ56p?=
 =?us-ascii?Q?GN5jCnGrIAdQDF9/4bKpeHrGrCAjht76cJr+gLLr5658O1IHcpcqEw0Q3QjL?=
 =?us-ascii?Q?YHV//6x3gWcvyozLVdbCVJCZfl3Qqnk/7ExTCSkKhvheJaJnVKUBvQLhXOI5?=
 =?us-ascii?Q?AX1Kp1FQeFkylO0HZr83sDiW3yZg/d+xjhQz7RB85wi+fs8wHmszs+zQdcUK?=
 =?us-ascii?Q?DokA1Q1GvUb1gsdX0JyyRIBtzv9reL81loAwX79ifb/ZvUsPehyi9PcSwsh2?=
 =?us-ascii?Q?us4c2RfuwbYLhjl/RT4+JvM8neq7U5cRs5NIkdsvQfYK2i+jmDsXCgbE24fP?=
 =?us-ascii?Q?OCLgZZi3EstpUSkcPC0toSR6wHkFkN1fusnVX+W4FW3Xu6PbVjVYPCDySaiX?=
 =?us-ascii?Q?iH4R1Y3Hfvou0s8lGM0+tbbFqJStH7wur9vc/kS8bmfp7eUFWPO64+OLHH+6?=
 =?us-ascii?Q?TzP2RZ88LjDh57dkq3cTAissOw+hhkofhZwsCHMvXSpYVqas+6TrwghgGOQl?=
 =?us-ascii?Q?4JXxKOcgQ0+ZMol0m+tMsbkL4TdlraLTobJX/+QZQHKoBzmDinDjwV1NWJSc?=
 =?us-ascii?Q?GYQFowKKLtLxIvMyxRlUMj7M0qWHWyzuVd5xHQ6nVvqeo2GmQNxDHDcXoJeI?=
 =?us-ascii?Q?SOhOfE5mf2wZbKWtaEmMtiDn2jIlTvbnWEl+z6fbOPI5p6lqxAVfIEichnNG?=
 =?us-ascii?Q?zKtUtzYSRJhtLyvA87sAHuOu6pzT1Z8EYc8LxMTn5dN2IoNPXhv9ZkNoqC3s?=
 =?us-ascii?Q?XyzPehC+hMnqGqsKF5xeDunRIXajrIwi3j+ZQBv40RZMeTWZ96UMZ4QjE0np?=
 =?us-ascii?Q?wirL9ZJzAlrSeTRdgDZySYZYE3l21JonIMr4Y9TRYy5JzhpXf3lmUg5hofMX?=
 =?us-ascii?Q?ACW0K9mR7mTb4mrR6hLOd3UT8/y3+dDtluL2C0KiwvIlNzvTDxm8M56HlUId?=
 =?us-ascii?Q?PfTVGQTapPBCO7KhFZXmpm7TWM5mwvrnuHaD/h/19zdLs6GqF57yWQjqlIrP?=
 =?us-ascii?Q?lyCCNXE8ENz07Jfb7j/3Xd75WsdymPg28N295mS0867sfMr+28rvMlqJ8nUG?=
 =?us-ascii?Q?cte+2dD21vuNOHjBLcUVmcZcnHaEPRwdD80Xjd3WquojKdGVpo6goe2p9JE3?=
 =?us-ascii?Q?oCpRAVh7j71J5ZnFhZmf77F9AHoHYRsda9afku1LnlcLyL73h/P37piwIpA3?=
 =?us-ascii?Q?Y+rCRxt6EFI6bDOpe+DoMsTYrPMXNCV3JHcWlP2Pqvwv6niscecFQuluIlSn?=
 =?us-ascii?Q?FuZC8FAwuIHJGnlU6EgEOpflPeZvNmDZbX4qUV6YrFd4DLvm8xd4MKsRpAHo?=
 =?us-ascii?Q?30iNXNurakPTcLeUJd5AyyIe316Oei/J8dOKiL8i8yt2ShWACmdgRnPKgt0W?=
 =?us-ascii?Q?UhIMDogU+b59RRBTpcRgsz0Cbk2L+swGedu6DR2rbOOrUGw5QbQ2DQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:55:14.0495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e12aef1-84b5-412c-145c-08dd657cdea3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
Received-SPF: permerror client-ip=2a01:111:f403:2009::624;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

On Wed, Mar 12, 2025 at 04:15:10PM +0100, Eric Auger wrote:
> On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> > Based on SMMUv3 as a parent device, add a user-creatable smmuv3-accel
> > device. In order to support vfio-pci dev assignment with a Guest
> guest
> > SMMUv3, the physical SMMUv3 has to be configured in nested(S1+s2)
> nested (s1+s2)
> > mode, with Guest owning the S1 page tables. Subsequent patches will
> the guest
> > add support for smmuv3-accel to provide this.
>
> Can't this -accel smmu also works with emulated devices? Do we want an
> exclusive usage?

Is there any benefit from emulated devices working in the HW-
accelerated nested translation mode?

Thanks
Nicolin

