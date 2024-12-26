Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFB6E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 22:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQwA5-0006SS-FC; Thu, 26 Dec 2024 17:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQwA4-0006SI-Cz
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:16:56 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQwA2-0001jE-RX
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:16:56 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso6549495a91.0
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 14:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735251413; x=1735856213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DDgea+faHu8nOAYAgn6CXBeO93BHe1vSNxF2zIrxiIU=;
 b=wMP4Om0WD3b3FqoSkPDRa5sWhMcFzIeP8ijYJdNTzb0b4UpajubkEidCn56BR3ksr7
 O1Ok+7pt+jlpfNPne8TbdHhTH6xcTU+ehdmjJSsdFv7Tt4S3jU+bNHZnVDnK9i8806AD
 Z6qfBhkLHVhdRF0EpyI2dNVYRYFflSNNVb67Etoe7AuTv45QF9JJNxQweP0fdFg2DAcq
 JHLJKLrPHvpWoIF5WExBuBRMXVwzP7J9deawK1x03MM62b4ea6m9xW0Ce7+Z5L5Aua5x
 0ySjDQvLvNPzlrgndIAUvPrg1Vm9X9CM/4EkhKac9eRUYcImKDIz/jRmlDYn3YDuh/ly
 i8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735251413; x=1735856213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DDgea+faHu8nOAYAgn6CXBeO93BHe1vSNxF2zIrxiIU=;
 b=Lrp+GwQGyyn7RUNDRQNvflIOeb5RcaJF2Lr9ZAo6rVb1hr04AOtlX0B614mvpT5h9b
 qoaSGJAZpj8HnCxwGVfPsN535Zh7/JsaZZQrFyp/3duT2QSXiRgs1t3++iKOJITfx1Xd
 0JeF+gEScw9iyOJmz6xt81WA7QIPH57d6fWduz5X3iRXO7YiMv8rIItiLGqgnEjSWaNm
 HWDJIrZBy7qxfLhs1OLycsnXS/NLcYzDL2U0KWwV0XGVeIA4aXEN/cuxDkxm3LxdUosU
 sYVcJ0CBCwUv17eAu/H1tMzAzFKHGkDno4QM16kkFRdKJZnJ3UWBrgw38Gd+dQKjblBl
 aGhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX28/HP66ji24nW+PrGKodGSz7MxUdHHh2lueGujqmGTCAZAO2J4Mglwbiovyh9MvV2rT3EJdSgnh04@nongnu.org
X-Gm-Message-State: AOJu0YwfCKhIscXniFp2pBmxjYGCZAixukraJYjR4zjwH2wc4goRXYnY
 UVOCJdQZBMx2KRZHkLXzw6XP6782zM6zVQikK8JPHdoDlWXguo59YzJnd1OSRCM=
X-Gm-Gg: ASbGncuq2Hg4ij/Te+Kxc0UESJYQh7eq4QM6oqJS/9wd7GVjW4BtI06e19zrTjCxdLt
 wJuzv5uYqr6QKMlypoDjOH4kQVYdrZTLot5lF6nZ5p6494coXeKfBFAtg/6I7hdUnzbk6kk1oFv
 XyVAYiHG8sGaAugdbtSV1AmPyBRWjat6d8PaiNyDVdT4SebSRve6rWB2YnZIKFWTjJVlI9Y9OJt
 OKqC5rmkXI4kyQ1Aoj9mWrsg8borh+/Bs6b3d4FFa9tmO0LbBUgcQDa/KtPiqPJHuOxdK1ZJdR+
 eO/RnvJzdFuahRqHPQAFWSjzeQMPqKwQwE+8EH0=
X-Google-Smtp-Source: AGHT+IFS9Qxk+PWKCjFgJ/1qvbtCnFdtHAPhu6H0HVUpff8Tff0IdUANLx371e94kkH83vRRb1mQ8Q==
X-Received: by 2002:a17:90b:2d43:b0:2ee:c797:e27f with SMTP id
 98e67ed59e1d1-2f452eed977mr30922640a91.36.1735251413209; 
 Thu, 26 Dec 2024 14:16:53 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f4477ec656sm14311915a91.30.2024.12.26.14.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 14:16:52 -0800 (PST)
Message-ID: <f2f1f62d-def9-42ca-84d4-552b932d1ece@linaro.org>
Date: Thu, 26 Dec 2024 14:16:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/23] target/loongarch: Fix rdtimer on 32bit build
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-13-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-13-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 12/26/24 13:19, Jiaxun Yang wrote:
> Use TCGv_i64 for intermediate values and perform truncation as necessary.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/tcg/insn_trans/trans_extra.c.inc | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> index cfa361fecfa9ba569034b2c591b910ae7a3c6427..f9fb828ce51f2ee925edde7330d3054da534ecb3 100644
> --- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> @@ -46,13 +46,15 @@ static bool gen_rdtime(DisasContext *ctx, arg_rr *a,
>   {
>       TCGv dst1 = gpr_dst(ctx, a->rd, EXT_NONE);
>       TCGv dst2 = gpr_dst(ctx, a->rj, EXT_NONE);
> +    TCGv_i64 val = tcg_temp_new_i64();
>   
>       translator_io_start(&ctx->base);
> -    gen_helper_rdtime_d(dst1, tcg_env);
> +    gen_helper_rdtime_d(val, tcg_env);
>       if (word) {
> -        tcg_gen_sextract_tl(dst1, dst1, high ? 32 : 0, 32);
> +        tcg_gen_sextract_i64(val, val, high ? 32 : 0, 32);
> +        tcg_gen_trunc_i64_tl(dst1, val);
>       }

If !word, you are no longer assigning to dst1.
The trunc must be moved below if (word).


r~

