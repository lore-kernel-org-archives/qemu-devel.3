Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D24BF459FC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBH3p-00067M-TK; Fri, 10 Apr 2026 14:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBH3m-00066s-CE; Fri, 10 Apr 2026 14:58:30 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBH3j-00014G-78; Fri, 10 Apr 2026 14:58:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dO8YH22myF6gloP2BRnuueZFBee1WA5dZDKI777S5nC5QRAxc1g+yORNYQKhEept9i9PlQicMClPBzlfpLPe3x2rxVl0k67HrW698xbK9jtreJBR4Es6Wt87DnxQulLaToIiVc4MX65Tn53DY9BZtrjjlRLmXW9mNTnH5fWJXvZaZd10zJSbCVRZKSrWvJkCXFL/sudO86Jjq+kLZYQRVJLGZGYppaRe9AnGAawB+0lnywELA+tOXcnnuPUBH0aI0R2e+A2qZZWBcN7+WhVMms9gfC4SuEgq2FlHyUtkX/vvR8fpifWrJWWwaZ9Ts4bSrF3BNJYtdWJ5GsUaS7CokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW3VhmxhrGOaHGtjKvXmiv5KSYfmHjH2ysPgScqXibQ=;
 b=HMkrpwE94L9nMQGEn1+zIhP5/fuO396DF9fojM6T2oRt/wcSMaRipHRsd+/Q609JrE+m4R011XODvw8IDGgYY47Dkfsq0t/PiMOuJJ2eRbUm1a1F/Om8f0Gje9VIglme+IevXx4hB/IGWe4c1AJy660/GWgXZhjf1diuGc349woeq8dH7d6D6roloHfWC8ZAlquTNZpykKwOSrzqXmoqp3C1zSZWAST9Glx1IPRp4335GF/6jLW3oXutt15TarZTqWuHxRYGK2SVNgkRNmc27ytynQpZfI4AP9vFaGwoGWNb6oA9Kx/oQhhL8tVepSaoTQYGuytweOb2aYwC2ozjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW3VhmxhrGOaHGtjKvXmiv5KSYfmHjH2ysPgScqXibQ=;
 b=VaWAVtqg5Oohs/rJrpjfqMZxMctBuM+GxCUSqwvJZEJnsBscpjHjh6biI+WhlmOAByQirz8ZT9LNOwsJVYWIxu1q1O4O3u9d6H2tApXarS+0UHO+GLJKtMypshUwSR0AiGiK3PUYT4qeCodTqjRdCsCkPV1hYubq7ScP8pJBqz0UYJMW8/XDxSKSuV5aa4MCsT9ci0CntX/j6sVliJVTkiKphmTyOIlmK8RoL0eSILRdKA7jskB9UPobFrPSioNTKmi9UV9KzNC2+4U3tSzXowu0y4Lk0pvz4JCprtZIMYSR2k71i6O4RzPu96FZLhbkTQseuPba0eaE3KyWabwoIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Fri, 10 Apr 2026 18:58:20 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 18:58:20 +0000
Message-ID: <78bf2ef7-988f-4e5d-a219-c506798e8727@nvidia.com>
Date: Fri, 10 Apr 2026 11:58:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] hw/arm/smmuv3-accel: Implement "auto" value for
 "ril"
