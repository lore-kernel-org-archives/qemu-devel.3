Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48036C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1oT-0005fF-Gz; Thu, 06 Feb 2025 08:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1oN-0005at-Ac
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:20:55 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1oK-0002LZ-5Y
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:20:53 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso6090345e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738848048; x=1739452848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jcIW+pUXooB/M+luOf34nVCQ0S+y6gaCHaWYpDrmV8I=;
 b=ymwe/TTfYyzWfiZ+Q2JZLV+Qy+fmUrc9m0RYJcFPekqRev0gmBWqqCmF3Ywc3F/beD
 qRpcsQCnP6yHZgzXMviijq/0iM9lUs+i5q4Xh/OzWpPwpxFn+AY6bfBaszjnwSlub7cX
 zXziLeXNOa+7MN21Yb9UEoAnOzn+oi9NzaMopgNNp5XRSGi7Et0SNRElgHCV+LVLgeII
 KxKJPp3pdqJyUdZtB+kLi24NLpB7QkOXhsAsrytViapONH16iUKFI068HYho0u0hZvlb
 KPg8vlpWqA4+XFlTGV/aUTiRkuwKT84rq8qCFgVuwOSDo+NL6UX0cxfww79XDBWbyIHX
 zriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738848048; x=1739452848;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jcIW+pUXooB/M+luOf34nVCQ0S+y6gaCHaWYpDrmV8I=;
 b=ukorK7e9+F/E1OrK2yKclxilkrBrF9SSyVpqc/NPz7Ku0RGNT5d7AZSHjMpLw2mqdC
 YflIfBaW4x29mApLzXrZsUJlhXt6c9u5d+mjXom6V865b3O1t6eNfm5t5ZOwAFJnshbj
 b2rmvUy8s4aBrRG9FUMo24tTuZLNqvkmLVOoZMzRP3ki17KN8PR5Ozj3YV7zIcBJobI1
 lz0rqK3QgtBInfBPQmgD3abvUlcLxR3jG9iCPAf1UNbmrhLzln2zvaqzJ08hsziUAeHc
 B3DIhwwWTBpPI6R7oYwntw4KaXIqKrzcQSx+qog9nTo8JlVgYJY8NRvGPdyvHeIsBsT2
 X1rg==
X-Gm-Message-State: AOJu0Yzw5Th5kF7cMHPgitg2I79uJAolPE8J8kQS5fjyoloViW1eJxQ5
 KnhjlNjPDtgjCU4DZIqeGG5QKQmPXGWgxiK2MsTTG2kvbXZwZAevDWYzjx8Oj2bo2fBU0lxohRr
 Qs4Y=
X-Gm-Gg: ASbGncuypsxerdHsMfoLHrdupXcpuSkis+AzfvF+k+c9CTe5vn9u/cCRQmJWZnwNGu8
 TleWrBBvbe17r9A8Inr1iPT20JogNF3TgxO355B639P0371hjIT4ZK0NjwTJ1HmDNsIBOU8vWUa
 hASUV/SJBRUgftbu3W9rIz9DWIOaEdKnnK6DYEvg8QE8OLkaYoGyijxOVGR/BnxiWqYNpYtqxiS
 utgSkc8a06eJ9Cl5cDC97XVYzWrb6aCwzqy6VcgS3wzBBHn5BS/qSLtM/C0XpWi4k3MFqTP1cME
 r/9gGzK+b8gMqZoz6yNuvnAXaHNbewZzXUswhd/E0LVXuFWUPj3TSNmPZpE=
X-Google-Smtp-Source: AGHT+IEVaZSBftPmpqDeV+3Ljd+04RYc4VdXC/jXSU5QFNW3iCbLJDCeD4VBjGk2CsJtm0zkTNvbxA==
X-Received: by 2002:a5d:5f43:0:b0:38d:c600:ad30 with SMTP id
 ffacd0b85a97d-38dc600b0d3mr115744f8f.40.1738848048523; 
 Thu, 06 Feb 2025 05:20:48 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd36d3csm1765049f8f.36.2025.02.06.05.20.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 05:20:48 -0800 (PST)
Message-ID: <800dcc1b-8bf6-48e5-843a-99e630d4b494@linaro.org>
Date: Thu, 6 Feb 2025 14:20:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdhci: Set reset value of interrupt registers
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>
References: <20250115190422.5F0FA4E6030@zero.eik.bme.hu>
 <8cbad5be-e67b-46bd-9198-f7c90ad5ff56@linaro.org>
 <cc92e02b-c20d-974e-8b6d-bb30ea5af452@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cc92e02b-c20d-974e-8b6d-bb30ea5af452@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/2/25 13:49, BALATON Zoltan wrote:
> On Thu, 6 Feb 2025, Philippe Mathieu-Daudé wrote:
>> On 15/1/25 20:04, BALATON Zoltan wrote:
>>> The interrupt enable registers are not reset to 0 but some bits are
>>> enabled on reset. At least some U-Boot versions seem to expect this
>>> and not initialise these registers before expecting interrupts. The
>>> numbers in this patch match what QorIQ P1022 has on reset and fix
>>> U-Boot for this SoC and should not break other drivers that initialise
>>> (and thus overwrite) these reset values.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> I've also noticed that the work around marked with an XXX comment near
>>> line 600 breaks the U-Boot I've tested so I need to disable it:
>>> if ((s->sdmasysad % boundary_chk) == 0) {
>>> -        page_aligned = true;
>>> +//        page_aligned = true;
>>> }
>>> What should this hack fix and could it be now removed or somehow
>>> restricted to cases where it's needed?
>>
>> Cc'ing Jamin for
>> https://lore.kernel.org/qemu-devel/20241213031205.641009-2- 
>> jamin_lin@aspeedtech.com/
>>
>>>
>>> hw/sd/sdhci.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>> index 58375483e3..88eb0bfcb2 100644
>>> --- a/hw/sd/sdhci.c
>>> +++ b/hw/sd/sdhci.c
>>> @@ -303,6 +303,8 @@ static void sdhci_reset(SDHCIState *s)
>>>       s->data_count = 0;
>>>       s->stopped_state = sdhc_not_stopped;
>>>       s->pending_insert_state = false;
>>> +    s->norintstsen = 0x013f;
>>> +    s->errintstsen = 0x117f;
>>
>> I guess the problem is earlier:
>>
>>    /*
>>     * Set all registers to 0. Capabilities/Version registers are not 
>> cleared
>>     * and assumed to always preserve their value, given to them during
>>     * initialization
>>     */
>>    memset(&s->sdmasysad, 0, (uintptr_t)&s->capareg - (uintptr_t)&s- 
>> >sdmasysad);
>>
>> Not all registers have to be reset.
> 
> Nothing seems to program those registers before reset but the reset 
> values are documented (for Freescale eSDHCI) to be the above so just not 
> zeroing them does not seem to be enough. Bernhard has similar patch in 
> his branch, not sure if he came up with that separately or took this 
> one. Do you have some docs on which regs should not be reset?

The header precises what is being modeled here:

  * SD Association Host Standard Specification v2.0 controller emulation
  *
  * Datasheet: 
PartA2_SD_Host_Controller_Simplified_Specification_Ver2.00.pdf

I can not see the reset values you mentioned there.

What is wrong with adding a TYPE_FREESCALE_ESDHC, like the
TYPE_IMX_USDHC / TYPE_S3C_SDHCI types? Then you can add your
reset handler fixing your fields after sdhci_poweron_reset().

