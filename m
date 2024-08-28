Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3846C54EE3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHWv-0006aN-Mc; Wed, 28 Aug 2024 08:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjHWr-0006Pk-RR
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:12:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjHWp-00086U-OV
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:12:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-428178fc07eso55663035e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 05:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724847117; x=1725451917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/IdnejZ0+c5D0kkc//Gu0db6ZVpVK0+X6RKIZc/oqQY=;
 b=zALxLJ9fs4fZYv1q1fty1moWZaCFrViaT+FC7xdLFDjUGpBlMU3AtmkeWC5A09RBoA
 ONrf9xDPuhXvo8/zySqInfB+51qfvTsVVZrCGmG9qmQWit9w54h/SzYQDBFX74odKDAB
 KltcsFWgn2hT8cqFrmZJjD9vlWPH/6FIUkbGCjBTH5sDvIjL6QLU6mOTLDzJXcacen3s
 qAHEKZ3ysCXBDWUowetKozlv0UopG8fTamzCe7oxRCZol3l4xeZdWG/6JCHMbCnFq3Vb
 BM6C9eH/pSuetcP457y1i9OPq6/ppo0w4aLE1O79KISvJ94qB4EGSpEuJs7IbEfl5Hqt
 bJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724847117; x=1725451917;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/IdnejZ0+c5D0kkc//Gu0db6ZVpVK0+X6RKIZc/oqQY=;
 b=G5lTCbRMBEClWq/Mp3GQmY6u7L2aW5Wh8Mqf044lP5FNF0IEGj5dyoGI0CkVxKjq4X
 f+QPHajLY8J02zsHxj8J3HPLmsj5lNNjp5CRpWIYL4ijP3Kdks1PyzActJPOYOhmWgzD
 5dXnDP+GtIwj1xXxJjQY1yoasDJ7tpTWSbi2xclCrAGcD5YSMwkoYXxnLc3e9vJ5jngV
 wqLZzm3b0jBC+uekA3MgzYAiBX8V+gxhC6fRtNiMlHXoa5L9JQdYzd0fjVYRpkaxCj8/
 /I5s/z+1MWiiW8a70WN4LC1aqZCTUOo5t7W+hr8VMGQwaJtIc/0Z1egRiSf1b4Gm658L
 xHHA==
X-Gm-Message-State: AOJu0YxwjC3WGVHV1cklwtN7z0XDwqor6FzBEcM7QPl8NKtj3R6C6q6C
 6fkHhbFGs7M71rLrRXK1sy4fWhY9K4pNAOSX16b7XhFzNeI5XnMJ7kd4gIObsfo=
X-Google-Smtp-Source: AGHT+IEoSLyxAvBvLK89hASOAmIEbBVTy3MCM0dZM+qnhxwILxwrl4ICj3NVMw4divjkVA8nvSIM5A==
X-Received: by 2002:a05:600c:4707:b0:426:62c6:4341 with SMTP id
 5b1f17b1804b1-42acd57c086mr121245405e9.20.1724847116403; 
 Wed, 28 Aug 2024 05:11:56 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639d51dsm19544285e9.12.2024.08.28.05.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 05:11:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 349FB5F796;
 Wed, 28 Aug 2024 13:11:55 +0100 (BST)
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
Subject: Re: [PATCH RESEND v9 3/9] configure, meson: detect Rust toolchain
In-Reply-To: <20240828-rust-pl011-v9-3-35579191f17c@linaro.org> (Manos
 Pitsidianakis's message of "Wed, 28 Aug 2024 07:11:44 +0300")
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-3-35579191f17c@linaro.org>
Date: Wed, 28 Aug 2024 13:11:55 +0100
Message-ID: <875xrk4zjo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> Include the correct path and arguments to rustc in the native
> and cross files (native compilation is needed for procedural
> macros).
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure   | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  meson.build |  8 +++-----
>  2 files changed, 51 insertions(+), 7 deletions(-)
>
> diff --git a/configure b/configure
> index 019fcbd0ef7b07e7b0280b358099cae72c73aa98..9ef6005c557fc627c7c6c732b=
4c92ed1b934f474 100755
> --- a/configure
> +++ b/configure
> @@ -207,6 +207,8 @@ for opt do
>    ;;
>    --objcc=3D*) objcc=3D"$optarg"
>    ;;
> +  --rustc=3D*) RUSTC=3D"$optarg"
> +  ;;
>    --cpu=3D*) cpu=3D"$optarg"
>    ;;
>    --extra-cflags=3D*)
> @@ -252,6 +254,9 @@ python=3D
>  download=3D"enabled"
>  skip_meson=3Dno
>  use_containers=3D"yes"
> +# do not enable by default because cross compilation requires --rust-tar=
get-triple
> +rust=3D"disabled"
> +rust_target_triple=3D""
>  gdb_bin=3D$(command -v "gdb-multiarch" || command -v "gdb")
>  gdb_arches=3D""
>=20=20
> @@ -317,6 +322,8 @@ windmc=3D"${WINDMC-${cross_prefix}windmc}"
>  pkg_config=3D"${PKG_CONFIG-${cross_prefix}pkg-config}"
>  sdl2_config=3D"${SDL2_CONFIG-${cross_prefix}sdl2-config}"
>=20=20
> +rustc=3D"${RUSTC-rustc}"
> +
>  check_define() {
>  cat > $TMPC <<EOF
>  #if !defined($1)
> @@ -636,6 +643,8 @@ for opt do
>    ;;
>    --objcc=3D*)
>    ;;
> +  --rustc=3D*)
> +  ;;
>    --make=3D*)
>    ;;
>    --install=3D*)
> @@ -755,8 +764,14 @@ for opt do
>    ;;
>    --container-engine=3D*) container_engine=3D"$optarg"
>    ;;
> +  --rust-target-triple=3D*) rust_target_triple=3D"$optarg"
> +  ;;

