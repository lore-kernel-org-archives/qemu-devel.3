Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D7FCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZW97-00026G-UE; Tue, 16 Jun 2026 11:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZW96-00025U-CY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:56:12 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZW94-0003jG-8G
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:56:12 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66049669d78so4590678d50.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:56:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781625369; cv=none;
 d=google.com; s=arc-20240605;
 b=cn3Lteq1cQQtcZFlwcv1EiDi/m9MbDnp+towT7yqM/73LoWxBS//lh5D6OaS0AwGRV
 +I/SXuViCbyShtoKlixj38Bja63ezFIec91nz09npFpzDmSK/7lmwZ7c6Y0qNOct6J3S
 ZuEUkdKH71AgoaLceY+dtPRVzdhYgDm173emrBZOup8dsRJdsD8uo0QykxXCuoC2MnZc
 DzV2S+cXHsWXt7pzGP+jRjFUhI4+YuEu+TTy2wKJ419Tl2J93otYyhhgdBq+ICtewF2+
 Y9kru4KpqS8Bcm5HF47z3zWhqdzn75mgRMLW1CaLvvMSqMqeWDLupKwW1GHaCDGX3c1c
 4Saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aLlXLLlZpsJLIJhAoQ1vgzkz1ZtgpX1qYhgNOsL8Bkw=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=BEXJmfRyvvReTofcrJbR07rVNih4Lb3bxtinjTNP6jJ013sHAsT29MEbdu0/i7+VJ+
 WMMCOun20CMGvRKZ4J7LUulOlWu3OiOCcvl9mr0McJOuIQOEP9h7UH4W6TRZm2z5GS5X
 7A0WmBAxYR2IAR1wWFf6uJhvtUQPw39NHcLuM4GRq63vdvKyuXGF1IY8xxiNl5XQ4dqn
 pGu8V80Zzhs36aDHfwae4rLQZhZbo27nBPzKpxgvgrwNg7Qd5MSryVW7EiM2SVmCm0Ve
 2R03QCeYGi8qQtSujK+6BQUPFyVsZ07hVHtLCL/RzRUccRtlig2lQiNk9cKPBMqCyBXs
 ZMgA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781625369; x=1782230169; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aLlXLLlZpsJLIJhAoQ1vgzkz1ZtgpX1qYhgNOsL8Bkw=;
 b=N1J1UxnSPrf1NBUwYxU8x5uo6XsgCigZsaj4z1IKzkpljHSOjAhigO7DEcgqrpW4sP
 Bx8YggbhRFq+M0Fo+DkxR/ShU3GYT+9niofzpKZ5NnEmF9oFf0re+CwUI2aJlq8N/QrZ
 dAk1io38FjUq7VQkA9hPa6Bv3btG3q+7RXi+XcaQqbC8xHoxOaoRAi158d5iq1Q/s3dC
 ZwMmR9FJd1V2ehg/qZ+b3DHGrPMJBOmJ7czUYN12U4U0xsp1wONn4a1rst9LGa4TzSBo
 BDmJtfEVtEW5q72WHcyr78fRXQ1ZweOBwlyfiKadFVsV6IazK8H9kpVNXaloBP+9bY/F
 +PSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781625369; x=1782230169;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aLlXLLlZpsJLIJhAoQ1vgzkz1ZtgpX1qYhgNOsL8Bkw=;
 b=Qgbj4F3Kmvhv0QAS2ie37FDpsgoPiWElDPNjjL1cY0GZ1OLBX38aVYa6xnf4tgdvdp
 67FYoS62vIwdfB9CslkVFEGM7QGWtXduF9eGOdnnEweNDGIF4Kt1u0afZwEvgaErv1DL
 6IPUuTB17v/Kfm8DZaz0uLWfmRHPBDXUCDp4IbA9qitWrNJmrF38P0w5tXW/9m3rZ7Q3
 QOXk4Q1Rv8uzzGx00odWd+RGQqKiR9EmsbCoILxoUS4ce/OHOic4JueMTPtP1p89owqs
 jHydEZgb79kDzEg8zRVfGJQkBWEHxn+Cfmdur3SePOVDZvNYkIxOYbpddDXHb4qmYuTe
 A2XQ==
