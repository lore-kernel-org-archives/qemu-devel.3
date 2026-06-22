Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566DACD98E4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 03:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbVc4-0005rI-9Y; Sun, 21 Jun 2026 23:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbVbw-0005qk-Pl
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:46:13 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbVbv-0005Hf-6a
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:46:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n20Iy2cTis5ol9VJVMLeHmbTcjhQD8jpMGtAaioC3sXwYvUvWtMV+Vgf2gUEcjdvTM9CgMVfOEcZVr8jsptl+KIoYErXl0jnxLu3f42QL/w1tWuIjFkYEFkum9NitjcQPmKZUPxxLvVg0WpryOgU5y8U0nid108300SMkZl0/JI0tow36rjAxczEnKg5cttGxhYlWzR8BCPHfOcxq3g0+DgwI156VTX/DWF4wG1/zHm69JeY1DyzGC1HT/G+Emn4SPRNlcJt7aTHp4J/+4eJ9Z4Zo7W4CmpR0xHCQvWzG8Mg20RiYL7yBjQ7zd6K+sRvwCS88F6V1RowmYtuyhW0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJvoYg49jhvPDMVWNOyVPpwGaBY/UnU5PJ0JK6CjruA=;
 b=J39O2M9r6nivZV6++mzL1DruK8HMYEA2hxg+2snc/BY7M1gcHo/h6vNWgkbfxAIbksbfen1ShjUEwECcDNwyJ8x40L5tfBwAtrerZoLglTGQaCBZHP+ZYMk4qg8OtiF6wLTA+aksO3mmqQJ5gP58sdYNnttkThzHL1KzqBPLBAjAmF3knjRtvw2fSvh4LZbkkZgdik+HUXvB00yI5W8vlVYcBdEs3WUld3gcMpaYgmQwCY29waKfrc6pQdS2Hl65QnaoWKhTLdvrlLYIzH39iVVY9cqu6geHAz4KeQ/rauYBopby/8Z8QR2z03y21EIYmwY+nRSD7+a6JvHxB01iOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJvoYg49jhvPDMVWNOyVPpwGaBY/UnU5PJ0JK6CjruA=;
 b=kdVpXpG4MXCH+NQ1IUIhCNz9v8Ngy5vKoTQfpFPdg1zgvAhjhlYCj59hZH1cl3w7psdUat8TlhtOvudipx6HFpRLMGL2n3aJrVpTbYbhQw1rmVzQb3pXcDqJZWlhVaD0hBodcdsOAhN0KSt5hFSCty8w/17WoH5GdOEEG1wSxP2QD+fukdQXmsNCAzn7tkRH4phaCY5PBNKMIJakppYyCqxo5kyLLl+PS1ahBxm/hdfeLia+/VsJ7MLdHIgdhmY1F6vq9YaYLzhxZrj4EjlBggtHQ4wRdhHotGQPvv5hIsxRE4x+RRDZBh753XcFr3eHqZrKnTdGG+/Qaj+w5QGyrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by CH0PR18MB4258.namprd18.prod.outlook.com (2603:10b6:610:b9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 03:46:07 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 03:46:07 +0000
Message-ID: <d65ac351-6795-4170-a79d-d8fff7d77e8b@axiado.com>
Date: Mon, 22 Jun 2026 11:46:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] hw/arm: ax3000-soc: Enable Cadence GPIO controllers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20260618101249.2926976-1-kchiu@axiado.com>
 <20260618101249.2926976-9-kchiu@axiado.com>
 <b1dac60a-f4fb-47cc-9a92-f45732f9d684@oss.qualcomm.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <b1dac60a-f4fb-47cc-9a92-f45732f9d684@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0044.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::18) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|CH0PR18MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: f72add3e-e1ab-47d6-5f47-08ded010cae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: pKOkjxYwJwvQ5EA0e+5EiuS+TL6i7N8Iv664gLbFdoejzo3XCvFDfyiB1igVCpQ179G66XRWEC1CMjfgyeIJ1IsQ8GCG1IKBZrCxA5eDkkTuv6mhUgd6LWAwU6w3QEerFyy2dHzqgsdF1TQ8XpLxre2bOJTMr4+kchbPWod4OL9UDereIUOLVNmNAsYitfrrFQkBx3Q7r0t+PMY/HEICwSBZ5+Cs5qk38HiMRt2ua+VRWs7N2/FDJM6w5/Etw9fwQpSjRxaaX7thx7ICruO5+tXVcsdh9Hyw7qdBKVbTAq6NgVCjXl2OpMdQBANb2JHM1Ggc2XasK2pVyLJdEeAW1S/fL/zCJ6qlpBrG8Z+tfL8rsqdlmAuTBUkM0VD/Rq0BlfKC5dTGcSm9uj6BZ2m5cJy1VdIO7C8JkBqwZc+z+ITIy7rysjp6jhJz0aRM03L88KY1C9VhgypnolY41pYbbtV5yCbnquO0mDzjVf1uFMfrTW2J8QDi5yZlukFg+23ryAUOR3HgGZi7xRhz6/rG90y4Cm370c1JKmG827P5zaho30f7Fs0aonuzBSKo+SEOuItZeDDQy7Ebx0jO5r56lwaPwrVeYcfeuz14+VdCZfJNSHWXSTc6QwZKCT2n58uC1DTrSmp3apMXL6IjwQSWvhnqkuAmYksGkpq+kLwK9lI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjBxd1BRcllBTHVZZTA3UG5qcDdxNnJOaWQzSWhhdTVtcllKTXcwcUZYVm5j?=
 =?utf-8?B?L1lwRHY4YllBZlRaQjFXS2hMbWtqTmRSSEtMMStIN2lwK3JXemdad3E4RTVJ?=
 =?utf-8?B?RC9JMHhwUENaR1Z2ZVdrSitva09zNW5EbzVXZDlhc0dmT0JJb0x1WVFCQ1l6?=
 =?utf-8?B?aTdBZDlTTHRnZDlwdlcvM0lwU0txbC9vZGVCU1h0ZW5uK0FLOGcrRjQzNnJR?=
 =?utf-8?B?OXczVzhLZWNhRFQyQkVIbU5zRXBBSVdpc2hOV0M4MTAvU0dYdUF2RDNBcnRq?=
 =?utf-8?B?MVJ2bSttL2I2bzFTV0R6cFA5UHRxN3RoTW5GOGFXVjBVVy92T1FuQzVxOExo?=
 =?utf-8?B?ZEtwdG1EdlJWY090dTAvait6cWFjaVlaRFBRNWIxZm1yZ1l0TkVwWGlJMDBh?=
 =?utf-8?B?N1JDWmJCS0M1UGVzNnRtT2pQVE5ZRFpGK1lxMUNHeVUwdE9JZGE0Z0JVWit6?=
 =?utf-8?B?Y0JFdFgwUnZ5RkFWWjdaaFEzZDhjOUJwNU9sQ0RUbTd5Zy8zcUN0eUtMb3gw?=
 =?utf-8?B?bnlLS2lrWE45bjJ5SlVGWDhRcGpRYzhlMWdIZEp2T2ZkYWs2RTZxN0R3dGQ3?=
 =?utf-8?B?eEJEV0FYUEc0V0ZVWGRQT1J6c1pwUUlRcnRhUkhZUnVMWGNRMGtlU2JlY1JO?=
 =?utf-8?B?V0tnOVNWZUx3ZlVKdmxLQ2xXaFR0ZGxDN05nWmNVOVRXTTFlMDRVaHpxRUUv?=
 =?utf-8?B?aFVGZTlqZ2pHQ203a1NOOENjekMrWHh2V00zZmZiN3pnVVgydGZpRGtCMmFW?=
 =?utf-8?B?NUdlQ2g4ZU1KTHpPQVQyUnh1YUgxUjdiMXYrdVlpblNWZHo0N1BUREw5U2xW?=
 =?utf-8?B?c2p1Z1pHVVZGSHBkZzAwdjFvSGx4L1VPdVlDYkRielVUei9VTW5JU0E3NzJ4?=
 =?utf-8?B?WWdCcDYwaGE5RURwek90WTlDTFdQRnhNWlU3K2dKblZRSVdMOTYwTk1RUzZv?=
 =?utf-8?B?RHRhbVNpTVVOSlVCN0N5c05neHpqbktyZHh2ZFNqeC9ySTJuUUd5Nk9XZE5J?=
 =?utf-8?B?elJGSGRCM29WRUhkRHlEbktMc3RhZ2tYelBua2RtTmdmeE9KUnVsT2Y1YTQx?=
 =?utf-8?B?YzlraFJ3TFBDMzRWRncwYnBCaDB2bmZ4NnZIaWxSTE5Uc3IyTCtEUFQyejF4?=
 =?utf-8?B?VmFRcG45QkU1eVY4MmJzZnUxM1dyZ3NWVndTV3UyVHBDTzlma2FqNFdDdmhv?=
 =?utf-8?B?dDVpdDRyT1I3S1RCdzZ6ZkxWK3ZoeVZiOUVGNUFSUWNJdEJObWgrZkswN2Z1?=
 =?utf-8?B?UHpHTjh5ZjVmME5vTG9VTkFET1dYZm5UU2UvM2VNVFd2Y25ZQjFPYUZOMnBO?=
 =?utf-8?B?ZVRtSXlqNlhlR0NFWFpmQlQ0TVVNcmFlSTNyYUFaQkNtZDd2d2ZUaEdjckdI?=
 =?utf-8?B?QXJVT1laWkZORm1QZnRHN3gxU3pBSXpOVEJqWnhFdHZaZ25GM1FHYm9hZWxI?=
 =?utf-8?B?TEVpVElzNEVPRTExcWhIcDl6bkpheFJtK20xTkhLS1QrQTdzei8zak1qeWYv?=
 =?utf-8?B?YkgvTlpvSXlWNWdxYTMycC9QM0FXZHFKeUMwQzBzdUdLc0RabUR0WjlxbTVT?=
 =?utf-8?B?ajY4L3d4cHNTbXlKTGpOeWlKOG9vdkNLTTdjRUlxYjdha1h5VTlwLzNzRWNL?=
 =?utf-8?B?bDB0RTd3c2NVYnNTbkVOV1JuUWhIN29WN04xSmFuMXRWNTRKKzJLbWJiZDVs?=
 =?utf-8?B?ZkJvVXEyL2FZaEdLZEJRYTdvQ0d4SGNiSjBqY2tEbldUQmRORlE4czhLUVVo?=
 =?utf-8?B?VmdSM2MvSDhPMDhxOUVwWmgyZGpEbzk0SytiTHR6RXcwSXhXMHBjVXcweERF?=
 =?utf-8?B?b1BwdjAxNndUN1NoRTE0b0UxaHZ2MTNnbHZqeXVvMVdYNXIvMDJXMy93Ujgz?=
 =?utf-8?B?K1BxVlcvcEllNmt4NnJabUd5TlREZFY5SloxYzlQeWQ0aStlYmhUeW40bTB1?=
 =?utf-8?B?QTYvYjhrYTYrMkVwWjJnRzFzVFB6amlaK1F4Wldaa1JjbTNFdlNoVGxCQk9X?=
 =?utf-8?B?TEtFVEVkVE5IRDEvdStwemdZVzlZakNhcmdnWkFlWTEwZ3NJRnp0M2F1RVJ1?=
 =?utf-8?B?ZEFPS3FEUmdUZGlxTkJjdm40cDNleTdQbWc0aFVTQnFnV0d3SXRtRXBCVkVG?=
 =?utf-8?B?TlBGby9aUjIwV2VvQmhzQ21oNEEram9ITkJjQTJMV1NySmcvR04wWnVxbDN0?=
 =?utf-8?B?RUhNeW42Ui9EL2ZFSXJ0bDB0YkJ1TW5zZitLMEROODV5SkprSzB0WjBhWDd4?=
 =?utf-8?B?V0JNRExzTnBHdTJVclRudWRvTUNPbjRaU1JMYmhOdmhPQmwvSmsxc3JUQmM3?=
 =?utf-8?B?WEhXYmtsZzZqL1dMZElxRFN3amZqT0FuazdzUXVtc011ejJlZG1WZz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72add3e-e1ab-47d6-5f47-08ded010cae9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 03:46:07.7632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhh66zQ9b+uRQ98Qs3IeVKaBELzO2LbpLD9+GMDiIaL3W+gS0V1j+X/hPcBI+BDwmLh6V327SmAYflwXU4HpwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4258
