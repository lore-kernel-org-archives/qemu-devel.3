Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1961EE4995
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 11:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soLML-0005Fd-JS; Wed, 11 Sep 2024 07:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1soLMJ-0005Er-WF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:18:04 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1soLMH-0008Ad-Gw
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:18:03 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-710da8668b3so706447a34.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 04:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726053479; x=1726658279;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOfVESvvvwO8VkglR5RUtmi7/BPLzKTG1nOdgAriQjI=;
 b=BgsajU5glRn5wQe919to5H0ZhH27eghVa3HXvtbAJ8Uhh9FkHyAw9M2HYbzUWkhk4z
 fkQVMMXeJTHxIf/h2nSp+8FFbyE7f+/yt+HpGPGiXLc89X7ZNlIofZNvffu2nvYn/HKv
 cttf7AcXRWRV1n6NUi/5ed1pUQBUeT+pUToN4CiHBZKmIr3TlLBP+tUh4ouPSHtSV3sI
 TiZJclYR08qWRN3TdFz9pMh1WDDAVmtRw3ZIEKr7UTu6c/wsyMQH1p/1JgeaAKgZQDIa
 5JbdiH2yG9f0p8Ur45XGLmhp0/FOZ+kFOtZis2y64QIvebdOWkkSFrK2/1i1ioP8FoXG
 nExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726053479; x=1726658279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XOfVESvvvwO8VkglR5RUtmi7/BPLzKTG1nOdgAriQjI=;
 b=blvUExxcYURsL4+J5J9L4PKmyzTqCZ5aJ5dGdFDqoZu+jtsyuo0zJkY+mVDxwXug1w
 zsdoeXIbkpadFjB6L05l7/QTFaHjD8hfYqPUacGUHofMZD/4fLKo7VzRIB5R913LKid7
 13+rcjeWYlQIiQFOKqGRXGkPmQ5gMIP8kV5pGPXO81pL7dneRR8TDWbUSM2GhFkJkhvw
 Z0R6eI+5nGHp5mflYG+q+cuNgJk+Z7htpypNXzA1U7BLVmD3E61Fap/L9l8XjMyKldRW
 SW6uVtK1xG7n1cTkqlOVkn11MChOHj21NBN1Db1XyWlZ3sAsZaDMEO/plmqlNowEDnVq
 gYBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7RiN2FQ+rW6q18S2Y/Q0eTpjlylIZ9oWK98QU8Wh/vSl7iIswhSKwOdSohJbk/wznmErsGdCPAb6k@nongnu.org
X-Gm-Message-State: AOJu0Yw5JuD6jyV+ncBL558JbCtNLaxwxrakwaKzNxjYBIQqyi+Vhv2T
 ok6GXiNdsmKepXfqJNVl8MrQF1hUK+Kr6rTGGHyCnjtNFnynC9XpMa/81VGlVBybOSGQitzaMB3
 pblhZe1BrT8zR+aBMTSiBBqPzBmKCqwT9BjtTSA==
X-Google-Smtp-Source: AGHT+IFAGdDwS/BClSYa/4ctxJ/+FYXkfZqXZgWOd5c9lS8xP3nZNSdl8gyxxj+I7c64bih2Yb9QN6fJwPzDkO7NVn8=
X-Received: by 2002:a05:6830:2b13:b0:710:ed53:7e4e with SMTP id
 46e09a7af769-710fe75fdbfmr1635087a34.22.1726053479373; Wed, 11 Sep 2024
 04:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
 <20240910105002-mutt-send-email-mst@kernel.org>
 <CAFEAcA9dxdKmU-SPg1QGUbziKeydVB=i8BZUaKqMZvMSTr8RVw@mail.gmail.com>
 <CAGNS4Ta7RbLNCk3ffaS7fpqDJDjAUwnCXsVvjawSb6F7+inYxg@mail.gmail.com>
 <20240910123810-mutt-send-email-mst@kernel.org>
 <CAGNS4Tb9=H=c4=nihUYQH6oB8as++r8nG8SyOZtLo0XuiJR6kQ@mail.gmail.com>
 <20240911062402-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240911062402-mutt-send-email-mst@kernel.org>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Wed, 11 Sep 2024 13:17:48 +0200
Message-ID: <CAGNS4TaD35BpONFJc9UQGMmUX_1YJmCEMhxqQ-BP_frec6whBg@mail.gmail.com>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=mnissler@rivosinc.com; helo=mail-ot1-x334.google.com
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

On Wed, Sep 11, 2024 at 12:24=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Sep 10, 2024 at 11:36:08PM +0200, Mattias Nissler wrote:
> > On Tue, Sep 10, 2024 at 6:40=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Tue, Sep 10, 2024 at 06:10:50PM +0200, Mattias Nissler wrote:
> > > > On Tue, Sep 10, 2024 at 5:44=E2=80=AFPM Peter Maydell <peter.maydel=
l@linaro.org> wrote:
> > > > >
> > > > > On Tue, 10 Sept 2024 at 15:53, Michael S. Tsirkin <mst@redhat.com=
> wrote:
> > > > > >
> > > > > > On Mon, Aug 19, 2024 at 06:54:54AM -0700, Mattias Nissler wrote=
:
> > > > > > > When DMA memory can't be directly accessed, as is the case wh=
en
> > > > > > > running the device model in a separate process without sharea=
ble DMA
> > > > > > > file descriptors, bounce buffering is used.
> > > > > > >
> > > > > > > It is not uncommon for device models to request mapping of se=
veral DMA
> > > > > > > regions at the same time. Examples include:
> > > > > > >  * net devices, e.g. when transmitting a packet that is split=
 across
