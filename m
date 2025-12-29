Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4934DE92FE3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 22:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaLyY-0007Dt-DZ; Mon, 29 Dec 2025 17:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaLyV-0007Da-1l
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:44:27 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaLyT-0007hR-8O
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:44:26 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477770019e4so79833585e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 14:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767048262; x=1767653062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ECFGSH7QKgkEYMaKQOYdlwFsntH230dy80b0LlaOyBA=;
 b=GWMkf7s5USXpmxtNyUl2Kp4hYxjGBY8pjuEBvee7pcnwJpo+x9yHkC4jTnm+1rwkXi
 G5AgUU1G6bhQqClEv9qEdU1GdiT14jCslzSXwmDHYNxi40Fgpmp4VoqaQESw+QOF2S53
 bZ79lu1RDuj5fIGJfKWM3cSTn3YKtvYyvi0tmuZwlixJ/8veDiujtloMGw3A2Q+1DunT
 vJqxdrjWrbh99xTj70ywu56U6ZFiEV7w5lg/quliei26szPe8Tv+hg4WxB38/qH44TeX
 C2CqFaFW9JqRlFdco5hwgMe0gwBDJ5Q9niSjW9D/eYbkqwO9pC1pdafU++/bHXhlbcDZ
 vXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767048262; x=1767653062;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ECFGSH7QKgkEYMaKQOYdlwFsntH230dy80b0LlaOyBA=;
 b=jW98R2dT9SZk38RZvhhr6WKG+gEnfzL9vXwVfHdHVsvCbFXgMovfVCQfjDNOy0+r5N
 L5uxUOxPgYGQvF2O5dc1B7Afk2h438WsYT4az2KQnENqBFe7rB+GcT9DP3k/IREXJYNn
 Eg7tRtravEEsXRrFm+/9fueSxWL0coF5EWsTlc1K4uC3UVXZV+PZmZkxaB17zRz1qUwP
 gf+Usc3Iwx0Wwu0ul/8VA4MJ/WIQU0ebNFQV2/7M893E8LagzpJP7I3K6h2YTwUEwvSA
 FVs/coF9yM45iBHrWkrFwsOQjjMXtL0JOUCSq7RI0ZjVhmbl6x1x/a8glX/wNl+tZcvO
 I6QA==
X-Gm-Message-State: AOJu0YxSleub2w13GKTm+phscfNftgZ7NcDR6av9fkfuDekmyi2BAJe+
 aaNHWpA4gDM1vqFVGkPJnEtosBVXmibNvBr/6GYzLkaAvYUou3aQ6FC3MkXiWmxu9Iw=
X-Gm-Gg: AY/fxX4qxsMvNwRFjlFTm+jRcVrVYo393swpRyq3g8xMgeATNTJaa+1dOG3OLAKtoW+
 UhI9gabQDFzRSh1j/9pOc1wH8tDfBjOXaO1NXxqIpdOMOv56svN0CPlTir9fL5MTt6W57a1qIBo
 tNoSaH3Aa1iuZEa193QEBWSb4TYTt9zAOfi9J4hPfW1DMykr8ef1dsYCtXfCPSnkDRbZ1x17RaV
 7L2zlqdDSSmbVAm5WYNbKhhm29PZlFbDTFVXkoOdsCxioPKpLlwPgAYV7PkPFSd4rQWW+hpSz7n
 Lso/9nTdNCRLpSxDMUng1Ofy6VdFqt/uTZDuwvMOoRtdV2GWgLfVRGIwgZJCqIL3elB5aVZEqOy
 pIgV86E3IXjG56lVHwe8cWuYwnB+UBWxYwMuR2dOBS6bp//9GNdGreyemVpkJVu7AM+sBOJ1l95
 vCo8zuQexss6KtQhTo2MAgl7Iw/RVjg6YbkDj0HPT1LXyR1FO7h8+TEOveBibYzdkH
