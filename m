Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB906D6ACEF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 16:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGKT8-0006Et-4y; Wed, 27 Nov 2024 11:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tGKT6-0006Ea-Qz; Wed, 27 Nov 2024 11:00:44 -0500
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tGKT4-0001fE-Kl; Wed, 27 Nov 2024 11:00:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qei++R5UgmH8HuDWNHDhfscYhRNERhRZgKaZwyu2JaQqlz4/HBPWFPx/443Y4jgGTIxMXbsb9SQkfJhB9KbJv9Hvb1l727jeb075QDjfBM/6h6kojDElpfNaqGdfafNmJWYPO9qrXAgLBbFNPRvQJrGrQVcTOY1BEXGyJfY4i/Zo9QeGHuHQWQNB6MdGcoTXS3oGXbGviUPWMblqUHxdK0Qaynnqaw7xO7poO8LFL6BvTDF2uvd/baYIGiJfeCjCkVZ9NdVHYxFHl5/qKIn9djLm1e44mPSAC/EjMJMRR0+phhVruA4ody698MW+Yi5mynnszmHTRZaWVDT+g3Ju3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Wtb8lNMFKnEO/SlipAumecHcX1SXrqOq37SESj8xL8=;
 b=LGZvKzRrN5FggmYK0u13WjrsZHuY5KdsXPNkb9Za/EIKgPJmJS4MaQhNdER5PmhgTsjid6xoxk45VY61h/c3zKGHjwy7ikEjavcIQEYBEFq5qfCPMlmk9qB/dxOrIUt8lNXv0a0Nb72ax3mGA89y5hO3SVdzv7bSLognoUdcekG/AbdiPOhpub9cZVGGzD6xhgAHuN7SUsSur/qZB6Whfz1E4uJU/vk2SFP9gaJYdJtWDeaL0IDyY90I6fO7V19GEnuuXILvjcO4WuOeRVyuy+QNu+KQJkhCZreHT+in7WSYyeHJdK+s8NJZEgJ8xmdCkJ8UrZ5b7YFl25QfoahjOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Wtb8lNMFKnEO/SlipAumecHcX1SXrqOq37SESj8xL8=;
 b=D/07kkcw8TEDGp4/AhOU0zP6ynIpcxke+fqfZ8VdEt64NZFKPKFZF2rZwr3TfysiI5DJ6g/SwArqEhtWtAOkcVGzUQf7ozcy+79vFYyUaNrubGPm+HJyZzT7laiwf7iN0SG3HyuVaGKrOxJNHoUe4nIQ3vpMUg0MVS3pWspzZQqIMHa80ms5Fyn63ZSv3EXpVRqrGPL5oa0C2+kFXEeVDqPRkWsfu4PXxs+VHP46AgYy8LFH996YZEzi0QKHNkJb3rbcXxr/ownFxSzeTjpRO5lkJtndcGWdLNTIzwHYhyMi+BC0K8k/CKBRdTU07gaDajspvAjdJdcxir9zjPwcOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 16:00:33 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 16:00:33 +0000
Date: Wed, 27 Nov 2024 12:00:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Donald Dutile <ddutile@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Message-ID: <20241127160031.GA1253388@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
 <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
 <d8fbaa677771425dac985438b4b1db59@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8fbaa677771425dac985438b4b1db59@huawei.com>
