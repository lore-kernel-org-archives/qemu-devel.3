Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08CBC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6AA-00079x-5j; Thu, 06 Feb 2025 12:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg6A6-0006zn-Pe; Thu, 06 Feb 2025 12:59:38 -0500
Received: from mail-co1nam11on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2416::629]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tg6A5-0001L1-19; Thu, 06 Feb 2025 12:59:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oggRC4exppHu94HJfSAVLFg9E1uu+x9W7/ho/uZ08GKCNkqAlsrbQG37O4w47DvmFU02hkmszqdLGXIUmRRXp9E7Vz2pRL3t7y7E2bWwoXSMZVuxpHXkWesGTvKuEs06wKBERsS/ONbsDu4BQLSBjXaGs8u0fW3BaFCoUalMtoVjwKkExkkUbI2Ymop72deYp1KWiPPRM8OPM5dgNsoDNXMqb8mhMbOHwB+zTMOeYN5wKsJ2WHYxJZyTmyefJ+zrU3M/ZzNS0X/P7qx3lwkywa9+/GkUkbL3my1KxPGD3BmQwNnsWjsE8lZdlmZ8rYU0H6F33+OMLiuwduK1GnUZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpyh9nyvMv5yttIT30ryFikdi6PpSDzOwhaCsQq753k=;
 b=MFhXXowaVC10Xg/0XB8KzlTBFvVQ5xiWxcLOmRhqxOJkmhTF/6uu+gydbAUZXTZi8w0C3GyQDN8GgX9OC4VhZ2wbaw+Fu54Ofwo4pWVWpJlUx463Fk1XFO7n5vohhrhzNSvwfzznTXavvhom4Cksv04vhG5g4qNBOnvtFYbeWp2MLTYCXDFoQt9QKg0MshgD/4KWZ3W9E5uLifKkhNbS5GxpS+svpJ1SRsqOGGVvz75UgBpUyLF0ppxNo+kamzlEJNajrWLHWq2NwcShcMPmEkkHpjrtn5ULDFjycnD9EqS0fz+wN2O4kUWu07jffIqS3lpfxjpCz4OtJMcUZNfvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpyh9nyvMv5yttIT30ryFikdi6PpSDzOwhaCsQq753k=;
 b=oeW8EbUbnczdZSKUaveWlpbcFUH/+VRva1haPVHywzVEQzGsl9FN6ckkpFIL5FtjjPRUR0ps6+6NYGWS0U3mr5lfUjyud2cPzznkh+5xCK2g/qCiTu1zkNllASciMs5cxZ0PmmD0sJSeqdX8EDGW3bCHyix8iy7wYmNFpJvhzhazWYVLkE82vGwhf+IVZmNAr4JT9NItj846b6AmNAUcAKqWawp1IXD+QnqnfB5jvnzWXRUoCe3V15ZqfG730pBEbZ64iiUgXvlyVkZqcaU+LJ+3UqBHqBAKp0eHbP6rudDW8+KYirfiqtv8hFR1bxJWekO5+JBV2TKR5+fbmeYogw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 17:59:30 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 17:59:30 +0000
Date: Thu, 6 Feb 2025 13:59:29 -0400
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
Message-ID: <20250206175929.GJ2960738@nvidia.com>
References: <Z51DmtP83741RAsb@redhat.com>
 <47d2c2556d794d87abf440263b2f7cd8@huawei.com>
 <Z6SQ3_5bcqseyzVa@redhat.com>
 <f898b6de4a664fe8810b06b7741e3120@huawei.com>
 <Z6TLSdwgajmHVmGH@redhat.com>
 <71116749d1234ab48a205fd2588151ec@huawei.com>
 <20250206170238.GG2960738@nvidia.com> <Z6TtCLQ35UI12T77@redhat.com>
 <20250206174647.GA3480821@nvidia.com>
 <eb4375c4ca914b1887f5f8a501b93354@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb4375c4ca914b1887f5f8a501b93354@huawei.com>
