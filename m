Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C48C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzWCH-0000N1-RO; Thu, 27 Aug 2026 05:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wzWCF-0000H6-K5; Thu, 27 Aug 2026 05:14:55 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wzWCB-0004XN-VY; Thu, 27 Aug 2026 05:14:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzkC0udvJT/2SX3i5CwxFHc/7LJNiqNWDq45GP7LLKzW/REfxtRHaGnbY3rFgZBqGRlQrkkHrSARxUEg0dLpv1JraokFvURGfwqlxP3hzszUYIHw9dxdkojkd/Q4Qmka8ChInXKETkON5ev6VQ6jexqVnyt0eBa8KQ3j1KJssnBlo7S2psq8E1wSZV6lie/bUYasqq7FV+B5/o4ZWtqBAZaloLqyU5CV4BPc0ouFk3q5zMkw4csyFaKeuKamN7b/842bae1cT9QJLeE+ddEeclA0HjlZ8J4DcItDiH9gq+3ZqPJUxS059Bv+kIQaOHXJxrmiaS0bOizSabwEP0HDtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sj87Rl0GrCEIpTTFZXoIMrJTlpPi09gonGvtB75TcRY=;
 b=JKoGI3owTkgQeiehORyUhEarWK7NUYuC5RARsBXf2vwKCPORBoa3q87vUZftbdoMMztro42gN6y3Wp7kQCJ41TxusAmYL/vFdSL4jKfnE/1ykYfo29YHCO4PTk+nTxdLQHFXcs9en02+Q8aXg1EjCc1zXR5D48TTU87SVn6+rXJyCixqj5EUWVow5s8LJgk0W0WNLI5tiqDC925fB+YpjEpjw3OTW2Hdigx5Puw29qZ5FeLyWxNfiM2XPzA0loW2R4+0Y676dB7e9FqupJNaI4nu9EOhf5iP84mEXemP0rmVeQMV03qg2HyFcOkhDfDKYOGCMK7ed573TaqTXLQKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sj87Rl0GrCEIpTTFZXoIMrJTlpPi09gonGvtB75TcRY=;
 b=vFN314Az3ddnF54+g9FD/hCVKtmQnMMRUT29+Q9c9EXcbvvFg8bcv2JDOTdJsu+//hg6LVdCEwo5d0bfiem+2Fzugu+aae9+arg8jD6vxY8fsk25nim+xB+XYKK0OgmuJA8V+4CQInCMdqHp6yW7ATrKDbol5oHJ1Zr7gyes5E6/q8sxqvNO35asU2YSD6xm7STnV66bNTQm81WZGYxQ1AyT5Ta8ohF3niGKppWOYZlC1xDp7mGhvb5rfQtE4KHEOkg9D4gzaH3tLDOaE5U2XRdzWWclrAmqgnYkl3cTfUwSNDuIK2Dl0xCgNdWUpV63m630bL516o5RBK70ukJk8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by PH3PPF33C709630.namprd18.prod.outlook.com (2603:10b6:518:1::c91)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 09:14:45 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 09:14:45 +0000
