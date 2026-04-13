Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF7BF531C9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 19:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCMh6-0007Ti-1y; Mon, 13 Apr 2026 15:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wCMh5-0007TV-2L; Mon, 13 Apr 2026 15:11:35 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wCMh2-00016o-Nl; Mon, 13 Apr 2026 15:11:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BC43lCIIll9x27Ur6vfSheVNWB2W3GvaGjh9sequM4DVEPcIwr3XirVZWGqbAUAGtSgLp6uu+1HP1jvshc/kCxKFi/IhgWRg6unT0Y3tSrd80/ZPOXV828grLB7UhxxgbhfKNHF/UXyBH6IUFPmT/ZrSQUoCW2NH10VTMu1rKUY+y9vykZ81HAW3/Ppoi7RIQ4Se5OM+woxIUK2dr203mn1f8PALc7fnciopL0HT9rfV3pf+nAdmJNIlGxuy2lFFbbwJgrcBhT8Z5zvkGuqUeVMvDALzv1ohvFaXajnPU2mJgwQ0m/3hAbUd3s9Dl6JxObu1n59Hkv06HtYngQtOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFThX4xqFE727K1CLzF6wO4Vhe/N+9ed3lJ9RjoRUuU=;
 b=e6n1N76FGrcvzxg+vX1WNXtRvRMQ08dyWqoHlv4nu2jG5d3M4ZC/5+WZC0TOlH3GbD9ZnuxaRrHleEh5Ccm5EjmGMUXXEmsX6ObAVatxNg0m3rRe9WpkDjtMhh9m/HfUOUyaioAT0Afjo2XYcGdBGsMAeKarqH97LMDAXVHYxtPOgyRsDSgXtN6RrsTiq9VYKQVi6T7MQeXZp/2CR0tgr316C/7CYQUi8GNeJz7GQfWTzH4b3JwRlIXQSo1E7ottsgmAITuxsCVHi2qTM7z5VFk7o+tzjCbfONaOT5+EPlYsVZI0tmBdviz3jp27BNVSW5f6fVSm6vLB81H/L+FftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFThX4xqFE727K1CLzF6wO4Vhe/N+9ed3lJ9RjoRUuU=;
 b=Ofhy55DKUuvAvTC/ONjQY7vUwtBkpTQtsVLdMim5PtCAtCY+XKxMw/wtDurO5Uf8UZZogAGylZYTXIggXOYfHt1a5hk1nlw3uMrUJZMjoawRGJs7d0uYAaGTN2JbE+Z54EG/+9vFsWd5B42+bdSc1lWTUjSpf2LQ+Zlfl2wUiXVTkbrEYxdqhkAJTMlyieaxrW5pJUqGhuf/cu+8bqMZavijT5KpPbayTQ+Q9HTdM/j0NB/Z+OQHUFKKEBPGW6J8p95JzE6ZK2Uf7a+Z0cALs6WNnTHIzSArzhiuJQw5zzx9oLt0ZI4w82vqcTkBZ7hJjOxrFgtowE0KSiNESLgPfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Mon, 13 Apr 2026 19:11:24 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9791.032; Mon, 13 Apr 2026
 19:11:24 +0000
