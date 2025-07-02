Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57980C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 01:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWlrA-0002eW-7m; Tue, 01 Jul 2025 21:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1uWlr9-0002eK-1S; Tue, 01 Jul 2025 21:01:47 -0400
Received: from mail-bn7nam10on20615.outbound.protection.outlook.com
 ([2a01:111:f403:2009::615]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1uWlr6-0006Ze-A3; Tue, 01 Jul 2025 21:01:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKV2+FMQazOb7Xy3SuzkK39W2clzwxyPP56sCKgySGDO9v2Dogc2nK8bjXa/S6tOI8HVtgC0EdoJbKKnez4MpdLftfI1kdz8Bk9t8bVJJWJJSmZAM4y4PjyzudU2n+kGUfz2aNwEvZ9RzW1FBb+AzAJEcPEgQWTVQ5YqfBdUztOAYwGqiNt/I1xJVxYvEjsuwmTs/5JDgWOpCG38j9DsBWtQz9hOKjZudy3b1EbizkCzOQQnQWfVWDl2mtv6Bb5GdspZ/M3VtA/Cv+LqZ4eIwEPCl5qeZZdaENR4Nn3rXJQa01sLkTdwUvUWi+qfQokCyWAiahNB6UjOSu/yx2DeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaYR7I7FK+n7wM9027CmnwaNObPilb9mIoGhMwWImBw=;
 b=xzCPDzwP1PqmwmTTfWyVqcAsS9ltKniFQB9kByS0344Xd59vizKjN3yPEqzgKQPn80KYO5pxAsmQI8l2NFvBIg1Q+aanL+YfFoSh5WF0J/xr+ci2jagzdO6DPIgis05tuXeqHSeQ6mSF+E+UJJYdtkNvgM5nAH6Rm8iVzlcsQT3CNo/IXDg5k/oEKM7RTheeauF0KALO5BajrkmBMr2mP6DezpJ98nomDk/WHLI4/KHbBvgioh0Hj3SRxEsVrvWR8ON+RuxRcujRVW/5SoHC7RPwfpWw0sVH2G9CzUonZ8566lhk0A0940g81enOMHO7D3wPsgdBVWYhmOR1kNPsaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaYR7I7FK+n7wM9027CmnwaNObPilb9mIoGhMwWImBw=;
 b=KDnZjJQeFVzSLk73A6+rwEpfWBnr6YRPnu0li4+NjRAJXBFxvMIvkMtL4BcmFQko9QEwGHl8+dQk+IlqwyP/uXr6E6ChK3OSImMWwCchpM5UhBG/A0WRUopKPzi8/gEV1gTKzOeSQeuGxmoNIYsB8vwPrPatV/5dEE9BRk4oP7BW89SChx1QkTji38gGIinNCYQf3uaxh42abAsd2KlL2bvIVbupAEUknDDiFoeWF9WWF4wkMZNtvNmnnERfEgirrze7FIeWPmiZH/c8uvI0zGNAzDWqg/DZPI6vXp6fPeyF+IYR9M2hyfA8OSpgUBqzo3l1cJvU3BTU+OVrs3LpdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 by SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Wed, 2 Jul
 2025 01:01:37 +0000
Received: from SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400]) by SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400%3]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 01:01:36 +0000
Message-ID: <81708f09-849a-4b01-9e4c-a854ae26eefb@nvidia.com>
Date: Tue, 1 Jul 2025 18:01:34 -0700
User-Agent: Mozilla Thunderbird
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, ddutile@redhat.com, eric.auger@redhat.com,
 gustavo.romero@linaro.org, imammedo@redhat.com, jgg@nvidia.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, linuxarm@huawei.com,
 mochs@nvidia.com, nathanc@nvidia.com, nicolinc@nvidia.com,
 peter.maydell@linaro.org, qemu-arm@nongnu.org,
 shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
 wangzhou1@hisilicon.com, zhangfei.gao@linaro.org
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v5 00/11] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0094.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::35) To SN7PR12MB6838.namprd12.prod.outlook.com
 (2603:10b6:806:266::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6838:EE_|SJ0PR12MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e5ea9a-7d6e-4f22-6e6c-08ddb903feb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZERMN3hkamRHKzNxcWNYaERzdTZFMXMvOThuM3U5eUlOQnNNbWR6R0xPelNV?=
 =?utf-8?B?L1lhcVpvYXAzdzZiTUlmN0k3M2pjNEJYbVZoajlKUTRmOUtOUVFMUVgxZkxy?=
 =?utf-8?B?SGRMUW1EdHdrQUs3M3B6empramRpcXhYZTRaOUFTbzhFcWVNTWt2VDRSZElN?=
 =?utf-8?B?RGs3ZmRHcWxERFRkcXJ0bDBya0tMTXRwanVRcHk0OEVPNlZDRkpFK1VEemln?=
 =?utf-8?B?UXZhL2QvNTJiL0NkVG1mdUtWZ0lqY3F2Snhic0lRWUQ0emNhd2pramI3Tkpo?=
 =?utf-8?B?b1BNejl0cUF1aHpYS3VwTVNUelVwM1ZubU95OFhib0U3QzdQaHFFTkVYbUVW?=
 =?utf-8?B?SzJaYkN2VWM5dE5TNEdmQjVndytlWjduN0dVZkx2Nis1c0F3TEFIbitIem5C?=
 =?utf-8?B?SDJVZDJTVkgrTlNJOURya1dpNkZIY0xsdTZySkkxKzBwOVRIZzJNV1NVM3Qx?=
 =?utf-8?B?YmVoQWpiY0FsOTR3RUlmYTZZQnhnSEg5OHVnUVpwVUgyY2F2ZkpBcGczTmV0?=
 =?utf-8?B?WUFnVXprQ2RycWJaZG4zb2RHczUzQlhObXkzWk1pV1YxbVUvM21RK1RoYlZR?=
 =?utf-8?B?VHFhM05MMjluRUpiN01mVExtMGNaQ3JSZ1Z6bDZLSnRjZVEvQjNPTkRmTDA2?=
 =?utf-8?B?OVhHc2hYbkcyS0pBWXA4aVY1M2tnbmo3RGMrWE02dTg1ci9OdkNTQ3dZcU9Q?=
 =?utf-8?B?TWphWFNZVFhCRTZRSTRUa2cyZGQxRWNLTlIzU3FGZ0pvd1F3V2N3UWEzVk5U?=
 =?utf-8?B?RDYwdS93V2VOQ2dMM3J6aStaT0JVNGdmRVU2VmtmZlJyRkRoZCtvdjJmTDVa?=
 =?utf-8?B?V1luUkVCVUZ6cGU2SHRwR3Y5RkQyb202d2RNY3hTV0ZXbG1ZdkpiTG5WS1pp?=
 =?utf-8?B?VWRQejlia1hvWExGSFlhYWFsS0FpeE5tc1NCV0pSNjRsSmJjWmJURjNQZWlE?=
 =?utf-8?B?alVzTGx1TnJKSlprZ2FjbklVY0w5ZmppdmUxN2U5YWZvREJzNEhSaGsrbCtB?=
 =?utf-8?B?VGRGdllyd2ZsVi9pNk9UbHFTZnNyL0hiRmMyWTNNWERLd3JLbUhXeCttWFEx?=
 =?utf-8?B?SW9xbmUyZ215ZXU2d0Z0UE9TNHdoTW12eGVhQm1Wcm8wM2pYZ3YvM0RLR0lx?=
 =?utf-8?B?elBKd1Q1ZllDK1FjL0FXdlNJZ3ZkNVQzenEwVGMvK3pNZWh5TDYyb0dxTkti?=
 =?utf-8?B?N2JyRXNXRzcza2N3aituQmFtdmtGWUErWU1xNUl6NnQyVkxGb0VBdkZwVnlI?=
 =?utf-8?B?T21KY2ZmWjRQZXp5MmJJZ1RGZ0ZIYTFteTRIa2R5ME5XZjBUZTFLWThsT25k?=
 =?utf-8?B?NjRxc0ZVTXRIdDVYbUJmUzJmaGZ3MjZCbFZTSnFaTUlxTXJlY1N1VEF5UlJm?=
 =?utf-8?B?T041WHg4THJ0bXNzUVJjd3M4ZHhDdUhCdEJaZFFXNDRqa2pNYmdBZUZaeGlM?=
 =?utf-8?B?SExaNEYxOXViRVBVUEliK1l3WWd0ck1yYWtQcThBNTE4dmRkMVJQRHZwWkdE?=
 =?utf-8?B?d1k3Mk5MVklLZExKNUxqU2RaN1RpNFE5dUVsYjlQc2N3QU1YNzIzcGFKbUFy?=
 =?utf-8?B?MkQ3WEJ0RFVUazBnSGJzVGhNcTE2amVsaElCZWNUb1hmNjZsVnJOcFVDdFBx?=
 =?utf-8?B?SUs1bmxJNElhbTNybnZCUXJHZ1dBOUMxeERKakNTd1ZKSDhoc3hEa2s2SlZv?=
 =?utf-8?B?SFU2RC95Y3pnd0FubFZGVlRTOXU5ZjV1eGRmdnBKN1R3dUZEUTNMVDdFbzVI?=
 =?utf-8?B?RVJzSkF2bGFhRW9wNU5wMGV4MGJMU2MwWEVuU2IyK3I0aklJMnVDNkVySnZh?=
 =?utf-8?B?U0Y0YmNPd1hVS25ZSmtiZkxGS1NaK1haNU91RzVzamR6djNyNlRoZmtWM2pS?=
 =?utf-8?B?R0dHNmpoSFBLazFsaTJndUdPdkw0Sm1MRERZdVpObFhac3VOQWozNmFNaEZQ?=
 =?utf-8?Q?HKjZhynHs70=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6838.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU51aHhyUDRBenlGS3p2dHFkMU5YMGl5cXY2NHBQYTJoalZhM1lFZ255aENS?=
 =?utf-8?B?dWpPZjV2TWpXNTNjTUtCOURiZFJ1Q3U0em11citZSDA4YnV3UmpFNEg4ZGJR?=
 =?utf-8?B?aHdoR0hqOGR3amFhK0xqN3FWRGgyMS9UQXN2OGRlTm1XcklXYm5GWGtiVlBW?=
 =?utf-8?B?cnBsWitIRXhVRjNqTGJ0QVkyNHQ5anlzRCtFMld3Q0hmWGhvSTE3YXZLVWhi?=
 =?utf-8?B?ajQxME0xRWNBOGRrc0ZEYzRLanBSN2I0S1FrUnBDZ1JObjRsMDFiVUI1RUdv?=
 =?utf-8?B?ZXd3bmFmMWx3YlVtYzFoTGhCN2JUckpnajlOZkJmNGFwckZWMkI1Qi9FNTZx?=
 =?utf-8?B?UUhlNkw0TG8wUHgvWG5LaThWbjhxZndrQ3p5cmxQUmI0cm5iTU9uM0tkOERp?=
 =?utf-8?B?c1BwdlE0NEU5d0l5ZnJIMUhFUTN5NTZkSmhHM2RXLzBPVFlpOTQ0ZHNBd0RU?=
 =?utf-8?B?Y1BuYnVJek43SDJ4cnIraFZlK282ekp3UDE4K3pRSzVLRURNc0JSZkgxVko4?=
 =?utf-8?B?dSsyb3A5clJ6UCtLM1lsejJ2eFpSVFZNdDBUb1ZUdU5QRXpCaklXdlVIdnNR?=
 =?utf-8?B?enh2dTFUQ1VXdXArelpqdXdvZ1gyQW50dVp1cks2MXc4bXNTZ1FocGZFb0ZZ?=
 =?utf-8?B?NUdpdHlBckpweFhMaEtqdG5IbUU1NGRrT1EvQzZ0RUxrMkdJdlVZYVhiUjdC?=
 =?utf-8?B?Tk11U2JqUTA2V2w3eW1HUjVhNXVJdXBUaWM5M2hVM0IwdDR6MUpNQ1d1bXJQ?=
 =?utf-8?B?TVhOb2Q5L0xtdWtONHNqcWxFd2h0ZWd4ZS9rN1Faam1ldndGVVFoTzNRTC82?=
 =?utf-8?B?OGgvcTJacEZrU2x2dldBTjMveGlyMGsvSFUrYnFpdGFvUzJ1N1NkQUZDNUs0?=
 =?utf-8?B?VlU5STdMR0FvV0hid0NoSm1LSVJBYzE1NUJNajlCVXlrRjdEekJGZjZOMi9M?=
 =?utf-8?B?MWJ6T1FHSHFyYnFUWENVVzJXVjRaZ0FYSFprWmxER2RiUVBUYUZoY0lFdHZi?=
 =?utf-8?B?VW5lS3dwNWZmMVpvOE1kcENhNjdCUjBlNDNwb0xCOXZoT3Y5YmYvQmFranI1?=
 =?utf-8?B?MWFRM2VDNlIzWGNZODhUVEp3d3ZhM0xnSUhHZ3RxbG1yczkzQzVlNzYrWkFO?=
 =?utf-8?B?TC9iTm0reUdIN203cTZYTjFyRXQ1R3ZQcDNveEc5SmM4b0pVTFQxa3U3T2d0?=
 =?utf-8?B?R0tsNldLaWZ0a2RNbUJRVXdva1hDcktjTHhEb2VWYVBJUTdTSE9MUHNxOER3?=
 =?utf-8?B?SytKRUdsaUZoQTFiYUxTTUg5Mk51MG9aMGxrWFVBdytvNjcyMWdweUYzeEhQ?=
 =?utf-8?B?WVoweXdoZVVyQW0xS252OUR3QWxEdUR2T1lLSEFMWFAxMnMwQ05YWUhWZHI1?=
 =?utf-8?B?VC9IUXhlQkNPdE4yb3dxNDNmTjNlc0U4eXZ3RmEvL2lLUjBiVjlRUjNraUFx?=
 =?utf-8?B?c0p5aFc4NWdaT2tJclVicnV6L1Bhb1VQc2dSN2lYMFRjcWlyRzFwb3k0NHc4?=
 =?utf-8?B?SnFhRCtjQ3NxenNxdmxFNUthcWxBOVNuUmFFbno4eDYyRWlFYjlxVloxMTBx?=
 =?utf-8?B?VWxodnVZbW9Zc01qcE1RQm9HMEcrTkpSblVpclJMVDM1NVZNNFBPdzN6RzIv?=
 =?utf-8?B?bW5GUGlPZFlRN3orU0JMbTdpdlR6SmZ5VHdHTEJrZ2szdU92Q3FxTGFxbWxl?=
 =?utf-8?B?T2lKRW9jOVZFWjJibndPbUhlTkE1emE2OTJLRXdzMTFZa0t0WGtSZDFSeklG?=
 =?utf-8?B?Q2Y0bE1lSmlwT3RSY0NvMmc0cFpPWDdtMlBRcTBIM0lHWFlWN2dwSE9SRVd5?=
 =?utf-8?B?OWFRS3lSQjkycmQ2VjJiczB4a0hZM0tTTzZnaU9sVTZ3UFRFWVlVWGQyMmQ2?=
 =?utf-8?B?QU5rOXcxU3ZhM2RZNUNlOWcyeEVva2lkeUprMTFxaG9aU0ROc0lPdHFncE1O?=
 =?utf-8?B?VW1tR1dZczRtWU9MbjNybHpDZmM5d09jWEc1YUlYZGZOZ3lvVlVkdFBTakxp?=
 =?utf-8?B?V0hhdkNRT0dhSWNId3JqWWx5QXljYklOcnZiY0Q0R3hXdVpNRHEyTGdLQy9k?=
 =?utf-8?B?UmcvSjNENjdTNCtDOVNGUGVLRWdTS0FRUzRVcytMWDdXajhFazU2RTI1dWpk?=
 =?utf-8?Q?ab8p05IjuvsfAZjVOYgc3lPVE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e5ea9a-7d6e-4f22-6e6c-08ddb903feb6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6838.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 01:01:36.7657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94xCA1dZnNhK51ZXW4DPM29i4MUpG45sYrrUFUjAq7Z9ewtnpMQ/R/TDRomWAi0IeBQF3sFHcw9iCdfqbIQ32A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476
Received-SPF: permerror client-ip=2a01:111:f403:2009::615;
 envelope-from=nathanc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

>    To address this, patch #6 in the series introduces a new helper 
>    function pci_setup_iommu_per_bus(), which explicitly sets the 
>    iommu_per_bus field in the PCIBus structure. This allows 
>    pci_device_get_iommu_bus_devfn() to retrieve IOMMU ops based 
>    on the specific bus.
>
>    This patch series introduces support for a user-creatable SMMUv3 device
>    (-device arm-smmuv3) in QEMU.

Tested-by: Nathan Chen <nathanc@nvidia.com>

I re-ran the test from v3 [0] and am able to create 16 SMMUv3 devices in 
a qemu VM with emulated devices properly associated with the guest SMMUs 
in guest sysfs - verified with some guest SMMUs having two or three 
emulated NICs assigned to them while other guest SMMUs have a minimum of 
one assigned.

Removing SMMUv3 devices from the VM config described above, I do not 
observe the problematic behavior where devices behind PXBs without SMMUs 
erroneously use the address space from pcie.0's SMMU. I removed SMMUv3 
devices from PXBs with one, two, and three emulated NICs assigned to 
them. Below are the guest topology and qemu command used where SMMUv3 
devices are excluded from the original test:

nvidia@lego-cg1-dvt-59:~$ lspci -tv
-+-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
  |           +-01.0  Red Hat, Inc. QEMU NVM Express Controller
  |           +-02.0  Intel Corporation 82540EM Gigabit Ethernet Controller
  |           +-03.0  Red Hat, Inc. Virtio network device
  |           +-04.0  Red Hat, Inc. Virtio network device
  |           +-05.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-06.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-07.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-08.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-09.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-0a.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-0b.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-0c.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-0d.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-0e.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-0f.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-10.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-11.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-12.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           \-13.0  Red Hat, Inc. QEMU PCIe Expander bridge
  +-[0000:90]-+-00.0-[91]----00.0  Red Hat, Inc. Virtio 1.0 network device
  |           \-01.0-[92]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:94]---00.0-[95]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:98]---00.0-[99]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:9c]---00.0-[9d]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:a0]---00.0-[a1]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:a4]---00.0-[a5]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:a8]---00.0-[a9]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:ac]---00.0-[ad]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:b0]---00.0-[b1]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:b4]---00.0-[b5]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:b8]---00.0-[b9]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:bc]---00.0-[bd]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:c0]---00.0-[c1]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:c4]---00.0-[c5]----00.0  Red Hat, Inc. Virtio 1.0 network device
  \-[0000:c8]-+-00.0-[c9]----00.0  Red Hat, Inc. Virtio 1.0 network device
              +-01.0-[ca]----00.0  Red Hat, Inc. Virtio 1.0 network device
              \-02.0-[cb]----00.0  Red Hat, Inc. Virtio 1.0 network device

