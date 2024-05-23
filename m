Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F513C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 13:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA8Id-0006dP-LT; Thu, 23 May 2024 09:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.lu@intel.com>)
 id 1sA8IU-0006X0-Fr
 for qemu-devel@nongnu.org; Thu, 23 May 2024 09:15:57 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.lu@intel.com>)
 id 1sA8IR-0007SH-MP
 for qemu-devel@nongnu.org; Thu, 23 May 2024 09:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716470151; x=1748006151;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HrkdM+1A8RvALrbGZdU3TUDSjTsIAoHFGDedEF9BsEM=;
 b=jqR3JCqUkWZEfET5mSRpaRoljqR9eXRlVcpx68ohHV8YalJuWHM9fyNJ
 PfsIIcfxsit6Uvdr2Dke1JmYXfVJ3AcvCeZmlJWRXBkx4/sKmrRoHEyJi
 wb0TeyDkJYokUHpQog7djJbuAs4GlZlZ6mpSfj5MVSh6PAYrWtFv5xx5z
 Zhp1RvAPpZ9B6X2IBw/uY0DdUS0HSSyDd2uQ+lWmY/iQVAiCybYN0gFpD
 eZ5NjyxvFuIIXK2LZgGEhX2g7/bG6aPTX+wAwJls6Zgr34p0vRH4ZYPZ5
 lNO0AgE9MKNo5T/MaFdvJkOur3jBSykfqoNFJPWjeoPaabfbyytPX+od1 g==;
