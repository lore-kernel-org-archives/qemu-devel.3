Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0965ECD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbcVW-0000gh-LF; Mon, 22 Jun 2026 07:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbcVI-0000g0-Lv
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:07:49 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbcVE-0004ik-OG
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:07:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRwq9wlyA75k+LaqBrKI8kXNlByQvhw4ZVc14HYetLEIeIwYQkur6pLjy109/+ygPejcW5N1LvXMSirpMoH/lvGRUyOsDFreEvn/cpyAb7yTxbKETY+hGR1E3fekmrT0lgZP4+B1G+u4DUHIzXQpBxSIsDpWXHkmdwerefavPNdTP45CefL0xiKmaboiSJM22REZe6XRhwHApxCwgSGsVUhe7gFhvM9gssp57jfuJpy8K63MmVc0V3DfV71ACU0sBN+Hs8YFAlHuPPPMb9PiRhlqwbvz/lUL9jv7WQGNBncqX3dEMqwTuRwezVZpGE/YE8X4c39teIdHQy9XRKEVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVCkuEeU/4kls7WNhUw/U8yY90x+oBiY9AyNjZFnPJw=;
 b=W64UOoXeWHxFObtToeE4ypotl4EuhOqwYqrH7EYmNIm3Ddp5D0xmHwpshxu7MrMXSgAttsqwAh8U+5PkJZIWh5h7S2LUaGXWftvj0pcJ3hKREBxMbn6BjLpfFx3bOgTgFM3VhuH59CkNV8dmNRkHyDcB2i9ibmlkqvJOfNlQTbbdMiqNF7Vdh2syO9FT3Lay151T+qfHx2h9WNU0qIQYiVKJ94k52eQHsvOCNpQXo4kVl4TwpPo0mqYTlimO12qGB1ODwtIx4Bot3Z0t1Z5a2nhXC5oTeTkhmdk9ZhAtxF+lFmmO2uHfqsMwZvLwdMo483ELhuZw2/f9tG7mf7A4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVCkuEeU/4kls7WNhUw/U8yY90x+oBiY9AyNjZFnPJw=;
 b=v7WIBMpnFmvpqpEeHQBswXrcjWszbos0J/aHnVxaEiHu7LXM0rMkMVDFnRrkri0UObmRK/ckkrFOWJdMzlVSceHPvSrEMorFKPkXt2EFUsF5e09otmsUm6LkGwG1ctloChR8lmZZEWVKLq7MSZB2wjXmH0viqTlS9x8Y5+QvPVuetSt+FfQlJQlNG+WEjKENnzpfv7yY1SDIflEJweLtVkzdlWzQ48MHjeSICTItF29MQvfex9yGokiFikaEeMrHVReWmEdUHB4sJ+zj71MDL3QJVgTqLStpCTxlwEKza+P6sWpmmJgO6AtOzP/swwg5q+248iQlzzb3HMQYGzKl1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by LV3PR18MB6220.namprd18.prod.outlook.com (2603:10b6:408:278::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 11:07:40 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 11:07:38 +0000
Message-ID: <3153f768-13e0-4d84-955b-946c1596d009@axiado.com>
Date: Mon, 22 Jun 2026 19:07:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] hw/arm: ax3000-soc: Enable Axiado SD host
 controller
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20260618101249.2926976-1-kchiu@axiado.com>
 <20260618101249.2926976-6-kchiu@axiado.com>
 <41ffebd9-00fd-4a1a-a281-1e8bc475fa9f@oss.qualcomm.com>
 <8beb5c51-04f2-4e96-ae7d-a015d16b0ec3@axiado.com>
 <27203775-0a47-4758-90e5-f74cd8ef36e8@oss.qualcomm.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <27203775-0a47-4758-90e5-f74cd8ef36e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0044.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::18) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|LV3PR18MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: d0879885-3b96-4cac-8d6e-08ded04e78c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|5023799004|22082099003|18002099003|4143699003|4133799003;
