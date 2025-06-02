Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3758C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 08:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM0or-0000Ee-Re; Mon, 02 Jun 2025 04:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uM0oo-0000DA-ML
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:46:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uM0om-0003ay-Af
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:46:54 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-450d668c2a1so18368865e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 01:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748854010; x=1749458810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a7jyu99NtPdmf2Ia5Cr+Qyc8VQqg6GbjRm3hnIhBqmQ=;
 b=aiWhGc8hhMwopDn4vtq3KwAsYWV2srNslyS3MygQY21+QvzgGiyXL0ubIqudE6XVVb
 GjhYb28ltJQ4obrG7Ta6NmdrK8sx1sl3kQOLPFwRcuA3F6pw4J6rTLEZWUagTcvISIo3
 hOQmEOkHTpK64j8l+0vL9XDxCkNnQChsInSDdgeCeoNCG23DZiKKN94X779s2HlnfRNt
 llUP251gaIVnJ4OdqroPAEDFZPWTj6tEgQ1jC2lZZ/Ef7ioY/+zRmpGmRm4irjFa55w4
 f/S4VEx291cd9NA8iXBZKyv2FsCClHDVeEzpWozcdbpdGq8LLlEQe6GA5nPPywah49Jh
 OtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748854010; x=1749458810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a7jyu99NtPdmf2Ia5Cr+Qyc8VQqg6GbjRm3hnIhBqmQ=;
 b=A8DwTJds2HBtoHM0v/8/7vU0pOBfrelvdsfz/PxBSTx//w6xstNG8HRpsBRC536whz
 XecV7lrmwaUrfocf11zUUEI3OpaU6gLo9FOL1zlag8g6gMslmgXIRYwEGtNS43vBSkBS
 QW1Cfc+CECpun65QOfWGNKNcm+b5i5ABYmQbmVH6W7Lr2nfqKWb3rQwFH4NNmO9KXr1D
 zqtJEspyljq1nMXH2WmSsVI1vNQ5IIXplcpZ8idn5uDA0ZUSBP5RiywylubYLHUi179O
 34NdzFJotu10S+i5idqDg8YAKu7PVKGEoA+YfH2+nz7sAmc0WdvBm0IhgrYq8BumpogY
 gaug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPtqxeSmGIlzNNWluTcrWXQHg6sOjKGjCJg4GlkevVYKQi/INZebrj8OiTLgGMb2I33Afkdhni2QO3@nongnu.org
X-Gm-Message-State: AOJu0YziB0HEQq41l+u8isSPgqayNWSAMBQhvo53sbyh+IHJK73KI3Sn
 Wzu/id01dVNyyMl2GM9SrVnZt9qd/AuKNf7g5407SC2O6GzRJMTw7nWVkWeAnLjv+p0=
X-Gm-Gg: ASbGncuWyTIW0pW2sQ8WGdrc8tWRbkY76cSPTZSV7HrR+CYxQvOCyKS9/7cQ7LMO4Nf
 EQuTH1S2efj1QexQCH1t07Y0qeBprRAZ904ICH6D5tH9xF7YdCLftUiFGto81qCdd1rTNOSOeFW
 RX1qT92GUxC9UZ2eewqHCAPNdA/822NXm9s9JjsW6DkS/QJF6/Gq1y0TwwmDxw2Y9T2zS0cVueU
 +Esl9wNNvMyTOKO07mOc9I4WM1bDeSxg3zHJK6Ejzmf7xo487TDWMGg1woRvP8XhufWS2cNeiSQ
 T17x1aGglpY23XdkoPXzJq3/ZXdaKlY1nGK2nF727gC1XtONf8YJ8wpFE0blv76xX8whZd8XqYZ
 opdbkDchQsQxJ2yuPB2VGZAMX+dcaN6s=
X-Google-Smtp-Source: AGHT+IGyQIOZGSRDrPnjfN/Fy5oJfBzoR45HYVB1LZ97G0ksuqzju8t9+sUHajd1Q7RqmiZ9hSd2hg==
X-Received: by 2002:a7b:cc81:0:b0:448:d54a:ca23 with SMTP id
 5b1f17b1804b1-450ce8376bamr96661105e9.8.1748854010457; 
 Mon, 02 Jun 2025 01:46:50 -0700 (PDT)
