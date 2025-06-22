Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FF4C7115A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTBMY-0005tH-7S; Sat, 21 Jun 2025 23:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBMW-0005so-Av
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:27:20 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBMU-0006wE-FO
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:27:20 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so2138280b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750562836; x=1751167636; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=goN4rsH8eHiM6YY22SlvRQE/BaTzvPhgMQg5iJHTcy0=;
 b=DYYsHlmY6SbLvU/p7UtBmhWBT1VDw4it3x+zEzsg9HY4Kr3grLy5XUjdYHCzPB3dao
 XdO1+KIogiA9g93KaZVgP1xYpCWr3I3U24/+NWgaTjXZAjMpi6zwXpxz6BNzu9ibuink
 UT57H22+xq3ipdFKSIVR14UN3v4UNXUfZm/5P3+24n0s2YgO5+iPfK9Z83EBZzvX7YlQ
 0VY/BqHCVPwqWVMCEIdvuo7I2xdicH/CH+i6dk3oS2sQurP++Hz68tBvhzUJD3hUl2J8
 oP2E+za272aVlJyyjxj0cRWWWZBsiMGJ/N8+VZgVLlhbXfhHmaOHymqlcOw1kmAjJl9y
 aEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750562836; x=1751167636;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=goN4rsH8eHiM6YY22SlvRQE/BaTzvPhgMQg5iJHTcy0=;
 b=rq/lYBQ29BuvoK/cQWbD6/UXeoW7s2yvXZB8icUir9V2v5BBi91U5VyUCWBMi1zQRI
 JXKbQfurejZeEqT68sXHG3UTlFXZoQlPC4zuvfKiHiVrm9XrUq1HIy79Hsa3crdj2qfa
 s8inVd3a8ESMwviFU1FR7RxVRlIfuHqeq9EIroLaf19ZFBwiZHq0OhcbpyIFKEVQJCA1
 iuj2zxtPO7P3CDv/P5yqL7G3of36m6GD1TlfsGbkyizJx3zwc93N2H5lNzk5RG9HgcVV
 83PQ3352YW4wIEem2Coiel8AUnA+Gwuix1eideuJwoaah589A4DWyt0ahMMikQj5WYTq
 47Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfXfEsuuyRXeUFhrYuvwJhJOsmYygkBNeqLF+auvf0+viNVCwY2et9pupFS6YnsXIzPjW2P+QVK2eB@nongnu.org
X-Gm-Message-State: AOJu0YyO4IbHJSmX+rlUldJuHsXDQQzbHtK/T+HAe09zMyi6UtyVfyaG
 5ZrR+pgRUdBDXoYjXfLQFN9QLkEc0KkCTwF8W0VlBcGNz+XPnbcoMHHeCetbVxHdHfw=
X-Gm-Gg: ASbGncvBV5EBwzBDJjei1n92gT6Bx4V89LJExjkF128Tvp2um2HDoq6DD10VeNma7A5
 HxMNGRhyjid3u8Zmt/Qrj5iajDgiGcgAxAAeCYX4LM19jikpiZ9sfNjlZbXRGMbW7MXCwauB3ia
 Josw9+09mfsOGdP4Ev/zH+WBHsuIsOlafqV5HM63Ri8n4JvikN2qToYkvWMV7LuQ+B5GB/TJZWl
 O69Q6I0XoZStTHJGqjA3WqhwVT3oYJfi3yRLBqzBAx76TAosp4yEKyiaVg8F58I4vb9kZczgdFA
 AHeaq/uQ38NfpKiL41XNVgcTDUpXt+rfcGAkfIX3PXMOf3ejqNl49/VXLPb8fcxKgCMjwruHJrR
 zmA3KE/wAM3R7/qjhBnPTJgYGdFtx
X-Google-Smtp-Source: AGHT+IGSNt93t4vpnW+SKOShDriDquOrfjP5u0ZwsQyN2hYhtid3fDN17w7MgsEPrh6S/p9vWy6mnw==
X-Received: by 2002:a05:6a00:b45:b0:740:9d7c:aeb9 with SMTP id
 d2e1a72fcca58-7490db42aa9mr11831678b3a.21.1750562836335; 
 Sat, 21 Jun 2025 20:27:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a62763fsm5251003b3a.98.2025.06.21.20.27.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:27:16 -0700 (PDT)
Message-ID: <eb0c300d-5103-4f66-87d7-e3a11e6d22a7@linaro.org>
Date: Sat, 21 Jun 2025 20:27:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 36/42] target/arm: Have ERET switch to hw accel
 for EL0/EL1
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-37-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-37-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> When hardware accelerator available, use it to
> directly run EL0 and EL1.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/tcg/helper-a64.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index 4f618ae390e..5962cff4e7a 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -29,6 +29,7 @@
>   #include "internals.h"
>   #include "qemu/crc32c.h"
>   #include "exec/cpu-common.h"
> +#include "system/hw_accel.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "accel/tcg/helper-retaddr.h"
>   #include "accel/tcg/probe.h"
> @@ -761,6 +762,14 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
>       arm_call_el_change_hook(cpu);
>       bql_unlock();
>   
> +    if (new_el < 2 && hwaccel_enabled()) {

Because you're raising EXCP_HWACCEL, I really think this should be

   if (split_enabled() && arm_cpu_can_accelerate(cs))


r~

> +        CPUState *cs = env_cpu(env);
> +
> +        cs->exception_index = EXCP_HWACCEL;
> +        cs->exit_request = 1;
> +        cpu_loop_exit(cs);
> +        /* never returns */
> +    }
>       return;
>   
>   illegal_return:


