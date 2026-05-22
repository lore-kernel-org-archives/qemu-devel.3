Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76D1CD5BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 08:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQLfb-0005th-5k; Fri, 22 May 2026 04:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQLfa-0005tR-1R
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:55:50 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQLfX-0006zW-8T
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779440148; x=1810976148;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ihNASq1+Mr0p3UhBAG4v2JZyPm33l2nmOZO1x+TndGo=;
 b=aE5xuxEqXhP/OxToLJoJha/Mv7OVyvWUSQCFwDj728ERvGEveDzqqVlQ
 441JwGyldGsCnHLEBFvkKnQmdFNK5bv+DV9YmQzavXurr+nSM8HyPF5a0
 ei9hXFskk2hyuriiU+SRXV/hWm+mloXVxkPO2BDHH+2mBUzjMt4hIE1AV
 NLtdalacVgp/2HWUOH7RZEbSDL0DBkla6qiuT4+abNHga24Gk/fOHWM2A
 CMV7Co6oj/pCoYN9cBi4yXBJWpUbcq28PbPfaOHiBvxu2LPmVod5A7I6Q
 wPY6okZTBRGchFtu4b49r2g66DUYIps82VpsbKIZt5B6mjp10jwLKhmVW g==;
X-CSE-ConnectionGUID: ciDir3XzRnqjPBsP8AdD+Q==
X-CSE-MsgGUID: EAF5oMNMQju/v6Hef4Zz1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="91836584"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="91836584"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 01:55:43 -0700
X-CSE-ConnectionGUID: 6fdhbrHMRoGtn/BbynAAlQ==
X-CSE-MsgGUID: vhYa0dOGS/SH4Z6N+wEF4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="236430783"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 01:55:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 01:55:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 01:55:42 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 01:55:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfOYyiljVpLkjXOIxI+QffIAen3Gul6a8QP6frU2j+I/od+2fTxzPC5JIuY3yvbfYwOs+bnB82sFZt39bqlbeXzPAnaA2LEn2h0v641HxX/nlIU7k+9aFHSqA4W2VivIDC0RU/5IlfNAclpfp9tRzVIjIFhe2piOTgMTrjarVEpHmlBcqJhnehaEaXmcO4wNqeVKQWbCNmOWxiGn8PHXIZuEvLZvEp8CB9QuDX4uDCTpyUNndiRWOYKvXP/9TjZs+8CpX8C6vhcsbZQ7HnEXz0At+khlUcmsLs0h9Kd4A6ycIjkEZ99g6PIKghTxdRmm4LxcoTAg0KldVeATLsA3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugANaPhzd/NmF64i8NR+lSUa2fWIY4onE8lFPkNuht4=;
 b=P6dv6aLggoKjA8uUmHEc5OZAPqSMU+CUyhFQiDV+HSxZ6Q5ktDfIkg96WyJnZ6cZHhOjqsZ27g1D6tXssATz5Ei6SK28TvfiHm00ZeWhj00JyfGZb36m+n5WJVst8PhfCFUkiyMmYaS7vZm/T6mnzh74iUUT5B4/dGLIITLZf8PxC/Uspznhr9hM+1RBPLA5PWJxn7sWJe1mB3VlIZpaIbF+cScYwwY1ShwW5/9Ud2iaJ3VYMfsfkChCQqKA8qETbSTl/r9nLAJr+Gh5ih0Zocdba/NlQB/Smw+BpKptfFM0UF01b8rI9owy6HYdbdsiQcpBips00O3XzCIPDT8x7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DSSPR11MB9617.namprd11.prod.outlook.com (2603:10b6:8:375::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 08:55:38 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 08:55:38 +0000
Message-ID: <874d3755-4ba1-49c4-93ba-91b1e268ac93@intel.com>
Date: Fri, 22 May 2026 17:03:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/15] intel_iommu: Refactor PASID processing to use
 IOMMU_NO_PASID internally
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-9-zhenzhong.duan@intel.com>
 <eb419b7c-8fe9-421c-b0b9-d2dd5993e6d1@intel.com>
 <IA3PR11MB9136FA1C2BD60E9A028FC71692002@IA3PR11MB9136.namprd11.prod.outlook.com>
 <053b39b1-c522-491d-a36f-aa105485f916@intel.com>
 <IA3PR11MB91365BAAAC96F5E996416BC592012@IA3PR11MB9136.namprd11.prod.outlook.com>
 <c7f4ef02-a25f-4dc1-895a-4c3686ab6b4d@intel.com>
 <IA3PR11MB91366F6E763BDF93EE03D732920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB91366F6E763BDF93EE03D732920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0009.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::19) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DSSPR11MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: baf21a8f-28f7-49f3-228f-08deb7dfe4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: keUYGVW0lC0F/xu0FM6Ls9eZb31uJBBJCUGeUAd4nSsQba0W598MEdzCQi298Fo03sujrSUtW9lrwR33se/0dpx/IgUXwW4v/mXZO1bpJ3ReX6B8LR6RXAqZIjNkgH9Jy7MDualDU0LzAaEURfWxQ560CeZ/9pWwRSALi6Wjt2BRKkO1a1rzmq+y9kfv9NqN8dbVYN35igl+QfeFo1aO5kskStc8MJbf6iXCwqIA9K9DD6x/xqo+BqmvNszBdfLdRMuuZprNiO+fTcrm3QmSSq1SRb1CyO8dUB/0nHm+vA8tcUcb9OKTZYRBLEaQLEOM2930BMQb3ZRhPlWJ3aK8NGanioHRWrGdAhZHseo1+ZD4QoZU5NNjj4GWrYp9l7wKkZqkxGauMTKHjCzkk+uKwajScTcjFGnOCHd/Fu01QcnQkBd9t79RYxar+BsPcHFwxLd6hE+KIIx5oa1JNjItCpab4/hdfXKZHfREoWZZwWjdZU7oDxtFpQIetHQo5Zp4BZrWYXoplyO+5iMc+YUXzzfzczhbCXswFqpp6OCbw4tVaFJAFgRpR0syRKo9cBUq+XidKYm5IktO1aDY408/UfNPpyuk1hopQlsiGmsQMgPdTeH9LCTWv8uo9yS/ZkvShguYZATwlDDfAB8Te5zWOP/steDE3bUTL6mBd3KTEn917jbY9N3YXKwJDWPAb2zt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(6133799003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkxyNDBpL1dad1E5QjVMOWxKMGVlMWV5MU5tZlN1SkxJRkxPQmttNUFDMDFp?=
 =?utf-8?B?T0tpZktvM09RQjdYZHVBMUxKWFVYbUxWNG9jT214VjZDdWd1WWk1eDZaUzQw?=
 =?utf-8?B?MmhBaUFIOTRyVHJkTVlvd1JwbUZpcEVBODJNNmpsNElkdUkrbENmdnBMZ3cr?=
 =?utf-8?B?U0kvUGcrVmtJc2swVGl1WlgwejgwVkJ3RjFTZDNvcWZyelJjcEliZzU2NXFM?=
 =?utf-8?B?QnhZYnpZdEZOSWFWUUJaTkNnZGRieG9FdUdwQWhhK00vZy8yUHVkQy8reE4z?=
 =?utf-8?B?d2IxbFl0bWYzY1VXRU9FRXQ2VCttNlE3eEMzRGE5SkJQdFpHb0Yza0JrV0N6?=
 =?utf-8?B?ZVM3M0o2azZkenV1K09QbDBPY1FLZ2V5dDJYU0ZXc00rU0FBMHkzN0FYb3lh?=
 =?utf-8?B?WDVvbThpa29Wa2gxL3FOdU9yRVI4RTZkdEhGeVN0RUJPNm4rUkwxVzkwdkdp?=
 =?utf-8?B?S1MxNHo0YkJzMGY3NWdNNGZucTNJYVJEQTZJaDFtWDZBcVZSdkdTeWlHVzZT?=
 =?utf-8?B?eU9XTW5UMVdSZWkyeVVrR2t6eUoxVmJxcGI2UG1KVXZEWTJ2emJnQ0RzZzR4?=
 =?utf-8?B?T0R3S2pqRmNnbERZWlNRTkZvUUtzUlRUcmwzQU1BeWZOeWM4YzhITFJtSHRM?=
 =?utf-8?B?MEtoclZKNHltRjNNZVdTVUJFUlFETkVld1M4Sy95K0craC9xc3JrYlhYSVp4?=
 =?utf-8?B?SWV5NFp4MzE5TVNIRDZPakYwcFdzaWQwNkJrbUNuY2tZMXJ3cU15WjRndnd4?=
 =?utf-8?B?ZkJ4MVVZeGV0WE5RR0FoQThvQVBybnN0N1BGL29vdXcranY4SzBqWnFNenc2?=
 =?utf-8?B?eFpZLytGa1dMMTlMbGFlMFY0MVoyMU5teDhmc3VTZDVhRzlpQTBTTHFlRXZ0?=
 =?utf-8?B?MEpydmg0SkxSdm5nbzRXc1J4YkJxazVvRndlWG44eXJCazZNVkpUaXNpdUxw?=
 =?utf-8?B?N1pQUVNLcTByQ2FMRkJ4RFZjdmhtZDVrTnRIL2oyN0p4Mmt3N3Z0MFpQQ1Yr?=
 =?utf-8?B?N2FMR0NYdHNOWkdnd1BFUHJqUjM0YkZGTER5bS9zQjJWbXBjL0doOVZWQjNT?=
 =?utf-8?B?WFZEWmVoWlM4OWZiSkowdGdKaVRCYWtqY2pNNzhaWDBxZWRIQjNpR1d4WExL?=
 =?utf-8?B?bXVWK280amluMm9oTjNQb3M1bFBVYUVEOXpuTzR6azdHbmZFZkl3dGMyNk9X?=
 =?utf-8?B?ekZvVWl4YjZ5bVZlSlRJa09ReHowU3BkZFE4UEN0YlZwb2FiUHhOUEg5RGxz?=
 =?utf-8?B?TDZZV0Q2UGlraXJUWEl0RTRidDhDMWlKbURUL0pKUFdWYTd5MkZuYlFlYk41?=
 =?utf-8?B?NVVrTmNIZC9JMXpWNUlpVW5idXBHZG14VGdoYXRvVkFlUzdqNkg5ejdWMFYw?=
 =?utf-8?B?Yms5emN4Z1BQSm83WmhJdGlISy85UU5EengxME5CSlkveVpaVW10ZUdiKzMz?=
 =?utf-8?B?c3lDVytJWFVjeTF6WTZsd0JhcFRMbnNaOGROL3BsK0c3U2NEc3pHbmJESGxI?=
 =?utf-8?B?SGZ0UUNFSVpiaVBRNFJlV2lURW1xRFh5aks5YnM4Rm1HbmNjNWxSMG5LZDJH?=
 =?utf-8?B?K1JEM2E5cStBT2pUSGVkeFNHL2tOdFhoYXhSdnRoZFl2dVFVZS9tSmpuRWIx?=
 =?utf-8?B?Y3lIbU45cUtOek9rUFpiTmRXRjJoTGJjYW5sa04vcm5SN3FvMkd3WitCUWVa?=
 =?utf-8?B?aWlVajhlUTVPdjdpWHRCaS9ZeG8xY3ZKSEZJOU5GTG1DbG5VM0ZaUDk5WkJm?=
 =?utf-8?B?dTdZNFBZQnVsUGpBcmU0SFRib1pjRGlEWnV3U3JqYUU4TThGQUVZNnFxNlJz?=
 =?utf-8?B?ZFM4MW5ZZUoyNEp5WmRXeTJOSUlXcHBUclRXaXNYSmZ5YVJ1WTdsWU5jS2ta?=
 =?utf-8?B?R2ppcjF0WnZUQk1nNWlvVVFLcTBYZlliMU0vdGptaFVXbTBzejhpUEpUMFhh?=
 =?utf-8?B?NGpqays5ZHlVaGdRWFZNVi9CTHp1cEpmTEpvdTJpa1VDY3YyQm02R3NuQmtL?=
 =?utf-8?B?cTViRXhRQmQ3S29wMXhyR29mWXhINFBZYW8wNmtURmlxTGtYenRCbDFuemhv?=
 =?utf-8?B?UHA2bW9lY0lTNnhzT0c3eVE1dFovUTBBVERxMUtqL1Z2OW5jUmtRUUFXd0tp?=
 =?utf-8?B?SXpod0t3LzNxME1HVVpLbHlsK093YmJhNXl3b3J5S3VrZlE4Uk5xSSt1b3NU?=
 =?utf-8?B?THF3Ry9SZzBxbmpIK0xjeFM3SWJrL0RkcmZCb29pRVdTR0pCbkx3NXFCUmtz?=
 =?utf-8?B?TDFBVDl0UU40ZnFRRGY4SWVYWnlMTko5ZkZob0o1cFp2RHVBRTFpWHpjNjlx?=
 =?utf-8?B?WTh2b2tBNGF3S3F5M2I0OEdMNTBpQWpCRHlVdXZnSktWRHo0Z2NWZz09?=
X-Exchange-RoutingPolicyChecked: kdMgKHbL1uwpNs3slDY9wAC5RpaAXnhe3xQqC7i92c4+RaXmKPMghUnCWsAy+P3ygjgZ6zLUNbZY9wv9pf7f3ov72COYjJVY2DgbUM1HJC3fTZo0sZh53bJPqPLpuBd2/JsBIreN+kU03rfOYrZmQsOXSS01LCOeCdPInGdXWA4xGOG1baPF4h1s+svm9N9bFYo1YPqIs1KvzPI9QjlI7SSNltHnJLlUefst+c38im4Sfme3WqGmAbEcnr+TSLAi4MxtosFotef3FfTMI+G+93aq6DKNs5wJcl3VPzMQoC1/apxBfqEzhNE5/h7Je5hH5TsxOGqmkGmPdvVkMb1CcQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: baf21a8f-28f7-49f3-228f-08deb7dfe4b0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 08:55:38.0227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcTr1bfb24SqmrONftKtdkMhye+lU1oLXxr4DOXKj4mLMbJ92jqCJNxozIhFcx/Xs6uol4hdDuNoR3CxrKDIdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR11MB9617
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yi.l.liu@intel.com;
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

On 5/22/26 15:17, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v5 08/15] intel_iommu: Refactor PASID processing to use
>> IOMMU_NO_PASID internally
>>
>> On 5/20/26 19:00, Duan, Zhenzhong wrote:
>>>>>>> @@ -2121,10 +2112,6 @@ static bool
>>>>>> vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>>>>>>>
>>>>>>>          vtd_iommu_lock(s);
>>>>>>>
>>>>>>> -    if (pasid == PCI_NO_PASID && s->root_scalable) {
>>>>>>> -        pasid = IOMMU_NO_PASID;
>>>>>>> -    }
>>>>>>> -
>>>>>>>          /* Try to fetch pte from IOTLB */
>>>>>>>          iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
>>>>>>>          if (iotlb_entry) {
>>>>>>> @@ -2235,7 +2222,7 @@ static bool
>>>>>> vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>>>>>>>          if (ret_fr) {
>>>>>>>              if (!vtd_is_recoverable_fault(-ret_fr, iommu_idx)) {
>>>>>>>                  vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
>>>>>>> -                            addr, is_write, pasid != PCI_NO_PASID, pasid);
>>>>>>> +                            addr, is_write, s->root_scalable, pasid);
>>>>>>
>>>>>> a typo here? s->root_scalable should be "pasid != IOMMU_NO_PASID"?
>>>>>
>>>>> This is intentional.
>>>>> pasid = vtd_as->pasid = iommu_pasid, so it never equals PCI_NO_PASID now.
>>>>
>>>> not quite get. It can still possibly be IOMMU_NO_PASID, right? If not,
>>>> this looks to have introduced functional change, which should not be
>>>> expected by this patch.
>>>
>>> Before this patch, If pasid == PCI_NO_PASID && s->root_scalable is true, then we
>> pass is_pasid=true to vtd_report_fault().
>>> If we change to use "pasid != IOMMU_NO_PASID" in this patch, then we pass
>> is_pasid=false to vtd_report_fault() for the same scenario because pasid is
>> IOMMU_NO_PASID now.
>>>
>>> But using s->root_scalable could keep functions unchanged, right?
>>
>> got your point. But this helper should cover both translation w/ and w/o
>> pasid, it should not reply on the s->root_scalable, but rely on if pasid
>> is included. So the logic does not look correct.
>>
>> checked the original commit. It seems recording the rid_pasid in the
>> fault reporting wrongly. And that's why you got the current logic here.
>> May need a fix. Below is the original commit, and the spec definition.
>>
>> - commit: 1b2b12376c8a513a0c7b5e3b8ea702038d3d7db5
>>
>> - Spec says pasid is only valid when the fault request is request with
>>     PASID.
>>
>>    "
>>    When Set, indicates the faulted request has a PASID TLP Prefix. The
>>    value of the PASID field is reported in the PASID Value (PV) field.
>>    "
> 
> I see, you are right, will use "pasid != IOMMU_NO_PASID" in this patch,
> let me know if you want a separate fix patch instead.

go with a separate fix patch is better. :)


