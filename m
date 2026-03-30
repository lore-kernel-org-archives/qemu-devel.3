Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E539DFF4946
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 06:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w75vm-0005CS-Ot; Mon, 30 Mar 2026 02:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w75vg-00056W-FR
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 02:16:52 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w75ve-0005Vh-B7
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 02:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774851410; x=1806387410;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fLymVruOUuDc1akPKC7EAioBXRst8/ebweKAL5tR46E=;
 b=b0M9XPw/4j2Thx1kxgnkO3I3VnxZVKr2Q3OpQgHUdRAtRRMbFq01Ycg9
 1spObXxO4Tzl/3H80DgiHFCuFbkduICDU9b0OqxuMJ2/kvR2PXdTnkHRO
 +Elhmojwk4FF4wERUSnmgL5boGCD1TOKNDZ+mtnURL+G0nXSRfdk2ToXB
 C98kniiqLlmVaY0VpL9J0muxSBHQCbTo32u2XMpJD/PJEalzGcucSfnA4
 i+hkrfXRfEFxtTKxlmbq3V1EWYLuf9xzC9OXnYhn6CkudcCeb8THIC+JP
 T1ntmO/OfNQg9n/lBcK0Z+9J5dTkYTngo/0k6VZdtssgklLb3ru1aWPKM g==;
X-CSE-ConnectionGUID: IWvMzDFIS9OWXGcDyVXFmA==
X-CSE-MsgGUID: LkzVhzq3T4u+DxY1fprvIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79436829"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="79436829"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 23:16:48 -0700
X-CSE-ConnectionGUID: L8iYZJmNT3CETrheKbAcXA==
X-CSE-MsgGUID: D3UPPXoHSmyNicW7bHCf7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="221562023"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 23:16:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 23:16:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 29 Mar 2026 23:16:47 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 29 Mar 2026 23:16:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWzBWomsOzBByHBK2ubbg2pEy6Dyr/foj72LIfWo0IDX6+ywIQ+0j7JlBEdMzMG3aq5OORtXw3e3/Qdl+GxHTLioruJka/KflDWqkVo8pva+n4bpRBbPqhMoAi+nAtadJmJy8S81ntiEx+ZR1yKogRi9gIOPqszrmMJwtD4x11swnVoSjJnTlez9a+D3ZA/6ipGxL4R5FFHo+mQ+a2Er7E1PsTJMs7wdnvRpqhaJnAqdP99z5A02+lnYKGGos6YrQ1oGSwAk2ZnXHY0N+rQ+7dA5Qpj2NQ+siP4OjGar/zdLAnxOcAOu7NbbfvPCnYuE/D+po8/RRNV/B81zMRVemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCmd/dIoBKF3w8YiBwokdiPyewCygxKTsU0TSb8kf/E=;
 b=CU97p0QDeB0k5HzOoyW1ewa8iOjEUnRuk4B4PrQSv5tYhGShQv/7ClI/pS7S2ahiIYfFMMY9nI89ZRpNCj72+liCPGEVlBRD8OFF/ON89YsIFWox3EECjV9sgTbavcWxqvPPdpAK4fU0m4Jq8c9q2ae8pfi2PhdkPAtNCSjtXv6gq9Lrk6dIfNPs6qfCgsScPYHV2ggX5iKxTn7ipwCE1Aztv6fjialz0JLvxwRgJef3z8qaJqNSLejVjZhap9W470oHIsZz327geYnH3naYfHMXaechebcceFGU8QQB7ml9JKSKsAfRQSSBH8nM4fWd3bCA4YCYe0HaJxaXFbYRBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ2PR11MB8401.namprd11.prod.outlook.com (2603:10b6:a03:539::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 06:16:43 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 06:16:43 +0000
Message-ID: <a04bebd4-3fbb-48c5-9fda-9b5b57182d05@intel.com>
Date: Mon, 30 Mar 2026 14:24:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] intel_iommu_accel: Handle PASID entry removal
 for system reset
From: Yi Liu <yi.l.liu@intel.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-11-zhenzhong.duan@intel.com>
 <73392b21-f9b4-48f1-b712-30119cbc8648@intel.com>
