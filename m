Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9FFC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2No-00046I-PZ; Mon, 17 Feb 2025 09:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk2Nl-00045T-QS
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:46:01 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk2Ni-0004uC-Un
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:46:00 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4398e839cd4so1886345e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 06:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739803556; x=1740408356; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y5dcl97+R9ZvlvmhWi8vj8stXbph2OUxTVkLSpaI3GU=;
 b=nByUPg1Eves69ISs2U4zw7McXlUiEM+ibSCyR3Ku/IpBV6aoUDQ57p1rm9UlR3XfI7
 UXe3CzOYflZX5eKLNM8PnyQ7taNsfpOJJfBvNusu0/NiZOvrjI61djAxpJMVS2v6e39f
 PII0V6UpS+7Cekg6Zf9vcj3ocDiO5QirEwN01uQ7Iw0uu4qlxI7fcyD+66xJ4YHAM6Dn
 BQHg2Fbo4kL4LQjJrYc6fLA00YqWztDLIyBvGAykaUPGLknU0l6gZ2xj8Cc13rEvgVae
 EMkJz6hoyv5X6rtcqjnWRnq89256w45P0QdNiv8HT1TrRgcgpYz/4C134HQEbXUAlf+v
 9+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739803556; x=1740408356;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y5dcl97+R9ZvlvmhWi8vj8stXbph2OUxTVkLSpaI3GU=;
 b=THxj2gia9lLyYUlwRFLi0141ABNuOwz4uPb+YMEodvShaVnphNmLrWARbBsB6EpgD3
 BWMtHGixNMKYMAAWU4EhgcAuJuizXSZfe3izZhRMOTwWQ8RIw/PC/rKaCo/gbzpGjq/6
 PiqXXUgnQUY4ondNcq9PK+ROFIf6ryeU5/fuUz3BnOp+La5a0thzWV1eeAyt7MfDryXF
 yhCdIhY+BhCooEwVvZbXbJUbZrH/C4StK2CtHhMlrccexOWDTyL+wMREztX7M1/mAWCu
 W+VXv1K77hXGbWZuLP1Z/2AfKnXJStksjh/A5jQjsbAOyJU4QnQMV3aUiWGvAyWpCwTd
 7qfw==
X-Gm-Message-State: AOJu0YyZnTWgbgb2NcQyYMEIEAm/RZ+jT5mCEG+sb/C//rDffqDTdRcT
 bR9nTNC8XD6EZrfkAEt5RT8z6L+gkOjoK6yhzcfx0LIqoU1OIc7l66R49Wkldkk=
X-Gm-Gg: ASbGncsv1M7PQWYZBRs4LexhHW6sVsiSqij/ADThIQQbanprHokwx5JK/LyUlGmTsJF
 H0A/HPW2506ig9FL3rNvIkBsNgnph7/4/gaL81vDfZwKm+XThI+eGXPgnGCmOV60OHX/61PKuK9
 hkOJXlROXVCZzqlBG/GnDCu+HY4yuGwRYR8WeIArPj7N0dz67XrkWWGeqtOi0MM5dLozVzOzwt0
 xpKM5U5y/PYPpWo1Z4NJVZ9f+DO96Jn0GBQTIdrGxgoc4aqSDcOddysFQfMzqnW7goA6tPWA253
 /RVAXSdnPXuNl3LDeom10cPl+ZcPvdBsrYE=
X-Google-Smtp-Source: AGHT+IGiZCOT4kWCD8sJLEoL3o4iHw3Z3wI/vp8OkstOwVhDGGBN+DxGJkpaozJ5yg5lWCMHEBJ1hw==
X-Received: by 2002:a05:600c:5124:b0:434:f9ad:7222 with SMTP id
 5b1f17b1804b1-4396ec31d4amr87754755e9.7.1739803556598; 
 Mon, 17 Feb 2025 06:45:56 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7bcsm154096515e9.28.2025.02.17.06.45.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 06:45:56 -0800 (PST)
Message-ID: <b8377b2b-8924-40ef-904f-dce0b01e5bb6@linaro.org>
Date: Mon, 17 Feb 2025 15:45:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] hw/char/pl011: Trace FIFO enablement
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250208163911.54522-1-philmd@linaro.org>
 <20250208163911.54522-5-philmd@linaro.org>
 <CAFEAcA-tQUL2Rt4Y_eNFxCFXzNXupzQz3qYdEupB6Bb3HFyhfw@mail.gmail.com>
 <CAFEAcA_66f2t2UQv5eKwspDTBs+kfvpGsMPG6f31aqs6FWMx=w@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_66f2t2UQv5eKwspDTBs+kfvpGsMPG6f31aqs6FWMx=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 17/2/25 15:39, Peter Maydell wrote:
> On Mon, 17 Feb 2025 at 14:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Sat, 8 Feb 2025 at 16:39, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/char/pl011.c      | 4 +++-
>>>   hw/char/trace-events | 2 ++
>>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
>>> index b9c9e5b5983..447f185e2d5 100644
>>> --- a/hw/char/pl011.c
>>> +++ b/hw/char/pl011.c
>>> @@ -148,6 +148,7 @@ static bool pl011_loopback_enabled(PL011State *s)
>>>
>>>   static bool pl011_is_fifo_enabled(PL011State *s)
>>>   {
>>> +    trace_pl011_fifo_is_enabled((s->lcr & LCR_FEN) != 0);
>>>       return (s->lcr & LCR_FEN) != 0;
>>
>> Might be neater having a local variable rather than
>> repeating the expression twice.
> 
> I'll squash in this tweak:
> 
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -148,8 +148,10 @@ static bool pl011_loopback_enabled(PL011State *s)
> 
>   static bool pl011_is_fifo_enabled(PL011State *s)
>   {
> -    trace_pl011_fifo_is_enabled((s->lcr & LCR_FEN) != 0);
> -    return (s->lcr & LCR_FEN) != 0;
> +    bool enabled = (s->lcr & LCR_FEN) != 0;
> +
> +    trace_pl011_fifo_is_enabled(enabled);
> +    return enabled;
>   }

Thank you :)

