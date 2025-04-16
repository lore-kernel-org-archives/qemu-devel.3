Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE50C369C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 18:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u57zH-0004t8-39; Wed, 16 Apr 2025 14:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57zA-0004ja-LF
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:59:49 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57z8-0003PH-22
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:59:48 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22409077c06so310185ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 11:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744829984; x=1745434784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BCDEAVUt1dF+GeHW4nkB6H4k2LQMAJpTml+0qhhwaDg=;
 b=eSWcE1jfmuKx4s9CYxZQlQZAjHlHwkPGubwEMwxBoFtFoAQiAGeG2PTrJSlWM1Kcrf
 L39MfCrG3wRFWDbxvYw+Y0QR18fdr2OP0lD5kgHQqNtdSt5mlFbr4KX6fwt4oa98nYwY
 gsdU3zehlDeNpXZSIf7JsXpRlfYQJfJ6frpon9i3rKRb+CxhZQdlx9WARQmfSWccwW+m
 3l2bV6eJ+7IZaioqCBH1y1x6b6IVmii6lGteN4kR4UEKorZ/go0R/Hy2DDRuBZd9Z7yG
 SERnp0iLPLbpiTZ1CKVsEpJ9zn+eeNqsi1r+JXpVEza5LAmIHmgGrIzPXH9k15Kx8UCb
 ZRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744829984; x=1745434784;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BCDEAVUt1dF+GeHW4nkB6H4k2LQMAJpTml+0qhhwaDg=;
 b=lt5k5IZioQ/tUONuOmxGLGUmT336vjukliqZ+lGsmtbcy0PDfvU0VTyjoA/0C2EzB8
 CBXsMIMWsyUij4tRCqMZ2sc/AuLF6afiRqNx48YKtlHWiHFUy8E1jjZihLcKjnn3nM45
 uMY+Qv67xdijt33hVWG+cP16kxFroTFcGvQsKamzzVBmtMhivL5rJ1o4BgSJtbqLPeO3
 pxQVaU+rcAESy7t/BTtUeMmlJOHwy4jroAO656S7gMrcbfrHPxmwxHaon2ZqNxY4eERR
 hzeXkczrdKoAYyFkeoUXM3HQPI5gPFft10/ShBHAfN4u9FM7xsIhqeS8OMo+ipkY08DV
 YMDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfCmot9XFIxshMpowjjxBDPuctERj968xjbQ98uLWozSb0Y1YjGWJ/ZfapaoFlx04dXwBAwmXhT4Xm@nongnu.org
X-Gm-Message-State: AOJu0Yy14caDufbOEYktbT2aTL8Vt57IvV1RNRw/MjAT2TL65ylIDctc
 +kAYfXU71ashinNBlsNM1/X1mSY8hyuJ2L8RuzIQAXCP1ZNse7BUKDtWz90rkHs=
X-Gm-Gg: ASbGncsomls+6dNXhwlhQ+hhG/gbU9Ay/+HRjN4W/5wruhUsCcglKpeDFMfQZrYMT7B
 3mJpLz6sCBMfZXPwetPPVa4gQSzoqqlyYw5jenbWdiQPulvZGUi/1Uh/8hg+k9tbpcxYPEggfYg
 EhjYHT12DA0VfP6MbnDP7WIizpQYIjpgjEbPl/RJedbHxakttwJIfGScnrPikz+olywU097Jn5U
 D8WrqZs+mWpUSSsaHpQtG1ycZmDIrpd3fZt9/qw7gx5LJs9cJJ+D4NTaxSd3WfrdbQgPRRkZTjD
 6uuJmJYhf2Jc0yABwELJ4NWvnOU9FE5NVQqkdNhyZDWnVD8U7LbHQg==
X-Google-Smtp-Source: AGHT+IGgafRrgmZjq1Ou6xtJvJrUkg6J8Tvf6mXNcjrgnSIAEd6e/zeskg9pxCUB5GpH9swDxaYdug==
X-Received: by 2002:a17:902:f687:b0:224:2717:7993 with SMTP id
 d9443c01a7336-22c35986263mr43636775ad.45.1744829984549; 
 Wed, 16 Apr 2025 11:59:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fe6e1dsm17783645ad.236.2025.04.16.11.59.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 11:59:44 -0700 (PDT)
