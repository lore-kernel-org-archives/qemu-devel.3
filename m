Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA45DCD1280
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rolz9-00074K-Ib; Mon, 25 Mar 2024 11:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rolz6-00073t-FV
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:11:38 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rolz2-0006XF-Os
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:11:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41489d4ffccso5258915e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711379489; x=1711984289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3FX7sZnjQhQ4h6Jv1VvSmw2+PHG1NyglOoVslUBNQvo=;
 b=j7SSzOXxrH0vtQJT5/U9N2l5vFJunzfjU/wl9lJEJaeJyCdI1EJW8hQiMhsA16sWK+
 lxWaCY25190vBxu/6pGvoDCfth++zOtUnVNM76W9/iXyd3ybqF72eNSn/Nd9Is6pB8Cm
 dyEXa3BSoNi+mfeLsVa5Pl82ygtkrQi4ZoppVB2Txdtc/TTcZy0Wzx6l/YbZtn6h5xAa
 5iGgS/sSQ5dDOCSJLXPSMpiL9fTKPnpz9W86gDqrYxErgtb3n4iCOJd1ycTJGsZxo/DW
 3n6MtzzQxYNOBhbmZvPYt3jfkkha0jV8ZRm/JTnFauYyreFx9JOkdewev8KSSzg2+qsX
 RSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711379489; x=1711984289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3FX7sZnjQhQ4h6Jv1VvSmw2+PHG1NyglOoVslUBNQvo=;
 b=TmWcgmWomQjdCSwW56M/aH7EGwSW7pbPtqjczwpBHKYMXrlEnjSK94WEJdaVOQBVoI
 Caj6dW+KUjt6QKqnGzLCPUSK6GItTMMfpRNLFbSyfSMtNHC6OPCCHa4Km0Q7Mtl2dQ3/
 vNe6gE/68jtW3xR0qtQJiHiqD//RaHjXYhP5pAqGAwanD9v6g7qCb+VJItVJ4irBYlwP
 SY0OIjSAeR2CSBXfVdeU8opoGtmeAcV9OYCr4XMu3EATQTPT8dAV2VH/yF6JVt5G0II/
 fOvmFVrQJ0avXUn8c2lU6HW9oZiFbOfwOgwWp14CvKjEqRG8aLMumBGs+IPjCnqe7Bhu
 0rUg==
X-Gm-Message-State: AOJu0YxgZwbAXHdjXSeWJmnu2i+7J1xKULHIftHWdUhinNFZtd1feXOU
 JoEZvUXmeJrgnF3VbWDD+WlJ7k9GW0+5Rf6PMtdSTDGk+r7CRNTiAXt7ioD168s=
X-Google-Smtp-Source: AGHT+IENNwv4hxgXsZw5fFvB7cg9YUDs3dp1Jv5skDpRtn0Gvhes0w7AHyLzXOjZPPt2NniPmEhcZA==
X-Received: by 2002:a05:600c:45d5:b0:414:869b:dbd9 with SMTP id
 s21-20020a05600c45d500b00414869bdbd9mr3394880wmo.9.1711379489337; 
 Mon, 25 Mar 2024 08:11:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 h19-20020a05600c315300b004147c8dd13fsm8682334wmo.30.2024.03.25.08.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 08:11:28 -0700 (PDT)
