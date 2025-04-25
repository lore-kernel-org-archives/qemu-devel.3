Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEBAC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R9l-0000dU-7e; Fri, 25 Apr 2025 18:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8R7z-0006DN-QK
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:36 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8R7x-0001RF-KY
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:35 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so2430623b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745618552; x=1746223352; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=axez90JHWERTG5QTyuIzr6EezXEXtdJEqVd26XET/xU=;
 b=bJD5DQMr5WVxh9Bu94NZw5vSb4WczJg/OFWMpqj36opfh0323oPstxddQk0sqna1q0
 Hd4bYfAdf+m1ktqrA4z+jP4CFsG7JdEFvGai7Ne2Ga9R4mHtE5kxFuuN8kg4eR4YzJUI
 nQ/9y1cX4CYoBLpFLeV1psVWIYhX9W/X9ktAxMNQ23WCTpxZgVagM7SyQob13EQ3gapg
 HlZe/H4jd5GFszEQoJlNZxdA4+TMBKO0trIUD+EgfbmAXbPzkHr8ZoqkXfbxhVRAk8aR
 oN/pyQJr2JzHsbvFtsSesCrtm7wV9bSDxTxLaOLA5BnSy9RWnyqKJO8jaCkt6zrdK4nR
 S8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618552; x=1746223352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=axez90JHWERTG5QTyuIzr6EezXEXtdJEqVd26XET/xU=;
 b=qhjgnh1tqN1Jp34F25dIE2GUuCZ//ChSKKUKuxMJZRCFjn0re3rDLqbfsDaE9HvH0C
 vIiBk9ywV1hM5b6qgt9ch3KdkoobFjqJYiNz4aCKVtGD69mSrMcG2bnqoz0f9nToKVih
 IakIacg7F9Xn2o65nyEQIFHMebOTGvkL0juIEOzpeZzVW8StARRV21QDbb7DZZmTcd1U
 0IiZjCy6+1SnfAtOuJYVtsajVQhoNPQocdyoRXkrbPnBRsc8Mqm01Ic3BFsOuUT46qQI
 8wnWpCOWtEiizBNi+fFGjP1oKY2CFNX/iEXdaDLR/1rYIinNNz0swVJjypWi2YJPJnMg
 9IRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnstn0y8EJdkzbWr1FQuIellh9kOxiQaHu3Dc+1fWDzXPtZ+mg+Pgdp3gVnbKJSZV5OqnGqMuq+2bA@nongnu.org
X-Gm-Message-State: AOJu0YyNG8Z6MNVlKGiMgUrdj9Q9lSfec7WYEeh3yqFO901YSnY0VGu+
 D882/U8Q9W929DC3j7i9TILhyqQxMQrM+t0PW+372IEKjQjazHfkukhsvEfOeu32qy8cSxwukN0
 r
X-Gm-Gg: ASbGncvIrXEcn52JEbdeGxDe98Vc021f1rvnmg9SFEKyDoa2v414Y0Pnv/Lit/xAV+B
 jkQGGrRcbWpwyBO5AApGTxpzpRXtSyG/z2XoLi3F/1QYi3zg4+ynVyZvUnQrOdugJzG1BZI+q+w
 GqU4PTktR+Ifjiw7usyRk+5Cf5cKO7hxNiV7bodbuW6f9GlH8de6x5R3z8i8SSifQxlh6NZqpuR
 /X0bgbznikWUufIbyKerlBS6ZOnKWjwRrqQO5Ki6pyauN8Je5fH6hf9+SfnLjCc8jbp58RV1zPe
 jDUymizuulYr7BF78KyhgGBcH3U1U4nP1ZQ0NpJsCGOKgqinRKhoX+tGXJF4RvJecg==
X-Google-Smtp-Source: AGHT+IHKaNShR2wnFVQclSPv5yDMKKNgRbAykYIPQrHuL4CmEKcox8ETr6vQCniGOWEyk2IM+BsAaQ==
X-Received: by 2002:a05:6a00:4644:b0:73d:fefb:325 with SMTP id
 d2e1a72fcca58-73fd6af5a42mr4928354b3a.5.1745618551617; 
 Fri, 25 Apr 2025 15:02:31 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25941387sm3683725b3a.70.2025.04.25.15.02.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 15:02:31 -0700 (PDT)
Message-ID: <451616c2-5594-4d12-82ea-63ef7bbecd22@ventanamicro.com>
Date: Fri, 25 Apr 2025 19:02:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH alternate 1/2] target/riscv: Update pc before csrw, csrrw
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com
References: <20250425165055.807801-1-richard.henderson@linaro.org>
 <20250425165055.807801-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250425165055.807801-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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



On 4/25/25 1:50 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rvi.c.inc | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
> index b9c7160468..a367fecf7e 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -992,6 +992,7 @@ static bool do_csrw(DisasContext *ctx, int rc, TCGv src)
>       TCGv_i32 csr = tcg_constant_i32(rc);
>   
>       translator_io_start(&ctx->base);
> +    gen_update_pc(ctx, 0);
>       gen_helper_csrw(tcg_env, csr, src);
>       return do_csr_post(ctx);
>   }
> @@ -1002,6 +1003,7 @@ static bool do_csrrw(DisasContext *ctx, int rd, int rc, TCGv src, TCGv mask)
>       TCGv_i32 csr = tcg_constant_i32(rc);
>   
>       translator_io_start(&ctx->base);
> +    gen_update_pc(ctx, 0);
>       gen_helper_csrrw(dest, tcg_env, csr, src, mask);
>       gen_set_gpr(ctx, rd, dest);
>       return do_csr_post(ctx);
> @@ -1025,6 +1027,7 @@ static bool do_csrw_i128(DisasContext *ctx, int rc, TCGv srcl, TCGv srch)
>       TCGv_i32 csr = tcg_constant_i32(rc);
>   
>       translator_io_start(&ctx->base);
> +    gen_update_pc(ctx, 0);
>       gen_helper_csrw_i128(tcg_env, csr, srcl, srch);
>       return do_csr_post(ctx);
>   }
> @@ -1037,6 +1040,7 @@ static bool do_csrrw_i128(DisasContext *ctx, int rd, int rc,
>       TCGv_i32 csr = tcg_constant_i32(rc);
>   
>       translator_io_start(&ctx->base);
> +    gen_update_pc(ctx, 0);
>       gen_helper_csrrw_i128(destl, tcg_env, csr, srcl, srch, maskl, maskh);
>       tcg_gen_ld_tl(desth, tcg_env, offsetof(CPURISCVState, retxh));
>       gen_set_gpr128(ctx, rd, destl, desth);


