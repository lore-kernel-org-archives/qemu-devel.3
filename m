Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3D0C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WNa-0006Mz-CI; Wed, 23 Apr 2025 05:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WNZ-0006Mm-3L
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:26:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WNX-0006pI-1m
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:26:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so49353205e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745400409; x=1746005209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q/bNppnNksiL0ST/6cKvCf8KULq3PBVEV9GNl1ESqaQ=;
 b=NgFir+1Jgl37kVtng8mPRtb6YXSsp74BGQgRt/zIXxSYM/zjcz1r7yy7OM5i3XDkn7
 rR0yRCCG8Of8VZeyV2ltxne1nCyYPoimSLkGHIhWmNp+FBE19Tgq7HmoGW6xW4tAAt/W
 ur8BQHy5DacIokF/gtZpqAHFWR0jCeNvQ5FUS5N6ZF8NqbItnWznXVAWXS4lE+Po1N+V
 3f4QrQBEiesTpy7OA1yADwISA3WHIU5kg+tkObbMAH+j7bLXP73T+DftMiwEQJDhjNFD
 9JwPQ6ndylSdg6me/lghPJ4R6Ztipa3XMky776E0xDEPHfkF4MTcFKmg/tgs4+d2sJgN
 I/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745400409; x=1746005209;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/bNppnNksiL0ST/6cKvCf8KULq3PBVEV9GNl1ESqaQ=;
 b=dOV8CS07uBy8RKmulrf657dRzbeeaguz4+Wx6tKKtUBI1RXMpS1SugC5Pnan+JDuiC
 boSJ7AOUVEuPp1+nNsVzuox8liveh/mBTmIIryHXHjK8dFFo8ZUbyaxB9KtSjkUUVDGZ
 AsPT6+NootaBwOXlmvPROeGcs+gfv6brj/4jv8kEp9cB57z0a4+2ZS6QPAguTTB6xPTQ
 Lq3iKtbJw3FDWf8WxgHfAQRchHqdNrW0vghf1CQuLBLjTcPgWP2On9h5SJYjc1wulKKK
 Dg2entp93x98HlstHJvHsd5jO8W9hc37meAJRMKMU/B5TxENl/jz2pJKaqbqCLpAxcTZ
 AR1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUId+JDdJxSjkoTx+IQcrxd27/WwSBEgblHlPGvjOdQk+o2uh9gCrkQ+6rKZQ4Lz4qtDIGQD1Fue9nc@nongnu.org
X-Gm-Message-State: AOJu0Yyp/BfLxpxsQQXstvpR0S8RY+w9Grq+mxVQ2qeaWWBOyemnJS6p
 gUKDe2Jax7cjGaSgfl5UwHTYojHC5C6gafW+1xw9tS/3t5UtdYBm6oDfgqlEtj0=
X-Gm-Gg: ASbGncsK1ecVlT+sPgyt4GisHf8/agKVkR0TC3uRFhCaX5lIcaI2LlwNMc8b0XZy+1G
 4/YMsh8n8g5wgQ/m3oYu1t3b+a+u4r/6LCdIAYNcnL6My11WOwN4zKi/af0eNyHDh+HM9WKHAzI
 TwQqlwf58C9mLd4UxEadBdqT3y/IcQgU4j4Z6KwJeP3jckcSgELp2rSzVcA6RA1qAX3CHTsB2yo
 q2hwTNBbS7/CN+8/VV7b9lhMxXMmi1ADF8OF/G5fxEeqTKeENpWyFgh6zQad0XTImkBUK8Vc3rd
 fFzUEyR8tgfGhhPrfU0XqGksc83rerpDeUfZMrMfQQmnSL9ywQKxU4K7M2fNmEeJgK5n9Jfu4MV
 sKe2hv5F4
X-Google-Smtp-Source: AGHT+IGxn9XpumLc35pnN8J7/Ndz0oE/xk4R2+i4zsSRyX27SBVg2dtvGD3MdtDSKZI25p81A+RB4g==
X-Received: by 2002:a05:600c:4e0b:b0:43a:ed4d:716c with SMTP id
 5b1f17b1804b1-4406ac0ef62mr147673455e9.22.1745400408857; 
 Wed, 23 Apr 2025 02:26:48 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408d04802fsm27251855e9.1.2025.04.23.02.26.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:26:48 -0700 (PDT)
Message-ID: <08aa6eac-7b43-4916-993a-b7b9555c967e@linaro.org>
Date: Wed, 23 Apr 2025 11:26:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 020/147] accel/tcg: Build plugin-gen.c once
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-21-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 22/4/25 21:26, Richard Henderson wrote:
> We assert that env immediately follows CPUState in cpu-all.h.
> Change the offsetof expressions to be based on CPUState instead
> of ArchCPU.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 13 +++++--------
>   accel/tcg/meson.build  |  7 ++++---
>   2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 7e5f040bf7..c1da753894 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -22,13 +22,12 @@
>   #include "qemu/osdep.h"
>   #include "qemu/plugin.h"
>   #include "qemu/log.h"
> -#include "cpu.h"
>   #include "tcg/tcg.h"
>   #include "tcg/tcg-temp-internal.h"
> -#include "tcg/tcg-op.h"
> -#include "exec/exec-all.h"
> +#include "tcg/tcg-op-common.h"
>   #include "exec/plugin-gen.h"
>   #include "exec/translator.h"
> +#include "exec/translation-block.h"
>   
>   enum plugin_gen_from {
>       PLUGIN_GEN_FROM_TB,
> @@ -89,15 +88,13 @@ static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
>       qemu_plugin_add_dyn_cb_arr(arr);
>   
>       tcg_gen_st_ptr(tcg_constant_ptr((intptr_t)arr), tcg_env,
> -                   offsetof(CPUState, neg.plugin_mem_cbs) -
> -                   offsetof(ArchCPU, env));
> +                   offsetof(CPUState, neg.plugin_mem_cbs) - sizeof(CPUState));
>   }
>   
>   static void gen_disable_mem_helper(void)
>   {
>       tcg_gen_st_ptr(tcg_constant_ptr(0), tcg_env,
> -                   offsetof(CPUState, neg.plugin_mem_cbs) -
> -                   offsetof(ArchCPU, env));
> +                   offsetof(CPUState, neg.plugin_mem_cbs) - sizeof(CPUState));
>   }
>   
>   static TCGv_i32 gen_cpu_index(void)
> @@ -113,7 +110,7 @@ static TCGv_i32 gen_cpu_index(void)
>       }
>       TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
>       tcg_gen_ld_i32(cpu_index, tcg_env,
> -                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
> +                   offsetof(CPUState, cpu_index) - sizeof(CPUState));
>       return cpu_index;
>   }
>   
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index 14bf797fda..185830d0f5 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -3,6 +3,10 @@ common_ss.add(when: 'CONFIG_TCG', if_true: files(
>     'tcg-runtime.c',
>     'tcg-runtime-gvec.c',
>   ))
> +if get_option('plugins')
> +  common_ss.add(when: 'CONFIG_TCG', if_true: files('plugin-gen.c'))

So far plugins imply TCG; is this in preparation of supporting plugins
with other accelerators?

> +endif
> +
>   tcg_specific_ss = ss.source_set()
>   tcg_specific_ss.add(files(
>     'tcg-all.c',
> @@ -12,9 +16,6 @@ tcg_specific_ss.add(files(
>     'translator.c',
>   ))
>   tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
> -if get_option('plugins')
> -  tcg_specific_ss.add(files('plugin-gen.c'))
> -endif
>   specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
>   
>   specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(


