Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2122ACD6E55
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 03:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUFgU-0004KO-Ay; Mon, 01 Jun 2026 23:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUFgT-0004KG-4p
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 23:20:53 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUFgR-00084I-DG
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 23:20:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBFDbN8tBtMIvt1/U3Kj31QbrSGBWXwZPUZcupwUGLtMteNBzEaiA1VQHL1QP+Xvw8HSvYbnLxlrD6lOfeq/XpJ5UjyKmnX9wlwGncLDAwWdoC3HS8OHMwDxHsm9z6tJab35Jxf6kDRSA7CkL3QJdHWCcPvLceHLwzW70oxHYGv0FG+AK2Rmj6GF0lljE280TOhHTlDx2Ks8kb3kA7Edx86hs4SXzlHYNzAnPAMkelOa8eRqf2RuAhJaKVUUThZmCoRki4aV2dE6Kq1Ch6Jh5+l88LYHZDa+Zk9k24T9rEPnWq1t0be4r+LFkfrGfga21lavuV8D6ruK/4vgthvbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CywddgZQNTwLHb/cvZmvOS3fEeObdggtlnF2qn4YkMY=;
 b=AIQ+7jOQLhWKbHPjMhTxKN9x9lL3Bq1e3UzBsLNl75SyJW+hpwDlumujcQbUBGSRDVZ2RSxTvKUl4coWz+UNBkoKvYopMZH4A4pMhSJ28V55hfbLyBRVVcB6b/YBFje396Orgk3awVVm77At/AHvgMnklL/MP9PXYb5WV3v4/ppcqdZZAL5s6BznMwn5xEM0Xa1ZH+/u7KiKU3Qvj4BHxwV33GNHrm26r/JRWzDLGHiBttq0TA1IN+tzot9P3/i4G61pPPtdOzwi+xBJ+80DqbP4Vdxb6xdBkfLuvh4WkU+NRkEy5/YQN0GEgHk/+smr61tKmxF7mQPPaPAWBGyDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CywddgZQNTwLHb/cvZmvOS3fEeObdggtlnF2qn4YkMY=;
 b=WbTYI9uwUfBwFGfiXajqUo1nlhQ++y30DDkCMXCyi5keTfP8wc4DNkzgrTwydaM+c1/UyX5Dfg+K4S+HhZI/uDlVkkOUG5PeHynXy690oMAtEgsInGbYGpxDLV/JauCnPezj74AHJNiNOlVUevhYLGYuobK50YDlDsPWCfQbEqrsWadCVGpEnAS7R4X/1T1ugLXNmnlNG1GcaH2+1Z2pk7Vp/3yFdqeSeSk/CJKy8pUUL1VB/CYHxX66e5RMjxsXY5fkdkv123JcfXKtNeBas9tEPrHdhUg/F+cObtC0MUFSQ7Zrc+BDGbrXfjBIWABYYTltEUj7ggMxTpFD8IFicg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by SA1PR18MB5718.namprd18.prod.outlook.com (2603:10b6:806:3ad::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 03:20:48 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 03:20:48 +0000
Message-ID: <7da37165-ab8d-4594-9375-f94fe9bb09e5@axiado.com>
Date: Tue, 2 Jun 2026 11:20:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hw/arm: Add Axiado EVK SCM3003
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260430091832.1846637-1-kchiu@axiado.com>
 <20260430091832.1846637-3-kchiu@axiado.com>
 <CAFEAcA9qQt+HVqZGtH4mjP0sBv9Jxrs3JS+gBHaMevTdYFq+ow@mail.gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <CAFEAcA9qQt+HVqZGtH4mjP0sBv9Jxrs3JS+gBHaMevTdYFq+ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|SA1PR18MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 943ec9e1-a8b1-4c29-4e8d-08dec055f100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099006|22082099003|18002099003|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: n3kjEzZVd4W0d0GqY7wlUzUDiK+f7mpf82bVv1ZUGQrr0mxYTPbZ5tWeyllC5C33ySf+APNsZ23cWH9dXfOH64dCcSRikcijy+ltmrCyKXINCYn6ccqY2kcIAiw29lpwLxKeIiFpgKeWj7FS3xbxrP5BKWN4x6yHt9lNLj6kIjoUbc9x43Ux7XXFc6HP96f/e/GBOFXYmnETZYJDgq5jTW81wR1E40tNgme1OkPlfnlb+FqfhttGz/GBrYXwJopS/yC5x7XXjTlgCjSmlfP25ObfgFMsW2JgC1OONyfvFyYOXNGM3GF2KS5JhaOEu6Ka/vKAQ9Xlu/cQzbSubqI8x2TGowc5JowawnVlkUzDYJs0fcigUNRAbOKx3mmc6j04/3LqJmSd2VNBdLZy4G1XAuN41zPE9H9ggvtMuah/1vMVTdxmR/3kmBymB3geWEuySAdVMimQpcxcNt6SaAK25GKVvqu3avmaBwW5U/nhTD0kwLDUtZvz6TG1OWSA7DOI1eXEDZljDGxM9YUGXaKC4Ey9M3bTKlx0LB6v55S1H+aEySXW6Cm5PtGrj5r7Ceepg1vEbAzj3ydaFXwWmj/jMBeKmmEzcoK8J10JgX3mgVbjBRe4hfEvcwXNU0H2GBGEGsdEeSdUR4tbMCEcoI05E5XNc3DJdDrYm+JnyadEBNCj5Xpv2ANQ38BHe1GGy6/+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(22082099003)(18002099003)(5023799004)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2NSMEJTbU5aSFI3eHczdld3b3Z6em5sbG5rbmIzTStNeTJkQlJZNXdXWUFa?=
 =?utf-8?B?Q2hzSExPUldHMUwrSDFXeHJhMG82RUo3RExpV3hYRDg5ZjFsRlZpTGtwYWUy?=
 =?utf-8?B?VFVHZmt0S0wrMVY5RG9JYmM4TlJ5bks4dk5YZ2o1eHc0UU1FZ0RYcEZ6OTc3?=
 =?utf-8?B?YUpiVWwwa1krNXFPZE52ZUVhUTNtektPUlNmS1VIQ0h3NUpTVWxwSEVHRzhY?=
 =?utf-8?B?MnhQeC9xMzFRL2RLVkdtS0IrTW9WTUkxRk92b1VPSitwL0dhcFVLVEh1dGE3?=
 =?utf-8?B?QjdJK2pibWRsUUpsLzhqQkVXbUludXIvdXRlTDZ5Szhia2NZWWkvY1NmMHd3?=
 =?utf-8?B?SllHQ1lNR1Y3UWNscGtWOE5nRG5KTHY2RFRPd2xPRncrZ2N1RkpHK3lSa2N3?=
 =?utf-8?B?QjVHQmF5aDYrcm50QUtUcHIwd1VRRjd0VnpvVEh0VjBvL2o0bk8zdVphcmpT?=
 =?utf-8?B?WUlOM2wxcGR3dlVueGNXcHdpZ09mWUZtRkpOQ1VuaUd1RlFlQ29Yc0tFZUIz?=
 =?utf-8?B?V0lSWDRsUW5Vb0F6dU9wd0RQVVUwM29seGd1aGhHNDV2TVA0ME40Z0ZldzhG?=
 =?utf-8?B?OGpxdHQwbGJNeDAxRXNpM2JvL2ZsL1FheHhjTlRrVWlURUVWaUxnYStXSDFh?=
 =?utf-8?B?dUxrYzRxM2x2VTh1bFc0Y3dlOWFEYjJBcVR3VGpFREFwTGU5ZHBNMlVvRU1m?=
 =?utf-8?B?dFVPSG1neWFIVk1SY3FxWSthMFVBS3Q4ZG1xL3laL1JEaFliRVVnakZCTEFz?=
 =?utf-8?B?ZmVKVEpDVk1naTQzMGlSaHFBdWI2RU5CS1NaRy9iSmw5dnZnRDdIM1loc0li?=
 =?utf-8?B?TGM4TThxSkdvN2F1K2t3ckx1RjVaRGZUdFg5cUNoSWVKVFNsUDNXRjIveGp5?=
 =?utf-8?B?aXMwOEhyZEdpNTlja3dpblV4d0pvaXBiMlJwYjM3TlkxdkJqWmZaaGRCOVRq?=
 =?utf-8?B?Z3pDeC9KRnQ1dEF0cC91ZDgwR0x0QWVSS2dNcFNPYnR4VzRxREJTNHRBaStR?=
 =?utf-8?B?citCb08xMFd5bFF0TW9YdTBkbGczNDFvMmtPQnVUQXNpeWkwcU4wNlFhUVFk?=
 =?utf-8?B?MWNGUTlPWGVYUVVNaHBoOU5RaXBSUGxVYXR0ZlRybmFvSE9vTDhENEJxWUNV?=
 =?utf-8?B?MkJtMlpNK2RlUytmSGpTOWx3QTlsM0tpMTFrQ1hjMDJhUHd1VGs5NVVXRjZV?=
 =?utf-8?B?bGVLOFA2Z2tTaFBxM3ZPY2picG5nT3hML29yZlFNYUFEQnl0QWlqVU5VSFhm?=
 =?utf-8?B?V1B6d2Q0OG9IVUlZMFRYdFBLNEpMV2xyN1E3YlJVV25oOC9xM25qYkpmaWNi?=
 =?utf-8?B?ZFpzY1FDMmxZLzJaRE5qSmtKQ2FaeGF5MHJTcjRpT3hxVHBoK1NZMnpYWkZo?=
 =?utf-8?B?SkNMazljZEMrNEQvdzkyU29na21HS0Q4U3h6cUx3WEk0ekFFM3lFcW9ZRjh3?=
 =?utf-8?B?Rjlia1pZUExKZ3lsdXhWaFVUMWh3VDl4RG50aGRSTTAxdXZTV2lXSFRPY0JO?=
 =?utf-8?B?aEdxUzZsN2R3ZzloODU1dzNEMFZ0cUFxYU00a0hyeE05VWNpUm9CdFBqWmQ1?=
 =?utf-8?B?aHpYL3ZpdE9LSU5WM0pGOXdFK1hBazZ6ZExhYzR2NlQrSzlYRVUyYko4cDZj?=
 =?utf-8?B?U1JNczNaWmFWVkowOHNCS0V4RVJWN2FhNjRwUGxOVThpRUcxcmVrM0NmN2do?=
 =?utf-8?B?SE9ZU2xnQ0RabU9HOFVZTUJReGpMTzgxc3U4eEJxU1hvTVR5TFpJYS9MOEhT?=
 =?utf-8?B?WEdzSGdOcWRKalRhK3M3dHBwM0RJR2FRUVBGZi9RZWpHN05PUHgzK1l2UC9O?=
 =?utf-8?B?eGl2RDNXeHRueHRxajIrQjAraEt5dmZ5UVpGcVltVDNZVUZqM3NLbmtFZ2Zk?=
 =?utf-8?B?UjQzb3NIb3N1ZEJQRDNJY245dTd2TG12ekNtREU5ZmlwUFVXOTY0ZEhuam9B?=
 =?utf-8?B?VjRzZEZRR3dYQys4Q0lyVW5nOHpPZlErbGtaQ0IycTNuRVY5TVRHUWxySXpr?=
 =?utf-8?B?a0ZCK0lqTXU3R2hhb012aC84WlFscnRDcXdvYUFyWGtCRWlrNFdGYkZEWm5r?=
 =?utf-8?B?cjRiWU05UE9rcXNiVFNSWlVXdDUrQjV6TG9NRXFCcE8xMUhBMnNndThUWVUv?=
 =?utf-8?B?c3RGM3NHWkM1MENPMnlYVERkdzRWNUhNN292YmthMGNJYTcvcENMWGRac2tv?=
 =?utf-8?B?NUJHK3dGdXdtTi83NGFLLytqbXlIazZHdUJ1SVhVWndNRmZ5TVhQdkxIQVRV?=
 =?utf-8?B?Tnl4QjA5SnUvVDVOdENvUU5lcEpaSnJIaGFCbE5uMlliWm1NTk0xV0JPS2VW?=
 =?utf-8?B?aC9mVnVEVHNYVVVuRlJyNno1VXAwaU4zbGFRZFlnRnZlang4ekVRZz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943ec9e1-a8b1-4c29-4e8d-08dec055f100
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 03:20:48.2825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXjGmzC9IeV3DzXPJaDOxv5HETz/NvLM9KqKyxEu7tEdlDJsjWvr8RqXnjP/MIHsOeQBKVbD62vk1mHPpSAqow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5718
Received-SPF: pass client-ip=2a01:111:f403:c111::9;
 envelope-from=kchiu@axiado.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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


Peter Maydell 於 2026/5/26 下午 10:12 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Thu, 30 Apr 2026 at 10:19, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>> Add EVK axiado-scm3003 built with AX3000 SoC
>>
>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>> ---
>>   hw/arm/Kconfig                 |  5 ++++
>>   hw/arm/ax3000-boards.c         | 52 ++++++++++++++++++++++++++++++++++
>>   hw/arm/ax3000-evk.c            | 27 ++++++++++++++++++
>>   hw/arm/meson.build             |  3 ++
>>   include/hw/arm/ax3000-boards.h | 28 ++++++++++++++++++
>>   5 files changed, 115 insertions(+)
>>   create mode 100644 hw/arm/ax3000-boards.c
>>   create mode 100644 hw/arm/ax3000-evk.c
>>   create mode 100644 include/hw/arm/ax3000-boards.h
>>
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 4fb23122fd..e569d8ee9e 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -699,3 +699,8 @@ config AXIADO_SOC
>>       select CADENCE # UART
>>       select AXIADO_SDHCI
>>       select UNIMP
>> +
>> +config AXIADO_EVK
>> +    bool
>> +    default y
>> +    select AXIADO_SOC
>> diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
>> new file mode 100644
>> index 0000000000..cadbac8edc
>> --- /dev/null
>> +++ b/hw/arm/ax3000-boards.c
>> @@ -0,0 +1,52 @@
>> +/*
>> + * Axiado Boards
>> + *
>> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/arm/ax3000-boards.h"
>> +#include "hw/arm/machines-qom.h"
>> +#include "qemu/error-report.h"
>> +#include "qom/object.h"
>> +
>> +static const char *ax3000_machine_get_default_cpu_type(const MachineState *ms)
>> +{
>> +    return ARM_CPU_TYPE_NAME("cortex-a53");
> There's no point in having a function just for this; you can use
>    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a35");
> without the indirection.


Understood.
I will remove this function and assign directly

>> +}
>> +
>> +static void ax3000_machine_init(MachineState *machine)
>> +{
>> +    Ax3000MachineState *ams = AX3000_MACHINE(machine);
>> +
>> +    ams->soc = AX3000_SOC(object_new(TYPE_AX3000_SOC));
>> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(ams->soc));
>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(ams->soc), &error_fatal);
> The machine init function for an Arm board always needs to end
> by calling arm_load_kernel(). As well as implementing the handling
> for the -kernel "load this kernel/image file" option, it also
> sets up some things like getting CPU reset to work correctly.


For ax3000 SoC, we assumed that the kernel image,which is stored in an 
eMMC device, would be loaded into a specific DDR address by u-boot then 
start booting

So I do not expect that user should use "-kernel" argument to pass the 
kernel image to QEMU for AX3000 SoC
This is what the command I used to launch axiado-scm3003 machine in QEMU


./qemu-system-aarch64 \
     -m 4G \
     -machine axiado-scm3003 \
     -device loader,file=u-boot.bin,addr=0x3C000000,cpu-num=0 \
     -nographic \
     -serial null \
     -serial null \
     -serial null \
     -serial mon:stdio \
     -drive if=sd,file=obmc-phosphor-image-evk-axiado-qemu.wic,format=raw

>> +}
>> +
>> +static void ax3000_machine_class_init(ObjectClass *oc, const void *data)
>> +{
>> +    MachineClass *mc = MACHINE_CLASS(oc);
>> +
>> +    mc->init = ax3000_machine_init;
>> +    mc->default_cpus = AX3000_NUM_CPUS;
>> +    mc->min_cpus = AX3000_NUM_CPUS;
>> +    mc->max_cpus = AX3000_NUM_CPUS;
>> +    mc->get_default_cpu_type = ax3000_machine_get_default_cpu_type;
>> +}
>> +
>> +static const TypeInfo ax3000_machine_types[] = {
>> +    {
>> +        .name          = TYPE_AX3000_MACHINE,
>> +        .parent        = TYPE_MACHINE,
>> +        .instance_size = sizeof(Ax3000MachineState),
>> +        .class_size    = sizeof(Ax3000MachineClass),
>> +        .class_init    = ax3000_machine_class_init,
>> +        .interfaces    = aarch64_machine_interfaces,
>> +        .abstract      = true,
>> +    }
> Do you really expect to have a lot of boards which are
> all different subclasses of AX3000? Unless you really
> need this, better to do the simple thing and implement
> the MACHINE_TYPE_NAME("axiado-scm3003") without the extra
> layer of class structure which is doing nothing at all.


I will introduce another machine "axiado-scm3002" in future for sensors 
implementation

Both of scm3002 and scm3003 are built with AX3000 SoC and they are the 
different EVK boards

> thanks
> -- PMM

