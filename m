Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8881F8D753
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDOhT-0004sB-7M; Thu, 16 Apr 2026 11:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1wDOhL-0004rL-3T; Thu, 16 Apr 2026 11:32:07 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1wDOhJ-00063g-6Q; Thu, 16 Apr 2026 11:32:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXvBSp4dUMhigGr+whwVNK+WOCbHRz+mL7YN3BKsfSzTLDd3OTWaKQXSsT1hhQ/2ZC1K+CUc3O0cR/GWk+nd5+hbW6YT4HRT4U8sppm+HNbjzlfrh9ieD+rwKHbm7I3NvTbbHDZ8LhUx3JypwZlD7gwk0OZr4trMigXcFP1uwIH4syle3b93yjIJifg0VxXq+NC+3C2WJs9ujEDRhZOjbyI5pPf6D8kxL2KULQLt9Oc0E0IqbBnNojHziLX8es30PYTzTYP2q3g+jUkzS2vIAK721JzABz4E6X3msQaoxiZuwteC1wR8FSxCGRHOEvmqdyf219LyaZ9NxJeLSZtmCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgZynmwNkILdlbHbDnabl4cVxz8mLYim4w8zx+JtGnI=;
 b=VEPFRDkd8U2ET76Ew4apSxXcR9d7qT00W7mDKMKmSpfy2bIzwnFJFknppQynrjg6zcFTZ2OxQei2jIXLRA87nDr9AJF+ah/PajtvME0wIXoTZSC4EjyWzryD3G1bGcOFaZ19ILFtYXGa6KPzQ1dd5Y7VrGP0Fk94Ib84IGIzMsyoo7dy/7cz6Y3Y49DJ02Hy49JNwFWMwLnTGGl/YrIVXSlwdy7KrnamotTgN1rPNySg1oBk2YqveTjfi6TkXz0cngd9pjGmn/b2Yz40+Vil9yo+PSK6olDvSYTldKhtudSotK5nNMi8We1lDti5Z3FJ2txiCWYao+vhoFht5GEsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgZynmwNkILdlbHbDnabl4cVxz8mLYim4w8zx+JtGnI=;
 b=wwo9NYvFNqNPCSF8Uw71esJ95KOh15cB1GPLtz1eTYil3DN745dAJ/RYAG7xIFxd2x2T3oDJGRi1/c1MXsP7yvXKHXn2TIR93al/9YdE9Vf9dgX70aMIimy0GKgm2um3QkJ53G2f+cKo0cJId2JobBTRtLUVBxRibITCMTV7J9AhmxtZQOVukGKD8KXPdI1nAi35IQhVNn7MGMcboWPZvf1FhGbC/YWLPhHIirVPcpQj4PqhI4CEN9dgP1GET3trN0rfY8QbSoMmm3khaSeceuE0lAct6Id47wR2DJbnyKnVz0K9ws7/Mo7PCIlOKYN9c2syJ3nUu6Z0zDK8W+nC1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AMBPR10MB9818.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:733::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 15:32:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 15:32:00 +0000
