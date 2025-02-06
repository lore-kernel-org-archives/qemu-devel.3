Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389AEC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3Ry-00047H-EF; Thu, 06 Feb 2025 10:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg3Rr-00045n-Qp
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:05:48 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg3Ro-0006eM-U3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:05:46 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dae9a0566so483488f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 07:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738854343; x=1739459143; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=suklDlITHQcChgPwi6vR1PzjOXyN+avaT+qTX5br7Eg=;
 b=O1nH8ZDbt9nhmad1nZEZt5OqAiFbNBTh+rHA4yj9MJ6MTODzJIJyL/kpOQBI3Tt3qk
 UWxL53XUMpdLI/GZ/J6brPIfeFCUsWA0+5tljxnelpPHqWDRZqGFUWAkemsVAPV6kwwE
 SHs/JvnC7nWuh87jL6s6kNGwWizx2yYLJ1ySsjyQ0DmTtnehZpEbrhvM/5bj+gKKEp6q
 L8+Isd59zGCZIixqXdOi22WgtMHWCOkHAdr04slAxJ/FFdZFIWUTrp/6EO2n54m//EQE
 8aH4BEwAjQTus3ifh0L/hWhihiep9KVAfZvkaPo0htjpQAZIKLlMFd4kcQpHTeSIRvU+
 W4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738854343; x=1739459143;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=suklDlITHQcChgPwi6vR1PzjOXyN+avaT+qTX5br7Eg=;
 b=JBMlV2YlZa1UrrF0frQaTujMyyL8Yp6ypcydXD+zI7ueLyczHLpTZiIN95dGT0hoL4
 /O3kBPreZY45maY7pJE9EV0feF1X2R3xCRHvMFnyvNd6H1/wfhsQ1FuM7qtIw1WDgTpO
 u5ShW7ZZw1kgiDNS5APB83FIvgMVv3sAdoJJwWfp9KKUok7cMmmmhgUPQOmfktTVNJr0
 p6ARTBNk5GUMd/xP5Hl/gw8qfj2t9aAfdob5okQWK8V7tdHKYlfivEkje5rtWcMvfv0S
 CUWw+LQ2Jmkgc9lUNEYZJzNJiHeZA0N53b9afBuQ39w+aCOCAO9agBlq3lY3A8k+QCdO
 +sgw==
X-Gm-Message-State: AOJu0YzvaWU/j6XJoy2RRiPHxlJVHLZIesKWedFopd+ZpNG1k2J4RGmE
 b0kIdbElT6HvhHUceVOOfjT8VkPWgc5FxX9QmLXy3v3XyhNV6UjeIDu/eFuhu2A=
X-Gm-Gg: ASbGncsJDmyV7khla7NSIHyTqR31ojHRfzfLsZT2MAGHC7d5OE2JW3R9Vu9p6L/ml8c
 zMnhRmsvAxQQvFtyKEsjh0ySl/8KlOGhRhKjsup2CVZDpjGbftyBiLpIRV4bCMYKpiTJwJ1wYj7
 a4hD86lbSM7iYwgzY4+qCgfrh0t3ePN396cwJAMftOuCptiUuwaA+/esNrTQyew4s60HKlip/9C
 ulsZwF8lG/rJ31cO2tRCUPu3RPx/zRcVCgZ6sd0xErQGnYg8gbRrSK4gYDtueGjNK4PZDF7RZND
 jwalynh2tdkjGUtaqSKtx3JoGYdGRtLlKfbUGBXdPfxSU7JFSYq5CBqQK7E=
X-Google-Smtp-Source: AGHT+IEZ7HmGU66nD1sJ+9HlHaSLd4kl4AeaeYhevJUj6vgAwjPy/0SJCeNcE/7CAFW94giwbQMHQw==
X-Received: by 2002:a05:6000:1842:b0:38d:bd41:2f8b with SMTP id
 ffacd0b85a97d-38dbd4132c2mr1921017f8f.44.1738854342642; 
 Thu, 06 Feb 2025 07:05:42 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde1e197sm1974484f8f.91.2025.02.06.07.05.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 07:05:42 -0800 (PST)
