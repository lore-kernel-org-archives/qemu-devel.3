Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D32DC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6W5-00074Z-Fy; Thu, 06 Feb 2025 13:22:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg6Vw-0006x9-HR; Thu, 06 Feb 2025 13:22:14 -0500
Received: from mail-bn7nam10on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2009::62f]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg6Vu-0007My-AQ; Thu, 06 Feb 2025 13:22:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt3PSFgRDeWAgz+trTM8jQwTgqxRA5QH9UaoqqrztgO9oyMrQ/V7ka3Gd839WFeg+t0N+egOtvifB2zDXVVXxlyvc/czWHkCrOnY/5Zra5FH/qzAiN383wj4UoZwZxcovGWnKGLy4rPrU8UnNNlcCbeQR+6pYAOBilzH8c02oU4V3taI5jswGO7aOvU6aMBKrdDpL7a4gdAvVePIVBWqYuoDek9dK0Z8W3/1eax4I9BnZbJWZLKczpwf6G5ZCZbdx339J+0TIRAH9lBlbCCkSCefNHjIyzxn3huaCTOAwWmFA1Ph++E7iP/7Vo7y2IXyTxSeVO+o43N9T56NVQCwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUwDj7seNsAaSNsbGQVW/rVPzWBBVpTWrKoAmFU64Gc=;
 b=xiS2k5aXOD3zB9FuM8oWgV6L5Vlj0tvlmN4McTHoLuHCXgxmY2LX7RHh5D/oXjtZuCgGNVbN0VaJ+KVupu6IdD0AbzqLvMJXSKWcVQgyasXT6PXpra4OmEygumzaZFGD8+qCo66q+TN2zwBpgwewi4yIoQEAv+fYhkICyOzdjpg8eQjbceYiFa8zN2/vrLfi7SoHoBTjPCjC5+Py7w2J1318Vo3xL6tg8M2kiRhfbfiutUmLcp2+kLrgPb84ALz3ZkTTBvwWXXjC1TOrKxQ2N8KxGC4vleSss4jbi9oDoJXaP5w9/2TPSeTMSRIruVGmJcaf5FQA6p4HF4RX9M8mvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUwDj7seNsAaSNsbGQVW/rVPzWBBVpTWrKoAmFU64Gc=;
 b=F+GrRmHuJP8lM+qHMoiMH6SJT5c3E/9WnQGRqY0kE7z3aKjCEWLEWn17Bg8EaGY1r0s4CRgtMf5JZf36u3kBLw0gff50F9XNenBQr3MyVWhMqFs4woLJJUy0V3sJA8J1I9yfRJeGTp62m9tjyMXOhMXlHhjUvadoAjnjEtso3SrZQU4Gpyku8JOX/+GHHkduVfFkprURkBnsaSEkfeNj5b+AO/3vy+8r8ZQqWTl3CuSX1RwHfg505d6xy7fb4iaeOp+s9ydkToVsxrZLzQC3xAlD5IsLK6TLx+W58DTrNECZYdyloJ4ZweodVyWgmoDZN3fBxvTFwZbLwxNxg4Ihqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 18:22:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 18:22:02 +0000
Date: Thu, 6 Feb 2025 14:22:01 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <20250206182201.GL2960738@nvidia.com>
References: <Z6TLSdwgajmHVmGH@redhat.com>
 <71116749d1234ab48a205fd2588151ec@huawei.com>
 <20250206170238.GG2960738@nvidia.com> <Z6TtCLQ35UI12T77@redhat.com>
 <20250206174647.GA3480821@nvidia.com> <Z6T3cX_fM-aeYbMI@redhat.com>
 <20250206175843.GI2960738@nvidia.com>
 <13b1d8b97a314cb28b87563fa9b45299@huawei.com>
 <20250206181306.GK2960738@nvidia.com>
 <02a0080a4a1642d69b7f5dd4707a5b3d@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02a0080a4a1642d69b7f5dd4707a5b3d@huawei.com>