Message-ID: <5add8989-b670-4350-a251-eab8503082a3@siemens.com>
Date: Thu, 16 Apr 2026 17:31:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Add support for pre-setting the
 authentication key
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <cover.1776231967.git.jan.kiszka@siemens.com>
 <9fab19ee4c755f9cb2abf55494541fcadff46cbd.1776231967.git.jan.kiszka@siemens.com>
 <d68f975d-0450-4928-b758-bea1e657eae7@linaro.org>
 <60d47301-08f4-44e9-9cd6-2a12bb9e56de@siemens.com>
 <183ce56e-cbd9-41a5-8d68-9281aa6ddd54@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <183ce56e-cbd9-41a5-8d68-9281aa6ddd54@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AMBPR10MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a12c2ea-944a-4505-d6ca-08de9bcd4d5f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9OY1TQnIUgk6fgIAVNRIHfBzkB3CyB6JwsJAzUIQ2dzVzYad/v4p5beGLRNvFdRwcbJct8T33gEe7FSQ8rFnEtIeAqLxw7MA5Lqe8XnhG9FWMvOT50wugFNqdDLi5CTXhFp8I9X9hpsx9OXFncTjlzFonDdytG3lfDRtx6G1Ts0c1s8uxgdzGK3g71C0O2U4a4WvzQ2V5L6vLwJZr4dcmqnJRplHGNEY7j8C3FgHhXbBRfgixJw176yl4iwEvXW/H+VomUNBSw1CjiHzi5tTupem9apajJqjAsNy0Kpx5HfNY/CVHi80CCbRnX+4OWHqFhUw5SLZqtr5D5LHysiSE8iz2B9X4CCft5hkcKKsMS+OK+1JDMmUksCAh/tlO+F0vkxoVlcx+xQJVm19NQSE07a8GMIe2OsWZ3bLQv5GbptP1CDj/j8wHst/8d/TFHiCzbzTV9i7iOV5EfMh47GiI7gKYoIqdfkSnB6T5038iDsLR8APySFUXd/0UV6LUv4qH/OL4hXnrTaPnx9TIlZItzOQB1OvQYBQzzHHxC4Aqa2+QGAb5tfP5nTWS/n7zXtnXrFMxa94qoekymk2rodI9SqPXasIn29dgp/mcOVpSOEuOwozCYtURL2bp22Sn9NWzK1T6QdpM7BQUelMGH34X6CBaBMCvf1Iy6f4QKQTWZML5g3lMgTZM8PDki7JXh0hr+YTo0xv3MoFgHpb0DIBoxa2fLh4Tv7PGD6XEecCS6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUM0MjhGaHlkdzFuUmtWclo0cDVDZlBmTDJtNnc3Z2Q3bDJib1FOSEhPaVpt?=
 =?utf-8?B?eUN6cjlBd0ZUaktXb0dyaFBVNGlrdElxemt4eGhrQTZPWWJXUTFqSGpUYmVh?=
 =?utf-8?B?NDdiZ2wvUk9HNGZOUGpObmpCdjBzcWtHbWNWNzVUNHZVT1kxNmNxR2h4MERq?=
 =?utf-8?B?RCtGa2x1UE9jZlhzS2d0dEY4NlZ6dXNycGtEZWsvR3NjR3VzckYyUFlBOHFh?=
 =?utf-8?B?WXJncXBDUGV3d0ptbmhGQVJhVXZQQmo0WlY1ejFJL0R2bEdSRlVwcjNaNFNj?=
 =?utf-8?B?T1FvTVJOK2Z6dTNaV1VCQTFYaUNaSzNEaEhMSCtrUmpENlRTTmlleWgwd3hE?=
 =?utf-8?B?YkswWmp3aXc0M3RvKzBxSzI0SXR1eURlb0N0ZUZVTzhaMThFSmZYeHJBNmdO?=
 =?utf-8?B?TGljcGo3bHNiM1dyczJFdzVYRkYvRFlCSGtDcGZGc2djZjdIcUh3L00zdEdM?=
 =?utf-8?B?aFZ6NnhVQUZVMktPUGRISHY5TW1uYzd1bHp4SXJncXpTSE1yVVZiOWRiNmFJ?=
 =?utf-8?B?ZXoyZzArZENESGlUanorcVoyanQxSFU5Y2lDQkNlWGdYNEpkeEJsdVFxLzla?=
 =?utf-8?B?dHYzMmowQmlNYVRyanVVK1JUTXMvZkxLRlZDSDdUanFTSlpTMVUycWpUT1ZU?=
 =?utf-8?B?VGRFdDYyYUdOT2VGMUI1UDlEMUh6cFYyS3VCK0g5djlMMmo5Ynk4WjhodWlk?=
 =?utf-8?B?cldFUU4wUFBBci9qUGtSQzMyVWUwK1p6czNoL2g5dExWejM0UUhRTmRkNlE3?=
 =?utf-8?B?ZnphckZuTmY5MFZnbnV1dWtja2U5bUtWUnZvS2tjMmJnWTZUYk80SnV1eFUr?=
 =?utf-8?B?cElUK3ZlNnBxZHk2M1ZCblJSWjFZRmpBalF0VW45WU5saEUveUJheG5aTitl?=
 =?utf-8?B?dHdFNzRzUFlXTVl2YVJkYU5vMHRlR0xVRW1ENjhTaHI2K1hvNUxWN00yRHo3?=
 =?utf-8?B?RGlST1MzZkhlSkU5eVZualBLaHZaVExBQXdocVgxV3Vhc2J5R3BjUnFXUHRx?=
 =?utf-8?B?U0plSTNSRmxLczgrOWNvck8rQXZLckhqZlAwcWdvNDNuWlh5c0hDSytaV0tt?=
 =?utf-8?B?NmhpNEN4by9lTzNoeFNiaE4rdDIrejgyZXNhdzNydlBrLzMxenA0VUpXS1pC?=
 =?utf-8?B?RWZtRWlhUUJLdk9vOGIwaWtCVjU0STVrdXpyaUwzVk9IclZsblhNY3ltbk1O?=
 =?utf-8?B?OSs5dncvYnoyU3ZoWjBzNmFWazBvQjMzY213OUpueUlKcHZaNUsySXdMcmxq?=
 =?utf-8?B?WHV5SGZKN0laZzFSV25NQ3hPY1dJTGZJR0JINVdCc0xaT2VIVVdBMi9Kb04z?=
 =?utf-8?B?SUJDVTNqWTFtMERBaEpLcEp6S2R4TnlXTjE1UVlya0VPWFpIZnVxalJFb29O?=
 =?utf-8?B?U1FqOEQ0R2JBZGVrTDk4ZllxSFNXVllKenBNVTkvRjZzNUpnRHJhKy91Q2Nk?=
 =?utf-8?B?R3gyaDU2TjNMS3NPeGFRaHB2cjNZSlpWQm14U210STlOcFlESVpldXlOWXJW?=
 =?utf-8?B?dUhMd2xLanFOaWNhZ05yS3pHNnBVbWFORWwxMUtqZWJIRXlJVkh4eHF6ZitU?=
 =?utf-8?B?V2ZFQXh3NnowTkNwNzJRU2ExUWxWOWlvNFJhSHg3aHhSQVIrVUpOM09relJ3?=
 =?utf-8?B?Sm9wMUNVM3MrMDdicURtZlhybk9FbXhIOTBmYWdCM3ZsRXJWbVZCd0JUZHh3?=
 =?utf-8?B?OFRETUU4NXNJQklUOWlJeUs2NEhLekJ5eEFBcGFaSnhMRmlBWGRUMXpaL0dq?=
 =?utf-8?B?V2lPeW43M2grTm01SFZ3MmY2VGFlMjZRdU1PWC9aTDR6NDQ0WVFmcXU4QUs1?=
 =?utf-8?B?ZWZzZW5DdUozNm9yRnowZ2p5N2E0Y3I4L2c0Um5lUGx1RHIvNGlmS1o4WTA2?=
 =?utf-8?B?Q2RScFFvMmd1UVV5MXBITWJqWnZjYnpzcGpvYlRzRHFDa0JzSmJzZG5nWVhx?=
 =?utf-8?B?UEU2QnZaU2NhNjZGU1BtVmFNU2F4S2pTYXUzc09jVW4xWm1hN0FnNDBvZVYx?=
 =?utf-8?B?TG1oZVplZ1NYaVljU1FzRXZvM2dVK043cnlBZ0lOZWFsbTR6M1VZcURmQlYz?=
 =?utf-8?B?RW9SWTlCTHIxcW96MlFvOGJPeXpoMDVHSmJ6aHFEZkd4SjN2MGNQdEkvclhk?=
 =?utf-8?B?c1ZaNTBDR1pJTDd3Y3Y4bkd1ZFNDZTRsVHgyeDI4L0UvQU5IVmMrRmUxQzlY?=
 =?utf-8?B?bjRzWXJ4UWZGUDBrTldGWnVkWTZ3UUtUKy80WUF3ampoOXJRdGlHbncrdmh5?=
 =?utf-8?B?QUgyZnBYb1haYkdGUExFamNGM25Oa284TXdaVXBKTERwTHZUUm1tWW45OS90?=
 =?utf-8?B?WHQxemRQYWt0V3pleUhhSW5MQU14ZUhYc2ZlS2pxbzBJOTZ2OVlJMklFL2g5?=
 =?utf-8?Q?SDAobly9z3QRC4t4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a12c2ea-944a-4505-d6ca-08de9bcd4d5f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 15:32:00.4567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJ8OzEa9ONWV79i9624OOo5qu0Hf6HvonXQNspGzQi9w37k6f/zDZQIh0C8Kq0niO45ADdu/1MagLfyjlNDMfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9818
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=jan.kiszka@siemens.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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

