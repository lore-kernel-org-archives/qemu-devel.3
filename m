Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A62CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tzh-0001FU-9C; Thu, 09 Oct 2025 12:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tze-00019i-4o
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:59:54 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tzT-0007Ch-IO
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:59:53 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-782bfd0a977so1062425b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760029175; x=1760633975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IOMvX89C87BGan/FtKadeDU9ynTlUn919FXI9/VqyMc=;
 b=D0Zf3DCywXd4KP1iRiECAgr+d6Xk7M3z/Tj23ljrzBK9GYcmCPigKoft0TBUXvThBk
 BIBgwzgfaVyq2qTNbd2yNb50bl5u4Kcv54jGORYm9c8UbYS0mlpcULGwVwrIdXjOHujl
 TAefHOlbtmnZlxd+/ZQoe8mKNudjTW18Rxh+2kBxE3OuCZa5yTTn5Y6E/VU+CbGszmee
 Td1eQ31UnOVu6J4XtdlRdu7G8Z73bhJSORg+egFzWOoBgmpYWhR+6MHBc58wjDVxFBQf
 n8u7fcA+u0+MIA8bNouyqBaPkBsLHTdXsHhkPk/WN6XZSKD0wkGYRoX2WtmOj0J1Jaa1
 jbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760029175; x=1760633975;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IOMvX89C87BGan/FtKadeDU9ynTlUn919FXI9/VqyMc=;
 b=efwiR5ml3Aa3tv5iCPZKVzC1RE46QAbMkGvw0I214B0gUUj3evJS3RJrH76dKriG5u
 caaRmh9OITpg7QWGt95oc/a5u9WPGXryypdMFgrvxnL4i7u/wjkBXycfBblGx1Hiufcl
 zRdq1Tf8czd+BeOqfnn+WELL2hgH76cm103piLi3ELEoQjqYRf78SXTep6zNd5ndrj66
 b1WOgZfSRBIBcmmBkUH28G5AoFkoiJidsTGmy2XZjnrz58xhXfktg958k1KYZ1ZFoaA7
 DqN4eu2fdQ1mR1Zma1C9GQciwtOKV3TL2WmCR5MYueLyBPc5u70HBjzrFqeKfwXlkqJQ
 UgCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy78ZqEp+4OD0Yuc7RVWF2xWHfvRHA3E2k3ukW4emnlsHxSS4WErxxenn8x/0ZgOhxe1YRdeUx330B@nongnu.org
X-Gm-Message-State: AOJu0YyIt2R81FgNeGBGc/5WuHIcUC8IijGIbpgv5zuNyFEms+lQ+eXa
 0ChQqFwRlw4WzuFQMa+2+9IRfcKBa77qgIPinVgoRRRsOuSCGF9vGOBQzFinyWs916MD7psHCTU
 CgjIOUFY=
X-Gm-Gg: ASbGnctiHZu/lXD4w6FAjvD2UKkpL+gDlUflw1wS37O97EabtQ6fnSk2LKzTrGi8W+6
 6OpIsp3Xr7ddVy1CW8eLAqZ1zffnYrmbbN1Zlyu89JQVRurm0ibXAHEjcjxyLYGEzbDu1qUv6fS
 BMSpR3BsRgOoJu20TBBDD2/VFZORyE/iSgbE/iX7Tnx75QZHpBP73RwMzA4AfFmR6V/jIvnSr4u
 hKufLVYKpT4/bsljosKtLSiTLZv5aDUyg+u/UmGNxqWxenMDXlDP/RL/DB1xQMPZFwyBCyqQGPu
 IMxq/TGyN8BCmUjpnVjSlN8AUEU/tOI0gY4/k+wky0294vXRoCGjd0xs9R7rERdCdS2z7nMROCF
 HpBBHhvInzqjA0WBtjrAiNw0sT0nYO6N8dmpp4pKgbOQqGT6XvFJtfRXknz8UXvEpwZW/Wv8wGe
 E=
X-Google-Smtp-Source: AGHT+IEwj0iYUEObSBOpFVtI8h0pYhSrP1o3uw+HmNYAMg7PcNX9kF10Gly4si5L8PNQQuEYnC+fAA==
X-Received: by 2002:a05:6a20:5493:b0:263:3b40:46d4 with SMTP id
 adf61e73a8af0-32da84640d0mr10459755637.56.1760029175314; 
 Thu, 09 Oct 2025 09:59:35 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d09651csm223271b3a.48.2025.10.09.09.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:59:35 -0700 (PDT)
Message-ID: <9dc3d02c-4818-4eb4-87cd-7537e27b624f@linaro.org>
Date: Thu, 9 Oct 2025 09:59:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/hppa: Conceal MO_TE within do_store_32/64()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009101040.18378-1-philmd@linaro.org>
 <20251009101040.18378-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009101040.18378-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/9/25 03:10, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hppa/translate.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 3f78bb2a76a..92071affe47 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1637,6 +1637,7 @@ static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
>       /* Caller uses nullify_over/nullify_end.  */
>       assert(ctx->null_cond.c == TCG_COND_NEVER);
>   
> +    mop |= MO_TE;
>       form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
>                MMU_DISABLED(ctx));
>       tcg_gen_qemu_st_i32(src, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
> @@ -1655,6 +1656,7 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
>       /* Caller uses nullify_over/nullify_end.  */
>       assert(ctx->null_cond.c == TCG_COND_NEVER);
>   
> +    mop |= MO_TE;
>       form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
>                MMU_DISABLED(ctx));
>       tcg_gen_qemu_st_i64(src, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
> @@ -1739,7 +1741,7 @@ static bool do_store(DisasContext *ctx, unsigned rt, unsigned rb,
>                        int modify, MemOp mop)
>   {
>       nullify_over(ctx);
> -    do_store_64(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, MO_TE | mop);
> +    do_store_64(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, mop);
>       return nullify_end(ctx);
>   }
>   
> @@ -1752,7 +1754,7 @@ static bool do_fstorew(DisasContext *ctx, unsigned rt, unsigned rb,
>       nullify_over(ctx);
>   
>       tmp = load_frw_i32(rt);
> -    do_store_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UL);
> +    do_store_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UL);
>   
>       return nullify_end(ctx);
>   }
> @@ -1772,7 +1774,7 @@ static bool do_fstored(DisasContext *ctx, unsigned rt, unsigned rb,
>       nullify_over(ctx);
>   
>       tmp = load_frd(rt);
> -    do_store_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UQ);
> +    do_store_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UQ);
>   
>       return nullify_end(ctx);
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