X-Gm-Message-State: AOJu0YxpZj7wsWNNX3TCuEti+gpyzeERK8B9if1l2PS5Hsqq7uFVQSsO
 FRSIOLhIazjZXraauL7zBpUcFe4g/SxTw21RLqiWfFdzGVHJLAal17bgQZLJ7Cr/u6kJ9aECxoU
 //+Qfksh1Xo4I8ZbGgc2Q0AFLLXThT+El0JYkv3RgBg==
X-Gm-Gg: AfdE7cm2+8uwcmCf8VJQqqocEk/s0IIcYqZ8JzAsjxSp68uybFeFUcQ1GhTyWk6m1+H
 bDONDWuBGlRiqMn7IA1UxJ7wqB4iWx7s0n0Gtf5ROAQ1kTBDuE63UEF1RWPWb5yxpEWqc3tDnyM
 zAG18nE1AXo8+StpdYFMm2unZXsqNJpUyCdq4NTZ3c0ycYOSMqPANUpeWq8eb1rTJL8elzprEwH
 +n2CD2RTwlgH3LV8DX5XpNIDhdsYxzjOxrsVxrx+3TOdurXEUVbbtcsa2atElrSQwub1jhNmfHU
 Vto7/3bv93YTfd12SpOaVMTjBcUB/y+IbP17zPfYMgCOo4iFLgpMzDEd3lAEzlIMy3o=
X-Received: by 2002:a05:690e:144d:b0:650:1cdb:5f57 with SMTP id
 956f58d0204a3-66277f2cb2amr15754178d50.5.1781625368876; Tue, 16 Jun 2026
 08:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 16:55:56 +0100
X-Gm-Features: AVVi8Ce3H6kSUtKwn2x0XdizAtwIacXLa4FYqe-2djmgrrcPXqKyqoxEV6tpLpU
Message-ID: <CAFEAcA8dg3Vyfj7UXgaP1L9Eq3mZS4K+pbwn7wVopC_RDG=E1g@mail.gmail.com>
Subject: Re: [PATCH 00/25] target/arm: Implement FEAT_SVE2p2
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Fri, 5 Jun 2026 at 00:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: 20260603032855.106930-1-richard.henderson@linaro.org
> ("[PATCH v9 00/45] target/arm: Implement FEAT_FP8")
>
> Another batch of code on the way toward FEAT_SME2p2.
>
>
> r~
>
>
> Richard Henderson (25):
>   target/arm: Add feature predicates for SVE2.2 and SME2.2
>   target/arm: Rename sve unary predicated patterns
>   target/arm: Enable zeroing in DO_ZPZ macros in sve_helper.c
>   target/arm: Expand DO_ZPZ in translate-sve.c
>   target/arm: Implement SVE integer unary operations (predicated,
>     zeroing)
>   target/arm: Implement SVE bitwise unary operations (predicated,
>     zeroing)
>   target/arm: Implement SVE reverse within elements (zeroing)
>   target/arm: Implement SVE reverse doublewords (zeroing)
>   target/arm: Implement SVE2 integer unary operations (predicated,
>     zeroing)
>   target/arm: Add data argument to do_frint_mode
>   target/arm: Implement Floating-point round to integral value
>     (predicated, zeroing)
>   target/arm: Implement Floating-point convert (predicated, zeroing)
>   target/arm: Implement Floating-point square root (predicated, zeroing)
>   target/arm: Implement SCVTF, UCVTF (predicated, zeroing)
>   target/arm: Implement FRINT{32,64}{X,Z}
>   target/arm: Enable zeroing in DO_FCVT{N,L}T macros in sve_helper.c
>   target/arm: Implement SVE floating-point convert (top, predicated,
>     zeroing)
>   target/arm: Implement floating-point log and convert to integer
>     (zeroing)

I'm going to apply these first 18 patches (all the zeroing versions
of insns) to target-arm.next as they all were straightforward,
and I have a pullreq nearly ready to go.

thanks
-- PMM

