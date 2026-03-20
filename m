Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29960108B8E8
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 10:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Wg2-00082B-0v; Fri, 20 Mar 2026 06:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w3WfD-00079c-Dg
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:01:16 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w3Wf7-00021W-3z
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774000861; x=1805536861;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lfwkFfqHW+BSIZoGEcRQIBigsrxpJ8pEpaIwyrkDynA=;
 b=mQR4DIyiDcIWhHL985VT3NEdLWniBY1AMocNscUkmChF2YsvGHZ9zADy
 rKoUXl8xwAb7gH3JoxHcM7NLegsjjDuszFTUWEZ5KnOMLwOZL7eGW+XVW
 VSU/mfUF+dH+DqT7hlsXGBvk+WenNMDHAxguAOQ0CFqfWwl+HprH7hZdy
 G+mFVUEVuIw+rAgXhbpyDiZqVWDswgEGsJHHmdSC4y3OWr8Ica6W8fQDG
 IWzMZTLdwM2XcCimhSJWJ+IhRlZJaokIX3dkmqjkwep3WvrlAkU+PzgAV
 IJFu5C418DqfmNB/8cWi0bYGNCmWzZfn4vg1cphd5aCOH49tviIf4ILon A==;
X-CSE-ConnectionGUID: BliQYwRjTraQawuVbWE8HA==
X-CSE-MsgGUID: /bNLmPqMSsqkKV6laR5G5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86559309"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="86559309"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 03:00:56 -0700
X-CSE-ConnectionGUID: YpzzQx+tTse7ksVucOrkyQ==
X-CSE-MsgGUID: XW34ESa9TRSnjmCh85p7rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="223225064"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 03:00:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 03:00:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 03:00:55 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 03:00:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZ0czFzsXy2ekdZMpzSCsYeoQJna6CYCnhq9tihuaTGQP9fR/bylcKG1wFVbVAaHX11u4TBrGAkQDCoSwxeEq/rDoMmPl0rDD/csJgX7nCEdDfEfhi+5hNQ+/3lLuKhSgoHVXlhhxIAANoJ+khdjtMi7S5JKSuIvGiZqV6qmxBMH0AxnEwDcwyiWw1qyLhAI6hc1u88SkbWVg+iZZa13CS5uS367NztA/I4xZowk7D/3fbQZSql56lnkf5CL2lbEyayEdTc0ru5+TYDr8njT97J/vj7IJaKjylSqBRXhIDEbqDw2VVKV3GjMSG6ntDbLPSthgx3FPcUv2v5UIReAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poapq+8s9lmG5mkGry6klHoigOihvg6wx8Vb758ASg4=;
 b=GaBqjtltZ6CR4gkfxaKaYo679O+YbO8ptl3jEihufSeXlszeHse4w60vNzwDg0AIP3oGSZoL+BzKs2X+Sxyvq3B7Ect4xsCb8ztmclrA9cQEAxCYWN96j7126qvWY0YfHYuasAIVwcuWsIyNBK3Suf0cMrAwxHCiOt3Vt9LhJAAj3uSz90TTBgiKtNNuDea6qUwTowCCvSFC41kQp7Nvo1fPyJSVH15xTwbj1Jc7n49lG3tI/lmh6rJBqDOnXy2c/rXjwfqWZefGuTkLWF8DPWP4gzeU9SNiHudq2tFrVJhTJmuTkSM52/qg0cTj3Z9Zs+CiJJRsFssAQ9uRs82F/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ0PR11MB6766.namprd11.prod.outlook.com (2603:10b6:a03:47c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Fri, 20 Mar
 2026 10:00:52 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 10:00:52 +0000
Message-ID: <52063ae4-eb23-4139-9385-43422463e278@intel.com>
Date: Fri, 20 Mar 2026 18:08:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/13] intel_iommu: Handle PASID entry addition for
 pc_inv_dsc request
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-8-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260306034409.184873-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SJ0PR11MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 18672240-3137-40b3-2446-08de86679202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|42112799006|366016|3613699012|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: JMdrJQ4rJyE26n53WJcJYOFQixl4QSabNx9639Sx9kO8lml/uVtaXYRREOt/Ia6/ymm8yupFeSCZI9cum/YWzLn1CNleTzwlczVL0m0/1mPyJpXTk87iN74hqHEvTdpaCaZXLD8mN1xXCJIQbQKFphxA7xYY/E3E36Skk1uy4WAJtWSVabCPeLtjYAiNYDVzIZ1ttx+GtcHfpH/X3pQDYvb2OmMSC0dVAUXmoYA2xhWaOpI5KHZa4jMzIyx+ZgBdMDZJu1KfZL1kGO8HfCRV076L+eLNC4iaakXWBG/ZqzxJEwwGBqARK5QNyNo2J1nUDxmALehWTTNOcWKBDLE9KmSoud8OLrkaxmvidLe0yJxSbR7TZiN7i8hNxjzVPxtc99jFXgIMktdh+SZ1TjTL60D2XVCyUDP61JyF9nzEfqYo6pIewRIFvNH6zTPNblmlGPSLJMVYzHIRW3Qwlel6UyZUG5YyCJ7wvHDFAlR4eLW3/EKsWkHZVObGwAUuurzd2CiJfjPiA8SCnTp6taiaJOXmVky+gmkMw7MuFXhmk8p13OPUjKTbmQA40k+qedVEPDYsnbpAci1+t6PrJPMC1mlJU4oX3cq2yYd+AJRVZI4mvcJOew6Xv8u3Fg4jm6mzwuWAu8SNBiJhi492MOuKFgZmu2MjohJ/zfdrIM+lKs2ixf3O3Alb3OEIAXu/sRNLo0TWx23z8W2B9FB7sC7qA4PcriMchrnOQxFH2PAHGoGdwqMbQB1YtQ7KslEx+eQed4HF/sY+A99jBsQn96elRSdve7zdMmsed7jimFO8JuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(42112799006)(366016)(3613699012)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmFHRFVxVFFWdjc5K2tVTHJpMzcvV3JUd2F0T3JlY1ZRUnFaUkl1ZU9ycWRO?=
 =?utf-8?B?S2V2bGN4SXNQUWs5NTNJdUFURks3bzhPT2ZWbkJrU284RjhoT1BjUFo4U2E4?=
 =?utf-8?B?WFZxdjhSeFk1RjZsWVVzaVgrSDFaQ3hvRVJXWlgyWnZHWDlxYVE4TXUzTEJ2?=
 =?utf-8?B?cDZGYzU0V0Z1WWgyN3kzVlFtdExYcWtsOXNzdVRoZnRocTJHR2h2UWd1NmZh?=
 =?utf-8?B?TjdsTmRveS9EZGZrblJ3T3E0Z0RQeElDUE1mdWZDUk9RY2xQeDhDWjdRTUhK?=
 =?utf-8?B?dzM5QVpYOVZxeHdrWFI2bk0xQWlxOHBPT2tXNFNSVXY1TVo3M0wwbTN6RUxQ?=
 =?utf-8?B?T1U2SEN5MklwSnJmOFF1WUZRWVgvRjhwRDlsaWk0NUo2M0hOV3hibk56MWlW?=
 =?utf-8?B?Q21wUlhNS1lVaHhad3d3QjJsRkNnZ1l6NlU1OVhOZklFUHNydFc3SytLSytI?=
 =?utf-8?B?T2s4WGtwUFdGMkpLVVRsUkUrbW5zeGlFejNMcXlYc282eDdmeFRmOVRmMHR3?=
 =?utf-8?B?MktzTjZIdWc0eVJRL3cyTkxmY3BRTjd6WUtLR3U1ZktWN1l2eERaOGFvRUpO?=
 =?utf-8?B?K2Z4dE1mYlA5d1NUa1FqVG1sZVA0TitseGQzZDFiRENnTmErcklFQzBYRVUx?=
 =?utf-8?B?K2VBdTBrWm9ZcXRKQys2dGMwKzdBcXRtVnEwb3J5eWFCWUhaQWl5L0YyNTRw?=
 =?utf-8?B?VjVVWE5MbUpDOERZZ1ZLMlNUZE03cjVnYWphSUR2d2RTMlBUOFNsdmsyTG1N?=
 =?utf-8?B?LzNzSUdPdk41eEJvUTJBN1FaOWEyczFic0sweFZQWFFnTCtuUVZDV3dTK08w?=
 =?utf-8?B?cllTY0Zkdjd3Y1I2UVhpTXBXMUpRMUtIeEFoR3VOcHYvRGlDQ3dPamt6TGha?=
 =?utf-8?B?cFF4dEYyRVREd3lWaHErcGNTTEMwWFBPTmJDSSs0N3h5SFNxTisvRDFXdUxa?=
 =?utf-8?B?WHVOS0o0ZkFtL1ZjWHlvY3IwcTMvSkFleGZuWk5lOG9ZVU1WYVRaRmJjdUs5?=
 =?utf-8?B?ZnlSTE05bktPVk4vZFpqNTlkSy9lbTRrMUZVdG1LOVd4ODZ6Wjd5ZjlPYk5u?=
 =?utf-8?B?T2U1aEhVVVpubHpjVno4UVJsRkRtWXlId01Tc0Jldnc4UWRXbjNuSmhyVG1F?=
 =?utf-8?B?ajY4UEZiREVwWDlHK1ZlR2E1NGJ1andlb3hBSnkvOFVVNjdQalBScFFva2pU?=
 =?utf-8?B?MENvdW15NjIyNXdCZVUzTVJtQm9hRHZ3ZjBock1xVVlwQlRzN09rTzdmVlo5?=
 =?utf-8?B?VFZzcWpWNnRrazRsVlVHVEV6bko0UU5yVU4vWVAxUjlBaGFLN3k3bGF4bnZa?=
 =?utf-8?B?QnFmcG52YmVpRm1rWUxURWIwVHkwY0hRdFB6ZlRva0VYcUNjS1pwaWxiZG41?=
 =?utf-8?B?OHJITGZ1cnp5aFd6aVRSREkvUmlyUzk2TWErbmpOVzZ2eWc2MStIWEZ5My82?=
 =?utf-8?B?ZUZxSUFTaXNVck9hUXpmOS9BektYbDIyYUkrNDQ4WmVLVEhsbitBeSswUkJy?=
 =?utf-8?B?ZzBoelZZRUlpWmxQNlByNFVpdmh1VkhmR0lmcnZEcmMyWUJlSkYvUWF6UUNR?=
 =?utf-8?B?SHE2TWRPOWRoQkRBTHlueTVhOUFEU20vSXZ4VE5qRmExbndiRVVLYWc3ZFdJ?=
 =?utf-8?B?MjhpNldUMS8zQjJ4ZDFTSnVNY3c5a1M4cEJ0MXRsTGd1YmtLa3AyTUM3ZUxh?=
 =?utf-8?B?MHlnQkExZnB2cysxNFJyYlorQkt6anFiMUVIaVNsNmZlSDVWc3Y1UDN2N2Jz?=
 =?utf-8?B?R2tWTW9mMDNZVGZ4UjlnSUgvR2JIKzl2TUVnenVwZi9RREVOWnd6RjZqeGJn?=
 =?utf-8?B?ZUltUHg4Y2NxVFN6L2lmQ2RnbHA2RFZSUS9jMHNHMUJEaUdLQUFUblpWUGNL?=
 =?utf-8?B?KzhDQVFMVHFjT3dEOGNlR1Fjc1FkM3dKd1Vua1JoVDBGSkwvckIrdnNFbjJi?=
 =?utf-8?B?ejNpZ1JoL2p3d2pUV0RsUzNKcE5BT2txbFNnMUJ1V2hJb3pibHpqd3RIVVZU?=
 =?utf-8?B?VlRzaWZadE53akp2RlhPSmwvWkROZFBlNW5SeGRQanMrbllUSVk1K0xqakc4?=
 =?utf-8?B?U0RDbnhYNG9TS1FROE5oYytvTlN6N3V5Mkp1aEF3MHZiY0x6NjErR1BCZjdB?=
 =?utf-8?B?TUZjK3MxS2l1UHJvV09XVE4rQjA5WW5NbzVvMkl6RzlOOUZsL2JoK2RMTDBm?=
 =?utf-8?B?TG9jaU9CT2l4N0xHbi9DdWRWYlZUYjB3bURJSUNuVy9Rd0lkRDdwSzl2UXZ0?=
 =?utf-8?B?SmhDKzJ5R0cvV0dPWUFGeUdzM2VRT2o2d2lsQU4wZjdxZXJIL3RDMHRFQUY4?=
 =?utf-8?B?UTNncVBveHdhUEgwbFE2RTJDMnBYNGR1RmNiUWZmdERyZ2tXeFNPQT09?=
