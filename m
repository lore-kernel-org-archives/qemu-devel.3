Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D8010854DB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nHQ-0007i2-9X; Wed, 18 Mar 2026 05:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1w2nHO-0007hd-MW
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:33:30 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1w2nHM-0003tZ-VL
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:33:30 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43b4f48c47cso1185344f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 02:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773826406; cv=none;
 d=google.com; s=arc-20240605;
 b=LnHzO9b9jd7pu9h0f29P2Nkl5f3G9AvsxQKYwazUmwofbA1SQHBwTk+y2e/I5fC04T
 nXYvHqb9Stb8EJtzvdkQKlMBShnDOke3RrQCre2lAy4R2kKe9XtwguW9QKMvpm3QOpch
 EYtAJ89Y2rBFDOdDisA0sV50+G3t7b2/27GVeqz+gbqRpTwwSc52rT2jw+9IL4q0b2Pe
 DLW/JxyzjkyTQnNBZH7ugxrVufE5qByI1JYbyxzImE2H34Tf9+LlFlKJXaVPlj37PAPg
 7NveXGW7iw/PY99j9ogxKWNm4BXICdpTrjguhn5FVWc8L4zknJGx8mzGraifRO+zsfCC
 lH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k1fy0JqPs4yLcHo6z5qSg5Cwl4LO8vfIYNvOI6cMB6k=;
 fh=tfhvjx9GkMTxQ1z+1dMJ6hAmqvL/nKbjaZWqm5IU0hA=;
 b=lkvUraY/4GbenK0S3Z1i63gi4L5ezgwXRexnEY+cSIQmQ3psCQc9EqZfjswAR1+/FD
 5wDeFHayi81Y6CB9dJNk5sYcTAGVGd7J9tS2KvppETJZFHXMbfbLcMYN14AqFVtietMq
 EwwH2btCyDD28xm5llb+dtWMGYShswFS3byHH4dn9gqzCCxbd23q5Qy5/CFbjhiOIzPM
 5HLKO1+6FpXfWgaPo0uEubJCadtZh5KJplACvA+BvSDdFgRsnEl97aqECUD/QTnDlSkG
 ytjrDKVglBclqGz+KSkRxr+p3IYcDlDdCa3yRrpBx32+eB3oB95GXS/kpN1qL/Ejbruc
 x/Bg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773826406; x=1774431206; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k1fy0JqPs4yLcHo6z5qSg5Cwl4LO8vfIYNvOI6cMB6k=;
 b=zMRo+bukVDnpndilgqlF7qgbxapOB5ilDSWgv0FOvi2AzoCFLX7PDMLK+GOfKk9RcO
 B/JYg7+ijbjevqWDl/FmQ6V/C7ZhZmIH4kVFk7hsrfO7xAafnKHUlCs68nS29lmfVukG
 YQ6zaGp1Hejl3sC2LjUekhgHGxAYSDXADG96p/ICj/PfkKWoncrHJmJnaBELeev1owTt
 TOHquKro2zlL+G39ewmwP2pLRjhps0TtoTY4bspaA1XLjQPvAX2owWwHRRVQeuDGuYHe
 5HXmTRRmstY83VFgmAZUKKHQdWUeXN4x4yyGlvoHtFrHRYescEjLMmjkbuI4vwnzsFMt
 1ptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773826406; x=1774431206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k1fy0JqPs4yLcHo6z5qSg5Cwl4LO8vfIYNvOI6cMB6k=;
 b=NuuyPjFeKuCvB0TThOaw+OIBDAgEKn7cS8eTIozYe/Yuau0BL8tYOakS83HDYbcUKx
 s57QKq4tkj2HlF6HBVXDyLo5+Y3rcnm0gKVk2bI3eEScM5HZYQkRAFjYKS3gaIPcUtDl
 py/eJkcOxm6vclov5IuM5K1vdZ78PVvbJHoYZWkAqQNumzAyc1gdDbqFT5ipEk7yMCFU
 tHRNEvyFHmX+bYvNpZ9Omr669X8vRKxVhTxc2V54/lYjzVIg82P91AndbOfgs4/k/6K9
 nYIAJY3FhwRK77v4gwEJGaLDk0zXewGZSkPbv9eLmzeIK5GgPjt2q1olF5PdGNUuP9GL
 Gdrg==
