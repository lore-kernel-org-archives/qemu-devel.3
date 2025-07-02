Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF4CC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzLW-0001Jz-Lk; Wed, 02 Jul 2025 11:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzLO-00016b-UJ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:25:55 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzLB-0001pg-1I
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:25:52 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-611e455116aso1852300eaf.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751469935; x=1752074735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vYj5MnnvsKutdoedy7MwvT1rcAdz+BP4UP/vkZTsvpY=;
 b=PJCKOhBex2cL7w/DqS/eFBtcdwWAby3BolmVLHP3yyTvBrHydg1A+HSU3qVXk5yEK7
 /3ux8Oo4MifLRzV0ecSqHI/PJ2mxyYPOQsNqlJ3rdTV45kmM43a6gM8fNxmlU2ckbe4B
 Jh9R3ZDeMqs/rJDLb/9gQuT9F0trxzzpCQwiOtytQnwViAhnmuHyUL8qaRqFgCFXVhwo
 xklCX2isOQoUWnQOQ0NHupX2Q+xhQ8pCndQMg4xS30ENTpkeL+dgk13oIW0aFknysBxQ
 fbc5+emOclBQc/ltR9UXpN/exs7V+o2zA+n4auw8l8fmhR+EG/2T5WeMluLi6NozowZH
 N6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751469935; x=1752074735;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vYj5MnnvsKutdoedy7MwvT1rcAdz+BP4UP/vkZTsvpY=;
 b=KCwQgZMwCdmNmTbBHwfu6r2HYbuZlJczW93/E9pNkEqpIQ1n+SXwQwr5688ANsWVPi
 MJR0lfMbag/iqXbk/FT9SfR4uZkq9OGd+234WeP9KZAphacedb6g4MxuooXXKl6I+MKK
 3tm8Iq4/h0HkL1auPqboPvkBWPISaFlTgeHl3CWBU5GTBt3VbEYShOYPlgnp/wdFB3jS
 Kv4HpktECk8sl4GStkFbVJ9zwECA5+IxuUJciCNl1vOk5BkCHtKS3golbWpUaHRp+QxC
 6mNwglui11ccP3DtKLSTE4DfEIrhlcKd3PgyBnm957SWJ0EsBhbseQoQCr6MZ9QR8Jyz
 eOog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpPWOLSW9uhYIK5TuBFBlEUxRVqbJhDM4ExMxG89owlAoN/66tofZ3H/M316++luz85AxN7JvkZlVx@nongnu.org
X-Gm-Message-State: AOJu0YzBlhm9x7z6XMkU3d+bA/IGVL70qEsaNfDZpsYffNzk8JpM7S7i
 7KAbveLb0WuCnp4pvdMBAy0vcHyEC3r+tX36CpboEDDbXVRwP1r8Va1E2ZkFvB6mXuo=
X-Gm-Gg: ASbGncvnO9VM2uUs5QWODXxkpc8QL9XB/QQvLLclR21mUrf+8Zkn1vJcEwLp1mr5vdr
 Aa2FdROb5RQuYlm6Yaxsozz987R6ugr2Lbtax+YDVK/1Nn6Cuyz+PHpJnmimmb/9k1FIoPSgKkt
 eVJx29AgaEtGLaegSgcX0m7p7ix2bLRmPifgsuQ/I8p5gO+HmKM1R3b0BJkt6utZ+E264mS/up2
 1Y/k/2th+mLP/6K5u1sLnpp2BljLLUw9o17gz2EpNm9zwX/YbiNBA7pvXPQWQtaLuL9+Lj3jes7
 FiDqmXVFrDUTnnypGvZucQVHW2dctDD8BU1IAPB3cWuJ26PIf1Jbm71nGlu768BmnlMDi4BZi6t
 4
X-Google-Smtp-Source: AGHT+IEQ8KeN0chnczzryF1oKY+0V+MqBo7Wh5VW33ROZLfkqkOJpav48g03/t0BnnzrJJ24Aww19g==
X-Received: by 2002:a05:6808:2286:b0:404:1898:1a0b with SMTP id
 5614622812f47-40b8911d2b6mr2151636b6e.31.1751469935154; 
 Wed, 02 Jul 2025 08:25:35 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b322af252sm2549248b6e.16.2025.07.02.08.25.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:25:34 -0700 (PDT)
Message-ID: <9203d2df-5644-4957-9707-b7cba54521ec@linaro.org>
Date: Wed, 2 Jul 2025 09:25:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 61/68] accel/tcg: Clear exit_request once in
 tcg_cpu_exec()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-62-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-62-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
>   accel/tcg/tcg-accel-ops-mttcg.c | 1 -
>   accel/tcg/tcg-accel-ops.c       | 3 +++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
> index 8a0295e2410..2fb6ced2572 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -130,7 +130,6 @@ void *mttcg_cpu_thread_routine(void *arg)
>               }
>           }
>   
> -        qatomic_set_mb(&cpu->exit_request, 0);
>           qemu_wait_io_event(cpu);
>       } while (!cpu->unplug || cpu_can_run(cpu));
>   
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 83fb2d1362c..9b5caf9c4f5 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -95,6 +95,9 @@ int tcg_cpu_exec(CPUState *cpu)
>       cpu_exec_start(cpu);
>       ret = cpu_exec(cpu);
>       cpu_exec_end(cpu);
> +
> +    qatomic_set_mb(&cpu->exit_request, 0);
> +
>       return ret;
>   }
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

