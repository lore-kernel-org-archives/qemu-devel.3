Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E37C54EDA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 11:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjGpP-00034W-A5; Wed, 28 Aug 2024 07:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjGp1-00032h-R3
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:26:47 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjGou-000384-IC
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:26:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42808071810so56803775e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 04:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724844394; x=1725449194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jOQk+8SSsuBYmnmG5dfE6F/6VoLWWurVrBqPcOqTt0Q=;
 b=Mtk8oZXcVaI6HFQbEOXFayCLp+lnJiOtUsEm0l3ocmySr6ETeNJ0PmfZQkZZ6FhUam
 VZXjWB/8HvNw86wBsrNvCeOY2F32pw13fdRnktdO8ZqxgIPZAWyr4trmkQGSaxhgZ39E
 /uHDkQzCtnhQ7qHbE2/ttr5NSzD0Z3hcJ8093Xp0H5RvkzaKFr42yxaYgOjBCVnxs/Jv
 +TF3fnpZHPXUDvRtTlQDcw6U2BqOIVbGnalzn7MzlMiiaUnVLmQfqrXRsacF4FZyCiYK
 kafm+EZ3oXA60343Lgy97tytrmpwXAiZG+YqFwN78k6H3rHh79NOdaoF1qu3MTaO+fEZ
 Oxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724844394; x=1725449194;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jOQk+8SSsuBYmnmG5dfE6F/6VoLWWurVrBqPcOqTt0Q=;
 b=c8tpu9ASPNm2WgI6Yw3vGAfLyQvXaJIur5vDtdR1MnEO4qBH6NQ2HcaDGTlHAKRmyC
 aiBG097E3O/0+CzQI48LMFOZrPxxQBOZVN7oQwp7MyUTFX9nEimruwsan3A9U5j3xRka
 AzggFdJBhRPEzwXu7kAQFCPvQrxrOa06IMi9d8PoOqpAo97mLfHm4dJKV0K3in3+o/Rj
 wpuyUMSq10TfIA/E05lIBx109/pfp0OBnjMvJHqHUvU4OVEJhmVP7rRwEYeW8+p8mUJ4
 4UdM/a9StELD6RoZmlgLS8PxosjNeWDqHHFgAT5jAeIsCyP7bMvdSm4oS0say3V2cyWk
 E6hw==
X-Gm-Message-State: AOJu0YwTYykPJF+oNe1TsRe4sft8/NKyVVhWDkTGnUuwmC0eZBYqEMfR
 eFU9t8jyF4M8g6cT8yiHkOSecZlfJCtfUvTE/H7yDHz8jVHHqlXajiH1/9luW78=
X-Google-Smtp-Source: AGHT+IFngLS1HNgKu2IleTUD+951Qm+PdDQulwAgAETYM9jW2iPcY8UNGoyaduXcqtZhswCgyJvbfQ==
X-Received: by 2002:a05:600c:4f44:b0:426:66e9:b844 with SMTP id
 5b1f17b1804b1-42ba66929dbmr13133165e9.8.1724844393645; 
 Wed, 28 Aug 2024 04:26:33 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639d51dsm18417585e9.12.2024.08.28.04.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 04:26:33 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 61B915F796;
 Wed, 28 Aug 2024 12:26:32 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,
 Junjie Mao <junjie.mao@intel.com>,  Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH RESEND v9 2/9] build-sys: Add rust feature option
