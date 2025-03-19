Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25270C35FF3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhDn-0006VG-St; Tue, 18 Mar 2025 20:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tuhDi-0006UX-NF; Tue, 18 Mar 2025 20:23:43 -0400
Received: from mail-dm6nam11on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2415::609]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tuhDc-0000EA-L5; Tue, 18 Mar 2025 20:23:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLwQ71p3C/TYNSDA/iOiJfzM8oALJ1vzpPSxPXRlUq2TL9p8IJpOdTW2peezV7fwdktOfpDIwwGFrBq4/0w8STp21QNM7/1A2ho0rVAHNE0CjU/GqJDK52g1JKmMsv58bJg3XiN4Knjj9/gtFMFBs9JeoGNerX3fuD6RBOOwdklSt1v3GV+Z1T+rC2bM0jp5juApIjM5TqnX9t89NthyZbzB3Nlu8Fnpqx5jgbaB6ZiOiqKwll5Emw+QyOAJaX44+0m2zaNM+RQKJXqPR+3TsPSDrMln4ITbiwEzkLkPLfLyle82fOj/OCq/FU164sPnJIhUgJpCbOYEvpJ2akZ5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCWLsdbrG9y3fxA2Gg+tanCxiF+fa6H6af6VP25ROXw=;
 b=T4IiUwUH4Qi1mxRR6lyQljOBPWDAYtQrKkwXYzNnLSE04KWiQrnOach6lqAAMJgvPb8LnpbxnAy+mwxjcIeiu/4lt5xoS56Kn0tejskjrdqzicG9FnepOkEA1KqeQPacSce3ytWn7fiRvgxqgTVd32LB3045JJuvUvnHoZg+KbEChwxSEjReujo/w+3QfB/w+drfQQjeTMl7mQyMBr8QYAAafzyiVDUeB4nsD+/UistcF/fGx/WYa5sJa3JT0tRrfNDpfQP+nT0oGCx9Gb0VZWF/N3TNZYkQyyf1kMrAfMD++URdtrFMMdI7E/oWKH3kQI8kCZxIs9DV7nWCTfhNeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCWLsdbrG9y3fxA2Gg+tanCxiF+fa6H6af6VP25ROXw=;
 b=GpxgRrQ01NrHhU9ZVYxNI8jKOc3YBHMHzo16YIz5hrcxuW/wjsx+XfgbzcoH+HeXOqFMqerTCyAcx6KB2tbY3nhXi7iQkYYOhI9HC6hyzBOV2axuuJlm6sNfcGHmJBQEHaENZIRZwixOQ+RgixK+6NLzmCEeKX6FVxIbWVAWDx0cw9wIMa4gqjsFv9jhHl07im3Fa06OAUjo5izX6Y12REnqmks/fotkfWzaidauaFSIM6OaMgW3MuJ2uc1hxj81XBvW6QhBz7Sgs4nrS82cK99ayt/lejDc79e1nfIhaLjiod4tAAY7bwiGgjXyob9vIlK95r7ZGzyTkYyvq3W4xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 00:23:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 00:23:27 +0000
Date: Tue, 18 Mar 2025 21:23:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Donald Dutile <ddutile@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Message-ID: <20250319002325.GG9311@nvidia.com>
References: <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
 <20250317192453.GR9311@nvidia.com>
 <Z9iDxSvZVsgtasGj@Asurada-Nvidia>
 <6cb391a4-d150-4692-b62e-a509448a1034@redhat.com>
 <Z9nF6FaIU37BNg4B@Asurada-Nvidia>
 <3716d39d-3f88-4914-a9d6-440d379db3d7@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3716d39d-3f88-4914-a9d6-440d379db3d7@redhat.com>
