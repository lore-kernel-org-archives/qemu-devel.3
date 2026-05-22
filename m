Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C043CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIAt-0000ZF-QO; Fri, 22 May 2026 01:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQIAq-0000Z2-Ma
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:11:52 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQIAo-00069a-Ed
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779426710; x=1810962710;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RfzRz6luDxDPcSA/1tv+G5hqrx1tz6nm1kD1DeMVXn4=;
 b=Ie6cL2daO4pplz97ubWOWE9dHvgl4Xd3jo4wVQfEoJkDsdNVrXdcRdYd
 WqEXUREpElUrM8GL5Bj3zmajeDUGSgz2ppBxKj8WTi2+6TO4gWVvQusZ7
 Xe2RkvCvXnBv8twhIpJOYOakrjlvzO0XUp/DhY64bLaZb++dUA4Ug9rvs
 ri4fMpoySFVXN25idWhNNyKIMQN6b+UVsqEL1uxqGvoGi92dTRdEAauiR
 RWHwmPFQYUBIsA2uBBQyp+Wkq6OovBR7iS772zwDvZdqoPxEKntohX7Fi
 BTVP7kMWIxc6TNVm/NItuYOa61FKXQM2Byakvw/+IZYU9CXS3/iW0DtPV w==;
X-CSE-ConnectionGUID: n3/JQ3/fR7iEyfLZ4AR0EA==
X-CSE-MsgGUID: BOM23w+GQau9NQW9b73X/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="105818518"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="105818518"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 22:11:47 -0700
X-CSE-ConnectionGUID: dsZCcIBSRD6exJVeJHP/yQ==
X-CSE-MsgGUID: 7ulfWzPpR1+fXDUKYmhiBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="271149469"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 22:11:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 22:11:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 22:11:45 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 22:11:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoNfxwtBJqfzb+mlci/fF0ayUypnHz8ifoE8vdC8ogXMmzWgq09ss7yjjsda0MJtyqss+WaLBQ74Q0FlsN9hIKEli1HTxj1LrikXXRY7r5pG+ipU2c/btxt+bXVdeBPr5MaRvstX8bCECIlgTj6mEF9WyUCBl/9iFiIvVNlJaGiDhF2BZr+Dzpb9LwrtPksZK9fMUNDXMUcfDtqzRqCgfJc9LWvYY/BVWECCQ156lUV5kR3QpgLdn59UGb/9kWrsBZhjoWnOFekYZzNWORw5011YEtuqwr+B2MwWYQCEoE9/0w90atJk6OcaBDmexi5NBZoL58Xm72A/QXmpgUtU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCjBLVrtitjjIJaMUjfYL3/r35QNx2Cbf+SL6WaW5Wg=;
 b=W9nsLZLq9KiZbL7GaWj8PFEqjabY0JaqeynxVXNN7WfGVyjFMqcNTG0OS5XNhCUFUgVE8yOYnUup8KRuSNoCPyoHftsffdNp9twhHizh2TzNt5K4Z36Vm2145EcBz4ORiyaUDDguahfB3l2/jXndJHnwB5scetb3OnQRkoFYr7ovahP40Z1mQc6BVhoyBdUDUDfo/Ub/aNPYnscCxp/6itoq3yT+sluB+xJ+562Byde25e8x24xqy9W7ukTO8DrAsE5onRkOCIVBPrJvaEoRslJMq64kuPH46adKNazzzJJegYs0UBR36QsGE1ZuXEyqo1j3MfCwV8+htq16A5iVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by IA0PR11MB7792.namprd11.prod.outlook.com (2603:10b6:208:409::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 05:11:42 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 05:11:42 +0000
Message-ID: <c7f4ef02-a25f-4dc1-895a-4c3686ab6b4d@intel.com>
Date: Fri, 22 May 2026 13:19:50 +0800
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
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB91365BAAAC96F5E996416BC592012@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0037.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::16) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|IA0PR11MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 523c6005-dcec-4295-a5be-08deb7c09cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: 4ZxyiGLx69lc2UdWJ0PK87bFyInmEtBOLMsH00szeYMS99mcRbFlY02zz5Qy8OkSysMLZnMMcLf3DHfWNefmmKZ423yNf6SSeixKij29h84lpWc/qcX3/Em13n9yPDNNXoAsLgO3zJfQ5oheHM5gI6kg3nDLodlEkCJU/3DVqxlQOY/W3kW5mQGFr/1EF7iZD6CX/VrT+KOa8zE2RhU8NY3izIu2GrhCrqjLvUohmtPpC33reN4hNt6WEldnFi+RIACiyBMRaDfzFXmSqo9FxtsxbbJdCUjUStYONZV+ZDD5fhwECVOSNmZox4v01s1GPSDe4Yf+S6g4DW7g8LoPSFRRuw31yF3oPhWXnqe7vZZlzxiAJwQ4YdZjUIj5QMNwAoU4dB2iN5BCNy1pEJaeU+vigHmIWjswGbJW96dVoP+Xj9LAdNQcxIP8Gte7D/PG6Okp39+4IrKYhWwNESmnE59b339ARbDy9dia6S9c+OraVKRy+0AgdKTnvutztleZ3/RYpbg+gTo/4n8zqORQ3gPzqCJvxqCBvWYbz3QeRc8rW8GurjZnqaStpnVnxzijwkVhzRAQN2IqGQDtcFpyUBwl3Cebfa4AkXIl9SbowtuO1L7cM2ikpX9K71sekzoANHQ+90+o16R33zs7SNwuyrMRyjkORLFFJdf/oUusGuq6vdDQAM74bkpjSY+sZ49/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVVkenJvRHc0NXFlaFhsbEpBd3UyS0lULzRaOWxXNlZTSkZLbEpwSUxIVjd2?=
 =?utf-8?B?a2liUllPdnN0alpxbmJaenB5M2thNWpHMmk5SWllMEx4Y1U5Ty9oOG5XZC9K?=
 =?utf-8?B?eExjVHIrVVJuT1B6K0NOUjBkVGhPK0Qya01tNDVFaWd3ZXRhMjl0Zm1YVllX?=
 =?utf-8?B?M1lyemJKZDFFakhMcVMwK01kbDVFc1ZzL1E0NUdNbEozR3hvSXZhU2U0VTFu?=
 =?utf-8?B?NTVJUjJKRDlvTGlkemg2VCtHZ1EzZE5XOS9jUUt0ZFBIaGVRR1VQRDNKaFZF?=
 =?utf-8?B?K25rSWJuT3hGbEZNV0tubVRzdmFTRHc4TTJaLzRXd0YyczQvZ2pKZEtUckxt?=
 =?utf-8?B?czZySVl6ZnlJMUk5bmJMTkl4WHE3Qkp6ZXpnUEFhRmRHM1Nwd0czSUE1b3lZ?=
 =?utf-8?B?Tk1mVWoxSnl3K0ZCdUliUllpV2RZeUNYSUVITG83QkdmcjZ6ZkFvT2IzejBE?=
 =?utf-8?B?eUJucU5kdmtZL21ScWVlK01BQk4rNnhqVkgxN1ZrMVdBV1VuUk9QMXZ6WHZp?=
 =?utf-8?B?R0ViSHpjb0dsMGd2U0FwUVM4dUhzNG1jcVFkRFExbjRqdnlLam5iZ0NaZWNH?=
 =?utf-8?B?alh6blNzWCtVR2JCNWh6WEhJaWJpUTIvT0QxWVhUY1FzbkxZa1JRZElWWExQ?=
 =?utf-8?B?UDl5dmZvTUU1SzVlekIxMU1sWCtvY3RnaVJyK1AvVFNnMmd0VWx1MXVIR2s3?=
 =?utf-8?B?eTdZSHdnSkhiaVJCelZsS2lmRXRvZ3YrWm9TNmdJUlEwcVlkL0dqakZqRWMr?=
 =?utf-8?B?ek5VR0ZKaVVkd25YbVI4Q3NPYlh4ZUd3bGh5Y0ljWjRiM3lTR0hVRFpTK2x1?=
 =?utf-8?B?Vk9YYi94MUVlUjRzTk1HZEFNZmMxREhzTlg5K055TDFuRW5GcTdYL3MyMmhp?=
 =?utf-8?B?QmF1VFhvVnZiZjB0R1dSNlhOeHhCMnFjM0RMVy82TGhoeEJpcjVsMGY1T2RO?=
 =?utf-8?B?MTNHSE43aTFVZXNaZmJtZzNRT3U5aWRyWGxvbVFVOWplT0h0ZEpaSDNtL21r?=
 =?utf-8?B?NlpwL0p3SFVaSk1aY0Q2R1g0UWYvQzdweS83d3EyN3R4Rlh6UFdkSW0wcHo0?=
 =?utf-8?B?N3daTEZpcHdHYnh3WEN6bVFPNEI5WDdwK0t1U1BDWlRHRVg5TnpOZVNYNDNE?=
 =?utf-8?B?VkovOGJWeW13OGxtNm1FK3FMaWE2cFhTenJtVkd3V2NTbUlWdWFjNVBVRmJi?=
 =?utf-8?B?WlZTOXZ4c0tuS0hwYXVrbkxrY3JxM0kxV2MzSG9PbG5XcFY4MmhWckt1cWp5?=
 =?utf-8?B?ejFmUm5WOE5nWk9nbFd4Vy9xNDZEUHdyMWNsWDRyRVpyK2xRYmVYODNhVmMy?=
 =?utf-8?B?SmxTMytPVmdqM1FRME45UnBJWUdvL1VIVGVBTk9FVWJ1QzZzZnZtNS9vUG5h?=
 =?utf-8?B?Y1JTSGxybHU1bWxtazhZWEVPeFBtQnc1QkdURnowaGpOUDNqTHc5aGpLd3E3?=
 =?utf-8?B?TEdjQStHQURYVU1WVWlMUXp6NVRLL0FDb0prbnpDUmd6MElEem8xK1BqdHJw?=
 =?utf-8?B?U1JncVhwaGJrZTVlN2Fhb1RyMkxPTldmSjRDRE5JdFVWUWdyaG5HMzRxbmNw?=
 =?utf-8?B?Zk8xelcwd2Q1N0d1a21GK01PU3FmRWtjQ1ZzRXd2K2MySE5WazI0dStyV1R4?=
 =?utf-8?B?bW14cHZHU1JsTTRIZ2tiWjBSVG42VHRwdjUxbUxTYnpnK2RnbEg5dG8zRDhZ?=
 =?utf-8?B?MkRsT2daV3ZacU4yVmlic3AvU3FoTldtdVlUaERURmpoMzhaWnN5K3FtZm50?=
 =?utf-8?B?aWNmM0xYbkFpTEZKcUc0dzNWWDNoOXJtTFFXbmNzK1NIZzJiNTVCNlB4Z1Nz?=
 =?utf-8?B?SGdFVklJWUs3OHlPOTlCQzE4K2I2MHFqRjI4NVZqMkNLbWxrMkJxVmtvNWNu?=
 =?utf-8?B?bnF2WTdBOVIxTzA0YlFRK1JxOGN5VEw2ZzlHSHhNUVFhU2RVNHREbjk2d0Mv?=
 =?utf-8?B?RVk3QXpwWTVjSjNkakRiQURic0tFUEo0ME16enBPL294SkJPSENTaFVQNmhG?=
 =?utf-8?B?RGQwOXQwTXcyNnBVcjZjUTEwcTVndWdMMFozTDRNMHdJaFpkSjFaM0dyT2lU?=
 =?utf-8?B?S1BWSmYrMUszSnk5MnhZNjRWNys3M292UzB6bDJ6UkJPTkY5bTBaK0pjck1V?=
 =?utf-8?B?cGFyUGlNSitLU0tJcUZSRHQxdGJJT3l5bEpqWUVBVTRxWTdiYk94cGNhV3pC?=
 =?utf-8?B?UjhOUXJ2RDcxamVWUHNmaUI3WFdYa3BacEkxR2hoc1JMU2dPVjNHT1JUb1RN?=
 =?utf-8?B?djRQYUhxT0V4YnUvY0d2UXB6NUhtWHpXMHlqaWE2cGtOYllHTE5DSlpFYkdW?=
 =?utf-8?B?ck1aSGFTMDh5Qit2eVVPVE1tZmJZZVlzb05xTVN3NEVuMDNUTG9Gdz09?=
