Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A471CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 12:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMPii-0000hI-Qx; Mon, 11 May 2026 08:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1wMPif-0000gS-2h; Mon, 11 May 2026 08:26:45 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1wMPid-0007hD-9i; Mon, 11 May 2026 08:26:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ie0X7Myug3X5tcjHYu1pYBNmFvz81M2Rw0fJD0nlWP9chTdoVtKjmP96X5rQq9snOetSNPlLoqkbC077H6zBrGvVXI8WVhIisjiOVHx9krokdNQ1m5nxFkRfZGiFfR1oT/PFPW+QrYEezpERNghh4t1MGvgrD2tN7EZ64CXFLJUkxmBLZjYodPKgRSL+9Lw2IJg0VzqUhkAXat9GW9r5v3QwqDp62xvKPhwpuLnkynnNEZn0LPa0jY6n70uOlnNJmNGmfzY2jPoob2SLohViZPiTz7DVcsxsz4o5neAvHyYmxCdtZFQ6cB7OfIxoEioMuRlcUw2isT/KwSFOK6e5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA/jkjZnVeGieOwbv1xK8l9yaXzX6+CFCPukrgb5VqU=;
 b=VSAJ+xgXYzi4LSI8HF9s0rCqtRkTQ53ndiQc575eOH0TOM2wdCUeS1hRnjptoCL7277Lu9On64O7kQhaHGmJEZIEHocQEleExBqCKXqBXbypvTdOGe5N/Cyf4AN4FAfzOqCuipxgteT6aZ+U0+LA0t2B7MXtWC/DmSvu60KZ38cOl+ZyypeZ6dotx9CCTLrACIH+YBAN6DbtKyOfreIidYbQNG10eQMYV50ep7jxFa9nSK3/od5M/MW3CRh7+/ymdf/ldbfykelLlo/m3kggZDH4z/meyF9ZKZ+cHAJmZ2qj+ovTTqmWbfQ40VTnRLKGvRGtdSJqb1e38ILFwJjwmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA/jkjZnVeGieOwbv1xK8l9yaXzX6+CFCPukrgb5VqU=;
 b=FDJsLqzxdmg7+mjesLC97koaJ/LRaUDgnF7qMKu46o5r5qqvtZoJX+MvUfQ9xLwqgTS3/ujDpvZBBDbkzm0x+rH6tZTHVXvIOrBeLfozaOJEzL/si/bjDFW/wlyv7KZX3L0Oc7J/ZsuSUvPc9WWgNgzA0iPMUCIDbUwNKYw0xSwZ+olOIHHL315GR+B0AxZeF/HkgNku1lgws2rmukEXi8cZSsaND4o4tn2cFd0V/EKgSRfu03+2THtjfYWL/z8Kv3/873fHe7F8K0fqapKwOxH7ER0XIl9P32F7Rp5mhBicNTItJuGm/t7e+jwHYOgwsqkMrSY6pRsAGrvP9hFdIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 12:26:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 12:26:34 +0000
Date: Mon, 11 May 2026 09:26:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Tushar Dave <tdave@nvidia.com>, qemu-devel@nongnu.org,
 alwilliamson@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 devel@edk2.groups.io
Subject: Re: [RFC PATCH 0/8] hw/arm/virt, hw/pci: PCI pre-enumeration and
 fixed BAR allocation
