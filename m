Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925DCCF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkLGd-0007xH-Oq; Mon, 26 Jan 2026 07:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLFz-0007pK-2S; Mon, 26 Jan 2026 06:59:49 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLFv-0003OO-Q1; Mon, 26 Jan 2026 06:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769428784; x=1800964784;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ukDyVVPDc29gGqR11gSDxihYIqdlSuGXqlVVFdc6H78=;
 b=gcZT+1Ckflf+k1qGOhFtyaXng/X1zj+E6bMPGAcikjEoREjD5zJIUgCS
 YJRBNVfpXCyZmnwb74fa9ZMAzJQ2aoDk9aH6TNZLBr6ZELq85GSpIBz80
 qPdKFOA5rZCZvQZ+aPEHmmOyNrXuiwdn+3Xw28XkYMYRdkTZI/CuUHW6Y
 s4fT1LYQo3o+5r7JLrJajS8s6ijF2NBWeSZa3pkeLPbAkxnnEhwclo2I0
 sn5+zuHcx+SLmjdNDAO2y3xUTDMm9QOq5GpxlPwKoLWVSOB1fzgZfjfZV
 NFqwchC8FYe/Wj56S+fMPusRlzK9PJk6oFObTIZkEgUid3vv7x4zXtZ3z A==;
X-CSE-ConnectionGUID: mQvtpIPfRl65gv0fpH/RTA==
X-CSE-MsgGUID: TNPGzYoGQOiNlF8WsSjdkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="81237790"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="81237790"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 03:59:42 -0800
X-CSE-ConnectionGUID: EwOoBFU+S/m2qCw5nw1feA==
X-CSE-MsgGUID: +ZeNiMgPSVi2HgN8AWbX/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="212648794"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 03:59:43 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 03:59:41 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 03:59:41 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 03:59:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOC8iQSN31KB0hWkwCgrHinUR95hEOrNh12Rtu5UTVWIjwE2O00qCvNC8v15vbCV9vUQqPX1S/sCJGcQogV9rhrumIFW6L0bNTYl8AWiA2QuWTR1Hr52BqfwAYhiHTuM1m93Y2XczFX7M2JTQICEbPF5TAOC/8NlpQZfdNNAQHai4yQuts8YDJ4EKZHhRZbnPkjzAQZi5OTXrvqfVS/tnoEQspXk0get6O+OXKf5n40/UshfUIxFQvFsFnbfK8ppzka5ZieAhNMaPJv1LG4yWuzZNE4fKU/FEu94hxP/oolrOg1GZWcHic5rxkKEf58HUy6ch6dyzJbWZfoNQagUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fa4HV6oRXrrNQ2BI79j2PEJRzjJrajF2C3cths7FoJo=;
 b=A9RmiHsFFKpePngnD5W46gzfNbQA3h2MW9/UMbadcsUp3aOCB4wFhCrW/W4InB0kTFRWY1XHVGsb3WME4XKcbyVHV8pIBdPw6tRM+/RJwzQ4FagIxkxMBp8jkvL2qfp+uarvcziYm2V8gNaXa96Uw4TEWOEJEZTw5fyhfJWFwlDEmBjEk9juyBn/mZ3Urp46ZDguFMnjAYUO6PmA1nB1jSOry7ZEFpnRLHHtVfGy2tDFkLtWLcwa9hGp+RiBwW+gcP+OjqfvHF0PeafcWZOUtM7fOfAFlAOVDgZN6EUvUWuePvXAzYcpNlO7utooQnmhTslZDx0ZTMwWS+j3n25WXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by DM3PPF6A4412A55.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 11:59:39 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%7]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 11:59:38 +0000
Message-ID: <60669816-b9d6-432c-b1e8-2b146149a551@intel.com>
Date: Mon, 26 Jan 2026 20:06:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/37] hw/pci/pci: Move pci_init_bus_master() after
 adding device to bus
