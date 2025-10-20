Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A59CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 18:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAuaN-0008Ot-RR; Mon, 20 Oct 2025 14:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vAuaK-0008O6-FK; Mon, 20 Oct 2025 14:26:21 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vAuaI-0007OP-DC; Mon, 20 Oct 2025 14:26:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOT2UZeYafIPGXn15IECJe6sVDI9UMpRgVy+1N/jHLDSiQQt3ziEh+hl/7qJ+KGyhnV/20A/dcHpBsztWpVrkSL7RU2CTCy7w6WJMIXNaqowaD2l8id3DIJoiUPjYYnCr5xTEdMIEu1C6lLzo5dmjrYn+B28vcuioe/HC0Bxy9HdcDho3OODd9+mb2FlM85s1NR2C8QgoZSdIlJlqYnNSG/XloBCqwKO08g9RRn3cpDilIognzRTm8HgUm4JKh1nTkKY1SGvuYtu214nLqcOtoDzlbPRoGYGMPlKSkdfG7IojdLxBiTR/eE3Bry8/k3vcRT3Co5EKA6+V5vRAxkZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gK1gQhyMlzK7IdatvlRiTGtvIMYQw6wmHWsnyjuVHKU=;
 b=iiQZSAXXU07vx+ABhXVLQsBsCHj+DcLXyls6Iq4GFvOVHIDJg8+FIuKcWWA64DSFy1KAch8jKuEs3S0a7btS45EvqRy4TLqZURhcyfOayvCb70p3iJ9GLMuE5/MnJ9gbbWzeRrY0f/LaR00KDoiDcmt/qa6FnwvmvFaoBpqU4MTW5VGX0muONoeC1zSYWQxXxudqVlgUUIcwjKImjRaT8v2re7n760wj6WJHlqGndZF04W6Xi350T2uF+pze2I/O92hwzHeOwpxQqTDqfxFkVaoeUImSTnpOHq1gDcxnarbDrTiJoxtlTcCzwYMlshY7fvRe1cHny5YJK3IV13h4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gK1gQhyMlzK7IdatvlRiTGtvIMYQw6wmHWsnyjuVHKU=;
 b=gKlNiMP0TCasl9Sme7eVBM6YeSn0PKVid7GmPTz6i6xVpFb1slI68OqQfuJ3wsHiDnETe+jy7AeEr32c6itpRRCMj7j9/fycBNJzeuvPm54wYuBymM0HciRO6CO13JrFjVYP6Qufe7aWrCCl3ugyNDMpijnGjW/qBKMBKFbqq251FjC50dfBFvEf1EQrBziRozocy6o9CLEWbJBBTQ3TiyA5HDxaiceYJ2QFRjUv8CLh5jlL+3aNWgjijLEM2PckxJ1TdMtKsBPm5GSx+GwqvzkzRDbjwIlYjJUArBVfDJ6TUOXTdmjhweFAm1cLoPkBbKKpdO/gr+R9a/P3c0u6VA==
