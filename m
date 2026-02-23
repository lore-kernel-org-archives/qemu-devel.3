Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814E6EA4FB0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuU1L-0005Oq-Dh; Mon, 23 Feb 2026 06:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vuU1I-0005Oi-Uv
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:22:32 -0500
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vuU1E-0000GJ-7U
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:22:31 -0500
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2bd3b0bc201so2828067eec.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 03:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771845746; x=1772450546; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EQKmMH6RHymGiG1Qu4RQ6nX3lbg78gCpwVdoA5h3iCw=;
 b=Bmf4i8H3OM+r2kVaGg6XyCKA9TCYlWQzJVzqv5+Ji+M+avAzh3ALuOUpFOuAFis1M5
 UqPiSlS7Nqek5KK2ueCbCkbalmH9ymf12xqPMJC9pqcCWAnUBLM9hhMt6rqzUvzFR4lM
 cJ0Y1I+Epnj8FkqpuOdbyUMGNoQMB6AuDpCQnEipE/5RgzyaYrpy12IAMGU1tp3zNkuy
 1WWXn687dyfjU4kFIqYQws5HjJSzw8SRYeaT5SARYXP1haXU+2o3exjuJMuSAfMhuJFd
 mz80rXFuubOnyaHu0uMxbgvvym+DNhH/S6yPnijVk9kaaUIKGsBmf+VlZIQLRAC2q9+k
 rbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771845746; x=1772450546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQKmMH6RHymGiG1Qu4RQ6nX3lbg78gCpwVdoA5h3iCw=;
 b=A7t97DjOlXJDvOhORSsh0RJDpHXEgoq2aTF+OOJVjBMARH5KVSuhQezxEWy1PxzKKA
 PDq3xGrv56MeHaOdE3CL0wQyw0F8G48mMkB4Z9uztrSWBNWjmF2uRKWi+KWQ3Ub5KQo6
 NGS3ZHdvJyw/ErSzE3vS2nwn5eJiQ7cUt7QCWV3Zd85PrlyfKqxh8YIdW9gOGMj7axhi
 Gjxs9gyJ2D1ALqNVAeRl72rQVuaNLlfFSsN7y6vEbfDZCayN+5Ta7ZrtHOr9O3L6iqWZ
 s6IRW3OqpY/CsFalJhtI7JYicPKAsNkWXMkiwhdoWH5yhcGa62PcEJz3VOKGQQrxbLWw
 iQdA==
X-Gm-Message-State: AOJu0YzQ3G5kIrWeyK48rD8JTSEIX4Oqjo9ngbipHjP93eeCSG9F8L1P
 1/N9BabnjR6j6vcsYrb6QRVlDXmTNNhx/fVLoVTj2IOerzTV4Ss6Bj77CtMx/kuo
X-Gm-Gg: ATEYQzyHibNluSbarcyrp+opCo6DFOcmvLknagLG907r6VriR9QS6rN4A4KXv4eejME
 fjZMECV8ZKJ+tNfzUNVuQhCS7bMFBWXfDNmF/b9+BDVwVG4N8NyRFJUGL77f6B1UTIxSaYZmzb7
 ayX6HzeSM9Bt4PPFHhEqjRZQzWICwG1BpsgCafATtOl604tQwoF850dZqoyfRQGp053S1FlQcN2
 KTV4QdKe9FPEnA2VnbpYESPPi/fefhQs299W2PSBXIifj4V66xkNkNqKrpUnQGgrfmQxhKYPz65
 1u4Ptc+9G0x9e6S5LzNpSm9P8VYENTEaKi1lrsPc9L7Vwf9zi/TBqI19aOHO4a5xS+q9lI4pw7p
 RR/ZJEwdEKr+DGytO5WMH/D08A0ChV9sBPz1e/N2JafpxL7OWq8DN/kGUVQZwO1+Gt04QhAfZJ4
 QotQZfv5W00T+LN1jROSvjPw7bX6y9P1GLD0fqdq9bi/OdIJxHd9WEqFhNySIetoI7FdxUGbvyp
 qOUpcXBCI3OHVXQbVEPPNsJPXWlw1k=
X-Received: by 2002:a05:7300:8ca2:b0:2ba:9560:af0 with SMTP id
 5a478bee46e88-2bd7baed452mr3420646eec.14.1771845746024; 
 Mon, 23 Feb 2026 03:22:26 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7da45537sm4615082eec.7.2026.02.23.03.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 03:22:25 -0800 (PST)
Date: Mon, 23 Feb 2026 19:21:37 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, max.chou@sifive.com
Subject: Re: [PATCH v5 5/9] fpu: Add overflow_raises_invalid to FloatFmt
Message-ID: <aZw4MaViI88M47i2@ZEVORN-PC.localdomain>
References: <20260223082154.5623-1-richard.henderson@linaro.org>
 <20260223082154.5623-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223082154.5623-6-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
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

On Mon, Feb 23, 2026 at 07:21:50PM +1100, Richard Henderson wrote:
> From: Max Chou <max.chou@sifive.com>
> 
> ARM Alt HP raises different exceptions on overflow than is
> standard for IEEE when saturating a value.  Add a flag to
> control this effect.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> [rth: Split out of a larger patch]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c           | 6 +++++-
>  fpu/softfloat-parts.c.inc | 4 +++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 8d8e576757..9d06a1bb59 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -542,7 +542,9 @@ typedef enum __attribute__((__packed__)) {
>   * The following optional modifiers are available:
>   *   exp_max_kind: affects how exp == exp_max is interpreted
>   *   has_explicit_bit: has an explicit integer bit; this affects whether
> - *   the float_status floatx80_behaviour handling applies
> + *       the float_status floatx80_behaviour handling applies
> + *   overflow_raises_invalid: for float_expmax_normal, raise invalid
> + *       instead of overflow.
>   */
>  typedef struct {
>      int exp_size;
> @@ -553,6 +555,7 @@ typedef struct {
>      int frac_shift;
>      FloatFmtExpMaxKind exp_max_kind;
>      bool has_explicit_bit;
> +    bool overflow_raises_invalid;
>      uint64_t round_mask;
>  } FloatFmt;
>  
> @@ -576,6 +579,7 @@ static const FloatFmt float16_params = {
>  static const FloatFmt float16_params_ahp = {
>      FLOAT_PARAMS(5, 10),
>      .exp_max_kind = float_expmax_normal,
> +    .overflow_raises_invalid = true,
>  };
>  
>  static const FloatFmt bfloat16_params = {
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 455bbf281e..4909ff7418 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -348,7 +348,9 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>              case float_expmax_normal:
>                  if (unlikely(exp > exp_max)) {
>                      /* Overflow.  Return the maximum normal.  */
> -                    flags = float_flag_invalid;
> +                    flags = (fmt->overflow_raises_invalid
> +                             ? float_flag_invalid
> +                             : float_flag_overflow | float_flag_inexact);
>                      exp = exp_max;
>                      frac_allones(p);
>                      p->frac_lo &= ~round_mask;
> -- 
> 2.43.0
> 

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