To: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-8-skolothumtho@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260126104342.253965-8-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|DM3PPF6A4412A55:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e18c9b6-6922-4abc-29e6-08de5cd261b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzdwT2JSZjNWdHNlUTlvWFhGKzhkbVNUWUw1d1dsT3Y2b0RqZEVLbXlYVm5z?=
 =?utf-8?B?ZDhUOGU1Ujc5aitROWc2Q1lkbmZDd0ltZGdPUlNNTmFrTStub1FJeHdJY0g0?=
 =?utf-8?B?ZExzTStkaEh3V3JSNy9GSFV3angvMEJPb0RIU0VEUGdTVktJcWpZejlONzBp?=
 =?utf-8?B?WU0vSlNsMVc4eXlGbFV0dERqTXlWaGxpNlhMK21JYlhVYldUQ0hsbjNLb3VZ?=
 =?utf-8?B?Y2VBQTc5T01jSUdLWFF6MHZQaVNTU0ZubXU0eTM2RkVUUjdzS1FNMUJKajBL?=
 =?utf-8?B?dzd4ZHVJeVNrZS85NVM5enZQSE9TSXoybGlGU0VJVEJVOUVnVFIrenV3MjBq?=
 =?utf-8?B?L2pHNWRpTHYyRzJtejhvaW1hVVcrV08xNi9YNzBpSHY4T2MxcExUL0Z6QXZm?=
 =?utf-8?B?YytHL01OZGREWXFJL2ppdHdNZUZidHdWRndEenlIdy9YdVlEN3Mxa0ZrZmxx?=
 =?utf-8?B?OVV4blpma3VjSkEzZXJzdXB2cUtEVHlLT3hheTI2YkFjZndqUm9DbTJEdlhD?=
 =?utf-8?B?N3RhTkdwTm1reGhjekV2bUZyTVZ5SGN0aFpzZDBUNE01anI3ZHR3SFVMK0gw?=
 =?utf-8?B?N3FLc0hLejRoYTF6T3dIaUNZVWRpNVZyVk1OOEJEZnlnRGJsa0Z2ZWpOdUlu?=
 =?utf-8?B?aUlISWN6K0twQWREVWhjM2VJbEYxemt6U0I1L3QwWHhYWkJPRG9rTGNVRGpv?=
 =?utf-8?B?VThlSEVSeUQvUW1wMUVBTWs1YU16ZlZCc3pnQzNsWFBaWmdWNTk0NU1TeVFQ?=
 =?utf-8?B?d21kRWtBQXpsTmQ5dXg4dlpNWWJoWG1OZDJrZU84d0hiK3dFU0NQMnkzL2NC?=
 =?utf-8?B?WTFoYUtaYVdQREtqWGFWZnlSS2Y4ZmpPcUxMN3Z3TEl5UDhvKzFWbm9WM3hH?=
 =?utf-8?B?SEdEd0VjTW5rMEwyUTM1YUZIcHdlaDY2Rzh2a01HQm1zWDg5THZOcGdFMVpR?=
 =?utf-8?B?YXVFYkJ4NGFTdkY2dngxZHMzbDhZeGhOQkhUVkE5ZWRqWDd6T2F6L0VueVZs?=
 =?utf-8?B?UkhCQkhjbXhoTk5kN0M1RzJNbjB2WGU2VWZRR3ZFZi9NNGhYM0l3WC93NGJY?=
 =?utf-8?B?TlF3bzVsWDI0VHFvY1pDRktMaDdjajU1RHBWUExsZG8rZllmcjBOQ2hHNFhS?=
 =?utf-8?B?QUpxMWlFV3JUMDY2aVNOU0R3SkROcWFTaEk3RjBPdksxRTFEdzhrRGxpelpy?=
 =?utf-8?B?dnBtUDJHSndqcmUyVXZWaWJrV0l3NjdlcnpIcldzR3pFbWhUQ1lVdXBOSTJM?=
 =?utf-8?B?RUtXWTlpazNTWXh0alF2ZmdJOGdJMGhmUzFSdldtaFVlaVRoaGJHVkhtWHZp?=
 =?utf-8?B?Q3dtbXVyaFZxZ2Q2RWx5d1I0emVSTmlMMnZ2ckFNUjdBS01VdFIyRDNtWVRW?=
 =?utf-8?B?TDBWeGJLYnRSREt0OHUyYTVUSTE2T2JTN0dka1lZNUYrbmM4bEVUaWxhMm5Q?=
 =?utf-8?B?M3NmcHBpQ3JPN1ptMmpqK1VrQmFieDFFSGxOaGxsUEh0ZythNzkwNnRwNEJB?=
 =?utf-8?B?T3hEWWloOHVaR0JmbUpkdCtBZEMzOFYwcWtPRmhPV1RJelBrRTRjQlkxbSty?=
 =?utf-8?B?a3dUV3Vsc3V3Y1pRZG1YTzYzZk1CU2NQR1NFL1NtMEp1ZDNDZlJMWFpCSEo5?=
 =?utf-8?B?NGVxME1HQ0lNYTVDbEFQMWxwK004WjFWZG4vR0tUa1Y1d2VaMXFyem9HVkNC?=
 =?utf-8?B?T2oxREkzTC9HWkd6eVJlSjR2UDNpUCs4dkF5SUExeFo4Z0UrZTVlSmV1MU5T?=
 =?utf-8?B?a3R5T24zZ0JPN1lwamRDR1BYaVdWemVUNjZDMVhjTlVwMU9vRnN6Z0tjMExr?=
 =?utf-8?B?emVTbDgxSXlqU2VIWXAyVkNiK2w3T3Y5dys0aDZtQTNQYjMwZ25kdUFtTmZ4?=
 =?utf-8?B?R2d5NFhoWjI4S2NNdGhjdFVGbUx6a2JrdFVxVmpWRmpqb3MxVFdMNXIrZitl?=
 =?utf-8?B?aVk0cHRGalN4dTE1WkEyaUo1WHhuTHRqcEtDMGlFaWZtRThkSzlPemZJUWZX?=
 =?utf-8?B?RW1IazdvU2ZEVm4vaVBTWm5RQjB3MW8yaGlhMlgwTStROU1BTDYzSjN0STJW?=
 =?utf-8?B?TTI1TVZYQUUzNUpBRjZNT3A5Rk5RdUM5UkI4UmtXOENGdm1HSnpWdmlRWlAw?=
 =?utf-8?Q?X4Sk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(7416014)(376014)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVZZQW9pbkdBN09NWGJ1cVlmb2xPTEM1OUpsTHVCaFdKTG9HUXFEellmUVJj?=
 =?utf-8?B?STVPQnZXVnBMM1VodUZ3Wkw5aXhsNEk1UWptbTd0T28vM3dLUjcrT2xIMXdo?=
 =?utf-8?B?U1VWNDRxK1g4MGVmdTdYZnE3ZkkrNWFXdEJpQXRuTGhnY3gxNGJWbEhPdVcr?=
 =?utf-8?B?ZGljclN4Sjhqc0xlczJUbmovb1g1bWVzbGsxYkRxV1E0SXVxSWRUK3lyK0lm?=
 =?utf-8?B?NHdYKytZUlM5eFJySzBmcmZpYjVyM1VqR0RiRzZuM0JXb2xpYUJXTkdCTzhS?=
 =?utf-8?B?REEwMi92OVpJVlErUk9odGZyZE9JT2FSVUU2OUppRVNidi9uNXR5OWRkMFRE?=
 =?utf-8?B?OVFERlZaT25pc2JxQ25QaVpEUC8vZFdwVEdQNFRqUFRMcEpYdkRjQUo4R0cx?=
 =?utf-8?B?QS9RVmp0MUM4VkZqQWxrTjhnU3Q4UCt5N1ZEd2Q1blUzTDc1OTVEeDBkS0V0?=
 =?utf-8?B?aTFWQ0cyNlF0MkhyVERHYWhUeXBrajBMakJCUVFBZTZOYUtUSyt0Z2VmeUw1?=
 =?utf-8?B?Mi80YXltNW9NWHRXSlc3aktzRkJtblRZOWtYZEJsRzVLcHpac0VRckhZVFpx?=
 =?utf-8?B?SmR2S2tmdFZaMUFwNGNHZU5WbjdCU0xQa3NVMkZmdmd0UTY4Rzk2cndPNEx1?=
 =?utf-8?B?Yit6eEtpeHpIMjlqb0pmQ3RsS0hUWnlUWVd3c2pFTWYxS2R5bTlxM2ozOWJl?=
 =?utf-8?B?b1c5eWgxT0FLOVlDWkd1NVpBM3BSb0RjKzE1N0sxTnVlQS9sNHlERWNVOGIy?=
 =?utf-8?B?WEkvRmZERERaWVA2cVdiT1ZCVysvbkJKdFF1MDh0UXNxVXY5azBRSWtudWNP?=
 =?utf-8?B?cWJmakZXVDIySGliOFlzZEIrTjFYSDRkRDRwOS9vSUZ5TFNhWXl0NHZ3V1RS?=
 =?utf-8?B?U2NuUnUvUjhLMFBIVVBzY21zNTVpMVNQRG5sUWxpbTEwdTBnbHh0aUlia2hX?=
 =?utf-8?B?QWdwcDJXWWVMK2xNVVBON1pjamlxM0psOTVvUGdGSE5NbVRGbmpFcEh1Znor?=
 =?utf-8?B?d2FZdUFQYWhGWklUNE8zU01jcEx6WEozTHlTbmg5cFRKVFd4ckVpUW13aXFm?=
 =?utf-8?B?MXVlVys0bzgvUlZ6ZW9XZi80Skh6c2ZtbTB3ei9xUG8wcXM1L2hXdjVJUkt1?=
 =?utf-8?B?TEhsSWFBMHFoTEVpem1wVFhsc0wwVnpzdlBpeWxWeXhXS29JUlJFSXVhV3RD?=
 =?utf-8?B?YzkvNjNlWkVjQXZoNHFQbVR5aDl6VzVRcUZxejVzK3E2aVM4UU12ZFp5RFhR?=
 =?utf-8?B?VUxwRHZzb3hCdG85Z0JDbUsxRUJjRm0rQ2lUKzV4K0NMazZqbTFwTUFwREhW?=
 =?utf-8?B?SWowTDVVZ3ZJOFF6Zzl2NjFZYmxxOEhHNldMMGFSZTBlVlhBOU1EbGNoNG5L?=
 =?utf-8?B?L3Irdm5sNkEzU3pSN2ZzbG9XQWtZclBsTEZab2hLanhGTENOZEhUWFpoWWpY?=
 =?utf-8?B?Vi9yNWplM0VmSWxVV21NKzNCM01NMks5N0xNN1dIN1E2VGtmUjI0amkxcDBh?=
 =?utf-8?B?cHRNRU0rMkZDbFhZYWFSWHVhWFlqZU40aUpaangxVFpkY3llRDROQTEwQXh6?=
 =?utf-8?B?bXI4Y3NXRk4wSTlMMzdsT0FuVzQvcnNMbzFMS0U2RHRybXk3cmZxZy95dWVE?=
 =?utf-8?B?RjUzQnFLSHV0SFJsM0JNS1RqcTVrelNIN2tIc2twc3hVQzRBa2F4N2lremZr?=
 =?utf-8?B?alZoR2pySFFzZC8rbUtEWEI5MGJtd2l6cTE4dWMrSm1hWlphYkxHQTBNVU56?=
 =?utf-8?B?Qmpod2pPZUgzb0ZtVGxkbS9qOTVXazNsZStSSGFKcW4wbmlIVVBJeVVMUzBi?=
 =?utf-8?B?c3pYQ3M0aHRnNFlBMk1ESEhqU3VKaHVnVVRMZFRramU5ZE10YUdSRWJBQklp?=
 =?utf-8?B?SzBUcWtZZG10TTlsVzRENUpSK3dmbDhhSG9DTnV0KzNYd0RzMEFMMG0xbG5O?=
 =?utf-8?B?UFpvU0loM3lFMDJQNTVXNFUrcUR5eEFjdCs0TkxadG1UNVU4NXBTRmRvdWNr?=
 =?utf-8?B?WTJ3T3FSUUpkSklnajZsZjBMMTZENEdEdzlZZ1BFYkY2M0c0S2w4TW1CT2Qz?=
 =?utf-8?B?SktreHRIM3Z5R2NZQ2JGVlNNVnpDUllQeUc2emFuRXdtSkNqN1lFYTNYQmNk?=
 =?utf-8?B?STlrSTQ0SlNtSVF2VXpaTUN6S3lETk1UNTBQejlsMXA3dkFBMFExZUxPdjk5?=
 =?utf-8?B?cWJ5by9yd3BxZTNHM2pMalRSL0FPV2pPbTlwNzJKaDlXSjdUNk5rWHdpNEJQ?=
 =?utf-8?B?NndOVzliN2M5a0dobVloZGRXSHJnRXBSQ1Y2anJFQldQU1ptOEtxa1VRNk9i?=
 =?utf-8?B?RXRaTWNxN2x2OU9IOFdQZk5LQUVNd3liZEZXWEtGNnZtY2VTTDVBZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e18c9b6-6922-4abc-29e6-08de5cd261b5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 11:59:38.9001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LcNiO4290lNZG8EfEkUymeA+z0bwEBHAL5A2qgDl193HcFkXEqUBWV+sARpELwnNJ0eKljZsw1a+fycjQQ8UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF6A4412A55
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yi.l.liu@intel.com;
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