Message-ID: <98b61e85-2c6c-4de2-ba2b-e120229d230c@nvidia.com>
Date: Mon, 13 Apr 2026 12:11:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] vfio/pci: Add ats property and mask ATS cap when
 not exposed
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-5-nathanc@nvidia.com>
 <084d5550-c471-4d5b-8e2b-d2529a77cde8@redhat.com>
 <e2f357c8-c124-4a20-ae7c-acbee4be8e38@nvidia.com>
 <9481a1c3-0dec-482f-97ac-ad513af99f9b@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <9481a1c3-0dec-482f-97ac-ad513af99f9b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::7) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e5d920-1d7a-488c-558f-08de999074c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: uVh2H6hNuK92kff+tr9NU7lIfPQEjG8QdLeoKYU6VICtgJOHlGiJjuL8V9lL1kXUwFYuZ2MRyxZRWAQGS2pTH7DcIpeX2vRq2DHvo0ugcWw3IWEuG2ZrWFvwFVQgHnS/nveWnDmDZ5/8ITG7uWSRt58HwD9I6jfH+9pzJQwMRlezaD2QvioBn9JyHfT0CKFVCX6pJq+KTbbTRglauMclcM7R/HbFHx7OJL++OywL33vzo4dgRMPTwJvRLMyUDx2LHUIeFshVsv5rF3LCxd25DVpdOW5pwUx7t8PMpy/HmDp2TQcXAVdZcF0ZWUYWN7VbHT3vZmv+6NmRlVSnmiuFIG0IhnfyECIQ9GT7Y8eqPs9Lcb9bFgxEjH9tRF9lMuw6jJE03MnWRIv7pOmRevNEXWq5SE7JP/F5cFl99uCXP6DlZGJXObMGyfayc791H9HiuXm+jUbtFRyObA+krrTTebQVaRu9YLRG/CYqV8+7AtC5Px8jRsnw+vcP1ifikPPLpkRuA8w8X4B49yqG7TvdAiXCN7fLtRpnjltR+n/PvaTh3Cks8rLEZgQNLo+lBV9MBxoUong0imEPhQW9oESLpAz31jzaPNnJsRlIdCZqwSkyP2XyZ7LNUCrFOepD3G+mx11ZcdM182epPYSeJivNHuXJ7LWSe5aerMjIne1bUvakaXxtrs9N6EG41MSv2fJtBruGTsbvZrg1ragRJEiQkHD4FUr7webCWKAT75zrXio=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUNxUmt4QldjU1k4YkNoczNsU0hHeEdESkN6eTUreXUvRURVVnZaWE45cG5Q?=
 =?utf-8?B?VHkrZVNKVFlnQzZQVHhYOGhveU9sTUl2SHJLQk45SWNNN0RyUDROSUxaU1Fq?=
 =?utf-8?B?Tk1GdjJ4WTcvOVBrUE1IbEgwSk81QmZ2WGFTNmE1QUlva01ZK1Q1OHRNYXhv?=
 =?utf-8?B?K3dTM0NpOEVKYnU1T3BJVGx0Y2o2SjkxQnlIcGxnV0FFTUFITFVBYkpVdW1P?=
 =?utf-8?B?QlVwOVlJYVlHU3VFNlNGd28yWkczSlczOStvN0VTV0c4S1JqZ2U1OW9rZzhk?=
 =?utf-8?B?ZUZaeVlBeXR2V3RjQk9RaUtsZ0Z6S1VnRjhZakJTM0l0eTZEcFNCS212UzB5?=
 =?utf-8?B?a1lQYmdpWngwSHdrRkNrVU96N3ZNbUpuL3BldkpzbTgzeU5iZWI3UnZkTWpQ?=
 =?utf-8?B?d0Y1TlFuYmVzOVI1dWhXemVTd25HTGl2SW81UWo1OFN3V2s5UDczT25sZUZ2?=
 =?utf-8?B?U3doQ3RudWxVbXlKcFJGR0tOZER4NmllZmlMNXpUUXNJTmk0ZjNrYnhmdnRY?=
 =?utf-8?B?UGh2TDNUOVNtVkpUMFpBOUNETzlLVFBJM21zTnJSaGZvWEFiZ3ozR0JxcXVF?=
 =?utf-8?B?NVl2Z1B0dU9NYzB5RVpNZ3BZMW5UUFk0LzVRN2Z6blgzM2UyYS83L0FobHRT?=
 =?utf-8?B?RkZJVWJ6cUE5blQ4MjhLV3Awd2dvSnF1bklGTU9zMFp1alIrMkNIbkl3ZXE2?=
 =?utf-8?B?Qnh1SEd0anVDRjZBdjAzS3ZPL1F0Qk1XYTJNM2ltaG81akUrVEpoMGhRcHlY?=
 =?utf-8?B?TGJURTM3djRFQUQwRnZFcEY1b3BQUnF3MTdORU84d0U1UWR6VWFKc1UwY3ZM?=
 =?utf-8?B?WTVBS0ZHQ09XQjlmeXhhLzVBVmJjWWJiTUZqdnB3bno1eWwrMk1IaXI1Wk80?=
 =?utf-8?B?R1VRV1RyY2orNHdMZVRsc0ExWjJBOWVqMTl6b2VBd2dBRGhFUkJQeWsvMzY2?=
 =?utf-8?B?WVhrNUt4cmhmaE4rVnZsV2JLaGdUWVphNWoyMGZJVGVCczhsVmM3dnpsU1By?=
 =?utf-8?B?bW4vWjdOUDJEaEhhUisrQjJlNVc4L2FCckJXZEpVdm5HU3I5ZUd4M0RFbkIy?=
 =?utf-8?B?NGRlVnMvUTVNcEJxWWYxdzV5a04vbTNKMUt2cHpNQ01sT1g2R1pwNHc4UHNS?=
 =?utf-8?B?NFVyaXh1Z3pwcFQ2bzNZTERxcFlRQ2dtbUlwWnY0NHVZVEV5OVlVdWwxMzlU?=
 =?utf-8?B?MW1WOWlJdTkzYnZFdGROUTN0WTh0RUtMZ05WYjVqWng4WDMzRnYzOUQ0RUpY?=
 =?utf-8?B?N0JFTmFRcGo4WlRvaFlFajlZM3ZlT2dvRGVUR2NaTDlMdUNCcHZBbXBRWS9p?=
 =?utf-8?B?c2o0V3pvL05FSzYwZlQ5OEJ4OHlLNjdGUDRUR25abWdibGlVWEI4eTRoYS9j?=
 =?utf-8?B?NXZrbGdjV2R3SVR6WkJMY0RsNDBPdVU3RGptS1VjZVZ4SHdJbWhxWHEzUjM2?=
 =?utf-8?B?ME9mQXNjUWQ4MHFlTUVmUjdrS2REUHozR2ZTWWdDVTRiRGNvS2V6NWp5MHJC?=
 =?utf-8?B?SWVXcUVBUkNMOEFMeVZId3JTZWk2VHVQd1Y0cXUwdFpwWEFVR0FzUkNrZEtz?=
 =?utf-8?B?YlN5QjR1WFBQMVo2cDVvR2VWYXlsSHk0VWJ4SWRXRDBkR2RwWUhxWVUwdVdh?=
 =?utf-8?B?b3BpVnZXVW94OUR3NEdyQ01lcS9VTlZDb0M2M1p2ZU9EZDRZL3BlQ1NnY1Jm?=
 =?utf-8?B?MnFuNm9WbW5uM1Azc1YzVHRLRjVlWlFXZWZ4ZjUybE1ibEhHZ2Z2clBHODl6?=
 =?utf-8?B?MzFWeTByMkFHa09xdUxydXJoaUl1ZWs4MnRWeUJxWkRhVDFUSzJHQ003QWRE?=
 =?utf-8?B?bndHWnJJTGU3U0xNbWhVeHJqTFgvQmlpamtlcy9wSXVMRkR5YzJ6YTJaVkI1?=
 =?utf-8?B?clJrUjFJMEUzcEhzdEY0cDVkQTIrZVdvMnpaUzdTN2FOOURlNEYyZ3pKTFIz?=
 =?utf-8?B?T2YvaDRaK090QzRtLzhCVDI3UGhkRC8yblZ1cTVkaGN4dDJzVTE2aHBzSE92?=
 =?utf-8?B?bUhtc1NJTTBTWUVhdDVueDlQYkJLSy9Kbnd0VmFrTWxKUFhRTXRsOCtEckdr?=
 =?utf-8?B?TWNNQUdUYlBKQzZYVldJSlNZRlJKWUpxZGpwK2NvRnN5cFFlZG44WitxTkQ3?=
 =?utf-8?B?N291bTgrTkhiMHdkUURrRGVvQ01oQkNpU2FKaUMxR0UxNUJUT2xnNFB0MWlY?=
 =?utf-8?B?TnowMkRrK3M1MmNyRkNJVlhUNjdkeXlWeDVWcDc0YWxZNmdMZmI4WXEyaXVv?=
 =?utf-8?B?cTJIdzZRam4zK3pPVnl3S290b2RrR2c4YnkvQWNGeHpvdTFDUm0yZ2hXTmdK?=
 =?utf-8?B?OHpFNDFDMzdXYThhNFNKWWpEQ3RXSmNQRExDd2E4dDd6RW0vTEZjdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e5d920-1d7a-488c-558f-08de999074c0
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 19:11:24.7653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g421Ys4sjizf5GCtnpxJ4BUZEVrlnfmyvIl5k786ORVl4EqbNGmit8oqe+vBV6N1h/BjrGcUpXjj751ShmtygQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=nathanc@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 4/11/2026 5:45 AM, Cédric Le Goater wrote:
> On 4/11/26 03:52, Nathan Chen wrote:
>>
>> Hi Cédric,
>> On 4/10/2026 2:09 PM, Cédric Le Goater wrote:
>>> Hello Nathan,
>>>
>>> On 4/1/26 03:02, Nathan Chen wrote:
>>>> From: Nathan Chen <nathanc@nvidia.com>
>>>>
>>>> Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
>>>> extended capability in config space but we should not expose it 
>>>> (ats=off,
>>>> or ats=auto and kernel reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), 
>>>> mask
>>>> the capability so the guest does not see it.
>>>>
>>>> This aligns with the kernel's per-device effective ATS reporting and
>>>> allows omitting ATS capability when the vIOMMU has ats=off.
>>>>
>>>> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>>> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
>>>
>>> This looks like a standalone VFIO change that could be sent 
>>> independently.
>>> Could you please rebase on vfio-next [*] ? There are a few conflicting
>>> changes in this branch.
>>>
>>> [*] https://github.com/legoater/qemu/commits/vfio-next
>>>
>>> You will need to add a compat machine property too. This is a guest- 
>>> visible
>>> ABI change. A separate patch would be preferred.
>>>
>> Yes, I will separate this out and rebase on vfio-next, with the compat 
>> machine property added.
>>
>>>> ---
>>>>   backends/iommufd.c                 | 15 +++++++
>>>>   hw/vfio/pci.c                      | 63 ++++++++++++++++++++++++++ 
>>>> ++++
>>>>   hw/vfio/pci.h                      |  1 +
>>>>   include/system/host_iommu_device.h | 10 +++++
>>>>   4 files changed, 89 insertions(+)
>>>>
>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>> index e1fee16acf..52cb060454 100644
>>>> --- a/backends/iommufd.c
>>>> +++ b/backends/iommufd.c
>>>> @@ -22,6 +22,13 @@
>>>>   #include "hw/vfio/vfio-device.h"
>>>>   #include <sys/ioctl.h>
>>>>   #include <linux/iommufd.h>
>>>> +/*
>>>> + * Until kernel UAPI is synced via scripts;
>>>> + * matches include/uapi/linux/iommufd.h
>>>> + */
>>>> +#ifndef IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
>>>> +#define IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED (1 << 3)
>>>> +#endif
>>>
>>> This definition is introduced by :
>>>
>>> https://lore.kernel.org/all/20260303150348.233997-1- 
>>> skolothumtho@nvidia.com/
>>>
>>> It should reach Linux v7.1 since it is in linux-next. Anyhow, until 
>>> then,
>>> please isolate this change in a temporary patch updating linux-headers/
>>>
>> Ok, I will separate it out.
>>>>   static const char *iommufd_fd_name(IOMMUFDBackend *be)
>>>>   {
>>>> @@ -573,6 +580,13 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice 
>>>> *hiod, int cap, Error **errp)
>>>>       }
>>>>   }
>>>> +static bool hiod_iommufd_support_ats(HostIOMMUDevice *hiod)
>>>> +{
>>>> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
>>>> +
>>>> +    return !(caps->hw_caps & IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED);
>>>> +}
>>>> +
>>>>   static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
>>>>                                           PasidInfo *pasid_info)
>>>>   {
>>>> @@ -595,6 +609,7 @@ static void hiod_iommufd_class_init(ObjectClass 
>>>> *oc, const void *data)
>>>>       hioc->get_cap = hiod_iommufd_get_cap;
>>>>       hioc->get_pasid_info = hiod_iommufd_get_pasid_info;
>>>> +    hioc->support_ats = hiod_iommufd_support_ats;
>>>>   };
>>>>   static const TypeInfo types[] = {
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index 1945751ffd..2d408e1d9a 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -49,6 +49,10 @@
>>>>   #include "system/iommufd.h"
>>>>   #include "vfio-migration-internal.h"
>>>>   #include "vfio-helpers.h"
>>>> +#ifdef CONFIG_IOMMUFD
>>>> +#include "system/host_iommu_device.h"
>>>> +#include "linux/iommufd.h"
>>>> +#endif
>>> These includes are not necessary.
>> Got it, I will remove these. I see that system/host_iommu_device.h is 
>> included in system/iommufd.h already. And linux/iommufd.h was leftover 
>> from a previous revision.
>>
>>>
>>>>   /* Protected by BQL */
>>>>   static KVMRouteChange vfio_route_change;
>>>> @@ -2550,10 +2554,53 @@ static bool 
>>>> vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
>>>>       return true;
>>>>   }
>>>> +/*
>>>> + * Determine whether ATS capability should be advertised for @vdev, 
>>>> based on
>>>> + * whether it was enabled on the command line and whether it is 
>>>> supported
>>>> + * according to the kernel's IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED bit.
>>>> + *
>>>> + * Store whether ATS capability should be advertised in @ats_need.
>>>> + *
>>>> + * Return false if kernel enables IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
>>>> + * and ATS is effectively unsupported.
>>>> + */
>>>> +static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
>>>> +                                                 bool *ats_need, 
>>>> Error **errp)
>>>
>>> May be rename 'ats_need' to 'ats' or 'ats_needed'
>>>
>> Ok, I will rename this to ats_needed.
>>>> +{
>>>> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
>>>> +    HostIOMMUDeviceClass *hiodc;
>>>> +    bool ats_supported;
>>>> +
>>>> +    if (vdev->ats == ON_OFF_AUTO_OFF) {
>>>> +        *ats_need = false;
>>>> +        return true;
>>>> +    }
>>>> +
>>>> +    *ats_need = true;
>>>> +    if (!hiod) {
>>>> +        return true;
>>>> +    }
>>>> +    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>>> +    if (!hiodc || !hiodc->support_ats) {
>>>> +        return true;
>>>> +    }
>>>> +
>>>> +    ats_supported = hiodc->support_ats(hiod);
>>>> +    if (vdev->ats == ON_OFF_AUTO_ON && !ats_supported) {
>>>> +        error_setg(errp, "vfio: ATS requested but not supported by 
>>>> kernel");
>>>
>>> hmm, I wonder if we shouldn't fail to realize the device and stop the VM
>>> in this case (ats requested + no support).
>> Agreed. I can move the vfio_pci_ats_requested_and_supported() call to 
>> vfio_pci_add_capabilities() so we can propagate the Error **, and then 
>> pass ats_needed as a new input arg to vfio_add_ext_cap. Would that be 
>> alright?
>>>
>>>> +        *ats_need = false;
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    *ats_need = ats_supported;
>>>> +    return true;
>>>> +}
>>>> +
>>>>   static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>>>>   {
>>>>       PCIDevice *pdev = PCI_DEVICE(vdev);
>>>>       bool pasid_cap_added = false;
>>>> +    bool ats_needed = false;
>>>>       Error *err = NULL;
>>>>       uint32_t header;
>>>>       uint16_t cap_id, next, size;
>>>> @@ -2603,6 +2650,11 @@ static void vfio_add_ext_cap(VFIOPCIDevice 
>>>> *vdev)
>>>>       pci_set_long(pdev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
>>>>       pci_set_long(vdev->emulated_config_bits + 
>>>> PCI_CONFIG_SPACE_SIZE, ~0);
>>>> +    if (!vfio_pci_ats_requested_and_supported(vdev, &ats_needed, 
>>>> &err)) {
>>>> +        error_report_err(err);
>>>> +       err = NULL;
>>>
>>> indent error
>>>
>> Thanks, will fix this.
>>>> +    }
>>>> +
>>>>       for (next = PCI_CONFIG_SPACE_SIZE; next;
>>>>            next = PCI_EXT_CAP_NEXT(pci_get_long(config + next))) {
>>>>           header = pci_get_long(config + next);
>>>> @@ -2640,6 +2692,16 @@ static void vfio_add_ext_cap(VFIOPCIDevice 
>>>> *vdev)
>>>>           case PCI_EXT_CAP_ID_PASID:
>>>>               pasid_cap_added = true;
>>>>               /* fallthrough */
>>>
>>> This change is coupling the PASID and ATS capabilities. Is this 
>>> intended ?
>>>
>> This was not intentional, I will add a pcie_add_capability() call and 
>> break for the PASID case.
>>>
>>>> +        case PCI_EXT_CAP_ID_ATS:
>>>> +            /*
>>>> +             * If ATS is requested and supported according to the 
>>>> kernel, add
>>>> +             * the ATS capability. If not supported according to 
>>>> the kernel or
>>>> +             * disabled on the qemu command line, omit the ATS cap.
>>>> +             */
>>>> +            if (ats_needed) {
>>>> +                pcie_add_capability(pdev, cap_id, cap_ver, next, 
>>>> size);
>>>> +            }
>>>> +            break;
>>>>           default:
>>>>               pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>>>>           }
>>>> @@ -3819,6 +3881,7 @@ static const Property vfio_pci_properties[] = {
>>>>   #ifdef CONFIG_IOMMUFD
>>>>       DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
>>>>                        TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
>>>> +    DEFINE_PROP_ON_OFF_AUTO("ats", VFIOPCIDevice, ats, 
>>>> ON_OFF_AUTO_AUTO),
>>>
>>> conflicts with vfio-next
>>>
>> Ok, will take a look and rebase on vfio-next.
> 
> when you rebase, please put the "ats" property at the end of the list
> and update accordingly vfio_pci_class_init().
Ok, I will keep this in mind, thanks!

Nathan

