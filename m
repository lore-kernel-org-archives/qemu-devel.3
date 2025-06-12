Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC32C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 12:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPhLu-0002C8-7k; Thu, 12 Jun 2025 08:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uPhLt-0002By-4L
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 08:48:17 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uPhLn-0001Sk-DM
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 08:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749732491; x=1781268491;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oTyR0pxXTTO9lgb54R2DKxPTIrDBNI1kz71HZGaaZIs=;
 b=eFlR0WAuZC3R3n/+YO+ovvFV/mGqETZ8x4yLQC7CE56OiiYZ85FV32rO
 1hH2iSbQRpgZu9xWdFnDghEEXcaC0tVxbaMvyKi74qK2H7A/NB6HUk369
 87DvcJU5KYrpiomLeV6JBBQlQsw0ABOvPsnWZRNqNk/e3S9f4Jy1aQhRr
 +alAvCTtC/bK3/5eaYTRvV2RRFU8GUPkCWZk19QBez5n8H6FMv/tFLZt+
 RIpAacUMaR4jWNeRcx6YBmu9MkF8s/r9ZO/8Y9fgOseuC8zqCarOCclK5
 zTuXWkHjyatYmL6ftTO52Xz2C8hJ3hbkqXDr1vUlXh4kSE+Jlr9lYv66b Q==;
