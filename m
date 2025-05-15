Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFB2C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbKW-00034Q-M5; Thu, 15 May 2025 12:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFbKR-0002xE-SW
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:21:05 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFbKO-0002a4-5V
 for qemu-devel@nongnu.org; Thu, 15 May 2025 12:21:03 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-74251cb4a05so1681070b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747326058; x=1747930858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BfC0feAdksDI2FeDE71xlN2LP+Nd0nOu6tGyCoe9NVU=;
 b=BT3J/oujLcAOMdDSiGiCURARBkKwQAVJKHNbhxaor6r7M5BTxG8UC5CkGhKKvTJWmL
 I5MuHSXDpQTWqhiX4P4F7bX0eAXwSZwd1p+DTJ/CxPCbW6e/FJXsaSLK6v0VmtsjpA/W
 nCoZsYc7QFR5kmmcjFxbomaaUENi9BufTP7IH+u8e9a5/PpmluCRlQTcoO3A2hM6ZwC/
 uPcVFx4J9C9Mjz3mns2FIEQmw26RC62tFYv4XH7LQw56grwwbD9yVDG0V2siNsjcL8Ke
 rMtbuhPR43xmHb1ceETRlICVMCPiWW4qEHYNZTj2jK7MbAGgKdbwC3KxEhjiOGMTMr2a
 v0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747326058; x=1747930858;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BfC0feAdksDI2FeDE71xlN2LP+Nd0nOu6tGyCoe9NVU=;
 b=ArRer5MNcAsymkcIEVh22NYdGyBHDwLZN8If5qb6FV0sW/bA/5bbtkaIpkBWwAwmUU
 SO68cTGhZIAAwL/YuyRF6qpIJ2Fj6+GP8+kp50TybXyWknO9EOHBrCQhVANuk9iW2Cxs
 Mao4i5OWvsUZRycdC2ZEjs9N64Qi2JOSoJyOh7fYJ/cjhAydXBwCgWNIfnSGvwRN7WHi
 f1ejnx8PAQh0oVLcwx1Nfrbx4xiWUa5Oky0FO7Ft091bdV9yC82pjhvZ6bmvNaLlBr17
 8yJkUAA1UbCKD/zmEYH5gSIXeEsdRQ3JrAys3nNGTHpmSQcTx+bKsFOilGtQWRx1t2bE
 GHqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM07C4TzmqXW8kxQODjLZ8uadDUEtINKdc9N9imb9GjlTSkpVDAc4IAWPdo01Gn8pbum1HwbiclziG@nongnu.org
X-Gm-Message-State: AOJu0YwSV26VIL96gnlbMQQ8nWYUfq1dJUxtDc1EUYW5trr/waqeCYrI
 3lIEdrZ/u5ODYwz/BMXpT5JLIU04jT7gp9VbSuBBJFxzyHWTh10LFl8oHtYfPJw=
X-Gm-Gg: ASbGncsTs1b5nI3ubkJcRko+6vMsZKja9z1u0dS5453MOo/5xyoscwk6EuFzUc7nwvW
 ppOnz6qJmh99N7IMQLqNGtFJYLqiatm51CA64kYy5BGOw1iQzoCqGhDLW11/ITD4udHCmRbEMnp
 iTL+dPdKcoH5OMgEHxGH7Y6XZ/S9K30796jPSo4sM/NG90rL4OubjfxZNA1+phV5Rn111lOw+vz
 fTZD4YqwRuddN6i6jgUge+E7lqitNSnxD1wpKRWxOH5idg69AEUzI9Pj1+87mTwPBFLu00mGkjY
 RPVEKAHfNymJj83AlVsrApWWmjXnv2q5aRFI0UIhEVKF6fknDYsT9u0ZgApN4r2J
X-Google-Smtp-Source: AGHT+IEnrxcUFyQN/3hAIBI2IWNcd7IDbMG90q/qve/RMgXslnGcxdskIU0eSkfC3UWE+15tLusGKA==
X-Received: by 2002:a05:6a00:32c9:b0:736:5822:74b4 with SMTP id
 d2e1a72fcca58-74289369005mr11086576b3a.21.1747326057939; 
 Thu, 15 May 2025 09:20:57 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96dfa2fsm11647b3a.2.2025.05.15.09.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 09:20:57 -0700 (PDT)
Message-ID: <d12e619d-1013-4a9f-be5d-7177ec09c8d2@linaro.org>
Date: Thu, 15 May 2025 09:20:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/19] target/arm: Add arm_cpu_has_feature() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
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
 <ac352dd1-a46d-4247-b022-6ce5252b472e@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ac352dd1-a46d-4247-b022-6ce5252b472e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 5/15/25 9:14 AM, Philippe Mathieu-Daudé wrote:
> On 15/5/25 17:22, Pierrick Bouvier wrote:
>> On 5/15/25 4:05 AM, Philippe Mathieu-Daudé wrote:
>>> On 14/5/25 18:59, Pierrick Bouvier wrote:
>>>> On 5/14/25 9:53 AM, Philippe Mathieu-Daudé wrote:
>>>>> On 14/5/25 10:24, Richard Henderson wrote:
>>>>>> On 5/13/25 18:39, Philippe Mathieu-Daudé wrote:
>>>>>>> arm_cpu_has_feature() is equivalent of arm_feature(), however
>>>>>>> while the latter uses CPUARMState so is target-specific, the
>>>>>>> former doesn't and can be called by target-agnostic code in hw/.
>>>>>>
>>>>>> CPUARMState is no more target-specific than ARMCPU.
>>>>>
>>>>> ARMCPU is forward-declared as opaque pointer in target/arm/cpu-qom.h,
>>>>> so we can expose prototypes using it to non-ARM units.
>>>>> CPUARMState is only declared in "cpu.h", itself only accessible by
>>>>> ARM-related units.
>>>>>
>>>>
>>>> Maybe we can simply postpone introduction of arm_cpu_has_feature() when
>>>> it will be really needed.
>>>>
>>>> Patches 17 and 18 are not strictly needed, as cpu.h (which resolves to
>>>> target/arm/cpu.h implicitely) is perfectly accessible to code in hw/arm
>>>> without any problem.
>>>
>>> OK.
>>>
>>> Peter, would you be OK to take reviewed patches #1 up to #15 (the
>>> previous one) or do you rather I respin them?
>>>
>>
>> In case you respin, feel free to include the base series, so we can
>> combine both.
> 
> Isn't the base already pulled in by Peter? I thought it was:
>

Oh, I missed it, thanks.

> https://lore.kernel.org/qemu-devel/20250515102546.2149601-1-peter.maydell@linaro.org/