Received: from MN2PR05CA0040.namprd05.prod.outlook.com (2603:10b6:208:236::9)
 by SN7PR12MB8058.namprd12.prod.outlook.com (2603:10b6:806:348::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 18:26:08 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::26) by MN2PR05CA0040.outlook.office365.com
 (2603:10b6:208:236::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.11 via Frontend Transport; Mon,
 20 Oct 2025 18:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 18:26:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 20 Oct
 2025 11:25:18 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Oct
 2025 11:25:17 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Oct 2025 11:25:16 -0700
Date: Mon, 20 Oct 2025 11:25:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Message-ID: <aPZ+i6Vgxww1OTTo@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-7-skolothumtho@nvidia.com>
 <b222848f-c933-43dc-b6e0-97dd8455cee6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b222848f-c933-43dc-b6e0-97dd8455cee6@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|SN7PR12MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b24b68-220c-402f-c052-08de1006237d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vqEVyDURyIXZcFcE5oU3cKZlwk89Klftf7KlpC5BpflIebaYrPuzoIWOlt2L?=
 =?us-ascii?Q?MBQGxIt7FKlOScNvuC2DqpM8VT/1kN76yUIp9ZLhoiu7pBR1nxOCqu5YTzXc?=
 =?us-ascii?Q?f1Mro0BpFNNIvN5X3BYJSKa4siRnMuJImFjKQfCz+JgxorUd3DAl/1EuR8I3?=
 =?us-ascii?Q?pTd3IS25y18VMnBb57/8Wpz7bavX+kWyyzXsxsZBc2IJgVBR0DV/owOb/X1/?=
 =?us-ascii?Q?MMQ1MEqGpNf2pktj6K/pa6bGLCy9cI50woeApPx8nTiUa4osAI/BQbvgXnKK?=
 =?us-ascii?Q?3dvE4H+wDg19Y8Zczz7hYvSf798pueeYs6syKca51KwsJh75AkimJLwVQySi?=
 =?us-ascii?Q?EIeh9J4LJyBaWTRhy+jEIB7b9pT382gHgztuo6yrXZLjduyPf3z040PcJqvG?=
 =?us-ascii?Q?mFx/FQpeavMMhNvGOxPkZ9uPrtA253wTWsOtwjH26JEzliMjiVuWTWvcFlP2?=
 =?us-ascii?Q?rgjt08+iq8P4eO52vwM5G4VycyAm5FyoODO3cp9ccha+WRF9CquHQCwUU9jl?=
 =?us-ascii?Q?gq0KXkmc327OVjjcN9BTFl1h+4vwPkV6X2UjPmxwffF3ZOIdZiuFkTmMBYns?=
 =?us-ascii?Q?3otGYGT8pAE/LbgqSCtAtv7w6gRLPOJJIyQvQEM4Eh5NjlHGf2pFJtqTEkSm?=
 =?us-ascii?Q?6QmTIbz2HLNSnhrdb5JiAFRMnMTn5jG+oIXEynjOtmFNoEHQeCRRTaDpc+TE?=
 =?us-ascii?Q?AfSLgbyMyKjrusKT8YrbYDJIfGqIwbAr4MMT+qoV/fs0Vz6HOBAhIU7BU9Ry?=
 =?us-ascii?Q?xnRXvMYp6Y5GFU1qCtUx4qdEH0jFm/nAb69Po7S7Xz2TJIuwhNDWbm+ehVMG?=
 =?us-ascii?Q?1i1oQhIidKQMFEkCqpu6FIiNgMZCwLhITPAXLfVGo8RKNwdLan/0kRxroCB5?=
 =?us-ascii?Q?RLJfzdbrC7zPVQ60KofadRjqXsjl13/efQvi9qf/++atgnEqigPnqs0ldp3e?=
 =?us-ascii?Q?9nIutmiXPPK8SX+oak242yrpeJEIXPsHSDa8gzDNEA1+KevyNtc9W1C6tZDA?=
 =?us-ascii?Q?Jh5sdbGadFnT4lZS2NDRBgdnB2/ndabHOpzsnWluMNQ2vlj4KORGbP/L7Z4A?=
 =?us-ascii?Q?k80mtBSSXFYgITlLkl36quMlqHK6L8ZnBvYu9RuDJ8Lx24R2x2r4gK7J+mwT?=
 =?us-ascii?Q?hyRwkvMuq/37EhhuuNzBR4pwSMIULWWZveBvhoOU/jvGjTFlU9+84wl4r1Ij?=
 =?us-ascii?Q?0/mh4HNdOGtgMcngA8TcEr+qDj1q7nuvIyb1jy6eTu0+2HJuZNUH11BKyVRY?=
 =?us-ascii?Q?KNef+8BmrVEs0xPND+MqiyNpFfnOYYeEBwbHTuWpydcmmbuX7ivurk7juDDv?=
 =?us-ascii?Q?J3J9LxenuPa2/qJepH+Ev6BU31r2qlqcPPip2bhqcAQDs1XBKYm+gr4riJ1Q?=
 =?us-ascii?Q?zEwtYaAG51gnLtkzmLZw3KpDLNagMmUd7d0ttL7lveknFJWafoT8PIgwktvv?=
 =?us-ascii?Q?92W2uTG7Q37Tt67wS0cv7GLME62fnzc+3LwOZr5nSzqJ8KkthOXpGH/CvQyj?=
 =?us-ascii?Q?2UW5n4pVtSu9jwN3iDZWBMMU4AD0bI1nhspbDsg54lrpznOINZyTY3HX9hk0?=
 =?us-ascii?Q?vd5Q03o16zFPA+BuY3A=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 18:26:08.1971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b24b68-220c-402f-c052-08de1006237d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8058
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nicolinc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 20, 2025 at 06:31:38PM +0200, Eric Auger wrote:
> On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> > +    /*
> > +     * We return the system address for vfio-pci devices(with iommufd as
> > +     * backend) so that the VFIO core can set up Stage-2 (S2) mappings for
> > +     * guest RAM. This is needed because, in the accelerated SMMUv3 case,
> > +     * the host SMMUv3 runs in nested (S1 + S2)  mode where the guest
> > +     * manages its own S1 page tables while the host manages S2.
> > +     *
> > +     * We are using the global &address_space_memory here, as this will ensure
> > +     * same system address space pointer for all devices behind the accelerated
> > +     * SMMUv3s in a VM. That way VFIO/iommufd can reuse a single IOAS ID in
> > +     * iommufd_cdev_attach(), allowing the Stage-2 page tables to be shared
> > +     * within the VM instead of duplicating them for every SMMUv3 instance.
> > +     */
> > +    if (vfio_pci) {
> > +        return &address_space_memory;
> From that comment one understands the need of a single and common AS.
> However it is not obvious why it shall be
> 
> &address_space_memory and not an AS created on purpose.

We tried creating an AS, but it was not straightforward to share
across vSMMU instances, as most of the structures are per vSMMU.

Only SMMUv3Class seems to be shared across vSMMU instances, but
it doesn't seem to be the good place to hold an AS pointer either.

The global @address_space_memory is provisioned as the system AS,
so it's easy to use.

Perhaps we could add a couple of lines to the comments.

Thanks
Nicolin

