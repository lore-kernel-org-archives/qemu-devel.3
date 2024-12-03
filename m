Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B0EE64AB8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIUPr-0007mh-V8; Tue, 03 Dec 2024 10:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tIUPl-0007k0-59
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:02:13 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tIUPj-0003Yl-A8
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:02:12 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7251ace8bc0so4682189b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 07:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733238130; x=1733842930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gqLzY+IRT6La492ly8emVrBu9C8joyzHbon3Upe0vEo=;
 b=fqwzmzvjeHIwBCOHUbcl4Imukc/bFVH6qEc3QXwHhP9FajKx62yQMu+Yj7yVvYcgST
 DKq9YvAZl/sFYNzO9srnxxmCQSxOt2DAhCt/v0hqD/3/vd2O4bMDG8nEbCQMYFrPo8Jd
 zuSkRZBljigwYI+Ku7k+KHRfn1kTRghGWmVdnMlQ4524ZJIZPIHhFSuwouUpCjeEf1Ya
 DazEx6OMltb/11Fl+bARf4GABXJbHzmL4Olu93SkQKV8mNcfokPCJ5RaVxY98Stw4Pxc
 bYks3mza/LN1tVlEL6O+LyfbnSfTfM3v95FQSeJr2RT6qeSHyjzw5ckje2+BXCCH/i4Z
 2j3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733238130; x=1733842930;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gqLzY+IRT6La492ly8emVrBu9C8joyzHbon3Upe0vEo=;
 b=F5uRap9AJENGT7eF9he7MUQt86PbNDwQ56joe4kO2fk8rTsd5uTT5C9Q/qjTOF4xBi
 FRwj/QGXj9MhenSmwxhy3QYZbSgrDlzXCbsvUuIrGRWds6m7IhZ2/DHM0yWxqS5HBOFx
 slOAo49zMiT/Fy0WN5wTybC1TQ0TMBODywCRudHS38IgEg2KA7VwDo0qurXnT78XOrpT
 +s0PlKsypq+lbOd+DVondQ9lG7HD81XzJcgEDZzjsNGjEKvsEFghApob/8XFGL4qZQAp
 xUq+QD5/x27F+Dp3TkZlC0fB/JFHS18d24OOEbd3LliIbIOfOBwXbkx/eeRMlesiOG9D
 ockw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8OcStm5YSYMJSoHyXJVTu5cbN9RmyOP9fSm05bZAfd8FTbYLevkAONPi7HLiXoeDXEtIDQ7HXmkU4@nongnu.org
X-Gm-Message-State: AOJu0Yzi/t677F6IvYvm1txFDx6PcoszNUFxTUnmtT9kJifO7XxeyZIM
 ifbaEZPVwV3LdfVd9VDcD6/9LlluvFewEyrnjqLg4I2+0/WUt7GGJZnQU7MCfVg=
X-Gm-Gg: ASbGncuUuJ2TCDVUkafYoeEmK78SPwh6BijpQIm2V3x7m0xxSuqfF32s7dTN8U+di98
 R2pf9TtwQtDR2INHJuiEAyQHurjE/79lHIun0JxhsMWeb6cyxV5zuqzP8XHNt6Kf5oDQp8oqB3u
 G6Eyb9HfgShODVhK2+SaRQWzHT28Ro/g6OZCrHGqLJJp8x6g1OXdR6lZps7ejGDbp1t372zsi2n
 FBew8YKE9JRz8AP1BZloiZwW1ml/VzYzNchnZvWCW7btoHl4sME5NoPiGiAoVc=
X-Google-Smtp-Source: AGHT+IFWWU0xifEh7JdWX7yIRoUB0hrkclGAfnre4R7nIjlYOnzio2yHi8j0x90cYJ3CgcOIWA5hmg==
X-Received: by 2002:a17:90b:4fc6:b0:2ee:b8ac:73b7 with SMTP id
 98e67ed59e1d1-2ef0262bc0fmr4182124a91.16.1733238129347; 
 Tue, 03 Dec 2024 07:02:09 -0800 (PST)