Received: from [192.168.1.127] (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8000d50sm112910775e9.19.2025.06.02.01.46.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 01:46:50 -0700 (PDT)
Message-ID: <41f75652-7242-4677-8500-686da53f3366@linaro.org>
Date: Mon, 2 Jun 2025 09:46:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: add check for fcond
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, philmd@linaro.org, lorenz.hetterich@cispa.de,
 qemu-stable@nongnu.org
References: <20250523011745.3833883-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250523011745.3833883-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

On 5/23/25 02:17, Song Gao wrote:
> fcond only has 22 types, add a check for fcond.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2972
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/tcg/insn_trans/trans_fcmp.c.inc | 11 ++++++++---
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc  |  4 ++--
>   2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc b/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
> index 3babf69e4a..5be759d30c 100644
> --- a/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_fcmp.c.inc
> @@ -4,10 +4,15 @@
>    */
>   
>   /* bit0(signaling/quiet) bit1(lt) bit2(eq) bit3(un) bit4(neq) */
> -static uint32_t get_fcmp_flags(int cond)
> +static uint32_t get_fcmp_flags(DisasContext *ctx, int cond)
>   {
>       uint32_t flags = 0;
>   
> +    /*check cond , cond =[0-8,10,12] */
> +    if ((cond > 8) &&(cond != 10) && (cond != 12)) {
> +        generate_exception(ctx, EXCCODE_INE);
> +    }
> +
>       if (cond & 0x1) {
>           flags |= FCMP_LT;
>       }
> @@ -39,7 +44,7 @@ static bool trans_fcmp_cond_s(DisasContext *ctx, arg_fcmp_cond_s *a)
>       src1 = get_fpr(ctx, a->fj);
>       src2 = get_fpr(ctx, a->fk);
>       fn = (a->fcond & 1 ? gen_helper_fcmp_s_s : gen_helper_fcmp_c_s);
> -    flags = get_fcmp_flags(a->fcond >> 1);
> +    flags = get_fcmp_flags(ctx, a->fcond >> 1);

My same question applies for exception priority.

Here it isn't possible to just inline get_fcmp_flags.  But you could, for instance, change 
the return value to 'int' and return -1 on error.


r~
>   
>       fn(var, tcg_env, src1, src2, tcg_constant_i32(flags));
>   
> @@ -63,7 +68,7 @@ static bool trans_fcmp_cond_d(DisasContext *ctx, arg_fcmp_cond_d *a)
>       src1 = get_fpr(ctx, a->fj);
>       src2 = get_fpr(ctx, a->fk);
>       fn = (a->fcond & 1 ? gen_helper_fcmp_s_d : gen_helper_fcmp_c_d);
> -    flags = get_fcmp_flags(a->fcond >> 1);
> +    flags = get_fcmp_flags(ctx, a->fcond >> 1);
>   
>       fn(var, tcg_env, src1, src2, tcg_constant_i32(flags));
>   
> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> index b33622ff79..0128a2398f 100644
> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> @@ -4666,7 +4666,7 @@ static bool do_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a, uint32_t sz)
>       }
>   
>       fn = (a->fcond & 1 ? gen_helper_vfcmp_s_s : gen_helper_vfcmp_c_s);
> -    flags = get_fcmp_flags(a->fcond >> 1);
> +    flags = get_fcmp_flags(ctx, a->fcond >> 1);
>       fn(tcg_env, oprsz, vd, vj, vk, tcg_constant_i32(flags));
>   
>       return true;
> @@ -4686,7 +4686,7 @@ static bool do_vfcmp_cond_d(DisasContext *ctx, arg_vvv_fcond *a, uint32_t sz)
>       }
>   
>       fn = (a->fcond & 1 ? gen_helper_vfcmp_s_d : gen_helper_vfcmp_c_d);
> -    flags = get_fcmp_flags(a->fcond >> 1);
> +    flags = get_fcmp_flags(ctx, a->fcond >> 1);
>       fn(tcg_env, oprsz, vd, vj, vk, tcg_constant_i32(flags));
>   
>       return true;


