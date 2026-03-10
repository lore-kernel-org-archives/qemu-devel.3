Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881ADFD4F0F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 17:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w018q-0007w9-VQ; Tue, 10 Mar 2026 13:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w018i-0007vq-Gt; Tue, 10 Mar 2026 13:45:04 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w018e-0002ix-Jr; Tue, 10 Mar 2026 13:45:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoTQlILVX4VsqPFeabEQLkV1RLgF2LGGgWAIFXUD/QlqJticS83xTJliKdg4YAO3QvtwB01XKD5As2D5HmStouGHn+tElgOOLbZ0fAU+sECDTch+P3jqnQDhq+IxJlzLriyQFj7/GaEz1PIYsLP5FOQYU9Pj0IxGnLVoLHtXTZD+NzAeDSpIaDCLZaa+sGYnd8HmPHuqaeGzsH+zgP+fyceoMdpRzcDDZtfWIthPb9BnU2jMpRT8cN2qqJYWNzpkbAGvmIcxrI8kknuReFbFgG/JhC1mKRuadQVCOz7I57SCByb8oVeeeTOsbS2e9pqCoNMXZ7y/mo0LOhJWxv30bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KN49hLjlW7+K9fUkED41VPPMedDQDXBHmhvdw+t0iY=;
 b=PcYTeLkNCemHBfY1MhJQboChM7MYQDBA5akq8xEqkJYDXdEoVV0HF9oDYyxhCdn9jAEAubs0X9SPvWqCfrCRZQE1QLD4y8XdY4ZMvhYHbpKakQah7dzYY6szqMr7UanooPE6oPIMve7lQ73A+2thmxyt3E740YL5OtJUSh89TkVULNL+fSYWkfG7TTS0uVXNzzwLXLK5eAEVUwrmJZXQ/ZbImJDf7gs9sMOQJkQmL/OenDjUgY6ay6IpWepVri6hMO+OY0EnPRgFiz4+Ew6mOacTJiWJP6Gzh0B6kfr7X3xgHV/lhXVWdnk55JfKlCZ5trn6D/+muF1ulyyK8DuagQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KN49hLjlW7+K9fUkED41VPPMedDQDXBHmhvdw+t0iY=;
 b=aqQREti0MMFOZF0qaDsERpRJPbZ1BCSyjdq3jf+NibsCjdPKXvf2SxB8PK4BdyTZYVa7hzWGy+6wbRYX5KNWHpsap1oScvdE92Kwl+ttLkJp+iiLqqjpvWJmmNNBI2guaNN+5OY8GA2JJ0uTlBspJI92i1ueUkI3gGvWQHkiWVSaqTrLXCIVBlQb3ujNNJw8ZunG2vq//boif4Zasa1FtkCCmvRD7X484eN4KESNUkGKWrkoy7Ae9HE8QHZluBQ2uBM06bGUGJEYia0qzUdDyyZOJAqzePFv7GBTr71RkoUF6a5ZV6Oa6f5lyOq8JRXEZU9GSH8sOAtFX0GKI3iGYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 17:44:53 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 17:44:53 +0000
Message-ID: <8b19e3cc-555d-462a-aa88-46b5fd783163@nvidia.com>
Date: Tue, 10 Mar 2026 10:44:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/8] hw/arm/smmuv3-accel: Introduce _AUTO support for
 SSID size
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-7-nathanc@nvidia.com> <87bjgwno8r.fsf@pond.sub.org>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <87bjgwno8r.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:a03:338::20) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aaba512-2887-46a7-ff5b-08de7eccbc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: UgyKzefVb5q53E/kSCexWgcHzOiADMYrqgtYPfEqHMg/UhR4AOPWwavQ3pvc4BYXd4c+gsJ1aKnudHborIgehquHj15dCtXRxuwQ5AAnGIkzwwGbnkmAfiBaIReUy9FZFG47VwunHSHP6DKqpTvSS9440/I5ghRWJ4djzsdaBE8YYTk62fTdyeQ+xg6vOHBsBys2zHBX53RICv7o6Sg1p9lJD11Q/VlPKdTM4P2mukh1wzQ5tQYadUlvRa91FBcZQ/lhHFeH19SBZzfiAO3T2p3KHXyZuMF4f1IylqajzI8G4Lmj4Y2S0RvPT7mwCmEXoBKxkLpfa9UcHDzZIiRiVEbzTWiPHkxCs6NGRWLg/ji6+3fG4LQ+GAIP1EucO1NxibSKMewvCifXv96H2ey2r6EoxF9Zuk24eCfAGHXWcn9cRQuOoa3pjw8f99QX6cT/gTNatWV0cWBAGnkwfzyZhourm3ovNlAManvAoBCGh88DWVy7nZRvpLYTy3HeSUoFMeMvn5ZxmPRx2Tt0YJNRpkQajuVXoDwu1EYueJCEt6yZHStn+s5bHvDSxDd7iQXuyXM/3Dts1JwF0nCvDJjnWUzbovYvSGPr3v6DFg8WDgPZkjw6olPTr8U9p+7DKZM0xQ+VMFjy0jhwteAaPbaKKpECgJsapRnEPIACxst/NjcD59Y4YrrkUXtT9jW3Btc3afUFAkIgQph+fcJS4bfrZdjZOe1h969mp2JNMlUcz04=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3daYWxlZXRqVEp1aUV6eEpZeVZ2cFdIalNBWGVXeThCWWYxeFREVkZkU3VS?=
 =?utf-8?B?UFhhK2hWVTdTSjBuQUhUZVQ3M3BHVEJKdlNZQVdDazZGWnF1ZnRicnpyRG1k?=
 =?utf-8?B?cEFLeUYwWVNVUzlvNDBDNytzdUJRSmMwNG9TckV2ZVh1bFRKdngvV0pQeldo?=
 =?utf-8?B?ZXpnK0MramJvN2pPWVczUlNYUVlWOTVvcDg5cXA3dERSSzl1bG5LcnNDUXdV?=
 =?utf-8?B?T1M3TFljdW5DbEhQL050WjlLUytkZGVLZkU5NkR6VnBXMnVlT1JmT0gzMTNk?=
 =?utf-8?B?OVgvVG1YRk1qamwzNFZkMytIY2pTRGxxK0t4MloxQWdiNFJMczF2Nk10ZDR6?=
 =?utf-8?B?KzBjaDAwNGhNQm9VSUdHSllqWlptNjhGSm9pZG9xa21UU3BhYm9EcFdkY3dC?=
 =?utf-8?B?TGZTYlYvR3FpaEhTNjVmWERqRUxFblpjV0wreEFGU0UxemF4UnV6VWxLZmkw?=
 =?utf-8?B?VFRnVmpBandXR2wxVG5saU1la1ZvMCtBRERTWndQaVZCZ2hPT3M1V2FGQXpV?=
 =?utf-8?B?MXZiQlhOaDRMdzh6S3FLS24wTXFIcTdST0Y3TE95UElUcCtPdGk2TVhhbUha?=
 =?utf-8?B?Ui9kYXlSZE9WNEt2ZmlLVmx0d3gzTjJJbFNNUGNVQksrVEdQZXlUemRLSEl4?=
 =?utf-8?B?RURXT05SWElaanZETTBzc1paMEhMa08xWWRYc01qSkorQmQ1WXRXVzg0ZkE2?=
 =?utf-8?B?TmtabFU3M0h4TUNlSFg4eSt4bTFmbzBCU0t4eXd1ZUQ3UVEvZzVMRTBBeXBo?=
 =?utf-8?B?NVpKeGJFTDlRUS9UalNhOFBmbFQ1WkdNSjNvRHVyZFluWEZzZGVETW4zWERW?=
 =?utf-8?B?MFVFeXB3YkFpZWgweW9DRUJ3N21DS0FIeXZLQ0V2U0JZbmh2WTJuMlkrMWQ0?=
 =?utf-8?B?QzR5NE80MXIvNStaMTBFNllwVUxoTS9CaXo5azhXTVZzcHVVV3lkNURQTVZr?=
 =?utf-8?B?VzFQK2JCSzNOY0pXR1dGVWhnai9vRWQ0OHZRVGVGSDMxeTAvd1RCM3Y3Z0Vn?=
 =?utf-8?B?RjFzblBqRGNjbVE5QmQ2UmxQbXR4MHU0S1FOWnJwcndXNjRqOWZXZ2Eyazd0?=
 =?utf-8?B?Q1VydlRNM0R2OUhvY0p4aHp2SzRRcTd2TjYvbkhKTVV3eWpMU0lPV2pnZ1NW?=
 =?utf-8?B?MFFyVUIrZ1dyd0c1SkNYbzZIVGlTUmk3c28rTjVTWXZ2SE9IYndMQkVCWTRY?=
 =?utf-8?B?TDNGb1JaN1U5cW5wa2tlYTVHSEpLN2dhUE41NmRuQXROa25DbVJZSGNzbkVL?=
 =?utf-8?B?elJHeGNKTnVVUXhwNmMzWjd4bWkzZklQQWR4YnhsdTZGUUZubWl1V2I1SllS?=
 =?utf-8?B?YjFnY3p3WnJ3RkwwbmFIUVMrdFVLSlU5ek5VZlBmQ0JUV3dtcGI1YThwOUJu?=
 =?utf-8?B?bEowNmpRL1RmTWlqM3pFb0lqdlFMZ1lFcS9IekwrVklpTjR4cDF5dk5TQVFX?=
 =?utf-8?B?K1ZQRmYzZDRpcStCZzNBNlJwZWNTWjRMSzRLVjJ2dklZUXFMT2x5dElaSkdp?=
 =?utf-8?B?aWt5S2ZiYXJpaW40VXh2L2dJS1RxWEowZkxTV0t5cGcvSG1QU1IwVjdZZ21H?=
 =?utf-8?B?ZzRLRGJTTHYrZlA2L1ltcTdjWmZ3Y29lRndBRUhzRFhHQTFFOWRsblU3aXNV?=
 =?utf-8?B?WHpvSi9LVll6YVhvS2ZhTGxwQ2EyMUEyQVEwSkYxYmtGRG50bEJ6RFo0KzBF?=
 =?utf-8?B?U2NibEF3OUJUc2QrNkhVYXR5SHZVenhaSGNyUEJJa2xkTHRjd3ZmSzFDTVJq?=
 =?utf-8?B?UVdFVmcyWVpzV1dkcFdkUWU5bUxlMEgyaytsaTVpODhCNTAwWDEzU2kvZmR2?=
 =?utf-8?B?clpTajVCYzVHTURVaWVkbWFtRkpta29qYnJPL2sxT3VoVnREMnV1dG9wQUps?=
 =?utf-8?B?YTVkc3hKRU9SZ0JpWkhkUDBXTmxkZTRCdjd3TXNONnQxMDhWRU1SZUtKY1Rl?=
 =?utf-8?B?SWo5ZWhkU3k4MXVKc0lBZ20ydUg4RUtmaEFxOUE2ZGsxNVpNWDBlS1YzbndO?=
 =?utf-8?B?WjZORmlvNjloS1pqNFF3bzJwYlNRM2pMZlJiMm5oWjZiT28zV0VPUjdUWkpi?=
 =?utf-8?B?NjFuLzZiZk9sU2hmR2dvd3NkOGoyN1JWck1JNWVibmV3K1lYQjdsR3l6M3FQ?=
 =?utf-8?B?RWYzUDlzYVNGdHJYMW1Tdi9Qa3BnaWljbk5UV0YvZjhORnJXYTZSaXViVjdW?=
 =?utf-8?B?cFFLYUlVYmJ2K1g3dnNLdlBKdjNNU1FWdEloOWEzUFRLblhneFJocmMrOHgy?=
 =?utf-8?B?TkNDb0JBa1NEdEEyNUhWaTZTYlRKTDM3RTl3Wm8rSEpJMjVyblpOdytJMlRi?=
 =?utf-8?B?U3JoZDFJOFpvejFIeDQ3azhjRVE5TUpjUWNCTFp5cmdoZEx1UHJTQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aaba512-2887-46a7-ff5b-08de7eccbc6a
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 17:44:53.3994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvFI5UApTuM6rJ1kgNveOJ0V69z8CebE7UzP4G5zu1/IBpGuxgLN+YdzamvykcNu2mvh7lvjSxTKgK/JCYN+BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nathanc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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



