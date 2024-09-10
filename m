Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E73EE01EB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 21:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so8XB-0008WH-Tl; Tue, 10 Sep 2024 17:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1so8XA-0008Lg-FQ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:36:24 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1so8X8-00038y-72
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:36:24 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5e1c56a8415so653721eaf.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 14:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726004180; x=1726608980;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sk3jd05KBAg8mRe5oxHqtdzEC2kTg8CUCvzwW3b+4Gk=;
 b=xuLAkthwzubf9rwuAdG6slzLx9HAqKWBQ2UAAJbGLCQ+Odb4g8PcN/75nhZSh5IDIw
 uyusL4rM86axL2XMSghIXnF5ajwHH+i91jRg2HR7nySWOeoCk4VHp9jO1KPZBJTIZH/v
 2XuffPaNPgyL8v6CpfnLvVU6K9+a3IXKaG5q24sDDRavThZlI2vBHyB6HcmCPtD0AXED
 +GW7Rr6Xkbp48XcZX194C/Ikkj17x96IqSOXOH4r8DcIjcJ22R4ZR87aFPtrkI63LL4W
 D2jW4HDO457gi2qccbvdWQwkhySVF2KU+6Y+EUFiFk2pKlaK07ImQKVRQwMXeaHe/aq9
 7jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726004180; x=1726608980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sk3jd05KBAg8mRe5oxHqtdzEC2kTg8CUCvzwW3b+4Gk=;
 b=T3h1ZxMNpjJafA1C8VFrRhCSfoYIYE93fUOGX40favtuOAbMpaQNyF4b5ZWlm4Spwy
 KG0RhLuS1o0beeJoy8i8sFD8DHnnKSlVdqUA2OoCPlzQ0oBZUzIdVra0hSw+PiAQH8Gd
 gdd9B0oL3Qf9eVbAavfjryju63QNI1IOadEywAd/J1IyEFUkADU3PWczs4r4djuY/Jjf
 JKwphomnOfyOvj0/TiXXCU+6ARO8/vSaSiO7bvCaEH9kA+zEjYY0Y2gx7ARj6UBtvvIC
 W0iKafWO1ISiYm2DbUFjSVdyVXIsX1YHzApU+xIrGDpKGS6AhvkY1UhYWsSrne65P9x0
 OZDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXss84CF/YXjbJgO2HxgbmtJ6Y0paGiaYWJmK4smfE9J4rH7C+uQIx3s/NjIoExQu+BxeFhEMzQ88nZ@nongnu.org
X-Gm-Message-State: AOJu0YxDelg7bAHyqJ8e1yv4as/P15/kqbep2a2/brk3k9TqfdNO01G8
 QYGiVCs6a/e717yW0794tIkoNd4mhYUpb8069fl/QLRsGCq7GPVmpglEPPGq/ZfUi5D+byc1vHe
 61lCflC6noRoQ9LBWpGWgKnRtZBeI+FMhyK4vIQ==
X-Google-Smtp-Source: AGHT+IH24OjmV0GLX+OKtoor0fORInIj2D9aGfEv74T2GUcHh38WA/kDB3wBMQejPdrI3nlwVVDw5LdNNATo73me1JU=
X-Received: by 2002:a05:6820:16a5:b0:5e1:eba9:8fe7 with SMTP id
 006d021491bc7-5e1f14a1f1amr898437eaf.3.1726004179792; Tue, 10 Sep 2024
 14:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
 <20240910105002-mutt-send-email-mst@kernel.org>
 <CAFEAcA9dxdKmU-SPg1QGUbziKeydVB=i8BZUaKqMZvMSTr8RVw@mail.gmail.com>
 <CAGNS4Ta7RbLNCk3ffaS7fpqDJDjAUwnCXsVvjawSb6F7+inYxg@mail.gmail.com>
 <20240910123810-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240910123810-mutt-send-email-mst@kernel.org>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Tue, 10 Sep 2024 23:36:08 +0200
