Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0435ED15D98
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2tCF-00083g-3p; Mon, 21 Oct 2024 10:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2tC5-0007yX-7Y
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:15:45 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2tC2-0006cz-UM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:15:36 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c984352742so4848805a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729520132; x=1730124932; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ArrduzBsxKEiFPZEnyjJFo/+AjF7LZd9W1CCHU7yPhw=;
 b=gD6V1/IJafl4BRroLbdog7wBI9EnN9OogKfeIxnVYZ/4s4cdnuFEqatWVizIk2gRvH
 ZiQpSCIGRTO6nlo0Apq7hc9INKBG/SlP5Eedf6LXww6zHG4gXRjhxCPa/CoZI1vOhI9s
 BJmBXKHZP4B6O7StJGZUtW6MfOiyDiG47dBdJVewNhJGVhYYeRq+5p+VlWFDlqGje/3P
 WWcIQmZDb1iN2CvaF6JCUahjhOhGmHNIEpNfLeSFA9E4puLGFeE7e4ZdlGi3lDi0TKOC
 JB3oPk3jofREQqrKj1403rb2oVynnagPwkbpnoOlgLGoNTMu8pF4W+JFXF6dVBP7Lm7M
 S6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729520132; x=1730124932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ArrduzBsxKEiFPZEnyjJFo/+AjF7LZd9W1CCHU7yPhw=;
 b=tB+xNyQkC1f3HLVHsa66EHFKp26nGj4BdnGW0Anl/2jlh/lyjXrdj8FrpswTD9fblD
 lM53bZmxleRwDF3FKJzqapqpWaJsG1Hg+olpHx+cAec3LpMMcSIWkHsiTUmLWPwLjKHq
 aRKty9gGBVdTAnWLlEPEOuqR2FV3OC46Hx42gTBI9Ll+kVrA/HwfnzL9qk/pQMFG3PUV
 bjK3h0CCTlC1HhQcOLFP8iEgsqqDV4Nm+nszT69h7qjHi/Dl4kGvT2AcPcniXLmsX7st
 iVPzaftwdvtzJC+0gLKevvSVIcO7hx9j4B/LzXRHtBkqN+F7VcwhfvhHnBaCDbFYrFtx
 ZhgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmdSszCr46MZlVKn7Sb9TLs/hHdUM9mvCGIdbW+D4a9ergvOdgiQlLChBlGHsVPwqu85/yp+3K/wX4@nongnu.org
X-Gm-Message-State: AOJu0YznoxgyUhN3tBUTI2edxAiYT0w43PeayGQ5Gl4RXsdM6JBdau8A
 TjiJ104c6Mwc+4c2TwG61mpk1S4VrGVG1d7I0MnKxaQ39Xr8JlzO9CqpzXhnyIk69qf8kQTpgAN
 y6YeTRQ3y76ZjPtFcT+9wy0jAPN4BZU2MaauJdA==
X-Google-Smtp-Source: AGHT+IFfrZby788opKSrGtoMHfIlXseuD9FYds9q5j+mCMG56grUv4nYW+iv+wEIEn9Bf1Lek6WdDc2IMeM/JZHsn/g=
X-Received: by 2002:a05:6402:3493:b0:5c4:14fe:971e with SMTP id
 4fb4d7f45d1cf-5ca0af92f0fmr7414362a12.23.1729520131793; Mon, 21 Oct 2024
 07:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <ZxJjLpDe0-A_6PEL@redhat.com>
 <2f34640b-77ad-4267-975e-7898b6f8e38d@redhat.com>
In-Reply-To: <2f34640b-77ad-4267-975e-7898b6f8e38d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2024 15:15:20 +0100
Message-ID: <CAFEAcA8HBNkbWOJ26jfopah1CDAm2qfJiudVJ1n2aeKayDFZ6w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/16] rust: allow older versions of rustc and bindgen
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, 18 Oct 2024 at 16:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/18/24 15:31, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Oct 15, 2024 at 03:17:18PM +0200, Paolo Bonzini wrote:
> >>                                                   Another possibility
> >> could be to accept Rust 1.64.0 but require installing a newer bindgen
> >> (0.66.x for example) on those two distros with an older release.
> >
> > How difficult is it to get newer 'bindgen' installed on these
> > platforms ? The audience here is not so much distros trying to
> > package new QEMU, as that's ony relevant for new distro, but
> > rather it is end usrs/contributors building QEMU for themslves.
>
> Very simple - "cargo install bindgen-cli", as already seen in the
> fedora-rust-nightly container's Dockerfile (note: building QEMU does
> _not_ need cargo).  In fact we could in fact do it via libvirt-ci, and
> it's quite possible that MacOS or some BSDs will need it.

Why doesn't 'rustup update' do this automatically? My Ubuntu 22.04
system I'm using 'rustup' to provide the rust toolchain,
and 'rustup update' updates rustc, cargo, clippy, etc, so
why isn't it also providing and updating bindgen?
('bindgen' for me is ~/.cargo/bin/bindgen, so not the system one.)
My expectation here was that "rustup update" would keep
the whole toolchain up-to-date...

thanks
-- PMM