X-ClientProxiedBy: BN0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:408:ee::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 955b0984-fb7c-4caa-8af3-08dd667c448c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TKM3wtJWqEEKCsNUqvYf1In4YcmTgoG5+nXhv5V0YtzxLj4ybSm9UP59ib33?=
 =?us-ascii?Q?b1Xf03UvD+NOgQS8QTaBzS/xXrstzcNjDRUKg+cBgtR0lNEXjBZzBrzBBROO?=
 =?us-ascii?Q?zay9BLXXzZ+ubrk37cCWl8KxAYKlh9qSQFqUuM40BcerJk673VomDBi8WUFf?=
 =?us-ascii?Q?xIZZsvX0aG7Un0uUQXnuO04p3Sj5Dd2FttNtoQL+jFOp3MyGp4opO7SMuNWc?=
 =?us-ascii?Q?bACZykKscykWtAhengq2cM3fFyveGXMStKufWY7tWDz5Hp/3/Ls1G5qscVTO?=
 =?us-ascii?Q?HteByugT6Eu3LLaJpmn2OKZ2B+vmGNBDKWnklCIi/aFzLfkvvjdUL7BIMuif?=
 =?us-ascii?Q?u9DwkMejHo3pL8fQ5cQQEc9IgQBBMmCd6F9VZBsWknqiIYhiPMTJqbV+ycbK?=
 =?us-ascii?Q?0qcaVoGYHBrp2qp5RF/d9Njoq140IwbbkdrP33Dhcsv094RrH2v7gMilt5hi?=
 =?us-ascii?Q?bjVWuk4/KpaSal9rKpenDwAypBjsECakHP6pqWcaR5Pp7CIPvyCPG4texfmh?=
 =?us-ascii?Q?v5c635iI0aoVW/OYETMb4xtDCMTZoEIUFR2fx8vGQVjZJBIELn/RS6mWO3uS?=
 =?us-ascii?Q?fM2r0p5vwpWbDiShSbqg/jekTIE3QSi/AGno+1F50NLGzlQdQdD2l71lCXJT?=
 =?us-ascii?Q?1sn/UauPShnAF/DhzXaWghNIEHOPDrXybAgKQUrZjD21mSBFKvWRIhp+fOgh?=
 =?us-ascii?Q?zmt4dwAYajZv+7rU2UBU9/GMmzk+2fNjQw8FQ4jWQkyK7PkQEBSqARIlTEud?=
 =?us-ascii?Q?SG2ZA+tj4CUrsl7QZMamwWdgaONEjLg5jtWcGsLH2y/ELBWchiw/sUooGogw?=
 =?us-ascii?Q?JMZxVn6gJYemNgogoVWIPpjb3yCHI7gMY+4UacZEX2l36VTIeRDRjfCvdREl?=
 =?us-ascii?Q?Jsnw6IfTaesPh/Vdkyr92xJC1lZ4xLCxROfLTpWcBZh9vci9GVEZo+iw0z7u?=
 =?us-ascii?Q?EqRnWijl0Il2bzkjaRj+Lp6kaMuxgBYxw22DcbhRiyPzW4CbCQCCiAZZoZ2A?=
 =?us-ascii?Q?tNVJmfNzd33BIawC6oDe5pJuk8Xlhk0L75ep/06GA4/qH/UJ53NmOMODpWdr?=
 =?us-ascii?Q?XnQT/D9gRtSMyJ0ihn4+2N5qDoP4pcez73m3I7na7kmG/LPYrF7kbYusBLGX?=
 =?us-ascii?Q?OZ4xOQG3HD6uEyM6zx1Z+UBdmPLRZC4boFCq0j1zc0OYc43mTGrsPVuLag50?=
 =?us-ascii?Q?ub/jrv+qhqTfjuQz2rjuAxQRWVdD9+vDWEm6LkDXAW8wNg/DabINjWs866+l?=
 =?us-ascii?Q?vthVNzT//yFClVWcJOPnHxdtIXR9o1LF9zxIqxiFGfIlEUJ+BS27T1UDzJGX?=
 =?us-ascii?Q?9el7KzTdAj1NVqxuVK1lPETKypaZyT79Mj4NaMFYgQRQIog3jR7bxBDSXR+v?=
 =?us-ascii?Q?XLs4Dt98KjNt+NQMQ0LiVY0ZH0Kz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cTwue9JNtemAgff1boowlnDe9wqQ3LVXn+5p6NQqS9gI1Lgt5wXbhfK71sbj?=
 =?us-ascii?Q?m2+Vl4KeSFbMDTcTr4bL454+N5tqMal1OkwhRqf/uQ5vmMgcmepXvfqBOhRM?=
 =?us-ascii?Q?Z2n46Dx326/CoSbgfbiNQqV65YVG2UOzJ08n/Z2igSIOu268lRLyMfnX47KN?=
 =?us-ascii?Q?hjDMrbDSBFTBqZb3cXET3WtWVSmIsDG3OD+cp8VPMGT334Lw7ZDa0ZJqnwGL?=
 =?us-ascii?Q?prkN4azaq1yhdrMs72TBQ2u0Tggq7tuENl2ifuQhiGYk2y6N2vwnspiDufhv?=
 =?us-ascii?Q?XXUTauzSNsaVeeVapFjK/FyW1Qw2LY3B0CJ/Vc6LcyRTOZup1KQmcsMN7I7L?=
 =?us-ascii?Q?/bUEezaav6DlQqJ8f+gfNkSdF9vzWTh3qMDUywHWFJjRnaIeTtwTOmw1q/7N?=
 =?us-ascii?Q?xQ1wEa+vJ/TpwpViQRwgOkV9s13hK7huT4C3gyo2400FVYrnqYf2zku7Gg49?=
 =?us-ascii?Q?Y4DA0PlUL2Wl1ki+b57d3YOg/NqQaOkxPQH3HBJVYyr+f4oYNYmpSLgSQABo?=
 =?us-ascii?Q?etf1U2bipYEvsGle8B2j9uLJC3vDxtzIpwJ1Cqqfi1LO/Q7cSFfOXd8Uy3Gv?=
 =?us-ascii?Q?5Wa4hf8OOviTahN8uHDeCIvQYYWJDK0XkYj1ByH9ATb3d5DpIFvc4RIxMKBF?=
 =?us-ascii?Q?eRXG97E1kEvVJRvJfu+EKmqlavPhMFpfL0WRMn5/Yt1HhUyoa9HCA8+1Yteh?=
 =?us-ascii?Q?96l1ou8nrqbZBANgex+nNyH2mQk5FG0MloPqyMv57njwtnOHi6866enNwFnw?=
 =?us-ascii?Q?yxl1/4Pl6q1UECDTEQ6Ei2VRb4jR2GENBAtTfq5G9mL2NeyDxyrsUVBp7uRg?=
 =?us-ascii?Q?gFgAwPFDh/03YbZlihx+Y2DWBXjMEJ81zIL1cefrgmY4oR4UGZKpybR9VtFz?=
 =?us-ascii?Q?DEd8R/zoJHEBWv77X9JMiBSyF90t+Q0w4SwAHK8SleJY41lT/7rH+MGS7unB?=
 =?us-ascii?Q?P9uJEcnBa7PsFQYP6t9EOCYIy61fTjta2PvmC6zZ6dFOXIf80AncEhvqRwGg?=
 =?us-ascii?Q?GVrxNiTtVR/CYqIXyO2QOQXtIx8A1au2qYUkNIapWSUZ0v0AohpwsqScZoJi?=
 =?us-ascii?Q?tnlvyvKu0rAtX0bPMr8yZp7IedxoXvNNTa5UbW9Y/u1ockm9g4Eq2BSYSwJi?=
 =?us-ascii?Q?EzQUG7oEdwLLhn75BVoQS1X/pDcP3c2MI0/By+dVuuj5EatCNv0NxRF+80pL?=
 =?us-ascii?Q?lmm+u7BmxgxiEVZxYwrbSTunOib+UmSLgnI+4dyZRLBJdMaLtfvUCa5NVijr?=
 =?us-ascii?Q?ny831pz182bpPw2q3m6VK13vIqsZ2uQXV9LvVolyhcRmIC3H9UOYthqZXzyl?=
 =?us-ascii?Q?babpu9tga/gQmTQ7Jj7TSd3T4qO7sK1ufnHGFm4gUhODDLuiiOf/V4AnjdjS?=
 =?us-ascii?Q?7gjDG6a/n24/WX/L4Seu/Z2dLuXoo6b5EYWB7lLgCcl/bqHNpMjAI+qilKWg?=
 =?us-ascii?Q?v/0wRTw3XQppZtMsvvqRN6wtPxLqOya2jySUr8Aq0LiMXooOleT96Nx1QbTl?=
 =?us-ascii?Q?DaXGbIO2ouZwJ5DShoRA9MysxcxT8PZaw9Y2mU9m7CpkPLZNDKEfuj1el6WL?=
 =?us-ascii?Q?IpP5pzjql7bbS+6ozes=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955b0984-fb7c-4caa-8af3-08dd667c448c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 00:23:27.1383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXEp8SsOT1/eKnytMKOMcEitFQrSZkxs2FWnB4MZBRQdPmQ1s9YXoW3tCRnmUuNv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
