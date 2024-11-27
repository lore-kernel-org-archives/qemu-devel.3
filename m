Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF31D6ACF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 16:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGLBg-0003EZ-5L; Wed, 27 Nov 2024 11:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGLBe-0003EQ-PK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:46:46 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGLBb-00036c-Hi
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:46:46 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ffdd9fc913so1312611fa.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 08:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732726002; x=1733330802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dzV41cTzxq7eIpqr0WRp7MvbTk7xpMOF1Ow1F351q1A=;
 b=cIJq83k3o+vadEXz5dZwJVcyE8K0XN88ik8JoIZlSVWfRGibiFtZkOhYXbWetb3Crq
 4ScpG1roT8bQVIhGsLDnsFJfrJaK0/hcg/RRj4qMaWGRFfJa+/DoAKcCrlCp/ipjY0Tk
 pSlRqKOwne1hwC0pk2RNdpyCgJNg/O/mIkCi5QierjEkyYdG/GcPPRCdyDw0JSFIdH40
 oGMs2sa7d9OKYBt34pNubrPoqJY1wyXjzBsnh+mAuE68rUvLCF7/3bBKgOAl4phLH2pr
 MuZXEKz4wIS9n8KMzdpF3HcpGSRxD0/Yb+hH1Lz8s9wk6zv+8NhRQISCbA+6QyGvpOHW
 9KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732726002; x=1733330802;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dzV41cTzxq7eIpqr0WRp7MvbTk7xpMOF1Ow1F351q1A=;
 b=SCZ7ix6atPP/QSTV64JYDRQ3Q+JgEuiImotnDU/5pmnCyow4/xlV6VstEo2eaY4oPS
 AyCa3IJPfshP4973EME49B5kr/2odfaBGLbDSE8zJ7mRkXNifDsIhKaile335btmRIBW
 3kslc2Y7UyMf/+8TWBPnM4FgA+cwQuZsSNDfCSlThef+6pjjRwHyYrL6tqPVaN1Xd+6N
 PCKuoyQu9VXPB8LqApSHHhKAPHTwoMZSNAeg1cCbeo2ekW+6Nu1r73N4Z25nHVv2tWWX
 8+e3/5REdSNe4o8MJBOosGX8B0O9kghtzlvt1CkC42vExhU0zogQhA/x4Pl2e3M+ftZA
 oI5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0Bs01bI9yqUxq8ZV7Ck798P+5TU6uwOMhdeiu4PnrZGmbUnESSJGft2pHlnO68nWAHZjIOB5jci+P@nongnu.org
X-Gm-Message-State: AOJu0YwilNeP5bZAWhPypjoSnIPf6Q+T5WfsRVcdM50AKx53t9IqtjI3
 6juVrkZLppv/ttU/aEMPwukFGxbRSfpNKY3KNZpEsdie35o2FOF9yrUL/mJEGgMEF5gxDQX8gew
 DdkA=
X-Gm-Gg: ASbGncu/4fyqdM5Gigse58cVEIVDeuYyYiYD0EOS6dcPEqFRGEJFpEqYq1Jz6wnFYzx
 +4MB4zKLWQ0lfSBeXC4g8BseiCA/SHUonMGkM1+0zhXrguCUNG3Z3bkvxOdhBnu/WIWDGGED+a8
 bA3BK7RT0angV1UoUrW+09e852BlQsxkhjRPAQ7mpTIpMcoEsI7vBkG456xyII/nl3+fNjK3QXv
 bh6uGz7R/kZeCK0aQucwdfN5Lc2at3/ftp28gnkCh27RyLfXrVI/ymxc35IeUY8O1hA
X-Google-Smtp-Source: AGHT+IEXaxBRIrz8fXkTViho7WeD1VAdJ5/c6EqxOu+JP3xFL1DU21B267xoYZB+Gg+yoPiLWNUvOQ==
X-Received: by 2002:a05:651c:10d:b0:2ff:d15d:649 with SMTP id
 38308e7fff4ca-2ffd60cfad0mr20010961fa.31.1732726001754; 
 Wed, 27 Nov 2024 08:46:41 -0800 (PST)
Received: from [192.168.170.227] ([91.223.100.71])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ffab5a77edsm19530821fa.61.2024.11.27.08.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 08:46:40 -0800 (PST)
Message-ID: <8e9680b5-e761-49dc-a4b7-34792f45e621@linaro.org>
Date: Wed, 27 Nov 2024 10:46:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 4/6] include: Expose QemuArch in 'qemu/arch_id.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20241127121658.88966-1-philmd@linaro.org>
 <20241127121658.88966-5-philmd@linaro.org>
 <7103f10d-5852-4c07-83d3-8e25fd3a0578@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7103f10d-5852-4c07-83d3-8e25fd3a0578@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x235.google.com
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

On 11/27/24 06:25, Philippe Mathieu-Daudé wrote:
> Alternatively we can restrict TCGCPUOps::arch_id to
> system emulation, using in the next patch:
> 
> -- >8 --
> diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
> index ec3d2b50a9e..6fe0e1a7e97 100644
> --- a/include/hw/core/tcg-cpu-ops.h
> +++ b/include/hw/core/tcg-cpu-ops.h
> @@ -19,8 +19,6 @@
>   #include "exec/vaddr.h"
> 
>   struct TCGCPUOps {
> -    QemuArch arch_id;
> -
>       /**
>        * @initialize_once: Initialize TCG state
>        *
> @@ -58,6 +56,7 @@ struct TCGCPUOps {
>       void (*debug_excp_handler)(CPUState *cpu);
> 
>   #ifdef CONFIG_USER_ONLY
> +    QemuArch arch_id;
>       /**
>        * @fake_user_interrupt: Callback for 'fake exception' handling.
>        *
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index b37995f7d0c..31a2ab18e7c 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -1072,15 +1072,20 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
>   {
>       static unsigned initialized_targets;
>       const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
> +#ifndef CONFIG_USER_ONLY
> +    unsigned arch_id = tcg_ops->arch_id;
> +#else
> +    unsigned arch_id = 1;
> +#endif
> 
> -    if (!(initialized_targets & tcg_ops->arch_id)) {
> +    if (!(initialized_targets & arch_id)) {
>           /* Check mandatory TCGCPUOps handlers */
>   #ifndef CONFIG_USER_ONLY
>           assert(tcg_ops->cpu_exec_halt);
>           assert(tcg_ops->cpu_exec_interrupt);
>   #endif /* !CONFIG_USER_ONLY */
>           tcg_ops->initialize_once();
> -        initialized_targets |= tcg_ops->arch_id;
> +        initialized_targets |= arch_id;
>       }
> 
> ---
> 
> But it add more #ifdef'ry and doesn't seem worthwhile IMHO.

I agree, not worthwhile.

r~

