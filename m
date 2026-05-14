Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD063CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 11:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNU4D-0005IR-SJ; Thu, 14 May 2026 07:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU49-0005Bi-Hx
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:17:21 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU45-0007sv-6w
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778757437; x=1810293437;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ascAXIwGu1tpO3xmGAKcYSREZ0tRH8BWldna0ykaTMA=;
 b=dAnJtEMa63FHxCw/sIcA9hsZnkU+8Kf25JPvq1wB1nnhB7aqwyittTbW
 eMNFXQf2vBXT+0nKTtw1rIFKK+Uk3oJVlXOkt+3vpojitqLjWrbwINCZ/
 lHZmQ+rvMlhGMeZOimWwHG5Zex1LvxtIKKwkNR3I/fIFE/OFBqYINkpD2
 GBF0T6N0yakYAB2Ifffy7T/8eRzk45Ph1cBMAU2i3NHV0AeqUj9sZUy4b
 QaeQTGrxJWTylfX1QH+v+eOi8a40/vV8M1gDVQq92sK0k04keTl133JKg
 V7OIQ+Zy1fJlBeoessD23y2YfqHfF8F40zEkHal60wMpPiWf5EEN+i849 w==;
X-CSE-ConnectionGUID: 7Jmqj8E5QS6mUFROI0RbWw==
X-CSE-MsgGUID: CUQk+2tWS6ifFg7K8dCnAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90006612"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="90006612"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:17:14 -0700
X-CSE-ConnectionGUID: PUenC09xSOG/eY1eumckCA==
X-CSE-MsgGUID: Akg2Vl90RquKoguB2jCqjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="237495278"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:17:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:17:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 04:17:13 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:17:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6kAX2HHpR5QhPVJSMjhYTRoeLu3XalO5YlY0ajrUwLA5OvVQjI5uTznBAKtQXBeXdgf8QhOR3qo3x4g0t6PhNizvzxqMEsiiGpeP1UfsM53+aXOGkB9LvpPecAeCmwOLdDnJI0n26wMRdDhXAAyf0HzsMD0RY5om7GaOevIroy602akng9ncA/RrR10tRdfxfGY/IhWetzRfW+GHw9ZntadBtnoGwAhIRPJsi7Dlp8rDq11NavWl2N4LmuJlErOuYeeMdlUEYPqriTk+PZwZ3eXGqP1JtjrS2c/ACgGH7tLgSpgObni0huISGQw3OvykAKg8j8SM2jb7ZmnqUCH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvxlFb2oCgxE+U8sHzHBJwRP6u735+SYY74PzYitamM=;
 b=XM2VGF+FY6iLBFzsSMGiP4dExUKqp3ewXTW8FkcssCHEWF025Ne1Mw8Y1R93TmtX9JRS5ErIGS4QR7171AHp3lhVcSbjKs0C9BbkgFgcDXjrjudtgAHWIcBieatIIOGViawvKg9HrCdU9VRAeW2U7R9D51mlDhE4lyCQoxnb2LI9GvdxzY12XQbiaqJ+Qlb1hBkH+gLl3huDtHZi1xjxEXSkXwg85OK1/hy7dA/bFls9axuimhE59We9Q+KfEjqvrAGsPmihHBGRcyiGRGlTfTCf4LbEYdEtUtW9xOExAXp9BrBtaUFzIsPz9T5LURj64cQjNuUOvJMtB7t7OkJjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by EAYPR11MB9588.namprd11.prod.outlook.com (2603:10b6:303:2c2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 11:17:10 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 11:17:10 +0000
Message-ID: <44c1dd56-a37a-42ca-b8f3-9ac69aa1f33b@intel.com>
Date: Thu, 14 May 2026 19:25:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/15] intel_iommu_accel: Handle PASID entry addition
 for pc_inv_dsc request
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-10-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260509040819.1044702-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::13) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|EAYPR11MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be8a438-551d-4a6b-96cc-08deb1aa573f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|366016|7416014|376014|11063799003|4143699003|56012099003|22082099003|3613699012|18002099003;
X-Microsoft-Antispam-Message-Info: /k7xa0BCLygeh8Yp3sNEn7Qav5IKd8A5Driy0v5sk6miZcajyOPTHW3W5AwRGZrCAi119uBFOf+KhnOMu5vj6yc8v6Js9ir+2QL29JOBH8mYtqbSUEKOUdjI+Ughl63G+LwH8QQnCVrrxyLb6bWcSgRSHXmp1rcXsz/L27fa8Xymo1KTYZMtJMvrnhmXWB+XRW48xS6Ry2VrOs6yDCdDKwIsuxV4sp0/BhYtuZQiIDMdz03ooUmeQcHeC8kMysR8Uex6s4f7LXzNGmPkMTaRlWS0yYuTvjMR/R4t5+O97iFPf27mnQ7F9fktOggatmrBue3Poway8zPwNWBXhr801BcjDwims/5se1IoHbxG85pa6dteyohJiZ7C4i3sMq9wibow3kUNaWEgk2ANvla4JuPXkNAiMXSHzttCrSjOeC+PuNbLTcSm1/+Qq5oLiASIc/gnjvXyBH48rrOXYxHgMnquoR50KAmuyM3GafW/3ZEkyQIZaNg7L9Tabil1fgP3QkKTkqUALtBhyGIbuf4KsfhjwtSZRry8yis+8px/zDVY5jMUui4t6P0po4/RLYHbuDKJ/u9WgAcJPQFGBotn5WNh2mcibeclvXtmMk0tWrKxzgGxrtfTo7SKRfyQIwZC0c4/kSKBbIS6OE4Y+ViBaWN99vvBgvwBFvhZJR5z/ETjeirDOfa+B92GKxWFEetabCX6/Sr1V6gqvNBUZrH3ZzjPOcv3juAwNhJjvwu6A8zZ/iWgl+HxeGA2Itj6K/xc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(366016)(7416014)(376014)(11063799003)(4143699003)(56012099003)(22082099003)(3613699012)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk5YLzNBd0pISVlVa2hVR1N2NHNoenArM0hDS1hnSzBSMlgvY2Nua2d6ckRq?=
 =?utf-8?B?Y2I5aVZ1aHQwMEw0UVVENVRndmZNcWVLMVgzbjFDLzJNd0dnYWNLWXlNOFlI?=
 =?utf-8?B?UmpCZEdBKzJlcll1Q0xkNlA3UHRDSEtUcHRRdTlRWGduOEQ5TUV3UnY5SXl2?=
 =?utf-8?B?VS9WQVhheEVGd2tNTXhnNnN1MG52QWJXRytNbzFNY3dDZ2RFTFRKTHE1ejhh?=
 =?utf-8?B?YVRpbjlkNVhoRkk1RTRIaXc3czducm9IZ1BBZ25NcFNFUUNyMWJXK09Zd0RX?=
 =?utf-8?B?ZElLYlJjYit0Wld1RlJrVlBiRGFJZUpxd3g0ZDJBdUxoMjUyK0s3R09GNmVm?=
 =?utf-8?B?NE9xQUZhV0YwWTlkeGFlT0YwQnptR01BS3ZKcFVYdTFkVStFUnp1bWJ6Ykw3?=
 =?utf-8?B?QWtQL0sxdnpnV1VuMEM5QkVvdnRrc2U3cVdldm5kMVR0anFLZ3Y3NnMrc1I4?=
 =?utf-8?B?SkVRRnFaR0JFdVJ3RTFRRUNsOThJRitRbndxZU5mZHY5c3hQcEtNaUpReVkz?=
 =?utf-8?B?aVJKM1JXU21SN0prUERKbEkrdytrRTFXZnpBdEpqNDl2WHB5bDVVRk1DMElJ?=
 =?utf-8?B?SnR3bDUwUGd1d20wL3JNYWFFWkdhRGZKMUZvUE5pYjhLUXB0VlBMUlRMMTVi?=
 =?utf-8?B?bzJiRWl1S24yYUtRaGNYZnJtVXVyQXZtcFYxa0JXZHh5dUE4Z0Fxc1p3dmxU?=
 =?utf-8?B?RjYvaTlETWlOQzA3emwzbnN3NEtzMWJ3aWlBUWlWT2tHSHY5WlRUZCtYaDlR?=
 =?utf-8?B?R3ZncjJONFFETXBjM0w1eTluSzVqQ0xGNEJ6Yi9NVkEra1U2dXpLVkFTZHlN?=
 =?utf-8?B?TDhkbXZKbFU2aDJPYzRSQUpLLzhxSzIwNjdqYTF5WjYrZnNuTld6QmVsNmhn?=
 =?utf-8?B?Y0dnUGlEa1lhR3BrdTBpcWRkbkxwSTN3Zzk5c0owbmllekxUSnU5c3UrV3NL?=
 =?utf-8?B?dzljbHFaSzRRcUpoNzZ5THp5eDFPNksydjBRSlg1RGZkTktoUXlLQ0VzT0dy?=
 =?utf-8?B?KytRNWF3QlVRYVROckh4NVdhSE93V0ZvQzFUMnZEYzN6SFU4SmxWVFI1aFpu?=
 =?utf-8?B?MXFXbkJ3ZDJ5MzNVbzFyK3V3aW1LSCtMRnZFamJvREFOYVUvUXoyTDBwZlk4?=
 =?utf-8?B?b25kWFNzUkM0SmtteXVUcnh6TktXM1dORWFlZWQ0VU41bDg5b3dSdXA2MlR6?=
 =?utf-8?B?YzRkaGVDUjdISktERVI2S3MyT2hZYzRaUnRuOGVoN0lCVEZkSHk0U28yaERa?=
 =?utf-8?B?RWRXRFlSb29XZjFBVHhXNStYNHd1WFI0YXdTdWY3eW0yL0xYZXVUZExwblVD?=
 =?utf-8?B?YW1SWjJUc3ptRngxUE5VWkkzSlhRbUo2T0ROaWtvQ3phV2FEbG8vemg5cGFR?=
 =?utf-8?B?cGVQWW55TlJOU2cwaG4zZUJ6V01YMnZZVGxFVjFFaHhLWTlWZkcyNzFTdkM4?=
 =?utf-8?B?d1ZQSENpYjMyd3FxQ0pDQStrdXhiVVdINXNqUnAwV09nQWsySS9aZUl6ZUYv?=
 =?utf-8?B?Tkk5d3lyRlR3eWRZY2NEL2c3NmE4OFRnWDlLS1lrL2k0UDZFbXlKMTgzcFVF?=
 =?utf-8?B?NDR1ZlNYdjJmeTVXa21uZkpWamY1VHk1Z2xKTFc3TVo4R1V5VWdPOXlWY1Nm?=
 =?utf-8?B?M2syMjFnZytsanpJNmxldlR5anR1VWdWdm5pbm42eGxQTmxkNi83bEVpVXRj?=
 =?utf-8?B?ZXVIRnJIdUN0dzQ1N0VWQ0k2MG5wd0w2Tk94VkRqbnlnTkoxQ1BmcC9WNWIx?=
 =?utf-8?B?QUQ5dEtQVXFocFFVR01uZmx3Lzl2UmpiK2syTmRTVktQakZkQ0xvNEJDNXJk?=
 =?utf-8?B?TXIzUEdtZ3ZKRGtnb3o3ZlFuc3lLOEVKQm5rK1JzSG9DMUl5Z0FEMHZnRVFK?=
 =?utf-8?B?NzZ2UWJKc2tNSHdJV0syMnYyM01mSFRaRkxHb3RYMGlyYkVJb3p0OG44ZHdF?=
 =?utf-8?B?SWxTeDhaQllHcVJsbWhBN2lFQkNJUGVES0N0cG9hV2Z0ZjBsL1p1L1FlYVp6?=
 =?utf-8?B?cnIrNTNkTGIxOU9QY1Axc1JURVhJYy8vTTRIN2lHUkdvcUVtckJnaC9OM3RE?=
 =?utf-8?B?bWRVR0IydmFWQ2JpRHRDRnZiZ0JXeERHZUhDNzlhZEhoV3QxQnF4RHUycGpu?=
 =?utf-8?B?eTZkQ25vdU9zYnh4cmJ2Yno4ajFIZVlmbW5sWTlVSjBwSnNvN3RhRWNGTUR3?=
 =?utf-8?B?cDFqQnlRMlhCVzNISFJmSS9iZ1FEaG9PeTZYSmVLeDJKbUlBQTNkdG9vNUZY?=
 =?utf-8?B?U1ZmZ2hlR3MwTUk4aEt3ZGw3ZGJheXB4a3RmRFd3Y3pGTkVNbXRjaHFyaXdL?=
 =?utf-8?B?M1BXcGsveWh3Ly90dFdTZWRKd3VETm9xMnJiMmxtSU1lUHdNa1J1QT09?=
