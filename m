Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A53D0E6D6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 09:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2osH-0006hb-SD; Mon, 21 Oct 2024 05:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2osG-0006gt-0U
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 05:38:52 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t2osE-0003e1-7G
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 05:38:51 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539fb49c64aso5791793e87.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 02:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729503528; x=1730108328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0r4lvSKFiaGSGx3xkyX4K/X94ogUMhlhlo23gFryysM=;
 b=uKxFpgC8cUF8/tps6DpLjRMqp6VteV72y7ymNfM4L534HBU8xdGgd+X7NGNaDPA74X
 qeMFtbAJC09DfX1+IuNR4QqRdSGM0tWLRhQMGRIgHA4D5cP+RYzq21xkQEwlcZ0+TVI+
 ZlYH0H1vrj26V83oF7wbWqZ9VdXea502Tpnoz/lbgZjBpaM+g5mmNZUUq8+OGBZvem0m
 FY+whzKHsf/wC9aiFEZoES51JyAYjy1heksN6NcBOEHXU4bb/JngfhioKu9E7PxxPvgl
 9ESens+kO1dTkZQetE1NkiSKT1w5gAKg1auNDPcuYeIwKsDVVuaPLqUxxWtC7mHb0qO0
 VoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729503528; x=1730108328;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0r4lvSKFiaGSGx3xkyX4K/X94ogUMhlhlo23gFryysM=;
 b=PUoUcOkKiW1kfdaAR31lBe1wtnVYIgMl3sOpv99R2vZm3SoJfwc1U/RTUI9EXCt5di
 7WzbKwnMintPkw2lZhFywe01neu2N5KZJ4BUvpNmiWyR0rrp3mPZhcNfLFtaggR3XmBV
 0c5SCtryFwBdh0uy+Ju/RQC/ztPR1Jr8CEmwle0X57r1k13AbsYWk3GFzZpPHhnODyii
 yawKea7gSuKUiWnzEhH6mPO3EXbq1DAxhbg5soYx6H/aeKCys1pUrSnz6zOceVPla75M
 hDnCmakAiujo2H9LDg1K+rh2tugmT1wevJHiHDHXzF+Xt1XaClkrwajhBUWCoDZVdfxT
 g80Q==
X-Gm-Message-State: AOJu0YzW1nxcUJSIZAv3kKJ3238I+5AKz+fPKJbZIKTcICDeGjY9GJ0h
 1TJdHS7WncWUjiGUifnsm6OcmoKo2mmYbMADIAmddNquSvU+Ynhnk1i8tO4j430=
X-Google-Smtp-Source: AGHT+IGQGb83YNkzUvCkIPEntpIlxNrjCrLbKab43q5YNzNDSZyBu7ndXGn6wYDVqai89Lg4SRf0cA==
X-Received: by 2002:a05:6512:2388:b0:539:9767:903d with SMTP id
 2adb3069b0e04-53a154eb91emr6304943e87.60.1729503527991; 
 Mon, 21 Oct 2024 02:38:47 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a915717b8sm185671166b.145.2024.10.21.02.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 02:38:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8FF855F8B9;
 Mon, 21 Oct 2024 10:38:46 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alexandre Iooss
 <erdnaxe@crans.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>
Subject: Re: [PATCH v2 1/2] meson: build contrib/plugins with meson
In-Reply-To: <20240925204845.390689-2-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Wed, 25 Sep 2024 13:48:44 -0700")
References: <20240925204845.390689-1-pierrick.bouvier@linaro.org>
 <20240925204845.390689-2-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 21 Oct 2024 10:38:46 +0100