Received-SPF: permerror client-ip=2a01:111:f403:2415::609;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On Tue, Mar 18, 2025 at 05:22:51PM -0400, Donald Dutile wrote:

> I agree with Eric that 'accel' isn't needed -- this should be
> ascertained from the pSMMU that a physical device is attached to.

I seem to remember the point was made that we don't actually know if
accel is possible, or desired, especially in the case of hotplug.

The accelerated mode has a number of limitations that the software
mode does not have. I think it does make sense that the user would
deliberately choose to use a more restrictive operating mode and then
would have to meet the requirements - eg by creating the required
number and configuration of vSMMUs.

> Now... how does vfio(?; why not qemu?) layer determine that? --
> where are SMMUv3 'accel' features exposed either: a) in the device
> struct (for the smmuv3) or (b) somewhere under sysfs? ... I couldn't
> find anything under either on my g-h system, but would appreciate a
> ptr if there is.

I think it is not discoverable yet other thatn through
try-and-fail. Discoverability would probably be some bits in an
iommufd GET_INFO ioctl or something like that.

> and like Eric, although 'accel' is better than the
> original 'nested', it's non-obvious what accel feature(s) are being
> turned on, or not.

There are really only one accel feature - direct HW usage of the IO
Page table in the guest (no shadowing).

A secondary addon would be direct HW usage of an invalidation queue in
the guest.

> kernel boot-param will be needed; if in sysfs, a write to 0 an
> enable(disable) it maybe an alternative as well.  Bottom line: we
> need a way to (a) ascertain the accel feature (b) a way to disable
> it when it is broken, so qemu's smmuv3 spec will 'just work'.  

You'd turned it off by not asking qemu to use it, that is sort of the
reasoning behind the command line opt in for accel or not.

Jason

