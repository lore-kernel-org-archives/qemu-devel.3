Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA61C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 13:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tewuT-0003jg-DB; Mon, 03 Feb 2025 08:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tewuR-0003jI-VA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 08:54:44 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tewuQ-0004X1-2h
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 08:54:43 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aafc9d75f8bso887832366b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 05:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738590879; x=1739195679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldokr/KBk3hFyfq13vhbUrReVg0Ihk5KXbZeoinvgYU=;
 b=GVEaha7LjbSf3R/VHUOyhMqsRW0gy9JKPX52Y0CqIJ34EOA0I3AxHyyC36euy1DGZz
 gNw3HWVV2YJtt59HJmzyFVOxhGHjk5SxrSUFeJfOYNxhfwYSEmkD1FALM0mMQE0O2l+L
 L8KTKr4+jxs48F2PPDJiS81rV8EZII4u7cnG3xqFuTMXwno6ntyndzbiwKtF8Pk9+yQC
 HlshShlB1kAkEJ6CATvZxrmWEkhJszuri7wtuyR4sW6TG/zRBtkBTeXLobjCZzqkm8Wi
 4V/mThg/ws2x8YWwRzjY55u1XuP5Bj1+D/FXs3aQbucPUWLV9PwEHdDIEFPO53k43ISu
 1/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738590879; x=1739195679;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ldokr/KBk3hFyfq13vhbUrReVg0Ihk5KXbZeoinvgYU=;
 b=J3VTcx9tAnOzOlZHWQz9pKNPr3apCr45iVQGIRQmW1cPlhdpiwW+vfT+4rUfN9XI/8
 y8lIBScA9HuCQazB3s1uFm4X+F2mLrqjvoNH8TPgQH3xaG3pq7Dvo1bVfYeNrWEnHn+E
 fnG31GCN0Yq1SaQHqvm2WyZZuAuiuvLuPgwlwUPJkzE/UoEPRKbKcr3coxyfkhgfVkQH
 dS3TxYoTMESYlKJynEeL1NrF+uWe6awcOIWY0eCSJUiSlGuji7iTab971K1wopv6TJSv
 ZBYf/t2A/H/T2CKsBd8EG1HN2QFG34k2UnrSXmv/L60lWmhWjd5iSG7jL/Mx64NQEg1u
 m1Ig==
X-Gm-Message-State: AOJu0Yxv5T+40Uwavf3rD6U9XBiueosIc8y/Kl1NQgT35gpf581LGrWz
 bXwBJ4UaMn0aWUvelf0awwE+qbzw8/bWemE1DBbjceR75YhODUVr+LVG3ojKlcA=
X-Gm-Gg: ASbGncsYtpZr6xZC1Cr8NcKI2bk47i0fog5k5zLaCoU+FkclOTzGS8XjFIKUlYpyii5
 vbWhXC/FjCmeU80iswADDvA0ngFaD/lcKYXoEcYHzZkIuRLgFuMsvxSue6tGC91k/GmmZLStSrt
 HosqdNF0zGDtz6EkNgfEMEQjNq6ctywuPSOK3VSPbYgU+QWfkScywnCEJa1q26HT25S4cdI2fLK
 CSnMbYNtymEO9SNH+K26cscDB1QWw7uiHxrIEHaI3Re7x4qaOkEdfOlW/fxM8KTmvLrgjDEl2ZC
 m6msZN5QVrVFErd+xQ==
X-Google-Smtp-Source: AGHT+IFKYbSqFuV2WLP8XV0rVh4N3yalwsoDnWqgsjRMKqr9uymKaH8vJbAbRlQwLYmVXWj9ZIZrvw==
X-Received: by 2002:a17:907:7fa4:b0:aae:8843:9029 with SMTP id
 a640c23a62f3a-ab6cfdc6008mr2590040266b.48.1738590878754; 
 Mon, 03 Feb 2025 05:54:38 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47d11a2sm765722566b.64.2025.02.03.05.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 05:54:38 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 520935F8BF;
 Mon,  3 Feb 2025 13:54:37 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk,  berrange@redhat.com,  philmd@linaro.org,
 thuth@redhat.com
Subject: Re: [PATCH v2 12/14] meson: Disallow 64-bit on 32-bit TCG emulation
In-Reply-To: <20250203031821.741477-13-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 2 Feb 2025 19:18:19 -0800")
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-13-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 13:54:37 +0000
Message-ID: <87o6zjcew2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> For system mode, we can rarely support the amount of RAM that
> the guest requires. Emulation is restricted to round-robin
> mode, which solves many of the atomicity issues, but not those
> associated with virtio.  In any case, round-robin does nothing
> to help the speed of emulation.
>
> For user mode, most emulation does not succeed at all.  Most
> of the time we cannot even load 64-bit non-PIE binaries due
> to lack of a 64-bit address space.  Threads are run in
> parallel, not round-robin, which means that atomicity
> is not handled.

I think in itself is not enough, on aarch64.ci.org:

  ./../configure --disable-docs --disable-tools --cross-prefix=3Darm-linux-=
gnueabihf-

Should only build 32 bit binaries. Which it does:

  13:52:57 [alex@aarch64:~/l/q/b/arm32.crossbuild] review/deprecate-64-on-3=
2-v2|=E2=80=A6 + ls qemu-*
  qemu-arm         qemu-keymap        qemu-mipsel       qemu-sh4         qe=
mu-system-i386    qemu-system-ppc      qemu-system-sparc     qemu-xtensa
  qemu-armeb       qemu-m68k          qemu-options.def  qemu-sh4eb       qe=
mu-system-m68k    qemu-system-riscv32  qemu-system-tricore   qemu-xtensaeb
  qemu-hexagon     qemu-microblaze    qemu-or1k         qemu-sparc       qe=
