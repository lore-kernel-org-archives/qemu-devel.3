Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBD510BA422
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5yid-0001RO-0u; Fri, 27 Mar 2026 00:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5yiW-0001ID-2k
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:22:40 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5yiU-00056A-Ah
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774585358; x=1806121358;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rg8jsOtG+kuYaPQnf8pActTwgLf2b7dx7Vb40Rws12Q=;
 b=Cf4cdAjE+nNQSmRjihe6FT/nz+lgCZH8o9YQHOW9r5BovCaIhBfhGJVd
 xGPNMzA77aXbV4AX/94KJ5PqJkwcmuUWeEO3pCjy2xjIh8xrQXdTUqlBS
 jeUQg8piFUVPES1cr07cIxCBySyxgfF3fKWkcvFkfNwQuyxeabhP8P0aN
 osbQKvfGVYzMHUYK0BI98LaVZnG9HLuYkTxiFHnoxfeoUYYJ/LYwnPCnQ
 g/sE+zFSAsNpyPzEy7nHsS0ldtttt7EDJbXbZFiPrmb0Ob7UbyY/1YsuI
 mx7Zq8LfUKlaBC9zWmMydB2h6rHKB0lIR8Lqa/26m45BSSydsGLFHX8dz Q==;
X-CSE-ConnectionGUID: hapxoFHnSfiVr/94coJojw==
X-CSE-MsgGUID: Fh+lhcgRQCqGR4QKMmCyHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79560877"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="79560877"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:22:36 -0700
X-CSE-ConnectionGUID: aFAjJapLQ+6p3x0sHeqcOw==
X-CSE-MsgGUID: GJn9Ay1ES5a/Yn5CdrhClw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="255697089"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:22:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:22:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 21:22:34 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:22:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+oBKpASV0gNAbycXWM8YkBRgO8LiBWMLHW6Aya29bUqKT59o4VeOusH7NJ37DFyKFU/RlhHx0bjDsWqkvmozDxxWbx9xMFLwaXAiYHhw4sQoBdtuLxgkDwRdX0dwQn1JZJKa0y2O7lVXLCMxRFHKcLNkG1wxwpF11zZMLAJgpOBCIasDnf08bvpjCEqpt0uWSweI5k/loVi4r+1e4Lhofc8gQoOdOLof7ZGNBLnjMl9B3hCQ2s9QLqzIt/4P8Wm6beqobQW/5wj1oj67Njs6lktBug/09PNGKR+kGmze0ye73LwNtuOEs+F53Zu7K99svUzP6wyFiQ0vHPceob54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0HiwySUOLnznTzgeZBQ1b5nkSJMtKFEvNqL0LndeOE=;
 b=JDaFalvytms2+craeSh68r4HylBs7fiPbqBTHzWY/F4NBTW3NX976N5gyF4q6Q8XQA6iDEpUhx5bNm6+FgvqCLLwcszFWDluP8HaodfzC6Wsa63ueKSSgv/crVZp/fJ2lAEoePTsRKyWOlvzoFMsGAbm33bMEWgxl7WyRqhqBOL/xxRgOdjt0avBy+xKN38eCgiwHs/c6Koxwc/Rq3M4BSel4ZxRG4i8OhcfgwgEbHUThzz121ebdgIvqgqkS8rCLXSFFFe2rTtsgm1dXuJv1YTbKfHDtXFNeJM0eGL0BvDJIHFDZv/4n8FZbnp71wL/qG1nHywgFHSRzJ7IDw6S/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SA1PR11MB9614.namprd11.prod.outlook.com (2603:10b6:806:4c4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 04:22:30 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 04:22:30 +0000
Message-ID: <e5422d16-8728-47e3-b2e7-c8f1a076a2e5@intel.com>
Date: Fri, 27 Mar 2026 12:30:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] intel_iommu: Change pasid property from bool to
 uint8
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-6-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260326091130.321483-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0054.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::18) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SA1PR11MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1c8524-f305-4c34-62bd-08de8bb8760e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|42112799006|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: VvJ5azgeHUsf2+tVt+cNVpIPN+0xXi28M2bIinPuJSJvilsg1ztQuGd+GMtVCnS10JCwzgCw9Y2X6OBuJ/i4GjWuj794zakoESUZ80nouMlCb9jKyp/aLNuH1Ff/lo+PdnvtAh/8nnUNEhxcXyxwIntvwpul3R2NzCRsv5+V1X1iCCkfHDLSoqsJ0pY20n/EK2Gb7A/f0wOMNqhMuBgasrKOIi7bt++gdUj5niPLHGcgzoPKt1CLzsAZ80rzoLe6D5eehIfOLss0AxVg3TdpkTv6xECzcvfAkSpOJ7LGYyb1pSwIoD0PqIbsIvllWQnZKuuj4uU230wXKEq2hT355NLPVfMfunxOhsbERmmPSExw+RheAN365AlrrpaHlA5zv7ozprtTa8J8qBHjSZ0XNZVFhon/ONdCdY+AF9li8NP+YkLm7l+7hsiJByNru+fkdVwvnWrpSLkz2dCLTsjY0qnuyW+jZvR85dv49hJmTVz6IpnmPJRlfA0tAxtXMgatkWds8a+lb9BfQcofKWhB+EdlIx91LSXq0F/FeWU7DhFX/Qko9jvckIHtVgOSrmxhxjbfdXFVSL/UwAahA1YrV3Ip1qeph8jYDOVK3UJl9CYXppMPCJmvN4i0K4aKIvTEMednIl0Oi4UepVrPJgG+ZJb+C0O9CN8RutfKvsl6EVStxqFxcI2DdKqg/6hlxYhtCtXBPBmWF5mHXz7yGVKnjo6dr66bB1Y97RuXq7QoaKk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(42112799006)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTkzUmQvQnJ3azdZckZiVGk3b25qcmkrYmdqSW50Y3lqWW5DOWZLSDZiLzdC?=
 =?utf-8?B?YnYvM241Y3k3N2NYTDM3TmxFU0xwU1hkTE9JQVRCbW00R0hCM2FxR09NZWFa?=
 =?utf-8?B?T2IzMFNYYUJ3cTdWWHJOMlRhbzNQdEs1VlR5M1VLUHp4Vk5pM3RiOFBPUnBC?=
 =?utf-8?B?SzFpRnVVRXpnSDA0bHRyR0FXeVJFeVhYSW5RbzNORDZ6Wlc4VTlVQmJQclZr?=
 =?utf-8?B?blNHNy9vV3ZkbzdjaENxczVOc21GcXFtZ2ZuY3gwYjhZTHFoY3pWMnFYZkNa?=
 =?utf-8?B?MVF4clo2YkpETk56cldoL0pxbEdGZDZxOFFoTlZoVU5MbHluYW9YT0FlWkxW?=
 =?utf-8?B?bERrcW14MjlsZFEzUndmVlZ6cXY2VGsxMTVSSWFrVHozVFBibUo2MEZqc3ZG?=
 =?utf-8?B?UWduU3N4Q0pNT2MxNVZjNmk0OUVZQk8wSFVwa0ZtSmNYaWl6VmxGcVRNeXlu?=
 =?utf-8?B?SUVNbVBvN3ZaMGV6NHR0aTlyQjVXSGY0VWFOb2QySlpCOWhHYWNtVkF1Nk9n?=
 =?utf-8?B?cHUvRWNyLzBzTnk1UXY3Q0R4U0F3K2FWR0lXTU55a3NZNTlvK2R3ZWFKQmRx?=
 =?utf-8?B?azJMQ3hIWjdxQnJ3dkt0OXBqSzhHbjJ0L09ycnQ4elMraWZUcFZkMm1td041?=
 =?utf-8?B?YzJVNXFXaG9ZcmN0TldhQzJjTjViOHU0NWgvREt5TS8zZHBFZmczbGhmd280?=
 =?utf-8?B?aHNjR3RSYXZjVWRsMVdZK213WCtBUTRkSXh6VHFFSzRaY2RkUDR4UkFYVThN?=
 =?utf-8?B?Q1ZtSDJ2dW5Wd1dEb3VWK0RuTkpvWVgwUGsvMzdYNlVrbGQ2WUZYcVVlQnRi?=
 =?utf-8?B?ajg4d0FnK25BQnhzcklzMWJpR0dUU0tKbmFzYklQdTJSR0NkYmovWWdpT3JY?=
 =?utf-8?B?d2RpU2Q2MmRUaURRZlVEZWN2VHBUWkhsbzZUaUJzQ0RtcUVCUk5WWlJwNVhO?=
 =?utf-8?B?QzFoNXdNMEE1VkFuSWc1WStNMXU3bkxLcTZwbGxPZ3J0aEorYTVPQ29jbEht?=
 =?utf-8?B?ODNJZ05Nb1BmeUxGUUNSVHBVNjVOMnJEcHQ3eTF5ZmlGcUNRWUR4bjZQYjYz?=
 =?utf-8?B?dTIwUEtvTU5BVEpRMFdOaGRiaXJQb2svSlVEbndnYlV2c2oyUjFyeHRXVDNh?=
 =?utf-8?B?NjRMNlIxQVpyaXBGa0IxUUQ2bzRzRkxGSkhIdWxmV0h6Umd2TUx1MkpCQ1Nh?=
 =?utf-8?B?SU5DZlB4SFl2SVFXb0xpckc0Z0w3OXQvY2d2MDNXUXhqZjdyWlFEa1BQOHcr?=
 =?utf-8?B?SzNkQ0RGVnNzZjF3NE1HUlo3aHgxcE41dk1FRGFMVTVaY0o0RFFHZHN0bG9l?=
 =?utf-8?B?dEZYSlFEYTFocWJMV2lZR2EyNnB1UzZiUTBSa3FWaXc4TWdicFZmbEEwcGM0?=
 =?utf-8?B?R2lUSjRQQUI0bDBENlRZN0ZBN2hjZjBKeFNXaXgyM1ZuZ0tPUzR3ZHNiY3Yz?=
 =?utf-8?B?dGhDbkpPMUZXZ3ZlcnNqODJwU0FZZUJIWGhObDkwazVGVmNJWUxBOTlkcmJx?=
 =?utf-8?B?N2xLSzcwTWJhaFVDeHp3Ti95cnJTeFNvNDEzYXpoM3pzQk5QN0g0SEQyQXFk?=
 =?utf-8?B?TkdMTktoRHNUWUpUWGkrWUxwOHBoekJtNDdocGR6TzBRV3JwaDYvM0Z2V25N?=
 =?utf-8?B?MnR6V1Q1cGxGa1dhSm5ETEgrcHJZQWFkVS9VbUZoVGg3Yk9wdW5jaUVEL05H?=
 =?utf-8?B?Y25WMVJBTzlqU25Qbkx3WCtoSWxGM1k5djRlaXRDa2kzRjErVTQ3M1dHeDZM?=
 =?utf-8?B?Y2dxYlVWVlJnY3RCaFdmY0lpRHFRTWN4bHhja3lSM2hsbjJkQmhsd0RkYjUz?=
 =?utf-8?B?clorYXJ6djJKVmdDWkVVNkJLczcrNWxvekRPbG5ZL29BRUtVdldsTUtOMjJt?=
 =?utf-8?B?ZHA1Sm5jUk90b3Z1OFBTMTlYaHV3ZmlvRGlVZVZhWUR5WWhUNW9QU2U1WjZs?=
 =?utf-8?B?dzdHblcwNDBlUFBqL2FRSXI1TFhyQTFhRSt6eXdvT2piNGlDc3dLMzFVUFE5?=
 =?utf-8?B?OFhiaDFmbzM5SjJsMUdnOERyUVFFVjFwelJVNy9YZGkwVE5KUUw5V2hydFda?=
 =?utf-8?B?SEZtcUdISW82dnFoRm1obzkzZnNBT2NrK1JtdEYzcEtOS2szZWlSNDdkRzVV?=
 =?utf-8?B?UEE0NG9SWmV2QlRpWFRzZS9iVlEydGVZVDBPY3drOGlmVDEyWE5hT3REa2R2?=
 =?utf-8?B?K256OWpEdTlTOFhaREJCSnRDbDJyMVNFa2FjRjA0N29FdmRSVklWd1ZaZEx5?=
 =?utf-8?B?UVFER0d4ODQ5ZzUvc3lLdHRMZzNsU1VKeWI3WXQ1UW9KQmNyWWNMMEJMcFdu?=
 =?utf-8?B?eXl5S0tUTjlXYUVVWERRdGc5dERMMWt5R0duTXNuRFhWcGRVdFdXZz09?=
