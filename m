Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ABBE6E81F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 11:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnEjf-0002vt-0g; Tue, 03 Feb 2026 06:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vnEjd-0002un-8C
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:38:21 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vnEjZ-0006Hp-8Q
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:38:20 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b884d5c787bso972690166b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 03:38:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770118693; cv=none;
 d=google.com; s=arc-20240605;
 b=jZ1gho11jtEoT06I/PTehRG2Wlmu4Br4t37f9G4vVQY94b0jHbawSatTcWWht09LD8
 KqM20Qysl8zzloltqRrSTP/V1N22jVLLhEam/ATHzLS5zo6A4dEQFhtUyIXSrfxMhFNH
 nN2rgNf4dpvlc5Ohpq428ktqIG4+5E51sKQW/4JavatKV/1L+sbynrduqJ89I99DXn5z
 9MMzVaQAWqoXCBynNR3eK7CZnM31jm+8jB5CmRHx/i1BqHtdk8KM7PmvAzCLSEeTC2uL
 sN+z94TLUS5Mz40fuowkBaWnuso2He6x1hAL3xLe6xDcWCQd601jkRrQbYIRr2n34Wku
 rgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aVQv6CefGtgIOR20D4RlnBWnJXe3hdMZ0MR5Vo/DNJM=;
 fh=8QB9gjlusW+IdGsiqYBTwFEpf6YNREhGypQ/QDKlP7E=;
 b=Ta/T2Cwl1K1En68Y3+nTYFde92U49aaepaPjdsWfQnioFPHCbeB3nJX9jCIBTuccYX
 BMEEzsNcqgakT7KIRUZ2zCsE02U713hGCt74nxB9GNCDXccr8JBPav6U7G9ZsoIkDfe4
 HC5E8KEhsaWe/bHTeArtB6YEjh4/2vWJdmJ6/bGFIjKMkg1zYgM8i1ZDzUfvVWLJOvrK
 Avc5O5IR6dV0Q5t5ZmHc6jiW75JCBy69e4XJLjEnUPladKK5jAYIolknzru2bxymbUms
 ZjIpDNuq+SMlSGRVn+pwpIyugUUpXqbbmTiwg8/+4VOY2vdMeJdsBn+nUBZ3FYADCTYy
 FAUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770118693; x=1770723493; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVQv6CefGtgIOR20D4RlnBWnJXe3hdMZ0MR5Vo/DNJM=;
 b=ZF2fdEhKxzUcYok+M8YNgDYkLg7qsquPko/pYxbuR36atIoWZ1QPOnelnInXgcXxpe
 ihY4FdxOVgOnTJE5GVJdrQ/RqwpDJhXJ5+//rGxFUZZ4MP+u8CChWSqA0osdcv3/zBCi
 5RcCerojAw1jpqfz7ADARuG9hxtzbXM/khqfzf7l7pmgaaG64PKLZtueMt5wAilyEKwm
 u4lU5HbpKkM7VFUYdTLytTMIDjmLdiCKzyVqgfRiAyWR0ubWNPj/A0Pjix4u3Nw776cA
 +rB53hfuz5QTf5nsOaHylQSrU30vu24Hlzpb+wvBhA/svumfOLphoyYhizmMEiKB7bA4
 yZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770118693; x=1770723493;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aVQv6CefGtgIOR20D4RlnBWnJXe3hdMZ0MR5Vo/DNJM=;
 b=S8UeUiKqW4+YtCvno01eSdQSPlC0PFc1ps8mLne2wSAd612z+259IoGtPweeewsay/
 jepLZGhojxC4Zzdt72YeSkBK+FVucHlIHDFeD6jzhdK51QQMM3omySFWRhXBCEB886IO
 KjLiFGTktinR8d+9vXgL7uZA00vxeROoel76kp+Q0yeT8QqUMEN62gx11hib+eHuUB6y
 8CNnt5/0aamhTP1YjT7N9GjfsawOOr9wn4zZiivZgL4mBIuPAve8ASLlpTd8A3IlTs81
 +Qww/+1JVs6cjDwkuGdBDhEgDm6iwUJo0VgtHE+F8qLo+L3layqLTw+mJJvPwkLz3uL0
 N3wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR2PCk2ZCfChBQjMmmLs5ER7XkuV6HLmXrFcIw3yNuJBqZl4v7YUXoojerLF1uC5Ikxe8p2ZOHobtU@nongnu.org
