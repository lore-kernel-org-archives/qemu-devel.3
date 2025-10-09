Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C94CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6uVI-0007my-8w; Thu, 09 Oct 2025 13:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uVF-0007kL-5b
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:32:34 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6uV9-0003s7-If
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:32:32 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3305c08d9f6so1034324a91.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760031136; x=1760635936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jJAzNDVwfXbk8xIN9G4Eib9vEPZUKApR7WJerqLnnJw=;
 b=RxSg9a/0HCqaPhDQhdPWp5Tp0kPsNr/CEYJyVX5hAcNeQx5qkWELXdgg9p6jwiLVoo
 JrY85R9DBSTMWZG9BhVSDw+7OVSP14AACN5TZ4hTSPPxJAvmoSXnCg1YKiAW2ofGVLnv
 OcYdNGIXAuJNhw1YrraPBsPUuiBR/s5tZY+BJrnrHm8tArTRePsLsDnSHO9qtt6knauh
 TTFdNPS2LPdQAshg5b9kn1TNkHddb2BuP2sJGOQu8NeUYMpL20VTIgOb26twc6xJ9lTj
 P3ZHOvqOFFbTo2q1h3qKbY551FYhzEupRCHjDRd2VwPfGYSz5HiOm8pC4PFJdHgVprsm
 iKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760031136; x=1760635936;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jJAzNDVwfXbk8xIN9G4Eib9vEPZUKApR7WJerqLnnJw=;
 b=MbE/u1lyAQyY+dNUUNlN1nAHWwvVYjo1EJiOZDrKvcCTWlJxiRrMaMugTJ9EQSD3RQ
 D0D+8YYbnxyHUqLfCCP1J7hLlqV+eFwxsXGQ0391PYSHdoU8q3ZosYwhpXAWvvPvCC1x
 6ttZTnudrGBcVuXGB/Ky+ze/xeRdgiOPIme/FMYr73V+o02D4AgLE8g7l/pg+vfmeXcw
 rgBP+/pJKeiusgP5OeQIAjh8WXp3eSMGTnFNDkzc/BaAUM6ugZhybc30X/gwQ5rtMhtg
 31xjEaYLFV6ZtXpi+V4Ub8f+9Twuzg0NxSNietJSgCh2aD8NWPu8YeygPgTKFS5I5bc/
 dIaw==
X-Gm-Message-State: AOJu0YwDLHOCRpI0+SCxIUJ/Bc1ksGmE/Vlffs58iUW7KeUBqM5ngk6A
 KdCvoIJETMWppwKYbvFZePRFMhqOUppLeoLGnrc9DDyD1Wh3mznWZSgDSIVc+lJSkO/aTwSqE1j
 Zpsv3o4U=
X-Gm-Gg: ASbGncu0ul3e8OXu9lowepzuaFC4i0CR7pzMj7Wsff4NwK9psskrEqQ6kyvaA0A+ru7
 KxNJGl/xoCnRQh5oOg8M0tPkpBSHz3hGr31gGgv0oDsW+DLDA7wDSeiS0xfBEU8N/zTSmQ3BI3Q
 tnXfRp7naGc5wL2MuKr3AccTxNPraw72G/jYJyPmuVRf4nxfMH5Wn/FVBjd7NkoKI+Sbtn6ZPvs
 1PYiVxmVVQkZS3xVZvKBssQpCXzM6/lqYn1Koqn+wjEjANy0wHK7bkmXLPIdR+hjdU1Yxs9QS5O
 OYQ/bvfusrnV0pHrmiCWzNK2Pt5AlQw1MZMgyqxvEKH7u3kOT+wfqu5bn54YniJJBiGqx4cChRQ
 lqh5TsCFHNhge+BzpOG5p2KTCFGWJSVfwh/BtFNCyomjjerWUNAnf3Dgrw8z9l8bB
