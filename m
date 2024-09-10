Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ABCEDE99A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 15:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so32U-00036T-2n; Tue, 10 Sep 2024 11:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1so32S-000347-6g
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:44:20 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1so32Q-0000Ol-BU
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:44:19 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f75a81b6d5so40242911fa.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725983056; x=1726587856; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LSXUcdf+AFB6pXykINnOaOeGj5koD2UbOsxWW388qWo=;
 b=jJofsf1zmq8+zstW9nyB5Id73N8XlZpkQkH+kDQ90qjTdxbLIoaV84HVh3Yjueh3dE
 Va/CSXkhnh+H6+kY6Lntv6wWiPcRZNQ9YW1KTNVt8letZ5huXoyuX9SIcZ+Md5r3V1Ju
 4J27iiwKQNWJW/zI0U2C43feT113eKgKs14HMUDgLPD1HYpsDFI1RnXXGZCe7gkO5Gm3
 kJUFzs8qw4qUnwpkb1gvQlpiMJa25jXRB0JzptZ9suvEdLQ/8g38ARGWq7fTmEoaRRrA
 KD943o72HHfvR7mn/ysw1Ly0cQPU8THEUPUcxyEMtNuNssN/xEBM9pagMrg5+QLYKbsT
 KBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725983056; x=1726587856;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LSXUcdf+AFB6pXykINnOaOeGj5koD2UbOsxWW388qWo=;
 b=BbKyZaCS9taIVJxnpTXMlviZQOv3FrptvmVLOqOsVYTqOhZQBXqFh9RxqQ+LIJ+kOl
 K51t/5lfQVdc96hRIKHIaOHg5dlP49gF1LsEwtW/wUJhtq6bbtX8ekyKMqwtotSeOHqE
 yMeZn2/tsgOKwTLBUnSH31jXOi8PyLZ1YbMWOQxWQQ/gSWNa4VP2xptklWc812o6rKdb
 U1LYQchGoLT57RlaJkpm66XYVgFNTw0xT6ZGSn5jXEyoqw278ot/TrH/+Z5eXH09Clhz
 sAMbiTGfJWN5s3R83/cgyLRg6AaGdUqXBI+Vf1nFmig+j1bdwWSpMCYEAdt9etW0PLUG
 6zuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvCMtR4tFNi8DavJtAJI4O2U8iuifOrJipO4xfXwXjHfVsrClLOnNyXGWw3GrejRLoD2yTTxilABTZ@nongnu.org
X-Gm-Message-State: AOJu0Yzdul4/uqQ0AUMq73gDKsTac8swTNj2yTgtibu6MH0kJH/LXw5I
 1DAHHgYWwJKfoXlk4Be+n2grDIBkz5CZfhVlmsekgbhZb322PXUEVF7kPS2E2Qv9tclerC81x8G
 IwRIqNXAtyT2j+72HZfqHMoLtbNrXwP4pBxF5GA==
X-Google-Smtp-Source: AGHT+IFpRYmFWFWuc0lg1fFpbJdoNcwdBTiuTLGfQKGh1iPx/WjyYACd192h3XyPI7Jitlm8iUG0U2WzJJLW8Y308Cw=
X-Received: by 2002:a2e:4c01:0:b0:2f0:25dc:1894 with SMTP id
 38308e7fff4ca-2f751eaf1c3mr82762951fa.2.1725983055483; Tue, 10 Sep 2024
 08:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
 <20240910105002-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240910105002-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2024 16:44:04 +0100
Message-ID: <CAFEAcA9dxdKmU-SPg1QGUbziKeydVB=i8BZUaKqMZvMSTr8RVw@mail.gmail.com>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mattias Nissler <mnissler@rivosinc.com>, qemu-devel@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

On Tue, 10 Sept 2024 at 15:53, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Aug 19, 2024 at 06:54:54AM -0700, Mattias Nissler wrote:
> > When DMA memory can't be directly accessed, as is the case when
> > running the device model in a separate process without shareable DMA
> > file descriptors, bounce buffering is used.
> >
> > It is not uncommon for device models to request mapping of several DMA
> > regions at the same time. Examples include:
> >  * net devices, e.g. when transmitting a packet that is split across
> >    several TX descriptors (observed with igb)
> >  * USB host controllers, when handling a packet with multiple data TRBs
> >    (observed with xhci)
> >
> > Previously, qemu only provided a single bounce buffer per AddressSpace
> > and would fail DMA map requests while the buffer was already in use. In
> > turn, this would cause DMA failures that ultimately manifest as hardwar=
e
> > errors from the guest perspective.
> >
> > This change allocates DMA bounce buffers dynamically instead of
> > supporting only a single buffer. Thus, multiple DMA mappings work
> > correctly also when RAM can't be mmap()-ed.
> >
> > The total bounce buffer allocation size is limited individually for eac=
h
> > AddressSpace. The default limit is 4096 bytes, matching the previous
> > maximum buffer size. A new x-max-bounce-buffer-size parameter is
> > provided to configure the limit for PCI devices.
> >
> > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Acked-by: Peter Xu <peterx@redhat.com>
> > ---
> > This patch is split out from my "Support message-based DMA in vfio-user=
 server"
> > series. With the series having been partially applied, I'm splitting th=
is one
> > out as the only remaining patch to system emulation code in the hope to
> > simplify getting it landed. The code has previously been reviewed by St=
efan
> > Hajnoczi and Peter Xu. This latest version includes changes to switch t=
he
> > bounce buffer size bookkeeping to `size_t` as requested and LGTM'd by P=
hil in
> > v9.
> > ---
> >  hw/pci/pci.c                |  8 ++++
> >  include/exec/memory.h       | 14 +++----
> >  include/hw/pci/pci_device.h |  3 ++
> >  system/memory.c             |  5 ++-
> >  system/physmem.c            | 82 ++++++++++++++++++++++++++-----------
> >  5 files changed, 76 insertions(+), 36 deletions(-)
> >
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index fab86d0567..d2caf3ee8b 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -85,6 +85,8 @@ static Property pci_props[] =3D {
> >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > +    DEFINE_PROP_SIZE32("x-max-bounce-buffer-size", PCIDevice,
> > +                     max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_BUFFER=
_SIZE),
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >
>
> I'm a bit puzzled by now there being two fields named
> max_bounce_buffer_size, one directly controllable by
> a property.
>
> Pls add code comments explaining how they are related.
>
>
> Also, what is the point of adding a property without
> making it part of an API? No one will be able to rely on
> it working.

Note that this patch is already upstream as commit 637b0aa13.

thanks
-- PMM

