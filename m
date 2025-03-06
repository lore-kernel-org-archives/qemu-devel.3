Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E7BC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 10:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq8EX-0005Rz-Kg; Thu, 06 Mar 2025 05:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tq8EU-0005RT-2V
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:13:38 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tq8EM-0006ez-UF
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:13:37 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6fcf90d09c6so4316417b3.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 02:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741256009; x=1741860809; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5lJXKZf5zcYw5ohzoA4hRxGVuZ41Pla04bRM8TI0aM4=;
 b=MJYZkVWbD5XB4NKLIA9PtjUjIDXnvZq5bWEGgLXrbH6iinDZ7siA6KxfubCkbW9lkT
 PPH39bHvy7U69bjaHPW6ocdugq1TeuwK4txNU/jSLQGBdyEe1rXW12snocC3WtEzZkbZ
 tjVCzOv15hpxRSc3qnpfYRoN7PGJPSMrvqlK4RRe4SWKXjexZqXMy+hf+NOstS+rBfPV
 nybDjJvuUBUnt2TxeECtlC6P2xlj9GJaE+pDGjMSqnVQJ6GWNblyVuvMeo5get79AHeE
 W38WPZJkLfGputWFXue4ldMSBHdmPlMm3HAm7MLZ3vITLV6sIqv+tBqbjZE2FLKLtl6U
 d+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741256009; x=1741860809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5lJXKZf5zcYw5ohzoA4hRxGVuZ41Pla04bRM8TI0aM4=;
 b=VBLK0KZvNzNZ7xzsO0avbqDOZQhPUNWDqn/j+fa6uemqLFgxm2u8p0y6fom3mhpTd8
 q2oYefUEeXNy2qKScLDzJAxi/HyyZfjiNWDgEhMbUUQGjZOtEP6kX9KXJHEHA2eYNyQn
 I+olHKAwfw/Z5BI0b0N4LPRFpxPEwDiRgPrpvCi13eLM4cJopt2Ila5KV8xZ+iiDHY8g
 V/A72oAGOaVdVq9geiKm8S8qwyxr7ofhPa450BpexGPy+RtwARb162+l12uyy3mGwhQR
 Hdx/GjdpVLmuNikheRRcvPS/MO+sjE2CIz6Bg96pACAB/+lMLJLl8yONHCoUxMnDZYJe
 VnBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkdV0drgY+U8Ahm9Pqlh2m1T/BFpaXxhf6JhNXWaT4QUTGB+dGuBQtAS06ughHFSUqNq3CKrAjQyrq@nongnu.org
X-Gm-Message-State: AOJu0Yya6xlgXq7/I963xB70OvcEr3/sHCKyycpLrAUfVzZXRkFlyMq4
 nyjhkiRa0avtLiPwcMOcoEQeh6GOlCrQXnxkM/OkzpR3+iwa87dqubCrkX4+XVsKY/eQUWYwFI9
 XXX0HT6x1bBHn6tfNFAo/d/hqx6bYEKEg/MzlfQ==
X-Gm-Gg: ASbGncvoTocyEHmVpOYTvaO7gO6yNxC1FE4W8kyeAW1bdHGsubb/2qpu3QyksHs2TIj
 Any/vQttJZifjtf6Eg/+zP+794OfmD+BDDdtXbopg5B622SYzhjoBaxy6QG5BgBD5V+Jg7zHf+Y
 XrIKcr9IjtwuSv3Pvbnpn1v5JR5Gc=
X-Google-Smtp-Source: AGHT+IGAkHtVrhbM0rUIE+VF0q/zYEaQvPttC/adGGYQuG8e/lqVdReWfCOxNKL4LxUj14JV08rUtstqnYBbEZ++ko0=
X-Received: by 2002:a05:690c:64c5:b0:6fa:fd85:a2b6 with SMTP id
 00721157ae682-6feaeeda024mr37834847b3.13.1741256008805; Thu, 06 Mar 2025
 02:13:28 -0800 (PST)
MIME-Version: 1.0
References: <20250305161248.54901-1-philmd@linaro.org>
 <20250305161248.54901-3-philmd@linaro.org>
 <Z8lpB6XdNPT8zyTa@redhat.com>
In-Reply-To: <Z8lpB6XdNPT8zyTa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Mar 2025 10:13:16 +0000
X-Gm-Features: AQ5f1JrjmBIvYLT_jqvL_Q04vutWHCYlIcEFcz_IjkUx64YHVNTExNWlQGns4ZU
Message-ID: <CAFEAcA9FuNJZwQ2NyJdBicoMMF=3Ua+qokrHu+-_uwnF9_tDNQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] hw/arm/raspi: Replace TARGET_AARCH64 by
 legacy_binary_is_64bit()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 6 Mar 2025 at 09:21, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Wed, Mar 05, 2025 at 05:12:46PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > For legacy ARM binaries, legacy_binary_is_64bit() is
> > equivalent of the compile time TARGET_AARCH64 definition.
> >
> > Use it as TypeInfo::registerable() callback to dynamically
> > add Aarch64 specific types in qemu-system-aarch64 binary,
> > removing the need of TARGET_AARCH64 #ifdef'ry.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >  hw/arm/bcm2836.c | 6 ++----
> >  hw/arm/raspi.c   | 7 +++----
> >  2 files changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> > index 95e16806fa1..88a32e5fc20 100644
> > --- a/hw/arm/bcm2836.c
> > +++ b/hw/arm/bcm2836.c
>
>
> > @@ -219,12 +218,11 @@ static const TypeInfo bcm283x_types[] =3D {
> >          .name           =3D TYPE_BCM2836,
> >          .parent         =3D TYPE_BCM283X,
> >          .class_init     =3D bcm2836_class_init,
> > -#ifdef TARGET_AARCH64
> >      }, {
> >          .name           =3D TYPE_BCM2837,
> >          .parent         =3D TYPE_BCM283X,
> > +        .registerable   =3D legacy_binary_is_64bit,
> >          .class_init     =3D bcm2837_class_init,
> > -#endif
> >      }, {
> >          .name           =3D TYPE_BCM283X,
> >          .parent         =3D TYPE_BCM283X_BASE,
>
> So historically we have a subset of machines that are only exposed in
> the qemu-system-aarch64 binary, and not qemu-system-arm.
>
> You're attempting to build a single binary to cover both 32 & 64 bit
> arm, so need to be able to filter what machines are available to
> create when the symlink indicates invokation of the 32-bit binary.

What machines are there that we don't want to provide, though?
We don't provide for instance raspi4b in today's qemu-system-arm,
but that's because it wouldn't work there: qemu-system-arm
doesn't have the 64-bit CPUs. But if we have a single binary
that has both 32 and 64 bit arm in it, then the 64-bit CPUs
will be in that combined binary. Do we actually need to explicitly
forbid the user from saying 'qemu-system-arm -M raspi4b' when
qemu-system-arm is a symlink and the command would work fine
if it wasn't forbidden?

I had assumed that the motivation here was that we'd like to
be able to build this C file only once. Currently we have to
build it once for the aarch64 target and once for the arm target;
to avoid that we would need to determine "does the binary I'm
in have the AArch64 CPU types this type depends on" at runtime,
not at compile time (which is what the ifdef is doing, effectively).

thanks
-- PMM