X-Exchange-RoutingPolicyChecked: apy30Vej30rcZVHcXwpgQuR37akke7bDqi+OgU2cPODjHFHElKYPc//3cjMSIrV1bMY7hm0SgekzhhvfalSsX0mtH6IlqYPbwsl/RT1K2xT+eNWSna7ocOyIylCQDGoIjcm9FV5XACEylo33mhC2uPM8KPmqMfP8orHNofak09Cfc7n+jcQPPKVNotA+wwDgDkzJOLYhZmC7Gyj9pLm/J4ttjOYCqK/K0C/F/upAMLSnfEYM3pgEuEVVwqKP2EtSAshv4mII8PxNLa8fC7/h3rYNT+m+m+6yaN6IK/qRuqh83KuxwuaVZxtQ4u6FsJpOvPWJvokZvcZeQqcKDXytrw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18672240-3137-40b3-2446-08de86679202
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 10:00:52.4745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOZJwWTm62iFaAZY3ooIlqxTH6kj5QiHaub+gdvEZqg2mKEjxiYpV1jC/p5hSIuyPwk5TPSJZfm/OfvoyR7stw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6766
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

On 3/6/26 11:44, Zhenzhong Duan wrote:
> Structure VTDAddressSpace includes some elements suitable for emulated
> device and passthrough device without PASID, e.g., address space,
> different memory regions, etc, it is also protected by vtd iommu lock,
> all these are useless and become a burden for passthrough device with
> PASID.
> 
> When there are lots of PASIDs used in one device, the AS and MRs are
> all registered to memory core and impact the whole system performance.
> 
> So instead of using VTDAddressSpace to cache pasid entry for each pasid
> of a passthrough device, we define a light weight structure
> VTDACCELPASIDCacheEntry with only necessary elements for each pasid. We
> will use this struct as a parameter to conduct binding/unbinding to
> nested hwpt and to record the current binded nested hwpt. It's also

