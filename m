Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1050E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 18:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLR1Z-0005ne-DU; Wed, 11 Dec 2024 13:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tLR1V-0005mV-OS; Wed, 11 Dec 2024 13:01:22 -0500
Received: from mail-bn7nam10on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2009::624]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tLR1R-0004n9-J2; Wed, 11 Dec 2024 13:01:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuLfPxEUFmzXP/37c0K75repNjlMJWtw8MVwer3sty74NaQdmPYt04ECo/l12LJTYbdgivxp225rczhIoQxfolwNgCiMT6g2X2iUN8X3fHvz/KPNyPP4uo9QhM7I+cEtGvrXLX2KAKkOg7XWxZEELuNMqbLUWhWhDzVi5yjglfQQAoaXWmKdW8ZZBm4SD96pK0G59dREw0hXSLaAGJNBFmhLeZiNLBBLEEwqeYdJH71QZaMql/WZqfQrq1cNVBflYosHgBwyRItOu9EciIcZ9n0gKE+cSuYav93kUElqiRyCfDIf5nctl0XPcVtmJPOGUerzziCCRxV7hRt+l3Etzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVHsGdHVeuSjkexTKVTx0T5w5Mem6zy9WMEuIyWEfSY=;
 b=W+S10NRhHEFvPxAHY++FTgF65r9MtvSxZMZA9JuX0KhZV3KIWBWje88o4facP9hIvQfmT+moei6yZHbl9/kK+xdrnGogEkROoj6zElqYkB0yXjwuFrOZPr99+vxKkRCBH+y91zRfPa7N6xakDbIwySkEd0Joi7whbGRJRII8HlGYWvtmvylg8uvq6WNXD247v/c0MwICXDlc4HMS4wUr7jg7KGubkt1iZMkdYgxQvPzVA2XoW888SExl6gTx2ANr9s2ZM4Vvi79z+5QXdvrKnLTb8hj9vZH7oXIQBw/g90/Gg8uylcCKgkwtCb+at5E/xlc91JTnGNoa0EiM1ukkgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVHsGdHVeuSjkexTKVTx0T5w5Mem6zy9WMEuIyWEfSY=;
 b=pqSDOZYXjtnz8Q5+BHD//b/PPkjet+OuO+SmYZO0Di6Lx28cAOk+T2/AGCA2yms0zvUU+bQUq4f8F2QS0hekjcgU7R9JOyZOfOG/TIzWZhUimIQ5Jq1X5Mb4Ey9bgltoRy3/9pQSCLnPtBRrtRPRaH+ux0KxvJCZxwwDuvj1/kmxKjynDOP4gslOfWjParkrH/X7WR+1CusQ3/IyDfCzcxn4tfu+3DS/E8xvTFsvJY3u2/ZeutmjTKuOBb4sG06Cs3dO8m8vHgUNmL/sEt+CP74/jyHBAS5SLbHM7ch61U0FvYqEfAzS9FQNjpodbhR/EcmWSfVpjolSv/IqKwZSGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.22; Wed, 11 Dec
 2024 18:01:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 18:01:10 +0000
Date: Wed, 11 Dec 2024 14:01:09 -0400
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
Message-ID: <20241211180109.GO2347147@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-6-shameerali.kolothum.thodi@huawei.com>
 <Z1jIXHmFcBFIUeKn@Asurada-Nvidia>
 <20241211004821.GM2347147@nvidia.com>
 <Z1jqsVTiMwW/Zk5z@Asurada-Nvidia>
 <20241211131112.GN2347147@nvidia.com>
 <Z1nJ1HYxnCdsEKng@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1nJ1HYxnCdsEKng@Asurada-Nvidia>