On 16.04.26 10:29, Philippe Mathieu-Daudé wrote:
> On 16/4/26 09:50, Jan Kiszka wrote:
>> On 15.04.26 22:28, Philippe Mathieu-Daudé wrote:
>>> Hi Jan,
>>>
>>> On 15/4/26 07:46, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> In contrast to real eMMCs, we are not (yet) persisting the full state
>>>> of the device. This particularly includes the authentication key used
>>>> for RPMB access, complicating testing of firmware images which do not
>>>> support initial provisioning of the key.
>>>>
>>>> One way to address this would be, e.g., extending the eMMC disk image
>>>> with a special sector to store further state. A simpler approach is
>>>> used
>>>> here: Add another device property that allows to specify the
>>>> authentication key, bringing up the eMMC as if the key has already been
>>>> provisioned before.
>>>>
>>>> This is how to tell qemu to use the OP-TEE test key:
>>>>
>>>> -device emmc,[...],auth-
>>>> key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
>>>>
>>>> Or use this for machine-configured eMMCs:
>>>>
>>>> -global emmc.auth-
>>>> key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>    hw/sd/sd.c | 23 +++++++++++++++++++++++
>>>>    1 file changed, 23 insertions(+)
>>>
>>> Do you mind mentioning it in docs/system/devices/emmc.rst?
>>
>> Right, there was something... v2 our patch on top, what do you prefer?
> 
> If there is no need for v2, my preference is an inlined diff that I
> can apply directly saving both of us time :)
> 

