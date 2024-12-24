Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD56AE7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 01:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPtjJ-0004Wh-Lw; Mon, 23 Dec 2024 20:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tPtjF-0004WK-Tf
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 20:28:58 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tPtjE-00021q-1h
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 20:28:57 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so53346375ad.0
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 17:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735003734; x=1735608534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vuVPMIGlpVw9+dL5VBg3Geq49iODNqiO+bQW6XoXBzY=;
 b=uyoqt/fUVVEMsixgmz2Ph/BEKIaVIlWnZfu6hI+ZymClLxILVTjGFh3fCdVv9iirA+
 mO7f/K1khC0RDRcxS1QabXFabLAAYCKJDjTSLDlgX8TeVkpJcbojtZXSzRfZUmmv6XP7
 y3Wtz5kr66oUhUSd4g7hhF3HKtrGIVYQZjl4ITysnBpG2WN/V6qB7pdz+zf8ne8olWEq
 EdUqFxVVHT9sAeofQ2M8nRf+LrcB5aA8bbnyFSxp4VWlMFCaZX1DD8J0fScrW4IG9Cjj
 YIIiKlnGNN+JxYbemHZSBLtbd3Mfna/B+fc/ACqDT0q5Eod8C0kYGstBnP+nhF131Agf
 11/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735003734; x=1735608534;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vuVPMIGlpVw9+dL5VBg3Geq49iODNqiO+bQW6XoXBzY=;
 b=hm8K0+ktUYRJwVT+RpCfsH0KKwhdJYwy+pCdZUQvscaipLLy78j9fCzlvvFbOeqOO3
 hQWZaXr4O0kT7paMvpb/opGUqDS7jJo4naZqi25zE6NcQkxud/naVNFl5VmmtboJ8rRS
 xFKqOog8YUsw3zRXWQdQfsHIaz+ubpJ3mXKwYUR0l+2HvDaqGqW9kjJJe6T4TL60gMjs
 Hq1z9r6n+ieczBhLc18fZmdddLH1vkJrMhMc70kO8u/k8IF0A3iZO7YAFw2NsWju3Nw2
 2aRADUB90xu9s7fdmgOyVKozbwVe1fHQgX3eQTdtREJ2HhpvqHGKD9jnR/exs/IWGDEc
 rzvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7CrNY+xncyU5+CcEi+w8isR7jFftTdEKwCfr+x8L3+7dFvtOlgzff2CTzgQy0u1bisNnmGFWYq6Q0@nongnu.org
X-Gm-Message-State: AOJu0YyLXOJkFi0HrSXwb/GmVkux8k9mam8YzTIEAJgMkNGDTtV+Ae4O
 TANA8kaY9dC/UmIiuFKQmtgsMS9yhklqv8FCm95jRCpBkqEIYZLqrP9eOsVRH01csR1guFsABYk
 F
X-Gm-Gg: ASbGncsaRAOyHCi2WGEl8CRldx65T0notxUDvJWgo17aqAab66kCJ5fwKTJSUM9b2Di
 tme3QjEXEVwYqhamMuGNKZsmtOo6cg6KvIzzQab0t6bCWxhL9X+vw8bD4XXDXVhHCvkSMJ0Ft1Y
 QGkVBz4i5vwFgk9mYyo3+uZXsCwN/PGFqeljrm4yd3/2iwAJ50C52nA2/vkcgTjyU8XeGvGScSM
 t8ZhGBNJqf7CwZ8UeBfjXodkyifYQyEWK1VnDhJUXwwbXXfJJNw+z1UqT01V8AxoVC35g==
X-Google-Smtp-Source: AGHT+IFKZCU9ghdS6sUee7Ob2MGj587qdOXaAAYw874HFIps+c2GJeyT4jf7F4B9eUepYKMdn2Ddbw==
X-Received: by 2002:a05:6a20:a122:b0:1e1:b220:63db with SMTP id
 adf61e73a8af0-1e5e1f56b34mr24306751637.16.1735003734228; 
 Mon, 23 Dec 2024 17:28:54 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8163fdsm8562458b3a.6.2024.12.23.17.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2024 17:28:53 -0800 (PST)
Message-ID: <f4a9764f-2a1c-4ccb-97fc-2e445571ed9c@linaro.org>
Date: Mon, 23 Dec 2024 17:28:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/51] tcg/optimize: Change representation of s_mask
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
 <20241222162446.2415717-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241222162446.2415717-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 12/22/24 08:24, Richard Henderson wrote:
> Change the representation from sign bit repetitions to all bits equal
> to the sign bit, including the sign bit itself.
> 
> The previous format has a problem in that it is difficult to recreate
> a valid sign mask after a shift operation: the "repetitions" part of
> the previous format meant that applying the same shift as for the value
> lead to an off-by-one value.
> 
> The new format, including the sign bit itself, means that the sign mask
> can be manipulated in exactly the same way as the value, canonicalization
> is easier.
> 
> Canonicalize the s_mask in fold_masks_zs, rather than requiring callers
> to do so.  Treat 0 as a non-canonical but typeless input for no sign
> information, which will be reset as appropriate for the data type.
> We can easily fold in the data from z_mask while canonicalizing.
> 
> Temporarily disable optimizations using s_mask while each operation is
> converted to use fold_masks_zs and to the new form.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 64 ++++++++++++--------------------------------------
>   1 file changed, 15 insertions(+), 49 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index d8f6542c4f..fbc0dc5588 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -52,7 +52,7 @@ typedef struct TempOptInfo {
>       QSIMPLEQ_HEAD(, MemCopyInfo) mem_copy;
>       uint64_t val;
>       uint64_t z_mask;  /* mask bit is 0 if and only if value bit is 0 */
> -    uint64_t s_mask;  /* a left-aligned mask of clrsb(value) bits. */
> +    uint64_t s_mask;  /* mask bit is 1 if value bit matches msb */
>   } TempOptInfo;
>   
>   typedef struct OptContext {
> @@ -65,49 +65,10 @@ typedef struct OptContext {
>   
>       /* In flight values from optimization. */
>       uint64_t z_mask;  /* mask bit is 0 iff value bit is 0 */
> -    uint64_t s_mask;  /* mask of clrsb(value) bits */
> +    uint64_t s_mask;  /* mask bit is 1 if value bit matches msb */
>       TCGType type;
>   } OptContext;
>   
> -/* Calculate the smask for a specific value. */
> -static uint64_t smask_from_value(uint64_t value)
> -{
> -    int rep = clrsb64(value);
> -    return ~(~0ull >> rep);
> -}
> -
> -/*
> - * Calculate the smask for a given set of known-zeros.
> - * If there are lots of zeros on the left, we can consider the remainder
> - * an unsigned field, and thus the corresponding signed field is one bit
> - * larger.
> - */
> -static uint64_t smask_from_zmask(uint64_t zmask)
> -{
> -    /*
> -     * Only the 0 bits are significant for zmask, thus the msb itself
> -     * must be zero, else we have no sign information.
> -     */
> -    int rep = clz64(zmask);
> -    if (rep == 0) {
> -        return 0;
> -    }
> -    rep -= 1;
> -    return ~(~0ull >> rep);
> -}
> -
> -/*
> - * Recreate a properly left-aligned smask after manipulation.
> - * Some bit-shuffling, particularly shifts and rotates, may
> - * retain sign bits on the left, but may scatter disconnected
> - * sign bits on the right.  Retain only what remains to the left.
> - */
> -static uint64_t smask_from_smask(int64_t smask)
> -{
> -    /* Only the 1 bits are significant for smask */
> -    return smask_from_zmask(~smask);
> -}
> -
>   static inline TempOptInfo *ts_info(TCGTemp *ts)
>   {
>       return ts->state_ptr;
> @@ -173,7 +134,7 @@ static void init_ts_info(OptContext *ctx, TCGTemp *ts)
>           ti->is_const = true;
>           ti->val = ts->val;
>           ti->z_mask = ts->val;
> -        ti->s_mask = smask_from_value(ts->val);
> +        ti->s_mask = INT64_MIN >> clrsb64(ts->val);
>       } else {
>           ti->is_const = false;
>           ti->z_mask = -1;
> @@ -992,7 +953,6 @@ static void finish_folding(OptContext *ctx, TCGOp *op)
>            */
>           if (i == 0) {
>               ts_info(ts)->z_mask = ctx->z_mask;
> -            ts_info(ts)->s_mask = ctx->s_mask;
>           }
>       }
>   }
> @@ -1051,11 +1011,12 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
>    * The passed s_mask may be augmented by z_mask.
>    */
>   static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
> -                          uint64_t z_mask, uint64_t s_mask)
> +                          uint64_t z_mask, int64_t s_mask)
>   {
>       const TCGOpDef *def = &tcg_op_defs[op->opc];
>       TCGTemp *ts;
>       TempOptInfo *ti;
> +    int rep;
>   
>       /* Only single-output opcodes are supported here. */
>       tcg_debug_assert(def->nb_oargs == 1);
> @@ -1069,7 +1030,7 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
>        */
>       if (ctx->type == TCG_TYPE_I32) {
>           z_mask = (int32_t)z_mask;
> -        s_mask |= MAKE_64BIT_MASK(32, 32);
> +        s_mask |= INT32_MIN;
>       }
>   
>       if (z_mask == 0) {
> @@ -1081,7 +1042,13 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
>   
>       ti = ts_info(ts);
>       ti->z_mask = z_mask;
> -    ti->s_mask = s_mask | smask_from_zmask(z_mask);
> +
> +    /* Canonicalize s_mask and incorporate data from z_mask. */
> +    rep = clz64(~s_mask);
> +    rep = MAX(rep, clz64(z_mask));
> +    rep = MAX(rep - 1, 0);
> +    ti->s_mask = INT64_MIN >> rep;
> +
>       return true;
>   }
>   
> @@ -1807,7 +1774,7 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
>   
>       ctx->z_mask = z_mask;
>       ctx->s_mask = s_mask;
> -    if (!type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
> +    if (0 && !type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
>           return true;
>       }
>   
> @@ -2509,7 +2476,7 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
>       s_mask |= MAKE_64BIT_MASK(len, 64 - len);
>       ctx->s_mask = s_mask;
>   
> -    if (pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
> +    if (0 && pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
>           return true;
>       }
>   
> @@ -2535,7 +2502,6 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
>           ctx->z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
>   
>           s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
> -        ctx->s_mask = smask_from_smask(s_mask);
>   
>           return fold_masks(ctx, op);
>       }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


