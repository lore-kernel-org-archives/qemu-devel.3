Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AA4C5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzRgv-0003Yc-DO; Thu, 27 Aug 2026 00:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wzRgu-0003YN-9E; Thu, 27 Aug 2026 00:26:16 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wzRgs-0001Wi-Js; Thu, 27 Aug 2026 00:26:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDaAzfozYf9lGQYmbG2ne7rFJwj7UBYKd4fEgE8hSObuc6R8qLuhAQVDQZ5lisyKi/9YX4ZwVnuAAjLkh/hafcwBrGnW0kPBkb0wXA5yeNRuUDvszDnDL3kOOK9QMKvyqfY40CMDZtiS8hO0C1osc25Hj3WFixbrHz1eKERVrh3Fd1cwBKkOMAMxqifPwnuk4w66NZgZlJwxqm7baP5pqrJHW5iIoSnGIFFedValN4XY2qAmWR3Rv2BCbSCq7nivXSHg6IF07iW5WoYrKFsavucPbjshszUVJk8f8/MKQRvmxIwPJkkFCXzLL4ug6cKZsU518x3XfDztkhEa+f5l7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/+v7417jXOiblP6HJJo9H78wDmvKTjIjwBf0g2TL9Q=;
 b=G8M2M4vEIcjgypNpQ3Q5dg16n5QEYKwWY6cr4unWNAl8hHri33KTwpk/akwtNzyzaeT7uhq2/xCuelPH6e8RuQyNmJTLmj+JX+zYof/Gw3ZrLNUAsADqu3dlmUdlRsgSNMqDD6ephaA/S1WJQnInBBEDQbB8mHko0wcR3IkjLa02MasArxQmZ15EErdNRV79m/2Ef04fuif2M41pLb+EzmCKm1tiTjC6Lfrv/N60BnBjLdQve0w19R8QVdyQ4PB8XPDWG95iAxlrJUCUCSA0gRkqbPDfiiyv15ZWINoXMnaZzpIVa40fI9qo7rUZs+R59x41JbPV0kMVRg+yD1lkxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/+v7417jXOiblP6HJJo9H78wDmvKTjIjwBf0g2TL9Q=;
 b=EdGsTXuFajwto8DpO3LqpcHyHW7qd1vs2sniEvJ8cUc5v2HnNEoVO5WA3TDEvYHDx0wNfDKoPAAe66DloEcvz+af4GzhODafFdfCRGjGeX5W4v/YkNNNFoqqVfiXBK99kOdiboUtXwbpn/VGQoenhvN32hIxTL42j9C2nqbjk4co/q911XoJV+ikL0ejUYvWA6zgDoYfPFHbfDs1ntGxidF0csJz4VBh2vfGSUHK2UQ7GT8qdYsA22XjdL2NfQqy/svMAgYZgag3TUzZfCpbRFwA7c9xz5o1zBTBbB9wLXJcHwMRYIBQntWKwiKnegCwLanvV3Yhu8CHemW93gOnyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by DS0PR18MB988740.namprd18.prod.outlook.com (2603:10b6:8:431::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 04:26:10 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 04:26:10 +0000
Message-ID: <a3210074-7795-4a9b-b72e-aea0efb53664@axiado.com>
Date: Thu, 27 Aug 2026 12:26:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] hw/char/cadence_uart: Reserve MMIO with dynamic
 size
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 163wangjack@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
References: <20260826074635.2850931-1-kchiu@axiado.com>
 <20260826074635.2850931-5-kchiu@axiado.com>
 <5e22ac73-0650-493d-a099-c88cbb74b397@oss.qualcomm.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <5e22ac73-0650-493d-a099-c88cbb74b397@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0035.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::17) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|DS0PR18MB988740:EE_
