Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C6AE7718F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 22:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvz0-0001oz-Uv; Thu, 26 Dec 2024 17:05:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvyw-0001nJ-2T
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:05:27 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvyt-0000jy-9Z
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:05:25 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2166651f752so89696125ad.3
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 14:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735250721; x=1735855521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FEgb0biW9dIurVQepRtHWHwyaylKXhtaAJSsfHae740=;
 b=kEyGalvojqUO1ijgWuGNKIsY9dEaKlbb7RMKiCAerM53lYqwhTkvlf4UsMVtn8zSvR
 FNRkfJohbBbgamJvv6Om4ni8hSnVhlvWCGdxGDL7rYKCVsdOlR61seuMPtvqR6IV61rg
 /D/NX3QYtNcbqv8a/K38yJljZLSuX2X65V+waLyIajebTxBmzfJJaGlXgPWqpXYj5tXv
 NXRJDz00KcB3mFMyDZq07F1MKeh7vIfJxEYS9gFcw8ecMggKjJhb6GzMSN7wFNC6RFP1
 EIxLLHQWHe1PK5cqh1rf1vNpVu7h62XlVUPTpb64DCBhKhrdQmLSUcyZ8DsU7ePoRXFr
 yUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735250721; x=1735855521;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FEgb0biW9dIurVQepRtHWHwyaylKXhtaAJSsfHae740=;
 b=TWC3ZD9FkhYcb63khQW1bAuVA7T2tKD1uAe1ZFKZUMmzOAdNejjlzi9GhWrjonIeaV
 UVvEm2cEG/AVEv1Bm6n0SalT/GOcijvZCoET43pSum4FTm5w92t3MmU4ga2219/1xWBn
 xTUE+C5vqM4FQp/dsonlBzColiqMeB4su7meb9Q4znpENe/tiaWS2evobEmFKOCszXsJ
 E4GYHLPckUnb7C89lHu4NFJPkN434y6kmYpT3OZgwhhPk+nAnikT7oTUKH7mtqQnC6Yi
 42cZFV0i+uZrV7aH2FWFVzPKSDyUGKljua0hNDyo3F61gvu3ifKXhJ9QAWYq4vFybZNR
 lr0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKpazyydW4qTC94WMzC7NS0+tNR7AzB8NJJQv2x2rsPO1JGCD2zP0Jg7Wl0973jK7fH7utOCpQHxDi@nongnu.org
X-Gm-Message-State: AOJu0YyCMNhSHeIhMCuttEE1a3YBleIVVHblxdaWVh02GOBwEBdS48ob
 hcHqQvjGNOEQndp9gXMA+E8lgWLd6/kRHmVQR89wXtRyvVeZw9gZxcJWz0VpQ9c=
X-Gm-Gg: ASbGncux1deR96dyx0Kw5rGg/JgBpH3jCpvuaTFgNydliQ7opPlv/aLzg1omQS0jixr
 t9qLy377maoqCLKPaRYU8TVtUvsYbK5M+mbOPR01LBgL2ZpophF5a9KAc3m42YrM6ALkaWJlIVt
 dnjiJl38iSU3xl8YZ5N87ug6guEGXPtG+nfKElnG6o+k8XL5/cDbOMyc1abh8YaEoaM0egH6Tgd
 fNEjZAr9IcWSTp0/HvSLm0zorZbEtuhujj4Y1w1Su88pWnylKKHA+YhoCCMrPlXpnDTYuWfLzk6
 eU1QSmnIcjGalxynwFTnk1oLQrHnAyxot8g5jPs=
X-Google-Smtp-Source: AGHT+IEWasJNFbzncPBfyWROiNcML1v95QTiDcSWd5NSsEXc7AYz7SDR4t3oQsNbO9oqjo781dlWhg==
X-Received: by 2002:a05:6a20:7343:b0:1e1:90bd:21a0 with SMTP id
 adf61e73a8af0-1e5e081f33cmr38563406637.42.1735250721568; 
 Thu, 26 Dec 2024 14:05:21 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad90c173sm13338940b3a.192.2024.12.26.14.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 14:05:21 -0800 (PST)
Message-ID: <a74f8580-ca9d-455d-991f-19a5b5822ef9@linaro.org>
Date: Thu, 26 Dec 2024 14:05:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/23] target/loongarch: Scrutinise TCG arithmetic
 translation for 32 bit build
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-14-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-14-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
> mulh.w and mulh.wu are handled with tcg_gen_muls2_i32 and tcg_gen_mulu2_i32
> to adopt different TARGET_LONG size.
> 
> min value of divisor is generated from TARGET_LONG_BITS to adopt different
> long size as well.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/tcg/insn_trans/trans_arith.c.inc | 25 +++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_arith.c.inc b/target/loongarch/tcg/insn_trans/trans_arith.c.inc
> index 2be057e9320a9b722c173b0352e1631543147d68..a2360c5fdd2003ca0e458743348e687987f421d4 100644
> --- a/target/loongarch/tcg/insn_trans/trans_arith.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_arith.c.inc
> @@ -92,8 +92,24 @@ static void gen_sltu(TCGv dest, TCGv src1, TCGv src2)
>   
>   static void gen_mulh_w(TCGv dest, TCGv src1, TCGv src2)
>   {
> -    tcg_gen_mul_i64(dest, src1, src2);
> -    tcg_gen_sari_i64(dest, dest, 32);
> +#ifdef TARGET_LOONGARCH64
> +    tcg_gen_mul_tl(dest, src1, src2);
> +    tcg_gen_sari_tl(dest, dest, 32);

Leave the _i64.

> +#else
> +    TCGv_i32 discard = tcg_temp_new_i32();
> +    tcg_gen_muls2_i32(discard, dest, src1, src2);
> +#endif
> +}
> +
> +static void gen_mulh_wu(TCGv dest, TCGv src1, TCGv src2)
> +{
> +#ifdef TARGET_LOONGARCH64
> +    /* Signs are handled by the caller's EXT_ZERO */
> +    gen_mulh_w(dest, src1, src2);
> +#else
> +    TCGv_i32 discard = tcg_temp_new_i32();
> +    tcg_gen_mulu2_i32(discard, dest, src1, src2);
> +#endif
>   }

Otherwise, these two are fine.

>   
>   static void gen_mulh_d(TCGv dest, TCGv src1, TCGv src2)
> @@ -113,6 +129,7 @@ static void prep_divisor_d(TCGv ret, TCGv src1, TCGv src2)
>       TCGv t0 = tcg_temp_new();
>       TCGv t1 = tcg_temp_new();
>       TCGv zero = tcg_constant_tl(0);
> +    target_long min = 1ull << (TARGET_LONG_BITS - 1);
>   
>       /*
>        * If min / -1, set the divisor to 1.
> @@ -121,7 +138,7 @@ static void prep_divisor_d(TCGv ret, TCGv src1, TCGv src2)
>        * This avoids potential host overflow trap;
>        * the required result is undefined.
>        */
> -    tcg_gen_setcondi_tl(TCG_COND_EQ, ret, src1, INT64_MIN);
> +    tcg_gen_setcondi_tl(TCG_COND_EQ, ret, src1, min);
>       tcg_gen_setcondi_tl(TCG_COND_EQ, t0, src2, -1);
>       tcg_gen_setcondi_tl(TCG_COND_EQ, t1, src2, 0);
>       tcg_gen_and_tl(ret, ret, t0);

This is ok, but s/prep_divisor_d/prep_divisor_tl/.
Without the rename, this change would appear to affect correctness.

In addition, gen_{div,rem}_w will need to use prep_divisor_tl instead of prep_divisor_du.


r~

