Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A563BC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUsx-0002sQ-RZ; Mon, 29 Jan 2024 11:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUst-0002fx-6b
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:53:23 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUsk-0005mB-RR
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:53:22 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5110d0b1af7so2042473e87.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706547190; x=1707151990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7zYf6iUNFHrfxMQpPNj1mXN6dt+LxrDt3+/kg2hLKwo=;
 b=Vwp/kM1sp7UetpiN+Fm1hczwoUYJRqIn5TyOjRBDa6tFqlCFY2nc+DJUsiKI/OyOlR
 YrlV1w0N9Gljto29Qcu9ByvweL4d+KJCEOxbiqPytEuy6+QuEYisq17h5yX1mxAhEwff
 MCdulEpQ2DWYJMOjyAnJYuyL6R92Xzl5qhnr6boRWqlKU+xXmi8JqhBEoPxOWiALo5iB
 COFbxQLHf7PwonGm4HovCZlLQ1JhyFa22m/9bAL1uuoGoLzJHH2j9LSEKhoHBT8Mta1V
 7HDoKaDcVgvg4/OvCI9aRWzPC9npeIEmS2FxveEZBfyrKRULlV+HpZvWFh+5gNMXcmF0
 Pjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706547190; x=1707151990;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7zYf6iUNFHrfxMQpPNj1mXN6dt+LxrDt3+/kg2hLKwo=;
 b=fovge9jeq374wZd41qgOoXsYDGQGUoEavGcZGQTaTEGChODx4TJEEuCNHhh6nlS6pf
 DDcRdMVodZ242xdGmoEd39wbJ0MezNHZ4kfdxYowu+0zhdJ9kR00cFx8/IZ2bEd7cWcJ
 d1ADP38Pzf3lwOX/lV33PZtOqyf6TG5Y6S8bDtcPKyNsoa7aP+DofihEzmpgddu3Ud2e
 b55h3sEEZCt6fFbUTWaxTwFNC4t4ZYPZSZJaZaQsJqcF2LrEZkj05xK0fO5mpCcUfeCk
 VnBiF34psSgeBb2pb+GQGOUbL2UD6n259P1muVKHKhTWDyf1MONCLwU6YV38sRWM0sNG
 RTSg==
X-Gm-Message-State: AOJu0Yx0I1MBzSPTabbD35UjgP2e/hcy6TMRjlyLBIy5Fzhn7RiBPPlJ
 GPE6ejQd+/nOcpX5akHJ616gNgiME6U+W3B22L6wKnq7KepQtH5D4hagwVW7RgNDFa12X13WTd1
 T
X-Google-Smtp-Source: AGHT+IFqDbBCw7yz5nV9RcvTZBX8s1a0hQpdUqa06QWgXja+MJAioJfvQM63rBkNoCDgx4FWDHSl3w==
X-Received: by 2002:a05:6512:1082:b0:50e:75ee:ec4c with SMTP id
 j2-20020a056512108200b0050e75eeec4cmr5201521lfg.11.1706547190625; 
 Mon, 29 Jan 2024 08:53:10 -0800 (PST)
Received: from [192.168.69.100] ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a05600c310800b0040e703ad630sm14516047wmo.22.2024.01.29.08.53.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 08:53:09 -0800 (PST)
Message-ID: <bb4ed4c6-ecbb-45a6-af3b-caa4fe04afb8@linaro.org>
Date: Mon, 29 Jan 2024 17:53:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/29] scripts/coccinelle: Add cpu_env.cocci script
Content-Language: en-US
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org
References: <20240129164514.73104-1-philmd@linaro.org>
 <20240129164514.73104-6-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240129164514.73104-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

On 29/1/24 17:44, Philippe Mathieu-Daudé wrote:
> Add a Coccinelle script to convert the following slow path
> (due to the QOM cast macro):
> 
>    &ARCH_CPU(..)->env
> 
> to the following fast path:
> 
>    cpu_env(..)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Changes since v2:

- Avoid templates by using coccinelle generic types
- Deal with uaccess API (by skipping functions using it)