Message-ID: <1d42c033-333d-4fdf-b4b7-7dc19b831982@linaro.org>
Date: Mon, 25 Mar 2024 16:11:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? v2 2/8] hw/clock: Pass optional &bool argument to
 clock_set()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?In=C3=A8s_Varhol?=
 <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, Luc Michel <luc@lmichel.fr>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20240325133259.57235-1-philmd@linaro.org>
 <20240325133259.57235-3-philmd@linaro.org>
 <CAFEAcA9aM8J+0RjYnvr8Xr8Q2j3w_TgxHO-gPDn8MaAcAUDynw@mail.gmail.com>
 <e3806179-47ed-4952-a7b6-c256a2aad197@linaro.org>
 <CAFEAcA_yyWKo7E1Vz2zQXnjetYWEXtt6mUyg+t4mJXt+nsKBgA@mail.gmail.com>
 <c951c51c-3811-4997-b27d-deb8515b1539@linaro.org>
 <CAFEAcA8fMVVBxhH8NoPMcNarRYMZSFN1x5GWLg=KSxg1p_FK3Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8fMVVBxhH8NoPMcNarRYMZSFN1x5GWLg=KSxg1p_FK3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 25/3/24 16:03, Peter Maydell wrote:
> On Mon, 25 Mar 2024 at 15:01, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 25/3/24 15:44, Peter Maydell wrote:
>>> On Mon, 25 Mar 2024 at 14:39, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>>
>>>> On 25/3/24 14:47, Peter Maydell wrote:
>>>>> On Mon, 25 Mar 2024 at 13:33, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>>>>
>>>>>> Currently clock_set() returns whether the clock has
>>>>>> been changed or not. In order to combine this information
>>>>>> with other clock calls, pass an optional boolean and do
>>>>>> not return anything.  The single caller ignores the return
>>>>>> value, have it use NULL.
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>>     include/hw/clock.h       | 22 ++++++++++++++++------
>>>>>>     hw/core/clock.c          |  8 +++++---
>>>>>>     hw/misc/bcm2835_cprman.c |  2 +-
>>>>>>     hw/misc/zynq_slcr.c      |  4 ++--
>>>>>>     4 files changed, 24 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/include/hw/clock.h b/include/hw/clock.h
>>>>>> index bb12117f67..474bbc07fe 100644
>>>>>> --- a/include/hw/clock.h
>>>>>> +++ b/include/hw/clock.h
>>>>>> @@ -180,21 +180,28 @@ static inline bool clock_has_source(const Clock *clk)
>>>>>>      * clock_set:
>>>>>>      * @clk: the clock to initialize.
>>>>>>      * @value: the clock's value, 0 means unclocked
>>>>>> + * @changed: set to true if the clock is changed, ignored if set to NULL.
>>>>>>      *
>>>>>>      * Set the local cached period value of @clk to @value.
>>>>>> - *
>>>>>> - * @return: true if the clock is changed.
>>>>>>      */
>>>>>> -bool clock_set(Clock *clk, uint64_t value);
>>>>>> +void clock_set(Clock *clk, uint64_t period, bool *changed);
>>>>>
>>>>> What's wrong with using the return value? Generally
>>>>> returning a value via passing in a pointer is much
>>>>> clunkier in C than using the return value, so we only
>>>>> do it if we have to (e.g. the return value is already
>>>>> being used for something else, or we need to return
>>>>> more than one thing at once).
>>>>
>>>> Then I'd rather remove (by inlining) the clock_update*() methods,
>>>> to have explicit calls to clock_propagate(), after multiple
>>>> clock_set*() calls.
>>>
>>> You mean, so that we handle "set the clock period" and
>>> "set the mul/div" the same way, by just setting them and making
>>> it always the caller's responsibility to call clock_propagate() ?
>>
>> Yes, for consistency, to have the clock_set* family behaving
>> the same way.
>>
>>> Would you keep the bool return for clock_set and clock_set_mul_div
>>> to tell the caller whether a clock_propagate() call is needed ?
>>
>> Yes (sorry for not being clearer). The API change would be
>> less invasive, possibly acceptable during the freeze.
> 
> Sounds reasonable as an API to me. The other place we currently
> do an implicit clock_propagate() is from clock_set_source().
> Should we make that require explicit propagate too?

For API consistency, I'd rather do the same. Luc, any objection?

> For freeze: is there a way to fix this bug without changing all the
> clock APIs first?

Sure, I'll respin that for Arnaud.

> 
> thanks
> -- PMM


