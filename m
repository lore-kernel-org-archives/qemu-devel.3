Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C4BC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 04:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKVnI-00056s-RW; Fri, 21 Jun 2024 00:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKVnH-00056a-TX
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:22:35 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKVnG-0007uW-Dt
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:22:35 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7041053c0fdso1192863b3a.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 21:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718943753; x=1719548553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RiOqIutPIkweiHeRirV2kjw1izhKmdgJIbuQySoQwWA=;
 b=Ho3iUtX+pYMdTpu+2LI60s7JTsFyP9omrciLHtD5KKtqufAl3zM0voO0JeJp86nu57
 Prr9HOVYr+Tvy7Ia+opNrKZH+Uz7q/rQqZZ6OI3LytW3Bz6NchGxfiXlbYiPU8nZgpqR
 Nsvn9T74e47z6jBDyov4GMWc9uLQdhYXUoekU9VSiPoaZsNsgCXYogrGO5CEE3HiX4Sa
 jfXGoliT2mVYced3Tf2gALrt5eot9pcwOFC9t+EYgK/HovDism7gj9Hk7vEdJcbwoz/H
 bj1SOUnVZr+UL1NkQmQvrydt+FQMMBkX7uP2ytGxQYjDIpQO5EW0CjQDEJ3ckqE7bXJz
 zhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718943753; x=1719548553;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RiOqIutPIkweiHeRirV2kjw1izhKmdgJIbuQySoQwWA=;
 b=hR1YEx5oLZGsV0smA1KvHnJZxZ0jnCT3MQ4ES0N8VJu8NP4vblQCK/VGgfgLCAdd85
 MH+r5N9Z99ljd0yi3+zYAXXuH5nhAZAaP2mG3bnATY7yB05YGvUQj3qn96a4kDJVNvv3
 pNl8Rz2A1MDL/aNKwyn37pz0PP6OvP1gVtImO6G+rN9dKkD54Lh5zLHxEAioNe6TvEjb
 BNQ6f3RWc5+i+EO5wYknoXG1gzALV1kcfDUd9bLCkadMZXdFBm+P1r3QGw6iwm05OdJP
 cHDHGadLTER3YivnVaLp38llKuLwJI78run2tTeIUcHQyLhR2rqQTJa4CJCmbXvi2kOY
 s3bA==
X-Gm-Message-State: AOJu0YysMR/9NKCxvX7tTOfXJyyFCwYTPbJJCGzMGjTYyiF88GCWRl1i
 QqpWrVjUvG9cEM5nooYUv+HPre5iYcBVrzNgtpTQW8mtlnE97B4giqS7LhYXKEw=
X-Google-Smtp-Source: AGHT+IFq5vF3a6swXj/qpEC1GWfZwvZJ0bq5KyM4lSsWMFC9c/1uaJkeWvDUupYkMhl7xKO+X2Smlw==
X-Received: by 2002:a05:6a00:1a94:b0:702:7cf0:e1a1 with SMTP id
 d2e1a72fcca58-70629cf2154mr7912163b3a.32.1718943752643; 
 Thu, 20 Jun 2024 21:22:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7065126557asm462288b3a.140.2024.06.20.21.22.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 21:22:32 -0700 (PDT)
Message-ID: <a8b69391-c60d-4250-97cd-60e1f695c9ab@linaro.org>
Date: Thu, 20 Jun 2024 21:22:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix froundnx.h nanbox check
To: Branislav Brzak <brzakbranislav@gmail.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com
References: <20240608214546.226963-1-brzakbranislav@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608214546.226963-1-brzakbranislav@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/8/24 14:45, Branislav Brzak wrote:
> t/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index 871a70a316..91b1a56d10 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -676,7 +676,7 @@ uint64_t helper_fround_h(CPURISCVState *env, uint64_t rs1)
>   
>   uint64_t helper_froundnx_h(CPURISCVState *env, uint64_t rs1)
>   {
> -    float16 frs1 = check_nanbox_s(env, rs1);
> +    float16 frs1 = check_nanbox_h(env, rs1);
>       frs1 = float16_round_to_int(frs1, &env->fp_status);
>       return nanbox_h(env, frs1);
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

