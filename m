Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EDFC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 06:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PCs-0005N0-6b; Mon, 13 May 2024 02:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s6PCl-0005Ko-GB
 for qemu-devel@nongnu.org; Mon, 13 May 2024 02:30:35 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s6PCe-0003YF-LH
 for qemu-devel@nongnu.org; Mon, 13 May 2024 02:30:34 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5aa1bf6cb40so2931508eaf.1
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 23:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715581802; x=1716186602;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lj5FHeMUi9+289d+EDAj+NxC/FVbTNg5TfQeHn1rEY=;
 b=B84SOcdC3d0KlBe2jaRnai23sgcmTr9EYBqumdhCIdmEINp4NwLar/OwP42Xne+X4D
 OkbNi4h4y1GjMIuISff31TMi/SZHm4f67UGJOoxAOpllnGwOuQKgF9GGfQbgeL78GTp/
 rIj+/s26pCgl1s2oFsUoxgrxUW1kaTtUNGxV3E/9xl11QA1un0E5s5E8tzens/F9jNuc
 Zi8PYvv3B89P4e4QbPL1jni0QDWpJs76feZuqnQdRY2MNtBeC9iUOFIBscVx8zCCoF2L
 M0VFRYpCvlN6NmzX10jU75c9ErJ91Ten/2MKb286li18ecvvooEnbl9EKwSJZbzOUaxB
 j6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715581802; x=1716186602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lj5FHeMUi9+289d+EDAj+NxC/FVbTNg5TfQeHn1rEY=;
 b=VDFuVuMn1gOGMaAGiX6z+wg4AZmj0+K6GPj6YvDUm5S32W3tuVltrBvez27R7L0pxM
 8q7Nzu1F12Bow95gPEbUCcPgtHSczlnAcUmwxLRNbO3NZPlihSYuGoHymmwrqYtrCxiF
 eA71tqiHbCgWKNiUMO2PbpRppsyL1vdoJHtXYJWYcpBSyH4hf5EpvbfTk4TD7W96/3yJ
 l/y8DHjXRvdVnNUF/x8MfqxhmvyIHsh3utiJuVQ01B5EMUtqLzEidNFvf180QgOak2VN
 /3MtdNFRPxsyglAx2iuRit6r1vrMa+tb6Wk0xi8lrTrNlYFizLoEVpX1TTr1dxy+3ga2
 KjFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8ZFHtGaOPxnC+UUEq5xjQsiLiIiBgyzj8z0XAAvAJGDCGygL8V7J6gTOfVpOVqiOysRgJcf+NtyegpunUXUh0bjnVnnk=
X-Gm-Message-State: AOJu0Yw8br5qCxzWI5zWjMSlXjt5NAkb2lQ6oKPVYu0rulSBNyn3L1dA
 bbVYlxIXhvD0stVO0e88woyzX2G1IKwks707s4IXZTejBZPpaMU8vhza8uIjSDQ6aHNelqMpj+z
 UoI5zpgi+AHTK7IERfDsznDws1Gg5kc56/sKbIg==
X-Google-Smtp-Source: AGHT+IFqcWlc5xd20ET7ho1+ApiEmXgHnKbbuVUoxfcVlBum4XiDRZojXzGcQ7Db/91lzBSrmyzeOeLd60DI8qwFB5U=
X-Received: by 2002:a05:6870:730d:b0:22e:b299:6512 with SMTP id
 586e51a60fabf-24172bab10bmr11865988fac.32.1715581801859; Sun, 12 May 2024
 23:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240507094210.300566-1-mnissler@rivosinc.com>
 <20240507094210.300566-3-mnissler@rivosinc.com>
 <447ddc5a-ae1e-4fd1-b03a-dd7e1faa46e9@linaro.org>
 <CAGNS4Tb1FVFmzVLvSZD84n0q80bwDiAMaSr752jb4nDwkGHSjA@mail.gmail.com>
 <b239ed9c-df6c-4785-91cc-fb7139997209@linaro.org>
 <CAGNS4TbG2=mqzfRjNsSueQCNGbBvPP0DdXLVO7Pg8YfpTmpwTA@mail.gmail.com>
In-Reply-To: <CAGNS4TbG2=mqzfRjNsSueQCNGbBvPP0DdXLVO7Pg8YfpTmpwTA@mail.gmail.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Mon, 13 May 2024 08:29:50 +0200
Message-ID: <CAGNS4TZcN3y9dDR5p3eijf_u9VSM2CFVk=RBAuT0KOM3TC7vMQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] softmmu: Support concurrent bounce buffers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, 
 jag.raman@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, john.levon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=mnissler@rivosinc.com; helo=mail-oo1-xc36.google.com
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

Phil,

Did you accidentally miss this in your pull request [1] or did you
leave it out intentionally?

