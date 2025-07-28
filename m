Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97696C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 17:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugRRZ-0003mP-S4; Mon, 28 Jul 2025 13:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugRRT-0003lQ-TE
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 13:15:15 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugRRR-0004Ie-SV
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 13:15:15 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so5084458b3a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 10:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753722911; x=1754327711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2uha6uA1VfFX0hsoKzeGpL8PlfaiJhcXbP8G9jjO8p8=;
 b=qVRbwOPoH64AKBUVJM8HoPbGnSMpaDbylYv8eb7NgcPEYrUV8AYmqjI9uiQa+qjmEw
 SH/JvDR3IJpXbQSXFxhZXM+/EIfYkUElHtK464di7VQDxCEqNq1X8StS4byN6sxslCVa
 zWwT0tje+GyrOcpdyk+lhNhZ1Ev7A8nSjg8GqMBmc+fa3IdQ88jzyyX3+Fxvq08ui9XQ
 7vKH6cesdL6DOAxQOTDjnT6DjXI3tLzEoc9yZtn+e89eZPPqqNEiRFIzonkk7QYWTzF/
 j5Ni6OcK1dFXnx5XIvYqSwXegtTUCG4i37KDE4cwpaGp4e+IgUFwME2dtbx7vDL8UWvF
 oXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753722911; x=1754327711;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2uha6uA1VfFX0hsoKzeGpL8PlfaiJhcXbP8G9jjO8p8=;
 b=CsXf6kqs2cfFv+IxrI6bTgZtHCpJE5MM8BSJar2pJt6ywKu+Lqtaef7Qpz3E29toCo
 r1gKttEu9vjwFp36b1mT2PhTFZd3IE4N03J2YSGGoV+PPjBVXYQPHRjoxS2ox7WlG578
 wUycTWQSHXySg/PKPX6alu2VC3uIgLITrkcYvwZlqnveyGbM8OCxbBhjdNeJE0t+GjWT
 NqC4XQp3juPQmbpEVR69Nv52JPwa0kNSKwsyDwPMdl2OGDUlnxK2WjY5syFVFCdhlRYg
 XLSB9XH//Nq+zrGok3boha9sFlLy/QsJB8IyovwYFbh5uUccLbM1tI2/bVPuDr2yeYOW
 BZ4w==
X-Gm-Message-State: AOJu0YwRLWLok37aYHiz+w2rETj3RfZEWk/ZajSnnKvX5dCq187BpWzx
 Z+Rx44QjfUelyvlVkaA292GJmepIyPPCj2tbgFOVVnReVCWxAWgs0MEkDC3Vedrjzvj6zgEB+Gz
 TpbT7
X-Gm-Gg: ASbGncvfcl3BbLyNjNdvr9u/F0nVTMAHfLLlJK4RWIN2IntLduveL7VaORD7CcAFKyS
 NM1dcHc2g1/YQiz6xxRpSGW94cAk7R9zSwXlu3cNKJAZUebDjayWZgiKJ5YYv2NnZtRqmnoaVOX
 oqE+Ztiea2g1h5wHNMRwojxkUB+7iyUPpc+TVp9E65jgmaJ/QoTXUzvNAgmL6ebgL5582f4gXF6
 tIkSRoiBQv01spfVZvkxZZi6It48YmWTqU+ytWmNvDoNShvfygPHfJEYwLUrlLBTTeDeIhFLOcQ
 7el9MzNyZK3ZPVik4kVlG/vW4g8r/9g4H6MTWwDTxq+5q89bL4a3Vglmh1DnTx54BaAMtlSsbMC
 PUzbgMe/uSOMTxD0QMMX7QY0V7Thwv8XRVbk6Kran0wnJzW9a0CwxY13AlSr6wVMMf1W87yRBIe
 LuTA==
X-Google-Smtp-Source: AGHT+IEdwSJDGELCwmwheQZfVP0LEIAqagMPv9DOk8wOr0+mBA87UIVWSjwP7joLixUR+6QKNxxyZA==
X-Received: by 2002:a05:6a00:3e01:b0:754:7376:548f with SMTP id
 d2e1a72fcca58-76337de94ebmr18800333b3a.23.1753722911354; 
 Mon, 28 Jul 2025 10:15:11 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640b2ddf63sm5486929b3a.102.2025.07.28.10.15.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 10:15:10 -0700 (PDT)
Message-ID: <98f76923-af51-4fa3-b284-26cbce59a3b2@linaro.org>
Date: Mon, 28 Jul 2025 07:15:06 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/strace.list: add riscv_hwprobe entry
To: qemu-devel@nongnu.org
References: <20250728170633.113384-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250728170633.113384-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 7/28/25 07:06, Daniel Henrique Barboza wrote:
> We're missing a strace entry for riscv_hwprobe, and using -strace will
> report it as "Unknown syscall 258".
> 
> After this patch we'll have:
> 
> $ ./build/qemu-riscv64 -strace test_mutex_riscv
> 110182 riscv_hwprobe(0x7f207efdc700,1,0,0,0,0) = 0
> 110182 brk(NULL) = 0x0000000000082000
> (...)
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   linux-user/strace.list | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index fdf94ef32a..ab818352a9 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -1716,3 +1716,6 @@
>   { TARGET_NR_clock_gettime64, "clock_gettime64" , NULL, print_clock_gettime64,
>                              print_syscall_ret_clock_gettime64 },
>   #endif
> +#ifdef TARGET_NR_riscv_hwprobe
> +{ TARGET_NR_riscv_hwprobe, "riscv_hwprobe" , "%s(%p,%d,%d,%d,%d,%d)", NULL, NULL },
> +#endif

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