On 3/10/2026 12:21 AM, Markus Armbruster wrote:
> Nathan Chen<nathanc@nvidia.com> writes:
> 
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Allow accelerated SMMUv3 SSID size property to be derived from host
>> IOMMU capabilities. Derive host values using IOMMU_GET_HW_INFO,
>> retrieving SSID size from IDR1.
>>
>> Set the default ssidsize value to auto. The default SSID size used
>> to be 0, but we change it to match what the host IOMMU properties
>> report so that users do not have to introspect host IDR1 for the
>> Substream ID support. When the auto SSID size is resolved to a
>> non-zero value, PASID capability is advertised to the vIOMMU and
>> accelerated use cases such as Shared Virtual Addressing (SVA) are
>> supported.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c   | 30 +++++++++++++++++++++++++++---
>>   hw/arm/smmuv3.c         | 16 ++++++----------
>>   include/hw/arm/smmuv3.h |  3 ++-
>>   3 files changed, 35 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 02e3f7a9f3..bd27b0da7c 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -64,6 +64,13 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
>>                                  FIELD_EX32(info->idr[3], IDR3, RIL));
>>       }
>>   
>> +    /* Update SSIDSIZE if auto from info */
>> +    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
>> +        /* Store for get_viommu_flags() to determine PASID support */
>> +        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
>> +                               FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
>> +    }
>> +
>>       accel->auto_finalised = true;
>>   }
>>   
>> @@ -839,7 +846,10 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
>>       SMMUState *bs = opaque;
>>       SMMUv3State *s = ARM_SMMUV3(bs);
>>   
>> -    if (s->ssidsize) {
>> +    if ((s->ssidsize != SSID_SIZE_MODE_0 &&
>> +         s->ssidsize != SSID_SIZE_MODE_AUTO) ||
>> +        (s->ssidsize == SSID_SIZE_MODE_AUTO &&
>> +         FIELD_EX32(s->idr[1], IDR1, SSIDSIZE))) {
>>           flags |= VIOMMU_FLAG_PASID_SUPPORTED;
>>       }
>>       return flags;
>> @@ -854,6 +864,16 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>>       .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
>>   };
>>   
>> +static uint8_t ssidsize_mode_to_value(SsidSizeMode mode)
>> +{
>> +    /* SSID_SIZE_MODE_0 = 1, SSID_SIZE_MODE_1 = 2, etc. */
>> +    /* SSID_SIZE_MODE_AUTO = 0 */
>> +    if (mode == SSID_SIZE_MODE_AUTO) {
>> +        return 0;
>> +    }
>> +    return mode - 1;  /* Enum values are offset by 1 from actual values */
> This relies on how the enum values are ordered in the schema, and on how
> the QAPI generator encodes enums.  The latter is fine: we document it in
> docs/devel/qapi-code-gen.rst section "Enumeration types".  The former is
> worth a non-doc comment in the schema, like this:
> 
>     { 'enum': 'SsidSizeMode',
>       'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
>                 '10', '11', '12', '13', '14', '15', '16', '17', '18',
>                 '19', '20' ] } # order matters, see ssid_size_mode_auto()
> 
> 

