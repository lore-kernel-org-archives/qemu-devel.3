Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD931D69104
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 12:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGdzM-0000GE-VK; Thu, 28 Nov 2024 07:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tGdzH-0000FE-Td; Thu, 28 Nov 2024 07:51:16 -0500
Received: from mail-bn7nam10on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:2009::60b]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tGdzE-0004xi-1B; Thu, 28 Nov 2024 07:51:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twGGnD5ylq9HJaTLF7yLJTN2H7ddKWIekNLrE4kGE0llAZLeWKAQ5Yw3WmC70LXObncOkHxCjKfBog3Bre02ApIg0fSchYWPaOpy1wuwduKdWuhQPpFA5JzHGd1NjCzff4+cvwN/qtmlTuYfBzP4fwH7mM0x7s15ehfEr0S9vMJA69bCiUtNZum+rM30IMiAqmSytSzlpBsB+fa8Gbx7X+dTorJrrcemOqjix5T4dRNKd776Yp7wfj/aA9c6eOaJssHvwXCt3GThlCs9YZhMFP4Jqq7Akem5PCH2zLnT/xCnOSmsXvFv8ZzKzZpCwXE+oxvDYE4g8/BYH9Z9z5UJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9B8cNvV+U839EqTD3Zc5EaCkf7fYkH0SQS6ve1kr6TQ=;
 b=xNofgczaOMF78o7LbuJcCeFghgTn1ulekkFpZTaSWjXvZ8dVDJAVEilzXEitALiBSYWOYgi03GW7igr/SWcKHIqzZFGYYx2qviF17Xicyn6CX7beMZnH5dxxuEM21ZPr57XDh5ZJTbPV5XFhK+U7MD/fWWL7Gj+madpOwF9hwCW01rincaQgbiNNNzmOUXNXtvbaJYFScRmAR2+IfUueQfs7yjuLF+MtEoogmiE68hNKE+OvfMOgmJ6sojoV2qtikNKqHarNzyRrp6p6Bar9jZ5oEkBxZIGkJAIQInacBt5UuRFTzH4DnPDBBy6fJJ+F7B+g7rBuFBCT0UCsM4VVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9B8cNvV+U839EqTD3Zc5EaCkf7fYkH0SQS6ve1kr6TQ=;
 b=Wi2Lf+7GEMgaDCNBWJatjaSwaTsp9+VCoPNGgAXHBaCAA1vJkvMFzYxHXRya81TPDYF9KrmquZRpvdzbUUUwSWIWU8luF+eAurvT5GcnbE7mWRnupf6YQKU6yMAKFRmpsCXQrDIqxGcKmSGCBVlWi+OmafTQkAlYZPxpNJRIKtJFvT4u9EZUUwkzzmJ/LWRIq051/1CMvpOokp/iumQPZ74yazDtMa7+rLhocOGAztrrg2KqpRcLR8UHZ5P24f6bBgBDZlEKjaIn/NczOOQnEUp1kaRQizTY6Jt8oYg0tmD28aP/ujLBVqdB49WRWRNjl69lvfBNu2OYfpeqAGxXEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.23; Thu, 28 Nov
 2024 12:51:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 12:51:06 +0000
Date: Thu, 28 Nov 2024 08:51:05 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Donald Dutile <ddutile@redhat.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Message-ID: <20241128125105.GB1253388@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
 <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
 <d8fbaa677771425dac985438b4b1db59@huawei.com>
 <20241127160031.GA1253388@nvidia.com>
 <9a62fa8d-a7a0-4bc1-bccb-2fcfaa119d65@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a62fa8d-a7a0-4bc1-bccb-2fcfaa119d65@redhat.com>