X-ClientProxiedBy: MN0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:208:52d::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 15195498-23e5-4be4-451b-08dd0efc9f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xOkGH+vnOCIyeIKxGR9OflBTdrRYupqO01uwzAwG0qxqWA6xwiDNi4nLNaJG?=
 =?us-ascii?Q?9n2bTSnx0I69tRcnZa/Ofn20dex8VZrsa8AiTTFQoYfqbwP0eazpNQScnTzY?=
 =?us-ascii?Q?EbvSKXDIduyto58zCFls22bXaZcpdiSfBDRcKUilFgM6laifQ3HnuAVURg4S?=
 =?us-ascii?Q?vTakOGspucUgFNTnc4ywJ1jUDDhKWmnydOPCEs6xQdhvAwtK+qy5tRWHpev1?=
 =?us-ascii?Q?7b8essVatt52tZuEEQrNr709ESDAVWpA5vGYtAc8NLPU+kYBpcv9H3vrSnL4?=
 =?us-ascii?Q?WQtjx8LDAa7L9xIFa4Z2s7E8LJU4htKsb24GU7piSissuaIKc+O+AxWnaAvZ?=
 =?us-ascii?Q?RpWFLfukdCOLWzudHhJ3hLsGzETLGU6oPkECfO4SHMjKcmJRmXxB1XX0hieo?=
 =?us-ascii?Q?GCI+COTFjK7iEPZDC49QZmvCyvbW8t5kmKszze99pauizFp4GX8oqBqbXlVD?=
 =?us-ascii?Q?UMDUy69sGVCxLETvgEyY4P4BZTMpHjuckAyx62lIz5EQ6xAlUe7yMaxUFq5g?=
 =?us-ascii?Q?Fz31LOVoH84qjCq0UgzX19GEOBaY6t0L3X1rdqftk3hLvOJBB+RcX4H2U14M?=
 =?us-ascii?Q?i/z2WILzsOYsomBH2Jj+wLWB4b61J1VCjpsI8l1pq8aryFh1TAuSLtO3s09O?=
 =?us-ascii?Q?METJLnSn/VB19H8W8dI7XLuKJXMFX2OswuEN+jbKvmNcbABvoSKM6onAi30J?=
 =?us-ascii?Q?fN4rar8pPlBa+KCx4hiX7Hr7i+XOkmnLOtvpzt8dFUTcJc1E78BiqRRkImUB?=
 =?us-ascii?Q?68bY4qIKUpK1PZGsJOkrzPdcxnn+JRXv72zNwK+5XTluxizRpe8JjDp6+Frh?=
 =?us-ascii?Q?H+mGpy35RaaBlI3K1kip8g24t5IYxcQ42sDaRt9FhSCG12Or758dyEwM263f?=
 =?us-ascii?Q?2/ZXuVS0PEF6GBR7HzYQU84ixVDJBFsKqdqCk0+hiJQEhd+82PJyby/8Kgs9?=
 =?us-ascii?Q?PpodXbq4qGpHrplebWmR7vMKcfW3vyVZuoD+5y66iuotCHw/MrSL+ePOSSZD?=
 =?us-ascii?Q?LIErtFxW1KEtB/R2o6IDT4TbmoJstVo2Z68q+shTHKNAY28ASIig0TKLEtb4?=
 =?us-ascii?Q?Wc52pi1HXoUmHzR4OBo1woWJlp4h9dnmov+bh1vxZTi1594zt+SZdIvGtB4v?=
 =?us-ascii?Q?jhCztKmqLoraMbW/4uazJ3e1rdl2X6GtLHpPgF2F5BWVhGeXqziEKGvenWT7?=
 =?us-ascii?Q?E8oj1RPMxbUHBdTrjg0DjG+IqniE4++blFlIO+kIW91ZD4EGAPrISyiveu49?=
 =?us-ascii?Q?lDZXyUr+FmyKsAL/YAEuYVnTfa9Eialf5CdtrvGctytZCAPPqTQ0F2cd2YJo?=
 =?us-ascii?Q?3C8wLnuBOC64uIjlWjw0+bJbgtGa2vmHQ7kk+yybDX4MBg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FNgoVDWNuAHlYzsxhhnD7wGA/PAUjLC1VTNfmQCNaZcxlsdKI6WbsJ3tJLkN?=
 =?us-ascii?Q?tVgKoqiNOUchtN2igsmw3PosrChRoSKh31FBDVlTdO+E/481hLEa/WOjtpB6?=
 =?us-ascii?Q?kS1JkorOhDIYlIpukc95UtZKLIlC63pTEyjQANnk1/+gQh05piCbLAtxnMm0?=
 =?us-ascii?Q?nt1SXKlb5GIqJQswSAHB5c2Jcq58I26R37K4VeXT9PZY37Smq4kKP3/1jeJg?=
 =?us-ascii?Q?Yyoy3AW3M4acyUfqSWrfxlJ3/8RrWnubAH1RwEGBh15yxuXKLLJqlmXNFpTK?=
 =?us-ascii?Q?EGzrSnoMCIgd1WxjOfI5MrtNQ0dRcKsOEHE+Ptow6rBOOq/Wm5Z02o4PCTAk?=
 =?us-ascii?Q?L/ahZY7Tp49ZU5hzEgmOogSOQGZkXHbROqyuOQaWjqu0Ml/6WYtIa+laGg6S?=
 =?us-ascii?Q?bBEcSFlihzxDbK0wCjpjyHFZ98nH1k3SNBzYNsxmKHxbbMO5tFskhZYDqhmH?=
 =?us-ascii?Q?RvaCg0YMOSeF2WYaYCKZPYfo9wnMCOamivpZ+b7VQ9858amNz36PVB+LPS9W?=
 =?us-ascii?Q?yR989yuYs3ranV3fb4nrxrQZJnFsi/Z0rDvxs2EOc+b3D7KjBPvW/xVN2xLX?=
 =?us-ascii?Q?Aq6jmZzM9P5GbDNgw3UX51Oc+ERCPYWFWywLggeazDES8OLzSzwPacg9FwXw?=
 =?us-ascii?Q?bwrCIjnTUYXGiGXdFYhf8yiOlF1ckj/DK7Xc6Wdm7+vpDhFvAx2zN762WDXE?=
 =?us-ascii?Q?r+librvwUn17O3wDrtbtW4lrU+sSbsF2rGPeylRUyFO4wUDITb/CBdNW0/kn?=
 =?us-ascii?Q?SNHQ7OUCdBF/lqLF94O6ZN8iAc5KREKFlEU7EvDm3BGxa6LW9qKa4s34s1mR?=
 =?us-ascii?Q?0ZkEPDuIKK/7EdoTu1Jzdfu2Q/7K4BOEZ94wGCi9kF0JWk9rsmLB/EHcbtKg?=
 =?us-ascii?Q?sAJzZ1KDRsmh2lPWtbIOwVF3ZiFHxcIyTyNnY5TS75KZJZWX8O8zgPwEeRkj?=
 =?us-ascii?Q?1CHmehuNivb0WdV4ckWeCGS0zmZXWZnysT9j+lT5iLMm8HXUpLTeEnuYmtAe?=
 =?us-ascii?Q?PGSTqRhho2wc94bJeBnFjKlhq2D8nxjyBd06lq3Fjbmv8OaDqThbTjX7UM//?=
 =?us-ascii?Q?ZteEtS67o5/Z/aC0C10ZivA20HKPhKTh2qphTEIiq2IwOw6biPMW5amasITV?=
 =?us-ascii?Q?ODQXFc9YCZ9WA/OVPIJwKjpfVaGOSn25YyddPjvOgVOkgkglCwXvyi4+SCM0?=
 =?us-ascii?Q?ffDXV6jHYWLX9r8+Nv3zc/G5pcf/SjSeTvXrExaWieBweVVOymlJ/mcpdi95?=
 =?us-ascii?Q?IeS5L+nO+RYyAKAmcqC9obi9fBM9zdhtW+4ZuXjBsypUEeHHe2XcKZDM+bto?=
 =?us-ascii?Q?1+Tn4pxc7/xtMOSh/stL+mYJZOfxk2tQ2euWOzqi0KZUtNGWFAvbM+KHvo+s?=
 =?us-ascii?Q?c9esqI61gaMjKLTeflP/pGgKfejmC3Apivi/nuTkEBR0tz9VGqeqZrkLTpBM?=
 =?us-ascii?Q?kVYtHrF6iH/o94dSYDYfpvJxM33eaW9BoGnE28NreiF2OWkVXiy73o1AHQJf?=
 =?us-ascii?Q?MNQ8uFTyBIzQChRaPGo/IxAmRth+Ftw1pCWB5zAj0+5hR2aozXuIiTqHqTFX?=
 =?us-ascii?Q?fOCtFd0c4XOxkPcWMIid49JtraovphizSI+UmuaJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15195498-23e5-4be4-451b-08dd0efc9f90
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 16:00:32.9907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ut0xdheVE40ucs+w3/PXL/SWrYU6CSUXMLJo4oHFEwkbvN7u92IfC8ZUcz9bOeC6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793
Received-SPF: softfail client-ip=2a01:111:f403:2416::601;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