X-Exchange-RoutingPolicyChecked: X8TSY5b5wy1in8eSobHTHWaF5nUhJWmL4FBXQmXjSGvvdGT8wRpzIRNZjpcQ3u18VpbuVwgKzV7l331b8zXsr0M4bbclgRH3JMNjXppSEmdj7/iYyrNxcrQdkRjneS24oo84yws+dTgP3zFMlrbhCoIH6+ggzFYr6lu/jGEVH6uNIms3L+Xr6XUiu8NC7Mtfi5UuSn7e2Jk6GOIbXX4v838hpxpFBzgnE4MazZCSxLRI5azeWvpUEk9XsyLc5TOsXleGvQxhMjnIggFAZadN+uBaPrQArZZBS4YRiskWzrOnXWQBbOzasXsvisSRP+80M1By1p0PRjIpSVLaky1CIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be8a438-551d-4a6b-96cc-08deb1aa573f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 11:17:10.1032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dH4Qp4HuVVRtRkmOKPi1G7MZ1+Dgm6vxshSLcnkoyviA+RY6tyte4f20/G4P2GkjdUST1zvN5+vDcv4/tpYJ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9588
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yi.l.liu@intel.com;
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

On 5/9/26 12:08, Zhenzhong Duan wrote:
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
> VTDAccelPASIDCacheEntry with only necessary elements for each pasid. We
> will use this struct as a parameter to conduct binding/unbinding to
> nested hwpt and to record the current bound nested hwpt. It's also
> designed to support IOMMU_NO_PASID.
> 
> VTDAccelPASIDCacheEntry is designed to only be used in intel_iommu_accel.c,
> similarly VTDPASIDCacheEntry should only be used in hw/i386/intel_iommu.c
> 
> When guest creates new PASID entries, QEMU will capture the pc_inv_dsc
> (pasid cache invalidation) request, walk through each pasid in each
> passthrough device for valid pasid entries, create a new
> VTDAccelPASIDCacheEntry if not existing yet.
> 
> IOMMU_NO_PASID of passthrough device still need to register MRs in case
> guest does not operate in scalable mode. So for IOMMU_NO_PASID, we have
> both VTDAPASIDCacheEntry and VTDAccelPASIDCacheEntry.

