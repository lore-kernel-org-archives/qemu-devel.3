Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219A3CF34D0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 22:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swUgs-0006R3-8W; Thu, 03 Oct 2024 18:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUgo-0006QZ-3d
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:52:54 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUgm-0000xA-LT
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:52:53 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e0894f1b14so1184533a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 15:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727995971; x=1728600771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z06gW5wTSQECxDfRhAythjDYf+v+MVr/DNEElTMltQA=;
 b=wrfLoUFJz4ALsJdjLLuUL1zaF7IMQyMObpu6WrH28Xrc28jBu1kkY2eVXHffSqXXle
 nNbtMKrLdqVyj93i1pAvDrKMZy1L6K6FSTosMaaw/jZJIaHEzKhJBb7bIm5lhbS9aBcl
 Tc9U1oR7ppn0c903gOpN2PUgNqrUUH4tGzGsi1NKd91zWwZmnSZ5NooDNsU52UMHLSla
 CtMpC635Caf9NrdHKW1B+N35bhXzKILR2X6DtWmAUX9z87k1NQfpPykTjxkRtA78eVMr
 WYabVuuykGKQDHNOKleZFhUNdTPtBADNaLjji4ghvyA0b5CVydyymb0i+/6wNoXgXkrT
 eKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727995971; x=1728600771;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z06gW5wTSQECxDfRhAythjDYf+v+MVr/DNEElTMltQA=;
 b=A46eVwLAbMDBhIP4+sElbyYsbvSlPL6tqgy2QG/IEtGVSHLn1kmoi6iWhkhoL3Veb5
 dDHh8fQMM5CkOEzUn4sLe+C35moMAoWfQRQjVF9Q0+g+4EK3iC8pL/rC5sxhTzPXsBCi
 cocPrixQHyd4RNqtN3ZHqo61BMpLvdPCm2kdR4ouxJX8qZ8K9pVX/xfYtc0Qi1rNg6eM
 5R0KJ4Vi/hEAv04gwvGOvplWYGVPFJiTmqzRzNg4HEg7nPPyvzN819P74cTnMdVmEQWv
 +bXZztTz8NhKmfdBcl09qfl+ncIU6vBoZ/f1Jxkbv3nEROEgstd8fpnGpiUeTxiVV/2G
 wkSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAiiMtoMwwm1y13nRjGJwVI4Qd6ogu/RnBFLM+SIz/rFBWx2tN/Eg4TzKvbgMcUye/tOB8czJ+ZeHK@nongnu.org
X-Gm-Message-State: AOJu0YyAw6YAgwSPevUjjFgtyLPKP5wjH0ynG4mMTqza8EA1vCwCkDlV
 1HQyVFb6l1z4EIOgec0rRvkIaaypeB8IfgEQAREgfz7DyMUT0HGsyPMpf3LpzpE=
X-Google-Smtp-Source: AGHT+IEyPgR16QWagfcAGg1XNUSvHecGP9oUsyhOXAKxK/khLvoIuGKuL9BrLS+yAaINQv9eBmt4ZA==
X-Received: by 2002:a17:90a:4805:b0:2c8:647:1600 with SMTP id
 98e67ed59e1d1-2e1e6221a3dmr767818a91.9.1727995969382; 
 Thu, 03 Oct 2024 15:52:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e86a9400sm44826a91.47.2024.10.03.15.52.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 15:52:49 -0700 (PDT)
Message-ID: <68fd0426-66cf-412c-9d2b-63838c313b04@linaro.org>
Date: Thu, 3 Oct 2024 15:52:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] target/mips: Declare cpu_is_bigendian_env() in
 'internal.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
References: <20240930091101.40591-1-philmd@linaro.org>
 <20240930091101.40591-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240930091101.40591-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 9/30/24 02:10, Philippe Mathieu-Daudé wrote:
> In order to re-use cpu_is_bigendian(), declare it on "internal.h"
> after renaming it as cpu_is_bigendian_env().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/internal.h        |  6 ++++++
>   target/mips/tcg/ldst_helper.c | 15 +++++----------
>   2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index a9a22ea00e..1ce2bbf62d 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -9,6 +9,7 @@
>   #define MIPS_INTERNAL_H
>   
>   #include "exec/memattrs.h"
> +#include "exec/memop.h"
>   #ifdef CONFIG_TCG
>   #include "tcg/tcg-internal.h"
>   #endif
> @@ -287,6 +288,11 @@ static inline int mips_vp_active(CPUMIPSState *env)
>       return 1;
>   }
>   
> +static inline bool cpu_is_bigendian_env(CPUMIPSState *env)
> +{
> +    return extract32(env->CP0_Config0, CP0C0_BE, 1);
> +}

Using the cpu_is_bigendian name for DisasContext is the error I think.


r~

