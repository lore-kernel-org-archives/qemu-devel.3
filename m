Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A72CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 07:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ4x0-0008FT-Ot; Wed, 12 Nov 2025 02:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ4wy-0008Eb-NU
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:07:28 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJ4ww-0004T6-OG
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:07:28 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47758595eecso2201355e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 23:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762931245; x=1763536045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3ZHUhyxlTqIrmpRfSH2rmBuKi5JiPWXboCziGiH3ma0=;
 b=UZAaO0hUOGgmwarbHAgk4dIUuvEU2RO8FRfV0xE3eiPPjpXo1q2AM3MSGEYNLVHKlV
 rxyKlAKmFg0d3oTsCoG+BDfRskk+6IW+fvbJkF7leDIhGiyyXTQjrTntxyMQafevI29b
 WcBPvjf3RoVI6HQYXP1Vv/nKO82tu1zaotpHYuceySbjz8L16l2ZwAvMh5j7JoOv0jKE
 rEbzJmC9/ckSoBNZwuYrNvluypAWOXeGcsU7WiDz3/YKnec0xVLIOK2C7dXJzM6wdRW4
 tUFde4oDEHke0yB3Pb6zbqI5CT1oKp8V6aaKc4/2REYyGfCBFaPbUtJ3M6X98VjWdbWq
 vbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762931245; x=1763536045;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3ZHUhyxlTqIrmpRfSH2rmBuKi5JiPWXboCziGiH3ma0=;
 b=kXGWpoOqKJ/OsCMYarPRjLK+GhtTT1v16p/lR4avdteHLofCxslcG8frTdPVt3V2TR
 HFrV9qbcV8KfS/RF7riR+4qrn/j3eBF6DnJIhhNjoT8eDPDq9+33FRkBpZCcr8Yeg2RK
 iy+XJGoNHpOZGoFsMaUifvzD+coShVa7vFTsRJy1VaEc4afoQvwgjYflaBlesF5z9X+s
 xQ8e1m23SfVzRPit4TeuOJo09rlHb04lInIX1dVeUAplKOQASIJKuJinQ1+dD5EnqyNK
 jd26Eb00vF6jRBFQocqUrR2puYHONDsNeGml+HFK7tgxzJyod5NMM2c49KST3QP96EDV
 1ilQ==
X-Gm-Message-State: AOJu0Yw9zUXRFDwEpdD25nZxLrJ0xm90zyq/bZ36FPyEVCztxiAPe7vw
 GX3xqxuGXSUOJg5feOL+ZWCK3YfHN5auGLcFG93XcXo2c52YXh14vuet0RB8wZds+YBJDu8Og1q
 Mm+AZLINYGA==
X-Gm-Gg: ASbGncvm8UUf0BNm2iQGKdslGK5ZBlN8dUb1TbTeSQKeoknlk/PMg2M7eLS7WxbkYKu
 11eOz2RuSe4z8T8tOgnCwaRIBYp9NG4V0MmT5tl1UkT1vmC130wSvjJDhVSroXBGcOs8NHAlv8P
 hVuHBwznpYuIhlAzPV96RV6/6nYeOUIcBH7oDFmXlWmlAeB9ZI/4aUk6412iYvcico2vcNHiZ/9
 TFcEjbuaLR1gAAaAEaXMpGlzcpcgh7G7JvaZ0XPacfjjqWmNFJ29gwMSOxhltgdSfA14ErG9k7p
 9PzNcvgfQIu1oiIhowEhk1tOcIj+or1Z7gWtYr9eUEGFd5mpYwNaGVCIxPvqPDDQukLJJzKipNQ
 /ue3DEhpIuPMwBmWeITjg7oillcTImSG7oFqkxLssujsFMf2jjkdlEfchoajPx46q4RHs+pxbWC
 JoaIZV9tQe/uy/9j2U7Tuc6+TR0yz2k65X+Uq6xJCfEh/m3iKI
X-Google-Smtp-Source: AGHT+IF+Gf6K/t4OuINIQBE+4bW9k9sLE/9A6+5RGyTphRUhrBZvjZRyyNMZ34IJzWTc9edvQ4Lmdw==
X-Received: by 2002:a05:600c:19ca:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-477870cd9ecmr15195175e9.37.1762931245015; 
 Tue, 11 Nov 2025 23:07:25 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787ea39ccsm18712425e9.15.2025.11.11.23.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 23:07:23 -0800 (PST)
Message-ID: <41f24ea4-787f-4e79-bff2-5ae66c4c2a6e@linaro.org>
Date: Wed, 12 Nov 2025 08:07:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/hppa: add 64 bit support to gdbstub
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org
References: <20251110222646.180265-1-svens@stackframe.org>
 <20251110222646.180265-2-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110222646.180265-2-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Sven!

On 10/11/25 23:26, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   target/hppa/gdbstub.c | 66 +++++++++++++++++++++++++++++--------------
>   1 file changed, 45 insertions(+), 21 deletions(-)


> +static int hppa_reg_size(CPUHPPAState *env)
> +{
> +    return hppa_is_pa20(env) ? 8 : 4;
> +}

>   int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>   {
> -    CPUHPPAState *env = cpu_env(cs);
> -    uint32_t val = ldl_p(mem_buf);
> +    HPPACPU *cpu = HPPA_CPU(cs);
> +    CPUHPPAState *env = &cpu->env;
> +    target_ulong val;
> +
> +    if (n >= hppa_num_regs(env)) {
> +        return 0;
> +    }
> +
> +    if (hppa_is_pa20(env)) {
> +        val = ldq_p(mem_buf);
> +    } else {
> +        val = ldl_p(mem_buf);
> +    }

Alternatively:

        val = ldn_p(mem_buf, hppa_reg_size(env));

>   
>       switch (n) {
>       case 0:
> @@ -267,16 +291,16 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