It's still missing the Reviewed bit after the atomic cmpxchg change
prompted by the size_t switch, so that might be the reason - I'm just
trying to figure out what the next step is for this patch.

Thanks,
Mattias

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-05/msg01712.html

On Wed, May 8, 2024 at 8:33=E2=80=AFAM Mattias Nissler <mnissler@rivosinc.c=
om> wrote:
>
> On Tue, May 7, 2024 at 4:46=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org> wrote:
> >
> > On 7/5/24 16:04, Mattias Nissler wrote:
> > > On Tue, May 7, 2024 at 2:57=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <p=
hilmd@linaro.org> wrote:
> > >>
> > >> On 7/5/24 11:42, Mattias Nissler wrote:
> > >>> When DMA memory can't be directly accessed, as is the case when
> > >>> running the device model in a separate process without shareable DM=
A
> > >>> file descriptors, bounce buffering is used.
> > >>>
> > >>> It is not uncommon for device models to request mapping of several =
DMA
> > >>> regions at the same time. Examples include:
> > >>>    * net devices, e.g. when transmitting a packet that is split acr=
oss
> > >>>      several TX descriptors (observed with igb)
> > >>>    * USB host controllers, when handling a packet with multiple dat=
a TRBs
> > >>>      (observed with xhci)
> > >>>
> > >>> Previously, qemu only provided a single bounce buffer per AddressSp=
ace
> > >>> and would fail DMA map requests while the buffer was already in use=
. In
> > >>> turn, this would cause DMA failures that ultimately manifest as har=
dware
> > >>> errors from the guest perspective.
> > >>>
> > >>> This change allocates DMA bounce buffers dynamically instead of
> > >>> supporting only a single buffer. Thus, multiple DMA mappings work
> > >>> correctly also when RAM can't be mmap()-ed.
> > >>>
> > >>> The total bounce buffer allocation size is limited individually for=
 each
> > >>> AddressSpace. The default limit is 4096 bytes, matching the previou=
s
> > >>> maximum buffer size. A new x-max-bounce-buffer-size parameter is
> > >>> provided to configure the limit for PCI devices.
> > >>>
> > >>> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > >>> ---
> > >>>    hw/pci/pci.c                |  8 ++++
> > >>>    include/exec/memory.h       | 14 +++----
> > >>>    include/hw/pci/pci_device.h |  3 ++
> > >>>    system/memory.c             |  5 ++-
> > >>>    system/physmem.c            | 82 ++++++++++++++++++++++++++-----=
------
> > >>>    5 files changed, 76 insertions(+), 36 deletions(-)
> >
> >
> > >>>    /**
> > >>>     * struct AddressSpace: describes a mapping of addresses to #Mem=
oryRegion objects
> > >>> @@ -1143,8 +1137,10 @@ struct AddressSpace {
> > >>>        QTAILQ_HEAD(, MemoryListener) listeners;
> > >>>        QTAILQ_ENTRY(AddressSpace) address_spaces_link;
> > >>>
> > >>> -    /* Bounce buffer to use for this address space. */
> > >>> -    BounceBuffer bounce;
> > >>> +    /* Maximum DMA bounce buffer size used for indirect memory map=
 requests */
> > >>> +    uint32_t max_bounce_buffer_size;
> > >>
> > >> Alternatively size_t.
> > >
> > > While switching things over, I was surprised to find that
> > > DEFINE_PROP_SIZE wants a uint64_t field rather than a size_t field.
> > > There is a DEFINE_PROP_SIZE32 variant for uint32_t though. Considerin=
g
> > > my options, assuming that we want to use size_t for everything other
> > > than the property:
> > >
> > > (1) Make PCIDevice::max_bounce_buffer_size size_t and have the
> > > preprocessor select DEFINE_PROP_SIZE/DEFINE_PROP_SIZE32. This makes
> > > the qdev property type depend on the host. Ugh.
> > >
> > > (2) Make PCIDevice::max_bounce_buffer_size uint64_t and clamp if
> > > needed when used. Weird to allow larger values that are then clamped,
> > > although it probably doesn't matter in practice since address space i=
s
> > > limited to 4GB anyways.
> > >
> > > (3) Make PCIDevice::max_bounce_buffer_size uint32_t and accept the
> > > limitation that the largest bounce buffer limit is 4GB even on 64-bit
> > > hosts.
> > >
> > > #3 seemed most pragmatic, so I'll go with that.
> >
> > LGTM, thanks for updating.
>
> No problem, can I ask you to provide a formal R-B on the v10 #4 patch
> [1] then, so the series will be ready to go in?
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-05/msg01382.htm=
l
>
> >
> > >
> > >
> > >>
> > >>> +    /* Total size of bounce buffers currently allocated, atomicall=
y accessed */
> > >>> +    uint32_t bounce_buffer_size;
> > >>
> > >> Ditto.
> >

