Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAEEE6B246
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 11:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6qFJ-0007Xj-AT; Fri, 01 Nov 2024 07:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1t6qFF-0007Wv-Al; Fri, 01 Nov 2024 07:55:13 -0400
Received: from mail-bn8nam11on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2414::606]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1t6qFC-0000vl-NK; Fri, 01 Nov 2024 07:55:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNtOZCY/TmrEdjkNeNDXUQaYRmht/Szv5lh21WK0Rwt2dAJAbtfIrq9xyJ8MiVy4jcxTvFv2UZ2+sItp00r2KBJgZy503nici/DxruC5Tc9tPPiXY1cQJnRwjdcjnkTrr6jCe8ISjGHZtGwpl9I5t6ZnEGx7MOCShoVXP27mo/6JFuBP9qYZooP2bEHx6vJx9JGWq0+eYW7gp9eQQB7aFrAW7I40Em9YY4wIo63wBseXDPUiwGyGu7t5MLtTsKvOZhUwMfGgnhnku4MtRzAl0l94gyQDfT8RKxk/vLlYu6koLa9wr18Es5yw8k0kmPLdODPxM6yIAB/ckzlMHD0rLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KKsJn0VnIZ+qJ2wPmfvjsS5rRYpQHRRmX/JxSf5Pzg=;
 b=g0jv1fvxAKXoQ5sE0m5a6AH+UV58fDCs//17ClToAmDpgwwC0I90cwvH1NtA9sZGaKKaHmN9LDpGFiDZMNrAOUn7VtacV3ObshJlEyZeowPWQPhs6RdhFpl5aaPVqn0YETvT4k9SqzsKA8nHN/QAAWCFyoCcLHZUyCWTMJZley1EMQblF7rllwD5k+1c7T6EDcBvevV13I6cxugG2QQvOqoKKGgW1eANohqDqQS831b6vRMsYmzieooINYrR9Kf/QLpOzwczXq5P5WAm+aQbBBPTgwWeZfyYzPtLp9AuGaxemyL+Cxp3uv++Cd2y2+D60WbWlUhh9FN6stUHK8qlLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KKsJn0VnIZ+qJ2wPmfvjsS5rRYpQHRRmX/JxSf5Pzg=;
 b=EfU3vOMaQJROgKeuapIA8VrHmWczTlvJnFz/AFhacaxoYh8kYkN5n0rr32libdn0qOOE1FkioOiFq2A1bBsTDndUNDaXsDrYufvvNCftw2ylzytP3PT0alZlfJMeSfWi/TFEc4ehJHAlDS8aDxYxvnYNOiyJ54s/LLODeje35+tkYQo9/TpX1mxeTyGkADEJqizpUfQS1ebHeTlDy5qa9a5Ct9o4IuyqS7Y2TbWcSuJXh7EilX2EMs5PuYIgQuvK+1nKRli9lRaJULniGNdoIp2jSxfooUe6JQrh1h3IzffXunAcaGybiOfr0zsuy8ZaeZsT8rXl7QrH19ddt/Ymfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Fri, 1 Nov
 2024 11:55:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Fri, 1 Nov 2024
 11:55:02 +0000
Date: Fri, 1 Nov 2024 08:55:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, Mostafa Saleh <smostafa@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Moritz Fischer <mdf@kernel.org>, Michael Shavit <mshavit@google.com>,
 Andrea Bolognani <abologna@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, nathanc@nvidia.com,
 arighi@nvidia.com, ianm@nvidia.com, jan@nvidia.com, mochs@nvidia.com
