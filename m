Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E0CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rolU6-00035M-BT; Mon, 25 Mar 2024 10:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rolU2-00031s-CV
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:39:31 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rolTz-0001OE-6E
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:39:29 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d28051376eso83952981fa.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711377564; x=1711982364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cLo0clHLzmfqJyAmA9loIdTW7dvRHYH5J9MCipaP/mI=;
 b=Xi7lwluTMYLogA+QOtufmfxjeZSaoVp8Sc4Tvuu+eukxCg/akuf03AYgBdd2jRSDem
 HCaCDZZZ0CQmYya2akSJFI9wgqpgKa/29vPxbNqIh25IX+qOfbu9LMq9RkbW7dKMAXO7
 MoC7j5+MDYQQ1f5bOxRCQG9wS02npXUJD01ljTsC1rCv8PEA/sIC/KORsG6RVNJTX37K
 aJJHpPWAd8A5RNA+ovrAAlta7ebehZYU4zdjMd2cI5MdLPYPDLcuDMppIJtni156Frfg
 HdR631ZwG6ulPZmmzzMKBcvQhr/yCBtmGJLY022jUGWKe/yRiw3yP2yC8Ozxwx0lUQpi
 +FLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711377564; x=1711982364;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cLo0clHLzmfqJyAmA9loIdTW7dvRHYH5J9MCipaP/mI=;
 b=djHZXHPW+7i3bvlx0mTB/Pbu5fejrRI1EluiDVPL3KoIHnQ+36jQPfwoovPktP2v8n
 ObkcrNHJOaQPGGcp5KVs+N56LHJL2StlkmGNFxVLrUO5aanlM4v2SkJRT0dmF27GQsoD
 IxPKs3vZQAyyqPaHHvbu1oZFH+Qvt8KR29QdpZWnyRUJbW/xfRU1mCRErCdXuSRqamAt
 4uztyeZN1tr7TpnKOz21D0cV8iHX92CiJLScKVRyyjTed85U7Vr9aO0T0kkqnZHLaRb+
 lz6ujkrRiwHlYA8S8Sw88ZTFFRD30Ev6+mCGVPnQmgsS9lj21qHTdfAnlrFOmOAXgqcG
 PDYA==
X-Gm-Message-State: AOJu0Ywk/GEbqlhWOgc6EB2k9bt06HA17AK03ilr4rmE4zskPLwKOgT2
 uap9z3AeU5OhtTIMB4tn5RZJQXZ8FhCpGyx6Ew/38G6jPt1MkTtuBECR4jSSxSY=
X-Google-Smtp-Source: AGHT+IEpkA0acwcaa56R3OQEwGwEjB0IgD8BcKDltsfHBZid4U+2bEDB2joHxHHUzxilODkStKSYcA==
X-Received: by 2002:a05:651c:2ca:b0:2d4:7373:2a5b with SMTP id
 f10-20020a05651c02ca00b002d473732a5bmr5691225ljo.47.1711377564267; 
 Mon, 25 Mar 2024 07:39:24 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 u10-20020a17090663ca00b00a4a33cfe593sm1271473ejk.39.2024.03.25.07.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 07:39:23 -0700 (PDT)
Message-ID: <e3806179-47ed-4952-a7b6-c256a2aad197@linaro.org>
Date: Mon, 25 Mar 2024 15:39:21 +0100
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9aM8J+0RjYnvr8Xr8Q2j3w_TgxHO-gPDn8MaAcAUDynw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

On 25/3/24 14:47, Peter Maydell wrote:
> On Mon, 25 Mar 2024 at 13:33, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Currently clock_set() returns whether the clock has
>> been changed or not. In order to combine this information
>> with other clock calls, pass an optional boolean and do
>> not return anything.  The single caller ignores the return
>> value, have it use NULL.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/clock.h       | 22 ++++++++++++++++------
>>   hw/core/clock.c          |  8 +++++---
>>   hw/misc/bcm2835_cprman.c |  2 +-
>>   hw/misc/zynq_slcr.c      |  4 ++--
>>   4 files changed, 24 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/hw/clock.h b/include/hw/clock.h
>> index bb12117f67..474bbc07fe 100644
>> --- a/include/hw/clock.h
>> +++ b/include/hw/clock.h
>> @@ -180,21 +180,28 @@ static inline bool clock_has_source(const Clock *clk)
>>    * clock_set:
>>    * @clk: the clock to initialize.
>>    * @value: the clock's value, 0 means unclocked
>> + * @changed: set to true if the clock is changed, ignored if set to NULL.
>>    *
>>    * Set the local cached period value of @clk to @value.
>> - *
>> - * @return: true if the clock is changed.
>>    */
>> -bool clock_set(Clock *clk, uint64_t value);
>> +void clock_set(Clock *clk, uint64_t period, bool *changed);
> 
> What's wrong with using the return value? Generally
> returning a value via passing in a pointer is much
> clunkier in C than using the return value, so we only
> do it if we have to (e.g. the return value is already
> being used for something else, or we need to return
> more than one thing at once).

Then I'd rather remove (by inlining) the clock_update*() methods,
to have explicit calls to clock_propagate(), after multiple
clock_set*() calls. clock_update*() are used in 4 files:

$ git grep -l clock_update hw/misc/
hw/misc/bcm2835_cprman.c
hw/misc/npcm7xx_clk.c
hw/misc/npcm7xx_mft.c
hw/misc/stm32l4x5_rcc.c
$ git grep clock_update hw/misc/ | wc -l
       37

Regards,

Phil.

