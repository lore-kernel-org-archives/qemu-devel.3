Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924CAD3B7F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 15:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSdLY-0006Lc-IR; Mon, 08 Dec 2025 10:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vSdLX-0006Ky-7x
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:40:19 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vSdLV-0007J5-98
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:40:19 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6597b877066so2833055eaf.2
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 07:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765208415; x=1765813215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Bzs2cE0dFLuWQUSJjpsF88B6TmFTjl9fHMhZsz3zGE=;
 b=qu5/+MGMgkbPFf6W0Vab/05b8BxIvV824RlF/A+97tjRFd5/NNsDNd03gfZlUa2Et3
 8449jZyoyv/ocfJViht0wyi1/IQtLAqlYU9k5PdaaQP94O5BnQmB+lZhHUcPL7W5V+y1
 XrzngkGrVbmXOKwnBq4i/ASBa7aCE6iX8EDagc6KC+7y+G3X+d622AqC3eMUNbppWhnH
 OjnoB7hixYAn3fv81SxE7bDXHZAEUc99h5V+HtWQkrJM1QxUWIFpVdxtB0Wud0+ZOVZY
 Bq+Gl2UkSGH5f3gh1vl+pxi0Xviph8cX6YdMqYVLc8Tvz1nzvA7kD7x56+077hwNXn7B
 UWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765208415; x=1765813215;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Bzs2cE0dFLuWQUSJjpsF88B6TmFTjl9fHMhZsz3zGE=;
 b=C76G/uKi9u8P7ZmZQ03LU73zPelB05zF3/4BZvPJZY/D5X49kwxFdY+OPDobC/7Mds
 od6NaiOODjwwZo09QBh7PhzQX3jK5Aoam6S/0FF7dfX5R6tIlCiTEmsT2DG0SO1Dbvvi
 7lc55OKg1GiOtAlcKHq9YnUBkcoJrGITbCC8rzumC9KOYHee2djx8dVdPT/7eAB63wuc
 QIPogFV+rBPXbKrnpl1zOhvIG/HK+YDpM4/pSJX6c6HKt+26kjC0MD+qOxotHLebr5YY
 P0vYEn71+MtEXgV6rdTesCUHhtVTxAwld5j0BNnvziv/0nSZ6C5H48U4MAXgY+rY0nXG
 ROZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNqKSB2b4gIuGiPN8XYgW/IYs4ajtLdxDVLudGZMe9WMF6W9iJEVoMNojKHk9nizZH/FUOnAgUigMp@nongnu.org
X-Gm-Message-State: AOJu0Yy4ID4qA6mJw/StU3d29ZLf/3ZZeDoCph5X/6vc08nHLoGUXf/U
 0VerzEQgZuR37OSYjrVEPA/lqW/GoFumr4GlCwZ/qSFPKHLJoSnzA13SEQDuBjMtpuk=
X-Gm-Gg: ASbGncu6QNH3oV7w6GeB9rXTZW98opv4OCXoznsIAQZtA1B2kWmdG+5ZQ/QIw70ZsUU
 /YzC+2CTLnwS+tz6vZxpWKpe7p2UNKSLGQYDmtpxH0nsRPYp5/JxGElT445W1fAyxyDCUkfQniF
 9wJVMGCQVgp1sUpPO3J0wUgbOG8Sfq2rzFTBTzc/46o2dpprGG77HcyJApFCXMff5Fr6s1YqqSo
 DijxvP21NzthCQqnACb5DHhpsr2w1AEP1vGXhCbfL6M5jkEa6xq5kG4VZ92zGfrBniLTOGRl4kW
 FdM5sLcDrQAI/jo0jtRdyN6SUqtWUj6YBWE11BPaaPViA99w7sy3HsWNcXev2uBGIzEbPno6Z2v
 VJCcYaM2uDFjh/ZAc3v7yfqo5GHqqQpV+pNZXwnWsJW9tn8GNkNN3FSLasz7Xcz/O3Se0QugiMy
 yDUFmDMiYyH5DCzH7XKtySncXd3aB0+rnVrjc7OqS5Fg/zAWRzifyGpjNFUXxS90eMwDDLO76TY
 pQ=