The implementation LGTM. But I got a question to ask here.
VTDAPASIDCacheEntry is cached in VTDAddressSpace, while
VTDAccelPASIDCacheEntry is cached in VTDHostIOMMUDevice. A natural
question is why usingVTDHostIOMMUDevice instead of VTDAddressSpace. I
think it might be valuable to mark the reason of this choice. This
would help maintaining it in future as we might forgot the reason. :)

> Co-developed-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   hw/i386/intel_iommu_accel.h    |  13 +++
>   hw/i386/intel_iommu_internal.h |   8 ++
>   hw/i386/intel_iommu.c          |   3 +
>   hw/i386/intel_iommu_accel.c    | 156 +++++++++++++++++++++++++++++++++
>   4 files changed, 180 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index e5f0b077b4..c9b1823745 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -12,6 +12,13 @@
>   #define HW_I386_INTEL_IOMMU_ACCEL_H
>   #include CONFIG_DEVICES
>   
> +typedef struct VTDAccelPASIDCacheEntry {
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    VTDPASIDEntry pasid_entry;
> +    uint32_t pasid;
> +    QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
> +} VTDAccelPASIDCacheEntry;
> +
>   #ifdef CONFIG_VTD_ACCEL
>   bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                             Error **errp);
> @@ -20,6 +27,7 @@ bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
>   void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>                                         uint32_t pasid, hwaddr addr,
>                                         uint64_t npages, bool ih);
> +void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
>   void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
>   #else
>   static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
> @@ -49,6 +57,11 @@ static inline void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
>   {
>   }
>   
> +static inline void vtd_accel_pasid_cache_sync(IntelIOMMUState *s,
> +                                              VTDPASIDCacheInfo *pc_info)
> +{
> +}
> +
>   static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
>   {
>   }
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 0141316f83..623dc24760 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -615,6 +615,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_CTX_ENTRY_LEGACY_SIZE     16
>   #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>   
> +#define VTD_SM_CONTEXT_ENTRY_PDTS(x)        extract64((x)->val[0], 9, 3)
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>   #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
> @@ -645,6 +646,7 @@ typedef struct VTDPIOTLBInvInfo {
>   #define VTD_PASID_DIR_BITS_MASK       (0x3fffULL)
>   #define VTD_PASID_DIR_INDEX(pasid)    (((pasid) >> 6) & VTD_PASID_DIR_BITS_MASK)
>   #define VTD_PASID_DIR_FPD             (1ULL << 1) /* Fault Processing Disable */
> +#define VTD_PASID_TABLE_ENTRY_NUM     (1ULL << 6)
>   #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
>   #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
>   #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
> @@ -710,6 +712,7 @@ typedef struct VTDHostIOMMUDevice {
>       PCIBus *bus;
>       uint8_t devfn;
>       HostIOMMUDevice *hiod;
> +    QLIST_HEAD(, VTDAccelPASIDCacheEntry) pasid_cache_list;
>   } VTDHostIOMMUDevice;
>   
>   /*
> @@ -767,6 +770,11 @@ static inline int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
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
> index b50c556c40..e1e32959d3 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3181,6 +3181,8 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>       g_hash_table_foreach(s->vtd_address_spaces, vtd_pasid_cache_sync_locked,
>                            pc_info);
>       vtd_iommu_unlock(s);
> +
> +    vtd_accel_pasid_cache_sync(s, pc_info);
>   }
>   
>   static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s)
> @@ -4751,6 +4753,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>       vtd_hiod->devfn = (uint8_t)devfn;
>       vtd_hiod->iommu_state = s;
>       vtd_hiod->hiod = hiod;
> +    QLIST_INIT(&vtd_hiod->pasid_cache_list);
>   
>       if (!vtd_check_hiod(s, vtd_hiod, errp)) {
>           g_free(vtd_hiod);
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 10bdbba632..a66d63b4c8 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -259,6 +259,162 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>                            vtd_flush_host_piotlb_locked, &piotlb_info);
>   }
>   
> +static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
> +                              VTDPASIDEntry *pe)
> +{
> +    VTDAccelPASIDCacheEntry *vtd_pce;
> +
> +    QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
> +        if (vtd_pce->pasid == pasid) {
> +            if (vtd_pasid_entry_compare(pe, &vtd_pce->pasid_entry)) {
> +                vtd_pce->pasid_entry = *pe;
> +            }
> +            return;
> +        }
> +    }
> +
> +    vtd_pce = g_malloc0(sizeof(VTDAccelPASIDCacheEntry));
> +    vtd_pce->vtd_hiod = vtd_hiod;
> +    vtd_pce->pasid = pasid;
> +    vtd_pce->pasid_entry = *pe;
> +    QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
> +}
> +
> +/*
> + * This function walks over PASID range within [start, end) in a single
> + * PASID table for entries matching @info type/did, then create
> + * VTDAccelPASIDCacheEntry if not exist yet.
> + */
> +static void vtd_sm_pasid_table_walk_one(VTDHostIOMMUDevice *vtd_hiod,
> +                                        dma_addr_t pt_base, int start, int end,
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
> +        vtd_accel_fill_pc(vtd_hiod, pasid, &pe);
> +    }
> +}
> +
> +/*
> + * In VT-d scalable mode translation, PASID dir + PASID table is used.
> + * This function aims at looping over a range of PASIDs in the given
> + * two level table to identify the pasid config in guest.
> + */
> +static void vtd_sm_pasid_table_walk(VTDHostIOMMUDevice *vtd_hiod,
> +                                    dma_addr_t pdt_base, int start, int end,
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
> +static void vtd_accel_replay_pasid_bind_for_dev(VTDHostIOMMUDevice *vtd_hiod,
> +                                                int start, int end,
> +                                                VTDPASIDCacheInfo *pc_info)
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
> + * VTDAccelPASIDCacheEntry dynamically if not exist yet. This entry holds
> + * info specific to a pasid
> + */
> +void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
> +{
> +    int start = IOMMU_NO_PASID, end = 1 << s->pasid;
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    GHashTableIter hiod_it;
> +
> +    if (!s->fsts) {
> +        return;
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
> +     * Loop all the vtd_hiod instances to sync the "pasid cache" per the
> +     * guest pasid configuration.
> +     *
> +     * VTD translation callback never accesses vtd_hiod and its corresponding
> +     * cached pasid entry, so no iommu lock needed here.
> +     */
> +    g_hash_table_iter_init(&hiod_it, s->vtd_host_iommu_dev);
> +    while (g_hash_table_iter_next(&hiod_it, NULL, (void **)&vtd_hiod)) {
> +        if (!object_dynamic_cast(OBJECT(vtd_hiod->hiod),
> +                                 TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +            continue;
> +        }
> +        vtd_accel_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
> +    }
> +}
> +
>   static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
>                                             void *caps, uint32_t size)
>   {