Message-ID: <20260511122633.GE1116784@nvidia.com>
References: <20260508183717.193630-1-tdave@nvidia.com>
 <CAFEAcA9KxUF6c555Q_Kqn_NVE3z1ojr91+KuatYudj_T4GjbxA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9KxUF6c555Q_Kqn_NVE3z1ojr91+KuatYudj_T4GjbxA@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ebf6dc-d4f7-45bb-8abd-08deaf5889fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: K5P0y8R9MoGSEJdTKhO454xR0OwcCRsrMk/czmh7rzPDbJlFwcSfdXR1QgNXXbNQQhg7BZraTiSDDwR22hgAo71NyV5vcsEwe3cTBCH5FilkxQU1JKi/gEf+Lp+mhA6j8rmBWAzVNppeQGvse9iHFOKfr7UBM3cYC1kjWrXJRRBdduGIb1xKPTzhV/jXiHCIaSP2XS2QugCFZOGAcHXCeeqy7rSWOWlyv0zqLV9iRcRkOWesmZbcE06gMqPWdX0KqC4MKTpj4EWHWOYMbdXe/q6yXb8mB+8QeL9PNZwVwrEAWnwWDQjWMshfnm62AgpsPXIukejLbJfUR7OnHMNYx40sEz1ZfzlzkSeMV87vp1R/owX759YX/lw2U8uc+bmbBhadLJupxyCsFGAnmiekSpTcj+W1zfqhDQyVL0reBTv2xpkOzSvrZ+l9xX07+CqSkNBVdVnNHEJH1k+rC1Mw+mp69cfl03vppTqvvFoA/M+8O/7DKV24g56E6V2q9b1eONTsUZrBak2TewA/EuI/4AufDy8lsIEM72dC/0S+VxY8N8K/O2kZdUKTqVsisSYdLG0TRCn+170eiaIlmbxF+20MFSXL6portxg3RRt6OaHWKP9w0kTHNtyZYMtH2GmWd++2G1PZtMUwHF4k25lJskyKDKiZHj69vfJLLLdu9VlqDeswIBh+JGQaGR7O1nrf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TnLiwulyeKlPkpOSeTBiNPI6W6O6eQLiET/hw1C+WExJ87wiBxXTDH086dyR?=
 =?us-ascii?Q?NXAfRkGPjv5SCLVaF5dlTbdFwrYB9F0K43iAgnNhHAGpkeCs0lIEezpCueN4?=
 =?us-ascii?Q?z5QN7DYmzP6JGNB/GnHlypX6Yr8VoNCWxr+BrvM2CVLjAW0Tktb7ofnOw6iT?=
 =?us-ascii?Q?PU2uROrhDoXMK3hSNsbzv2+VcCtm577FOpd82K//mWsRah6t8fHK0pzZXh8c?=
 =?us-ascii?Q?tGHYGpRviYZzho8AiZ0Pi25ZFoS8PZD2SpReo1Udlis8lTeYK8m3joH2KBcu?=
 =?us-ascii?Q?Dfph+zUuSRzAQFA2LV2IYBH3+QM5rJAcI4R7n2TptvXmseKMG+cCbV/L+0Cv?=
 =?us-ascii?Q?qQTPyKd4sc54XZWI0FEU7Y5PFx5dV06xb85g9cUAwQtqWEthq5SWYegJ2P9M?=
 =?us-ascii?Q?nehqljWMuDqAXWTgP8Z6hPsODk5ahIa+onPQ7+9wjXxkQhrOBBdr/n8EmpOS?=
 =?us-ascii?Q?ITQw6GH62fqvyXiIsmGQSmSHZ/KbjMVQAmeVqCvuqoVTvVvsdvaSWulmhLgH?=
 =?us-ascii?Q?3L/8H+fdWoGX/OMndep8og0wFG5jNCqRvJI6j7cBkS9zazAiovNBkf7YF+8i?=
 =?us-ascii?Q?2leAIF5tZd9uqnHg6ICXAcHw18rOVNOuIaCR8BxXFhHz4ic+oXzJEDbSwO/O?=
 =?us-ascii?Q?eVYadFkY0vw7UOPxTj50Cy1yPIQdGR6eRKVWAxbbKR7Bzwk1t3IPr6llW/Rn?=
 =?us-ascii?Q?N5tUDYpIqkIAIme8wIUlkOX2RVaEvDNtQ9HbjdyNvUjq70JPLaHMqEXSY4Sk?=
 =?us-ascii?Q?qilUFmt2IoNN88p9layCnnKUfPmG54rRk9li8iauiquUFI/8HeM7FNkfwFHL?=
 =?us-ascii?Q?/5EVWRuyvCW9HZxkoS5t+kEJmLV+eAO89Jp/i9CustzQHAZY+V6EZRf2Y0We?=
 =?us-ascii?Q?li40ALSU8mlCmc/ZXnbK+Hgt+eYJcwtLpgp/pthgRqV6jVfYnvPdmsfMicuj?=
 =?us-ascii?Q?tdOl262f9/Q3ICa2zy6wsF6nhQXf6WiRSyT1SFZ+U7io78WmZ+YgD24NTMGi?=
 =?us-ascii?Q?F6/b86ahwlQzGtRQjsvtQqnFYEGY6p04C2Q/UEW5pvQ74EzGfJLBsZEtHbA3?=
 =?us-ascii?Q?aUuz9prvxzwCVkBHH2tvcDZHflENYLBTPyQvR7xquwuOumkLoUupHNAIpIS7?=
 =?us-ascii?Q?rsDiVYdQN2TqFvxWMlRYqan2dChyT+I7+EW2kIaC+cvXetGZNFtQBhuqBhQb?=
 =?us-ascii?Q?tLRYYfw1xH6fvExMji7kU7TZJGgzeYSplPwXJCIWvLEIAMogfA8a0cymfm+G?=
 =?us-ascii?Q?shLPb+yVhh4SgiBb82oJoGD53tXHyQAPKCWdoA6h/Ijc5e1vWO8w9qKWq+vT?=
 =?us-ascii?Q?FGxaHXrlKQr2Y9Bj7FUEOk4w/Mzp249Dn8Bjpp4u438UlB1aL6LY9K18Epos?=
 =?us-ascii?Q?fpVHkODVfQSjp4zcYGUFoLcn8zfKf4eAZxLM8XlP6YTiFBYx+vyGdB+MynL0?=
 =?us-ascii?Q?B/nv7UKN7vukW+o8lfgWzhTC7cht7HLuA8fTQctbaV5NfIuKPFJpjlgPPYfs?=
 =?us-ascii?Q?8kLlvvUzDBvbP7/76G/3R/X5P/I5kxw41E1enKs0o4FSiA4TehViEDAx1dco?=
 =?us-ascii?Q?RIVD7tHXoAH5dEg5FspKAkvs/5p3rKjDqQFnS+QlWWi/rZpG4Tf5h9ZeREy6?=
 =?us-ascii?Q?p9mG4HhpRoPUweQMFJMYWITWBf8zA10FZVRomKiLCNJZoPKEemZjdh/hxzhp?=
 =?us-ascii?Q?ZVCOSio3/I+RtC/bmD06iBQB9k2aJmzveONuEnsrKOeg8i0m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ebf6dc-d4f7-45bb-8abd-08deaf5889fd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:26:34.1980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXpZJ1m+O2SN4XOV7fnG6OwYMBBYv5h6s9Yr4tzwCUrp07offbEPa/SdBErsAcgA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=jgg@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 11, 2026 at 08:46:57AM +0100, Peter Maydell wrote:
> On Fri, 8 May 2026 at 19:37, Tushar Dave <tdave@nvidia.com> wrote:
> >
> > This RFC introduces a mechanism to specify Guest Physical Addresses
> > (GPAs) for PCI BARs, allowing explicit placement of guest MMIO BAR
> > addresses to match host physical addresses for assigned devices.
> >
> > On some platforms, P2P DMA is performed between devices within the same
> > IOMMU group. The PCI fabric ACS is configured to permit direct P2P
> > without going through the host bridge in order to achieve the required
> > performance.
> >
> > To support this multi-device IOMMU group P2P scenario in virtualization,
> > the VM may need to use the same MMIO BAR addresses as the host physical
> > address layout.
> 
> This feels like something's wrong in the design. A VM doesn't
> necessarily have the same memory layout as the host: the
> VM hardware is all about making that possible.

The HW running these systems is unfortunately limited and doesn't have
ATS support. Without the right HW features the physical PCI topology
is leaked into the VM and there is no choice but to have the VM guest
physical and true physical match, otherwise the VM can't work.

There is no other way to support these VM shapes on this HW.

Newer CPUs in this family have more HW features and won't need to do
these things.

Jason

