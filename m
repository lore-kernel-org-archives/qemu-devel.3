Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D820ECD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXcJ5-0001We-3H; Thu, 11 Jun 2026 06:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wXcJ4-0001WS-Ap; Thu, 11 Jun 2026 06:06:38 -0400
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wXcJ2-0006vQ-NH; Thu, 11 Jun 2026 06:06:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTDW/Z541pDAYuUXaNOuvr0APWW0kzV5rXKuEMYhHCeJWlsXwW4j94kqqLcsxIeKmkMIThA0gGGaaubXbclhjRmerpPYkCrmkOEu5uiPs0SrrYmvZPLIBsww14ObqifePDsPQ8Qvyyvn1ip8I13VcOFFEKDY/HjrBhd/7EcYF3b2rvLxsh9ytF0POywW1yldTcRsKV94c0rwJdEdwIOqD4e8yrfKVR0b4Tks4/GY1hmLRoDR8bY9DhudBx0uK1+MExLFMoh20umbzignlXVLdW3ebCe1vjA9hGrn5Tw2AXZUqbSQIeqn/T383Tjq6wbaUg0L0pedhbNwgLx/Jeiuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6229FYuDhqLQc/dMps29OthbEvyBcxohdqbTftR/MdI=;
 b=YI6a61YTGCtZygc14H92Ay/vlQO4mV7MnCuTpXiJQCmAKa1dzv26oY/wUDT/BMzINXMTGCS01WbfDxLl3/cVQQmyzD6IMqvpbV4ARivIsA9VcLZApQs1Os1HPS2UWJT0r8bSNZLSC2XjDpHksNNp7INyhneIM8r294DP4j4Na5CPDiUELMAxYHuy+kmQVBpejbfBqkr4anMf0fSEam9vCqfChFAxIiRKok2t6RyKWhdaHQt3mHMh43CP0JCUIJsFwFMWMdYVNa6BNUFQS/eqAZwf+anPc5k7KaDhTh5wM9cXqm3dpVmxmtNmiNmOr3GU1I6aHmJQwuq6ecCtGhbCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6229FYuDhqLQc/dMps29OthbEvyBcxohdqbTftR/MdI=;
 b=mtKjTLz7hxlie9TU29itIehjKfSWEiRUDrBfuyge271nLeuWI7raBjFg1TQDD1wol2CrhnurtAUvGMmg9DNujyt6ygLP895mWQ6/QN2sb8LfgHsKmiCl9lGxKRSLlzvT+HNbFNG1yE5usZqAYtoLG8e0LvajvmDzHdCbYUQkqwN+6AJCGcVFacUdc/A5Hqdg4j4kR6hvMmqNuBnis9dhZw5xLBy1bX91wl1JNUHRx4ApqlFUJoKvcjlLNlbhArvsOZ7iA2YjYvtfwAGolLaq1Z1m1J77ql0gDspNo7FMiVQ73OcR7ZUc0ethm/ovKQooiiuTbQyiTDsnyDsEnLjZKA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by KL1PR04MB6980.apcprd04.prod.outlook.com (2603:1096:820:d6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 10:06:27 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 10:06:27 +0000
Message-ID: <SE3PR04MB89223BFA19CAED63F7C799EFF31B2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Thu, 11 Jun 2026 18:06:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc: riscv_aia: Skip reset for KVM irqchip
To: Qingwei Hu <qingwei.hu@bytedance.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, jim.shu@sifive.com
References: <20260605110621.644997-1-qingwei.hu@bytedance.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260605110621.644997-1-qingwei.hu@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0036.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::15) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <585f629d-2873-48fd-b44a-52fcf643deb8@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|KL1PR04MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c7a4c2-42d4-43f6-9cdc-08dec7a11906
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|41001999006|51005399006|21061999006|6090799003|23021999003|19110799012|15080799012|5072599009|8060799015|19101099003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmZzVERtMm1xdVVDTUlXaWFTT295Zlo4Mm84OU4yb3BkY1VLRVZveXducnlZ?=
 =?utf-8?B?RmFTWGVBNTRGcEhVSUJwZ2dQek9nNk9Ta1BnNnlMczNOVWE1M1VxQjEyUjBo?=
 =?utf-8?B?RUU0TGNiMGNqZkVybDdjMCtHcE1mYklTd05jcTUvMWg5VnArUjlvRlFXT3RZ?=
 =?utf-8?B?RER0UEYwVm0yVjJOL05FV0VPR2xpTkxEc0pQeUV2SFhBL2xnZzk3bGU2Ykl5?=
 =?utf-8?B?azdvOGJTRjFBd0JPbDhzeWZTQjJ0MnFxS3dCMlVjRWlzOU82eXZQTFlzNnJa?=
 =?utf-8?B?Q3JXQ24raXNFNkJrR0E3ZmlFdGduSWE3NS9HZmgyQUNjR3NMSzI2NUQyMzVT?=
 =?utf-8?B?cUthRUoxT29sUENWQUNSek5qWm9uUkZyaWRiQXBtZWp0TnpTNlNVRFpEMmFn?=
 =?utf-8?B?UFNOaTVkeG9WSnlwSC9tbGtkd2R0NEVDR3BJdXVNTHJFdnRkVjlYMUZxVmtp?=
 =?utf-8?B?QXdneGZVQUVaQXoweXV6UW5keUFkcmR2d0NkNUhMcWN5N1NLNWRZRE5uV0FE?=
 =?utf-8?B?dFByVThjOWVkUm5PV244YWFlSFJQeDRrdjVnYUtjamYxTUVxaHlDYTdQM080?=
 =?utf-8?B?MzJDVFVvdXZraGFtTE42elViTFVUL0JReFFTdFQ1VjJpcUQ4Ri9nWDIyNmJj?=
 =?utf-8?B?dXJwcUNKbURkN2xrQk5GM21zZGozU2RPNDZuVzA3L0Y2TmpibWR6dFpQdkh1?=
 =?utf-8?B?bDZldFU1eGNKUWZsOElVT1FrRWxiTXdyeTh4VUxiRjYzZFg1NDQ1MjRHSmhN?=
 =?utf-8?B?UG9VeW5wTGNwZFlZTDA5cEhDZUpBRkY1TDVKQ2lZVlhXeks3VVZVNmJJYXgy?=
 =?utf-8?B?ek0yNGVMOWxXaGZzYzJUSmY1cXo3cXZlN0owVzQ2akY3ZTkyenlqL2lhSHY1?=
 =?utf-8?B?UmJXVVJWSm5CQzNieEcvMEdIYkxXdlJ5VFU4REhSLy9JU1YrbzZlMHlvL1pS?=
 =?utf-8?B?TTUxQjZhUGQzVkhkTno1ZUtrMlJyMHhUVzAyK1VUNDZkT2d0UGVkNWc5YzZP?=
 =?utf-8?B?cC82SDhVUDk4Nnk3YkRQUEtDUTlpVzNuNWRDWDVUUlpiMWpRMm5rSmN1bGF3?=
 =?utf-8?B?cDhKakFoclhSVlNGa2Y2MHVhQjd2MFpZZFdwazVHWHdDUldabWY5WHRaa2xD?=
 =?utf-8?B?N2wwWXpHZTR0OUNKRCtqeU1ubWJId21NQ2cyMjFHZHZrbUUrN0J2WVc2dDZI?=
 =?utf-8?B?M0E3T0V3bi9yQXp5aFJPMDJoWGp1ZmwxbEhEeU1uYTVRelpkY25Ub0JHK0Zi?=
 =?utf-8?B?cnN5Y0pkMnV4ZzljUEhxVVlBMXNkZXEzdzNEdXNjdUpWNzB0bTJjTmZoRk81?=
 =?utf-8?B?Rzk0bS8xK1dWMjArMnhROXY0cFpmTEJOZ1pwdWkvci9HVitNT1M3ZnpoNitk?=
 =?utf-8?Q?DSo7H2VkyetDUvJQR9jqSnHCqLjVU9Ws=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzAzTEo2SWlYOHBMVFJBTkhwUjhVVkZZa0dkSEFOdS9LMkt6M2RPUE5RaVRB?=
 =?utf-8?B?akhJWDFzOXhIelZXa3h2ZERYMGExRkUrVnF3bzZGc3E3V1lsYk45cUhlblNV?=
 =?utf-8?B?cE1sekJkN2R1K05PaVlmZU1kL2twYTdUODY0b0JaTGgxU09RdDhsNVFzUll6?=
 =?utf-8?B?NGJvTUFpcDZzbUlEUE50ZW9VaUpUNTJCcS93UnBuS2hxNHh5cXJtZWNLUzZx?=
 =?utf-8?B?NjVFU1FFMk1GZEFPdU9yS1pONHlYa1VZVXUvYjNiOHJQTjFuMnZSaVRvSnF0?=
 =?utf-8?B?L3FTNkJ4ejBvemRJc2psOHJTTTZ3OWlDbWkrc05xZzBHVW9FVy9nbDJRM3V1?=
 =?utf-8?B?L0R2UVU5UzNRNEhKRnJrTzM3L3EvVWJ6cCsveHBNbjVCZUVOajFpVG8xYWhC?=
 =?utf-8?B?TVplbHIvMlpCVjdHclVEZEM4OEU2aHprUE5wSGlyV0RyeW80WGFlaTFHWk56?=
 =?utf-8?B?eGQrNmoyN1BpV0M2a0hMWXNsMDlvQmRHNkErVS83UFEyTllseEtDNDlYRXZl?=
 =?utf-8?B?WGgyeklKT3VlTE1UUTZqT2J0ZDZwbWdTL2RkT1JTcnBYUlJva3RjTHBMMGtq?=
 =?utf-8?B?d2JodjhNTU0xZUttdDNhZXBSNXBpQ1g4c0p2dFEvUmZLZFdQYzR5bGRRQkN5?=
 =?utf-8?B?L1UrRzB6SXZScVBWRVFveTgxeTBacUdaN0Fjd3VNQVRDNW1Pdmh3c3RJb0ho?=
 =?utf-8?B?NUFEbXhQajhHWTJTZG1US05ocG52VmlhQ1QwdXZEUjFJSmJaZVFXVFZ1cFJ0?=
 =?utf-8?B?VFhwUUIwalhsREVvZDJsK2VJemxLS1FneDVYeVg0cytsN3hLaTRPYVFCRWNr?=
 =?utf-8?B?VktxTVZaRTFXcTVGempDc1JEeWM4K1RFSHpvaHhzSC82cEtnaG9rK2cxcWty?=
 =?utf-8?B?bFhTWDBad3N0Ry9jRXZZN2xyOEw3MjhNUk0rencwWDBUbnFXWGhVTnhDTGtY?=
 =?utf-8?B?VmlHdmFMN241R1RpTk9lbndkVStwZERvZnBOeGhQUjcrWTNabExqUm43dWxs?=
 =?utf-8?B?YUxoVWttRVB5MGw3WVN3MSszaVhtWmZ3WGhsYjRlTWNvQmJhSGdqQy9qRWJC?=
 =?utf-8?B?Q1JHSXliNFZ2VnJPTitBL3liRGlKL1JKLzdlWW0zV3ArL0tzUmYxMFduZlV2?=
 =?utf-8?B?QTF4NGQ2VGRkZ2plVHhaMHZkZW5GRDlYVUdjMEJxRTRqbzI2Wm9JY01HY1hS?=
 =?utf-8?B?YmVPaFd6L0JnRkl2ZVA4MTV1Ym15eXA5a3NwazZLdVlSREVLK3FJMVRDUllm?=
 =?utf-8?B?aUphbW1CSGxiV1dwNU1aQ25HRzF2OGxMdHdMNjBQM002LzhRZHB5TTBXRDJj?=
 =?utf-8?B?S3Y1ZUlkWFBNTVpockJXNXhrdmtIMnI3bkZoTGpuZWs4U0phdmxmV2UyR2xy?=
 =?utf-8?B?eXovRzJKWDl0WnY3L0ZVdlkvQ3V4NTdwVXdUa3VLMm1ETDQva0JFaWtUOW16?=
 =?utf-8?B?Z3FLNWN1YXhEU2l4d0tLYjl1c2ZYL0F3RGo3cDRhbDNSZHpMcGNXY1dTVi9V?=
 =?utf-8?B?VHFWN1krdFdNNXZ4WVVBY0JCVUE4Y0JGbmgvMTg3dFlyd2w3dU14dnpzRVEy?=
 =?utf-8?B?RXNGcGFPQUJRbStXVjZ5dFdpMmtrV2lGYmlURW5qT1A1NUYwamlmRVhBTWlT?=
 =?utf-8?B?dHkwcTdtY3ZtTG5ETnpnMEIzNnFVS0ZRY3Ywd1VLaGRkdTBteStHcmlsSG9o?=
 =?utf-8?B?KzhINThVenUwUm1ERFp1VzBWNDBZbWFUdHBCTXA1VDROZktlZUFrWUxkM3Rk?=
 =?utf-8?B?OVlzWkhERFI5TlRYZ3llR0lSZkhVaUdUY3NTZHhWZ1B6WDg0aEM2a05VZC84?=
 =?utf-8?B?OU1VaWl5NXJRTVFURmFNL0JOVWdxZFRtVXNaVTEzaWpjSTJGOVZrYlg1VjZX?=
 =?utf-8?Q?PcFpBFxPdtnnp?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c7a4c2-42d4-43f6-9cdc-08dec7a11906
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:06:26.7679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6980
Received-SPF: pass client-ip=2a01:111:f403:d405::2;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 6/5/2026 7:06 PM, Qingwei Hu wrote:
> The emulated APLIC and IMSIC state arrays are only allocated when QEMU
> handles the interrupt controller state itself. With KVM AIA/APLIC-IMSIC,
> the interrupt controller state is owned by the KVM in-kernel irqchip, so
> these emulated state arrays are not allocated.
>
> The reset handlers added for APLIC and IMSIC still clear those arrays
> unconditionally. This makes qemu_system_reset(), which runs during machine
> creation, dereference NULL pointers with -machine virt,aia=aplic-imsic and
> KVM.
>
> Skip the emulated APLIC and IMSIC reset paths when the interrupt controller
> is handled by KVM. The emulated paths are unchanged for TCG and for
> configurations that use QEMU emulation.
>
> Fixes: 99bfcd329a ("hw/intc: riscv_aplic: Add reset API to APLIC")
> Fixes: 766391483b ("hw/intc: riscv_imsic: Add reset API to IMSIC")
> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
It would be better to split it into two fix patches.
Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/intc/riscv_aplic.c | 4 ++++
>   hw/intc/riscv_imsic.c | 4 ++++
>   2 files changed, 8 insertions(+)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index c2c67c29e6..84606e9f3d 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -910,6 +910,10 @@ static void riscv_aplic_reset_enter(Object *obj, ResetType type)
>       RISCVAPLICState *aplic = RISCV_APLIC(obj);
>       int i;
>   
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        return;
> +    }
> +
>       aplic->domaincfg = 0;
>       memset(aplic->sourcecfg, 0, sizeof(uint32_t) * aplic->num_irqs);
>       memset(aplic->target, 0, sizeof(uint32_t) * aplic->num_irqs);
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index ac59496c22..f1f23c3a3e 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -347,6 +347,10 @@ static void riscv_imsic_reset_enter(Object *obj, ResetType type)
>       RISCVIMSICState *imsic = RISCV_IMSIC(obj);
>       int i;
>   
> +    if (kvm_irqchip_in_kernel()) {
> +        return;
> +    }
> +
>       memset(imsic->eidelivery, 0, sizeof(uint32_t) * imsic->num_pages);
>       memset(imsic->eithreshold, 0, sizeof(uint32_t) * imsic->num_pages);
>   

