Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536A3C5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmoT-00011V-Pj; Fri, 31 Jul 2026 08:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpmoS-000113-2a
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:58:08 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpmoQ-0004bO-9g
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:58:07 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66807ba2f0fso1297000d50.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785502685; cv=none;
 d=google.com; s=arc-20260327;
 b=Uy6Z058CVDzhbThlDM58fjwpCCFoTaa9JOX4VEwlrnCBU/J8SGqA7g6Z0tmFXkrqf1
 4UvgOEYZj/r989Ofc8+fH7Hx16+p5RJ4OREKi+HXeUCAfE+vMy35rll9YmQ7S27F9sRD
 HdMhSCUYaxsXsTpjRECEmuWbR0+wcXnLK402wmOOeenL3aQUFxVBFXOLFf9iwTc26gmo
 7OqIQKTwWoA0rdRjHq8Jaw5pf0KrnIuJq6KniXPvKZ2NRLiDR9mtzUNaiOLDYplcS/xy
 9Lc9sMfIpYlZbhnPpXu0WVDH+5TFhdGrmpxu/Ny/APg/uvp8uXYF/tLwhdDIk3V3xcyA
 Jgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zT010dL9zwi/EIWKfQkcBqsb9hq/y0PhOEutY5xxjRU=;
 fh=ez+LVd8M9hy1dnJgxFB0699yjwsZu5xnMX7Bb9/3STE=;
 b=qjs808+vRJ2q4evTPXCjIuY1PoKt1hpOwERa9imxQorngMZstbtW5DRsqUy85LHF24
 UW/brR28KtXFdl0ag31bX5v8ove88ApJZ4Ct4JvUSpFE69+QFgwvu2UyKJzwN8kX2VYr
 tlsCNN3Q87rI5PcEDkzTT902WJqqs5UeLQHbdqRpI8FjTK25XSOWhl0as5q6QBWyyr4M
 hR5tLCnvrQrIGvXCnXvywE4c3IdFf6Ac5wYe552KjAzOAAuWLQKUU8u660ETWqA91FAu
 sG71rhCa8w7Xy7hFz2Gvt2+wYf/Zs7Ke849fiuY9eswIMzi18/A33N7TdjW4uq+hRDdp
 Ic0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785502685; x=1786107485; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zT010dL9zwi/EIWKfQkcBqsb9hq/y0PhOEutY5xxjRU=;
 b=jh+jSTIh7ROKDTZDxO/R7hNJ0NnHTLyoMq3r6ljIOHfvYpfz+rONrybyK+zrPcktDp
 0xgg6jJVlgVbbNuQs6D0f8v0EkFLTuZV6SsBlvgfeKc7bMbOcT93dCH+z/qXMpI0tncd
 gtgErPyBRLvF1FOC3DyhzKYqO8iRABEuVoOrWca+BM90Vn7XV0al/2cde97sRpM3g7WM
 zPKdO2szhjTfuggbSNMettnTae8ExQVzwtWIsihuDDatqlcWTa1iCQLB5NkRbvWUzu1q
 xVFstw+qTe3XIGhGrqIfRZUJNBMqbUl9rxKU55iID1qCd96i+1aHGNGOerU230gyR4VH
 p5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785502685; x=1786107485;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zT010dL9zwi/EIWKfQkcBqsb9hq/y0PhOEutY5xxjRU=;
 b=JnvtydgT385fDruNHIUL8MjlmtKgdicYpK6+ak3d0Ry38/B3lVzzvou50kehIand+k
 kCEVbMayWXlTLEIYBPjmL780NxrCAK4RCsut0yd5VEQpXMv86ViQQlhNNbVamZmqh/Eb
 cLKoEBCabK+RswtHSZg0YdIG0oNnkqye6FHW+QUmXycko/wpKJCdj4Uhv1kTdMhtFWV5
 8CAaJFsBoKFQ50ZVnAjm0qBQ0krUzVSAJCCu5BrLYzaszWh3xF514r+Y+9hadYH6ruPh
 8cjQu+pu+22/xi92y4/AIelqbtoWmlezvcvxoUVB4uK8tgJ41pupydgQRBADH6xgDQ9C
 d2ww==
X-Gm-Message-State: AOJu0YzpylkBBmNS1BAOtwdBKn0jIocNVkeUEehdGABjvL1ADDVrlhcO
 IbCROVxfmrmijms8yHDu3Fv5IwcatcVgMKcVkAUGBhoCn07vzKtaCjbJAkSGfHEjHSC/M8cqWf3
 kPI7ElqzYFxi1FY2peIFyJVW29g88K0OQhf5o3oHh4w==
