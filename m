Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD909FC5910
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYTE-0002Pc-Nf; Thu, 26 Feb 2026 05:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvYTD-0002PL-3l
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:19:47 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvYTB-00046n-L5
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:19:46 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7982c3b7da9so7379307b3.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 02:19:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772101184; cv=none;
 d=google.com; s=arc-20240605;
 b=UJckCwaRLyvyH9XMpfJFvPLDADve8/jWQInZAJgZ7jcWsSUrOfD3cCWH3HPvN3lvfE
 gaAVk2OO8U2UknfvX91j47Z+J8faRK3157jeJB62Wwf/V7/ZfW9ds4/9uZFjAMBDzkjI
 gwxyOhP0pHHfr7pKkJ8Tt7PtWGXD6HNAmKJ50Q5HHbivThlPezzK0KNsGjL/9TFcWSRk
 caO6RYy4u1EeenOkJBjH8M3Z254gRPG97pFSSLWkxygiC5AGIglWzpaXMXtlKPnm0m8r
 Acx94Pm+rfZ0eTdd/KnJQPju6Ocq+S5pnbTx3RDqXbi9tWHpBs4IWWtb8jnSVPh1Mlb+
 XMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ERgBiwPJOT5sqaJzAZH1sG7hvUhBl2XMAdmXa++VDEg=;
 fh=qDEitYY2TPRRMZ4OARbMiUT09q8rCCMKzcZWPtML1Tk=;
 b=CrVvmvZTrmOXVMxPA5KvnVNNmAU/vBG1Kz/Mi/Z7MJilKqsgBDsRZXEFFg57njrSh/
 7HwJysZC7GikK5HcXYOLXVjPyOeR/N8egrpZPcuwich8H6po0BKDpqMjwyJir0x3E3xe
 WbaAV5qGlD2WSI2bKLGqEJyU2XtAmllI4l1OI/lBnUEfFj7FV36/GeTVQIG6JbiJoL98
 VTR3s+V4hAwsGcS3Scv+ip9DOoiNqVx8JhcaIyr4RNaWdP0VWel4kCRjLLJrgcPaHxi7
 l/tkJ+waHJLXyQs1TsQg4jn7XdIPtsMXX1NqbCirgM5krmARFx06qHJ7RSH1VMy32BV7
 N5Zg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772101184; x=1772705984; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERgBiwPJOT5sqaJzAZH1sG7hvUhBl2XMAdmXa++VDEg=;
 b=ir7sL2q495nJgZERktS/o8pQ11HTvOXUjQx8z+FngmGDbOeNtYa+aNpWHJ2mqPfeHR
 BvYtPZo6ifWwY71033p79sT3C4RQidDQg0O4ZNAouCS1LfdqTSb1B3H7NlfpHCm5KzgD
 cp+/87epuHj4iY2KQ4MZYb4+yrmStySFcosdTb1f3xUH2k6XKZXJ3L6I55Kl3L1gl2lK
 x83rop6AmpIwDExPVnJa/4o3epIooSqyVjXXGdKfLs/9nR4eiGY9fbYdO7mZZSMy7WaB
 R1LAFkcM3nkiilX/0QMt5YJ3v2m41obcBshd8UgCVbdsQ0kWWTpqa7T7Itlh5TTV7k88
 ZrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772101184; x=1772705984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ERgBiwPJOT5sqaJzAZH1sG7hvUhBl2XMAdmXa++VDEg=;
 b=Z3DGjuueYS+Zf6CxUmKS/z6X4o1tQxCeG5RDuwppTLlgxh1E05Hw7V4dp7JU62NHeu
 Do0pnXCJSQ1A+gwMIlUeNgrlmFhhcnCR9z2Vc/znqHPl7zBwC7FxFqrmiV4YRBuh1Djm
 9WnytPcjoonYVR0QPFdWgdReBMHCfll9Ybk4lAFsDO55Yp+bpalnfKaMlBXEaRA7aoHz
 y2MHZ39FFuw5LkamRdNetPZu7ssMma6la23dB+44rpEI60L4u5RYT0D8qlCX2+yGUZFp
 10uJRzZGw73LwM+PiwdyHjjDMsjNVJSnnQthT/tsYyHZliKLUZvYmETH10Ymze14FRQD
 3ExA==
