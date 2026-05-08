Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07162CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHUI-000526-2f; Fri, 08 May 2026 05:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wLHU8-00050J-F7
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:27:04 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wLHU5-0000K7-Py
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778232422; x=1809768422;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UGi2VyXbxAu74usikJF5bzUUfN5UPzRdQFitw7Pmk4o=;
 b=lcLi18yrT2hW1Qqdgpsd+jOKvBcJf0zWnGD78Nf4auP6SOF++Qhpjb9x
 wsTrc1DSjNt4m6PW9Q0li7dpgkcEIQqxoY/HlnZOdXpSn0KdkZEZw0SJm
 kCifH5rG/Vebtln/2GuuDJe/5ksMpbw7Cvd6B99BfmBy7t39YdwfTtiS9
 wficzhc+4xTHxD3xZgkxFdEy3Ry5MzQTazo9frV0a73jpiayC8RS53ONX
 dYqyBdWblRYy9UgQssgvEikChNMj9sQUcXFAUJbpp60COxXdRfTKn7tOE
 hThbdaM/xx5bk6ngDhagXuEcvl5OUsAk20qVvD2pV/duuCVX9sYCbAN0n A==;
X-CSE-ConnectionGUID: zsdbT9WWT7GzkVG1akDjxQ==
X-CSE-MsgGUID: ZiELJiQ1RXiAzsaH/wFsmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="89506015"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="89506015"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:26:58 -0700
X-CSE-ConnectionGUID: kE4q/kwOSjGH8gfFWy/JVg==
X-CSE-MsgGUID: uhYcnrSgQYWhx3bLZeXSvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="230324468"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:26:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:26:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 02:26:56 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:26:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/hGjQfySuKhKcGi0Itghx8D82Vk6Py9EXzrpsg1D67EKMPUf7YDOuesuYr7R2MUoluO5KbNS/F4WZ7z5eSKl6RZ+TGByRoVrHyrfDRwgpfFciu7DHVsi1EbiM1umbsQzclrXTVb8AqYpHO+MVdtE2bXJeM/0FfhTsDfgyofD3C8T/OFS/WMqe1CsXS9XrcsZvaSS0wUZITWI6Gc75Da5X7KisfQw4WW7QC2lZWNusiK2NjC5ISH+jgUnsjytdDa5LrLZo/+7ot5vfEXo3do7lyQyby2NMqTfBDM7IRwkgGtcM/ssq0XipGGpHQ6rBvAesaSeMlMZFvW5dWNOednLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y6mxl+Hs4gJ/BOdf4nhWrQXTnAXgCBYeOeOSvW4IJ8=;
 b=mHZoluk/P5qr05OspT46rdGXVHHvT63pPd4OcoojCBha6dohaE/vFWM3umnfzRO6bsb+8iuqPr1E4fi0ybN7Cdlx1bjrpfIQp0f5uNjUZEgb0ROl9Df4a+TY5bA2FLpLMeRkUgzpPn0Q6IzLO5+N5CztjCR/EHJLCUFcL6XNsv22VdaJALQ/oV2uuI3ajlz7WXHqrcmoY+bw02Oxiaa/aK5IOUVRoijoOHi5WMPrjXHoA0v/VX0J3Uq+eCC4rMTPclol5tRMTjSERRhB5PM6iZv5sMHi6Unfe0TTRGeHEqx//l+nLW8kTspqDM3MLoMJZkM1l1PYjONya1LUPdU3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by PH7PR11MB6700.namprd11.prod.outlook.com (2603:10b6:510:1ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 09:26:54 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%4]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 09:26:54 +0000
