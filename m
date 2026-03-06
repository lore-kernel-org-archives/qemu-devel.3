Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2895F01804
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyPyX-0004p4-TF; Fri, 06 Mar 2026 02:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vyPyT-0004ov-61
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:51:53 -0500
Received: from mail-switzerlandwestazon11020123.outbound.protection.outlook.com
 ([52.101.188.123] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vyPyR-00057J-Ev
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:51:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3+wPwUy6FYgfSB6kwU0ESC+Co/UeWdN66voHnDSWcFIuR3BZecPoLA6FAfQYzoaG4x5AMoYqPs3DB2QvZVr9a5z51L8XH1CyIr+nCx71D8QefuteLS6+ysLAshVDKNRa+FHku8n0I969eFyvwBGlDSCS8Y/g64sOZN/tCN2YDSRTCsLkbhUSj1F/bVXzUnZf/aDKtmw569Iz5B9kXhojSe+JqAInz1+KP9Vz+OCHTEhfwy0NhSOJgr1UfXNH/hDbzJkge7WWjhEZX1AfF1+2qkzKMCpUnkmRLKY+TGSf51iqzsTzsEDG9MgIOFicqETbybxEm4U/hA+kSt1hKWEMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVKtD3e+ObH2SQcoMvpD4tO+IF2MH1X7tLchLu5Vq6w=;
 b=BsOhrf6y6qXGuDZuNQvCe6nirAlmnkBWYdrKGZsCrQPq7rY6ddUMSbSR06S1VAHBHh6Tuvq0VD4uY8rkOvl28hfQ6JqE0NuYA01cROhdfIcCLb36EDmWWp1iFye6SsBvtAykE1eHzYJKcmJf+is+Bt/OgQC0pC0KieAmA4sH5WIgJAPiukY9q9ILdhhTaMallEeH4ssrE6DyLd8FEYafNf1UJQGYZDVbYICFpaxvxTIar5omM4WBi7FPJNTR5OPYrkXN/tun8XMLcfHTBHC0R9x9QG0MHv/DVBrleIJBrXaew4+88v+WGVXtPjasJmn2kUoUH0+Z6Sm4Vx4okstcdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVKtD3e+ObH2SQcoMvpD4tO+IF2MH1X7tLchLu5Vq6w=;
 b=XhkTHJ1yal8rchpisZOcjjstY2K38M0OoD32ephLXgYWLna+J3T4Mp8gmVQFE8iAsBo4ajA+JO5bjUMxXDW15QZpDEVYE5v27Zl2EqQLhCvvasVWvwlZRbCqAcQXeEoVXCcmiRNOF6WIYqENSdG+2z0lbzSDqbpEGspqvbK6sw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR0P278MB1694.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 07:46:46 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9678.016; Fri, 6 Mar 2026
 07:46:46 +0000
Message-ID: <793d5cb4-686f-47fa-9188-b13818f2a283@epfl.ch>
Date: Fri, 6 Mar 2026 08:46:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/8] plugins/core: clamp syscall arguments if target is
 32-bit
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
 <20260305-setpc-v5-v7-1-4c3adba52403@epfl.ch>
 <81547e70-5b7b-41dd-89fc-732f4209ef61@linaro.org>
 <6a344053-bbed-4d3d-b12a-aa8664ce132a@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <6a344053-bbed-4d3d-b12a-aa8664ce132a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0025.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::12) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR0P278MB1694:EE_