Message-ID: <42e7024e-43d9-47a2-9816-229aa8ee4d2a@axiado.com>
Date: Thu, 27 Aug 2026 17:14:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] hw/char/cadence_uart: Reserve MMIO with dynamic
 size
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 163wangjack@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
References: <20260826074635.2850931-1-kchiu@axiado.com>
 <20260826074635.2850931-5-kchiu@axiado.com>
 <5e22ac73-0650-493d-a099-c88cbb74b397@oss.qualcomm.com>
 <a3210074-7795-4a9b-b72e-aea0efb53664@axiado.com>
 <33c9db8d-2004-482a-8d86-5400252fe2d2@oss.qualcomm.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <33c9db8d-2004-482a-8d86-5400252fe2d2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0032.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::13) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|PH3PPF33C709630:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa075e1-f71f-499b-e65d-08df041ba29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: MiCy/xfZZOIMnQfZcVzUsElU2qB6zJZqTRODaWLIS/6AZW+vZPOJJWxmfjiSYflb1YODd3XH6t0M7oNtx5yUuu8qtKBCho8vVJpwfT3E6dIZ5lWlPKoXC4lbjuICZSmzGa9M/SRGsYR6Fwsl/x1WuzgEukKCZMrK+mysc0n4Z9jlM5P5dnWWUbWo61gtAM76qe3GxFjEfE7BYrMpJLp3SnnbJX+UzI1DW8hvGvI0tedmBDYIQwdFdnhKrhVQ2e9tl0OOtTYK2WxvvRW0esrHM7oK/FMcCFjbRgrvPXb/TOXEn0qHUWsGhIxlqdq+p6EzL7Xrc+GntGCliib1ZIXA7ogsmxwMf5Udaw9cRd1J7YJq0EYpqFILTOkwYImNjsWKAwYLXKtt3O7WAjCDqIj8NiP7JelcrAAxpjNFWFsV1upV73z0pEnbGqq2xQ93RMR/Fdhkgu8Kv09M1oXvv3U9tbo5FWpUhX7bHWVKwG8Dda2cVYtI37faSNOCjOPDUZwCDXHVO2ly6ovtB7tEpD6Qy/EMMlik2hzN55Ehjq1+iji+inZi896+CaMZtb1SPHxg5jjWujQdj1rAuubY7PwpQSKMMH6P0H48JmJzK+QIp94bPOJ1Zvm2dz9SglxUD6NxGqyuhxshDfzbzeWbaTGupcYILTdK761n0UrUeRoGphA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2wwMXdlRFd2YStzTExiWEFCYVE3SU82aHNFRHZqODJGQzZzWUV6bHVPOXVj?=
 =?utf-8?B?ZGQyTU95OWJiUFpmbFFUaWtaYWMvSXpTMWJ0eUMyREE4Mi9mNExiM3JkRml1?=
 =?utf-8?B?SytqU3g5TWdiK1NCUkFoYnMrcVRKSXFwR2g0R2xoM01SYTQ5YWNldXd2aWto?=
 =?utf-8?B?UEpTMkQraHVQSjdoN091V2o3NjFIZkxSMFRvTUpzRkUwSWFyd2FIMHhqeStu?=
 =?utf-8?B?R2FQc3NGeGU2UXRsSFN0TnVtV1FlUGNoZWx6ZXlkenozdDVXTHVoVFRaVC95?=
 =?utf-8?B?MTJ3amZxZHQ0ejBwV2N5Y2RQRmcyS1RGM3dEYXlTNkV2UTY2ekMxM3FIaDRB?=
 =?utf-8?B?bGVxNVRkQ09GM2JjL3V6QzBNMmVlN3Z5WERUNC9kUUw3MkEveDV6MTE5bWFJ?=
 =?utf-8?B?QW5UYmdKdlk0aWlrVTFUVThyNU9scTlHNFFSNTRYN29KanFjd21xV2hkSFVq?=
 =?utf-8?B?dVEwN0U3Mmxlb2tnWERUY2htSUh0R3Q1QXpJTmdhWVpqYWtFMk50RnNZYkJT?=
 =?utf-8?B?cmVqdTVSdjZ4YnBaMWt1RzgvanVad0Q5OXJqeEE5eHE5Y2dPc2ZMNTVKdFRR?=
 =?utf-8?B?QUk2TVhha25MemJJZkNwOW80SVlJaXhzdXdRRzdWTjZJd2Q0Wk0zVUErSWkz?=
 =?utf-8?B?czlwSmdTTk1nMTB2RVpLMUlGYWtuVVQwZ2JJK0xDdnN3dUR3NC8xRDc1cmo1?=
 =?utf-8?B?bm9rUEpGN2lXSVQ5UFd3MzlSMDdJa3NHdHNHNHVJa0pHVllsUDdTOXZwZ2dh?=
 =?utf-8?B?eFpNS2ZnT0xkOUVOWXBNdU43bXhpdjFGVUVsL2NKci9CYW9JdEVSYzFUN0xy?=
 =?utf-8?B?NUlLY0szSHlLSlBPcTV4djhWa29XVTVsK1Joc1lEQnpkbHNmSWxKc0xSNWZz?=
 =?utf-8?B?NVIyd2NJWTBoUFZVeGZrV240c0FQd3N2VFdvbUFxNlpQNnFwdkJoY3ppU1JO?=
 =?utf-8?B?V0V6c0tRU1dwcWt6M0V6Rk9QUm5DeWU5SlUrRHQvY1ljUWFIWkR4VFVMQWFG?=
 =?utf-8?B?TG5tUTJmZDJLd0xQTjF1Ukl0b3dFbUVGMjB2M2ZVeUpxcWdQc2syUk8wQ0J2?=
 =?utf-8?B?VlY1VEc1ODJkb0o5cnFXYi94c2d6L1FiWGxpR1dscEdKMTN3bXZFbUt4Q3g3?=
 =?utf-8?B?ZHUvSWU5MU9HQjVzTWRzNGtHZzIyUEdrNkFnREtZbzZ6eEdiWktOS2dzd2Q2?=
 =?utf-8?B?ZEFmOEpFR0QvUVcwazdhd0xOZllDQTQ2VGsvYXEvM3J4R0tLOGlyRlFMNmNl?=
 =?utf-8?B?SWE0Wm11TkJRK1dYcU5jZVV0T29ZRzJQbUNUeUpZZUx6WCs1UjgzODBROWlC?=
 =?utf-8?B?dDI5a0c1QVBPNFh6Sk9wSVdhRkczSTVpeWRvVy9jUXh0VXJRTS9MSG1YWU94?=
 =?utf-8?B?UEFTWnZVYXBXMDQ4T0RjMkhyRXJ4cHFHSHRrbGNqVkhxall4T2tKekthSnJB?=
 =?utf-8?B?U2FQWXBHT00xZllhVEVZaUpldVpIYlVTOFo3bUlkQ01iWTQreVdTYmhYRUN4?=
 =?utf-8?B?MjVNQ3FHMmZnTXVFcFlEcU1SM0loaXlLVUZiSUgzc3QxUWMxQ2JDTkd6ajM1?=
 =?utf-8?B?NHRpYTE2Qzc0RHg1czQrWDJqU2lyTkIyTXp6MlZKUTM1M0NTNFNxNmVKSUlX?=
 =?utf-8?B?OEh2WnhPbGc1OGhacVBPUFpVMi8vK0FUS2V0My9lOGZlQnIwWW5WTXNnNjJo?=
 =?utf-8?B?dFA4OUJDYlRrWlU3bDhONzlYTGtyZGVlMytDZjVIOUZWdmxXMkdVVjVOd1VT?=
 =?utf-8?B?K2pNV2dKcmFFa253a0tjUWVUYmNIc0hHSit4RDZ4T3hsa21yekFuSXBsV2tl?=
 =?utf-8?B?THV4Vml4MmxwTkxPR0dDUHhXV0Q4SUtac2tyNWRYczhvaTRva1J4Rko2K0Jo?=
 =?utf-8?B?eG5oc3ZKdCs4Umd3RkZNK0F6NUdrMDlwbEFsanVHdlpNd29nSWRUOE1PeXRy?=
 =?utf-8?B?azVOSjg0TGt0L0VXdGxrNzJsaW9hZTArenVXYW94enRqUWREWkphcFhFWkVS?=
 =?utf-8?B?WGdVYlg2Q09KM25yeVk1RnpraEhBTkovSGppV092cFNyWHk0dnc4aG5Ja1Ar?=
 =?utf-8?B?Q0VESEhqcmpIbG9XTHNndWVIcFVLRE5rekVFY2NjMFh4S1BNbDg5S2xldW42?=
 =?utf-8?B?Tm95bjRoR1IxWWF6Z2wvMVN6bTBtNE9Wc1ByVllrakg0V0JnWU02TVJkQklO?=
 =?utf-8?B?QlJRU2lkelorZXI4SkhlRFppU2s1Wml1aE1Ib2Vzd2t5eTNyUk1JR2NHM3RG?=
 =?utf-8?B?WWhZNEtsNnk2T3pySEdxUlJrbzF4R1pPelNYeU90TE9Xa3pncHNNb215OG1B?=
 =?utf-8?B?dzJEN3NGOFNiSk1BdUZlcy96K1ZFSHlncFd5cXl5NEN5bUxqT2h4dz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa075e1-f71f-499b-e65d-08df041ba29a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 09:14:45.0131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kX1Cgwq/2hhKfTMYbmo2IhUiJGg10UtiryDU1/UQlSckoSEeIlv5Mubns8r/DxnEJ09kPOWkLnyBnDcekJZwUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF33C709630