X-Exchange-RoutingPolicyChecked: HUhQKTR/nY+z/6VtEqxms4haJ7NAr5PnNDgHeBFMybOLYKck1l9EtNK9z2MTLu2lQj4dAqd+R4ACufXzGcP5XucE7kJ48VXqcPNWPBtfeQMpMNtQX2DRUGEL+yyLU6rXvYIthwmCZ63BFxm6ihskA9tPf6iFmptzueycYrezynD0UWzxOZNvHBlpHcVu/YfSAkjPneKvBGIh5+ssw2s4/PKKUZxoT1vsJEWfmx5obyRGFiwXENH9fTs9ork4g83KmCB1GuGnS5GXya9Okjbm5v50M4QTmwpDvK7a4KcKT+h7/T0kXbnAbiCuNbelmtLbJMgaerBQr2hrW6FMy5RPDw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 523c6005-dcec-4295-a5be-08deb7c09cbf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 05:11:42.6341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fa47ffFqxllPjtK8Xzezo9HGmiO/MKK8x4tI5CxrhkYCwQbVPImsqP0n3VB4I2f3odd739K6w9gvK/3qhVpTUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7792
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yi.l.liu@intel.com;
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

On 5/20/26 19:00, Duan, Zhenzhong wrote:
>>>>> @@ -2121,10 +2112,6 @@ static bool
>>>> vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>>>>>
>>>>>         vtd_iommu_lock(s);
>>>>>
>>>>> -    if (pasid == PCI_NO_PASID && s->root_scalable) {
>>>>> -        pasid = IOMMU_NO_PASID;
>>>>> -    }
>>>>> -
>>>>>         /* Try to fetch pte from IOTLB */
>>>>>         iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
>>>>>         if (iotlb_entry) {
>>>>> @@ -2235,7 +2222,7 @@ static bool
>>>> vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>>>>>         if (ret_fr) {
>>>>>             if (!vtd_is_recoverable_fault(-ret_fr, iommu_idx)) {
>>>>>                 vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
>>>>> -                            addr, is_write, pasid != PCI_NO_PASID, pasid);
>>>>> +                            addr, is_write, s->root_scalable, pasid);
>>>>
>>>> a typo here? s->root_scalable should be "pasid != IOMMU_NO_PASID"?
>>>
>>> This is intentional.
>>> pasid = vtd_as->pasid = iommu_pasid, so it never equals PCI_NO_PASID now.
>>
>> not quite get. It can still possibly be IOMMU_NO_PASID, right? If not,
>> this looks to have introduced functional change, which should not be
>> expected by this patch.
> 
> Before this patch, If pasid == PCI_NO_PASID && s->root_scalable is true, then we pass is_pasid=true to vtd_report_fault().
> If we change to use "pasid != IOMMU_NO_PASID" in this patch, then we pass is_pasid=false to vtd_report_fault() for the same scenario because pasid is IOMMU_NO_PASID now.
> 
> But using s->root_scalable could keep functions unchanged, right?

got your point. But this helper should cover both translation w/ and w/o
pasid, it should not reply on the s->root_scalable, but rely on if pasid
is included. So the logic does not look correct.

checked the original commit. It seems recording the rid_pasid in the
fault reporting wrongly. And that's why you got the current logic here.
May need a fix. Below is the original commit, and the spec definition.

- commit: 1b2b12376c8a513a0c7b5e3b8ea702038d3d7db5

- Spec says pasid is only valid when the fault request is request with
    PASID.

   "
   When Set, indicates the faulted request has a PASID TLP Prefix. The
   value of the PASID field is reported in the PASID Value (PV) field.
   "