qemu-system-aarch64 \
    -machine hmat=on -machine virt,accel=kvm,gic-version=3,ras=on \
         -cpu host -smp cpus=4 -m size=16G,slots=4,maxmem=32G -nographic \
         -bios /usr/share/AAVMF/AAVMF_CODE.fd \
         -device nvme,drive=nvme0,serial=deadbeaf1,bus=pcie.0 \
         -drive 
file=/localhome/local-nathanc/noble-server-cloudimg-arm64.qcow2,index=0,media=disk,format=qcow2,if=none,id=nvme0 
\
         -device 
e1000,romfile=/localhome/local-nathanc/efi-e1000.rom,netdev=net0,bus=pcie.0 
\
         -netdev 
user,id=net0,hostfwd=tcp::5558-:22,hostfwd=tcp::5586-:5586 \
         -netdev user,id=net1 \
         -netdev user,id=net2 \
         -netdev user,id=net3 \
         -netdev user,id=net4 \
         -netdev user,id=net5 \
         -netdev user,id=net6 \
         -netdev user,id=net7 \
         -netdev user,id=net8 \
         -netdev user,id=net9 \
         -netdev user,id=net10 \
         -netdev user,id=net11 \
         -netdev user,id=net12 \
         -netdev user,id=net13 \
         -netdev user,id=net14 \
         -netdev user,id=net15 \
         -netdev user,id=net16 \
         -netdev user,id=net17 \
         -netdev user,id=net18 \
         -netdev user,id=net19 \
         -netdev user,id=net20 \
         -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0 \
         -device virtio-net-pci,bus=pcie.0,netdev=net1 \
         -device virtio-net-pci,bus=pcie.0,netdev=net20 \
         -device pxb-pcie,id=pcie.1,bus_nr=200,bus=pcie.0 \
         -device pcie-root-port,id=pcie.port1,bus=pcie.1,slot=1,chassis=1 \
         -device virtio-net-pci,bus=pcie.port1,netdev=net2 \
         -device 