To: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-6-nathanc@nvidia.com>
 <d4bd87ee-caaf-497e-9e4a-90051868d9a9@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <d4bd87ee-caaf-497e-9e4a-90051868d9a9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: b00b1e31-c8f4-44d6-1636-08de973321c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: WpI7EywOY6P7cTFGdxb2GKpHCGmojmVKYacUKh4PMrhHfLoFOdhon6C8zyF9q0rIgDPdEckELTokuOwK9nk9BNqb3PwMqwe7IGk8/2LBwbOU8W3A43I49BWzwuILFGs6G1DC7gsjTJcaoNN3wxyiGovo2hAe69kBPCrDuzC+Z4BwIgwMM+mCcyAq0NUawPt9XzMmud+Bdgp6MH6QdCkNBJuIrTBonhtUmy+ReOJVWWea6ROt7yHItVFxH5Djvc0C5g7KG9o77nosIeGmu+0tzjPztK3JrXTtfUBjrb1VAgiMju0o+jPUfMMZXmVPMizZ6+K85+HJavbAY0JBPQgopDRj36K5SNTPyfrpuBwUavoK19gcvvQO398dud9fHAWYeG5aCwi2HOkNeAX8I/3T/pXsnIDivzsPClYANT142+cLJBSsK9wwL5sOCrWJGrqy4zEghSESd5jwxPNBYyEyGrAiZ+tRaStSF29pDptCWKa7zi1P55Teiv5yNW1j8KZbDDc7S0I+1CfxrRRlsUJ8FuTtuc8vGLqMkC62kVM0IMziqCwVfd9Ne9zmYwBpdkhfOI/JAsjPpY053Vl2QxO9iLmPlTMe8oHbnzPhoUVVnPPKS0WdkTfPVPeBCAvQh8jiIfOB6kpTgDaCx8yQOgEAJ1ghUEeUnDCCB01MkMMtHj+5jv3rwHiMExJHtYH2KLavAwzfq6eYMWCDoCXnYbYAWt4V9Huw1otuoaaG2JEkb9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1NkNHN4T0xVeVJ6bUExK0V5L0dWME1WaENVeG1CMzQzNlpZSDhWeUIyTVJI?=
 =?utf-8?B?amZxeWovb1VEc1pRQmc0SEhiZHhNMzd0VWRzTWdpZjBCRjVTY21BK0hPQ3V5?=
 =?utf-8?B?VDFuRjdLYk5tMnI5SE1DRC9USnBwSmxUQWlDeVZHOHZnUjBjY1VSbG0ybjVa?=
 =?utf-8?B?TGpiRnBqZ01XcUh1YUNPek9rTEVROTdJdEpUK0pLTlBjTnNJWTFQOHlBS20r?=
 =?utf-8?B?Ky9TYmFVV1BDV2xPbUE0OUd1RUUwWk9QRUc3OWNvMmFxNEpQRTNETVJzVFhD?=
 =?utf-8?B?MUFLaUFPdFM0OVBMdkJ0blZEL3VJM0U4dVdLd0tvSzlvY2ZzRTRwK3JqNkFT?=
 =?utf-8?B?ekV2U2xzbkZKUVhYTGJxcDkxd2FJcyt5ZkgzUzV0aW1pMlJGTjNLVktWTlhr?=
 =?utf-8?B?ZkI2N1dSczBQYzRablNycGhLOTJ0eUUvck9aSmVMTUtQc3V1WkZoTjgvR1oz?=
 =?utf-8?B?TnFGNE1vaUllK01xN1RsbjNUUDh1UDdHaitaMDJTRkUwbEh4M0l2MHlQWitX?=
 =?utf-8?B?S2o0K0JJTzF6cWszTzAweG8weGsrTGtpZlVtMEYrYU9haVY0bFlVVnNieVIv?=
 =?utf-8?B?a3JSRHY4b0prUGREcC9IWFhlNC94VXI2TElCT0hLQWRsb1BiQ05yQWFzZTBj?=
 =?utf-8?B?SjZGUEpRZU8wNUtXbld5RVhFNkFEclRxbEx2bzl6ZE5QVW9RU2VYN21QQVkx?=
 =?utf-8?B?MEFyOHJ5NGR5YUVNSXhHYTFKcGdLb25UWCtvQlhvdkNpNndqSW9VM2Jkb2dR?=
 =?utf-8?B?cGpTdFBMYk9GVnBLVlVweDdJTjh2MGhta09NZ05QbUhrRXRpaXFiRFFBazlK?=
 =?utf-8?B?RkpGVjBzTWh6YklVNHpydm55b0h3NGdMekZYTG8vbTVYYXM5ZU5UekxCMjA3?=
 =?utf-8?B?UklpS1ZLZEo5ZHVEZTFUazhIdGVrSkFHazlLSGFsbnROcmRGbUdzR1dpSzg2?=
 =?utf-8?B?dzNOaWdKaUVvbVpXNmlDRmswMGlFREluTHAwUVc2QnZOejdFUFdQKzdEL0pQ?=
 =?utf-8?B?UGhDeC90bTNydURMUk9oR0dYSTBNQ2dKMWR5bG50MFltZFN3TXZVREplZER6?=
 =?utf-8?B?c1IvbWRabjNtV09xRFROQjJQTWkzOFpPd2h5bW9EMjVSVEhzbXJNUXExTi9Q?=
 =?utf-8?B?NFg2QUhwNU5rVHdHeTFTNUhEczc3THZRbXFBblhOc1hSbEJ3d081dnYwL2d3?=
 =?utf-8?B?Z1RpOVFpUnF0c0lpeVlVZk0rS0JHSkJUdEF2amtrOENiTGFyMDlQZi9Ra2RY?=
 =?utf-8?B?WHpYREtTemUrNEs4eW9WU1B2U0pycDhSTE9NcmFvYzcySndMMTg5SUhjKzFQ?=
 =?utf-8?B?UTVJMDRxZUF5ZXJvdFN0K3RudlpVZFBJL0dma0lJRWFla2xiTEN1WHdYckJo?=
 =?utf-8?B?WkRNYlBPSHJLeUxCSUU1eGlxV0U5MU1reUM1K0JZVVNEQlFUNGtGb2lIM1NK?=
 =?utf-8?B?bkVFRkdJKzdLSzhRbEtHNkFGOWtBR1dUYUZkQnZvTDROZWdpYUMwMEo0Q0Zv?=
 =?utf-8?B?UXB4djJuZTZkbGxLY3I0RDJnUGltajNVK014dEhLYnFHYUMzd3Z1VXZ4NnE1?=
 =?utf-8?B?b3RWZHdMUHZ3eGxUMnFuZFhsSDFXbXFHNkVtTUVFOStNRGxPVzRlbkxrdW1C?=
 =?utf-8?B?LzRhUWdDeHQ5dkp2MlZoQm9Sa0xubUo1aWFuWmczMmVEK0tkUmtFeWoxL1Nr?=
 =?utf-8?B?N2RlSXJ4emZmUU0venBqZE11Z3F1Z2NtaDZ0aXZ3ZVhYUWtqSnZTS01tTVRw?=
 =?utf-8?B?MGJPNGlSbSsrQkVqRFMwWHJSbS9TVDRDZFpDREYzS0k5ZTh2VFYwc3Y0WFJW?=
 =?utf-8?B?cThHQXJmVWt3Z293WXNteHBXOUYreDNNVDd1TTdIQ1Zmbnk3WjA0ckRpdnRj?=
 =?utf-8?B?QWRYYjFaRlVyTHcyVy93bTM5ajliU2JHUFJYbUVkZW1IOXhtWVZaUGNhL2Za?=
 =?utf-8?B?SHBJNnkzNmIvUVJZNFNiQjRac1dDWHR2SlhtRU1ZbjZmcEtBNTlucXhMeEoz?=
 =?utf-8?B?TGplbDhhUm01SU9KcEtZMXRHT1J5SG9oUXF1N3o5QVZ4c0NDN1dBTmtIZEdm?=
 =?utf-8?B?dEE0eWVNaGR4WkhOZEhJcE9wTVNDbzFiOVlHcjNDY3NycC85Vmg1cnN6TE1N?=
 =?utf-8?B?ZGhhSmJYaUIzVTJ4WDlFYVFtMTZrQytwL0xYQzR4eE84SU9MQnlCMmlhak0v?=
 =?utf-8?B?NGIvdDJnSzNTZ2RneGVQRU14OUc5WlRqS3pQRDFNdVpTRk9sejQ2UlFsTXcv?=
 =?utf-8?B?N2liTVo2MmhyUlYzMUJNdnZ6bmZ6OFBIOWlMM1NUcHBSOFRTY1JYaW9xOTVX?=
 =?utf-8?B?RTVVc281QWdva3E0TzEvOHg1YTkrc2RabGgyWTV1MGg1a1lRY2FaUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00b1e31-c8f4-44d6-1636-08de973321c4
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 18:58:20.0219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nx8CIOKpRDWuV5uwrx+MvtViBrvBcHpbrBSe+PtTxU2xYpRyM99oxFTSU1qzluqhpSFf23nN6lGaNMREycgPfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=nathanc@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 4/10/2026 12:47 AM, Eric Auger wrote:
> 
> On 4/1/26 3:02 AM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Allow accelerated SMMUv3 Range Invalidation support property to be
>> derived from host IOMMU capabilities. Derive host values using
>> IOMMU_GET_HW_INFO, retrieving RIL capability from IDR3.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c | 9 ++++++++-
>>   hw/arm/smmuv3.c       | 7 +------
>>   2 files changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index a835c8f220..9e7ec6a930 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -50,6 +50,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
>>                                  FIELD_EX32(info->idr[0], IDR0, ATS));
>>       }
>>   
>> +    /* Update RIL if auto from info */
> not sure that kind of comment is really useful.
I'll remove it for these properties and add some more details to the 
comment above about "Return if no auto for any or finalised already".

