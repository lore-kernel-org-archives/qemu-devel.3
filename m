Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D17FDEE5E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 03:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG6uj-0007c8-Kr; Thu, 23 Apr 2026 23:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wG6uZ-0007bc-BS; Thu, 23 Apr 2026 23:09:00 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wG6uU-0005kQ-3w; Thu, 23 Apr 2026 23:08:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pss+jsMPSIgQlQIrfIncqxauq9E+TtEfE3A38qc5lt8wNELIZ1WECIvyMzu064oQAd/k4KGWOqEllLB7eheyMMwbopJz2OdvE0sQI+Wd/1wJfyfBZgc+C8G6wWNb4iCxJuwvDyuUXrKl9WQJiKaMgpAJ/Jt8obxum6RlIEDdR3G8Vaj5s0QprF0KiGcy28CcQ8hq3k8q6qmmy+ZWsMw2taeky6xvfbMp78DQtozIQgGrX2bkwA705wXBlUbNcpGrXRyhRaf1T/JVY8VBlWrWh95NAN548YpBbrooF7Bg/EoSNvr9W2DAGsM2krYWXfZBPucjkwHPteo/51gipswRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7WnUCRPs2Cyifxjj+ead2ovLv9nDH13a4AyJ9Bg/Cc=;
 b=qSgAW5smp8p9cQcgOUsgJaeEsZhbwlUGfE8W8GgjA0cwd/VLBPKEqwtUPPrih5krLlIt1GUJyJh2EaC2WEJQ1XUymD5x21z8vXnE9pU9U+T254AA/PPte7neIoUF1vbkwYvBIIeTSSHLIslIdy1d75ka+4iND1qC5PeAn/60hLQhbGVkv0iGZK6Xsp0YPSYzW9klbUyqknK9uzOXlLqYmGpUllyl+Np3a5wkZHjKCt1nXarWVG7PQ2oF/BBLs1lvqXmt66nxVDAK1Zv1ZhFqqNqdayEyd2SjZfGlcCWkCvhBBmLgciGWcdCoMh3DLnp9v7HJk+jOuLWS92yBF3DViQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7WnUCRPs2Cyifxjj+ead2ovLv9nDH13a4AyJ9Bg/Cc=;
 b=hpsuEIF4TCXZZgPNlYt4/2cxpZJYzOIb8rtc+MXljXf6W6lZSVQ4jHu9W+U1EzStQdNYYSpL4w2l0OVgW72g4fzI52nQ/WmEvIXsCHAO3e5kQWbkDl7y1Hd8R8sGCa4+znIdlhITto/9Yduob2XLhqb4dzo3lzy1Q4EvepGwGVmokNkJmreceEQViR3vz3xkCP2VpDkmvb8Lq7JrrTSB83owRIcAx4OD/mV8dERKlZVjNKf7whUYjzOnc5VATGl2LWEeKSsxQIKArhwpuzApXIDRfGDZ/LocCT8RCwedp8VXNL7/bRoNf035kwfsiBHlNjNDpdr0nL8gh/Y/K1poAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by CH5PR18MB927681.namprd18.prod.outlook.com (2603:10b6:610:2f0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 03:08:47 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 03:08:47 +0000
Message-ID: <cba7059c-9472-45f1-8fb2-06b26036f958@axiado.com>
Date: Fri, 24 Apr 2026 11:08:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hw/char/cadence_uart: Add BXRS register
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, alistair@alistair23.me
References: <20260212104432.4168886-1-kchiu@axiado.com>
 <CAFEAcA_u5B2RdVEaGycCQ6gCx1pQuT8rvGVGZpoKLTK+2s72+w@mail.gmail.com>
 <69691e3b-1605-4a5a-8ad5-0eec56ce3eed@axiado.com>
 <CAJy5ezpcvp0Qy-P9gE46oDtsxZxNO=xMV1k-GC3WF4yY3gARGw@mail.gmail.com>
 <CAFEAcA8mC4TkicLy9bcS8NYMDNcSUjsataGGmkMpViw4wBvmCA@mail.gmail.com>
 <CAJy5ezqTAMr=A3uAfmuWLepK66AdLRu4Q8AmFMh4+4q2HtDrkA@mail.gmail.com>
 <CAJy5ezogVjNxHLFVBp9wd332kwyR8peBHMEjoALg6pYfVk1q8g@mail.gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <CAJy5ezogVjNxHLFVBp9wd332kwyR8peBHMEjoALg6pYfVk1q8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::14) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|CH5PR18MB927681:EE_
