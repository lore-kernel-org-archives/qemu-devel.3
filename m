Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC1CD41D65
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjUn-0006mc-9G; Thu, 11 Dec 2025 11:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTjUj-0006j1-Jg
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:26:21 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTjUi-0001zc-4H
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:26:21 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3e7f68df436so180717fac.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765470379; x=1766075179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qIQTuMJnwCiKm2I5n2TD2oV90OBaOyfG5eqJT20HyOI=;
 b=b/+YUZOCsYqFtbsfQkaBeuP1dconJlz4ybx44zWpuV26amKYjpnnmntaW+pGPowrEH
 sbLF6q5TzODN4+w+s8IADeF3jEm5prvwnnk66C1TErQ/TVgu+6MNlb5fGHXtpb6Ws4Yy
 SacKRuJostI8V3h8RQBL843cnILJ0uzdZpqeKKCMR1XEcvwov6lGpjNK6fIAeet1Tnrt
 n0xmqj7B/YRhU034xynYYpErK/nZh4gun6/572cxHPRdsrdXhuBdv+8T0nOBq3U/CX/7
 TDNiBd+8Vl2YJeLrwVzgoBS5YPjneXQuqzdTsXdbulRfJ9IG+Q36aXjB8PM/VMvHra9C
 /nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765470379; x=1766075179;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qIQTuMJnwCiKm2I5n2TD2oV90OBaOyfG5eqJT20HyOI=;
 b=eqgYwyvKJB9cqvt5cC+bAwzQBrM4iORpB5iAXgyaOsNOLVGmv3XQDkJxbDnf/39vDV
 VCcBz0RiMzjPnJx7Mcm0Rb0ezhyijUI3wTbIl/5dSV5RaOzmIr51aqmjI0NwHZETskpz
 y1Cf2wUDGL9obk5GjcQiQSj+F2ZgbLmhjV97bSsfDffQlXycBo7cCQbzxquqM5ChuAd+
 uTFzJ36uCxptw7wDfhxdkL7PLje6/b4pm4ssLntAOMA/56qEZW+tMfRUmmiSnFGcJ67A
 zatyEVAs2d9BHzMDHcyLMebS8CzSVGbjG6lmJ3So1kZYXUdgh2pcc2Fk0mveh7D5feh1
 53PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVwOl5cpwAMILi+eU8+vJGJuQmkTLGOItSEuF+hkf8wyY/ls9iblIDtS4UZeFqVsIrOTLSbdcbjQO6@nongnu.org
X-Gm-Message-State: AOJu0YxHA0uhCRtdP9a1VrTM6lN7fonooBAzqdwvNISk+yV5ZqHHZ1iJ
 LG8wB67cVUiGGWklbzhKry5yqbYva80TsECzzFC6MT+xfA2agpcRfvXk2O9wjq7LQGI=
X-Gm-Gg: AY/fxX6N9iNOssbknu1BG3Y+VpKc5wMd0CVIKHyNTAPdI1QHujQDZHrak0RKf624JUC
 2croBM1jcfVsJi2d/rO4ZoeTSZIxnTtd7m0NsnYWJzHbgnpuw5Nw58AAXTPEhcy81ZxfTXTemCm
 CmWr6rsrbRHnNNT7Zubg8tZzK8CeI3alAV5idCGG2dObEeYvhngbH5QUukEyZwWZz/bcuAZkKZT
 ywyl3EHfvhCCMKhoSYa/WLrDzCaJ9XHJpgOS+8jr8TAUAuB1LF2dD8U7IlGW9/RlB+aSVmFZ633
 cx2PdIwvybNE9pnKxUAWQjMvAfRIkSX3OlGS2bOi6l/ylOPrU9HJolqDMSgWsxbaVhpz0kwXOQb
 JfDbC7j/gtevnpRTGKutdd/fvIdX7OzQEWbi4hG2K6IxIkW5RQMSiDC5WamyHymuDc4PDBdxNue
 CX8dZi8gR+Un0zoNjCTiLd9r86y3nLiRJctadEjJGhqG77DdLU4q2V54oExHSisvaa
X-Google-Smtp-Source: AGHT+IFxpGcvh31eRM1ebEu4SChLCi/st0e3J5QHKiBfTeClw/t5r4Lr7V/bNB0uuQxejar8uKKBvw==
X-Received: by 2002:a05:6871:3a81:b0:3d3:1fc3:c0c6 with SMTP id
 586e51a60fabf-3f5df9cd139mr1294872fac.1.1765470378621; 
 Thu, 11 Dec 2025 08:26:18 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d51a0c8csm1994015fac.20.2025.12.11.08.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 08:26:18 -0800 (PST)
Message-ID: <8bd16de8-19e7-421b-af97-4a3028b4746a@linaro.org>
Date: Thu, 11 Dec 2025 10:26:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] target/i386/tcg: reuse gen_helper_fp_arith_ST0_FT0
 for undocumented fcom/fcomp variants
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-13-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210131653.852163-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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
> For 0x32 hack the op to be fcomp; for the others there isn't even anything special
> to do.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 8f50071a4f4..f47bb5de8b3 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -2777,7 +2777,12 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
>                   break;
>               }
>               break;
> +        case 0x32: /* fcomp5, undocumented op */
> +            /* map to fcomp; op & 7 == 2 would not pop  */
> +            op = 0x03;
> +            /* fallthrough */
>           case 0x00 ... 0x07: /* fxxx st, sti */
> +        case 0x22 ... 0x23: /* fcom2 and fcomp3, undocumented ops */
>               gen_helper_fmov_FT0_STN(tcg_env,
>                                       tcg_constant_i32(opreg));
>               gen_helper_fp_arith_ST0_FT0(op & 7);
> @@ -2790,16 +2795,6 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
>                   gen_helper_fpop(tcg_env);
>               }
>               break;
> -        case 0x22: /* fcom2, undocumented op */
> -            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
> -            gen_helper_fcom_ST0_FT0(tcg_env);
> -            break;
> -        case 0x23: /* fcomp3, undocumented op */
> -        case 0x32: /* fcomp5, undocumented op */
> -            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
> -            gen_helper_fcom_ST0_FT0(tcg_env);
> -            gen_helper_fpop(tcg_env);
> -            break;
>           case 0x15: /* da/5 */
>               switch (rm) {
>               case 1: /* fucompp */