X-Gm-Message-State: AOJu0Yy8ZfvhP9OzYtbnTzTOcrkTL5IgUH9sZkGi1KwRBx3GrYhVFM4s
 cl4FETetWRABnmHZctd0VgZKmkhHU4DKDY8pKNaWW4iUhb5fQTKoklhL0VARg16aqjoFZkAUXHW
 BExEA2aNw/hfzihlTbQMZW63t81I9OdPSTZ1O5hIzvw==
X-Gm-Gg: AZuq6aIzoXo4EAPv1yPbfj98jkCUiqw1x9MX58Qycgy9PbTh0Gz8k0cX6/ooRXvuWGh
 ophttJ5UuJwOHM0JSZQVutagkZ9JnwBBib4JCbh9LKrNlmdrF/MrgmvNS1U0VJWzjGIEhu0eV7Y
 PEAOiHJVsBL1+12LI2A8Vjv0/VzPcXmi2sKAumLthX0//xViH+7/nSMWOMTj1hhm5Nq6/2v8B3Q
 QIicTHMi5chDYMl/5qxdgZXWhuI9+71FDrj1jUtec0+TgFQrST+SAGRRCfa5/MK1s7ONeDszk20
 gn7NKgRkIPSLJR54qWxAutHl/jrW3j7gvLfi
X-Received: by 2002:a17:906:c153:b0:b87:6b9a:3016 with SMTP id
 a640c23a62f3a-b8dff77a8f2mr893267666b.60.1770118692559; Tue, 03 Feb 2026
 03:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
 <20260202133353.2231685-4-peter.maydell@linaro.org>
In-Reply-To: <20260202133353.2231685-4-peter.maydell@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 3 Feb 2026 13:37:46 +0200
X-Gm-Features: AZwV_Qg3w8YcygChAX9hYqT5U9S30n_IMvFlt-wTMpowhOAn_j1gBzTlOgDAfIM
Message-ID: <CAAjaMXapsWd1S2waeJ5rOx9rEXREboa=GkFE9Z=z104m8k5qFA@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] target/arm: Fix feature check in DO_SVE2_RRX,
 DO_SVE2_RRX_TB
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x633.google.com
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

On Mon, Feb 2, 2026 at 3:33=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> In the macros DO_SVE2_RRX and DO_SVE2_RRX_TB we use the
> feature check aa64_sve, thus exposing this set of instructions
> in SVE as well as SVE2. Use aa64_sve2 instead, so they UNDEF
> on an SVE1-only CPU as they should.
>
> Strictly, the condition here should be "SVE2 or SME"; but we
> will correct that in a following commit with all the other
> missing "or SME" checks.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/arm/tcg/translate-sve.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sv=
e.c
> index 64adb5c1ce..81f487152c 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -3769,7 +3769,7 @@ TRANS_FEAT(UDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_g=
vec_ool_arg_zzxz,
>             gen_helper_gvec_udot_idx_2h, a)
>
>  #define DO_SVE2_RRX(NAME, FUNC) \
> -    TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
> +    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_zzz, FUNC,          \
>                 a->rd, a->rn, a->rm, a->index)
>
>  DO_SVE2_RRX(MUL_zzx_h, gen_helper_gvec_mul_idx_h)
> @@ -3787,7 +3787,7 @@ DO_SVE2_RRX(SQRDMULH_zzx_d, gen_helper_sve2_sqrdmul=
h_idx_d)
>  #undef DO_SVE2_RRX
>
>  #define DO_SVE2_RRX_TB(NAME, FUNC, TOP) \
> -    TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
> +    TRANS_FEAT(NAME, aa64_sve2, gen_gvec_ool_zzz, FUNC,          \
>                 a->rd, a->rn, a->rm, (a->index << 1) | TOP)
>
>  DO_SVE2_RRX_TB(SQDMULLB_zzx_s, gen_helper_sve2_sqdmull_idx_s, false)
> --
> 2.43.0
>

