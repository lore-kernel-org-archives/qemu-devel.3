Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B3AC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuG5F-0005Vv-JA; Mon, 17 Mar 2025 15:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tuG5C-0005VL-Pk; Mon, 17 Mar 2025 15:25:06 -0400
Received: from mail-bn8nam12on20608.outbound.protection.outlook.com
 ([2a01:111:f403:2418::608]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tuG59-0007wl-3c; Mon, 17 Mar 2025 15:25:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InX4TQGRSn1b4pDuUN58y0R2HRFvmj7iMA4RLKxcaojdOJKozOdolASewfxpsmDXX/+1vFQ7uEcZjMw6K0z0dBb8KvEs+bbU6oLmP5FSEn2cYaapLTgNCN6fS8LAYCConYjHx7SL2onVr3qyQgkzTWhDXWVpUTAEfTjh0gAod86VDmoScRkdLfhPDk1s8zBIhIBwJsJshvQ61xMZ0uq7YwWZCn05d7dsgzofuFBEJNfbc3qt6W+AMI8EgpkrsgecWGz0+JOj4LUQktzcjnd/ek4IPfw+m9wGXJsLtSUTx3iXIBDzhELyVRtXZjf8YH537ar1lgg4nenyUKkQfrvZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlrNBrVmisuGBSQw0wYuavgcLTsMKpXlKp4myEJW54A=;
 b=fk0Wks4j7meGUfooTROBJG9U1hwAYj4U/RUxATD2EiL7/otCePA0x41Elg6+ip6F67i907T7oAaUR9vIerZwxByTPwLEG8PXSM+/tYJVGcyh4B4Q/AlR08Yw4EfhcWvF60vwCtoUB+kNQdVXCyAeO2m3BJXgOd9zzxVL/QmOr9Z6au14G1xlIdhiv7GUDuIeRzNaxLY2SDDSs2CGT/XMQfqBG73/Az+++1PxdI8hfZ+D2EMVEEp37ayRKx/jKDTsV7ZnWy2+XTfFBfyLfZopJOf4shhzzVq224hx46I3Rrby5fb+Tu4rKt+n8onpm4Aw1TFz+6lz5lDOwIpXUILndA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlrNBrVmisuGBSQw0wYuavgcLTsMKpXlKp4myEJW54A=;
 b=WDW1xZcbLEJDf9KbOhRyFjDLl2U+7v4vWl+rNYIu9oC/Zpj3jGDIV6/xIrbfoJf6dZiR8beuYWmVEFPc/JoJL8D9zo9uHs/gaEcqXcZIwujTUQRfwYQep7mdbN4KgeivBMQBmZ2avKn5mWoZbgZhxh6fVxtdSQzmf1T2I/tJHV4/PBWlxb51rsrR2ZxnvSaju8ODLD9a75OFB8mvAZ6my09f/s8ivmbzDC6icIrM3YZYBwmff1uUk1rVIUZYYUNg+MVWQ93pGJo4t4FrTLw72fMlsqmqVQ3suEjC6Tyn/1RT9/Cr+2F+kZpW5Cd1xbEGwLOGybZKvXnNJ+SZ4DvuTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Mon, 17 Mar
 2025 19:24:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 19:24:54 +0000
Date: Mon, 17 Mar 2025 16:24:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Message-ID: <20250317192453.GR9311@nvidia.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
X-ClientProxiedBy: MN0PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:208:52d::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 777a8228-2d25-45ca-c746-08dd65896547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0AdE2SiZGeXw57zHe8Ld7xOM7KgiFJ0CVwznzqSigmRTR7BUAkOQwSPeFa4I?=
 =?us-ascii?Q?GSs3fV3xYU24e9rV5kAjJaa2f4rDRsXtu0dth6C6fxvmnJiUSN1AoxLDcOHw?=
 =?us-ascii?Q?pqxmwaguYdCUbru+dcj1bK3HgAIk5FrxxMVH+KI/xiONXSafwmmHeOquJaPp?=
 =?us-ascii?Q?2WGtN64WORG0fxwVC1wbB1BnUgBNrxsT6mobtebJxWc25TdSFuCDfUBNNwjq?=
 =?us-ascii?Q?sXpceb49qrkVUV5E+6Pf5V8IguK6xuZrjmm+8fcrOJ8vMpfWFz664qNmEfyG?=
 =?us-ascii?Q?ih+INtBeaxDoTGcu+c/hdiay3k4TUtFxcDkpxQkjd2zfVHFDbz6vgAtzsCtQ?=
 =?us-ascii?Q?hm54pmwg2BV4fKWunhUmK+D6pRlbMgj82gWaLSWWpLjLGeJ0O8ILSAoT+JGu?=
 =?us-ascii?Q?HtY56o2X/mdK9LfTuMSACknbc8k65qqSk2mt4/8vm+77rMJHRJL4sAA8pErS?=
 =?us-ascii?Q?ZOauFl9AuMWM0TYTruoQtkucR0z9ufCJQGeYp3GTyf5jXfG+3645j8RAymgV?=
 =?us-ascii?Q?2ynkV0MatTHSsHWCnuhHR2K1qGACFDten9qm9rwpH/HbEfvJlxejZYV3XpSh?=
 =?us-ascii?Q?jpq1RWhbjZ9OZonz1VERYciuSEBeWA+kmC4gaEMf31Tlm0oPPzbACC+wOmxq?=
 =?us-ascii?Q?qXiyvZD8JwRjuzEgISohGSGF4dljK8I3y5mCkyxiCRuK03gSgdskcVRUicED?=
 =?us-ascii?Q?LUurIpEbLa9eyqdWKWXG1WrkGAxQEIf1PvoQ0ZGD5laUl4lyMjObPeOAR3T+?=
 =?us-ascii?Q?tv61xzrAUQTci0/dszXSd2i+p8G2Ik0mKICsl2Zyc4bUJdMjczQoacP6zVxn?=
 =?us-ascii?Q?6w5qWJUfcUiDrMht1ZYMfqmllUz9cLaNbmTgOn+wXn+Xa7POTB0g6i4OYEOH?=
 =?us-ascii?Q?VJ04lVJo2+iWyfo316RVJyx/fV/gw1CeukLWrgU4CMPbzJVHYv6Lg09cImxy?=
 =?us-ascii?Q?oco+cnn9l6W5oxmZVrShB1hGaMecUwpLihbHZBUS7F27JkybhhQ3nHIfEp5w?=
 =?us-ascii?Q?Li5kDgz5UqxcFq9oA8PSVTy29fe5okVvW1/xwhbU0iVYgqYKL4wEIbR8BjiF?=
 =?us-ascii?Q?InpfirzWP9LWJTf8wPMmcrH/Ao5Pvi+DGrKIncAH5zjpyHg8ZWqCo6qA1t/r?=
 =?us-ascii?Q?5j0Idr8MxWLFdU6OrLO9XO7oS/ywYCWgDOzlGWswU3nm2Y7CjZrypfzh1u2E?=
 =?us-ascii?Q?44H+9zueUiB2z4i1A12bXVJpSYkILgjIb5rsMDLDFUNumekORSErwUmtHYJw?=
 =?us-ascii?Q?epsY5D3MQBpanZCUhgdqVvSmK9tGkLx5yc+FqvzSDN6PJd6q4+rfSWLxCo3l?=
 =?us-ascii?Q?Dup7VpDsvnOXSSE6Vca7fx6TApbWuodcIDJBnFwUtVWkeUnsMGY2+oaqZfL4?=
 =?us-ascii?Q?tRKRVT4EOEB7RwDlXnMzEd8dCmyf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UcmzV6WcbpTyw7lLQD4FZT3WBhKSWJgR35g/frcgf26WB7+iWM8YJKo5etKC?=
 =?us-ascii?Q?iFK9P8JY0JYHjVzDTrmOdwinj3g+CHdtP6Pq0oiNj0U+yW54c/iKBCEjDKI5?=
 =?us-ascii?Q?KG7NuXli6YpLCLRn+nGJ/5VojR6KblqhFm2zDmzYnNgM07OelQtUgH+mjcuY?=
 =?us-ascii?Q?HUyAU+DxwOaJODXuxcz9cUzRnrQU9njkNamigdvy94okhzFjrUWyokGkEbHy?=
 =?us-ascii?Q?3xHbnRA3/P3rZqf5dp8/xg2SHgtN+rYnZHdqqPWpTZ6iAm2Re9mNvgodfpK9?=
 =?us-ascii?Q?EeOXSZZvBgLuekQ95HYPFI7WdwZC5xHjrpC7FOVodzQe08RojHPcCyPwK8VT?=
 =?us-ascii?Q?CmJiA3HEj73XvsuFjuHL5SZxmxrsKL+Zb00y+ARphyIZfjItaq4H8hQzY/S/?=
 =?us-ascii?Q?FZhqpT2/J++GRwhyYGp1OTuqbS0hYsFlAEJ7K0ZeKnQ+gghHGuKePdnvDYoT?=
 =?us-ascii?Q?w0Y9nvrb8Bqv0D8YqB0eElX4dBSs/sGY1uYoWw+bKOP0E59Oaycq8NSNVilB?=
 =?us-ascii?Q?frEkAkf4guiQpEb2362yp3otBBOm6QqffwAiPDw/Kbc3RL1Ohuq6GyzfCoa6?=
 =?us-ascii?Q?HVUnojx4CmEvZck0G4axqsDQhfE1UvuBUfgN9wlDZT6NxhbqDTALHfWC0fo/?=
 =?us-ascii?Q?DtBMNik+PPvFqENP0qxOvzNpvzbmRktG7+XqbSPbmc1UpaABTtkelAttpxR+?=
 =?us-ascii?Q?VlOLCqHCKD67kggvdidNLNpqzqulXMc/TySd3CIZt/6IuFwbi2PO+XjN+b7N?=
 =?us-ascii?Q?hvpQQuxpZLBPgW94hHsnzkPePfzFgISX4BV3Q1KeyzchJAwbjd/817C/TKF+?=
 =?us-ascii?Q?JX0OIg8hGudrDVKv+il5wKnNWIgR8CqR4A07kQYpzItNi/O549IgL1MGuTic?=
 =?us-ascii?Q?PmoFgBsbjsd3DZMuQwL8csb1PnRkagturhCYJOcc/SWRlkE0Sqt+MFRWbR21?=
 =?us-ascii?Q?DJRpsz2KdpnF3TOKTa81OOdUOm5lBmWhgbn98NwT4L2qYiCOuIns8hAGcP/b?=
 =?us-ascii?Q?hJ0tUSSdPg24LZyjmyXKmGOrsBByzXj6KoRzwNPyhE49Vj58BwXKtx3lxkGF?=
 =?us-ascii?Q?EOkgAml4iasOiAawJPPGenfRBkWMvT/rv0Ix7gNpwUe1bEtGet/cnFzv2QDS?=
 =?us-ascii?Q?kDW/CaQje+QjI9FxM6tbDONBgA1W7+RhwogOExB0n3lz6nM0j0uaZTRFG1sB?=
 =?us-ascii?Q?6YqXvd1IRQ49w8tQw+NypfOVYvehvZPMmMm6ZiMbqChIUtdL7ZLjLgk/cs7H?=
 =?us-ascii?Q?GAHaQp3wkIGUsG5ZhWJUgWPjVqsuKa//yyw4m3xRbGmTh7mSbZBxqJTCycP2?=
 =?us-ascii?Q?LoDx8gZ+Q77+hvBAKq3vyGDA1gqoLgzePqk6Wkp7C/Fj+4n4rwnKwllsDF/a?=
 =?us-ascii?Q?HjfgECIbN24g1wMvpvuMxxMOexJmj196IUx4DXUq8rhuWV71Y3Aa0S6f+ZX4?=
 =?us-ascii?Q?xQ44lIauSFt/tlx/xxt8TAlhFDAbTkY2DIqDa4p2o++G8/JV4KP+9abHX+CG?=
 =?us-ascii?Q?b5QUzQoYEUDLxBolDLWF691pHcmElNsETp2lHMII3ANcWKkJB7ESmL4mT2+c?=
 =?us-ascii?Q?9+MyfplW6aYstVuMaF2Pzkl8aPd+bBnHTDuLdXHX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777a8228-2d25-45ca-c746-08dd65896547
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 19:24:54.2483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUPSXnKAqiHvkrC/0dtimCJ3wG9/X3yIA+BE9mUYoV5ppeM+cy2jJv+rHs+I/dSc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462
Received-SPF: permerror client-ip=2a01:111:f403:2418::608;
 envelope-from=jgg@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On Mon, Mar 17, 2025 at 12:10:19PM -0700, Nicolin Chen wrote:
> Another question: how does an emulated device work with a vSMMUv3?
> I could imagine that all the accel steps would be bypassed since
> !sdev->idev. Yet, the emulated iotlb should cache its translation
> so we will need to flush the iotlb, which will increase complexity
> as the TLBI command dispatching function will need to be aware what
> ASID is for emulated device and what is for vfio device..

I think you should block it. We already expect different vSMMU's
depending on the physical SMMU under the PCI device, it makes sense
that a SW VFIO device would have it's own, non-accelerated, vSMMU
model in the guest.

Jason