In-Reply-To: <20240828-rust-pl011-v9-2-35579191f17c@linaro.org> (Manos
 Pitsidianakis's message of "Wed, 28 Aug 2024 07:11:43 +0300")
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-2-35579191f17c@linaro.org>
Date: Wed, 28 Aug 2024 12:26:32 +0100
Message-ID: <87cyls51nb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Add rust feature in meson.build, configure, to prepare for adding Rust
> code in the followup commits.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  MAINTAINERS                   |  5 +++++
>  meson.build                   | 25 ++++++++++++++++++++++++-
>  Kconfig                       |  1 +
>  Kconfig.host                  |  3 +++
>  meson_options.txt             |  3 +++
>  rust/Kconfig                  |  0
>  scripts/meson-buildoptions.sh |  3 +++
>  7 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3584d6a6c6da9a3210150534d640d29ddf329dce..0bc8e515daf7e63320620b52b=
42a799b99dbe035 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4243,6 +4243,11 @@ F: docs/sphinx/
>  F: docs/_templates/
>  F: docs/devel/docs.rst
>=20=20
> +Rust build system integration
> +M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +S: Maintained
> +F: rust/Kconfig
> +
>  Miscellaneous
>  -------------
>  Performance Tools and Tests
> diff --git a/meson.build b/meson.build
> index 7eb4b8a41c0a667cacf693cfa2764f326ba72b1f..67eb4eda649d5f0566de2b754=
66b5a9d9ca87ab4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -70,6 +70,22 @@ if host_os =3D=3D 'darwin' and \
>    all_languages +=3D ['objc']
>    objc =3D meson.get_compiler('objc')
>  endif
> +if get_option('rust').enabled() and meson.version().version_compare('<1.=
0.0')
> +  error('Rust support requires Meson version >=3D1.0.0')
> +endif

Isn't this test obsolete as patch 1 ensures we have at least 1.50 anyway?=20

> +have_rust =3D false
> +if not get_option('rust').disabled() and add_languages('rust', required:=
 get_option('rust'), native: false)
> +  rustc =3D meson.get_compiler('rust')
> +  have_rust =3D true
> +  if rustc.version().version_compare('<1.80.0')
> +    if get_option('rust').enabled()
> +      error('rustc version ' + rustc.version() + ' is unsupported: Pleas=
e upgrade to at least 1.80.0')
> +    else
> +      warning('rustc version ' + rustc.version() + ' is unsupported: Dis=
abling Rust compilation. Please upgrade to at least 1.80.0 to use Rust.')
> +      have_rust =3D false
> +    endif
> +  endif
> +endif
>=20=20
>  dtrace =3D not_found
>  stap =3D not_found
> @@ -2131,6 +2147,7 @@ endif
>=20=20
>  config_host_data =3D configuration_data()
>=20=20
> +config_host_data.set('CONFIG_HAVE_RUST', have_rust)
>  audio_drivers_selected =3D []
>  if have_system
>    audio_drivers_available =3D {
> @@ -3076,7 +3093,8 @@ host_kconfig =3D \
>    (host_os =3D=3D 'linux' ? ['CONFIG_LINUX=3Dy'] : []) + \
>    (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=3Dy'] : []) + \
>    (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=3Dy'] : =
[]) + \
> -  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=3Dy'] : [])
> +  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=3Dy'] : []) + \
> +  (have_rust ? ['CONFIG_HAVE_RUST=3Dy'] : [])
>=20=20
>  ignored =3D [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
>=20=20
> @@ -4287,6 +4305,11 @@ if 'objc' in all_languages
>  else
>    summary_info +=3D {'Objective-C compiler': false}
>  endif
> +summary_info +=3D {'Rust support':      have_rust}
> +if have_rust
> +  summary_info +=3D {'rustc version':      rustc.version()}
> +  summary_info +=3D {'rustc':      ' '.join(rustc.cmd_array())}
> +endif
>  option_cflags =3D (get_option('debug') ? ['-g'] : [])
>  if get_option('optimization') !=3D 'plain'
>    option_cflags +=3D ['-O' + get_option('optimization')]
> diff --git a/Kconfig b/Kconfig
> index fb6a24a2de8c3ff11d4ee432d65ad000ba9d6c4d..63ca7f46df788144864b26ef5=
a64b29ad6547435 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -4,3 +4,4 @@ source accel/Kconfig
>  source target/Kconfig
>  source hw/Kconfig
>  source semihosting/Kconfig
> +source rust/Kconfig

I was wondering if we should call out the directory structure in
docs/devel but we don't currently. docs/devel/build-system.rst is
probably the wrong place for it so maybe we need a new section for code
layout. Anyway not a problem for this patch.

> diff --git a/Kconfig.host b/Kconfig.host
> index 17f405004b3bc765890688304322a1937ca8c01c..4ade7899d67a5ed91928f8ee1=
e287f5ba3331949 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -52,3 +52,6 @@ config VFIO_USER_SERVER_ALLOWED
>=20=20
>  config HV_BALLOON_POSSIBLE
>      bool
> +
> +config HAVE_RUST
> +    bool

Not this patches fault but the top of this Kconfig states:

  # These are "proxy" symbols used to pass config-host.mak values
  # down to Kconfig.  See also kconfig_external_symbols in
  # meson.build: these two need to be kept in sync.

but that was updated in 0a18911074 (meson: cleanup Kconfig.host
handling) and I can see host_kconfig has been updated. It would be nice
to put a patch in before just cleaning up that comment.


> diff --git a/meson_options.txt b/meson_options.txt
> index 0269fa0f16ed6b6f734fcefa2cfa94aa029fa837..fa94a5ce97bb14ab108e21ccc=
b651923ac6a58f8 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -371,3 +371,6 @@ option('hexagon_idef_parser', type : 'boolean', value=
 : true,
>=20=20
>  option('x86_version', type : 'combo', choices : ['0', '1', '2', '3', '4'=
], value: '1',
>         description: 'tweak required x86_64 architecture version beyond c=
ompiler default')
> +
> +option('rust', type: 'feature', value: 'auto',
> +       description: 'Rust support')
> diff --git a/rust/Kconfig b/rust/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..e69de29bb2d1d6434b8b29ae7=
75ad8c2e48c5391
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index c97079a38c9e4ed24a0fe9b44e492b7108481048..5e8a225a6b343cf506950a314=
6af718d52a6c1a0 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -170,6 +170,7 @@ meson_options_help() {
>    printf "%s\n" '  rbd             Ceph block device driver'
>    printf "%s\n" '  rdma            Enable RDMA-based migration'
>    printf "%s\n" '  replication     replication support'
> +  printf "%s\n" '  rust            Rust support'
>    printf "%s\n" '  rutabaga-gfx    rutabaga_gfx support'
>    printf "%s\n" '  sdl             SDL user interface'
>    printf "%s\n" '  sdl-image       SDL Image support for icons'
> @@ -452,6 +453,8 @@ _meson_option_parse() {
>      --disable-replication) printf "%s" -Dreplication=3Ddisabled ;;
>      --enable-rng-none) printf "%s" -Drng_none=3Dtrue ;;
>      --disable-rng-none) printf "%s" -Drng_none=3Dfalse ;;
> +    --enable-rust) printf "%s" -Drust=3Denabled ;;
> +    --disable-rust) printf "%s" -Drust=3Ddisabled ;;
>      --enable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=3Denabled ;;
>      --disable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=3Ddisabled ;;
>      --enable-safe-stack) printf "%s" -Dsafe_stack=3Dtrue ;;

Without the unneeded version check:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