X-CSE-ConnectionGUID: Bn+biyE1TKKE7V3aTn2KoA==
X-CSE-MsgGUID: KTLzGuomS4G5/wPaFlRfQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="62559970"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62559970"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 05:48:06 -0700
X-CSE-ConnectionGUID: PZDXUGmVSpWA3/ctuVDySg==
X-CSE-MsgGUID: gX7L1tqhRiKRhwzwv9ZLKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147415922"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 05:48:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 05:48:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 12 Jun 2025 05:48:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Jun 2025 05:48:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QiNiYN/s/64PloH8iqqMK1ZbtLkTCP2ek53iYxoPEhBfBZGrIsek4R2tevIuhzvIdHu2TR3TI6AxaEcByiSPZhSrhkJPEjOi2wxCEmOYpW1zk3mXXcu/8ujnBjd0noaO+lm2mQ87DBdHpxvW62Nu4TqMRoQqZWwy6PAg7zS1mGijttkWpAoaUXD9Xz3iz/MGCGwqPUPhreaRiXMx8qLIDCnBDDx51xfgy0gaCLyAL0TDx9aVAezACuugGnjEIp/6kLTOUMV6q/44UESF4TBOwhHLTLvXGYDAVDEbuSbadZLrr4+Qxn8lF9eJSAAHFtgWXNaOY6deFz8s3YL9jg4vjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tajO51v/pGYQo95bO3bktNm6VhSOjx/HZlSJygQ14uw=;
 b=eXABLF1b7rDC5yk8J6LN0OQzuLLbD9KB1kkdU0AbwMvjP4a8eFoOJ3askmT9gGepnRafAxj0xtA7cu4Ub9IplvdDb4GcJ4Cfu66vzX8657yy+WdOL36PPzP0kQ5IOTYFICLEbJTLbB91GT3lGcZizDEx4Z1pSMvbMhmhLVptuR2SwpdMjNWgGkqQAhEJx3Yix4Y+t9dZzNhbU2DOAqNqRIP7AMGJcpJFZwOHALRpBCckvwVSL5UUN2TCjJ6vNn2DchswnDrbCMIPwbjCt+FIqKkpliRj/cOOkYYK3fhAOsEtE4Lcqq7OScZB4uuO3xwnf3QAGLMRY/mFFH1xr/nprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CO1PR11MB4946.namprd11.prod.outlook.com (2603:10b6:303:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Thu, 12 Jun
 2025 12:47:35 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 12:47:35 +0000
Message-ID: <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
Date: Thu, 12 Jun 2025 20:53:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CO1PR11MB4946:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ad6650-874d-45f3-e71e-08dda9af4df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGxFSzNpZmJzazl2THFnMitQM3pkTlh5dXZVeWVmMmVvMjV5NE5PUUZJNWxD?=
 =?utf-8?B?T2t4M3g4aUM3elNVVTlwZkk0ejQxV0JONDNSK3BxbVFqbk9pRTVwTExLWFZX?=
 =?utf-8?B?cHpHaXMvM05tejQ2dDFkUEUrMWdKRm1hbllJQ2JKTDdibTFvUmU5S1k2ZHFZ?=
 =?utf-8?B?NklLVnhSVGp1bjYwdHhhSGZYV2l0enU5WWVEUWNKNmNKVDVmK09kM1NhWVpY?=
 =?utf-8?B?TUVGWU5LMEptc3VvbVYrNXpyR08xdEpSVFFCSzVxN2J0K3F3OUlDbmU1OHdw?=
 =?utf-8?B?a3Z6TndCUE9KZjlxTFB0WGVKRkhuYU9GdDhPZ2RsK0lIN3JlS3prRWlpQitZ?=
 =?utf-8?B?L3Q5WnQwbjNOYmFzVUdxSnZCYVBYYWdTSkROVE96VWVDYmNUWTFXOVVpMU05?=
 =?utf-8?B?ZXpyK2ZDR0trdWRwMzZsQmNHenpvTEZpZ3o3U0Y0NVU0VTFUYUJmdmE2N2pC?=
 =?utf-8?B?ZkVIWGp2NmYrWjBId1VwR1c1UU5vOEJna2laWXdSbEFPTHhDY0NlSXF5dVho?=
 =?utf-8?B?QThqOGtlelNndUlmdFdYRG1HY0NmZVR4cjZSWGxCNHVOWFVXb3pqSUgxRkxE?=
 =?utf-8?B?dlo2cFEzRjVQdEtHRDlsUnVhMWZwYjBXeW8vSldGTlp3WHE4dzgyZUNtY2pw?=
 =?utf-8?B?MFlUNnVBb3M2blUxVEc2anc0VElOcEdWalE5RU11S1JkNTNIcUNCRlFEOHZX?=
 =?utf-8?B?em84aGNwTENFR3BzdXFycXUveG9Sdk5kRGNsL1BFKzBuWldsWVpVenQ3Wnlz?=
 =?utf-8?B?Z25TNEEvT3d4UkNENHFoZThZM1ArSUJJcjcwMkxuWkRyck1VUC9nZkM2cTNI?=
 =?utf-8?B?U1NSY2t4Ry90YXNXRURadFpHbmdWR1Z3Z2UxMjJBK2U2dk9zSGVUcUZuQ1p0?=
 =?utf-8?B?R3NXN1pUc3FMZnp0bE5OREtvN20zcW8wd0JtWUJXRDJBV091N1MvOWs5Zncz?=
 =?utf-8?B?UUo1TVRUd0ZvZHVQTTlYTndibVhUS0hlV2Q5dDVTL3NBcHFXcStTMklRUGtw?=
 =?utf-8?B?WHhxSlQrQ05QemJYYmovLzJNUk5mTXFuMEdOWDZIK20rMXlqaXNpS3hGbERQ?=
 =?utf-8?B?aXA4UGJzeDgwSDlzam9UdnZ6a29Oa0JtdnF4dDlSSG1LZmI1ZGdRMHFSZlVp?=
 =?utf-8?B?UXJTRXdhU3p2T3BKTWpEKyswUWZWbXQzcjNhdDEySWhIbjdXRG82YW14VXJI?=
 =?utf-8?B?NWZXNGFUaTl2Y2ZwOGxaSnQ0YWpYdURTYVZ2UmJwb0ZMbHRIZWZOVHhWQ25o?=
 =?utf-8?B?WEhmNnl1bEJpdURCd2FaKzdvN2MxVzZYUndWclFISDVyTzRycjYza1hIbVhS?=
 =?utf-8?B?cThHdExwUmU5WTYwTzdCMmZaMEhsMmxuMTFreTVVdWhWa1MzZGI3L1p6RVFk?=
 =?utf-8?B?clMxQkF1SU1KZ1VKN2xtVE9DT2ZvMmQvWjArNGxUcU5mTFF6YlBpY1YrNGtq?=
 =?utf-8?B?alNXSmN2V2RNbHpjblRzUmE1Vm5lbkg0TEJFOS9CS3gyWDc3K284UnJpZmty?=
 =?utf-8?B?dDRoTk52NEVHSFR5bWh3RzRQb1hKcmtDQU84MjFJdDdhVHJzRXNKL05PV3dj?=
 =?utf-8?B?cFhXMGNHdXJZb3RUaWt3NzVCV2NOV25xOWZEbWxlc21ZRVhjZW1pZmZqVk15?=
 =?utf-8?B?NzlMckhUczFWVnVrWmdrZ1lZVHRwd0lhaVVSWnQyWDg5L1JMVDFqZnFidlVC?=
 =?utf-8?B?Y2JaWXVuWlhlSnpFbVlQeGpsWUkwTmFSYlBUVk13Ty9CcDNGZ0xVdWIzb0FQ?=
 =?utf-8?B?aFBNTzdmNXJGMGw4dEpTNkNpRWNydEZuRC9rRDJFYzNSLzF6Snh0LzVRbmdZ?=
 =?utf-8?Q?X863iB+1iHoJ7n89TqQAvRfZ2lsuusynjYfco=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3R5RTVyNmFFaVNtblF0QjBOUEtXdGtTRk9HYUJTVCtUTkxJR2ZUUURtNmc3?=
 =?utf-8?B?eEtWU2JtQVo2dnExWDl6TGtwdlBWTlRNWnQ5WWE4c1pkdXJuN2VVRmswMXBr?=
 =?utf-8?B?V0NNK2JWUk5nRG5rK1FhYmZhcHJ6U2QwdnNRSjB1S2dselZrd2tpSTFid3Y3?=
 =?utf-8?B?Y1lFVkJoa21TUkc5L3ovZVlHT1NSZU9YWHMvSGFVdWwzOFJRd3JoRlNuNVRZ?=
 =?utf-8?B?cE83bEMrTXQzTEVaVWtZVjAxZnNkaXBaU0JXWVR5VWNJWWd6NDQySVJWV1VW?=
 =?utf-8?B?Y2hiVEZKV3FBcjdKYzdwZTM1Yko2MWl4cEZnajhSSzVscytRSkRqNUN0c29x?=
 =?utf-8?B?V1NHeU1SdDkrZTFVYmFxdlQ3WkRJZTU4ZEl0VmZ0WGNYK0dNaERhdWNHY1pC?=
 =?utf-8?B?c3NRVzRhQXhabDhlWW1yc1h6RkRQa3BSVzVMZEV1SDcvd29ub21YY01YYnNH?=
 =?utf-8?B?c3g1blNHQXpTRlRTMXRHbkFscXFvNFBJM2tYOUtvWnZPM1BxY3hOUFpFNUtk?=
 =?utf-8?B?ZklURmFWZGVod21QRGtJZzJYSzdWc2l2dVJXTHFpb2hJMDVIWDRRV3VDNUJy?=
 =?utf-8?B?eXJRVmJDY0J2UFZBZVVNbkRvenFTd2Zka2VjSVcvdldrbytHUVVmZEM2OElE?=
 =?utf-8?B?MU8rQVFsMzdVejE0YlpMRGZya3VIMWtmM1lpSENkNkdMVHBvSTdlMFlEN2pl?=
 =?utf-8?B?MjcwREFpeS9RVEdCbVMrbEg0YnZkV3E5dWY1ZUNDYjZrVDVON2RKMFBEZ2FB?=
 =?utf-8?B?cGJ3VVZVSWU3eEF6WmVKcENQVEdCZlNxTTBRRVd4RkgzWjlVSUpFTVRBT2dh?=
 =?utf-8?B?clZ3MVlxVng1QS9OWDZIbG04OXB2NzF1c2NlLzh6Zm1lMHR3Um1HcjdEeXBL?=
 =?utf-8?B?T0xmOXZIaGFCU0Y4OTgyWmtBK3VsbUI4Z1JaU3g0dytTMG02R294WnBHWUhT?=
 =?utf-8?B?b2tjRHJGVlVXR2p2c2xKNktQZzMwUkVFN29zOTFZMFNLcHhDUlZNWW1uZDVP?=
 =?utf-8?B?TlJMMDd4ZFN3Sk9sMFk0ZWU2MnRoVE51N1JjR1JoVW8vMThCTFUybHZPdXlD?=
 =?utf-8?B?UVB4ZmhRTWpHelV3M2dKWXBSMU4xa2t2Zi9mQkxSSjEyN2txM3RMeXJUdS9I?=
 =?utf-8?B?UG93ak9OQkVCMjNXZG56ZzI0MGYrVGZYSnE3bHBIUlFSQWg3bEpOdUhTSjBY?=
 =?utf-8?B?Z2Z1cXpZUXFaWVJqM041TWVXU2V0MWpPTkNaaCt2eGRkYWpMeEZXb2tLRXJE?=
 =?utf-8?B?ZTU1SlIvdEVKbXRtdDN2cFhJV3pOaGFGVHRDWHlMSnVoUjR4TjhxSENjZ01S?=
 =?utf-8?B?YXRyNERtdWZRMkJac050K2lEcVZrdzV2UHRLM2JHd3ZHTDJmaERjVXFsUzR3?=
 =?utf-8?B?aW1VSjdNMjNHVko2MkxqYmdwNDNKNWNEUEVhQllTMFlLdmhWclVzTEh3dmJ5?=
 =?utf-8?B?aTJnSkxXTURyWlgxMlFZWnVUMFU3TUFvZ2V5bEhNWk96bkhYR1ZCYS9KTUJy?=
 =?utf-8?B?cUlQUjhFWkp0akYzZHU4bnc4eVdzalBWajZiRDZYSFFmTnBLZVg5Zk9pMk5H?=
 =?utf-8?B?R3FBY1pzRWdySE4yZlcvTG1MT0tGbWVYUURZS2Z6VXh3MHJLZFZwcExMbi9N?=
 =?utf-8?B?SkF5QkhHSUVvK3pjQTBGSFE4RHdYVWpJaUtWb2h4aTltWlBtOUFoVEcvdGlm?=
 =?utf-8?B?Kzc2dDdHSFRwd3diWWNFWDdtcUl5NlJVVStwZ2R3NGd6NXhvN0lIOG83YjNq?=
 =?utf-8?B?VWMyY2ZxQWdudWNhTWkvclcyZWRpT1B1bFArT2hoMGhUazRucnFVMXNwVmhr?=
 =?utf-8?B?elNaZGU3dDd5YzR0Y0xTYWxLMEh6dFlPelJaN0d6RlBNaTNWckRhZ0JaSlAv?=
 =?utf-8?B?VER3WG5XUjZRdzJzcysyd0c4OFJ2dTNIVUdkTlRCaVFieFpGYWtHb3ZjR2p5?=
 =?utf-8?B?UUZIRnU5citBK2J6TER2NlhDVWFrSTMrRENIaTY0cHF2SkNsdUdWOUJyWEd2?=
 =?utf-8?B?TlN3cVROWWRVbXlXUVJmbERrYU8zREdHcDVkSS9BZ3BiM1pzNGFBWUhQSUlV?=
 =?utf-8?B?YW83Z245SGF2dmpYNWt4YTV2MXh3U2VUdnZ0cGdkZ2RacmEyOVVWMnNELzZv?=
 =?utf-8?Q?RpRFWbVIDIlgbKGN/ZCelU3jT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ad6650-874d-45f3-e71e-08dda9af4df8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 12:47:35.2368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXNEzrw6JqcaF8vOr2BfNQMTBJrWaqTl9bf00dHfUC9GaTpJ2r3t59YbHzJGrwaTBn9Q5sLNDhcEzw5WD2vRNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4946
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9; envelope-from=yi.l.liu@intel.com;
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

On 2025/5/28 15:12, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
>> host
>>
>> OK. Let me clarify this at the top as I see the gap here now:
>>
>> First, the vSMMU model is based on Zhenzhong's older series that
>> keeps an ioas_id in the HostIOMMUDeviceIOMMUFD structure, which
>> now it only keeps an hwpt_id in this RFCv3 series. This ioas_id
>> is allocated when a passthrough cdev attaches to a VFIO container.
>>
>> Second, the vSMMU model reuses the default IOAS via that ioas_id.
>> Since the VFIO container doesn't allocate a nesting parent S2 HWPT
>> (maybe it could?), so the vSMMU allocates another S2 HWPT in the
>> vIOMMU code.
>>
>> Third, the vSMMU model, for invalidation efficiency and HW Queue
>> support, isolates all emulated devices out of the nesting-enabled
>> vSMMU instance, suggested by Jason. So, only passthrough devices
>> would use the nesting-enabled vSMMU instance, meaning there is no
>> need of IOMMU_NOTIFIER_IOTLB_EVENTS:
> 
> I see, then you need to check if there is emulated device under nesting-enabled vSMMU and fail if there is.
> 
>> - MAP is not needed as there is no shadow page table. QEMU only
>>    traps the page table pointer and forwards it to host kernel.
>> - UNMAP is not needed as QEMU only traps invalidation requests
>>    and forwards them to host kernel.
>>
>> (let's forget about the "address space switch" for MSI for now.)
>>
>> So, in the vSMMU model, there is actually no need for the iommu
>> AS. And there is only one IOAS in the VM instance allocated by the
>> VFIO container. And this IOAS manages the GPA->PA mappings. So,
>> get_address_space() returns the system AS for passthrough devices.
>>
>> On the other hand, the VT-d model is a bit different. It's a giant
>> vIOMMU for all devices (either passthrough or emualted). For all
>> emulated devices, it needs IOMMU_NOTIFIER_IOTLB_EVENTS, i.e. the
>> iommu address space returned via get_address_space().
>>
>> That being said, IOMMU_NOTIFIER_IOTLB_EVENTS should not be needed
>> for passthrough devices, right?
> 
> No, even if x-flts=on is configured in QEMU cmdline, that only mean virtual vtd
> supports stage-1 translation, guest still can choose to run in legacy mode(stage2),
> e.g., with kernel cmdline intel_iommu=on,sm_off
> 
> So before guest run, we don't know which kind of page table either stage1 or stage2
> for this VFIO device by guest. So we have to use iommu AS to catch stage2's MAP event
> if guest choose stage2.

@Zheznzhong, if guest decides to use legacy mode then vIOMMU should switch
the MRs of the device's AS, hence the IOAS created by VFIO container would
be switched to using the IOMMU_NOTIFIER_IOTLB_EVENTS since the MR is
switched to IOMMU MR. So it should be able to support shadowing the guest
IO page table. Hence, this should not be a problem.

@Nicolin, I think your major point is making the VFIO container IOAS as a
GPA IOAS (always return system AS in get_address_space op) and reusing it
when setting nested translation. Is it? I think it should work if:
1) we can let the vfio memory listener filter out the RO pages per vIOMMU's
    request. But I don't want the get_address_space op always return system
    AS as the reason mentioned by Zhenzhong above.
2) we can disallow emulated/passthru devices behind the same pcie-pci
    bridge[1]. For emulated devices, AS should switch to iommu MR, while for
    passthru devices, it needs the AS stick with the system MR hence be able
    to keep the VFIO container IOAS as a GPA IOAS. To support this, let AS
    switch to iommu MR and have a separate GPA IOAS is needed. This separate
    GPA IOAS can be shared by all the passthru devices.

