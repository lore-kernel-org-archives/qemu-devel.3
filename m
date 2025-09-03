Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6FECA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utn2L-0001Sx-1E; Wed, 03 Sep 2025 08:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utn2J-0001SD-6X
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:56:27 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utn2H-0004fz-C4
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:56:26 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-61cbfa1d820so12986620a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756904183; x=1757508983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9INEzjDw25wZ/WqxSioxyyZpgtayqnXYVa2BJ+rRogc=;
 b=Pe6rxN0VDh+JdZ3vvXy9Y1+aY1bFVLTzYNxuAu5uERhkLoiv0D4z8a43+GEd0pM9g1
 W3L6htsV/tdnlCcWXLzDx/4P53vYSTUeTvizHX5H+R4J1I6OwRmvx0h6ybI5Jf22peZF
 wArEtGrGs6Qkl10jcVxsx9us5ZVmzek5UajnUNhUzMg0897+8xCdrHxny2Ez3miIBrwB
 dOUda9ilEINVnpBLDGzcgE+rI3NE02TqvGcgW/wOD/CTOwAxMonSi6tqoEuYwmubkroe
 UjI/r3JDeK1Oe2o5jfsYK8BySagua1C2qRTaYLoWWUVYD7FLY8no6V105SomkRy06JSi
 p5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756904183; x=1757508983;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9INEzjDw25wZ/WqxSioxyyZpgtayqnXYVa2BJ+rRogc=;
 b=obVUjC8xEkI7cV072XK7dKtJnHQlsfE6zoxOvNAgE+Lu5we0StXrTq1rBiKbcQkHFr
 D1IX27/bMT5pd2WsyefqFel4g2gLuY59oHv+Gp4jOzelwn9RWQ8N7t+7prOp+aLppOrD
 axQ7UQ4L7/ltPNr4y3qIEDBVnwQMSAJt9JBg3HUZHYQP5KKfM47NdmQ3QGb3yge83BNy
 kpKOB1CoJUhY+CYroMY7sGa+5j7foBYokHXdkHQbZ7mmARVT9JJ5ghv0+tS4P91IwcLP
 UmX1Ear8mNe+mUnApM33Tp8Ci5xH2i2ECkoLD0gvAhrUag+YgqR/p5htM8yIqPeT+wRS
 muPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGRKIgpByFrRTy3qY/QZ8bG67bLSRw2XgCQTXvXdOEdQS0Ja+S7dz9RAk4Gvr24t8DyoKBLFRI93CQ@nongnu.org
X-Gm-Message-State: AOJu0YwRszFA41/GB5l4EC8SqWNeiTdvpPpA66ZCLYY3NlehgCgEFtrQ
 ARxtExTRRn+p6538dn+DRRqBnuWA93UQkqBYrsKbKSrYd1282zxsZj/VV1pvd7b/R2A=
X-Gm-Gg: ASbGncvXF9WndFaKiAUZE8dvDeDR/9PJBVNbuhhIQrRpEGCaVwYx/wGdQMWrLcY5Jd6
 X5Pbs2IXxh6Ac7xwIM0uenQ7hSghvhhURlZV5U5VZ/GxLRIt3o/0aiV+ZzcwRewoXIZN7iGM2xv
 2SKFvhdYmOlLRkwGP8RgRjuBKy9fQSKzfgC1wsLq6J19bAM2EwFJF6XXTLMuOpqDj2c99JEkLFq
 C8HE82Ca3cABw4U0qJcNYQEHDVf6fNmVe2Z/fRylX5EMhkCxUdd6lJDcaMdb00FFC/laxvmIiWA
 /36+9paiwf0qatdi8YSx+W2ekXp2Tl1IpbVVub0r71k7O2m/BQMEuzvRqUyX40m/x4PIEj98aCd
 uw/pMBd67XBsTAyrZ971ToXiuo6g2lZijJPpFYrZhy30JXnrP7maqJU7BM0ylLhJs3kmtJtI=
X-Google-Smtp-Source: AGHT+IE9Wh249uYD8nTL+7ILkiNdAfcA/YBTyGtJ1IU6MDMeIbhqeOOFzt9CpKibWOHFGQxgwLnMxg==
X-Received: by 2002:a05:6402:27ca:b0:61c:5a8c:9a4e with SMTP id
 4fb4d7f45d1cf-61d2699752fmr14195369a12.4.1756904183501; 
 Wed, 03 Sep 2025 05:56:23 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc4e4d77sm12023601a12.37.2025.09.03.05.56.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:56:23 -0700 (PDT)
Message-ID: <37a1af69-0850-4b2f-b2bd-a9c99de3d68d@linaro.org>
Date: Wed, 3 Sep 2025 14:56:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] target/loongarch: Only flush one TLB entry in
 helper_invtlb_page_asid()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250903084827.3085911-1-maobibo@loongson.cn>
 <20250903085401.3086110-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903085401.3086110-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x532.google.com
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

On 9/3/25 10:54, Bibo Mao wrote:
> With function helper_invtlb_page_asid(), only one TLB entry in
> LoongArch emulated TLB is invalidated. so with QEMU TLB, it is not
> necessary to flush all QEMU TLB, only flush address range specified
> LoongArch emulated TLB is ok. Here invalidate_tlb_entry() is called
> so that only QEMU TLB entry with specified address range is flushed.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 017c0d2f5b..de0bbbb6b1 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -541,7 +541,6 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
>                                target_ulong addr)
>   {
>       int index, asid = info & 0x3ff;
> -    LoongArchTLB *tlb;
>       tlb_match func;
>       bool ret;
>   
> @@ -551,9 +550,7 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
>           return;
>       }
>   
> -    tlb = &env->tlb[index];
> -    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
> -    tlb_flush(env_cpu(env));
> +    invalidate_tlb(env, index);
>   }
>   
>   void helper_invtlb_page_asid_or_g(CPULoongArchState *env,


