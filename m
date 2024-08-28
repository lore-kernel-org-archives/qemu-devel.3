Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4D9C54FB3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIWM-0000lv-1Q; Wed, 28 Aug 2024 09:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjIWK-0000lQ-Sl
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:15:32 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjIWI-0007tV-JH
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:15:32 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-371b098e699so5478805f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724850928; x=1725455728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ybhwW6eOaI5X2FwIEswneSTSHouB8fAO/LAoGz2vjww=;
 b=ESNEOi9FyVj+5zXph4dyWp+dGuesDzNBZVgEatbakkQg8VCAIMN+CyZd7OTuOH+nBl
 23DmoqhReDUuX2wV1Nz8ByMd8EGm2Ssa7dQc6OnUMICTioqek14KtHnvhqygSOx5APL3
 8Z+WQZKGt3/F0vqpYMtACE9RtJ5A9vGkUJZjUwRpZxSVGiMbbJZNMlr+xedA9Eb3VmO4
 tn0m+GBTMFzpRMhaZFYqhu5uXXZT/Jukc4lWGjEz9hlISl8mV44kBmVr8X6kABC84TB9
 YPtOmxGy2eNb9YX5GaiewWlYlaId0dMqxb9bpfD+j0RN9B/w07mse9FNSt3fc6M67qa6
 QVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724850928; x=1725455728;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ybhwW6eOaI5X2FwIEswneSTSHouB8fAO/LAoGz2vjww=;
 b=jIjpOqWcYdm3D99VQXPvH2eK5Nf1k+TOtRiYQ2VBEhJy/Va4FjMoSmlSa1x3OiLCBC
 YBzfEVDF4DvmRrk5kDSE6fSDlyogIhrow290t8QfppoYxSwi7iUqKGhhlJFRXIYWIfy4
 4z4cCs6VkbooYQ/voGLo/LJX1gMZshZgSp/OJoG49MwxbjdX1LA3mYIGD9G4EVCnlbpn
 2vrIVGFRKyIb8cfzyW9Z/ebIdZ/U+LNx5ePm9jHuqq6TflQ6TKtm9CatQR2/y58xZVTH
 AVDZ7fVSlOquX/J2qPcSFmWhD/eqKUtYLiA/uf12epV2yjbFDgINxdDGFVeL2cWgWQFy
 LSTQ==
X-Gm-Message-State: AOJu0YyKIdh8OisoRYHGzBzYCKXRxFbFTfLgcphUhfMx84sCVk6L4UcA
 qcQmrPE70/ezoZN9Jwp2/PIk4kytM9/GpU7/iav7VI13oqgHM/F9dxwDuJ9aFD0=
X-Google-Smtp-Source: AGHT+IH9ILJJUgaC0iq1oz6/d0i3LvkP4UKtZvywvT1cJvN454T3hFV6m415R0b3f166y2Yu4C5UDg==
X-Received: by 2002:a5d:67c3:0:b0:368:65c7:5ffc with SMTP id
 ffacd0b85a97d-373118e3f57mr12664043f8f.60.1724850927159; 
 Wed, 28 Aug 2024 06:15:27 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730826b10bsm15393088f8f.114.2024.08.28.06.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:15:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D6C1F5F796;
 Wed, 28 Aug 2024 14:15:25 +0100 (BST)
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
Subject: Re: [PATCH RESEND v9 6/9] meson.build: add
 HAVE_GLIB_WITH_ALIGNED_ALLOC flag
In-Reply-To: <20240828-rust-pl011-v9-6-35579191f17c@linaro.org> (Manos
 Pitsidianakis's message of "Wed, 28 Aug 2024 07:11:47 +0300")
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-6-35579191f17c@linaro.org>
Date: Wed, 28 Aug 2024 14:15:25 +0100
Message-ID: <87wmk03i1e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

> Rust crates, introduced from the next commit onwards, use the glib
> allocator API and need to know whether g_aligned_alloc etc are
> available.
>
> This commit adds a define in config_host_data that depends on glib
> version >=3D 2.72.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  meson.build | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 05446acbc684a7521ecc9b3f80b98e2cec1a60cf..7f05466d128776ad8dbf40317=
9734e6831b023c0 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -979,6 +979,9 @@ glib =3D declare_dependency(dependencies: [glib_pc, g=
module],
>  # TODO: remove this check and the corresponding workaround (qtree) when
>  # the minimum supported glib is >=3D 2.75.3
>  glib_has_gslice =3D glib.version().version_compare('<2.75.3')
> +# Check whether glib has the aligned_alloc family of functions.
> +# <https://docs.gtk.org/glib/func.aligned_alloc.html>
> +glib_has_aligned_alloc =3D glib.version().version_compare('>=3D2.72.0')

Minor suggestion: you could update the comment for the main glib probe:

  # When bumping glib minimum version, please check also whether to increase
  # the _WIN32_WINNT setting in osdep.h according to the value from
  # glib. You should also check if any of the glib.version() checks
  # bellow can also be removed.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>=20=20
>  # override glib dep to include the above refinements
>  meson.override_dependency('glib-2.0', glib)
> @@ -2508,6 +2511,7 @@ config_host_data.set('CONFIG_TIMERFD', cc.has_funct=
ion('timerfd_create'))
>  config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_=
range'))
>  config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
>  config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
> +config_host_data.set('HAVE_GLIB_WITH_ALIGNED_ALLOC', glib_has_aligned_al=
loc)
>  config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependen=
cies: util))
>  config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul'))
>  config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', p=
refix: '#include <stdlib.h>'))

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