Subject: Re: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
Message-ID: <20241101115501.GS10193@nvidia.com>
References: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:408:f6::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: b01b525a-4057-4461-38d4-08dcfa6c04d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nmFG8ZRK7XAoLRV0pJ+mvhBRAbPNoCJBbcEE/FWyr9NJ7C/0Gw4JNlMGNRdr?=
 =?us-ascii?Q?G7FEQg9NtKYRt/TUVNeNT2CTKe0gfBLSkeIgsqkh1/s/1zTeSlyGYECTbllM?=
 =?us-ascii?Q?a9eU+yMqu5ncyaC1cAfc2zhkNxvimVPlZylxXt6IVh5WWGp7izX56x3U32FV?=
 =?us-ascii?Q?3uTLfqkskSY8dDDWrlZ1PLHEAUiUm6bM8sWJRTXX+PPKGN7ZAWPMvG1wV/wV?=
 =?us-ascii?Q?C8hl1VkQHk2wBak41+uWhe+xtVN+mnDQA93C7IM3tp7dC8tMbzzL0qtA7U8y?=
 =?us-ascii?Q?IDbiUQOkyuPyEDtWKRGAanZYSVxyoVirqtXHIK6eLGnOhrvcSO9qZjV377f9?=
 =?us-ascii?Q?bwXlAFdX3rXTJqRThBpWyc/3pyQKsqzHpUHjXo2vAdNOXeLoB3r9ou0DHSpb?=
 =?us-ascii?Q?PA1YwNqYHP4NHTJJtFWu4YhFJ34ZNU3bIToHm27Y2ilSXwk7NX06uPkx1GmK?=
 =?us-ascii?Q?ApINlwddPAsPVntF/7YjL9K9/J5pohuVe31gPETwnv9pRUfvcH7Dfm7gaLi9?=
 =?us-ascii?Q?8NILm7DJ9v8Y8ESFZwX/dbiAeBMJW1VXDJ4eCHE9GmUBl4vm4XQHTziFQ9Ds?=
 =?us-ascii?Q?m3hddoc4gEyzvfSzm5DgGbksgD43mT62PEKzG6S912JI2BkexSW4UtoZphrJ?=
 =?us-ascii?Q?/ZHs1+HEWglpnKSq5dP/OVP1Xuz5KXz8IDH0D0GgjP8tRXPS9AXk0uC7A6Ir?=
 =?us-ascii?Q?uUGMDcKREJtxdfMa9u4wGmBlEomGl6RYsdlsMG/EnH55N6f/NvbWWvYgMm0E?=
 =?us-ascii?Q?Tl8G/dVmt61ILhGpaPzaSRsFWw7C30OeTtogS6tllPSuyuCx9YyhQDwUnsiU?=
 =?us-ascii?Q?5zLoKLhJTckRh779hIOzESw3nf1T4sCu3NB3pWC4lXCtOdOjXUXPVc0CbNV3?=
 =?us-ascii?Q?/Idozzd9PZbTSD4upcyRMJbfhjWryktj/d0CRD8C/oEVZnkCjj3F2UOTg8xH?=
 =?us-ascii?Q?6BCioq/DcPXGF3OOGNYjB3IYQoLTQthYq0+YSqIJuzvKWEjYiN98H2quwvco?=
 =?us-ascii?Q?kb2kfiYPcTWmPTyke7eh9hszQzQ5FYcqHVVAMUy9QWZw1cf+kXP6nlWJlX+i?=
 =?us-ascii?Q?K/Xaoo2UvLhpwYYwXurZ0CCPtNC7bQUOlryGD0HB3XsUi6wjL0MeE7C4AiBe?=
 =?us-ascii?Q?9gN11dggwEZLWwwuKmhymgPud+JCXw9upbmeIJkneoEPvhPRguGlG0+WxVgA?=
 =?us-ascii?Q?kC1QCAoQLMYLWQVMA2ndMGmjGKC0f+BCRHfCGZZUCH61qrscYtEQnferGRtH?=
 =?us-ascii?Q?rIuJj3bSaoFsKtpl8ww1r2g81WMFXAkdwSCcBeCOuHNo/8zijLwu1gDYG1qg?=
 =?us-ascii?Q?Rjk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BC4yO265s0IttQxuUVR+IKkBK0eZY4O+a7H5ByvuPuqwvmIVaxe9dMC7g1jz?=
 =?us-ascii?Q?GroLTVlK2WzwdgY1wPyuM9VEeGjq19GY6SyK6TkgDWgaTSKUSUiQNCTyh2gM?=
 =?us-ascii?Q?2fGEMJOVhs2uIQG+Qe9LQaVBFr/uFsvbdqdBHK3SrMS0O37VZ/QNojWEa+E5?=
 =?us-ascii?Q?jXxn9xyGzDgKZdx3iciSBYA2ZZJGXLxIGpXscPCcluZ9pe7Y5ZszS3yfT6oU?=
 =?us-ascii?Q?oCfcu+TwJZDvZcMoGavYR2oRKybLTK0gJLBs7DYbjVx/V6X3/hKhWQRN3TY9?=
 =?us-ascii?Q?4Mp0/XBs/59agEDGNqzoqcgqkOrItBwIduR4ZASS7CMkith/yhoMbkeHZ8Be?=
 =?us-ascii?Q?Gfn9QAS8XVYJ88n9ShhG9DSPC1yP9b/JYKCT/qMy8B46eWgeaCcvnp8ox02v?=
 =?us-ascii?Q?nQR1t4zsJN7XPnZQU1T6ZZZ6yi3rrbwWPLiWlHIJbNYUk2BymFl2QzmmPtzI?=
 =?us-ascii?Q?FAsQu2Bmrh1RR4OpXzV/AVmZN+90hDvYX/OTHWKAqeyGHnecWdUZMBF/VDN1?=
 =?us-ascii?Q?t0VPpgr/x5oCmwdalY9peBB3Gwa5J8ZD8cmz+hBwRAj38YuywGOjURgsfMt5?=
 =?us-ascii?Q?ETzql1cDREmn/ag8veB5tFe9tVucVd40PP9K0x/VoJDiRWM1jacxbLNqhtx8?=
 =?us-ascii?Q?yiSJmY2PXFsR6+NqBwr9XSPV+FGcbxunTIKh34oV7AaBKbak18SI4IrjdgkS?=
 =?us-ascii?Q?PeaADHv+fBuDhmXzxNiFamUz2vpGXvqLKiQJfT6OsntzZ1duz2xox6ELECEB?=
 =?us-ascii?Q?PzaFz4uwInMnzFLvn7exaFEi5zFRLHcx8zZcOL+FvjVIfk3uJJ3jxnPLgNhH?=
 =?us-ascii?Q?v0MaZItATkhw060ndgfiA2T87NhWOGKOV/v33ts9bHLjT4zUzZ0JSHq1UYus?=
 =?us-ascii?Q?sG+/xR4AZuKnS3GBnq0kOXvIPVyQHyuSLt7FpKE+RlrVWu4M7EyspAlG0CjB?=
 =?us-ascii?Q?b7e7LU5RZXYDLoqz5YCGlDjCO3D0hpKcFwgcArpvCcieI2+r6jq2sH8dKPaB?=
 =?us-ascii?Q?+Pdtc64lHJes2gbXPV0wZnOnvi0CDqmoDpKEZtIDi611/koQWXZeyY/UByOB?=
 =?us-ascii?Q?5CE5K66wrPlVY8xfDB9BoGI6iK0tD6bihq4AQvUHhYC/TYcO0vbT2jayWQuP?=
 =?us-ascii?Q?m/k4EXSHx9GQJ37e33yYESg8e0ly0M6nMeR1JsifVhSzMb+d5862mdwczFMr?=
 =?us-ascii?Q?EQBV0bt7VKaoLwygtWkQN67s7Wd+flo+QOT0VEADDRHV9evE+dom9bkOpJYQ?=
 =?us-ascii?Q?lePJOXop+mg4SiiUGQdjDEfEA79meb8MP03vmkGXXDucC2LC0+UO7dbGbumI?=
 =?us-ascii?Q?82Ww2Vd67929wXIn2JQ9XfpKLVgcpOKKEogcb8ZDSKrDUlvm9KzQ+Xuc092v?=
 =?us-ascii?Q?ufOyYi25t4T6OySGqwFu1YBwiOvjv0Z4gOLzQ7IR4nbrjNvRy4xHTVtK5z7h?=
 =?us-ascii?Q?CetttMp9hZI4AoesbF9nUduXmyRI5ByCaVcOlLOd2D65t6t1FkwfbaNOACki?=
 =?us-ascii?Q?5wVBLteC17i2l7Fd5qeOz+ea8bpOQUJ1C19/q6oaa4oQY9NLw62zI2ozjwdx?=
 =?us-ascii?Q?987HMZ8diJb9HPVi5DY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01b525a-4057-4461-38d4-08dcfa6c04d2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 11:55:02.6200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKgK/YVSevXGPmlVhEJVCagBrl7HBPiS9eUhcsehoTgyTqymY7LVDrqUYqgg+V3r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725
Received-SPF: softfail client-ip=2a01:111:f403:2414::606;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Thu, Oct 31, 2024 at 09:09:20PM -0700, Nicolin Chen wrote:

> FWIW, Robin requested a different solution for MSI mapping [1], v.s.
> the RMR one that we have been using since Eric's work. I drafted a
> few VFIO/IOMMUFD patches for that, 

I also talked to MarcZ about this at LPC and he seems willing to
consider it. It took a bit to explain everything though. So I think we
should try in Nov/Dec

Jason

