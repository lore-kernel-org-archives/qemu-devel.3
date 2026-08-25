Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD7AC5DF9C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wykJa-0008M5-VY; Tue, 25 Aug 2026 02:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wykJZ-0008Lr-Ag; Tue, 25 Aug 2026 02:07:17 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wykJX-00029g-EX; Tue, 25 Aug 2026 02:07:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZKyhLO0O9O/3xEJ8WnYaZPS+J9XY2tZ8U4D2YLYh1FcoxJGM1AfurohMHXcfluBlJqHskGU6TiyfBuZNIf/PvXGydKNRc/HzVgODKK/4j/WaG3XYBp9niuGqiElSzE2UDzQU1seortlrs0tzeHXsilAXXZKT/qxJ/izLn5zUQ5lwUhubHa02mH4P4T7TAT15BmA7H5iqPn3aaDC1dBk50BPbETfyhgv5B2Q11xHIROJdiTDVZubfEt4Wr8VFEXQA/QbuuM2dpcxdSFtIkaG97Si3OCWU5kZyNL7FuB7eY0YSzA5imw5un8FuwrMQyNL8UyRmhTBO/1tkAXNAieUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVu/4v8IF7o7ajomzc9Ub7+fh9V+fse+rx/OqwBBcf8=;
 b=X62XSYtu0aLQQcOvreTSjhK9/esbA79EJyPohHlaWkqJwGXSlk7ytKWSgwWhL77CHdUAEjc7IRKyiqNj4AHaaLcAikd4BmwbZe9oV8FYKtiLVtjketOOV1HJkqXpGTYVy/AOAUPKSoEFyNfoy1A+q10LV3YLPhuCB5KEs/GI3IyBa0ckKs4OWLh05S4TTRkDrZnnfGVzIaLGZ4UTPFXckzEFVTRbed/ptzXn4V9Wkf15qwEZiR/8BUG3lbgqrZic7UJYT4e3j9Tg7g/Vrn6H/31440TfmvGwxrNL81Sy55Lt3/0memj63yDGnscK99RYgUfMK1TI3LTad3o1ME9QXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVu/4v8IF7o7ajomzc9Ub7+fh9V+fse+rx/OqwBBcf8=;
 b=usVf5JT4LU8TIF5imv5qrlacxOZ1fYj1jog3tQf2wk5zl7q7WD+6FXvkjN1ljtVmiuHxvcSDYm58mmLCFfkNWk1EvmlEabyWRkDwseeFO1ujY2WohCPZt9c2g4pjJc4LitXs8O9r5Scoi/dkAZ/fk3TxIUAc/uyAjjh+WVj+xS1Gfj40WZZcChi0xA7JrMfc3gXoiqw+cr91HG12mNCKu8ef1ofTSDAypoY7cU3PPv2eYJxEbSz77j5dB/+gZ3BfxSCmaQmVBmV7FswOn+8yh4dNa6qelIaFbg3LdW9l2s4AHDuwkuh8FkL7/qlq9nlumLHVmzT5+V1XNwq1fsT1Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by DM6PR18MB3521.namprd18.prod.outlook.com (2603:10b6:5:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Tue, 25 Aug
 2026 06:07:10 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 06:07:10 +0000
Message-ID: <9eb76bbd-be48-4095-85ab-7097a7a94a09@axiado.com>
Date: Tue, 25 Aug 2026 14:07:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add Axiado SoC AX3005 and EVB
To: Jack Wang <163wangjack@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20260825021155.2475879-1-kchiu@axiado.com>
 <812FA8DA-88ED-437E-B9A0-E3418F092DDF@gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <812FA8DA-88ED-437E-B9A0-E3418F092DDF@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0046.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::9)
 To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|DM6PR18MB3521:EE_