Received: from [192.168.0.102] ([179.93.129.106])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2eeb2956718sm4700862a91.44.2024.12.03.07.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 07:02:08 -0800 (PST)
Message-ID: <b9e375ad-2b71-48a4-8e97-2cdced17ea79@linaro.org>
Date: Tue, 3 Dec 2024 12:02:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
 <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
 <CAFEAcA-xa1AKf2GAv7go5wdu+Td=4jf7Nriin-Oe3S6qEV6X0g@mail.gmail.com>
 <fd7ad48e-1e72-4735-8064-7039eedc00ae@linaro.org>
 <87ser6c5be.fsf@draig.linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <87ser6c5be.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x431.google.com
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

Hi Alex,

On 12/2/24 15:23, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 12/2/24 02:57, Peter Maydell wrote:
>>> On Sun, 1 Dec 2024 at 18:09, Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org> wrote:
>>>>
>>>> Hi Marcin,
>>>>
>>>> On 12/1/24 05:34, Marcin Juszkiewicz wrote:
>>>>> W dniu 28.11.2024 o 22:37, Pierrick Bouvier pisze:
>>>>>> This boot an OP-TEE environment, and launch a nested guest VM inside it
>>>>>> using the Realms feature. We do it for virt and sbsa-ref platforms.
>>>>>>
>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>
>>>>>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>>>>>> index 5c048cfac6d..b975a1560df 100644
>>>>>> --- a/tests/functional/meson.build
>>>>>> +++ b/tests/functional/meson.build
>>>>>> @@ -13,6 +13,8 @@ endif
>>>>>>      test_timeouts = {
>>>>>>        'aarch64_aspeed' : 600,
>>>>>>        'aarch64_raspi4' : 480,
>>>>>
>>>>>> +  'aarch64_rme_virt' : 720,
>>>>>
>>>>> Took 2974.95s on M1 Pro macbook.
>>>>>
>>>>>> +  'aarch64_rme_sbsaref' : 720,
>>>>>
>>>>> This one needed 2288.29s.
>>>>>
>>>>>>        'aarch64_sbsaref_alpine' : 720,
>>>>>
>>>>> Have to check cause timed out.
>>>>>
>>>>>>        'aarch64_sbsaref_freebsd' : 720,
>>>>>
>>>>> 331.65s
>>>>>
>>>>> So RME tests probably need longer timeouts or would not run at all.
>>>>>
>>>>
>>>> By any chance, are you running those tests in debug mode?
>>>> It seems to me that CI is running functional tests with optimized
>>>> builds, so I'm not sure we want to support debug "times" here.
>>> We do need to support debug times, because a common developer
>>> use case is "doing a debug build, run 'make check-functional'
>>> to check whether anything is broken. The debug times also
>>> are useful because the CI runners can have highly variable
>>> performance -- if a test is slow enough to hit the timeout
>>> for a debug build locally, it's probably going to also hit
>>> the timeout at least sometimes in CI.
>>>
>>
>> I understand the scenario, but given how slow debug builds are, it
>> would probably be faster to advise developer to recompile in release
>> mode.
>> The overall time of compile + test is slower than waiting for debug.
>>
>> Beyond using a debugger, what is the advantage to compile with -O0?
> 
> --enable-debug
> 
>    - enables -00 with -g3 for symbols
>    - and enables additional checks to validate TCG

hm, do we ever used -g3 for --enable-debug?

https://gitlab.com/qemu-project/qemu/-/blob/master/configure?ref_type=heads#L749

I'd love to use -g3 instead of only -g for having the macro symbols.

In my builds I use --extra-cflags="-g3" to have it but would like to drop it.

unless I'm missing some other change in the flags down the lane...


Cheers,
Gustavo

> You can use --enable-debug-info for just debug info without the overhead.
> 
>>
>>> thanks
>>> -- PMM
> 