X-Google-Smtp-Source: AGHT+IERQvil/IpOvAkKT+rq+jRrd8Q6OnKGZzrG9lMp0rNdM2kNDMTxMH6W11ThuEJ1XkjvW9biCg==
X-Received: by 2002:a17:90b:35d1:b0:327:c583:add with SMTP id
 98e67ed59e1d1-339eda5cf24mr18335799a91.6.1760031135601; 
 Thu, 09 Oct 2025 10:32:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b678df8ea31sm207464a12.42.2025.10.09.10.32.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:32:15 -0700 (PDT)
Message-ID: <7a83738c-4b98-4a21-9292-2672e04866a9@linaro.org>
Date: Thu, 9 Oct 2025 10:32:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] target/rx: Propagate DisasContext to generated helpers
To: qemu-devel@nongnu.org
References: <20251009151607.26278-1-philmd@linaro.org>
 <20251009151607.26278-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009151607.26278-4-philmd@linaro.org>
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

On 10/9/25 08:16, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/rx/translate.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/target/rx/translate.c b/target/rx/translate.c
> index 9a2be2107bd..f02a8cc5dc9 100644
> --- a/target/rx/translate.c
> +++ b/target/rx/translate.c
> @@ -1894,7 +1894,7 @@ static bool trans_ITOF(DisasContext *ctx, arg_ITOF * a)
>       return true;
>   }
>   
> -static void rx_bsetm(TCGv mem, TCGv mask)
> +static void rx_bsetm(DisasContext *ctx, TCGv mem, TCGv mask)
>   {
>       TCGv val;
>       val = tcg_temp_new();
> @@ -1903,7 +1903,7 @@ static void rx_bsetm(TCGv mem, TCGv mask)
>       rx_gen_st(MO_8, val, mem);
>   }
>   
> -static void rx_bclrm(TCGv mem, TCGv mask)
> +static void rx_bclrm(DisasContext *ctx, TCGv mem, TCGv mask)
>   {
>       TCGv val;
>       val = tcg_temp_new();
> @@ -1912,7 +1912,7 @@ static void rx_bclrm(TCGv mem, TCGv mask)
>       rx_gen_st(MO_8, val, mem);
>   }
>   
> -static void rx_btstm(TCGv mem, TCGv mask)
> +static void rx_btstm(DisasContext *ctx, TCGv mem, TCGv mask)
>   {
>       TCGv val;
>       val = tcg_temp_new();
> @@ -1922,7 +1922,7 @@ static void rx_btstm(TCGv mem, TCGv mask)
>       tcg_gen_mov_i32(cpu_psw_z, cpu_psw_c);
>   }
>   
> -static void rx_bnotm(TCGv mem, TCGv mask)
> +static void rx_bnotm(DisasContext *ctx, TCGv mem, TCGv mask)
>   {
>       TCGv val;
>       val = tcg_temp_new();
> @@ -1931,17 +1931,17 @@ static void rx_bnotm(TCGv mem, TCGv mask)
>       rx_gen_st(MO_8, val, mem);
>   }
>   
> -static void rx_bsetr(TCGv reg, TCGv mask)
> +static void rx_bsetr(DisasContext *ctx, TCGv reg, TCGv mask)
>   {
>       tcg_gen_or_i32(reg, reg, mask);
>   }
>   
> -static void rx_bclrr(TCGv reg, TCGv mask)
> +static void rx_bclrr(DisasContext *ctx, TCGv reg, TCGv mask)
>   {
>       tcg_gen_andc_i32(reg, reg, mask);
>   }
>   
> -static inline void rx_btstr(TCGv reg, TCGv mask)
> +static inline void rx_btstr(DisasContext *ctx, TCGv reg, TCGv mask)
>   {
>       TCGv t0;
>       t0 = tcg_temp_new();
> @@ -1950,7 +1950,7 @@ static inline void rx_btstr(TCGv reg, TCGv mask)
>       tcg_gen_mov_i32(cpu_psw_z, cpu_psw_c);
>   }
>   
> -static inline void rx_bnotr(TCGv reg, TCGv mask)
> +static inline void rx_bnotr(DisasContext *ctx, TCGv reg, TCGv mask)
>   {
>       tcg_gen_xor_i32(reg, reg, mask);
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

These really shouldn't be marked inline, but that's another issue.


r~