Message-ID: <b53f4500-5ebd-45d8-a554-8fe22a060544@intel.com>
Date: Fri, 8 May 2026 17:34:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/15] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@bull.com>, <kevin.tian@intel.com>,
 <xudong.hao@intel.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260430071315.354333-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::17) To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|PH7PR11MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 1afd5b50-d6b9-42a2-ea40-08deace3f16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|42112799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JqLt6qqsmG+5B8oWVhY71D+Ul0CV4o50+U+yxVmR70YVpUTqVaTVc51C6qT4aV/qGArkC4ZisKtQiswrZf972bjfaZ1hcr3gi6+lvA9/01pNTqRkioCTnixu2ZYdiCW/vIH5/UMykZvSCDpymxcV7092QzB0+dJ7+la7U6MKJv61ZZmRiFFJwIBN4/2ycUzZw9pTZH3iceDuOMOV7GXpP2UJRsw3GkpgC0DSpMBQ8xVvGy4sQ4CSmegrr7czY9QLfOsfd+MhIPKB3nY0ez7vFnK5/XelCLZIXU8+8eiQjebhwYPJA8qGxxd+CDmV3ja7fdm5EvhabYwvkE9P8UWxXH4RoKWuv0vpnStSzVAwNln07bfAPCu4v4PGZzRIpr5lGDxFM7wolUNAukK68JATasyvPx5dMZx83aOL5kl7R3Z450ILKn80dSuRLTr//lvECg2zmdZtUb2OlmWAOi1+HGD2EzpUqyxCEFBvAkfRozRV4Kxqr7AqDHaxsmP96In0tjbSbIVhPDySBjdARpizwI9ZTRziN6jw7Z1ZzgJ8ipR/v3vxQs1owdZRem4jW5UFZLhvBfIGHrhHLAOprxs4hezg6SsiuAutCPL8EtHPNVk9VTH4wmLSaCcs4RxaRJXDNmPIj3LQ6Q5oqQ/A9uOb1aAaeIOTr6h2d4gdj8TbDkmUma6a18+iEOu4U4g0p1DU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(42112799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjR3UEVPZnp5SlN3Z1hEWEdKV2JqOUszdllRWlk2WURiTFVTU0hwSFBVM2xs?=
 =?utf-8?B?cHhPQ2ZJajg4Sllic0JKTVRTaWg4WFFDTWJYRFNsY3MvNTlDOHpyOG1BelVX?=
 =?utf-8?B?clJZZE9hNG15aTE4ZFg5Yi9DYmY0NzJiTG42ZURLT0JCQndoZWo2c1ZtTmFO?=
 =?utf-8?B?c1BUQ0NGeFoxbm0yWU5WUWU5SXZpdmQwRW5pWDlKNllaMUFHV3cyaUdsTWVG?=
 =?utf-8?B?cGpEdTFZRUY4cGJOUTRnWFJoaWltL3BwTStaZVVSM0p1akhCMDhnYkZuNGJh?=
 =?utf-8?B?aFZEelZSQ3dEbE5ZbGpMemxGdm83QkZDa0xtS1BuK0dCMGY4M1ZJOHBSRDNN?=
 =?utf-8?B?aTFOcmh2OXR2eFJvNlFGWFJGUXhuNzlLSGFLM2V1TGdiQTFXRm9QSFNLaEtG?=
 =?utf-8?B?b3E1cjcvTkdScVV3Z1AyeU9EaDkzMEFmWkpnRG1MMEM0dVVtMW12UFNEUzFJ?=
 =?utf-8?B?VTNoQWNZLzRZcnl0akdHNEhPbWlvN2MxM0hiQmVXRVJpMEwxeGx6VUpxV21N?=
 =?utf-8?B?OUN6SDZLQXcvVjZCandBOHhFQXhtUmNMMitrbm5MWllkZmJGeUtSTTljVml5?=
 =?utf-8?B?NUxlN2tCVjhzM3Y1TWlVZHdhVVFDemRxUGZ2NlhWMWloN1BGb0tuOFhxemxx?=
 =?utf-8?B?blEzQ20rQUxuckNrMUVXeHJ4QUNKRU9OM0xpS3dudGF0UHhaVkZDRkhLNkNE?=
 =?utf-8?B?bnhMYkpHZi9vZHF6MUFlNDgyWllFaUQ0WDhDMUUzbzhBWXZCSURlN3ZxVUNu?=
 =?utf-8?B?cGJJaXlkRnhTU1pSdlMxUFNwbWF2cnBmanBoVmZHdnhlaCtOcWVrQ05aUmlo?=
 =?utf-8?B?YUIrQzJ3OEJDL2RDZVkwcDZsS0pYcWZiUlRrWU1GQmF2bW5iM2tESEk4ZVdj?=
 =?utf-8?B?cHpBdm1tQzNIc3hkaWMvL1kxYmRhTkZSM2NQRmlBME5uVmxyNGpOSHUrUk1k?=
 =?utf-8?B?Y0NhK0NVRGhKTXQ4TWVNMGhJMjRuTXEwbkZGL3lDUW5wK0VMSmZqVDRjb2oy?=
 =?utf-8?B?bWlERWMvQUFZeklVZUJKNEQwSHQyR09FaytGSlJuWlBROGplcWZiUS9ibVBt?=
 =?utf-8?B?alk4dzgxOThtUnk1bzVxbEd3QXJrdU1qOVpHcGUybjVZYUNGcWh4S3hCcXov?=
 =?utf-8?B?MkxSbXc3MUsyNkc5U25XbWxyVHZDSHdDeU13OEhpWlV5d0RHOVR4R0VSZm52?=
 =?utf-8?B?QTdnbDYzMUoycDFxMzRGZVhhWFovVUJaRFBzZ0gwZkp2b0I2RncwUEY3bEV2?=
 =?utf-8?B?d3E2dk05SXcwemVWOEExcUdWaklQLzVUU213UEJIRHpvcGFhZkRLS1NGNVpZ?=
 =?utf-8?B?ZFJNd0pPNWNxaXdQT1lORHUwUEJ4b2YvK2dSdFFvaDRIajFVS0ZPSmRLY0Jw?=
 =?utf-8?B?YjhrVXVxd1V6WnRGMFJhRU9ldnhYSVVjelJMQ2lqOVdTNjIyVzZleDRpTHhz?=
 =?utf-8?B?WGZJUTM5Vm5XQXNMZE90bE5GRm8raUNEek92TzNaTVlHdmNkcUk3Y25hSWw3?=
 =?utf-8?B?RG9aQVZzVEw2eGxuV0xUMkdYYk9ma3hvOE4rVXFNdm9EL08zUC9kalEvcmVu?=
 =?utf-8?B?d0dYSjdTc29TT2hmQzNVdzZTVHpBb3hwRk1lOFBKOVFBR1haVVdWbXBIWFo0?=
 =?utf-8?B?NFV3bEovTkdDdlkwYStHVHJvUkl4enZuZjZsRHlrNzVSSTQzRllYaVhVRjc4?=
 =?utf-8?B?QklsOVA3UnBiOXdQYVhHc1ZqNjV5RGxkM3Q0TldQdTBmaWZlaDBHYmFURDRi?=
 =?utf-8?B?ak9aRWZCczlrOHNqdml4emhPSGR5R2d6SUxhWHNQNS9Pem1EVytJSzB6ZmdP?=
 =?utf-8?B?WTA2bHJ3NHhEVVFjRFoxRmhaQkR4V0dFUyt0YXAxaUZNdlpNeFNhazhCVWhi?=
 =?utf-8?B?MXFrWUlMUXNUWXpEb2pCNzRCamJSQ21SN3VpUTBwamJKa29PMnR2QzQ5bGd3?=
 =?utf-8?B?SitFYjlNWTJUNFduYkkxRzlETXR1RUJqS05QUmVjVTRGYXYzMzYwZFluOS9W?=
 =?utf-8?B?NlpvcHIwSVpSZGRCeWdCNWxlaEJxcHBWazVLU2VvdmVEWEExOVhpL0hvS3dl?=
 =?utf-8?B?ZVY4aGxTV25Dd3FBTERsNDNlcE9Eazh6NlNPMVZrSk1yZkdXQWtsNXJZaFVp?=
 =?utf-8?B?a29XcUNpOXMvNzFOOVFUTnBBK0VMWGM5dFpZbll4ZlpLd2plaU9SOHRncFA3?=
 =?utf-8?B?cDJic2ZQcDIxM3pwZlZVTHYzYmdUVWZ1WVpXekkyTCtGU3lQSnhNdlRRb0xS?=
 =?utf-8?B?WTA5TWs5YUphMTV2V0JSRmZjSTkxVkU5bm8vTXEyNkxQS3U1QjV5Mk04dWI3?=
 =?utf-8?B?c2ErTUpleVYyM0NHYzdqN1JxYWVrL1duZlpJZHAxV0d6ejd0Z29sQT09?=