On Wed, Nov 27, 2024 at 10:21:24AM +0000, Shameerali Kolothum Thodi wrote:
> > For SMMUv3, NVIDIA-specific vCMDQ, it needs a parameter to state that
> > specifically,
> > since I'm concluding from reading the SMMUv3 version G.a spec, that
> > ECMDQ was added
> > to be able to assign an ECMDQ to a VM,
> 
> Not sure the intention of ECMDQ as per that specification is to assign
> it to a VM. I think the main idea behind it is to have one Command Queue 
> per host CPU to eliminate lock contention while submitting commands
> to SMMU.

Right

> AFAIK it is not safe to assign one of the ECMDQ to guest yet. I think there is no
> way you can associate a VMID with ECMDQ. So there is no plan to
> support ARM ECMDQ now.

Yep

> NVIDIA VCMDQ is a completely vendor specific one. Perhaps ARM may come
> up with an assignable CMDQ in future though.

Yes, it is easy to imagine an ECMDQ extension that provides the same HW
features that VCMDQ has in future. I hope ARM will develop one.

> > ... and all needs to be per-instance ....
> > ... libvirt  (or any other VMM orchestrator) will need to determine
> > compatibility for
> >      live migration. e.g., can one live migrate an accel=nv-vcmdq-based VM to
> > a host with
> >      accel=ecmdq support?  only nv-vcmdq?  what if there are version diffs of
> > nv-vcmdq over time?
> >      -- apologies, but I don't know the minute details of nv-vcmdq to
> > determine if that's unlikely or not.
> 
> Yes. This require more thought. But our first aim is get the basic smmuv3-accel
> support.

Yeah, there is no live migration support yet in the SMMU qmeu driver,
AFAIK?

When it gets done the supported options will have to be considered

Jason

