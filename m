Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543AECD6E56
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 03:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUFlA-0005Tt-T0; Mon, 01 Jun 2026 23:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUFl2-0005T5-1u
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 23:25:37 -0400
Received: from mail-eastusazon11022132.outbound.protection.outlook.com
 ([52.101.53.132] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUFkx-00019O-Ci
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 23:25:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmaTh6Hok64lrkwKs5llhX44GOqBMnLvA7IrR6RyWHqF+B9n7pXwhT1HFSJU6JLhLyR1iMYMoHsVoIORXZPPBCV6TAFeRnI2WuqZwos2eUEyJiZe3OEMxSNqxyRlNqJ183K4RMuA7wQ2Fo8pK1z6yarB2fWpwtymjSMdK/bQ9wqAR5SDHG+Ov/Zc/i6TcinylE5reoYV6jfu0mx2s0S2jbgLe2yKMfeEFyCqgrF79+mzVaGoJjRy5PfOmJtINjHiMctUHYtXcXSlHY+K2d5raf6djxwLn1rp4ZpFIHtIwoxU5uP+V4jk/ZBIyMQmjBu93SGY1kCqwc1KyYJ1GfuwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1++1C5DjsWtfeqBuHTv2y3ddreYGR+Q9TWRBbs/tOA=;
 b=ISNK3WbrMbx6ogk8vkqnTvfi7krM4CHqLjBnUZTX5Y6ZzHorLhk+ygOpLn67mlT3XBRZeZhbK5z7ILrjlxIeFp80yrtXry5/+GPALHjltQ5sHNwLPphRSS1KqnMWf9grZA0bEjCkpbGkfcke/nyc1CvX1o55R21VJCp0GRO6CTWCXhVozLLFfwJFEUN4oiu2B751ns/DYELU0/J6hwhCNWS00o25yjv58PLR0eS1EEhrQD3HPJfe6Qac9EO8+VRxFWQbV0bXzXV9MH3wKtc4KyxtLtsoFNbrIN1hVP7DDIL59UdIHRqsvy1e1JFnKmkHBsk0WqOQq+qMx0qkNvo0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1++1C5DjsWtfeqBuHTv2y3ddreYGR+Q9TWRBbs/tOA=;
 b=cL5FaD1QTxMUBfLh99u3bU67IWQGpG1i+QA0oe4mGx496V9uKDRMHaIpI6BtDs9SN78hp8mRBhz2XieCWZSf1tLFB2sm+xH8DEt1YCnhudmu9zyOMj7c3ikaQJGqjHl6B84OdHP8XDyFIW0Ywzp8+qplPAoFm/8D8hA397KLBWPvV6srw5/ogU085jclJxoW7+F3G8rbw8LBGUL7oVWDzhlKr16s+ATqxYLqFP9xc2/HsHxA8BHgSoFvNGDjFfPcEVQNeXnAaWO67zlBWetMWCmarrLiFFxS/ADtAMsu6udJZddVwt4Kg73Uc/pbVJcCY2FETVC4fbhv27jA/TmsFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by CH3PR18MB5598.namprd18.prod.outlook.com (2603:10b6:610:19d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 03:20:25 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 03:20:25 +0000
Message-ID: <e5c73430-5471-4623-8f2a-9592b04a3679@axiado.com>
Date: Tue, 2 Jun 2026 11:20:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] hw/arm: Add Axiado SoC AX3000
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260430091832.1846637-1-kchiu@axiado.com>
 <20260430091832.1846637-2-kchiu@axiado.com>
 <CAFEAcA8dRq+hqCZ+eSHdafwEccd4coqHZ12nxWAkyDOG3GEkgg@mail.gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <CAFEAcA8dRq+hqCZ+eSHdafwEccd4coqHZ12nxWAkyDOG3GEkgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0013.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::18) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|CH3PR18MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 082ff708-d43f-4f76-1d00-08dec055e352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099006|4143699003|5023799004|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: xTex/yezxWGZb2Rpb5sh11zvkf3qVcHS0+aLQOtl4QEV/L9WNTfIzxYCxFiYWskCwtI45MwBHYcXTttz1axHO5xEokrNlGOUUiMmuxgUdz2OXuWxzJkPLaVeoAkNK6If+x9KMgNhIg6DTVAkJtiOS9jXSGCFITc90Iip2+VNXQ9x1f2snMLSbqlT4ZY+KCUtiSkBBV7dVdyHsK7QoR9ojLjrAYNwYCMFGP/fy0XmEqfbGf9fz4TM5ImJRu45HHDqoIxU54GYBqPVynAi7sd4KphDsEw2p1+CarXnx1C4Bf1xbjlCwEgRTfHbW5aNrE60+n0uOPt0wPzhQC2l0GGhjjsu1R3WFKSSK4Yfh4xx+FYY1iNj1SpATAvxNIDodjr9ONHwd0srWdoIrduOdSAivdZcC2p8eYVoeDHxbuvBb2iIt4CTpnRo7FEWd11hEr3kwsjeKuJD6h7ZzIFPYDwTzfFn/3lE+05EiuQqTzsZuamW82rUCEEQUevIvTtKotPjdQGVS78LzmVOdh7Lz+L2rAh7aMNjtBUG4DTa9x1QQmcQ7lMw/6bKl0RkaBS4OcsYjCoUirabDrK3G/sBscVCjhvp9ntZQtjV+3matcW4jf9OrnxjVeFL+zYB/wKgYZKrKiUPWHzNH10WaFSij8fjejHWh48/H5zFw3So0tSj/2UXKRgoH/fjdZkilUoXRRXx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004)(3023799007)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUpleVBUaWZ5TXU1MytGLzdTa0p0ZGthOXRpdnA1ZFNSdjhKdVk3YWlCUVBE?=
 =?utf-8?B?R3hrMlF2UDNrMm9IOFZPbmZLdy9zMUl1a24vcDRCbWEvRVBHMVFCNG04OFFM?=
 =?utf-8?B?ZzlRLzIxeHZqM3FlbVdibWtuTS9mbzNQSytPd1pRY2pZcHhOYzNlakg4Rktq?=
 =?utf-8?B?cHFJcFkzRnpMYytQZjhCdkRaM0wvaEk4cUgreUUwdWtIOC9ROUVSNmQ3WjVn?=
 =?utf-8?B?WWdzdTdGdnVmK1ZPRm5LYWw0NVptSUQ1czl3UmJSUm1KSWw2Z3ZOSk1yczdh?=
 =?utf-8?B?bFhQR0FsTDY2bHg3QityL21RZEp0ZmtZNnN1MkRVamZVbnVORm55OUcwMlBT?=
 =?utf-8?B?YUNvWVp6ekRya3ZCOUlOdEJEeDd5K1NOVjVlVXZSUmRPM0xrQUR6TlVMYXVO?=
 =?utf-8?B?TnF4VE1CWTYwKzYxRkFFekppWmJIUHlMVmpRaXlybi9xOWhNbzBObHIwdVV5?=
 =?utf-8?B?V3BYUGFSQ3FPeGNwNll6bjJLV3VSU0p0b1hqMWpnMUpkMDV3bzBlQjAzbUpN?=
 =?utf-8?B?NjFzbkFRNUltWHJSTHArc0pSYWV2aHNYTngreVVLU2lFMlJTY3dHM0c1dlRJ?=
 =?utf-8?B?QWxmSElmMnh6cGM3VStucjR3MWk5eTN6S01kamZjNThSQ1VDRXhQVDFIM0FW?=
 =?utf-8?B?WFhIWlYvSjF6dUcrdVJ3QWtSV0xTeVZVNjFTZk4wNzlCVkhyOWE0KzNtTmNv?=
 =?utf-8?B?SEdjV2M3UU5WcTY4UEdRQWVzU0JiYmMrdC9oK0R2Wnc4UDBYU3VBY09MTFJV?=
 =?utf-8?B?amVMbTJlWVIzRGJUWnpzNFd6bzl2VTRnVkkycFlsTmp2YmdTaVdFeFJqd2dO?=
 =?utf-8?B?U2FmK2UxMlVJbThpcFJLaGlwV0NVZXc2enVCUnF2eDFsQnNzOWptT20xckp5?=
 =?utf-8?B?elkyWGFRVG9US01adjdKUlZYdU16a285U0N0Ym5uS3JHRlphZ25PcEJnZlVr?=
 =?utf-8?B?MmRFei8wb1R1V3V5cVRnTUJJNFl6YktTNDBHNDllV1VxTzB6T1lGN3hSbkhN?=
 =?utf-8?B?ODYxRVZuVExDNGhueXdvWmtPeDNCdkd5L1lncEc4MzltWkcrRFBua3RzU1k0?=
 =?utf-8?B?WlBxS3QzbnVmSTcyNGdWM1MyZXg4c1BTeC9GUUk1MlY3eXFxeHpwVDhzczlx?=
 =?utf-8?B?aHkvbFpJZmVvOG9LMHVIUkFZY1ZtK0VuSmRCNXJObGdtcnZtaTZBcE9FeERk?=
 =?utf-8?B?RnBUUFNoY3ZzNm93NFk2aHZlWVJGc2NGbmpGYW1KNmJXTDhaWU13Zm0yeTFH?=
 =?utf-8?B?OUpqdDArVVBwalVvMjNVT2Q5TVhwZUw0YlNLTW5XbHRtR2Y0dzJZVVBsS3FJ?=
 =?utf-8?B?ZkZ0bU5lbWkvR2UxL1kwQlRTOWJJS21Lbmh6TUxoc3NkZ1AwNWxhTC9tREhY?=
 =?utf-8?B?Ty9Sa1kxRXQ4L3RPL3ZwN3h4ZVNNZTN4N2R5OGZpMlQxdDdGS2VYT3hIZjdF?=
 =?utf-8?B?MG5ab0g5WUNVTjB4R2toRUM3V2pacWY0ZHYvNjJjK2ZieEF4MU5FTTl2cVZJ?=
 =?utf-8?B?K2ExejMxRHp0UTdkQ3h5ZHpRSHMwdVRCb0JkQmVUTDA3UmdOZVliVmY4R0VG?=
 =?utf-8?B?Wk9BZ2cyMTVFWXRXc0ZJWmlnWVdYclRrRlBmb0xieU9jRDhWWlZLUkhFWVJ0?=
 =?utf-8?B?UG95VzFEMDFTMnp1YmJraWpGZXhseC9jUVVnd05IUFRGWjdVU0ZlM05vWXRh?=
 =?utf-8?B?dTlYUGJtd3RPN0JGYytYRnZBTi9hZGdUeU9WNjNHSHUxR0EyQ1lJQkkxYzJJ?=
 =?utf-8?B?Z2U4Y253Q25XNDQ1VkRpeEN6ZXJZemQ2MkpsM3pwYTJxR0tzNWlOT0VUcjc0?=
 =?utf-8?B?ck9ySTVDUkFnODY2NlFOZkRQdm1adFZjZDRjczhld1M4eXVpUXZPb1haOFR3?=
 =?utf-8?B?WTAraXZwYVFnWG9CTzVPTjB0SUZCYng5MUgvcUFpdjdpSzlJMm8vajkxRjdJ?=
 =?utf-8?B?NjVPRFZVSnhYZUpBdG9IbzJxNE9vekF3NlpyUHNqMWd6ZmJGdnc5TTNsR2lp?=
 =?utf-8?B?N09xV2xxNWNBQ1VvSS9OeExlV1QrWFZRT2RvUm1GaW1DOW9ET1lRODE4eWVG?=
 =?utf-8?B?L2prVGd0SnFVWVdNVlVTc2wxeHVXdTYxb3Z3TzBnOTNZcEJOWW5xNzdsTk1t?=
 =?utf-8?B?c1lvS3BzK1d0M2wwUEFoZndLMCtYeE1vRk5yUHlhWGh6SHhaektzV3R0L3N5?=
 =?utf-8?B?M2d4MnhIWGFZYlE1NzJRQVhpd2xMTmovY01DejlYZDJzbTgyWHBENjI5VHg3?=
 =?utf-8?B?TzM4NGVhUXpGL1dUVEh0MWRIUU5oSEM1dmU3NzZBWUluQVYveVM4ekRPS2ti?=
 =?utf-8?B?SFhSSDAxcm1LT3lUSWVwZUN4akk3cTk2d0VzNm5CaVcyeEUzQW01QT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082ff708-d43f-4f76-1d00-08dec055e352
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 03:20:25.4530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYCsKIN09DPHaTYKkfby5bZ2dTwbiediON3OJ2AaiD3R/TG0/GmABq+ZpZ5N+QhRKL8mlXP7Lk0FBIJzJvGIsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5598
Received-SPF: pass client-ip=52.101.53.132; envelope-from=kchiu@axiado.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