X-Google-Smtp-Source: AGHT+IHbs8mZpnrx0BZAbBQjfI5ev/Ad5HhTDguyY+Qb+TwEZfag7A7ULBT3vOeuvVSsL9qAFxUeiQ==
X-Received: by 2002:a05:6820:1905:b0:659:9a49:8f49 with SMTP id
 006d021491bc7-6599a8c3affmr3089843eaf.14.1765208415235; 
 Mon, 08 Dec 2025 07:40:15 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6597ef41302sm6055281eaf.15.2025.12.08.07.40.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 07:40:14 -0800 (PST)
Message-ID: <d1627919-0f18-4c6e-9bc8-2a6d2b4ed7af@linaro.org>
Date: Mon, 8 Dec 2025 09:40:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/loongarch64: Support every TCGCond for cmp_vec ops
To: WANG Xuerui <i.qemu@xen0n.name>, qemu-devel@nongnu.org
Cc: WANG Xuerui <git@xen0n.name>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, xtex <xtex@aosc.io>
References: <20251206182445.3656223-1-i.qemu@xen0n.name>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251206182445.3656223-1-i.qemu@xen0n.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

On 12/6/25 12:24, WANG Xuerui wrote:
> From: WANG Xuerui <git@xen0n.name>
> 
> Support for TCGCond's in loongarch64 cmp_vec codegen is not uniform: NE
> is not supported at all and will trip over assertions, and legalization
> (currently just operand-swapping) is not done for reg-imm comparisons.
> Since the TCG middle-end will not legalize the comparison conditions for
> us, we have to do it ourselves like other targets.
> 
> Because EQ/LT/LTU/LE/LEU are natively supported, we only have to keep
> the current operand swapping treatment for GT/GTU/GE/GEU but ensure it
> is done for both reg-reg and reg-imm cases, and use a bitwise NOT to
> help legalize NE.
> 
> While at it, lift the cmp_vec handling to own function to make it easier
> for readers.
> 
> Fixes: d8b6fa593d2d ("tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3237
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reported-by: xtex <xtex@aosc.io>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 119 +++++++++++++++++++------------
>   1 file changed, 75 insertions(+), 44 deletions(-)
> 
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 10c69211ac5..1a243a57beb 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -2179,15 +2179,38 @@ static void tcg_out_addsub_vec(TCGContext *s, bool lasx, unsigned vece,
>       tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
>   }
>   
> -static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
> -                           unsigned vecl, unsigned vece,
> -                           const TCGArg args[TCG_MAX_OP_ARGS],
> -                           const int const_args[TCG_MAX_OP_ARGS])
> +static void tcg_out_cmp_vec(TCGContext *s, bool lasx, unsigned vece,
> +                            TCGArg a0, TCGArg a1, TCGArg a2,
> +                            bool a2_is_const, TCGCond cond)
>   {
> -    TCGType type = vecl + TCG_TYPE_V64;
> -    bool lasx = type == TCG_TYPE_V256;
> -    TCGArg a0, a1, a2, a3;
>       LoongArchInsn insn;
> +    bool need_invert = false;
> +
> +    switch (cond) {
> +    case TCG_COND_EQ:
> +    case TCG_COND_LE:
> +    case TCG_COND_LEU:
> +    case TCG_COND_LT:
> +    case TCG_COND_LTU:
> +        /* These are directly expressible. */
> +        break;
> +    case TCG_COND_NE:
> +        need_invert = true;
> +        cond = TCG_COND_EQ;
> +        break;
> +    case TCG_COND_GE:
> +    case TCG_COND_GEU:
> +    case TCG_COND_GT:
> +    case TCG_COND_GTU:
> +        {
> +            TCGArg t;
> +            t = a1, a1 = a2, a2 = t;
> +            cond = tcg_swap_cond(cond);
> +            break;
> +        }

You can't just swap if a2_is_const.

You can get better results by using tcg_expand_vec_op() to transform the comparison early.

You probably want to do something like s390x, where you have a helper that transforms the 
comparision but without the inversion for NE, and then applies the inversion for 
INDEX_op_cmp_vec and swaps operands for INDEX_op_cmpsel_vec.


r~

