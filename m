Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED0EC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 03:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4VuY-0002CA-4j; Wed, 09 Sep 2026 23:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4VuV-0002Bj-Tl; Wed, 09 Sep 2026 23:57:16 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1x4VuT-0004zG-1H; Wed, 09 Sep 2026 23:57:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7tf9st8KxNJaCAOGCBLNpbjpi7ctvwxPcA4ovhD/jcJLF9Cei4pmfB3Mh4XSGC3hkxgoVkLhbfWvc06NNDtlPif5d68xreS4/OLMyTG8pJXeMTk2naJW/jiP6M63SngE83ZK/H4Fu/YTuBy2S01qbfY8Oo5PsKJhdiA722WcnETk8hN5yzbpYvjeQtah83hTNQrE5E1iHYret6Y7Ru8M7NVFIXE5+lk1pzZxEwnmKdT1Wl0/eOqVi3womVu+2saip797hdW8lx48nKVKhXBOjgKuiOfZNc52NSJX/6wyV8aePTmAM6o7Hkvl0GrbupFuK7rCQfy2Uea+DExitjrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGAXAcy21gRCCSe7wmuUnJ5xQuoIYCpjRbTYor6o+tM=;
 b=I6Nve+RsrfbGBHuzvfeoLQBHWwgCLkBheAD8wYPjqgVDgUl/5mPP+t62OoCylqJznTiW8Rs0ooH2PTw4VjYmj3XFKBBo3hb4+OpA/geHNliZtwc+PRB2AtbAx1ughGF2Q4iUWYHtLHXVtDbQHOC3w03ZCNMMDL5XhfpH4A+rSAmial3rydvY20MV4QHj4lh83lX5QDZV1pv2AxIz3Jl+zC0t6DoiPnbrHUx8LBCS3Kf/a0NRs4IHZzuEPd5smiQoujykfXIerrp29N7XEQleKQig+/gJjehhTuU7TF0Nwm9EIa6FDrnH+1w29CqES2HvoIVFWPHxgQ4t60F+SlMGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGAXAcy21gRCCSe7wmuUnJ5xQuoIYCpjRbTYor6o+tM=;
 b=cX45PwnetzkvW6NJanyDFqHdwOsQwbTT3qnDC+mu4F4xDaeSEZk63pfwcEC7CwgEJQTJh0ju8ZggF3Zr8czwGwmCNgu7nPAOAq6VXAukiQTSCkXMp5NBkHmzAjWxa2PaDcoWLk0Rzb27Q41334e9ks6hNrfW0Gd7MJzYoAfQ5JnZKVb9D3Lci9cwn4RfxKb1Irh9dNCv89tvNGOHH8nKOW3LBNefAN6UMkCTWfcJbB108oOk5+2QG7IkcBiJQweRxCSdNhauUYGJkY3hxRvi1vQLeKl1nV5p1yBiNNyhu7qaqC5eaWeszSii1eDClavfljnX0adsUbtz4WorVkp9lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by PH7PR18MB5624.namprd18.prod.outlook.com (2603:10b6:510:2e9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 03:57:07 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 03:57:07 +0000
Message-ID: <c01ed4e7-7ea5-416c-89f9-5b24369f18c9@axiado.com>
Date: Thu, 10 Sep 2026 11:57:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/12] hw/arm: Add Axiado SoC AX3005
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
References: <20260909105543.1478008-1-kchiu@axiado.com>
 <20260909105543.1478008-10-kchiu@axiado.com>
 <8411ce33-12f1-4359-8724-f92480e5e558@nutanix.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <8411ce33-12f1-4359-8724-f92480e5e558@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0009.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::8)
 To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|PH7PR18MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: ed93886b-06b2-4266-750b-08df0eef954b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|3023799007|10067099003|5023799004|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: m+UuJAT7wBmEANCYHGgk7szaYnxnzJqQwj8RHq9Aj9c10j1EAvdp3I1BC6vJEVEk5//15koIKaLiI7m3HEHa+MQ1usnUdDkaSAwoUv42ktxd0zb/CiuRLyjofkLry5uDih7SwQlWgCTj6tHspWYocmvYGHjHsbQgaS8hPaxEYPje9MYKvQBa0FSu4GqmQElGTs7EsdsPX603hiSrwedkUnu/kmrCXSQW9n8dxnqlgIqtz142vs2apAMzbT2E3xdFWh5NvKDXOoBrni++h8BANjl2vr9Ciw1XHhnr1w2l8WH6X4vN2Lh7X7iFjhZVTExpa2UM3Bf5fR7rjGaKf9ujdQXcWIxYxKl7AFJn0AUKuEPUvWRBowtx28kyoPtbiWjOrApgjRFF4vR0RJAa9hf4lKfIBBuE825YTXiuHOQMLPdmdjh6aCFKyvf3oBdmfclgK+WCQ+lpMiRUsziTIevAnwUz3DQxcKXVP2RkUs85NCTJtW0gyDjWe7BY/QV7vY9vpjU9mCreF4KnoITtuZDIwH9Tw0Q7xLpsKO68j/YR3z0W/0zgJEXi4mjf5pwq5TcsZ8lrqGqh5FhUTPmun97RpxoqShefEQLAMVg7DTn6QP5gTfmm2aOBaGIOrEcjBu4uA9WyH0GE23RfVaquPJAj5XvsX6bFZoWgOrI3cQmK5IM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(3023799007)(10067099003)(5023799004)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUYxb2RiYlNDdGp4OGJoRjVxRGtvalhhdFlZZ1pES1lyb0d5QWxBMFlYMnN0?=
 =?utf-8?B?V1JOd2MwNjN6Z1lWRmcyMDdjWlVlbE15dTVCNEVVN3hHcnF4TmtwdExsdzBX?=
 =?utf-8?B?ZTR4ZXZ3dGh6TUNpN1kvVXdLdXQrRHNROWtSVHRwQzVLb0lzcTJialBpRDV5?=
 =?utf-8?B?RUd5Si9rendQZnVKblRNSlFGamE3NHRSMy9NRTVQeEIybVpidVRHWDdXRXlO?=
 =?utf-8?B?U2Q0ZGxoOUtwYlhMN0k4UjlXZmQ2WTJNSTcyTE5tZGhiZ1N5Y0pkZlpxd1hR?=
 =?utf-8?B?QkhEQXdPLzlTWXFYbUVyQXZwc251MXV0Z1hMQ3ZpY0gwNTEvb2NZdkNnSHNw?=
 =?utf-8?B?VisyVkV4TWhScHVDeTNnMlRVbU5KRHpKSThSZXp4MG5hNmEwSTliTTNXUGtE?=
 =?utf-8?B?Q3hscnZiZjZ4SHRjZ0ZMWC9vbC9rU1ZOajlTd0RLVFBpdUtzd1BRZHI1b2pK?=
 =?utf-8?B?elVkNElac3k1K2ZwUzNLTWhLQ1VpNnlSbmVkWC9SK3RxbG02Q3BveG44MWNH?=
 =?utf-8?B?UWhZbk1TRFhMVDQzTS81Nm42aUI1aWhwczlpU3Q4UVBPT2JNWm1EVjEySUxW?=
 =?utf-8?B?QUZMbmpPSkZYSFRTTFFWMGVVUitsalZVSUFQYXQ0Z1hpU2s0NmJOSVpZdTU1?=
 =?utf-8?B?eElSSm1vM1phdWZHQ0w0dFRaUndvMWMzUGd1ZDFPZkt6ajFFK1ZDNGV4ZldL?=
 =?utf-8?B?T20ydnhodS9FNEI4ME5LMEhmMUJiaXlLSlpsQ0ZJN1R6eis3YzdXV2JaRjJT?=
 =?utf-8?B?QWhncWdHcktpL2VsYnFWWkViK29YSjQ4RjdBZU1TU3RvcVlXclFKc0xGOXlt?=
 =?utf-8?B?OFpVVGVaN0ZWNC9OckVPNUpGWWpsdDZzRGFhMjhZc0c5NGxSaXBMQ2hFSHJO?=
 =?utf-8?B?SVl1dVE2cU1aNEVjVzlmWWJzUkZyampzMkdDUnllQVFobHhHRjJqamM1ZHZS?=
 =?utf-8?B?RWpoc2ZGNlBZNC9qVTFqWnF2QVQ3OStGWW9HSjNyaGFITFVmbHl2ZmpLNXY3?=
 =?utf-8?B?ZS83eTR0WHYyUndtbXZEQ1MwUlpqUmdMN0ZsV1ZXaHBUekRacUtEbFh4UjNN?=
 =?utf-8?B?dS9xdG1KOXVKeUJMRllMTmdqU2FUdHVXSm8wb3VWenR5bVhSamFGcngxMkNJ?=
 =?utf-8?B?RTgrNTdqN1hycUVqbGhDc2NPYkZucVNiR2JwUGRxRzRWbTRPbjlHdzZwUnlw?=
 =?utf-8?B?a3VEU3pvVmkxSFVvMjV6L3ZKcUlvTmZkUGhxNGpCenFmc0o0OXhUVTVqSHAw?=
 =?utf-8?B?NlJNdFNqbTY0WVVJUm5KWlIxeWgwZk41ajZtSFdoWlQ0TmxaNWJqSC9zcGNh?=
 =?utf-8?B?QmVVQnVubGFFeFRPVE4zZG1YdjJabFhGWTJobFM2SVpWak5Db08vN0lPbmQw?=
 =?utf-8?B?WlhyMXJwYTk0aHByZ3BkUUd6U09BQ1hxV01LS082NGZVRENxSDhaUTBSRVkr?=
 =?utf-8?B?bXYvVlFJSGJqeEFyVGpGYk5PUHZneGs2WWVqSkNpWWJNcXpWYlBhV0k1NGRM?=
 =?utf-8?B?WUR3YkZGejM4bmxyVFFtcEZ0ckhUOVFPSVJsOHpZdDhQamhwK0VjUDFSZEVD?=
 =?utf-8?B?L0doc25LRzVYZjQwS0JtWkhYNVJaMzFsQjRYcEpVNk1GWXlvZnVWaHF3Rmh4?=
 =?utf-8?B?YVZZSVFxcmtHOXpQcUYwSHR5cmUzTDB6ZWNwUkJmVUlibkF1cnJ2NlVrWjk5?=
 =?utf-8?B?bmhncDN6NWs1cnJYSWc2S01ZTVpWempsaVU3U0d1ODlaaFpXV2pOY0VoeXVx?=
 =?utf-8?B?ekEvWWN6dVp2bmFSNmp1ZGlva0t0dmxEUEVyS01rRzU2NmRvOGltamk3M0oy?=
 =?utf-8?B?dG5iK2JnNUNUeWozRHFVK2drYVpObHFRbkhRSEJQdmZZWFBaMkJkeWRsVjlw?=
 =?utf-8?B?Qm5FUVJNZkgrZlZ6dFVsSUYzMm4vZXcrZmJNWldEdzBIZnZ2blpZUXZKTG1E?=
 =?utf-8?B?U1Rwc2ZsajNPS2ZSQnMvUkZVbzlrcDdtbHNja1N6M2lWUEVvWUdoY09FalNa?=
 =?utf-8?B?TE1pL0tKaXp0bDZYd2J6QnkyQXlqaFhTQk56TGpIekFiY01iYlY3eXF0aE1C?=
 =?utf-8?B?c0ZEK3VPanFQRDZLRVRqSTZ6dlVXN0x3UU01Y0VTNjhUNG5iak93OGNGcnFi?=
 =?utf-8?B?TS9XNWRtaEhxdW01UjBqVGpCSzUxOXRMSm9BaVB4RTVYWEJLTnlib3d6UXE5?=
 =?utf-8?B?bjV1RTdxV1R5bXJHdkNDQjgvekNKQTZjM3VpeTlFaG15cUVpWFZsYUFoKzJy?=
 =?utf-8?B?VmhyazUxeWVzdkx3bkFoTTNFcC84cDM5eGRSendGUi8rdTA3dDVLa200T0xG?=
 =?utf-8?B?dGZkWVU1QldiMC9xTDBkRWlLNWVWMGZqbVc2Y0RVdjVSR1UwNkpSUT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed93886b-06b2-4266-750b-08df0eef954b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 03:57:07.7151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUYL90uGsVGxXfSYa7+Hhw4s9NnLQffv53z0vhQmYbXlo4Dv52lVHnLc+1leYWzCKj45FgPjkAX6Rw5YsI8eog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5624