X-MS-Office365-Filtering-Correlation-Id: f386c20d-5e20-4686-74aa-08df026f19a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|13003099007|3023799007|10067099003|56012099006|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9OGIAc7tyXczOvevQ7TH9v00zhMXNXerOINgfmFEQTojRUplWWqdpHt1EWMMW/2mogM8PPi71ffI8rnSMz7uaNiHFQRiYOI48WAaumY46JLEQM7yqLoi4M7fmS2SpTz5q6VDlfahEqygn0yde85wvsiduEWqyiyc1S/HLidO6AVUd9zZYzOX+OGACcnNhRzEreQfagpnVFvK94rrHBQmmY4KJUYAshA2aiulKvhfxpPd/nOZ8CPLIQJj9RzknNiWYPwNI9crtvq2dtqPoblCxtRL+3mMPJpA6o3PXZMD0AZnlaMCxLTvQ7JF9AY42//twsom/meiFGpj8Rqh8yXZoNPrNIDu1VB+GIrudXeVwuEo5t0hmfolNLjbYK5Uznx3oI4S7iZuABJraToadR+EEh3ktAPXpU8iLueQkt+vNOkmPSEqFovqS2m1QNJ14FSKbHSDCH6Dwr1n62VEgWO/GyJvKCQ4DBqJm9UtKycrtQWEZAQToTm8Z6U/VzbnaT4eTqWN/xMPKGi4LTocME9B5zxTiQP3976+g7D1Nv+l8h1/O48Zml/whzxSSme0aI51EEyrvDWhjiZLJegdZRDDgkeUm/pgvKKl2jBakM/BuBQYXqJ2Y4z8uD6kgA5fgzvG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(13003099007)(3023799007)(10067099003)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHExTHVTeWhQendWK3pWVE9qd2EvWlFEd3FvUE9zbnRSUlEzRGJ5aTc4NWpY?=
 =?utf-8?B?WU5FK2IwMHQwUlNyemhKUlpHY0wxOG5GWHUvUE5QaXJyYytMZ0NaclVITER2?=
 =?utf-8?B?YVFVVmtFMFZqYnZzK01xSFF4NFNMRmxudWM2aEhKcklKZ2RiY2ZFV3RRM2Nv?=
 =?utf-8?B?Y2dMSjdUSGh4ZUtlZTA0ckZIQTlRNE90eDR5d21zL2RGZHlENEVkb1lYcGNO?=
 =?utf-8?B?dm9iZEp5MmFFQVlIYjhBNU4reVRjMCtIZDVwUmdjcmM5R3gxeUVFYnZVdFAr?=
 =?utf-8?B?YTlQTWVRVTZLWTk5UTRBS0NxazZySTlYZWRnd3ZsNmw4SnNYd3JYQWJ6bEJv?=
 =?utf-8?B?K2M3RFAwR0VRdVBxKzdkbkVaMUo3eGI0OW5LSzdQMVJLVkdvQVc1bG9Ub3BX?=
 =?utf-8?B?Q2FvNkZINWRkRWNUSHdidWoyM1hoNmx4b1NLbTFOMCs5TWpIb0paSHYrREN5?=
 =?utf-8?B?VjdwMkFPdlYzcEcwSkE1MVhDWU5rcnZiZnFWd1hEcGNQV2FjTHBod3JIQkVW?=
 =?utf-8?B?VzJoL0ZJNlltNTZZd3lUcjhadEpqUk9ZV0JxK2dlS0lod2RDSFc2TG1VT1pS?=
 =?utf-8?B?anZkQjNLb01YM1ZrbG5KTTQ3RGU4dGZEa09yZkR3c0pMWHlIeDJXenc3VUhj?=
 =?utf-8?B?a2lnbE5xSk5qUmhRNzdJb2lSZThVK0RYS2J4c3dLR1prczg0T3I2R0IwdEds?=
 =?utf-8?B?UFNBUDdZTVFIS3h3dHZ0bWZQMFJLTHpLNVRPVFFpcTBCclM1THFRNTVrZjFa?=
 =?utf-8?B?dVk3Q2lvdytOVDUxbkphcklDWWVOU2JxY1JBL2lUVmd4a0F6NThuM3NNT0RC?=
 =?utf-8?B?Y1dxWU82RkhleHl0TXJwQ1lsQ0pCclgvV0d1OUNHeVhNejN4VVV0ekZKdGRs?=
 =?utf-8?B?RlNYUldvVDREdDVTTm5vM1Z3aktCS3hEblpnM09qREpxN3g2NG1iSWxRQkNw?=
 =?utf-8?B?M3VFbGlBTWFrNHRlbzAzZDhQdytCdmJKbERXZVVtN2p4NytvbTllanJzY2lH?=
 =?utf-8?B?RTVCMGk0Um41Q3hLbHNkamRLSkNDU0hpRitBSkVSVlBFMTFtelVQc24rOTNy?=
 =?utf-8?B?TFo4Nm9oUmVlWjBkd0drbTZTQ3JNWGVPTTNmUk5FMmdXdDkwWnoyWmowdFZK?=
 =?utf-8?B?R2ZibG5MUWM3MFkvZEwrdnJLdmdJVTNYclBWVURTUGMybjN0cTZTc3V6dmRq?=
 =?utf-8?B?aGloSTBJZTdPU1Z0MXRIVkNCaGxSQUlGUGhhUXlubGYwbS9kbEc0WUJVSzhW?=
 =?utf-8?B?RlUrYlNGamY1SWNkSkU0emd2dmh0NnZHYjkvVnU2dWNXYnVGR3dkQWRodGJL?=
 =?utf-8?B?ditJVS9xVHV0WjdPY05LeE9LaklpWVArNXh2Q0pWc3g4NWpJWTlFQzRoN1JP?=
 =?utf-8?B?RGRuZVRDTG9LeWN2dXROZk1RYWovRkZsS3Rld0pDQ3dyOWlMTW9oVHBmQ3Qr?=
 =?utf-8?B?bmxUbWpOMkVFMWYvbXRranlzUWkyT1YzYmV5a0E3b001dTI2SFVQNXFMWUs1?=
 =?utf-8?B?NEhpOC81Qi9DaVcwN0lYeTNqVHF1K1kwNUZsaFp2dThwRWExWkw1OUpPbUpR?=
 =?utf-8?B?Q0FOL2JaRnpGQzBlR29mT0U0MDR5bmpCSWtrUC9ac0o0eVZxcGlTWWRwdVJS?=
 =?utf-8?B?OExLZU9UQmpJcHR4SGdTYmdTOXRZUHU2d3NQcnNHNnJUUnBGeE1GOS9aWERX?=
 =?utf-8?B?RDNxQWUzVTdKSmY1NDVUTVplTjU2Ukwwc3hDeTlYYVBYeVloSXZLQ2pGT3ZH?=
 =?utf-8?B?TlNLMzc5SkUzeWVlR0c0VXRWN2VFdVBPdEozM3RKVlVLZjRmdnh2UGE5NGcz?=
 =?utf-8?B?Mld3akNEMTBoMWJObkxJUGZrRUdOMnMrM1p3U1ZoenVnZExYRUV5TThhTWZV?=
 =?utf-8?B?Zk82SnV4Nmg1a0lMTGZEZXA0WlRLTDV6dkpGeWFWdU8yQlZQVWVjZzQweHNM?=
 =?utf-8?B?RUhRZVpjV1J4eUtaNWRnSDhhUjNuTzlWWE1IaC9rYmFTZlZRVTJjMk9hajJy?=
 =?utf-8?B?QWpyTVlUTyt2NFJzVm5yMCt3NExkdVAzNDBBWXdhcEpkcXZOVzQ3MmoxVGRv?=
 =?utf-8?B?SDJGREkvdjBwUWdHSyt5WE1GQ1dnYm9lOVIxczJpeUFjbldHcWhGcWEyZko1?=
 =?utf-8?B?U0ZSQWJWbi9nbFpQdmlBemJMVm9lNzNNVjlxYVFWQ3JHckdQNlFsQjBBR0pI?=
 =?utf-8?B?aUdSMy9XSjViTmN3TnM0YjhMUXJqSm1LRSsrRWx5QjFvZFMyRE5IMFlRaWFI?=
 =?utf-8?B?YWNhSUJrNTMzYytRdG1WRW1nOUhzYTlwQXR4M0VZNkc4QktVYWl6blBUMkNh?=
 =?utf-8?B?QlBwMmRzK2dBQjZ0WWVSTXNaS29SS1lzTUUvcERCcXgzU0NIMCtPZz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f386c20d-5e20-4686-74aa-08df026f19a5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 06:07:10.7492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXeZJuQloJsPjzSpfWSiLmb35UX7/9WXKeB73PhhPuFg1tIxY4fvm+Fouro2KaLo5/s0BHGR+8e6Ik77H2YVxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3521