On 2026/1/26 18:43, Shameer Kolothum wrote:
> During PCI hotplug, in do_pci_register_device(), pci_init_bus_master()
> is called before storing the pci_dev pointer in bus->devices[devfn].
> 
> This causes a problem if pci_init_bus_master() (via its
> get_address_space() callback) attempts to retrieve the device using
> pci_find_device(), since the PCI device is not yet visible on the bus.
> 
> Fix this by moving the pci_init_bus_master() call to after the device
> has been added to bus->devices[devfn].
> 
> This prepares for a subsequent patch where the accel SMMUv3
> get_address_space() callback retrieves the pci_dev to identify the
> attached device type.
> 
> No functional change intended.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/pci/pci.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 8cbf5f5d70..229ea7cfb1 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1381,9 +1381,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>       pci_dev->bus_master_as.max_bounce_buffer_size =
>           pci_dev->max_bounce_buffer_size;
>   
> -    if (phase_check(PHASE_MACHINE_READY)) {
> -        pci_init_bus_master(pci_dev);
> -    }
>       pci_dev->irq_state = 0;
>       pci_config_alloc(pci_dev);
>   
> @@ -1427,6 +1424,9 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>       pci_dev->config_write = config_write;
>       bus->devices[devfn] = pci_dev;
>       pci_dev->version_id = 2; /* Current pci device vmstate version */
> +    if (phase_check(PHASE_MACHINE_READY)) {
> +        pci_init_bus_master(pci_dev);
> +    }
>       return pci_dev;
>   }
>   