X-Exchange-RoutingPolicyChecked: mXnVLiq0AeRnEbku+U+T10/xo3bgQIcyGX0E8lt/Z4gWslD2+NdrfIKmZDPchw+8qHw4F21q3WnAoHq8KVjbLmvh7zzYds1qg3aC5/gifOWqzxpPBtzUfi0OVmnhutS1HScpb1BaRa/PI5fWkr+swhRaNMXDddV2Nst+kLqBbM67C1p3iBGDTPVIuUzth76JRx7pvPALzOwMgcTONrQSg3Ql9nRaPuWGLt6j+8O1hRh9vwx9X4mj2aItoL9ZHyg7e9LGfj9GpD8CCn2vC2wo033c6Ox6PEttJQr9G5uxeEWdBjj2hOc0rtuUjNZs2yj1JFcO/wBUmbFjwvhxwBW7eg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afd5b50-d6b9-42a2-ea40-08deace3f16c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:26:54.3207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3wZKGAp9hKd1GlJnfbQpi3HsT8VV8p//QFm5lwxYAR7r3rmYHjpKCq1Iw906I7d/aSh/vJSmqwczg1OKdCkHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6700
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yi.l.liu@intel.com;
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

On 4/30/26 15:12, Zhenzhong Duan wrote:
> When both device and vIOMMU have PASID enabled, then guest may setup
> pasid attached translation.

