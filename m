Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9800FC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraak-0002VF-Kr; Wed, 05 Aug 2026 08:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1wraaQ-0002UV-F8; Wed, 05 Aug 2026 08:19:06 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1wraaO-0002Gl-Qj; Wed, 05 Aug 2026 08:19:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrFADuZNwEte5q18wUp4kzI/D/BJzk+8Ck0iOIFnGSjvvzJ3xFaY4y+JdF9r3nHC2jLmdvyDddvHBydrBoAvG7lfdmq5jOzes7S/grTNJxeEM8Gaxcf5C5K0j8HZQ8ALVqIB+z1k6tRJ3noaWQKgjDDYmUR6fhmJNNk7IzXiZYjVsT/KLfuA1RHY3zvre/MLXBN4WVNOjkVVkq8ev1sxEppxuQEVZQdfQ3ur0W+ubqlV/oAt1mNtgnz69UfUzboTUcpiOWcYl37oiaq9aOjLCxNOkCg/F9RBuv4tM84FuSv+CI9n/j1voQltuudKqNKWJJY23SHBANaxKmYAu7NEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS2wnso62R2aKl0jGfRjBNM7mc1S6+9mvulWXM+NFpI=;
 b=GOKXO4R9IhpDl2ljB5ZJT3gCAxcJG5z6r02FBkTrnpPrpOHGwHMeUIpsvaqVbKUc+fq7IAez/nsSLX+KREFKKTOL30OHnc7+NJF5WXGRFgungeGRbTJu5b3pG3nTnYELLqYml59s8Q5cLyXxswyxT50wYjKLuq/3CfJ14Flmnc0r0bxnAMWz4h/a54jbjUwrLCG18R9yU856BzPTrzKRnF8e+qSZo5XpZUp/WmKfDX32Jw6h2EK9RCDcZEag0pzsPDcFdTBmcXA3lk9Fl1Tu4ExM5Tm/6xBFju66vYI8NsKY6F5GS+pPi/u+BvvFG3FEvYRBuVv4RszCXHJQwGjrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS2wnso62R2aKl0jGfRjBNM7mc1S6+9mvulWXM+NFpI=;
 b=lOSk2u8bxfMNf9KXtTeJfWNSdJLe4LPERP5H9aOMVXJGNrnvcvrsMuDTBnrEv6ap1tLPAhgEszMJ3hXyWdbPf5UK0xU97imjH4M5KEijMOP90WBd5HFfOpZF/F0lGAuWmUVSCtBLU0c8gjJwDLVtlQnxDEpEBu7r+2IoHwJssOI0OOhtEEkLGyLiQ8gJAWgwG3OznzgqNjRimerNMZMA+4ruJI3WVU5FBPfydruGR5tg9Wumj4dW04KszxACoQSi3RXn/lpOtpt/9o2P5lB5wWppKFXKezNVfn4C+KODPznkBodJyxYlhIKpHJf6m9t57s7WNo+EVR9evs9fPjElZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB7175.namprd12.prod.outlook.com (2603:10b6:806:2b2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 12:18:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.015; Wed, 5 Aug 2026
 12:18:54 +0000
Date: Wed, 5 Aug 2026 09:18:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: Gavin Shan <gshan@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>,
 "meshetty@redhat.com" <meshetty@redhat.com>
Subject: Re: [PATCH v4 3/3] hw/vfio/region: Create dmabuf for PCI BAR per
 region
Message-ID: <20260805121852.GN27883@nvidia.com>
References: <20260121114111.34045-1-skolothumtho@nvidia.com>
 <20260121114111.34045-4-skolothumtho@nvidia.com>
 <aa45597c-aed8-49a0-b9bd-3c637c154ee5@redhat.com>
 <SJ0PR12MB86148329F85C2A4A22D0C67FABD32@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR12MB86148329F85C2A4A22D0C67FABD32@SJ0PR12MB8614.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT4P288CA0082.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: d7312406-32aa-46ea-116f-08def2ebb73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2yYNRxbkzxGRvbo9rSiez0chGAj93ufWiHGI/sVx+XHEi/GAr9rW4JKnK/cTY+4lcwzgoAZFNSWKyomvzEngipOOf2TCPbHpza5i7kELJT2UBanVmHJDXIfcuHU5BsSSeY5nyBrC4eMIOJ2fYjkNiPjYiB7KaSe/mDCXq1qEqmB7Nf0LgIBuqlk4zbxPwwNqSeNwfyMphWUCBaWSoYErxTjl3zazArgfNrSc7yWfVYytYz4iBFznjXk2GmSvfsRwWZ59C+8EaAflr39lAMbqtAEWwKuAulR7HIzf5yUeCZt0YWyJVPF8keQ6KvP4tuNx0c4JmdsrPLyhDuYIo/4DdPuiYMknRr22FC5MMzGuRgyyPCj+8fO7Oz2H+UBD9W1w5FfwEXo5Fp1XzRpDBhuzXdvuEvWiGk9BL5gc1xwImuW5GRqRcKfiBEayxp0xOzlKcLDgvUA0c+zq03lJsDA2kXSaH7qjni0bb/JFrj19Hes5gWI77x/4FXw0RdbWIJ8jFc8M/KK7eOtJAvOlx/cKyi8NJ7T6bKE8Zr/A7ajix+3TtdHzXKR5tEeuh7F1rwys801uSw1L1KJUaeUCnaaNcuHMJW+suFnhthpVFt+SBUJKmO0KOEYWhyjZi0pVH0AAzdNVsdPRM1eLoudAuYXVO9kcTbferbv2kXB3HZA+H0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vGtqBNkncHAf4EKWlTm3/j6K2blXi7zZfpEUZw5X2AnI02Lwnpxo58oaNDOK?=
 =?us-ascii?Q?6ruZK+r4IUSH6jcjSdvja8vidkdepKVSfbO4OjkEyCqZ3h0dtApqtcKgaeFp?=
 =?us-ascii?Q?QmmN+ZcxhRcF+9zjD4jQrYzLRUJttwaCCl3fsvFxve6p1qs0o0nFts71jXMj?=
 =?us-ascii?Q?ZAc3a8Ms+494uFMrK0lBBrEqj+OT8imAKtGZrXPKWgvSfKbKyLghRtYZyWct?=
 =?us-ascii?Q?O6DZdVI9mrS0EwPGx415IWCREAc437o4oRBndbbYZ0V66dykNb6tS8v+aVZ5?=
 =?us-ascii?Q?HQMy9c4Z2NuY5SYnPwsxfukNfqBX/M92R7tiUq3Ut44pc0GcCHvxsUemvbMk?=
 =?us-ascii?Q?Lw+zaHBBr2o4xiafTS/UPNaa0V2FqvfVI4ZVApKY8wuDSDHmoETnh/RpsTIs?=
 =?us-ascii?Q?OGHJoSnjI1vvto37DE0dVmzY2jfBB/kmEpwIHR7827NUAcDtERPXrxKm7x/p?=
 =?us-ascii?Q?8NfZ5IjicsKGD515te6kgXihUzj/4R7LGf4V8HRirPfOosdPh63PCYBZc2Rx?=
 =?us-ascii?Q?336xcOOIUojQ666jxCJ0cDWEom+O2xtsxp62cVGrqBl5CdcLpDhyB0FgzZOm?=
 =?us-ascii?Q?7hOSLEbE+JCQe8k6XGm3U9KYgpg7Lt7csJog0Rz/IfnufXRM12IEjU0jS80p?=
 =?us-ascii?Q?oaF/PNQjEhonTbkl1MBAUaCvRfEuu4jI7OJX2QJPg9UZaQDzjv+MHanTRUMs?=
 =?us-ascii?Q?BH5wkseCuF+hvVg3867iHN5kS91YhHHgSU+oa8w8FuyIab4ipunRPZU3wqPM?=
 =?us-ascii?Q?Lu//U95ncDZ1NOdUnXv9342x12hL5GZOEXNM8eohuQYvePEcPKyNFZV6cNAg?=
 =?us-ascii?Q?YVcpz21XaA3qpuX1OWI/xq/gqfyAwbv4QEk0RMTa7uBX4Vk0xji7ULhAQyE6?=
 =?us-ascii?Q?+sdmWVkysKZmNhIQ4txPjIgdrz1rXTsnv/m9R7fxG63Me47808TWjrr3TvEK?=
 =?us-ascii?Q?Iw/mfotvVqqzupW8GKUa3z4PZPCTSQ+hIyBBPtRNVRhJ+NB3c7JmOnaLq69O?=
 =?us-ascii?Q?wPGaFd+Jm2KoOHEe5gkQymx0Wo+U/bABhkj768M1BZFX3SLbJPIBFgOI7YUt?=
 =?us-ascii?Q?AWWnlR4/7RvKJBosYyjpg0ZyOtIvVCwEYPa8EVhaCf/xDYtksPu3lpUwJUo0?=
 =?us-ascii?Q?EWD0YSKtAj0kIis0wO7JCarAXFxikK7sUD9wsnUISdGcxXrozN+bM0R0jLuq?=
 =?us-ascii?Q?ajZfo9jZ5mzf0/8D8phXxnBj/TBfMltw3m7G7CVNAzl3M2lweyoDMHFna4PB?=
 =?us-ascii?Q?XEc4gGgJVX5MtZEKQ5XJAMcEnlE2jmOvNJ0cRqrGv5bLdueMSsreEIDW6dVK?=
 =?us-ascii?Q?AK/fGHP28z37cc8FOmrIW3LE+wWGIw99DuEk/+MIyIMlS6ogHrRVHg/Oidk4?=
 =?us-ascii?Q?IL7UFaHQnXzQMCgs/JnEJ+W/8RRWYl4zCTor7S74tt646CQ7w7Qh6r5uNRzV?=
 =?us-ascii?Q?iQkMLvSh2SCHe9/S2DpXvaQy34rsu99VuHp37KweYYRhxN80PqUdvWEVPAEU?=
 =?us-ascii?Q?2e99E+IZFgp+s+TOHk7QsE+Ud/joWJet6Gk9WBokmW0qLT49IsV+8NDylq1w?=
 =?us-ascii?Q?yPGbZvC3uz5ay9l0KnIWrrZiPNlJQqfJi9dw2A+P3HDoylaSE4WQ+ItFUpLr?=
 =?us-ascii?Q?c+CdaXxOIgpfr2D8W4/4oWT4QyuToQ6e9cvZpzXcnrfZGj0pyBmcR9lqhlOF?=
 =?us-ascii?Q?U2yfHLfWgZyRi//S30ZhHm2OQaS0uMU+4ThCOqz1wcESbTD866xcgEl09Vv6?=
 =?us-ascii?Q?DMRRIvwBqg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7312406-32aa-46ea-116f-08def2ebb73c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 12:18:54.2307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoxNLhteQDF78I/8ERVzfOpzuZsTXBzvghIBT/SUY0KbuXKxeywazWCfvM7EbZa9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7175
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=jgg@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 05, 2026 at 08:33:06AM +0000, Shameer Kolothum Thodi wrote:
> > > +    dma_buf = (void *)feature->data;
> > > +    *dma_buf = (struct vfio_device_feature_dma_buf) {
> > > +        .region_index = region->nr,
> > > +        .open_flags = O_RDWR,
> > > +        .nr_ranges = region->nr_mmaps,
> > > +    };
> > > +
> > > +    for (i = 0; i < region->nr_mmaps; i++) {
> > > +        dma_buf->dma_ranges[i].offset = region->mmaps[i].offset;
> > > +        dma_buf->dma_ranges[i].length = region->mmaps[i].size;
> > > +    }
> > > +
> > 
> > Shall we check if @offset and @size is aligned to PAGE_SIZE? If they're not,
> > I guess we need to skip populating DMA buffer instead of preventing the
> > device from being passed through to the guest.
> 
> Hmm..does it prevent passthrough in this case? The intention was not to do that.
> vfio_region_mmap() returns 0 irrespective of dma-buf outcome.

I think you should always be able to create a dmabuf, even with
irregular offsets and sizes.

The resulting dmabuf may not be mmap'able though.

Jason

