Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D70FCD0DA
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2mdZ-0006eH-Ry; Wed, 18 Mar 2026 04:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1w2mdX-0006e1-TF
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:52:19 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1w2mdV-0002tX-No
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:52:19 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439b611274bso4080533f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 01:52:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773823936; cv=none;
 d=google.com; s=arc-20240605;
 b=VW8A5K3gS9ebzgg/Rvi++k6B+icKJGwFRFYEuINJGpgWL8ZU4/qg2ISHoAILt6czlD
 ql5zdfK/oScWi2vrZqK8XpWvR/FI7BfCymmNYR3/jwylluE6p6xub/DPRA4nZUsaI+CG
 sUZpGcVy9dfxD4CjwcGPwIbsHiOxYFd03wO0jzj97ZvbdQhrywCp6uDKHLGSNZXQsMxQ
 FRyYjZN3ai/j5gLdQXj+H6UddxfGJzthhj5by3XuwivsqdljrfYiSaFjUfUhOtWlLCXk
 gtLAsg+/jRg4SdYK9wDJF9tsQFdkM6dduOgWeJ6sLgPLrln6qls0YbZI7z84REn37Wrs
 kCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XTtdsiC5FBCUf3nWRK1frgAGfl4FuTiwzTdwhp6m3WI=;
 fh=tfhvjx9GkMTxQ1z+1dMJ6hAmqvL/nKbjaZWqm5IU0hA=;
 b=WTPqKeLkD9WjyzPhuXUTaIKWGzin4k7GH5UtwjyZiF/dH9OOxsWyvYel0qVfj+y3QB
 wnS1MagF2wu6jhZDJS4/2uwDl+b1R1jEQnqW5dhVyzd35EN1Iy4tz8jbQYnrHx8FclT3
 aBcr7cdffWTxrVVoFWvkpPk9X4jtBg1vgi0yTN8FmGxs63JKRCIPgwwiSUvnWDjeYSEx
 HEWRThO8e5WRyZfni8rSVjIVv3745KzHXRjLGJKUNNQXCQypAbzav+HfBDXXzVFxRkLN
 IfiDVAW1/L3YElbDF8p1sCgnmHA3uXx49wN+y6yobeTT4FKWi+7Jyk5HC7tHsHgWQsKF
 3YDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773823936; x=1774428736; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTtdsiC5FBCUf3nWRK1frgAGfl4FuTiwzTdwhp6m3WI=;
 b=NxQG5owzE2wUv3kznI4bXFKafZNy0H4JWJ3acSq+MLna0hAjiML+kx93FbYUug/NsM
 4X35XRVRTxIHu5jpBLJZO0K18X32ZkKlfXTB4Us18mKkXqwkG1wYU0du9C4h+wmLp1eb
 zZr5C92BW1zdkGu94baJ6Q6aehUH1wtve8pmmsGTVcuSYvwYJx6fYS5faAUGdHNaqAHI
 mLt6MS1nLzQ21B9O7xbzYQG1z+w+3VMWzquxuFpupvZSJJSmcq73cpujfwryb8LqH770
 D+xZge6XkcmNDH+t13bfx5XSfbdC+FNuP2+nO1bzbPnXIlmlaepdQm76yP5Jfvm0m+74
 4SvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773823936; x=1774428736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XTtdsiC5FBCUf3nWRK1frgAGfl4FuTiwzTdwhp6m3WI=;
 b=b8kEbpbNCI816Q77gj7OJNakYJYk1jTFkWIt3zcIentGQxpGV4VGqIidfqKaOvDb8t
 AeN6gQ7EEB0ePv6rTVc/8X7Dt7SnbM6NdgcVjNJgK/OV1lgpx0fB8xhaT9cYC7TFaDn6
 euT/f46SOO+RH//ZSdCa7N6C+fzXMkJVG40/PZnAgbcUBZtqM72pmiiscVP+1tu811OD
 mK6lnOxosAk/PRVpCq4zh/QMkf7SAyFLhFY9k/Lo7+KVIYOdiY2Qdcvn0MYOFgIXmvAb
 D8J+9c4HKbF2TeXdieZBsF2P5UIy7UuGbwbfJU/EhuIGPinGbLlwK9P3FBHpxnpCiQ6e
 zLpg==
X-Gm-Message-State: AOJu0YztTb3sPvAdtsBUmttdKr7mt8DEC4BGP6PxE102Xkxlz8+h+F8f
 v17hUunzpnmyntZezjqFlNG7IPcjo4Lt9i5tzx7V36Nx57zDFnIY7DKn+d+qareVwonjYxAKtle
 n8wogJnZw+C+EX5oZ23CN0Vfb4RroIElb5S9IsPgcQA==
X-Gm-Gg: ATEYQzxo+AxAWndzmbNeakNm3Gmvf9o/jJhKsImatILzgkCsbinH6hZ4XYyiDx+Hkh7
 4+1mWKKEc0Tgs+M4DbFmsstvolSnU5xTVnFBukOLijfiIJAFUrZ6vUj7K2VwYPAKZOpuuIJF8D2
 mGBeu7Wyhezf/2Dxq4hiLAOTNR9MY9RKgjR7Ai+XtQXpZnt3sUZXo5AyolXbJQwVdB30ZhgBI42
 JFCRwvcXAM+sKpqpHg5Ui98X4KkPy2ZwgA+tO8NGOGDp4iuSeDfGhkWrQNRmtz96kYLzs2rmpnD
 DJaMPtp5E+0Y9CB7IehCmbdbTqy42gLE9+vU7V8wubLM2t0D1Q==
