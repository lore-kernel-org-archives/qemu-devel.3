Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8985FCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tzL-0000zr-Sz; Thu, 09 Oct 2025 12:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tzI-0000yF-Ka
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:59:32 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tzA-0007Ay-Up
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:59:32 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b5579235200so758853a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760029161; x=1760633961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QtMt9AMUchK/1A2xTgn4Ti3MLZ+TIBqa9R6kLiTTxps=;
 b=EJScgjUOr91ctVm2EevVX7/Z9jeKhoJmhgtOFx1bg1Xbw76j9mUhf4inxf1epe0cFY
 ypa0uyUYMGqJbNUvxioc4hMOqnsMPvLGcWmDZ7FulOeJkgQ6826AE0rO3ppmtvVijl6l
 YE7PVZGv1ufFuQdf4aCzimXzf9ilPPDy8+K0xfxBJVN1diIwmlObsL4pIbnhAY/PY35x
 o0pQQemN0P3otlrCdQh7qCEsN4knoplN/Tss1Qoq+j1eIp45PeOMWCpaDtjRv8hOTp0S
 X2Na1TYaFMm1ngO/fnmR1+iWKWsa5yGbgHM+31hP+5L/d9gTnEEj5K7auXQkGup0Ddit
 bhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760029161; x=1760633961;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QtMt9AMUchK/1A2xTgn4Ti3MLZ+TIBqa9R6kLiTTxps=;
 b=VuGd2HvNs3eewf2AQLccfJtq7DMQRY+bbRKZ/VIWTWRK0w1TR+bigqOVx4t9u+CA7m
 Q9fjZSUtGHi29RRBWCWJmDNde0MmYmpGq5GS/qK6wdozoAHprxOsD6FLD/cuvvfW5ScC
 Gifsah2VvMjMJMjXSxIStamOX30Ei1saW3HATrJyzNXezlbXIF6yk4DEN60TMZkwxSba
 0jlAe81HK9Ky2Bb9I9RHrPvySyrS+yLcYaBq/sfT1nqezkrJSgj5eAdf55gs3DNIRkp3
 2jSmH8Sgc2lg8xL18KhEJ/V87XwVwVvG2Pj86Ngx3LbXR6MP1e2mD3arTvOxdIjJ872l
 rlpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyu+uWgRuSVGbzZrZu69CQDUUKMwrTFO9SmjR5kZM4AKAHHIjqySdt8qIZn/uKx9vPnS7NwQ+f3Cxq@nongnu.org
X-Gm-Message-State: AOJu0YwLGV2y0/hivEg9vtSyiD/6/M2m4N7W+taVPWpIu6+UDp9aDvkk
 zzuy9/i93UPI0tofnWA+6W54YgwMEebGUAumRyFFrw8z57C5M7Vuzzj4l3DnCknRhbx421UNqsJ
 5mvqCdSk=
X-Gm-Gg: ASbGnctrMv0BSZsvQlUnsd4/Sw93PpYihq1M21HiOU5gjWNED9+wsmNDC2fAgyk5HPB
 IM65f5uk0cXiL9ulkHbdZKi/+ofqJtF3JX7jrxPmk2fFN8UFWsus9ITYwBJkM7JeCbe3YlQfvWC
 TzeIsFNYhbhBHCNvzfFgGQGhONrZeDoPez+0pU5SRBN4y3N5yowYjW7fdJjbW2LdojDasGjahkm
 gomNEUqYakwFvK3C5tZ6MnYhFd5wKA9QYlykiB1ulc2DPNWkt33gfQz+Wwwcdw323lGlSm1qNuB
 /scj+zJbuM7S9dSBsSy2SUnmrsU5hzXVAUtQGHv+Q+YmoccyszCtMUSUGeJufzlbENMYnh3Iv3v
 GMmMnSFLzKrc04GQvzEdQYmHXf7mUwVaQhmsGX6HTAYdh3w8sigkQ/QIYSxl9xnEV
X-Google-Smtp-Source: AGHT+IEBLgspfvN+7+vK/r8CTi1UkUDuU4ZQI9Qa6Gbf7TGoIe4tZGn38JOBuX8j2rGesrlgV+WQ+w==
X-Received: by 2002:a17:902:cf03:b0:273:daa6:cdf9 with SMTP id
 d9443c01a7336-2902723ba36mr98338615ad.22.1760029161055; 
 Thu, 09 Oct 2025 09:59:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f8f72esm33692995ad.118.2025.10.09.09.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:59:20 -0700 (PDT)
Message-ID: <320c666a-6cda-46af-af88-3d420a45eaea@linaro.org>
Date: Thu, 9 Oct 2025 09:59:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] target/hppa: Conceal MO_TE within do_store()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009101040.18378-1-philmd@linaro.org>
 <20251009101040.18378-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009101040.18378-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 10/9/25 03:10, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hppa/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 4680d826345..3f78bb2a76a 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1739,7 +1739,7 @@ static bool do_store(DisasContext *ctx, unsigned rt, unsigned rb,
>                        int modify, MemOp mop)
>   {
>       nullify_over(ctx);
> -    do_store_64(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, mop);
> +    do_store_64(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, MO_TE | mop);
>       return nullify_end(ctx);
>   }
>   
> @@ -3313,7 +3313,7 @@ static bool trans_st(DisasContext *ctx, arg_ldst *a)
>       if (!ctx->is_pa20 && a->size > MO_32) {
>           return gen_illegal(ctx);
>       }
> -    return do_store(ctx, a->t, a->b, a->disp, a->sp, a->m, a->size | MO_TE);
> +    return do_store(ctx, a->t, a->b, a->disp, a->sp, a->m, a->size);
>   }
>   
>   static bool trans_ldc(DisasContext *ctx, arg_ldst *a)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