X-MS-Office365-Filtering-Correlation-Id: 024c056f-c1ac-4982-9215-08dea1aeccd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: ESRZVUJaC+tj51il/l/o/R2NHQkNtrl1Q0JEzL/V2oACJBH0nC/YjWvAFQDCR/qTWbwKMNm+eKleWJBUEYjXIvq591N44Ho7TO6It14ahz3w+7yJHAOjtoGg++gMERhaZXPYemzIB4DuBNmyx2CQ8O0/OyOK9RAI1WH6sEbJJCyS3n3JQvOuAdzCu2qxWJ043zA4QpbxR0m9NWfLZhnWfsWAE5eGeBz2/CJYhI1YWLlyfXuuDh3H2Aqu0ZePDb1v0p+irwKOMuoIPLteM3UgpePSdtFUMU/Uzlcmtq3eHJ89/qI0J4Juzc3B4Nu2awXQpxaJcAtLSYvird3uQ18WzgDKzHUyVyMJ/erSYKw6hxRdQFVF1IzYYAjWM/E4BF/0bFbA3SL/v4XB7yJcChkh3yzo56bwj9Ov9+qRazMe8n7BAvzdn7yHj3a0wwRPSjcggn5TeZ3JrJvQ603XCbQupJRAnSQvfaDDLr2C9TbL87yx+u5jk869nxWHAdWi3ccfJU0SddzD3szYJOKXBZAf0om4lB/gYSrVnGCuFyJ5ewccUsb3KnzEoh7zgbnXx1Z6X6x3M0pZ39YQSblHFaZttQfCKMuacklWC686M2LjUN4Vccb1lpwoBeCTURwq9X/pgXQQsnP4nic/a/e/n4k2C8YwP4r2kxdn/hFQjq8zvIlH5INjwsG0L0bt3/O7zubp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3diVVpyeEU1V3FGUFZSbElVNG9kZ00zSjlhcXZjb1pkaVdHd1dKK05RQlRU?=
 =?utf-8?B?dUE0djJwbFJORituTHcwZnpBcHdKNStwSDM4VnNQejNka3dpVlZFRWcwWXFQ?=
 =?utf-8?B?R2dDQzZnRy9ObUxtNmJ4RGtiOEd4aXhUSG9ZbUVlMlNLSldDK1BKZ0NPTlVY?=
 =?utf-8?B?Q1BjS1lGQmR3RTBhbm1kRUFSU0tpZm43UUFlQjk0U2kyYzQ0NjR0OFhoUUJK?=
 =?utf-8?B?N3BUaWxaVHUrU0puYkZ6QjdOMkY3QVBkeE1FT041enFZYXVlaHJqMG95Tkp6?=
 =?utf-8?B?YVdZOFhWMk5TeVNJVHNWeFhvUHdMZ0YxQVpyQTU3TFBTTGVpa3A3dFFPRXRU?=
 =?utf-8?B?VlVBQ1Zndm5sY0dMNkFJUUlnOHJUNzdPVFZiUENuWjVEVy83WDd2QkIwZ1FZ?=
 =?utf-8?B?WEVydWI5c204cnNpeDU4SkgyaVVyZUxGNWVQWWpaS1V2bGNBYzdsalBDRkNv?=
 =?utf-8?B?UmtiWXZNRUR6L2RpdWl6MGdock45SUxod1R3RGhEMEU2VjZibWsxMmNTM3RM?=
 =?utf-8?B?SEx0RXBneGxNQ0VCYU1EU2JQcUVQTUk5eVl5dGlUUWxpcDRldXoxVFZlMnhY?=
 =?utf-8?B?YUFpRk54OSt5K0dnelJLK0NPVHJIYS9zcHZwTFNVZDZuNHQxdWFkQUhTeW05?=
 =?utf-8?B?RXllVUtIaFUvWnlrU29JRFlYaWxjRUVhZlZRdmE5T25nTUZ5YXMzRTJrbVRr?=
 =?utf-8?B?RXBuMXV6SGwxMmZ0YUFSTk9ib0h2cFBacmdjZ0lqLzNQRFN2bWdvRklQVlVr?=
 =?utf-8?B?M1l0UzNVMjdrZDlZRTByZ1ZzbElGYjF2dnBBN3lpSkFMcWYyTnlGNTI1YmZD?=
 =?utf-8?B?Vk5ZZU5xOWJtUUc0SHFRa0VHRk1KWmVHUUxiMk9ZUEt1RkxRZXhCNnRmdzJv?=
 =?utf-8?B?ZWZoNldqM1hzWWJpR3pkbXBNOFJhRHVnVFgxVlJVOThUUThYT0dhSW1GYnhm?=
 =?utf-8?B?ZW9LTGFEY3M2QTR1bFlhbmM0eUEzV3gyL2Nkd2lDa2t0OXdPdTNURDV2S2xk?=
 =?utf-8?B?Tk82Z1F1ZXRIb2p1Q2NWcDNpdnhTVlgweFhmb1YwdzJuckpRcyszUVFNNDJk?=
 =?utf-8?B?NzBGQyt3N3htRWRmcFpHeS9vdHQrYTc5V0dGWjVPKzZzK1cyRnQ4bGpQc1E4?=
 =?utf-8?B?VGpWZDFwUnQxMXVaTFhQcnBtRmhjNkRlVk1BaFl0WFNtQWcydThBZUhtTkF0?=
 =?utf-8?B?U2c5WWdCV0J4MFpDMDFGZUh0T3pmdFp6Y2c1OGRiK09RUG5DeHNWb3NEVXpw?=
 =?utf-8?B?bXNOWnI4Tm1VYmQ3cmJZdWtQWGRvV1A1SVBLZlh3TlZid29EcGJhOG56QnFG?=
 =?utf-8?B?S3dLZVpJb09BODVQSVV6SVgzSE5tZWRadS9kaU1ycHFLcDlSN0lLUS9jM3kx?=
 =?utf-8?B?eEtFZkxnNTk2cHFLM0ZSRU0rSkFhcXNnNTNGa0VFMzJFSVZub0VJNXV1dE1G?=
 =?utf-8?B?bUNHbUR2NXRRVkFjUjRQUVl3VVBCSG9iWVNDNVg1WS9KR3RwdHFOenpQelRl?=
 =?utf-8?B?bUY3VVNySE5VcEdvS3psbGdtaTFDaTVCMzRqZXR6QlJDcFZjeXpuNUxMaVNi?=
 =?utf-8?B?d00wK2F5KzJ0YytVRXpWSFBYNUREVFRJay90cEdaS3U1eC9rZlBPN1pFSENm?=
 =?utf-8?B?N0h0dEU0M1dxYkxaWXRRc3ltbUhweWhHVXJiQUVQdnRMdjhoSEZXV2JmOThI?=
 =?utf-8?B?TlQ0T05MR1N1dGdBRkdrZEczUmNTL1ZScUJodm5jMkx1Y1cyNjc4anhsK3lQ?=
 =?utf-8?B?V2xydmc0ZjA2NVlOaGtFRVpkcm44YUgzREdjeTQ3Z1hObEVNVEhoWWJlakZN?=
 =?utf-8?B?ODg2UE42dCtXcHNRM0xLMUlKMDJHbm1GQVJSRUhPc3JmcnlVdUV1TlpDQlhV?=
 =?utf-8?B?TDFHWVk2dlpuU3l5bHRXSHR3VzVHWEpWS2pEeDE0RW4yS080eDk2UFFQUEI4?=
 =?utf-8?B?aFhteEs5UmZUMzF0ZFphZER4S1lzR3A4SkpWdHJOS1QwZWN3RjV6aEdYSG5y?=
 =?utf-8?B?c0ZKVzdXNUJuUXd4SzdLcXU2cGNlRERrZTFBZGFaME9CMXJKNUxOTU01dVdY?=
 =?utf-8?B?Z3FiUVM5RjRFLy9RcjBuKzVpelB3OEdLbTRFV0doSTJ3NEc0SSthNnByb3Fx?=
 =?utf-8?B?KzJacW15Q2RBRnJPUFpJTHJCaVBtYVpxQTBXTHpEUVYycTh2RzFIUEt1NEJk?=
 =?utf-8?B?czVyTXZQMkl1eVZzQXpYWXFmcFJ0ZjFuOWVNc3ZiZ2VRK2pxOWJvV1dSWjBo?=
 =?utf-8?B?MGtiazJyZzZoN0haeVV4YzdtbEUrTzJjRFo1OTZhSitRdHVwUUdJdVNqdXAv?=
 =?utf-8?B?QlNBQ2FHaXhHS2thRFRuOW1jUzZta2UzWEtiU21ZeVU2dFk5Z3JpQT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024c056f-c1ac-4982-9215-08dea1aeccd7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 03:08:46.8928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xS8pgPirZgqZFSY+T5+kdZryce40SOgC/AGoS+kXsUG9QsOZ6RB1cefI2py67P3fOrLhtBtgutPfHC4tIXLiKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR18MB927681
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

