Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3219CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlYa-0006RZ-CH; Wed, 20 May 2026 14:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPlYU-0006LT-F5
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:08 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPlYK-0000Nl-OT
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:00 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-65c24be9e4bso5525074d50.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779301314; cv=none;
 d=google.com; s=arc-20240605;
 b=C19Ax4sGTVYsDE7wGdIC/NucSW9RkMQnBngU/o64UkZdtbUDbiN0vMFR/srFiIrzkQ
 2UfKKJddTPoCbU3MjXtNO4l+EvgMerVIO74DhBwr6q68EP4kcKRIc/dj/fEHiSwQpbti
 RHncCkt/zNuIc1j0raAHdeEH44GGHn80yNLK2X2pcI3yft5kLoU82YPcXTLoNI73pBl8
 lKxchMqwuEC2/vh2vOQ5oQpLpBkGfc59Lj8SY9NXulIpqH5GkG0nf+OirMNiDVeIUXnx
 lLCPvajOQ9+0hyfnmoClwOwIMmpjLvsyGXbD2u0O8qzCHS2K6WflFVAtRiy8Kzxgn3dl
 /a8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OFXPmkXtgd29xqoCC9GVo5rZeGQcUrbDM9GBnhd4uVs=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Hiri0SUgmP+1w6YbSUEjGIBhm6Dk+SphZUs50osiymbDcWfb8dU3qZaSn6mgNYuUug
 lVobJ6mNRpIO+01SY09FU+1UovwfbLsp+909FsgUPu5bDWGeWiqaZUlP9BytFDc8/bpT
 uB63oJ2+wgnHjfcm0qMVrK/S45BxtvXidWLIdJ5tdZkzzl0bZOmGG07Dj6jYv1u2AfIR
 sCxt+323ygXQz4CEMhSFU1L8EsaGin9M082LjZgcx6GRGJeCBsz6t3YyXuO5FcTgtcPY
 qvkClS2HJUX0yzmjvZsXABO23qrVDi9k1fqMSfkOtVjCVcq0l1DNXkHDLC83j8YO0+gf
 Tn8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301314; x=1779906114; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OFXPmkXtgd29xqoCC9GVo5rZeGQcUrbDM9GBnhd4uVs=;
 b=UQ37KLWlBZtlhm4dOFoc3IY8J6AZc6Zz3xNZw6+0XSahHrAgIssoHx2860tKyBW0De
 PQGPRcjC2h+ADV3C+0P3BMjZZqVyzUSiyDrGEceeqlb8Icu9HEPRG5gtKk4XflIpW1qm
 JDz3DS+OlILDUHNizsn1iqcpQLtTAEYU9ZrT48rPgeo3PSGM+SjZMusxpqkSZ8TpPqTl
 6uthvnfczehRQ3zuGuG7zAm3xJ7og+o3W3g7eNFovGEF2e2lqof3vW0ZmuONBKSRyPjQ
 4P37cvDGTcqi6IvevX3x+dNfp+DPFnw7E3DcXGqEzqjqhZBvmSo0BCcEqaYNtG3DRZcO
 +2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301314; x=1779906114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFXPmkXtgd29xqoCC9GVo5rZeGQcUrbDM9GBnhd4uVs=;
 b=tG+aviBTEM1kG5iKALOvX+7fVLCT+aAdgqvqPFlye9vCsqYWfo5lLArV8L0o7ME1nl
 nwSBsT8H0UMAjyLCiJ6atRTzaXkQOUw4OlRKOw2FPhdZFEQhtVAGF1u5C4HuDtlvmT9G
 2zkNsd5/tWl/uiHe/BLo8HjYkq54dg2Za0yf/TPUiMFWCQ7N99hksQ1wGGlJ0krIeieg
 6VvI6NQZZmRB6fwV11JCfvYvzX0/9X8YZM2hQujxcWaOVe1W/oyHX+uUmVP/EZ69hEFI
 aWzm75263OFFRmeeZMzz19AopIsEWoTYWmzz0cdkA6PuzOfR3H7tLRVdFz0TeQmhePeU
 MH0A==
