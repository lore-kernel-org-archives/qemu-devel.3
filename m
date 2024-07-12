Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD961C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGDn-0006Bx-JW; Fri, 12 Jul 2024 09:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sSGDm-00067N-3r
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:21:58 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sSGDi-0003IH-3n
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:21:56 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52ea5765e75so2342889e87.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 06:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720790511; x=1721395311; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Q1YiXlRBwYtEqhlZxsYFrLPRnyTRtB2wNYNghujJvg=;
 b=ufjAAPJpzFrUd+RivNpgcv1JB5r4Hq6wtZ5SuTgO4TcqBgau8i2A8HkCf2To7oDbPN
 8SR13J1x6yAU6UkaEIaRuoBOGUb34SAsj/9dRuIW7l3FQ4tqN2cu8gf4A7ykweXCDiIa
 3d4diiy2+M3gbN/6xeNqKS4SZJll5/94PaJEXQLoz89OFY8es5LgfR99GpX8x4QTTXD+
 XTVeDUqbd/Z45KNnliEx5vNffiU7TDb3n4LwQMY/d2zlXy7rhUi6OrbpPDygIpBiPgdU
 QkK8HkrCl9DnVlenFd6ybYwI5Zi4i3PJsRjuuo6aDIK7Bq3kkgFGnaPKPEyxE8D3cE61
 QMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720790511; x=1721395311;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Q1YiXlRBwYtEqhlZxsYFrLPRnyTRtB2wNYNghujJvg=;
 b=IRqo3uIQIgck70LPM9JzkitVC6PHz24o7mEJmT/rImYIwM5e8LiCAfWbvNx4cOGGL/
 5tCwycVZGZZ8A5kjCDZnhA373z6fHSeowNMTZS3XZk2eZwlorc+FZw84NC4dbfpw2413
 2zOIEmjxerFhltH3IsS7z9cT8kwBLfbqj/7BQhGFYlGKjTe3Zv42RkQB2LYPPEINI/zc
 BEi1CHQdtXr+tkpqa+X94YjBM4zpcgF30KuLETJLvJIk4l2hDoV6APGmXSmJUnkpuNQC
 zDnr20ardaouK8xI8IMPFsA6g4ksSIkzBgXjnwTWIP9xMsJ8PPf7XHKNxxzfK9fmtpaI
 BCJw==
X-Gm-Message-State: AOJu0Yy/Vjqo1UwuZR29Oe0ajtuGhwj2MhO9fi/EZHUAvrvegVPbT/bU
 PJa0d+O+agiK1gf3RrhDYdiaWAZZ1Z1RioBiHTT8uOoufs/BFN6Da+HMUxRsZMKQiMX00ec7I2v
 SnsFjJ3KEGuEOnFWQMwQb0r3CxEM/z0C2TEhsKw==
X-Google-Smtp-Source: AGHT+IHs1hxrW9nbvPPikD5lNpgHouTB3PIlcgVPU6vqjimZ+mz9BCELf59roMu4Y9B1Ar3SLzCUdyo36Cvmz/ph+fo=
X-Received: by 2002:a05:6512:3e02:b0:52c:e180:4eac with SMTP id
 2adb3069b0e04-52eb99912c5mr7818300e87.9.1720790511046; Fri, 12 Jul 2024
 06:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240710154335.2510260-1-alex.bennee@linaro.org>
 <ZpEBds6AUnPsVCY4@redhat.com>
In-Reply-To: <ZpEBds6AUnPsVCY4@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 12 Jul 2024 16:21:34 +0300
Message-ID: <CAAjaMXbNMnq5QuqfX=AZubMdL3npFGjqBRk1jYFFtgtteyaqUw@mail.gmail.com>
Subject: Re: [RFC PATCH] build deps: update lcitool to include rust bits
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Ed Maste <emaste@freebsd.org>, 
 Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12c.google.com
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

Hi Daniel, Alex,

I will pick this patch up with all the reviewed-by trailers for my
next Rust RFC series if that's alright with you,

Manos

On Fri, 12 Jul 2024 at 13:12, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Jul 10, 2024 at 04:43:35PM +0100, Alex Benn=C3=A9e wrote:
> > For rust development we need cargo, rustc and bindgen in our various
> > development environments. Update the libvirt-ci project to (!495) and
> > regenerate the containers and other dependency lists.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> > ---
> > NB:
> >   - this is currently waiting on the upstream MR, but if you manually
> >   add the remote
> >   https://gitlab.com/stsquad/libvirt-ci/-/tree/more-rust-mappings the
> >   submodule update will work.
> > ---
> >  .gitlab-ci.d/cirrus/freebsd-13.vars                   | 2 +-
> >  .gitlab-ci.d/cirrus/macos-13.vars                     | 2 +-
> >  .gitlab-ci.d/cirrus/macos-14.vars                     | 2 +-
> >  scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 3 +++
> >  scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 3 +++
> >  tests/docker/dockerfiles/alpine.docker                | 3 +++
> >  tests/docker/dockerfiles/centos9.docker               | 3 +++
> >  tests/docker/dockerfiles/debian-amd64-cross.docker    | 4 ++++
> >  tests/docker/dockerfiles/debian-arm64-cross.docker    | 4 ++++
> >  tests/docker/dockerfiles/debian-armel-cross.docker    | 4 ++++
> >  tests/docker/dockerfiles/debian-armhf-cross.docker    | 4 ++++
> >  tests/docker/dockerfiles/debian-i686-cross.docker     | 4 ++++
> >  tests/docker/dockerfiles/debian-mips64el-cross.docker | 4 ++++
> >  tests/docker/dockerfiles/debian-mipsel-cross.docker   | 4 ++++
> >  tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 4 ++++
> >  tests/docker/dockerfiles/debian-s390x-cross.docker    | 4 ++++
> >  tests/docker/dockerfiles/debian.docker                | 3 +++
> >  tests/docker/dockerfiles/fedora-win64-cross.docker    | 3 +++
> >  tests/docker/dockerfiles/fedora.docker                | 3 +++
> >  tests/docker/dockerfiles/opensuse-leap.docker         | 2 ++
> >  tests/docker/dockerfiles/ubuntu2204.docker            | 3 +++
> >  tests/lcitool/libvirt-ci                              | 2 +-
> >  tests/lcitool/projects/qemu.yml                       | 3 +++
> >  tests/vm/generated/freebsd.json                       | 2 ++
> >  24 files changed, 71 insertions(+), 4 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

