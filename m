Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB02C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uety0-0006ZF-ML; Thu, 24 Jul 2025 07:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetxx-0006TL-FH
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:18:26 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetxv-0006oT-8U
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:18:25 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-607cf70b00aso1773569a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753355902; x=1753960702; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFWbJCwrh1BN5XnR1bOtJoZoxBtrY/3UT9jQp0EmQrE=;
 b=Gfb/ZH3L+omNYR5NvWgFB+1TsKG4hNQBdX9zVQWAiG/742P904ZC/sS1+DoQMLKmFN
 z57PoHA3jsYavxcyRt0k6hvWuYCZmzrfZyONeXBuTOkWPVhNpelFVnkuhfPBNYW5xSIB
 rmwYBV3oUfd/Cem82vZuMz2K9dMYGuSJ4DvpJRnYkiNdu9r4/aL1vk1+bCv+pYTE3xFA
 nPVrhrAXDtwI+z5LkJn7U5lNt8Huo6gYQ9hBTs5WgEtojI9YdlI3LBDy0+MaD3eLoaOB
 Z4R+zpEhdstn4gKX8JkdXEJdP7wAjczrv8QHjTaTByetF/n/n+RVRcTYRv/sBB88ao21
 7oVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753355902; x=1753960702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tFWbJCwrh1BN5XnR1bOtJoZoxBtrY/3UT9jQp0EmQrE=;
 b=hcCN5D3Z32UMOhea2SLLtIGzePbogB9l7jk6TuGPrRjiopAnHu1sjtn5H3MbOFXiSh
 tSf56yMs2p3HQ9kE5LpJI153RMAiHBBpow+ltvfBjCRqWNxEnzYEC1sXnG61t5lK1zjR
 cWka73P9NFhZ77t7+fJiyMMdhBylnZQRmgOhf1pjhNiIW2ow4l/qXnEbeKCxkbWM9moy
 HOBfujDuNCi0A/LBtFYXL6vz6GAv/TRZM8829f9RAYIN/ofaKvH8X9zna7Q7aG06fl2Q
 UwdDNCDiKa/ggmWmMGCodzQgM/Wrp1wi20U/whmkMRyblqX87vY1GEHj57j6wvQqAj+O
 vI8A==
X-Gm-Message-State: AOJu0YwDhst0HhKOj2E4R+RfMCOIG2ijLQvg/CYBRzhYSVK7CqWB/98K
 bhzC2YY7vfchISdjqTBJ4mfEiqOJfa7POvUvLCIr1WvYYcqVR/O2eaVyKujFU9sbIMukZs8YJmv
 4aImqXJvYASmuXiJymKjFUB4PvVeVqF7L6FJW4GuYSw==
X-Gm-Gg: ASbGnctVMC6P3m16tB9c76sHErI6aRQfe2cgsVRvL7yDzaInOZ3iY5KQEwU54ISR8Bh
 wSqJ5b6CNFf+ZJCo37pzOUXXIlIOBzw65EXk96eJHCviod8lYScNhUhV0jvaPHbxP3ILMtm4/rp
 wzGpIvVtP2KNthb4qC8uFfu1v/LCX17br3llMcd8Bl253uaBhQTu/DI9TLAe17ufUHSCw+HWvp8
 1jXlg==
X-Google-Smtp-Source: AGHT+IE3mPne9nf7UmCoyqTfnuS8UeVKvJdMU2BJY65LpFoXFHgxCnnrPzz4hbhq6HsS+h9chLtjmwCzTXW5C6wzovU=
X-Received: by 2002:a05:6402:3507:b0:611:fdb4:1dc1 with SMTP id
 4fb4d7f45d1cf-6149b417fc6mr6415317a12.7.1753355901513; Thu, 24 Jul 2025
 04:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-10-alex.bennee@linaro.org>
In-Reply-To: <20250724105939.2393230-10-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 14:17:54 +0300
X-Gm-Features: Ac12FXwpabkx7s3fZIdZ_mQgQyv5GRR48Mk6f3Cw4fDem6VaBjzXJG-ia2R-Os8
Message-ID: <CAAjaMXa95yof8TRywdUaZQ2mWDKVGLZOi0Bim1Eaw78y6L=bYA@mail.gmail.com>
Subject: Re: [PATCH for 10.1 09/13] tests/tcg: don't include multiarch tests
 if not supported
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52d.google.com
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

On Thu, Jul 24, 2025 at 2:01=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> We are about to change the way the plugin runs are done and having
> this included by default will complicate things.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/Makefile.target                          | 6 ++++++
>  tests/tcg/multiarch/system/Makefile.softmmu-target | 5 +++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index 97ebe8f9bc9..a12b15637ea 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -127,8 +127,14 @@ else
>  # build options for bare programs are usually pretty different. They
>  # are expected to provide their own build recipes.
>  EXTRA_CFLAGS +=3D -ffreestanding -fno-stack-protector
> +
> +# We skip the multiarch tests if the target hasn't provided a boot.S
> +MULTIARCH_SOFTMMU_TARGETS =3D i386 alpha aarch64 arm loongarch64 s390x x=
86_64
> +
> +ifneq ($(filter $(TARGET_NAME),$(MULTIARCH_SOFTMMU_TARGETS)),)
>  -include $(SRC_PATH)/tests/tcg/minilib/Makefile.target
>  -include $(SRC_PATH)/tests/tcg/multiarch/system/Makefile.softmmu-target
> +endif
>  -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target
>
>  endif
> diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/t=
cg/multiarch/system/Makefile.softmmu-target
> index 07be001102b..5acf2700812 100644
> --- a/tests/tcg/multiarch/system/Makefile.softmmu-target
> +++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
> @@ -6,6 +6,11 @@
>  # architecture to add to the test dependencies and deal with the
>  # complications of building.
>  #
> +# To support the multiarch guests the target arch needs to provide a
> +# boot.S that jumps to main and provides a __sys_outc functions.

s/functions/function

> +# Remember to update MULTIARCH_SOFTMMU_TARGETS in the tcg test
> +# Makefile.target when this is done.
> +#
>
>  MULTIARCH_SRC=3D$(SRC_PATH)/tests/tcg/multiarch
>  MULTIARCH_SYSTEM_SRC=3D$(MULTIARCH_SRC)/system
> --
> 2.47.2
>
>

Otherwise

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