Received-SPF: pass client-ip=2a01:111:f403:c005::5;
 envelope-from=kchiu@axiado.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hi Jack

Sorry that I can't provide the datasheet due to the company policy

I can only share about the SoC specification in cover letter and use the 
existing QEMU models like Axiado SDHCI and Cadence GPIO


I never enabled QMP before but you are right on this missing class 
problem. I am studying for how to use QMP right now.


B.R.

Howard

Jack Wang 於 2026/8/25 下午 01:52 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> Hi Kuan-Jui,
>
> Cheers for the v3, that was a really quick update!
>
> The basic tests passed on my local machine, and I will look through each patch carefully next. I'm not sure if I'm qualified enough to give Reviewed-by or Tested-by tags yet. Anyway, if anything I do during the review is inappropriate, please just let me know.
>
> I checked the https://axiado.com/products/ link you mentioned, but didn't find the critical info I needed. I googled for the AX3005 datasheet but not much useful infomation. AI tell me it's not public.emmm.. If you could offer me some key hardware information for the QEMU modeling, that would be much better.
>
> Also, since you asked for my commands before, if I find any problems, I will attach the exact commands I used in the email to help identify the bug. I am testing on my Mac now, so please contact me if you have any trouble reproducing the issues.
>
> Best regards, : )
>
> JW..
>
>> On Mon, 24 Aug 2026 19:11:50 -0700, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>> This patchset introduces Axiado SoC AX3005 and evaluation board for emulation
>> The model for Axiado SoC AX3005 supports
>>   4 Cortex-A53 CPUs
>>   Arm Generic Interrupt Controller v3
>>   9 Cadence UARTs
>>   1 SDHCI controller with PHY
>>   8 Cadence GPIOs
>>
>> Refer Axiado website for more product information
>> https://axiado.com/products/
>>
>> and minor changes for the compatibility with existing AX3000 SoC model
>>
>> Test plan:
>> 1. Verified the machine "ax3005-evb" with following command
>>
>> qemu-system-aarch64 \
>>     -m 2G \
>>     -machine ax3005-evb \
>>     -device loader,file=bl31.bin,addr=0x88300000 \
>>     -device loader,file=tee-raw.bin,addr=0x88400000 \
>>     -device loader,file=u-boot.bin,addr=0x80000000 \
>>     -device loader,file=fitImage,addr=0x80100000 \
>>     -device loader,file=obmc-phosphor-image-evk-ax3005-qemu.squashfs-xz,addr=0x80B00000 \
>>     -device loader,cpu-num=0,addr=0x88300000 \
>>     -device loader,cpu-num=1,addr=0x88300000 \
>>     -device loader,cpu-num=2,addr=0x88300000 \
>>     -device loader,cpu-num=3,addr=0x88300000 \
>>     -nographic \
>>     -serial null \
>>     -serial null \
>>     -serial null \
>>     -serial mon:stdio \
>>     -drive if=sd,file=obmc-phosphor-image-evk-ax3005-qemu.wic,format=raw
>>
>> 2. Run QEMU test suite
>> make check
>> Ok:                331
>> Fail:              0
>> Skipped:           17
>>
>> make check-functional
>> Ok:                28
>> Fail:              0
>> Skipped:           7
>>
>> Changes in v3:
>>   1. Remove patch "hw/arm/ax3000-soc: Add missing class_size to TypeInfo"
>>      because it was fixed by commit 4f50d637e2
>>      ("hw/arm/ax3000-soc: fix heap overflow from missing class_size")
>>
>> Changes in v2:
>>   1. Add patch "hw/arm/ax3000-soc: Add missing class_size to TypeInfo"
>>      to fix incorrect class size
>>   2. Add missing class_size "Ax3005SoCClass" to ax3005_soc_types
>>
>> Kuan-Jui Chiu (5):
>>   hw/sd/axiado_sdhci: Add header guard
>>   hw/arm: Rename ax3000-boards as axiado-boards
>>   hw/arm/ax3000: Specify SoC name in header and variable
>>   hw/arm: Add Axiado SoC AX3005
>>   hw/arm: Add Axiado Ax3005 EVB
>>
>> MAINTAINERS                                   |   2 +
>> hw/arm/ax3000-boards.c                        |   4 +-
>> hw/arm/ax3000-evk.c                           |   4 +-
>> hw/arm/ax3000-soc.c                           |   4 +-
>> hw/arm/ax3005-evk.c                           |  55 +++++
>> hw/arm/ax3005-soc.c                           | 225 ++++++++++++++++++
>> hw/arm/meson.build                            |   6 +-
>> include/hw/arm/ax3005-soc.h                   | 102 ++++++++
>> .../arm/{ax3000-boards.h => axiado-boards.h}  |  10 +
>> include/hw/sd/axiado_sdhci.h                  |   5 +
>> 10 files changed, 409 insertions(+), 8 deletions(-)
>> create mode 100644 hw/arm/ax3005-evk.c
>> create mode 100644 hw/arm/ax3005-soc.c
>> create mode 100644 include/hw/arm/ax3005-soc.h
>> rename include/hw/arm/{ax3000-boards.h => axiado-boards.h} (69%)
>>
>> --
>> 2.34.1
>>
>>
>>
>>

