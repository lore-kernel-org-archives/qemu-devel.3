Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CE8CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApA2-0000Oq-Sx; Mon, 20 Oct 2025 08:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAp9w-0000Fj-V1
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:38:46 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAp9o-0000jr-OT
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760963917; x=1792499917;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U9VKFczGUpgJJKVdHUnONeeyhdMiRQuvthFxTVkZPRk=;
 b=TalwQrUUJXHMe+J/sX9DT3KIzXGTYoWHsGYrV3EK8tQOnioYONSlWtpr
 KPkpt4bntWgiiM7qG5R/7A5HhH93AOJ3jd8o++S0Z8FR0Q8Y7NmYYEQM4
 j4VZTCRdH5IZknJGQi6Z1Irc4OMx3qpowy357sBvEsMhez/r4CHBnb1GR
 5jgFoHl0ZRDMFeNBkLmwNnVCkn97Nkq5WCsbt8SwbQy4SfgaGHfhMfqIX
 QzIAGTETpP73iLZTDb6ixPVTLuHqsHz93I6jTwQaivOYUjo78B2b/FOOd
 DkBIr/9xQ1WD0QD8qSVbFTTNLi3/9bNJ75Xs4TrMCyln2L743ZjdGr7YN A==;
X-CSE-ConnectionGUID: 8f/53bp3QbOpfH0I4uympA==
X-CSE-MsgGUID: HevqPIOGRgy4tGud7uZn9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62110155"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="62110155"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:38:29 -0700
X-CSE-ConnectionGUID: PW2nkDEnS8OX7IcsclBEtA==
X-CSE-MsgGUID: DTaKThMNSOmI80qhkOjhmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="183336515"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:38:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:38:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 05:38:26 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:38:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbfOtuBezjpGsukzNDX3Cl/TsRWW+auSlkeU5eHcNOYG18GZ+gPc85edRH6V4Xm4IJkj/WMB/OVJ/XBhk3drIXBP+wPewOts7oS4eAQBnVdZKUbCPAtvgyckeKOtj2qWmTGsRL8I87ievQaUqeYwGqnDnyoBkQPg+rpXKvzNMofBY3tRi0pIrMd9IPm1Qk8KG3TR0AGnyrid0BVD5f6cO2wgBpc06ayQQiEzT/JwfaNj/K6v/+h3r7yS/WpmePN+M5PPub+LMuMNrD6v2d4IQsHkOEVBCHc6nix7WkYdhN2GnyaFy8vRsiOaL+YfPdkVGTSZryZ2UMrG5ths0kjNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh5+fXTIpzXxB20AmzGpFRecWTsmfsvv1bgJcMMGywc=;
 b=x1xGhdrPA6Ms/n8Sfj6PJsRXaWUBjq2HZjYL4gK1Fo/3rwbX7k05ucA5DdM7ev8Vp+4FvyGk/H0GL8ARvO9p1wuECWUXDLSTuc1kh1B/7Ue/wFrStqw9dd1zqPbaUO5SZZxL38EquksMPtQ097Y8oT9RVGLPul4qYzMIEiu5orE7+JfD9gF04dZj5tuqrQ2h6lrj+GHlmtDJc3Gc6zcnBxG/PZUtH93oe1joM/4k5nxBd3RDIpVo/najBp2vF+2UTzWQjZ4C+7VpuIrUh7/1tGi7YcWSsTkcrHtRSHkRfKxUvdPbS/H3Ylinq6vf7Byo/HVx/RCSaGteu83ORlckfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by IA4PR11MB9059.namprd11.prod.outlook.com (2603:10b6:208:560::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:38:23 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:38:23 +0000
Message-ID: <e7cdcee2-1df1-40fd-8f46-42e8c75185d1@intel.com>
Date: Mon, 20 Oct 2025 20:45:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] vfio/iommufd: Query dirty bitmap before DMA unmap
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Avihai Horon
 <avihaih@nvidia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Hao, Xudong" <xudong.hao@intel.com>, "Cabiddu,
 Giovanni" <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, 
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-3-zhenzhong.duan@intel.com>
 <e620aadd-c70b-43d3-9832-0cc1fc9d7c3c@nvidia.com>
 <IA3PR11MB9136BCC9994E40C674FE495792F5A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136BCC9994E40C674FE495792F5A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PS2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::25) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|IA4PR11MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d741f1e-4238-4307-f446-08de0fd58f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTJQK2JpZng0UEdDYVdNTmtlSHllbkxGK2pDZnhQbElmcWR3UWhtTXFQeXBu?=
 =?utf-8?B?RmpLWXhYWFVvY2xIOGlhQ002R0JDSjA2OGRQdTNFSzEwNEwzR0RJSnRldnJ1?=
 =?utf-8?B?WEUraVcvSmFLREl2UHlhSlJ2alZRTWJpZ0xMUXJncGdMS0ZJR1gxeDllSFhh?=
 =?utf-8?B?NkFNWEtxUWFPWlZWQ2I4NERRN0w0ME1pZmZqZERvendrL1ROS1RVTUZHaURa?=
 =?utf-8?B?OW5HRDkzMHpwTUVPYnVCVjB5QmVUNUJmWGlaUGFaVXgrcDg4VW5zK1hTQ2l0?=
 =?utf-8?B?QlNzSFNUTDAvbXBOY1ZnMVBkQjdBRmJrMkRPV1hJWlAwRzJYN0NVVi9LT0Na?=
 =?utf-8?B?TkVSRTJvL2d3RFVZbHFVS0hjK3hnTzc2aXJUdkxvRllBcHN1QjNEYVpUR0VR?=
 =?utf-8?B?dEJublVmT0RhcVp0UVdyQWVGbldxQ3RPTzVXVTNmNVpqOXQ5ODJ6dmNiQy9v?=
 =?utf-8?B?Ym5kbE45MVVMWUl0TUlpR3pPc0V4NXNvVzY4WWxhTzQ1NEliMThZNzNWRmhx?=
 =?utf-8?B?MTl4Vkw0YXJERUkyazN0ZzNta2VDWjBWNUF5TzhaQ1FQcU85TjRSSjVmU2kz?=
 =?utf-8?B?ZFNBNVRzNFMwY0FQZ1ZmNUkxalB5TjdRZ1JYamhZQzdkWEZLL1ZQcW1YUW0v?=
 =?utf-8?B?ZG1CUUZCSjBCdjRsbGVxQkp3ZEJCc0pqSFpmWlZ0SUM0MjJ2NU1WV0FNcm5C?=
 =?utf-8?B?cWYvM2ovUFRZbHN5NzhjYnJjek5JQklSbmo5eFhHdnBjcE14NmhtMGt1NmJ2?=
 =?utf-8?B?V0dXS3Bzd2IyZCtLb29sNkw3ZHdEWEloNnMyVk9BbmZsRjBHSXJoL2ZvQnRv?=
 =?utf-8?B?NXpSM09wbU54ZW9mMnhWdndVZkNnakJDNVZyZ3BRUUhRR0N0TlJJWUtRdzB1?=
 =?utf-8?B?MVY1aGtnM0pUM0JJVkRGYVV5bzl6NC9BL08zQVF3Y21ZTTFLL3lZOEdaZmxD?=
 =?utf-8?B?RDNqNVM0MVlsajdjTzltMDM5NFNYdENha2w0bUduenpEV2htNEhhR213ZVZY?=
 =?utf-8?B?Ym10cXdsOG5JTWttdEpqUTIvU0pMVVNEQjFld2J1THR2YWV5RGl5R3QwT1Za?=
 =?utf-8?B?bzJCeXZvbW90K2ZrUFFTU2UxUlcxc3pRa0Q5ODY3eElnbG5QQU1Oa1I0UU56?=
 =?utf-8?B?ZFhlakNtdDBwbTNkdG9iODRXNG9oWUdSSjNYV1hVTFBmVnV6V1MyUC9wNlVS?=
 =?utf-8?B?Y2hsUU5JNzNnTTJKdE1Xa09FZE1OR0gybENFTi9kOEJnVlh4VXhZaHJXS1cx?=
 =?utf-8?B?NjJ6dklrUG11dlk4YjBOeFdnZ3hhVG1BMW0xUmM3OVBXWlZJNUJrOTFmbWdw?=
 =?utf-8?B?eUMrV1R5NGIrTnp0STZsbmxhMlhld0hKdzF0cHVFY09YR2JkOHJFRjhSbXh0?=
 =?utf-8?B?d2I1TStscWJYdGZieFd1L0p4YTJCRG5lV3JUand6Q1doejRGUjA2NW5pWGRR?=
 =?utf-8?B?ODJOMmR0cHFzT3oxc09wTFF3aTFBOWdSTWhoWTgrUnlGMjcwZU9ZeDQ1cGxi?=
 =?utf-8?B?a25hYVJQWk1mTnlNU3VNQm1FeUFLRWtGWXNISSsyRG9vTDVsajZxb0FGVW5B?=
 =?utf-8?B?ZFdMWmxTMEZVYXlIRm1FSkl5bjhJbWdWS2NtQ3dmVXVnTDVVTHFMYU9jWm4z?=
 =?utf-8?B?bFU5eEY3dExQLzZRYWhOUDVRUGtsMFowa1RXUnA1MGpwNFhueWgvajhnMkZo?=
 =?utf-8?B?Q09wVFZnOHlEMzFCdTJscXlPUUNMTTFDYnZYMkJUdDNVYi8xbFZIeVlVVk9s?=
 =?utf-8?B?OWs3dmJsRzJHWnkvNmVmRTVhUEJONUtXWnhDbXF2aUl2dE54RmliOW5RdXBx?=
 =?utf-8?B?enc0Mk5sTTNSeDFqY0hMb01FN204NjBCR1BtSFY3UHV4Nk9sVVBIUEVIV3lY?=
 =?utf-8?B?c3RmNDNzNkNDdmZ5NXNVWTZBZWxSTGw0anlFTTVaVHJzUWV4KzZJZnUrWnhx?=
 =?utf-8?Q?OY/bofmG1sjAA6Sb/Va4Z6DVIH88dC0U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c293d1VpeWNrcHI0OElCblIyQTdLdnZLRDNiaHhpZHJuc3h2KzBhL0paMTZY?=
 =?utf-8?B?K2NzT01oNUd2aGF2emFEK0o4UCtUOHY0SDJ3ank4NnUzcTQvQkprTEF0NHQz?=
 =?utf-8?B?QlQ0aTdqQ1M2TWJDVzJ2aFhhWDF4N0k2aWpRa295bTcyLytRL0xabVpPTmhx?=
 =?utf-8?B?M2lBbUtteDd3a0pHanhBT2N1blNFcFVUK3JoRFFxTmhUL2tXNHJhS2R4TnFF?=
 =?utf-8?B?SWZlVm90YnhiTUJNTERMQzJPY2xqRG9pcitUck9KQUJ5bW14ZFQxNkRPOGhQ?=
 =?utf-8?B?VzA0SHpjdzhSNzRGSUdYY0pkdjlHWTRyR1JFZmw5V2E2Qk9CSUZNdHhWOCs0?=
 =?utf-8?B?TmdMcmo2VnhJZ0JqaUREalBLdWlzRW9FREdSbitRM25oY3R2b25sSnJqczNz?=
 =?utf-8?B?TDhUblVGYmFPcmQzU0V3ZjdDbG1McFd0S1BScnFvNkNtY3NxVTkrZWY3RXFm?=
 =?utf-8?B?aVc1MHZOZnJOM0t3cW1Yem44ckplZjN6b1ZTWTNKOHh4d2UwUk1sMEJmMktL?=
 =?utf-8?B?Y0k4dkhvdUxKQkdQQ2kyUFBpdW9NU0d5SERZc2E4NGZGV0RxZC9rRjBaRmp3?=
 =?utf-8?B?MmZlZ3lZUE53VVhJbjZWWWpCNGR4QStJMVZaK2Z0L3ZnUzRzNlRjRUdneHdp?=
 =?utf-8?B?N05ad2NOci9nNmM4R2Nab3lHbDk0VDVMRlQvWHNDMFhDZEZad2owUjZLeEUz?=
 =?utf-8?B?QWFSdTNRWUJUTFB2Zzh6RWdrdTBqNUk1bG9pK3dIUE1aTG1TUEJJNlhzSFgr?=
 =?utf-8?B?VURoVkZzT0FudWplaTN5TWhlZFdrdVhRZHY3TnhHYlkrT2FVbHRSK25RSWF4?=
 =?utf-8?B?c0lHVlg2QVFFbmxHRkFBa2pFT2p0Ym5FUE9XU1FYRndYKzU3OFJZeFRLc1dG?=
 =?utf-8?B?dGpNUzRRVFVLZU1tWHM3TlV5NGJlQ1Z3TGRMODllbzBpVmY2YVNQUUFNRENK?=
 =?utf-8?B?bWJVSVdxNktNSkVRT2ppWUFTTDBBS0FFaU50VVFMK0s3MGFaYXM0V0lKVnhz?=
 =?utf-8?B?ZkN0NFoxMnJYN3ovazBDRGkrR3lsZHh6dEttbWR4emJZK0VRZ3cwR3hWMm4z?=
 =?utf-8?B?am10Y2VVU3ZkM0VZci9LYnpMdTAvUlprenJoWk43YlVUVlRieU1FRHJXZXZH?=
 =?utf-8?B?bWhVZDdKTjI5SGxzMVV1OFhmMU5hekdNUC9jYWVueTJZdTdZWW03NnFyN3lR?=
 =?utf-8?B?clo3d1JhWnhwd1lYeVFBTjJ6djdqaTh3NVJLZ00vZDRuRlI5Q25sa2dnWUM3?=
 =?utf-8?B?Nnh0VVc2R083ekxDUU15d2xvNTJqdEtsRWZqczJvbzF4RVhzVlI1SG5maU1D?=
 =?utf-8?B?Sk5IR09Db05hbFdyOWpWei9JQUF0Q2NqUEV5WHExYTQxVGlSUDhkckVQN3o1?=
 =?utf-8?B?czNYU0R2eTRjRU4rVGYyOTltRzRrRXphdXBBTW1BVlZsRElsRzhpeXpNd0FK?=
 =?utf-8?B?K08yTjdmaCtJeWFZL0NWcEJuOEpQckFWNGZoOHlrZTJTUFc5cW9ZbFk3V2Ru?=
 =?utf-8?B?RlNUMHphRjBxOGhOMzIxUnAwSXJNY0xxMnJFREhTejUzcEZIQ3podFkzWjl3?=
 =?utf-8?B?Y2t6MkVJWGxNdENvenhReTNwTkIrQUNScDdsWEhsVGszVXl5Tk85VVh1cWNC?=
 =?utf-8?B?Y1FxL1hkNStiR3hoM0N3MFFWUmNjQnVrTll2dHp3SE1XeVVrWmtXeU1MRzUv?=
 =?utf-8?B?eWh5emtHQlUyUUJ5eXlMSlQ3MXdlbXNMRmxsSXRHMEZtL2thdkxYUmtmOGlk?=
 =?utf-8?B?dGdmOWgwcEgzQ3dsb01QcHgzT1N1QVdNTGtWRi9TVHNJOXhCWmMweUh3WGla?=
 =?utf-8?B?S1prelM2alhHTGxtUGtHemI0aWJ2dXJSUnFGVUJOSjlNb3RTbmpwemlTam9B?=
 =?utf-8?B?K2d1a1NDMTNCZFdOVjJNem44T05FWkc3KzUyNml1NGdPNjAvZ3hBYktiMTZH?=
 =?utf-8?B?V3psaXVZa0NWaE91Mk9yVk11eGk0SmN3bDIxNFdlaXY3OGdTZURjck5JT093?=
 =?utf-8?B?YjNjVEFXWEtQREp5bklvM2ora1IwWFl3VTl4eXVQZ1E0enRLNjZHeHU1S0g4?=
 =?utf-8?B?VjRRSC9VVGx4dWNYN1lwallBZ1FlUXUwM0hvMTF1T0NSRmMxOFdIN21kSEJG?=
 =?utf-8?Q?FX1/yJ7ZPgVICQ9/9rvLs26A1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d741f1e-4238-4307-f446-08de0fd58f11
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:38:23.7991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXTny7DjixCneJotgJ+AH9FNVueKlmOTxJM+VqUXG3EKquMD0TgRIqcJL8mAoKIZbluE0a1ln0fu/dW6pikWaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9059
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/10/20 18:00, Duan, Zhenzhong wrote:
> Hi
> 
>> -----Original Message-----
>> From: Avihai Horon <avihaih@nvidia.com>
>> Subject: Re: [PATCH v2 2/8] vfio/iommufd: Query dirty bitmap before DMA
>> unmap
>>
>> Hi,
>>
>> On 17/10/2025 11:22, Zhenzhong Duan wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> When a existing mapping is unmapped, there could already be dirty bits
>>> which need to be recorded before unmap.
>>>
>>> If query dirty bitmap fails, we still need to do unmapping or else there
>>> is stale mapping and it's risky to guest.
>>>
>>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Tested-by: Xudong Hao <xudong.hao@intel.com>
>>> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>>> ---
>>>    hw/vfio/iommufd.c | 8 +++++++-
>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 976c0a8814..404e6249ca 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -74,7 +74,13 @@ static int iommufd_cdev_unmap(const
>> VFIOContainer *bcontainer,
>>>        if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>>>            if
>> (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>>>                bcontainer->dirty_pages_supported) {
>>> -            /* TODO: query dirty bitmap before DMA unmap */
>>> +            ret = vfio_container_query_dirty_bitmap(bcontainer, iova,
>> size,
>>> +
>> iotlb->translated_addr,
>>> +
>> &local_err);
>>> +            if (ret) {
>>> +                error_report_err(local_err);
>>> +            }
>>> +            /* Unmap stale mapping even if query dirty bitmap fails */
>>>                return iommufd_backend_unmap_dma(be, ioas_id, iova,
>> size);
>>
>> If query dirty bitmap fails, shouldn't we unmap and return the query
>> bitmap error to fail migration? Otherwise, migration may succeed with
>> some dirtied pages not being migrated.
> 
> Oh, good catch. Will make below change:
> 
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -65,7 +65,7 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
>       uint32_t ioas_id = container->ioas_id;
>       bool need_dirty_sync = false;
>       Error *local_err = NULL;
> -    int ret;
> +    int ret, unmap_ret;
> 
>       if (unmap_all) {
>           size = UINT64_MAX;
> @@ -82,7 +82,14 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
>                   error_report_err(local_err);
>               }
>               /* Unmap stale mapping even if query dirty bitmap fails */
> -            return iommufd_backend_unmap_dma(be, ioas_id, iova, size);
> +            unmap_ret = iommufd_backend_unmap_dma(be, ioas_id, iova, size);
> +
> +            /*
> +             * If dirty tracking fails, return the failure to VFIO core to
> +             * fail the migration, or else there will be dirty pages missed
> +             * to be migrated.
> +             */
> +            return unmap_ret ? : ret;
>           }

do we need a async way to fail migration? This unmap path is not
necessarily in the migration path.

Regards,
Yi Liu

