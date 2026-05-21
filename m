Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF89CCD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1zp-0003KJ-7x; Thu, 21 May 2026 07:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQ1zk-0003HZ-Kc; Thu, 21 May 2026 07:55:20 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQ1zi-0003Cy-5h; Thu, 21 May 2026 07:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779364518; x=1810900518;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4aCZE8BDzlY+AoZdgOUYURzngPcgDOjIu77bSjuHpLY=;
 b=PakM39MBAfPhqjdo5l15XJjrhAFHrUVL1VbnE6jye6Q4UBPjmfbMocyb
 x8mYlS+WGkkkhraHNqU/tI4FBJVpVFbClgJyKk5/d576P11oQogrrN/6W
 ysOPFFxl2JRxgNFq+vCZZT+9xBVfE6jshkK8YT+km8YX5op6Y2CXgY11w
 8H9zXnBrSKcRQaXHj0a8rUtlurAkqNxto0H1KhnK+qizcRLRJ87t1XFCo
 XCM8achTc/QXP4Mzo4vpyRVcjceTEeCwWIvAQNQjCjcI72UK7MZgULLu3
 X1JRZ3oHozpXetiTonsoiBHAnlBRi4+9hx6/11ogBcvcAi52bjLXYYohN w==;
X-CSE-ConnectionGUID: skA1M3nbQhWWYvF0J090QQ==
X-CSE-MsgGUID: 5UaEzkJzQeGRcZ6vM1PFIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80245353"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="80245353"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 04:55:14 -0700
X-CSE-ConnectionGUID: HzJsF91gQa613o7Ok+I9Tw==
X-CSE-MsgGUID: DwnXdrE2RH+fvdDiaJFKxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="239497790"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 04:55:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 04:55:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 04:55:14 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 04:55:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Konmv454lG+U8sKQ2f6IrmdY5lcKH2MQJa2uCn7dqgM16TQc0qDlvzuGzXkUmlTtZYRQln8fKKpyZhIE+c9m/LTlye/75XYk9UBRGZ9o0BaAtEWJmtuIHXHNnyiTYjSRKQY6TJOoqO6L/+R0E4RwWZKeXY1O3yZKOSVt/H51ICSRTMLLnxDdcdaSUISrv2kfzw6WFZ0hgiud5Jway4fQ6xxaa3yBdsULlVdt0CKZhXAbVyVehjIG/c1YhE1R4ZLx/rw3NjQEnZrKysvtoNrXU4e0Rf/0nt1rudU023y4jgRVLVVPkbPNirjt+DwwS1hXOcO6dZGa45PIOsntw9VxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=la/0lCuAj/u0Oi59opzb0q/15wDVfKDxCiW9WdvCIxo=;
 b=Pa2ArLhIpkH+88PTw98JFL0cO6GAzog+3lO9yz+Ux4dmF1aSx/cfu1tEHyHghaAEtIFT82mNGYKk5daHCmK+HEUVBG4CafW4L0+vufFpof68IaeNiWC0J5KK6TFU4NbYcBu2LPsDQWhZ3em6FUgqxUUuYb8jodCSGTpIErrH6vLcm2DHqlXNvcHWGMR0/voXNwgV/QPUTMyJqnTGET2ZaoXlEpnhxuaNuDpLfsejY+OtLBEjtyUsn6s+3bdZ4zl/aFhPMzc2Eu63sm+SBrASyZwo13EkfpLNvdoxdIWMlo8cqcLpcLSxCdpRog1I6w9mUWeqv5DbwniwSbTjR+4GXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by LV3PR11MB8484.namprd11.prod.outlook.com (2603:10b6:408:1b4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:55:09 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 11:55:09 +0000
Message-ID: <aa7b6186-9605-49bf-851f-352ddcc6f55d@intel.com>
Date: Thu, 21 May 2026 20:03:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] backends/iommufd: Extend iommufd_backend_alloc_hwpt()
 with fault_id
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>, <qemu-arm@nongnu.org>
References: <20260327025228.474257-1-zhenzhong.duan@intel.com>
 <20260327025228.474257-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260327025228.474257-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|LV3PR11MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f14bba-bfcb-4395-d4a2-08deb72fceb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|7416014|366016|4143699003|18002099003|56012099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: lrEYc5w/UbB5NFaIMjFyhyufidk/CF/C7pNfpFgJM7S2hV/Z/oIPtxhLeqD5uqFeQNYyHTGWQno1brPU+I+TJ7l1bUL5Qjqvbe9FRrbNw4ieppJ57GpZ+98xyMbWY0B+onbhcEygX3HsQX1g4eOx/XtNbYQhw210DlyavKYGWL1QuCgtkBsm0HrszRS2KuCkdn3yWYNrDkECqYdXHl9mT9dQLG7q4bPJr+XwrGooX8v139qPucZ5WQm2kfC24Xzgt5oc0ivzYvoewKsE4AoqCmapX37FOqg3iKbh2FSGbiz9un6pbN0oY7u67CvcSJrwNkA+MHKH81bQiLjAU2M8TKKxJV9FnUUbArxUiAmbLi4HrC3nF+P1MmhZzfLb3+3ua1tw0bB6j5IKT3F1i8J9Rw/8DSFEZKDni5bhtH9oMCNw2ko3B5RUH7YAYuGPLuQv9XJ0l4HyLXX3fSLpagd2t4o+52QithFFj7zJjz2D8qEh/PFEsQMgYb8cNbgPi2YjO5c5ZU/7/AqzTdKTHbYkEvMVW1Isis8wnWAbdJ0T4PXGYXSDXz4OaKgQX4AEAq29EsMk0jwYehzhJQBMaJDcKzRpjQL8a4Unf50xt3P0vSvM2JpoNlDBEmmaCsnMe4ZQdjIJSd0jpBWSFRaQdu8WUwTcVhYkIMcjXWjeFiz3zSzSfyOBJ9msMn6JYjg293GL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(7416014)(366016)(4143699003)(18002099003)(56012099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmt3U3JZMlF1cjFESlkxMWdqaUdRdUNhcjNKc25HNW1USkZXZ2JSbFJJWnFw?=
 =?utf-8?B?N1I4ZmdWZ0EreTJoTms1SU8wN2l6emhhNnhWRTFMUFlVYnRORFg2cXNjMm1W?=
 =?utf-8?B?MnJZYnFFVHR0RGpUQ0w3Y2R5VDBzMWkxMHpxdkJ3akpCdGM1WlM1eUlNeXZI?=
 =?utf-8?B?N3hNdzlvNWlkSXo2Sk51UVJtYXhCdHF5NlVocEtTREswQ3pDZktPQ2xhclVK?=
 =?utf-8?B?clJwU0ZoeEw3NkZtWFBEZ1ExdVB5WWZycGVNVkVpeGFyTUJoeFp4OGlNWWZX?=
 =?utf-8?B?V3E2Rllqd2JiRFpnNkVMSFQwS3RyOUxIL0xFcitSdjA1SDJLZ2FybmJsMG9z?=
 =?utf-8?B?VG9zbFp1NTBwek5rQjh1LzErMmdrNlBrL3Y4UEZiQjE4ZUtianNZUnRHbkcz?=
 =?utf-8?B?RVJhaC9Ebmd2TkZSYUlzNW9yZnZ1WVVqcEN1eHJ1bElxSGdLME5jOG9ORGlo?=
 =?utf-8?B?MlJjN1BQeEFpY1ZOMnVzNm5UNERhcWJvQzViVlUwcDF3SjdOQnhNK1c4ZStk?=
 =?utf-8?B?cFpFbjl4MGJvcnRJenl1S09sNkdqTzh2RVJNT3FHcEtNaUI0SnAyM3pFK3Nt?=
 =?utf-8?B?MVNBN0xDaGtLbEFQSUZnY2tublRvU3pmM1g1MUVjc0x4bCs2VWtKZ1JDQUxL?=
 =?utf-8?B?WHFSWERaU0RkMUJxaTJmRFBvQnI3dTl6dXVzUTdCajVoV2prSHY5RlhWb2kv?=
 =?utf-8?B?d2J4Y0Z1d3k3bS9GMi9qdGhEY25rZCtwejRtVTFpTk9ldnJEY29telpFQksx?=
 =?utf-8?B?OFRNOEhLQ2w1dlZrVk1GTGVIaVEyaCtZK2szMWxud2xMcGJxUkJxTmVsd2hI?=
 =?utf-8?B?UGtSNGs5UkpkRFBRTmk2dlB6NGNIR2EzRmNBeWFzbzN1ME9rVEY0Skx5MGwv?=
 =?utf-8?B?SHVzUlM2TXNFd3FlamVQV05uaThTNkdROWJqWXNBMzNXZTlOei9GRG5lQ0h5?=
 =?utf-8?B?WkUwUnVZdUhDeDhSS3lFQ2Z2dnBqemIvY2taNDBFOFNMRituOHlIRUR0c29Z?=
 =?utf-8?B?aCtSNHE5MFRtdkVCeW5TSWMzdVMzYkE5c3hxazMvdXNqVlQvNTVZSlJlRmRQ?=
 =?utf-8?B?a0dkeWNhWmgvTlozN1lBZmd0aktBYWlWZWI1NXdYK0RCN25vMW15TDNEUGxt?=
 =?utf-8?B?dkZCMWVRbms3aE50d3lvVHhrazZxdTE2R0Q2WEJKMnZaNXpGR3hiemI4d0xK?=
 =?utf-8?B?aXNSWCtHUlJBUGtSSldRbElYVG9pV2RndUtGdFNQOXR1YTJSZEJvOFlGUDl0?=
 =?utf-8?B?NS9BWVI3VE9qb3RKeVVDY29nRW5PQ2NYazhySEJuMlhFVVRIZ2hiRWdaSzZJ?=
 =?utf-8?B?dlRCWEZFRTJ5cXh3Nm10VkRKUkhmcXkrOWpGOGJPSkYvOGt3OWlpUXVDSkt5?=
 =?utf-8?B?V1VKV1hSamVCMy9PcjhNU0o1dTcxckRLNklSbmFNY2c0ZG0vM1QwSXpWRWdR?=
 =?utf-8?B?L3hDbU1nQUJubk1tM3NKVXRESk9TOEJaaExsWDlselB4TFBsNDI0U2t4Umd5?=
 =?utf-8?B?T0VoZC9QNG9ZRTNIQllaaU9FWGhyNnNHNGRsNkgzZ1ZFcGRQQTdLTm5YYjVT?=
 =?utf-8?B?NC9OdWp1b0VRUGphQkJQRFVKWitDUCtXS3lGZGY5M3JMclJvMGxRY0JVUWcz?=
 =?utf-8?B?Y29SM3kwWXdTcnFBMnUrTkh6Vit6THdOekkvL2s4T09RNXE4blRTTUdFWHh0?=
 =?utf-8?B?dXdYRUx4YlYzK1dKNUF3LzN5RDBzc3dFcTFNRVhCakN3MFVuVklUK01iNUlu?=
 =?utf-8?B?cnp4MFpwbEtvSWNORDc2UFo1QlhVSG5yczBvOGJoT3FkT1Ryc3dxdGNLSDRV?=
 =?utf-8?B?aElLMDdOVHBPS2xUS2Q1aDN0T28wNmtKUWhBYU9zRnVhRkxvZmI2WHBXcitt?=
 =?utf-8?B?QUZmeTZKL0llakQ2QTJZK293cWV1THczYXZzY0NNdml1NHlMb2ZEQm0yN203?=
 =?utf-8?B?dG5jWXEwZlVuVEltWEczMnpMaUpsc0V2YThYUlJKbDlTS2tmbENsN3Vxamhz?=
 =?utf-8?B?RGdrRWl6NU5kRjdvbGZlUEQwQUxmUzZxUVl1SGpjVGpyaWFyOS8xVWxRaGpP?=
 =?utf-8?B?OE40bjByQlBCVGdSRVdWTHh5MFMvYjJHYTdqWXcvNEdsaXlmd3VVbng0SURP?=
 =?utf-8?B?S0w3VGFTSTBmdXh3UEZwQ2Yrb3FCa2V0VkF5RmxtWG5vd2lMQlp2ZTg4T2E4?=
 =?utf-8?B?TG42UE43ZVRzbUdDMGFTUnNYWS9rYzA5NHBXUmVXcmlZZm9MdGlXUVhYcXFa?=
 =?utf-8?B?OHNUVm5wR2ZKZENPaUxlKzN5em84VWJXVEpWMGhqYTVwNVVqN1d4a2ZEbDRx?=
 =?utf-8?B?S3JhM0tKLzl4ejJtbzI4L0YzYkFDM0xrandGK25jYkZTM3pTZFZYQT09?=
X-Exchange-RoutingPolicyChecked: OwLM8dRyxfrZKgK9+E5ji4oxuNQfj2a88C0U+fF9BnP80Fec8zITTfCI2eucQKPw6s5b9S2BfyUaOWoK48d4Eg+CKlqOeikr+j/LAkIdtb7YWCMqe2WszM/+Me6+JDOprq55f0J2G+V+dHXeNAt68c3n3bFbVZ4d2QYLnGi67ssDvXJZzKFoCi0LshD+1exyAJmD2N/Uw/16579DP8ldOalC3pIAvzb3FLRwsffgpPm0W7igwS4XSRCuxb8RdGzBWHKYBfOWQ+jckamzlY4XDDNeabzDpNpYaImv7p/vLqWl1uxl1F3wgojZEwhxMBD1p2BAAsRi6XiDeVOy0MsJMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f14bba-bfcb-4395-d4a2-08deb72fceb6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:55:09.4500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPIlMd9mhyBzUg6lB8/maGuWX7/dtjj8CppCP8mNr0BM1xl19fZA8J3I8Eq/uyc4Nu1EFMxGmVfVw0Ue78M2MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8484
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 3/27/26 10:52, Zhenzhong Duan wrote:
> No need to force caller to set IOMMU_HWPT_FAULT_ID_VALID, we take it
> by checking fault_id nonzero.

this is not reliable. There is no doc that claims fault_id should be
non-zero.

> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/system/iommufd.h    |  4 ++--
>   backends/iommufd.c          | 13 +++++++++----
>   hw/arm/smmuv3-accel.c       |  6 +++---
>   hw/i386/intel_iommu_accel.c |  2 +-
>   hw/vfio/iommufd.c           |  2 +-
>   backends/trace-events       |  2 +-
>   6 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index d4ba8434a5..f753bfaf69 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -85,8 +85,8 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>   bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                   uint32_t pt_id, uint32_t flags,
>                                   uint32_t data_type, uint32_t data_len,
> -                                void *data_ptr, uint32_t *out_hwpt,
> -                                Error **errp);
> +                                void *data_ptr, uint32_t fault_id,
> +                                uint32_t *out_hwpt, Error **errp);
>   bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
>                                     uint32_t viommu_type, uint32_t hwpt_id,
>                                     uint32_t *out_hwpt, Error **errp);
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 9496377a25..fe64badea0 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -310,23 +310,28 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>   bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                   uint32_t pt_id, uint32_t flags,
>                                   uint32_t data_type, uint32_t data_len,
> -                                void *data_ptr, uint32_t *out_hwpt,
> -                                Error **errp)
> +                                void *data_ptr, uint32_t fault_id,
> +                                uint32_t *out_hwpt, Error **errp)
>   {
>       int ret, fd = be->fd;
>       struct iommu_hwpt_alloc alloc_hwpt = {
>           .size = sizeof(struct iommu_hwpt_alloc),
> -        .flags = flags,
>           .dev_id = dev_id,
>           .pt_id = pt_id,
>           .data_type = data_type,
>           .data_len = data_len,
>           .data_uptr = (uintptr_t)data_ptr,
> +        .fault_id = fault_id,
>       };
>   
> +    if (fault_id) {
> +        flags |= IOMMU_HWPT_FAULT_ID_VALID;
> +    }
> +    alloc_hwpt.flags = flags;
> +
>       ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>       trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
> -                                     data_len, (uintptr_t)data_ptr,
> +                                     data_len, (uintptr_t)data_ptr, fault_id,
>                                        alloc_hwpt.out_hwpt_id, ret);
>       if (ret) {
>           error_setg_errno(errp, errno, "Failed to allocate hwpt");
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 0af6b3296d..1e2fb1e748 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -224,7 +224,7 @@ smmuv3_accel_dev_alloc_translate(SMMUv3AccelDevice *accel_dev, STE *ste,
>                                       accel->viommu->viommu_id, flags,
>                                       IOMMU_HWPT_DATA_ARM_SMMUV3,
>                                       sizeof(nested_data), &nested_data,
> -                                    &hwpt_id, errp)) {
> +                                    0, &hwpt_id, errp)) {

same remark. passing 0 is not reliable. :(

>               return NULL;
>       }
>   
> @@ -558,14 +558,14 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>       if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
>                                       0, IOMMU_HWPT_DATA_ARM_SMMUV3,
>                                       sizeof(abort_data), &abort_data,
> -                                    &accel->abort_hwpt_id, errp)) {
> +                                    0, &accel->abort_hwpt_id, errp)) {
>           goto free_viommu;
>       }
>   
>       if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, viommu_id,
>                                       0, IOMMU_HWPT_DATA_ARM_SMMUV3,
>                                       sizeof(bypass_data), &bypass_data,
> -                                    &accel->bypass_hwpt_id, errp)) {
> +                                    0, &accel->bypass_hwpt_id, errp)) {
>           goto free_abort_hwpt;
>       }
>   
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index e73695ff83..32cca7672a 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -115,7 +115,7 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
>   
>       return iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, idev->hwpt_id,
>                                         flags, IOMMU_HWPT_DATA_VTD_S1,
> -                                      sizeof(vtd), &vtd, fs_hwpt_id, errp);
> +                                      sizeof(vtd), &vtd, 0, fs_hwpt_id, errp);
>   }
>   
>   static void vtd_destroy_old_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index dce4e4ce72..e4e8b266ab 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -444,7 +444,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>                                       container->ioas_id, flags,
>                                       IOMMU_HWPT_DATA_NONE, 0, NULL,
> -                                    &hwpt_id, errp)) {
> +                                    0, &hwpt_id, errp)) {
>           return false;
>       }
>   
> diff --git a/backends/trace-events b/backends/trace-events
> index 6820a9939e..8a204fcb73 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -16,7 +16,7 @@ iommufd_backend_map_file_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t
>   iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>   iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
> -iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t fault_id, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" fault_id=%u out_hwpt=%u (%d)"
>   iommufd_backend_alloc_faultq(int iommufd, uint32_t fault_id, uint32_t fault_fd, int ret) " iommufd=%d fault_id=%d fault_fd=%d (%d)"
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>   iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"