Received-SPF: pass client-ip=2a01:111:f403:c105::7;
 envelope-from=kchiu@axiado.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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


Philippe Mathieu-Daudé 於 2026/8/27 下午 04:50 寫道:
> CAUTION: This email originated from outside of the organization. Do 
> not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
>
> On 27/8/26 06:26, Kuan-Jui Chiu wrote:
>> Hi
>>
>> Philippe Mathieu-Daudé 於 2026/8/26 下午 04:11 寫道:
>>> CAUTION: This email originated from outside of the organization. Do
>>> not click links or open attachments unless you recognize the sender
>>> and know the content is safe.
>>>
>>>
>>> Hi,
>>>
>>> On 26/8/26 09:46, Kuan-Jui Chiu wrote:
>>>> Candence UART model is reserving 4 KiB for registers statically
>>>> For other SoC models, the MMIO size may be not 4 KiB which would have
>>>> overlapping sysbus regions in QEMU
>>>>
>>>> This patch adds a property which allows other models to revise the 
>>>> MMIO
>>>> size and it is 4 KiB by default
>>>>
>>>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>>>> ---
>>>>   hw/char/cadence_uart.c         | 8 ++++++--
>>>>   include/hw/char/cadence_uart.h | 3 +++
>>>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
>>>> index f57cad57a8..d83c71b877 100644
>>>> --- a/hw/char/cadence_uart.c
>>>> +++ b/hw/char/cadence_uart.c
>>>> @@ -541,6 +541,10 @@ static void cadence_uart_realize(DeviceState
>>>> *dev, Error **errp)
>>>>   {
>>>>       CadenceUARTState *s = CADENCE_UART(dev);
>>>>
>>>> +    memory_region_init_io(&s->iomem, OBJECT(dev), &uart_ops, s, 
>>>> "uart",
>>>> +                          s->mmio_size);
>>>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>>>> +
>>>>       s->fifo_trigger_handle = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>>>> fifo_trigger_update, s);
>>>>
>>>> @@ -561,8 +565,6 @@ static void cadence_uart_init(Object *obj)
>>>>       SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>>>>       CadenceUARTState *s = CADENCE_UART(obj);
>>>>
>>>> -    memory_region_init_io(&s->iomem, obj, &uart_ops, s, "uart",
>>>> 0x1000);
>>>
>>> Are we sure this size is even correct and not a copy/paste error?
>>> We can clearly reduce it up to 0x80 (so far the last register
>>> implemented is R_TTRIG at address 0x44).
>>>
>> No
>>
>> It is 0x1000 since the first release of this model
>
> QEMU model use 0x1000, but what the datasheet says? I'm
> suspicious using 0x1000 for the current model is correct.
> Can you point me to the datasheet please?
>
This is the datasheet provided by Edgar previously

https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/UART-Module

>>
>> Sure, I will change it to 0x80. It would be a simpler fix
>>
>>>> -    sysbus_init_mmio(sbd, &s->iomem);
>>>>       sysbus_init_irq(sbd, &s->irq);
>>>>
>>>>       s->refclk = qdev_init_clock_in(DEVICE(obj), "refclk",
>>>> @@ -621,6 +623,8 @@ static const VMStateDescription
>>>> vmstate_cadence_uart = {
>>>>
>>>>   static const Property cadence_uart_properties[] = {
>>>>       DEFINE_PROP_CHR("chardev", CadenceUARTState, chr),
>>>> +    DEFINE_PROP_SIZE("mmio-size", CadenceUARTState, mmio_size,
>>>> +                     CADENCE_UART_MMIO_SIZE),
>>>>   };
>>>
>>
>

