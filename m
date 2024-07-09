Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD58C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 18:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRFB2-00079k-Hk; Tue, 09 Jul 2024 14:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sRFAz-0006sU-8t; Tue, 09 Jul 2024 14:02:54 -0400
Received: from mail-sn1nam02on20621.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::621]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sRFAx-0001IA-33; Tue, 09 Jul 2024 14:02:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPeW6h5JBZXZhhnZvRWv8ZjFF7qYPVpt5IXMHpiKTbBHQ6tM8afukV3OHM75mFdinxJcb0Q7mg/zC50DAaDnLyaJT7lIXvEJBo5gwa6bkiAjxo5nxRo/Ee4xCd8w/z9GQnrqkizvxMwf1X2nxwND+0zXP7UEEHXfon5hz7X54yJ2lkfbCXDn5GqnpvjvruW4vmRD1FEkXeLYnhr3T+/4R2nGgoXoa4d+mCxY9VUA4PdtVkdzHgu9Osp+rklcxJekjUBNPGmhrtiVOUaFgfwr6EFIRQ0ZSSftez0johWWkKYDSjWKjgljhKJUqBYHSy1gX1iHspyF+ylx0aUpC831HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0DzYNIbGfrAkNheZJTzM897eJtp6shMoZgDkz+XE2E=;
 b=Vy6SYbY6XxVs3dvjA8L3kblAjzmtQFQpOBo4vCMvImha81J9d3ojXiT7bphqSwD8lNimcDpI9pa9slQm31YmkBrdUj7flvSe1ADeGNqPvLojXR0bgvqDMJpWMsZBCHSP6w6rQNkj+azUVNB/KLgImKX5mG/Lih4dBt2zggiTm6wrHeZEgBHwf0IZxe6UH7p3CyL9B4zhjPfi4gsCnxY9g3Pw1d288nyZBZuZ8/oMkN04uR+mVnL3OfU3iBO+rcoFUXblGBiKZSZ0Uu4ky6/17TvrJDaMvPWczd27yPXGcO4OQMMZAGi5b4wqi6uNt+/D7SHsE/8JB99MPNT7xZcoHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0DzYNIbGfrAkNheZJTzM897eJtp6shMoZgDkz+XE2E=;
 b=Qd2Yb1PWQiE1B5RpFX57qLqeYwao9S56uK50H5MinbW68aJN+ePX5X7yuPbVTxT0ct/JxMEjvBhoghTcxyIWbw/9i1fTU/81BqBH+ng14UwXrMAem7799tX2PduzfApspYESPX4tFwMfYrRY/9NRV7fv8Ss7rbXsSuFksghGXoeAeun7qz4TEYM7WKBok039LQFRFxkrIjNFQf5IlfNh9rgWs+13zRN1m8n5YvH3D8CnSeMxgAhp1HmYolxbahClQDy4O+uV362NeKxpOV7fP7es4rj9srgKB2tzjVBkXectpCzSvqskVgFtjDngJdKgYqpVGDJ6/8vXbbz/OHBPLg==
