Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6F5C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyWJ-0002S2-EQ; Wed, 02 Jul 2025 10:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uWyW5-0002QM-0n; Wed, 02 Jul 2025 10:32:54 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uWyW2-0002jD-2O; Wed, 02 Jul 2025 10:32:52 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-608acb0a27fso7249252a12.0; 
 Wed, 02 Jul 2025 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751466765; x=1752071565; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsBKy9jl+N02u6EXjdGsJxToxb/LGdsXv5iKgtPBjjY=;
 b=WeGDS3VOVeq6QN04WoLhzhbn1JIomGocYUK5mNQU5eLfGAqMDCjiZzd1LsDQWY0mqr
 Pz858TXfCkZTw4ADx17s1v9gvs5JEgV1HO5Yp654ndxrUFuio89mNYCNRBqLqAu0ND8u
 C1SqaGfiq6GhqoZKhUEVrJ7vCde9tVuP4KZZoysa8Qb1bOTrIyYnf6FrE0Dizs5KxAcz
 U1S5Yw4Yw3kJnC+Klx9JsHDxfLnnlF/Fz0pjr8aeeSE6TmdzKrPtsxpeXE+sNrK6y/Jp
 s8VjPeiE0nVQUQrcFhudV2IIMAwDHcM+jLNXYSiin+9mNmyRptUJPDC32uZjjUqvgqsP
 a5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751466765; x=1752071565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BsBKy9jl+N02u6EXjdGsJxToxb/LGdsXv5iKgtPBjjY=;
 b=Wl/5TNmAMJw8TG+UMKj7OMwFHXTc7MnGQjwr4cgyMhDYUe9pDWC0u3dFAZIvlNLij2
 8d55uJmxIoq3Wl7vEGOfev/MtZ7WNNYUR0AtCLpT4DTPdHRGBUQF9fyzAV88LUfVQCyC
 hSQ+MQwRR+feqgLaNwWDvsA2Sc21fIVIoS07k4855WsKv7iAWbtO1CFTYjysC22+7086
 PP3iPPwrGqaz2bQ3nGLMhVAYdKIlP9PXh1sEmDpjN6mu2OfC98REN9eUdNN3wD2S6et4
 OUWaCBUgIFJOyYe6iNQnzkFRg+um60EDWVm8KfKr3LqZSbpkgSMRfBpsY+JwJ4+0j7Aw
 GtVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtiSh6W9pygipMYPAgiBUK56mZaKS4Qx6fda510uhUOfp5q5zDmoNlXXQXBEIe1fPrYFez4Iz9WQ==@nongnu.org
X-Gm-Message-State: AOJu0YwDgu5NS/vWuxn/18eeMdgWPfeRySY0eqO9ltrbSXZQtdJ8XHaN
 jNs7sVfhghJ7AaBvD3FR4J/j5zFbIm4/E3SKwJmXynFy6tY2n1ud8g3KBM2m7MiYpRL9dFowBg+
 Fk61sTwnAN5h6ZEd62u1u122dCMFqEEo=
X-Gm-Gg: ASbGncsomLinbOqNctBxYkyzR4KnF4iZxcsbOiLHknXmL6Mx1VMwbPB8BHpYfEAnHMF
 cDPphqGBqiW8qAWcDJmU9KsG2m8iGODBPx7kS4y6Zy+1KLaoyBD3NNcTkC1Sx/dLzant3rLddAE
 k8vTuf0YbSzBSfxnffq25FOVb3g6dGXagzL1GX4tzNnQ==
X-Google-Smtp-Source: AGHT+IGfhAXHSl+FswI/GtvrLp1pLt2igRsI8lIuaiuPvgJeplTXn373AfYd9cgpZDGB+UEL/yrUxnY8/b/BaVPh6CE=
X-Received: by 2002:a17:906:491:b0:adb:2a21:28b3 with SMTP id
 a640c23a62f3a-ae3c2c7d137mr271824866b.54.1751466764413; Wed, 02 Jul 2025
 07:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250701105809.366180-1-thuth@redhat.com>
In-Reply-To: <20250701105809.366180-1-thuth@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 2 Jul 2025 10:32:31 -0400
X-Gm-Features: Ac12FXwnYvWz-wZ4o5IVqEQBlIcY2dh1eSARpNr6DCEDjMM9sBh1YDa8TgnRqh0
Message-ID: <CAJSP0QWjoW3ZFC6dAXS-hsTBsdUVNOrMi5mwy_N6aEQtebaBHQ@mail.gmail.com>
Subject: Re: [PATCH] tests/functional/test_aarch64_sbsaref_freebsd: Fix the
 URL of the ISO image
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, Warner Losh <imp@bsdimp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Jul 1, 2025 at 6:58=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote=
:
>
> From: Thomas Huth <thuth@redhat.com>
>
> The original image has been removed from the server, so the test
> currently fails if it has to fetch the asset, but we can still
> download the ISO from the archive server. While we're at it, prefer
> the XZ compressed image, it's much smaller and thus the download
> should be faster.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/test_aarch64_sbsaref_freebsd.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/fun=
ctional/test_aarch64_sbsaref_freebsd.py
> index 26dfc5878bb..92ebc69c9b1 100755
> --- a/tests/functional/test_aarch64_sbsaref_freebsd.py
> +++ b/tests/functional/test_aarch64_sbsaref_freebsd.py
> @@ -18,9 +18,9 @@
>  class Aarch64SbsarefFreeBSD(QemuSystemTest):
>
>      ASSET_FREEBSD_ISO =3D Asset(
> -        ('https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES=
/'
> -         '14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso'),
> -        '44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad46=
1')
> +        ('http://ftp-archive.freebsd.org/pub/FreeBSD-Archive/old-release=
s/arm64'
> +         '/aarch64/ISO-IMAGES/14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bo=
otonly.iso.xz'),
> +        '7313a4495ffd71ab77b49b1e83f571521c32756e1d75bf48bd890e0ab0f7582=
7')
>
>      # This tests the whole boot chain from EFI to Userspace
>      # We only boot a whole OS for the current top level CPU and GIC
> @@ -28,7 +28,7 @@ class Aarch64SbsarefFreeBSD(QemuSystemTest):
>      def boot_freebsd14(self, cpu=3DNone):
>          fetch_firmware(self)
>
> -        img_path =3D self.ASSET_FREEBSD_ISO.fetch()
> +        img_path =3D self.uncompress(self.ASSET_FREEBSD_ISO)
>
>          self.vm.set_console()
>          self.vm.add_args(
> --
> 2.50.0
>

