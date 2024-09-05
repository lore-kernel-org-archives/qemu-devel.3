Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64586CE7A96
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 20:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smJEI-0003cl-Ot; Thu, 05 Sep 2024 16:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1smJEH-0003b3-Hu; Thu, 05 Sep 2024 16:37:21 -0400
Received: from mail-bn7nam10on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:2009::62e]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1smJEF-0002ny-GJ; Thu, 05 Sep 2024 16:37:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcGNp3lq0TvR76O7h9TNcxSOKFJ3FMVU1r++9SejV/09H7Y6tl1CW54nNOlVks17GyKWhi5L3FIM3C+OYZ6zdKzHYmEAtmYtPgeLuyBbaoMV1suWE6hsmDUd1b4N0bI3kKQDAUu1z8mxrOxWwS11ylJOG1ZqJmBNP3NU2yHE2Z1E20gsO3Bl/KF+/vi7w7GgV9Fc9XhsmfQM5gJILbXH8ap6PJKm5JrQ5pBi7VWRtLLAuirb+kfq8CXZbgqLaUcNY4cojFoxVrAF6vLCD/asDtYYlnjsfqKdFce0NvgPDomCsKwZ86teaAfTuNFzf+fhDW2vjY7sfjZsTKHPS83fig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20uZ1/P/FMoIxFjBzU0cM3H9X8Ir8ItQ1oHsmJItEao=;
 b=IEm0s8iqGL7o57UdqmLKidV+3tO+f5ceuHXGmyJlXD6LgrlSUUGx/S08jJzDCF9C8bM01vyQuKXuSBoTai+XbIOeZ2WoZ1Vi2R9hmTz6megeMhA8SBgeoHQt++mjRFK3NoZjnP8MkxesKn8yuTdqLU+4XCv8aAI6QZHyiJchFbDmnL/eu05oQn5RlZJ55Gge1i6J84CxEJyuiOolLg9bawhqiMZALGEPucd+yiNQVrs5OiEI3gJSY5RHIgwLqKYg5WMTH6w3dSC0tjKwZXtDI+LozSc94XDLqzjk4kHysBIFEFhOSu2rzJjXm7A56XGVb5ljtt8rYR6DROz8F/Ombw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20uZ1/P/FMoIxFjBzU0cM3H9X8Ir8ItQ1oHsmJItEao=;
 b=N3i6/bLH/3wxzV3C29vuSgJdHV+9CwfmqjAootoRUK9+8ZCGUfbOGg+ySM8PK2oJRhjpMlWYIbXTV4uxpXpvV9Q2v6n704uEe0WLEvGcwXJKNkJ6CJLnt8TOS4W9+91kDAW4Ra1VFBc1hvRv2fl7rNfhFswSYDeIxXqDFaeKdBa6JuPjJqG5OyVPXp+XrgCDi27ai0bjyWCQB08VxItOXh1VXYQJCERDvYPzo05/6AEeOmhWOosZffqUQKbWqOYJQjs648fB8xKAXI9mcoMm5i5PjZ4SkmaqyWb5uYXMDCuPGDIsYH2SNjZWUR6FR5nG/rMVwnEOwUUIxTz85oMGxw==