Message-ID: <CAGNS4Tb9=H=c4=nihUYQH6oB8as++r8nG8SyOZtLo0XuiJR6kQ@mail.gmail.com>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=mnissler@rivosinc.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Sep 10, 2024 at 6:40=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Sep 10, 2024 at 06:10:50PM +0200, Mattias Nissler wrote:
> > On Tue, Sep 10, 2024 at 5:44=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > >
> > > On Tue, 10 Sept 2024 at 15:53, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > > >
> > > > On Mon, Aug 19, 2024 at 06:54:54AM -0700, Mattias Nissler wrote:
> > > > > When DMA memory can't be directly accessed, as is the case when
> > > > > running the device model in a separate process without shareable =
DMA
> > > > > file descriptors, bounce buffering is used.
> > > > >
> > > > > It is not uncommon for device models to request mapping of severa=
l DMA
> > > > > regions at the same time. Examples include:
> > > > >  * net devices, e.g. when transmitting a packet that is split acr=
oss
> > > > >    several TX descriptors (observed with igb)
> > > > >  * USB host controllers, when handling a packet with multiple dat=
a TRBs
> > > > >    (observed with xhci)
> > > > >
> > > > > Previously, qemu only provided a single bounce buffer per Address=
Space
> > > > > and would fail DMA map requests while the buffer was already in u=
se. In
> > > > > turn, this would cause DMA failures that ultimately manifest as h=
ardware
> > > > > errors from the guest perspective.
> > > > >
> > > > > This change allocates DMA bounce buffers dynamically instead of
> > > > > supporting only a single buffer. Thus, multiple DMA mappings work
> > > > > correctly also when RAM can't be mmap()-ed.
> > > > >
> > > > > The total bounce buffer allocation size is limited individually f=
or each
> > > > > AddressSpace. The default limit is 4096 bytes, matching the previ=
ous
> > > > > maximum buffer size. A new x-max-bounce-buffer-size parameter is
> > > > > provided to configure the limit for PCI devices.
> > > > >
> > > > > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > > > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > > > Acked-by: Peter Xu <peterx@redhat.com>
> > > > > ---
> > > > > This patch is split out from my "Support message-based DMA in vfi=
o-user server"
> > > > > series. With the series having been partially applied, I'm splitt=
ing this one
> > > > > out as the only remaining patch to system emulation code in the h=
ope to
> > > > > simplify getting it landed. The code has previously been reviewed=
 by Stefan
> > > > > Hajnoczi and Peter Xu. This latest version includes changes to sw=
itch the
> > > > > bounce buffer size bookkeeping to `size_t` as requested and LGTM'=
d by Phil in
> > > > > v9.
> > > > > ---
> > > > >  hw/pci/pci.c                |  8 ++++
> > > > >  include/exec/memory.h       | 14 +++----
> > > > >  include/hw/pci/pci_device.h |  3 ++
> > > > >  system/memory.c             |  5 ++-
> > > > >  system/physmem.c            | 82 ++++++++++++++++++++++++++-----=
------
> > > > >  5 files changed, 76 insertions(+), 36 deletions(-)
> > > > >
> > > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > > index fab86d0567..d2caf3ee8b 100644
> > > > > --- a/hw/pci/pci.c
> > > > > +++ b/hw/pci/pci.c
> > > > > @@ -85,6 +85,8 @@ static Property pci_props[] =3D {
> > > > >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> > > > >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_presen=
t,
> > > > >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > > > > +    DEFINE_PROP_SIZE32("x-max-bounce-buffer-size", PCIDevice,
> > > > > +                     max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_=
BUFFER_SIZE),
> > > > >      DEFINE_PROP_END_OF_LIST()
> > > > >  };
> > > > >
> > > >
> > > > I'm a bit puzzled by now there being two fields named
> > > > max_bounce_buffer_size, one directly controllable by
> > > > a property.
> >
> > One is one the pci device, the other is on the address space. The
> > former can be set via a command line parameter, and that value is used
> > to initialize the field on the address space, which is then consulted
> > when allocating bounce buffers.
> >
> > I'm not sure which aspect of this is unclear and/or deserves
> > additional commenting - let me know and I'll be happy to send a patch.
>
> I'd document what does each field do.

I have just sent a patch to expand the comments, let's discuss details ther=
e.

>
> > > >
> > > > Pls add code comments explaining how they are related.
> > > >
> > > >
> > > > Also, what is the point of adding a property without
> > > > making it part of an API? No one will be able to rely on
> > > > it working.

All I needed was a practical way to allow the bounce buffer size limit
to be adjusted in the somewhat exotic situations where we're making
DMA requests to indirect memory regions (in my case it is a qemu
vfio-user server accessed by a client that can't or doesn't want to
provide direct memory-mapped access to its RAM). There was some
discussion about the nature of the parameter when I first proposed the
patch, see https://lore.kernel.org/qemu-devel/20230823092905.2259418-2-mnis=
sler@rivosinc.com/
- an x-prefixed experimental command-line parameter was suggested
there as a practical way to allow this without qemu committing to
supporting this forever. For the unlikely case that this parameter
proves popular, it can still be added to a stable API (or
alternatively we could discuss whether a large-enough limit is
feasible after all, or even consider DMA API changes to obviate the
need for bounce buffering).

> > >
> > > Note that this patch is already upstream as commit 637b0aa13.
> > >
> > > thanks
> > > -- PMM
>
> Maybe you can answer this?
>