X-ClientProxiedBy: MN2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:208:239::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fae703-201e-4644-757f-08dd46db26d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G9CjyPfNmDkUp4Ffu1Kj/RH5DCOAHbfWCjfXB02DKkpproY2htpLw5Ijlfde?=
 =?us-ascii?Q?VIKxRlI2iNkDNwOPxZm20FC1GOlNFzYB8g0mj5d+z7s8nUhlIL6jfWypdXBN?=
 =?us-ascii?Q?SIa2ncR/I0TpzaKgcP7VDC1ZWf5hrWSfNI4c7s70t+J+XvvwpJMruAVRhf+9?=
 =?us-ascii?Q?TpANpPoDxZAVyYzbvZA5C/xmL8t75GAzMud5Q/6st49eDWPaENc8fDXG0dC7?=
 =?us-ascii?Q?x4Ek7XAaZqOg1V/XnU5fan5C5TUo/C4kr3uD1xprBpxK3faxD8LfB+Rgr3aH?=
 =?us-ascii?Q?yFmBZvZI113lIg95V4y/i20JAyhgIGxKeC0U4o+YOI/L5L50k9LwwLfI/U7P?=
 =?us-ascii?Q?Bigf1awSmO+dqqLLfrIrOA29LsOmvk7yGjU/d7B7jbwwurhMCbV4oHRl1ZDe?=
 =?us-ascii?Q?eIudiqfutzKJlimiImak5VjUSw8IGnWq+3ZXx1R+eij/fVi/f+EkxMSnxYPH?=
 =?us-ascii?Q?BzocJX8D0lBFTGOwd4DmvHJh3GXWBh0iOiuxdlGdYbbwDSkdj9So5wM6+fuR?=
 =?us-ascii?Q?mEw85fzNm9F2KNoIAPFtACrq89/3mv/ihHhxvjLWx2KeCR37BWmj2l9CySI5?=
 =?us-ascii?Q?vnk1NdG/af87r8RlsoEBzA0OuieBbqexD7zLXWqUlHXemVDDFhKsrFW90or3?=
 =?us-ascii?Q?icHU4eogLRImy4pbIYjnvJjrypqnHFvZgGO7DWYvPCDP4oW2lQz4GUukJidz?=
 =?us-ascii?Q?AT+/CQsx7jo8MZXtuZ8lN1n8HAF9yoZo9i5YJtlFTwVhI3VA24nGaWY3vNkA?=
 =?us-ascii?Q?YWL5JdgHGUN3FE1cDvpM/E49iGmIzR70J8l8UXwXdoi04TiQ7oWapD5iSpKh?=
 =?us-ascii?Q?AvjjWHzusJBzuRQfH0CQ1UC3devUx7epSYs0izPGImTKeX9ESLsBWFeY0uoj?=
 =?us-ascii?Q?GnekwMxEjpBkSybqdsd6/gbuuKZwF7XlPc0LU81w1fwjvRFgPP2M9DxFdgw6?=
 =?us-ascii?Q?2/B8zYtW+2VRKfnNByfsZ3nmJMoEKzgJ/1NDeccJkq2YkrIq/y4bwRVwMF0+?=
 =?us-ascii?Q?RJ4poNy+EVSXmaaT10RbnGO5AWhCB/fnSZxMcVy+Vvuh/KF44A7tgh1dZBHP?=
 =?us-ascii?Q?3OJ2DdNAzTsyNgkxirSj/A1KsII91MUo2ENOOgfFiAUXxsh4OxPrIGqfQx+5?=
 =?us-ascii?Q?HAQ0sDfNNH1EXLp/Ow3aRXE4zrFACXc1T3/pnjMwuOobzAinM3bhMiTXyepZ?=
 =?us-ascii?Q?yagtA4dc/y+BXeag5/zY/twMoBg3juRYPlTOfYCZzdzuyEQI0t49Edc+td3b?=
 =?us-ascii?Q?8sYR4Cu4BwtA3wTwtDa2UvA+VHGfhVlOVfO219vFvkA1NjQwlSvMjF9W2Tnv?=
 =?us-ascii?Q?pn9ozYIm0azg1TzirnnoWGwYiuHgWMzajC51BDobSOoa1WXAHlQiZrqe96w7?=
 =?us-ascii?Q?h5qfHwh4grihuBhkMAicPVsEj8uh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HdOlgGlogzhIjknEGuLUzbG0cMvHTxiQMg36ID0cUVUSpwoL/uhSK2CLJyEd?=
 =?us-ascii?Q?7QgyGebC6Y2dMh0enPkEpAjzPwtMNKSI88DP6Y7cxI7j2Q4RWUHp5MeNUl+0?=
 =?us-ascii?Q?5w5GO35sFlBKksRhQJjEQfq++ER57EJgVhYWdzSNYerB1zYwVwGnMgWFMd1P?=
 =?us-ascii?Q?+Es+3+EBZWCPShIeDFByIfykdILiajsdVzmnXdVY5Ey1ciwusRW+HI155Oce?=
 =?us-ascii?Q?h1nDwlc1gsXr4LofO8MCfp/Pic2Tb0ym0Jly55v9tzvredpR+k7L9XyMEEKC?=
 =?us-ascii?Q?CHYiGoQoE4MTB2jNXtQTWxqoj/+JPI5x/32RglbcTR7/AJtQBU7AdeY0Uzm5?=
 =?us-ascii?Q?HYtXZFYDC/cEID3KCw69NkxtEkNsV1xPOJCI/tU29i3LYPATmV1gk+iD/Gfg?=
 =?us-ascii?Q?+TI8yBhiGYgZxSJ/YKxZFcES++15xgIQ4u0KwNQSW9ZcW/FJOzq1i5Mfix6X?=
 =?us-ascii?Q?b3hc/Q8GuWEo8F2wU+PA+Udf/iVPBa8I/SZTcG/e6mumE3wYqHrSNEef9JjY?=
 =?us-ascii?Q?SDyiYedZzTwoB+6EY75FhKbPOnkWof39wNvqoKhYpZYOwxDdrmv0ZxqZ659h?=
 =?us-ascii?Q?c7A0YSfVTAQwEMM+G0u5kXHimzFCFacnI0nNb3QZT0tMII3znwLx59IhJC2o?=
 =?us-ascii?Q?d/FgqEVkKSrlLx898QY+frSE0KhgmVm/BZP7O+Az76KkcTbeoCXg8toewOlp?=
 =?us-ascii?Q?mL0mGvNbmVLzRlp8JePfmtxf5J5HKdUAo81MQV2dmSldCijU4oPk9pQYmqYD?=
 =?us-ascii?Q?g72q3M17ASIKDMWwNvXRPYK8htUws+ecWkmXFqHu3kYtxLfEjiiAsY/Gmxrv?=
 =?us-ascii?Q?WEIzl+a4GYILC0MKHb4HiYl/5Wy+wJa+SpWBdBsCHZGd0KprdJ9OhgPE4sa8?=
 =?us-ascii?Q?D83f6egcZ/SScBvsTr8hyKFu0k7KTHA1u2y0YOzzwerw/oriIiDOpFnV7wCc?=
 =?us-ascii?Q?UAU1eo9DnKWSJ78/J4APNZ4E5D9/sM/YHxgOaZMOgc91NAkE23xPTeGTpPvM?=
 =?us-ascii?Q?uMOrVSvXACmxHt26Z3O2GK9wRkBK0t4kMFHTDW7vGs6w7vpRmMi3BUEZ10LL?=
 =?us-ascii?Q?vUwUaV+UVjJx1kppn1coY2W+XFG2aavBWrLdkw9316cP/21d48/1TWjUt/RX?=
 =?us-ascii?Q?iT2yUXGEyObrPkQgbU41CgpZ0u9RcxReuOYynq38h6pBbGs5w4AVtQ90k40D?=
 =?us-ascii?Q?FMYnWi3nYBuDDebZEvkAZRASqy2JEoX/5YLjPeqWnx31cD0R6HpDS5P4GZCN?=
 =?us-ascii?Q?+9yH+iUW/xuMvwwmqFmbg/CpvAIset8+9r9gb/4e3XLYyQsNDkbhjp9DmZkD?=
 =?us-ascii?Q?MuC0kXGyhnYCuGVNxwmwPD/QeNQ6pTI1ii1eysTE3jPazDU5djvk2onfg/Go?=
 =?us-ascii?Q?y+USjFATBY0SUsK+FLsSg6pWcA8LPgBpa9OF4Pk2Fh5VpPyzcel1y+aQhO7W?=
 =?us-ascii?Q?6alAPU/u22b9eu7EAegoe32B+rp+Ea4EB23GeWnUqcud6k9hC7s8CMM8NycU?=
 =?us-ascii?Q?vsvfqnCeeHOSp6+43zroCVu167k2e5YJd/GLj+WuoBVtNqTrZFcK/FSC3pEP?=
 =?us-ascii?Q?tmOBvcM3B5JG4kTV6JDIbRcxezLJMY0t5V09ad5t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fae703-201e-4644-757f-08dd46db26d1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 18:22:02.1102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J44Q98AjeWc7F6TtfAecvqAvrLRk6gzVSNSC0UT9B0DJCjja7T2YsNRLT7ragCzD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
Received-SPF: softfail client-ip=2a01:111:f403:2009::62f;
 envelope-from=jgg@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 06, 2025 at 06:18:14PM +0000, Shameerali Kolothum Thodi wrote:

> > So even if you invent an iommu ID we cannot accept it as a handle to
> > create viommu in iommufd.
> 
> Creating the vIOMMU only happens when the user does a  cold/hot plug of
> a VFIO device. At that time Qemu checks whether the assigned id matches
> with whatever the kernel tell it. 

This is not hard up until the guest is started. If you boot a guest
without a backing viommu iommufd object then there will be some more
complexities.

Jason

