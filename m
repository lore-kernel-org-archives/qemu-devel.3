Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3A0CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utn8y-0006KN-3v; Wed, 03 Sep 2025 09:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utn8i-0006DP-G8
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:03:09 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utn8c-0000dX-A7
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:02:59 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-afeec747e60so1110389266b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756904576; x=1757509376; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y2G6yT4v+ABAnILA0GwJLFDR4TEqCFt7xBLFHKMc/cI=;
 b=X9q/Iut2rP2KTk0BbZ+O3yJcNKF7asAtFjJ79iOpYTIgpAZOT429kIwFxGX+08gjHX
 HsSWAUUrvuk/QOdEcXVVct3S0LpZQLh+bgKVWm43qwmQ8UEhpHuEyhYisGqGc6Y/pW/D
 36bPUXHvT9mhe++yWH8epCBYdFkPHDXrsgNzx1ix7VxLTSw1bsHp6/g6VaOKyhm2bCvK
 TvpLBkcdCmjQqSSC8XPEKzVsbQsEbV1SP/0n/HmvLB7I8RpczGKXvf4MnDTFGhlhKecE
 DGq+2+IkD1iz1WUsgwNKrsdOgVI9CkaVC+JjhChb012GCD0mKtSbxmoaNMYl5eD1KqXU
 pXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756904576; x=1757509376;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y2G6yT4v+ABAnILA0GwJLFDR4TEqCFt7xBLFHKMc/cI=;
 b=DG/rnagX+HpPuMuacBfhdUUO188qLDEOcG2gjVRY2eTC8wENZDt8hbXrDM/xjjwgQG
 ICvqEwJRZ734toxNuV8IDjbftLwhe1vZ/zWtkLwranoW3JW9Mlrb3Pkn8oveHvQwP2Op
 xaBMVyyEvGWj6bnJT6edfulTiDS3kKnZXwqPSmtL+ROD7HcsCMWY0VKZ1GCjk9FNuE6x
 niH097U6oz2qA92Xgi4ICOaZz2B6mWgsZOebho3P99Gq93xK77OYqPApJ5SU1qcTM0Oq
 Cnk8ltmjKTfZPYnMK3/3szhMqQUNm7vnu7RaHweSbS3XOWvaQi6tVq65I58jHkwNBBnG
 XliA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvhKrVYJWmOXhHQsccbj3vufAnWhLPwpnRjpJMSDii/h55ztM5Qg11R0JaPECm3cGeWgFiX7aHX5Wu@nongnu.org
X-Gm-Message-State: AOJu0YzHNkRPVHN4lDt4cfRBVYj0qGEbAgKWEaFdpd/JABRCXHwSvOej
 L8nmVOB1071dxLkaagnQJxmgvhg1RodyjMWGTEY7XDxaRpC2oe3HOaKakGLaAoLiwbw=
X-Gm-Gg: ASbGncvO2vTo4x5O3moHHao6pSoSRRXOaOJ309kIE0XM0HlaGYLphbWiZVbR4LTD5pQ
 4qrEyVa1qyL2OaLw94EuYm7gRWESr+hTPY9h+/3nM0O5oouFQiYk7ae7QD1yFOVt7FLj90TDwLx
 jy3CnQ8HN5M6QKzUzkCnIDybEJeLHyeBLd+Jf8hFWys6vCEqXn8p2CIKzAz0KCyFsecxGuk9+Xn
 XYXOsuOk0WqnaZFrAj8r5KzV/EA8bQtaAtc/8Q3B8FmrWG0iNJ8LQ0jrzVSVAXKRo8Dj97xLF0A
 Ybho5Ppgmke6RjdXRFZ0PcG1l3/+iw65Nz4S77FJ/72p3g98Yb9cpOqb8YvJ2W/BKFnTUVgytxD
 7HtK/AoSajZCY/5U8Ui8swskO0DNygdQ+eKmgMyTdCB18Gr1qrObGfEANbRNzCMNDTIMCi8/FgJ
 meuxtHvoZgeZTKkJ3I
X-Google-Smtp-Source: AGHT+IH6OUCwuNOxgsTxjqzxSpFzrvm32JRejCHqu4h2UJjbwkDe0FFr29oPFBMtAfNQ9k4KdiRaIQ==
X-Received: by 2002:a17:907:7242:b0:b04:5734:3b76 with SMTP id
 a640c23a62f3a-b045734438emr552338866b.24.1756904575652; 
 Wed, 03 Sep 2025 06:02:55 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b040a410817sm1007467966b.101.2025.09.03.06.02.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 06:02:55 -0700 (PDT)
Message-ID: <ad903d54-b4ee-47e6-bbc7-fe660409d374@linaro.org>
Date: Wed, 3 Sep 2025 15:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] target/loongarch: Use mmu idx bitmap method when
 flush TLB
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250903084827.3085911-1-maobibo@loongson.cn>
 <20250903084827.3085911-2-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903084827.3085911-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
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

On 9/3/25 10:48, Bibo Mao wrote:
> With API tlb_flush_range_by_mmuidx(), bitmap of mmu idx should be used
> rather than itself. Also MMU_KERNEL_IDX and MMU_USER_IDX are used rather
> than current running mmu idx when flush TLB.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 9365860c8c..d58f447555 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -101,8 +101,7 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
>       target_ulong addr, mask, pagesize;
>       uint8_t tlb_ps;
>       LoongArchTLB *tlb = &env->tlb[index];
> -
> -    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
> +    int mmu_idx = BIT(MMU_KERNEL_IDX) | BIT(MMU_USER_IDX);
>       uint8_t tlb_v0 = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, V);
>       uint8_t tlb_v1 = FIELD_EX64(tlb->tlb_entry1, TLBENTRY, V);
>       uint64_t tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);

Better to rename the variable too, since this isn't an mmu_idx.
We have used "idxmap" elsewhere for this purpose.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