s/pasid attached translation/pasid usages such as SVM/

> VFIO needs to be aware of potential pasid usage and should attach the
> non-pasid part of pasid-capable device to hwpt flagged with
> IOMMU_HWPT_ALLOC_PASID.
> 
> ARM SMMU doesn't support IOMMU_HWPT_ALLOC_PASID, only VTD need it. So
> we can't check the existing vIOMMU flag VIOMMU_FLAG_PASID_SUPPORTED to
> determine if set flag IOMMU_HWPT_ALLOC_PASID. Instead, introduce a new
> flag VIOMMU_FLAG_WANT_PASID_ATTACH which will only be exposed by VTD.
> 
> Opportunistically add documentation for VIOMMU_FLAG_PASID_SUPPORTED
> and explain the difference with VIOMMU_FLAG_WANT_PASID_ATTACH.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   include/hw/core/iommu.h       | 11 +++++++++++
>   include/hw/vfio/vfio-device.h |  1 +
>   hw/vfio/device.c              | 11 +++++++++++
>   hw/vfio/iommufd.c             |  8 +++++++-
>   4 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
> index 77739d4214..20d6d79062 100644
> --- a/include/hw/core/iommu.h
> +++ b/include/hw/core/iommu.h
> @@ -20,9 +20,20 @@
>   enum viommu_flags {
>       /* vIOMMU needs nesting parent HWPT to create nested HWPT */
>       VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
> +    /*
> +     * vIOMMU supports PASID capability, VFIO checks this flag and synthesize
> +     * a PASID capability.
> +     */
>       VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
>       /* vIOMMU needs dirty tracking on the nesting parent HWPT for nested use */
>       VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING = BIT_ULL(2),
> +    /*
> +     * vIOMMU requests other sub-system like VFIO to create a HWPT that can be
> +     * used with PASID attachment. VIOMMU_FLAG_PASID_SUPPORTED can't be used
> +     * for this purpose as PASID attachment is needed by VTD IOMMU but not ARM
> +     * SMMU.
> +     */
> +    VIOMMU_FLAG_WANT_PASID_ATTACH = BIT_ULL(3),

instead of having a flag, is there any chance to let vfio check the
struct iommu_hw_info::type? It appears that only
IOMMU_HW_INFO_TYPE_INTEL_VTD has explicit pasid attach.

>   };
>   
>   /* Host IOMMU quirks. Extracted from host IOMMU capabilities */
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 380a55d6e5..8472420d3f 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -282,6 +282,7 @@ void vfio_device_unprepare(VFIODevice *vbasedev);
>   
>   bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
>   bool vfio_device_get_viommu_flags_want_nesting_dirty(VFIODevice *vbasedev);
> +bool vfio_device_get_viommu_flags_want_pasid_attach(VFIODevice *vbasedev);
>   bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>                                                   uint32_t type, void *caps,
>                                                   uint32_t size);
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 3ffd69a579..b954b44d31 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -544,6 +544,17 @@ bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
>       return false;
>   }
>   
> +bool vfio_device_get_viommu_flags_want_pasid_attach(VFIODevice *vbasedev)
> +{
> +    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
> +
> +    if (vdev) {
> +        return !!(pci_device_get_viommu_flags(PCI_DEVICE(vdev)) &
> +                  VIOMMU_FLAG_WANT_PASID_ATTACH);
> +    }
> +    return false;
> +}
> +
>   bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>                                                   uint32_t type, void *caps,
>                                                   uint32_t size)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 78e7b6a045..0718f029ca 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -364,6 +364,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       VendorCaps caps;
>       VFIOIOASHwpt *hwpt;
>       uint32_t hwpt_id;
> +    uint8_t max_pasid_log2 = 0;
>       int ret;
>   
>       /* Try to find a domain */
> @@ -409,7 +410,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>        */
>       if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
>                                            &type, &caps, sizeof(caps), &hw_caps,
> -                                         NULL, errp)) {
> +                                         &max_pasid_log2, errp)) {
>           return false;
>       }
>   
> @@ -437,6 +438,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>           }
>       }
>   
> +    if (max_pasid_log2 &&
> +        vfio_device_get_viommu_flags_want_pasid_attach(vbasedev)) {
> +        flags |= IOMMU_HWPT_ALLOC_PASID;
> +    }
> +
>       if (cpr_is_incoming()) {
>           hwpt_id = vbasedev->cpr.hwpt_id;
>           goto skip_alloc;