Here we go:

diff --git a/docs/system/devices/emmc.rst b/docs/system/devices/emmc.rst
index e62adfd68e..e7d67c809d 100644
--- a/docs/system/devices/emmc.rst
+++ b/docs/system/devices/emmc.rst
@@ -53,3 +53,26 @@ SDHCI controllers while assuming that the firmware needs a boot partitions of
     -drive file=emmc.img,if=none,format=raw,id=emmc-img
     -device sdhci-pci
     -device emmc,drive=emmc-img,boot-partition-size=1048576,rpmb-partition-size=2097152
+
+RPMB Authentication Key
+=======================
+
+A private shared key is used for authenticating requests of the host to the
+RPMB. A real eMMC stores this persistently and permits no reprogramming once it
+is set. QEMU emulates key programming but does not persist the key state
+across restarts. To emulate the state "key is set", the eMMC can be created
+with a user-provided key via the ``auth-key`` property:
+
+.. code-block:: console
+
+    -device emmc,[...],auth-key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
+
+This sets the well-known test key of OP-TEE on emmc device creation. In case an
+eMMC is instantiated by the machine model already:
+
+.. code-block:: console
+
+    -global emmc.auth-key=D3EB3EC36E334C9F988CE2C0B85954610D2BCF8664844DF2AB56E6C61BB701E4
+
+A key always consists of 32 bytes that have to be encoded as hex numbers,
+left-padding with zeros as needed.


Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

