Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A88C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u587p-0004Ga-6C; Wed, 16 Apr 2025 15:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u587n-0004GH-Ck
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:08:43 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u587l-0004tv-JC
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:08:43 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30155bbbed9so5590926a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830519; x=1745435319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cXa986JNVzrHhnRDx2Vo8/gOEhLm+t491JDb1JzjdpQ=;
 b=TTCEAamvzo7Y7mMgF+bmnus76FQJoq1BAn6eEVg8FvWQjO9iKrVrD759+pYMyg6VS4
 fHdsY0mt9fZs+Qrrzxkol1yqfiTzw8xZdqTmm3PpzAUG6Ki6VFI9Rf/QBggJca9KSp8G
 4HUJFbfNvhhwBI2JwNQIRXxjgAdq2A4SHGFbQBm2PeIVQYmM7PRjGV/TvFxbLEVvQ+j3
 DEEITXLrZWvbi7AV7KFNIp5hJiPxcs9OSUQr0S6emlmSQSIndqQqb/+p51r2ITV4pTmC
 a6nvP5G+adhBw6TVv/rmOpFxOnXSemCDBrgFug9FN2BwrZuGzPNnrTDe9dVb+gsJzlkH
 sigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830519; x=1745435319;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cXa986JNVzrHhnRDx2Vo8/gOEhLm+t491JDb1JzjdpQ=;
 b=OgetKKZIvR1EEB43iRwUUZpGgIXx2avWdGWuSjVKoEG01tXX+qJrGKwQIIKAuTf18W
 ZKgl1lR0fWN5CMsHclJolKbC/imGMMjzVdT7Y0crvtr328JIkXClTrLknxZrNYniVbIt
 Nb0qwjlaR4sKDS64SjpshKCGLCiHEl/oZp3eOsMhhD6zx80zA1Cou3Xs2OUFJkF8JzLX
 oV8BNNJ4O98338xCz88Sk+tyUUnyY+H2molp0515rXIA0VtDa5BQ14Ft/+8Hy4KXQ0Nh
 K/RenlOnrQCBxAIw6bymNB47pxngSKADJNNeEc8ycMIJRj/7D5guhUQW5iwqvd/bJgaa
 konA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXInLVm+vZUT5IxQc6NvPdqvKihWBaqo3jjNcMjKXWvAMc8pp16TjW/yKos7D1g66zi0dmHZVRZwZ99@nongnu.org
X-Gm-Message-State: AOJu0YyHqI/8sJ2MwWNpchN2rjJUQ22MyYCfwsozWnvjh8rFbJ3BCRQI
 LlW7I9rudKX7aMkjvTW0BF1BsMDgmtU+rwO4f3iedxrAs89ihY+t5NmAJqdXQmI8hWCF3lR9uLy
 c
X-Gm-Gg: ASbGncsTreYRypaKTyR6tcCpj+osmjrkS+Ex17TNiY9Eofaq1bZASSS7zfxSB2hwOmA
 85GMBAcyas9jQAYie9bJ6oZFZFy+IlziQXSuo0w7Y9DDdxKunNLR+rMSZuqRdWO29igeel1M/dH
 AGKhdlbasRiI3It2L2sttivxYJVJiOEKtQFJq6An9YMd9FudS/gSsaS2Tt9Psz7zxtzPTsr+HfM
 UPtVSV+khNcOzHzyoel4ZY5JESs71WwQ6BCTKbHvjpu0c12nz2LIR5cUq2zAMgHeV99fYFlx1F2
 Q1YFokQQxtb2L+K8Crg3NXnA0k9tNuo1xvb7tvWu3nRmG7LX9ww89w==
X-Google-Smtp-Source: AGHT+IH7NcXzsFVpCGe/NKgy7SQGBV64fK8mFbPEQ/ZM1LLsZfomfdZBESykk2NYBhx7LtmPi/7SEA==
X-Received: by 2002:a17:90b:1b11:b0:2fe:68a5:d84b with SMTP id
 98e67ed59e1d1-30863d1de4bmr4456381a91.1.1744830518760; 
 Wed, 16 Apr 2025 12:08:38 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fa5db7sm17947715ad.119.2025.04.16.12.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:08:38 -0700 (PDT)
Message-ID: <c5af84f1-c88f-46eb-85e4-8cd50d8dc879@linaro.org>
Date: Wed, 16 Apr 2025 12:08:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 128/163] target/ppc: Use tcg_gen_addcio_tl for ADD and
 SUBF
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-129-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-129-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/translate.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index a52cbc869a..e082d50977 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1745,11 +1745,10 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
>                   tcg_gen_mov_tl(ca32, ca);
>               }
>           } else {
> -            TCGv zero = tcg_constant_tl(0);
>               if (add_ca) {
> -                tcg_gen_add2_tl(t0, ca, arg1, zero, ca, zero);
> -                tcg_gen_add2_tl(t0, ca, t0, ca, arg2, zero);
> +                tcg_gen_addcio_tl(t0, ca, arg1, arg2, ca);
>               } else {
> +                TCGv zero = tcg_constant_tl(0);
>                   tcg_gen_add2_tl(t0, ca, arg1, zero, arg2, zero);
>               }
>               gen_op_arith_compute_ca32(ctx, t0, arg1, arg2, ca32, 0);
> @@ -1948,11 +1947,9 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
>                   tcg_gen_mov_tl(cpu_ca32, cpu_ca);
>               }
>           } else if (add_ca) {
> -            TCGv zero, inv1 = tcg_temp_new();
> +            TCGv inv1 = tcg_temp_new();
>               tcg_gen_not_tl(inv1, arg1);
> -            zero = tcg_constant_tl(0);
> -            tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
> -            tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
> +            tcg_gen_addcio_tl(t0, cpu_ca, arg2, inv1, cpu_ca);
>               gen_op_arith_compute_ca32(ctx, t0, inv1, arg2, cpu_ca32, 0);
>           } else {
>               tcg_gen_setcond_tl(TCG_COND_GEU, cpu_ca, arg2, arg1);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


