Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E906C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9dLZ-00047E-Ro; Tue, 29 Apr 2025 01:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9dLG-00045R-UH
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:17:18 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9dLE-0008Mm-M5
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 01:17:14 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4769b16d4fbso34969391cf.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 22:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745903831; x=1746508631; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0g0UXrnh1XltyXsK4IOvDIMeIu2up9kBjAufb7tnEp8=;
 b=OZ5QDIUGZX/33pymuLeZjgp0Tr5iiR1Z4cYVxR+h4IrXvdFOOjWMHjgjv3UV8wimmo
 WVMDQ59nEGS0wBiUe7e/PNsk0snMC1AtHA2ejObsDAk98g/J/0wcvBr/Q0H3Lb9R7XBW
 FC4vppK0X/+2EuLrKXSlWFw/NP9ec0cPF19tQlErYqFIznNOHECezeQBgkHyGzo7PbIo
 vvcYcXK9YhlhnRlEtVs7BDM0CFlqAHkgJVfzp+QY7E1omxbLwW9N0hR4LE1XWLg6xiMA
 U2DwGCXFrxlOPlkM4Bsjavh/7UGgcfogZMUAnkQfB2L32lJgxWkg+1LIjn6eXvoYpjgq
 hWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745903831; x=1746508631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0g0UXrnh1XltyXsK4IOvDIMeIu2up9kBjAufb7tnEp8=;
 b=FUZPngRpxOA01VZ0hf3hMSehPIYviE9Xc/Z03NsYT0td5AedSSYOPQBPCNkhiKfM9S
 V4iZUXecYZj4mg6oX3zhi8lJEDScKyWwy9e3EWqztvWU2F2l7oYnWY/NqCQXTBmPFrLa
 m23BX0z2afAQ22sAAREMbW1h3/cCA5u8SRpvK328KRYllmgQUmZhJCi+JoSV1u3bD2+h
 pI+VVnjrEfiYc5+4FVtUzjzhizu8W5mwyKSz+CbLewR03oJHUNuGhtdKaKCjKgNAuGDI
 1aswUWZ5mtVZLARAcdMIj1BMpOsqgLAL1gH6yFnXMwNKdrQ/VaIXIATK694T5HlsFw/1
 R7Yw==
X-Gm-Message-State: AOJu0YxZz1L0xSEEm7hecffczs6QHTPPG9bz7mkhUpK63yCx3xbdurTi
 6j0kZ9dvm850hbzfvHit+ta79nBEe0+VzDmE1zH+m8ttfLnNEr7Y+9r0aNFv5QeWY5dmCPV/Gx2
 Hx0EYsW1PR6WVTyVbKMjqoG09JwV1EcZ2UZ8=
X-Gm-Gg: ASbGncswYQ4BBDBPVZ2jvQ5u0lSj5z+p68vTcMT3rCEYWbW5iBzJzh8O7006QIb05ny
 FCFybfC7SUa9KX+6pJ69qHGl0cY43FtD9AjVNQGHweuqT0gpclf1tkcRchMuJi2nxlw0PI7bC/C
 vJSRPLmfjuKeRDwNDt/SIjrsd0314gQpzRdzhMn35PHvo20f4q30kqWgE=
X-Google-Smtp-Source: AGHT+IEuUnWrTqyyqLdeOxsD6RsIxYZfJpiiFRIhvNyeCg96zlIEOn5XRVQDC3NmhhSVVIqWo7ZmTwC1tfptIPHzeGQ=
X-Received: by 2002:a05:622a:4a0d:b0:476:8cef:4f0e with SMTP id
 d75a77b69052e-4881393f10cmr40464641cf.29.1745903831299; Mon, 28 Apr 2025
 22:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250428080336.2574852-1-dietmar@proxmox.com>
 <20250428080336.2574852-9-dietmar@proxmox.com>
 <CAJ+F1CJ7=qGN6FiWjK2kQUv8gf_QaFrHDDJCEMOgAkQ_OkuE5A@mail.gmail.com>
 <1225009485.7178.1745842083490@webmail.proxmox.com>
In-Reply-To: <1225009485.7178.1745842083490@webmail.proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Apr 2025 09:17:00 +0400
X-Gm-Features: ATxdqUEH5SYSrOcGnh4-FBH0vaWisG9AE9Y0PcYEohwyMPMx6_Xtl77nOfA9XpY
Message-ID: <CAJ+F1CKhzKaREBBJv30GfPGMqLLZKh2EW2fCcKwUr6GejkiVgQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] h264: stop gstreamer pipeline before destroying,
 cleanup on exit
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
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

Hi

On Mon, Apr 28, 2025 at 4:08=E2=80=AFPM Dietmar Maurer <dietmar@proxmox.com=
> wrote:
>
> > In file included from /home/elmarco/src/qemu/include/ui/console.h:4,
> >                  from ../system/runstate.c:54:
> > /home/elmarco/src/qemu/include/ui/qemu-pixman.h:10:10: fatal error:
> > pixman.h: No such file or directory
> >    10 | #include <pixman.h>
> >       |          ^~~~~~~~~~
>
> Just noticed that after updating to latest qemu.
>
> The following change fixes the problem, but I an not
> sure if we can simply depend on pixman there?

That shouldn't be a problem. Alternatively, perhaps split the vnc API
in ui/vnc.h ?

>
> --------------------------------------------
> diff --git a/meson.build b/meson.build
> index 50a9a2b036..2dfb1b1a4f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4073,10 +4073,11 @@ libsystem =3D static_library('system',
>                             libsystem_ss.sources() + genh,
>                             c_args: ['-DCONFIG_SOFTMMU',
>                                      '-DCOMPILING_SYSTEM_VS_USER'],
> -                           dependencies: libsystem_ss.dependencies(),
> +                           dependencies: [libsystem_ss.dependencies(), p=
ixman],
>                             build_by_default: false)

better in system/meson.build

>  libsystem =3D declare_dependency(objects: libsystem.extract_all_objects(=
recursive: false),
>                                 dependencies: libsystem_ss.dependencies()=
)
> --------------------------------------------
>


--=20
Marc-Andr=C3=A9 Lureau

