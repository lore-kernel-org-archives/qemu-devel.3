Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BE9CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwzRm-0005sR-0W; Fri, 12 Sep 2025 04:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uwzRl-0005sH-Ey
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:47:57 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uwzRb-0006R0-Lo
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:47:57 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4b5f79aa443so13911551cf.1
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757666865; x=1758271665; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvDF9zJHT/BjdbOPEASN998Q36lT+8Had9rYleB5lhc=;
 b=Uq8QDR6imT4nZcOmdmY359PNa5ztuQh75m2y0+FdjUNNHEyVEs9iM4V8yqoH8+lFE8
 9+Vw5F+oWPvoZKHXSho9zFGvYw6yqhq8z4L/PfUawPXByUyK/TYIOp7wVVk6ylk/Bzlp
 RGq5Z3GPcQNw2SlqiApTcYqAZGOmma5NUYbqupJ2FUAdrw43aDLkyJ0g44JzeZBkeWGo
 C86CLqWELTLaHFvHIjLgDZDIYOnMO/EzKEkuN29Ofn6Fqx+HQBHSNHlNd65OCL3lnwyA
 YbJwTM+VehsEoLEg7cNhxNVUuOIVexgyRIIsjifySQcK2YzwAs9Pm7CoCz87nPqzA0Ob
 m0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757666865; x=1758271665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZvDF9zJHT/BjdbOPEASN998Q36lT+8Had9rYleB5lhc=;
 b=jQQ7osGQ4w4iApIBdHUZ/zwX/gB5/dIsR8nScX/xWXdP1rdwYQuyKdqCjFb5vfb33L
 kMljYSreTUOD/8P3ND/X6Pb6GTJ2XELHejWaQcivuLPXrnsBsdLEK+3RcndijAfLMDpD
 rPFALpOHrqZrdFKdyiuJ5FokS0V8j59nIOMAPCNfqn0vNkTp5piFXGJ8vLJy/O8RnJqF
 1mveoY/hIP4aHhsp+ZmU1vf4ra9JPQjdPiE7O97teF2p0FMVfEUSD6iBGM3RbIVmX+Ej
 u1IyHoRVjiEzDlvoK7i52mVEK91IdujG4pExmePBPWp84QZifyYNKtqdVHCfz3FxyI+/
 1ZNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4cpxnPkOCI8kn4v/pRRfAVyihmXPZZaaaHBiOFtGYof8IC4ackwZ+C8rKNpNQgMhiE6m8L1xuxjha@nongnu.org
X-Gm-Message-State: AOJu0Yx5p+FRJmUSaKAG87cNoO1z+eG3SH2nFfj9lLFIVWuluewFedq9
 FVemCnYoldhFbeKzbN9A9febGI9a9Rg67t6kCOMbnTPBwN9sXw3s5i12S4zumrNHlVqXobcS3it
 w/L7kkJI+NxB1QaLoh5/RxFyBV5mqs2k=
X-Gm-Gg: ASbGncs8TP0bixLebYKJQlu6nToOq56arrtV5w/r8qKzvgiKCmtb7cCPGXPyaWz1F+2
 piJ6tyHJURs3OL2KSIrP6Ro4IvoC1bDvwzv64RN/PIgGbPDtEYLcQfhvFzkygh67YezOOBtlvnd
 ydC+imxJsipU9+tpOLl27Oh6WeGMfyVE9lHUeZPNODJJLz+P3T0EE2N3bssQNJuSJvN3i8ljJ9t
 OvLfoj0lLQ9hKEK0r58YNZz
