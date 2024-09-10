Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE398EDE9A0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 16:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so3SN-0003zv-3H; Tue, 10 Sep 2024 12:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1so3SK-0003yy-Sm
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:11:04 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1so3SI-0003Wi-JE
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:11:04 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5d5c7f23f22so3311209eaf.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725984661; x=1726589461;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhJz73nxqh6xQa3oW3aMTYalOpqSo2No8sD4Wx2QEzE=;
 b=lonYLVaiTjRvHeFZ1ARhUhcH6RDgznkAw/PbDzD/s5wtcdfM4ESqi+DYwRmaF6BPfA
 MF082rf8lQg/6cKy3BH+07wMRhLCFsco+gpA+S4AhUH/i42D/EsBiIdjlgE51MC70no+
 MVI40UmAmWcMbBhrBDZJ/Dax4ZXQQDIRJMIJZjd/GMlzLp/rUs3Qe98IY68QwjW2bvYc
 dFbF8wu5FInzS+6Y6tNyic+qGpjMdECR3j04KMOwm/RNnZd2ybsKq8bP4TUuAzsmUikr
 y+ct/VXhlTK5sfnsGnR7SyCWhL2xvO+5JdlVwkJGZIz4oHaZdu8vKBNQF7REnMvEsXF9
 0+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725984661; x=1726589461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xhJz73nxqh6xQa3oW3aMTYalOpqSo2No8sD4Wx2QEzE=;
 b=VRyAWXKZUzYDVw5Xwo3dwyokLjddD07a+tVp3i3LChk4yEmekp+6RQZ5atCnwkDwBj
 rutPq4yTeiDnd6S9vrFDT292SnnDAzPMHgdFOHvq/9qILBp2A+l1Xud4Q8ZkePnO0Z0q
 zH1zRxlc044+rnjMmGVJfUq3IiH/kpsfc5DDWHnOdElHgByEKn+vJuWkb4fV9EaiMQoT
 PCUrIz0+fgS5PBzBtMrpbuQdOTZWcb2HsT6vd9MZQFiSCwC0lm3M4kBYLOte+VDT6/QB
 uMjpOZjxPKtj7VUinX651Smh5Guho1tFeieff1LsLuh2c4YV8NmANuQMbJSUcrsHDE1V
 mPrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKh9qxtcULlmmP4couWnDC02/7SHYvMMtOTsgBqvwv3HgImoZ71LQMJDzMJmgsDoeTMyCSptcU0ueB@nongnu.org
X-Gm-Message-State: AOJu0YwgpvfYTZB9mfn6/+cb+oqe4mA73rdRIaRICbkLf46J3IP2TfGK
 70ECJe23ujlyiJ7DCxUZ9wWEGTTQ4VYmjlINMJ9zlSZaLQxl+L4m+q0rpvnz+JkT/qHEA4QECzM
 gO3SmglaPXgJm47st7bW1np3NbwPyEpDTxZwZFA==
X-Google-Smtp-Source: AGHT+IHpUz+Z9xFP/JsWbzCmx913cc6bAGSA31Pf1C6QTCxCFcjRazZDm8PshaNX9YZO2oXsc0qqKbM7fSiYR7WPKFw=
X-Received: by 2002:a05:6820:60a:b0:5e1:eba9:8fee with SMTP id
 006d021491bc7-5e1eba99197mr1153602eaf.1.1725984660743; Tue, 10 Sep 2024
 09:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
 <20240910105002-mutt-send-email-mst@kernel.org>
 <CAFEAcA9dxdKmU-SPg1QGUbziKeydVB=i8BZUaKqMZvMSTr8RVw@mail.gmail.com>
In-Reply-To: <CAFEAcA9dxdKmU-SPg1QGUbziKeydVB=i8BZUaKqMZvMSTr8RVw@mail.gmail.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Tue, 10 Sep 2024 18:10:50 +0200
Message-ID: <CAGNS4Ta7RbLNCk3ffaS7fpqDJDjAUwnCXsVvjawSb6F7+inYxg@mail.gmail.com>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=mnissler@rivosinc.com; helo=mail-oo1-xc2f.google.com
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

On Tue, Sep 10, 2024 at 5:44=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 10 Sept 2024 at 15:53, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Aug 19, 2024 at 06:54:54AM -0700, Mattias Nissler wrote:
> > > When DMA memory can't be directly accessed, as is the case when
> > > running the device model in a separate process without shareable DMA
> > > file descriptors, bounce buffering is used.
> > >
> > > It is not uncommon for device models to request mapping of several DM=
A
> > > regions at the same time. Examples include:
> > >  * net devices, e.g. when transmitting a packet that is split across
> > >    several TX descriptors (observed with igb)
> > >  * USB host controllers, when handling a packet with multiple data TR=
Bs
> > >    (observed with xhci)
> > >
> > > Previously, qemu only provided a single bounce buffer per AddressSpac=
e
> > > and would fail DMA map requests while the buffer was already in use. =
In
> > > turn, this would cause DMA failures that ultimately manifest as hardw=
are
> > > errors from the guest perspective.
> > >
> > > This change allocates DMA bounce buffers dynamically instead of
> > > supporting only a single buffer. Thus, multiple DMA mappings work
> > > correctly also when RAM can't be mmap()-ed.
> > >
> > > The total bounce buffer allocation size is limited individually for e=
ach
> > > AddressSpace. The default limit is 4096 bytes, matching the previous
> > > maximum buffer size. A new x-max-bounce-buffer-size parameter is
> > > provided to configure the limit for PCI devices.
> > >
> > > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > Acked-by: Peter Xu <peterx@redhat.com>
> > > ---
> > > This patch is split out from my "Support message-based DMA in vfio-us=
er server"
> > > series. With the series having been partially applied, I'm splitting =
this one
> > > out as the only remaining patch to system emulation code in the hope =
to
> > > simplify getting it landed. The code has previously been reviewed by =
Stefan
> > > Hajnoczi and Peter Xu. This latest version includes changes to switch=
 the
> > > bounce buffer size bookkeeping to `size_t` as requested and LGTM'd by=
 Phil in
> > > v9.
> > > ---
> > >  hw/pci/pci.c                |  8 ++++
> > >  include/exec/memory.h       | 14 +++----
> > >  include/hw/pci/pci_device.h |  3 ++
> > >  system/memory.c             |  5 ++-
> > >  system/physmem.c            | 82 ++++++++++++++++++++++++++---------=
--
> > >  5 files changed, 76 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index fab86d0567..d2caf3ee8b 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -85,6 +85,8 @@ static Property pci_props[] =3D {
> > >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> > >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> > >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > > +    DEFINE_PROP_SIZE32("x-max-bounce-buffer-size", PCIDevice,
> > > +                     max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_BUFF=
ER_SIZE),
> > >      DEFINE_PROP_END_OF_LIST()
> > >  };
> > >
> >
> > I'm a bit puzzled by now there being two fields named
> > max_bounce_buffer_size, one directly controllable by
> > a property.

One is one the pci device, the other is on the address space. The
former can be set via a command line parameter, and that value is used
to initialize the field on the address space, which is then consulted
when allocating bounce buffers.

I'm not sure which aspect of this is unclear and/or deserves
additional commenting - let me know and I'll be happy to send a patch.

> >
> > Pls add code comments explaining how they are related.
> >
> >
> > Also, what is the point of adding a property without
> > making it part of an API? No one will be able to rely on
> > it working.
>
> Note that this patch is already upstream as commit 637b0aa13.
>
> thanks
> -- PMM