X-Gm-Message-State: AOJu0Yyd5UVtX/UYMjism0JZq0ISdL8fgG9TcWaKezXm4hUR6pNP25VW
 NT8Z00Lboloi3WYxR4nFiV506B4izXVLoNpDewgTkD2PzyUDbxA0rX9xCEskYsmb/jbC8AwcYVb
 gTgFmHqDTDcSdIWmNksl3lCoJ9C/bakMQC+CSZVu/WA==
X-Gm-Gg: Acq92OFuSt5PNbvUhlsc/ORA/fcqyCTS36q4J6jDWFHcl/BRgiV2wKViDkLwQmzrHyc
 Wyb1htgSFV1Jt1g0X+cy44spUs4SyxnHn8dh/OsKeiwoS3YW0Ct9GvpHSOKW079XleYulQyFz9y
 pncallxzygAQUEQ8ZQ3ShpTcFIGiJonR77fTk6rAUht5WvWBLpTQRX3S3DA8LbzXWoXIdyOb+uO
 EyPk738H3lEiMNDNYlyu/nRW5wJejA6wLCohsdzyPM7k2sDzdgbslgWvM7oGNB1ylu4vIGCudaw
 hmozElh/0Rn5RhAbVSWKZ6/ywTeBnC45iNOM8WF+p0bHyVZS0CftVD+qtjefOnjtYpML5bDz6TB
 6+e296HfrAO2z
X-Received: by 2002:a05:690e:151b:b0:65d:4429:b6b3 with SMTP id
 956f58d0204a3-65e227d4852mr22817051d50.30.1779301314295; Wed, 20 May 2026
 11:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260520171820.848839-1-richard.henderson@linaro.org>
 <20260520171820.848839-30-richard.henderson@linaro.org>
 <CAFEAcA9tXNossXoMC=LSa7Aw0CZzsmtkppKqEGqcdSgy-X_GOw@mail.gmail.com>
In-Reply-To: <CAFEAcA9tXNossXoMC=LSa7Aw0CZzsmtkppKqEGqcdSgy-X_GOw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 May 2026 19:21:43 +0100
X-Gm-Features: AVHnY4IlzUXEspB9u5uBQk9j99NK9VcV36cR9UnuBGVXhxXalr32yGXDT_Dl1sw
Message-ID: <CAFEAcA9X-2+_LgGaT3Jf3tC7p3RSH0qRQ0CK_3BhySzS_cxqWg@mail.gmail.com>
Subject: Re: [PATCH v5 29/30] fpu: Fix NaN encoding for E4M3 in parts64_uncanon
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Wed, 20 May 2026 at 19:20, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 20 May 2026 at 18:18, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > There is only one NaN fractional encoding for E4M3.  Retain the
> > incoming sign, but force the outgoing fraction to the unique value.
> >
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> > @@ -507,10 +512,24 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
> >              return;
> >          case float_class_qnan:
> >          case float_class_snan:
> > -            assert(fmt->exp_max_kind != float_expmax_normal);
> >              p->exp = fmt->exp_max;
> > -            fracN(shr)(p, fmt->frac_shift);
> > -            return;
> > +            switch (fmt->exp_max_kind) {
> > +            case float_expmax_e4m3:
> > +                /*
> > +                 * There is only one NaN encoding for E4M3, and with a
> > +                 * conversion from another format, the input NaN fraction
> > +                 * may not apply.
> > +                 */
> > +                assert(N == 64);
> > +                p->frac_hi = E4M3_NAN_FRAC;
> > +                /* fall through */
> > +            case float_expmax_ieee:
> > +                fracN(shr)(p, fmt->frac_shift);
> > +                return;
> > +            case float_expmax_normal:
>
> We used to assert() that exp_max_kind wasn't "expmax_normal",
> but now we don't. What does it mean to have a FloatPartsN that
> says it's a NaN when the format says there isn't a NaN
> representation ? Either way, the "break" here means we
> won't treat it like we do NaNs and we won't treat it
> like we do normals either...
>
> > +                break;
> > +            }
> > +            g_assert_not_reached();

...ah, I misread it. I think it would be clearer to
have the float_expmax_normal case be "g_assert_not_reached()"
rather than "break, and rely on the thing immediately next
after the switch to be g_assert_not_reached()", because
it more obviously says "this case can't occur".

-- PMM