X-Gm-Message-State: AOJu0Yy9LJegBGM+L2YuukAU3ne7qQKH9XysMbuWaqlNAMQzJVKD3A0r
 2r3RFCRqjFT0epygyClh/mzNFNGy0AkChGUPEi8kWop4uIKXvlKxC/NYM7aAWNIyVHvwc25dA7V
 WaVbSRoVx8p+E9zlUvgwP6qm8qhvJuh/SsyDgoZ+DWg==
X-Gm-Gg: ATEYQzxQKIyDIBzLqRfzkop5poCB0CPOeOOm/AyDAAKhD7YzD4mw1/vgiXiRgWZkJ/e
 NDMOy3fm28fCdUdhloT02fCcMQzOgApYtgYTMBoEZ0FW589RsA6fnq2ZZqkXqh62FunMfGtJkEG
 LwzNcv+Ya/4qR53HFbLhjP2xOCyY7PRoXHzOVx7k0IRzvz2ETR63CaG7wn46YedGF302C/1qnv2
 AZOrdwQ8darJ1nDuLM1+f00eGHpLFVvsy1q0/4sNXXDXHci/tXIUYxK8F0Z/GpVNVXXtywDDxQD
 CMdK4VVhfwJ3elRGHmnAE7YliG/MZFntgSno0ChI39Amy7lzrA==
X-Received: by 2002:a05:6000:2010:b0:43b:4ef0:e13 with SMTP id
 ffacd0b85a97d-43b527a9d88mr4394904f8f.12.1773826406494; Wed, 18 Mar 2026
 02:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260318082113.1127992-1-pbonzini@redhat.com>
 <CAAjaMXbRGLX6=dnP0mh2q5G3ZUe4H_JBmmzskiwKOf=Ddsh0Jg@mail.gmail.com>
 <980ab0ed-d009-4e7b-a199-8edc8379e676@redhat.com>
In-Reply-To: <980ab0ed-d009-4e7b-a199-8edc8379e676@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 18 Mar 2026 11:32:59 +0200
X-Gm-Features: AaiRm532buuHWtnVASPC1WA3-ZkkLJINV8qPxCzXS6Q9f2CD6y0okowKqkoLAvE
Message-ID: <CAAjaMXaRoghMM10Km=aMeGByibyc-bBqricaUCUORb6Rxxp2yQ@mail.gmail.com>
Subject: Re: [PATCH] rust: suggest passing --locked to "cargo install"
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
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

Hi Paolo,

On Wed, Mar 18, 2026 at 11:28=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On 3/18/26 09:51, Manos Pitsidianakis wrote:
> >> +      error('bindgen version ' + bindgen.version() + ' is unsupported=
. You can install a new version with "cargo install --locked bindgen-cli"')
> >
> > Am I missing something or is bindgen not in Cargo.lock? Also doesn't
> > this depend on `cargo-install` being invoked in the same path as
> > Cargo.lock, i.e. `rust/` subdir? (Not sure about this)
>
> Because the bindgen step is done in Meson it uses a bindgen binary that
> is preinstalled in $PATH; it doesn't build bindgen-cli the way you'd see
> it happen when done with build.rs(*).  Usually it can use the distro
> package, but as you can see from the tests/lcitool/ part of the patch
> it's too old for Ubuntu 22.04.
>
> The "cargo install bindgen-cli" command does not use QEMU's Cargo.lock,

So what does `--locked` do here? As per `--help`: "--locked Assert
that `Cargo.lock` will remain unchanged" What Cargo.lock does it not
change?

> it downloads bindgen-cli as a standalone package from crates.io and
> builds it.  It works even if invoked from `rust/`, that is QEMU's
> Cargo.lock does not interact with "cargo install".
>
>         (*) which I hate.  It's 67 crates and takes 5 minutes of CPU
>             time (1 minute wallclock).  Why did no one write a
>             simplified implementation of the same bindgen::Builder
>             struct, that calls out to a preinstalled bindgen binary?
>             But I digress.
>
>
> > I'd do `cargo install --version 0.60.0 bindgen-cli` instead
>
> Picking a specific version of bindgen-cli can be a good idea for the
> Ubuntu 22.04 container, but it does not fix the problem with the lack of
> --locked.  The breakage happened due to a new release of clap_lex, not
> bindgen.
>
> Paolo
>

