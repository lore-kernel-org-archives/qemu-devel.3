Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D3ACD5BB1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3tE-0007iu-Ka; Thu, 21 May 2026 09:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ3t9-0007AR-E7
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:56:40 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ3t6-0000ld-9M
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:56:39 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65c3ea2ebf7so7074174d50.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779371795; cv=none;
 d=google.com; s=arc-20240605;
 b=KOtzUbWl8ELGH/WgPV5MRYzpvk09raOD9Us3qypyGiOGoCJBCl+bmsaKeb/Ip9OkXA
 CiowNwc6jNYqqYLzlyf6XI/qmcoFrOMhfbSeks1/MgaynEljy9wcErOUw8SOIn2/dwxP
 Vws+wXZpXPNZSrNkwfvTd/hVR4bDON0cYmcIvbgiuM/9xTmfgoNhsPf5s0UnhLd22FqG
 erxNfU4Epggw56zlLs75bcnyKHnidG8KG8dmxS2rWKxoLsVbCUJ5+WU8y9iUW7xZnz64
 onqfRIA2b1oT3DBM4hCgB0x9FHRz6jRTbO71odJ9+yHvCfRkFrs2+vfie7fr37T0XfLf
 GZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j1afOWLioth1c/QT3cgJWLgos5ClUpYjBi60y6SrEzw=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=NMy/0F6HLmyawJyEnLNWpVW1Y4plK2BGpKyCeT7nC9NbbHhqJy8x1vO8tzZ4GPEJf2
 Zg5sFg2hvTr2lpVouCqzoMei4WmHWvnfLHaGbzLJhwY5cT9+AZsHHi4NoYajlSNbirtZ
 zdytMd4Dx+X4rKNhSL1H15JhWqBUcB97L7fElrNYByrfKeuM4hdv4U+I290anZ3elQEE
 bjg/oK3skGpp7aQIMhUGc99JjUnG2w6WlmFUqZokSPyMWmOuc09PkHRQCRsMLeu8qoe4
 GYVpXODe6psQN4LgGYZgnBNUmp74irlWoa7dgXnQxmM+mNPBc+eymBvF366VNvwDMO7e
 XZuQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779371795; x=1779976595; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1afOWLioth1c/QT3cgJWLgos5ClUpYjBi60y6SrEzw=;
 b=DBRu28sA0KinOq+IAnMiA9RlaidpSbT6U/XrcEU7N6x8aMczZA1jTCGF0dQqigsCU4
 5etWWjxJXxz0fZR1xYWqV3rSRO9QGC66D4ll+bJ5haWeN5YODWSA9chTDk4WVKicDK7B
 O4OIElW6Arn7tYal1smGh7uiAtvhDDK8UfQoW+12aZqA4spjSDW6TlLifitDZxgCFXcU
 oCAFAJk0/DSVi10fKI1eDzFhLhj88cpxRvVHfqYaGZ4/BWRo0ugUZpQVVkOBo2urI+Fh
 xXTqqQzmFl+PyB1ZHJijP3DwIfLE3C2vhRAU5dAQrpWcZx7a9L5ohe3MF/XA/Q7ZcCK+
 LNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779371795; x=1779976595;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j1afOWLioth1c/QT3cgJWLgos5ClUpYjBi60y6SrEzw=;
 b=QcxqWS8R2OMcu1FX+44dV3ilAHTrk4HQaS6nZdoU0Ig2YM5EZUwYn/cqxBpx+m7ETP
 9lw6ixYHTM2yDQKVlCPVqNuvGpU2aYGEIxFHzB3tG8IqtcnGDa2Hh1IdI0+Ji1A0kaP1
 /VIbAyRTEWYXG2Ovhp+tHQy6tnshZ58onqwgI8kb02PTvD0o1Ed/tCUjg+QbHF0DRGkr
 p62p3EbG2T0iY/QqSD5+/QcQ3hK5he3iV5YoYEeLzJnhdWMBM6Wfl6NZMkKb9GekZeOQ
 WLtv1eU4eitoZQKwggKHyjvTTpaH7g8GtaQSxMEdfQmi2PC1Fdx7SVPFBxb/PfDISEew
 xHJQ==
X-Gm-Message-State: AOJu0YyGsL6lCE1HSUKrrst1PTaxaXZN74oyhPBTxKaF5DajaabGyMC8
 iA4CAVcB+xId1dXPhJjPHm/G3Wg27F9Y3lIVmOG28OtHMprbrXcL9vtNHO18VTQCKYYQ/ErQXRs
 GrDCIOdY8Xyi+1HC0QW5iHkgRjY/pJWEPnNlcn3yuQA==
X-Gm-Gg: Acq92OGDutMdVDXI2O73anpOY6v59KH/OIfsxkWwXW6GfM660ckgok6rojgdvCNTKjj
 SN6UDsdBOwLP3mrOYenG+c5BM2OcuoONMUmkcpLQIcwipf2arJIR0U8VJhuxIwPCmkx8Hr13uWD
 Dy8BcjvzE7Y5kwN8OgCSasV042yqKnB5ZqBVN2opvDon+U/fzm92SsPVFh1OXvrtu8HCphpkegQ
 27bKpzJ2h4ouXMGLRi2iSlRUJTNvzcTxHbJoyWt8ZQP/FW1ovQRtzeFaYVqA3UT1xehqt/3qSVW
 HRsf6fwKdZg0bb/e9fuL4tWFxkVXw0ULcgva/VSkZK0S2Zk2GIvyUVfxXKz5LBLaAkCCb/REFdl
 6Dg==
X-Received: by 2002:a05:690e:251a:20b0:651:b8fc:5490 with SMTP id
 956f58d0204a3-65eae2850bemr1941355d50.38.1779371794908; Thu, 21 May 2026
 06:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-5-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 14:56:22 +0100
X-Gm-Features: AVHnY4J-YggElKj0VncB-UaBbh9Qwepu0hoF2CVao4P4i6Aq4H0AZ_beTWWU-Wg
Message-ID: <CAFEAcA_uZsqTZn7uGrkL=o86_kzjO7MXsieYdCsEqALs9ZSQRg@mail.gmail.com>
Subject: Re: [PATCH v6 04/64] target/arm: Implement FEAT_FAMINMAX for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 20 May 2026 at 19:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sv=
e.c
> index aa7d72a35e..db32230595 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -4253,6 +4253,8 @@ DO_ZPZZ_AH_FP(FABD, aa64_sme_or_sve, sve_fabd, sve_=
ah_fabd)
>  DO_ZPZZ_FP(FSCALE, aa64_sme_or_sve, sve_fscalbn)
>  DO_ZPZZ_FP(FDIV, aa64_sme_or_sve, sve_fdiv)
>  DO_ZPZZ_FP(FMULX, aa64_sme_or_sve, sve_fmulx)
> +DO_ZPZZ_FP(FAMAX, aa64_sme2_or_sve2_faminmax, sve2_famax)
> +DO_ZPZZ_FP(FAMIN, aa64_sme2_or_sve2_faminmax, sve2_famin)

Does this get the "OK in streaming-SVE mode only if SME2" check
 if IsFeatureImplemented(FEAT_SME2) then CheckSVEEnabled()=CD=BE else
CheckNonStreamingSVEEnabled()=CD=BE end=CD=BE
right? I have lost track of how we do the streaming checks...


thanks
-- PMM

