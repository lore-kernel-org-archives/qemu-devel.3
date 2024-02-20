Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48706C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 17:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcTWY-0002wz-HX; Tue, 20 Feb 2024 12:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcTWW-0002wQ-RD
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:03:16 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcTWU-0006iy-1I
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:03:16 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso5731975a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 09:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708448592; x=1709053392; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NqeR/kVadd0kl3tBhSYcwh36UrIE7Pnl9a16h/JaRf8=;
 b=vektG6yrjvoBObJxl3WxC8K29V0EiTFiRRtcK1hlYpFA8Td8M//Mvx1GfiuC5InfzF
 tBKY21lpfSdyvd88FshmK2DbqG5/B1l3KkCE5EQnVQTYLgg6h/UuqTHPI7QsYIEQlRli
 95uDSt9nfFjrjvYrbo3pVnVBFyi3+Owk3OQ+kFMVc2R29o695w1MT9e4B+nZh/fB9PuH
 SCE+HsFx9Uc3iiTChlMWyUWC1rBiC/pikPqltJwZfvp4yGRwx44vxZ02JxOhzdhi/lbG
 7Bs0chEwcTpSf3bmh8vcakYaRvZVzfQiS0sJ+/0UhzrbTdPX9nBGMjgpQoC02AqbmHkh
 3pRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708448592; x=1709053392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NqeR/kVadd0kl3tBhSYcwh36UrIE7Pnl9a16h/JaRf8=;
 b=lhCCrgBfLR5BnOO1a/kTNXO4ajSPXi0lpgyelf0bf6YJaV4C+K3f//ZMoanbgouY3F
 RCYRmuJ/uhVVbx7S4qP5kyKme/Tz+e+yUJVCOKWzxVmG17ZQQH9thfrasIJQ/l6x8Csn
 xxLGFEmVznRNjXcMhDQf0ctGeg4M3+k8MVHUnOkjKNcf1GzwGYwxaY61kidG545F1k5b
 leIdB2h92GWvV3GBWsjyoBWWiLXRwXOM2Bt8Yo8ZA8C+Q1YQvxqnYn1mukXsAchQrwrn
 l4WK3UxJqx/V3slVN9nxngoChIdgkrcRy0rUNGargSsypEAwMmHK5m7M+Y0gBuQcfYyM
 db6w==
X-Gm-Message-State: AOJu0Ywk16Es2l/kE0vFaz+FGCSSy+UHM9OzdAtMaT2P14E5aekV4wVZ
 uiSFL6l7D5Eca1G/rAQYSbpSPVl21vTuCcHi1TSd6pQXqWmuPc0DwByACV0bMiO++ONxeyjKe9G
 h6/EgNQQVJVC7tPp1PIl/l235PJi0EQVpF7Y1pA==
X-Google-Smtp-Source: AGHT+IFsLKJ7feb2rlmKikHiGrCgeNXLMCvQmIrTFoqe+nuO3nry9tN8O55OpT6Adl3CueXh6vUNHxwnS4/jP7XyPx0=
X-Received: by 2002:a05:6402:234b:b0:563:c54e:f1 with SMTP id
 r11-20020a056402234b00b00563c54e00f1mr13213150eda.2.1708448592203; Tue, 20
 Feb 2024 09:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20240220165602.135695-1-peter.maydell@linaro.org>
 <0726d0f4-ded9-4f9b-92d8-611aefb71762@redhat.com>
In-Reply-To: <0726d0f4-ded9-4f9b-92d8-611aefb71762@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2024 17:03:00 +0000
Message-ID: <CAFEAcA-RyCEE9HRPDUyg_Eqgoz=n_+tgEwak8V-nDr52HtqSSg@mail.gmail.com>
Subject: Re: [PATCH] .gitlab-ci.d/windows.yml: Drop msys2-32bit job
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 20 Feb 2024 at 17:01, Thomas Huth <thuth@redhat.com> wrote:
>
> On 20/02/2024 17.56, Peter Maydell wrote:
> > MSYS2 is dropping support for 32-bit Windows.  This shows up for us
> > as various packages we were using in our CI job no longer being
> > available to install, which causes the job to fail.  In commit
> > 8e31b744fdf we dropped the dependency on libusb and spice, but the
> > dtc package has also now been removed.
> >
> > For us as QEMU upstream, "32 bit x86 hosts for system emulation" have
> > already been deprecated as of QEMU 8.0, so we are ready to drop them
> > anyway.
> >
> > Drop the msys2-32bit CI job, as the first step in doing this.
> >
> > This is cc'd to stable, because this job will also be broken for CI
> > on the stable branches.  We can't drop 32-bit support entirely there,
> > but we will still be covering at least compilation for 32-bit Windows
> > via the cross-win32-system job.
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Minimal patch that disables CI, for ease of backporting.
> > ---
> >   .gitlab-ci.d/windows.yml | 9 ---------
> >   1 file changed, 9 deletions(-)
> >
> > diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> > index 5c1e385dc89..8fc08218d28 100644
> > --- a/.gitlab-ci.d/windows.yml
> > +++ b/.gitlab-ci.d/windows.yml
> > @@ -131,12 +131,3 @@ msys2-64bit:
> >       # qTests don't run successfully with "--without-default-devices",
> >       # so let's exclude the qtests from CI for now.
> >       TEST_ARGS: --no-suite qtest
> > -
> > -msys2-32bit:
> > -  extends: .shared_msys2_builder
> > -  variables:
> > -    MINGW_TARGET: mingw-w64-i686
> > -    MSYSTEM: MINGW32
> > -    EXTRA_PACKAGES:
> > -    CONFIGURE_ARGS:  --target-list=ppc64-softmmu -Ddebug=false -Doptimization=0
> > -    TEST_ARGS: --no-suite qtest
>
> We could maybe merge .shared_msys2_builder with the msys2-64bit job now that
> we only have one Windows-based job left ... but that's maybe also rather
> something for another patch

Yeah, that was the bit I left for a different patch for backporting
reasons. I'm also working on eg having the docs say 32-bit Windows
isn't supported, etc.

-- PMM