Could we not map from --cross-prefix to the target triple? Having to
specify both seems prone to failure.

>    --gdb=3D*) gdb_bin=3D"$optarg"
>    ;;
> +  --enable-rust) rust=3Denabled
> +  ;;
> +  --disable-rust) rust=3Ddisabled
> +  ;;
>    # everything else has the same name in configure and meson
>    --*) meson_option_parse "$opt" "$optarg"
>    ;;
> @@ -859,6 +874,7 @@ Advanced options (experts only):
>                             at build time [$host_cc]
>    --cxx=3DCXX                use C++ compiler CXX [$cxx]
>    --objcc=3DOBJCC            use Objective-C compiler OBJCC [$objcc]
> +  --rustc=3DRUSTC            use Rust compiler RUSTC [$rustc]
>    --extra-cflags=3DCFLAGS    append extra C compiler flags CFLAGS
>    --extra-cxxflags=3DCXXFLAGS append extra C++ compiler flags CXXFLAGS
>    --extra-objcflags=3DOBJCFLAGS append extra Objective C compiler flags =
OBJCFLAGS
> @@ -869,8 +885,9 @@ Advanced options (experts only):
>    --python=3DPYTHON          use specified python [$python]
>    --ninja=3DNINJA            use specified ninja [$ninja]
>    --static                 enable static build [$static]
> -  --without-default-features default all --enable-* options to "disabled"
> -  --without-default-devices  do not include any device that is not neede=
d to
> +  --rust-target-triple=3DTRIPLE  target for Rust cross compilation
> +  --without-default-features   default all --enable-* options to "disabl=
ed"
> +  --without-default-devices    do not include any device that is not nee=
ded to
>                             start the emulator (only use if you are inclu=
ding
>                             desired devices in configs/devices/)
>    --with-devices-ARCH=3DNAME override default configs/devices
> @@ -1139,6 +1156,21 @@ EOF
>  fi
>=20=20
>  ##########################################
> +# detect rust triple
> +
> +if test "$rust" !=3D disabled && has "$rustc" && $rustc -vV > "${TMPDIR1=
}/${TMPB}.out"; then
> +  rust_host_triple=3D$(sed -n 's/^host: //p' "${TMPDIR1}/${TMPB}.out")
> +else
> +  if test "$rust" =3D enabled; then
> +    error_exit "could not execute rustc binary \"$rustc\""
> +  fi
> +  rust=3Ddisabled
> +fi
> +if test "$rust" !=3D disabled && test -z "$rust_target_triple"; then
> +  rust_target_triple=3D$rust_host_triple
> +fi
> +
> +##########################################
>  # functions to probe cross compilers
>=20=20
>  container=3D"no"
> @@ -1604,6 +1636,9 @@ if test "$container" !=3D no; then
>      echo "RUNC=3D$runc" >> $config_host_mak
>  fi
>  echo "SUBDIRS=3D$subdirs" >> $config_host_mak
> +if test "$rust" !=3D disabled; then
> +  echo "RUST_TARGET_TRIPLE=3D$rust_target_triple" >> $config_host_mak
> +fi
>  echo "PYTHON=3D$python" >> $config_host_mak
>  echo "MKVENV_ENSUREGROUP=3D$mkvenv ensuregroup $mkvenv_online_flag" >> $=
config_host_mak
>  echo "GENISOIMAGE=3D$genisoimage" >> $config_host_mak
> @@ -1735,6 +1770,13 @@ if test "$skip_meson" =3D no; then
>    echo "c =3D [$(meson_quote $cc $CPU_CFLAGS)]" >> $cross
>    test -n "$cxx" && echo "cpp =3D [$(meson_quote $cxx $CPU_CFLAGS)]" >> =
$cross
>    test -n "$objcc" && echo "objc =3D [$(meson_quote $objcc $CPU_CFLAGS)]=
" >> $cross
> +  if test "$rust" !=3D disabled; then
> +    if test "$rust_host_triple" !=3D "$rust_target_triple"; then
> +      echo "rust =3D [$(meson_quote $rustc --target "$rust_target_triple=
")]" >> $cross
> +    else
> +      echo "rust =3D [$(meson_quote $rustc)]" >> $cross
> +    fi
> +  fi
>    echo "ar =3D [$(meson_quote $ar)]" >> $cross
>    echo "dlltool =3D [$(meson_quote $dlltool)]" >> $cross
>    echo "nm =3D [$(meson_quote $nm)]" >> $cross
> @@ -1770,6 +1812,9 @@ if test "$skip_meson" =3D no; then
>      echo "# Automatically generated by configure - do not modify" > $nat=
ive
>      echo "[binaries]" >> $native
>      echo "c =3D [$(meson_quote $host_cc)]" >> $native
> +    if test "$rust" !=3D disabled; then
> +      echo "rust =3D [$(meson_quote $rustc)]" >> $cross
> +    fi
>      mv $native config-meson.native
>      meson_option_add --native-file
>      meson_option_add config-meson.native
> @@ -1788,6 +1833,7 @@ if test "$skip_meson" =3D no; then
>    test "$pie" =3D no && meson_option_add -Db_pie=3Dfalse
>=20=20
>    # QEMU options
> +  test "$rust" !=3D "auto" && meson_option_add "-Drust=3D$rust"
>    test "$cfi" !=3D false && meson_option_add "-Dcfi=3D$cfi" "-Db_lto=3D$=
cfi"
>    test "$docs" !=3D auto && meson_option_add "-Ddocs=3D$docs"
>    test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_eng=
ine=3D$LIB_FUZZING_ENGINE"
> diff --git a/meson.build b/meson.build
> index 67eb4eda649d5f0566de2b75466b5a9d9ca87ab4..065739ccb7300f4f0d4876024=
85802f9f68fb095 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -70,9 +70,6 @@ if host_os =3D=3D 'darwin' and \
>    all_languages +=3D ['objc']
>    objc =3D meson.get_compiler('objc')
>  endif
> -if get_option('rust').enabled() and meson.version().version_compare('<1.=
0.0')
> -  error('Rust support requires Meson version >=3D1.0.0')
> -endif

Ahh this is probably needs merging into the patch 2.

>  have_rust =3D false
>  if not get_option('rust').disabled() and add_languages('rust', required:=
 get_option('rust'), native: false)
>    rustc =3D meson.get_compiler('rust')
> @@ -4307,8 +4304,9 @@ else
>  endif
>  summary_info +=3D {'Rust support':      have_rust}
>  if have_rust
> -  summary_info +=3D {'rustc version':      rustc.version()}
> -  summary_info +=3D {'rustc':      ' '.join(rustc.cmd_array())}
> +  summary_info +=3D {'rustc version':   rustc.version()}
> +  summary_info +=3D {'rustc':           ' '.join(rustc.cmd_array())}
> +  summary_info +=3D {'Rust target':     config_host['RUST_TARGET_TRIPLE'=
]}
>  endif
>  option_cflags =3D (get_option('debug') ? ['-g'] : [])
>  if get_option('optimization') !=3D 'plain'

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