X-Received: by 2002:a05:6000:2512:b0:439:c2ce:1226 with SMTP id
 ffacd0b85a97d-43b527c1fcamr3605297f8f.33.1773823935505; Wed, 18 Mar 2026
 01:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260318082113.1127992-1-pbonzini@redhat.com>
In-Reply-To: <20260318082113.1127992-1-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 18 Mar 2026 10:51:49 +0200
X-Gm-Features: AaiRm51NgHhSQaMAEs9lVgTXsDEV7DoeXfocO8s4T2PhkZiVBFDuc7YCDwYikBA
Message-ID: <CAAjaMXbRGLX6=dnP0mh2q5G3ZUe4H_JBmmzskiwKOf=Ddsh0Jg@mail.gmail.com>
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

On Wed, Mar 18, 2026 at 10:21=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> Without the option, cargo will try using the latest version of the
> dependencies of bindgen-cli. While it will obviously respect the
> constraints in Cargo.toml, old versions of Cargo do not have
> version-constrained resolution and will choke on dependencies
> that need Rust 2024.
>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/about/build-platforms.rst                      | 2 +-
>  meson.build                                         | 2 +-
>  tests/docker/dockerfiles/fedora-rust-nightly.docker | 2 +-
>  tests/docker/dockerfiles/ubuntu2204.docker          | 2 +-
>  tests/lcitool/refresh                               | 4 ++--
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.=
rst
> index 6e3088d524a..3d23dfbd779 100644
> --- a/docs/about/build-platforms.rst
> +++ b/docs/about/build-platforms.rst
> @@ -114,7 +114,7 @@ Rust build dependencies
>    bindgen tool, which is too big to package and distribute.  The minimum
>    supported version of bindgen is 0.60.x.  For distributions that do not
>    include bindgen or have an older version, it is recommended to install
> -  a newer version using ``cargo install bindgen-cli``.
> +  a newer version using ``cargo install --locked bindgen-cli``.
>
>    QEMU requires Rust 1.83.0.  This is available on all supported platfor=
ms
>    except for the ``mips64el`` architecture on Debian bookworm.  For all =
other
> diff --git a/meson.build b/meson.build
> index d016482db1b..62fab727f4e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -114,7 +114,7 @@ if have_rust
>    bindgen =3D find_program('bindgen', required: get_option('rust'))
>    if not bindgen.found() or bindgen.version().version_compare('<0.60.0')
>      if get_option('rust').enabled()
> -      error('bindgen version ' + bindgen.version() + ' is unsupported. Y=
ou can install a new version with "cargo install bindgen-cli"')
> +      error('bindgen version ' + bindgen.version() + ' is unsupported. Y=
ou can install a new version with "cargo install --locked bindgen-cli"')

Am I missing something or is bindgen not in Cargo.lock? Also doesn't
this depend on `cargo-install` being invoked in the same path as
Cargo.lock, i.e. `rust/` subdir? (Not sure about this)

I'd do `cargo install --version 0.60.0 bindgen-cli` instead


>      else
>        if bindgen.found()
>          warning('bindgen version ' + bindgen.version() + ' is unsupporte=
d, disabling Rust compilation.')
> diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/=
docker/dockerfiles/fedora-rust-nightly.docker
> index 043b42a0a9b..38381ef8f59 100644
> --- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
> +++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
> @@ -179,7 +179,7 @@ RUN set -eux && \
>    test "$RUSTDOC" =3D "$(/usr/local/cargo/bin/rustup +nightly which rust=
doc)" && \
>    test "$RUSTC" =3D "$(/usr/local/cargo/bin/rustup +nightly which rustc)=
"
>  ENV PATH=3D$CARGO_HOME/bin:$PATH
> -RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli
> +RUN /usr/local/cargo/bin/rustup run nightly cargo install --locked bindg=
en-cli
>  RUN $CARGO --list
>  # As a final step configure the user (if env is defined)
>  ARG USER
> diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/do=
ckerfiles/ubuntu2204.docker
> index 23b33d6ad44..44e763f571a 100644
> --- a/tests/docker/dockerfiles/ubuntu2204.docker
> +++ b/tests/docker/dockerfiles/ubuntu2204.docker
> @@ -162,7 +162,7 @@ ENV CARGO_HOME=3D/usr/local/cargo
>  ENV PATH=3D$CARGO_HOME/bin:$PATH
>  RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>    apt install -y --no-install-recommends cargo
> -RUN cargo install bindgen-cli
> +RUN cargo install --locked bindgen-cli
>  # As a final step configure the user (if env is defined)
>  ARG USER
>  ARG UID
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 259e6ea0729..79a280feab4 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -147,7 +147,7 @@ fedora_rustup_nightly_extras =3D [
>      '  test "$RUSTDOC" =3D "$(/usr/local/cargo/bin/rustup +nightly which=
 rustdoc)" && \\\n',
>      '  test "$RUSTC" =3D "$(/usr/local/cargo/bin/rustup +nightly which r=
ustc)"\n',
>      'ENV PATH=3D$CARGO_HOME/bin:$PATH\n',
> -    'RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-c=
li\n',
> +    'RUN /usr/local/cargo/bin/rustup run nightly cargo install --locked =
bindgen-cli\n',
>      'RUN $CARGO --list\n',
>  ]
>
> @@ -158,7 +158,7 @@ ubuntu2204_rust_extras =3D [
>      'ENV PATH=3D$CARGO_HOME/bin:$PATH\n',
>      "RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \\\n",
>      "  apt install -y --no-install-recommends cargo\n",
> -    'RUN cargo install bindgen-cli\n',
> +    'RUN cargo install --locked bindgen-cli\n',
>  ]
>
>  debian_all_test_cross_compilers =3D [
> --
> 2.53.0
>
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