mu-system-mips    qemu-system-rx       qemu-system-xtensa
  qemu-i386        qemu-microblazeel  qemu-ppc          qemu-system-arm  qe=
mu-system-mipsel  qemu-system-sh4      qemu-system-xtensaeb
  qemu-img-cmds.h  qemu-mips          qemu-riscv32      qemu-system-avr  qe=
mu-system-or1k    qemu-system-sh4eb    qemu-version.h

However make check-tcg fails because:

  13:53:09 [alex@aarch64:~/l/q/b/arm32.crossbuild] review/deprecate-64-on-3=
2-v2|=E2=80=A6 + cat config-host.mak=20
  # Automatically generated by configure - do not modify

  all:
  SRC_PATH=3D/home/alex/lsrc/qemu.git
  TARGET_DIRS=3Daarch64-linux-user aarch64_be-linux-user alpha-linux-user a=
rm-linux-user armeb-linux-user hexagon-linux-user hppa-linux-user i386-linu=
x-user loongarch64-linux-user m68k-linux-user microblaze-linux-user microbl=
azeel-linux-user mips-linux-user mips64-linux-user mips64el-linux-user mips=
el-linux-user mipsn32-linux-user mipsn32el-linux-user or1k-linux-user ppc-l=
inux-user ppc64-linux-user ppc64le-linux-user riscv32-linux-user riscv64-li=
nux-user s390x-linux-user sh4-linux-user sh4eb-linux-user sparc-linux-user =
sparc32plus-linux-user sparc64-linux-user x86_64-linux-user xtensa-linux-us=
er xtensaeb-linux-user aarch64-softmmu alpha-softmmu arm-softmmu avr-softmm=
u hppa-softmmu i386-softmmu loongarch64-softmmu m68k-softmmu microblaze-sof=
tmmu microblazeel-softmmu mips-softmmu mips64-softmmu mips64el-softmmu mips=
el-softmmu or1k-softmmu ppc-softmmu ppc64-softmmu riscv32-softmmu riscv64-s=
oftmmu rx-softmmu s390x-softmmu sh4-softmmu sh4eb-softmmu sparc-softmmu spa=
rc64-softmmu tricore-softmmu x86_64-softmmu xtensa-softmmu xtensaeb-softmmu
  GDB=3D/usr/bin/gdb-multiarch
  RUNC=3Ddocker
  SUBDIRS=3D pc-bios/optionrom pc-bios/s390-ccw
  PYTHON=3D/home/alex/lsrc/qemu.git/builds/arm32.crossbuild/pyvenv/bin/pyth=
on3 -B
  MKVENV_ENSUREGROUP=3D/home/alex/lsrc/qemu.git/builds/arm32.crossbuild/pyv=
env/bin/python3 -B /home/alex/lsrc/qemu.git/python/scripts/mkvenv.py ensure=
group  --online
  GENISOIMAGE=3D/usr/bin/genisoimage
  MESON=3D/home/alex/lsrc/qemu.git/builds/arm32.crossbuild/pyvenv/bin/meson
  NINJA=3D/usr/bin/ninja
  EXESUF=3D
  CONFIG_DEFAULT_TARGETS=3Dy
  TCG_TESTS_TARGETS=3D aarch64-linux-user arm-linux-user i386-linux-user mi=
ps64el-linux-user mipsel-linux-user riscv64-linux-user s390x-linux-user aar=
ch64-softmmu arm-softmmu i386-softmmu riscv64-softmmu s390x-softmmu

So possible TCG_TESTS_TARGET needs to be merged with the meson code?
Also do we still use TARGET_DIRS?

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  meson.build | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 5ca3cc3f34..866b8ce477 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3176,6 +3176,9 @@ if host_os =3D=3D 'windows'
>    endif
>  endif
>=20=20
> +# Detect host pointer size for the target configuration loop.
> +host_long_bits =3D cc.sizeof('void *') * 8
> +
>  ########################
>  # Target configuration #
>  ########################
> @@ -3268,11 +3271,18 @@ foreach target : target_dirs
>      }
>    endif
>=20=20
> +  config_target +=3D keyval.load('configs/targets' / target + '.mak')
> +
>    target_kconfig =3D []
>    foreach sym: accelerators
>      if sym =3D=3D 'CONFIG_TCG'
> +      # Disallow 64-bit on 32-bit TCG emulation.
> +      if host_long_bits < config_target['TARGET_LONG_BITS'].to_int()
> +        continue
> +      endif
>        config_target +=3D { 'CONFIG_TCG_TARGET': 'y' }
>      elif target not in accelerator_targets.get(sym, [])
> +      # Other accelerators are handled by accelerator_targets.
>        continue
>      endif
>      config_target +=3D { sym: 'y' }
> @@ -3286,9 +3296,6 @@ foreach target : target_dirs
>      error('No accelerator available for target @0@'.format(target))
>    endif
>=20=20
> -  config_target +=3D keyval.load('configs/targets' / target + '.mak')
> -  config_target +=3D { 'TARGET_' + config_target['TARGET_ARCH'].to_upper=
(): 'y' }
> -
>    if 'TARGET_NEED_FDT' in config_target and not fdt.found()
>      if default_targets
>        warning('Disabling ' + target + ' due to missing libfdt')
> @@ -3301,6 +3308,7 @@ foreach target : target_dirs
>    actual_target_dirs +=3D target
>=20=20
>    # Add default keys
> +  config_target +=3D { 'TARGET_' + config_target['TARGET_ARCH'].to_upper=
(): 'y' }
>    if 'TARGET_BASE_ARCH' not in config_target
>      config_target +=3D {'TARGET_BASE_ARCH': config_target['TARGET_ARCH']}
>    endif

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