X-CSE-ConnectionGUID: MxzDN0vAQC2KMxlAOj+qLg==
X-CSE-MsgGUID: kqtBwesfQuOmRdcIggOf+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12968128"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="12968128"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2024 06:15:49 -0700
X-CSE-ConnectionGUID: tSb8b6fIQfelpOQj5KOsCg==
X-CSE-MsgGUID: 5DkAkov5Rk6kaGysKi7fSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="64878482"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 May 2024 06:15:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 06:15:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 06:15:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 06:15:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 06:15:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpuYBT74MhHNvjFx69MGKiatyxjCk9y/v0rsY0PY02LyjwQlEeq4Foqi/XD6BZvdp+xw7U+PULxd3p5JGsfJ18bzz46w4yG2ynItGM2wiBvJbrsZTiDwiFOUP5aoL1aPGxcpS9/dNoHNup/TfRJyxwk7Tn45/Ozj15eg2Z/eK2qkjEh0oELKqyjPAxyH44OdXD9Eaxap3ocMOVfwQtkTyOOCKoKYXLIH90rKuCBx+ko9vq68lQoB3Za2WFLwMr6igmQEzApQhPUG12mS+LxszLwpvt8XmkqLoqqKR/5X9bUqcG4d6QK3UvNgDDE/1vCY3dzRUAC20R+Z+ENPcBnqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efP7xMFx+fDAFRRFjItl8EIDUzHJDgrCVXPbOeq5fW4=;
 b=QkYC666rgfjD19G8tk04PB4U0+hy6Mha2n5kAEBPmMvecA9RjFnYFOY+CNdm83x8c05uBM0P1Z8XJweNw9O2LLrZelvv8T/qUc5Bq4342GjXV83uGOKQ/J0AGvXyO/hf14xJFAVA8EDETcWMenMi30GKt+md8t3Or3d2f++koPC2++mqE0RhFVjaFIIciaxqTAu3IYKxc8mak8JSowLNP+6vZEgJe8S+UHhViASukUGWXZU4CkfRe3BEVn4XdRYD+ljPrUQWbjxW2q0nUJQB/f92Dg5FnGcNtzD4kfY5GxoMIrmkXAV4+ne2fpZeUQ26lkr/1q5ZVTDKVNABd2NdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB6985.namprd11.prod.outlook.com (2603:10b6:930:57::6)
 by CO1PR11MB5201.namprd11.prod.outlook.com (2603:10b6:303:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 13:15:46 +0000
Received: from CY8PR11MB6985.namprd11.prod.outlook.com
 ([fe80::77ac:889c:cfd9:b9f5]) by CY8PR11MB6985.namprd11.prod.outlook.com
 ([fe80::77ac:889c:cfd9:b9f5%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 13:15:46 +0000
Date: Thu, 23 May 2024 21:15:40 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Juro Bystricky <juro.bystricky@intel.com>
Subject: Re: [RFC PATCH] docs: Enhance documentation for iommu bypass
Message-ID: <Zk9BfEcKLsZA2-4F@ziqianlu-kbl>
References: <20240522074008.GA171222@ziqianlu-desk2>
 <20240522051403-mutt-send-email-mst@kernel.org>
 <Zk3mRaoDGRj6Bw8J@ziqianlu-kbl> <Zk88E2F9WHFa8iUo@ziqianlu-kbl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zk88E2F9WHFa8iUo@ziqianlu-kbl>
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To CY8PR11MB6985.namprd11.prod.outlook.com
 (2603:10b6:930:57::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB6985:EE_|CO1PR11MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: fe89d556-34b7-4fd2-a9c8-08dc7b2a751e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KlCJKMvrc/gzooVsOPINquaOYkKeivIMRN8L0+eYToqoKsMNKnLWs8ZyW2hq?=
 =?us-ascii?Q?wiyzoAsaCFBtHN4bd7WkNPx9k0fgzPPno/iOLWoLojC9u7GBB1SIqJ0/glRP?=
 =?us-ascii?Q?j0orJAJVqfBCpT065KZuPPTus/ieZfCDKp86xI/ifPowgECGK0OPkqhKAi07?=
 =?us-ascii?Q?+5s5vzdiJlrmPHH0m8g4bHRsChKpGxNkkOkTKvXuhwrESeMtO4z/A7M6JkgR?=
 =?us-ascii?Q?U0OGAUo9peyAooi0QS4qIZp0IRDluE+cgDdNHzvX3UDB+90TnUBPwmT8pD0K?=
 =?us-ascii?Q?tPUzZJnXxE3D3CYMNuetT336zO8vbQW9J87dd5J7HxyxvDaQITAWTxxNd59A?=
 =?us-ascii?Q?NDySZGOymLRHSH4l86V7wCaooQkKNbpdRfA0S958mUH7sLXkTAymIVDPRgYM?=
 =?us-ascii?Q?YxkndLCVhozFgHj+ZjdvyomwWEyfh6hL9F7WnpzxHWp/C+sOIaeLfRZoMIzl?=
 =?us-ascii?Q?x61YicHZfelSp5hUcvZiOQL3qa3SA/AWegohUlI8v+fRZU5Bzr92BAuQZ0yT?=
 =?us-ascii?Q?BkAg18d5Oxucr8614sjezDLIERgHkVA1eOOG+swMqSYA8hsICz5DwjYa9QAm?=
 =?us-ascii?Q?o9OfbBJnaUhd0BkshAuZ8bB1eTvE1JsJmizYALYv25IO4uSqg1cCFBJZX0hD?=
 =?us-ascii?Q?xq/RsT9MXV6JMQq5Eg0rufvV8uFzUjyjnIwUUn6oJQyd1Ic7fLcEVvbjpizK?=
 =?us-ascii?Q?/1c6zw/Q4TVDrpsc98+qNMaTTr0L/2h2ylfALiCMjT5182xCouk+JKf3h30D?=
 =?us-ascii?Q?Chmb+XiFT+YsBt7K+8sr5d1SrOjsMGOZiRAxoVlJTqmWlqZdRQPJZ1xYmm1y?=
 =?us-ascii?Q?ZvngFaZ8sVU7DqO9nn5lYalgX4sUGhFNcmhcMq4+B37iEqJasm5QIHAvHZb7?=
 =?us-ascii?Q?DlPPTZzVvUx50oKz94EJHEm3vjsyN4dfLSOMwHY/r3aEj/Z7dM+vqyChctyg?=
 =?us-ascii?Q?FUKxJwBxOtNVidCF0SkmfnGq67ptI1jUJtrFkaKHf68csUVolxtmfsPCYv75?=
 =?us-ascii?Q?CICbV6XryRe/mYPyIC23IPtaL7dz8l6vYnLvpNtYGsxFGQcG2YdQSyc7zKg3?=
 =?us-ascii?Q?fYyb3Yvw+22+Yp76YoJMm1UrRX3XI1aOT7k9h9dzmLOuMSrI7vS0GybdteoI?=
 =?us-ascii?Q?+NCQbg1UrUmcv1vMzhYMR/BsXVOq3mjlb6S8atWsiXfEZoQKPHo6ocKvwXCu?=
 =?us-ascii?Q?bk/VbyKjIYsveOfd19RhF25zYx+82ZTPU1wYsNjz7c5B2vBZA4zj+CIR0y1D?=
 =?us-ascii?Q?YovDBk6OfJQ3XfmF54DdYBi9t8UQz9qEZLJwXefcUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB6985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QkPpR02ST78N6XGgKLgcoxM6VkIg4S++8qdVDJMMR63LYGd+AJ5wxXzl5S+M?=
 =?us-ascii?Q?m+G4avBWoai1ZM51IYagZ0vt+zPf6n7JlLvOFlOL5t9wZI2VuMSjVrlIDTEj?=
 =?us-ascii?Q?0iu69mddg1Dz01owAWv5BGzcPLw+TMSFT0Bsc5IgCWFJ3LkabA085ijjUx/9?=
 =?us-ascii?Q?s4NYAIViEZSgpxqxbL9SDKzww7vPVwc34caNkq4hp93L63mBKRxldhWP1CBL?=
 =?us-ascii?Q?F0lH4tSFNJ01n3McfOQARRalIwwBepWERJj7qCZFVQH17JMTzYfLbbI3aADJ?=
 =?us-ascii?Q?H9fDwOxNxzmxq6h2IW/WF9CmYEuGf7k0ZEnu99dvZ3abUd3u4rw5IbuZHFrU?=
 =?us-ascii?Q?YJHiwIUif9NurTHEJUsgwSJzB//+EL5KBHqfQ6CVcXJ0K9ryJ82w70bzZv+C?=
 =?us-ascii?Q?H9VSxoTHfH4H1M7OpzL0HzSrL2pfbShMpoX0S1LbsNQLl5j+MUjMcn3eb8Iu?=
 =?us-ascii?Q?q1pA969oAFoH3fIrxKF6znhPBnpbrIcGjey8o4RxwT7+SuMXiQLOHQa2XTo6?=
 =?us-ascii?Q?1eJlnzNwDyt+gekZXeUDdLlI/3lQzicZp05n4e9F3uizbLx3MMWDa2Y02LXf?=
 =?us-ascii?Q?04LeoeNzUwbyTqkeFeIJ63aZ7xFctdN/vlBsOLtK64WoWpE6KGWFoiAGtr59?=
 =?us-ascii?Q?LD7x7Fb8iqqCLcT/qfzRSLzuuinxMqZKi/XfA9tcMoJOzIXSv3Ok8CXQdUlH?=
 =?us-ascii?Q?hrPy0OLOTQGB1kOiUEFd04waiPEX/Yf/ZUbMLWnSoyFPBjhAb7GoZzuKBxPN?=
 =?us-ascii?Q?ORCw/M1AfI2Px9ucURj6XUpXoC8BkZ3IdDyYJm6JlCqQBQfMKFc13UEM7lPZ?=
 =?us-ascii?Q?ba8SEfjNv8jMEygMqBvAm3EgCBUt7bIQVrxj+kcVK9YyhaAnxYO3MtCreXJj?=
 =?us-ascii?Q?y0FPm4Nzk9gqGxPHmUUFMwnWbQMABz/y36ILU9FHMcEU++0jSnfs9eqEZxfx?=
 =?us-ascii?Q?AmI7wbMuPTASGtd9zJIsMEedGlcwg8q2jEatwCxNceLGwMO75a0PrZF3yc4T?=
 =?us-ascii?Q?VXYBeOe7fpcHbXf2aj4g1fr2GCe/kZxWgJxchoxu3HLxhZzQGhRYC6YXwNBm?=
 =?us-ascii?Q?BeSWMhLTO2mWCI4UwWlit7pxh+0UYeDIFutjc0tK0MTC+tK6vw/Q7udMzkNe?=
 =?us-ascii?Q?L7RELquQ8Zroh2wm035AgnF+NqlGNiwfeZ15Z/MVH9vzLILxCzYQ/OpZNZ5h?=
 =?us-ascii?Q?e1pofOXiOY+0z+QOJynCdFYmUqHCIBu6hr0YdYtW2uuavkrviPw/lIyEcudm?=
 =?us-ascii?Q?A8hiHomE6oQCneFz9FVLPMA+s3RlBM4vE96nnlxusYeL6u7o9AoWNvxJb0XI?=
 =?us-ascii?Q?0vRSJ5JMiodJKL2m+55wJ3iTtKzKmXGFjrB5f+/61aWo2vypStLO+e0we5aJ?=
 =?us-ascii?Q?cnyV3v5kYmU0eYA9V4ecWmsBBvDIXsod7nfN3kkrq2GHAm/fCGdn4YtnDAw0?=
 =?us-ascii?Q?V5Ita143bGXfKTR5290/eiC+XQGzSKtN0d3QeMXWvQdpKLeYoZe5F8ZCOYkP?=
 =?us-ascii?Q?1kK1CbeGBPTDf1vSVfIlSIXQgpD04xEOOIMnttzjuYvt+PP9WCoTODXV8Gri?=
 =?us-ascii?Q?RbdvNCyiqV1jw0cUAIPJ5j5/PQu41PANyLD18gMD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe89d556-34b7-4fd2-a9c8-08dc7b2a751e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB6985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 13:15:46.4750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddh7HiMqYUZKpnTGsW8/mHcF8rn2OlR5GTVqylFKVE49WduAtDl2nqpqz53K/gRV7QrIj4RRIhtoNV2VoRUR/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5201
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15; envelope-from=aaron.lu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Thu, May 23, 2024 at 08:52:35PM +0800, Aaron Lu wrote:
> On Wed, May 22, 2024 at 08:34:13PM +0800, Aaron Lu wrote:
> > 
> > I do not have Windows VM right now and will report back once I finished
> > testing there.
> 
> Tested with a Windows 10 VM and turnes out virtio pci devices always
> use MSI no matter vIOMMU and bypass iommu are specified or not.

Just noticed another thing about Windows VM.

If I install the VM without bypass iommu on:
 -machine q35,accel=kvm,kernel-irqchip=split \
 -device intel-iommu \
 -cdrom win10.iso

Then the install went well and after installation, adding bypass iommu:
 -machine q35,accel=kvm,kernel-irqchip=split,default_bus_bypass_iommu=true \
 -device intel-iommu \
 -cdrom win10.iso

doesn't change anything regarding PCI MSI functionality.

But if I install the vm with bypass iommu on:
 -machine q35,accel=kvm,kernel-irqchip=split,default_bus_bypass_iommu=true \
 -device intel-iommu \
 -cdrom win10.iso

then the install couldn't proceed and it appreas to me Windows couldn't
read from the installation iso.

Not sure what exactly happened but looks like something worth mentioning.

