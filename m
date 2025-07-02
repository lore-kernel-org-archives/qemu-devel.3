Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649EAC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzat-0006ND-Vm; Wed, 02 Jul 2025 11:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzaV-0006IC-8m
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:41:34 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzaR-0000rQ-9h
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:41:30 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-611f48c6e30so1026704eaf.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751470885; x=1752075685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pWumB7VML/p/NyPefYUiHvXnoWApGVdaA1r+Ju2JxqM=;
 b=dCUaB/6UK3hEb3pfhvwQA4APUSY+VrIa/ybs9k1S7FGzAkCXru/U2M49EcLdBDjp57
 nF8sezqVT13LC2H0W/mEJkNN9XZO49BSzCanWaESCcd4NEruEquYi5LRNM3kSSIQ7Vwm
 BJhHLWUFC82a5MFqzDhpLWGkNG+ANyIM0Kv+05mlXAafWhMhrA+yewFho99SIFC2GgwH
 IZpXZy8V5rgoYslgbA1yaKBQIEl0oWrIrJczbhqEEeHvfsR+tZA+lOvnt61NDxHE2e3e
 W4YZpFFT2SYHIo25lIRXfaoP/d9GhKY61fuYs44qpQo9d+0rogEafJR7P2ZDff4k66OO
 4eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751470885; x=1752075685;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pWumB7VML/p/NyPefYUiHvXnoWApGVdaA1r+Ju2JxqM=;
 b=sZKaVks2uUinGtS0IhHXEg69KJcbodGhg9lesZan+15nd733hlqR2XEZM74bsBHKgx
 sDuLqwG6kHO3lizmkr+UfcTB0j7+ol6l28zf0DQuSwYlSGc46HzfcN7fKNTep1nE2bJr
 42PZSzJ1K4gtsgctz/TippKxvbBmSlvYOAJU49u/yocAF82+3+3FYkQTGsu/AgkNdzIc
 JZYSHitEgH9R6ZHh5yXmcjpxBnZOAfaOmql5DuaIyOMgb4LVLd9V8y82lJ94G433gwd5
 ChbKoC5hjFTZSe+ygg67XDi2tcIwZECd2vsPa+uvLHcQ1FWHN1v8g+S2plrFCpYlFY3V
 5tBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUP3HneZi5PratwzHqEpPb9n7XThaWemFr3kzuwhDgV3xa5/vvHFmkN++PvuaFIuWBQ49IFfyfFkZw@nongnu.org
X-Gm-Message-State: AOJu0YzafbZc+auf+u0WdryBkopLSKVVWTdfRKCrVgqdEXffNOaJc96f
 Vf7E1Zz3x6TPOCUalY+HCn/ikOa/RSEp6/0B1M5bzwVg079wQvMOLx11jnyhlfuK638=
X-Gm-Gg: ASbGnctz3cdTjjAIzJkepay4D+YH2yQ3DWQKKIqRM7lVECfCy3iqv7BwA0Npf/FPKPK
 Hhnfm2kBgzC0KYL0sq/tDcLUr3n5i5x9laT1II4f1olD/Gvz00sMY6Db5DMQT6izmY8qIaWhDE2
 s1rAPPlPJYEiuK/pjhR/RGWvEh/tbrSLYQGq+UYai/EdYEnN2ZtiFVSQeOgYv82hyTHQenrP0nO
 yYGapG51P6Zu3Wt7ItyfMocEdtbgY0wMoh0q1jwpxnAaEIsE9fsQaQVJAYlYSdRqZDLNRtCgcym
 EpVjGznIahW3K2rzyVIl5w8IuNO47ktlB141o6lWb9hi7Wd2+Lw2wmjN3EWRYG/pE/LjK0bPLgc
 /
X-Google-Smtp-Source: AGHT+IFUKw+S5zOUvk2GHmS3dFe4SyVaR7iFmVHGKcI9l9lx8ny+j9kcpEyEI3Iv3JdRUhk3w81gKQ==
X-Received: by 2002:a05:6820:206:b0:611:641a:9db3 with SMTP id
 006d021491bc7-612011c2a13mr2741124eaf.7.1751470884940; 
 Wed, 02 Jul 2025 08:41:24 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b848d6b8sm1696804eaf.12.2025.07.02.08.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:41:24 -0700 (PDT)
Message-ID: <8c9a832f-4dcd-4763-95ea-911ac203a84c@linaro.org>
Date: Wed, 2 Jul 2025 09:41:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 65/68] accel/hvf: Register init/exec/destroy vcpu hooks
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-66-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-66-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/hvf/hvf-accel-ops.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index b61f08330f1..d2b3217f145 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -354,7 +354,10 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
>       ops->cpu_target_realize = hvf_arch_cpu_realize;
>   
>       ops->cpu_thread_routine = hvf_cpu_thread_fn,
> +    ops->init_vcpu_thread = hvf_init_vcpu,
>       ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
> +    ops->exec_vcpu_thread = hvf_vcpu_exec;
> +    ops->destroy_vcpu_thread = hvf_vcpu_destroy;
>   
>       ops->synchronize_post_reset = hvf_cpu_synchronize_post_reset;
>       ops->synchronize_post_init = hvf_cpu_synchronize_post_init;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