Received: from CH2PR02CA0028.namprd02.prod.outlook.com (2603:10b6:610:4e::38)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Thu, 5 Sep 2024 20:37:12 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:4e:cafe::85) by CH2PR02CA0028.outlook.office365.com
 (2603:10b6:610:4e::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Thu, 5 Sep 2024 20:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.2 via Frontend Transport; Thu, 5 Sep 2024 20:37:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 13:36:58 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 13:36:57 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Sep 2024 13:36:46 -0700
Date: Thu, 5 Sep 2024 13:36:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Eric Auger <eric.auger@redhat.com>, Mostafa Saleh <smostafa@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, Michael Shavit
 <mshavit@google.com>, "Andrea Bolognani" <abologna@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Peter Xu" <peterx@redhat.com>
Subject: Re: nested-smmuv3 topic, Sep 2024
Message-ID: <ZtoWVjmSXfQStlkF@nvidia.com>
References: <ZtlrLJzZqpnUrZQf@Asurada-Nvidia>
 <d0e3a60713da4ff1bb10245e789ecf24@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d0e3a60713da4ff1bb10245e789ecf24@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 3861a36c-ef5b-4446-1051-08dccdea8548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8uN00PWvHArNEYQICJ53ZzSO1t4kXhvlPNjZtkgao++3ert2trfwXqHsuegs?=
 =?us-ascii?Q?971UC4Ui0XnNlALviDNhYDXrI5U/0R8LDAgdBqa/05ShVb381YHAkE/7pBJ1?=
 =?us-ascii?Q?jrawoMeAkQ0hvduMkVAL3sIemH996I+A3kthSRubtB+q61C3Iid8RItD6FG9?=
 =?us-ascii?Q?y6Z3QHoE06zyBbmvFsrk33fBHlC2edPA2wDSqzwAHx1/kXBEa2YPKKkVMTzm?=
 =?us-ascii?Q?2AsRF0VuejUt/cy6qF6x956U0biXz6wmgHtWqi3y0ERqiDCwR2lDK42NnmNw?=
 =?us-ascii?Q?JNWiH3Hkn6kgyoEAySlPtxrldKglVLyl2vVCgH4LLgu4th4gAS/wfoArHRs3?=
 =?us-ascii?Q?FvYosnWIsg0fgz0lpz8+y07EsW3Atng2FrhvC9BdLIcMDYGk2srRYvw+44d5?=
 =?us-ascii?Q?5MmmfCePxHOSBX8z5GOMHGwF1ji0BLkVgWPKoIPd6bx4l7qIP87lsh7BwOP9?=
 =?us-ascii?Q?CH837BHwGCjudSzzGCA7v0S4oK4JDwx9oZEA4iJevTh6yvwcrEpaK1LMgkYg?=
 =?us-ascii?Q?4SBaoyF5tFCzc+fqNHEfZMU2tHrxOTo7UUcdREL49tf2F838N/nZwS+3aiX0?=
 =?us-ascii?Q?NYFU+h4MbcuzEavEvBOG0kh0H3g7odY4lNQKcUq2uGb0c2I/wfAd42X15wdH?=
 =?us-ascii?Q?10StnGVZ6TrTEvsny0zrfk7aTA4EIltOEI1X4/ORPF2eBJocx+rR7bUYryxX?=
 =?us-ascii?Q?TN/n6OiTtUfFbvf+lR/Cn6x/VVnnK2TwlK2wKuKIPWu34aZMYcIMmGZWsvms?=
 =?us-ascii?Q?ip+61NFScjBkSBBmEFLkulu82AN0LUxdN8oK0weOwUyf7mQN9miAdB++mMtz?=
 =?us-ascii?Q?p4hKqdMxNzRwV9kafWm0ucZFSGiit5B7q3DRUdV9qwEIKQNUzC+y1HS2dMOG?=
 =?us-ascii?Q?k00tUpMIgRx41hu/r7Rg6VMNbyUrtS0xbDTmEewTy8HYgaJ1Bl2aapqHRYgk?=
 =?us-ascii?Q?eI9Rg30dKsJaoNv3i4Mj1wDRbstJQVmhBMnWrhFW5DVpz9nM9+lSwwuEtxAl?=
 =?us-ascii?Q?eUbFejjxuPekjZwcVbuNsQoac60SEEbFOzIe/mB031BzoGMdWs5PInIiwZqc?=
 =?us-ascii?Q?ScrQ0UqCMn9g6VKCw+PJS3lKcBbRhjciq7dNPuWl8L1u5KlLfzYtBuT6fmPc?=
 =?us-ascii?Q?GPByh75ZB5qUwey39/L7QP9hg66MGWI+qxQGNabXqx5puBs46w/982hc6Lf8?=
 =?us-ascii?Q?rrB+kvRCdHZ4cp1k65xYxX6R/xPPLZBUxaaiuPmDpMPMNmV8Af++CKCuaYCw?=
 =?us-ascii?Q?ClqMtC3XiR/UpheFD5LUX95S3ZO3Ie4BMFrwGWu1I2UXK495PZ+f/C1Tp7xC?=
 =?us-ascii?Q?0ScOJpXOrqz57/1oH9Yvb2kvTvG2Iyr4+1ipkpW+DHeFbS4kXLeXLAtSwGzW?=
 =?us-ascii?Q?U/i9M4rUiJuhXFezbj0wsUYa4jcjTdyjueiJO76TBdrzvuK1oJHo5vgTDwja?=
 =?us-ascii?Q?YS+wIUFksj92P8csZvDZgo48l9aU2RRQ?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:37:12.0339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3861a36c-ef5b-4446-1051-08dccdea8548
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
Received-SPF: softfail client-ip=2a01:111:f403:2009::62e;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

Hi Shameer,

Thanks for the reply!

On Thu, Sep 05, 2024 at 12:55:52PM +0000, Shameerali Kolothum Thodi wrote:
> > The main takeaway from the discussion is to
> > 1) Turn the vSMMU module into a pluggable one, like intel-iommu
> > 2) Move the per-SMMU pxb bus and device auto-assign into libvirt
> >
> > Apart from the multi-vSMMU thing, there's basic nesting series:
> > 0) Keep updating to the latest kernel uAPIs to support nesting
> 
> By this you mean the old HWPT based nested-smmuv3 support?

HWPT + vIOMMU. The for-viommu/virq branches that I shared in my
kernel series have those changes. Invalidations is done via the
vIOMMU infrastructure.

> >
> > I was trying to do all these three, but apparently too ambitious.
> > The kernel side of work is still taking a lot of my bandwidth. So
> > far I had almost-zero progress on task (1) and completely-zero on
> > task (2).
> >
> > <-- Help Needed --->
> > So, I'm wondering if anyone(s) might have some extra bandwidth in
> > the following months helping these two tasks, either of which can
> > be a standalone project I think.
> >
> > For task (0), I think I can keep updating the uAPI part, although
> > it'd need some help for reviews, which I was hoping to occur after
> > Intel sends the QEMU nesting backend patches. Once we know how big
> > the rework is going to be, we may need to borrow some help at that
> > point once again..
> 
> I might have some bandwidth starting October and can take a look at
> task 1 above. I haven't gone through the VIOMMU API model completely
> yet and plan to do that soon.

Thank you! That'd be helpful! The major effort I think is in the
VIRT code also, where "-device nested-smmuv3" must tell the info
to build Device Tree or IORT.

The vIOMMU uAPI is not that complicated. That being said, I am
trying to add some kernel documentation for nested translation,
so hopefully this would be helpful in the near future.

> Also I am planning to attend KVM forum, so if there are anyone interested
> to have  a chat on this, please let me know.

Wish I could make it to that. I think we will need another Oct
thread to get all of us aligned once again.

Regards
Nicolin