X-ClientProxiedBy: MN0PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:208:530::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 31672a01-1ff3-4853-b787-08dd1a0dcb4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PNNh2DawRVmyYH59MyvMW+oleiaMlTU6gb4FTXmowr8PGCqMmgtp9YOGjWGN?=
 =?us-ascii?Q?bcLZ6ajT1U9/lTU6zZvjYeRXH4RC11n9ajPIidOEfvylMs9im9Q9j3LEnEza?=
 =?us-ascii?Q?MuOeafec3njf+OHnqsveTOpbIE6AKI9FFMFobXlukF42V0e7X1+ZNyYZLNh8?=
 =?us-ascii?Q?JTFUOgn4XMfQXDsek/q1DJTu4sARnok6+IIdcWnuMCbl/scQvMLihDgl9etn?=
 =?us-ascii?Q?vdbsT10xEicQPFEKaFGENb8OQQQpGGCwuCTqFKIvz2HDRaFyw0M07Fo7bROY?=
 =?us-ascii?Q?wLeisLi+snVy0SoSh52EL41zDeGXC81iEU31t36dOZSbd2Vy+wo6FCNNoDEO?=
 =?us-ascii?Q?0P2GkWwiMUjfSC3fXLHfOYztalHplWh8eHTSfon6aqir5HPX/0AyelVMYtK6?=
 =?us-ascii?Q?as4vfXGNiBTReyPMwClNam1YEh9kZRapIX5smSCBo59UhR5gKxDgO/UA1ABC?=
 =?us-ascii?Q?egxe+N8gF9A15PTajOwHRsLnMh0bHRWNubORutxyJQ3+A3qySRnTFFjgHy1a?=
 =?us-ascii?Q?E+ffw1CY3WYfIGptiHsTaUd1Updvd6pkY/YR1FMG426mccS0K0DRbihJQvPD?=
 =?us-ascii?Q?hWBLvIRsRG3dcfgDU0L32WM1yPbuLsnWhxeza01DNALZrmqkdgjXwWNIEqU+?=
 =?us-ascii?Q?QO9mB2Vu5ztE/22zHtLJxu0iWicaKMzuM5ug4DgJbDnm5eZiskZ5sBWdP6so?=
 =?us-ascii?Q?ghgHYgXJxxg/1VpQtO5etieo/k/ihWC5tqMz+gSoX9S4CnzPavynOJdi4bDj?=
 =?us-ascii?Q?b4lxyoy18dhDthrwgVScAw5BycV1mFValuIUDWGxvJ6wqSKI2f3qtB+mSEuA?=
 =?us-ascii?Q?oFpbwG8Wak+mPqMoCQqI64iS+MVA4sZ4Mdg1bVkqsstFSXCkK08fKGU1WVHn?=
 =?us-ascii?Q?rnvolqiLbLLT2BS6D6hwJI8mo1io7Oo22RlNKUx6zV11LhmNOnJmBjmDrMP4?=
 =?us-ascii?Q?IYt+ir8T5KJ9xtB6Gzc3VCkMvKnyxHE92HNq1FQASfa2ctbozYMt0YY8aaV9?=
 =?us-ascii?Q?YBs6pj5jjcOW/bKNfDQniREIulePFJ1rwhTpnyP9ebslO5rTcMPxD3TCBsM/?=
 =?us-ascii?Q?GwZlBCWcgl7Qjs/Viz+UO7sp9LDBMRxFDX60EGfb/wg/oEgUshd4r8qlz+0C?=
 =?us-ascii?Q?82pxxdrU3cfmBL4nVmv8aXMBxWJ8baRwORPM1SNNUakCYPovwKfEqH4IVofv?=
 =?us-ascii?Q?vWMa3PmKB5qX+jLysGye9YFgaqBqx0L1fkBPwiv/9LCm4dnH6zo/+F+kdC7o?=
 =?us-ascii?Q?Vd5REdGS+phnrhiG0zHoJQl6+RVl+svKW1xUSL0uniYvLZfjWARpINcKZi+P?=
 =?us-ascii?Q?vbDxHxzqAHsVfmsqcCcNkdGE/oZSYYlEOPrjpH7c8dOfDg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?THsZ0VFmvlyuI9rxBVeI9bwW6Wxbubsv4JmQ10WCAoytzMZtmbcPEFsHt3jB?=
 =?us-ascii?Q?aLkhqeFPBekFmt5dBpHblUxRh754O1EskgByN6c5P49eHo3YFwAhsS7RQkO6?=
 =?us-ascii?Q?S8/DcB0skp/9qcj3mCrJysSsaJeZdonN2Kp8KuGF7zPnnD2EFVWVq7mEmR0P?=
 =?us-ascii?Q?TghODID6eWAJIkOcJq/E3nwN9AzVgPQ/VG6hCWnFL7MEtCfqpwiGUHyFC4EE?=
 =?us-ascii?Q?qU5kE238aAmLC/6BKeA1LX7CaPHt9HTQWJN/nmqKRCCcH1PctSeySX82PEGY?=
 =?us-ascii?Q?O3gFhER4YX+QpZiMUSW/oW4t1tR3pTX6gwEskqbSCnbQvG9tRhDR5HSjnPH1?=
 =?us-ascii?Q?leJrkxYHTdrlMLoxtbWrPAVCMrNRxS/zJUqVMqI9fbJuavpSCqD+xNQOOlEL?=
 =?us-ascii?Q?JNihTEAUKDtREy1aauHa2kxZJ0x6fhKnO74zmRtJ0W4JlRKyDK/rpGCpoifp?=
 =?us-ascii?Q?wYEXoSXN9jy+OBhuOdhS1mGsnhtvHnCOhJkCodN2d3galdS8cr/GcBLVn9Ti?=
 =?us-ascii?Q?BNPwN+3/j5uQfxZObWB02R/VtIJKm36GqdFnEh18i8jzJl0/nNVIz76imear?=
 =?us-ascii?Q?UMmaqHdGm5E+iC9RdivisKq2MhoOx8CDkMJkZsxThHs64Axm+X99klxznnCY?=
 =?us-ascii?Q?24czV4BUjOAX1PTmzeuKiNIPglc6F5iSNj6UhaZXAB+nqup4k7fxi0HOfmnS?=
 =?us-ascii?Q?lcVK/F2ryjz8w93XOlNRqXfoKige5zd+uGcnaQ7rB4p4YJGFRGTUzfGq6aMT?=
 =?us-ascii?Q?S1zizypv5SegsFD3kToxKHFz5mtf8RHfojQlc9wLc0YU0E3LswEB8XOEJrqo?=
 =?us-ascii?Q?AjFbHDGbjH+bd2CBzunsdIgTlGgOYk5VzZ61T3D7Hgkwrc2S72qpze6HzE/X?=
 =?us-ascii?Q?AC0Fmx2ycKlZEIvKL9CYPpM3txl1c5kNROCm7QcYI1YrdcTtFxT6pmQY0ZdX?=
 =?us-ascii?Q?EuMG6yK9LJ0AVliF2R3Kx3B4Nb2RjIRrpcdOb7OJHcB0jofm9EBUBkWy32Fj?=
 =?us-ascii?Q?rnzsDSuA9FOaXIsBWfqaYAYuP1bnc47Hgh4VvymDwPPgyAadiNg2/Hkj6i3r?=
 =?us-ascii?Q?SKWXcM4Yq5qfgKOddbLu8DgKa6rL0SAxtOeejDueRPCElyhOGKp1xtsOw8wM?=
 =?us-ascii?Q?qb4Ppk/JbhVljpNx91UkkvR0sKZNGDQz/h6/Xvna+eaD/dAQ1LpkPlAS30Dp?=
 =?us-ascii?Q?9XwTxmNPlv9UBA5AG9h0vSPXfpftXZ2MCjlORLm9OSWQ9RIOUd6bZgkCHyqB?=
 =?us-ascii?Q?Lqz23NnvHyJF8OzsltkbHHhwtt6k0VBsgp5WapW8k7M3tWNVaMR9pIeseRLi?=
 =?us-ascii?Q?koQXcy9PGwfn+3T1j5DR9HvnK36cX+mUO1KfXOSnrTCKytP1OlWu0ZRmJx2T?=
 =?us-ascii?Q?nLdlV+/u4L6P9vdCubOLgbDInlv5sqx+pcSJRkLLDvXa5wlERKNXh4I5PYpL?=
 =?us-ascii?Q?8yNqKKG7wP94DKt7KdFNzWu7uNTP7wsS0IehKjpoxbFD4st1PDkUbNzpybPt?=
 =?us-ascii?Q?D2w8JvTuUpVCPsrdTlgr+64WgspdMRnYoKB1ig5+C6lRYE7nS/gj8aWB3D7e?=
 =?us-ascii?Q?s1hFdeb6lcITfDv0yVcT7QT8bdBmzKGAVnLzBfQL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31672a01-1ff3-4853-b787-08dd1a0dcb4c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 18:01:10.5683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+vuqK+nSH3cfOJnQfofQuS343q7er5oPfThp5wImfgifVXYiAg7xw5rosmGjza0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880
