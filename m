Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E245C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaPx-0008LW-Ge; Thu, 15 May 2025 11:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFaPe-0007zC-Oe
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:22:24 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFaPR-0002nV-DP
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:22:14 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-74294fa4bb5so1637305b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 08:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747322525; x=1747927325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Wwaufpr8Z6a4ck6g2EdvI8iMo2hfWASSYRcby6tdEc=;
 b=vS1oM5lWXnHL2bD1+v4TSycF4FvM1anQYbsvCkTkjnimPrJI5kvxPXOFEHv4lmPFpN
 jcl+3N+M6qV/hiLvbXGrrBOqw4a6LqLHf8wXHI2eoP0TdIXMiT3Tw6XRzAGb66eCWvTk
 IraaP5dawZOe4mtWT2oG/voCHoAcbumLjjB2T2M4+wepHpGDxHjST7KLHzRrksKkw0M3
 O868vjY7rE1viofD6YmtDYnQzL5qNw8Pq/27ftlTQlnVnkLk38e1dHmbdZRJX72KNYmy
 slTN9FxvZRrzIE8BpBkQgRHjp+O+Y9aX38vF2MujtN+feJd1eUbwD+4YXhLZmYvGnSk+
 1XrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747322525; x=1747927325;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Wwaufpr8Z6a4ck6g2EdvI8iMo2hfWASSYRcby6tdEc=;
 b=RPWy7h1BbMLkhrvUSv3j7/2c+0Xpd7gDFwrobU5FEVIBxDUF8y4kX5kKuSBKJiDwfk
 NTNCLHY+8vQigra0dgb7SSPBlqJ5VcBOKBmxXUVlDKrQr0fRCKlPlZoNEaiHgcXuTI4w
 tM2WD4Z0AH5Yfa97LIIuF4UEK10xuWaTqye6wHYssfXCgk1HlLzp1+cbxqBHqrWjrSSn
 lQgHsGikjLmSL778G/0MynjbJv69HdJ+PFMnvqZHxQDKBHsUFzlX8xLVQsXrTr0x6vRF
 KMVAjYTmHbNk+sb/2jeVGOW3sLD/nTZUMfwVcRye7rR2DiCuapuhumLDYQ323AjsZCIh
 HOwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX5LNdoxJBCU3vUMSZuj+hRjVVtqcQlCpzTNWDT8EImJsytjEvzme9nQJDJau88DYLwMtcpw4rUS4p@nongnu.org
X-Gm-Message-State: AOJu0YwPJpaxumGmZYoX8LPav/yLUZ8sWBkCeRBPJzet2Xc+/QlL0nKX
 6nXzr9PnwROK7YSDihYhqyFG87aAyUYj0dCEgJwwWa9zhw1/LwcJxzM/Gcu1zSg=
X-Gm-Gg: ASbGncvxgs61yjw8cuxPXXZyH+AhEIiTSGhDEL1jh6aHhBpheMOiwmd9RdRxTPX4x6A
 g4SgaTALMocQ4450mubaJ0IisZeAFUcLyq/xI2BQY6RvGHM4IKXj7dzu1xNC99r9ICIfUs1541T
 KVhXlAHMbYZ3zRXyvdeDBf/uF8l7TZEPWI2l5R/maAGN8IL/6K/6oBu7Bi+hnyPD4P0oJUpzbHX
 qvRUlEq/0P/tbh9POKTveQnjeUw8Hxn3GI88E40qK/CKEDq1xdtVUuqyIdokwKlwMD2ySH+yj6r
 9kX/lLmYYCpU4L8RMw9LRcHT78o1Ltsrc4uBtyLxwi2iWWp6/cKNz8XTTEcHdyA2
X-Google-Smtp-Source: AGHT+IF2bdLwMCewSDom80krFb/JiiplIY2U9HhI2uxSnuJm8k7jzh3n3of2CTMytg54xzEj1qa79w==
X-Received: by 2002:a05:6a21:4cc7:b0:1f5:7c6f:6c96 with SMTP id
 adf61e73a8af0-215ff11a577mr11182366637.22.1747322524885; 
 Thu, 15 May 2025 08:22:04 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb084980sm34145a12.58.2025.05.15.08.22.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 08:22:04 -0700 (PDT)
Message-ID: <b5c07354-fbe8-4910-a019-fa9fd7e813a5@linaro.org>
Date: Thu, 15 May 2025 08:22:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/19] target/arm: Add arm_cpu_has_feature() helper
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
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <eff0b1a9-5267-4290-a9d4-da95179289b9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 5/15/25 4:05 AM, Philippe Mathieu-Daudé wrote:
> On 14/5/25 18:59, Pierrick Bouvier wrote:
>> On 5/14/25 9:53 AM, Philippe Mathieu-Daudé wrote:
>>> On 14/5/25 10:24, Richard Henderson wrote:
>>>> On 5/13/25 18:39, Philippe Mathieu-Daudé wrote:
>>>>> arm_cpu_has_feature() is equivalent of arm_feature(), however
>>>>> while the latter uses CPUARMState so is target-specific, the
>>>>> former doesn't and can be called by target-agnostic code in hw/.
>>>>
>>>> CPUARMState is no more target-specific than ARMCPU.
>>>
>>> ARMCPU is forward-declared as opaque pointer in target/arm/cpu-qom.h,
>>> so we can expose prototypes using it to non-ARM units.
>>> CPUARMState is only declared in "cpu.h", itself only accessible by
>>> ARM-related units.
>>>
>>
>> Maybe we can simply postpone introduction of arm_cpu_has_feature() when
>> it will be really needed.
>>
>> Patches 17 and 18 are not strictly needed, as cpu.h (which resolves to
>> target/arm/cpu.h implicitely) is perfectly accessible to code in hw/arm
>> without any problem.
> 
> OK.
> 
> Peter, would you be OK to take reviewed patches #1 up to #15 (the
> previous one) or do you rather I respin them?
>

In case you respin, feel free to include the base series, so we can 
combine both.

> Regards,
> 
> Phil.