X-MS-Office365-Filtering-Correlation-Id: c40c8767-ba23-4350-01bf-08df03f35232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|56012099006|3023799007|10067099003|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: bKXhCIZBGfLtDkNUfkmdBuPJfKGiCTU1iT2H6lmdEdLZXU2BYTGBKFFZ1J0pHlwIuW93eOKS87Xm3C3p/3jx9hARHEmiGFmo+4+SYGCQvs7K6fSa5RQI8/SYyeL39DtLiuojNwga96rYRSWf3X5z+fOuV6pkcxXz+0yeFKfmBuL/ePlkdk2T0B9rA4nSJcZABX+2vZFLmqE6/4mvHCV/W02wHnGXukAekcw27y2fmOs3AqrvZiWphuIWljg+tFjiAVQrClah/1R4f30Y4ARfHLcnGz3qY1D8BPlGrCZNO0A7aBk4Dz4ECiaUqFToVI6GR9aIHwBfmqyL1p4UQE4cn6ypmJe4/BK2IBZ2D+IlGPBz6S4W4k2XNv4dZ+CtLpQOlrR0ycusmplletUlBRoZ3Vn+qx3ggH3mMD0j12elgV/ilfNH83BbAY5l1qoL5aciI+CWAaa7pSdcbULQ9kwcWk5lxEsXmNCSgX/eybfx4Tm7AzfuAbGv8jxH+Pb3JPunNgKX9zQQhrXsAcpp3ugM49t7nDuvPt5IClbeYnYBZi4BUn5fRNEjuNI1fCDeVDOmhYoG5wLWlCDOAS1E00H+tJ2+a+M1tk9y/KLkmtAUsjFbL/YPFU0njCEG+5Kg/8tucXjfycQz8M4f5ZZMLwNZx6UftxqugnJzLOCPZqRdL9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003)(6133799003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFBqaWs2ck95R2U0YVBVT3dnVHZGcUNtZ3pqQVd0M29tTVkwUkRHSHdJSitm?=
 =?utf-8?B?NEsvaDJSai9DQThIRndERlRhMUdhNnJvRnJ3eDlQOGNydnBuUnI3WTlrMngr?=
 =?utf-8?B?MnhxQjhoNXhPL2V1MUo0VTVyUFZBald0QWl1Q3VMVnRncG9UQ2k4TlZHNEV0?=
 =?utf-8?B?UzgvbVJtQ3BIVkx2b3dpU0plSjVXcytPUFpmZXFSbzVmMU1USHFMQ1A0U285?=
 =?utf-8?B?cVcrN3haMG5TbTBEWjFsbXo0RERwSUJIVWhYdUVTRnBuZUVEdFkzSzIvMW9Q?=
 =?utf-8?B?dHpJVlAxQjFHZWoydGh4bkVLaFNXZUhlbWg1bnNUb2VhR2taZlByTDBTbXlL?=
 =?utf-8?B?MUs5Zkh0NUM2MVl2OUFIMkd1Z0E1MGdnWFo3YlBxY1pKcGZvRW42R2tKM1pC?=
 =?utf-8?B?MFlTVXZGUEM5VFR6TXNSZy82ak14VGR3Qzh2amwvWGorVHdVYm5JcGpWejVQ?=
 =?utf-8?B?MjhvYzJyQ2FxdFgwRWFmY29EMjBVVXYrK1F4czJ0SnQ1VGxYM0hrbWk0RE9r?=
 =?utf-8?B?WVlQbWRIRXRlMGdRdHZkUFpPT3k4U1pGQVhFWFJnYkZDSHZ4dHBocTJxOGVt?=
 =?utf-8?B?T1FZd2xXcTRwcE5RNmJueG02TnpaSGd1NHd6YmhJUHRKVHY1anV4Wm5nNmJs?=
 =?utf-8?B?YTY3RzJCZVU3TnFPU1gva0tQbVRQWnVNZlRYN2lNT1ZhdUxVT1ZON2w3b1c1?=
 =?utf-8?B?U0R4L1NWRXRrWllOcUlYbzQwWFk2L2M0WmYzdHE1dk5iMlAvS3czcjZJM0NG?=
 =?utf-8?B?Z3ZmcGVZbDM5QmZQdXRMUkpnTEoxMHFEVkdENGdYOHVhVUpORVkxZkk5elJ5?=
 =?utf-8?B?ZkZ1VEZ0YVVsUTcyMStYTTBTSUpPM0R0RGY5bHNvMk5tbG1YZG5DN1d4aG8z?=
 =?utf-8?B?a2FtdmYxM2J0NHRxWHJMMTkwNHBHc3hiN2NROTYxQUxsMkc0VERjbjYxY2ZX?=
 =?utf-8?B?TENHU2x3YUhEYk5SSmZHa1RzbXZQSzZlc2xRUG8zOWxCY3pRRUdHdDZSQnpz?=
 =?utf-8?B?OEZscDAvOFBvZVpRVkJLckdkVVlTMFV3QXE3Z2Ewdy9HbWt4azFsZlRjTUJR?=
 =?utf-8?B?NCtmZ0NtanZmbTlZbTlJNXRHWGR4c2RSSXdzTGpwd2FzSytHVXc4SStZVHpP?=
 =?utf-8?B?TkZJOUV0L0tlNUlCbnV1N1FHS3p1a2l2eDl3VDgwWW50Y21xSXkxNW5wM1Fx?=
 =?utf-8?B?OFp2SHRMckp0aWJGNWdaMVE2dHJ5ZExsM0NKQjZqR3l6SWhZL1ZCSE9JdVlt?=
 =?utf-8?B?bnk4VXdXVDdObzhOeW5odStVTGxsenpPSlVUUWorTEJaOVNLaEdXMzZyeXNP?=
 =?utf-8?B?Nk5qZ0c2Y0Q0Ykd2L3g0NUgzQVdVSnp5RzhZU1U5dGE5MmE2ZWFJcVdBYVJS?=
 =?utf-8?B?NG9qaWV5TVhzRSt1dHZtM2R6Rk5lN2dKWlNCL3U2d1kwMkI0UlI3MWl0MHdX?=
 =?utf-8?B?azhTY3RwUngyM2ZjK0lXQ1lZd2lMWnpFMlgwcmtNVlAzak5qcCszZ3NPVGJ6?=
 =?utf-8?B?VFd0ZVdPNHMxZS8vd1FjWGZmZDc3TW1TdnFLTTl4N3k3RFc4UE5iT0lsTUIx?=
 =?utf-8?B?SjBVUDdjd2FkQVI0d2xRT3V5THhOY09aVzRjVlRZQnRNT0JFWCsxaVhzYk9u?=
 =?utf-8?B?ditxSHZvb1pwM2s4Mm44NURFNlQwcUpab2xseGNDV3BJVHNqTzNiejUxeWJU?=
 =?utf-8?B?TGdna2Z3NU9OcldCVTV3Mjl6ZGxwUnBOdWhNcUtkcjJzTUpYUHh4azkwR0xy?=
 =?utf-8?B?bVh0VmRGdmdtVG0xTXNhS0hVd2hDcTlzMU9SRDJqYUpFMG9TMGdkaDZQVEQv?=
 =?utf-8?B?Tm1MWkxyS0F1dTZteWNrOGUxb0dPaXZUa1U2TFlZbjIvYmRGMkhiaUhEeUFM?=
 =?utf-8?B?YzlFTTIzZ25ublJQTmJEaW9CR1Z2U1NEV05PbE5aQVZ1blpsOEk3YVA1VlMw?=
 =?utf-8?B?d3pTSkVEQ0RkRmVJYUQrUDM1WlRvc0JyV0Z4ODVFVzhKM0luazNDblMvaDMx?=
 =?utf-8?B?VzA3N3NvVHkxOEkxWmNNMFlBbDUycXlHODB3SWcyVWtnQ3NJRGcwT1NYcFlR?=
 =?utf-8?B?dHVVVXZmWEI3YXM4WkdiTTFPcUJsbFZET1VvMFVJMkhMV3FoemhOSFVJaDhL?=
 =?utf-8?B?OUlwc1NtNTRPYzU0WTRjQmpMSzBPNXcyWWZ6L3NsUVd3K2hQbjZTV0laZnZV?=
 =?utf-8?B?SE9Gai9BZ0R5RjVqbzFhdHlMTzhpejFrWmxpQmN5OFFZTVNrNzg4cWE4V2Q1?=
 =?utf-8?B?cHNtN0dEU3I2M2ZqeHZNODZRTnlCTnVMcHlneWVxZGlHTmw4bnhGRjJ0cTF2?=
 =?utf-8?B?MnNTVjlOKzVZQjRTUFFzM25pV2RGVGtyeGJrY0xBS01RdFZBZ1RJQT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40c8767-ba23-4350-01bf-08df03f35232
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 04:26:10.2266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38lZGeEIUpDME8fq2ezvML0lgLCOqOYaZeEfPB/r4Sc/pyXPVXtDg0go1OvKqBNZcMw4F0tDJZ5g+5RULc2m0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB988740
Received-SPF: pass client-ip=2a01:111:f403:c000::1;
 envelope-from=kchiu@axiado.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi

Philippe Mathieu-Daudé 於 2026/8/26 下午 04:11 寫道:
> CAUTION: This email originated from outside of the organization. Do 
> not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
>
> Hi,
>
> On 26/8/26 09:46, Kuan-Jui Chiu wrote:
>> Candence UART model is reserving 4 KiB for registers statically
>> For other SoC models, the MMIO size may be not 4 KiB which would have
>> overlapping sysbus regions in QEMU
>>
>> This patch adds a property which allows other models to revise the MMIO
>> size and it is 4 KiB by default
>>
>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>> ---
>>   hw/char/cadence_uart.c         | 8 ++++++--
>>   include/hw/char/cadence_uart.h | 3 +++
>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
>> index f57cad57a8..d83c71b877 100644
>> --- a/hw/char/cadence_uart.c
>> +++ b/hw/char/cadence_uart.c
>> @@ -541,6 +541,10 @@ static void cadence_uart_realize(DeviceState 
>> *dev, Error **errp)
>>   {
>>       CadenceUARTState *s = CADENCE_UART(dev);
>>
>> +    memory_region_init_io(&s->iomem, OBJECT(dev), &uart_ops, s, "uart",
>> +                          s->mmio_size);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>> +
>>       s->fifo_trigger_handle = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>>                                             fifo_trigger_update, s);
>>
>> @@ -561,8 +565,6 @@ static void cadence_uart_init(Object *obj)
>>       SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>>       CadenceUARTState *s = CADENCE_UART(obj);
>>
>> -    memory_region_init_io(&s->iomem, obj, &uart_ops, s, "uart", 
>> 0x1000);
>
> Are we sure this size is even correct and not a copy/paste error?
> We can clearly reduce it up to 0x80 (so far the last register
> implemented is R_TTRIG at address 0x44).
>
No

It is 0x1000 since the first release of this model

Sure, I will change it to 0x80. It would be a simpler fix

>> -    sysbus_init_mmio(sbd, &s->iomem);
>>       sysbus_init_irq(sbd, &s->irq);
>>
>>       s->refclk = qdev_init_clock_in(DEVICE(obj), "refclk",
>> @@ -621,6 +623,8 @@ static const VMStateDescription 
>> vmstate_cadence_uart = {
>>
>>   static const Property cadence_uart_properties[] = {
>>       DEFINE_PROP_CHR("chardev", CadenceUARTState, chr),
>> +    DEFINE_PROP_SIZE("mmio-size", CadenceUARTState, mmio_size,
>> +                     CADENCE_UART_MMIO_SIZE),
>>   };
>

