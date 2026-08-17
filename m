Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36821C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww0Sx-0004IT-9f; Mon, 17 Aug 2026 12:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ww0Sq-0004G0-O1
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:45:34 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ww0Sn-0000PU-PF
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:45:31 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so377682366b.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 09:45:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786985128; cv=none;
 d=google.com; s=arc-20260327;
 b=gi/yKmTwVDozxU8WA2hyixBSELzHGaJAr6OyXr5U8qEop+aH31r/kJiW+lpZOcVrqf
 J1VjtS8SyhMmHTHBbK897ngGtc5qhYMeadORI6+CenLXhGbLSqaGh2xcUcRZCks+tYoD
 vY71dc6wD2UwjrCacFq0fF7aduds+THGx+7CvPLu2pOZsyk5CaBI77F7Eb6K/iX3OF+E
 /Xs3ZCY/oAfM9s7L9rp72jpN/Fod0G2DLncuc7xnstX1oYSy1wUVpgZXEYVYCdxxAS3g
 CpziwUjg4Mw1O5av1+9QYPUH5102qDbl/MKGwTVlAN7o3rYIWuV7f4/dTxRnmEstgNzh
 jKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1t8sNwKG7c1EyHhRvWRZ4z3J16W9r+mbOLetTXmgc3E=;
 fh=rRwEAwPkSZ0I452N0nR2YVKCsQWVAiaKmLym9qGnx7I=;
 b=riZE111e6w2g4DELz5Atr6W7fzyMS3MzldKJXA6d0f/ZChXxPpVqaOvXJ4B0qrkfX8
 rPk3eykB2NxNJlFZNzyM3DBVsP5graPGX55nadWpq0k3Nd9dwfkU9QbNlr7HBS+ktV4k
 w96+OsKthQkxWr+1L3AlInudm1bGFQkCijXBMITjtWsK+195NJxaW5dfqyeF8H25yAYt
 9fiwd7EzR7EwdKwBJSJq7tmlsRkbZwJ3tBVxcYWxYn/TmLeuZPQ7PzGApFjOvaspo7Bb
 wfTU1/vBlz6got2sWMFcypYyL/CaMmvIto9JIO8tmRcnZPe2nsHLvLuzDbEuCtRPXGvF
 gGXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786985128; x=1787589928; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1t8sNwKG7c1EyHhRvWRZ4z3J16W9r+mbOLetTXmgc3E=;
 b=c8gz6e+eQNmxfbQpLoHF/k8/c5ILz5imOS5N3y3TlIntvbWXbgHG6nd8zcr1P5kRGU
 N4yORvjaYIH7XBkCZIUbqA/gZHaObtf8KK5QR1kpOlMvo9YddZpAsFZ+n0tP99KsCjqE
 ycZ2qHyDnIFWt+Y6kJY682FFpU4jAOGti2TKw4elkv4o4BV9cjXQ/LxlWjSk0jxIyC5v
 O3bPy9TvMgbVHyAWhUL4LEkVH3cRJOTxhGpxTxpEUd7v3u8D8datflQ8BviOO4fN4vX9
 lasyT/u+E5VN1Wm7a35gNeTltDqMPfVQDU2iW6dMv68W5M3IYLkZzzlSEsZcBkRGJSY3
 PlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786985128; x=1787589928;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1t8sNwKG7c1EyHhRvWRZ4z3J16W9r+mbOLetTXmgc3E=;
 b=BXE0HbKGkCOgEM9I8d0jBhguBC3rzZBN2PKnD7VSxu0drThjZ3JaFzg58VLBhv0phE
 Yest9fhKJYzxPwbxKNWslW6A1AtTPOckoGDfiOb31DWUkxukCkgiM44y9cbygtGoFlOh
 xdr7hO6wjUXiFWBMP1YiwI08SacjayUHrQWfinqtdpG5IFZqdUNiNGgSpxir1PmgigpD
 SVMvz1Eo5feekerSze3SpqkmTN7qVFMwAzznoRqI8XwIdn4LQze2PdlkhICOCO52JERN
 Q5jCTkj5lt8cXpKq0Li5b4nWjRRu0rzJ3w+cm4ONmWHWC1Mv+ezEB+fP4xGcWQqN5bFV
 FJfA==