Message-ID: <87y12hokwp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Tried to unify this meson.build with tests/tcg/plugins/meson.build but
> the resulting modules are not output in the right directory.
>
> Originally proposed by Anton Kochkov, thank you!
>
> Solves: https://gitlab.com/qemu-project/qemu/-/issues/1710
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  meson.build                 |  4 ++++
>  contrib/plugins/meson.build | 23 +++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 contrib/plugins/meson.build
>
> diff --git a/meson.build b/meson.build
> index ceee6b22c8d..b18c2a54ab5 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3655,6 +3655,10 @@ subdir('accel')
>  subdir('plugins')
>  subdir('ebpf')
>=20=20
> +if 'CONFIG_TCG' in config_all_accel
> +  subdir('contrib/plugins')
> +endif
> +
>  common_user_inc =3D []
>=20=20
>  subdir('common-user')
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> new file mode 100644
> index 00000000000..a0e026d25e2
> --- /dev/null
> +++ b/contrib/plugins/meson.build
> @@ -0,0 +1,23 @@
> +t =3D []
> +if get_option('plugins')
> +  foreach i : ['cache', 'drcov', 'execlog', 'hotblocks', 'hotpages', 'ho=
wvec',
> +               'hwprofile', 'ips', 'lockstep', 'stoptrigger']
> +    if host_os =3D=3D 'windows'
> +      t +=3D shared_module(i, files(i + '.c') + 'win32_linker.c',
> +                        include_directories: '../../include/qemu',
> +                        link_depends: [win32_qemu_plugin_api_lib],
> +                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
> +                        dependencies: glib)
> +
> +    else
> +      t +=3D shared_module(i, files(i + '.c'),
> +                        include_directories: '../../include/qemu',
> +                        dependencies: glib)

I was trying to work out where the include dirs come from to make sure
Brad's fix (see Zu4063fjfHC5hHUl@humpty.home.comstyle.com) also applies.
It does but:

  =E2=9E=9C  make contrib/plugins/libexeclog.so V=3D1
  /usr/bin/ninja -v   -j1 -d keepdepfile contrib/plugins/libexeclog.so | cat
  [1/2] cc -m64 -Icontrib/plugins/libexeclog.so.p -Icontrib/plugins -I../..=
/contrib/plugins -I../../include/qemu -I/usr/include/glib-2.0 -I/usr/lib/x8=
6_64-linux-gnu/glib-2.0/include -fdiagnostics-color=3Dauto -Wall -Winvalid-=
pch -Werror -std=3Dgnu11 -O2 -g -fstack-protector-strong -Wempty-body -Wend=
if-labels -Wexpansion-to-defined -Wformat-security -Wformat-y2k -Wignored-q=
ualifiers -Wimplicit-fallthrough=3D2 -Winit-self -Wmissing-format-attribute=
 -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-style-=
definition -Wredundant-decls -Wshadow=3Dlocal -Wstrict-prototypes -Wtype-li=
mits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi -Wn=
o-shift-negative-value -isystem /home/alex/lsrc/qemu.git/linux-headers -isy=
stem linux-headers -iquote . -iquote /home/alex/lsrc/qemu.git -iquote /home=
/alex/lsrc/qemu.git/include -iquote /home/alex/lsrc/qemu.git/host/include/x=
86_64 -iquote /home/alex/lsrc/qemu.git/host/include/generic -iquote /home/a=
lex/lsrc/qemu.git/tcg/i386 -pthread -mcx16 -mpopcnt -mneeded -mmovbe -mabm =
-mbmi -mbmi2 -mfma -mf16c -mavx2 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_=
LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-va=
r-init=3Dzero -fzero-call-used-regs=3Dused-gpr -fPIC -MD -MQ contrib/plugin=
s/libexeclog.so.p/execlog.c.o -MF contrib/plugins/libexeclog.so.p/execlog.c=
.o.d -o contrib/plugins/libexeclog.so.p/execlog.c.o -c ../../contrib/plugin=
s/execlog.c
  [2/2] cc -m64  -o contrib/plugins/libexeclog.so contrib/plugins/libexeclo=
g.so.p/execlog.c.o -Wl,--as-needed -Wl,--allow-shlib-undefined -shared -fPI=
C -fstack-protector-strong -Wl,-z,relro -Wl,-z,now -Wl,--start-group /usr/l=
ib/x86_64-linux-gnu/libglib-2.0.so /usr/lib/x86_64-linux-gnu/libgmodule-2.0=
.so -Wl,--end-group -pthread

I'm not sure why we see "-Icontrib/plugins -I../../contrib/plugins".
It's probably a harmless redundancy but I'm curious as to where the path
comes from, any idea?

> +    endif
> +  endforeach
> +endif
> +if t.length() > 0
> +  alias_target('contrib-plugins', t)
> +else
> +  run_target('contrib-plugins', command: find_program('true'))
> +endif

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

