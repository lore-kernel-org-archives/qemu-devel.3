Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF7BCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHUx-0005yq-Gd; Fri, 08 May 2026 05:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wLHUv-0005tD-Sd
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:27:53 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wLHUt-0000ai-S9
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778232471; x=1809768471;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pegSpUzfNR1kmDGGwrTGKecMlJ+C2O+IjauwqPQlrIA=;
 b=MaQLBlEC9vglqhSbbtu+Sxp5+5CemDPYPmgbThk+/YqPLqAVf5inmIlh
 WjvXvgg2eLeh3As3GnCZKPrzKqrUR9F00rxPdDMydaB1RRdp/4gal1Yve
 jHWZJzbk3RxfNgnQqNv7/6WxNlAk6G9c1uSMNCw6NMj6a/HZUR6IXTs9d
 b+PZE3AlDuHlVw7ZcStPWEVS0CtpccMBjRRr61MWbtvHyQuh+K8sjkj+x
 8wG59LaS6HXOsuOTcguKQy1I40ATLU524sIaAhH6bBRfgAISFagCYH6hD
 6qLdYu+dQ3VFsEdWr4bULHywPVSsLCiZfbH+xCilmv5EHbHJjY3d/RUp8 g==;
X-CSE-ConnectionGUID: Rgw5b9VcRHSfBrjU1qxdOw==
X-CSE-MsgGUID: xo3sJU/sRPiPysT/TcQg4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79051715"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="79051715"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:27:50 -0700
X-CSE-ConnectionGUID: u+FPAhUdSZmjgQI74LBv7A==
X-CSE-MsgGUID: tJ4WPkA2SUmtnLyskbP25A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="274837578"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:27:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:27:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 02:27:49 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:27:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjyZweDMoc5Q7cJ9OJD/l5P7/FOePc7jod23Zw7EpftX2FfOXhmKw/LN60ZnNsuFrNLQ0WkSTwn5YA7uwBawDyFHaFjah3Ie1r4HfJU1R/LI4JzuftCjbHncdEQhuwo4G+B43cNGJ3HEwF9CUkdplprrLLwwvHn43ZVIWqYqR8t1uOOtudZBIoBdLqt4X6lHXFEohGUB5I7+7yHn4LaP5UF1SNgxe7ry9feDX3zJ+q5o/W7H1To4XhIn4gOo3y0hUyjbwhWHbW30XdSOA6PfBMYT/CHDR7JQUiY1/N9XlLA3pqQl1jnrn3//WO7C+B12ptUdWSqY5etXlq10Qz22zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVvSW+Ae17fqzmQE/8HW+/W1rd0pxdkNJNU+fd5S53g=;
 b=iH0PDyGuU8L4ZjO7wAtlmlL91StuJD0LQXBSHaRxTKsBbOs/fTgQxL2UGayTbyfI45ga1mtQotjcpwOYDC013GhBfzOeCrpQ+EXhaMzT9b0snPYEiR4OjNznMh/pveGCvg3cNJ+jhUnYmRzQG+D+ZDV99HyZtamXlX6OyIPSvnrtdPVSBcgvER2E5uswqELZpq8WQi9LxlmqT/vBmrhrVJ8wzqJkJcjSXiQH6aVhq898Nug85Y/41rO4My6/C00Nb8kmRW3yoJ9uO3kY2J0NoqOHn17viEQKZkIWvOzTYJ2WvaG/TxCl0lxJdGq0GbNtA5fXLZhBwIrQwZ2dFDUMtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by PH7PR11MB6700.namprd11.prod.outlook.com (2603:10b6:510:1ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 09:27:40 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%4]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 09:27:40 +0000