X-Gm-Message-State: AOJu0YwIDgiS0XbzKuRFVMBscVAc2+BwCH8XGm79Jx0XzqRYDAATgtNm
 ZHn9nVwc9+Y+o2ypToRtiUewkngnemRYzp1Ltihyhn7kPnpMLJCBhY2fK6PzW8XMq6FXl8UboO8
 yfW1DFcDQWW/kvlPD1an7CFV5uyCwiwfyaWQNFts58m4qY8Hh0+hO
X-Gm-Gg: AR+sD122DJlsIn0zc4PHGdP2SO7C2TY4XfUmOO26iqTltB/hizO9xLiQhPiHiJ8Jb7q
 uhd6BQI7SNltHQ2793I/EI1zVUlWBZcd9SSwUUejDxC6PSY3j4OzAvNGU1AMXFmoKJiai6i7rAE
 nZTTDY/VZloClEwv+v5z2+CABvSxlsJHiQ9S7T6m2mEnQfZX1WFpYbZ8zduF4oXrgfKm5vJajBH
 XJJnfoYkgJH0m76YgUGFCVwlU0lyL4Q72/tV+M7KKaiVXALOwwUv7bjF8oDxKDoJF/cLh2470FF
 y0+kMTn3lXD6AxK55uJJKUUVvU3cWFObdrvBkF0+OlNPnELHDm2jOLsVqKN3S3cLZcWJ9Zc2yva
 1qRaeJnuoj08n/w0cq00nbv+6GDfe
X-Received: by 2002:a17:907:c78e:b0:c20:f6d9:d8c7 with SMTP id
 a640c23a62f3a-c212a256de5mr1057918966b.24.1786985128178; Mon, 17 Aug 2026
 09:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260811191540.79882-1-richard.henderson@linaro.org>
 <20260811191540.79882-3-richard.henderson@linaro.org>
 <CAFEAcA98oxLs-w1PNuoM9mArit=toTCTucD5xOmN29Rbk6XBTQ@mail.gmail.com>
In-Reply-To: <CAFEAcA98oxLs-w1PNuoM9mArit=toTCTucD5xOmN29Rbk6XBTQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 17:45:15 +0100
X-Gm-Features: AcwNN1WOezCgxsy6hmB-Nx7Bm4cN-_76e44vnroDw369LaYPhb-HvslDiXLImzY
Message-ID: <CAFEAcA9NuN3tTPoVyNKWcoF3cK+jfBg7ySvPhgM-hkNANy7M2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] target/arm: Fix SVE2 WHILEWR/WHILERW zero diff
 boundary case
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, yang.yanjun1@sanechips.com.cn, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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

On Mon, 17 Aug 2026 at 17:37, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 11 Aug 2026 at 20:16, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > The trans_WHILE_ptr function incorrectly handles the case where the
> > address difference divided by ESIZE results in zero. This happens when
> > the address difference is less than ESIZE but greater than zero.
> >
> > Fix by dropping direct comparisons of op0 vs op1, and instead
> > testing the scaled diff vs 0.  Merge with the bounding to the
> > maximum vector length via wrapping arithmetic.
> >
> > Reported-by: YanjunYang <yang.yanjun1@sanechips.com.cn>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/arm/tcg/translate-sve.c | 38 +++++++++++++++++++++-------------
> >  1 file changed, 24 insertions(+), 14 deletions(-)
>
>
> > -    /* Since we're bounded, pass as a 32-bit type.  */
> > +    /*
> > +     * If diff == 0, the condition is always true.  Also, bound to max.
> > +     * Simplify
> > +     *    diff = diff ? diff : max;
> > +     *    diff = umin(diff, max);
> > +     * via
> > +     *    diff -= 1;
> > +     *    diff = umin(diff, max - 1);
> > +     *    diff += 1;
> > +     * via 0 - 1 == UINT64_MAX.
> > +     */
> > +    tcg_gen_addi_i64(diff, diff, -1);
> > +    tcg_gen_umin_i64(diff, diff, tcg_constant_i64((vsz >> a->esz) - 1));
> > +
> > +    /*
> > +     * Since we're bounded, pass as a 32-bit type.
> > +     * Sink the diff += 1 from above into the 32-bit type.
>
> Is it worth doing that? Hosts are all 64-bits now, and surely there's
> not going to be a perf or codesize difference between "add 1"
> on a 32-bit type vs a 64-bit type ?

Other than that
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