Message-ID: <48a155a6-accb-4086-b15c-f261ce5c326d@linaro.org>
Date: Wed, 16 Apr 2025 11:59:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 123/163] tcg: Add tcg_gen_addcio_{i32,i64,tl}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-124-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-124-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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
> Create a function for performing an add with carry-in
> and producing carry out.  The carry-out result is boolean.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h |  4 ++
>   include/tcg/tcg-op.h        |  2 +
>   tcg/tcg-op.c                | 95 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 101 insertions(+)
> 
> diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
> index 009e2778c5..b439bdb385 100644
> --- a/include/tcg/tcg-op-common.h
> +++ b/include/tcg/tcg-op-common.h
> @@ -135,6 +135,8 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
>                         TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
>   void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
>                         TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
> +void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
> +                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci);
>   void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
>   void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
>   void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
> @@ -238,6 +240,8 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
>                         TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
>   void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
>                         TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
> +void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
> +                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci);
>   void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
>   void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
>   void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index a02850583b..44914e9326 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -252,6 +252,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
>   #define tcg_gen_movcond_tl tcg_gen_movcond_i64
>   #define tcg_gen_add2_tl tcg_gen_add2_i64
>   #define tcg_gen_sub2_tl tcg_gen_sub2_i64
> +#define tcg_gen_addcio_tl tcg_gen_addcio_i64
>   #define tcg_gen_mulu2_tl tcg_gen_mulu2_i64
>   #define tcg_gen_muls2_tl tcg_gen_muls2_i64
>   #define tcg_gen_mulsu2_tl tcg_gen_mulsu2_i64
> @@ -370,6 +371,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
>   #define tcg_gen_movcond_tl tcg_gen_movcond_i32
>   #define tcg_gen_add2_tl tcg_gen_add2_i32
>   #define tcg_gen_sub2_tl tcg_gen_sub2_i32
> +#define tcg_gen_addcio_tl tcg_gen_addcio_i32
>   #define tcg_gen_mulu2_tl tcg_gen_mulu2_i32
>   #define tcg_gen_muls2_tl tcg_gen_muls2_i32
>   #define tcg_gen_mulsu2_tl tcg_gen_mulsu2_i32
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 447b0ebacd..b0a29278ab 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1123,6 +1123,33 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
>       }
>   }
>   
> +void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
> +                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci)
> +{
> +    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
> +        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> +        TCGv_i32 zero = tcg_constant_i32(0);
> +        TCGv_i32 mone = tcg_constant_i32(-1);
> +
> +        tcg_gen_op3_i32(INDEX_op_addco, t0, ci, mone);
> +        tcg_gen_op3_i32(INDEX_op_addcio, r, a, b);
> +        tcg_gen_op3_i32(INDEX_op_addci, co, zero, zero);
> +        tcg_temp_free_i32(t0);
> +    } else {
> +        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> +        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
> +
> +        tcg_gen_add_i32(t0, a, b);
> +        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, a);
> +        tcg_gen_add_i32(r, t0, ci);
> +        tcg_gen_setcond_i32(TCG_COND_LTU, t0, r, t0);
> +        tcg_gen_or_i32(co, t0, t1);
> +
> +        tcg_temp_free_i32(t0);
> +        tcg_temp_free_i32(t1);
> +    }
> +}
> +
>   void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
>                         TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
>   {
> @@ -2868,6 +2895,74 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
>       }
>   }
>   
> +void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
> +                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci)
> +{
> +    if (TCG_TARGET_REG_BITS == 64) {
> +        if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0)) {
> +            TCGv_i64 discard = tcg_temp_ebb_new_i64();
> +            TCGv_i64 zero = tcg_constant_i64(0);
> +            TCGv_i64 mone = tcg_constant_i64(-1);
> +
> +            tcg_gen_op3_i64(INDEX_op_addco, discard, ci, mone);
> +            tcg_gen_op3_i64(INDEX_op_addcio, r, a, b);
> +            tcg_gen_op3_i64(INDEX_op_addci, co, zero, zero);
> +            tcg_temp_free_i64(discard);
> +        } else {
> +            TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> +            TCGv_i64 t1 = tcg_temp_ebb_new_i64();
> +
> +            tcg_gen_add_i64(t0, a, b);
> +            tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, a);
> +            tcg_gen_add_i64(r, t0, ci);
> +            tcg_gen_setcond_i64(TCG_COND_LTU, t0, r, t0);
> +            tcg_gen_or_i64(co, t0, t1);
> +
> +            tcg_temp_free_i64(t0);
> +            tcg_temp_free_i64(t1);
> +        }
> +    } else {
> +        if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
> +            TCGv_i32 discard = tcg_temp_ebb_new_i32();
> +            TCGv_i32 zero = tcg_constant_i32(0);
> +            TCGv_i32 mone = tcg_constant_i32(-1);
> +
> +            tcg_gen_op3_i32(INDEX_op_addco, discard, TCGV_LOW(ci), mone);
> +            tcg_gen_op3_i32(INDEX_op_addcio, discard, TCGV_HIGH(ci), mone);
> +            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_LOW(r),
> +                            TCGV_LOW(a), TCGV_LOW(b));
> +            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_HIGH(r),
> +                            TCGV_HIGH(a), TCGV_HIGH(b));
> +            tcg_gen_op3_i32(INDEX_op_addci, TCGV_LOW(co), zero, zero);
> +            tcg_temp_free_i32(discard);
> +        } else {
> +            TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> +            TCGv_i32 c0 = tcg_temp_ebb_new_i32();
> +            TCGv_i32 c1 = tcg_temp_ebb_new_i32();
> +
> +            tcg_gen_or_i32(c1, TCGV_LOW(ci), TCGV_HIGH(ci));
> +            tcg_gen_setcondi_i32(TCG_COND_NE, c1, c1, 0);
> +
> +            tcg_gen_add_i32(t0, TCGV_LOW(a), TCGV_LOW(b));
> +            tcg_gen_setcond_i32(TCG_COND_LTU, c0, t0, TCGV_LOW(a));
> +            tcg_gen_add_i32(TCGV_LOW(r), t0, c1);
> +            tcg_gen_setcond_i32(TCG_COND_LTU, c1, TCGV_LOW(r), c1);
> +            tcg_gen_or_i32(c1, c1, c0);
> +
> +            tcg_gen_add_i32(t0, TCGV_HIGH(a), TCGV_HIGH(b));
> +            tcg_gen_setcond_i32(TCG_COND_LTU, c0, t0, TCGV_HIGH(a));
> +            tcg_gen_add_i32(TCGV_HIGH(r), t0, c1);
> +            tcg_gen_setcond_i32(TCG_COND_LTU, c1, TCGV_HIGH(r), c1);
> +            tcg_gen_or_i32(TCGV_LOW(co), c0, c1);
> +
> +            tcg_temp_free_i32(t0);
> +            tcg_temp_free_i32(c0);
> +            tcg_temp_free_i32(c1);
> +        }
> +        tcg_gen_movi_i32(TCGV_HIGH(co), 0);
> +    }
> +}
> +
>   void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
>                         TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
>   {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