pcie-root-port,id=pcie.port17,bus=pcie.1,slot=17,chassis=17 \
         -device virtio-net-pci,bus=pcie.port17,netdev=net18 \
         -device 
pcie-root-port,id=pcie.port18,bus=pcie.1,slot=18,chassis=18 \
         -device virtio-net-pci,bus=pcie.port18,netdev=net19 \
         -device pxb-pcie,id=pcie.2,bus_nr=196,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.2,id=smmuv3.2 \
         -device pcie-root-port,id=pcie.port2,bus=pcie.2,slot=2,chassis=2 \
         -device virtio-net-pci,bus=pcie.port2,netdev=net3 \
         -device pxb-pcie,id=pcie.3,bus_nr=192,bus=pcie.0 \
         -device pcie-root-port,id=pcie.port3,bus=pcie.3,slot=3,chassis=3 \
         -device virtio-net-pci,bus=pcie.port3,netdev=net4 \
         -device pxb-pcie,id=pcie.4,bus_nr=188,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.4,id=smmuv3.4 \
         -device pcie-root-port,id=pcie.port4,bus=pcie.4,slot=4,chassis=4 \
         -device virtio-net-pci,bus=pcie.port4,netdev=net5 \
         -device pxb-pcie,id=pcie.5,bus_nr=184,bus=pcie.0 \
         -device pcie-root-port,id=pcie.port5,bus=pcie.5,slot=5,chassis=5 \
         -device virtio-net-pci,bus=pcie.port5,netdev=net6 \
         -device pxb-pcie,id=pcie.6,bus_nr=180,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.6,id=smmuv3.6 \
         -device pcie-root-port,id=pcie.port6,bus=pcie.6,slot=6,chassis=6 \
         -device virtio-net-pci,bus=pcie.port6,netdev=net7 \
         -device pxb-pcie,id=pcie.7,bus_nr=176,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.7,id=smmuv3.7 \
         -device pcie-root-port,id=pcie.port7,bus=pcie.7,slot=7,chassis=7 \
         -device virtio-net-pci,bus=pcie.port7,netdev=net8 \
         -device pxb-pcie,id=pcie.8,bus_nr=172,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.8,id=smmuv3.8 \
         -device pcie-root-port,id=pcie.port8,bus=pcie.8,slot=8,chassis=8 \
         -device virtio-net-pci,bus=pcie.port8,netdev=net9 \
         -device pxb-pcie,id=pcie.9,bus_nr=168,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.9,id=smmuv3.9 \
         -device pcie-root-port,id=pcie.port9,bus=pcie.9,slot=9,chassis=9 \
         -device virtio-net-pci,bus=pcie.port9,netdev=net10 \
         -device pxb-pcie,id=pcie.10,bus_nr=164,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.10,id=smmuv3.10 \
         -device 