X-Google-Smtp-Source: AGHT+IHj66frKyUYCxzcMNbIo8n0gd0VnEYGeQfYNX0sgnYqCZzmzNXTRgATpqkVLNDzzl2N10FvkcI7Lx3Z9i8biaM=
X-Received: by 2002:a05:622a:5c94:b0:4b3:4c51:643e with SMTP id
 d75a77b69052e-4b77d1a3cccmr21856711cf.68.1757666865024; Fri, 12 Sep 2025
 01:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <CAFEAcA8WZ1Aa==LZv+roEHdaOzoMoX3aoeBbsM4gc3d_Yq=GTA@mail.gmail.com>
 <CAJ+F1CJCJUgnFRvc6LCCMdLVrXAoaTqWzuYtKE+siW+-8vZ4=Q@mail.gmail.com>
 <aMPO5YZK3EgWBJdC@intel.com>
In-Reply-To: <aMPO5YZK3EgWBJdC@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Sep 2025 12:47:33 +0400
X-Gm-Features: Ac12FXz3y1pzgF8HJlbLZsXlRZ0pC2PJ5yuRsSCSf8jYR6APzPpOryaglb52PBU
Message-ID: <CAJ+F1CJKbmexhgc+jLko8RgYHxSF66HXQYHdagZLpagq-tXXNw@mail.gmail.com>
Subject: Re: [PATCH 00/33] First Rust update for QEMU 10.2
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Hi Zhao

On Fri, Sep 12, 2025 at 11:20=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
>
> On Thu, Sep 11, 2025 at 03:18:44PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Date: Thu, 11 Sep 2025 15:18:44 +0400
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
> > Subject: Re: [PATCH 00/33] First Rust update for QEMU 10.2
> >
> > Hi
> >
> > On Thu, Sep 11, 2025 at 2:05=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > >
> > > On Mon, 8 Sept 2025 at 11:53, Paolo Bonzini <pbonzini@redhat.com> wro=
te:
> > > >
> > > > This includes:
> > > > - bumping MSRV to 1.83.0 to support const_refs_to_static
> > > > - Zhao's safe, builder-based implementation of migration callbacks
> > > > - Manos's qdev properties macro.  While bit-based properties are
> > > >   not yet supported, that's a small change overall.
> > > > - the Rust crate split from Marc-Andr=C3=A9
> > > > - adding proc macro aliases in individual crates, also from Marc-An=
dr=C3=A9
> > > >
> > > > I'm still not convinced about having "bql" depend on "migration",
> > > > but I am convinced by the crate split between "util" and "bql",
> > > > so we can move the implementation of VMState from "bql" to
> > > > "migration" later if needed.
> > > >
> > > > For the purpose of getting this in as an easy-to-use base for futur=
e
> > > > development, I'm disabling CI from Debian and Ubuntu.  The plan is:
> > > > - that Debian will require trixie to enable Rust usage
> > > > - that Ubuntu will backport 1.83 to its 22.04 and 24.04 versions
> > > >   (https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/212031=
8)
> > > > - that Marc-Andr=C3=A9 or someone else will add Rust to other CI jo=
bs
> > >
> > > How far into the future does moving to 1.83.0 push our
> > > "we can enable rust and make it mandatory" point? I was
> > > hoping we would be able to do that sometime soon but this
> > > sounds like we're going to be still a long way out from that :-(
> >
> > I suppose most distro will want to backport a newer rust in their
> > stable distro, like ubuntu is doing or debian with rustc-web. With
> > that, it shouldn't be too long before we could make Rust required.
> >
> > fwiw, I am working on a series to enable Rust on our various
> > CI/docker/vm. I am mostly left with issues from windows and macos ..
> > (btw, if someone can help me investigate the linking issue on mac
> > https://gitlab.com/marcandre.lureau/qemu/-/jobs/11301499123, perhaps a
> > temporary ssh somewhere?)
>
> Just a guess...
>
> It seems "-llibqemuutil.a" may tell the linker to search for
> liblibqemuutil.a.dylib or liblibqemuutil.a.a [*] :-(
>
> [*]: https://manp.gs/mac/1/ld#l

Good guess, the trouble seems to be the usage of -lstatic:+verbatim in meso=
n:

https://github.com/mesonbuild/meson/issues/15020

--=20
Marc-Andr=C3=A9 Lureau