X-Gm-Gg: AR+sD13PfBZpW+4csnr2KHbESimoYiiNa3nRFTxCqVZrOd5sASYkSdXoGZByf3mzr7/
 vxcVYc2AlOLKUowZTqshXcU1YhvbxmkfoQFDCfibDRTKxoaq7pMx/0YOai/VJjB38GChQYRZwYZ
 AJGRGOJqhEXAW9P8FE3KT2ed4G/NrnOOE5oGjzADrph3U/xoa4/2gb56AtAQbofxpSWJakw2gQo
 RXfGMjnEpg5ius+DO8+Q8FKOMwxhGp/i40+uQGB7rwg8G0N461+KM1xZMxro9qDYy5iCsUlqv2h
 WFoEGJ7burTd09dkBM5jBHZkjIA6in5cJavfbfJ+onxDmoCwngbowxnqV/32mCjTrIxMXSUrCEw
 Jz1MskOE6zXolsUOepKg2bHi87Aak
X-Received: by 2002:a05:690e:4887:20b0:660:4936:95d5 with SMTP id
 956f58d0204a3-66945480ec9mr1111441d50.40.1785502684845; Fri, 31 Jul 2026
 05:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260723233605.805-1-simonxhy0404@gmail.com>
 <20260723233605.805-2-simonxhy0404@gmail.com>
 <CAFEAcA_Ybrqb0g-cZYf6yL2eHRUZ6PfeWQMiVrVVeFJFp3q8KA@mail.gmail.com>
 <DM6PR02MB49408F0E20F38E117E7FA08FFECF2@DM6PR02MB4940.namprd02.prod.outlook.com>
In-Reply-To: <DM6PR02MB49408F0E20F38E117E7FA08FFECF2@DM6PR02MB4940.namprd02.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 13:57:52 +0100
X-Gm-Features: AUfX_mwhHN4YczljuUr35pt2yA3jGS3PHiNYGl4bxDW-fsy_E23m7ZYAtHpjLvY
Message-ID: <CAFEAcA8h9ca6gjKrBjvzX63OJ+1TCy=TTDCHA=0SHdv_TsFVGg@mail.gmail.com>
Subject: Re: [PATCH 1/4] target/arm/tcg/cpu-v7m.c: add cortex-m85 model
To: Simon Xu <simonxhy0404@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Fri, 24 Jul 2026 at 19:11, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> > The major reason IMHO to add a Cortex-M85 model would be to
> > have a CPU that supports M-profile PACBTI, so wouldn't
> > it be better to implement the feature first and then
> > add the CPU and the board model that uses it ?

> I understand your reasoning behind adding the feature first then the CPU/boards
> so that there's something to use the features. I looked through the patchew and
> saw that was how you handled it with the M55 CPU and v8.1-m features.
>
> To explain myself, this patch series was a part of my intern project at HPE. We
> currently have a fork of QEMU where we use it to emulate the HPE BMC. I am
> working on implementing the currently unavailable M85 CPU with the Custom
> Datapath Extension for internal use. I thought I could potentially upstream only
> the M85 CPU and related machines. I didn't include CDE because it was not fully
> polished and PACBTI because it was not super critical to my experimentations.
>
> I do agree there are no architectural differences between the M55 and M85 right
> now so I fully understand if this patch series is not sufficient for upstreaming.

I definitely think it's a great start and it's most of the work
that we'd need to do to be able to add a Cortex-M85 model.
We also had a series submitted which made an attempt at
the PACBTI implementation (though it only tried to do it
for user-mode, so it's also missing some parts):
https://lore.kernel.org/qemu-devel/20260518-pr-pacbti-v1-0-8932a885b03d@foss.st.com/

I've made review comments on the other parts of this patchset.
If you have time to work through those and respin, then I
might be able to find time to sort out the PACBTI part,
even if we can't commit the an555 board code immediately.
And even if not, we have these patches in the archive that
somebody else can pick up some day.

Incidentally, the custom datapath extensions would be a much
trickier thing to upstream, since by definition they're custom.
The Arm Fast Models handle these by letting the user supply
a plugin DLL that implements whatever the custom insns are,
but for QEMU external user-facing interfaces are always awkward
and it feels like specifying that in a workable way would be
a lot of effort for an extremely niche feature.

thanks
-- PMM

