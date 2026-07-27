Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FE9C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woHpE-0004WZ-36; Mon, 27 Jul 2026 05:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woHp7-0004W4-ON
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:40:38 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woHp6-00041J-5G
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:40:37 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8114a4542b2so33482687b3.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 02:40:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785145234; cv=none;
 d=google.com; s=arc-20260327;
 b=p8gu9R/UStPsH5ELGfD42HEEdpe4qV6l4QD3GI403CZQB9tOyh0OU686sp4fBjiMQY
 S/6afFHvqJV9TVfMe3Eps5q1y3yP+sb6ui38gPk64fd3IQ7seB3jCP/DMUO3VAQHxsag
 u+RmLb2p5krB/f1jMfaafIxeP0OB/ltQcp3XE1gn2IhULUDnurYrPU/ky3pQqZSPX9oW
 +bLwc3DkaRHzQp6CIMKZzgXBDOvVFeUEPhDNGv6DoObyz6r4FAWTZ2YB9rwQZr54L/nc
 Wz8ZvU/rntm29rd8QhhXGeOYphqQkUwRWs+GyRDti8sgjx9Mcls1U4flDF3JPacbD8ez
 2pnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PBjTSeUZsflLVbw7xBkJvO6XZnbCoCdD8ANczblZNo8=;
 fh=pNDvVMtLDvW4cAeBaapkxV6ynVENb+aqTOIHw2UELYg=;
 b=M2/Q7HcXqaXbgANxkFII+wbmgC02egh6z7VtsIFVOhtvfp84xLj4JhaD95CDLW7/xt
 4bVxQ7QQWn7iZRpG8C+EvukQGViA8bUBNmi/FaR4gVXJ28PCvV8lzZeoBMCdMGnG0zZG
 xgMhu+SEM1yR+Ww1zAeKV0/AQlSbYrlstB1/Ogrdc0WsV1ov2WRSGM0BtKjb2uBER6zD
 XHzMniyiSUvMNJ5MjQNOUL7v+2c7innNDgQOg9hObdGirFJLwKMf8Wb6hOjUccL00v/e
 1cGLlE4zWwhXhfFXjpWt956yzyGwGJWbgQNTvT4L0WlepnR9JFndfwDwwrDI7g/wF9xN
 6nhA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785145234; x=1785750034; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PBjTSeUZsflLVbw7xBkJvO6XZnbCoCdD8ANczblZNo8=;
 b=auhL/E6baoMO/Arp+3G8jUsM0b6Gp72n/RVQcvycajzAlZ3rDBvdbThaSEbga0GfRt
 5kHaXvfHOuaL2WkF5OdgzZMopSHb9g9n1JS4h9E4DsAnYLR/YKu6JWdqlUGe9uY+JTqb
 hW4lgqcFRcGxyfusa9/Nri1gEqaqcvKZtrxzx7vSkAXpH403NMomHxRNIF1NWIw6SwKD
 Rr42tIIkXVo3IOkDMjGQREbYqFnSbygaGWrain8/sDXAG7CXwKN9VniHee45agEiL8kV
 4Yrca/EItXJuQ7ak1aASsd7vuV++3wJ+2B2IWApHExPbFmLgKViYD05DyFpZNMq1mcdB
 UDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785145234; x=1785750034;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PBjTSeUZsflLVbw7xBkJvO6XZnbCoCdD8ANczblZNo8=;
 b=PQJO5QKh0LkmOs4P3k1aYiKqWepSaEpjIicUx+RC4qqzRLKk5g+2deOgBDNJ7WqUc4
 ILEtB5qLqDn0RlxUkNfNFdOJKlUAlW6wzm3894p/wkSw7IcFWTIeV2Vy4xZc6Y8056kN
 JVnFcp2STfFAHPomR8s19YL+g5pdVZiA3fZqgJTKNkGCbY8ftxa0PWaGAuBz1PzWSO8f
 J0ussQ++fpstE8zR1xY3HKyupBc0171iyNi5wOYoJGUdvXRSwTKjuU2sbJtIHL/jF9xc
 Q7nlXOrdOUqzFrkeaBZfd+IG4zKoruEadM8JUyDciR6IyeHWz6IP8V0kztUMbozFTBPR
 fW8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAeE0ucEFNFgp2btQjCLd7KrX4YW/uR4SIdiGTHk+rjKTSV0GD2Pv5sVQ07DVgE6du/U8JgfStvpKa@nongnu.org