X-Google-Smtp-Source: AGHT+IHHvDteLfn4loCBDjwq6yaf9O7mXz9+E05sF/xOGc4/kHLmjVltleaX2gmkPWewTHeVn1/IrQ==
X-Received: by 2002:a05:600c:4f4a:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-47d1953b79dmr418982115e9.4.1767048262351; 
 Mon, 29 Dec 2025 14:44:22 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3aa9971sm239602935e9.13.2025.12.29.14.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 14:44:21 -0800 (PST)
Message-ID: <2a20f149-adca-4e40-b253-1afbde7ade7e@linaro.org>
Date: Mon, 29 Dec 2025 23:44:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] target/hppa: add 64 bit support to gdbstub
To: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org
References: <20251113044857.67290-1-svens@stackframe.org>
 <20251113044857.67290-2-svens@stackframe.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251113044857.67290-2-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 13/11/25 05:48, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/gdbstub.c | 62 ++++++++++++++++++++++++++++---------------
>   1 file changed, 41 insertions(+), 21 deletions(-)
> 
> diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
> index 0daa52f7af..777f4a48b9 100644
> --- a/target/hppa/gdbstub.c
> +++ b/target/hppa/gdbstub.c
> @@ -21,16 +21,25 @@
>   #include "cpu.h"
>   #include "gdbstub/helpers.h"
>   
> -/*
> - * GDB 15 only supports PA1.0 via the remote protocol, and ignores
> - * any provided xml.  Which means that any attempt to provide more
> - * data results in "Remote 'g' packet reply is too long".
> - */
> +static int hppa_num_regs(CPUHPPAState *env)
> +{
> +    return hppa_is_pa20(env) ? 96 : 128;
> +}
> +
> +static int hppa_reg_size(CPUHPPAState *env)
> +{
> +    return hppa_is_pa20(env) ? 8 : 4;
> +}
>   
>   int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>   {
> -    CPUHPPAState *env = cpu_env(cs);
> -    uint32_t val;
> +    HPPACPU *cpu = HPPA_CPU(cs);

'cpu' variable is not used, why introduce it?

> +    CPUHPPAState *env = &cpu->env;
> +    target_ulong val;
> +
> +    if (n >= hppa_num_regs(env)) {
> +        return 0;
> +    }
>   
>       switch (n) {
>       case 0:
> @@ -133,24 +142,35 @@ int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>           val = env->cr[30];
>           break;
>       case 64 ... 127:
> -        val = extract64(env->fr[(n - 64) / 2], (n & 1 ? 0 : 32), 32);
> -        break;
> -    default:
> -        if (n < 128) {
> -            val = 0;
> +        if (hppa_is_pa20(env)) {
> +            val = env->fr[n - 64];
>           } else {
> -            return 0;
> +            val = extract64(env->fr[(n - 64) / 2], (n & 1 ? 0 : 32), 32);
>           }
>           break;
> +    default:
> +        val = 0;
> +        break;
>       }
>   
> -    return gdb_get_reg32(mem_buf, val);
> +    if (hppa_is_pa20(env)) {
> +        return gdb_get_reg64(mem_buf, val);
> +    } else {
> +        return gdb_get_reg32(mem_buf, val);
> +    }
>   }
>   
>   int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>   {
> -    CPUHPPAState *env = cpu_env(cs);
> -    uint32_t val = ldl_p(mem_buf);
> +    HPPACPU *cpu = HPPA_CPU(cs);

Ditto.

> +    CPUHPPAState *env = &cpu->env;
> +    target_ulong val;
> +
> +    if (n >= hppa_num_regs(env)) {
> +        return 0;
> +    }
> +
> +    val = ldn_p(mem_buf, hppa_reg_size(env));
>   
>       switch (n) {
>       case 0:
> @@ -267,16 +287,16 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>           cpu_hppa_loaded_fr0(env);
>           break;
>       case 65 ... 127:
> -        {
> +        if (hppa_is_pa20(env)) {
> +            env->fr[n - 64] = val;
> +        } else {
>               uint64_t *fr = &env->fr[(n - 64) / 2];
>               *fr = deposit64(*fr, (n & 1 ? 0 : 32), 32, val);
>           }
>           break;
>       default:
> -        if (n >= 128) {
> -            return 0;
> -        }
>           break;
>       }
> -    return 4;
> +
> +    return hppa_reg_size(env);
>   }


