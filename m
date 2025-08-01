Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEECCC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 01:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhemv-0005S7-5R; Thu, 31 Jul 2025 21:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uheka-0001QX-EI
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 21:40:05 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhekS-0000s9-VQ
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 21:39:59 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-31f3b54da19so1138397a91.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 18:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754012391; x=1754617191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d5s94bG7WyiNqIEKHah44b8TSZ60Zcg4W/p9g00ipTU=;
 b=i2wZCHySeHch2A623hXAsT7KcV1RBibBqSX5s2erMlUk3wNvGS5wNCxGpWyUs5aCTL
 qPWKCq+t/m/9/EfBhYMvsy2rSg0QlR1hOnjZdcmsnG8l1p8JN23TCmJ+P6GG0bXeU9/P
 ugcbFr0SWKto767x+Mq4CiQmH8T1FBW+LQex+sMnbietVkbjug79lUZ0OcJDWxDuBl/2
 K/+Es1jq6jDry7svLUuHM8yfEbOdxtYnwbeU3y4TjUtypvPHRkk0wV2vtp0IdONM3pFc
 FhbKPXDeR3oHkEF79BfMCcUK348cu5EZ6kneoZCRh8Sqa23COwsva4AXiM+A+oBrGfyQ
 Swdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754012391; x=1754617191;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d5s94bG7WyiNqIEKHah44b8TSZ60Zcg4W/p9g00ipTU=;
 b=iqqOyyE25i9Cu4Pit8cHcUwmgr5dhM4eWFUiVuRF1+nB5/hxLMUMme4i4kfXiCLBQK
 DB0wf+lypqd9lMBOerbnqX9Sv+Bm/fSNOUmvrdb18CAvhTXOSFIyOhQpNQrJ7DoQ7SYK
 sVJXf4DAVj563EkNTZk4EwFnLzNLbT9fJbUnueCMfecRwn1WYsX58S4N3hx0kb5SMk8e
 WK6vonmwbq1eeYSUS7I8lclQlbe1ixyNZRqfoO60vNyzQANjJ/U1YtQdJ1hHifivlh8x
 wZW50aYMHQhUjUPUjMzCEt/tcIrXwMkp7AvLk1ScSSYbYI4XOsg/aUsW5E6fuQtJSScs
 1nVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYRb0+RKH/GERZujVQrfdcQ6xiKl3wNIm5cfNZ/nia/OlGCvTsrk/fVb+qQVFnWveZiLV6UnuPqBG+@nongnu.org
X-Gm-Message-State: AOJu0YzlfXUh/9YGLvzWh6WoBrNTM85E32/4dfAjifKriBBXd6pC5GIQ
 FRYllBK/YeRzY002gshfg/Li3MieqRKOqLe1qAIHETq2yMStU2JCT1v4PjjV5zScX/8=
X-Gm-Gg: ASbGncuVTUOrJdWQzviaN8XZpdvzsGylBXbMS/tlHp6sPzpBQn1Uc8/CjnRwjNV+2Kf
 RTGwIYM7CduN5HCBjEkcudPPzFrWN8VR+PLAlobKtwOKpvwnOxJdjzkbISKeZdg4kVU1N+pCLEu
 34JoxPydnZmxJO1F3y20VGkgAuii4hXrorT+HYUsFzUdITld4m0TScyy91VgvMxiDwayjgQIFDT
 NDLbB/q0Y/qY35W5+hkuOhyfO3vsbTldnQ+aWSjG3kYINgfFXDuQ6AB+qNi1KddpkmdSmeYz0Hc
 IGXC0JjDMTKDC5mHHFWsJI7apTHKskIZO8YFXqQGjUDkEBQ3ZJcwwpGgBLUApQRyPxUlJUQf2uU
 +sqZ/qedALnNKxckILdwKDYDcX7jehBZCFkg=
X-Google-Smtp-Source: AGHT+IESnb49fqYI/m5f/oDCSY8nLrWl78F5neFQ6hQ4qpikry5Gt6sxgXvDcRvbSpMBhdoB7+xATA==
X-Received: by 2002:a17:90b:4cc1:b0:311:c93b:3ca2 with SMTP id
 98e67ed59e1d1-31f5dd88646mr12036854a91.6.1754012391088; 
 Thu, 31 Jul 2025 18:39:51 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63da602asm5904934a91.2.2025.07.31.18.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 18:39:50 -0700 (PDT)
Message-ID: <ba7bbf85-139a-4268-b358-6bfa1a034328@linaro.org>
Date: Thu, 31 Jul 2025 18:39:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] semihosting/arm-compat-semi: replace target_long
 with int64_t
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
 <20250730220621.1142496-9-pierrick.bouvier@linaro.org>
 <8658920e-34ff-4aba-b412-92d06b29fe5b@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8658920e-34ff-4aba-b412-92d06b29fe5b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

On 7/31/25 6:25 PM, Richard Henderson wrote:
> On 7/31/25 08:06, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    semihosting/arm-compat-semi.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
>> index e3b520631b3..715a22528ab 100644
>> --- a/semihosting/arm-compat-semi.c
>> +++ b/semihosting/arm-compat-semi.c
>> @@ -502,7 +502,7 @@ void do_common_semihosting(CPUState *cs)
>>    
>>        case TARGET_SYS_ISERROR:
>>            GET_ARG(0);
>> -        common_semi_set_ret(cs, (target_long)arg0 < 0);
>> +        common_semi_set_ret(cs, (int64_t)arg0 < 0);
>>            break;
>>    
>>        case TARGET_SYS_ISTTY:
> 
> Here we have a semantic change.  For 32-bit, we used get_user_u32, so this will always
> return false.
> 

Right... I'll add the intermediate missing cast based on 
is_64bit_semihosting(env).

Thanks,
Pierrick

> 
> r~