X-MS-Office365-Filtering-Correlation-Id: 12531cdf-d57b-4e96-8f89-08de7b548495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|786006|376014|19092799006|7053199007; 
X-Microsoft-Antispam-Message-Info: wtqc6EEUEpzV0WxuQvuiEWd4y18/WJa00rUT8gvCd1RTSfIxqhfDCrCz8bg8P3Eprwa7/h69k55TQWjfl4Kiz7Y9oNlSbdjfukf1MpgioTq3PBzbiUfmVeP3khGi8+xR865ThUR0UPlsVyuyGHL/WRwYvpQAep5nEkopPsdP8qVWQX8QJ/BXYUchvmWsiXmJ9m9buinwdqrPmorhZqjReRkPivfcXdpRw1NRh+nWLtVYZTdeJAfSnJBohJx+FJk0EaB4Psw69GPPB2AexrDmPw6nTOYoDEe6dDDnJGE0za6HvKXhx/9TwYAjacUaTU8D1ipetHyMGEZdZvKtNdvaxePHKC5rOY4zGkx2afLiawSOYczXgl0pbdZ77lK+NE7Mi5IUFFbcZsXIVIo+4jMRE8pvgnzEisBl5ZCsN/otLKSaGm3qkuw6E9+ns8zAAWGkSyvXZhIsiar2zZGZY2BTKpavjCA5V9hk6h0BnT0xrmqj0IxECei0nXBrzsXzwy8uSqUFwTFIE37OB2ab49VQbBlP0LrXQUEVDHQa7jijit04/HRjQQGku7CCtLgEDtEF1qniNUkmOhnWkC9UD7oW7KhM5E2KpzOqHG7IXtTdyZZDmPAewv0/TEH8hN1wS3QyaXU4/8yk0Y/XcXEgFQnsMIA27U1+8Sv7TAUCLgXfy2w7IvP03vk/S4hl2AEW8V6DLMEoOX3C6gxGw+6pSfOZTFlExdb7ok+sxvdDbjhNo3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(786006)(376014)(19092799006)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3dDWnBtZHViVGFmUnNsc01KWWluUE9aU0k0R2tRczNRVVhmdk1vQWQ5WEhU?=
 =?utf-8?B?VGdzelk4aGhjdy8yTWdEd3ZEdDR4dVVzTWRMc1FsKzBZeVNMTXVycTBPOHRF?=
 =?utf-8?B?M2JGN1BaRUwvM1RKTkoyYkh2NWNsRnVqNlpTK0ZhZktab1hVbWhXeVJKUktB?=
 =?utf-8?B?MU9VUWFJaE1lNU9hMkNoamtQNTZpTnoxTldlOGRZck5kaDc5T1FDaFo4aFhL?=
 =?utf-8?B?c05QOGlkMnB3dnpzVEtRVVpRaTFvVitTY2Q5SmwwTzIxSXRxUER1b21YZ25q?=
 =?utf-8?B?R0g0YjduSjBwamVtbmVwL29RTE1WbHJXam9WK3Jqa1BkVTQ0QU1aT2t5UzVD?=
 =?utf-8?B?aXN3ZWEya3RNUG5zUk92YkxhdEVpWXRQY21vZ3Y1SmFQUlI1YXZSWHZGU0Zj?=
 =?utf-8?B?bjJxNnZjaWZtL3ZLdkdiM0JVdkdhdStadWJnazg4bmoxVkV4OSt3bGRsMEJu?=
 =?utf-8?B?M3JZRmhMYmROUENlRzMwZkJkKzlMWFFzUGNjUHJhN050Z3p5ektwanZjOERD?=
 =?utf-8?B?MjBpOVE5MkdnSXVlU0xFL3dScXBoYWZqbkJ1Q3Y1MXU2Wkd3Tm4rbmFhREls?=
 =?utf-8?B?SmJUMFdiWEdoaHk3NmZwVXJISDJId2ViRmVwKzZ2RXhqQ0RQcjdhMnRZR1R3?=
 =?utf-8?B?WXIwQnlETVd6eGc5S2RMQk92RlE5ZnVGUDlVd3phOHNqWCs0R0lxNTRwVTFI?=
 =?utf-8?B?NEVZS2l5WmZGQW1hWHdDckFqemhXVVpFUVd0eXVCYjZjTlBNelNWWkE0b2Qx?=
 =?utf-8?B?Q1lma0QyVFBMK1MzamxCenpmTDAzdEY4andsZE82dFJ6c1duQ2U0MjNyMUpX?=
 =?utf-8?B?UzMzcXlkVFpncitIS3hYNHMwblpzbmZjNkJLVC9zY1ZMTjZpaGgyTVMxdkVp?=
 =?utf-8?B?TFRQWkRrdmpHUTlpMm50VHBxUnU4UkRnYThlUDVzRm5hUTlsUHptMkhZQmNv?=
 =?utf-8?B?RExXdHkrRnFwTjVaT0VGRmZzMTdpa21JL25JZU9VVFc4RmlMSE5sN2F3YzB1?=
 =?utf-8?B?dm9VMU9yTFNTdG54dE9mUWxRTlB1Q05xYWN2VEZ6SVE5VU1NMVlnSmZmNUhy?=
 =?utf-8?B?ejdWZ3lCdkxYSjZoK21kYjNsR25jeVhERnNRMVlJQnV3WDBFclNVZVJzb0Jq?=
 =?utf-8?B?ZGh5N2FraDBNVTFEbW1WbE9OeXdWMjNTeXppcXlva0h3bkRFL3Q3Y3B0cXMv?=
 =?utf-8?B?MWthcTQ5ZEpvaHhzOXhqNjB0TGhXa0lPQURuN0hUbTA2MHgzQVdudHExQXJa?=
 =?utf-8?B?SzBUVWMxWU9qM1E3NXVzMGRxZUxKTXZOcEorZlppQ3dvTXp2K1Y1YzFPempF?=
 =?utf-8?B?TzZiOHk0VHJYUHo2UWFGajRJbmczKzhmaUNjRWRpa2VDV0NBb01qNEVDbVM2?=
 =?utf-8?B?SzN6M0UrVWhnQTBwcFRWSTZ0SHJBU2hwUFhFc1ZvaDZ4WGllSWpOcjN1dmxN?=
 =?utf-8?B?L2dMazNxd1IraXphY0V2a2gyNW52cjYydEdVdnNtaDVsL2FIdDBTOTlEaGJW?=
 =?utf-8?B?MjZMQW84RmIvQm9KRWZZV0JMMklXcFp4S043UWxpTGwxc210bFZvbWR6T2JZ?=
 =?utf-8?B?MnErNzRRaTBpaW9rcTVCbGRuUmZFNDJvam5lMnRVTkp3aFFtdkxmbGdLQXpw?=
 =?utf-8?B?T1Y4Y241QUg3UDJOOTY4ZDVqcTlLcEptWmtwZTlsRzlwN2tSNW1PVUR3RUtm?=
 =?utf-8?B?OTQxSzI5NGlDdVFKY25VRjA3am03ai93YXNJbThORDdra0gzQVFBUFp2Yjk2?=
 =?utf-8?B?Z3k2R3haR3BOK0xqeGUzME9YZFYyVjJ1SDN6Smk4WUNNZmNOajlsVHVENWNp?=
 =?utf-8?B?Z3c2bk1sZnBGL0RtaGhRbUlLa2JsekY0YnZxcXlkM2FoQU9Ma1BhbXZ2d29C?=
 =?utf-8?B?S1gzN0g0L2xmOTAzVEtIMFZPcGVDelpmWXVYVVJXZkZzSkcxTjh4T0lEMWhz?=
 =?utf-8?B?T212YTVwTmdwbkM3WW1XKzFHZXBQWDBKK1kzeGVHMXJPaitlMlRtYXUyVGI2?=
 =?utf-8?B?Zjh5NXd3eXVxOVBoUVppejRZZGExZzkyWmpZaWwrMXdUMldJY2FPcnk5NXQ2?=
 =?utf-8?B?MWFPcGh5ZVQrTmY1QVVCRVp1YzV3Z0ZFZTViS0VnNTNyNjNDdUpqOEduVm5Y?=
 =?utf-8?B?dDA5aWVRZ09vbk1iNXJuZGsxRGs0Z0RwSlh1eHRFZ0pEM0dCYjlyU1VTSzFx?=
 =?utf-8?B?ajVuOGFPRnI4MjhGU1FIU3o4bFF3VUZ2V2VIejFBNUlTbmRkR0tzTjhRSkhr?=
 =?utf-8?B?MlhXMFVWbTBtYUZOREMyeEtOOGIzUlplSTYzMEV4UW9NVHhEYXZZdWxhbVl4?=
 =?utf-8?B?WkFNR0x4cHROYStSYU1BazlENUR2TVg3QWJrZi9KOW1sY3p2YmFTUT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 12531cdf-d57b-4e96-8f89-08de7b548495
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 07:46:46.7420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSAQqS9vPvNe3HYKy/nG5xq69cAuDE4uceanBTh+kksCmKWbkyloKbi9K7pwkzoTDTWtRghP++JsfMt8aIOVBGkSDO/VbGmPo3zCLQZRFU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1694
Received-SPF: pass client-ip=52.101.188.123;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 05/03/2026 18:38, Pierrick Bouvier wrote:
> On 3/5/26 9:33 AM, Philippe Mathieu-Daudé wrote:
>> +Laurent
>>
>> On 5/3/26 11:05, Florian Hofhammer wrote:
>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> Syscall arguments are abi_long in user code, and plugin syscall
>>> interface works with uint64_t only.
>>>
>>> According to C integer promotion rules, the value is sign extended
>>> before becoming unsigned, thus setting high bits when only 32-bit lower
>>> ones should have a significant value.
>>>
>>> As a result, we need to clamp values we receive from user-code
>>> accordingly.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    plugins/core.c | 21 +++++++++++++++++++++
>>>    1 file changed, 21 insertions(+)
>>>
>>> diff --git a/plugins/core.c b/plugins/core.c
>>> index 42fd986593..d6173422e9 100644
>>> --- a/plugins/core.c
>>> +++ b/plugins/core.c
>>> @@ -513,6 +513,23 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
>>>        }
>>>    }
>>>    +static void clamp_syscall_arguments(uint64_t *a1, uint64_t *a2, uint64_t *a3,
>>> +                                    uint64_t *a4, uint64_t *a5, uint64_t *a6,
>>> +                                    uint64_t *a7, uint64_t *a8)
>>> +{
>>> +    if (target_long_bits() == 32) {
>>
>> IIUC this is related to the target ABI, so maybe we want to
>> unconditionally use:
>>
>>      const uint64_t mask = MAKE_64BIT_MASK(0, TARGET_ABI_BITS);
>>
>> Maybe guarded with #if TARGET_ABI_BITS < 64?
>>
> 
> More broadly, I really wonder why we use signed type for syscall arguments in linux-user, while I think they should always be unsigned.
> But since soft freeze is coming very soon, it's not the time for a refactoring solution, thus this pragmatic, but correct, patch.

If you think it makes sense to refactor this for the next development
cycle/window, I'd happily give it a short and prepare an RFC patch for
it.

> 
>>> +        const uint64_t mask = UINT32_MAX;
>>> +        *a1 &= mask;
>>> +        *a2 &= mask;
>>> +        *a3 &= mask;
>>> +        *a4 &= mask;
>>> +        *a5 &= mask;
>>> +        *a6 &= mask;
>>> +        *a7 &= mask;
>>> +        *a8 &= mask;
>>> +    }
>>> +}
> 

Best regards,
Florian

