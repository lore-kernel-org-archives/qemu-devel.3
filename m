Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9695C531D1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBZa-0003m3-S7; Thu, 19 Feb 2026 16:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBZY-0003l9-KV
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:28:32 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBZW-0000le-S9
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:28:32 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8249aca0affso793636b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771536509; x=1772141309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K2uJFligPrVHrfr6KHvU0T03PbZTs5EzdPGyoPKC60s=;
 b=LPQkKBLrG7KG5XDwxNf+E39PkaHdUhNIeqeUD9fPrmq71od7vtFWM6d1PEEd27yLbS
 wUsMiw4PMWBykTJcytSfQvahbtzMG+uc8UDXQej1sWF7TzP0QPo1js/VyKsTq5nNLw7Z
 Djgr737iXHN39HteZkA3aSfVcBYrtM1XuXOkH2XEL3c+B3DtT3ZmlxADbA6G1UBQSDkI
 VMwHqgfWyygDFcX8oJu1TmAOLKg6CyYjvbMxrB/leIZlCT9wbcW0PUfB4FJIzfGWDjc+
 o3NHAju7UWZStX5oRJOXrmk6qlMlv4QsaH+MVTDe4vu8y5ami0y+R9I4egFRgHbVKPSe
 hXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536509; x=1772141309;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K2uJFligPrVHrfr6KHvU0T03PbZTs5EzdPGyoPKC60s=;
 b=BN/8OG3eNKAxkPJ06WZAOc5mk8Sm0jKgBlwXcRLb91Y10Qzkdlr+Q7EE0ej9B9D0GI
 5kJk0S4PyWmD+AG3NmTTDxZUAHCMxSSMrgVDSOuOgtN7/cvluuOm3O05d2AgXdYawEhR
 RNSl9puoaxMAlcaIV0JkrYn+pH6ovmAcTxDJqa/jlEVLtxaSEuqpQpLJxlVj0MEjCQyh
 1B+PYOrLB87qQgCH5MfqAg/VPCiVe2WRshGHLZkkarapRjIgXbQCjGJlBAu75WiHunsN
 X/yhqCOT2VIvuXE32I08jCXeJMBoC+K+q99DTXg9vAxhLlgomnoPLB1OisbS+4A8IfQn
 +faQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjmCFIg8JM5WCAd+K+XPk3WL7Hpeh1veI/heYUm3h6JGNVUMTJ+kj0htZqvXEtaH2n8xxdI8D2pANH@nongnu.org
X-Gm-Message-State: AOJu0Ywe1yzCg9BZhMmjypEuSbFADNuT7k+mj/kOmduefNA+n6rfddRe
 l3ZaAwiKL/VbqRClhXiX3xKEQWvv5GT9IWuLTnr5k94IfRWfKckPmPiudiEKNJ7o3Vk=
X-Gm-Gg: AZuq6aLIeh0zHjLb13rzKLdVwEH0fmDN+/rHf53Hdd9pDfTXSLpG8oOLTV9I2EFfUKH
 SVPhJFW+xsKiN5gIvMPWZLb+6ytOhEmqcwpZ+9BZrqB0c0CvfQC2IQ7VOsEi5Vl++JLRLUsjTPK
 P5l0Gm9yH/mBHaww8kjhvxWdEBFI0ZV/aAr7ZiRLYXHipa7Oofy6AJGOIsZJ2Aonp4IhkzTlS17
 tZbJHtfmCQnAd7mC94/3R7QSoIb/cFIFr9vjYSmyrY9eYxkP/CZ3biJuyn73jMLyjZWuERfBVPA
 5GU0WTi0T0PlC6QBIh+CCCkG0XSo2UjOUyNMDVBqUGFXNUUT0F8znCz6gGAQXim/O3axJ5P58PK
 JZqNtkRjDD76cp8vOUY2TsomxlyR/2ydQHvZsy/ASk43chJn7qMd00NSeHNdiW0LlyydnP3BNXq
 Fsm5emiE45DXt95rU4+S6ePIgiXHh68P71+m3Qi0ng7vKREVX1WxvyIlGlPuWekPRxsvOl
X-Received: by 2002:a05:6a00:1c84:b0:81d:f938:800b with SMTP id
 d2e1a72fcca58-824d9640796mr14947365b3a.61.1771536509008; 
 Thu, 19 Feb 2026 13:28:29 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a42688sm20255296b3a.21.2026.02.19.13.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:28:28 -0800 (PST)
Message-ID: <98776b81-9f5b-4924-827f-1f8fde2f299b@linaro.org>
Date: Thu, 19 Feb 2026 13:28:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/50] target/sparc: Factor
 sparc_cpu_gdb_write_register() out
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-25-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> Factor sparc_cpu_gdb_write_register() out.
> 
> Prefer ldn_p(target_long_bits/8) over target-specific ldtul_p().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/gdbstub.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