X-Exchange-RoutingPolicyChecked: HCJxf6a6q+oFo7XNvUQaauPrkIoDE+NlVhaEBUJ5rGNUm9zjy20iDTnoyI1H/w6w6xzaMDzSDiHDrW6Oht2CfCwz7wIAy/INmPq14LEYe9QX1zRwOR5flyoIF+tL+2wad3jUtZP1ZWbGMKiJop8dge91RVglOAMcKhy/GVz6w85MxI5TlurRDWLLF4E8UR+6U9JnfGrCkvV2AjbvDzXqAIsf4RsNLXvY8Fzwmi9DVXM44tjcXqTAJC+lXIvQIJAB4EkV7Q9RNqnomW7+E1U6L4RiZIaJuU05Xfdux2BNralr4jifW2efmb/wSQLWoSd6qne37UAVFo9CNf5t1n6PVg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1c8524-f305-4c34-62bd-08de8bb8760e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 04:22:30.8234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAbUf1Zv8IUhShIPtSH7UJ2If29ma0IEIQKOKQSUyMM3PRbavIOP+AvvYH0mN8S08WYyy/6i45YmXEexqEPqNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9614
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 3/26/26 17:11, Zhenzhong Duan wrote:
> 'x-pasid-mode' is a bool property, we need an extra 'pss' property to
> represent PASID size supported. Because there is no any device in QEMU
> supporting pasid capability yet, no guest could use the pasid feature
> until now, 'x-pasid-mode' takes no effect.
> 
> So instead of an extra 'pss' property we can use a single 'pasid'
> property of uint8 type to represent if pasid is supported and the PASID
> bits size. A value of N > 0 means pasid is supported and N - 1 is the
> value in PSS field in ECAP register.
> 
> PASID bits size should also be no more than 20 bits according to PCI spec.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  2 +-
>   include/hw/i386/intel_iommu.h  |  2 +-
>   hw/i386/intel_iommu.c          | 11 +++++++++--
>   3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 11a53aa369..db4f186a3e 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -195,7 +195,7 @@
>   #define VTD_ECAP_MHMV               (15ULL << 20)
>   #define VTD_ECAP_SRS                (1ULL << 31)
>   #define VTD_ECAP_NWFS               (1ULL << 33)
> -#define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid */
> +#define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap = deposit64((x)->ecap, 35, 5, v))