Peter Maydell 於 2026/5/26 下午 10:06 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Thu, 30 Apr 2026 at 10:19, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>> This patch adds new model for Axiado SoC AX3000 which supports
>>      4 Cortex-A53 ARM64 CPUs
>>      Arm Generic Interrupt Controller v3
>>      4 Cadence UARTs
>>      1 SDHCI controller with eMMC PHY
>>
>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>> ---
>>   MAINTAINERS                  |   9 ++
>>   hw/arm/Kconfig               |   8 ++
>>   hw/arm/ax3000-soc.c          | 232 +++++++++++++++++++++++++++++++++++
>>   hw/arm/meson.build           |   3 +
>>   hw/sd/Kconfig                |   4 +
>>   hw/sd/axiado_sdhci.c         | 100 +++++++++++++++
> Adding the new SDHCI controller should be its own patch.


No problem, I will separate it

>
>>   hw/sd/meson.build            |   1 +
>>   include/hw/arm/ax3000-soc.h  |  78 ++++++++++++
>>   include/hw/sd/axiado_sdhci.h |  21 ++++
>>   9 files changed, 456 insertions(+)
>>   create mode 100644 hw/arm/ax3000-soc.c
>>   create mode 100644 hw/sd/axiado_sdhci.c
>>   create mode 100644 include/hw/arm/ax3000-soc.h
>>   create mode 100644 include/hw/sd/axiado_sdhci.h
>
>
>> +static uint64_t pll_read(void *opaque, hwaddr offset, unsigned size)
>> +{
>> +    switch (offset) {
>> +    case CLKRST_CPU_PLL_POSTDIV_OFFSET:
>> +        return 0x20891b;
>> +    case CLKRST_CPU_PLL_STS_OFFSET:
>> +        return 0x01;
>> +    default:
>> +        return 0x00;
>> +    }
>> +}
>> +
>> +static void pll_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>> +{
>> +    /* TBD */
>> +}
>> +
>> +static const MemoryRegionOps pll_ops = {
>> +    .read = pll_read,
>> +    .write = pll_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
> MemoryRegionOps should always explicitly specify a set
> of .impl and .valid fields to say what the min_access_size
> and max_access_size are. (.valid is what the hardware
> permits; .impl is what the functions handle; the memory
> system core code can somewhat bridge the gap if your
> implementation handles a more restrictive set of sizes
> than the guest is allowed to use.) e.g. if the hardware
> is "must always be 32 bit accesses then set all of
> .valid.min_access_size, .valid.max_access_size,
> .impl.min_access_size, .impl.max_access_size to 4.


No problem, I will add fill in these parameters

>> +};
> This looks like it should be its own device in its own
> file, not a free-standing set of MemoryRegionOps and
> MemoryRegion in this file.
>
>> +static void ax3000_init(Object *obj)
>> +{
>> +    Ax3000SoCState *s = AX3000_SOC(obj);
>> +    Ax3000SoCClass *sc = AX3000_SOC_GET_CLASS(s);
>> +    int i;
> These days we tend to favour declaring the variable
> inside the for loop:
>    for (int i = 0; ... ; ...)
>

No problem, I will correct them

>> +
>> +    for (i = 0; i < sc->num_cpus; i++) {
>> +        g_autofree char *name = g_strdup_printf("cpu%d", i);
>> +        object_initialize_child(obj, name, &s->cpu[i],
>> +                                ARM_CPU_TYPE_NAME("cortex-a53"));
>> +    }
>> +
>> +    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
>> +
>> +    for (i = 0; i < AX3000_NUM_UARTS; i++) {
>> +        g_autofree char *name = g_strdup_printf("uart%d", i);
>> +        object_initialize_child(obj, name, &s->uart[i], TYPE_CADENCE_UART);
>> +    }
>> +
>> +    object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_AXIADO_SDHCI);
>> +}
>> +
>> +static void ax3000_realize(DeviceState *dev, Error **errp)
>> +{
>> +    Ax3000SoCState *s = AX3000_SOC(dev);
>> +    Ax3000SoCClass *sc = AX3000_SOC_GET_CLASS(s);
>> +    SysBusDevice *gic_sbd = SYS_BUS_DEVICE(&s->gic);
>> +    DeviceState *gic_dev = DEVICE(&s->gic);
>> +    QList *redist_region_count;
>> +    SysBusDevice *sdhci0_sbd;
>> +    DeviceState *card;
>> +    int i;
>> +
>> +    /* CPUs */
>> +    for (i = 0; i < sc->num_cpus; i++) {
>> +        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
>> +                                &error_abort);
>> +
>> +        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
>> +            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
>> +                                     false, &error_abort);
>> +        }
>> +
>> +        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
>> +            return;
>> +        }
>> +    }
>> +
>> +    /* GIC */
>> +    qdev_prop_set_uint32(gic_dev, "num-cpu", sc->num_cpus);
>> +    qdev_prop_set_uint32(gic_dev, "num-irq",
>> +                         AX3000_NUM_IRQS + GIC_INTERNAL);
>> +
>> +    redist_region_count = qlist_new();
>> +    qlist_append_int(redist_region_count, sc->num_cpus);
>> +    qdev_prop_set_array(gic_dev, "redist-region-count", redist_region_count);
>> +
>> +    if (!sysbus_realize(gic_sbd, errp)) {
>> +        return;
>> +    }
>> +
>> +    sysbus_mmio_map(gic_sbd, 0, AX3000_GIC_DIST_BASE);
>> +    sysbus_mmio_map(gic_sbd, 1, AX3000_GIC_REDIST_BASE);
>> +
>> +    /*
>> +     * Wire the outputs from each CPU's generic timer and the GICv3
>> +     * maintenance interrupt signal to the appropriate GIC PPI inputs, and
>> +     * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
>> +     */
>> +    for (i = 0; i < sc->num_cpus; i++) {
>> +        DeviceState *cpu_dev = DEVICE(&s->cpu[i]);
>> +        int intidbase = AX3000_NUM_IRQS + i * GIC_INTERNAL;
>> +        qemu_irq irq;
>> +
>> +        /*
>> +         * Mapping from the output timer irq lines from the CPU to the
>> +         * GIC PPI inputs.
>> +         */
>> +        static const int timer_irqs[] = {
>> +            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
>> +            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
>> +            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
>> +            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ
>> +        };
>> +
>> +        for (int j = 0; j < ARRAY_SIZE(timer_irqs); j++) {
>> +            irq = qdev_get_gpio_in(gic_dev, intidbase + timer_irqs[j]);
>> +            qdev_connect_gpio_out(cpu_dev, j, irq);
>> +        }
>> +
>> +        irq = qdev_get_gpio_in(gic_dev, intidbase + ARCH_GIC_MAINT_IRQ);
>> +        qdev_connect_gpio_out_named(cpu_dev, "gicv3-maintenance-interrupt",
>> +                                        0, irq);
>> +
>> +        sysbus_connect_irq(gic_sbd, i,
>> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_IRQ));
>> +        sysbus_connect_irq(gic_sbd, i + sc->num_cpus,
>> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_FIQ));
>> +        sysbus_connect_irq(gic_sbd, i + 2 * sc->num_cpus,
>> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_VIRQ));
>> +        sysbus_connect_irq(gic_sbd, i + 3 * sc->num_cpus,
>> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_VFIQ));
>> +    }
>> +
>> +    /* DRAM */
>> +    for (i = 0; i < AX3000_NUM_BANKS; i++) {
>> +        struct {
>> +            hwaddr addr;
>> +            size_t size;
>> +            const char *name;
>> +        } dram_table[] = {
>> +            { AX3000_DRAM0_BASE, AX3000_DRAM0_SIZE, "dram0" },
>> +            { AX3000_DRAM1_BASE, AX3000_DRAM1_SIZE, "dram1" }
>> +        };
>> +
>> +        memory_region_init_ram(&s->dram[i], OBJECT(s), dram_table[i].name,
>> +                               dram_table[i].size, &error_fatal);
>> +        memory_region_add_subregion(get_system_memory(), dram_table[i].addr,
>> +                                    &s->dram[i]);
>> +    }
>> +
>> +    /* UARTs */
>> +    for (i = 0; i < AX3000_NUM_UARTS; i++) {
>> +        struct {
>> +            hwaddr addr;
>> +            unsigned int irq;
>> +        } serial_table[] = {
>> +            { AX3000_UART0_BASE, AX3000_UART0_IRQ },
>> +            { AX3000_UART1_BASE, AX3000_UART1_IRQ },
>> +            { AX3000_UART2_BASE, AX3000_UART2_IRQ },
>> +            { AX3000_UART3_BASE, AX3000_UART3_IRQ }
>> +        };
>> +
>> +        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
>> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
>> +            return;
>> +        }
>> +
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
>> +                           qdev_get_gpio_in(gic_dev, serial_table[i].irq));
>> +    }
>> +
>> +    /* Timer control */
>> +    create_unimplemented_device("ax3000.timerctrl", AX3000_TIMER_CTRL, 32);
>> +
>> +    /* PLL control */
>> +    memory_region_init_io(&s->pll_ctrl, OBJECT(s), &pll_ops, s,
>> +                          "ax3000.pllctrl", 32);
>> +    memory_region_add_subregion(get_system_memory(), AX3000_PLL_BASE,
>> +                                &s->pll_ctrl);
>> +
>> +    /* SDHCI */
>> +    sdhci0_sbd = SYS_BUS_DEVICE(&s->sdhci0);
>> +    if (!sysbus_realize(sdhci0_sbd, errp)) {
>> +        return;
>> +    }
>> +
>> +    sysbus_mmio_map(sdhci0_sbd, 0, AX3000_SDHCI0_BASE);
>> +    sysbus_mmio_map(sdhci0_sbd, 1, AX3000_EMMC_PHY_BASE);
>> +    sysbus_connect_irq(sdhci0_sbd, 0,
>> +                       qdev_get_gpio_in(gic_dev, AX3000_SDHCI0_IRQ));
>> +
>> +    card = qdev_new(TYPE_SD_CARD);
>> +    qdev_prop_set_drive_err(card, "drive",
>> +                            blk_by_legacy_dinfo((drive_get(IF_SD, 0, 0))),
>> +                            &error_fatal);
>> +    qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
>> +}
>> +
>> +static void ax3000_class_init(ObjectClass *oc, const void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(oc);
>> +    Ax3000SoCClass *sc = AX3000_SOC_CLASS(oc);
>> +
>> +    dc->desc = "Axiado SoC AX3000";
>> +    dc->realize = ax3000_realize;
>> +    sc->num_cpus = AX3000_NUM_CPUS;
>> +}
>> +
>> +static const TypeInfo axiado_soc_types[] = {
>> +    {
>> +        .name           = TYPE_AX3000_SOC,
>> +        .parent         = TYPE_SYS_BUS_DEVICE,
>> +        .instance_size  = sizeof(Ax3000SoCState),
>> +        .instance_init  = ax3000_init,
>> +        .class_init     = ax3000_class_init,
>> +    }
>> +};
>> +
>> +DEFINE_TYPES(axiado_soc_types)
>> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
>> index b187b946f0..e32f5eb0c7 100644
>> --- a/hw/arm/meson.build
>> +++ b/hw/arm/meson.build
>> @@ -105,6 +105,9 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
>>   arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
>>   arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
>>
>> +arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
>> +  'ax3000-soc.c'))
>> +
>>   arm_common_ss.add(files('boot.c'))
>>
>>   hw_arch += {'arm': arm_ss}
>> diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
>> index 633b9afec9..c69bf24f8d 100644
>> --- a/hw/sd/Kconfig
>> +++ b/hw/sd/Kconfig
>> @@ -23,3 +23,7 @@ config SDHCI_PCI
>>   config CADENCE_SDHCI
>>       bool
>>       select SDHCI
>> +
>> +config AXIADO_SDHCI
>> +    bool
>> +    select SDHCI
>> diff --git a/hw/sd/axiado_sdhci.c b/hw/sd/axiado_sdhci.c
>> new file mode 100644
>> index 0000000000..219d49079e
>> --- /dev/null
>> +++ b/hw/sd/axiado_sdhci.c
>> @@ -0,0 +1,100 @@
>> +/*
>> + * Axiado SD Host Controller
>> + *
>> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/sd/axiado_sdhci.h"
>> +#include "sdhci-internal.h"
>> +#include "qapi/error.h"
>> +#include "hw/core/qdev-properties.h"
>> +
>> +#define EMMC_PHY_ID     0x00
>> +#define EMMC_PHY_STATUS 0x50
>> +
>> +static uint64_t emmc_phy_read(void *opaque, hwaddr offset, unsigned size)
>> +{
>> +    uint32_t val = 0x00;
>> +
>> +    switch (offset) {
>> +    case EMMC_PHY_ID:
>> +        val = 0x3dff6870;
>> +        break;
>> +    case EMMC_PHY_STATUS:
>> +        /* Make DLL_RDY | CAL_DONE */
>> +        val =  (1u << 0) | (1u << 6);
> If this comment is trying to say what these bits are, better to
> define symbolic constants for the bits and use those.


