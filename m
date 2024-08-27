Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C8CC5321D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 00:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sik9L-00020U-64; Mon, 26 Aug 2024 20:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sik97-0001uy-Cl
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:33:19 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sik95-0008PM-Jr
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:33:17 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-201d5af11a4so43222465ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 17:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724718794; x=1725323594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qac4b5Kv4OBKie+42FUj0CLupwsvaZhDDZPlSur5ZcY=;
 b=BGo0hS7dX2+C7LJx0YnCeP81Y6tPAd1UXCAPLwRAk9JHNhuQLIm1qqLLKJlPLhG5t2
 qyfD/DO/X5uau0gw4s6bin/6e5XMV0ha5athMqpDz8DVAycxAfF/qyDgqIEnaiTKi58O
 bHJZ1MHvLYK7KrvxuwNLVV9ue0vcwW2qRbuRRH2tMvTXG3CkJ87hIKb1enZUEhRAeqhS
 T5bEYnX4EcQzYRpE4NYhnBULpHf7irjW7jBoTgKbVy99jPC7a3HQdoKtzyzmXSChFGzI
 CjamvOaX9HBJ/8QBza3Lf4fHvnBmxjAAHTK2gyAzimZidJFqf7vQYRb2QZmTGUBB5aa+
 3LMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724718794; x=1725323594;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qac4b5Kv4OBKie+42FUj0CLupwsvaZhDDZPlSur5ZcY=;
 b=E8CTFnOlVFRagkGcFShcxaoP8yWdWzB+5CyrSzo3rmrJaY2FwZND9f5UEZtDVnIe9+
 EUih9+LB14QyIUq+zl4TyuLNRH/oVU+qEXg+Er9VA/+WWqZ2OszmgV6nHjPZzCJmoRlV
 ws8iHBO9YiCqqfCql/Ly23bKPXDxpNI8NLj5KiDaQJ/lYS2G5Pe4zZihyxDGV84tLfEV
 Z0pUxA695KpszJ4AyLAExrVzPXN6zFhi86zwFLGp+4Lk+RX8PQU72PPtykUZh96JwMQe
 yvZssEeV0afkEkHhnFYcpxDuaXloI0N4uwEfujQrV1FN8RnU85+4taUO69kxX8FbvYdE
 aG6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBhchaopvLg0dzMC9G8XfnDNUVNeE2wjkP5p9+M+8zuh1sUzcEu9pQRVdXkQB8D9snF8VXS9n4lbak@nongnu.org
X-Gm-Message-State: AOJu0YxF+6c3oYBfbzjvq6zxq2UfLbfXx0xbz5it+j25vYTQFgkS7xxC
 g3IEj5aoZdfvYwjLH55A9QQqCPsvVSabWRkaYIbhyuvWVZzvr/JR/jRnrsHP01s=
X-Google-Smtp-Source: AGHT+IEiFMeOa5itLVT1pveIa5hvjUJaxiIiTo7vpT8tElTp2PhjmmE6+0T6pu4DhnBWAnk+UTMYow==
X-Received: by 2002:a17:902:cf4f:b0:202:1db8:d9b0 with SMTP id
 d9443c01a7336-204df4803e0mr11745535ad.34.1724718793777; 
 Mon, 26 Aug 2024 17:33:13 -0700 (PDT)
Received: from ?IPV6:2001:8004:5110:2082:f68a:6871:1edc:69fe?
 ([2001:8004:5110:2082:f68a:6871:1edc:69fe])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2038556659dsm72705355ad.59.2024.08.26.17.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 17:33:13 -0700 (PDT)
Message-ID: <da021104-6836-4e5b-a8a4-991f975c553c@linaro.org>
Date: Tue, 27 Aug 2024 10:33:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/17] target/riscv: save and restore elp state on priv
 transitions
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-4-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240826152949.294506-4-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 8/27/24 01:29, Deepak Gupta wrote:
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8e1f05e5b1..083d405516 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1022,6 +1022,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>       env->load_res = -1;
>       set_default_nan_mode(1, &env->fp_status);
>   
> +#ifdef CONFIG_USER_ONLY
> +    /* qemu-user for riscv, fcfi is off by default */
> +    env->ufcfien = false;
> +#endif
...
> @@ -226,6 +226,7 @@ struct CPUArchState {
>       bool      elp;
>   #ifdef CONFIG_USER_ONLY
>       uint32_t elf_flags;
> +    bool ufcfien;
>   #endif

Thinking about this more, I think adding separate controls for user-only is a bad 
precedent to set.  You said you are adding these because senvcfg/menvcfg are ifdefed: 
well, that should be the thing that we fix.

The only real user of *envcfg that I see so far is check_zicbo_envcfg, which does not use 
the same switch statement as this:

> +    switch (env->priv) {
> +    case PRV_U:
> +        if (riscv_has_ext(env, RVS)) {
> +            return env->senvcfg & MENVCFG_LPE;
> +        }
> +        return env->menvcfg & MENVCFG_LPE;
> +    case PRV_S:
> +        if (env->virt_enabled) {
> +            return env->henvcfg & HENVCFG_LPE;
> +        }
> +        return env->menvcfg & MENVCFG_LPE;
> +    case PRV_M:
> +        return env->mseccfg & MSECCFG_MLPE;
> +    default:
> +        g_assert_not_reached();
> +    }

I think your function should look more like check_zicbo_envcfg: (1) PRV_U may be either U 
or VU, and different tests apply; (2) M-mode disable means that no lower level may be enabled.

It would be nice if you could generalize check_zicbo_envcfg to apply to your new use as 
well.  Perhaps some tri-state function to say "enabled", "disabled", "virtual disabled".


r~

