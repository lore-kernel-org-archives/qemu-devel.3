Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66DBE7717F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 00:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLAu4-0002Q6-0h; Tue, 10 Dec 2024 19:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tLAu0-0002Pi-PC; Tue, 10 Dec 2024 19:48:32 -0500
Received: from mail-bn8nam04on2062b.outbound.protection.outlook.com
 ([2a01:111:f403:2408::62b]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tLAtx-0000si-A8; Tue, 10 Dec 2024 19:48:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAfn+uWgjDZkEFfIFx+3HKO7q4P0u1j7z/0GO4gcmBf8GFzJ+8pDyaQyYjCQcOfOJhYFJhbFZYua+jUPPKbYlvHdo9V8i4RXyQ2yHNgu6WQpnZnLgWOtx+iZCVrILD8WiEGKcTJ50QXZQ3mEt14dfuH0ipy9CQ7SWSLYMbgPyTFUQeTNAccgZpmeDj+Zdy6VY54vuj8ziXJ1vuw/FdqdVN4Hdoux7wo28n6Djm4zTDDJmxnsmCAGUwKPX122EnA2C+/ZUbz6jzuYNnglQo7Lsp8dJdJ0l4sOB+SieTDKNkGgxgvkT4zSVy6d5R7Ute5vdxQCnMMGDLcgIHl++Y1c0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UR9DCmBKu92brchyypvqD1cE1zLnxyUOEqkQEuWODwE=;
 b=PE0cO7q1BoRiaLuq3mqr0JuuTG0mA7xzBzkDQiqNT3NWDF2rfW24Si7RxePGrh/jKelYOalAZqO4+VT3wGWyzyGI7GUfpKJiI7VZPbI2JP9d9YvGvnnnwoVFeNPPel+lTqJSws+iGbVj7ivFMWQRdM2/6rmXVIk0V8aYf5CQLtrbQsYfkPqG0qKW/ff0818biUDUEdndU3+vN0IsR114671QhReE4hTmIhtLMhig3cIShDQx1umWq1YdK7hp2v9rAFscX9WGjVenALSVzTagmgGAWlVRsrJp45QH82t8nP8TxHvM9UPL1/tGPs77uh1bYuZbcpGtCRDdXfiNsm2png==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UR9DCmBKu92brchyypvqD1cE1zLnxyUOEqkQEuWODwE=;
 b=cgLpKQ604PRB/rdIT5bzZ1hsWGAcFTkHDpt6OSY6SciNZ0eQ22S4BJjagwxirTh+c/bPCeKWdd7+3sDySp/eJ7zkKOJ/jFKDVSIydJ+xOhX9wWacnugM0V9F+dYPD962vAhZab9HbNwBBgvgKlb/w49yUU1Esj95nXj+y7RwQO1aVXeg01t3hrwMTPdBuZo4wtP4KZWQ8O2oPLpGKOwIm5w/TE4fd1gNSqcAX2bwftC46IO9EigW3HQV2xzalHIXsGhRNacPAmJZr96Q8U5WW8lROrj2rzYuqhUaqlNAUsW2YcDo8IadjTFp5L3QuiG7CpZOf7Zg1oiBQpoyYchq6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Wed, 11 Dec
 2024 00:48:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 00:48:22 +0000
Date: Tue, 10 Dec 2024 20:48:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: eric.auger@redhat.com, ddutile@redhat.com,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [RFC PATCH 5/5] hw/arm/virt-acpi-build: Add IORT RMR regions to
 handle MSI nested binding
Message-ID: <20241211004821.GM2347147@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-6-shameerali.kolothum.thodi@huawei.com>
 <Z1jIXHmFcBFIUeKn@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1jIXHmFcBFIUeKn@Asurada-Nvidia>
X-ClientProxiedBy: BN0PR04CA0163.namprd04.prod.outlook.com
 (2603:10b6:408:eb::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6f2ceb-f5c1-4ee0-b9d8-08dd197d834b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Odbh7CqNpjNRDFtjYvGq4Xtgf9cNGcAAqu4+oZVuQIJP1AUJ1JkdQ/B7hQMJ?=
 =?us-ascii?Q?JkLXHjw2lJxXEmxtFb5+Fgz3yVqK95aThkNgW0ZWSPhDTN17jhOsKsusSK+G?=
 =?us-ascii?Q?BL50TNmxS1RscXUhCkK3XvUXIAKJRrn59K4IDUIY8RsbGogIBnGr4v7DA7CP?=
 =?us-ascii?Q?xdyMS7GQJx4nLC4tJ8FEcEiukqOcW4YhmQYW6aAx+QaDQFdbrgwRUmQPFXHw?=
 =?us-ascii?Q?yR3yKbFl2pnjRtTM/aIpx49L015FRpgytYahlp8hTnlgezrIAVgPWCUCuyxA?=
 =?us-ascii?Q?A3cXzKSVN+ZOMTks9ZpnZkrS91hOKavkL6tIrFN1MyNN1EYZJ4zhb3RITLFz?=
 =?us-ascii?Q?F7w3ao5LM5T2fkWH3z66fHctDNPrcgA9IGV3P+rcsaHYffegcbaaHe0rdpLM?=
 =?us-ascii?Q?n/hXS7ISJgGJK+WHhdRLQ4iwuWqjfjD3fkUMY11XGr5KzSgqKuzYnhNDXMf3?=
 =?us-ascii?Q?5Hv7RZpIICHBOI26bV9hw8xjL7SuQUtKwPoxlwvjS/Jtvy2kn2IKBgP8fqs2?=
 =?us-ascii?Q?q07S6c2cxyofUxBO8XQbKmmyNfXAgWUZrF9Z+tyhwAiZ9XHKqgapbz4N6bUl?=
 =?us-ascii?Q?gY35GDL5d/JOYErpDYDOnndulYxDM5tMAeBfCnqZBy3Q8cXAiQ9zmyQQPBLh?=
 =?us-ascii?Q?qs+wH5Wbu4v0WU0ukS1eaxBDgBbG2ZwdjryIT6QMwiqR7n2geIpsa/48nKma?=
 =?us-ascii?Q?Rbyi6ySEZ+xOwo6R+9op5rvzd0EoEhSl+Iz9LhUbHvcP20cKY5B7Bb2yjZw8?=
 =?us-ascii?Q?B3jb+gbnAyd8Zj+1agDpu1pdud91p67APDpAea7Tk8YvN8rGOxcUb3sldU2q?=
 =?us-ascii?Q?72t3jxmcLEakuY8fi+p7CTMo284fKMCBajItm4wKUj6kxyfT5eZgmkLQfJj6?=
 =?us-ascii?Q?463ukB0w4ku9/hTIapPdoxT/PMzFiKnF2+I+IH/voQHoBlBjl1Ky44A83Wvf?=
 =?us-ascii?Q?nex9L6KwHrAkBZmTexpyY+R+99x24x8X1Dld7MMp2Zs2FMOBfCt83usKC9D7?=
 =?us-ascii?Q?7Nw5yV3P1+PCwDinuO7u+YPjnAYKUhwvwaQzhZBZfEgT09SS9VuLXHRUT0gW?=
 =?us-ascii?Q?MXHQwu3gRv6tCoWkLgP3V5m2DKziU1n6sXoT111k0mRtKg8cmcoTtZtkEoUS?=
 =?us-ascii?Q?5LCJlRVxnUAYgCkXQrN0d39ACn/H4bLOl9ElrdIUM3hTBVWOdkxvInAWi5ZA?=
 =?us-ascii?Q?BFZxrqLH9n0h37YLHLSuGAcl4XrPJE11BLCGhEVT8fT7r31Ldn8g9ZnUaE5i?=
 =?us-ascii?Q?mTtf+EXzXkxnaZ5oZ5OO4+lTZJpljYyUeLxnTYpM8MP6gtD7sWlndWnVvE6Y?=
 =?us-ascii?Q?AeKFbBt7iXwq8fxnQmGqIaerAlOHewSQ8/Ca5cbrWyEVsA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?88pJj+OlqFa1BMHVEgQKYP0of4lKMZ3t3LpCDUYAtXofFnq8UEK/GVoRGxcr?=
 =?us-ascii?Q?xGYycTu9Oo8JDmZX30rCq6dj15zra9KXWpNDgnKLrD1r0eGYVPVVo24eDrCu?=
 =?us-ascii?Q?9vzkMBF/uIDGt9DZOk+7eTy7FnHsITn8sobD2KNVwMRfAWSkhB8eqhBoWkvS?=
 =?us-ascii?Q?bPgmNCQbIElZDzvPkxNmZJiXL79ny66HBxACqIKzv7MHiWU3tx64c6atRlH2?=
 =?us-ascii?Q?jE+4uDVkn6DJ70hfg0JzZDiRxKQlxcs0WL01m7k8FJIwSJ+bzldPssG0qvLF?=
 =?us-ascii?Q?XsAUd1cioSV12IoN/JRVvPfKX2sXxhJRgDIKrhL7si2+xiOhiIxTaWrgEcaR?=
 =?us-ascii?Q?KHxc9BmPb2opBy6ZyXO82mdC9u5KT664r6+AYVqHqfFLYLvif+oDfThxbI3u?=
 =?us-ascii?Q?ZHu64zh0/aavxE/fHshnyxoQS85bkcj0f5a5QUO0oFwiXpZB2NuHp61o5C7X?=
 =?us-ascii?Q?s/7h3ezLp+mGfz8/CjQUDznbtmu6P1WbJCVEiGyCmEaFpIj2BmJZAutunoDx?=
 =?us-ascii?Q?hW0uhhr89UpFqty9A0kgNrG+Ku/tXgR419LVE23Xh86kM4oiUS/L3wJd3DFm?=
 =?us-ascii?Q?8wgcZy1RGrtW09Fdl22jK8NXltbCCbLH5ufgsOj+7ZGim6n9kk/UFFjeXdG3?=
 =?us-ascii?Q?nOij/8CtI7LbYO1cUblKx17a7nl3/PaHRsB8Z5va3Yo8VkWmHkQX/SGMvKdO?=
 =?us-ascii?Q?pwJ8Fm8zVTBcwly3AJNTdRrUgAqkfhMzgrmSTrUPpkjFfyLOhRZN3KWV1dtk?=
 =?us-ascii?Q?Nq/Z87FIFvqx+s+ACidx1C4ViS67eV6VhW9NiH11Mc8JnzC3sAHdJcMQyHYv?=
 =?us-ascii?Q?5P0Uq/2Kt6AK3gYFMh1fOMMO5OYCE3PtqWesSrK8v8F7biKdBxjy+E8bZplM?=
 =?us-ascii?Q?HlumF6G3EENHfVYKXNCyH9z9wwj8DRhJaSzG9J0cPefEL9kB9lhZT+TDZ8/i?=
 =?us-ascii?Q?t3EtVGp8EbyJOVjQqbEe4V/n6qqFo/126VkTKbc/rdWbFGzo025StrYanZ82?=
 =?us-ascii?Q?nukMUbn4dHbvWrayB8+HcmCAH4MiEcgdtZw+U7B3N7w9ifZkYTgMR+vbPwst?=
 =?us-ascii?Q?XloaC3jUK3gKyyXLkzVnAszCirKzR26ugNjBzLaXoJD5J64eOzLOSkw2mlb9?=
 =?us-ascii?Q?JHrNpgL8p0doGLp1ABdfgi0wXDt+qy4V3JZycudoPm4gFDYYydSC9TGXD7Mq?=
 =?us-ascii?Q?tTWbwGZR/zZiXIxud/kgAM+D9W0uoGD5idYYtYZvZpE5upZGJ0I+sCY8mxBy?=
 =?us-ascii?Q?b7MA2Jg1FQNF9y9NMNK9Sn+vTC1Gs5JgC9Ijq9qpvl2LW5hRn7RwKjqQgBM2?=
 =?us-ascii?Q?DKXakCvaKFBuRKXeJTEmZF1eUorLo0M19FGN8Mqm6lMlfZ7pvpeK2YzuLLRa?=
 =?us-ascii?Q?BHYvHMb/AylzZ1ANZ0+kL/EcEhZSBHzki5DxoCVzVBlZuBQhMWKbnok+lss+?=
 =?us-ascii?Q?mRO/iqF4EZDf6BQGUC4v23OpAkdVV5SaRm6/8Bidme1jlpRWcMU0u5BviKJN?=
 =?us-ascii?Q?4oYxe3i8EiJ17XhT5gZ5ZR7tSpQzL0Ui71n9nR+/1NX/OyAKSSGEh7bm1NeG?=
 =?us-ascii?Q?KXh332x5esvKnoR3nCbneXivUARxRlTtgOL8TTH9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6f2ceb-f5c1-4ee0-b9d8-08dd197d834b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 00:48:22.2775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Uox1aKJls5wcLnTtrGEPnOOLcVkQYYkGVQSvfeJe6Sk06TxRPDfp17RzqtkqZK2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
Received-SPF: softfail client-ip=2a01:111:f403:2408::62b;
 envelope-from=jgg@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

On Tue, Dec 10, 2024 at 03:01:48PM -0800, Nicolin Chen wrote:

> Yet, here we seem to be missing a pathway between VMM and kernel
> to agree on the MSI window decided by the kernel, as this patch
> does the hard coding for a [0x8000000, 0x8100000) range.

I would ideally turn it around and provide that range information to
the kernel and totally ignore the SW_MSI reserved region once
userspace provides it.

The SW_MSI range then becomes something just used "by default".

Haven't thought about exactly which ioctl could do
this.. SET_OPTION(SW_MSI) on the idevice perhaps?

It seems pretty simple to do?

We will eventually need a way for userspace to disable SW_MSI entirely
anyhow.

> I have been going through the structures between QEMU's SMMU code
> and virt/virt-acpi-build code, yet having a hard time to figure
> out a way to forward the MSI window from the SMMU code to IORT,
> especially after this series changes the "smmu" instance creation
> from virt code to "-device" string. Any thought?

You probably have to solve this eventually because when the kernel
supports a non-RMR path the IORT code will need to not create the RMR
too.

Using RMR, or not, and the address to put the SW_MSI, is probably part
of the global machine configuration in qemu.

Jason