X-ClientProxiedBy: BL1PR13CA0427.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CYYPR12MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a36687-269d-46c8-08d6-08dd46d80103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u/yHgcwuFoWmzZgKmHzLD65VBdVHJdNUpufAZ5d+wbBY6NGsV1GDZL2OQC6w?=
 =?us-ascii?Q?lg1aPwNgB3BvKq6Ivl0nYTUcl3vSGkBOkZby55Y3Nz+eT56oW3QlEEM//+VO?=
 =?us-ascii?Q?1nCTlQMnPmdAb2gUyv1rEd+kQVckc5aMmgVzocImfJ+SzXALh83gXaSWO3qx?=
 =?us-ascii?Q?PcgnHG3IVJxqg/YNqWmm4Tx/hfjqvdsfdcvvkxfl+rp0Yn+bzChVt+XvTGwK?=
 =?us-ascii?Q?+ecywnUk4MzM55N/EkZdeEFrI8kUlf7OzfCnRyo40mi9jbb/F2oBVeMGyrXL?=
 =?us-ascii?Q?7BqhN+XP9paFNWPU5QtJ+ov6/l3U3zAE5aKFzkCGgL5QLMlUKAerJolTcCM0?=
 =?us-ascii?Q?sn0TR77RqUCejLBHalSETjnyUP94O88Wxz2/LKT8LKTkAFGFOwSg29TAP8HA?=
 =?us-ascii?Q?gaobBQDr+md5XKsCVnJVxkfT+hWM43Vend9B8sGggcdgoJtvvSDimlvv1gP6?=
 =?us-ascii?Q?q3MtgsU+NRtMqkCby9tuycbydxf7y6/DyDPKQIHlPE3F2plzebTxILI0Ecw+?=
 =?us-ascii?Q?fgSVvhWX4kmAbbFoW7ZSMzRSwTcf+gloi1UTDdhzdq9OVQvF18Z4YLu4cIwF?=
 =?us-ascii?Q?SI4KPVYBKLviDqcR0pMqmMIoQA3ROSpCZ96jHLPG8jwRr9FaKHeBzfLNnIvo?=
 =?us-ascii?Q?/6jNmuVbl2I0PuYAY19bGr/oLj9jeUGzWx5MvMmIcp5tbS8LF5AHT57fjrzd?=
 =?us-ascii?Q?ZFnKbdkShptP4aH2SzH4X4qUj/u66EEzryWD1rGUWZEriMsa4EPLsOpegg6T?=
 =?us-ascii?Q?eunec63JAaOj7l9XcyGNV4WgHnXv3alJ5lKCAGmFiuhYxiVVgl0G/410YKiZ?=
 =?us-ascii?Q?nNfug4UG86UgnxtAz6Z1CoZzIB0bxcpOjfvCY0oONpUcY2NcwGZuQJCVlBRw?=
 =?us-ascii?Q?alA8nN3TBwA5n8b32BC966pOV5tV1mnoZuQr509bzF6w+eunvrvxS8x+G4VQ?=
 =?us-ascii?Q?ahtJxfqsbIgzDBKQ46O/qwrICU7KAXofhWxwm+Fzpe/nAfIOtm0UfTk2SZaA?=
 =?us-ascii?Q?Fd6yBDlggwPsSTL6N7MuwvFU9X51TD0e31I0BBHl0NRr1vGp/QPVVTjCKBjD?=
 =?us-ascii?Q?GR4G6xsFCDoGh5OkDImWf2jk8sFwnL+Xo6lStXXbQIM/paLslPFi2mvP9ETf?=
 =?us-ascii?Q?Z15hI3XYULAURyfz0QJpe4R8pgXLkcOwPrzQjaDKzYv+qPD4/d/T4x7DzwKe?=
 =?us-ascii?Q?uuGnitdEH4omn7u95OtJcVv0evasa3+EXfDqXKLaYEC1uuJ3M2ZSOJyyTu6/?=
 =?us-ascii?Q?jxQgIdc8fySs3AtrdGYUEPUO9tIgvezcpeqCskJxkfvA/cFcvK2MSB+ThO9T?=
 =?us-ascii?Q?PBOrSvaeBTi3wTOZdRSNgFahXFWY9b+iMZ2o4H5+otf4nlf4GLuQ4tnGu+EH?=
 =?us-ascii?Q?ozbbodww0CEGbYeTHrhthlk1F1m8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UVEDPAKi8WehUpGgYtAwNd5P+ezGZgXXj1c85L82qAcYUetI756QApZwX2sO?=
 =?us-ascii?Q?A4B6bDzkyOnpKt61OKRIvlYRm4FoNzfyZDFlWsHc6OWJ7KrpjwWeFEzOUW3r?=
 =?us-ascii?Q?PK7ACyU+g7XAUMu7uKCD6FZrHu9CqMW8wxkHE/tJwpYTz5DB7xB/yFQz8B86?=
 =?us-ascii?Q?Hso6gshR5I8DLjCpEwoopXKWuVCXi8IcOFhs7lCwnPF05wTPbtVubpzjvjjV?=
 =?us-ascii?Q?gtIfW9C5ty4YaW7d3lMWa7Igyw7cC3BKsB7+IWw59pjW3mou37wILEqeMiqK?=
 =?us-ascii?Q?62mN2YWAcdEJ7vuMXlPpPnDWWkQ8KpfsCjQyByk0wbUCtja9ls4amvKeICHF?=
 =?us-ascii?Q?0QtFBsbG20rcRSPXVWmjFFN/SUYbpTykovLhSo0wLePpIJlI6siKtmjGPGQ3?=
 =?us-ascii?Q?dpXZhCjKT604wPJlwRS6QTOVXkdwBB+sJuJ72gJWr4NBubMA+5OxPM3scGHD?=
 =?us-ascii?Q?6BcBTx1OvMvmiB6jBNVrj7XiBD0h9bkmt7NgKjeFW26U0MFmj59qJYSIR+vm?=
 =?us-ascii?Q?GsXBUr/m2qzTNV274cV5EJP7IbLJY8dXXDXzUd4KYvkrh91roqZyKeupzfFv?=
 =?us-ascii?Q?aDaDFhGnfzNO4BIqNfTtSXhh7iWCKkyCf2ORtomg3G8QCchRmEPZ1+kBG+q7?=
 =?us-ascii?Q?mfzGrOvBsFF37KAfw5EiTGwzEcDRZnLtzcCBD0qX1X+oUkkBHj/XXvuFtCnG?=
 =?us-ascii?Q?ZjkuLwPijRzH04S6UZceHnUXBzSCrRGclHpRyE/ybcZA4DRh4wpzFWdzOW6L?=
 =?us-ascii?Q?uUbX9M93FX6V4Jpv4g+A2+Hzz/FN0B3ZkLW/Ok1AVEleT/tMJpOu+oZ9dC8Q?=
 =?us-ascii?Q?5YtsN5nV2+NQ9HwtW2blDHfR6JMMifiwGXZfYEBAFsdDxfVQGDEg5kxA+txg?=
 =?us-ascii?Q?pZ/VDzxfizmbptwL7pJLjnDKKB2GjP1tUB15c59fGNveUlSnRkwbhzwloaa2?=
 =?us-ascii?Q?ZQ2bsOir6iHgFvk2GcOJPGytrTpep2Nqi95fWXgI8DKTLUoy5B2uFjPaFAah?=
 =?us-ascii?Q?2BlDmRRfTH7RCSSkIaUCgIudru1+rCZQEnHsezU2jeJANJk+rEGpf+00FzPp?=
 =?us-ascii?Q?A2UWHfPEkvcIDS9hhe/o4J3Xa/mWBZTAjg/BZMZY7B6pnr3WogCmEVvgeXqH?=
 =?us-ascii?Q?qKTgVd8BsL3te80ankvoJbcp1bFk/robIYg1qt6gO9lZJIYNPWsV6eWxBvew?=
 =?us-ascii?Q?ItFm9tA3K379npGc3WKYhydDwZfDBo4rlvyJszJ0PR2DTax8wMR7KPz83rPZ?=
 =?us-ascii?Q?J/1J8ik/Si33rX/9TGN67mX8MWw1AJli1mF/0WtDUOOuE0rji4N11BU7+R84?=
 =?us-ascii?Q?Fv2WbT/S0V4pDzq4N7rkweLNDvj/CJaewUeV68bN892L8EasUHWW71CMz6va?=
 =?us-ascii?Q?OMtXTdoq0moqLhL5hV5tYvFtJaczrP8gXbzp07EvC7IdEzker4djtXHdsfCN?=
 =?us-ascii?Q?VfR4awK2+S0J+Ucw5kMPmKR4LYzN3Dh75sSj53idSEX17diMjKregJWIRqtl?=
 =?us-ascii?Q?R6r/dLZQ9h2TQxoABuBTsjGAXkYIRzAKy+fnTm8NdToYIysQMat2IJXWWNHx?=
 =?us-ascii?Q?EnDH7Y47fdhVvwudI/8Affur6zpnjjhX2MuRqaHc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a36687-269d-46c8-08d6-08dd46d80103
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 17:59:30.1886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+eAMqk6Or73IJxfZjQck6A0NJOWWQrso0oIwsN++954uv1tjcYrumdMykyjWlLm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891
Received-SPF: softfail client-ip=2a01:111:f403:2416::629;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

On Thu, Feb 06, 2025 at 05:57:38PM +0000, Shameerali Kolothum Thodi wrote:

> Also how do we do it with multiple VF devices under a pSUMMU ? Which
> cdev fd in that case? 

It doesn't matter, they are all interchangeable. Creating the VIOMMU
object just requires any vfio device that is attached to the physical
smmu.

Jason