Hi

Do I need to take further action on this patch?

B.R.

Howard

Edgar E. Iglesias 於 2026/3/4 上午 03:04 寫道:
> CAUTION: This email originated from outside of the organization. Do 
> not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
>
>
> On Tue, Mar 3, 2026 at 12:59 PM Edgar E. Iglesias 
> <edgar.iglesias@gmail.com> wrote:
>
>
>
>     On Tue, Mar 3, 2026 at 12:44 PM Peter Maydell
>     <peter.maydell@linaro.org> wrote:
>
>         On Tue, 3 Mar 2026 at 18:32, Edgar E. Iglesias
>         <edgar.iglesias@gmail.com> wrote:
>         >
>         >
>         >
>         > On Tue, Mar 3, 2026 at 2:33 AM Kuan-Jui Chiu
>         <kchiu@axiado.com> wrote:
>         >>
>         >> Hi
>         >>
>         >> I was referring this commit of upstream kernel which xilinx
>         added BXRS
>         >> register in Cadence UART driver
>         >> serial: xuartps: Adds RXBS register support for zynqmp ·
>         >> torvalds/linux@3816b2f
>         >>
>         <https://github.com/torvalds/linux/commit/3816b2f886d0918d8a8ae593b2db203ab905a889>
>         >>
>         >> Peter Maydell 於 2026/2/16 下午 06:53 寫道:
>
>         >> > Where is this register documented? The cadence_uart.c file
>         >> > references the Zynq 7000 Soc TRM UG585; its URL for that
>         >> > is out of date, but looking at the copy on the AMD website,
>         >> > there is a table giving the register summary for the UART:
>         >> >
>         https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/UART-Controller-UART
>         >> > and it lists only registers from offsets 0 to 0x44.
>
>         > There's documentation here for zynqmp:
>         >
>         https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/Rx_FIFO_byte_status-UART-Register
>         >
>         > I haven't looked to carefully, it may be a register that
>         didn't exist in the version of the UART on zynq and was added
>         in the version of the uart in the zynqmp.
>
>         Thanks. On the subject of Xilinx specs, do you have an opinion on
>         https://gitlab.com/qemu-project/qemu/-/issues/3297 ?
>         Our Xilinx AXI ethernet device model lets software write to
>         the PHY registers for the PHY ID, and it's not clear to me
>         whether these registers are supposed to be read-only or not.
>
>
>     Yes, they should be read-only, there's probably more registers and
>     fields that have the wrong access restrictions as well. The PHY
>     model is super simple, created just to get guests to not get stuck
>     on boot or fail to use the PHY...
>
>     IIRC, there's been several attempts on list to create a better
>     MDIO/PHY interface with shared PHY models but never got merged.
>
>     Cheers,
>     Edgar
>
>
> For example:
> https://patchew.org/QEMU/20170922171323.10348-1-f4bug@amsat.org/
>
>