>   MAINTAINERS                      |   1 +
>   scripts/coccinelle/cpu_env.cocci | 100 +++++++++++++++++++++++++++++++
>   2 files changed, 101 insertions(+)
>   create mode 100644 scripts/coccinelle/cpu_env.cocci
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dfaca8323e..ca3c8c18ab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -157,6 +157,7 @@ F: accel/tcg/
>   F: accel/stubs/tcg-stub.c
>   F: util/cacheinfo.c
>   F: util/cacheflush.c
> +F: scripts/coccinelle/cpu_env.cocci
>   F: scripts/decodetree.py
>   F: docs/devel/decodetree.rst
>   F: docs/devel/tcg*
> diff --git a/scripts/coccinelle/cpu_env.cocci b/scripts/coccinelle/cpu_env.cocci
> new file mode 100644
> index 0000000000..5a70c2211a
> --- /dev/null
> +++ b/scripts/coccinelle/cpu_env.cocci
> @@ -0,0 +1,100 @@
> +/*
> + * Convert &ARCH_CPU(..)->env to use cpu_env(..).
> + *
> + * Rationale: ARCH_CPU() might be slow, being a QOM cast macro.
> + *            cpu_env() is its fast equivalent.
> + *            CPU() macro is a no-op.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * SPDX-FileCopyrightText: Linaro Ltd 2024
> + * SPDX-FileContributor: Philippe Mathieu-Daudé
> + */
> +
> +@@
> +type ArchCPU =~ "CPU$";
> +identifier cpu;
> +type CPUArchState =~ "^CPU";
> +identifier env;
> +@@
> +     ArchCPU *cpu;
> +     ...
> +     CPUArchState *env = &cpu->env;
> +     <...
> +-    &cpu->env
> ++    env
> +     ...>
> +
> +
> +/*
> + * Due to commit 8ce5c64499 ("semihosting: Return failure from
> + * softmmu-uaccess.h functions"), skip functions using softmmu-uaccess.h
> + * macros (they don't pass 'env' as argument).
> + */
> +@ uaccess_api_used exists @
> +identifier semihosting_func =~ "^(put|get)_user_[us](al|8|16|32)$";
> +@@
> +      semihosting_func(...)

Hmm, s/semihosting/uaccess/

> +
> +
> +/*
> + * Argument is CPUState*
> + */
> +@ cpustate_arg depends on !uaccess_api_used @
> +identifier cpu;
> +type ArchCPU =~ "CPU$";
> +type CPUArchState;
> +identifier ARCH_CPU =~ "CPU$";
> +identifier env;
> +CPUState *cs;
> +@@
> +-    ArchCPU *cpu = ARCH_CPU(cs);
> +     ...
> +-    CPUArchState *env = &cpu->env;
> ++    CPUArchState *env = cpu_env(cs);
> +     ... when != cpu
> +
> +
> +/*
> + * Argument is not CPUState* but a related QOM object.
> + * CPU() is not a QOM macro but a cast (See commit 0d6d1ab499).
> + */
> +@ depends on !uaccess_api_used  && !cpustate_arg @
> +identifier cpu;
> +type ArchCPU =~ "CPU$";
> +type CPUArchState;
> +identifier ARCH_CPU =~ "CPU$";
> +identifier env;
> +expression cs;
> +@@
> +-    ArchCPU *cpu = ARCH_CPU(cs);
> +     ...
> +-    CPUArchState *env = &cpu->env;
> ++    CPUArchState *env = cpu_env(CPU(cs));
> +     ... when != cpu
> +
> +
> +/* When single use of 'env', call cpu_env() in place */
> +@ depends on !uaccess_api_used @
> +type CPUArchState;
> +identifier env;
> +expression cs;
> +@@
> +-    CPUArchState *env = cpu_env(cs);
> +     ... when != env
> +-     env
> ++     cpu_env(cs)
> +     ... when != env
> +
> +
> +/* Both first_cpu/current_cpu are extern CPUState* */
> +@@
> +symbol first_cpu;
> +symbol current_cpu;
> +@@
> +(
> +-    CPU(first_cpu)
> ++    first_cpu
> +|
> +-    CPU(current_cpu)
> ++    current_cpu
> +)