Received: from PH7PR17CA0050.namprd17.prod.outlook.com (2603:10b6:510:325::22)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Tue, 9 Jul
 2024 18:02:43 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::a5) by PH7PR17CA0050.outlook.office365.com
 (2603:10b6:510:325::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 18:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 18:02:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Jul 2024
 11:02:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Jul 2024
 11:02:08 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 9 Jul 2024 11:02:07 -0700
Date: Tue, 9 Jul 2024 11:02:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <peterx@redhat.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>
Subject: Re: [PATCH RFCv1 03/10] hw/arm/virt: Get the number of host-level
 SMMUv3 instances
Message-ID: <Zo17HoZN2KiOorOZ@Asurada-Nvidia>
References: <cover.1719361174.git.nicolinc@nvidia.com>
 <886883c4cb43117ef26e6c9434247b75cd827f31.1719361174.git.nicolinc@nvidia.com>
 <3d151591-4cc6-4de4-8055-27d6fb7200df@redhat.com>
 <Zo1vW5dwHqBM5zFN@Asurada-Nvidia>
 <33e5c4b7-6f5e-4ef2-9156-9a1e4b6a2dfe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <33e5c4b7-6f5e-4ef2-9156-9a1e4b6a2dfe@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a57e610-d19a-4ca9-fcfb-08dca041531a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UAHqYYANoM94qTrOW+g5DSb2Ay+osQ4wxNAMce+RXl4K6EZ8LTkfG/x0r1A4?=
 =?us-ascii?Q?hcRO5Jj6XCniEPXuakMflLc4X9rZ/9TfoifQwPX3pg5fF/shNrVpF3Lbuclc?=
 =?us-ascii?Q?PGxEq/NKcch1Spv8fa9LykpsYekWiRHUnipk4w+WTpAYs2DZ8Y6rbn+dB9HA?=
 =?us-ascii?Q?o11IDB/DILMglBjElQJnX1PIaiP/d2ZRKXEt9OYO3yNE7xLcf7r/4YzVV9Bg?=
 =?us-ascii?Q?xFKpoYSVe2ET9B2dn+AJ7FzybNSepbWAAbQGr89GYcLeNrzuJxJ521dBqMM+?=
 =?us-ascii?Q?SIDqIbi+SnlXhM0k/ylGVwtUXxmjHXUYFacRgDiDBFw32Vro/QzV0HmRrOBG?=
 =?us-ascii?Q?s9auD38cNZt7MgLfkKPPHRwVH3meqS1wUefuk0Fgd1ItCqbojmZke8WmpGdW?=
 =?us-ascii?Q?oxzM1qHqzcBi1hlezta6rMhnfDZxk5eajEmID1xA8okH+kkXVedn91f6B0E6?=
 =?us-ascii?Q?qMye4Vm/MyS8Jm1FUfm2A8VrcFVo5L6AjPtu0XVV4WGlbH2CF3feR4qgLDVI?=
 =?us-ascii?Q?ydL8MrWq2aVd2QsctNwnMhknGGDDU10Q/9tORi0zhW1f7u1oZT77WtkeJDjj?=
 =?us-ascii?Q?FCVojWVcGX5gGKx1M6qHzsPIlX3M/0okayNtQfq1ZWJFX6n9oY/QRSTo1tQ4?=
 =?us-ascii?Q?RqNxxXDptlDAPvHJWKXu2fiE/M7OJk9OvxLDHXtd1dy0PQWhMrMxSIAv0Zn8?=
 =?us-ascii?Q?5fjZ5legEUU31Y/U55vnxeQNsD42Sq/CaDQxnYDgr9+Dz3Nri/UybXTFYREJ?=
 =?us-ascii?Q?qZkGAaAV+JnFs/QlXbT0FEatKh1STO77BNG0k8AE+Qu53sYiHpoK3DS4lFnQ?=
 =?us-ascii?Q?wCuBRjjXdk0M+09zOAnZ0OW+MlRrcFmH1MalaBWWBibxZmh0h9lrjDtY/LqZ?=
 =?us-ascii?Q?20/EIfYW7vzX0EHptEEvSIDcsWeolBpsbLU/+mBRV42HTGWK63xbow+XpU3A?=
 =?us-ascii?Q?lwojBqyeDHHYymSpXAOOQoh9J6DmRLqsfFtdPQVksW7635WiVk6wtbMMgtaI?=
 =?us-ascii?Q?FyHSr0WOASrZC8/sG01Nd3mQ7/zQ9NPpbIYDkTwKAniH75TOTDXbvzeiend4?=
 =?us-ascii?Q?bmUvdNKsd3QHE2pz3hh3o/CseqJJ4BjywlsmGQ0ElBFdDUJK4P11JZJF8KM2?=
 =?us-ascii?Q?uXYGPhRxnIoZCiPsZfHhuoudAqnimmKzlHujFDkLoBalNWhiVYG1zoI36xQS?=
 =?us-ascii?Q?Gsc0OiAFTHbRkjT2RfRIPcv01wGFyjm3qa84jayNuK/SUIiDzzYFF9heuiki?=
 =?us-ascii?Q?robTFmn4AX3ok89wrvVxI6hKlOoIWesGz2g4EheGmA4ZUYcy8RLDFISlo6KW?=
 =?us-ascii?Q?CDU6Erb/B3P+CWl6lqfNc/ie2Qy0kg7adVGqE3kf9z3tDVcSEHOTB12XhHhu?=
 =?us-ascii?Q?usm9T1R4K830IR6A+odlL4yTMZLmdMCeX+9olO/olRTEoDjsm3MTjLb1FeLd?=
 =?us-ascii?Q?h6meVH5JDyrq1SalDgEz4cAaglNCf1mk?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 18:02:40.5957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a57e610-d19a-4ca9-fcfb-08dca041531a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::621;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Tue, Jul 09, 2024 at 07:22:16PM +0200, Eric Auger wrote:
> On 7/9/24 19:11, Nicolin Chen wrote:
> > On Tue, Jul 09, 2024 at 11:20:16AM +0200, Eric Auger wrote:
> >> On 6/26/24 02:28, Nicolin Chen wrote:
> >>> Nested SMMUv3 feature requires the support/presence of host-level SMMUv3
> >>> instance(s). Add a helper to read the sysfs for the number of instances.
> >>> Log them in a vms list using a new struct VirtNestedSmmu.
> >>>
> >>> This will be used by a following patch to assign a passthrough device to
> >>> corresponding nested SMMUv3 instance.
> >> Laterly the HostIOMMUDevice has been introduced to allow, among other
> >> things, to pass information related to the physical IOMMU to the virtual
> >> IOMMU.
> >> I guess it would be well fitted to associate the viommu with its
> >> underlying piommu.
> > Wow, I missed that part -- backends/host_iommu_device. I will
> > see how I can fit these well with that.
> >
> >> I don't think we have such kind of host introspection in machine type.
> >> Generally in can happen in the very device or in libvirt.
> > I think the biggest reason for having such an introspection in
> > the virt code is because of hotplug, (though it's not properly
> > implemented yet), as we don't know what new devices requiring
> > for nested translation would be joining later. So somebody has
> > to hold a full list.
> >
> > Would you mind elaborating how the "device" or "libvirt" can
> > handle that?
> If you know that on Grace you have 5 SMMU instances, can't you pre-build
> a PCIe topology with 5 PXB and root ports at libvirt level.
> Then when you hotplug your device you specify the corresponding slot
> just as we do normally. But maybe I misunderstood the hotplug problematics.

I guess I got your point: basically, the introspection and sysfs
node matching for device assigning should happen in libvirt.

Thanks
Nicolin

