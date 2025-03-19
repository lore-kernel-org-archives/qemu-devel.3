Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69348C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuw7k-0007ec-73; Wed, 19 Mar 2025 12:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuw7c-0007ZJ-PR
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:18:26 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuw7X-0006Y8-4C
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:18:23 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2240b4de12bso50769015ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742401094; x=1743005894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mmVvwZxPZXPaH+rMioC1tIGm3m1gapEOP4E5AKWCXPg=;
 b=F4zIUR1PBjntoJudVa9Wdc/rZrR2FJGgJFjP1YZkTDmOyDPkR4SSCsQoNDXM+cBqoM
 6Jn+8AQEH2Ia1AYr/YhYOsizEc14+ZALJQ0aRf/l04ZFoW0kVwV5mk3a9Iq3u/tzUhEK
 4IaXNXxFGyVZzNqEdUXF9ckgZxUMFt2mUNWtXSPm5R3RLt8zEOemUBzgXIxL7VLmJ/p8
 t/BwdLsVrJ1/ZgXRdgaeTHknDbUvyvYXED94PwrL/8AHXgiSRFAgY5jo7HFbK9Bnd6Hl
 /GU8nvQ9HSkdtmsgWIYPSrX1VQxwUPmyxoSAjxQG+TXv1pZeN3nH1ndFJIc/5qeoXDcq
 /6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742401094; x=1743005894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mmVvwZxPZXPaH+rMioC1tIGm3m1gapEOP4E5AKWCXPg=;
 b=a7LkL9MuKpzNSHeftD4GtmallPaiKYOeyS/WiNfMKT7epVR4+JEHy4nf3YYjYjsMIs
 3Xlvh8u1Mmgxgl3qAQIvWgAiwBRkzjk83WVeAGOdT/vj/gHDDjxRHVh1QBU1U4qcoXZY
 ORUU6tR8u3W2zo2uTTUQg4kK75B6d6ueLKw7GvomTvv4eYYRkdETAon48GwYBWog/zo7
 SBu9lyKchthk+8UliFJVvbBGh4kwejAWzTPt97q01JarT+jg0npuWVYAB+x2cqmr33zB
 Z1FqGAI35squGNMp9OwRabRwFbNFPZD0N7ZvdKLPt5lJYA76Idlk3JXGVKmNN+lx0UCD
 37pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/At7snLGlfhTHI6X+a0YpJQZW+oIlIAi3ly6Ji2SLwcQdlw2zX/hQ5K5VkLnTZJUIr7w7/31m0Kp9@nongnu.org
X-Gm-Message-State: AOJu0YwFi58opaKI3Z6zNmm9pNr/Mv6oLOOK9xSuDNzm2LaqbdI9264G
 96E6c2N/P/tUkev+0Au6qcpJzkX6jJhoNTKjQG9/N7K37m3S/87m9YeBt1LsA+8=
X-Gm-Gg: ASbGncumN6XImcbGH9RYx3M8Xq5STFk+ZCP8C39trGCg6NyB6/XLK3FxqivSRMKxs3N
 u1VOuOJxiuHQ+FQGKxtrF8aWdfuXXrfjwPmmRjimYuqMtlXLFC2V1ZD1iNoKq3yDTDkX34lHSFM
 UGc6u63dT0CVYE4Fgq78IW64ot8wG62NVoDlat3eslYHaE/NSZYkSQaSijbV3DGy5YsbKR1njb5
 Mi4qQv3BtYfEOJ/bnZz9u8CyChROXXPpvM+vAQc35O2sEOkV8tvndyYKirsxX2Eo+2+513ntaO3
 jP8es22Vyq79kQeJphLzyFYmBCW+Ne3edn1gef4GWOiHYNrjlmOP9m1PG3SYTrBSYDtzV02zbW5
 ZKm6xt71j
X-Google-Smtp-Source: AGHT+IGBMUh0tyfa+/5pZFs/p5idfHTusjMU7/pm0hnKGK0m6iN8VsR40XLMJumX5/Dzl8nU3970BQ==
X-Received: by 2002:a17:902:eccc:b0:224:c46:d166 with SMTP id
 d9443c01a7336-22649a59b28mr58898375ad.40.1742401094404; 
 Wed, 19 Mar 2025 09:18:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c688857esm116747085ad.17.2025.03.19.09.18.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:18:14 -0700 (PDT)
Message-ID: <fc5e61e6-b3fe-49e0-b55a-955acf2496e8@linaro.org>
Date: Wed, 19 Mar 2025 09:18:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 04/12] tcg: Declare local 'insn_start_words'
 variable in tcg_gen_insn_start()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
 <20250319134507.45045-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250319134507.45045-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/19/25 06:44, Philippe Mathieu-Daudé wrote:
> In order to keep following commits simple, introduce the
> 'insn_start_words' local variable in tcg_gen_insn_start().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/tcg/tcg-op.h | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)

I think there's no point in this, or the follow ups vs this block of code.


r~

> 
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index 8938f386599..e0038e70a8d 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -25,20 +25,29 @@
>   #if TARGET_INSN_START_EXTRA_WORDS == 0
>   static inline void tcg_gen_insn_start(uint64_t pc)
>   {
> -    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 64 / TCG_TARGET_REG_BITS);
> +    unsigned insn_start_words = 1;
> +    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
> +                            insn_start_words * 64 / TCG_TARGET_REG_BITS);
> +
>       tcg_set_insn_start_param(op, 0, pc);
>   }
>   #elif TARGET_INSN_START_EXTRA_WORDS == 1
>   static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
>   {
> -    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 2 * 64 / TCG_TARGET_REG_BITS);
> +    unsigned insn_start_words = 1 + TARGET_INSN_START_EXTRA_WORDS;
> +    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
> +                            insn_start_words * 64 / TCG_TARGET_REG_BITS);
> +
>       tcg_set_insn_start_param(op, 0, pc);
>       tcg_set_insn_start_param(op, 1, a1);
>   }
>   #elif TARGET_INSN_START_EXTRA_WORDS == 2
>   static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2)
>   {
> -    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 3 * 64 / TCG_TARGET_REG_BITS);
> +    unsigned insn_start_words = 1 + TARGET_INSN_START_EXTRA_WORDS;
> +    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
> +                            insn_start_words * 64 / TCG_TARGET_REG_BITS);
> +
>       tcg_set_insn_start_param(op, 0, pc);
>       tcg_set_insn_start_param(op, 1, a1);
>       tcg_set_insn_start_param(op, 2, a2);


