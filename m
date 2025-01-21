Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BEEC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 17:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taIEq-0005xo-G3; Tue, 21 Jan 2025 12:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taIEn-0005s1-Iz
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:40:29 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taIEl-0003Fc-SH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:40:29 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so41872945e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 09:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737481226; x=1738086026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0BYxFronY7Uple2vqBBHRK1EBFohH/hoFiEwcXYXDTQ=;
 b=RuEXOVtCjnZs61UuqE7HQ4QwNtpfStrfk9Jbch0QLFFjxwGKFAyJptvgpxzewmXRvY
 0svyDadGtULPSWg1JrH7K/Ox8mCwKhPcNZf79SoHmlo4QzkH9aynusT7dCQVebHLroka
 jZ7ZXwYdjf6BpfAR4nQwjM55jsDEouddMOG52P+i7n9pCLIR6cdYnvliZpaxWilVW3gu
 xqqgTmMEKhblobHS0Ofr4w3dlDSaiOc0dHSOctFe86fJuKoAHwtDCOj11q+D0cmMwOEG
 DfYpvmXtuQAm6/eiRM9hPpYDfjth1sxL4B+VqwksDB7SJ677tAy0TH6vakMaBam1BXVs
 cuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737481226; x=1738086026;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0BYxFronY7Uple2vqBBHRK1EBFohH/hoFiEwcXYXDTQ=;
 b=P2Vfu+X4bI0Eynmagm/WssKnJn5kvJzjCAUymiQTe8nagwSoxkqijvJH3BlU7HKPkX
 vyLcyY7ExRFe0lnu/Tn74tv84hdp/UMQgBT2LdUGImuWaPVbW6o9iEYKtF/ri/zRIPhY
 JfOSt6J1XtYbjOLvLSSYui0jexNbw4pfHmRYPFecnKcTS9C7kv24Xm+uXrLtAlMwt4O+
 fHveFTJMQESwndd44gVsPLcUOll99zPTZGk+vDAaJs5mWoghM7ZFTCoYOyTkgTNlsTzE
 eY5JZRuV6ALkKVap58iiv+KW1OgaXN4PYUoRxUpjjNpK/Jb5smcs/803a7QdUxD1zjfj
 3mhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZZZwAvo0DBUgXPwAsyXx54BVukhBthw1TQe0M2VNolA/gULOSbRfnNmptLbQl+Myb021urW/HEBOz@nongnu.org
X-Gm-Message-State: AOJu0Yw18P6urU852T1vFVlU2wfYOxh2S/uxwlHpyQHtHW/IqmimMhje
 zqXt0YtRLpeN6OFsdfB1Le3RPOKiKuyEHTWbsvvpjWaw0R0ph8dkT0MsfRclz6U=
X-Gm-Gg: ASbGnctH4y1FUO3zme224Sf2WzRYyv8dS/UiZ58iMlofOstBdsJTfG87ZW1v+rxtFfT
 ptSztKVt5jduQu3GL4MKvmbF+QLTMP5w24eZdXc5/1/na++slZ3xko0fuHbhOIvg9dFtyBVmqV/
 DuhcwRlaA+756jPrtUSw3WKaQ9fEocksKjHlxy4E49jef3yLs+XK3D0TzG0xsuXs1MlP6r3Arfo
 D6ut6V7Wjtikete8Pz6Ur0wKAHHVDFPTbwaxHRu9TF3pfKYaYdFPlDGs5iEa2NjpBc19OchRtKw
 CZMSUuYvlNCrfuhe6bGbiKQ0OGRWzrejLVgIkQ==
X-Google-Smtp-Source: AGHT+IEqTmqbVjBrPTETkvHAZRrbq2Fd4Nw6JedK+1CwXRnQ9CiEDlDAHUMdsIkFR9OXYNyktMu1AQ==
X-Received: by 2002:a05:600c:1e02:b0:438:ad4d:cf09 with SMTP id
 5b1f17b1804b1-438ad4dd134mr54411245e9.9.1737481226275; 
 Tue, 21 Jan 2025 09:40:26 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890462195sm185677075e9.30.2025.01.21.09.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 09:40:25 -0800 (PST)
Message-ID: <9b2114bb-ed61-42bc-a5fe-f28a6a5319dc@linaro.org>
Date: Tue, 21 Jan 2025 18:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/riscv/debug.c: use wp size = 4 for 32-bit
 CPUs
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org
References: <20250120204910.1317013-1-dbarboza@ventanamicro.com>
 <20250120204910.1317013-2-dbarboza@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250120204910.1317013-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 20/1/25 21:49, Daniel Henrique Barboza wrote:
> The mcontrol select bit (19) is always zero, meaning our triggers will
> always match virtual addresses. In this condition, if the user does not
> specify a size for the trigger, the access size defaults to XLEN.
> 
> At this moment we're using def_size = 8 regardless of CPU XLEN. Use
> def_size = 4 in case we're running 32 bits.
> 
> Fixes: 95799e36c1 ("target/riscv: Add initial support for the Sdtrig extension")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/debug.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index f6241a80be..9db4048523 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -478,7 +478,7 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
>       bool enabled = type2_breakpoint_enabled(ctrl);
>       CPUState *cs = env_cpu(env);
>       int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
> -    uint32_t size;
> +    uint32_t size, def_size;
>   
>       if (!enabled) {
>           return;
> @@ -501,7 +501,9 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
>               cpu_watchpoint_insert(cs, addr, size, flags,
>                                     &env->cpu_watchpoint[index]);
>           } else {
> -            cpu_watchpoint_insert(cs, addr, 8, flags,
> +            def_size = riscv_cpu_mxl(env) == MXL_RV64 ? 8 : 4;

riscv_cpu_mxl() seems bugprone w.r.t. MXL_RV128, better could be
some riscv_cpu_mxl_wordsize() helper like riscv_cpu_mxl_bits()
(or better named).

Anyway this pattern is already all over, so meanwhile:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +
> +            cpu_watchpoint_insert(cs, addr, def_size, flags,
>                                     &env->cpu_watchpoint[index]);
>           }
>       }