Content-Language: en-US
In-Reply-To: <73392b21-f9b4-48f1-b712-30119cbc8648@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SJ2PR11MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 981cc388-def4-4d61-e8c2-08de8e23e977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|42112799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 26QjEeut6m/KX5Ve++v3rYLnrb4yOBf8KuOH6OhOmIBwEERHdpuR0T4XLZDP7uIfmOno43YZsxmZmoeGRI0lzh+nBf0XyTWF+PTYyyC9CHPyAN4pDMsIdieexRLSCW90utAMTqdyV4+uyXyPIjJZHl6bu+0kmnEqh50RSLrFDloTjKBkjXjFw1Qgl7Cm19uwLAxg1V98lWp4PWB+nll1Ms8SimQz6pO+QPmIjdP/qoCzD1dxyCdsG3LV9GzNcW9Nd6+0g4l0nhL5MU92G2weuiI7d/Vhy2W46J0nSrUw7rKWbDsmJ82+fO22T4y9JW+OmnQbiGYjzm+8fUr1MhBp6lx706iO5/hJIT0aIWsT2sIxZrQ21Q15zX22PY6vt8sFquDNnywOLYcxwvRpTE5LL7dOcp13OYFUDpTz/Xfyx42Tli/7VtEq0vmCaE7MS2t0SU/fGqxBrIc7Ng9duXa5jpA2VwDJ9Q81HmEJiWRJCJunmWRSTPRMzzpzjKAx5qtpz8g1kQyjO0dFni/UlgHtGM7SDHpdIK6fsFhCTtMxBn+/qTcp1uqsK3JvEjT2vCzVtqa6SWVBqgB/aTxJZm8OOHH7+Et6+3+sCGaMNSoODYNCMAirzthcLNFjnlmAaiSDGN3gkcq9NyYkRD9yqRPWNwoKJVsfriKnW0a7tn81xabOaxy+o/d1tDO2sfqd6+F0g4xl6Bo1os/ZSBaR4Rqjd1TgdOfQ4y1Wf87WS9Spb4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(42112799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2RDV25BcDIwWnZzdFNDUmtlQng2RUpFR1UxRWhmMDNzMHBObkJGVVgwSWYz?=
 =?utf-8?B?dVYyUGhNWS91UTk0aXVYb2M3MkVqcW1GRzN5NmczM05HZFVhMk5BcTNVd0xy?=
 =?utf-8?B?Ulgza0NwdGtzbFNIQmhPWkozWlIvc0ZlZjAzc0w4Z3dMcFl4QmtBcVcvY04y?=
 =?utf-8?B?TFdDRTdJaldncHFBVUZZSGFtNnhQaW9lRm1HMFZyZmFnRGZoY2Q0L1FMN25u?=
 =?utf-8?B?RkFVOExoZFNUSXkxTGNjNmNQcUUvMjJ1MkxLdk5VeW0wQnA5c28zTGZmODN0?=
 =?utf-8?B?MXZHaHk0Q1pYcFREWXZrRmc5dHNUb2tqN2c4Q0JTWUdIa1QyUGhLUGViMXQr?=
 =?utf-8?B?STJyTnlXdFZ0MWJINDJiY3hXTVdVc0NPT0pjRjM1Y1hBbmxTcW93dzNtSHBs?=
 =?utf-8?B?cVcwdWNUTXVIejRqTkpTTVhZVDdXaktCTjZ3alNLQzRSVkFZcGZDN0xkbHU3?=
 =?utf-8?B?REZabEoxRmUyT1p1QTgzd3pYbll4ZktoaFBqY05VeFVVcllSZGNoYWY2amV2?=
 =?utf-8?B?czdZRDU2QlAvTTBCVmhMdUFTUlVyKzIzQm1XaGkwck50UnM1MjAwdHFjclJF?=
 =?utf-8?B?YkZrNmdVLytrNGhkZkVlMlF3UWhXZlZqR0VEeW0yOTFHL2UvR01FN1RSUjlO?=
 =?utf-8?B?cE1tQWI1QzdjR2FLcWVVa3puSHJOVitBaUNYNnZQMCtXaExsRzQva1pFOGM2?=
 =?utf-8?B?TUJWNk1CUjczTWdEODlZeDArcFpCSnFLZEVrT1cvQi8zZnJSaUh1RWpVS2hz?=
 =?utf-8?B?R2dWT2V3S1oyRHRsMmVGQzVZTXlXNzUyajFjSFRkL0RBOUQyOGdKYkR6SlUz?=
 =?utf-8?B?djRTbVpJRktHY2plN2FQNEpMQ0pIODIxQmtpdDlxTzVNU1FVTENQYllCTndi?=
 =?utf-8?B?Mk54WWZNeEIzUWhJVTRVRnNMZjRMWTdKZmFkRW1IVEZHOUsrSjk2dzNweFFC?=
 =?utf-8?B?Y04xS0hEZnBvU1k0MjJSbXI1WWY3Mng0c28yYTBCUWwrNUc5bi9ScWs0Z2xi?=
 =?utf-8?B?dG9zRjdhOFNDa0xjQnJvdXdFRGdOVEtTaTEyalJnS2JYZTRoZmlrbDNwMjZZ?=
 =?utf-8?B?Q0FjZG5IcW5FYWkzbVR2K1dVTjdhMWY4VlRPTTYxV3FkRHAyQkVyZTlkczc1?=
 =?utf-8?B?My8ySE9SOThVTDRjZ3ZOMERBdHZsTWxtR2ZnN2UyUm1UOGllRS9TbU5zY3pt?=
 =?utf-8?B?aXpjS2dPTlJNM2JObDZyUVJTQ3JQRlU4NExTdGNPcUtJZ1hVY2s0OWEzdkdE?=
 =?utf-8?B?bndKVDUxOTRDbVZEcEhwLzh2WW1SM0VLVTh0ZXp2VWdNU0RyUy9ySTdqelV5?=
 =?utf-8?B?MzVSWUI1K0RKbExpc0c5Tnp6Yk9YNGxBa3VSSkZGei8wbjV6SEVDMFkvOU50?=
 =?utf-8?B?UVR2RlRYY0NidU5JS3hlRDJuY1M5S2lBSlNocHhXd1R2VzVOb0haS3l1UUhw?=
 =?utf-8?B?NGk2Um9nUkFHZUpNcjdUKy9XRGZ3c3hYWkFqZzh4MnlrWmt0OFluOHBVTUxw?=
 =?utf-8?B?N0FOTHdFb05ncFg0UHRIakFGMmlEaWQ3KzhYR1lhNWV2NmRza3NwNFcxVGlq?=
 =?utf-8?B?bGFkMTRkVFcvSHF1bGVmQWZhenU5dkVnZmY4OWVLR3V5T21WQ1lIanNoMGYz?=
 =?utf-8?B?bjJwVFBGT2QrelpxeFhKM0xNbVI1TG9XT0ZnQm9wRzg3RVFWSlhMVjFMMFgz?=
 =?utf-8?B?RzlTRGZ4d3NsaDFoRkVkSHZzb1QvVVRUUjlhYU9GamV4cUgyZERwUjVwR0h6?=
 =?utf-8?B?RWE2a2JOQlFmQWZZSm5yRnhqRnQ3OEFlMXRQNnBXbllPajkySTR6M3NVeDJz?=
 =?utf-8?B?aHZVUnFEYkhscnRtQ3BHVUNGYzlYOGhIMzdJQ2FsUG1GeHIyQUIzellsNGFn?=
 =?utf-8?B?UW9WSUN3cFVtZUJURjYwaG83QWpxZUZuYXhWci9WS3Irbi9ZenZBSlhUZnZ0?=
 =?utf-8?B?OEZmbGQ4dWZ5a1A1d05ISlhuT3FMaE9ET3lMd3A0VDdCUERLamdUMzYxa1JV?=
 =?utf-8?B?THRFWitxZ2VmcFBUU2xVZVhESzl0Tld4Zmc2Q2pHMlZBVFBhNEhDcGwxRDB6?=
 =?utf-8?B?c05IQ1RhQkxJVzJwLzZoeWpOTGhTdnBHYmxYTUFGZnJDcldDb3Y2eDZCMTRI?=
 =?utf-8?B?WmJLWWJ0YXAwdEhXNGVJbVRwL0N6Q1RiTGhBWHo3dEhLOVQ2Nngrd2dna3dU?=
 =?utf-8?B?TENSM2ZaajkwZEJlWWZpdDhnNzNaS2d4b0s4b1FES1JyRnFnMEszdk4xRk9y?=
 =?utf-8?B?dGlhOVRtYysvNU8wZmZONWNqRzdWSUtDTXJsM3lxVzFaaFcxVUs2L1ZCVjhm?=
 =?utf-8?B?Y1lHY0x4d1FrMllYZ1FnQXhuKytBai9HL0JOWGRoM0xyQWdmdEF6QT09?=
X-Exchange-RoutingPolicyChecked: A6zj7vf2QLWSk48YZtISmW21C7X/sL3JkfzSJhYteGXwN6E3M+tkyBfHLEmFFyr5ldHT9hOzkmRcTCMsBtI+trupzAOQy/USKtpvApbSEkeOq+fOOsKY1c3vVKkcceY43nmg7ARm8ndk2hTAh5VSvAMw8HdAzBe7al2wzHz3fkWG+2oBMAsoIcvJsr3XTYr2kJ53gZ+CA3eJowYDB8j3Ccb1ktSnq8ML0DYzWISvCiSIMqkqGl0g7muq+WG4DyxpTwM/X81+jOhdp+H3LONZv0nFKI4OeQjJ4wJdQsb81kAJjur0VBCEebAF1iAq/cl8PJpS3jj2dzQxUe5WhhqbXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 981cc388-def4-4d61-e8c2-08de8e23e977
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 06:16:42.9433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+l8c2ULoBExswnXKuFvbGvgcIPEP8rOTzM+GOH7QbmFtB5krFTmtkQGzyASx2h7KBUWmQJrGu1cyWHaRe9qOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8401
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/27/26 12:32, Yi Liu wrote:
> On 3/26/26 17:11, Zhenzhong Duan wrote:
>> When system level reset, DMA translation is turned off, all PASID
>> entries become stale and should be deleted.
>>
>> vtd_hiod list is never accessed without BQL, so no need to guard with
>> iommu lock.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/i386/intel_iommu_accel.h |  5 +++++
>>   hw/i386/intel_iommu.c       |  2 ++
>>   hw/i386/intel_iommu_accel.c | 13 +++++++++++++
>>   3 files changed, 20 insertions(+)
>>
>> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
>> index c5981a23bf..1fb7ca0af6 100644
>> --- a/hw/i386/intel_iommu_accel.h
>> +++ b/hw/i386/intel_iommu_accel.h
>> @@ -28,6 +28,7 @@ void 
>> vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>>                                         uint32_t pasid, hwaddr addr,
>>                                         uint64_t npages, bool ih);
>>   void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, 
>> VTDPASIDCacheInfo *pc_info);
>> +void vtd_pasid_cache_reset_accel(IntelIOMMUState *s);
>>   void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
>>   #else
>>   static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
>> @@ -62,6 +63,10 @@ static inline void 
>> vtd_pasid_cache_sync_accel(IntelIOMMUState *s,
>>   {
>>   }
>> +static inline void vtd_pasid_cache_reset_accel(IntelIOMMUState *s)
>> +{
>> +}
>> +
>>   static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
>>   {
>>   }
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 451ede7530..b022f3cb9e 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -391,6 +391,8 @@ static void vtd_reset_caches(IntelIOMMUState *s)
>>       vtd_reset_context_cache_locked(s);
>>       vtd_pasid_cache_reset_locked(s);
>>       vtd_iommu_unlock(s);
>> +
>> +    vtd_pasid_cache_reset_accel(s);
>>   }
>>   static uint64_t vtd_get_iotlb_gfn(hwaddr addr, uint32_t level)
>> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
>> index 1e27c0feb8..e9e67eb1a0 100644
>> --- a/hw/i386/intel_iommu_accel.c
>> +++ b/hw/i386/intel_iommu_accel.c
>> @@ -511,6 +511,19 @@ void vtd_pasid_cache_sync_accel(IntelIOMMUState 
>> *s, VTDPASIDCacheInfo *pc_info)
>>       }
>>   }
>> +/* Fake a gloal pasid cache invalidation to remove all pasid cache 
>> entries */

nit : s/gloal/global/

>> +void vtd_pasid_cache_reset_accel(IntelIOMMUState *s)
>> +{
>> +    VTDPASIDCacheInfo pc_info = { .type = 
>> VTD_INV_DESC_PASIDC_G_GLOBAL };
>> +    VTDHostIOMMUDevice *vtd_hiod;
>> +    GHashTableIter as_it;
>> +
>> +    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
>> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {
> 
> s/as_it/hiod_it/
> 
> other part LGTM.
> 
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>

this function is better to be vtd_accel_pasid_cache_reset()
>> +        vtd_pasid_cache_invalidate(vtd_hiod, &pc_info);
>> +    }
>> +}
>> +
>>   static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
>>                                             void *caps, uint32_t size)
>>   {
> 


