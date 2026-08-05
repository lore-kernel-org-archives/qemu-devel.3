Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB60C55ABF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wravR-0006qq-8h; Wed, 05 Aug 2026 08:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wravP-0006qZ-GA
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 08:40:47 -0400
Received: from mail-japaneastazon11023111.outbound.protection.outlook.com
 ([52.101.127.111] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wravN-0005NF-6Y
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 08:40:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+u0I6Y+HoTicy6J/je9lLbozPrPjfUAzrazN6k1CJh0xRqpujbAz03BVwx1QAc2uoZemauS+t/Q1vG50GEM7qvO/Kr1RWyjGMsmPF01ZbkQq5P8BzcvVPW+rFllXOOGylX0WQ+UjxO5oY3IGtIlk5cZKTvjeRRkLkF3GLHFrMNi7I8Z+aOlPF/pxRFDqbACryYfl9A+eiMZAPZ54g4IQBU32rBuCGs1JZ7KMejPWas/19HKG5uhzR6hflnh/GSeo4QLfg3REXTOWnDDR+r4mH9ZTyReQixBdDCTjW+VBDqCIMC21ykBuRluEmXK57mswxa+UaTSTKB9hTeva7DRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYNDbWSVlZSLtboEWnYDhIbEPlvqOTcGqkbUkyXHDUg=;
 b=utE2LksnzDBldVs9NQ41D3dKC64Kv886vMlfkGaaLR6fvHsmi8V4qw2W8TOHW8NMTYzCCs3IMaI5a/+W3kRhXX+4YSW0rl7DIRu7gde6tqoCi5ccdrYT/7bXSvBEdgcvp68gt4NyH8x2m5iTaSfwzYgm2aOG3HluWc036IfkpH90C2l/56eRYExcvfMM5fBQoDk18ORmSj8r89auUE3oSgguILQXy9H32ePPKUiOAinU9dw+6/le41y8qTWFnMKwJMN+DC8EmggfdUVkAUebu7XFMtuIupvdKGFNqrzNcFkeV6M3+Hx9fGtuW274ukjYQnmpMi2DuGaf9bRme7gkaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by TY2PPFBE94497F1.apcprd06.prod.outlook.com (2603:1096:408::7a5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Wed, 5 Aug
 2026 12:35:35 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%5]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 12:35:35 +0000
Message-ID: <20b525e7-4ee0-4db8-9314-e30dafce439f@linumiz.com>
Date: Wed, 5 Aug 2026 14:35:31 +0200
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 christoph.seitz@infineon.com, David Brenken <david.brenken@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 00/10] target/tricore: MPU, peripherals, tc39x SoC
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
 <9f3952f1-1794-414d-bf7b-db7a5094ed22@linumiz.com>
 <cfdde0d6-77fa-4216-92ac-bdf9b9b26087@linumiz.com>
 <1ecb1dd7-5d47-4304-a0f0-bfec305fb859@oss.qualcomm.com>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <1ecb1dd7-5d47-4304-a0f0-bfec305fb859@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::8) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|TY2PPFBE94497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 9edefe31-df7b-4038-c1ac-08def2ee0bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zwhopUQj3hG33jGZsNsmxuIltl/SWulx4Nj5JTGhdlCkhXqfkM0RWNAVdgJnenGd2f/+KC/ZjyvHkb1JhnMBj+VLiCdpe24vk5Ri/68DA1Jhc45DZW8TDC/WUKcymhR4a5X8k2yybzzOCk5LniR1kC0cN0glf9/tV9j3JlI6H3Oi5A9nWI1XX491hTJ2CejU2rsO+WLu0CYnu3j0ZEFrRztFzxRlN4RrJtFICN6Ta4ruB+Y98aQHZoK6YlCAzia9hb4ltp2Me5wnfYYxz6esxDl4TFs/XbD4uxuaYzJjP5nNM4r99LGEzEFkObhZXm3tkFYgVT6XVWCYm27GAFELLuVD8oS49ebc4eRYV/n/bTAo0puEnPrk3HK1j17Gry02ZLzt17j7mvLHF/JVQnecJLO+n9UUsU8lgXVAgBPBsWz0hfEF+QJnPF+QwPM6pdRdX/hgngGuAqeg3AlnpdDfu9fFLeL+hYMJ3AtwWEtWDKDDOQeEaUYvtkU+VWI4kmY5ByVjE1Ko8YPxoIIC9WzTKYZJCRu9DhNP707yaMeT6tjlGFcyERh0uJIWYtCZMb/PUCb1bEnvpQhTmMv1TTdeCm3VqnSq7T1V8YS2nejEma4AGX4Wp1SNzFfu9mSINxS1JKIBXr3h59oe77g11NubGh3yajVzHMBACFVpFmx2RzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alBzL2FZc0VlazZiTHBSKzNSdjRad1ZuYVZhT3BkbE80dHFyQUIrdnBlakxy?=
 =?utf-8?B?a2FyVEY5eVFIMkZHMG5ab3JoNzFrSWJQUjVmSXBRRTEzWThWcTlFejh0K2Zx?=
 =?utf-8?B?bFZ3WDNkZXJac2JDQTVxV3ltQUFkdXVSNmRnbVoyY05keXZiajFSQk54UElr?=
 =?utf-8?B?REQyZ1ZtV1BOY2psTVNNQW1oVnpNSHJwSmxCMzMyeVkzSVJQRmVpaVFadzgz?=
 =?utf-8?B?UXZ4bWtOOTlQWVhrNTFScUt6UmY3MjZZUjA5SlBHMjR6T1ZuSzhqOXp5VnBS?=
 =?utf-8?B?TFRzTGgwL1J4N2UxbEVvK05WZE1aTkZpWnFGbm5NSy80cWxqZlJvWHdvc0Vn?=
 =?utf-8?B?amU0T2dabTIwdG80aTdZMmN2ckRtblFYN2dXTGpMZDhmQ3l6K1IvNmdjbHlS?=
 =?utf-8?B?SU4rUlp5bGhmcG4zK3VTbzh2Q1Z6MHFRK1FLUXIrNXFqRmNnaW5iaE8wbG5t?=
 =?utf-8?B?NmxHMU55SWEzNDUwSlphYnJNaWZhK2xlNFFuaFVybEpaY0EwM0JjSFY2cjM3?=
 =?utf-8?B?aWp4cHY0akt4UVkxdmxFUHFhYi9PVHhhZGlVR3YrUExYM1NCYVVRTVIzVnFX?=
 =?utf-8?B?WXhEQThUa1RMdkpFc1c2RGpOdUhsbVZtQTNQN3E2OFQ5UVVhQ244RmczSTVM?=
 =?utf-8?B?aFZjTG5wYXo3RElTUG9KUS9NSnorWU1ucXBncWFjSkZwdVplRTFEbTI4Yzcw?=
 =?utf-8?B?aVhJZ0VqM3hVcFFZT2xpa1grQy9zOG9Zb3cwb3RvTU1DYVNYWDNDRmluQ2h6?=
 =?utf-8?B?S3dHNVZ2aHJSTWdGYnRyeWVrbS9HUmRrN1ZWSVdxQnFLQ014K0kzRUYyME1k?=
 =?utf-8?B?bWh6aFJ5eVNGZ0xBY0ZmblIwcmxSN3NvRWpYcUVIVWlQUHY2V2FXUU5yRml5?=
 =?utf-8?B?NXZiNDlGNTBJcUMyUGNhbFduc3doRnA4NmpZV3FHN2NaaGVBRkdzT3VVMEEr?=
 =?utf-8?B?VUI2anFJU3dsY3FVTDh1UzNwTXFnSDFCdUlWRGVpd1R2NTBVTG9MTzZ3Zmg4?=
 =?utf-8?B?ay9sbEZZTDVCYlJ0Um1GQmJEZkFpL0trR1JVeWNnczEzRStRR1NGZzIvNUox?=
 =?utf-8?B?OEVPZENiM0VXVkJQbXhBRXRhOTdpQjB6ZnlZZW1aVjYvRjlJMlFaQzA3SFBS?=
 =?utf-8?B?NW5kUUd4S2pOcE5HTFZHVE42RW9veEp6bnpKUENscEhjUllMeU1SL281amQ5?=
 =?utf-8?B?c0IwRWtxdjFDN2xsUmJ4QVhIK2VkYk1WUDd5SUtoKzBheTArTlZza3p5NXBM?=
 =?utf-8?B?TldJajU0SlRoeSt6RE8vZUtWb3NQajZYcXk0SzZ1d241bE4yaFpnMkpabTJ5?=
 =?utf-8?B?WUd5V1UwNHRpdU9MK1lpd1lNUWNlSklrWjlza1VKR3RLUk4zQkxDYzJJRXIv?=
 =?utf-8?B?S2hETzV2dWJKNi9BNnVqTDJLOWNaa3JHK2dBSXBpN0hPVm1SZmtVRjU5b0Rs?=
 =?utf-8?B?cUkvMXpVTUdva0dDYThhdGpESXlDa1h4ejdRQ01rMklxL1VtbTFFMWVqWWx1?=
 =?utf-8?B?bEFRRXdxQ052UmFKS3VKMlNlNllYcHd1RDg4ZENDa2tyQmZLY2xGZDltZzRP?=
 =?utf-8?B?L3VqdU0zWlIrOHBJSEpWckVrMkVnQ2hiQVJYaHR6eUg2enB0TFIvYlpUV1pY?=
 =?utf-8?B?am1hLy8vRUlxN1NibHo3T1VHZFhiQU1WMHNCQmN5dXY1bWNSUFlqWEpQczJ1?=
 =?utf-8?B?TE8wYWpzN3pOM1FndTcwcGhFZnIrVkF4SC9RT3QzQW53NkJiTmdsY2ZXaEYz?=
 =?utf-8?B?YmpiRUxTQ1BNOXcya09QOUFSK3g3UTZ2RnRsWWZnTnZabkExY25SZjJNclRS?=
 =?utf-8?B?UGNnaW52WjhYcUpabHV2VUYydHdlcUMwN0dnNlgzZ0JIZmMzdDYrTE5rZmxW?=
 =?utf-8?B?MmF2TUFNZGRCNnN2Vmx4c0VnMnlCT1liRllnaWpleDRvU2x4TmkrY0hUQWho?=
 =?utf-8?B?TEV2VmdjZE9vcVJYaVMxRXNmQVRGdW1QSGtENkM0bUN2YVh6L1J0b0pSWTc0?=
 =?utf-8?B?Z2F5aENQZGMzb05qV0V4Sm1SNTBSazdRQ3pxVmhpN0VUOUN3Y3M3clFiNnVn?=
 =?utf-8?B?MEF5OXFHTEFxV0FJZUoyaWZtN1p3NnlwUHdYNWEvQmpQZHMzZCtURU16VVR3?=
 =?utf-8?B?azFCM0l4Yi91OTZ6VDgyZmJQQ2E3WXlDbjJvaDlQMHoxV1JscDhlVk5HT0NJ?=
 =?utf-8?B?N25QTkJhdFpBSVVzUDg4c1BVSnNMR29TcTh5dnZISFNEQTNWRG9YR090R2cv?=
 =?utf-8?B?dUJtNlUzcXFmQ2xLZnVmeWpTZmdYcS9vMm5wbEpPbUlDL0lHcmt6V1VUdGZ3?=
 =?utf-8?B?QWZhUVo3UGJJUWhMQlEweTJvVHc4ckVMQndScEtTczJUVzdqZjF3Zz09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edefe31-df7b-4038-c1ac-08def2ee0bc9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 12:35:35.1792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jO8a+fBOVP3/HXShWrLUX7WGY0ErlBdnk9uu4SVCmiyQEzSnk4w7v3zE8BisM6mAlMSG48VIN/6278Yue9qD2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFBE94497F1