I see, I will include a comment in the schema to make this clear. Thanks!

>> +}
>> +
>>   void smmuv3_accel_idr_override(SMMUv3State *s)
>>   {
>>       if (!s->accel) {
>> @@ -886,7 +906,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>>        * By default QEMU SMMUv3 has no SubstreamID support. Update IDR1 if user
>>        * has enabled it.
>>        */
>> -    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, s->ssidsize);
>> +    if (s->ssidsize != SSID_SIZE_MODE_AUTO) {
>> +        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
>> +                               ssidsize_mode_to_value(s->ssidsize));
>> +    }
>>   }
>>   
>>   /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
>> @@ -955,7 +978,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>>       smmuv3_accel_as_init(s);
>>   
>>       if (s->ats == ON_OFF_AUTO_AUTO ||
>> -        s->ril == ON_OFF_AUTO_AUTO) {
>> +        s->ril == ON_OFF_AUTO_AUTO ||
>> +        s->ssidsize == SSID_SIZE_MODE_AUTO) {
>>           s->s_accel->auto_mode = true;
>>       }
>>   }
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 7791e5294d..bc03353759 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -20,6 +20,7 @@
>>   #include "qemu/bitops.h"
>>   #include "hw/core/irq.h"
>>   #include "hw/core/sysbus.h"
>> +#include "hw/core/qdev-properties-system.h"
>>   #include "migration/blocker.h"
>>   #include "migration/vmstate.h"
>>   #include "hw/core/qdev-properties.h"
>> @@ -626,7 +627,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>>       }
>>   
>>       /* Multiple context descriptors require SubstreamID support */
>> -    if (!s->ssidsize && STE_S1CDMAX(ste) != 0) {
>> +    if (s->ssidsize == SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) != 0) {
>>           qemu_log_mask(LOG_UNIMP,
>>                   "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
>>                   "Configure ssidsize > 0 (requires accel=on)\n");
>> @@ -1985,7 +1986,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>               error_setg(errp, "OAS must be 44 bits when accel=off");
>>               return false;
>>           }
>> -        if (s->ssidsize) {
>> +        if (s->ssidsize > SSID_SIZE_MODE_0) {
>>               error_setg(errp, "ssidsize can only be set if accel=on");
>>               return false;
>>           }
>> @@ -2003,11 +2004,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>           error_setg(errp, "OAS can only be set to 44 or 48 bits");
>>           return false;
>>       }
>> -    if (s->ssidsize > SMMU_SSID_MAX_BITS) {
>> -        error_setg(errp, "ssidsize must be in the range 0 to %d",
>> -                   SMMU_SSID_MAX_BITS);
>> -        return false;
>> -    }
>>   
>>       return true;
>>   }
>> @@ -2136,7 +2132,8 @@ static const Property smmuv3_properties[] = {
>>       DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
>>       DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
>>       DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>> -    DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
>> +    DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
>> +                              SSID_SIZE_MODE_AUTO),
> Is property "ssidsize" accessible via QMP or JSON command line?  If yes,
> this is an incompatible change: JSON integer values no longer work.

Yes, I will update the SSID size and OAS properties to accept both 
integer and string values in the next revision.

Thanks,
Nathan

