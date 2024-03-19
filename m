Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC31EC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 17:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmdIU-0006I6-VO; Tue, 19 Mar 2024 13:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmdIJ-0006GM-2T
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:30:35 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmdIF-0001Df-5A
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:30:34 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56845954ffeso7818369a12.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710869429; x=1711474229; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JdpTIk9+f5e71+MYsNfHufuXiNazSlSND9bnfl+T+Sw=;
 b=dUuAM/ur1TQAyA2FjuGsbgQNwBCNEdnLXW8Njk+t2+t1wD0F3G+X/zHEfMg3aPrHm9
 hM8ysJ1k/U2jmLN6p1ypQ6Q8hzbmT+It2c8e/9PU6+ugSfT2/Vm6thDuiSFwrk9Xshdc
 HAmB5IQb2+UbMgQnX10hfRPhSVdYr0tKEOxKLbJaK7NAEhkSQaSCRlHHiY+WWaMskpH7
 5tj690Vk+PqTQ3xd3sVpvSchzicuSRO+CjZg5Gz41YyDEonXWALG1i5DcfPk/tAAXV8l
 2Tlqduz5RAhm9KtjggncPk0B+iHs4jJiDNsVfN+itZFwOmv51FpXE/BazTe6LJlqNbxF
 RHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710869429; x=1711474229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JdpTIk9+f5e71+MYsNfHufuXiNazSlSND9bnfl+T+Sw=;
 b=jBCuH+z/gfMrnPYDhlYvQ1fKzPZAAW+EUJQFVPtjWGuLKv/tRt+RdVXg57aM8OJK+g
 K/Gx8AvHlBX6ej06YJHYGHQFN7lOV94Rsszjbfd+JMlCi9ErkHdYfqofXwaBnvnHN4TR
 x9OIqbCEXZGzfAHf/ExRzw8n8V5vYRoX1WrlKIKeKKifqRw70E8M4PqF9koV8JAtuiJJ
 oz6nqu8hMRkJoMI3fnjfd7bz0Y0zaaompZA8eGbru+XIJ1t4hedYcE0c8k3pIDsimWdD
 ghkcPAfsOQuIaCvwoJvPoxt+y3AGvudAQqPiweyiEaFsUB1AkYb/YuRbk6IYcq1ivNdg
 it5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMCCEXqYC6bT7lRyxeWF7pqmY7GAU3eAAa4+G0s+R8D+nPefb6Dzu3pw7YlMKqPw4iYkA9/66qzx5F5XjQxxuAiRYcSJw=
X-Gm-Message-State: AOJu0YxaIDOlgBspzyRoVnPWyJsNuCnrsg/bzacFdAsCi6MtiVlhfpYZ
 XiWzq3MZvfJe5YMQvqwBbi7n/gQARSDLyfyxXfldHDZHS8XmJqgKNjp6Y5M/MftvszAF9JWe/i0
 BFEehJiqRXcpY7WuYTlKp5Kgx6g7Joa25/genSg==
X-Google-Smtp-Source: AGHT+IHeQWck9xE5x1KfUfGsxeUoHiSb/Yfo60aFpCxeU96IIAQpWtcWdP2/HjA36BSSHUKzlcyD+eo4xio2iuOf13s=
X-Received: by 2002:a05:6402:2421:b0:566:f5d6:4b4 with SMTP id
 t33-20020a056402242100b00566f5d604b4mr2332387eda.12.1710869428791; Tue, 19
 Mar 2024 10:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240318093546.2786144-1-ruanjinjie@huawei.com>
 <20240318093546.2786144-6-ruanjinjie@huawei.com>
In-Reply-To: <20240318093546.2786144-6-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 17:30:18 +0000
Message-ID: <CAFEAcA9LnJJDsC8WZzd2ZYGgwqYkbH-FmxKHy0CXKcS2tEonJA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 05/23] target/arm: Support MSR access to ALLINT
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 18 Mar 2024 at 09:37, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Support ALLINT msr access as follow:
>         mrs <xt>, ALLINT        // read allint
>         msr ALLINT, <xt>        // write allint with imm
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v5:
> - Add Reviewed-by.
> v4:
> - Remove arm_is_el2_enabled() check in allint_check().
> - Change to env->pstate instead of env->allint.
> v3:
> - Remove EL0 check in aa64_allint_access() which alreay checks in .access
>   PL1_RW.
> - Use arm_hcrx_el2_eff() in aa64_allint_access() instead of env->cp15.hcrx_el2.
> - Make ALLINT msr access function controlled by aa64_nmi.
> ---
>  target/arm/helper.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b19a0178ce..aa0151c775 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4752,6 +4752,36 @@ static void aa64_daif_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      env->daif = value & PSTATE_DAIF;
>  }
>
> +static void aa64_allint_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                              uint64_t value)
> +{
> +    env->pstate = (env->pstate & ~PSTATE_ALLINT) | (value & PSTATE_ALLINT);
> +}
> +
> +static uint64_t aa64_allint_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    return env->pstate & PSTATE_ALLINT;
> +}
> +
> +static CPAccessResult aa64_allint_access(CPUARMState *env,
> +                                         const ARMCPRegInfo *ri, bool isread)
> +{
> +    if (arm_current_el(env) == 1 && (arm_hcrx_el2_eff(env) & HCRX_TALLINT)) {
> +        return CP_ACCESS_TRAP_EL2;
> +    }
> +    return CP_ACCESS_OK;

Forgot to note in my earlier email: HCRX_EL2.TALLINT traps
only writes to ALLINT, not reads, so the condition
here needs to also look at 'isread'.

> +}

thanks
-- PMM

