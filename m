Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06873C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 21:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thbGc-0001gi-9S; Mon, 10 Feb 2025 16:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbGa-0001fQ-6C
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:24:32 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbGX-0001VU-Tc
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:24:31 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4368a293339so54153365e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 13:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739222668; x=1739827468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RX2Ba4AEmWE/ZbSo9lVv2ayt1T6p6DSyJXpJ16zRnN4=;
 b=epB1jlpgZC0OjNy+484kTlELBnLW/ySQRFM6tLnZAbj1ve6tGAbwsM97u0iKNPJ3i+
 /p4fwRb/0pO3brsztRZ7i+e+xEIKQQshOdtySVCeACmVF9D21soXFS9FrbldkCXHL1FW
 7ShmDamuNHJ4nxsG/dW501VFC/b8PSUwJ+BG4OIFr4fowIcTG33wvNtkDx6ORrPGLclS
 DYc4Mou+ivDOu3o7sz7o15DYJiWsA9JvEUtRVxGO8j5gCVh8a2lyHU+SBIuVpkew1pEC
 IS4v9UMv9zAiIqGOJCBSIvu5i3Uqtf0/YpoX/aVCjM5W+1ZNwlbBvOMFgNYmDUQEWNf0
 XV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739222668; x=1739827468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RX2Ba4AEmWE/ZbSo9lVv2ayt1T6p6DSyJXpJ16zRnN4=;
 b=QCx1ub2eqU4c7LgGebVsCRfux05aK1XlTjmOdzesS1OX5QdcdrJbAXTWQuURp690TA
 5gyJjCxCB9y082V2vHnY/clbY1MJD0Kqc+5rgHxqG3fzUFSaPgGOJvSO0HDTgbkTFqIN
 NVNDLegSatWLBdYwHEdKF80+rYbUTkUeJUa/UXlj/uoLLC9/W7D/DXrxaD/g/d9KfrNo
 Y/FpulUwl6E6X8q0FZyadFlH7NqOT0FDp5S3yoGK6E22NrVlQw7GFg5sc0MPUL0x35WQ
 ylWvUgAJ6hyYgogwDlJRpVYEldDqYJEKwmpN3sX2Xqowd4PMWPpOXyohlDbgarjotc9s
 mqHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwO5pQdLlqYY4sF4EQEivmuXqzxQqLPu4zHoeaDJeBEOHr11GvBS/FZ1x1wsOa4FJHVxOHZk/tzf2S@nongnu.org
X-Gm-Message-State: AOJu0YzzzJYQt/OlxZSqahkH85SsudlfEgKo06NuHLtSLH+d3hCmNEng
 vINa6cBRvQNS5vQRgqg07fbR/a2PO3uIBJOiXp+FMx+l6ALThUOUe3KkhNVZ74I=
X-Gm-Gg: ASbGncsx2jEEmvfRMahPlMrYb6FTg34S/ayubqMwqRnJsJFbi4YRWCXKEG0TigiLEZA
 nsKlkBkJ/PYj2Y0p+OGLFmr76+3ACBpC34vEN4PRDknPM051Y0VkJaeQ9BARLHjmU8QWYTUW02g
 IXwIEkTGBcE2/A6ERmi3qa9X/68krWoIFJBVgpO52MS/7zqqXm9YADsID9svUuAe1ZNLMAZtncD
 HE/eNJtI4PCWgIahSnW7aGu5RisrIu1DDUHFr0I/+b5uS5sIcgeIFODxnC7cV74oSYLWZ2SN1Wx
 2zc/Q9jX1sPg5na5U4j1+uRoDfymgjXah/NYRpLHxbez6jZdGkTJE+cnNts=
X-Google-Smtp-Source: AGHT+IEDkI147k0o0gDzWHheNda1d+bPHNMSUv5FXH6WssmFr9ti4uNlmdYrkMquofDTbygNzgCTqA==
X-Received: by 2002:a05:600c:4e89:b0:439:45ce:15c0 with SMTP id
 5b1f17b1804b1-43945ce18d2mr34098865e9.25.1739222668139; 
 Mon, 10 Feb 2025 13:24:28 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcf35b15bsm9659767f8f.64.2025.02.10.13.24.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 13:24:27 -0800 (PST)
Message-ID: <ad266394-bf8c-4030-831c-b7e16aefd803@linaro.org>
Date: Mon, 10 Feb 2025 22:24:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] target/arm: Set disassemble_info::endian value in
 disas_set_info()
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
References: <20250127115426.51355-1-philmd@linaro.org>
 <20250127115426.51355-4-philmd@linaro.org>
 <c364ee71-7f0c-43d2-8ded-a7b8156c0839@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c364ee71-7f0c-43d2-8ded-a7b8156c0839@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 27/1/25 14:57, Thomas Huth wrote:
> On 27/01/2025 12.54, Philippe Mathieu-Daudé wrote:
>> Have the CPUClass::disas_set_info() callback set the
>> disassemble_info::endian field.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/cpu.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index f9fdf708653..9de8c799c77 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1220,6 +1220,8 @@ static void arm_disas_set_info(CPUState *cpu, 
>> disassemble_info *info)
>>   #else
>>           info->endian = BFD_ENDIAN_BIG;
>>   #endif
>> +    } else {
>> +        info->endian = BFD_ENDIAN_LITTLE;
>>       }
> 
> I'd maybe rather go with something like this:
> 
>      info->endian = BFD_ENDIAN_LITTLE;
> #if TARGET_BIG_ENDIAN
>      if (bswap_code(sctlr_b)) {
>          info->endian = BFD_ENDIAN_LITTLE;
>      }

This misses:

        else {
            info->endian = BFD_ENDIAN_BIG;
        }

> #endif
> 
> What do you think?

I'll go with Richard's ternary suggestion for v2 and see :)

