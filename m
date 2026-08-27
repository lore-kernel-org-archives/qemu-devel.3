Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB70FC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 06:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzTii-0006yl-53; Thu, 27 Aug 2026 02:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wzTif-0006yY-58; Thu, 27 Aug 2026 02:36:13 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wzTid-0006iw-DO; Thu, 27 Aug 2026 02:36:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5Zfq8E/blx+jlZ+iHWxElgQ/6Z3dJXN9XexnfeddFjfWOyqXsfCVSWZ4ytOsVgvU0cnS7i9lo+hGQY5ls0RyYQNzJA16GmLBgtoEq7YeF7iRd9b7buVHhkCFP1suw+k8JhFbUMVdF7lQEuXNwhl86tSpy2w+El8SnwI6ruLsb0OODR9Crt4j9sJ1DzLnN/8YJyYXfIVbVbB1WBOC3pq6Ldr3XHboNKoxpUtScwPvp7HZz3yXO4tfIGROIcmwW1jczb0GWDTP07BHL2+5a7Ke0T/saUZzDLtcU0kDA7zKR/y8wiMmEyMg0QNo2pSGxvb94oc3suUzPEREXtpAubR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6RGuIJ6LNGn8W7LAgUY+JgJkSqTPIo439Rk1e9+M1Y=;
 b=Lagm3fpqnzziBv7LjIvnQ9h50wpwK0Sm+kMlhWtLh0T5vN+s7O3CLJLggevrb1wmsL3TLxY0dMXpApwJwpaS4KP7Xg6JrLA0Ob+Rx7oOxx7Q/R+2RqYML3dZ8IVwutl4109LLH/KAsh3vRxPDt4SKk92kAYINo2EqdTWjs0ahTJgPeNH7r6Yeef1f8UrCEOUNCwUS11p96xALfv1GWwrFC6S67eAYusV1WeTvKb3FyVx/tdQ262NxpC/ehfbVc0nx6lfAcU3ejVlf2rCns8r+YhCQlv1pq78qKO7eYFForzKrOwDVFCrDZrUxKq3gPDIcHYTl7yHpBeUW4k4Oig2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6RGuIJ6LNGn8W7LAgUY+JgJkSqTPIo439Rk1e9+M1Y=;
 b=EaGRaw73WtDY8FsgE63VkasvnMissK83k2MCtjoB3kcow7lfy9cm3RpdZbxvPE906SoIuxegx5jcnF7Nr9BPFAaiCTlHR0FZ7+sODUMt/SG5eECZHzdw74CJuK7nhYLYmzxatqulhTl9IarC/F5xoVlAkC+iQI5XC8p70Z/Pvq2upqk/pO9Mf1OFLDMeqKJfgTwPDRiYBQe5vOuuGa9kv8pI6GrIf1YyBX3i+5gZJWxyl1VQh5M8DpSaodsaUhL/W2xAElFfxwhrtL082hMT71k6Qiz7q5WjneEHxKd35E6aGn7lL+gs6WDLqzrt118LQbTHlQbX2AOu2NHFTjmFXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by DS0PR18MB5501.namprd18.prod.outlook.com (2603:10b6:8:163::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 06:36:05 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 06:36:04 +0000
Message-ID: <cb69d173-0ee2-4e19-98cc-2f694f3726cc@axiado.com>
Date: Thu, 27 Aug 2026 14:36:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] hw/arm: Add Axiado Ax3005 EVB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 163wangjack@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
References: <20260826074635.2850931-1-kchiu@axiado.com>
 <20260826074635.2850931-9-kchiu@axiado.com>
 <de9dd447-80f2-45a8-b166-beccdd950287@oss.qualcomm.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <de9dd447-80f2-45a8-b166-beccdd950287@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0044.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::18) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|DS0PR18MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: a7def814-cd45-4dfd-34d7-08df0405780e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7z/3DF9nFVT95SEJa33pAsOQVYKF/GLicdIvqycGhBGCSOkyfdL3jrtY4OMLwvuNwe2fQmOp9hqb5aG3ykCBjqU2bwphSUFUZ2tERQOvTLZ7CkadRZbeM13kTXnDQz4FtlZ9AlzLSpHtCwtoqgjaJoupIaiMqrbUH6Gfc8Fi2flKFr3EvvLdJ232WbfxP+LE1ellhxG2kJbTIbhnDF9fgLbhTi6vah6XS500tioFRSvmx7LASsGL9lUZ+N2fTB6q4eG3WM42ZFRalvwMqJP+1cpsWOloWaCm5FdLBvGhivsWDJzFQf/R1EeHESWr2z/PEFTCtcJ6YaH0Sn4nzzoJ/Zj0t/9gnFqbKA5EV4aXAaX+9qARs69ksVgtI+FloTx8B1Uv4rRna0ShZxpTKQzuOCf+oGKlvtS4XIBUmvQYcRECZtaMplJvp6KRSOrqZPN7BveR1MEvMgdKWb4EBIexZ5HPwM6DkiFUPPRVs1H3N9rBqlK5T9vy2Y1+6xSzUgDGZZmehmsq4Al1NOiPHB0B2u3MnecwxfKsfxPkB0ozaYM4bWCpoIiXG5t2msuCvOjnZoANToS1eYG61BK2YUKQpa1Wf3fWIBKjguaACMJGqrdQaO67j5uzqB/CIAPSB5iHt2IPIQ4GtwvQW301GVWXMi+TryOPgtUhEz9LZlLBBnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2grclRwdm9mTU9PNlNpbHp4VnJXenAxNlhJQVpPaEM5Y0JzVVN2eUNVbTAx?=
 =?utf-8?B?cUo4Y2lESXJpeVhuZzV4d1gzd2NWMHMvbytoTE5ycEhETGREN3BSM1lpcHFT?=
 =?utf-8?B?cE9yR1BIeTl0anlYTkdoZFRoMVZheTVFb24zaXVoVTE1ZnV0aFcwVHdIUS83?=
 =?utf-8?B?aVp6YndXZTlmL2lWSnJnMys2TllSaUtadkVHcWZKVzFGQnQwTlBsQmd0YVZq?=
 =?utf-8?B?U2ZMMW1IaEhIbTRFRmZERVg0MVhmTnlUcnh5SU9uUXY3UHBpRU9VNUE3eCtR?=
 =?utf-8?B?aDRTN3VCMlhUdnQyRFh3SitTN09RQk9NYm5kd1pwa3ZqM0IwZXhGWWtJYXJV?=
 =?utf-8?B?TjdQMGxnbmNHRnhXazZ4Z2VBajhQY2NvazZ0YWduR213WVcxRythVXR0VlZJ?=
 =?utf-8?B?SWw5ZU93a0N0REdXUytkRkNjVWVUaGJieGp1am9SMVZjc2o1RXFZVDZqVTY1?=
 =?utf-8?B?LzBEdkE4R3FjZTFub3Q3WTFLcEdZUVB4dzN6aldYSDN2UVRwRjZmd3dQM3FF?=
 =?utf-8?B?VFRqNmZUZytsTWNPcmFJeDZjYTlqN01qTnNXeFppUXRCOEF6STJoSHRrQjMv?=
 =?utf-8?B?dWs5TlVSSXVuMDJUWDArUTdEMzRYVktZbENIbGNEVnlBeTUweG5PRUluOWJC?=
 =?utf-8?B?N0ZXdlRJR29ZNVBPM1pwWDUrWFZHL2tyUCtYa1Qvbm91NUMvNysyM2ZQVkN4?=
 =?utf-8?B?ZTc4V3praEtpSkFyaWJPSGJzaUlTWldKODZvREt2eHIzdGtmVDhqbklXSWtI?=
 =?utf-8?B?S1FKcEVqNzhqbTBTYnI0ZVdGQnFRQ2tHRmg4QzEwNXcxYjdIcDhUZDkwWXdr?=
 =?utf-8?B?WlhydTRNc0VVbWg3bWltcVQyNldLNUdDdGFWaHZKaW1JQzlHSW44b21qcEx6?=
 =?utf-8?B?bU9tTkpkS3pPNnRHL3V3QlEvNXBSc2JjaFp2VG4yMEpsVTVBOFpYTlJLUHpI?=
 =?utf-8?B?MUFZdXprMyswM3RkaHFRalZKcVpYSjdaa3psNDVUelRITEFuOFZ4NTZreEVU?=
 =?utf-8?B?MEtzM1FxYlFucW9IaFBlK3czRnVseGRFbDdDQ08xMTdWUVNYclJFRUdyaVhK?=
 =?utf-8?B?Z3hxWkM0dnlGWStyS3JJMU93Q3lGL1N6WEhlcmJ3WXdZS0x4RVpUTEk4eG9t?=
 =?utf-8?B?cWltRmdyVmxmMVBZLzM1R0t5OFN4OVZGQ3dMQm50UklpcTRBckZjNkdpZndG?=
 =?utf-8?B?bFFyZTVKUzBOZmhIVW9pb0dNSzJ3UXF1Wk5JdGJiZkNzUFdSSm9Tajk1WkF4?=
 =?utf-8?B?QmJIcWhjYjZrTGZ5dmZoUnBxc2Y2ZkJ1NXNsSGxJU2x4UTRYcGhxWDZLSXZE?=
 =?utf-8?B?MjhBMG9xaWVXVm9OTWlOV1llaVlpZmtaQmRNN1pjVGw0cC9sbEcwZnVRczBH?=
 =?utf-8?B?NWlwaHBLSCtjOW40RTkxb0FYbzhmYmhHOGw3bVpzcUI3N0pXUnhHd0l6Zzht?=
 =?utf-8?B?NklTV0tpUnZOZENzRlhlT0VTU0Y3QzZJbHp3c1ZlOHNtUFFYMVBQcmp1TER4?=
 =?utf-8?B?L2VYeDBFUTlTVWN5cWdsd2FROGdGaklYSWhYQm1rNCtOS1hNTjliQkxaNVhJ?=
 =?utf-8?B?alVFRGxlZlhFRnhiR2MwaTZUU2U4dHJOcXA4ZWQvZE1FMlpyTUhieVFPbWpJ?=
 =?utf-8?B?Si9LVWRza0lKdzVOUmRvd1hScjIyWDN5MWJGeWN5ZFlJc3BhYUZyWTBtcmV0?=
 =?utf-8?B?aUt5SDVtUlBtZDVNOEZ5a2R3TEpncGRMWk1YRlR3eGVHa1R1UVdzS0htVWlj?=
 =?utf-8?B?MThHUmk3NnVaYlZnWnNNMGZZWGJIQ2dLejVjeWVOeHRzcjZkRGVnVFV6R1lD?=
 =?utf-8?B?MnExeGgvYTN1QVdOa2tNTDUwLzRZZGRtaEVVWEsrUWxMVXFXT1NwTDk5dDIr?=
 =?utf-8?B?S01QMkFjRWV5R3M1THZ6UGNUdlVQUmp4RDR0WEZFYTBGWUJQUG1BckF2ZWJy?=
 =?utf-8?B?bDRUZFZnbEdxaTlKMXozMmhqTnRjaFpqNEN2bGtLcUxtN1ZUR1VrMGhEK1l3?=
 =?utf-8?B?MlYyUXNReWlHeC9WbE9meVh6d3lqL2ZZRU1SdGxCMU1kUmlvQ0M1OXcvaUYw?=
 =?utf-8?B?RmlYQ2RtY2NWUmxSZW5qVGVyaXVyRHVyakJqYnUzZGlVSklJaTVLQVNkbEt4?=
 =?utf-8?B?YlZBM3Z3aXlvTm1obERrNnVBWXhwYXpQcVBFME1PWDRZOHpISENXNWdJVndM?=
 =?utf-8?B?bGFXUlk5UWZiZU1TcWFiQWNFcjg4U3RqYmJaUVhORHBTZ1VGRjhCQkd5TUdN?=
 =?utf-8?B?ZFUzMzhmb0pHSXJteENudGdmemF3K1k1UldlelpEZFovSVVRMTBtbGlsY1FY?=
 =?utf-8?B?UGZrOXhyMThLcDJzUkVQT242Qm9iMDRZQTlHbFZHZXdSWDF1NlNGUT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7def814-cd45-4dfd-34d7-08df0405780e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 06:36:04.8665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2tOoppZuXlTEiV95u5JDP1rNYlPF1qBRffccKmEJFbLs9xeuw1SXKBldXCojMhvq8pzoM8MKrGGznxUikNA3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5501
