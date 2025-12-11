Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E77CD41D66
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjQ2-00059x-9d; Thu, 11 Dec 2025 11:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTjPz-00059R-TM
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:21:27 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTjPy-0000No-7C
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:21:27 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7cac9225485so219241a34.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765470085; x=1766074885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NkdLpVpNN0SBDZJAbfggpMyi9NMY6zLiVFxgI4ntZL4=;
 b=fCTJ0NMOcGSvvpSm1onmG53B+Z5jQQ9eR7iVdoUGEB2FyHINft98GvUe19R95XDETR
 6ayK40gkSEFMNEX/+izBO4qD4rxXBWRYfpbItjw1YShtE8aw4L0xAg9f3lKEmkop0v70
 VZv2Z4bfOBhtlJwVG7f596uIHg7Uo51H8+C9U1IO9gEHv7FpyKm8dTDNEFLuZt/Cfkoy
 wqyH9UL1WmIKPsgoYw31J4DZIJbk3ukXPyFatc7bbCyLWNRKaPbzTIok8wXYOVw9oeAg
 ZtYxqkncQHW9qcPUrgDHfifD1VrATNyDqXDvTNUOqpyOjzeewwnDMw+6R0lRo9NUQRVK
 zVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765470085; x=1766074885;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NkdLpVpNN0SBDZJAbfggpMyi9NMY6zLiVFxgI4ntZL4=;
 b=mQ4G/5hVKKDp3F4AMdgCJMMrQwaWae9X8Wme1+Pbx4j5bEk6bWMCeg5ASSYgj0/RJj
 KSjpgSPdufSt1i8f7FOMjBBpB8JvlrmSzK9QHsppxu69jQpUdyEErZ1g5OC+68cuw+dM
 J94wA8wMZo6SEGf/kSciFN3l2LwOUu/stvC31azbo776bhRB86yKbyzSV1vfFABieg11
 sEQgA/LX28jKGqoz7Lpeg3RV5ePxr9tleBYUR9B7diyRhUR65PeVyHlRiZqABOaV/ZGa
 C6Yirc5LahFKrfpVP6Cv2ON42ZhG+wA6pePiWSO05PNrwytTIavgmK1BPbog48ISkZfw
 kzUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXlksJZx+uheOud27FD9Oe76AAYtQOg+jDBxDJ6+iEOksvSQvZLv7Lg5wBdaYRppnJPCS02KWpAHth@nongnu.org
X-Gm-Message-State: AOJu0YyULjCQGDoNtByoztbPxmq7TQBNsbrKlhjvjaH3LmrJK0Njy1Gb
 fpPUmzbNWUCOCPRRrtpyEgZCbsgvbjascwIICB/81NUxp96q228IxzeoLs9XJ5a5tsGnvtCSt3t
 hW4nDxB0=
X-Gm-Gg: AY/fxX462gSH/KGstgdL5od39AXltsjTyCp4PH7PbgC2nnS2ZdwHxD96QzAlb1u71qM
 ix6+XwQEmF/eo3eKLlQZWdWRqn3kzXkPocU7v2Ywn6mxxv2foe9RdzLU18mdfaagJYL+XMnoZt2
 hPrtnNjV/Zy3cP+H/VO9Umb4j2jIwaDSYKO3Ud2grm5m3glm7s0Guu6epRmp4FP2QyeK42v4yC4
 diqTwZzEnVJlCG8MgOvsXZvodlJfFHt1jMnsFiX64BXzzi70HajL4XMH4+KzBZ5vCNJorjCn/6O
 TsYbaa53mlqqIuthAgvEPj7ZZ6CmjIpegx4NSfQnWrz6FlRbBT5aSafvUabX+xDWZW0Ul2+EIgD
 bobeVxk2n9JLLaBYKmEV8JpPq4kNSp97xiWCRJkotxzg9ceDOqs7y3QRglVp2IxUKu3Bo/QFaGJ
 n8i7pYxmXsa2b4Z2O43Mcus6yAS1EcJilJKmLmAuFwMah8PVGS4JSFcjc5LjHxcpYFnr0Jc5azO
 GM=
X-Google-Smtp-Source: AGHT+IEu6XDFODxNUs1x2O80DFIB90dB0eWVfSKo96u54/t0ZWi+OqTk9vjTa8iedu+vNgbCYbZW8Q==
X-Received: by 2002:a05:6830:410b:b0:7c6:e92f:41ca with SMTP id
 46e09a7af769-7caceba9785mr5638996a34.8.1765470084993; 
 Thu, 11 Dec 2025 08:21:24 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb2fc086sm1677629a34.18.2025.12.11.08.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 08:21:24 -0800 (PST)
Message-ID: <e7b569aa-b1f5-41b3-9487-619fb0d785d8@linaro.org>
Date: Thu, 11 Dec 2025 10:21:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] target/i386/tcg: move fcom/fcomp differentiation to
 gen_helper_fp_arith_ST0_FT0
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-11-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 12/10/25 07:16, Paolo Bonzini wrote:
> There is only one call site for gen_helper_fp_arith_ST0_FT0(), therefore
> there is no need to check the op1 == 3 in the caller.  Once this is done,
> eliminate the goto to that call site.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 23 ++++++++---------------
>   1 file changed, 8 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index c755329b3d9..3c55b62bdec 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -1485,6 +1485,7 @@ static void gen_helper_fp_arith_ST0_FT0(int op)
>           break;
>       case 3:
>           gen_helper_fcom_ST0_FT0(tcg_env);
> +        gen_helper_fpop(tcg_env);
>           break;
>       case 4:
>           gen_helper_fsub_ST0_FT0(tcg_env);
> @@ -2460,36 +2461,28 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
>               tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
>                                   s->mem_index, MO_LEUL);
>               gen_helper_flds_FT0(tcg_env, s->tmp2_i32);
> -            goto fp_arith_ST0_FT0;
> +            gen_helper_fp_arith_ST0_FT0(op & 7);
> +            break;
>   
>           case 0x10 ... 0x17: /* fixxxl */
>               tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
>                                   s->mem_index, MO_LEUL);
>               gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
> -            goto fp_arith_ST0_FT0;
> +            gen_helper_fp_arith_ST0_FT0(op & 7);
> +            break;
>   
>           case 0x20 ... 0x27: /* fxxxl */
>               tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
>                                   s->mem_index, MO_LEUQ);
>               gen_helper_fldl_FT0(tcg_env, s->tmp1_i64);
> -            goto fp_arith_ST0_FT0;
> +            gen_helper_fp_arith_ST0_FT0(op & 7);
> +            break;
>   
>           case 0x30 ... 0x37: /* fixxx */
>               tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
>                                   s->mem_index, MO_LESW);
>               gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
> -            goto fp_arith_ST0_FT0;
> -
> -fp_arith_ST0_FT0:
> -            {
> -                int op1 = op & 7;
> -
> -                gen_helper_fp_arith_ST0_FT0(op1);
> -                if (op1 == 3) {
> -                    /* fcomp needs pop */
> -                    gen_helper_fpop(tcg_env);
> -                }
> -            }
> +            gen_helper_fp_arith_ST0_FT0(op & 7);
>               break;
>   
>           case 0x08: /* flds */