Received-SPF: pass client-ip=52.101.127.111;
 envelope-from=parthiban@linumiz.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


On 7/7/26 10:12 PM, Philippe Mathieu-Daudé wrote:
> Hi Parthiban,
> 
> On 7/7/26 20:16, Parthiban wrote:
>> On 6/15/26 3:13 PM, Parthiban wrote:
>>> On 5/31/26 11:30 AM, Parthiban Nallathambi wrote:
>>>> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
>>>> ---
>>>> Parthiban Nallathambi (10):
>>>>        target/tricore: replace legacy DPM/CPM CSFRs with CPXE/DPRE/DPWE
>>>>        target/tricore: implement memory protection in get_physical_address
>>>>        target/tricore: add tc39x CPU model
>>>>        hw/intc: add TriCore interrupt router
>>>>        hw/char: add TriCore ASCLIN UART controller
>>>>        hw/timer: add TriCore System Timer Module (STM)
>>>>        hw/tricore: add System Control Unit (SCU) device
>>>>        hw/tricore: wire peripherals into tc27x SoC
>>>>        MAINTAINERS: take over TriCore and add peripheral file paths
>>>>        hw/tricore: add tc39xb SoC and KIT_AURIX_TC397_TRB machine
>>>
>>> Good evening, Ping for review. I know TriCore lags active maintainers.
>>> Looking forward to know how to handle it. I have few follow-up patch series
>>> which handles additional models and also newer cores.
>>
>> Ping and looking forward for initial reviews for TriCore.
> 
> I have this series tagged for review, but I couldn't dedicate enough
> time / focus / energy to start reviewing it... :S Unfortunately it
> missed the next release, but it will likely be in the following one!

Thanks and looking forward for initial reviews.

Thanks,
Parthiban

> 
> Regards,
> 
> Phil.
> 