X-Gm-Message-State: AOJu0Yy+AEyDLsxJhYfSnZ1LsYQKPy8I878MBvPWf7p3RLgwJay492KL
 gQFTo8kKuvrd551UYigT/VhB7+y2xidVp5jikRdzFQwepIIANusmb7YRsbvlKMfMI3qOdr0wshL
 WGHLziwfhGj9NIPDbZCC/vMvwAF2XjT79UEiRgvGxzg==
X-Gm-Gg: ATEYQzze0rYlW8TceV8NAWiJWsG3oJaHj953KgGilXk6tMofzdL4+O/p4g+X8Q1/3vX
 94aL/wUgwiO8SoLPxO3ThvBQCKDDg+gvhZtkCTNd4ypfTlM71GX1erRPjo+qLe7R96kBOMf1koI
 7uZo9CdldoxYNpwS+9skq0YO/NoAo5Zq2gGgzBdCh0FUoMzZBoZO+6KosaUo32invpXkBuMAU4A
 VNdnZUwnJoitdtrA6XneiGUi0qN8ErJQXf9nl1YerwxhWsShFvkiRfJywZTIRICo0hREMZO99jz
 NEl7D4M7pwrgAwArqSf3YO1U81ettu9AQNHxtDBG6yOPVCDQlvOxTOvXWvBCFl9wfk8=
X-Received: by 2002:a05:690c:b10:b0:796:3f2f:a33b with SMTP id
 00721157ae682-79876c1c2d7mr11547367b3.18.1772101183918; Thu, 26 Feb 2026
 02:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20260224154347.344219-1-alex.bennee@linaro.org>
 <20260224154347.344219-3-alex.bennee@linaro.org>
In-Reply-To: <20260224154347.344219-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 10:19:31 +0000
X-Gm-Features: AaiRm50DPzGrXORSCBPZp3zns44SYEPNOpukRR4ANOPj6ov1RvPIjvsrF3rGS2o
Message-ID: <CAFEAcA8BX-YdALLhyYB_mDOycnUaLQ_abmSyK3VcPNQz9E3imA@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/arm: use FIELD_DP32 instead of open-coding
 syn_wfx
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Tue, 24 Feb 2026 at 15:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> We can use the registerfields API to safely set the individual fields
> and avoid open coding magic numbers. The EC and IL fields are still
> driven by defines but we could convert them later.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> +FIELD(WFX_ISS, TI, 0, 2)
> +FIELD(WFX_ISS, RV, 14, 1)
> +FIELD(WFX_ISS, RN, 15, 5)
> +FIELD(WFX_ISS, COND, 20, 4)
> +FIELD(WFX_ISS, CV, 24, 1)
> +
>  static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
>  {
> -    return (EC_WFX_TRAP << ARM_EL_EC_SHIFT) |
> -           (is_16bit ? 0 : (1 << ARM_EL_IL_SHIFT)) |
> -           (cv << 24) | (cond << 20) | ti;
> +    uint32_t res =3D (EC_WFX_TRAP << ARM_EL_EC_SHIFT);
> +
> +    res =3D FIELD_DP32(res, WFX_ISS, CV, cv);
> +    res =3D FIELD_DP32(res, WFX_ISS, COND, cond);
> +    res =3D FIELD_DP32(res, WFX_ISS, TI, ti);
> +
> +    if (!is_16bit) {
> +        res |=3D ARM_EL_IL;
> +    }
> +    return res;
>  }

I'm not hugely enthusiastic about this mostly because it
means we would have one syn_foo function that's written totally
differently to all the rest.

-- PMM

