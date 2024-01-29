Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBE2C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 09:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUOHJ-0000qC-Qv; Mon, 29 Jan 2024 04:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUOHI-0000pq-1r
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:50:08 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUOHC-0003Vt-4Y
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:50:05 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e800461baso39991645e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 01:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706521800; x=1707126600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z+5yP86Sq+xAFVQASSNaRr0GjEc6nbXjs44JCyiME7Q=;
 b=kZE9NRzNv0fiDnC6obrq1/XPuWIWhrQCGusXpIQA/Spcqb/X9Zwl3Ohayngb5viRwN
 rKoXGivWYDudJyfVOqLEaBj1ADfNwMZucBi82mVwP6H/T0uTMTpKj+Qem3R4SdiZ6IWa
 22+EEmtr+P9ujsv+CxQGlEUJXcaMHaC/xVrnSlLCldKYqKgA55pGNYkVzW7FqvU3IC5T
 fhmo0zfDNNrvx74mYOpDzdmt62FFM+W9gxRn75J5uIZtPZ93jNz9E0yKKjdke4gwQ5QK
 QFu2ovgasik+bQ5ilc/MNd9+xJGmtRLuayEaF5w7EnlbPUvzAOwvuhIr3A/yKaLWjhBH
 EpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706521800; x=1707126600;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z+5yP86Sq+xAFVQASSNaRr0GjEc6nbXjs44JCyiME7Q=;
 b=lDpJolEmc8E4xjn35lluKVq1qCbj5VmcP1Dr+B/NZFQGx2cbTf4e+EiHySkd0afGpu
 odWE2ButHzWEiJ2hVL5OlgAhuh8opKqJncMvLLCvhG92OON9/0AgsXcZCCPz1r80AUah
 bkukUslt/TokucabQyXbDHS3ORV78keMyJ69VGZzndpqyTa+vd2MA1WJVoCJ2Hik1Ih5
 ZI/NDMgy7ctQ4GujR3wJdkzYitoHS9QZrF5X/pPczgi1+7ZgWXK+O3R6HGPxng6ZMaVr
 UyLuRQXn/DQxHXxH4xOEydGsQKAc+Y1+dmIKkj7u4IAlSArNtLXikvWNNBZNCas7WCWE
 oWZg==
X-Gm-Message-State: AOJu0YzcR2N2yVQut3ss2HLL289qFrUtlRzHAIXXEmKEukxHm9UOPtln
 +GH5mm1fDg1af7GwBV92p+jOoqTzP8nnjY5D0Ibr7hWOWiuXT1zohMPj7M7g/cs=
X-Google-Smtp-Source: AGHT+IE4UDDl4VE1clnzq2VlD/q7Qi3f6J4jZUJkfUGcRa//KVujJv0x2SGglVQui+rJhyJagdmNrA==
X-Received: by 2002:a05:600c:3ca4:b0:40e:491d:ac80 with SMTP id
 bg36-20020a05600c3ca400b0040e491dac80mr4222182wmb.15.1706521800407; 
 Mon, 29 Jan 2024 01:50:00 -0800 (PST)
Received: from [192.168.69.100] ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a05600c354500b0040efb8f7158sm401321wmq.15.2024.01.29.01.49.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 01:49:59 -0800 (PST)
Message-ID: <5f7abfb0-cb01-49b2-a659-d559e35b81fe@linaro.org>
Date: Mon, 29 Jan 2024 10:49:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/60] semihosting: Return failure from softmmu-uaccess.h
 functions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20220628045403.508716-1-richard.henderson@linaro.org>
 <20220628045403.508716-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20220628045403.508716-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28/6/22 06:53, Richard Henderson wrote:
> We were reporting unconditional success for these functions;
> pass on any failure from cpu_memory_rw_debug.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/semihosting/softmmu-uaccess.h | 91 ++++++++++++---------------
>   1 file changed, 39 insertions(+), 52 deletions(-)
> 
> diff --git a/include/semihosting/softmmu-uaccess.h b/include/semihosting/softmmu-uaccess.h
> index e69e3c8548..5246a91570 100644
> --- a/include/semihosting/softmmu-uaccess.h
> +++ b/include/semihosting/softmmu-uaccess.h
> @@ -12,82 +12,69 @@
>   
>   #include "cpu.h"
>   
> -static inline uint64_t softmmu_tget64(CPUArchState *env, target_ulong addr)
> -{
> -    uint64_t val;
> +#define get_user_u64(val, addr)                                         \

These macros match their user emulation equivalent, at the price
of loosing the 'env' argument, still used. This confuses meta
transformation tools such Coccinelle spatch. Not a big deal, just FTR.

> +    ({ uint64_t val_ = 0;                                               \
> +       int ret_ = cpu_memory_rw_debug(env_cpu(env), (addr),             \

                                               ^^^

> +                                      &val_, sizeof(val_), 0);          \
> +       (val) = tswap64(val_); ret_; })
>   
> -    cpu_memory_rw_debug(env_cpu(env), addr, (uint8_t *)&val, 8, 0);
> -    return tswap64(val);
> -}


