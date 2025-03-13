Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB89AC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslhr-0007r9-NQ; Thu, 13 Mar 2025 12:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslhS-0007dl-4G
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:46:35 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tslhP-00085s-C2
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:46:25 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso23643125ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741884380; x=1742489180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ze2XcqWUWVra0yUxq+qlsoMQbdx+/e/8efUvGVuJQCs=;
 b=yL7ZhPEQlcMwxaS2snUojRL7gEPNxwljsm1q7q7nWIVAB+/RSESWf7EF970hz0L3xy
 KFkJW+JXR80G4pNxndzLyfG2r0pBd6ViWQwi3/UOAfupj18mirZrZdh72k7CZS5GwGkp
 y09ZgRMowgTsluqRct79OXlB7zYQl2nIYxk0LBTclttHnD+d+s5+H6DD7N7hdpoZsWlj
 WKiJflQLmc1NVV4C3RHcZFY+9zFSwZdtCEptB3bfFPzcqq5RWEwV3AMDyO44NsPwQeGk
 3N4rsUpUHtl1sJMUsDIgBqM19SHQwMk+5r+REG7jveZ47zChGcYQoEZAhv2PwnuFGw2L
 1fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741884380; x=1742489180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ze2XcqWUWVra0yUxq+qlsoMQbdx+/e/8efUvGVuJQCs=;
 b=MmwQfbUNuc/NMKMZQrjRtWhyV56xyX+a+g4bIYrW9SDYicq85ow5JyBZ3amaR6nPrj
 qxJ4iB2iYZ6pK8O7g1NN6qvJk1audNSXwtG1CpQ/AU6/EXM5x4PLa2RWopNKSONnS+qR
 BIPUVYOANbB2vYSiHYKCqWvwHpKN1Kxh2SJa1qLoTN7iRi35e4ERGIgAKW1rgPOEj7fJ
 2Ry6/+BhOsfjSonvy0qDjtdXZSzsLET5BPTFP+FZu7PWGqC7NN/5VqXxuz53DSVpjGr3
 QcKLajWfY2VtJlGUWHCWX8DLKalgKxIvbB0QaxSqe8DzWvV2k7JMcUNaL95lqsS6t6DV
 z3Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg2uqjycKY7Cqgvp/tXrSKfbvouawVi5+uC9ET8Y6B3zBmJ/qwkXUdysLEO46e76Xlwox8Yrnql+cl@nongnu.org
X-Gm-Message-State: AOJu0YzHbZ8Ux5vrNoF3lhWg9wYE7SWPNMc4oHlH/O9S0Ttq9SYeht3r
 duIkhqcgWq38PVjhY4IZ2p5G+y/ZwKozIjiuQI2USqftz3Jp3gVgBzV2d2hFtRg=
X-Gm-Gg: ASbGncs2XT4JMrLizk9EWqG6UYFcssz9sJ3ELgyMzmfDUHZG2TITP20Kq7Iz574vPoR
 KGRpmpqvw3lAfT5R6tA+SsvuVkGWquIcKh4QEVsOTuYvb4J917h6SjIfBuOqNkrZH7ZMpP0y/9j
 SAz/GE68k9BqBkMY1tsnkwG2zKo8Lx92jLAqxODUuJ6ntzlGnT+xdTRqCef1dV/TA1vBTsWP5C4
 29+PZf74BTfkaxfSvUGLf4K3f+H003wmc1vMrrPEEKXUYf1C+mTtQY1ldY+s0pIfQmVUyD8OfGt
 GgV1ohn7mplVj9EpHYQd6fzED5IPGsOaudAha5ST16tj/m33tAHhaiBBWw==
X-Google-Smtp-Source: AGHT+IFk6/8tGOTqRfVQhuCR7yzCcDSjf+edWdg2S1BO93dmfabXnfwtAsdOz3AD/iauTSQ/EE1Swg==
X-Received: by 2002:a05:6a21:700b:b0:1f5:70af:a32a with SMTP id
 adf61e73a8af0-1f5bd90ac2dmr809219637.32.1741884379910; 
 Thu, 13 Mar 2025 09:46:19 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9dbdf8sm1282558a12.17.2025.03.13.09.46.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 09:46:19 -0700 (PDT)
Message-ID: <15183977-158e-4258-969f-b11fbfa3afaf@linaro.org>
Date: Thu, 13 Mar 2025 09:46:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/37] accel/tcg: Build plugin-gen.c once
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/12/25 20:44, Richard Henderson wrote:
> We assert that env immediately follows CPUState in cpu-all.h.
> Change the offsetof expressions to be based on CPUState instead
> of ArchCPU.
> 

Nice change.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

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