>> +    if (s->ril == ON_OFF_AUTO_AUTO) {
>> +        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL,
>> +                               FIELD_EX32(info->idr[3], IDR3, RIL));
>> +    }
>> +
>>       accel->auto_finalised = true;
>>   }
>>   
>> @@ -945,7 +951,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>>       bs->iommu_ops = &smmuv3_accel_ops;
>>       smmuv3_accel_as_init(s);
>>   
>> -    if (s->ats == ON_OFF_AUTO_AUTO) {
>> +    if (s->ats == ON_OFF_AUTO_AUTO ||
>> +        s->ril == ON_OFF_AUTO_AUTO) {
>>           s->s_accel->auto_mode = true;
>>       }
>>   }
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index f353865187..a2d2f0e3bc 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1973,10 +1973,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>       }
>>   #endif
>>   
>> -    if (s->ril == ON_OFF_AUTO_AUTO) {
>> -        error_setg(errp, "ril auto mode is not supported");
>> -        return false;
>> -    }
>>       if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
>>           error_setg(errp, "ssidsize auto mode is not supported");
>>           return false;
>> @@ -2188,8 +2184,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>>           "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
>>           "configured in nested mode for vfio-pci dev assignment");
>>       object_class_property_set_description(klass, "ril",
>> -        "Disable range invalidation support (for accel=on). ril=auto "
>> -        "is not supported.");
>> +        "Disable range invalidation support (for accel=on).");
> same comment as before. Suggesting "Set RIL value. Valid values ..."
> + qemu-options.hx updates.
Yes, will update for RIL and the other values as well.

Thanks,
Nathan

