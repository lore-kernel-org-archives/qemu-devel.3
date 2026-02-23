Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2464EA4FAE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuU34-0006ch-Nn; Mon, 23 Feb 2026 06:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vuU31-0006cQ-5e
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:24:19 -0500
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vuU2x-0000Od-Dk
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:24:18 -0500
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2ba9d13f10eso6691443eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 03:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771845854; x=1772450654; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NoyDrkWrjFAgYPx1W0Hxl4HBIQnq1Ru8TpIZSja3fmk=;
 b=Q1N+WxysNyEz/89xXtJQ6Ex/ZXo4X8GAkhHKyYRgbDrgG7gYskpZ1qau0VcruSQt4o
 lVyriFglXGmeqBvmLbJMubkmYdvt3KQrU/D1qnJV587bjxVENYGFnDgh1VRvLH+BLDQ+
 h6JJhdMFmWdp8oslbGlEHwUqFD8YPqSNjZrk6DxrqFJj9O+JDZxY6pIeJz3JlcGruz3j
 4EeFfPZ9CqyRn3XhWuzAhgr1SM1skdMyyQCWgtEm1udt/Y94OvKS01e1PsUm6bbnuQl3
 0Uo4cLIQj9/tzUjY9EAVI9VpTRT3M7ak8JdFTYigcFuPj2MBnUG0bWJQdlstBB6Rh0W8
 auCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771845854; x=1772450654;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NoyDrkWrjFAgYPx1W0Hxl4HBIQnq1Ru8TpIZSja3fmk=;
 b=n7GoRWIhiKWrWuUnQKCjeUObnFJtmZ83gAyODP+nOxX6uhppMiNMKX3E5Io/8mbPR8
 a2IFNHkrmKc38reBKe/iY0e6NuYzCqrN7l4rQ449Af6IyOoe8oTidHnxEd5hPS/omkh0
 8wAiAwYPM8mLvynRY1F5tZelG/y0Io/bv4z5i+dmF9YMP8DoCzklkeiHVgKZfE24k/mA
 T8EUrh2B5Gt+I4FdPycwQzlKwVawrD/zCRCFqOjjLecH6apiUFKrLdXjdmOMjtTMd/gu
 dLQW6bbSbXSoPK49AJhs0WCI6ZoNeHgYJZsm5jTCBURB9owJ17RWAKGYn6TKpDvQuArv
 AVsw==
X-Gm-Message-State: AOJu0YxAp5f5yHTMmGs80ebWpS6PzWz7LvykvcaJDQRLddFvMQm+OCHE
 6qMNCRDBR8Mcaa+MzdfMtg4sgZHt3RP8J0E2vKkHvyBLP4qSV1IFM6R0
X-Gm-Gg: ATEYQzzYydMHklpbsqIbFVJQiA/k39dwnjwZA/5WvBAJifU1/OEujKNQTR4fegBnL5E
 5aicV3d8P6ERzgTgct9a3m4LT7S2YTkhka/U0/Pb97HBQ5w6l9i7f7PxQJirqn0MIwmvoEfDLOo
 eDYg9dcpWzarR4+wuoQs5oX0RLj1LLBrqnddob4PNd/q9Z2pKMZuUDaawTBrbglZYvyfhOwVz89
 g2zef9+/4seCOTZdUacEJZOOJ/hK/jJKzcndmA5MK0iEveXOtFej7pSbUhWVavvYykFQ4tA9niL
 +RlQDbTYMVM3YlAdZvErvznDSjHL+vNm3/LYLUZVf7jFEIfoM7fqt4j/TjMy022YTduKJiYddT0
 FU32YozOb+6CYY6uySEtxxqXFxueTfD2zP9RbVGT9GeNRNaxiNLwylstsz3gH642VgHnRW7DSzP
 hhscsKOBroJ/qN9kzbaDkz0pc1vw6icrwnkJXQb4HTW1yjg89qIyfXeEHz8lssWEwRChkjY+93u
 uMvk2lY30rZzFzacfsaEwtf3tavIXg=
X-Received: by 2002:a05:7301:5f08:b0:2ba:94c1:6c8c with SMTP id
 5a478bee46e88-2bd7bd74a05mr4240406eec.39.1771845853639; 
 Mon, 23 Feb 2026 03:24:13 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7dc16203sm4600083eec.27.2026.02.23.03.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 03:24:13 -0800 (PST)
Date: Mon, 23 Feb 2026 19:23:23 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, max.chou@sifive.com
Subject: Re: [PATCH v5 6/9] fpu: Add saturate parameter to parts_uncanon
Message-ID: <aZw4m7gRHx61uxtR@ZEVORN-PC.localdomain>
References: <20260223082154.5623-1-richard.henderson@linaro.org>
 <20260223082154.5623-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223082154.5623-7-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Feb 23, 2026 at 07:21:51PM +1100, Richard Henderson wrote:
> From: Max Chou <max.chou@sifive.com>
> 
> The OCP FP8 conversion operations have a parameter to control
> saturate vs overflow.  Add a parameter, currently always false.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> [rth: Split out of a larger patch]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c           | 46 +++++++++++++++++++--------------------
>  fpu/softfloat-parts.c.inc | 15 ++++++++-----
>  2 files changed, 32 insertions(+), 29 deletions(-)
> 
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 9d06a1bb59..b3c4104854 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -771,20 +771,20 @@ static void parts128_canonicalize(FloatParts128 *p, float_status *status,
>      PARTS_GENERIC_64_128(canonicalize, A)(A, S, F)
>  
>  static void parts64_uncanon_normal(FloatParts64 *p, float_status *status,
> -                                   const FloatFmt *fmt);
> +                                   const FloatFmt *fmt, bool saturate);
>  static void parts128_uncanon_normal(FloatParts128 *p, float_status *status,
> -                                    const FloatFmt *fmt);
> +                                    const FloatFmt *fmt, bool saturate);
>  
> -#define parts_uncanon_normal(A, S, F) \
> -    PARTS_GENERIC_64_128(uncanon_normal, A)(A, S, F)
> +#define parts_uncanon_normal(A, S, F, X) \
> +    PARTS_GENERIC_64_128(uncanon_normal, A)(A, S, F, X)
>  
>  static void parts64_uncanon(FloatParts64 *p, float_status *status,
> -                            const FloatFmt *fmt);
> +                            const FloatFmt *fmt, bool saturate);
>  static void parts128_uncanon(FloatParts128 *p, float_status *status,
> -                             const FloatFmt *fmt);
> +                             const FloatFmt *fmt, bool saturate);
>  
> -#define parts_uncanon(A, S, F) \
> -    PARTS_GENERIC_64_128(uncanon, A)(A, S, F)
> +#define parts_uncanon(A, S, F, X) \
> +    PARTS_GENERIC_64_128(uncanon, A)(A, S, F, X)
>  
>  static void parts64_add_normal(FloatParts64 *a, FloatParts64 *b);
>  static void parts128_add_normal(FloatParts128 *a, FloatParts128 *b);
> @@ -1699,7 +1699,7 @@ static float16 float16a_round_pack_canonical(FloatParts64 *p,
>                                               float_status *s,
>                                               const FloatFmt *params)
>  {
> -    parts_uncanon(p, s, params);
> +    parts_uncanon(p, s, params, false);
>      return float16_pack_raw(p);
>  }
>  
> @@ -1712,7 +1712,7 @@ static float16 float16_round_pack_canonical(FloatParts64 *p,
>  static bfloat16 bfloat16_round_pack_canonical(FloatParts64 *p,
>                                                float_status *s)
>  {
> -    parts_uncanon(p, s, &bfloat16_params);
> +    parts_uncanon(p, s, &bfloat16_params, false);
>      return bfloat16_pack_raw(p);
>  }
>  
> @@ -1726,7 +1726,7 @@ static void float32_unpack_canonical(FloatParts64 *p, float32 f,
>  static float32 float32_round_pack_canonical(FloatParts64 *p,
>                                              float_status *s)
>  {
> -    parts_uncanon(p, s, &float32_params);
> +    parts_uncanon(p, s, &float32_params, false);
>      return float32_pack_raw(p);
>  }
>  
> @@ -1740,7 +1740,7 @@ static void float64_unpack_canonical(FloatParts64 *p, float64 f,
>  static float64 float64_round_pack_canonical(FloatParts64 *p,
>                                              float_status *s)
>  {
> -    parts_uncanon(p, s, &float64_params);
> +    parts_uncanon(p, s, &float64_params, false);
>      return float64_pack_raw(p);
>  }
>  
> @@ -1789,7 +1789,7 @@ static float64 float64r32_pack_raw(FloatParts64 *p)
>  static float64 float64r32_round_pack_canonical(FloatParts64 *p,
>                                                 float_status *s)
>  {
> -    parts_uncanon(p, s, &float32_params);
> +    parts_uncanon(p, s, &float32_params, false);
>      return float64r32_pack_raw(p);
>  }
>  
> @@ -1803,7 +1803,7 @@ static void float128_unpack_canonical(FloatParts128 *p, float128 f,
>  static float128 float128_round_pack_canonical(FloatParts128 *p,
>                                                float_status *s)
>  {
> -    parts_uncanon(p, s, &float128_params);
> +    parts_uncanon(p, s, &float128_params, false);
>      return float128_pack_raw(p);
>  }
>  
> @@ -1851,7 +1851,7 @@ static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
>      case float_class_normal:
>      case float_class_denormal:
>          if (s->floatx80_rounding_precision == floatx80_precision_x) {
> -            parts_uncanon_normal(p, s, fmt);
> +            parts_uncanon_normal(p, s, fmt, false);
>              frac = p->frac_hi;
>              exp = p->exp;
>          } else {
> @@ -1860,7 +1860,7 @@ static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
>              p64.sign = p->sign;
>              p64.exp = p->exp;
>              frac_truncjam(&p64, p);
> -            parts_uncanon_normal(&p64, s, fmt);
> +            parts_uncanon_normal(&p64, s, fmt, false);
>              frac = p64.frac;
>              exp = p64.exp;
>          }
> @@ -2258,7 +2258,7 @@ float16_muladd_scalbn(float16 a, float16 b, float16 c,
>      pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
>  
>      /* Round before applying negate result. */
> -    parts_uncanon(pr, status, &float16_params);
> +    parts_uncanon(pr, status, &float16_params, false);
>      if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
>          pr->sign ^= 1;
>      }
> @@ -2283,7 +2283,7 @@ float32_muladd_scalbn(float32 a, float32 b, float32 c,
>      pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
>  
>      /* Round before applying negate result. */
> -    parts_uncanon(pr, status, &float32_params);
> +    parts_uncanon(pr, status, &float32_params, false);
>      if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
>          pr->sign ^= 1;
>      }
> @@ -2302,7 +2302,7 @@ float64_muladd_scalbn(float64 a, float64 b, float64 c,
>      pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
>  
>      /* Round before applying negate result. */
> -    parts_uncanon(pr, status, &float64_params);
> +    parts_uncanon(pr, status, &float64_params, false);
>      if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
>          pr->sign ^= 1;
>      }
> @@ -2461,7 +2461,7 @@ float64 float64r32_muladd(float64 a, float64 b, float64 c,
>      pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
>  
>      /* Round before applying negate result. */
> -    parts_uncanon(pr, status, &float32_params);
> +    parts_uncanon(pr, status, &float32_params, false);
>      if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
>          pr->sign ^= 1;
>      }
> @@ -2479,7 +2479,7 @@ bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
>      pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
>  
>      /* Round before applying negate result. */
> -    parts_uncanon(pr, status, &bfloat16_params);
> +    parts_uncanon(pr, status, &bfloat16_params, false);
>      if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
>          pr->sign ^= 1;
>      }
> @@ -2497,7 +2497,7 @@ float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
>      pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
>  
>      /* Round before applying negate result. */
> -    parts_uncanon(pr, status, &float128_params);
> +    parts_uncanon(pr, status, &float128_params, false);
>      if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
>          pr->sign ^= 1;
>      }
> @@ -5435,7 +5435,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
>          /* Round remainder to the target format */
>          *r = *r_precise;
>          status->float_exception_flags = 0;
> -        parts_uncanon(r, status, fmt);
> +        parts_uncanon(r, status, fmt, false);
>          r_flags = status->float_exception_flags;
>          r->frac &= (1ULL << fmt->frac_size) - 1;
>          parts_canonicalize(r, status, fmt);
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 4909ff7418..09be686645 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -258,9 +258,12 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
>   * are FRAC_SHIFT bits that may require rounding at the bottom of the
>   * fraction; these bits will be removed. The exponent will be biased
>   * by EXP_BIAS and must be bounded by [EXP_MAX-1, 0].
> + *
> + * The saturate parameter controls saturation behavior for formats that
> + * support it -- when true, overflow produces max normal instead of infinity.
>   */
>  static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
> -                                   const FloatFmt *fmt)
> +                                   const FloatFmt *fmt, bool saturate)
>  {
>      const int exp_max = fmt->exp_max;
>      const int frac_shift = fmt->frac_shift;
> @@ -269,7 +272,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>      const uint64_t frac_lsbm1 = round_mask ^ (round_mask >> 1);
>      const uint64_t roundeven_mask = round_mask | frac_lsb;
>      uint64_t inc;
> -    bool overflow_norm = false;
> +    bool overflow_norm = saturate;
>      int exp, flags = 0;
>  
>      switch (s->float_rounding_mode) {
> @@ -294,11 +297,11 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>          break;
>      case float_round_up:
>          inc = p->sign ? 0 : round_mask;
> -        overflow_norm = p->sign;
> +        overflow_norm |= p->sign;
>          break;
>      case float_round_down:
>          inc = p->sign ? round_mask : 0;
> -        overflow_norm = !p->sign;
> +        overflow_norm |= !p->sign;
>          break;
>      case float_round_to_odd:
>          overflow_norm = true;
> @@ -445,10 +448,10 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>  }
>  
>  static void partsN(uncanon)(FloatPartsN *p, float_status *s,
> -                            const FloatFmt *fmt)
> +                            const FloatFmt *fmt, bool saturate)
>  {
>      if (likely(is_anynorm(p->cls))) {
> -        parts_uncanon_normal(p, s, fmt);
> +        parts_uncanon_normal(p, s, fmt, saturate);
>      } else {
>          switch (p->cls) {
>          case float_class_zero:
> -- 
> 2.43.0
> 

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