X-Microsoft-Antispam-Message-Info: 77INw5yDV9jnWlqFyZEiZuw7y9rSS+wbIXWXlw0WhkOLXmUMUlJ0DpOUd/9feek+dXW9MdCFk31NO8UAUITP/HEzMjsI94JfIWRjZtXAqUKEWp8+esi1g9wQGhNI/0do76gticLTm1GgW+LaYYFWDwSYqBsNd9veT38J5y1tMyoltMii6Sv57qTw6kPmAcHp/aI4zDCej7XwrD27XnFcPXMoR+dDkGjDBJn+2azwWiCOGGZRT9FxkSXCHsLBcMEO/BbRTnjKH8jXfjqYyuxt6f5DomhYqGhmG1hkE7Zh9tlTyghb/E8LYcAMxh0ySjY8fYIOc2cryGhXtkV4pjfIA04hoRPDZYdrzGnFvoZVRZFEJlse/yG/KJHlNzCcyTELSIfsLTN86B/xiPEQ2l7KCd/uhDF3eOYK3VooevMtGlYfMXZ/ZrQwFaNvi4Gc9I53sOeF+CMwwt/UOAWc7YCSFmow+QZ6WZzA+TPoG5aJtPyUm7GbhXpd171kg46tzVbOzYQQihgTKgyJetaNawt2Gcc1kgFjSfqdWHmtxM4V9XW4rYf2oT/C+8RY7whfAIto5XD6iazwZN+QnQ/WivkMNZtQTb2U5JONIahUZzYnuPjPYlpa/C36wAtyHdln2RsENAsJIbhjeWi1oTeGk00UlYL/Dk1a1wUYjCWffwwZ9tY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(5023799004)(22082099003)(18002099003)(4143699003)(4133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0ZRblY0T2o1NjJOYnhSRnJmM2t1NEs1YmFUK3hxR3lvUnJjTzNVdm14TTU5?=
 =?utf-8?B?N1NzL2pheXpxL1JBR0V4TVFmWDkwcDlONnVIbDFOd1dwNWk3SWNqWEx0a0I1?=
 =?utf-8?B?TGc3akFNRk1vNGZtSkVGVFQwY2diTDhXSDNkaTRSbkV1ME1SNWZwOHBBa2lG?=
 =?utf-8?B?MHN0S0x5dXI5ZjBHZ0F5bmx6WkFXaW5tdkxLUUt0NGxqa0RRMDZnV2VVMkRp?=
 =?utf-8?B?NDNrdk1QWWcxVzVnZWVSaENreXNnSXl4cUhFbVZWOHZMN0owM2l1NE5BYnFM?=
 =?utf-8?B?eDAzQnlQY29NUGJMNlAyWFlEMjR6RHk2QmV5TjFuVktyVTRxOXN6T3I3S05D?=
 =?utf-8?B?N2NQWGQ5ZDRnOFJJWFNPSVp1WXVQYzJhMjc0S3BZbnJURUxyNmRPZnViSXNx?=
 =?utf-8?B?dFFhQ0JwdzIyYVJzZXVlVGJENzd3aXNIblVRbGt6RkNDZnB5c1JITlMzTXRn?=
 =?utf-8?B?ZjlIcldCdTJaZGE4WWQ5enMydXBVYjB5NHdQd3pQdU5STkkzejhOcExMdldN?=
 =?utf-8?B?OWZuT0w4UGx2cWxMUHU4b092dGs2MGVBUGdoOFg3SWVML25PU1ZKL0ZFN21r?=
 =?utf-8?B?T2lDSkFaekZwWWtucDlyM0JZOWFMUzllVjZyb1RhK1dzV0duUGY4cjI3cWtX?=
 =?utf-8?B?ek43ZzJ5SEhYZzJXbkxhY0FvekUzOTZ5UzRidzFydHZTL1hpZENZUDRDNHpL?=
 =?utf-8?B?c2JmcW8rcWw3VnZjR0hFM0w0akx2U0hYaXJvMWdkaFhtT0FBUFRORUZGZWhX?=
 =?utf-8?B?elppcmYvc3ZYSjA3aWNqNjJ1SnV5TERVa1orTWtzQkJUSGxzNis3RC9jZFRt?=
 =?utf-8?B?RlB1OXBrME53YndFOEIrN0ZSYURSZnVUY0lYRTNNcFFzcEdGNUJGZ2c0VXFZ?=
 =?utf-8?B?NkZHYzQ2L1ZUTFN4dldOeUZlNDRldU84ZU1VanNDMG5Ua3dqS2F6blEweVBT?=
 =?utf-8?B?dXZXTElxdjR2V1laMGJtQ3dHaHF2UWs3QkZWVFZLR2xDNEhPc21hK1pFdDN4?=
 =?utf-8?B?S0VBR0dWUlAyWTE2ZXQ3ck9JRDMvUzB4cE42Nm9MTG5rMWJLN3BqMEk2b2tL?=
 =?utf-8?B?V3RWNWRKRFAzT1plTVBMU21WQzA3V3FJb0w4bFZKeXRzMDVvZkNhazl4K2E0?=
 =?utf-8?B?RG1uVlJNYTE5Wk0vV3ZVNWxpUDAwdG13bnk4WDhubVRMY2VVQmlGbzVEWk9L?=
 =?utf-8?B?R3I5V0l6V2RKNzk4eDBsVHZ4RUxPS283cGhHSGlQd2lFNFFQZHdGbFJRclRv?=
 =?utf-8?B?ZUh6Uy9pdTFOS2xXUDhSc1Z1VUlvdXN2Yk5FWVNXd3piaUlOVmFIaHo3M1RZ?=
 =?utf-8?B?NkkweDdSV1ZrSWhpMkZHRXBEbVNqS2RXKzBjTFpjTy8vSGlMS0NsZzlqL3pI?=
 =?utf-8?B?Y0FUWVNjZk15Z2gzc0Z3UE92b0NTOTRoWVdsd3M1ZWg4L3VqU0tjU3d0bXpv?=
 =?utf-8?B?MTVqcjNnNE03Sm93cDM1RHM3QUlBMTViUURIRVE5ZlRYTEJBUmRIeDh1Z25v?=
 =?utf-8?B?bW1HeU42MjBkVDBRSDY4ajQ2dDBqdHRVODFsWHRDS2c5RVBGYWVUTkNVUG55?=
 =?utf-8?B?Sk9nNXNSWXlsNFhWNHhsRHUxR0lIcUZ2Z1VOTjNVSWdRVzN6MWUwSm1IR0ZI?=
 =?utf-8?B?N2xpU0F6elR6b3FjUEpRSkE2TnlIOUYrdjcxUjlTdWRTSGRzekFpZlV5dHEv?=
 =?utf-8?B?dEdPa2dhbVVHdC9QWFRaR1ZQa1NEU2VPSEpjd2NFNzVHOEtBNlVXdDduN0gx?=
 =?utf-8?B?MUd5TXc3b1hHOW8xMFRDTWYxMGZmS1JSaUYxZmNZdUQ3ZTlPL3Jvd0ZjcDBm?=
 =?utf-8?B?K0tROTltWFJYYlJpaEp0YmMwZ0ZJaFk5azl1WTVnRXEvWG42ajlhNDlWQkV5?=
 =?utf-8?B?SVVpTnhpaFJPM0EzTUMreTBtdVljeFByRVMxNHNyRklvdldXUXpBWWhhNlhV?=
 =?utf-8?B?V2pEMG8waXRWTXhXaGxqaFAwSTdSdVZiK2NwdUFSaVFTZGR5NlN6RlFLMzNa?=
 =?utf-8?B?ZldxUzhVRmVxQXdwNDVtYjFsVncrL0ZPdkc0b2VnODVRTVN0aitibVI0a1Ey?=
 =?utf-8?B?KzNQRGRlbzNsWE10MmtyRkY4d0JqQWhKQWd5SWlLOEdaRVlVeTR3YmliZmN6?=
 =?utf-8?B?Y1U4YWl6RHlad0tHUCsySTVaeUFPU1RYa2NTK1Vodnp1WDZsNGFIbzJ3Z3hI?=
 =?utf-8?B?Ni9zdDVYWXpwY2doQkFnNTFWRThSOTE1ZXRCMWpWYSs5YlgxYTNycTNOWmJS?=
 =?utf-8?B?b0ZZMk9EUDJiSEtwNXNUNEV0cndRUDVCbTVFdERjcVptVnRZbEhKVlBGdnll?=
 =?utf-8?B?RmMzbzV1OVhqa3NCZkorOXgwdFYvQUZ0aDhGZkpYRGlBazdWQzhNZz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0879885-3b96-4cac-8d6e-08ded04e78c8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:07:38.8583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsMtjHYlDy26GjRslMOxtBL5T8/kAqFA2TEBedgWlXEmp/OBZYLSPRWk3fOxXEFHe3a0QUlaFnA8GmCBl+FNBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6220
Received-SPF: pass client-ip=2a01:111:f403:c005::5;
 envelope-from=kchiu@axiado.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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


Philippe Mathieu-Daudé 於 2026/6/22 下午 04:21 寫道:
> CAUTION: This email originated from outside of the organization. Do 
> not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
>
> On 22/6/26 05:34, Kuan-Jui Chiu wrote:
>>
>> Philippe Mathieu-Daudé 於 2026/6/18 下午 11:17 寫道:
>>> CAUTION: This email originated from outside of the organization. Do
>>> not click links or open attachments unless you recognize the sender
>>> and know the content is safe.
>>>
>>>
>>> Hi Kuan-Jui,
>>>
>>> On 18/6/26 12:12, Kuan-Jui Chiu wrote:
>>>> Enable SD host controller into Axiado AX3000 SoC to load kernel and
>>>> rootfs
>>>> from eMMC.
>>>>
>>>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>>> ---
>>>>   hw/arm/Kconfig              |  1 +
>>>>   hw/arm/ax3000-soc.c         | 18 ++++++++++++++++++
>>>>   include/hw/arm/ax3000-soc.h |  7 +++++++
>>>>   3 files changed, 26 insertions(+)
>>>>
>>>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>>>> index 866e4b14e6f..13c0b44a180 100644
>>>> --- a/hw/arm/Kconfig
>>>> +++ b/hw/arm/Kconfig
>>>> @@ -724,4 +724,5 @@ config AXIADO_SOC
>>>>       select ARM_GIC
>>>>       select CADENCE # UART
>>>>       select AXIADO_CLK
>>>> +    select AXIADO_SDHCI
>>>>       select UNIMP
>>>> diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
>>>> index 9a01d23bcc6..159385cf913 100644
>>>> --- a/hw/arm/ax3000-soc.c
>>>> +++ b/hw/arm/ax3000-soc.c
>>>> @@ -35,6 +35,7 @@ static void ax3000_init(Object *obj)
>>>>       }
>>>>
>>>>       object_initialize_child(obj, "clk", &s->ax3000_clk,
>>>> TYPE_AX3000_CLK);
>>>> +    object_initialize_child(obj, "sdhci0", &s->sdhci0,
>>>> TYPE_AXIADO_SDHCI);
>>>>   }
>>>>
>>>>   static void ax3000_realize(DeviceState *dev, Error **errp)
>>>> @@ -165,6 +166,23 @@ static void ax3000_realize(DeviceState *dev,
>>>> Error **errp)
>>>>           return;
>>>>       }
>>>>       sysbus_mmio_map(SYS_BUS_DEVICE(&s->ax3000_clk), 0,
>>>> AX3000_PLL_BASE);
>>>> +
>>>> +    /* SDHCI */
>>>> +    sdhci0_sbd = SYS_BUS_DEVICE(&s->sdhci0);
>>>> +    if (!sysbus_realize(sdhci0_sbd, errp)) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    sysbus_mmio_map(sdhci0_sbd, 0, AX3000_SDHCI0_BASE);
>>>> +    sysbus_mmio_map(sdhci0_sbd, 1, AX3000_EMMC_PHY_BASE);
>>>> +    sysbus_connect_irq(sdhci0_sbd, 0,
>>>> +                       qdev_get_gpio_in(gic_dev, AX3000_SDHCI0_IRQ));
>>>
>>> So there is no link between the SDHCI and the PHY. Thus no need for a
>>> particular AXIADO_SDHCI, simply instantiate a generic SDHCI here, and
>>> register the MMIO region for the PHY.
>>>
>>> in ax3000_init():
>>>
>>>     object_initialize_child(obj, "sdhci[0]", &s->sdhci[0],
>>>                             TYPE_SYSBUS_SDHCI);
>>>
>>> and in ax3000_realize():
>>>
>>>     object_property_set_uint(OBJECT(&s->sdhci[0]), 
>>> "sd-spec-version", 3,
>>>                              &error_abort);
>>>     object_property_set_uint(OBJECT(&s->sdhci[0]), "capareg",
>>>                              0x216737eed0b0, &error_abort);
>>>
>>>     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci[0]), errp)) {
>>>         return;
>>>     }
>>>     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci[0]), 0,
>>>                        qdev_get_gpio_in(gic_dev, AX3000_SDHCI0_IRQ));
>>>     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci[0]),
>>>                     0, AX3000_SDHCI0_BASE);
>>>
>>> Then you simply map the state-less eMMC PHY region:
>>>
>>>     memory_region_init_io(&s->emmc_phy, OBJECT(s), &emmc_phy_ops, s,
>>>                           "axiado.emmc-phy", 0x1000);
>>>     memory_region_add_subregion(get_system_memory(),
>>>                                 AX3000_EMMC_PHY_BASE, &s->emmc_phy);
>>>
>> This is the original design in previous patch but PMM preferred to have
>> an independent device model for this SDHC
>
> AFAICT nothing on v1.
>
> On v2 Peter said "Adding the new SDHCI controller should be its own
> patch." This is about the code contribution process, not how to
> structure the model in code. Is there another reference I missed?
>
> As it this AXIADO_SDHCI is unnecessary maintenance burden.
>
> v1:
> https://lore.kernel.org/qemu-devel/20260306121511.1781020-1-kchiu@axiado.com/ 
>
> v2:
> https://lore.kernel.org/qemu-devel/CAFEAcA8dRq+hqCZ+eSHdafwEccd4coqHZ12nxWAkyDOG3GEkgg@mail.gmail.com/ 
>

Look like I misunderstood this
> +static uint64_t sdhci_phy_read(void *opaque, hwaddr offset, unsigned 
size)
> +{
> +    uint32_t val = 0x00;
> +
> +    switch (offset) {
> +    case REG_ID:
> +        val = 0x3dff6870;
> +        break;
> +    case REG_STATUS:
> +        // Make DLL_RDY | CAL_DONE
> +        val =  (1u << 0) | (1u << 6);
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    return val;
> +}
> +
> +static void sdhci_phy_write(void *opaque, hwaddr offset, uint64_t 
val, unsigned size)
> +{
> +    /* TBD */
> +}
> +
> +static const MemoryRegionOps sdhci_phy_ops = {
> +    .read = sdhci_phy_read,
> +    .write = sdhci_phy_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};

Please put models of sub-devices of the SoC into their own
source files in the appropriate subdirectory of the hw/ directory.

I thought he was talking about the SDHC
Now he probably just wanted me to move PHY out of ax3000-soc

Should I remove axiado_sdhci then add misc device for eMMC PHY in v7 patch?


