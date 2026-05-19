Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C580CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 13:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPKTe-00007n-Nd; Tue, 19 May 2026 09:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPKTc-00006y-ML
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:27:16 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPKTa-0007Rr-St
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:27:16 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6563f83ae9fso3503123d50.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 06:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779197233; cv=none;
 d=google.com; s=arc-20240605;
 b=bD+dSenDTfib4KEgQcNEsOJZ0u+KzcDL5YfJ1UV7piRDzC+TJBRVsa4xRR0RpjR4QW
 3k3Aw2LHcOtZUzrlJ2NsCuLIbzk8IPeve88oBp/bVGf3l3lSbTi08xfrpBVSspUCi/3M
 gkLp2t791ariJmK1IBl8A3/QdAG2eBIM/b5VMTpuGvPA+ZspuaNr0vX3Mg+fZDERT/WW
 Z59DE44KUbhYEbueERE7QI7EhhKTG18q6j/g3BcV+tJd2MwLKVz4mpjBFmw3vewSvRBH
 35F4dmn0MW6CZXCT0/JttBvo5klmhlA1A1ioMTpqPD/81auTQCNZ9/cenudoRlUEQYtb
 X1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qSjj0IIDOrr3PY/+TtJBWcm7zY7QcB73XKXiMvE6qAc=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=jremkhrZ7y57Jyv6o/jqhgB/UWaGMyqOyZNRAuQIvgsBSswGdzA/IV1JOdGW4qbhfz
 MkS3g+87dsgXgBWLeWORZvHGA/3FCjHntno/at4qu/KN7FwqQ63qetOy7vyLw594HHji
 PU51XwLgdEp7yut8SgEfCrheGTJnA23uyX5X0BOxPPPdom1AkXFokrh9T92jp6ZP3VG5
 JmLK0PYB/a6lRMVRztJ6r9J9esw9feF6o6Zsxrdolx7mWFnYNyLoR3SN8wOWqT7rw6uo
 cNFOOWS2PQ0n9QdQKACBd6HHtKlaY5jrAoYVgX4916NWQh+vqsncqJQ5371LSB2cry8X
 b4+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779197233; x=1779802033; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qSjj0IIDOrr3PY/+TtJBWcm7zY7QcB73XKXiMvE6qAc=;
 b=JixjJTFJ/iC7QxZiCNNCkjiT2Ig7Qi5OkqVlveLT6VtRO1mjbPkF9sFl/q1sxro6Fg
 5plYVF9sxB3GBPBI5VZ3p7nRFdcMvFcQuEDGSvdmaItaLfic+UWO0+5Ehf5v2JizcUAW
 d0P9YmPOk0EKr0N0I7vkbkE/p2hpGlwiuxujx55n2Mp30Pa8HruLlHfeAC902yzJlNx9
 kNJsBTWZ+76kae/GWBGG4F30136hKuLJHAg67nPRev9F1gSDdVcPL6z3PYn9ZIffPtmP
 xE7zn6g2r0cleU0V/CIligDZscqDOWDyRZYafQ3+jVXO+M5jGDYzC3TBML2jJwzAwQY7
 iMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197233; x=1779802033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSjj0IIDOrr3PY/+TtJBWcm7zY7QcB73XKXiMvE6qAc=;
 b=o3SsVZ7BJLV4HXXb3NFrz/LZi0fHyjPh3Dh8aCQttp+JXALImU5xk6qJmCaT8aO6BG
 JuQjFKsWjQVxZn8nbnVN//EoD2e/67P3701zAmeK693vtci2Pj6YXSwd7FwMbzl9ZcgT
 vFR4jbDoObPNB+z/T+XOuNHesXmpPILUaXA05pPr/zGNcmcrCOtSbLhbdt3dTOZSm3az
 DeZMGWObdNrKjbXS7TsXiR5Q0WN0zTKBgJzAzG+2fgj0yz0J23B6sjCdmVBNkTb/JfN2
 JXiIm/BumzDduO8ox9L9OoEc1exTI5pcVxXlhmLwfV3mxi9yUBNjfBSlbstwutXsBmjT
 CIWw==
X-Gm-Message-State: AOJu0Yz4CrGNAfXfNqERgqGrqGFD2sfIWZJjOa/IegRkqb004D+IIv5x
 QkbXeTbTwm78/xa/Xr+lhBMF8G4waMLF5O2Kx3JZBxGsV+n7Yu+ZV24CBOI1vbDh04L7uF6+6ya
 tSZF9IDUjwu59GUhhH8ILzygrTAn06oreYFroQUNawA==
