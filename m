Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F45CF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swkqo-0008Oq-NZ; Fri, 04 Oct 2024 12:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1swkql-0008HW-SH
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:08:17 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1swkqj-0002fK-Si
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:08:15 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c896b9b3e1so3030027a12.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728058092; x=1728662892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cR1qvvo6MrxCLlE89I0o6HYWlahccs6+2zH2oOzn4ho=;
 b=JCPyU0lbuVNqOjQ6+G/cPzH0TS9Onw7I+QaEqRQqSIHmVu9bte+e5PHQz2ZCogQ/Am
 VJ2ZJhh/eN4GEmVJkr65cSDatZIdWKKEt25RL3qM05Yfcy8zgaGvN/SwySsiQy9dljGY
 hwvhjPH8r5uKI7Slold24yH78ADVpgHBndV2d/SKP8ps28+ySwtwCLt+lV+TwXOaKvPM
 iGEgr5HZRiNcJnxqkGupRIqNMLaxJ0SerZSr4mj+a/NcynmXdNLp36m/dZZVMx63CFiv
 F+kaUL00DU7IpCu8IGsUGqsmbzvk0LPT+14nLMDq/fDpQf2fM1RE531NfuWKBKe8WVBa
 4taA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728058092; x=1728662892;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cR1qvvo6MrxCLlE89I0o6HYWlahccs6+2zH2oOzn4ho=;
 b=rDumH5krEZhJT2NaOZD63KZgETAgrqEGBNvNR5IVAMf2NDiL5p0HQ4ZKwDU0b+fG+k
 xgSImVW9AqNgAxrR8CNNipIlu0ZTyvwDO8p7x5IAEEpcb931k2DbeWYlgM55bXRpgf2V
 awrSpOo+DOOMXtHGFbBy9NVr8DPrsw4Fxv09xZHqUu99p8nLK3hA+ju6Ueussy6ZJAAk
 OZZlpx+I9tOzNaCxdboHdEAfx0lxvUJCYEFDynMHF6bvkHabtqCokwdebpe5BAcKmNZP
 ilXrbMNN/BKCsEnIrfTQd8uSquH8lhcQj/5kftpTKcss+fWuu7pI6R2XzaaLy28nZ26j
 nGSA==
X-Gm-Message-State: AOJu0YyH7/U16g4zY8b5ceYhXXbnxt3dgeG0WxNDwN5arXc69ScJtLfl
 3iV9v6Mk6MTOiNhztJvs+sgrii7vpVb/HeRv7G4lApos6ZODqFM+X3iRzzWYbdA=
X-Google-Smtp-Source: AGHT+IGgbOUdCYeUy3N0Xe5aK1lkZGwgv1/vkG1L0OcHEwtfvT/5BqZhwaJYAPN/137wLaZXaE3mog==
X-Received: by 2002:a05:6402:538a:b0:5c5:b9c2:c5bb with SMTP id
 4fb4d7f45d1cf-5c8d2e9f05dmr2236415a12.35.1728058091844; 
 Fri, 04 Oct 2024 09:08:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8e05bd224sm21586a12.44.2024.10.04.09.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:08:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5524B5F876;
 Fri,  4 Oct 2024 17:08:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  Artyom Kunakovsky <artyomkunakovsky@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PULL 01/24] configure: move -mcx16 flag out of CPU_CFLAGS
In-Reply-To: <20240525113332.1404158-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Sat, 25 May 2024 13:33:09 +0200")
References: <20240525113332.1404158-1-pbonzini@redhat.com>
 <20240525113332.1404158-2-pbonzini@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Fri, 04 Oct 2024 17:08:09 +0100
Message-ID: <87cykflul2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> From: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
>
> The point of CPU_CFLAGS is really just to select the appropriate multilib,
> for example for library linking tests, and -mcx16 is not needed for
> that purpose.
>
> Furthermore, if -mcx16 is part of QEMU's choice of a basic x86_64
> instruction set, it should be applied to cross-compiled x86_64 code too;
> it is plausible that tests/tcg would want to cover cmpxchg16b as well,
> for example.  In the end this makes just as much sense as a per sub-build
> tweak, so move the flag to meson.build and cross_cc_cflags_x86_64.
>
> This leaves out contrib/plugins, which would fail when attempting to use
> __sync_val_compare_and_swap_16 (note it does not do yet); while minor,
> this *is* a disadvantage of this change.  But building contrib/plugins
> with a Makefile instead of meson.build is something self-inflicted just
> for the sake of showing that it can be done, and if this kind of papercut
> started becoming a problem we could make the directory part of the meson
> build.  Until then, we can live with the limitation.
>
> Signed-off-by: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
> Message-ID: <20240523051118.29367-1-artyomkunakovsky@gmail.com>
> [rewrite commit message, remove from configure. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure   | 7 ++-----
>  meson.build | 7 +++++++
>  2 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/configure b/configure
> index 38ee2577013..4d01a42ba65 100755
> --- a/configure
> +++ b/configure
> @@ -512,10 +512,7 @@ case "$cpu" in
>      cpu=3D"x86_64"
>      host_arch=3Dx86_64
>      linux_arch=3Dx86
> -    # ??? Only extremely old AMD cpus do not have cmpxchg16b.
> -    # If we truly care, we should simply detect this case at
> -    # runtime and generate the fallback to serial emulation.
> -    CPU_CFLAGS=3D"-m64 -mcx16"
> +    CPU_CFLAGS=3D"-m64"
>      ;;
>  esac
>=20=20
> @@ -1203,7 +1200,7 @@ fi
>  : ${cross_cc_cflags_sparc64=3D"-m64 -mcpu=3Dultrasparc"}
>  : ${cross_cc_sparc=3D"$cross_cc_sparc64"}
>  : ${cross_cc_cflags_sparc=3D"-m32 -mcpu=3Dsupersparc"}
> -: ${cross_cc_cflags_x86_64=3D"-m64"}
> +: ${cross_cc_cflags_x86_64=3D"-m64 -mcx16"}
>=20=20
>  compute_target_variable() {
>    eval "$2=3D"
> diff --git a/meson.build b/meson.build
> index a9de71d4506..7fd82b5f48c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -336,6 +336,13 @@ if host_arch =3D=3D 'i386' and not cc.links('''
>    qemu_common_flags =3D ['-march=3Di486'] + qemu_common_flags
>  endif
>=20=20
> +# ??? Only extremely old AMD cpus do not have cmpxchg16b.
> +# If we truly care, we should simply detect this case at
> +# runtime and generate the fallback to serial emulation.
> +if host_arch =3D=3D 'x86_64'
> +  qemu_common_flags =3D ['-mcx16'] + qemu_common_flags
> +endif
> +
>  if get_option('prefer_static')
>    qemu_ldflags +=3D get_option('b_pie') ? '-static-pie' : '-static'
>  endif

This breaks atomic detection resulting in:

#undef CONFIG_ATOMIC128
#undef CONFIG_ATOMIC128_OPT
#undef CONFIG_CMPXCHG128

which makes the TCG atomic handling code fallback to cpu_step_atomic,
killing performance.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