pcie-root-port,id=pcie.port10,bus=pcie.10,slot=10,chassis=10 \
         -device virtio-net-pci,bus=pcie.port10,netdev=net11 \
         -device pxb-pcie,id=pcie.11,bus_nr=160,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.11,id=smmuv3.11 \
         -device 
pcie-root-port,id=pcie.port11,bus=pcie.11,slot=11,chassis=11 \
         -device virtio-net-pci,bus=pcie.port11,netdev=net12 \
         -device pxb-pcie,id=pcie.12,bus_nr=156,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.12,id=smmuv3.12 \
         -device 
pcie-root-port,id=pcie.port12,bus=pcie.12,slot=12,chassis=12 \
         -device virtio-net-pci,bus=pcie.port12,netdev=net13 \
         -device pxb-pcie,id=pcie.13,bus_nr=152,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.13,id=smmuv3.13 \
         -device 
pcie-root-port,id=pcie.port13,bus=pcie.13,slot=13,chassis=13 \
         -device virtio-net-pci,bus=pcie.port13,netdev=net14 \
         -device pxb-pcie,id=pcie.14,bus_nr=148,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.14,id=smmuv3.14 \
         -device 
pcie-root-port,id=pcie.port14,bus=pcie.14,slot=14,chassis=14 \
         -device virtio-net-pci,bus=pcie.port14,netdev=net15 \
         -device pxb-pcie,id=pcie.15,bus_nr=144,bus=pcie.0 \
         -device 
pcie-root-port,id=pcie.port15,bus=pcie.15,slot=15,chassis=15 \
         -device virtio-net-pci,bus=pcie.port15,netdev=net16 \
         -device 
pcie-root-port,id=pcie.port16,bus=pcie.15,slot=16,chassis=16 \
         -device virtio-net-pci,bus=pcie.port16,netdev=net17


[0] 
https://lore.kernel.org/all/90957693-dc12-4731-960f-0ee295d297ec@nvidia.com/

Thanks,
Nathan