> > > > > > >    several TX descriptors (observed with igb)
> > > > > > >  * USB host controllers, when handling a packet with multiple=
 data TRBs
> > > > > > >    (observed with xhci)
> > > > > > >
> > > > > > > Previously, qemu only provided a single bounce buffer per Add=
ressSpace
> > > > > > > and would fail DMA map requests while the buffer was already =
in use. In
> > > > > > > turn, this would cause DMA failures that ultimately manifest =
as hardware
> > > > > > > errors from the guest perspective.
> > > > > > >
> > > > > > > This change allocates DMA bounce buffers dynamically instead =
of
> > > > > > > supporting only a single buffer. Thus, multiple DMA mappings =
work
> > > > > > > correctly also when RAM can't be mmap()-ed.
> > > > > > >
> > > > > > > The total bounce buffer allocation size is limited individual=
ly for each
> > > > > > > AddressSpace. The default limit is 4096 bytes, matching the p=
revious
> > > > > > > maximum buffer size. A new x-max-bounce-buffer-size parameter=
 is
> > > > > > > provided to configure the limit for PCI devices.
> > > > > > >
> > > > > > > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > > > > > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > > > > > Acked-by: Peter Xu <peterx@redhat.com>
> > > > > > > ---
> > > > > > > This patch is split out from my "Support message-based DMA in=
 vfio-user server"
> > > > > > > series. With the series having been partially applied, I'm sp=
litting this one
> > > > > > > out as the only remaining patch to system emulation code in t=
he hope to
> > > > > > > simplify getting it landed. The code has previously been revi=
ewed by Stefan
> > > > > > > Hajnoczi and Peter Xu. This latest version includes changes t=
o switch the
> > > > > > > bounce buffer size bookkeeping to `size_t` as requested and L=
GTM'd by Phil in
> > > > > > > v9.
> > > > > > > ---
> > > > > > >  hw/pci/pci.c                |  8 ++++
> > > > > > >  include/exec/memory.h       | 14 +++----
> > > > > > >  include/hw/pci/pci_device.h |  3 ++
> > > > > > >  system/memory.c             |  5 ++-
> > > > > > >  system/physmem.c            | 82 ++++++++++++++++++++++++++-=
----------
> > > > > > >  5 files changed, 76 insertions(+), 36 deletions(-)
> > > > > > >
> > > > > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > > > > index fab86d0567..d2caf3ee8b 100644
> > > > > > > --- a/hw/pci/pci.c
> > > > > > > +++ b/hw/pci/pci.c
> > > > > > > @@ -85,6 +85,8 @@ static Property pci_props[] =3D {
> > > > > > >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> > > > > > >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_pr=
esent,
> > > > > > >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > > > > > > +    DEFINE_PROP_SIZE32("x-max-bounce-buffer-size", PCIDevice=
,
> > > > > > > +                     max_bounce_buffer_size, DEFAULT_MAX_BOU=
NCE_BUFFER_SIZE),
> > > > > > >      DEFINE_PROP_END_OF_LIST()
> > > > > > >  };
> > > > > > >
> > > > > >
> > > > > > I'm a bit puzzled by now there being two fields named
> > > > > > max_bounce_buffer_size, one directly controllable by
> > > > > > a property.
> > > >
> > > > One is one the pci device, the other is on the address space. The
> > > > former can be set via a command line parameter, and that value is u=
sed
> > > > to initialize the field on the address space, which is then consult=
ed
> > > > when allocating bounce buffers.
> > > >
> > > > I'm not sure which aspect of this is unclear and/or deserves
> > > > additional commenting - let me know and I'll be happy to send a pat=
ch.
> > >
> > > I'd document what does each field do.
> >
> > I have just sent a patch to expand the comments, let's discuss details =
there.
> >
> > >
> > > > > >
> > > > > > Pls add code comments explaining how they are related.
> > > > > >
> > > > > >
> > > > > > Also, what is the point of adding a property without
> > > > > > making it part of an API? No one will be able to rely on
> > > > > > it working.
> >
> > All I needed was a practical way to allow the bounce buffer size limit
> > to be adjusted in the somewhat exotic situations where we're making
> > DMA requests to indirect memory regions (in my case it is a qemu
> > vfio-user server accessed by a client that can't or doesn't want to
> > provide direct memory-mapped access to its RAM). There was some
> > discussion about the nature of the parameter when I first proposed the
> > patch, see https://lore.kernel.org/qemu-devel/20230823092905.2259418-2-=
mnissler@rivosinc.com/
> > - an x-prefixed experimental command-line parameter was suggested
> > there as a practical way to allow this without qemu committing to
> > supporting this forever. For the unlikely case that this parameter
> > proves popular, it can still be added to a stable API (or
> > alternatively we could discuss whether a large-enough limit is
> > feasible after all, or even consider DMA API changes to obviate the
> > need for bounce buffering).
>
>
> Yes but how happy will you be if we rename the parameter in the
> future? All your scripts will break.

It's not that I'm running random qemu versions in production, in fact
I'm using this for semi-automated testing of hardware designs. We'd
find out when upgrading our qemu, and adjust. In fact, if you come up
with a better way to handle this bounce buffering kludge, I'd be
willing to not only adjust, but even help implement.

>
> > > > >
> > > > > Note that this patch is already upstream as commit 637b0aa13.
> > > > >
> > > > > thanks
> > > > > -- PMM
> > >
> > > Maybe you can answer this?
> > >
>