X-ClientProxiedBy: BL0PR02CA0131.namprd02.prod.outlook.com
 (2603:10b6:208:35::36) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: c0bddc2c-028a-4718-fa17-08dd0fab52bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xed4DyACX7B/BAobuPLzBNYTqEYkVDNeCpGPZqPVWM0FQ//OpLGNJ7+cHMBo?=
 =?us-ascii?Q?dVdAl72fKW5byu3pti8AEPuj6XYSjnRJPw/5/WSeQNaw4HWxUZxo9dSt1TV2?=
 =?us-ascii?Q?Z4tlGG/lnaV4Wn8D1p5TVi5AoG7W91JhNlJOMHTyssAPn6xtJTOwIrVzx4F9?=
 =?us-ascii?Q?ARkh6EHtD/8u8q8kID94TacDtx3nM097Qv2dozs7ashtqz/B1heHPtly2hSC?=
 =?us-ascii?Q?Mccdc9fJBayKFVwnzvl3/mEcXPxzkHzposAs/XthM3CBYO0IX3CzBI1VBqWh?=
 =?us-ascii?Q?lQxZwtLGnhYDNnhMW/zr/oMnflxbzNUeLYcbMXLOWhVvh4HGmEXJAbM+alnJ?=
 =?us-ascii?Q?zEFenE6kzUSn7Gy4393L1LqjPq7vItFQUC18QpQsdwbAbqJibtBVj9uFkzB2?=
 =?us-ascii?Q?9NqPyMjKWVsUhKvrcgKzA7l9qOT9+/NR3QaGh9WUbv5jSjE8oTbEwETWqoa0?=
 =?us-ascii?Q?4U+HAjtvCD0k9CoZSteh1vxluP8VOUB1hHkk1QHQ+o9/993CwiBXYIZivUHB?=
 =?us-ascii?Q?KFcwX46g5bJPsM3c3OWnA5UBlnJ9LK6wsbvrs9suNR05ADhcuHpd5Wr4vP7l?=
 =?us-ascii?Q?QhNtqYEig0D9JoViiskw4FxOVzX6dBEB151qrAw2zx8jzj5vRPizDTrlfIqb?=
 =?us-ascii?Q?5zog2panI2o03SbNH3fbqPCFEM584h0U34qie6H4OIxY2aidvMnpSzDT50rD?=
 =?us-ascii?Q?LxJzvaq3m2OK1Dt06BwoLbG7p36IMT5jpTqy/JXmNYdFuAmv1+D7W7z9PFaN?=
 =?us-ascii?Q?aS8/dixpgS50gU+iIdRVTXjd4jiyT2TBNqkJ2rvfRe8Q5ifX2X/UjsqULnEz?=
 =?us-ascii?Q?2KYxmSMHl+8HVO2dItRUapt7mR3qjS/cOS3aD/7b92DCCil0VJUFuwKSIIAU?=
 =?us-ascii?Q?mqx4ut4xhAYojGTWHblLlWUJ4CgdHxD51FYtRyLFLyOEJUDtxbtbnPYib16x?=
 =?us-ascii?Q?ADd3ru66EDBzL9GQOCSFlcCPTp3eK4RXeNp0zxMH/f06W8WudG1teVAVZGFn?=
 =?us-ascii?Q?T5SYAVC7DhVzxeh5QseGsmguFwBp8fjq7pQW2Fyba3MpENZy34Re6fZVGhv3?=
 =?us-ascii?Q?Egm06uD802mkW13sbHkY7D7anHx4eFu5p6iX5OrECcGSxLUbIjwX2xzNDBme?=
 =?us-ascii?Q?LLNwV71VGfsqqeYWLkgraJZIqsU+vRRv+wzeu6S5oG45JKvNicti7Xg/QsrE?=
 =?us-ascii?Q?6qfPyotbUsIr1pqXdASaZXjg1Cv4ntPBxwpIW1j5BToBiKYE1Q1/FQ8ZYcQ8?=
 =?us-ascii?Q?yKHQgLHw5FDFK8kSF2+mSHzYuXvo16eQ6EAknXtkqpme9INSE4Ybfw2o7Dx6?=
 =?us-ascii?Q?YDZNjXWLCkCrP4iX1CWNUApp9zuVLFumbj2kEMvjN4gI2A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N8DiW2hn6vh2mJLyl0HU09gTTJcZ0iN9nUz5xUxv/Kb+7KsnUqUVOYGLzFY0?=
 =?us-ascii?Q?pYl0xoQo7/i6BMKgpkbveU/lWJ+0mTaZuRx3Sc0kjcLAtLKToVN2ABQPA1uo?=
 =?us-ascii?Q?ODegrXqUmBLzE1eKQPRrzHZL9yHEszRgSeZGX0oK8OXOzbQyjIJRUflf28tw?=
 =?us-ascii?Q?llopfiyl/doc4oqdKSsmpUaX6afrj9IFYXlyYLTElA387ZaYHTHHMonLFqnX?=
 =?us-ascii?Q?P70TYs97G63ZT6qVJS7becK0kPmWoLjOGEEF1NF9kcOWqxUboPLrw0mjihS6?=
 =?us-ascii?Q?WfXrFpH4MXPd/AFynbc8OFGzlrEIH+yqelk3RQQwfRZS9KZXvyLQ4pTJkOzZ?=
 =?us-ascii?Q?H5zYjXaFRTEg8NoxZkwE4zvQLv5ai0dAKPnkMil8DI/9z+dndMdHtCCJ5k09?=
 =?us-ascii?Q?kROlahY/U1/+JY2YK3TptoffxJTE5mcatngZrfCkhdC2ss8obQgKTwBvSiDl?=
 =?us-ascii?Q?IV1e8TI9jx1NyPA/iqDxE2eHRkrRR0fXizU5f8rBCdLAN3JAHnuyAmo5UxKI?=
 =?us-ascii?Q?urQ6Ztmg8Ra9HwmWBNsN0azIpGZbjn7mWya/qArTnWkP2xltJ8QnJS1DwOpz?=
 =?us-ascii?Q?vFs8qzR94JxQtk/jmjY02L1QnrJlzjEsOgPxUmOExxqaFMXq6zC1YydsLdag?=
 =?us-ascii?Q?JEwP1dL2NYfUqLIVPuHAp5Eb1dz5UinTu2RVX/WwULLYxx3+BDRYDFJjbK+N?=
 =?us-ascii?Q?sLLWgWu4P+eVxicJJ05ka0TFat3SvcnMEO6XuMrz9NoSvLPgqLfBUrjHiYsU?=
 =?us-ascii?Q?DZdnHOhwIOTk+PUB09OcsyVg78jynt0X408E7m9D4wuJtkhC5L9YIKVoTkgB?=
 =?us-ascii?Q?MkFyUzN+BOZo74+UKYJ0WBslx/FbGHMGhO5jcG0tl3Shiwic+Nf4lVrQAjVW?=
 =?us-ascii?Q?OwcVYbtDsWGUJjCng8jsbxOGioOGm9WDWssDDBosMmgBxnIpelOUjqBYzdhl?=
 =?us-ascii?Q?dAQ6xwFxJl0EFFa938i8L/KIBJFXIlnWtQKxwLh0v996WvUoip6lgmNRMXfT?=
 =?us-ascii?Q?ogPVJMjaFT+gTWBSR9w5YGAxxbp1B2pq6FiqIXT7YZhFXMKEafXqyeKR0dIX?=
 =?us-ascii?Q?ZvB3zFwJDBZfd9Wg6jWOzv+yrtNVAZbt2ACb8yiYy0XkVQ3y/YSQRxPaVn6v?=
 =?us-ascii?Q?2YljuJK9MiXPDf+QEiA+OxyBGrjNMOzTwawP06vI7CkmeFJsl/+JJ5oCq/cT?=
 =?us-ascii?Q?aghWWFMltJOZLjHe1LRMwH2z6Fm1WTiKEBD/fMnaLTDpbxSglhyS/JuPlRle?=
 =?us-ascii?Q?QK4hAjAxi2wuXkCsFATfjDgFpqLZKyJHZmC0/0S1uebKtOUoQbIHkpG+oIMA?=
 =?us-ascii?Q?KMCcdkoQYATuKqlD7h406nV+Ac+W9iDEMqy0VwNs+wA2+a2BYfREUJr7JEh5?=
 =?us-ascii?Q?rROtKp+ZdTYoy99aSlQM3+Uz3MzpLqKzPufum0r11xGGGaHT0mXFzGej5PGL?=
 =?us-ascii?Q?4TXj6I1imx7GBpHZlBkdw6YE6m+eRjnVxxeYMDuB7GSS/2p516v/35HN6pQs?=
 =?us-ascii?Q?Z+/HXIy7giFYhPvEJimE6GNvpvKp6GrWJbaaoIE1Uey0VwXyhPGDzVNHCmr4?=
 =?us-ascii?Q?sCYnQQvd7RGX4mGT1h8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bddc2c-028a-4718-fa17-08dd0fab52bc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 12:51:06.0100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQ68abZMyQcxEX0L1RiINpRVRwykhrB3/umCBMJXz14sAt9nS+ifZphIsAkIK3Z4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141
Received-SPF: softfail client-ip=2a01:111:f403:2009::60b;
 envelope-from=jgg@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

On Wed, Nov 27, 2024 at 06:03:23PM -0500, Donald Dutile wrote:

> The association would be done via the VMM -- no different then what associates
> an assigned device to a VM today -- no hw-level (VM-)ID needed; a matter of exposing
> it to the VM, or not; or mapping the (virtual) CMDQ to the mapped/associated ECMDQ.
> They are purposedly mapped 64K apart from each other, enabling page-level protection,
> which I doubt is a per-CPU req for lock contention avoidance (large-cache-block
> spaced would be sufficient, even 4k; it's 64k spaced btwn ECMDQ regs .. the largest
> ARM page size.

There are commands a VM could stuff on the ECMQ that would harm the
hypervisor. Without VMID isolation you can't use ECMDQ like this
today.

Jason