X-Gm-Gg: Acq92OHEE8gWl422GWYbKcO+weOfCiqtiy4EHoAhcuvzeQGO7GuSbwPOuPXJSCBrLGt
 ba4kjThLGKmiN/qn3oToHF5HYr60TGtH9deQ5ACwwbA5XgYrWNQUNwRXLuhqK6IXj5E+vWyueXD
 eyy4Zr4ax13eO+1+qzGuqRE07IervWJswEAMaktMWG83A3UdRU1vzxvYWHqpxFR7V4lUxNi/mku
 cUX2CzyUi0TCfREG7YyXYsI9FZi5uMaONkM1VNH1oKP2Ef9aFCAu3LQ6xE+nvhQOErS2J+idqRa
 kvcCUrxC+e3u46R3AO33dNvhl5itu+mAhQQGFE4zbAxxkoCVzlte2DDoDJV9pnVpNRQ=
X-Received: by 2002:a05:690e:13cb:b0:65e:3eee:4ad3 with SMTP id
 956f58d0204a3-65e3eee588cmr12660822d50.49.1779197233283; Tue, 19 May 2026
 06:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260517003002.321430-1-richard.henderson@linaro.org>
 <20260517003002.321430-31-richard.henderson@linaro.org>
 <CAFEAcA-q4GdT-uawv-hw6j9ixdO=Nw60hkJ=mq61G3CxRE5t0w@mail.gmail.com>
In-Reply-To: <CAFEAcA-q4GdT-uawv-hw6j9ixdO=Nw60hkJ=mq61G3CxRE5t0w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2026 14:27:00 +0100
X-Gm-Features: AVHnY4JEaUgCVBpNhRAV4TusRdL5kFvgkkpUvb-HjneZCtt78bBwt4nAvmydgUM
Message-ID: <CAFEAcA_5nrmafaL8oGr9Oax5BJ=bJUXZ9XjNt0ZL4bcxzcebTQ@mail.gmail.com>
Subject: Re: [PATCH v5 30/63] target/arm: Implement BFCVTN for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 19 May 2026 at 11:16, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sun, 17 May 2026 at 01:32, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
>
>
> > +static uint8_t fcvt_fp8_e4m3_output(FloatParts64 *p, int scale,
> > +                                    bool saturate, float_status *s)
> > +{
> > +    *p = parts64_scalbn(p, scale, s);
> > +    /*
> > +     * Saturating Inf -> Max handled in uncanon_e4m3_overflow
> > +     * because there is no infinity encoding.
> > +     */
> > +    return float8_e4m3_round_pack_canonical(p, s, saturate);
> > +}
>
> The E4M3 conversion code doesn't seem to produce the right
> output for an input NaN. This looks like it's because the
> fpu/ code isn't special-casing "there's only one NaN value
> for this format". Here, if we input a QNaN the scalbn operation
> will ignore the specific input NaN and return the default NaN.
> There's no special-casing of E4M3 in partsN(default_nan), so
> you get a frac value that's based on the default_nan_pattern,
> which for Arm has the MSB frac bit clear. Then in partsN(uncanon)
> we just move that frac value down into the right place for E4M3,
> without enforcing that it really is the all-ones NaN.
>
> I think this should fix this, but maybe there's a better way?
>
> @@ -519,6 +519,14 @@ static void partsN(uncanon)(FloatPartsN *p,
> float_status *s,
>          case float_class_snan:
>              assert(fmt->exp_max_kind != float_expmax_normal);
>              p->exp = fmt->exp_max;
> +            if (fmt->exp_max_kind == float_expmax_e4m3) {
> +                /*
> +                 * E4M3 has exactly one NaN, with the frac field all-ones.
> +                 * Using the frac from the input NaN might result in
> +                 * a non-NaN value.
> +                 */
> +                fracN(allones)(p);
> +            }
>              fracN(shr)(p, fmt->frac_shift);
>              return;
>          default:

If we do take this approach we also need something like:

--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -288,6 +288,7 @@ static void
partsN(uncanon_e4m3_overflow)(FloatPartsN *p, float_status *s,
         p->frac_hi = E4M3_NORMAL_FRAC_MAX;
     } else {
         *p = partsN(default_nan)(s);
+        fracN(allones)(p);
     }
 }

because the NaN value from uncanon_e4m3_overflow isn't passed
through the NaN handling part of uncanon.

Though there's an argument for making default_nan() for the
format return the right thing I guess.

-- PMM

