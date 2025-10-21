Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B7ACCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBIgT-0007nh-Qg; Tue, 21 Oct 2025 16:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIgN-0007nC-Kg
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:10:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIgK-0001Nu-Rx
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:10:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso154833f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761077405; x=1761682205; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0JseKUjW9Ni9RmsgjQpjjRbH/EH5VYgj/JYe7RyFRv8=;
 b=D3CsvDlaHQcNjwu7+S8i4Xq0hCG9/aDXbV/Sst+KWDc2u5XxDmOhdXfS9lgqsLTRfx
 IEgnayJjn39yRWVMaROPR4mjqeH09olcPhApihXp0lp838f7zNkDYKjS9QcULMlzNRHM
 MUJ8eTV+VF//AJVr2Sc+VkxTZ3bcKRyquZBDiaOysErEtsrD9hlVJKv6BN08DsOiEllI
 dZqFaKh7lgzN2b3if7L8hXj9ZWiJ/6Q+tLuuvxdZzRtqPmh870kulBBxLFlEvYJIoefj
 ZJOpaS2I2xW+LssW4oFMAKzVr30Z5zfKbCfI6wMiyy7FlZWIkNg/fRhg6pSQsaXlJAAO
 jwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761077405; x=1761682205;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0JseKUjW9Ni9RmsgjQpjjRbH/EH5VYgj/JYe7RyFRv8=;
 b=vOqabqJ7rgnHjIXKXpZmZ7fjsEEA/kOiGAY19xx/VciNsTC4Hmx9hgzEItLbIKCbGI
 4oONcIQSZ3pDfPckwVtOvA352CpFD6N3QQX3TOt5rEan4pGxFOGT1BbM5tdRXBjrINf0
 ckEUNU+Y4wPVMw81/4iR0i6G+KzOfpGbrlALHkcIggMZ4c0JKQQldcqUE/NkaQT7bF3o
 pefRD8qcdtvwIDH3rnLzm6nIbrq9cHRv6e+2MbJCMPJO11l2+ZAKV9gC+ONB6A63pHP3
 YsuXgetuYXJzVw4GLqEr+lvj7pvtZKDumHpb8g43paOZdsLakFYAm6OQmee4wlJQvZM3
 zexg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3hz+WmpHlduF+FHcsl6XA+qBiR77sw8Cf9NjjjqOekO9EWpOFjSxZI5SOQwX9lAd87FsW1x2uSlUF@nongnu.org
X-Gm-Message-State: AOJu0Yyyg/BmlRfQQMBXksyp6vF3tw0DNmQJxcYzAC+gBzcvRBOvCmz0
 qWdFFTnMpL1DzPD4rlj7Q8f61ASCzATwE71mz/o7f7eHjnmhLkfb8HS1AP5d+gB2NyM=
X-Gm-Gg: ASbGnctN2VtBWi7aUvZGX2q1RbDN7yfBCo4BzwCfSnc9Wi4xJHvHw4EOUhWtgQYjHBz
 /FQOrpmVKqll1G7y+sZxZ0utVHtsO2clXPJqguOX60eXgrtZRJmjri9AuYUTO1uCec2tVIMGr8N
 1F9P4sz6AVQwu0FKDjYl6ifDN005/G+IrvzkuNlwKm2UaXjWiGsXkEn/3I6y5ywv2bYqV1M/fJf
 Sr+xRZZ9vGanjLKrgcykNbnpuEGSaCuWsaQBcekxux1rgOtt/cJfoDcaLkMp8v89tHNNII8LSed
 tKc+23ML1dN6hZpzjY9lc6fEfvc8rK9EexEROSyM2xf9FrdrVsf2nAqtnpJGTEtLQLJ2SWjpKo7
 GK52BHPhq74X06+KofkyTTKf9em7aytud46WWf8NnIgFnAj7nhB9r2qv7zBYIFG25C1YK5nbgYp
 YO7K1XQF99qqptKbzU+SxT6UPox5jwD2ZBaCnmDXyGIo4=
X-Google-Smtp-Source: AGHT+IEt2JlcgEve3V1V+C/D0KlmC0sN3t6ooiqC/wt9L+uMBR0041WKDfUR7L3Oq2RylK9fq4MtJQ==
X-Received: by 2002:a05:6000:2002:b0:428:3bf5:b3a3 with SMTP id
 ffacd0b85a97d-4285317da0cmr729871f8f.1.1761077404987; 
 Tue, 21 Oct 2025 13:10:04 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428f709sm10056955e9.8.2025.10.21.13.10.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 13:10:04 -0700 (PDT)
Message-ID: <2a0a4cde-1427-4d87-a331-f4ed6fa64aa2@linaro.org>
Date: Tue, 21 Oct 2025 22:10:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/25] target/alpha: call plugin trap callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <cover.1760884672.git.neither@nut.email>
 <78ba254c812a91105bf52f6f0ce73774ee2be265.1760884672.git.neither@nut.email>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <78ba254c812a91105bf52f6f0ce73774ee2be265.1760884672.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi Julian,

On 19/10/25 17:14, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for Alpha targets.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/alpha/helper.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 096eac3445..a9af52a928 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -27,6 +27,7 @@
>   #include "exec/helper-proto.h"
>   #include "qemu/qemu-print.h"
>   #include "system/memory.h"
> +#include "qemu/plugin.h"
>   
>   
>   #define CONVERT_BIT(X, SRC, DST) \
> @@ -328,6 +329,7 @@ void alpha_cpu_do_interrupt(CPUState *cs)
>   {
>       CPUAlphaState *env = cpu_env(cs);
>       int i = cs->exception_index;
> +    uint64_t last_pc = env->pc;
>   
>       if (qemu_loglevel_mask(CPU_LOG_INT)) {
>           static int count;
> @@ -431,6 +433,17 @@ void alpha_cpu_do_interrupt(CPUState *cs)
>   
>       /* Switch to PALmode.  */
>       env->flags |= ENV_FLAG_PAL_MODE;
> +
> +    switch (i) {
> +    case EXCP_SMP_INTERRUPT:
> +    case EXCP_CLK_INTERRUPT:
> +    case EXCP_DEV_INTERRUPT:
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> +        break;
> +    default:
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
> +        break;

Shouldn't we handle EXCP_CALL_PAL with qemu_plugin_vcpu_hostcall_cb()?

> +    }
>   }


