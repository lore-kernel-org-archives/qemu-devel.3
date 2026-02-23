Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1A6EA4FAE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuTya-0004mY-AO; Mon, 23 Feb 2026 06:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vuTyZ-0004mM-CQ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:19:43 -0500
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vuTyX-0008Lx-Jk
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:19:43 -0500
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2bd8097c709so3326869eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 03:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771845579; x=1772450379; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UWDYbFGbfMOHBnoz4H0gnyZfLSmLlay9dWzUDQeaCkM=;
 b=kQT5APFSp6FfBVYhsqKm0l9C5Lr4WGVmBj4aYVfahFwCIx/r9UvkjECq6lxFznpUx9
 P7vXs6xMunP1s039wkT8cir1eRK3vXDNT6YLJAsLWGNRgjPnZzwT1AIr/P/CgKtInVjr
 P4saBmwvXxZzqiezsN7eDdkfWny9jTwWPAHSc8uoIm7mjQbhoB3ZL7vcX4cJj0pQWM9k
 L9w78aZ7fD8MA59hQ7r/AD2WWR4ddnLGxBEOUrrNeKQKbsLZGQrYoYekyHqG8yF1ErZy
 RpSrCyw5EbZQShbGNneXnIPh0WfEIITvp1X/xV0LzapHgLQFb5ZvLNQZxdUogpeepI5P
 cPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771845579; x=1772450379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWDYbFGbfMOHBnoz4H0gnyZfLSmLlay9dWzUDQeaCkM=;
 b=pvcxh6wokFcKvPjrsp0Z8tdxuYJuu2KlQEvE40nzRe6XvXCLXf+65akeTmqg7T+a/R
 /swvJGGJ98k7OxqpljP7v/3rJ3iiAhjG62gmqAr9noa59T/ENWGuNox4Idunbo2uh8yi
 F/L9sMbH+2CXuFd5e2k+S/YElgL2BWJlwb717Two4hsdKIWN1M5/pYhFt424OqxlXBCP
 72oW1ICcMSvQosPV5e493shVR5fPADomDZ1HbsZ/UqUBZpY5KO1MPxZ4uxkbObGxImrK
 hQMn9B9fZdfMXFpyeKj1QRVklkynpdXQlLgEWa3Go5gPHPcSOxk6CfAhCGekQmk6Es5S
 nDxA==
X-Gm-Message-State: AOJu0YyNVXA41mWAnvScwSfqnt4zLtawAILmBa+uDq6BDbMDIys50X/S
 /eC649MP5EE+Cue3pjlT9Kz5/p8T3Zeh6EhP3mT/CFt84E6uoN//UnAG
X-Gm-Gg: ATEYQzxecTA6FfXMkZrKrliKEDFQ3XLgrD7ow7PFENBGTuezrauZvljgRk48ExabaAu
 r1bddKG9QHnY//o3EA4aofqqbdwjLbONhQsZpOSgpEX7FnN60M7/NbjXMFZm51Auysx1gVlQzoo
 Mi2jnLe0/gdb/LvlrzDbOg3Mri4KI+HYKttcXh1KKE3nIueDTC3+v1v2mbwN8vzrz6FExI2EUmA
 63aDqd5XqHgmaadEO4OfGoJumQ7If1WS67yrw9Elk6g4Jh4+2HR0spGNnsVek/OIbioxknOESgW
 mPyhJ5JdcxVDhE8eQw6RXcV2HtPeB6wR4uY0GTrpA+1tKY6617tqE0+irAtdRxzQIynp3k3Y+Ly
 F/CY9flmJsKc7NZBVS6y1LsanIo7MXsmfhfU4mlHAYD5M06Fvbi8q6l9cVMJyqweWOW4cnaJ7y5
 Htv+awVTPVY5z8y+mkTYvIZlsUrfv+Eecfiq+AkSYXQ0pGkbDD+j9rw3WipksQgpqziQ542BfA9
 l7VpIIvYvgOVVviKubWj2ZTUSN/rdU=