[1] 
https://lore.kernel.org/all/SJ0PR11MB6744E2BA00BBE677B2B49BE99265A@SJ0PR11MB6744.namprd11.prod.outlook.com/#t

So basically, we are ok with your idea. But we should decide if it is 
necessary to support the topology in 2). I think this is a general
question. TBH. I don't have much information to judge if it is valuable.
Perhaps, let's hear from more people.

>>
>> IIUIC, in the VT-d model, a passthrough device also gets attached
>> to the VFIO container via iommufd_cdev_attach, allocating an IOAS.
>> But it returns the iommu address space, treating them like those
>> emulated devices, although the underlying MR of the returned IOMMU
>> AS is backed by a nodmar MR (that is essentially a system AS).
>>
>> This seems to completely ignore the default IOAS owned by the VFIO
>> container, because it needs to bypass those RO mappings(?)
>>
>> Then for passthrough devices, the VT-d model allocates an internal
>> IOAS that further requires an internal S2 listener, which seems an
>> large duplication of what the VFIO container already does..
>>
>> So, here are things that I want us to conclude:
>> 1) Since the VFIO container already has an IOAS for a passthrough
>>     device, and IOMMU_NOTIFIER_IOTLB_EVENTS isn't seemingly needed,
>>     why not setup this default IOAS to manage gPA=>PA mappings by
>>     returning the system AS via get_address_space() for passthrough
>>     devices?
>>
>>     I got that the VT-d model might have some concern against this,
>>     as the default listener would map those RO regions. Yet, maybe
>>     the right approach is to figure out a way to bypass RO regions
>>     in the core v.s. duplicating another ioas_alloc()/map() and S2
>>     listener?
>>
>> 2) If (1) makes sense, I think we can further simplify the routine
>>     by allocating a nesting parent HWPT in iommufd_cdev_attach(),
>>     as long as the attaching device is identified as "passthrough"
>>     and there is "iommufd" in its "-device" string?
>>
>>     After all, IOMMU_HWPT_ALLOC_NEST_PARENT is a common flag.
>>
>> On Mon, May 26, 2025 at 03:24:50PM +0800, Yi Liu wrote:
>>> vfio_listener_region_add, section->mr->name: pc.bios, iova: fffc0000, size:
>>> 40000, vaddr: 7fb314200000, RO
>>> vfio_listener_region_add, section->mr->name: pc.rom, iova: c0000, size:
>>> 20000, vaddr: 7fb206c00000, RO
>> ..
>>> vfio_listener_region_add, section->mr->name: pc.ram, iova: ce000, size:
>>> 1a000, vaddr: 7fb207ece000, RO
>>
>> OK. They look like memory carveouts for FWs. "iova" is gPA right?
>>
>> And they can be in the range of a guest RAM..
>>
>> Mind elaborating why they shouldn't be mapped onto nesting parent
>> S2?

@Nicolin, It's due to ERRATA_772415.

>>> IMHO. At least for vfio devices, I can see only one get_address_space()
>>> call. So even there are two ASs, how should the vfio be notified when the
>>> AS changed? Since vIOMMU is the source of map/umap requests, it looks fine
>>> to always return iommu AS and handle the AS switch by switching the enabled
>>> subregions according to the guest vIOMMU translation types.
>>
>> No, VFIO doesn't get notified when the AS changes.
>>
>> The vSMMU model wants VFIO to stay in the system AS since the VFIO
>> container manages the S2 mappings for guest PA.
>>
>> The "switch" in vSMMU model is only needed by KVM for MSI doorbell
>> translation. By thinking it carefully, maybe it shouldn't switch AS
>> because VFIO might be confused if it somehow does get_address_space
>> again in the future..

@Nicolin, not quite get the detailed logic for the MSI stuff on SMMU. But I
agree with the last sentence. get_address_space should return a consistent
AS.

-- 
Regards,
Yi Liu

