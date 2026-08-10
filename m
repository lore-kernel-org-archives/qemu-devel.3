Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4294C5AE49
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtR1c-00067h-C0; Mon, 10 Aug 2026 10:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtR1Z-000677-EE
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:30:45 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtR1X-0004OS-L3
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 10:30:44 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cab973140bso29246705ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 07:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786372242; x=1786977042; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rZiBbaCDQS+TEHVJclHtwMQcR6FJqiRwTzrJuv7JBHw=;
 b=Q5jJnPWHU9G7l/kLuNcP865WNbChVvATcpgfId7yX7FP/c737PpFJCRUOFc7XzpSM6
 TsGiWsMPbpQnXSGTo3Wbio1AksGd+c8zY4HLZUO5lRU61gQpEtNXSjolj7owlcoDJ6yy
 jl41Lk8Ymp/jReuu8x5HGXDyYReb1vVCmn7uY9iKrM76ZNEoK/3n46sO5+pYVGzJjmSU
 BEvYnxSKVuPmkEqPEpyf5VSLDRfDuBGg4Y+nCANxKlhCuQLp6PZdk5BROZZ/pWnIisdL
 PMZKtm+ojaiLT4xZ+/zuaZN34FaxGrpStA+OVy5/VIufBQF9it36e3DSnDRZMWa9Somb
 MUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786372242; x=1786977042;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rZiBbaCDQS+TEHVJclHtwMQcR6FJqiRwTzrJuv7JBHw=;
 b=BTmXhdCpD4+1+zKt6QNZPWdhW6PA2FyJe1LQ82hedz/cNwacbOIu/8Im8nIWmzoRap
 3YYhS5pIzy56XPmVpja05bRwDZmCKoJ6kZXkRhL9ZV7qTpf0qhnQ8YXcfowprwq+PKtL
 T4eK68hOCQfZbT9fVeEDkBYDJLyypRf/XunsIffR2yG+nPT6wmHTFCikSG+74mYAYzc/
 ewBQOTmI4udCo1YwJSadYihBfgmLnYLSsMV5bRPEYA3ZPAOpwTx7WPtL+y8DraODCbAo
 fzatWGMm1dLLf5Y/XKCLwCdyUyGPZRHC0gXrwS+7BbiFp6X0Aq244gBEDlUwIFatTLuS
 Z2+Q==
X-Gm-Message-State: AOJu0YyklmO+Rjn4BmDKQJuHI6q7C6u7Po6fxGDg4fJY6W0/pl6+COha
 xdo76/8wwwp2incjN+DdFpjeLPPuNI9AGsrPfubFHLEpirttYqHBKCLN9klW2smkgtxR2XxcOoZ
 iqQK9
X-Gm-Gg: AR+sD11qG/xXMEsQn9WW/YZho2pnwgos71imY2DVSGmwIq09iSZ/MXFBFTLVKQblFsk
 pTQ1mOJA33+Gu6CmVBVrW/DVJ1s+0Mhn2qMxJ17g9pLiQ3yrbiPKssA0oMipx34fW+vCZ3OxA2n
 4jDVSRhIQ7TCDm+pY3QwW2RXX2zQiZt6UVevOIwO6Er7QPef3lfDdtIFrzL7JRY+JMGQw9VGwyQ
 mu+1YuCGtOjLbYgVIcAIZuitEKhyAt/6VW9aQCGG6X0SsA9rArFpVhwIlhMg1T68xbwleB6+uHG
 nDJZzcNljcfIz4dgXVig3uoX3vOFo3c++Ui4HO0ekGrqjuqXfROMFXLmrJfmm2UkENFFFE1t/BK
 FtLn7ZPqvZVIlT4gdSZeP561ZNNVvz4UPIxG3fF90PU0zSjJwLalHNxTCDi4s6wSOv1hs99Uj3y
 YVc5pRhwro+c877qlS0siX9lxQ87hWp3Ud/ueKDa94NVhUcoTePiZTz/+LC6uVaPCnmhlzJbLpd
 1blpumseq0CHkivzeKINLHSS1Lc
X-Received: by 2002:a17:902:f70f:b0:2cc:a977:4260 with SMTP id
 d9443c01a7336-2d2a8fb8adcmr259444645ad.21.1786372241672; 
 Mon, 10 Aug 2026 07:30:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14ccae01csm37815525ad.4.2026.08.10.07.30.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 07:30:40 -0700 (PDT)
Message-ID: <bacc7f30-49bc-4227-ab7b-77e401563412@linaro.org>
Date: Mon, 10 Aug 2026 07:30:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/gdbstub.c: use misa_mxl_max for GPR write
 width
To: qemu-devel@nongnu.org
References: <20260808121511.18088-1-heavenlydev01@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260808121511.18088-1-heavenlydev01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/8/26 05:15, heavenlydev wrote:
> From: Enrique Abma Romero <heavenlydev01@gmail.com>
> 
> riscv_cpu_gdb_write_register() decides whether to sign-truncate an
> incoming GPR value to 32 bits based on env->xl, the hart current XLEN.
> This is asymmetric with the rest of the gdbstub: both the read path
> (riscv_cpu_gdb_read_register) and the target description size registers
> off misa_mxl_max, the maximum XLEN. GDB therefore always exchanges
> 8-byte register fields for an RV64-max hart, but a write is truncated to
> its low 32 bits whenever the hart happens to be executing in an RV32
> privilege context (env->xl == MXL_RV32, e.g. S/U-mode with SXL/UXL
> narrowed to 32). The upper 32 bits are silently dropped, so a debugger
> cannot set the full 64-bit architectural register even though the CPU
> state and the read path are 64-bit.
> 
> Key the write width off misa_mxl_max, matching the read path and the
> advertised register size, so a full-width write is honored regardless of
> the hart current privilege XLEN.
> 
> Signed-off-by: Enrique Abma Romero <heavenlydev01@gmail.com>
> ---
>   target/riscv/gdbstub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 9abbf5b..9284579 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -89,7 +89,7 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>       const size_t regsize = mcc->def->misa_mxl_max == MXL_RV32 ? 4 : 8;
>       uint64_t tmp = ldn(env, mem_buf, regsize);
>   
> -    if (env->xl < MXL_RV64) {
> +    if (mcc->def->misa_mxl_max < MXL_RV64) {
>           tmp = (int32_t)tmp;
>       }
>   

A 64-bit machine in 32-bit bit mode has all registers sign extended -- it's part of the 
specification.  We enforce this during execution here:

static void gen_set_gpr(DisasContext *ctx, int reg_num, TCGv t)
{
     if (reg_num != 0) {
         switch (get_ol(ctx)) {
         case MXL_RV32:
             tcg_gen_ext32s_tl(cpu_gpr[reg_num], t);
             break;

The debugger shouldn't be able to break this.


r~

