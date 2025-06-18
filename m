Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CD7C7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRrCp-00031A-KN; Wed, 18 Jun 2025 07:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1uRrCn-00030q-4t
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:43:49 -0400
Received: from mail-sn1nam02on20621.outbound.protection.outlook.com
 ([2a01:111:f403:2406::621]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1uRrCk-00060I-Cs
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:43:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SX7sEE9cUmxq1kMPktZIoPqBIlGUM8cCjP3l3NKHcWzbLB0WYq/4FLv0ihHOxQEZZDgbp+ksanNGz4t2pyZuoW+XvTM03vyOJV9aRGf7zh73lP5iKb6szcq1fYw5AWUkPgzF35JGKK+HRvA2Y7k6QMWt3gVRtPA24O3O9q2oUKxMYGs/+13A8luTDoZG4ezn0awXyNPnf27DOObAAh1014uQF53wiGhk6HF7HQjVT/E3PxIZpxNxOA5+x7a3tvh2H8wCy6Hoe873mRYdQSBn7vvo6DJfB7+FUjrPAuxhytqq9VWF9AfyQAzwDK6Zhkx3epAfaYVQuSbUlS5f6Fb/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFT/HIUL/YiQIADgkfel6jOTQGKPmaEbcnEAxMwP7m4=;
 b=LwsHRtI8JZxYugk1LXJfCCAOKgCKHhAjRRTW4oZtFYQUOxiaGplq9kpFdFmIDri+UlM+YrjPvP/XB2S1e3SD0XEk/oj6OkuHrrkdDrcM4+tiUtDO4/A2f40My+MWQav0B59tQ9nrbf7fWDCArBAkC5fwP4qX+IvETcNFXtai9G1PwahoGPkOIuoRt/3gIG+hKIHZN+ENyd9Bg/8cdPbvLQbnbkKxqcCkD5i8vdKsN6mcr3no80b4xb//xq7PQjxgMRlOr+CiVq2l2rVKjZ4sjD2hY/8fEs6a/TVmWOeKhrEsaj9719HGwjc3W7PzEzrrX+waa0uC1pJDaWywzcOEjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFT/HIUL/YiQIADgkfel6jOTQGKPmaEbcnEAxMwP7m4=;
 b=Zz8r5TzzkBm76XfE+kpa6YbKbDQUP33BJqjr1L2LQizNtYx6VUWKU0sAkjOxsNY4nbADH2mF8G+Y9NZFxFGtfUHE2Lu1+r6/dvF6GMMai8ojsDKj5RvqchAoSTjNxCH+JbM/VNnJxCL4A+1FQtzSFfSkUpgD4NsLUYhHfgImzyd/mzNngue7jb5pYonZbXvg8eaGdOVZF5k3ySMYzqQHlony7Vx9f6x9X4FS90BUL7PY+gJWMz6m2puxIQKUvvI7It9WYKyxHGPM1ST6MGzwB7MyJcLSEsJZ7jGj1a85TDXBxnODnBrElFMZLNOdbtnG3ilPtcyTfwYDIii3eUoRdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 11:43:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:43:40 +0000
Date: Wed, 18 Jun 2025 08:43:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Peter Xu <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Message-ID: <20250618114339.GF1575786@nvidia.com>
References: <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <aE+wCIG8KHb3u1lV@nvidia.com>
 <IA3PR11MB91369A0E98CC76ABDBA365809270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aFDdkxPODYnyG0Vo@nvidia.com> <20250617123707.GW1174925@nvidia.com>
 <de5baefb-515a-47e3-9e4b-16bca4dbec5e@intel.com>
 <20250617131113.GX1174925@nvidia.com>
 <6a9f95b4-3e56-4ed3-b2a2-c41a6f728eb2@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a9f95b4-3e56-4ed3-b2a2-c41a6f728eb2@intel.com>
X-ClientProxiedBy: YT3PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9907016e-67ee-4613-3c0b-08ddae5d5ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mkoKKHgIhptO+pqS/Qm3MW0W+QblAibLm3P90xOSQ5TqVcrDXp2PmcyB55+x?=
 =?us-ascii?Q?pRnySeEZDMdgB8HtuCmL0/6fdPShIrGk/e0iFK1eMU0b8VYcB8V/R966T6uy?=
 =?us-ascii?Q?g/aMm3dAha54M2JER1OfcdMo1oMDIw8yJla/KGGqOl2kh2bMJWW7nSylmh1D?=
 =?us-ascii?Q?vf248tWJO/LfBwAgVTNW50RboRXjRj5vYguXZdj4uLIBB1JTyjuAonE9hnx9?=
 =?us-ascii?Q?qnS+7X4DE7QdeFnD6TUAkZDH5x+tWuPtN+J81sSytiUVePyNiiydULEdqgQa?=
 =?us-ascii?Q?AWItq9xDwKHcxL4E14dt9kHOfPtAzqi+JY4RecbOIlUJ1F8jdF+jZqNeqYfj?=
 =?us-ascii?Q?yNQAv6vvPPaauRMzU/QJpi66wo4oOZUL3N+wzYwonY1Rr5PwF5hhBtsP7kTG?=
 =?us-ascii?Q?ka9v4EUFgHrkgb2F6Jf4xogk6d9MHa9FWN50x2T26K5BHGZeymDUHiIUqT4c?=
 =?us-ascii?Q?3JZJjwFOfgHmhbbnZ0B1wB3k6N0eWVftUm13YyWnyhd1DCkgTaWRIdU+U9A/?=
 =?us-ascii?Q?IfPWJP0p0JprwTuGa2mK2Vq9ILZ8S1g1+wb4BxHv9JJp/LZZ9jg9sjaDtbvT?=
 =?us-ascii?Q?5xcwGlRdLKjuy5zmZ63yFjgqZsYmEojhtsvbVHcQNKySfzxBcCZlbflJ4QjS?=
 =?us-ascii?Q?nY1G5fyUrqMmDdx1x9HPn3RVpEm6UA3GDpVAZH49U+9m2F5gL5RpLuED/dEI?=
 =?us-ascii?Q?G37SaeMPstV4+fiyOxGgpA+DUlIYZXpKGBX83Jq5vHZIYQnJ5eeRCoEm0vjl?=
 =?us-ascii?Q?j6oezLmKile2Rl2j1zNkd72GOwBtih7GcKEujOHCVxvvvkbhNxkyzxbtXXF4?=
 =?us-ascii?Q?F+0eBW7vzj5FMT8wlmGiowBADGWhYmcFL3d9tXscd/YhE0jNtCzBeMV2LwZu?=
 =?us-ascii?Q?yHWrcfisZoTgR8Q32OWleTXW+G85fRj6q4rRLd8ssqZadgOObKXmUfAR+wlp?=
 =?us-ascii?Q?tqlyn0Qk26Xy6TEAjud1KdaVh1++iN+kmA8BdvvDErIPNOPxm3ETLVGOCrb7?=
 =?us-ascii?Q?90OFLbObfkM0h3mut1wnbD9kPVMH8BwzSvPmlMRJWCW2RBgQHCjxc76zAyEW?=
 =?us-ascii?Q?TOYASYaO7WUH0wiK/mpX0foa75iIZR8vC/XaQkuDJeWvtuPz8YhZxbs0VhIv?=
 =?us-ascii?Q?lPm+rEm6GfOer1OyHOZI/rdm+znXo4+JstTghXxt/UfJ61JzxNs3xZArS23z?=
 =?us-ascii?Q?bM1UOmxyquOSMaqr2t3xoQ87W9tkXGAYCkerLeKlsKolhPBDuh65D9/5WeN0?=
 =?us-ascii?Q?n3yf1ifxfXwTtIqJJN0xdMnKXMP43zEKrYFWurgyANWRkyvnBcaWt7rsSicx?=
 =?us-ascii?Q?tb8U+G6EWczjFxes24oag6oE3SVEqef4wfdmMk2clyqrydw+wjg4fsw2cc90?=
 =?us-ascii?Q?GE6Wqtw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?soXQWQG4fGh562xScmzdLSWy3iuTPr2nmyGcyBThG8Svpn/oGinBp1NQftFd?=
 =?us-ascii?Q?laIFYAsaUTsW5IpIQdareBUvY9MQcN+632IXfR7oxW0abNh2MQO9m1xVc9Ve?=
 =?us-ascii?Q?hSOegDUB/GEpwvlweqbuVnz3K3WXoKEAeoSQaGKmp6yohvpDT2lIDsN2/3pI?=
 =?us-ascii?Q?qN9zC1ueDFwPSJD0FlL3BgFyrkanIkNMfnYMnlQpBzjqmix0vnXwvQXeIWDh?=
 =?us-ascii?Q?KjzkvI5L8pm8Spq4MEbXLIes+Z0CB2TWXiR2ROXEhNgZemN8bji1IzNqN/OT?=
 =?us-ascii?Q?EfMnV01gIlNttThxh1ca+vIdmhokfWhoJ40mxqUHIGt8EM0TTi6gCUMKg0sg?=
 =?us-ascii?Q?zruAFg8UxEnNDuWHDoMrpohP/4gKObGSM0DqcslvXTe5lfCDjIFcfscEc9Ou?=
 =?us-ascii?Q?dUd7a7/3d2ZWVtDaL+h5MzNebK/hjNhrIZYrLzUX3CDu4Be3LGnkbmmv6Gmt?=
 =?us-ascii?Q?mIzVpZJlbNqcE5JVQ70GjlLpKsWB00bi1okiaVZu1n3dRUruy7FtWZ7F7gOP?=
 =?us-ascii?Q?fMXpusDlPU25oQzwkEMmq/sR12pWRSyN9sbG4Jfdr8Gh79bXMuO4QNBki7cx?=
 =?us-ascii?Q?c3JfIqV/B/pRMy2A93SFNlbo58Mlq6GcP0ohLg9x6oY2G0MeQkM4q8P3wF2D?=
 =?us-ascii?Q?uk3FPIEu4UJf0rrRUm0N2aD1kYOE1iT2lhLfJQnUEM3M+WtNNK8/iKZ3Lsk+?=
 =?us-ascii?Q?9U2OGm+msvR8ACb3qcun35px+rSAnFU9+Pja2GotOLWbBNG1mDWI8KP5kbL6?=
 =?us-ascii?Q?2wvo6ljzzJ8eeVTmPSQn4n2Ae7bT4ljBoK1z1SapGsQbyIckQ9IHjH21NKDg?=
 =?us-ascii?Q?0UL29WcuvEhEoM+z/na8nnsxRJHb2DyE+VhVq8ls7PO0OmQcZpFONiEGDqwz?=
 =?us-ascii?Q?rEKmVugcqPJz0fllgUNBifvNk/ASOhsFHqbjGiTOod2QLQ2uE1K8wfLdCBOG?=
 =?us-ascii?Q?ETjpn4Y6B11Q1SwLpKpdqtoDfK7PmYSLxnpEpliZltOYiNgqVEShOewVd3QJ?=
 =?us-ascii?Q?4ZBCSEHdvFQjBH4vZ1Xa1Wx2sZZZNBi8RRYCCqmkjfF6DiD5FlH5Eg7L9vH6?=
 =?us-ascii?Q?giDyKmnZSE7HfyjDooRbHhN4cSDy4RnksiIsdxzw3d60k/tvLnJeudkM3f1y?=
 =?us-ascii?Q?9Dnbsll4psvMkVy+z26FjN7xaXQhEmoq2u+im3Kvqa5nmYpBMIMLvb8Yr1Ru?=
 =?us-ascii?Q?Dj/wrhg35OjFToUPBEq13plhrvM4fcE+AqV4CdxCaDYrJrpfyxXGYUhw/I1s?=
 =?us-ascii?Q?XX9I47yrYkUw+zxDOFJUetWAjwIinX4OXEO0fTmFZwlzFTaNw0GSAlL5YvP5?=
 =?us-ascii?Q?Jkra54pWw9XGm+di2iHWh7IzkuT9SAeZ6kMPDsVzZZnqdyJgkccxn3PokrmL?=
 =?us-ascii?Q?9S6+i0GjTSPCReS2WLIj6x4dwYyu8Wig0UZ5vktjydf+hX3xsSYWFRKrZugY?=
 =?us-ascii?Q?6gXjVamTxlyC+DwA42d8X9ME5RWR9QV+a3P9cn0YjgTVCMpa7XammkoApHWE?=
 =?us-ascii?Q?PXWzXF8PvM256fSTJy4st1NAiCQPcd6Ner4DLuuLiOaQvHP3X/YU3LRAmK3H?=
 =?us-ascii?Q?O+qVRsW7/8pCRmPTyEH8ujwKus73y+Cz4AB41BOP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9907016e-67ee-4613-3c0b-08ddae5d5ec1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:43:40.4889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvEcvxlcljhtnzY2DwDMMxre70TwJIro7qDz2xQGje53Q71b2kmjYHqeAKBfJafc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
Received-SPF: permerror client-ip=2a01:111:f403:2406::621;
 envelope-from=jgg@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

On Wed, Jun 18, 2025 at 11:40:38AM +0800, Yi Liu wrote:

> Actually, as I explained in the first hunk of [1], there is no issue with
> the legacy mode support. :)
> 
> [1] https://lore.kernel.org/qemu-devel/20250521111452.3316354-1-zhenzhong.duan@intel.com/T/#m4c8fa70742001d4c22b3c297e240a2151d2c617f

My feeling is that it is undesirable to have the shadowing code in the
VMM at all, as it increases the attack surface/complexity/etc.

There should be a way to fully inhibit legacy mode, and if that means
old kernels don't work that's just how it is.

Jason