s/binded/bound/

> designed to support PASID_0.
> 
> When guest creates new PASID entries, QEMU will capture the pc_inv_dsc
> (pasid cache invalidation) request, walk through each pasid in each
> passthrough device for valid pasid entries, create a new
> VTDACCELPASIDCacheEntry if not existing yet.

I think some tweak is preferred w.r.t. this and the next patch.

In this patch you only need to handle the PASID entry addition. Hence
you assume no existing VTDACCELPASIDCacheEntry yet.

> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_accel.h    |  13 +++
>   hw/i386/intel_iommu_internal.h |   8 ++
>   hw/i386/intel_iommu.c          |   3 +
>   hw/i386/intel_iommu_accel.c    | 170 +++++++++++++++++++++++++++++++++
>   4 files changed, 194 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index e5f0b077b4..a77fd06fe0 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -12,6 +12,13 @@
>   #define HW_I386_INTEL_IOMMU_ACCEL_H
>   #include CONFIG_DEVICES
>   
> +typedef struct VTDACCELPASIDCacheEntry {
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    VTDPASIDEntry pe;
> +    uint32_t pasid;
> +    QLIST_ENTRY(VTDACCELPASIDCacheEntry) next;
> +} VTDACCELPASIDCacheEntry;

btw. s/VTDACCELPASIDCacheEntry/VTDAccelPASIDCacheEntry/ looks better. :)
> +
>   #ifdef CONFIG_VTD_ACCEL
>   bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                             Error **errp);
> @@ -20,6 +27,7 @@ bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
>   void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>                                         uint32_t pasid, hwaddr addr,
>                                         uint64_t npages, bool ih);
> +void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
>   void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
>   #else
>   static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
> @@ -49,6 +57,11 @@ static inline void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
>   {
>   }
>   
> +static inline void vtd_pasid_cache_sync_accel(IntelIOMMUState *s,
> +                                              VTDPASIDCacheInfo *pc_info)
> +{
> +}
> +
>   static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
>   {
>   }
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index c7e107fe87..ede4db6d2d 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -616,6 +616,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>   
>   #define PASID_0                             0
> +#define VTD_SM_CONTEXT_ENTRY_PDTS(x)        extract64((x)->val[0], 9, 3)
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>   #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
> @@ -646,6 +647,7 @@ typedef struct VTDPIOTLBInvInfo {
>   #define VTD_PASID_DIR_BITS_MASK       (0x3fffULL)
>   #define VTD_PASID_DIR_INDEX(pasid)    (((pasid) >> 6) & VTD_PASID_DIR_BITS_MASK)
>   #define VTD_PASID_DIR_FPD             (1ULL << 1) /* Fault Processing Disable */
> +#define VTD_PASID_TABLE_ENTRY_NUM     (1ULL << 6)
>   #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
>   #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
>   #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
> @@ -711,6 +713,7 @@ typedef struct VTDHostIOMMUDevice {
>       PCIBus *bus;
>       uint8_t devfn;
>       HostIOMMUDevice *hiod;
> +    QLIST_HEAD(, VTDACCELPASIDCacheEntry) pasid_cache_list;
>   } VTDHostIOMMUDevice;
>   
>   /*
> @@ -768,6 +771,11 @@ static inline int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
>       return memcmp(p1, p2, sizeof(*p1));
>   }
>   
> +static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
> +{
> +    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce) + 7);
> +}
> +
>   int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base, uint32_t pasid,
>                                     VTDPASIDDirEntry *pdire);
>   int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s, uint32_t pasid,
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 744b5967b2..984adc639a 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3202,6 +3202,8 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>       g_hash_table_foreach(s->vtd_address_spaces, vtd_pasid_cache_sync_locked,
>                            pc_info);
>       vtd_iommu_unlock(s);
> +
> +    vtd_pasid_cache_sync_accel(s, pc_info);
>   }
>   
>   static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s)
> @@ -4760,6 +4762,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>       vtd_hiod->devfn = (uint8_t)devfn;
>       vtd_hiod->iommu_state = s;
>       vtd_hiod->hiod = hiod;
> +    QLIST_INIT(&vtd_hiod->pasid_cache_list);
>   
>       if (!vtd_check_hiod(s, vtd_hiod, errp)) {
>           g_free(vtd_hiod);
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index c2757f3bcd..0acf3ae77f 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -257,6 +257,176 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>                            vtd_flush_host_piotlb_locked, &piotlb_info);
>   }
>   
> +static void vtd_find_add_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
> +                            VTDPASIDEntry *pe)
> +{

then you can name this as vtd_accel_fill_pc(). And I think you would 
have vtd_accel_update_pc() and vtd_accel_delete_pc() in the next patch.

> +    VTDACCELPASIDCacheEntry *vtd_pce;
> +
> +    QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
> +        if (vtd_pce->pasid == pasid) {
> +            if (vtd_pasid_entry_compare(pe, &vtd_pce->pe)) {
> +                vtd_pce->pe = *pe;
> +            }
> +            return;
> +        }
> +    }

hence this loop can be avoided.

> +    vtd_pce = g_malloc0(sizeof(VTDACCELPASIDCacheEntry));
> +    vtd_pce->vtd_hiod = vtd_hiod;
> +    vtd_pce->pasid = pasid;
> +    vtd_pce->pe = *pe;
> +    QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
> +}
> +
> +/*
> + * This function walks over PASID range within [start, end) in a single
> + * PASID table for entries matching @info type/did, then create
> + * VTDACCELPASIDCacheEntry if not exist yet.
> + */
> +static void vtd_sm_pasid_table_walk_one(VTDHostIOMMUDevice *vtd_hiod,
> +                                        dma_addr_t pt_base,
> +                                        int start,
> +                                        int end,
> +                                        VTDPASIDCacheInfo *info)
> +{
> +    IntelIOMMUState *s = vtd_hiod->iommu_state;
> +    VTDPASIDEntry pe;
> +    int pasid;
> +
> +    for (pasid = start; pasid < end; pasid++) {
> +        if (vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe) ||
> +            !vtd_pe_present(&pe)) {
> +            continue;
> +        }
> +
> +        if ((info->type == VTD_INV_DESC_PASIDC_G_DSI ||
> +             info->type == VTD_INV_DESC_PASIDC_G_PASID_SI) &&
> +            (info->did != VTD_SM_PASID_ENTRY_DID(&pe))) {
> +            /*
> +             * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
> +             * requires domain id check. If domain id check fail,
> +             * go to next pasid.
> +             */
> +            continue;
> +        }
> +
> +        vtd_find_add_pc(vtd_hiod, pasid, &pe);
> +    }
> +}
> +
> +/*
> + * In VT-d scalable mode translation, PASID dir + PASID table is used.
> + * This function aims at looping over a range of PASIDs in the given
> + * two level table to identify the pasid config in guest.
> + */
> +static void vtd_sm_pasid_table_walk(VTDHostIOMMUDevice *vtd_hiod,
> +                                    dma_addr_t pdt_base,
> +                                    int start, int end,
> +                                    VTDPASIDCacheInfo *info)
> +{
> +    VTDPASIDDirEntry pdire;
> +    int pasid = start;
> +    int pasid_next;
> +    dma_addr_t pt_base;
> +
> +    while (pasid < end) {
> +        pasid_next = (pasid + VTD_PASID_TABLE_ENTRY_NUM) &
> +                     ~(VTD_PASID_TABLE_ENTRY_NUM - 1);
> +        pasid_next = pasid_next < end ? pasid_next : end;
> +
> +        if (!vtd_get_pdire_from_pdir_table(pdt_base, pasid, &pdire)
> +            && vtd_pdire_present(&pdire)) {
> +            pt_base = pdire.val & VTD_PASID_TABLE_BASE_ADDR_MASK;
> +            vtd_sm_pasid_table_walk_one(vtd_hiod, pt_base, pasid, pasid_next,
> +                                        info);
> +        }
> +        pasid = pasid_next;
> +    }
> +}
> +
> +static void vtd_replay_pasid_bind_for_dev(VTDHostIOMMUDevice *vtd_hiod,
> +                                          int start, int end,
> +                                          VTDPASIDCacheInfo *pc_info)
> +{
> +    IntelIOMMUState *s = vtd_hiod->iommu_state;
> +    VTDContextEntry ce;
> +    int dev_max_pasid = 1 << vtd_hiod->hiod->caps.max_pasid_log2;
> +
> +    if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_hiod->bus),
> +                                  vtd_hiod->devfn, &ce)) {
> +        VTDPASIDCacheInfo walk_info = *pc_info;
> +        uint32_t ce_max_pasid = vtd_sm_ce_get_pdt_entry_num(&ce) *
> +                                VTD_PASID_TABLE_ENTRY_NUM;
> +
> +        end = MIN(end, MIN(dev_max_pasid, ce_max_pasid));
> +
> +        vtd_sm_pasid_table_walk(vtd_hiod, VTD_CE_GET_PASID_DIR_TABLE(&ce),
> +                                start, end, &walk_info);
> +    }
> +}
> +
> +/*
> + * This function replays the guest pasid bindings by walking the two level
> + * guest PASID table. For each valid pasid entry, it creates an entry
> + * VTDACCELPASIDCacheEntry dynamically if not exist yet. This entry holds
> + * info specific to a pasid
> + */
> +void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
> +{
> +    int start = PASID_0, end = 1 << s->pasid;
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    GHashTableIter as_it;

s/as_it/hiod_it/

> +
> +    if (!s->fsts) {
> +        return;
> +    }
> +
> +    /*
> +     * VTDPASIDCacheInfo honors PCI pasid but VTDACCELPASIDCacheEntry honors
> +     * iommu pasid
> +     */
> +    if (pc_info->pasid == PCI_NO_PASID) {
> +        pc_info->pasid = PASID_0;
> +    }
> +
> +    switch (pc_info->type) {
> +    case VTD_INV_DESC_PASIDC_G_PASID_SI:
> +        start = pc_info->pasid;
> +        end = pc_info->pasid + 1;
> +        /* fall through */
> +    case VTD_INV_DESC_PASIDC_G_DSI:
> +        /*
> +         * loop all assigned devices, do domain id check in
> +         * vtd_sm_pasid_table_walk_one() after get pasid entry.
> +         */
> +        break;
> +    case VTD_INV_DESC_PASIDC_G_GLOBAL:
> +        /* loop all assigned devices */
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    /*
> +     * In this replay, one only needs to care about the devices which are
> +     * backed by host IOMMU. Those devices have a corresponding vtd_hiod
> +     * in s->vtd_host_iommu_dev. For devices not backed by host IOMMU, it
> +     * is not necessary to replay the bindings since their cache should be
> +     * created in the future DMA address translation.
> +     *
> +     * VTD translation callback never accesses vtd_hiod and its corresponding
> +     * cached pasid entry, so no iommu lock needed here.
> +     */
> +    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {
> +        if (!object_dynamic_cast(OBJECT(vtd_hiod->hiod),
> +                                 TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +            continue;
> +        }
> +        vtd_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
> +    }
> +}
> +
>   static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
>                                             void *caps, uint32_t size)
>   {