X-Gm-Message-State: AOJu0Ywjr+rhsVrL7l2rurhUerPMiN2POet84aKOJuXt9CpXQY4ao4ae
 CE2Z3lX8flil7cxtiigkkjuQSJGPCJG32NIBd1kwi85azp1UqPMArumxFx/a7RFLW3gRR+R5OHf
 rCILgt8btUYgAlJQhMxm300TgkR0ig54bszoWM40tlJqMwDh4Dp+C
X-Gm-Gg: AR+sD102oB8egV2cGBDv6Sftg7cRX6j9jNzAdUP4r6uQ7MssXsZ2rynTEpvia0erTAX
 M6O9gpA8ZPVO23XgFw6Hre6PVC5bNLiZ0TzutfFCfwJzPuAIhnGaYsFD7VeopnrTQe9/mX9YJTr
 QbNyDmlSww5MD2Nk780OCdWxmy4L3DnBg2BI2EOoVNWbm9y34ZcEkiTiYCofxblSaIquFVmDnm3
 4IZX2YE9rFTQxTyhIHUud0VHCpUl+GAJHHFMdoGsnHDasgoQ4HRylnXWwM0ucD6q2ApkSOm+IcG
 kS0s11z8H8FICdftnbg1rQqnianIXZf1GDb/kCFHCUNsIw==
X-Received: by 2002:a05:690c:23c3:b0:81d:6eec:fe22 with SMTP id
 00721157ae682-81f69e3c454mr25026727b3.44.1785145233740; Mon, 27 Jul 2026
 02:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260627063208.33642-1-bin.meng@processmission.com>
 <CAEUhbmV_BfLT9_F9OPH8VvwCZ_8Th+swHu833E0sjYCkj-k_=w@mail.gmail.com>
 <CAFEAcA_or9830t85sHAq-PJegJ4OQ1ef=1wGpfcmiHFmVO0Jkw@mail.gmail.com>
In-Reply-To: <CAFEAcA_or9830t85sHAq-PJegJ4OQ1ef=1wGpfcmiHFmVO0Jkw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 10:40:21 +0100
X-Gm-Features: AUfX_mzuI-g41sAHPNQBRaHlejpBAA267EXL6C-ySZodXaLZvwLAC9wcaeE1o7g
Message-ID: <CAFEAcA-JDuWrmNcEhwT+MwKqVmhW+BWW8+CMAz4muBA9W61jSQ@mail.gmail.com>
Subject: Re: [PATCH] docs/system/arm: Update Nuvoton OpenBMC image guidance
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Bin Meng <bin.meng@processmission.com>, qemu-devel@nongnu.org, 
 Hao Wu <wuhaotsh@google.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Mon, 13 Jul 2026 at 10:20, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Wed, 8 Jul 2026 at 16:50, Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Sat, Jun 27, 2026 at 8:12=E2=80=AFPM Bin Meng <bin.meng@processmissi=
on.com> wrote:
> > >
> > > Describe the current OpenBMC target naming and release status for
> > > Nuvoton machines. The latest 2.18.0 release no longer includes GSJ,
> > > so point users at older 2.14.0 sources and explain how to find
> > > Jenkins MTD artifacts.
> > >
> > > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > >
> > > ---
> > >
> > >  docs/system/arm/nuvoton.rst | 54 +++++++++++++++++++++++++++++++++--=
--
> > >  1 file changed, 49 insertions(+), 5 deletions(-)
> > >
> >
> > Ping?
>
> The docs change looks OK to me as far as formatting goes, but
> could a Nuvoton maintainer review it, please?

In the absence of any response from the Nuvoton maintainers,
I'm going to take this into target-arm.next.

> PS: if quanta-gsj is no longer supported by OpenBMC should we
> consider deprecating (and eventually dropping) it in QEMU ?

I think this is still an interesting question to think about
for 11.2.

thanks
-- PMM

