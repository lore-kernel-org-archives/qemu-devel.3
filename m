Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3884CCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 13:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI5x7-0000kk-Mb; Sun, 09 Nov 2025 08:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI5x5-0000j1-FU
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 08:59:31 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vI5x3-0003Rh-L9
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 08:59:31 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-640bd9039fbso4484721a12.2
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 05:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762696768; x=1763301568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TwoLc0vvcAHe6FrRZqlSQXXFUE378WjuKdxhlU3DLRo=;
 b=uFR77x+NAtELByd18bOnFHCVGPvUjVbORF6mYvq9vzAJ6Oq4APVB2Ca4/zZBzuIVKq
 1FY0RmkiVLjFQGImQS95FvBxBKCtuqdAA//aY+6WzWCLrlzJogfGH1EvIOYMkPkb3cnH
 e3l9oztnMvIFp4FBlbEFIsNq3j/uYETF+wX9UjMlrDjwSv55S27cKUmQztmK7OvleMgM
 CIJQzdesXfGyhm/zUSdHU7yNMC6LAhjNYMh07Zdao2rIM/K4ZrWbHlLzAJZbSx7F+uYw
 f0w8eCta5pJybSZhMWIFs5CrOM3I4WJRE7FhOqnVEwNui+FP1mJzJSrkdIIHMXJzCqaK
 A8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762696768; x=1763301568;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TwoLc0vvcAHe6FrRZqlSQXXFUE378WjuKdxhlU3DLRo=;
 b=Cjam2oDAz+ZVzFKsEW5765ICEIDx5YfmwdvMyAYEw1E9rxxC8UNrYJ0BvpPulbJtOu
 7V5QeioNwAfHZjHZmLvyMUHx7tdE73ynDX4HXfdr6aa0Fn0wp0EcepzwzB5NJePYZH2f
 l0bu0DwCuijGxp7/v+jMKjLXvxcar80lw5d9rzXGGuE5Kpz2/JV9B5kFQv3Rp7JFEWuG
 o8n9zoidVk6ybDHIplnvvmKDUHw9/gCX8MMz9BCFvqT6fdQzKpfnAj2kIh6PksaQVhER
 iwLAkyvsiwCvy6W7YV1NvaA/bnUs0NafdImhU0vDID6w9zYdJ0W4/M/xBsgi2JjU2Nd1
 bMww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlgoOCtn6B0YgfzZlu9Pexj6mSAmsdYMiTUy2xsWpg6IinQiLCQY+UhgSJBeityISrvbOY7l9UZKMf@nongnu.org
X-Gm-Message-State: AOJu0YzX1M+u7y1LIEVP0yDCrTHbWIpzc8hQ8tqk0M8gTTHCu6EQWYiK
 JXLAwjt6mhJAfDl2ojDj6ov4JHDiwpWzKeXFWJPgabP1AcKQqUDg+8igM/Il6J571XA=
X-Gm-Gg: ASbGncvxWUf5In1O/muK5YkiiL9nOlkCHZIMnM9mqCtpcw+uPH5Km8Ba7nMkdVzIaXe
 y+nR7VLcqRsPp6vrNzhPFGpszFfngymzxiAoz4DG6DY+JwaN+z/aIVpZgR8/GVkNvdFNd1nu2oZ
 hWFl7OkA/jUpeShK89VDqbelaCrxXWLB6b/7oji8XfpZG+yd+/5y+nckIJPqf74K7uJ4cBqnOJI
 SwDz3OB7qV42l83AAWmN/3VOKCy1KAhdKHD4HBAbzWWGzJzwc4e8VHuPES2ZIfUFLvZuy6AIhTj
 h5BkUd53sFQCxqWcPMvy7H0whlw7izigzhNeYkTne1jQKGV3m3h/9+6+ibF5Ok20OK0BjthqaXF
 34vLo7RG0F4DdfxXmzYScnKArHcFoQlo7hKAUO3APRXsKGtd3w5YmKePY4il9ISS76S7lp5SAZ6
 0DOwTDpTmBDnEj7T6GaQARM2hNZ1TTntTvTTfwm6vAvQj/ojdzvYpgabuFIA==
X-Google-Smtp-Source: AGHT+IHWxZGfx2TvMYgSseWY40nHgOdTgkF/YV8pWgmQkftjg0gcgGHtub8jA3anYd20tKD9E6Gh6w==
X-Received: by 2002:a05:6402:35d4:b0:640:be20:fc7b with SMTP id
 4fb4d7f45d1cf-6415e80a82cmr3912174a12.31.1762696767998; 
 Sun, 09 Nov 2025 05:59:27 -0800 (PST)
Received: from [192.168.2.7] (tmo-086-152.customers.d1-online.com.
 [80.187.86.152]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6415d91f486sm4414827a12.22.2025.11.09.05.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Nov 2025 05:59:26 -0800 (PST)
Message-ID: <264a1c41-dc4c-4158-9a71-5261f4d51b08@linaro.org>
Date: Sun, 9 Nov 2025 14:59:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] target/riscv: replace env->rdtime_fn with a time
 source
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
 <20251107102340.471141-7-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251107102340.471141-7-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 7/11/25 11:23, Luc Michel wrote:
> Replace the env->rdtime_fn function pointer with an instance of the
> RISCVCPUTimeSrcIf QOM interface.
> 
> This allows to remove the dependency on the ACLINT in the
> riscv_timer_write_timecmp function:
>     - This dependency was buggy because env->rdtime_fn_arg was an opaque
>       pointer and was converted in riscv_timer_write_timecmp to a ACLINT
>       without dynamic type check.
>     - This will allow to have time sources provided by other devices than
>       an ACLINT.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>   target/riscv/cpu.h         |  8 +++-----
>   hw/intc/riscv_aclint.c     |  2 +-
>   target/riscv/cpu_helper.c  |  7 -------
>   target/riscv/csr.c         | 24 ++++++++++++------------
>   target/riscv/time_helper.c | 15 +++++++++------
>   5 files changed, 25 insertions(+), 31 deletions(-)


> +void riscv_cpu_set_time_src(CPURISCVState *env, RISCVCPUTimeSrcIf *src)
> +{
> +    env->time_src = src;

Worth asserting time_src is NULL? Regardless, good cleanup:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +}