Message-ID: <3bb34821-5de5-42a8-9a1f-d0dba55d1689@intel.com>
Date: Fri, 8 May 2026 17:35:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/15] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-9-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260430071315.354333-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0005.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::15) To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|PH7PR11MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 038f946a-bed1-4c58-f51c-08deace40cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|42112799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: d5J7AIIDFM0EthIPpY23NAffP4CX+v8zWAGh3NpmrdaAsXv3f3QGWkuPt9bnzuj8xhZvEx0tHQC8tSjB+0B1X9o/psqnTzjGo/OF2ygvGTCsPIEV047sHgjRg6QaP74G6V+LfLRg2Fk6u7T45+MykjlZofyqfm+Hpq4oSIpj9hfYO0CGliBHwZIetUcD3+aJHLhV96vE1WlbAIGw7uCqzA+qLYviErDMLDF5SLXWZbKcke2vzbG9dgTm15NMZmsFsB33Jc/00I36+LG5dH0PQHBGzpl37+j04Bw04yhnnaws+LcASB4JlgB97GXIwDKMirF1PCzB9siSkk3alZKD9J9ApCP22FnCCCqgaaCzlBOPsg2QZV+LOQqDHVZwjN65fWOriSoKOOBwDQGTSIHgo3JP693G/tXKCXvxZb/c+JZak7O1zXegC4fwoV79rm7Dw6V4W7nElCs4dva71OW3jx2l2lfc/DvszTV0l1v+c1xZ9t7g5VukTVeMhLGl55sRpO0L+c9F0iwbOuLV0M4fdMVMZfeZlZI2c3DBECpeAk+fkE2sdAkUyBQh6vfyyoYqPk0clccIfjAe2zkof+/aV271ANY9xpxD0OD7oTO2aX8FIXkblXM07WiZM5ag6WGThKS+3GBfh5QuYESZOfOGwcxw77rkQ5w9MT0l4ykp4dz5t2HgicsTRxy1QH0+DCEN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(42112799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjNvTDg3bEdjOXh4S1BkNDFseFN6dnI0MUlKTzZ3eVJNdXhBeFVacTdMbmo3?=
 =?utf-8?B?aWF5QWkwalRvb3pIVGkrNUMzWXVPR2ROT3cwc2NmMGdabFA4N3YwSlNDZGU1?=
 =?utf-8?B?OTBqbXJLYWYzMG14dnlaUDZVQVVoUXZXaitCWjdLaVY2eno2dmo0TGppVkxs?=
 =?utf-8?B?WkhjY0tJMnhvb05oUkVvdVE0VmNON1E1S1lJeE5oSlFaN3RKZEpLOVpBbENV?=
 =?utf-8?B?TEptUHJIL2RGajdRUUVDNmdDYzBjUUhPd3lGMnpWcnVRQUNVK3lhUkVVWC9Z?=
 =?utf-8?B?VjZSZEJlckJWd1N2L0Q1eWIzTUJxNTNpejNlRy8wcmc3bGhiVmt0SzY4VWE1?=
 =?utf-8?B?ZU5ZV1JRaGV6Ri95aXk3a0pHNWZ0UEhPUTNrdFViVEM0NXU1clkzTVJZbS8v?=
 =?utf-8?B?d0tWWXlxU214VStINENNZ1V1NlVwaExjZWRTSDNodG1EbFZHVWdBQjVlQW0v?=
 =?utf-8?B?YTJZS2plcFRPVGpJdmFQdTdhMWgrOHRPdmpEZ2x5a25iN3JUdE96U1N0QmFN?=
 =?utf-8?B?RlBRRDcwWEFtM09aTi9Tdm5hWmZlRFQxSU1nRUNnQ2p2b0dsdVpISzhFZjIz?=
 =?utf-8?B?eGM1RFpwY0xxc0xqRlVHMEcvLzdiVHpxdEFBZnJJZXJsbzFtRWtGVXFwbGFv?=
 =?utf-8?B?aDZhcktOemc0RHBTL2hnWE91c3BJbE1qSTBPdzlydUZLRE1Ga29MQzZFSUFi?=
 =?utf-8?B?QXEvc1JIeTlWNGR2cXF2WkZDd2xYZ0Z4VHkzbk9ERjBuWGgxQUlPbzJETUxi?=
 =?utf-8?B?ZEV2NU1UVzlKK3djbjM0bjk2ZHo2RVFjTTF4cExISGU0UWVGWEpzVHJMYUNj?=
 =?utf-8?B?RjIvb1dqQ2E4Wm9jOHdxM2ZZMUQ0dGlHaXpMbU4ydVZwM3ZHVzlkTzBIdGVV?=
 =?utf-8?B?Y2R6MTNvMXZnRHZsdnl6VklVQVhwRU1qUkxWeWg3WjRaSDlaQ05aLzArclZB?=
 =?utf-8?B?MmJ4NjhVcGxaUllYQUlSRm9iU1VMNHFyVk1iNVl5UlZ3ZXJPTkYvZkFBRkdx?=
 =?utf-8?B?RS9NZ0xscU5kU1FOSFJvQTIzT3Z2U09lMDNPVzVDcVdQVnNFUDFIRVpZNmp1?=
 =?utf-8?B?d0FNWUtUT3YwdjlGeTlrdzRlMjd2akUvSGRrV242cGxMNEdIRW9FQTRKRzAw?=
 =?utf-8?B?WEhJUm9Nd1ZYK3JlY3F6WWJDVnhwcTdiTFBPcGhRYjU4RXlncVQ5M3JJT1FD?=
 =?utf-8?B?dXRUaFFDQWVmTERTK095bVNBcmx0Z2JhTDB3N2paalp6b3VZMjRBRVZZSEdW?=
 =?utf-8?B?V3FveWlLTE9SS1ZFMW1LZWF2dUk0TjdrdlpCSHNjWUhJN21lRmVyZ1ZjbUli?=
 =?utf-8?B?WlMvQkFHd2RLZ0ZiRDZjbFBqcnlUcmN1clBVSEg0UjdqMm5aaUl0ZW5LaUJP?=
 =?utf-8?B?c28yVDNSZmMwQnkxd3piVEE2aks0dzJ0REdGQURBN2w2N0d3SENyMVcrVWh5?=
 =?utf-8?B?M2k0WUlNaVZNZWJ4MGhNTzc1OEYybCs3YmhSWjZJT2xwTzhlS1p6SlJyZWhO?=
 =?utf-8?B?UmR0WmFWbkQvV0Y2UktWSmR1MHdVM3g3UGhYWHZWTFJnNUhDRjlsYjRpMzNU?=
 =?utf-8?B?RkZQTnM3UTFNblNoN1A1eHhQbEluWU5rZGFuSXBhdjFwNFhUNUVkczM1cHhy?=
 =?utf-8?B?UU0wVmQ2RVp1bkFlYnFsbytmb0VyYy9rblhqaDRod1JZdnNBdkJOeHhvVXly?=
 =?utf-8?B?cGlhaXY1QWtSRFhRWnlORXB4WEVCNjVxanZxZE5ZeXNONlk2Vyt4QWQvUXRU?=
 =?utf-8?B?dERqVTNvRUZuTXAzUGxNOXBDUldzS2dqSitsdHl2NGhodEhpd28vQThhNFhP?=
 =?utf-8?B?emQ0a1N4ejg1UnA5Q3pERnh4ekJLRHluT25HN0FxLzhNTnVDYjl5N0Vobk1F?=
 =?utf-8?B?bEd3VFNqRmwrYk54Y3ZuUTY3a2tOckxDa2pQeEgwbno0OTJnQy92d0lFd2Rs?=
 =?utf-8?B?ZU5BRXRZYlZ5N2E4RXdEcUZWMmN3eC9nVkFqcUdOUTdnV0ZTMmV6YmZzbTV1?=
 =?utf-8?B?MTdyZ1RpR1NmZkVNRWtqVVhXS1ZWNk1Sc1A2dHg4cjh5YTRiVzlOSm02dU1y?=
 =?utf-8?B?R2lHVDhPNDA3VnI5dFEyMWVoTzJzQ295bk0rSVJMNHp6UHp5clNldkJidTZ3?=
 =?utf-8?B?Q29CWnIrU0o4dnNURFU1d0Z1Y05mR3NxdU9LTnVTSi9WMnBaT2hmaXdabjlm?=
 =?utf-8?B?MlBxNDU3MEhpN25EWGp0aGRKdG9Nck90ZGZpTG1FWldPMVUrcDhySE1iME96?=
 =?utf-8?B?NTV5bG5DZzl0c0ZWTStmRzA1V3JIK1JwaHhXKy8wbFhxSVV3QmV2QzV6LzVp?=
 =?utf-8?B?aTdaMnlrTFFLVEdOVGcwMWZzdmNsSXRObEZBbVBPRW5RdGE0RkNYQT09?=
X-Exchange-RoutingPolicyChecked: FRovosCs75IrdFR7xE6iPk/RYTLrP3UpjBo0gc0MByX2Hxg0jh1HD2wkezoNZNXAiFgQIsn0HGCW6Hus/c7PShWfWoX+yg3YkAiawYekcF6sPo8UjyfwX7anyx0ADulYl5JcTjLwLyFV1/14Eq4KeaHYaXz/TvXZKjg9nCGjcrcdg+hM5qZiOcFbr96M+mqQc61IT464ufhIhUFKugiygyoJCW8uUFx65bMxBn4g2BD3K06AIoA/+z6iIxSthMt4LzZvmU+Tk9dW1O1YOQod+ygEIyv50mnWL/QOffITTbI4eJkAki1m7+YQkZD5lCNRrh3tlZL9WW4LukHdrxiQXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 038f946a-bed1-4c58-f51c-08deace40cf6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:27:40.6487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/+ACyssSx5YM0otM7P+w6/gDHV/bTLAjcWbdGN+kOoPruMB/ZAa2U0LbogrqtNF/xsDRq747Zr+P1PFJj7G0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6700
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 4/30/26 15:13, Zhenzhong Duan wrote:
> In previous patch we introduced a global macro IOMMU_NO_PASID(0) for
> Requests-without-PASID, this makes the local macro PASID_0 redundant.

It's a bit confusing "for Requests-without-PASDI", a natural question is
what is the difference with PCI_NO_PASID. I think "for the RID 
attachment." is ok. Also, mark no functional change is expected.

> Delete it and use IOMMU_NO_PASID instead.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  1 -
>   hw/i386/intel_iommu.c          | 21 +++++++++++----------
>   hw/i386/intel_iommu_accel.c    |  2 +-
>   3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index c7e107fe87..0141316f83 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -615,7 +615,6 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_CTX_ENTRY_LEGACY_SIZE     16
>   #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>   
> -#define PASID_0                             0
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>   #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 74642d8123..4d1b262d56 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -100,7 +100,8 @@ static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>    *
>    * Requests-without-PASID:
>    *   - PCI subsystem: Uses PCI_NO_PASID (-1) to indicate no PASID present
> - *   - VT-d IOMMU:    Uses PASID_0 (0) to index the PASID table for translation
> + *   - VT-d IOMMU:    Uses IOMMU_NO_PASID (0) to index the PASID table for
> + *                    translation
>    *
>    * Requests-with-PASID:
>    *   - Both subsystems use identical PASID values (1-0xFFFFF)
> @@ -114,7 +115,7 @@ static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>    */
>   static uint32_t vtd_pasid_to_pci_pasid(uint32_t pasid)
>   {
> -    if (pasid == PASID_0) {
> +    if (pasid == IOMMU_NO_PASID) {
>           pasid = PCI_NO_PASID;
>       }
>       return pasid;
> @@ -969,7 +970,7 @@ int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
>       dma_addr_t pasid_dir_base;
>   
>       if (pasid == PCI_NO_PASID) {
> -        pasid = PASID_0;
> +        pasid = IOMMU_NO_PASID;
>       }
>       pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>       return vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
> @@ -986,7 +987,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
>       VTDPASIDEntry pe;
>   
>       if (pasid == PCI_NO_PASID) {
> -        pasid = PASID_0;
> +        pasid = IOMMU_NO_PASID;
>       }
>       pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>   
> @@ -1529,9 +1530,9 @@ static int vtd_ce_pasid_0_check(IntelIOMMUState *s, VTDContextEntry *ce)
>   
>       /*
>        * Make sure in Scalable Mode, a present context entry
> -     * has valid pasid entry setting at PASID_0.
> +     * has valid pasid entry setting at IOMMU_NO_PASID.
>        */
> -    return vtd_ce_get_pasid_entry(s, ce, &pe, PASID_0);
> +    return vtd_ce_get_pasid_entry(s, ce, &pe, IOMMU_NO_PASID);
>   }
>   
>   /* Map a device to its corresponding domain (context-entry) */
> @@ -1592,7 +1593,7 @@ int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>           }
>       } else {
>           /*
> -         * Check if the programming of pasid setting of PASID_0
> +         * Check if the programming of pasid setting of IOMMU_NO_PASID
>            * is valid, and thus avoids to check pasid entry fetching
>            * result in future helper function calling.
>            */
> @@ -2150,7 +2151,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>       vtd_iommu_lock(s);
>   
>       if (pasid == PCI_NO_PASID && s->root_scalable) {
> -        pasid = PASID_0;
> +        pasid = IOMMU_NO_PASID;
>       }
>   
>       /* Try to fetch pte from IOTLB */
> @@ -2515,7 +2516,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
>   }
>   
>   /*
> - * There is no pasid field in iotlb invalidation descriptor, so PASID_0
> + * There is no pasid field in iotlb invalidation descriptor, so IOMMU_NO_PASID
>    * is passed as parameter. Piotlb invalidation supports pasid, pasid in its
>    * descriptor is passed. In both cases, pasid is converted to PCI pasid
>    * before checking with vtd_as->pasid.
> @@ -2586,7 +2587,7 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>       vtd_iommu_lock(s);
>       g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &info);
>       vtd_iommu_unlock(s);
> -    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, PASID_0);
> +    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, IOMMU_NO_PASID);
>   }
>   
>   /* Flush IOTLB
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index bd1236c070..8940d240a1 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -217,7 +217,7 @@ static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
>   
>       did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
>   
> -    if (piotlb_info->domain_id == did && piotlb_info->pasid == PASID_0) {
> +    if (piotlb_info->domain_id == did && piotlb_info->pasid == IOMMU_NO_PASID) {
>           HostIOMMUDeviceIOMMUFD *hiodi =
>               HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>           uint32_t entry_num = 1; /* Only implement one request for simplicity */


