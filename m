Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EB4CF885B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 20:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swpK0-0005QV-23; Fri, 04 Oct 2024 16:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swpJy-0005QE-Gh
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:54:42 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swpJw-0002HF-Qi
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 16:54:42 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7e6afa8baeaso2142043a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 13:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728075278; x=1728680078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uNb2A1NLvz+pzd6UIzkrPUgzZKo8Vy7ahTWvR/TosNo=;
 b=QO4r3XE5RjNhIOZUtbruq8o7hZ2qHYCVlBs4uMHEOmrsO6An05d5eynfDTHL8cO6eY
 2NRHkkdk2/kL9pOwryODBc2+9F+JhEHklzMgwy2ccjHIaIpmSOcS4a00y9XwIoNhVK3e
 1GqqNhkVlcLUD4jZRva4j8Pi48TbDztLoPqURPSw/yBg6UQTVe3U516XiKI9u6g/vM/R
 doc+9/mm/nlSUjZj5G+wZpUa14SPe355xs5cgNovARNxp3B5e0taq6N3IyNIyQKlJuEM
 DlSHkIWHD87vdXsf8H8M8ZWnuJYL5puhewL1TYj0Ef39eDyhc6ofaOOVERKdloHoq0sj
 u5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728075278; x=1728680078;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uNb2A1NLvz+pzd6UIzkrPUgzZKo8Vy7ahTWvR/TosNo=;
 b=KC6ili2l5WeJQbWjFKkUAKF5IPz/pNzb7gvWXr2zx8EGA5C9rIE3C/CYzOstKoStqI
 QKuEhHyajmrwWVmSl5O1R1xJfz49tlxMyxoHwOH+XaFGjIuHnSINqxrskcD1TAAYcZnK
 5uGBGrF9B+icpb4+Bp1AwHxVWXh95SzC+YqSSwM1opAUHv8XCR6/tt9XxMHZhaL65QtB
 fj6cDjul/EJ2vJIltbTQrnlJS88s+v7Yh2WDXhDM25MlqSg1aNkQbC9gqfBwihubMdqP
 RtwZupSyaImUimDUyLsUUMMqtAnE5hmd7aapUD8ZprXII1QSKTsSY7Y8tABaR+8xuR9X
 zTiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX3I53aT0UJd0vjXHg1LvNpYqXSHtYG784X1HukNaGqN/MGOwEvGw+m71vbV10qWr+Ftf+InKm2no3@nongnu.org
X-Gm-Message-State: AOJu0YxnDQVLI19HPelGIcVAGQVYjOmWW3swnSoymkaoVEy3TVp7W/VE
 xyQ35dbOLzYJ7PaukX9Ks9JHf6Ca4+Wj8n6KVTxjTr2XseCLOCXBlGBUCLhYzro=
X-Google-Smtp-Source: AGHT+IE5rbOMNji/gtNrMgkXiPNHiFSP240sbq0Y3TvWI031SQZHS8OI7hbP3MDgh157vjgyuABVEA==
X-Received: by 2002:a17:90b:17c4:b0:2e0:9d3e:bc2a with SMTP id
 98e67ed59e1d1-2e1e636f96fmr4655735a91.32.1728075278480; 
 Fri, 04 Oct 2024 13:54:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e85d9ab8sm2117423a91.29.2024.10.04.13.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 13:54:38 -0700 (PDT)
Message-ID: <9b8c4a39-57c3-4143-b5c5-0abb271abbd1@linaro.org>
Date: Fri, 4 Oct 2024 13:54:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/mips: Use tcg_constant_tl() instead of
 tcg_gen_movi_tl()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
References: <20241004202621.4321-1-philmd@linaro.org>
 <20241004202621.4321-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004202621.4321-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 10/4/24 13:26, Philippe Mathieu-Daudé wrote:
> @@ -11428,17 +11415,12 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
>   void gen_addiupc(DisasContext *ctx, int rx, int imm,
>                    int is_64_bit, int extended)
>   {
> -    TCGv t0;
> -
>       if (extended && (ctx->hflags & MIPS_HFLAG_BMASK)) {
>           gen_reserved_instruction(ctx);
>           return;
>       }
>   
> -    t0 = tcg_temp_new();
> -
> -    tcg_gen_movi_tl(t0, pc_relative_pc(ctx));
> -    tcg_gen_addi_tl(cpu_gpr[rx], t0, imm);
> +    tcg_gen_addi_tl(cpu_gpr[rx], tcg_constant_tl(pc_relative_pc(ctx)), imm);
>       if (!is_64_bit) {
>           tcg_gen_ext32s_tl(cpu_gpr[rx], cpu_gpr[rx]);
>       }

Oh dear.  All of this can be computed during translate.

     target_ulong val = pc_relative_pc(ctx) + imm;
     if (!is_64_bit) {
         val = (int32_t)val;
     }
     tcg_gen_movi_tl(cpu_gpr[rx], val);


> diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
> index 171508f7deb..d044592f83e 100644
> --- a/target/mips/tcg/micromips_translate.c.inc
> +++ b/target/mips/tcg/micromips_translate.c.inc
> @@ -980,8 +980,7 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
>           tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
>                              ctx->default_tcg_memop_mask);
>           gen_store_gpr(t1, rd);
> -        tcg_gen_movi_tl(t1, 4);
> -        gen_op_addr_add(ctx, t0, t0, t1);
> +        gen_op_addr_add(ctx, t0, t0, tcg_constant_tl(4));

It might be useful to add a gen_op_addr_addi() helper.

Anyway, it's all an incremental improvement so,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