X-Received: by 2002:a05:7300:6144:b0:2ba:82f6:ccbd with SMTP id
 5a478bee46e88-2bd7bdaebc5mr3519250eec.34.1771845579427; 
 Mon, 23 Feb 2026 03:19:39 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7daa35f7sm4723788eec.8.2026.02.23.03.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 03:19:38 -0800 (PST)
Date: Mon, 23 Feb 2026 19:18:47 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, max.chou@sifive.com
Subject: Re: [PATCH v5 4/9] fpu: Introduce FloatFmtExpMaxKind
Message-ID: <aZw2nu-G3d21yOsd@ZEVORN-PC.localdomain>
References: <20260223082154.5623-1-richard.henderson@linaro.org>
 <20260223082154.5623-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223082154.5623-5-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
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

On Mon, Feb 23, 2026 at 07:21:49PM +1100, Richard Henderson wrote:
> Generalize arm_althp to indicate how exp==max should
> be handled for the format.  Reorganize canonicalize
> and uncanon_normal to use a switch statement, allowing
> more cases to be added trivially.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c           | 17 ++++++--
>  fpu/softfloat-parts.c.inc | 92 ++++++++++++++++++++++++---------------
>  2 files changed, 69 insertions(+), 40 deletions(-)
> 
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 8740975348..8d8e576757 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -522,7 +522,16 @@ typedef struct {
>  #define DECOMPOSED_BINARY_POINT    63
>  #define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
>  
> -/* Structure holding all of the relevant parameters for a format.
> +/* Format-specific handling of exp == exp_max */
> +typedef enum __attribute__((__packed__)) {
> +    /* exp==max, frac==0 ? infinity : nan; this is ieee standard. */
> +    float_expmax_ieee,
> +    /* exp==max is a normal number; no infinity or nan representation. */
> +    float_expmax_normal,
> +} FloatFmtExpMaxKind;
> +
> +/*
> + * Structure holding all of the relevant parameters for a format.
>   *   exp_size: the size of the exponent field
>   *   exp_bias: the offset applied to the exponent field
>   *   exp_max: the maximum normalised exponent
> @@ -531,7 +540,7 @@ typedef struct {
>   * The following are computed based the size of fraction
>   *   round_mask: bits below lsb which must be rounded
>   * The following optional modifiers are available:
> - *   arm_althp: handle ARM Alternative Half Precision
> + *   exp_max_kind: affects how exp == exp_max is interpreted
>   *   has_explicit_bit: has an explicit integer bit; this affects whether
>   *   the float_status floatx80_behaviour handling applies
>   */
> @@ -542,7 +551,7 @@ typedef struct {
>      int exp_max;
>      int frac_size;
>      int frac_shift;
> -    bool arm_althp;
> +    FloatFmtExpMaxKind exp_max_kind;
>      bool has_explicit_bit;
>      uint64_t round_mask;
>  } FloatFmt;
> @@ -566,7 +575,7 @@ static const FloatFmt float16_params = {
>  
>  static const FloatFmt float16_params_ahp = {
>      FLOAT_PARAMS(5, 10),
> -    .arm_althp = true
> +    .exp_max_kind = float_expmax_normal,
>  };
>  
>  static const FloatFmt bfloat16_params = {
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 79b56014ab..455bbf281e 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -227,18 +227,30 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
>              p->exp = fmt->frac_shift - fmt->exp_bias
>                     - shift + !has_pseudo_denormals;
>          }
> -    } else if (likely(p->exp < fmt->exp_max) || fmt->arm_althp) {
> -        p->cls = float_class_normal;
> -        p->exp -= fmt->exp_bias;
> -        frac_shl(p, fmt->frac_shift);
> -        p->frac_hi |= DECOMPOSED_IMPLICIT_BIT;
> -    } else if (likely(frac_eqz(p))) {
> -        p->cls = float_class_inf;
> -    } else {
> -        frac_shl(p, fmt->frac_shift);
> -        p->cls = (parts_is_snan_frac(p->frac_hi, status)
> -                  ? float_class_snan : float_class_qnan);
> +        return;
>      }
> +    if (unlikely(p->exp == fmt->exp_max)) {
> +        switch (fmt->exp_max_kind) {
> +        case float_expmax_ieee:
> +            if (likely(frac_eqz(p))) {
> +                p->cls = float_class_inf;
> +            } else {
> +                frac_shl(p, fmt->frac_shift);
> +                p->cls = (parts_is_snan_frac(p->frac_hi, status)
> +                          ? float_class_snan : float_class_qnan);
> +            }
> +            return;
> +        case float_expmax_normal:
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }
> +
> +    p->cls = float_class_normal;
> +    p->exp -= fmt->exp_bias;
> +    frac_shl(p, fmt->frac_shift);
> +    p->frac_hi |= DECOMPOSED_IMPLICIT_BIT;
>  }
>  
>  /*
> @@ -314,29 +326,37 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>              p->frac_lo &= ~round_mask;
>          }
>  
> -        if (fmt->arm_althp) {
> -            /* ARM Alt HP eschews Inf and NaN for a wider exponent.  */
> -            if (unlikely(exp > exp_max)) {
> -                /* Overflow.  Return the maximum normal.  */
> -                flags = float_flag_invalid;
> -                exp = exp_max;
> -                frac_allones(p);
> -                p->frac_lo &= ~round_mask;
> -            }
> -        } else if (unlikely(exp >= exp_max)) {
> -            flags |= float_flag_overflow;
> -            if (s->rebias_overflow) {
> -                exp -= fmt->exp_re_bias;
> -            } else if (overflow_norm) {
> -                flags |= float_flag_inexact;
> -                exp = exp_max - 1;
> -                frac_allones(p);
> -                p->frac_lo &= ~round_mask;
> -            } else {
> -                flags |= float_flag_inexact;
> -                p->cls = float_class_inf;
> -                exp = exp_max;
> -                frac_clear(p);
> +        if (unlikely(exp >= exp_max)) {
> +            switch (fmt->exp_max_kind) {
> +            case float_expmax_ieee:
> +                flags |= float_flag_overflow;
> +                if (s->rebias_overflow) {
> +                    exp -= fmt->exp_re_bias;
> +                } else if (overflow_norm) {
> +                    flags |= float_flag_inexact;
> +                    exp = exp_max - 1;
> +                    frac_allones(p);
> +                    p->frac_lo &= ~round_mask;
> +                } else {
> +                    flags |= float_flag_inexact;
> +                    p->cls = float_class_inf;
> +                    exp = exp_max;
> +                    frac_clear(p);
> +                }
> +                break;
> +
> +            case float_expmax_normal:
> +                if (unlikely(exp > exp_max)) {
> +                    /* Overflow.  Return the maximum normal.  */
> +                    flags = float_flag_invalid;
> +                    exp = exp_max;
> +                    frac_allones(p);
> +                    p->frac_lo &= ~round_mask;
> +                }
> +                break;
> +
> +            default:
> +                g_assert_not_reached();
>              }
>          }
>          frac_shr(p, frac_shift);
> @@ -434,13 +454,13 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
>              frac_clear(p);
>              return;
>          case float_class_inf:
> -            g_assert(!fmt->arm_althp);
> +            assert(fmt->exp_max_kind == float_expmax_ieee);
>              p->exp = fmt->exp_max;
>              frac_clear(p);
>              return;
>          case float_class_qnan:
>          case float_class_snan:
> -            g_assert(!fmt->arm_althp);
> +            assert(fmt->exp_max_kind != float_expmax_normal);
>              p->exp = fmt->exp_max;
>              frac_shr(p, fmt->frac_shift);
>              return;
> -- 
> 2.43.0
> 

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