Received-SPF: pass client-ip=2a01:111:f403:c111::5;
 envelope-from=kchiu@axiado.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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

Hi Mark

Mark Cave-Ayland 於 2026/9/9 下午 07:12 寫道:
> CAUTION: This email originated from outside of the organization. Do 
> not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
>
> On 09/09/2026 11:55, Kuan-Jui Chiu wrote:
>
>> This patch adds new model for Axiado SoC AX3005 which supports
>>      4 Cortex-A53 ARM64 CPUs
>>      Arm Generic Interrupt Controller v3
>>      9 Cadence UARTs
>>      1 SDHCI controller with PHY
>>      8 Cadence GPIOs
>>
>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>> ---
>>   MAINTAINERS                 |   2 +
>>   hw/arm/ax3005-soc.c         | 226 ++++++++++++++++++++++++++++++++++++
>>   hw/arm/meson.build          |   3 +-
>>   include/hw/arm/ax3005-soc.h | 102 ++++++++++++++++
>>   4 files changed, 332 insertions(+), 1 deletion(-)
>>   create mode 100644 hw/arm/ax3005-soc.c
>>   create mode 100644 include/hw/arm/ax3005-soc.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7183babd6a..deddcc4eed 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1305,8 +1305,10 @@ M: Kuan-Jui Chiu <kchiu@axiado.com>
>>   L: qemu-arm@nongnu.org
>>   S: Maintained
>>   F: hw/arm/ax3000*.c
>> +F: hw/arm/ax3005*.c
>>   F: hw/*/axiado*.c
>>   F: include/hw/arm/ax3000*.h
>> +F: include/hw/arm/ax3005*.h
>>   F: include/hw/*/axiado*.h
>>
>>   AVR Machines
>> diff --git a/hw/arm/ax3005-soc.c b/hw/arm/ax3005-soc.c
>> new file mode 100644
>> index 0000000000..e555b156f4
>> --- /dev/null
>> +++ b/hw/arm/ax3005-soc.c
>> @@ -0,0 +1,226 @@
>> +/*
>> + * Axiado SoC AX3005
>> + *
>> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "system/address-spaces.h"
>> +#include "hw/arm/bsa.h"
>> +#include "hw/arm/ax3005-soc.h"
>> +#include "hw/misc/unimp.h"
>> +#include "system/system.h"
>> +#include "qobject/qlist.h"
>> +#include "qom/object.h"
>> +#include "hw/core/boards.h"
>> +
>> +static void ax3005_init(Object *obj)
>> +{
>> +    Ax3005SoCState *s = AX3005_SOC(obj);
>> +    Ax3005SoCClass *sc = AX3005_SOC_GET_CLASS(s);
>> +
>> +    for (int i = 0; i < sc->num_cpus; i++) {
>> +        g_autofree char *name = g_strdup_printf("cpu%d", i);
>> +        object_initialize_child(obj, name, &s->cpu[i],
>> + ARM_CPU_TYPE_NAME("cortex-a53"));
>> +    }
>> +
>> +    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
>> +
>> +    for (int i = 0; i < AX3005_NUM_UARTS; i++) {
>> +        g_autofree char *name = g_strdup_printf("uart%d", i);
>> +        object_initialize_child(obj, name, &s->uart[i], 
>> TYPE_CADENCE_UART);
>> +    }
>> +
>> +    object_initialize_child(obj, "sdhci0", &s->sdhci0, 
>> TYPE_AXIADO_SDHCI);
>> +
>> +    for (int i = 0; i < AX3005_NUM_GPIOS; i++) {
>> +        g_autofree char *name = g_strdup_printf("gpio%d", i);
>> +        object_initialize_child(obj, name, &s->gpio[i], 
>> TYPE_CADENCE_GPIO);
>> +    }
>> +}
>> +
>> +static void ax3005_realize(DeviceState *dev, Error **errp)
>> +{
>> +    Ax3005SoCState *s = AX3005_SOC(dev);
>> +    Ax3005SoCClass *sc = AX3005_SOC_GET_CLASS(s);
>> +    SysBusDevice *gic_sbd = SYS_BUS_DEVICE(&s->gic);
>> +    DeviceState *gic_dev = DEVICE(&s->gic);
>> +    QList *redist_region_count;
>> +    SysBusDevice *sdhci0_sbd;
>> +    DeviceState *card;
>> +    DriveInfo *dinfo;
>> +
>> +    /* CPUs */
>> +    for (int i = 0; i < sc->num_cpus; i++) {
>> +        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 
>> 1000000000,
>> +                                &error_abort);
>> +
>> +        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
>> +            return;
>> +        }
>> +    }
>> +
>> +    /* GIC */
>> +    qdev_prop_set_uint32(gic_dev, "num-cpu", sc->num_cpus);
>> +    qdev_prop_set_uint32(gic_dev, "num-irq",
>> +                         AX3005_NUM_IRQS + GIC_INTERNAL);
>> +
>> +    redist_region_count = qlist_new();
>> +    qlist_append_int(redist_region_count, sc->num_cpus);
>> +    qdev_prop_set_array(gic_dev, "redist-region-count", 
>> redist_region_count);
>> +
>> +    if (!sysbus_realize(gic_sbd, errp)) {
>> +        return;
>> +    }
>> +
>> +    sysbus_mmio_map(gic_sbd, 0, AX3005_GIC_DIST_BASE);
>> +    sysbus_mmio_map(gic_sbd, 1, AX3005_GIC_REDIST_BASE);
>> +
>> +    /*
>> +     * Mapping from the output timer irq lines from the CPU to the
>> +     * GIC PPI inputs.
>> +     */
>> +    const int timer_irqs[] = {
>> +        [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
>> +        [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
>> +        [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
>> +        [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ
>> +    };
>> +
>> +    /*
>> +     * Wire the outputs from each CPU's generic timer and the GICv3
>> +     * maintenance interrupt signal to the appropriate GIC PPI 
>> inputs, and
>> +     * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
>> +     */
>> +    for (int i = 0; i < sc->num_cpus; i++) {
>> +        DeviceState *cpu_dev = DEVICE(&s->cpu[i]);
>> +        int intidbase = AX3005_NUM_IRQS + i * GIC_INTERNAL;
>> +        qemu_irq irq;
>> +
>> +        for (int j = 0; j < ARRAY_SIZE(timer_irqs); j++) {
>> +            irq = qdev_get_gpio_in(gic_dev, intidbase + timer_irqs[j]);
>> +            qdev_connect_gpio_out(cpu_dev, j, irq);
>> +        }
>> +
>> +        irq = qdev_get_gpio_in(gic_dev, intidbase + 
>> ARCH_GIC_MAINT_IRQ);
>> +        qdev_connect_gpio_out_named(cpu_dev, 
>> "gicv3-maintenance-interrupt",
>> +                                        0, irq);
>> +
>> +        sysbus_connect_irq(gic_sbd, i,
>> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_IRQ));
>> +        sysbus_connect_irq(gic_sbd, i + sc->num_cpus,
>> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_FIQ));
>> +        sysbus_connect_irq(gic_sbd, i + 2 * sc->num_cpus,
>> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_VIRQ));
>> +        sysbus_connect_irq(gic_sbd, i + 3 * sc->num_cpus,
>> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_VFIQ));
>> +    }
>> +
>> +    /* DRAM */
>> +    memory_region_init_ram(&s->dram, OBJECT(s), "dram", 
>> AX3005_DRAM_SIZE,
>> +                           &error_fatal);
>> +    memory_region_add_subregion(get_system_memory(), AX3005_DRAM_BASE,
>> +                                &s->dram);
>> +
>> +    /* UARTs */
>> +    const struct {
>> +        hwaddr addr;
>> +        unsigned int irq;
>> +    } serial_table[] = {
>> +        { AX3005_UART0_BASE, AX3005_UART0_IRQ },
>> +        { AX3005_UART1_BASE, AX3005_UART1_IRQ },
>> +        { AX3005_UART2_BASE, AX3005_UART2_IRQ },
>> +        { AX3005_UART3_BASE, AX3005_UART3_IRQ },
>> +        { AX3005_UART4_BASE, AX3005_UART4_IRQ },
>> +        { AX3005_UART5_BASE, AX3005_UART5_IRQ },
>> +        { AX3005_UART6_BASE, AX3005_UART6_IRQ },
>> +        { AX3005_UART7_BASE, AX3005_UART7_IRQ },
>> +        { AX3005_UART8_BASE, AX3005_UART8_IRQ }
>> +    };
>> +
>> +    for (int i = 0; i < AX3005_NUM_UARTS; i++) {
>> +        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", 
>> serial_hd(i));
>> +        qdev_prop_set_bit(DEVICE(&s->uart[i]), "brk-support", true);
>> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
>> +            return;
>> +        }
>> +
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, 
>> serial_table[i].addr);
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
>> +                           qdev_get_gpio_in(gic_dev, 
>> serial_table[i].irq));
>> +    }
>> +
>> +    /* Timer control */
>> +    create_unimplemented_device("ax3005.timerctrl", 
>> AX3005_TIMER_CTRL, 32);
>> +
>> +    /* SDHCI */
>> +    sdhci0_sbd = SYS_BUS_DEVICE(&s->sdhci0);
>> +    if (!sysbus_realize(sdhci0_sbd, errp)) {
>> +        return;
>> +    }
>> +
>> +    sysbus_mmio_map(sdhci0_sbd, 0, AX3005_SDHCI0_BASE);
>> +    sysbus_mmio_map(sdhci0_sbd, 1, AX3005_EMMC_PHY_BASE);
>> +    sysbus_connect_irq(sdhci0_sbd, 0,
>> +                       qdev_get_gpio_in(gic_dev, AX3005_SDHCI0_IRQ));
>> +
>> +    dinfo = drive_get(IF_SD, 0, 0);
>> +    if (dinfo) {
>> +        card = qdev_new(TYPE_SD_CARD);
>> +        qdev_prop_set_drive_err(card, "drive",
>> +                                blk_by_legacy_dinfo(dinfo),
>> +                                &error_fatal);
>> +        qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
>> +    }
>> +
>> +    /* GPIOs */
>> +    const struct {
>> +        hwaddr addr;
>> +        unsigned int irq;
>> +    } gpio_table[] = {
>> +        { AX3005_GPIO0_BASE, AX3005_GPIO0_IRQ },
>> +        { AX3005_GPIO1_BASE, AX3005_GPIO1_IRQ },
>> +        { AX3005_GPIO2_BASE, AX3005_GPIO2_IRQ },
>> +        { AX3005_GPIO3_BASE, AX3005_GPIO3_IRQ },
>> +        { AX3005_GPIO4_BASE, AX3005_GPIO4_IRQ },
>> +        { AX3005_GPIO5_BASE, AX3005_GPIO5_IRQ },
>> +        { AX3005_GPIO6_BASE, AX3005_GPIO6_IRQ },
>> +        { AX3005_GPIO7_BASE, AX3005_GPIO7_IRQ }
>> +    };
>> +
>> +    for (int i = 0; i < AX3005_NUM_GPIOS; i++) {
>> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
>> +            return;
>> +        }
>> +
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, 
>> gpio_table[i].addr);
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
>> +                           qdev_get_gpio_in(gic_dev, 
>> gpio_table[i].irq));
>> +    }
>> +}
>> +
>> +static void ax3005_class_init(ObjectClass *oc, const void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(oc);
>> +    Ax3005SoCClass *sc = AX3005_SOC_CLASS(oc);
>> +
>> +    dc->desc = "Axiado SoC AX3005";
>> +    dc->realize = ax3005_realize;
>> +    sc->num_cpus = AX3005_NUM_CPUS;
>> +}
>> +
>> +static const TypeInfo ax3005_soc_types[] = {
>> +    {
>> +        .name           = TYPE_AX3005_SOC,
>> +        .parent         = TYPE_SYS_BUS_DEVICE,
>> +        .instance_size  = sizeof(Ax3005SoCState),
>> +        .instance_init  = ax3005_init,
>> +        .class_size     = sizeof(Ax3005SoCClass),
>> +        .class_init     = ax3005_class_init,
>> +    }
>> +};
>> +
>> +DEFINE_TYPES(ax3005_soc_types)
>> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
>> index bcc068de04..b6a036c953 100644
>> --- a/hw/arm/meson.build
>> +++ b/hw/arm/meson.build
>> @@ -111,7 +111,8 @@ arm_common_ss.add(when: 'CONFIG_VERSATILE', 
>> if_true: files('versatilepb.c'))
>>   arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: 
>> files('vexpress.c'))
>>
>>   arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], 
>> if_true: files(
>> -  'ax3000-soc.c'))
>> +  'ax3000-soc.c',
>> +  'ax3005-soc.c'))
>>   arm_common_ss.add(when: ['CONFIG_AXIADO_EVK', 'TARGET_AARCH64'], 
>> if_true: files(
>>     'ax3000-boards.c',
>>     'ax3000-evk.c'))
>> diff --git a/include/hw/arm/ax3005-soc.h b/include/hw/arm/ax3005-soc.h
>> new file mode 100644
>> index 0000000000..2a383a8084
>> --- /dev/null
>> +++ b/include/hw/arm/ax3005-soc.h
>> @@ -0,0 +1,102 @@
>> +/*
>> + * Axiado SoC AX3005
>> + *
>> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef AXIADO_AX3005_H
>> +#define AXIADO_AX3005_H
>> +
>> +#include "cpu.h"
>> +#include "hw/intc/arm_gicv3_common.h"
>> +#include "hw/char/cadence_uart.h"
>> +#include "hw/gpio/cadence_gpio.h"
>> +#include "hw/sd/axiado_sdhci.h"
>> +#include "hw/core/sysbus.h"
>> +#include "qemu/units.h"
>> +
>> +#define TYPE_AX3005_SOC "ax3005"
>> +OBJECT_DECLARE_TYPE(Ax3005SoCState, Ax3005SoCClass, AX3005_SOC)
>> +
>> +#define AX3005_DRAM_BASE        0x80000000
>> +#define AX3005_DRAM_SIZE        (2 * GiB)
>> +
>> +#define AX3005_GIC_DIST_BASE    0x40400000
>> +#define AX3005_GIC_DIST_SIZE    (64 * KiB)
>> +#define AX3005_GIC_REDIST_BASE  0x40500000
>> +#define AX3005_GIC_REDIST_SIZE  (768 * KiB)
>> +
>> +#define AX3005_UART0_BASE       0x33020000
>> +#define AX3005_UART1_BASE       0x330A0000
>> +#define AX3005_UART2_BASE       0x33120000
>> +#define AX3005_UART3_BASE       0x33020800
>> +#define AX3005_UART4_BASE       0x331A0400
>> +#define AX3005_UART5_BASE       0x33381D00
>> +#define AX3005_UART6_BASE       0x33381E00
>> +#define AX3005_UART7_BASE       0x33381F00
>> +#define AX3005_UART8_BASE       0x330C0000
>> +
>> +#define AX3005_SDHCI0_BASE      0x46000000
>> +#define AX3005_EMMC_PHY_BASE    0x33301C00
>> +
>> +#define AX3005_GPIO0_BASE       0x33000000
>> +#define AX3005_GPIO1_BASE       0x33080000
>> +#define AX3005_GPIO2_BASE       0x33100000
>> +#define AX3005_GPIO3_BASE       0x33180000
>> +#define AX3005_GPIO4_BASE       0x33200000
>> +#define AX3005_GPIO5_BASE       0x33280000
>> +#define AX3005_GPIO6_BASE       0x33300000
>> +#define AX3005_GPIO7_BASE       0x33380000
>> +
>> +#define AX3005_TIMER_CTRL       0x48016000
>> +
>> +enum Ax3005Configuration {
>> +    AX3005_NUM_CPUS     = 4,
>> +    AX3005_NUM_IRQS     = 224,
>> +    AX3005_NUM_UARTS    = 9,
>> +    AX3005_NUM_GPIOS    = 8,
>> +};
>> +
>> +typedef struct Ax3005SoCState {
>
> The explicit typedef is not needed here since the QOM helper macros add
> it automatically.

Thanks for review, I will remove typedef in the next patch set

>
>> +    SysBusDevice        parent;
>
> As per our documented naming conventions at
> file:///home/mca/src/upstream/qemu/build/docs/manual/devel/style.html#qemu-specific-idioms 
>
> this should be parent_obj.

Got it , will be parent_obj

>
>> +    ARMCPU cpu[AX3005_NUM_CPUS];
>> +    GICv3State          gic;
>> +    MemoryRegion        dram;
>> +    CadenceUARTState    uart[AX3005_NUM_UARTS];
>> +    CadenceGPIOState    gpio[AX3005_NUM_GPIOS];
>> +    AxiadoSDHCIState    sdhci0;
>> +} Ax3005SoCState;
>> +
>> +typedef struct Ax3005SoCClass {
>
> No typedef required here either.
>
>> +    SysBusDeviceClass   parent;
>
> This should be parent_class.
Got it , will be parent_class
>
>> +    uint32_t            num_cpus;
>> +} Ax3005SoCClass;
>> +
>> +enum Ax3005Irqs {
>> +    AX3005_UART0_IRQ    = 112,
>> +    AX3005_UART1_IRQ    = 113,
>> +    AX3005_UART2_IRQ    = 114,
>> +    AX3005_UART3_IRQ    = 170,
>> +    AX3005_UART4_IRQ    = 208,
>> +    AX3005_UART5_IRQ    = 209,
>> +    AX3005_UART6_IRQ    = 210,
>> +    AX3005_UART7_IRQ    = 211,
>> +    AX3005_UART8_IRQ    = 212,
>> +
>> +    AX3005_SDHCI0_IRQ   = 123,
>> +
>> +    AX3005_GPIO0_IRQ    = 183,
>> +    AX3005_GPIO1_IRQ    = 184,
>> +    AX3005_GPIO2_IRQ    = 185,
>> +    AX3005_GPIO3_IRQ    = 186,
>> +    AX3005_GPIO4_IRQ    = 187,
>> +    AX3005_GPIO5_IRQ    = 188,
>> +    AX3005_GPIO6_IRQ    = 189,
>> +    AX3005_GPIO7_IRQ    = 190,
>> +};
>> +
>> +#endif /* AXIADO_AX3005_H */
>
>
>
> ATB,
>
> Mark.