Received-SPF: pass client-ip=2a01:111:f403:c112::7;
 envelope-from=kchiu@axiado.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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


Philippe Mathieu-Daudé 於 2026/6/18 下午 11:21 寫道:
> CAUTION: This email originated from outside of the organization. Do 
> not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
>
> On 18/6/26 12:12, Kuan-Jui Chiu wrote:
>> Enable 8 Cadence GPIO controllers into Axiado AX3000 SoC
>>
>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   hw/arm/Kconfig              |  1 +
>>   hw/arm/ax3000-soc.c         | 30 ++++++++++++++++++++++++++++++
>>   include/hw/arm/ax3000-soc.h | 21 +++++++++++++++++++++
>>   3 files changed, 52 insertions(+)
>
>
>>   static void ax3000_realize(DeviceState *dev, Error **errp)
>> @@ -183,6 +188,31 @@ static void ax3000_realize(DeviceState *dev, 
>> Error **errp)
>> blk_by_legacy_dinfo((drive_get(IF_SD, 0, 0))),
>>                               &error_fatal);
>>       qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
>> +
>> +    /* GPIOs */
>> +    for (int i = 0; i < AX3000_NUM_GPIOS; i++) {
>
> static const

I don't think we need static here because we don't need this struct for 
entire lifetime
I can add const here to mark it as read-only and others

>
>> +        struct {
>> +            hwaddr addr;
>> +            unsigned int irq;
>> +        } gpio_table[] = {
>> +            { AX3000_GPIO0_BASE, AX3000_GPIO0_IRQ },
>> +            { AX3000_GPIO1_BASE, AX3000_GPIO1_IRQ },
>> +            { AX3000_GPIO2_BASE, AX3000_GPIO2_IRQ },
>> +            { AX3000_GPIO3_BASE, AX3000_GPIO3_IRQ },
>> +            { AX3000_GPIO4_BASE, AX3000_GPIO4_IRQ },
>> +            { AX3000_GPIO5_BASE, AX3000_GPIO5_IRQ },
>> +            { AX3000_GPIO6_BASE, AX3000_GPIO6_IRQ },
>> +            { AX3000_GPIO7_BASE, AX3000_GPIO7_IRQ }
>> +        };
>> +
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
>>   }
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>