No problem, I will define these two bits as macro

>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +static void emmc_phy_write(void *opaque, hwaddr offset, uint64_t value,
>> +                            unsigned size)
>> +{
>> +    /* TBD */
> Don't leave bare TBD/TODO comments in the code. It's OK not to
> necessarily implement everything at the start, but the
> comment should explain what is missing. In six months
> time, will somebody other than you be able to look at the
> file and know what is still to do ?


Understood.
Currently I don't have idea to implement this write function, I will 
keep it empty.

>> +}
>> +
>> +static const MemoryRegionOps emmc_phy_ops = {
>> +    .read = emmc_phy_read,
>> +    .write = emmc_phy_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
> This should specify access sizes too.


No problem, I will add fill in these parameters

>> +};
>> +
>> +static void axiado_sdhci_realize(DeviceState *dev, Error **errp)
>> +{
>> +    AxiadoSDHCIState *s = AXIADO_SDHCI(dev);
>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> +    SysBusDevice *sdhci_sbd;
>> +
>> +    object_initialize_child(OBJECT(s), "sdhci", &s->sdhci,
>> +                            TYPE_SYSBUS_SDHCI);
> Generally devices should do the object_initialize_child for
> child-objects in their instance_init function, and
> realize in their realize function. (Occasionally there's a
> reason this isn't possible.)


Sure, I will move it to instance_init()

>> +
>> +    qdev_prop_set_uint64(DEVICE(&s->sdhci), "capareg", 0x216737eed0b0);
>> +    qdev_prop_set_uint64(DEVICE(&s->sdhci), "sd-spec-version", 3);
>> +
>> +    sdhci_sbd = SYS_BUS_DEVICE(&s->sdhci);
>> +    sysbus_realize(sdhci_sbd, errp);
>> +    if (*errp) {
>> +        return;
>> +    }
>> +
>> +    sysbus_init_mmio(sbd, sysbus_mmio_get_region(sdhci_sbd, 0));
>> +
>> +    /* Propagate IRQ from SDHCI and SD bus  */
>> +    sysbus_pass_irq(sbd, sdhci_sbd);
>> +    s->sd_bus = qdev_get_child_bus(DEVICE(sdhci_sbd), "sd-bus");
>> +
>> +    /* Initialize eMMC PHY MMIO */
>> +    memory_region_init_io(&s->emmc_phy, OBJECT(s), &emmc_phy_ops, s,
>> +                          "axiado.emmc-phy", 0x1000);
>> +
>> +    sysbus_init_mmio(sbd, &s->emmc_phy);
>> +}
>> +
>> +static void axiado_sdhci_class_init(ObjectClass *klass, const void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->realize = axiado_sdhci_realize;
>> +    dc->desc = "Axiado SD Host Controller with eMMC PHY";
>> +}
>> +
>> +static const TypeInfo axiado_sdhci_info = {
>> +    .name          = TYPE_AXIADO_SDHCI,
>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(AxiadoSDHCIState),
>> +    .class_init    = axiado_sdhci_class_init,
>> +};
>> +
>> +static void axiado_sdhci_register_types(void)
>> +{
>> +    type_register_static(&axiado_sdhci_info);
>> +}
>> +
>> +type_init(axiado_sdhci_register_types);
> thanks
> -- PMM

