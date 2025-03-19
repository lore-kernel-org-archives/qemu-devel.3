Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F371EC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuw8n-0000II-07; Wed, 19 Mar 2025 12:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuw8k-0000Cj-0r
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:19:34 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuw8X-0006rX-6O
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:19:33 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22403cbb47fso135850695ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742401159; x=1743005959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kJ9mPrkZ3QgkKl+eBkeiU9nIEsF8S3O9yZhbqtbaD8g=;
 b=a7tUAaRM/UW4dZ04QIvE2UFb8kxvC3+LWhmDrg1SFAal77tQ3Mt7IyGWxNiA6Eu4PS
 DBi/xTGnwtOajiUEzK+ex8mTyhKkqTNTaI/Y1Pi+efuCEmcSu7hloTg8B4v0tWSNLByi
 VDJbol6RYJAW88u9goNKgmqSRl0IlQ3+Zd6ktF0NGHeqN1XY/ZwLx9gjVU5d0ZTz/zoa
 8EUvjlJ8qsmTcKBRr0Ff8nNSm18X/YND9CdAD4ly05S9SgCcn0pdG2lujFl+Zh7v1AvN
 Zb2jigyufhr6VjsX3nNSEcCrAveVE33q0DDXYlfCBc66IDIElrB2P2TJkpdQrFiL4Npv
 kpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742401159; x=1743005959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kJ9mPrkZ3QgkKl+eBkeiU9nIEsF8S3O9yZhbqtbaD8g=;
 b=IlHNOSXn5LTeVMRJ2bv5WfxSclOfdjPZozBEnog93YXZPGmwV4z0VfwkHgz/zeC98V
 IysltfsKRocePTrMT/VvxjAbHi1h+Mu5sLoPBCRJSZuODG17gZCBGv/TPFpwwGiFngDk
 OIhEa52VqpcDLX7nNpqCrq2XmkVgXvRenk2LM8X6PSc3pf1dDrq5uKxF9a4YMKKMRVL1
 /QuknK5bChFBxp7btrGDy61z5XtPVKy6WlPKgaaezFc/BbGdDWVSBwnt3smheH/x231R
 +AlW4fUwGBzRSokm92t/nx5E2V8Wmf7w0OYrVvlApCs23duyLZLSYLEcJM3xIqgLA3hi
 Llmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7EeuW8DlLrlLe/V4LuZYSHZMbYS2FRmhttXuCXethnU4tLeodiORkudYIwLmncMSoWA2xN7Zk0uO+@nongnu.org
X-Gm-Message-State: AOJu0YwdZOAPa+PlgtTVj0/8Aaeuoj+myb3+q+gCd2ZydJbQ4cYqAWzG
 yaq98xv+JpWMSz0WgreN5QN0toAyxDTLyMuTVCgrnK7+STSCiunMfsLHLBYRaVo=
X-Gm-Gg: ASbGncteCjfBKcfHOw0t+tH1OaKZZT/QB3zcqxddSRwtWIX8WPsn1p8rWOWh/jmBACo
 SAeKrIiv7cqkV2SQtF1b2A9+oeKUIxZ1Jw+yrNi3Z6+nSYBJPSIEj5qjKHO73ChtFhUhGbzgRmC
 gf+wn0FC+S4kXFzhf0cLLbXewuLVPN8fsLl2ahmrLm152876DfxDpgsVdcD9EOxXpXda+DZ9EqO
 uZagttTo8mdF6ZWC0HmEnLvXScKQYJ4a05wTJtG5k3p1S+9K0XhxZsSGsA8DOAAGVN0Ztgfgb9+
 z2+yzZDV1ZUDG4g3VcAmM5C2mHyo4B05delHbTWLG+uZahy5p7lOgE2xURvc6WJUnUpdbceXlq8
 ZjPSp+Rpw
X-Google-Smtp-Source: AGHT+IHRhoCEgG0eudmIbwX89KmSqD/W/d9KDtKSrttcVKmam03TNNzm/xBU7wvyQ92Bxhdy8bNjsQ==
X-Received: by 2002:a05:6a21:a44:b0:1f5:86ce:126a with SMTP id
 adf61e73a8af0-1fbed40eb3cmr6102846637.40.1742401158852; 
 Wed, 19 Mar 2025 09:19:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737116955f1sm12202080b3a.142.2025.03.19.09.19.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:19:18 -0700 (PDT)
Message-ID: <5739e782-be27-4d64-b564-b7e07f5e616e@linaro.org>
Date: Wed, 19 Mar 2025 09:19:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 05/12] tcg: Use TCGContext::insn_start_words in
 tcg_gen_insn_start()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250319134507.45045-1-philmd@linaro.org>
 <20250319134507.45045-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250319134507.45045-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/19/25 06:44, Philippe Mathieu-Daudé wrote:
> In tb_gen_code() we set TCGContext::insn_start_words to
> TARGET_INSN_START_WORDS:
> 
> 290 TranslationBlock *tb_gen_code(...)
> 293 {
> ...
> 351     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
> 
> This definition is expanded to:
> 
>   11 # define TARGET_INSN_START_WORDS (1 + TARGET_INSN_START_EXTRA_WORDS)
> 
> Directly use the identical tcg_ctx->insn_start_words variable.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/tcg/tcg-op.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Nack.

We are specializing the function signature to the number of arguments.
There is absolutely no point in reading that number from a variable.


r~

> 
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index e0038e70a8d..1f0d3b95304 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -25,7 +25,7 @@
>   #if TARGET_INSN_START_EXTRA_WORDS == 0
>   static inline void tcg_gen_insn_start(uint64_t pc)
>   {
> -    unsigned insn_start_words = 1;
> +    unsigned insn_start_words = tcg_ctx->insn_start_words;
>       TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
>                               insn_start_words * 64 / TCG_TARGET_REG_BITS);
>   
> @@ -34,7 +34,7 @@ static inline void tcg_gen_insn_start(uint64_t pc)
>   #elif TARGET_INSN_START_EXTRA_WORDS == 1
>   static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
>   {
> -    unsigned insn_start_words = 1 + TARGET_INSN_START_EXTRA_WORDS;
> +    unsigned insn_start_words = tcg_ctx->insn_start_words;
>       TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
>                               insn_start_words * 64 / TCG_TARGET_REG_BITS);
>   
> @@ -44,7 +44,7 @@ static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1)
>   #elif TARGET_INSN_START_EXTRA_WORDS == 2
>   static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2)
>   {
> -    unsigned insn_start_words = 1 + TARGET_INSN_START_EXTRA_WORDS;
> +    unsigned insn_start_words = tcg_ctx->insn_start_words;
>       TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
>                               insn_start_words * 64 / TCG_TARGET_REG_BITS);
>   