does this change still meet the limit commented by "* limit: 
MemTxAttrs::pid */"?

>   #define VTD_ECAP_PASID              (1ULL << 40)
>   #define VTD_ECAP_PDS                (1ULL << 42)
>   #define VTD_ECAP_SMTS               (1ULL << 43)
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index e44ce31841..95c76015e4 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -314,7 +314,7 @@ struct IntelIOMMUState {
>       bool intr_eime;                 /* Extended interrupt mode enabled */
>       OnOffAuto intr_eim;             /* Toggle for EIM cabability */
>       uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
> -    bool pasid;                     /* Whether to support PASID */
> +    uint8_t pasid;                  /* PASID supported in bits, 0 if not */
>       bool fs1gp;                     /* First Stage 1-GByte Page Support */
>   
>       /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index f395fa248c..a7b676cd13 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4203,7 +4203,7 @@ static const Property vtd_properties[] = {
>       DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
>       DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
>       DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
> -    DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
> +    DEFINE_PROP_UINT8("pasid", IntelIOMMUState, pasid, 0),
>       DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
>       DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
>       DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
> @@ -5042,7 +5042,8 @@ static void vtd_cap_init(IntelIOMMUState *s)
>       }
>   
>       if (s->pasid) {
> -        s->ecap |= VTD_ECAP_PASID | VTD_ECAP_PSS;
> +        VTD_ECAP_SET_PSS(s, s->pasid - 1);
> +        s->ecap |= VTD_ECAP_PASID;
>       }
>   }
>   
> @@ -5583,6 +5584,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>           return false;
>       }
>   
> +    if (s->pasid > PCI_EXT_CAP_PASID_MAX_WIDTH) {
> +        error_setg(errp, "PASID width %d, exceed Max PASID Width %d allowed "
> +                   "in PCI spec", s->pasid, PCI_EXT_CAP_PASID_MAX_WIDTH);

s/exceed/exceeds/

> +        return false;
> +    }
> +
>       if (s->svm) {
>           if (!x86_iommu->dt_supported) {
>               error_setg(errp, "Need to set device IOTLB for svm");


