Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72A1C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbDs-0004Uc-Fq; Thu, 15 May 2025 12:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFbDo-0004S6-CH
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:14:12 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFbDl-0001Pm-AD
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:14:11 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a206845eadso716773f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747325647; x=1747930447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KT30wNQ0baX7k/dFxyJ9l5RiSPiLbRfLb/DXcESOiXo=;
 b=ctl9rC3ogzYWf7C55OW4pma16hRfIOp8x2LA29rBYyhH6+B8eN4Uuh+jnG/WSbIIEx
 Nhih4bQd6QdlPlYMhyS85UwPBarXjEsYL/f+/EB3r9Ani+Sctp5nCJ6tJwWA9itLTH2t
 VIYNOTRlKAtboWSMFJnl2xaefOXlBDWYMt4UJZa8wvXQHq6pvZg6rqzE+gwPbjU/yX3l
 +rfIuB0b/MXzG7ZXL0wCizLoTVXJrCAH0uuHYrHdDZWDwRa01DFlRzdosxhXPXs41kmx
 023HjRk2HDlUpfAd+5ISn29y8QK9IRDR/A/8tbGg2myeAAdRc8/91HLm3YL6j3aoMpWT
 hjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747325647; x=1747930447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KT30wNQ0baX7k/dFxyJ9l5RiSPiLbRfLb/DXcESOiXo=;
 b=XtVhJYuAh560z9PDd8ZToGLO2ptTerPhYEeMfm7xC/B8Nr8xjF1OAKv2YEw1bbnrkH
 UMg4IDdNShp6jBLKR6jXz6BCfW3h2yfCK7t5a52T9HHQ8GdJJ0k0YCKZjt/YMJYpqCWh
 jYJ4mN2L1tfpmsE89zX1mR2inYGQJsAb80MCeNIetPsXEcfmFS1f5B/3cyrWSFsz8zcL
 3Jr3LrGIjFH3Kyx1Z17vgitmDx/WRaC2wFVKZMTIo4J4l+4IN4kNbxvTy/3etILnqG4n
 bDP6wRTTt0JnXsqx1x5KM9VZTfhEL+Zf0C3Bp02PezfsUUMLS80FpMzMyq6I4Jh/1oIk
 splw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+u9BZv+JOtbKOo4oRr6c3W3DHNFAzG2uPgM5qbG+WPuVG3JnsAzhNc1io84IDZs0TkMzdEg+X+bLN@nongnu.org
X-Gm-Message-State: AOJu0YxV3GqUnZYSl9vhsbz3D4VL0vdVy0VcKO26/x/+VeGfWG0fnc7o
 5WHRKWs4GjBB9/8eizwszvxRNO5J8A8Hrkrieed6JyzzQNjJmrWu1mzagNme1sNtLeU=
X-Gm-Gg: ASbGncsLaQpJZ7fWWVwJPAYlSHRdyuEvA+PciPv7R0x4BRHYB2ax7mj6XEkh7XST1IM
 mDvq4s/nnEliF+/kUBfNMVpaYotRfhY41vdpN5RFSiGUaNMRrSTloYO8GMuPxPj7yJDANjgq4N5
 W/3vir3E6dFTQ8u7bVZO5POtky56t3yQ6y+MnREG0aDPSGw2p0J95Tk4+j8qzJl9HXoM5ydTY5R
 s04AAovRL56owCKKEIHKgj4REQBZY/kbsaV3B9bT/inVz4nWJ3WcnFDg8PXMnF1T3myWExng4N6
 C8hyV/FEb/t6o/o605w8oqVQEF/cnwmbQ0KAW9lugRsdjeS1vXpgZiP3YOXRAjuwx8N1fglwELE
 aFjNj9wdxIVpz
X-Google-Smtp-Source: AGHT+IFVa0G1qw4hIJBbaDGdulxHJotM5qr6HT3XEz3JEYOlTbwfhsMLqGRlSNnIM76hkIGJegte6w==
X-Received: by 2002:a05:6000:2209:b0:3a1:fd06:d1c with SMTP id
 ffacd0b85a97d-3a35c85c76cmr413462f8f.46.1747325647059; 
 Thu, 15 May 2025 09:14:07 -0700 (PDT)
Received: from [10.61.1.248] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2961sm23145455f8f.45.2025.05.15.09.14.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 09:14:06 -0700 (PDT)
Message-ID: <ac352dd1-a46d-4247-b022-6ce5252b472e@linaro.org>
Date: Thu, 15 May 2025 17:14:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/19] target/arm: Add arm_cpu_has_feature() helper
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
References: <20250513173928.77376-1-philmd@linaro.org>
 <20250513173928.77376-17-philmd@linaro.org>
 <b6c81748-091b-4d61-8d34-beaa0442aab3@linaro.org>
 <f7bcd8b2-2c0c-4907-8a0e-af172c235d56@linaro.org>
 <59b1ccbe-9ddb-43f0-98c4-8000a08d27b0@linaro.org>
 <eff0b1a9-5267-4290-a9d4-da95179289b9@linaro.org>
 <b5c07354-fbe8-4910-a019-fa9fd7e813a5@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b5c07354-fbe8-4910-a019-fa9fd7e813a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 15/5/25 17:22, Pierrick Bouvier wrote:
> On 5/15/25 4:05 AM, Philippe Mathieu-Daudé wrote:
>> On 14/5/25 18:59, Pierrick Bouvier wrote:
>>> On 5/14/25 9:53 AM, Philippe Mathieu-Daudé wrote:
>>>> On 14/5/25 10:24, Richard Henderson wrote:
>>>>> On 5/13/25 18:39, Philippe Mathieu-Daudé wrote:
>>>>>> arm_cpu_has_feature() is equivalent of arm_feature(), however
>>>>>> while the latter uses CPUARMState so is target-specific, the
>>>>>> former doesn't and can be called by target-agnostic code in hw/.
>>>>>
>>>>> CPUARMState is no more target-specific than ARMCPU.
>>>>
>>>> ARMCPU is forward-declared as opaque pointer in target/arm/cpu-qom.h,
>>>> so we can expose prototypes using it to non-ARM units.
>>>> CPUARMState is only declared in "cpu.h", itself only accessible by
>>>> ARM-related units.
>>>>
>>>
>>> Maybe we can simply postpone introduction of arm_cpu_has_feature() when
>>> it will be really needed.
>>>
>>> Patches 17 and 18 are not strictly needed, as cpu.h (which resolves to
>>> target/arm/cpu.h implicitely) is perfectly accessible to code in hw/arm
>>> without any problem.
>>
>> OK.
>>
>> Peter, would you be OK to take reviewed patches #1 up to #15 (the
>> previous one) or do you rather I respin them?
>>
> 
> In case you respin, feel free to include the base series, so we can 
> combine both.

Isn't the base already pulled in by Peter? I thought it was:

https://lore.kernel.org/qemu-devel/20250515102546.2149601-1-peter.maydell@linaro.org/