Received-SPF: softfail client-ip=2a01:111:f403:2009::624;
 envelope-from=jgg@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

On Wed, Dec 11, 2024 at 09:20:20AM -0800, Nicolin Chen wrote:
> On Wed, Dec 11, 2024 at 09:11:12AM -0400, Jason Gunthorpe wrote:
> > On Tue, Dec 10, 2024 at 05:28:17PM -0800, Nicolin Chen wrote:
> > > > I would ideally turn it around and provide that range information to
> > > > the kernel and totally ignore the SW_MSI reserved region once
> > > > userspace provides it.
> > > 
> > > Hmm.. that sounds like a uAPI for vITS range..but yes..
> > 
> > It controls the window that the kernel uses to dynamically map the ITS
> > pages.
> 
> Can we use SET_OPTION for vITS mapping (non-RMR solution) too? 

There are two parts to the vITS flow:

 1) mapping the phsical ITS page - I expect this to go through
    IOMMUFD_CMD_IOAS_MAP_FILE
 2) Conveying the MSI addr per-irq - this doesn't feel like set_option
    is quite the right fit since it is an array of msis

> 
> > > So, VMM can GET_OPTION(SW_MSI) for msi_base to extract the
> > > info from kernel. Likely need a second call for its length?
> > > Since IOMMU_OPTION only supports one val64 input or output.
> > 
> > No, just forget about the kernel's SW_MSI region. The VMM uses this
> > API and overrides it and iommufd completely ignores SW_MSI.
> > 
> > There is nothing special about the range hard coded into the smmu
> > driver.
> 
> OK. We will have SET_OPTION(IOMMU_OPTION_SW_MSI_START) and
> SET_OPTION(IOMMU_OPTION_SW_MSI_LAST).

Maybe length, but yes

> I think we will need some validation to the range too, although
> iommufd doesn't have the information about the underlying ITS
> driver: what if user space sets range to a page size, while the
> ITS driver requires multiple pages?

Ideally the kernel would detect and fail IRQ setup in these cases.

I suggest enforcing a minimal range of something XXM big at least,
then it won't happen.

Jason