Message-ID: <35c7e20e-2bfb-4523-8685-edcb753db7dc@linaro.org>
Date: Thu, 6 Feb 2025 16:05:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdhci: Set reset value of interrupt registers
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>
References: <20250115190422.5F0FA4E6030@zero.eik.bme.hu>
 <8cbad5be-e67b-46bd-9198-f7c90ad5ff56@linaro.org>
 <cc92e02b-c20d-974e-8b6d-bb30ea5af452@eik.bme.hu>
 <800dcc1b-8bf6-48e5-843a-99e630d4b494@linaro.org>
 <bd8e216d-df13-4842-9a5a-5f274237359c@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bd8e216d-df13-4842-9a5a-5f274237359c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/2/25 14:49, BALATON Zoltan wrote:
> On Thu, 6 Feb 2025, Philippe Mathieu-Daudé wrote:
>> On 6/2/25 13:49, BALATON Zoltan wrote:
>>> On Thu, 6 Feb 2025, Philippe Mathieu-Daudé wrote:
>>>> On 15/1/25 20:04, BALATON Zoltan wrote:
>>>>> The interrupt enable registers are not reset to 0 but some bits are
>>>>> enabled on reset. At least some U-Boot versions seem to expect this
>>>>> and not initialise these registers before expecting interrupts. The
>>>>> numbers in this patch match what QorIQ P1022 has on reset and fix
>>>>> U-Boot for this SoC and should not break other drivers that initialise
>>>>> (and thus overwrite) these reset values.
>>>>>
>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> ---
>>>>> I've also noticed that the work around marked with an XXX comment near
>>>>> line 600 breaks the U-Boot I've tested so I need to disable it:
>>>>> if ((s->sdmasysad % boundary_chk) == 0) {
>>>>> -        page_aligned = true;
>>>>> +//        page_aligned = true;
>>>>> }
>>>>> What should this hack fix and could it be now removed or somehow
>>>>> restricted to cases where it's needed?
>>>>
>>>> Cc'ing Jamin for
>>>> https://lore.kernel.org/qemu-devel/20241213031205.641009-2- 
>>>> jamin_lin@aspeedtech.com/
>>>>
>>>>>
>>>>> hw/sd/sdhci.c | 2 ++
>>>>>   1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>>>> index 58375483e3..88eb0bfcb2 100644
>>>>> --- a/hw/sd/sdhci.c
>>>>> +++ b/hw/sd/sdhci.c
>>>>> @@ -303,6 +303,8 @@ static void sdhci_reset(SDHCIState *s)
>>>>>       s->data_count = 0;
>>>>>       s->stopped_state = sdhc_not_stopped;
>>>>>       s->pending_insert_state = false;
>>>>> +    s->norintstsen = 0x013f;
>>>>> +    s->errintstsen = 0x117f;
>>>>
>>>> I guess the problem is earlier:
>>>>
>>>>    /*
>>>>     * Set all registers to 0. Capabilities/Version registers are not 
>>>> cleared
>>>>     * and assumed to always preserve their value, given to them during
>>>>     * initialization
>>>>     */
>>>>    memset(&s->sdmasysad, 0, (uintptr_t)&s->capareg - (uintptr_t)&s- 
>>>> >sdmasysad);
>>>>
>>>> Not all registers have to be reset.
>>>
>>> Nothing seems to program those registers before reset but the reset 
>>> values are documented (for Freescale eSDHCI) to be the above so just 
>>> not zeroing them does not seem to be enough. Bernhard has similar 
>>> patch in his branch, not sure if he came up with that separately or 
>>> took this one. Do you have some docs on which regs should not be reset?
>>
>> The header precises what is being modeled here:
>>
>> * SD Association Host Standard Specification v2.0 controller emulation
>> *
>> * Datasheet: 
>> PartA2_SD_Host_Controller_Simplified_Specification_Ver2.00.pdf
>>
>> I can not see the reset values you mentioned there.
>>
>> What is wrong with adding a TYPE_FREESCALE_ESDHC, like the
>> TYPE_IMX_USDHC / TYPE_S3C_SDHCI types? Then you can add your
>> reset handler fixing your fields after sdhci_poweron_reset().
> 
> Nothing's wrong with that, I just did not notice those existing 
> variants. Maybe that's the way to go then with this too. Bernhard, do 
> you plan to do that when cleaning up your tree or should I do another 
> version?

I'm not sure this is the best way to do what you need, but it'd be one
with less impacts on other SDHCI-based models IMO.

