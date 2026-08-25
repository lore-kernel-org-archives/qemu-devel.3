Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A64C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wymee-0000pD-1P; Tue, 25 Aug 2026 04:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wymec-0000oy-K7; Tue, 25 Aug 2026 04:37:10 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wymea-0007g1-RJ; Tue, 25 Aug 2026 04:37:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hs2a6XhsmDKvudGLMcmEgHA/ZArTTRlnoJlXW2+Cygor22UB7o2hiR4AA4mV7jOFPCIZn/FDLeDBU75kV8jzBnaPd0tbzoWT2EZWTDTn9F/jiJStKyHo9/dqMoD7GFLkX8g0p4wXCW2T3hB92hzeu4ifURsKE/mDZ+76HptGlxmRFeikyvzAzS4+KIzkl9uO1U1hXMmXUi/sDBYwZw8ruaQOi4EVvqoh3cJRIbgaR0QDERXmgj9IRDNmV+K/aMWuZ6+oyQgD7rsqGLW4QpKc7RqDyfD3vo5r30oNuRyDq5TJG/dioiRMprAq27LNiDfd7fvssr2MCsO5SB+p+Ns9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qC8SZbFW/wsRH5hozNDBqEn4Vr+ZlPe/HSC+aIMwID8=;
 b=rm1nO6YRY6xUdkWT1vgcxgYROkYuPngL4VN5lKBfIDyHoOcVzVVww32UufqzUvHmjZO6W2853+N2c7rJbM+BVaNemTqsBJIZke95qNkxJQuF9T7zgUeFKtklMhpftueoB3lCnG4rA9ePCf1hqjjZSHOJY9tz9H4Z/IPIIBXHhvLxBxGa8KJ78HaI0a5qxXWA9lBLS9u9dxOVb/SQd85mTO5FhTIc6w733IG5t9Ao5WPeyPMadN4YDLah6pzagT+DUPURpYOg9Axmz4XnWir4E6kSR27xP/5BaIc3KVW4rWJ8Hu+FQxZqzdJdQ3jrV2F12zqnkW2ti2RrXB5ZBrAiiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC8SZbFW/wsRH5hozNDBqEn4Vr+ZlPe/HSC+aIMwID8=;
 b=vg6rWUY426IuZtHqHiN95spDs/f2PIwxmhHfFNxuusMdtgHLMe2xCh3bn/5NihgjHj1xKMWNQ6UQz5Gyw83/QthUAx9qFNqmav0c3bBGSkArVbLysgldlP21o0C+JXukboLzpzsPdCDCvI4x4q4XKa2zjOPmr1A5knJ28ZwD8uHRjVWhRIEAwo9YSUVMCZquJn4pFnmIa7I+vIiIG+qtU/h7jA+mKmGtsOfVJG5GOxqgZyvyULJ9q6Qo8YQ84iOTWDiyBc6S4IbCz6ucU8BWxvLTBebTpc+woOKfG8Xns4pTGpLKBOJFsGl60iVKjNDxlrCcOdAZ5TZifnxwZauRLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by LV3PR18MB5778.namprd18.prod.outlook.com (2603:10b6:408:1aa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 08:37:00 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 08:37:00 +0000
Message-ID: <82aceb1d-bdfe-4d6b-af5c-b46f5fada470@axiado.com>
Date: Tue, 25 Aug 2026 16:36:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add Axiado SoC AX3005 and EVB
To: Jack Wang <163wangjack@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <9eb76bbd-be48-4095-85ab-7097a7a94a09@axiado.com>
 <5783F0B2-CF7F-450D-82DA-93A6BB0CFA38@gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <5783F0B2-CF7F-450D-82DA-93A6BB0CFA38@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0050.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::6)
 To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|LV3PR18MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 820ab8ab-776e-40e3-d162-08df028407d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|3023799007|10067099003|4143699003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: j7y6fKr+fLbDfv0bjGKzEfSCl6V1wOHYeKCGAFt6XTFOpGPf2oR4+GoVwy4yC2AZlm571E9Tpry8HdxWm7byaisS/fk5VXWP0wYYctAeh71C4KxPEAJmBOXiYIT8y3Ihcpd8ozoA5en66K3zzHtwFkQumXNWjk+RaXYZILLFD6zKWrQSox+BxZ4RuEACMCsBbVnX2I/gctx/H2n+ODyxL8GH7+IA4DIH7tesv9p+o20D5vQiWkuTCkJtCqpSbOqCGX8/jwuxcr+nZyqjrXyfoMIIf+P+qwWrOji8TRQc+CHlmxwGhXGQw/nQHnmK8ePsGyUpvgNJACeF4uFU7ONpSpNHaVydvoyAd1v4OvwhtPDYbOvJUfOoGQV3Vx2eZgi/vitN9rLwKfYEfdZpeO6I+cI3xGyYWpG36Nf5oGtDd/HvgAJ9xRfZKOyqIvg3kfC2xayf9Smd5LXZnok2M/nNTfvJgj69vdPRg5OKWTKXSshcmOJfYPMMnLyaB1UxFr0zme8VmqQCi8OWciO8OojnepMikl7VZeqWBijUqBWJB5N1+m73ilSQ3yXBx4CH9vDxvvOoos1VKqu4cLxLD+c2kP7wuOT41OypxskduwNTtOvp3W/KcEHujn1LjvzFyjRO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(3023799007)(10067099003)(4143699003)(56012099006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3NtZ1c2RmxNWS9mMjROQkxIZ0lzMFBJZStsOERmTTZDa1NUcjNQV1JteGNo?=
 =?utf-8?B?TUF1bWFtWEk2UEtoQUJIclNaVGdmeG51dkpuK2o2dEprZXhTbXorUEtHUFB1?=
 =?utf-8?B?VDgxci9lQzUzVXhSWjMrdlFSWFM1Mk9tcnB2RkZYOHhTeFRNdVhsSkpwcDRY?=
 =?utf-8?B?bVQ5VlFyNkhQUGpnUzdnTTAxY2sxZE50OURvQ0F5b1Zhc2dBTkJYVjhLRWht?=
 =?utf-8?B?by9WNDBkemJHSUJ5dEZZNm1IdzVnZm9lVUJETGx4NjRHSzl4Mm8ra2lMUlFI?=
 =?utf-8?B?SVo2dkhJaFdrUWNIMFE3Z095K3VDN0FJb2ltRlJveGkzVTZ5MjZJemhvQUNx?=
 =?utf-8?B?bzFRMTdlMVdMRzJ1MmgxM0piOEU3MzB6RnJEaXY3S3FKbXpBZ1B5bkJIZ1py?=
 =?utf-8?B?ZlBJckp4R3JjTTY1dUpLSVRzVG5mNzd4RUZzVi9NS0FSUnZvU0NITW0xM2Vi?=
 =?utf-8?B?WWlVeUtLN0g2MG1mRVpxS0pJUzJZZ21PTHp3a245Nk84SlJVWEwzSW44REhO?=
 =?utf-8?B?eEFlK3FzdkdsRjhwWDhjUWcvV0ozOCtMZUxXQ1NwUllwWm1oYkdtNzVNREJN?=
 =?utf-8?B?VUFRYmR5aTZjc0E1UUJ6NStBdDhqQ3EzdTEyVTRrNGVZK2NzbDI1RmpXWVg0?=
 =?utf-8?B?YVczZWxPeWliZ1hPWml6UFdjV1JPeFpoZGZtREVEQmVrNlVPbWx4VEtEcWR6?=
 =?utf-8?B?bm5BVlR2Lys3Rjc3djBGb0ltcDRuc295b0xDdkxPUXlPU2R6MUt6Q2xSV05G?=
 =?utf-8?B?RWVYTzc2YksrZjk1QWNacEVjeU1yN0xYU0pMVElvVGgwOHBKekkyVVRmN05J?=
 =?utf-8?B?WlNHb0FuaVFVeEVFcHBzc2RmRDBITzJNbkdTUVBUUVF3V1RpZjl4SHB1WGxR?=
 =?utf-8?B?ZUlCVGwwcUZMUEpXeWsyeG9rRkhkcDNWUmU4cDk2YlZtc3BoSEtRekpEYnhK?=
 =?utf-8?B?TEdiZDN6RGw1K3pRRjgrL3BHWWk2T0xDaElIL0tiNjdBaVlHNHNuQmZGdDNn?=
 =?utf-8?B?M0E3T3BYa0RmbE5BblArdnpscUVZNXk5aTBuMGM1UmlUWCtvd3NIekttbk5M?=
 =?utf-8?B?YnlLWGJCRnhMZThObVdSam9qbHBrb2JNRkRpOFhhbGNYaDY4SzdaaFYyeVZJ?=
 =?utf-8?B?UUJqRkMwWEdPNFYveEhFbU5BcFh3Y0gxK3Q2UW4yME5hSk01b1VjYWxyOTFk?=
 =?utf-8?B?TzBVNXZsWjdUbVJiWms3NjVKSHBiT2kyZy9JbnNzejhqRjN2NktrU3YzdU96?=
 =?utf-8?B?T0p6ZDFLdHN2bWhqS0piNFY2OVV6TEs5VTQrdnVkSmh6Z0V1ek5HNkJqNzJt?=
 =?utf-8?B?VkV5aHp1eERsRFM4cW5HakhXTDJ0Mng5T2xRblJVbStsY0UranZBelBmL2hO?=
 =?utf-8?B?REVKclYyZmtZQVVyTUxOS1hRajFHaW5EbExHRW5scTFjMlN2Ym5xRVNZa3Uy?=
 =?utf-8?B?eVZmMUtxNEtmODBiWSswaHZPWmFpRWIyekY1V2wwOFJwYUVjQWdDb3BTejBC?=
 =?utf-8?B?SC9lMnJWKzdhRUdrUmhpaGpmWGhHQ2h0Rk1sNER3WG8ySVB0QytnYUNqRFVM?=
 =?utf-8?B?WXkwM3pNZkpYTWJaUmZoaGhkL3JoMXovQnQwNlZ6cE4zdTc3UVVuMTNIRFp0?=
 =?utf-8?B?YUdhZnFSRHlTZTVoWEFLL01NMzhsdVlmVit2N0lJRDlZeUdYMjR3akQ4ZEVL?=
 =?utf-8?B?ODl6YkUrSkZJVkRIM21leTBRRHVhVWdqRFdvQmlqZUVPa1pGeWtMOUE4UUd5?=
 =?utf-8?B?cDJZNTk5b1RwTFhzb3F0dWttZG1BM1RLYzBYTnprVmQ4WUtLY2FDU1dTeVJ6?=
 =?utf-8?B?NWZEVlBJK013OVIzbHRsL2tHWFNIZEo0bFI4VlF4TFdieUZXRU42RG05VDgx?=
 =?utf-8?B?WnRlbElwTUZNeWFPRnBXdHhvdUJhQW5RVVlad2pPbU53ajM2U3o5d1NZUzRz?=
 =?utf-8?B?VmI0ME9PbWYwT0RDdSthRVc2MUQ3SXJzNkZVeVp1bWtpSUdBNTdWKzVLejVj?=
 =?utf-8?B?cVF4U3FTZnFwZitYMXZWZTdXcGlDWURyVmxNajQydlNlTjQzRmhwRXR5WS9W?=
 =?utf-8?B?Mjg3Szd4Sms1dmhMSDBRaVAxVnd5M2pwWkFRQ3djWFp4UXVJRUUyTDBDSkVu?=
 =?utf-8?B?eXB2eUNkeUpVWWZndURuanZ2Q053d0hXTFJGZzBKYytTTmpSOWwvRlcxTXUr?=
 =?utf-8?B?L3U3VndYNnUwZjhRb1hjNGZsbWNPajlnREJwMVBpYWY0d0JMZGphVmluWWxl?=
 =?utf-8?B?NzhHcG9QdG1BNW9iNTZ5ZE1FbDlWbW9EcVRsVmxHaXpyajIwSUZmNXZMcVB4?=
 =?utf-8?B?ZUcxK0VMWVJCODB2K1ZrRjNDbUM0WlpIZFpOUXpNR25wVU0vQVdXZz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820ab8ab-776e-40e3-d162-08df028407d3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:37:00.3787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVBAdKsDneWTtS7vw6MtvTgC097x/bgGKFRuOilhENyLpFvVS9QeJJUocVS3++NQvoCIBespglHeSWdwt97W5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5778
Received-SPF: pass client-ip=2a01:111:f403:c10c::1;
 envelope-from=kchiu@axiado.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

Jack Wang 於 2026/8/25 下午 04:00 寫道:
> CAUTION: This email originated from outside of the organization. Do 
> not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
> Understand.
> I still need some basic info for confirmation.What the is mmio window 
> size for each uart? Is it designed to be overlapped.Do all UART 
> instances use the same register layout and window size?
>
Yes, each of UART on Ax3005 SoC is using the same window size with 256 bytes

I checked the Cadence UART model, it reserved the 4KB statically so that 
is why it is overlapped in QEMU

> Thanks
> JW..
>> On Tue, 25 Aug 2026 14:07:07 +0800, Kuan-Jui Chiu <kchiu@axiado.com> 
>> wrote:
>> Hi Jack
>>
>> Sorry that I can't provide the datasheet due to the company policy
>>
>> I can only share about the SoC specification in cover letter and use the
>> existing QEMU models like Axiado SDHCI and Cadence GPIO
>>
>>
>> I never enabled QMP before but you are right on this missing class
>> problem. I am studying for how to use QMP right now.
>>
>>
>> B.R.
>>
>> Howard
>>
>> Jack Wang 於 2026/8/25 下午 01:52 寫道:
>>
>>
>
>>> On Tue, 25 Aug 2026 13:52:51 +0800, Jack Wang 
>>> <163wangjack@gmail.com> wrote:
>>> Hi Kuan-Jui,
>>>
>>> Cheers for the v3, that was a really quick update!
>>>
>>> The basic tests passed on my local machine, and I will look through 
>>> each patch carefully next. I'm not sure if I'm qualified enough to 
>>> give Reviewed-by or Tested-by tags yet. Anyway, if anything I do 
>>> during the review is inappropriate, please just let me know.
>>>
>>> I checked thehttps://axiado.com/products/link you mentioned, but 
>>> didn't find the critical info I needed. I googled for the AX3005 
>>> datasheet but not much useful infomation. AI tell me it's not 
>>> public.emmm.. If you could offer me some key hardware information 
>>> for the QEMU modeling, that would be much better.
>>>
>>> Also, since you asked for my commands before, if I find any 
>>> problems, I will attach the exact commands I used in the email to 
>>> help identify the bug. I am testing on my Mac now, so please contact 
>>> me if you have any trouble reproducing the issues.
>>>
>>> Best regards, : )
>>>
>>> JW..