Received-SPF: pass client-ip=2a01:111:f403:c10d::3;
 envelope-from=kchiu@axiado.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Philippe Mathieu-Daudé 於 2026/8/26 下午 04:20 寫道:
> CAUTION: This email originated from outside of the organization. Do 
> not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
>
> On 26/8/26 09:46, Kuan-Jui Chiu wrote:
>> Add EVK ax3005-evb built with AX3005 SoC
>>
>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>> ---
>>   hw/arm/ax3005-evk.c            | 64 ++++++++++++++++++++++++++++++++++
>>   hw/arm/meson.build             |  3 +-
>>   include/hw/arm/axiado-boards.h | 10 ++++++
>>   3 files changed, 76 insertions(+), 1 deletion(-)
>>   create mode 100644 hw/arm/ax3005-evk.c
>
> Missing some description in docs/system/arm/.
>
No problem. I will add it in v5 patch set.
>> diff --git a/include/hw/arm/axiado-boards.h 
>> b/include/hw/arm/axiado-boards.h
>> index 4a632661e1..7a610ecfda 100644
>> --- a/include/hw/arm/axiado-boards.h
>> +++ b/include/hw/arm/axiado-boards.h
>> @@ -11,6 +11,7 @@
>>
>>   #include "hw/core/boards.h"
>>   #include "hw/arm/ax3000-soc.h"
>> +#include "hw/arm/ax3005-soc.h"
>>
>>   #define TYPE_AX3000_MACHINE       MACHINE_TYPE_NAME("ax3000")
>>   OBJECT_DECLARE_TYPE(Ax3000MachineState, Ax3000MachineClass, 
>> AX3000_MACHINE)
>> @@ -25,4 +26,13 @@ typedef struct Ax3000MachineClass {
>>       MachineClass parent;
>>
>>   } Ax3000MachineClass;
>> +
>> +#define TYPE_AX3005_MACHINE MACHINE_TYPE_NAME("ax3005-evb")
>> +OBJECT_DECLARE_SIMPLE_TYPE(Ax3005MachineState, AX3005_MACHINE)
>> +
>> +struct Ax3005MachineState {
>> +    MachineState parent;
>> +
>> +    Ax3005SoCState *soc;
>
> When a component is not optional, our style is to allocate it in
> place (IOW this shouldn't be a pointer here but the plain struct).
>
There are two approaches existing in current QEMU:

1. Create SoC instance in board level then add it into machine state 
like NXP did

With this approach, I will remove pointer from machine state and add the 
following code into ax3000/ax3005 board like

Ax3005SoCState *s;
s = AX3005_SOC(object_new_with_props(TYPE_AX3005_SOC, OBJECT(machine),
                               "soc", &error_fatal, NULL));
sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);

2. Create a common machine state which contains a pointer for different 
SoC models like Aspeed did

With this approach, I will integrate Ax3000 and Ax3005 machine state 
into a common struct like AxiadoMachineState


Do we prefer approach 1 to approach 2?

>> +};
>>   #endif
>

